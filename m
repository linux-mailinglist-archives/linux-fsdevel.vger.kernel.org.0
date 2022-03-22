Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310174E43BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 16:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiCVP7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 11:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbiCVP70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:59:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52B765AF;
        Tue, 22 Mar 2022 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EufO8ORSTIOABGL8gkaGavLmha7OOyBEQ2+wUXQooq8=; b=AtV3H2BIaeZgnWt7oXNFNx8MQQ
        lqQKlGoORfLEAVx/2tp7oyv++NtJbckufZIrkUXGUtCZVzGga1UxYfrFFsDaogW3ZsdzULTFQcvdF
        71HG/t3H1JShIgvKjgwmGfS0CLNW7qgBs6iOujMjS0ij9ZTIGuIK0b7gpVqsRBi+qDE0iu/SMopeB
        1WLkgiZZq+e4P3A8Lw6u/2U+NwThiubOnSfGf7YAcQ8SJqHGl8sw6mq8cic9UhAt/NpoolQH3r6Wf
        mAfEWQQ+crpT9gtJoHlQ2rTw0DIyJPzrv8gCiz/FGwkXaBZ/ktC/MWtj8c72pjwRYpelHf194wWcj
        bNwdRqAg==;
Received: from [2001:4bb8:19a:b822:6444:5366:9486:4da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWgtL-00BbBz-SC; Tue, 22 Mar 2022 15:57:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 40/40] btrfs: use the iomap direct I/O bio directly
Date:   Tue, 22 Mar 2022 16:56:06 +0100
Message-Id: <20220322155606.1267165-41-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322155606.1267165-1-hch@lst.de>
References: <20220322155606.1267165-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the iomap code allocate btrfs dios by setting the bio_set field,
and then feed these directly into btrfs_map_dio.

For this to work iomap_begin needs to report a range that only contains
a single chunk, and thus is changed to a two level iteration.

This needs another extra field in struct btrfs_dio.  We culd overlay
it with other fields not used after I/O submittion, or split out a
new btrfs_dio_bio for the file_offset, iter and repair_refs, but
compared to the overall saving of the series this is a minor detail.

The per-iomap csum lookup is gone for now as well.  At least for
small I/Os this just creates a lot of overhead, but for large I/O
we could look into optimizing this in one for or another, but I'd
love to see a reproducer where it actually matters first.  With the
state as of this patch the direct I/O bio submission is so close
to the buffered one that they could be unified with very little
work, so diverging again would be a bit counterproductive.  OTOH
if the optimization is indeed very useful we should do it in a way
that also works for buffered reads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/btrfs_inode.h |  25 ---
 fs/btrfs/ctree.h       |   1 -
 fs/btrfs/extent_io.c   |  22 +-
 fs/btrfs/extent_io.h   |   4 +-
 fs/btrfs/inode.c       | 451 ++++++++++++++++-------------------------
 fs/btrfs/volumes.h     |   1 +
 6 files changed, 184 insertions(+), 320 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index b3e46aabc3d86..a3199020f0001 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -346,31 +346,6 @@ static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 	return ret;
 }
 
-struct btrfs_dio_private {
-	struct inode *inode;
-
-	/*
-	 * Since DIO can use anonymous page, we cannot use page_offset() to
-	 * grab the file offset, thus need a dedicated member for file offset.
-	 */
-	u64 file_offset;
-	u64 disk_bytenr;
-	/* Used for bio::bi_size */
-	u32 bytes;
-
-	/*
-	 * References to this structure. There is one reference per in-flight
-	 * bio plus one while we're still setting up.
-	 */
-	refcount_t refs;
-
-	/* dio_bio came from fs/direct-io.c */
-	struct bio *dio_bio;
-
-	/* Array of checksums */
-	u8 csums[];
-};
-
 /*
  * btrfs_inode_item stores flags in a u64, btrfs_inode stores them in two
  * separate u32s. These two functions convert between the two representations.
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 196f308e3e0d7..64ef20b84f694 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3136,7 +3136,6 @@ int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
 int btrfs_find_orphan_item(struct btrfs_root *root, u64 offset);
 
 /* file-item.c */
