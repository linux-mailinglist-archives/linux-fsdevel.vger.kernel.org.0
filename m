Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCEB6EEF81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 09:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239923AbjDZHn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 03:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239873AbjDZHnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 03:43:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7499140F7;
        Wed, 26 Apr 2023 00:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YLBuKPBlg1otbpdJA1Gf3tRE4LAvlfNkgUvTKKV70wo=; b=WJgIVULIYQ39sjUOZ5s4mxqE8E
        dHPM63xbMfd5wqw43T78yfNFrPvOYfM8KC+6TThNEQpMGmW1cqzRRu40pDKedIQ4MdNy7FC77bs/G
        PN+3RLyO+rOla23sbrnFdZx+KXz5raCiVtmHuD4o91cn0jZFi81vJ+FT4RJkbC1BHIOPomxDnuL7e
        +zLWXBDqx79hzBqjKJoZ+89ceJKO2T+LZRQeKH2RcSr85c7cHXRDbXmTLyry51mliJAeORkgytCzG
        O/hGY0CXMhKplYhERj4Klj8ffHn+3guUXYqKtc/imEZDTvNUT30+P9edc7spmNMmtvvG21nb4RnLa
        VXo2651Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1prZny-0034zX-1q;
        Wed, 26 Apr 2023 07:43:10 +0000
Date:   Wed, 26 Apr 2023 00:43:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Pankaj Raghav <p.raghav@samsung.com>, hughd@google.com,
        willy@infradead.org
Cc:     akpm@linux-foundation.org, brauner@kernel.org, djwong@kernel.org,
        da.gomez@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org, hare@suse.de,
        kbusch@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/8] shmem: convert to use folio_test_hwpoison()
Message-ID: <ZEjWDvbfePjqXJ+4@bombadil.infradead.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
 <20230421214400.2836131-3-mcgrof@kernel.org>
 <ZEMRbcHSQqyek8Ov@casper.infradead.org>
 <CGME20230425110913eucas1p22cf9d4c7401881999adb12134b985273@eucas1p2.samsung.com>
 <20230425110025.7tq5vdr2jfom2zdh@localhost>
 <ZEhYfHePaLpoUhbp@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEhYfHePaLpoUhbp@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 25, 2023 at 03:47:24PM -0700, Luis Chamberlain wrote:
> On Tue, Apr 25, 2023 at 01:00:25PM +0200, Pankaj Raghav wrote:
> > On Fri, Apr 21, 2023 at 11:42:53PM +0100, Matthew Wilcox wrote:
> > > On Fri, Apr 21, 2023 at 02:43:54PM -0700, Luis Chamberlain wrote:
> > > > The PageHWPoison() call can be converted over to the respective folio call
> > > > folio_test_hwpoison(). This introduces no functional changes.
> > > 
> > > Um, no.  Nobody should use folio_test_hwpoison(), it's a nonsense.
> > > 
> > > Individual pages are hwpoisoned.  You're only testing the head page
> > > if you use folio_test_hwpoison().  There's folio_has_hwpoisoned() to
> > > test if _any_ page in the folio is poisoned.  But blindly converting
> > > PageHWPoison to folio_test_hwpoison() is wrong.
> > 
> > I see a pattern in shmem.c where first the head is tested and for large
> > folios, any of pages in the folio is tested for poison flag. Should we
> > factor it out as a helper in shmem.c and use it here?
> > 
> > static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
> > ...
> > 	if (folio_test_hwpoison(folio) ||
> > 	    (folio_test_large(folio) &&
> > 	     folio_test_has_hwpoisoned(folio))) {
> > 	..
> 
> Hugh's commit 72887c976a7c9e ("shmem: minor fixes to splice-read
> implementation") is on point about this :
> 
>   "Perhaps that ugliness can be improved at the mm end later"
> 
> So how about we put some lipstick on this guy now (notice right above it
> a similar compound page check for is_page_hwpoison()):
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 1c68d67b832f..6a4a571dbe50 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -883,6 +883,13 @@ static inline bool is_page_hwpoison(struct page *page)
>  	return PageHuge(page) && PageHWPoison(compound_head(page));
>  }
>  
> +static inline bool is_folio_hwpoison(struct folio *folio)
> +{
> +	if (folio_test_hwpoison(folio))
> +		return true;
> +	return folio_test_large(folio) && folio_test_has_hwpoisoned(folio);
> +}
> +
>  /*
>   * For pages that are never mapped to userspace (and aren't PageSlab),
>   * page_type may be used.  Because it is initialised to -1, we invert the
> diff --git a/mm/shmem.c b/mm/shmem.c
> index ef7ad684f4fb..b7f47f6b75d5 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3013,9 +3013,7 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
>  		if (folio) {
>  			folio_unlock(folio);
>  
> -			if (folio_test_hwpoison(folio) ||
> -			    (folio_test_large(folio) &&
> -			     folio_test_has_hwpoisoned(folio))) {
> +			if (is_folio_hwpoison(folio)) {
>  				error = -EIO;
>  				break;
>  			}

With this, this I end up with the following for shmem_file_read_iter().
For some odd reason without the first hunk I see that some non SB_KERNMOUNT
end up with a silly inode->i_blkbits.

I must be doing something wrong with the shmem_file_read_iter() conversion
as I end up with a empty new line at the end, but I can't seem to
understand why. Any ideas?

diff --git a/mm/shmem.c b/mm/shmem.c
index 21a4b8522ac5..39ae17774dc3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2541,6 +2541,10 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 		inode->i_ino = ino;
 		inode_init_owner(idmap, inode, dir, mode);
 		inode->i_blocks = 0;
+		if (sb->s_flags & SB_KERNMOUNT)
+			inode->i_blkbits = PAGE_SHIFT;
+		else
+			inode->i_blkbits = sb->s_blocksize_bits;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_generation = get_random_u32();
 		info = SHMEM_I(inode);
@@ -2786,18 +2790,23 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
+	struct super_block *sb = inode->i_sb;
+	u64 bsize = i_blocksize(inode);
 	pgoff_t index;
 	unsigned long offset;
 	int error = 0;
 	ssize_t retval = 0;
 	loff_t *ppos = &iocb->ki_pos;
 
+	/*
+	 * Although our index is page specific, we can read a blocksize at a
+	 * time as we use a folio per block.
+	 */
 	index = *ppos >> PAGE_SHIFT;
