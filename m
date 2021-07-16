Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693693CBA96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 18:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhGPQhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 12:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPQhO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:37:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 874DF613CF;
        Fri, 16 Jul 2021 16:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626453259;
        bh=4nBTyZyJngRe55CU3IagbmHB+MF75H0iqAAq05mV6C8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AIx1xU9prVw/X9JWCwDj1szGKyIgRTI8wAeW+GPU4GzV10VCDvt0JXGwfv6TVXFIA
         Gv2G+yjFMC1xO4PAMJGbb1o41q5jrKWCuIj/nlttuLPd5fBJWUa3fyIBLUg1SH9b4D
         aS4wh5rOadXU8gi7sX395ZVH4gXJLB6uo7fGFOfN2xxts3gBRjBjqdL6JEJ0c8fbFB
         vJNJf1iThBVO9I7lh0jML8F/LfFyC9VPrrDUcTtKFCKiBZJk1ND0oE78A/IGDYM5xE
         8dbiUDoJljPIvLbDBrxKpbAQAUNppwN41KO73g/kQFVZvnExcB8Gr/JiVoUYRCwqPI
         /GufzInlxy+Vg==
Date:   Fri, 16 Jul 2021 09:34:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 097/138] iomap: Pass the iomap_page into
 iomap_set_range_uptodate
Message-ID: <20210716163418.GZ22357@magnolia>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-98-willy@infradead.org>
 <20210715212105.GH22357@magnolia>
 <YPD7NQvXMhR1D6jU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPD7NQvXMhR1D6jU@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 04:21:25AM +0100, Matthew Wilcox wrote:
> On Thu, Jul 15, 2021 at 02:21:05PM -0700, Darrick J. Wong wrote:
> > On Thu, Jul 15, 2021 at 04:36:23AM +0100, Matthew Wilcox (Oracle) wrote:
> > > All but one caller already has the iomap_page, and we can avoid getting
> > > it again.
> > > 
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > 
> > Took me a while to distinguish iomap_iop_set_range_uptodate and
> > iomap_set_range_uptodate, but yes, this looks pretty simple.
> 
> Not my favourite naming, but it's a preexisting condition ;-)
> 
> Honestly I'd like to rename iomap to blkmap or something.
> And iomap_page is now hilariously badly named.  But that's kind
> of tangential to everything else here.

I guess we only use 'blkmap' in a few places in the kernel, and nobody's
going to confuse us with UFS.

Hmm, what kind of new name?

struct iomap_buffer_head *ibh;	/* NO */
struct iomap_folio_state *ifs;
struct iomap_state *is;		/* shorter, but what is 'state'? */
struct iomap_blkmap *ibm;	/* lolz */

I think iomap_blkmap sounds fine, since we're probably going to end up
exporting it (and therefore need a clear namespace) as soon as one of
the filesystems that uses page->private to stash per-page info wants to
use iomap for buffered io.

--D
