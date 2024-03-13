Return-Path: <linux-fsdevel+bounces-14335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E587B097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FE81C264E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C81448D4;
	Wed, 13 Mar 2024 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqd8d32S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043C058AC5;
	Wed, 13 Mar 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352559; cv=none; b=g6IE6fXSq4WHv4iiiHup5HfZHq9Ae7gFTeWjGvg5lsqGdQUQyPuQ91tOzUcZyd4A6pODxNFbsod1SbGxpuPoCfSkVOYfDIMCzzp5rotaFJtEvdBZf92znM1ZUt7igznxQ+lJLonxuIiw5yeFRQHFRa35LfPor8UXUySFRs8VU+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352559; c=relaxed/simple;
	bh=kMdqz7RLV569ab/XXjmmU/XwIDmkNbuvXEq3UWvjaMk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUk/4ASyBEl3SH3WOsKFqyR5Lp29/kzgrTRWZIdweFGif7AHZezRfXzT4WEZ1qeNzpsUyhCyFB7u5SuC6CCGgIQOKdxuzszZ7Chq65If4Q7r/CpDs2NN9qv0qNk6B9UyfukdTu85gYnQrE7wy+CCZEI8ogXM8k/SETIlbKZTnbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqd8d32S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8049AC4166B;
	Wed, 13 Mar 2024 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710352558;
	bh=kMdqz7RLV569ab/XXjmmU/XwIDmkNbuvXEq3UWvjaMk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Tqd8d32SPrM/Q+9QfN+LaIUCtlJfaksXsZ0OsjGQBCMkzvmcfGKVeC+azvctN7qHP
	 Ey5DdeL0CGSipalmGOhr0IRj7zjy1C9GHs0Kgxr0p/Z4Ex95ESIu3fZrflycLba78V
	 7jA0REUdQsnJVQr7sOBqCbDqV/Y4G9kJQ1TeSaV8rNQqukqShsN7+9ZEztnn5MBiWE
	 NPM4YVCH/a/5/PsBZmOwrJFREVRrFA/krRILQohStdtpW/GwY4pgSjbhcGGrv6Lygw
	 GEHFUx33wBHAF1kJgoC167ic2NFUj2CZi/Ic08/fU6R3cw74BLVvybfxf2nC+oT8is
	 kjJ+Epx5dBo9A==
Date: Wed, 13 Mar 2024 10:55:58 -0700
Subject: [PATCH 13/29] iomap: integrate fs-verity verification into iomap's
 read path
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, aalbersh@redhat.com, ebiggers@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Message-ID: <171035223568.2613863.4052027843522117859.stgit@frogsfrogsfrogs>
In-Reply-To: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
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
 fs/iomap/buffered-io.c |   91 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 9 deletions(-)


diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 093c4515b22a..c708a93d6a02 100644
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
@@ -330,6 +331,56 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		pos >= i_size_read(iter->inode);
 }
 
+#ifdef CONFIG_FS_VERITY
+struct iomap_fsverity_bio {
+	struct work_struct	work;
+	struct bio		bio;
+};
+static struct bio_set iomap_fsverity_bioset;
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
+#endif /* CONFIG_FS_VERITY */
+
+static struct bio *iomap_read_bio_alloc(struct inode *inode,
+		struct block_device *bdev, int nr_vecs, gfp_t gfp)
+{
+	struct bio *bio;
+
+#ifdef CONFIG_FS_VERITY
+	if (fsverity_active(inode)) {
+		bio = bio_alloc_bioset(bdev, nr_vecs, REQ_OP_READ, gfp,
+					&iomap_fsverity_bioset);
+		if (bio) {
+			bio->bi_private = inode->i_sb->s_read_done_wq;
+			bio->bi_end_io = iomap_read_fsverity_end_io;
+		}
+		return bio;
+	}
+#endif
+	bio = bio_alloc(bdev, nr_vecs, REQ_OP_READ, gfp);
+	if (bio)
+		bio->bi_end_io = iomap_read_end_io;
+	return bio;
+}
+
 static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx, loff_t offset)
 {
@@ -353,6 +404,12 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
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
@@ -370,28 +427,29 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
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
 
@@ -1996,10 +2054,25 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
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


