Return-Path: <linux-fsdevel+bounces-56173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83683B14322
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8E518C2F0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 20:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F98280312;
	Mon, 28 Jul 2025 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPvLf9Ls"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDC27F18F
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734702; cv=none; b=NEmvLo20xEeo5+NqVRln907JVNoMFrLDufM+wVlND9RzM2xvIddkA3XfSMNIgijrkOiXd7a2WfgqeRWEVU+q2E7RnUsG2tgDcVUNKWpGmGNaYkmyIa8OdOpOqMm8cguPuNIt2JquHf15O6Iizn2KfwTvVQUzwuzYA+1YQSF/7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734702; c=relaxed/simple;
	bh=e2Es8wdMZS3flVZE32C0SddB+C3q6km56xQ6O1IEFg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BRlvuv9siN89d4RD8DTOgoHJ+3Fvz/4bsrJ3m8B1Tnb5U9zP4+H1c81IFPdmR61fkcr2+g9psnJqSb/Jbhgcfu1J6O/6Kk/v8SxtEtuQoJyiNaiT247n9AvfCmBLb09zeUnFQhbqaJTA+N3I7acmc4hts8yaTcQ993x1juV3GQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPvLf9Ls; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753734697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fvqI97skDcdihaUcfdESswaCFQ+0IHtIhkl6iPdsNPg=;
	b=NPvLf9LsNMQIT4tZ980tYvDHiRFk2cDoJIiTG3RVjSwolvFfIN5Jp4ujLUCxp6yzburE7y
	hHtW2zOB8UKsUAlUxOEyQz+OIb2v1zxxc9ObhWoEyILhxltrlzM+sCYfZDhTIFbEG47/gp
	hV/iV7o4uXtOWSp/SsM4lMp6cSjc9DU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-q8GRFkloON20oNba1LOfCA-1; Mon, 28 Jul 2025 16:31:36 -0400
X-MC-Unique: q8GRFkloON20oNba1LOfCA-1
X-Mimecast-MFC-AGG-ID: q8GRFkloON20oNba1LOfCA_1753734695
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aec53d77a78so329749766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734695; x=1754339495;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvqI97skDcdihaUcfdESswaCFQ+0IHtIhkl6iPdsNPg=;
        b=DU77OySjfC12kQ+BavqRJit+5F7VLNJifNCUhw25SP5xPueNuXptrm1O1+g38NB84j
         eSfsJzknb18yjizN8n7OUWsUpEvW8Of5Wc1azYenxli6EamxpE4r+I0exyyF+qn9c82q
         82J5n5TuZaAVyYPAqaaF0jkPD/CosswLp69hGEnWSR+SjgEaC96L2IOItyEuVgFyq5NG
         uJn+jynTLPqwzeTCbgbd6cHc1tT05aVoO4+CwTm/FgQOMUAVSQ8G1ZP75yuX4k/EApYJ
         KwNC9Q096TZQoakTVxbdt/apxcQrReaHO+29Pv+JzK9YRAsObDRWTH5hj/yjNXsOqzX2
         AG9A==
X-Forwarded-Encrypted: i=1; AJvYcCVPZ5iWRPi+ahfWl6SOKpMPXx7rKpstXWtJQtxBk9po1/c+ap6Hr2hT7f63WUzHk42YmJ8j5XPbKGqq6Yzi@vger.kernel.org
X-Gm-Message-State: AOJu0YzS80NL5omaqNViZltipGYrQqPWhus0Ziu4PTffp/5PA9m5dAAe
	PwjUVuyPlY/iMYTo5lmyqIjhK7cnITaOiMmYZyMRUHegmUlt1yXPvRs3iUhVFGKyQ8wb0Cm9oVj
	1HA61/1culXdqgjLDglpQ9sadyIrbB0NbD4Eb8/JifX9LPLtv0fVkahRxjyZAvPX8zQ==
X-Gm-Gg: ASbGncsx0uZ2db4P11dhnauAkVZ2bz8fwEGO4RBJZdSajUiFyj8OeZj581iXXPCPp2l
	2Nao6Tqo+zJkKw+OnDB9vjVA7jPbFVoJqo0rWIO15BeXhQ4fZuN4MS9mqMDkI+3ZrFH0waCROSC
	Xd6MpWmf/GsE0RDq1m+c0BC3EXkneUTR8ug1LdyMInlVvex6Riy3nHCbo8utYf6cS27cpfmkLJF
	y08ZOF7x0SstygSb92ArexdPnBHcQDiFB/DFunsP/1qh7XZ02Th+ivZkr7XoP0BjWbZtoCJkPm4
	9EVVTMDO8MYpseg44Y8ldBn3V3PVjoX15EiImORBTKyD6A==
