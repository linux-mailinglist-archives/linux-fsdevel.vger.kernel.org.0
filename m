Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1889F3CB1CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 07:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhGPFKn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 01:10:43 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:35948 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhGPFKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:10:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UfwgDyq_1626412048;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UfwgDyq_1626412048)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 13:07:46 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chao Yu <chao@kernel.org>, Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs: convert all uncompressed cases to iomap
Date:   Fri, 16 Jul 2021 13:07:24 +0800
Message-Id: <20210716050724.225041-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
References: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since iomap tail-packing inline has been supported now,
convert all EROFS uncompressed data I/O to iomap, which
is pretty straight-forward.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 288 ++++++++----------------------------------------
 1 file changed, 49 insertions(+), 239 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 00493855319a..7d38fcaec877 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -9,29 +9,6 @@
 #include <linux/dax.h>
 #include <trace/events/erofs.h>
 
-static void erofs_readendio(struct bio *bio)
-{
-	struct bio_vec *bvec;
-	blk_status_t err = bio->bi_status;
-	struct bvec_iter_all iter_all;
-
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-
-		/* page is already locked */
-		DBG_BUGON(PageUptodate(page));
-
-		if (err)
-			SetPageError(page);
-		else
-			SetPageUptodate(page);
-
-		unlock_page(page);
-		/* page could be reclaimed now */
-	}
-	bio_put(bio);
-}
-
 struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
 {
 	struct address_space *const mapping = sb->s_bdev->bd_inode->i_mapping;
@@ -109,206 +86,6 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return err;
 }
 
-static inline struct bio *erofs_read_raw_page(struct bio *bio,
-					      struct address_space *mapping,
-					      struct page *page,
-					      erofs_off_t *last_block,
-					      unsigned int nblocks,
-					      unsigned int *eblks,
-					      bool ra)
-{
-	struct inode *const inode = mapping->host;
-	struct super_block *const sb = inode->i_sb;
-	erofs_off_t current_block = (erofs_off_t)page->index;
-	int err;
-
-	DBG_BUGON(!nblocks);
-
-	if (PageUptodate(page)) {
-		err = 0;
-		goto has_updated;
-	}
-
-	/* note that for readpage case, bio also equals to NULL */
-	if (bio &&
-	    (*last_block + 1 != current_block || !*eblks)) {
-submit_bio_retry:
-		submit_bio(bio);
-		bio = NULL;
-	}
-
-	if (!bio) {
-		struct erofs_map_blocks map = {
-			.m_la = blknr_to_addr(current_block),
-		};
-		erofs_blk_t blknr;
-		unsigned int blkoff;
-
-		err = erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW);
-		if (err)
-			goto err_out;
-
-		/* zero out the holed page */
-		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-			zero_user_segment(page, 0, PAGE_SIZE);
-			SetPageUptodate(page);
-
-			/* imply err = 0, see erofs_map_blocks */
-			goto has_updated;
-		}
-
-		/* for RAW access mode, m_plen must be equal to m_llen */
-		DBG_BUGON(map.m_plen != map.m_llen);
-
-		blknr = erofs_blknr(map.m_pa);
-		blkoff = erofs_blkoff(map.m_pa);
-
-		/* deal with inline page */
-		if (map.m_flags & EROFS_MAP_META) {
-			void *vsrc, *vto;
-			struct page *ipage;
-
-			DBG_BUGON(map.m_plen > PAGE_SIZE);
-
-			ipage = erofs_get_meta_page(inode->i_sb, blknr);
-
-			if (IS_ERR(ipage)) {
-				err = PTR_ERR(ipage);
-				goto err_out;
-			}
-
-			vsrc = kmap_atomic(ipage);
-			vto = kmap_atomic(page);
-			memcpy(vto, vsrc + blkoff, map.m_plen);
-			memset(vto + map.m_plen, 0, PAGE_SIZE - map.m_plen);
-			kunmap_atomic(vto);
-			kunmap_atomic(vsrc);
-			flush_dcache_page(page);
-
-			SetPageUptodate(page);
-			/* TODO: could we unlock the page earlier? */
-			unlock_page(ipage);
-			put_page(ipage);
-
-			/* imply err = 0, see erofs_map_blocks */
-			goto has_updated;
-		}
-
-		/* pa must be block-aligned for raw reading */
-		DBG_BUGON(erofs_blkoff(map.m_pa));
-
-		/* max # of continuous pages */
-		if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
-			nblocks = DIV_ROUND_UP(map.m_plen, PAGE_SIZE);
-
-		*eblks = bio_max_segs(nblocks);
-		bio = bio_alloc(GFP_NOIO, *eblks);
-
-		bio->bi_end_io = erofs_readendio;
-		bio_set_dev(bio, sb->s_bdev);
-		bio->bi_iter.bi_sector = (sector_t)blknr <<
-			LOG_SECTORS_PER_BLOCK;
-		bio->bi_opf = REQ_OP_READ | (ra ? REQ_RAHEAD : 0);
-	}
-
-	err = bio_add_page(bio, page, PAGE_SIZE, 0);
-	/* out of the extent or bio is full */
-	if (err < PAGE_SIZE)
-		goto submit_bio_retry;
-	--*eblks;
-	*last_block = current_block;
-	return bio;
-
-err_out:
-	/* for sync reading, set page error immediately */
-	if (!ra) {
-		SetPageError(page);
-		ClearPageUptodate(page);
-	}
-has_updated:
-	unlock_page(page);
-
-	/* if updated manually, continuous pages has a gap */
-	if (bio)
-		submit_bio(bio);
-	return err ? ERR_PTR(err) : NULL;
-}
-
-/*
- * since we dont have write or truncate flows, so no inode
- * locking needs to be held at the moment.
- */
-static int erofs_raw_access_readpage(struct file *file, struct page *page)
-{
-	erofs_off_t last_block;
-	unsigned int eblks;
-	struct bio *bio;
-
-	trace_erofs_readpage(page, true);
-
-	bio = erofs_read_raw_page(NULL, page->mapping,
-				  page, &last_block, 1, &eblks, false);
-
-	if (IS_ERR(bio))
-		return PTR_ERR(bio);
-
-	if (bio)
-		submit_bio(bio);
-	return 0;
-}
-
-static void erofs_raw_access_readahead(struct readahead_control *rac)
-{
-	erofs_off_t last_block;
-	unsigned int eblks;
-	struct bio *bio = NULL;
-	struct page *page;
-
-	trace_erofs_readpages(rac->mapping->host, readahead_index(rac),
-			readahead_count(rac), true);
-
-	while ((page = readahead_page(rac))) {
-		prefetchw(&page->flags);
-
-		bio = erofs_read_raw_page(bio, rac->mapping, page, &last_block,
-				readahead_count(rac), &eblks, true);
-
-		/* all the page errors are ignored when readahead */
-		if (IS_ERR(bio)) {
-			pr_err("%s, readahead error at page %lu of nid %llu\n",
-			       __func__, page->index,
-			       EROFS_I(rac->mapping->host)->nid);
-
-			bio = NULL;
-		}
-
-		put_page(page);
-	}
-
-	if (bio)
-		submit_bio(bio);
-}
-
-static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
-{
-	struct inode *inode = mapping->host;
-	struct erofs_map_blocks map = {
-		.m_la = blknr_to_addr(block),
-	};
-
-	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
-		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
-
-		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
-			return 0;
-	}
-
-	if (!erofs_map_blocks_flatmode(inode, &map, EROFS_GET_BLOCKS_RAW))
-		return erofs_blknr(map.m_pa);
-
-	return 0;
-}
-
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
@@ -326,6 +103,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->dax_dev = EROFS_I_SB(inode)->dax_dev;
 	iomap->offset = map.m_la;
 	iomap->length = map.m_llen;
