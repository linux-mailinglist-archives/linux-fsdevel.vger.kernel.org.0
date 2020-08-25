Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186D1251B35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHYOt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 10:49:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52912 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbgHYOtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598366964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pzIP34Ki0Z+vBgdypgtKGWPh1iYERn+u9xsNVS6G0E=;
        b=isJktnqSLCZ5FmxyZ4za6MkPif8q1/hZc9nyB7gnFwKKr1aWaMiVpJURgPZOJAToeFhZ/9
        uZgiwts4Y7P1BG75FcmEB/tEjj3UL3om//Ev3qfncPsbdNOKocMMgf5UEdzZrLKYsSLQnn
        /cvgKMvZ9YKBuKwsifsd/iQOUlC0beo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-ZSlACoEiMjO5jaEochGcdg-1; Tue, 25 Aug 2020 10:49:21 -0400
X-MC-Unique: ZSlACoEiMjO5jaEochGcdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AA2310ABDB4;
        Tue, 25 Aug 2020 14:49:20 +0000 (UTC)
Received: from bfoster (ovpn-112-11.rdu2.redhat.com [10.10.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BFFE60D34;
        Tue, 25 Aug 2020 14:49:18 +0000 (UTC)
Date:   Tue, 25 Aug 2020 10:49:17 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        darrick.wong@oracle.com, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, minlei@redhat.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200825144917.GA321765@bfoster>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
 <20200820231140.GE7941@dread.disaster.area>
 <20200821044533.BBFD1A405F@d06av23.portsmouth.uk.ibm.com>
 <20200821215358.GG7941@dread.disaster.area>
 <20200822131312.GA17997@infradead.org>
 <20200824142823.GA295033@bfoster>
 <20200824150417.GA12258@infradead.org>
 <20200824154841.GB295033@bfoster>
 <20200825004203.GJ12131@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825004203.GJ12131@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cc Ming

On Tue, Aug 25, 2020 at 10:42:03AM +1000, Dave Chinner wrote:
> On Mon, Aug 24, 2020 at 11:48:41AM -0400, Brian Foster wrote:
> > On Mon, Aug 24, 2020 at 04:04:17PM +0100, Christoph Hellwig wrote:
> > > On Mon, Aug 24, 2020 at 10:28:23AM -0400, Brian Foster wrote:
> > > > Do I understand the current code (__bio_try_merge_page() ->
> > > > page_is_mergeable()) correctly in that we're checking for physical page
> > > > contiguity and not necessarily requiring a new bio_vec per physical
> > > > page?
> > > 
> > > 
> > > Yes.
> > > 
> > 
> > Ok. I also realize now that this occurs on a kernel without commit
> > 07173c3ec276 ("block: enable multipage bvecs"). That is probably a
> > contributing factor, but it's not clear to me whether it's feasible to
> > backport whatever supporting infrastructure is required for that
> > mechanism to work (I suspect not).
> > 
> > > > With regard to Dave's earlier point around seeing excessively sized bio
> > > > chains.. If I set up a large memory box with high dirty mem ratios and
> > > > do contiguous buffered overwrites over a 32GB range followed by fsync, I
> > > > can see upwards of 1GB per bio and thus chains on the order of 32+ bios
> > > > for the entire write. If I play games with how the buffered overwrite is
> > > > submitted (i.e., in reverse) however, then I can occasionally reproduce
> > > > a ~32GB chain of ~32k bios, which I think is what leads to problems in
> > > > I/O completion on some systems. Granted, I don't reproduce soft lockup
> > > > issues on my system with that behavior, so perhaps there's more to that
> > > > particular issue.
> > > > 
> > > > Regardless, it seems reasonable to me to at least have a conservative
> > > > limit on the length of an ioend bio chain. Would anybody object to
> > > > iomap_ioend growing a chain counter and perhaps forcing into a new ioend
> > > > if we chain something like more than 1k bios at once?
> > > 
> > > So what exactly is the problem of processing a long chain in the
> > > workqueue vs multiple small chains?  Maybe we need a cond_resched()
> > > here and there, but I don't see how we'd substantially change behavior.
> > > 
> > 
> > The immediate problem is a watchdog lockup detection in bio completion:
> > 
> >   NMI watchdog: Watchdog detected hard LOCKUP on cpu 25
> > 
> > This effectively lands at the following segment of iomap_finish_ioend():
> > 
> > 		...
> >                /* walk each page on bio, ending page IO on them */
> >                 bio_for_each_segment_all(bv, bio, iter_all)
> >                         iomap_finish_page_writeback(inode, bv->bv_page, error);
> > 
> > I suppose we could add a cond_resched(), but is that safe directly
> > inside of a ->bi_end_io() handler? Another option could be to dump large
> > chains into the completion workqueue, but we may still need to track the
> > length to do that. Thoughts?
> 
> We have ioend completion merging that will run the compeltion once
> for all the pending ioend completions on that inode. IOWs, we do not
> need to build huge chains at submission time to batch up completions
> efficiently. However, huge bio chains at submission time do cause
> issues with writeback fairness, pinning GBs of ram as unreclaimable
> for seconds because they are queued for completion while we are
> still submitting the bio chain and submission is being throttled by
> the block layer writeback throttle, etc. Not to mention the latency
> of stable pages in a situation like this - a mmap() write fault
> could stall for many seconds waiting for a huge bio chain to finish
> submission and run completion processing even when the IO for the
> given page we faulted on was completed before the page fault
> occurred...
> 
> Hence I think we really do need to cap the length of the bio
> chains here so that we start completing and ending page writeback on
> large writeback ranges long before the writeback code finishes
> submitting the range it was asked to write back.
> 

Ming pointed out separately that limiting the bio chain itself might not
be enough because with multipage bvecs, we can effectively capture the
same number of pages in much fewer bios. Given that, what do you think
about something like the patch below to limit ioend size? This
effectively limits the number of pages per ioend regardless of whether
in-core state results in a small chain of dense bios or a large chain of
smaller bios, without requiring any new explicit page count tracking.

Brian

--- 8< ---

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6ae98d3cb157..4aa96705ffd7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1301,7 +1301,7 @@ iomap_chain_bio(struct bio *prev)
 
 static bool
 iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
-		sector_t sector)
+		unsigned len, sector_t sector)
 {
 	if ((wpc->iomap.flags & IOMAP_F_SHARED) !=
 	    (wpc->ioend->io_flags & IOMAP_F_SHARED))
@@ -1312,6 +1312,8 @@ iomap_can_add_to_ioend(struct iomap_writepage_ctx *wpc, loff_t offset,
 		return false;
 	if (sector != bio_end_sector(wpc->ioend->io_bio))
 		return false;
+	if (wpc->ioend->io_size + len > IOEND_MAX_IOSIZE)
+		return false;
 	return true;
 }
 
@@ -1329,7 +1331,7 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 	unsigned poff = offset & (PAGE_SIZE - 1);
 	bool merged, same_page = false;
 
-	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, sector)) {
+	if (!wpc->ioend || !iomap_can_add_to_ioend(wpc, offset, len, sector)) {
 		if (wpc->ioend)
 			list_add(&wpc->ioend->io_list, iolist);
 		wpc->ioend = iomap_alloc_ioend(inode, wpc, offset, sector, wbc);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9..5d1b1a08ec96 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -200,6 +200,8 @@ struct iomap_ioend {
 	struct bio		io_inline_bio;	/* MUST BE LAST! */
 };
 
+#define IOEND_MAX_IOSIZE	(262144 << PAGE_SHIFT)
+
 struct iomap_writeback_ops {
 	/*
 	 * Required, maps the blocks so that writeback can be performed on

