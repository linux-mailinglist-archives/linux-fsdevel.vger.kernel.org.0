Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892E4516FEA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 15:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381791AbiEBNEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 09:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385146AbiEBNDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 09:03:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C012638A8;
        Mon,  2 May 2022 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XcyDdbV6DXOFSllXpbj6CsMixxQmR7G0rPcGqPJD948=; b=UnfKsUiNYlJFBUfNSmzK55N9FV
        d/ykjTsFHA4ajgAFOwQwqpJmlQRG2VNdw/oEJR/ZSb8f30uqP5x8yOD729FV8RqMo+e070nXj517V
        GB+sZgKt75sDs+9zpSWqPVtxxdlxhOjCYphLrjqHydAyfjJTQvECb610arZdFM2JqezqCN54Rjxty
        f4XEOesg85owuoqiZRyAuY1M6gSKuNfTJgiozjnCunVOYUBQ/Ff/epwsJ114WtLiDFUcIcGAChKvM
        mPSmUDiPpj2mVxnNKvJwd+PFqoW4EklW4wan3wamNQNwU+WX4w7a7WWSBQTuSJBSPUTk34+LuxkNN
        2u06H1Og==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlVey-00Ep4a-Hh; Mon, 02 May 2022 13:00:16 +0000
Date:   Mon, 2 May 2022 14:00:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: generic/068 crash on 5.18-rc2?
Message-ID: <Ym/V4G2RcQd/RmHZ@casper.infradead.org>
References: <20220413033425.GM16799@magnolia>
 <YlbjOPEQP66gc1WQ@casper.infradead.org>
 <20220418174747.GF17025@magnolia>
 <20220422215943.GC17025@magnolia>
 <Ymq4brjhBcBvcfIs@bfoster>
 <Ymywh003c+Hd4Zu9@casper.infradead.org>
 <Ym/MEBfa0szil3hW@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym/MEBfa0szil3hW@bfoster>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 02, 2022 at 08:18:24AM -0400, Brian Foster wrote:
> On Sat, Apr 30, 2022 at 04:44:07AM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 28, 2022 at 11:53:18AM -0400, Brian Foster wrote:
> > > The above is the variant of generic/068 failure I was reproducing and
> > > used to bisect [1]. With some additional tracing added to ioend
> > > completion, what I'm seeing is that the bio_for_each_folio_all() bvec
> > > iteration basically seems to go off the rails. What happens more
> > > specifically is that at some point during the loop, bio_next_folio()
> > > actually lands into the second page of the just processed folio instead
> > > of the actual next folio (i.e. as if it's walking to the next page from
> > > the head page of the folio instead of to the next 16k folio). I suspect
> > > completion is racing with some form of truncation/reclaim/invalidation
> > > here, what exactly I don't know, that perhaps breaks down the folio and
> > > renders the iteration (bio_next_folio() -> folio_next()) unsafe. To test
> > > that theory, I open coded and modified the loop to something like the
> > > following:
> > > 
> > >                 for (bio_first_folio(&fi, bio, 0); fi.folio; ) {
> > >                         f = fi.folio;
> > >                         l = fi.length;
> > >                         bio_next_folio(&fi, bio);
> > >                         iomap_finish_folio_write(inode, f, l, error);
> > >                         folio_count++;
> > >                 }
> > > 
> > > ... to avoid accessing folio metadata after writeback is cleared on it
> > > and this seems to make the problem disappear (so far, I'll need to let
> > > this spin for a while longer to be completely confident in that).
> > 
> > _Oh_.
> > 
> > It's not even a terribly weird race, then.  It's just this:
> > 
> > CPU 0				CPU 1
> > 				truncate_inode_partial_folio()
> > 				folio_wait_writeback();
> > bio_next_folio(&fi, bio)
> > iomap_finish_folio_write(fi.folio)
> > folio_end_writeback(folio)
> > 				split_huge_page()
> > bio_next_folio()
> > ... oops, now we only walked forward one page instead of the entire folio.
> > 
> 
> Yep, though once I noticed and turned on the mm_page_free tracepoint, it
> looked like it was actually the I/O completion path breaking down the
> compound folio:
> 
>    kworker/10:1-440     [010] .....   355.369899: iomap_finish_ioend: 1090: bio 00000000bc8445c7 index 192 fi (00000000dc8c03bd 0 16384 32768 27)
>    ...
>     kworker/10:1-440     [010] .....   355.369905: mm_page_free: page=00000000dc8c03bd pfn=0x182190 order=2
>     kworker/10:1-440     [010] .....   355.369907: iomap_finish_ioend: 1090: bio 00000000bc8445c7 index 1 fi (00000000f8b5d9b3 0 4096 16384 27)
> 
> I take that to mean the truncate path executes while the completion side
> holds a reference, folio_end_writeback() ends up dropping the last
> reference, falls into the free/split path and the iteration breaks from
> there. Same idea either way, I think.

Absolutely.  That's probably the more common path anyway; we truncate
an entire folio instead of a partial one, so it could be:

truncate_inode_partial_folio():
        folio_wait_writeback(folio);
        if (length == folio_size(folio)) {
                truncate_inode_folio(folio->mapping, folio);

or basically the same code in truncate_inode_pages_range()
or invalidate_inode_pages2_range().