X-Received: by 2002:a17:907:6094:b0:aec:5a33:1573 with SMTP id a640c23a62f3a-af619aff33bmr1469782066b.41.1753734694763;
        Mon, 28 Jul 2025 13:31:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKdwUM2CclfdDA13FdRZxfJ5fkS7FGoXEXw0DfaKG1iA+ZQc1AKCb99WjAD4cRzc3GP882PQ==
X-Received: by 2002:a17:907:6094:b0:aec:5a33:1573 with SMTP id a640c23a62f3a-af619aff33bmr1469778866b.41.1753734694269;
        Mon, 28 Jul 2025 13:31:34 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615226558d3sm2730656a12.45.2025.07.28.13.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:31:33 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 28 Jul 2025 22:30:17 +0200
Subject: [PATCH RFC 13/29] iomap: integrate fs-verity verification into
 iomap's read path
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-fsverity-v1-13-9e5443af0e34@kernel.org>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
In-Reply-To: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
To: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org, 
 ebiggers@kernel.org, hch@lst.de
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9669; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=rjgW2vyykgaPWHIMXQZ/4WOAMTbqoRf6Z7u6KDVUOpw=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtrvSRRMjn7KxJtV9yAudfmX0xW27ttmr14w4boK1
 5tjat2nTY06SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATKRRjpHhtP56n4SiY5J/
 Te4UTA1YJz2zRWOVqiCzHZ/t/bXPtJ98YmQ4y/puwlINtvDswBNvxEpPxNcmBHRMvcVX6zMxkfv
 6gVesAP3gRdA=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

This patch adds fs-verity verification into iomap's read path. After
BIO's io operation is complete the data are verified against
fs-verity's Merkle tree. Verification work is done in a separate
workqueue.

The read path ioend iomap_read_ioend are stored side by side with
BIOs if FS_VERITY is enabled.

[djwong: fix doc warning]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/iomap/buffered-io.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/iomap/ioend.c       |  41 +++++++++++++-
 include/linux/iomap.h  |  13 +++++
 3 files changed, 198 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index e959a206cba9..87c974e543e0 100644
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
@@ -363,6 +364,116 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
 		pos >= i_size_read(iter->inode);
 }
 
