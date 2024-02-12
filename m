Return-Path: <linux-fsdevel+bounces-11149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA866851A65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9E41C2255C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7553F8D1;
	Mon, 12 Feb 2024 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Djh54c3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3073EA8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757205; cv=none; b=tQT/avdbK758yomYwFPsacliTExEFzuD6f6L8tkZjSwxNMb5VDlOpRTkcHrGsmSSUs/Qq8xM8IolnE23vnhUf1Jng65L2uBPCxYSFczhs0MViDwEFZ7zsEBEFMWsMbm+dNY3d0SiCK+w7f8jJNrTtU/jMuxuFfrfiMiyYJ9WvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757205; c=relaxed/simple;
	bh=ykhQfKWuHsV04EnI2o5RitgAdbOcIAZZrnDV0B1Wz7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HBKoT6+4vtaC8zXaPsq61WE8zBwPzYbI6Tu8SiPPCqaU+aKyq/DoPRfqGGwks7KPejk4dAHJO6R3s/0x2MpXzRYYwnkOf4Y2aOTxaDh+J5p/bWIJlNE0jA82MO4TlC8oJ+O4ITcaQw/y915afI+4MGfTUBpvAsjlQaDuLuQq0c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Djh54c3u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1rjcwZ0Rr2XiOc2/6/uRIjv653Za/HHrJ87P2SLK6dc=;
	b=Djh54c3uQyjukCDYySGC170JPC0iIVXl/jZbI3/gfCSrsbkpf8AW3bF0WMVerrUlnGWapQ
	+yt74qDtCruqW3BzZLrReh73cCeGRHFcsJAujzk9JYlGExi4opCW1g55DAhVmGa3H/Df+Q
	eRQUpH6gYwHIqwX394Xw7JqWBdnU3SQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-Psc7opJjOTCJE6EYJgWxwg-1; Mon, 12 Feb 2024 11:59:59 -0500
X-MC-Unique: Psc7opJjOTCJE6EYJgWxwg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2bffe437b5so223263166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 08:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757198; x=1708361998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1rjcwZ0Rr2XiOc2/6/uRIjv653Za/HHrJ87P2SLK6dc=;
        b=UOeeK0o3mUT+QhxcK4+QZ+rt/2XU9vLFTAXtkCZ9XFx5qqwz/KM7JE0yeRxIsamCjU
         ThGnhKzg7HJ0cuS/jcFnx0Y82czbZypMzDLZdOinJY6gIBbHOAtxXOSQFYI2zyCQfEOS
         X0Mxuo252innlfx5CfLgS+ALJJ4ftvDhsA/96/MlVkNgrapUA3INq8AGBXiC6ZGjHeH0
         03xNFovLNlFAdmrNdIVE8JYdbjGTxjvf00/l6UZmXjMGbN2G7RXq18feBC86djVvaQva
         EHVkw5LgGbzlifDE0qYrU/r75BORJ/Cca58Yt6Ji8iSL0oAi6JoxYT2O1gruzQTeXaXZ
         QcoQ==
X-Gm-Message-State: AOJu0YwJg4ZTR5YKB2fK7TY4apaw/EW8smTRPjL5olRVjVols5Af083P
	VmbErGLlKPZGTo4arZ5wjgyWf5UJzFmRZqsjmqVEl1Bu/GUBFbDdiYmju/i9dGdmk1UrMEZ1dmh
	9+iC3Unpj+X4OezCgIrvS7OVJ7EudxCTk9mFNcGLX8S/lfmXm3DVsxkCUwalFWw==
X-Received: by 2002:aa7:ce09:0:b0:561:d4f0:eb14 with SMTP id d9-20020aa7ce09000000b00561d4f0eb14mr1075068edv.24.1707757198155;
        Mon, 12 Feb 2024 08:59:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrV4HkefzeD/lUvcrVUp0NxzWYYoatrN1WUPjbxa5Ak0YKZMHd6cREY48MPKQV1piavId3wg==
