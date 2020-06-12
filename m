Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D581F7B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgFLQRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 12:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLQRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:17:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2597FC03E96F;
        Fri, 12 Jun 2020 09:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RnYnvByuD6092LD9qRL6lklNo/rsSsLnkPCjmPNChsI=; b=Kb2v6eU1OWtyJ5Cds7VcNHvhyN
        VYvwdEDuoaStENVAT/pl8juV4An2f3FCSF0jmQRdmxMd2StcX59RcgbrIDAhtOttN+OH2aAdhQ2w8
        n66oSZfx6hhbkcHI4mquWrQoEQjL29KXM1+ZLXF4//sL7wyBdDXGp4+6g7tj+mV2WpIa3XJfY5lhi
        AuldmWxCMIlaAPmxiv1QhP4GY+X0kUR7z5rXo6sbOvIxddeggB3s3QXuGfQWNOMKWtWBtF04p+mWT
        RCmvdek3BbiRU6C9bCpu3KSM4zBu3+qeMv1TqN6J26rJRjEbzOhxlGwVUzcvy5+cunJVjiIvRvdh8
        5PQyN13w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjmMb-0003Au-QO; Fri, 12 Jun 2020 16:17:05 +0000
Date:   Fri, 12 Jun 2020 09:17:05 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 21/51] block: Support THPs in page_is_mergeable
Message-ID: <20200612161705.GE8681@bombadil.infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
 <20200610201345.13273-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610201345.13273-22-willy@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:13:15PM -0700, Matthew Wilcox wrote:
> page_is_mergeable() would incorrectly claim that two IOs were on different
> pages because they were on different base pages rather than on the
> same THP.  This led to a reference counting bug in iomap.  Simplify the
> 'same_page' test by just comparing whether we have the same struct page
> instead of doing arithmetic on the physical addresses.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  block/bio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 5235da6434aa..cd677cde853d 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -747,7 +747,7 @@ static inline bool page_is_mergeable(const struct bio_vec *bv,
>  	if (xen_domain() && !xen_biovec_phys_mergeable(bv, page))
>  		return false;
>  
> -	*same_page = ((vec_end_addr & PAGE_MASK) == page_addr);
> +	*same_page = bv->bv_page == page;
>  	if (!*same_page && pfn_to_page(PFN_DOWN(vec_end_addr)) + 1 != page)
>  		return false;
>  	return true;

No, this is also wrong.  If you put two order-2 pages into the same
bvec, and then add the contents of each subpage one at a time, page 0
will be !same, pages 1-3 will be same, but then pages 4-7 will all be
!same instead of page 4 being !same and pages 5-7 being !same.  And the
reference count will be wrong on the second THP.

But now I'm thinking about the whole interaction with the block
layer, and it's all a bit complicated.  Changing the definition
of page_is_mergeable() to treat compound pages differently without
also changing bio_next_segment() seems like it'll cause problems with
refcounting if any current users can submit (parts of) a compound page.
And changing how bio_next_segment() works requires auditing all the users,
and I don't want to do that.

We could use a bio flag to indicate whether this is a THP-bearing BIO
and how it should decide whether two pages are actually part of the same
page, but that seems like a really bad bit of added complexity.

We could also pass a flag to __bio_try_merge_page() from the iomap code,
but again added complexity.  We could also add a __bio_try_merge_thp()
that would only be called from iomap for now.  That would call a new
thp_is_mergable() which would use the THP definition of what a "same
page" is.  I think I hate this idea least of all the ones named so far.

My preferred solution is to change the definition of iop->write_count
(and iop->read_count).  Instead of being a count of the number of segments
submitted, make it a count of the number of bytes submitted.  Like this:

diff -u b/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
--- b/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -174,9 +174,9 @@
 }
 
 static void
-iomap_read_finish(struct iomap_page *iop, struct page *page)
+iomap_read_finish(struct iomap_page *iop, struct page *page, unsigned int len)
 {
-	if (!iop || atomic_dec_and_test(&iop->read_count))
+	if (!iop || atomic_sub_and_test(len, &iop->read_count))
 		unlock_page(page);
 }
 
@@ -193,7 +193,7 @@
 		iomap_set_range_uptodate(page, bvec->bv_offset, bvec->bv_len);
 	}
 
-	iomap_read_finish(iop, page);
+	iomap_read_finish(iop, page, bvec->bv_len);
 }
 
 static void
@@ -294,8 +294,8 @@
 
 	if (is_contig &&
 	    __bio_try_merge_page(ctx->bio, page, plen, poff, &same_page)) {
-		if (!same_page && iop)
-			atomic_inc(&iop->read_count);
+		if (iop)
+			atomic_add(plen, &iop->read_count);
 		goto done;
 	}
 
@@ -305,7 +305,7 @@
 	 * that we don't prematurely unlock the page.
 	 */
 	if (iop)
-		atomic_inc(&iop->read_count);
+		atomic_add(plen, &iop->read_count);
 
 	if (!ctx->bio || !is_contig || bio_full(ctx->bio, plen)) {
 		gfp_t gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
@@ -1090,7 +1090,7 @@
 
 static void
 iomap_finish_page_writeback(struct inode *inode, struct page *page,
-		int error)
+		int error, unsigned int len)
 {
 	struct iomap_page *iop = iomap_page_create(inode, page);
 
@@ -1101,7 +1101,7 @@
 
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
 
-	if (!iop || atomic_dec_and_test(&iop->write_count))
+	if (!iop || atomic_sub_and_test(len, &iop->write_count))
 		end_page_writeback(page);
 }
 
@@ -1135,7 +1135,8 @@
 
 		/* walk each page on bio, ending page IO on them */
 		bio_for_each_thp_segment_all(bv, bio, iter_all)
-			iomap_finish_page_writeback(inode, bv->bv_page, error);
+			iomap_finish_page_writeback(inode, bv->bv_page, error,
+					bv->bv_len);
 		bio_put(bio);
 	}
 	/* The ioend has been freed by bio_put() */
@@ -1351,8 +1352,8 @@
 
 	merged = __bio_try_merge_page(wpc->ioend->io_bio, page, len, poff,
 			&same_page);
-	if (iop && !same_page)
-		atomic_inc(&iop->write_count);
+	if (iop)
+		atomic_add(len, &iop->write_count);
 
 	if (!merged) {
 		if (bio_full(wpc->ioend->io_bio, len)) {