-struct btrfs_dio_private;
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, u64 bytenr, u64 len);
 blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio, u8 *dst);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5a1447db28228..f705e4ec9b961 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -31,7 +31,7 @@
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
-static struct bio_set btrfs_bioset;
+struct bio_set btrfs_bioset;
 
 static inline bool extent_state_in_tree(const struct extent_state *state)
 {
@@ -3150,26 +3150,6 @@ struct bio *btrfs_bio_alloc(struct inode *inode, unsigned int nr_iovecs,
 	return bio;
 }
 
-struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *orig,
-		u64 offset, u64 size)
-{
-	struct bio *bio;
-	struct btrfs_bio *bbio;
-
-	ASSERT(offset <= UINT_MAX && size <= UINT_MAX);
-
-	/* this will never fail when it's backed by a bioset */
-	bio = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOFS, &btrfs_bioset);
-	ASSERT(bio);
-
-	bbio = btrfs_bio(bio);
-	btrfs_bio_init(btrfs_bio(bio), inode);
-
-	bio_trim(bio, offset >> 9, size >> 9);
-	bbio->iter = bio->bi_iter;
-	return bio;
-}
-
 /**
  * Attempt to add a page to bio
  *
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 54e54269cfdba..b416531721dfb 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -279,8 +279,6 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  u32 bits_to_clear, unsigned long page_ops);
 struct bio *btrfs_bio_alloc(struct inode *inode, unsigned int nr_iovecs,
 		unsigned int opf);
-struct bio *btrfs_bio_clone_partial(struct inode *inode, struct bio *orig,
-		u64 offset, u64 size);
 
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num);
@@ -323,4 +321,6 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info);
 #define btrfs_extent_buffer_leak_debug_check(fs_info)	do {} while (0)
 #endif
 
+extern struct bio_set btrfs_bioset;
+
 #endif
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e25d9d860c679..6ea6ef214abdb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -62,8 +62,8 @@ struct btrfs_iget_args {
 };
 
 struct btrfs_dio_data {
-	ssize_t submitted;
 	struct extent_changeset *data_reserved;
+	struct iomap extent;
 };
 
 static const struct inode_operations btrfs_dir_inode_operations;
@@ -7507,16 +7507,16 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	return ret;
 }
 
-static int btrfs_dio_iomap_begin(struct iomap_iter *iter)
+static int btrfs_dio_iomap_begin_extent(struct iomap_iter *iter)
 {
 	struct inode *inode = iter->inode;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	loff_t start = iter->pos;
 	loff_t length = iter->len;
-	struct iomap *iomap = &iter->iomap;
 	struct extent_map *em;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_dio_data *dio_data = iter->private;
+	struct iomap *iomap = &dio_data->extent;
 	u64 lockstart, lockend;
 	bool write = (iter->flags & IOMAP_WRITE);
 	int ret = 0;
@@ -7543,7 +7543,6 @@ static int btrfs_dio_iomap_begin(struct iomap_iter *iter)
 			return ret;
 	}
 
-	dio_data->submitted = 0;
 	dio_data->data_reserved = NULL;
 
 	/*
@@ -7647,14 +7646,12 @@ static int btrfs_dio_iomap_begin(struct iomap_iter *iter)
 		iomap->type = IOMAP_MAPPED;
 	}
 	iomap->offset = start;
-	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
 	iomap->length = len;
 
 	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
 		iomap->flags |= IOMAP_F_ZONE_APPEND;
 
 	free_extent_map(em);
-
 	return 0;
 
 unlock_err:
@@ -7663,53 +7660,95 @@ static int btrfs_dio_iomap_begin(struct iomap_iter *iter)
 	return ret;
 }
 
-static int btrfs_dio_iomap_end(struct iomap_iter *iter)
+static void btrfs_dio_unlock_remaining_extent(struct btrfs_inode *bi,
+		u64 pos, u64 len, u64 processed, bool write)
 {
-	struct btrfs_dio_data *dio_data = iter->private;
+	if (write)
+		__endio_write_update_ordered(bi, pos + processed,
+				len - processed, false);
+	else
+		unlock_extent(&bi->io_tree, pos + processed,
+				pos + len - 1);
+}
+
+static int btrfs_dio_iomap_begin_chunk(struct iomap_iter *iter)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(iter->inode->i_sb);
 	struct btrfs_inode *bi = BTRFS_I(iter->inode);
-	bool write = (iter->flags & IOMAP_WRITE);
-	loff_t length = iomap_length(iter);
-	loff_t pos = iter->pos;
-	int ret = 0;
+	struct btrfs_dio_data *dio_data = iter->private;
+	struct block_device *bdev;
+	u64 len;
+
+	iter->iomap = dio_data->extent;
 
-	if (!write && iter->iomap.type == IOMAP_HOLE) {
-		/* If reading from a hole, unlock and return */
-		unlock_extent(&bi->io_tree, pos, pos + length - 1);
+	if (dio_data->extent.type != IOMAP_MAPPED)
 		return 0;
