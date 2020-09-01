Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE9F258EF1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 15:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgIANPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 09:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgIANFr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:05:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE6EC061244;
        Tue,  1 Sep 2020 06:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3snyZCqcx6nfDLLd1J100WLPuaRed18WUzYLSt3TcWw=; b=hbrvoG+vks0CAtQ3N78qWmX5eX
        /NQfB0lIwhTw+JIeEG3UTUpEED73WYlkgwy+xZx68o+RkOBAMNP+7v0DFBexLsFKpbTNNJqIkP6Sd
        H6pciRK1QoYcmLs5njnhEbPp+JKo6UVT0Z2NUYWZ0NZMse5fdbv3S2XuHDf10GHYZZybDqcLfFk/m
        6Ff6CFmabe6TrkJZ8Igy1YjbGZv8aeXp4VPkCG8+XCmqKf9ApGKGXpb6Ta7X8f9XykbBpBWgS6fzO
        /NVVDgQQqK3n9YAn9yxLyPSnjhSjdboM3fBHH/AaYwQ2ZCYOiPObZHa/hk33V3BnzVpg0bhQsq0h8
        +f07oIzA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD5yX-0000KA-In; Tue, 01 Sep 2020 13:05:25 +0000
Date:   Tue, 1 Sep 2020 14:05:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] block: Add bio_for_each_thp_segment_all
Message-ID: <20200901130525.GK14765@casper.infradead.org>
References: <20200824151700.16097-1-willy@infradead.org>
 <20200824151700.16097-5-willy@infradead.org>
 <20200827084431.GA15909@infradead.org>
 <20200831194837.GJ14765@casper.infradead.org>
 <20200901053426.GB24560@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901053426.GB24560@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 06:34:26AM +0100, Christoph Hellwig wrote:
