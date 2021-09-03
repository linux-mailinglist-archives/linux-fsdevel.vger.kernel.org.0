Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0626400548
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350846AbhICSs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 14:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350567AbhICSs4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:48:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 779DE610A1;
        Fri,  3 Sep 2021 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630694876;
        bh=hT4RRpDObCrnqrIR/+8EtNZkR2fPesdsprcdlGFcdQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7eoWV5Oc+mxNeU6xDgBsGQXlSQp4DrBk03yqy+9FA7qDJ7qtKDz6KS/G9mrZwmv5
         3mlCxWPFaj+ELLcLcfZnPYK5VPpr0Y8+n3w8EcuZgo6E5M/ge+iuTSGdKYeK8dUUt4
         aIs15/N269kT5ZvU6wgJtijOORJX/rqXc6BPOTLHWkYf2fUtD0Eb1Pj9y+NjM3sl5j
         4+36lDXfsFf58nMQ3TBuMJWqXhEOREZPYbz98il2a/Fa4eOLui3gH8amHRcEb5mLnh
         O8rofMu+3Mw3WI/bsNbuJ5fsZYIvt/efcLvhqR955Ay85aXvZOrIZ+l9Uw6HTMF30O
         sP2xlMHsEr88A==
Date:   Fri, 3 Sep 2021 11:47:55 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ocfs2-devel@oss.oracle.com
Subject: Re: [PATCH v7 16/19] iomap: Add done_before argument to iomap_dio_rw
Message-ID: <20210903184755.GC9892@magnolia>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <20210827164926.1726765-17-agruenba@redhat.com>
 <20210827183018.GJ12664@magnolia>
 <CAHc6FU44mGza=G4prXh08=RJZ0Wu7i6rBf53BjURj8oyX5Q8iA@mail.gmail.com>
 <20210827213239.GH12597@magnolia>
 <CAHk-=whCCyxkk+wfDZ5bQNX62MfdprBLpy_RwpSFhFziA2Oecg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whCCyxkk+wfDZ5bQNX62MfdprBLpy_RwpSFhFziA2Oecg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 03:35:06PM -0700, Linus Torvalds wrote:
> On Fri, Aug 27, 2021 at 2:32 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > No, because you totally ignored the second question:
> >
> > If the directio operation succeeds even partially and the PARTIAL flag
> > is set, won't that push the iov iter ahead by however many bytes
> > completed?
> >
> > We already finished the IO for the first page, so the second attempt
> > should pick up where it left off, i.e. the second page.
> 
> Darrick, I think you're missing the point.
> 
> It's the *return*value* that is the issue, not the iovec.
> 
> The iovec is updated as you say. But the return value from the async
> part is - without Andreas' patch - only the async part of it.
> 
> With Andreas' patch, the async part will now return the full return
> value, including the part that was done synchronously.
> 
> And the return value is returned from that async part, which somehow
> thus needs to know what predated it.

Aha, that was the missing piece, thank you.  I'd forgotten that
iomap_dio_complete_work calls iocb->ki_complete with the return value of
iomap_dio_complete, which means that the iomap_dio has to know if there
was a previous transfer that stopped short so that the caller could do
more work and resubmit.

> Could that pre-existing part perhaps be saved somewhere else? Very
> possibly. That 'struct iomap_dio' addition is kind of ugly. So maybe
> what Andreas did could be done differently.

There's probably a more elegant way for the ->ki_complete functions to
figure out how much got transferred, but that's sufficiently ugly and
invasive so as not to be suitable for a bug fix.

> But I think you guys are arguing past each other.

Yes, definitely.

--D

> 
>            Linus