+
+	bdev = btrfs_get_stripe_info(fs_info, (iter->flags & IOMAP_WRITE) ?
+			BTRFS_MAP_WRITE : BTRFS_MAP_READ,
+			iter->iomap.addr, iter->iomap.length, &len);
+	if (WARN_ON_ONCE(IS_ERR(bdev))) {
+		btrfs_dio_unlock_remaining_extent(bi, dio_data->extent.offset,
+						  dio_data->extent.length, 0,
+						  iter->flags & IOMAP_WRITE);
+		return PTR_ERR(bdev);
 	}
 
-	if (dio_data->submitted < length) {
-		pos += dio_data->submitted;
-		length -= dio_data->submitted;
-		if (write)
-			__endio_write_update_ordered(bi, pos, length, false);
-		else
-			unlock_extent(&bi->io_tree, pos, pos + length - 1);
-		ret = -ENOTBLK;
+	iter->iomap.bdev = bdev;
+	iter->iomap.length = min(iter->iomap.length, len);
+	return 0;
+}
+
+static bool btrfs_dio_iomap_end(struct iomap_iter *iter)
+{
+	struct btrfs_inode *bi = BTRFS_I(iter->inode);
+	struct btrfs_dio_data *dio_data = iter->private;
+	struct iomap *extent = &dio_data->extent;
+	loff_t processed = iomap_processed(iter);
+	loff_t length = iomap_length(iter);
+
+	if (iter->iomap.type == IOMAP_HOLE) {
+		ASSERT(!(iter->flags & IOMAP_WRITE));
+
+		/* If reading from a hole, unlock the whole range here */
+		unlock_extent(&bi->io_tree, iter->pos, iter->pos + length - 1);
+	} else if (processed < length) {
+		btrfs_dio_unlock_remaining_extent(bi, extent->offset,
+						  extent->length, processed,
+						  iter->flags & IOMAP_WRITE);
+	} else if (iter->pos + processed < extent->offset + extent->length) {
+		extent->offset += processed;
+		extent->addr += processed;
+		extent->length -= processed;
+		return true;
 	}
 
-	if (write)
+	if (iter->flags & IOMAP_WRITE)
 		extent_changeset_free(dio_data->data_reserved);
-	return ret;
+	return false;
 }
 
 static int btrfs_dio_iomap_iter(struct iomap_iter *iter)
 {
+	bool keep_extent = false;
 	int ret;
 
-	if (iter->iomap.length) {
-		ret = btrfs_dio_iomap_end(iter);
-		if (ret < 0 && !iter->processed)
-			return ret;
-	}
+	if (iter->iomap.length)
+		keep_extent = btrfs_dio_iomap_end(iter);
 
 	ret = iomap_iter_advance(iter);
 	if (ret <= 0)
 		return ret;
 
-	ret = btrfs_dio_iomap_begin(iter);
-	if (ret < 0)
+	if (!keep_extent) {
+		ret = btrfs_dio_iomap_begin_extent(iter);
+		if (ret < 0)
+			return ret;
+	}
+	ret = btrfs_dio_iomap_begin_chunk(iter);
+	if (ret < 0) 
 		return ret;
+
 	iomap_iter_done(iter);
 	return 1;
 }