X-Received: by 2002:aa7:ce09:0:b0:561:d4f0:eb14 with SMTP id d9-20020aa7ce09000000b00561d4f0eb14mr1075053edv.24.1707757197684;
        Mon, 12 Feb 2024 08:59:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXoL6yMAYidy/lOKRY2jPCMiORGPkk95YuL1jAOO6tNDyxcUsB4d9UtXuoZT8q5rUy2U0Lr+iRt791uvwUuvGhpt64KzZpG2EF3repx8hifvPytV0NLwughyrDoPid3EKCsskNtxMrKtoAA6JCt7wFpVJNwR77UiOGGL4awivMvbJ+7h65gk6ebsBlI8Y0Ik9hdyZBfrPVgfbjC8on5SyYor5LSJJmcwbym
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:59:56 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 07/25] fsverity: support block-based Merkle tree caching
Date: Mon, 12 Feb 2024 17:58:04 +0100
Message-Id: <20240212165821.1901300-8-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current implementation fs-verity expects filesystem to
provide PAGEs filled with Merkle tree blocks. Then, when fs-verity
is done with processing the blocks, reference to PAGE is freed. This
doesn't fit well with the way XFS manages its memory.

To allow XFS integrate fs-verity this patch changes fs-verity
verification code to take Merkle tree blocks instead of PAGE
reference. Then, adds a thin compatibility layer to work with both
approaches. This way ext4, f2fs, and btrfs are still able to pass
PAGE references and XFS can pass reference to Merkle tree blocks
stored in XFS's buffer infrastructure.

Another addition is invalidation functions which tells fs-verity to
mark part of Merkle tree as not verified. These functions are used
by filesystem to tell fs-verity to invalidate blocks which were
evicted from memory.

Depending on Merkle tree block size fs-verity is using either bitmap
or PG_checked flag to track "verified" status of the blocks. With a
Merkle tree block caching (XFS) there is no PAGE to flag it as
verified. fs-verity always uses bitmap to track verified blocks for
filesystems which use block caching.

As verification function now works only with blocks - memory
barriers, used for verified status updates, are moved from
is_hash_block_verified() to fsverity_invalidate_page/range().
Depending on block or page caching, fs-verity clears bits in bitmap
based on PG_checked or from filesystem call out.

Further this patch allows filesystem to make additional processing
on verified pages instead of just dropping a reference via
fsverity_drop_block(). This will be used by XFS for internal buffer
cache manipulation in further patches. The btrfs, ext4, and f2fs
just drop the reference.

As btrfs, ext4 and f2fs return page with Merkle tree blocks this
patch also adds fsverity_read_merkle_tree_block() which wraps
addressing blocks in the page.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/verity/fsverity_private.h |  27 ++++
 fs/verity/open.c             |   8 +-
 fs/verity/read_metadata.c    |  48 +++---
 fs/verity/verify.c           | 280 ++++++++++++++++++++++++-----------
 include/linux/fsverity.h     |  69 +++++++++
 5 files changed, 316 insertions(+), 116 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b3506f56e180..72ac1cdd9e63 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -154,4 +154,31 @@ static inline void fsverity_init_signature(void)
 
 void __init fsverity_init_workqueue(void);
 
+/**
+ * fsverity_drop_block() - drop block obtained with ->read_merkle_tree_block()
+ * @inode: inode in use for verification or metadata reading
+ * @block: block to be dropped
+ *
+ * Calls out back to filesystem if ->drop_block() is set, otherwise, drop the
+ * reference in the block->context.
+ */
+void fsverity_drop_block(struct inode *inode,
+			 struct fsverity_blockbuf *block);
+
+/**
+ * fsverity_read_block_from_page() - general function to read Merkle tree block
+ * @inode: inode in use for verification or metadata reading
+ * @pos: byte offset of the block within the Merkle tree
+ * @block: block to read
+ * @num_ra_pages: number of pages to readahead, may be ignored
+ *
+ * Depending on fs implementation use read_merkle_tree_block() or
+ * read_merkle_tree_page() to read blocks.
+ */
+int fsverity_read_merkle_tree_block(struct inode *inode,
+				    u64 pos,
+				    struct fsverity_blockbuf *block,
+				    unsigned int log_blocksize,
+				    unsigned long num_ra_pages);
+
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/open.c b/fs/verity/open.c
index fdeb95eca3af..6e6922b4b014 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -213,7 +213,13 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 	if (err)
 		goto fail;
 
