Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569604004EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347331AbhICSdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 14:33:47 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:48934 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346181AbhICSdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:33:46 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMDso-000qie-AY; Fri, 03 Sep 2021 18:25:46 +0000
Date:   Fri, 3 Sep 2021 18:25:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH v7 00/19] gfs2: Fix mmap + page fault deadlocks
Message-ID: <YTJoqq0fVB+xAB7w@zeniv-ca.linux.org.uk>
References: <20210827164926.1726765-1-agruenba@redhat.com>
 <CAHk-=wiUtyoTWuzroNJQwQDM9GHRXvq4974VL=y8T_3tUxDbkA@mail.gmail.com>
 <CAHc6FU7K0Ho=nH6fCK+Amc7zEg2G31v+gE3920ric3NE4MfH=A@mail.gmail.com>
 <CAHk-=wjUs8qy3hTEy-7QX4L=SyS85jF58eiT2Yq2YMUdTFAgvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUs8qy3hTEy-7QX4L=SyS85jF58eiT2Yq2YMUdTFAgvA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 03, 2021 at 08:52:00AM -0700, Linus Torvalds wrote:
> On Wed, Sep 1, 2021 at 12:53 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > So there's a minor merge conflict between Christoph's iomap_iter
> > conversion and this patch queue now, and I should probably clarify the
> > description of "iomap: Add done_before argument to iomap_dio_rw" that
> > Darrick ran into. Then there are the user copy issues that Al has
> > pointed out. Fixing those will create superficial conflicts with this
> > patch queue, but probably nothing serious.
> >
> > So how should I proceed: do you expect a v8 of this patch queue on top
> > of the current mainline?
> 
> So if you rebase for fixes, it's going to be a "next merge window" thing again.
> 
> Personally, I'm ok with the series as is, and the conflict isn't an
> issue. So I'd take it as is, and then people can fix up niggling
> issues later.
> 
> But if somebody screams loudly..

FWIW, my objections regarding the calling conventions are still there.

Out of 3 callers that do want more than "success/failure", one is gone
(series by tglx) and one more is broken (regardless of the semantics,
btrfs on arm64).  Which leaves 1 caller (fault-in for read in FPU
handling on x86 sigreturn).  That caller turns out to be correct, but
IMO there are fairly strong arguments in favour of *not* using the
normal fault-in in that case.

	"how many bytes can we fault in" is misleading, unless we really
poke into every cacheline in the affected area.  Which might be a primitive
worth having, but it's a lot heavier than needed by the majority of callers.
