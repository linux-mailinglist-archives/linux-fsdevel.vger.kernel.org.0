Return-Path: <linux-fsdevel+bounces-382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D81597CA3CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8EDB20E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 09:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB7E1C2AF;
	Mon, 16 Oct 2023 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="asGkYUdJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E621775F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:15:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A370F9;
	Mon, 16 Oct 2023 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CZhZvdQQ3EZe8vFqbFcCuiiLm8jOgTSVaqi8kmgJ1lQ=; b=asGkYUdJYdm7nroEKWRh1cJXBZ
	Tl0G9hP5s5dtug9Q9mQH8n+Jsq9EbVoTT41bya/J5N0yMRtkO2p1aRENgtrrG8YbiTYhUMJPWZ1gd
	w/f9YPnhoV1p5olGsrTY3TmTwTBHea4IaWzIyCCuHbXAp8+qMSWk38IIdfAdDcbg4nkXR+2uk7yEN
	Ncspf4DL12gBSfLa3WsNYehZ8w8IgK7PawhHsGH/fudm0cKvAE5qTdlJkhMAw9zhVEEBc+3TFh/D4
	4LVd4sFRXG7P+uctnpuHdxLYRfOlZPHtM43qDPkmf0uKR+xKoxkzOaf0xt1cJZIIE4YMqRJ8eevw+
	YHMxiL4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qsJgi-008xWb-0s;
	Mon, 16 Oct 2023 09:15:00 +0000
Date: Mon, 16 Oct 2023 02:15:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, djwong@kernel.org, ebiggers@kernel.org,
	david@fromorbit.com, dchinner@redhat.com
Subject: Re: [PATCH v3 11/28] iomap: pass readpage operation to read path
Message-ID: <ZSz/FLK+tNIQzOA/@infradead.org>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-12-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-12-aalbersh@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Looking at the entire series, it seems like the only XFS-specific
part of the fsverity processing in iomap is the per-sb workqueue
now that the fsverity interfaces were cleaned up.

Based on that it seems like we'd be much better just doing all the
work inside iomap, and just allow XFS to pass the workqueue to
iomap_read_folio and iomap_readahead.  The patch below does that
as an untested WIP on top of your branch.

If we go down that way I suspect the better interface would be
to allocate the iomap_readpage_ctx in the callers of these functions
instead of passing an extra argument, but I'm not entirely sure
about that yet.

---
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0a1bec91fdf678..95077676b714cf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -6,6 +6,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/fsverity.h>
 #include <linux/iomap.h>
 #include <linux/pagemap.h>
 #include <linux/uio.h>
@@ -264,7 +265,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_unlock(folio);
 }
 
-void iomap_read_end_io(struct bio *bio)
+static void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
@@ -273,14 +274,13 @@ void iomap_read_end_io(struct bio *bio)
 		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
 	bio_put(bio);
 }
-EXPORT_SYMBOL_GPL(iomap_read_end_io);
 
 struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
 	struct bio		*bio;
 	struct readahead_control *rac;
-	const struct iomap_readpage_ops *ops;
+	struct workqueue_struct	*wq;
 };
 
 /**
@@ -332,17 +332,55 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		pos >= i_size_read(iter->inode);
 }
 
+#ifdef CONFIG_FS_VERITY
+struct iomap_fsverity_bio {
+	struct work_struct	work;
+	struct bio		bio;
+};
+static struct bio_set iomap_fsverity_bioset;
+
 static void
-iomap_submit_read_io(const struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+iomap_read_fsverify_end_io_work(struct work_struct *work)
 {
-	if (!ctx->bio)
-		return;
+	struct iomap_fsverity_bio *fbio =
+		container_of(work, struct iomap_fsverity_bio, work);
 
-	if (ctx->ops && ctx->ops->submit_io)
-		ctx->ops->submit_io(iter, ctx->bio, iter->pos);
-	else
-		submit_bio(ctx->bio);
+	fsverity_verify_bio(&fbio->bio);
+	iomap_read_end_io(&fbio->bio);
+}
+
+static void
+iomap_read_fsverity_end_io(struct bio *bio)
+{
+	struct iomap_fsverity_bio *fbio =
+		container_of(bio, struct iomap_fsverity_bio, bio);
+
+	INIT_WORK(&fbio->work, iomap_read_fsverify_end_io_work);
+	queue_work(bio->bi_private, &fbio->work);
+}
+#endif /* CONFIG_FS_VERITY */
+
+static struct bio *iomap_read_bio_alloc(struct inode *inode,
+		struct block_device *bdev, int nr_vecs, gfp_t gfp,
+		struct workqueue_struct *wq)
+{
+	struct bio *bio;
+
+#ifdef CONFIG_FS_VERITY
+	if (fsverity_active(inode)) {
+		bio = bio_alloc_bioset(bdev, nr_vecs, REQ_OP_READ, gfp,
+					&iomap_fsverity_bioset);
+		if (bio) {
+			bio->bi_private = wq;
+			bio->bi_end_io = iomap_read_fsverity_end_io;
+		}
+		return bio;
+	}
+#endif
+	bio = bio_alloc(bdev, nr_vecs, REQ_OP_READ, gfp);
+	if (bio)
+		bio->bi_end_io = iomap_read_end_io;
+	return bio;
 }
 
 static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
