Return-Path: <linux-fsdevel+bounces-18229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE78B6878
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D991C217DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A981094E;
	Tue, 30 Apr 2024 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVBat7jk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8C5DDA6;
	Tue, 30 Apr 2024 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447447; cv=none; b=DsarHA2Nb7oq7qRXm+EtnAPOi8FddM0DuRO4V2O3LLxsqXhpqLzkqdKrY8a+xwU3y3358W/3DhfxeNhpRpXuhwqvbz0sJWCUOR1txY0iwujO9koHOvrl5jBtYAFeQuRvyblaz4QVEPUM6zAeNrlRi7nnyjuImcvPFduIsIiuEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447447; c=relaxed/simple;
	bh=zYCnvovwQsV/o4rIrrIQz2fleBCOcrRw8dsnJc1wStw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkaAN4bSYkn/nUa2WCxoPKDZ/kw505XyvQVr8WpXMZiAJyhWBcToaaYUn4elE5L140U8OLAsMG5sPe3oSvETv1c6rYDFRkw4mKzL3rP16Qd/Rm2MQ1FYTHFgbofyCBAJ4yKoK2Il2eQLTIC9fTJee1KW2Bt14MfSHAMxH4V8FIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVBat7jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56E8C116B1;
	Tue, 30 Apr 2024 03:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447446;
	bh=zYCnvovwQsV/o4rIrrIQz2fleBCOcrRw8dsnJc1wStw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=tVBat7jkWr0KQUhzDVIOIi3mhsU3DhBXOuEaj8pvH1uWW/LDamdoxoH7Onj0iyKgn
	 sWSpa/DaX0x/xLlonXLp0P4p9f7gTqrTGwitXJ89Lqu6FMzoI+IiI5j2hk4OfDwNtB
	 VROOQ3cNTjZZW0G9P4BKcSAr1uiAli3rwglcyvl5LIWioqhzrmxdOKl1Chl49VSe1j
	 1bmLy6dQxfeZRQj1fPGIyoZXkhAVJIxIc0NVwfQlIsMrTQ9EBLY+UlW4KBp1Z52Xi8
	 9V7OUii2nam5Bsolt8YZ972Cn9mzV+Si9qqA5SAlcsXpfnR2/rp6LJLpMgH6JK/AN7
	 IMR7iV97iUhMQ==
Date: Mon, 29 Apr 2024 20:24:06 -0700
Subject: [PATCH 18/18] iomap: integrate fs-verity verification into iomap's
 read path
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
 alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Message-ID: <171444679890.955480.13343949435701450583.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Andrey Albershteyn <aalbersh@redhat.com>

This patch adds fs-verity verification into iomap's read path. After
BIO's io operation is complete the data are verified against
fs-verity's Merkle tree. Verification work is done in a separate
workqueue.

The read path ioend iomap_read_ioend are stored side by side with
BIOs if FS_VERITY is enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix doc warning]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |  133 +++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/iomap.h  |    5 ++
 2 files changed, 131 insertions(+), 7 deletions(-)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4e8e41c8b3c0e..0167f820914ff 100644
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
@@ -23,6 +24,8 @@
 
 #define IOEND_BATCH_SIZE	4096
 