+#ifdef CONFIG_FS_VERITY
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
+
+/*
+ * True if tree is not aligned with fs block/folio size and we need zero tail
+ * part of the folio
+ */
+static bool
+iomap_fsverity_tree_end_align(struct iomap_iter *iter, struct folio *folio,
+		loff_t pos, size_t plen)
+{
+	int error;
+	u8 log_blocksize;
+	u64 tree_size, tree_mask, last_block_tree, last_block_pos;
+
+	/* Not a Merkle tree */
+	if (!(iter->iomap.flags & IOMAP_F_BEYOND_EOF))
+		return false;
+
+	if (plen == folio_size(folio))
+		return false;
+
+	if (iter->inode->i_blkbits == folio_shift(folio))
+		return false;
+
+	error = fsverity_merkle_tree_geometry(iter->inode, &log_blocksize, NULL,
+			&tree_size);
+	if (error)
+		return false;
+
+	/*
+	 * We are beyond EOF reading Merkle tree. Therefore, it has highest
+	 * offset. Mask pos with a tree size to get a position whare are we in
+	 * the tree. Then, compare index of a last tree block and the index of
+	 * current pos block.
+	 */
+	last_block_tree = (tree_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	tree_mask = (1 << fls64(tree_size)) - 1;
+	last_block_pos = ((pos & tree_mask) >> PAGE_SHIFT) + 1;
+
+	return last_block_tree == last_block_pos;
+}
+#else
+# define iomap_fsverity_read_bio_alloc(...)	(NULL)
+# define iomap_fsverity_tree_end_align(...)	(false)
+#endif /* CONFIG_FS_VERITY */
+
+static struct bio *iomap_read_bio_alloc(struct inode *inode,
+		const struct iomap *iomap, int nr_vecs, gfp_t gfp)
+{
+	struct bio *bio;
+	struct block_device *bdev = iomap->bdev;
+
+	if (fsverity_active(inode) && !(iomap->flags & IOMAP_F_BEYOND_EOF))
+		return iomap_fsverity_read_bio_alloc(inode, bdev, nr_vecs, gfp);
+
+	bio = bio_alloc(bdev, nr_vecs, REQ_OP_READ, gfp);
+	if (bio)
+		bio->bi_end_io = iomap_read_end_io;
+	return bio;
+}
+
 static int iomap_readpage_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
@@ -375,6 +486,10 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	sector_t sector;
 	int ret;
 
+	/* Fail reads from broken fsverity files immediately. */
+	if (IS_VERITY(iter->inode) && !fsverity_active(iter->inode))
+		return -EIO;
+
 	if (iomap->type == IOMAP_INLINE) {
 		ret = iomap_read_inline_data(iter, folio);
 		if (ret)
@@ -391,6 +506,11 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	if (iomap_block_needs_zeroing(iter, pos) &&
 	    !(iomap->flags & IOMAP_F_BEYOND_EOF)) {
 		folio_zero_range(folio, poff, plen);
+		if (fsverity_active(iter->inode) &&
+		    !fsverity_verify_blocks(folio, plen, poff)) {
+			return -EIO;
+		}
+
 		iomap_set_range_uptodate(folio, poff, plen);
 		goto done;
 	}
@@ -408,32 +528,51 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
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
+		ctx->bio = iomap_read_bio_alloc(iter->inode, iomap,
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
+					iomap, 1, orig_gfp);
 		}
 		if (ctx->rac)
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
-		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
 
 done:
+	/*
+	 * For post EOF region, zero part of the folio which won't be read. This
+	 * happens at the end of the region. So far, the only user is
+	 * fs-verity which stores continuous data region.
+	 *
+	 * We also check the fs block size as plen could be smaller than the
+	 * block size. If we zero part of the block and mark the whole block
+	 * (iomap_set_range_uptodate() works with fsblocks) as uptodate the
+	 * iomap_finish_folio_read() will toggle the uptodate bit when the folio
+	 * is read.
+	 */
+	if (iomap_fsverity_tree_end_align(iter, folio, pos, plen)) {
+		folio_zero_range(folio, poff + plen,
+				folio_size(folio) - (poff + plen));
+		iomap_set_range_uptodate(folio, poff + plen,
+				folio_size(folio) - (poff + plen));
+	}
+
 	/*
 	 * Move the caller beyond our range so that it keeps making progress.
 	 * For that, we have to include any leading non-uptodate ranges, but
diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 18894ebba6db..400751d82313 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -6,6 +6,8 @@
 #include <linux/list_sort.h>
 #include "internal.h"
 
+#define IOMAP_POOL_SIZE		(4 * (PAGE_SIZE / SECTOR_SIZE))
+
 struct bio_set iomap_ioend_bioset;
 EXPORT_SYMBOL_GPL(iomap_ioend_bioset);
 
@@ -207,9 +209,46 @@ struct iomap_ioend *iomap_split_ioend(struct iomap_ioend *ioend,
 }
 EXPORT_SYMBOL_GPL(iomap_split_ioend);
 
+#ifdef CONFIG_FS_VERITY
+struct bio_set *iomap_fsverity_bioset;
+EXPORT_SYMBOL_GPL(iomap_fsverity_bioset);
+int iomap_fsverity_init_bioset(void)
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
+EXPORT_SYMBOL_GPL(iomap_fsverity_init_bioset);
+#else
+# define iomap_fsverity_init_bioset(...)	(-EOPNOTSUPP)
+#endif
+
 static int __init iomap_ioend_init(void)
 {
-	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
+	return bioset_init(&iomap_ioend_bioset, IOMAP_POOL_SIZE,
 			   offsetof(struct iomap_ioend, io_bio),
 			   BIOSET_NEED_BVECS);
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 73288f28543f..f845876ad8d2 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -339,6 +339,19 @@ static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
 		iter->srcmap.type == IOMAP_MAPPED;
 }
 
+#ifdef CONFIG_FS_VERITY
+extern struct bio_set *iomap_fsverity_bioset;
+
+struct iomap_fsverity_bio {
+	struct work_struct	work;
+	struct bio		bio;
+};
+
+int iomap_init_fsverity(struct super_block *sb, unsigned int wq_flags,
+			int max_active);
+int iomap_fsverity_init_bioset(void);
+#endif
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops, void *private);
 int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);

-- 
2.50.0