-	if (vi->tree_params.block_size != PAGE_SIZE) {
+	/*
+	 * If fs passes Merkle tree blocks to fs-verity (e.g. XFS), then
+	 * fs-verity should use hash_block_verified bitmap as there's no page
+	 * to mark it with PG_checked.
+	 */
+	if (vi->tree_params.block_size != PAGE_SIZE ||
+			inode->i_sb->s_vop->read_merkle_tree_block) {
 		/*
 		 * When the Merkle tree block size and page size differ, we use
 		 * a bitmap to keep track of which hash blocks have been
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index f58432772d9e..7e153356e7bc 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -16,9 +16,10 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 				     const struct fsverity_info *vi,
 				     void __user *buf, u64 offset, int length)
 {
-	const struct fsverity_operations *vops = inode->i_sb->s_vop;
 	u64 end_offset;
-	unsigned int offs_in_page;
+	unsigned int offs_in_block;
+	const unsigned int block_size = vi->tree_params.block_size;
+	const u8 log_blocksize = vi->tree_params.log_blocksize;
 	pgoff_t index, last_index;
 	int retval = 0;
 	int err = 0;
@@ -26,42 +27,39 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 	end_offset = min(offset + length, vi->tree_params.tree_size);
 	if (offset >= end_offset)
 		return 0;
-	offs_in_page = offset_in_page(offset);
-	last_index = (end_offset - 1) >> PAGE_SHIFT;
+	offs_in_block = offset & (block_size - 1);
+	last_index = (end_offset - 1) >> log_blocksize;
 
 	/*
-	 * Iterate through each Merkle tree page in the requested range and copy
-	 * the requested portion to userspace.  Note that the Merkle tree block
-	 * size isn't important here, as we are returning a byte stream; i.e.,
-	 * we can just work with pages even if the tree block size != PAGE_SIZE.
+	 * Iterate through each Merkle tree block in the requested range and
+	 * copy the requested portion to userspace. Note that we are returning
+	 * a byte stream, so PAGE_SIZE & block_size are not important here.
 	 */
-	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
+	for (index = offset >> log_blocksize; index <= last_index; index++) {
 		unsigned long num_ra_pages =
 			min_t(unsigned long, last_index - index + 1,
 			      inode->i_sb->s_bdi->io_pages);
 		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
-						   PAGE_SIZE - offs_in_page);
-		struct page *page;
-		const void *virt;
+						   block_size - offs_in_block);
+		struct fsverity_blockbuf block;
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
-			fsverity_err(inode,
-				     "Error %d reading Merkle tree page %lu",
-				     err, index);
+		block.size = block_size;
+		if (fsverity_read_merkle_tree_block(inode,
+					index << log_blocksize,
+					&block, log_blocksize,
+					num_ra_pages)) {
+			fsverity_drop_block(inode, &block);
+			err = -EIO;
 			break;
 		}
 
-		virt = kmap_local_page(page);
-		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
-			kunmap_local(virt);
-			put_page(page);
+		if (copy_to_user(buf, block.kaddr + offs_in_block, bytes_to_copy)) {
+			fsverity_drop_block(inode, &block);
 			err = -EFAULT;
 			break;
 		}
-		kunmap_local(virt);
-		put_page(page);
+		fsverity_drop_block(inode, &block);
+		block.kaddr = NULL;
 
 		retval += bytes_to_copy;
 		buf += bytes_to_copy;
@@ -72,7 +70,7 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 			break;
 		}
 		cond_resched();
-		offs_in_page = 0;
+		offs_in_block = 0;
 	}
 	return retval ? retval : err;
 }
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4fcad0825a12..414ec3321fe6 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -13,69 +13,18 @@
 static struct workqueue_struct *fsverity_read_workqueue;
 
 /*
- * Returns true if the hash block with index @hblock_idx in the tree, located in
- * @hpage, has already been verified.
+ * Returns true if the hash block with index @hblock_idx in the tree has
+ * already been verified.
  */