-	offset = *ppos & ~PAGE_MASK;
+	offset = *ppos & (bsize - 1);
 
 	for (;;) {
 		struct folio *folio = NULL;
-		struct page *page = NULL;
 		pgoff_t end_index;
 		unsigned long nr, ret;
 		loff_t i_size = i_size_read(inode);
@@ -2806,7 +2815,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (index > end_index)
 			break;
 		if (index == end_index) {
-			nr = i_size & ~PAGE_MASK;
+			nr = i_size & (bsize - 1);
 			if (nr <= offset)
 				break;
 		}
@@ -2819,9 +2828,7 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		}
 		if (folio) {
 			folio_unlock(folio);
-
-			page = folio_file_page(folio, index);
-			if (PageHWPoison(page)) {
+			if (is_folio_hwpoison(folio)) {
 				folio_put(folio);
 				error = -EIO;
 				break;
@@ -2831,50 +2838,63 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		/*
 		 * We must evaluate after, since reads (unlike writes)
 		 * are called without i_rwsem protection against truncate
+		 *
+		 * nr represents the number of bytes we can read per folio,
+		 * and this will depend on the blocksize set.
 		 */
-		nr = PAGE_SIZE;
+		nr = bsize;
+		WARN_ON(!(sb->s_flags & SB_KERNMOUNT) && folio && bsize != folio_size(folio));
 		i_size = i_size_read(inode);
 		end_index = i_size >> PAGE_SHIFT;
 		if (index == end_index) {
-			nr = i_size & ~PAGE_MASK;
+			nr = i_size & (bsize - 1);
 			if (nr <= offset) {
 				if (folio)
 					folio_put(folio);
 				break;
 			}
 		}
+		/*
+		 * On the first folio read this will amount to blocksize - offset. On subsequent
+		 * reads we can read blocksize at time until iov_iter_count(to) == 0.
+		 *
+		 * The offset represents the base we'll use to do the reads per folio, it
+		 * gets incremented by the number of bytes we read per folio and is aligned
+		 * to the blocksize. After a first offset block the offset would be 0 and
+		 * we'd read a block at a time.
+		 */
 		nr -= offset;
 
 		if (folio) {
 			/*
-			 * If users can be writing to this page using arbitrary
+			 * If users can be writing to this folio using arbitrary
 			 * virtual addresses, take care about potential aliasing
-			 * before reading the page on the kernel side.
+			 * before reading the folio on the kernel side.
 			 */
 			if (mapping_writably_mapped(mapping))
-				flush_dcache_page(page);
+				flush_dcache_folio(folio);
 			/*
-			 * Mark the page accessed if we read the beginning.
+			 * Mark the folio accessed if we read the beginning.
 			 */
 			if (!offset)
 				folio_mark_accessed(folio);
 			/*
-			 * Ok, we have the page, and it's up-to-date, so
+			 * Ok, we have the folio, and it's up-to-date, so
 			 * now we can copy it to user space...
 			 */
-			ret = copy_page_to_iter(page, offset, nr, to);
+			ret = copy_folio_to_iter(folio, offset, nr, to);
 			folio_put(folio);
 
 		} else if (user_backed_iter(to)) {
 			/*
 			 * Copy to user tends to be so well optimized, but
 			 * clear_user() not so much, that it is noticeably
-			 * faster to copy the zero page instead of clearing.
+			 * faster to copy the zero folio instead of clearing.
 			 */
-			ret = copy_page_to_iter(ZERO_PAGE(0), offset, nr, to);
+			ret = copy_folio_to_iter(page_folio(ZERO_PAGE(0)), offset, nr, to);
 		} else {
 			/*
-			 * But submitting the same page twice in a row to
+			 * But submitting the same folio twice in a row to
 			 * splice() - or others? - can result in confusion:
 			 * so don't attempt that optimization on pipes etc.
 			 */
@@ -2883,8 +2903,13 @@ static ssize_t shmem_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		retval += ret;
 		offset += ret;
+
+		/*
+		 * Due to usage of folios per blocksize we know this will actually read
+		 * blocksize at a time after the first block read at offset.
+		 */
 		index += offset >> PAGE_SHIFT;
-		offset &= ~PAGE_MASK;
+		offset &= (bsize - 1);
 
 		if (!iov_iter_count(to))
 			break;
-- 
2.39.2