@@ -368,11 +406,10 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
-		if (iomap->flags & IOMAP_F_READ_VERITY) {
-			if (ctx->ops->verify_folio(folio, poff, plen)) {
-				folio_set_error(folio);
-				goto done;
-			}
+		if (fsverity_active(iter->inode) &&
+		    !fsverity_verify_blocks(folio, poff, plen)) {
+			folio_set_error(folio);
+			goto done;
 		}
 
 		iomap_set_range_uptodate(folio, poff, plen);
@@ -389,21 +426,16 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
 		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
-		iomap_submit_read_io(iter, ctx);
+		if (ctx->bio)
+			submit_bio(ctx->bio);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
 
-		if (ctx->ops && ctx->ops->bio_set)
-			ctx->bio = bio_alloc_bioset(iomap->bdev,
-						    bio_max_segs(nr_vecs),
-						    REQ_OP_READ, GFP_NOFS,
-						    ctx->ops->bio_set);
-		else
-			ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				REQ_OP_READ, gfp);
+		ctx->bio = iomap_read_bio_alloc(iter->inode, iomap->bdev,
+				bio_max_segs(DIV_ROUND_UP(length, PAGE_SIZE)),
+				gfp, ctx->wq);
 
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
@@ -411,13 +443,12 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		 * what do_mpage_read_folio does.
 		 */
 		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
+			ctx->bio = iomap_read_bio_alloc(iter->inode,
+					iomap->bdev, 1, orig_gfp, ctx->wq);
 		}
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
 
@@ -432,7 +463,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 }
 
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
-		const struct iomap_readpage_ops *readpage_ops)
+		struct workqueue_struct *wq)
 {
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
@@ -441,7 +472,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
 	};
 	struct iomap_readpage_ctx ctx = {
 		.cur_folio	= folio,
-		.ops		= readpage_ops,
+		.wq		= wq,
 	};
 	int ret;
 
@@ -454,7 +485,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
 		folio_set_error(folio);
 
 	if (ctx.bio) {
-		iomap_submit_read_io(&iter, &ctx);
+		submit_bio(ctx.bio);
 		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
 	} else {
 		WARN_ON_ONCE(ctx.cur_folio_in_bio);
@@ -499,7 +530,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * iomap_readahead - Attempt to read pages from a file.
  * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
- * @readpage_ops: Filesystem supplied folio processiong operation
+ * @wq: Workqueue for post-I/O processing (only need for fsverity)
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -512,7 +543,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * the filesystem to be reentered.
  */
 void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
-		const struct iomap_readpage_ops *readpage_ops)
+		struct workqueue_struct *wq)
 {
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
@@ -521,7 +552,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
 	};
 	struct iomap_readpage_ctx ctx = {
 		.rac	= rac,
-		.ops	= readpage_ops,
+		.wq	= wq,
 	};
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
@@ -529,7 +560,8 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
 	while (iomap_iter(&iter, ops) > 0)
 		iter.processed = iomap_readahead_iter(&iter, &ctx);
 