-static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
+static bool is_hash_block_verified(struct fsverity_info *vi,
+				   struct fsverity_blockbuf *block,
 				   unsigned long hblock_idx)
 {
-	unsigned int blocks_per_page;
-	unsigned int i;
-
-	/*
-	 * When the Merkle tree block size and page size are the same, then the
-	 * ->hash_block_verified bitmap isn't allocated, and we use PG_checked
-	 * to directly indicate whether the page's block has been verified.
-	 *
-	 * Using PG_checked also guarantees that we re-verify hash pages that
-	 * get evicted and re-instantiated from the backing storage, as new
-	 * pages always start out with PG_checked cleared.
-	 */
+	/* Merkle tree block size == PAGE_SIZE */
 	if (!vi->hash_block_verified)
-		return PageChecked(hpage);
+		return block->verified;
 
-	/*
-	 * When the Merkle tree block size and page size differ, we use a bitmap
-	 * to indicate whether each hash block has been verified.
-	 *
-	 * However, we still need to ensure that hash pages that get evicted and
-	 * re-instantiated from the backing storage are re-verified.  To do
-	 * this, we use PG_checked again, but now it doesn't really mean
-	 * "checked".  Instead, now it just serves as an indicator for whether
-	 * the hash page is newly instantiated or not.  If the page is new, as
-	 * indicated by PG_checked=0, we clear the bitmap bits for the page's
-	 * blocks since they are untrustworthy, then set PG_checked=1.
-	 * Otherwise we return the bitmap bit for the requested block.
-	 *
-	 * Multiple threads may execute this code concurrently on the same page.
-	 * This is safe because we use memory barriers to ensure that if a
-	 * thread sees PG_checked=1, then it also sees the associated bitmap
-	 * clearing to have occurred.  Also, all writes and their corresponding
-	 * reads are atomic, and all writes are safe to repeat in the event that
-	 * multiple threads get into the PG_checked=0 section.  (Clearing a
-	 * bitmap bit again at worst causes a hash block to be verified
-	 * redundantly.  That event should be very rare, so it's not worth using
-	 * a lock to avoid.  Setting PG_checked again has no effect.)
-	 */
-	if (PageChecked(hpage)) {
-		/*
-		 * A read memory barrier is needed here to give ACQUIRE
-		 * semantics to the above PageChecked() test.
-		 */
-		smp_rmb();
-		return test_bit(hblock_idx, vi->hash_block_verified);
-	}
-	blocks_per_page = vi->tree_params.blocks_per_page;
-	hblock_idx = round_down(hblock_idx, blocks_per_page);
-	for (i = 0; i < blocks_per_page; i++)
-		clear_bit(hblock_idx + i, vi->hash_block_verified);
-	/*
-	 * A write memory barrier is needed here to give RELEASE semantics to
-	 * the below SetPageChecked() operation.
-	 */
-	smp_wmb();
-	SetPageChecked(hpage);
-	return false;
+	return test_bit(hblock_idx, vi->hash_block_verified);
 }
 
 /*
@@ -95,15 +44,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 	const struct merkle_tree_params *params = &vi->tree_params;
 	const unsigned int hsize = params->digest_size;
 	int level;
+	int err;
+	int num_ra_pages;
 	u8 _want_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	const u8 *want_hash;
 	u8 real_hash[FS_VERITY_MAX_DIGEST_SIZE];
 	/* The hash blocks that are traversed, indexed by level */
 	struct {
-		/* Page containing the hash block */
-		struct page *page;
-		/* Mapped address of the hash block (will be within @page) */
-		const void *addr;
+		/* Buffer containing the hash block */
+		struct fsverity_blockbuf block;
 		/* Index of the hash block in the tree overall */
 		unsigned long index;
 		/* Byte offset of the wanted hash relative to @addr */
@@ -144,10 +93,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		unsigned long next_hidx;
 		unsigned long hblock_idx;
 		pgoff_t hpage_idx;
-		unsigned int hblock_offset_in_page;
 		unsigned int hoffset;
-		struct page *hpage;
-		const void *haddr;
+		struct fsverity_blockbuf *block = &hblocks[level].block;
 
 		/*
 		 * The index of the block in the current level; also the index
@@ -161,33 +108,27 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		/* Index of the hash page in the tree overall */
 		hpage_idx = hblock_idx >> params->log_blocks_per_page;
 
-		/* Byte offset of the hash block within the page */
-		hblock_offset_in_page =
-			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
-
 		/* Byte offset of the hash within the block */
 		hoffset = (hidx << params->log_digestsize) &
 			  (params->block_size - 1);
 
-		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
-				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
-		if (IS_ERR(hpage)) {
+		num_ra_pages = level == 0 ?
+			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
+		err = fsverity_read_merkle_tree_block(
+			inode, hblock_idx << params->log_blocksize, block,
+			params->log_blocksize, num_ra_pages);
+		if (err) {
 			fsverity_err(inode,
-				     "Error %ld reading Merkle tree page %lu",
-				     PTR_ERR(hpage), hpage_idx);
+				     "Error %d reading Merkle tree block %lu",
+				     err, hblock_idx);
 			goto error;
 		}
-		haddr = kmap_local_page(hpage) + hblock_offset_in_page;
-		if (is_hash_block_verified(vi, hpage, hblock_idx)) {
-			memcpy(_want_hash, haddr + hoffset, hsize);
+		if (is_hash_block_verified(vi, block, hblock_idx)) {
+			memcpy(_want_hash, block->kaddr + hoffset, hsize);
 			want_hash = _want_hash;
-			kunmap_local(haddr);
-			put_page(hpage);
+			fsverity_drop_block(inode, block);
 			goto descend;
 		}
-		hblocks[level].page = hpage;
-		hblocks[level].addr = haddr;
 		hblocks[level].index = hblock_idx;
 		hblocks[level].hoffset = hoffset;
 		hidx = next_hidx;
@@ -197,8 +138,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 descend:
 	/* Descend the tree verifying hash blocks. */
 	for (; level > 0; level--) {
-		struct page *hpage = hblocks[level - 1].page;
-		const void *haddr = hblocks[level - 1].addr;
+		struct fsverity_blockbuf *block = &hblocks[level - 1].block;
+		const void *haddr = block->kaddr;
 		unsigned long hblock_idx = hblocks[level - 1].index;
 		unsigned int hoffset = hblocks[level - 1].hoffset;
 
@@ -213,12 +154,10 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		 */
 		if (vi->hash_block_verified)
 			set_bit(hblock_idx, vi->hash_block_verified);
-		else
-			SetPageChecked(hpage);
+		block->verified = true;
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
-		kunmap_local(haddr);
-		put_page(hpage);
+		fsverity_drop_block(inode, block);
 	}
 
 	/* Finally, verify the data block. */
@@ -236,8 +175,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		     params->hash_alg->name, hsize, real_hash);
 error:
 	for (; level > 0; level--) {
-		kunmap_local(hblocks[level - 1].addr);
-		put_page(hblocks[level - 1].page);
+		fsverity_drop_block(inode, &hblocks[level - 1].block);
 	}
 	return false;
 }