@@ -7718,54 +7757,40 @@ static const struct iomap_ops btrfs_dio_iomap_ops = {
 	.iomap_iter		= btrfs_dio_iomap_iter,
 };
 
-static void btrfs_dio_private_put(struct btrfs_dio_private *dip)
+static void btrfs_end_read_dio_bio(struct btrfs_bio *bbio,
+		struct btrfs_bio *main_bbio);
+
+static void btrfs_dio_repair_end_io(struct bio *bio)
 {
-	/*
-	 * This implies a barrier so that stores to dio_bio->bi_status before
-	 * this and loads of dio_bio->bi_status after this are fully ordered.
-	 */
-	if (!refcount_dec_and_test(&dip->refs))
-		return;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_inode *bi = BTRFS_I(bbio->inode);
+	struct btrfs_bio *failed_bbio = bio->bi_private;
 
-	if (btrfs_op(dip->dio_bio) == BTRFS_MAP_WRITE) {
-		__endio_write_update_ordered(BTRFS_I(dip->inode),
-					     dip->file_offset,
-					     dip->bytes,
-					     !dip->dio_bio->bi_status);
-	} else {
-		unlock_extent(&BTRFS_I(dip->inode)->io_tree,
-			      dip->file_offset,
-			      dip->file_offset + dip->bytes - 1);
+	if (bio->bi_status) {
+		btrfs_warn(bi->root->fs_info,
+			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d",
+			   btrfs_ino(bi), bio_op(bio), bio->bi_opf,
+			   bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
+			   bio->bi_status);
 	}
+	btrfs_end_read_dio_bio(bbio, failed_bbio);
 
-	bio_endio(dip->dio_bio);
-	kfree(dip);
+	bio_put(bio);
 }
 
 static blk_status_t submit_dio_repair_bio(struct inode *inode, struct bio *bio,
 					  int mirror_num,
 					  unsigned long bio_flags)
 {
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	blk_status_t ret;
-
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
-
 	btrfs_bio(bio)->end_io_type = BTRFS_ENDIO_WQ_DATA_WRITE;
-
-	refcount_inc(&dip->refs);
-	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	if (ret)
-		refcount_dec(&dip->refs);
-	return ret;
+	return btrfs_map_bio(btrfs_sb(inode->i_sb), bio, mirror_num);
 }
 
-static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
-					     struct btrfs_bio *bbio,
-					     const bool uptodate)
+static void btrfs_end_read_dio_bio(struct btrfs_bio *this_bbio,
+		struct btrfs_bio *main_bbio)
 {
-	struct inode *inode = dip->inode;
+	struct inode *inode = main_bbio->inode;
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
@@ -7773,20 +7798,22 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
 	struct bio_vec bvec;
 	struct bvec_iter iter;
+	bool uptodate = !this_bbio->bio.bi_status;
 	u32 bio_offset = 0;
-	blk_status_t err = BLK_STS_OK;
 
-	__bio_for_each_segment(bvec, &bbio->bio, iter, bbio->iter) {
+	main_bbio->bio.bi_status = BLK_STS_OK;
+
+	__bio_for_each_segment(bvec, &this_bbio->bio, iter, this_bbio->iter) {
 		unsigned int i, nr_sectors, pgoff;
 
 		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info, bvec.bv_len);
 		pgoff = bvec.bv_offset;
 		for (i = 0; i < nr_sectors; i++) {
-			u64 start = bbio->file_offset + bio_offset;
+			u64 start = this_bbio->file_offset + bio_offset;
 
 			ASSERT(pgoff < PAGE_SIZE);
 			if (uptodate &&
-			    (!csum || !check_data_csum(inode, bbio,
+			    (!csum || !check_data_csum(inode, this_bbio,
 						       bio_offset, bvec.bv_page,
 						       pgoff, start))) {
 				clean_io_failure(fs_info, failure_tree, io_tree,
@@ -7796,21 +7823,56 @@ static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
 			} else {
 				blk_status_t ret;
 
-				ret = btrfs_repair_one_sector(inode, &bbio->bio,
-						bio_offset, bvec.bv_page, pgoff,
-						start, bbio->mirror_num,
+				atomic_inc(&main_bbio->repair_refs);
+				ret = btrfs_repair_one_sector(inode,
+						&this_bbio->bio, bio_offset,
+						bvec.bv_page, pgoff, start,
+						this_bbio->mirror_num,
 						submit_dio_repair_bio,
-						bbio->bio.bi_private,
-						bbio->bio.bi_end_io);
-				if (ret)
-					err = ret;
+						main_bbio,
+						btrfs_dio_repair_end_io);
+				if (ret) {
+					main_bbio->bio.bi_status = ret;
+					atomic_dec(&main_bbio->repair_refs);
+				}
 			}
 			ASSERT(bio_offset + sectorsize > bio_offset);
 			bio_offset += sectorsize;
 			pgoff += sectorsize;
 		}
 	}
-	return err;
+
+	if (atomic_dec_and_test(&main_bbio->repair_refs)) {
+		unlock_extent(&BTRFS_I(inode)->io_tree, main_bbio->file_offset,
+			main_bbio->file_offset + main_bbio->iter.bi_size - 1);
+		iomap_dio_bio_end_io(&main_bbio->bio);
+	}
+}
+
+static void btrfs_dio_bio_end_io(struct bio *bio)
+{
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+	struct btrfs_inode *bi = BTRFS_I(bbio->inode);
+
+	if (bio->bi_status) {
+		btrfs_warn(bi->root->fs_info,
+			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d",
+			   btrfs_ino(bi), bio_op(bio), bio->bi_opf,
+			   bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
+			   bio->bi_status);
+	}
+
+	if (bio_op(bio) == REQ_OP_READ) {
+		atomic_set(&bbio->repair_refs, 1);
+		btrfs_end_read_dio_bio(bbio, bbio);
+	} else {
+		btrfs_record_physical_zoned(bbio->inode, bbio->file_offset,
+					    bio);
+		__endio_write_update_ordered(bi, bbio->file_offset,
+					     bbio->iter.bi_size,
+					     !bio->bi_status);
+		iomap_dio_bio_end_io(bio);
+	}
 }
 
 static void __endio_write_update_ordered(struct btrfs_inode *inode,
@@ -7829,47 +7891,47 @@ static void btrfs_submit_bio_start_direct_io(struct btrfs_work *work)
 			&bbio->bio, bbio->file_offset, 1);
 }
 
-static void btrfs_end_dio_bio(struct bio *bio)
+/*
+ * If we are submitting more than one bio, submit them all asynchronously.  The
+ * exception is RAID 5 or 6, as asynchronous checksums make it difficult to
+ * collect full stripe writes.
+ */
+static bool btrfs_dio_allow_async_write(struct btrfs_fs_info *fs_info,
+		struct btrfs_inode *bi)
 {
-	struct btrfs_dio_private *dip = bio->bi_private;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
-	blk_status_t err = bio->bi_status;
-
-	if (err)
-		btrfs_warn(BTRFS_I(dip->inode)->root->fs_info,
-			   "direct IO failed ino %llu rw %d,%u sector %#Lx len %u err no %d",
-			   btrfs_ino(BTRFS_I(dip->inode)), bio_op(bio),
-			   bio->bi_opf, bio->bi_iter.bi_sector,
-			   bio->bi_iter.bi_size, err);
-
-	if (bio_op(bio) == REQ_OP_READ)
-		err = btrfs_check_read_dio_bio(dip, bbio, !err);
-
-	if (err)
-		dip->dio_bio->bi_status = err;
-
-	btrfs_record_physical_zoned(dip->inode, bbio->file_offset, bio);
-
-	bio_put(bio);
-	btrfs_dio_private_put(dip);
+	if (btrfs_data_alloc_profile(fs_info) & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		return false;
+	if (atomic_read(&bi->sync_writers))
+		return false;
+	return true;
 }
 
-static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
-		struct inode *inode, u64 file_offset, int async_submit)
+static void btrfs_dio_submit_io(const struct iomap_iter *iter,
+		struct bio *bio, loff_t file_offset, bool more)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_inode *bi = BTRFS_I(inode);
-	struct btrfs_dio_private *dip = bio->bi_private;
+	struct btrfs_fs_info *fs_info = btrfs_sb(iter->inode->i_sb);
+	struct btrfs_inode *bi = BTRFS_I(iter->inode);
 	struct btrfs_bio *bbio = btrfs_bio(bio);
 	blk_status_t ret;
 
+	memset(bbio, 0, offsetof(struct btrfs_bio, bio));
+	bbio->inode = iter->inode;
+	bbio->file_offset = file_offset;
+	bbio->iter = bio->bi_iter;
+	bio->bi_end_io = btrfs_dio_bio_end_io;
+
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
+		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+			ret = extract_ordered_extent(bi, bio, file_offset);
+			if (ret)
+				goto out_err;
+		}
+
 		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
-			/* See btrfs_submit_data_bio for async submit rules */
-			if (async_submit && !atomic_read(&bi->sync_writers)) {
+			if (more && btrfs_dio_allow_async_write(fs_info, bi)) {
 				btrfs_submit_bio_async(bbio,
 					btrfs_submit_bio_start_direct_io);
-				return BLK_STS_OK;
+				return;
 			}
 
 			/*
@@ -7878,189 +7940,36 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 			 */
 			ret = btrfs_csum_one_bio(bi, bio, file_offset, 1);
 			if (ret)
-				return ret;
+				goto out_err;
 		}
 	} else {
 		bbio->end_io_type = BTRFS_ENDIO_WQ_DATA_READ;
 
-		if (!(bi->flags & BTRFS_INODE_NODATASUM)) {
-			u64 csum_offset;
-
-			csum_offset = file_offset - dip->file_offset;
-			csum_offset >>= fs_info->sectorsize_bits;
-			csum_offset *= fs_info->csum_size;
-			btrfs_bio(bio)->csum = dip->csums + csum_offset;
-		}
-	}
-
-	return btrfs_map_bio(fs_info, bio, 0);
-}
-
-/*
- * If this succeeds, the btrfs_dio_private is responsible for cleaning up locked
- * or ordered extents whether or not we submit any bios.
- */
-static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
-							  struct inode *inode,
-							  loff_t file_offset)
-{
-	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
-	const bool csum = !(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM);
-	size_t dip_size;
-	struct btrfs_dio_private *dip;
-
-	dip_size = sizeof(*dip);
-	if (!write && csum) {
-		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-		size_t nblocks;
-
-		nblocks = dio_bio->bi_iter.bi_size >> fs_info->sectorsize_bits;
-		dip_size += fs_info->csum_size * nblocks;
-	}
-
-	dip = kzalloc(dip_size, GFP_NOFS);
-	if (!dip)
-		return NULL;
-
-	dip->inode = inode;
-	dip->file_offset = file_offset;
-	dip->bytes = dio_bio->bi_iter.bi_size;
-	dip->disk_bytenr = dio_bio->bi_iter.bi_sector << 9;
-	dip->dio_bio = dio_bio;
-	refcount_set(&dip->refs, 1);
-	return dip;
-}
-
-static void btrfs_submit_direct(const struct iomap_iter *iter,
-		struct bio *dio_bio, loff_t file_offset, bool more)
-{
-	struct inode *inode = iter->inode;
-	const bool write = (btrfs_op(dio_bio) == BTRFS_MAP_WRITE);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	const bool raid56 = (btrfs_data_alloc_profile(fs_info) &
-			     BTRFS_BLOCK_GROUP_RAID56_MASK);
-	struct btrfs_dio_private *dip;
-	struct bio *bio;
-	u64 start_sector;
-	int async_submit = 0;
-	u64 submit_len;
-	u64 clone_offset = 0;
-	u64 clone_len;
-	blk_status_t status;
-	struct btrfs_dio_data *dio_data = iter->private;
-	u64 len;
-
-	dip = btrfs_create_dio_private(dio_bio, inode, file_offset);
-	if (!dip) {
-		if (!write) {
-			unlock_extent(&BTRFS_I(inode)->io_tree, file_offset,
-				file_offset + dio_bio->bi_iter.bi_size - 1);
-		}
-		dio_bio->bi_status = BLK_STS_RESOURCE;
-		bio_endio(dio_bio);
-		return;
-	}
-
-	if (!write) {
-		/*
-		 * Load the csums up front to reduce csum tree searches and
-		 * contention when submitting bios.
-		 *
-		 * If we have csums disabled this will do nothing.
-		 */
-		status = btrfs_lookup_bio_sums(inode, dio_bio, dip->csums);
-		if (status != BLK_STS_OK)
+		ret = btrfs_lookup_bio_sums(iter->inode, bio, NULL);
+		if (ret)
 			goto out_err;
 	}
 
-	start_sector = dio_bio->bi_iter.bi_sector;
-	submit_len = dio_bio->bi_iter.bi_size;
-
-	do {
-		struct block_device *bdev;
-
-		bdev = btrfs_get_stripe_info(fs_info, btrfs_op(dio_bio),
-				      start_sector << 9, submit_len, &len);
-		if (IS_ERR(bdev)) {
-			status = errno_to_blk_status(PTR_ERR(bdev));
-			goto out_err;
-		}
-
-		clone_len = min(submit_len, len);
-		ASSERT(clone_len <= UINT_MAX);
-
-		/*
-		 * This will never fail as it's passing GPF_NOFS and
-		 * the allocation is backed by btrfs_bioset.
-		 */
-		bio = btrfs_bio_clone_partial(inode, dio_bio, clone_offset,
-					      clone_len);
-		bio->bi_private = dip;
-		bio->bi_end_io = btrfs_end_dio_bio;
-		btrfs_bio(bio)->file_offset = file_offset;
-
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-			status = extract_ordered_extent(BTRFS_I(inode), bio,
-							file_offset);
-			if (status) {
-				bio_put(bio);
-				goto out_err;
-			}
-		}
-
-		ASSERT(submit_len >= clone_len);
-		submit_len -= clone_len;
-
-		/*
-		 * Increase the count before we submit the bio so we know
-		 * the end IO handler won't happen before we increase the
-		 * count. Otherwise, the dip might get freed before we're
-		 * done setting it up.
-		 *
-		 * We transfer the initial reference to the last bio, so we
-		 * don't need to increment the reference count for the last one.
-		 */
-		if (submit_len > 0) {
-			refcount_inc(&dip->refs);
-			/*
-			 * If we are submitting more than one bio, submit them
-			 * all asynchronously. The exception is RAID 5 or 6, as
-			 * asynchronous checksums make it difficult to collect
-			 * full stripe writes.
-			 */
-			if (!raid56)
-				async_submit = 1;
-		}
-
-		status = btrfs_submit_dio_bio(bio, inode, file_offset,
-						async_submit);
-		if (status) {
-			bio_put(bio);
-			if (submit_len > 0)
-				refcount_dec(&dip->refs);
-			goto out_err;
-		}
+	ret = btrfs_map_bio(fs_info, bio, 0);
+	if (ret)
+		goto out_err;
 
-		dio_data->submitted += clone_len;
-		clone_offset += clone_len;
-		start_sector += clone_len >> 9;
-		file_offset += clone_len;
-	} while (submit_len > 0);
 	return;
 
 out_err:
-	dip->dio_bio->bi_status = status;
-	btrfs_dio_private_put(dip);
+	bio->bi_status = ret;
+	bio_endio(bio);
 }
 
 static const struct iomap_dio_ops btrfs_dio_ops = {
-	.submit_io		= btrfs_submit_direct,
+	.submit_io		= btrfs_dio_submit_io,
+	.bio_set		= &btrfs_bioset,
 };
 
 ssize_t btrfs_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		size_t done_before)
 {
-	struct btrfs_dio_data data;
+	struct btrfs_dio_data data = {};
 
 	iocb->private = &data;
 	return iomap_dio_rw(iocb, iter, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index c6425760f69da..e9d775398141b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -341,6 +341,7 @@ struct btrfs_bio {
 
 	/* for direct I/O */
 	u64 file_offset;
+	atomic_t repair_refs;
 
 	/* @device is for stripe IO submission. */
 	struct btrfs_device *device;
-- 
2.30.2