+#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
+
 typedef int (*iomap_punch_t)(struct inode *inode, loff_t offset, loff_t length);
 /*
  * Structure allocated for each folio to track per-block uptodate, dirty state
@@ -368,6 +371,111 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		pos >= i_size_read(iter->inode);
 }
 
+#ifdef CONFIG_FS_VERITY
+struct iomap_fsverity_bio {
+	struct work_struct	work;
+	struct bio		bio;
+};
+static struct bio_set *iomap_fsverity_bioset;
+
+static int iomap_fsverity_init_bioset(void)
+{
+	struct bio_set *bs, *old;
+	int error;
+
+	bs = kzalloc(sizeof(*bs), GFP_KERNEL);
+	if (!bs)
+		return -ENOMEM;
+
+	error = bioset_init(bs, IOMAP_POOL_SIZE,
+			    offsetof(struct iomap_fsverity_bio, bio),
+			    BIOSET_NEED_BVECS);
+	if (error) {
+		kfree(bs);
+		return error;
+	}
+
+	/*
+	 * This has to be atomic as readaheads can race to create the
+	 * bioset.  If someone set the pointer before us, we drop ours.
+	 */
+	old = cmpxchg(&iomap_fsverity_bioset, NULL, bs);
+	if (old) {
+		bioset_exit(bs);
+		kfree(bs);
+	}
+
+	return 0;
+}
+
+int iomap_init_fsverity(struct super_block *sb, unsigned int wq_flags,
+			int max_active)
+{
+	int ret;
+
+	if (!iomap_fsverity_bioset) {
+		ret = iomap_fsverity_init_bioset();
+		if (ret)
+			return ret;
+	}
+
+	return fsverity_init_wq(sb, wq_flags, max_active);
+}
+EXPORT_SYMBOL_GPL(iomap_init_fsverity);
+
+static void
+iomap_read_fsverify_end_io_work(struct work_struct *work)
+{
+	struct iomap_fsverity_bio *fbio =
+		container_of(work, struct iomap_fsverity_bio, work);
+
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
+
+static struct bio *
+iomap_fsverity_read_bio_alloc(struct inode *inode, struct block_device *bdev,
+			    int nr_vecs, gfp_t gfp)
+{
+	struct bio *bio;
+
+	bio = bio_alloc_bioset(bdev, nr_vecs, REQ_OP_READ, gfp,
+			iomap_fsverity_bioset);
+	if (bio) {
+		bio->bi_private = inode->i_sb->s_verity_wq;
+		bio->bi_end_io = iomap_read_fsverity_end_io;
+	}
+	return bio;
+}
+#else
+# define iomap_fsverity_read_bio_alloc(...)	(NULL)
+# define iomap_fsverity_init_bioset(...)	(-EOPNOTSUPP)
+#endif /* CONFIG_FS_VERITY */
+
+static struct bio *iomap_read_bio_alloc(struct inode *inode,
+		struct block_device *bdev, int nr_vecs, gfp_t gfp)
+{
+	struct bio *bio;
+
+	if (fsverity_active(inode))
+		return iomap_fsverity_read_bio_alloc(inode, bdev, nr_vecs, gfp);
+
+	bio = bio_alloc(bdev, nr_vecs, REQ_OP_READ, gfp);
+	if (bio)
+		bio->bi_end_io = iomap_read_end_io;
+	return bio;
+}
+
 static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t offset)
 {
@@ -380,6 +488,10 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	size_t poff, plen;
 	sector_t sector;
 
+	/* Fail reads from broken fsverity files immediately. */
+	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
+		return -EIO;
+
 	if (iomap->type == IOMAP_INLINE)
 		return iomap_read_inline_data(iter, folio);
 
@@ -391,6 +503,12 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
+		if (fsverity_active(iter->inode) &&
+		    !fsverity_verify_blocks(folio, plen, poff)) {
+			folio_set_error(folio);
+			goto done;
+		}
+
 		iomap_set_range_uptodate(folio, poff, plen);
 		goto done;
 	}
@@ -408,28 +526,29 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	    !bio_add_folio(ctx->bio, folio, plen, poff)) {
 		gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
 		gfp_t orig_gfp = gfp;
-		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
 
 		if (ctx->bio)
 			submit_bio(ctx->bio);
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
+
+		ctx->bio = iomap_read_bio_alloc(iter->inode, iomap->bdev,
+				bio_max_segs(DIV_ROUND_UP(length, PAGE_SIZE)),
+				gfp);
+
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_read_folio does.
 		 */
 		if (!ctx->bio) {
-			ctx->bio = bio_alloc(iomap->bdev, 1, REQ_OP_READ,
-					     orig_gfp);
+			ctx->bio = iomap_read_bio_alloc(iter->inode,
+					iomap->bdev, 1, orig_gfp);
 		}
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
 
@@ -1987,7 +2106,7 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
 
 static int __init iomap_init(void)
 {
-	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
+	return bioset_init(&iomap_ioend_bioset, IOMAP_POOL_SIZE,
 			   offsetof(struct iomap_ioend, io_bio),
 			   BIOSET_NEED_BVECS);
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d1..43ec614d64e87 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -256,6 +256,11 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 	return &i->iomap;
 }
 
+#ifdef CONFIG_FS_VERITY
+int iomap_init_fsverity(struct super_block *sb, unsigned int wq_flags,
+			int max_active);
+#endif
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,