@@ -362,3 +300,165 @@ void __init fsverity_init_workqueue(void)
 	if (!fsverity_read_workqueue)
 		panic("failed to allocate fsverity_read_queue");
 }
+
+/**
+ * fsverity_invalidate_range() - invalidate range of Merkle tree blocks
+ * @inode: inode to which this Merkle tree blocks belong
+ * @offset: offset into the Merkle tree
+ * @size: number of bytes to invalidate starting from @offset
+ *
+ * This function invalidates/clears "verified" state of all Merkle tree blocks
+ * in the Merkle tree within the range starting from 'offset' to 'offset + size'.
+ *
+ * Note! As this function clears fs-verity bitmap and can be run from multiple
+ * threads simultaneously, filesystem has to take care of operation ordering
+ * while invalidating Merkle tree and caching it. See fsverity_invalidate_page()
+ * as reference.
+ */
+void fsverity_invalidate_range(struct inode *inode, loff_t offset,
+		size_t size)
+{
+	struct fsverity_info *vi = inode->i_verity_info;
+	const unsigned int log_blocksize = vi->tree_params.log_blocksize;
+	unsigned int i;
+	pgoff_t index = offset >> log_blocksize;
+	unsigned int blocks = size >> log_blocksize;
+
+	if (offset + size > vi->tree_params.tree_size) {
+		fsverity_err(inode,
+"Trying to invalidate beyond Merkle tree (tree %lld, offset %lld, size %ld)",
+			     vi->tree_params.tree_size, offset, size);
+		return;
+	}
+
+	for (i = 0; i < blocks; i++)
+		clear_bit(index + i, vi->hash_block_verified);
+}
+EXPORT_SYMBOL_GPL(fsverity_invalidate_range);
+
+/* fsverity_invalidate_page() - invalidate Merkle tree blocks in the page
+ * @inode: inode to which this Merkle tree blocks belong
+ * @page: page which contains blocks which need to be invalidated
+ * @index: index of the first Merkle tree block in the page
+ *
+ * This function invalidates "verified" state of all Merkle tree blocks within
+ * the 'page'.
+ *
+ * When the Merkle tree block size and page size are the same, then the
+ * ->hash_block_verified bitmap isn't allocated, and we use PG_checked
+ * to directly indicate whether the page's block has been verified. This
+ * function does nothing in this case as page is invalidated by evicting from
+ * the memory.
+ *
+ * Using PG_checked also guarantees that we re-verify hash pages that
+ * get evicted and re-instantiated from the backing storage, as new
+ * pages always start out with PG_checked cleared.
+ */
+void fsverity_invalidate_page(struct inode *inode, struct page *page,
+		pgoff_t index)
+{
+	unsigned int blocks_per_page;
+	struct fsverity_info *vi = inode->i_verity_info;
+	const unsigned int log_blocksize = vi->tree_params.log_blocksize;
+
+	/*
+	 * If bitmap is not allocated, that means that fs-verity uses PG_checked
+	 * to track verification status of the blocks.
+	 */
+	if (!vi->hash_block_verified)
+		return;
+
+	/*
+	 * When the Merkle tree block size and page size differ, we use a bitmap
+	 * to indicate whether each hash block has been verified.
+	 *
+	 * However, we still need to ensure that hash pages that get evicted and
+	 * re-instantiated from the backing storage are re-verified.  To do
+	 * this, we use PG_checked again, but now it doesn't really mean
+	 * "checked".  Instead, now it just serves as an indicator for whether
+	 * the hash page is newly instantiated or not.  If the page is new, as
+	 * indicated by PG_checked=0, we clear the bitmap bits for the page's
+	 * blocks since they are untrustworthy, then set PG_checked=1.
+	 *
+	 * Multiple threads may execute this code concurrently on the same page.
+	 * This is safe because we use memory barriers to ensure that if a
+	 * thread sees PG_checked=1, then it also sees the associated bitmap
+	 * clearing to have occurred.  Also, all writes and their corresponding
+	 * reads are atomic, and all writes are safe to repeat in the event that
+	 * multiple threads get into the PG_checked=0 section.  (Clearing a
+	 * bitmap bit again at worst causes a hash block to be verified
+	 * redundantly.  That event should be very rare, so it's not worth using
+	 * a lock to avoid.  Setting PG_checked again has no effect.)
+	 */
+	if (PageChecked(page)) {
+		/*
+		 * A read memory barrier is needed here to give ACQUIRE
+		 * semantics to the above PageChecked() test.
+		 */
+		smp_rmb();
+		return;
+	}
+
+	blocks_per_page = vi->tree_params.blocks_per_page;
+	index = round_down(index, blocks_per_page);
+	fsverity_invalidate_range(inode, index << log_blocksize, PAGE_SIZE);
+	/*
+	 * A write memory barrier is needed here to give RELEASE
+	 * semantics to the below SetPageChecked() operation.
+	 */
+	smp_wmb();
+	SetPageChecked(page);
+}
+
+void fsverity_drop_block(struct inode *inode,
+		struct fsverity_blockbuf *block)
+{
+	if (inode->i_sb->s_vop->drop_block)
+		inode->i_sb->s_vop->drop_block(block);
+	else {
+		struct page *page = (struct page *)block->context;
+
+		/* Merkle tree block size == PAGE_SIZE; */
+		if (block->verified)
+			SetPageChecked(page);
+
+		kunmap_local(block->kaddr);
+		put_page(page);
+	}
+}
+
+int fsverity_read_merkle_tree_block(struct inode *inode,
+					u64 pos,
+					struct fsverity_blockbuf *block,
+					unsigned int log_blocksize,
+					unsigned long num_ra_pages)
+{
+	struct page *page;
+	int err = 0;
+	unsigned long index = pos >> PAGE_SHIFT;
+
+	if (inode->i_sb->s_vop->read_merkle_tree_block)
+		return inode->i_sb->s_vop->read_merkle_tree_block(
+			inode, pos, block, log_blocksize, num_ra_pages);
+
+	page = inode->i_sb->s_vop->read_merkle_tree_page(
+			inode, index, num_ra_pages);
+	if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+		fsverity_err(inode,
+			     "Error %d reading Merkle tree page %lu",
+			     err, index);
+		return PTR_ERR(page);
+	}
+
+	fsverity_invalidate_page(inode, page, index);
+	/*
+	 * For the block size == PAGE_SIZE case set ->verified. The PG_checked
+	 * indicates whether block in the page is verified.
+	 */
+	block->verified = PageChecked(page);
+	block->kaddr = kmap_local_page(page) + (pos & (PAGE_SIZE - 1));
+	block->context = page;
+
+	return 0;
+}
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index ab7b0772899b..fb2d4fccec0c 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -26,6 +26,36 @@
 /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
 #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
 