-	iomap_submit_read_io(&iter, &ctx);
+	if (ctx.bio)
+		submit_bio(ctx.bio);
 	if (ctx.cur_folio) {
 		if (!ctx.cur_folio_in_bio)
 			folio_unlock(ctx.cur_folio);
@@ -2022,10 +2054,25 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
 
+#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
+
 static int __init iomap_init(void)
 {
-	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
-			   offsetof(struct iomap_ioend, io_inline_bio),
-			   BIOSET_NEED_BVECS);
+	int error;
+
+	error = bioset_init(&iomap_ioend_bioset, IOMAP_POOL_SIZE,
+			    offsetof(struct iomap_ioend, io_inline_bio),
+			    BIOSET_NEED_BVECS);
+#ifdef CONFIG_FS_VERITY
+	if (error)
+		return error;
+
+	error = bioset_init(&iomap_fsverity_bioset, IOMAP_POOL_SIZE,
+			    offsetof(struct iomap_fsverity_bio, bio),
+			    BIOSET_NEED_BVECS);
+	if (error)
+		bioset_exit(&iomap_ioend_bioset);
+#endif
+	return error;
 }
 fs_initcall(iomap_init);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index fceb0c3de61ff3..1982bdb456d0ee 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -26,8 +26,6 @@ struct xfs_writepage_ctx {
 	unsigned int		cow_seq;
 };
 
-static struct bio_set xfs_read_ioend_bioset;
-
 static inline struct xfs_writepage_ctx *
 XFS_WPC(struct iomap_writepage_ctx *ctx)
 {
@@ -550,97 +548,30 @@ xfs_vm_bmap(
 	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
 }
 
-static void
-xfs_read_work_end_io(
-	struct work_struct *work)
+static inline struct workqueue_struct *
+xfs_fsverity_wq(
+	struct address_space	*mapping)
 {
-	struct iomap_read_ioend *ioend =
-		container_of(work, struct iomap_read_ioend, work);
-	struct bio *bio = &ioend->read_inline_bio;
-
-	fsverity_verify_bio(bio);
-	iomap_read_end_io(bio);
-	/*
-	 * The iomap_read_ioend has been freed by bio_put() in
-	 * iomap_read_end_io()
-	 */
+	if (fsverity_active(mapping->host))
+		return XFS_I(mapping->host)->i_mount->m_postread_workqueue;
+	return NULL;
 }
 
-static void
-xfs_read_end_io(
-	struct bio *bio)
-{
-	struct iomap_read_ioend *ioend =
-		container_of(bio, struct iomap_read_ioend, read_inline_bio);
-	struct xfs_inode	*ip = XFS_I(ioend->io_inode);
-
-	WARN_ON_ONCE(!queue_work(ip->i_mount->m_postread_workqueue,
-					&ioend->work));
-}
-
-static int
-xfs_verify_folio(
-	struct folio	*folio,
-	loff_t		pos,
-	unsigned int	len)
-{
-	if (fsverity_verify_blocks(folio, len, pos))
-		return 0;
-	return -EFSCORRUPTED;
-}
-
-int
-xfs_init_iomap_bioset(void)
-{
-	return bioset_init(&xfs_read_ioend_bioset,
-			   4 * (PAGE_SIZE / SECTOR_SIZE),
-			   offsetof(struct iomap_read_ioend, read_inline_bio),
-			   BIOSET_NEED_BVECS);
-}
-
-void
-xfs_free_iomap_bioset(void)
-{
-	bioset_exit(&xfs_read_ioend_bioset);
-}
-
-static void
-xfs_submit_read_bio(
-	const struct iomap_iter *iter,
-	struct bio *bio,
-	loff_t file_offset)
-{
-	struct iomap_read_ioend *ioend;
-
-	ioend = container_of(bio, struct iomap_read_ioend, read_inline_bio);
-	ioend->io_inode = iter->inode;
-	if (fsverity_active(ioend->io_inode)) {
-		INIT_WORK(&ioend->work, &xfs_read_work_end_io);
-		ioend->read_inline_bio.bi_end_io = &xfs_read_end_io;
-	}
-
-	submit_bio(bio);
-}
-
-static const struct iomap_readpage_ops xfs_readpage_ops = {
-	.verify_folio		= &xfs_verify_folio,
-	.submit_io		= &xfs_submit_read_bio,
-	.bio_set		= &xfs_read_ioend_bioset,
-};
-
 STATIC int
 xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops, &xfs_readpage_ops);