+	iomap->private = NULL;
 
 	if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 		iomap->type = IOMAP_HOLE;
@@ -335,21 +113,62 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		return 0;
 	}
 
-	/* that shouldn't happen for now */
 	if (map.m_flags & EROFS_MAP_META) {
-		DBG_BUGON(1);
-		return -ENOTBLK;
+		struct page *ipage;
+
+		iomap->type = IOMAP_INLINE;
+		ipage = erofs_get_meta_page(inode->i_sb,
+					    erofs_blknr(map.m_pa));
+		iomap->inline_data = page_address(ipage) +
+					erofs_blkoff(map.m_pa);
+		iomap->private = ipage;
+	} else {
+		iomap->type = IOMAP_MAPPED;
+		iomap->addr = map.m_pa;
 	}
-	iomap->type = IOMAP_MAPPED;
-	iomap->addr = map.m_pa;
 	iomap->flags = 0;
 	return 0;
 }
 
+int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
+		ssize_t written, unsigned flags, struct iomap *iomap)
+{
+	struct page *ipage = iomap->private;
+
+	if (ipage) {
+		DBG_BUGON(iomap->type != IOMAP_INLINE);
+		unlock_page(ipage);
+		put_page(ipage);
+	} else {
+		DBG_BUGON(iomap->type == IOMAP_INLINE);
+	}
+	return written;
+}
+
 const struct iomap_ops erofs_iomap_ops = {
 	.iomap_begin = erofs_iomap_begin,
+	.iomap_end = erofs_iomap_end,
 };
 
+/*
+ * since we dont have write or truncate flows, so no inode
+ * locking needs to be held at the moment.
+ */
+static int erofs_readpage(struct file *file, struct page *page)
+{
+	return iomap_readpage(page, &erofs_iomap_ops);
+}
+
+static void erofs_readahead(struct readahead_control *rac)
+{
+	return iomap_readahead(rac, &erofs_iomap_ops);
+}
+
+static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
+{
+	return iomap_bmap(mapping, block, &erofs_iomap_ops);
+}
+
 static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -365,15 +184,6 @@ static int erofs_prepare_dio(struct kiocb *iocb, struct iov_iter *to)
 
 	if (align & blksize_mask)
 		return -EINVAL;
-
-	/*
-	 * Tail-packing inline data is not supported for iomap for now.
-	 * Temporarily fall back this to buffered I/O instead.
-	 */
-	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE &&
-	    iocb->ki_pos + iov_iter_count(to) >
-			rounddown(inode->i_size, EROFS_BLKSIZ))
-		return 1;
 	return 0;
 }
 
@@ -409,8 +219,8 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 /* for uncompressed (aligned) files and raw access for other files */
 const struct address_space_operations erofs_raw_access_aops = {
-	.readpage = erofs_raw_access_readpage,
-	.readahead = erofs_raw_access_readahead,
+	.readpage = erofs_readpage,
+	.readahead = erofs_readahead,
 	.bmap = erofs_bmap,
 	.direct_IO = noop_direct_IO,
 };
-- 
2.24.4