+/**
+ * struct fsverity_blockbuf - Merkle Tree block
+ * @kaddr: virtual address of the block's data
+ * @size: buffer size
+ * @verified: true if block is verified against Merkle tree
+ * @context: filesystem private context
+ *
+ * Buffer containing single Merkle Tree block. These buffers are passed
+ *  - to filesystem, when fs-verity is building/writing merkel tree,
+ *  - from filesystem, when fs-verity is reading merkle tree from a disk.
+ * Filesystems sets kaddr together with size to point to a memory which contains
+ * Merkle tree block. Same is done by fs-verity when Merkle tree is need to be
+ * written down to disk.
+ *
+ * While reading the tree, fs-verity calls ->read_merkle_tree_block followed by
+ * ->drop_block to let filesystem know that memory can be freed.
+ *
+ * For Merkle tree block == PAGE_SIZE, fs-verity sets verified flag to true if
+ * block in the buffer was verified.
+ *
+ * The context is optional. This field can be used by filesystem to passthrough
+ * state from ->read_merkle_tree_block to ->drop_block.
+ */
+struct fsverity_blockbuf {
+	void *kaddr;
+	unsigned int size;
+	bool verified;
+	void *context;
+};
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 
@@ -107,6 +137,32 @@ struct fsverity_operations {
 					      pgoff_t index,
 					      unsigned long num_ra_pages);
 