+	return iomap_read_folio(folio, &xfs_read_iomap_ops,
+				xfs_fsverity_wq(folio->mapping));
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops, &xfs_readpage_ops);
+	iomap_readahead(rac, &xfs_read_iomap_ops,
+			xfs_fsverity_wq(rac->mapping));
 }
 
 static int
diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index fa7c512b27176e..e0bd684197643d 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -10,7 +10,5 @@ extern const struct address_space_operations xfs_address_space_operations;
 extern const struct address_space_operations xfs_dax_aops;
 
 int	xfs_setfilesize(struct xfs_inode *ip, xfs_off_t offset, size_t size);
-int	xfs_init_iomap_bioset(void);
-void	xfs_free_iomap_bioset(void);
 
 #endif /* __XFS_AOPS_H__ */
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 80b249c420678a..18c8f168b1532d 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -132,9 +132,6 @@ xfs_bmbt_to_iomap(
 	    (ip->i_itemp->ili_fsync_fields & ~XFS_ILOG_TIMESTAMP))
 		iomap->flags |= IOMAP_F_DIRTY;
 
-	if (fsverity_active(VFS_I(ip)))
-		iomap->flags |= IOMAP_F_READ_VERITY;
-
 	iomap->validity_cookie = sequence_cookie;
 	iomap->folio_ops = &xfs_iomap_folio_ops;
 	return 0;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index f32392add622f3..880d9039437eb1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2385,17 +2385,11 @@ init_xfs_fs(void)
 	if (error)
 		goto out_remove_dbg_kobj;
 
-	error = xfs_init_iomap_bioset();
-	if (error)
-		goto out_qm_exit;
-
 	error = register_filesystem(&xfs_fs_type);
 	if (error)
-		goto out_iomap_bioset;
+		goto out_qm_exit;
 	return 0;
 
- out_iomap_bioset:
-	xfs_free_iomap_bioset();
  out_qm_exit:
 	xfs_qm_exit();
  out_remove_dbg_kobj:
@@ -2428,7 +2422,6 @@ init_xfs_fs(void)
 STATIC void __exit
 exit_xfs_fs(void)
 {
-	xfs_free_iomap_bioset();
 	xfs_qm_exit();
 	unregister_filesystem(&xfs_fs_type);
 #ifdef DEBUG
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8d7206cd2f0f49..c7522eb3a8eafd 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -53,9 +53,6 @@ struct vm_fault;
  *
  * IOMAP_F_XATTR indicates that the iomap is for an extended attribute extent
  * rather than a file data extent.
- *
- * IOMAP_F_READ_VERITY indicates that the iomap needs verification of read
- * folios
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -67,7 +64,6 @@ struct vm_fault;
 #define IOMAP_F_BUFFER_HEAD	0
 #endif /* CONFIG_BUFFER_HEAD */
 #define IOMAP_F_XATTR		(1U << 5)
-#define IOMAP_F_READ_VERITY	(1U << 6)
 
 /*
  * Flags set by the core iomap code during operations:
@@ -266,36 +262,10 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
 		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
 
-struct iomap_read_ioend {
-	struct inode		*io_inode;	/* file being read from */
-	struct work_struct	work;		/* post read work (e.g. fs-verity) */
-	struct bio		read_inline_bio;/* MUST BE LAST! */
-};
-
-struct iomap_readpage_ops {
-	/*
-	 * Optional, verify folio when successfully read
-	 */
-	int (*verify_folio)(struct folio *folio, loff_t pos, unsigned int len);
-
-	/*
-	 * Filesystems wishing to attach private information to a direct io bio
-	 * must provide a ->submit_io method that attaches the additional
-	 * information to the bio and changes the ->bi_end_io callback to a
-	 * custom function.  This function should, at a minimum, perform any
-	 * relevant post-processing of the bio and end with a call to
-	 * iomap_read_end_io.
-	 */
-	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
-			loff_t file_offset);
-	struct bio_set *bio_set;
-};
-
-void iomap_read_end_io(struct bio *bio);
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
-		const struct iomap_readpage_ops *readpage_ops);
+		struct workqueue_struct *wq);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
-		const struct iomap_readpage_ops *readpage_ops);
+		struct workqueue_struct *wq);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);