> On Mon, Aug 31, 2020 at 08:48:37PM +0100, Matthew Wilcox wrote:
> > static void iomap_read_end_io(struct bio *bio)
> > {
> >         int i, error = blk_status_to_errno(bio->bi_status);
> > 
> >         for (i = 0; i < bio->bi_vcnt; i++) {
> >                 struct bio_vec *bvec = &bio->bi_io_vec[i];
> 
> This should probably use bio_for_each_bvec_all instead of directly
> poking into the bio.  I'd also be tempted to move the loop body into
> a separate helper, but that's just a slight stylistic preference.

Ah, got it.

> >                 size_t offset = bvec->bv_offset;
> >                 size_t length = bvec->bv_len;
> >                 struct page *page = bvec->bv_page;
> > 
> >                 while (length > 0) { 
> >                         size_t count = thp_size(page) - offset;
> >                         
> >                         if (count > length)
> >                                 count = length;
> >                         iomap_read_page_end_io(page, offset, count, error);
> >                         page += (offset + count) / PAGE_SIZE;
> 
> Shouldn't the page_size here be thp_size?

No.  Let's suppose we have a 20kB I/O which starts on a page boundary and
the first page is order-2.  To get from the first head page to the second
page, we need to add 4, which is 16kB / 4kB, not 16kB / 16kB.

> > Maybe I'm missing something important here, but it's significantly
> > simpler code -- iomap_read_end_io() goes down from 816 bytes to 560 bytes
> > (256 bytes less!) iomap_read_page_end_io is inlined into it both before
> > and after.
> 
> Yes, that's exactly why I think avoiding bio_for_each_segment_all is
> a good idea in general.

I took out all the attempts to cope with insane bv_offset to compare like
with like and I got the bio_for_each_thp_segment_all() version down to
656 bytes:

@@ -166,21 +166,15 @@ static inline void bvec_thp_advance(const struct bio_vec *
bvec,
                                struct bvec_iter_all *iter_all)
 {
        struct bio_vec *bv = &iter_all->bv;
-       unsigned int page_size;
 
        if (iter_all->done) {
                bv->bv_page += thp_nr_pages(bv->bv_page);
-               page_size = thp_size(bv->bv_page);
                bv->bv_offset = 0;
        } else {
-               bv->bv_page = thp_head(bvec->bv_page +
-                               (bvec->bv_offset >> PAGE_SHIFT));
-               page_size = thp_size(bv->bv_page);
-               bv->bv_offset = bvec->bv_offset -
-                               (bv->bv_page - bvec->bv_page) * PAGE_SIZE;
-               BUG_ON(bv->bv_offset >= page_size);
+               bv->bv_page = bvec->bv_page;
+               bv->bv_offset = bvec->bv_offset;
        }
-       bv->bv_len = min(page_size - bv->bv_offset,
+       bv->bv_len = min_t(unsigned int, thp_size(bv->bv_page) - bv->bv_offset,
                         bvec->bv_len - iter_all->done);
        iter_all->done += bv->bv_len;

> And yes, eventually bv_page and bv_offset should be replaced with a
> 
> 	phys_addr_t		bv_phys;
> 
> and life would become simpler in many places (and the bvec would
> shrink for most common setups as well).

I'd very much like to see that.  It causes quite considerable pain for
our virtualisation people that we need a struct page.  They'd like the
hypervisor to not have struct pages for the guest's memory, but if they
don't have them, they can't do I/O to them.  Perhaps I'll try getting
one of them to work on this.

I'm not entirely sure the bvec would shrink.  On 64-bit systems, it's
currently 8 bytes for the struct page, 4 bytes for the len and 4 bytes
for the offset.  Sure, we can get rid of the offset, but the compiler
will just pad the struct from 12 bytes back to 16.  On 32-bit systems
with 32-bit phys_addr_t, we go from 12 bytes down to 8, but most 32-bit
systems have a 64-bit phys_addr_t these days, don't they?

> For now I'd end up with something like:
> 
> static void iomap_read_end_bvec(struct page *page, size_t offset,
> 		size_t length, int error)
> {
> 	while (length > 0) {
> 		size_t page_size = thp_size(page);
> 		size_t count = min(page_size - offset, length);
> 
> 		iomap_read_page_end_io(page, offset, count, error);
> 
> 		page += (offset + count) / page_size;
> 		length -= count;
> 		offset = 0;
> 	}
> }
> 
> static void iomap_read_end_io(struct bio *bio)
> {
> 	int i, error = blk_status_to_errno(bio->bi_status);
> 	struct bio_vec *bvec;
> 
> 	bio_for_each_bvec_all(bvec, bio, i)
> 		iomap_read_end_bvec(bvec->bv_page, bvec->bv_offset,
> 				    bvec->bv_len, error;
>         bio_put(bio);
> }
> 
> and maybe even merge iomap_read_page_end_io into iomap_read_end_bvec.

The lines start to get a bit long.  Here's what I currently have on
the write side:

@@ -1104,6 +1117,20 @@ iomap_finish_page_writeback(struct inode *inode, struct p
age *page,
                end_page_writeback(page);
 }
 
+static void iomap_finish_bvec_write(struct inode *inode, struct page *page,
+               size_t offset, size_t length, int error)
+{
+       while (length > 0) {
+               size_t count = min(thp_size(page) - offset, length);
+
+               iomap_finish_page_writeback(inode, page, error, count);
+
+               page += (offset + count) / PAGE_SIZE;
+               offset = 0;
+               length -= count;
+       }
+}
+
 /*
  * We're now finished for good with this ioend structure.  Update the page
  * state, release holds on bios, and finally free up memory.  Do not use the
@@ -1121,7 +1148,7 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
 
        for (bio = &ioend->io_inline_bio; bio; bio = next) {
                struct bio_vec *bv;
-               struct bvec_iter_all iter_all;
+               int i;
 
                /*
                 * For the last bio, bi_private points to the ioend, so we
@@ -1133,9 +1160,9 @@ iomap_finish_ioend(struct iomap_ioend *ioend, int error)
                        next = bio->bi_private;
 
                /* walk each page on bio, ending page IO on them */
-               bio_for_each_thp_segment_all(bv, bio, iter_all)
-                       iomap_finish_page_writeback(inode, bv->bv_page, error,
-                                       bv->bv_len);
+               bio_for_each_bvec_all(bv, bio, i)
+                       iomap_finish_bvec_writeback(inode, bv->bv_page,
+                                       bv->bv_offset, bv->bv_len, error);
                bio_put(bio);
        }
        /* The ioend has been freed by bio_put() */

That's a bit more boilerplate than I'd like, but if bio_vec is going to
lose its bv_page then I don't see a better way.  Unless we come up with
a different page/offset/length struct that bio_vecs are decomposed into.