+	/**
+	 * Read a Merkle tree block of the given inode.
+	 * @inode: the inode
+	 * @pos: byte offset of the block within the Merkle tree
+	 * @block: block buffer for filesystem to point it to the block
+	 * @log_blocksize: size of the expected block
+	 * @num_ra_pages: The number of pages with blocks that should be
+	 *		  prefetched starting at @index if the page at @index
+	 *		  isn't already cached.  Implementations may ignore this
+	 *		  argument; it's only a performance optimization.
+	 *
+	 * This can be called at any time on an open verity file.  It may be
+	 * called by multiple processes concurrently.
+	 *
+	 * As filesystem does caching of the blocks, this functions needs to tell
+	 * fsverity which blocks are not valid anymore (were evicted from memory)
+	 * by calling fsverity_invalidate_range().
+	 *
+	 * Return: 0 on success, -errno on failure
+	 */
+	int (*read_merkle_tree_block)(struct inode *inode,
+				      u64 pos,
+				      struct fsverity_blockbuf *block,
+				      unsigned int log_blocksize,
+				      unsigned long num_ra_pages);
+
 	/**
 	 * Write a Merkle tree block to the given inode.
 	 *
@@ -122,6 +178,16 @@ struct fsverity_operations {
 	 */
 	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
 				       u64 pos, unsigned int size);
+
+	/**
+	 * Release the reference to a Merkle tree block
+	 *
+	 * @page: the block to release
+	 *
+	 * This is called when fs-verity is done with a block obtained with
+	 * ->read_merkle_tree_block().
+	 */
+	void (*drop_block)(struct fsverity_blockbuf *block);
 };
 
 #ifdef CONFIG_FS_VERITY
@@ -175,6 +241,9 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
+void fsverity_invalidate_range(struct inode *inode, loff_t offset, size_t size);
+void fsverity_invalidate_page(struct inode *inode, struct page *page,
+		pgoff_t index);
 
 #else /* !CONFIG_FS_VERITY */
 
-- 
2.42.0


