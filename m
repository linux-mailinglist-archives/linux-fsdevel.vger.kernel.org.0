Return-Path: <linux-fsdevel+bounces-13531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EBA870A4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99CF01F228B5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADC77BB15;
	Mon,  4 Mar 2024 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sf5scRNu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA667A715
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579547; cv=none; b=bo9O34fc7KI3WElxrxNsYNhMILGtoeApuyjfIu2phgDXXTOb2+/scLQWjtxaP73zeJ/WMworwNUbLtVcdOZjA5awqlMe8KqLYTILQgBBtLz1TSB13Z+8Hq1AtMOc/ocPv/pLu01zBRzd67CSV1vYWrtLpJhJWXMhAWTC8M/Hedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579547; c=relaxed/simple;
	bh=Vt7WvP2XhADPbA/qo1mYoxhY+7xb8p2lGDruDcXdPMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNh4VKHwAcY1qtdvr/r+qs6IFQdQi2hhMyeKS4c5j72lbC8PI6VL0SnVlJ5D5te1XK9sn8DhCoucVdgw3e8p6CzO+vaHYkyjA3ca0n6kL4x0B7zvqe0qAm0hSsENk8cEtEpMJkQ0PFrXDDjbSdJHQlCO2TAFZm9LSLGpNNlgrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sf5scRNu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/shyD/zHMRWtd9bWbKxXT0byjIZQKYEyRELvQZ4LTg=;
	b=Sf5scRNuWiA6yiOrDfY5VVTOllNe9WI8PcJq5afUyWM+kJWcQBrYv6+uKoPlgH3fs824zG
	nj3m3MJrqvEnqHkyTcF/38Oir0INSuhzqAQwVH6FqVMwK4q8mO9xaygKcw8F1T8knYWrdd
	rFV2kIviwA62IoqQaYfUs/hmftnlLIA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-eFq-ck9XPeOr_ru1zJZKBA-1; Mon, 04 Mar 2024 14:12:21 -0500
X-MC-Unique: eFq-ck9XPeOr_ru1zJZKBA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a449be9db59so197161366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579540; x=1710184340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/shyD/zHMRWtd9bWbKxXT0byjIZQKYEyRELvQZ4LTg=;
        b=GPB4V2OBbMbmEsEhnBuSq/jpE9fOQxKoL1L7/P/kZ/RINb0LAlriyw6EoM5WrNosto
         wuja3wd7cUac3UULmLYlmDvsJjuP8sa+Q1PhA3eXUZsowZAmMZtknGwlngSS/kugsuAp
         f5LBf5ViPNEZ63GdmmBMmvLiq1R/Uj3nJ3xRN7Z4MAy1pLo6NRR499Awa4w+w4lnDP+y
         HlaQoXFE+qUUIeODc3dQY4V+LO+3NXk/wEi4/uQwaHWIsBH+EV85yQb35f68Akk4UY4e
         5fK+CNyjqKibUhOzXeNNBi7ZKXEjG3wOF61FfB++ty/nuJ4KiqGTTU3ZSevj2whHmPX7
         +/tg==
X-Forwarded-Encrypted: i=1; AJvYcCVc0DVQW8ti98nZ6R+VNqjJbeJFjWssZaVZAIwnyrX8J2Z2huK0kR5+KxT/lEvs9Ulq4r6UFEpQCKdLSi79uhKGD+qUDTY6HNuFAb9cXA==
X-Gm-Message-State: AOJu0YxGeaovb55DPvP5FaxLR7xHbbZoW31RO0c7P2VUwPgdCWZwQfx/
	Z3hmVpHAko17eHReMmvWcSje+nIkIhmuco0w6XdFFc/lCVPeh7bDFf8kScKy7l2yUWEXnCvDvX9
	pZp22oWPkxD55liDLoVT1OInEgEghwwQPjXjEYhNbWaTpWBaKfr8PJE5qk1dMkw==
X-Received: by 2002:a17:907:20b9:b0:a3d:4ed8:f5bf with SMTP id pw25-20020a17090720b900b00a3d4ed8f5bfmr5798151ejb.2.1709579540391;
        Mon, 04 Mar 2024 11:12:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZJKgr6p4QAsWxEf89MCCY1JTA2uvYFezCjzZbDgLzFJTT4VF+2CzblpR+va0nmjLJBQhYdw==
X-Received: by 2002:a17:907:20b9:b0:a3d:4ed8:f5bf with SMTP id pw25-20020a17090720b900b00a3d4ed8f5bfmr5798135ejb.2.1709579540109;
        Mon, 04 Mar 2024 11:12:20 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:19 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 10/24] iomap: integrate fs-verity verification into iomap's read path
Date: Mon,  4 Mar 2024 20:10:33 +0100
Message-ID: <20240304191046.157464-12-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds fs-verity verification into iomap's read path. After
BIO's io operation is complete the data are verified against
fs-verity's Merkle tree. Verification work is done in a separate
workqueue.

The read path ioend iomap_read_ioend are stored side by side with
BIOs if FS_VERITY is enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 92 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 9 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 093c4515b22a..e27a8af4b351 100644
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
 
@@ -471,6 +529,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * iomap_readahead - Attempt to read pages from a file.
  * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
+ * @wq: Workqueue for post-I/O processing (only need for fsverity)
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -1996,10 +2055,25 @@ iomap_writepages(struct address_space *mapping, struct writeback_control *wbc,
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
-- 
2.42.0


