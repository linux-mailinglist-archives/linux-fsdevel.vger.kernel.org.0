Return-Path: <linux-fsdevel+bounces-13527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B33870A43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1E528166F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B657B3F9;
	Mon,  4 Mar 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBSbc20m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0356278B7F
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579544; cv=none; b=hQqlBsr+pcD8ctu0+BBrJzcbNdmhtr/Z0hXAoP7p6EgTyQEdUaozCKcJ65b/a74g/pNGREu4zH0kXW857N3QPShAd7ZwOztBfO2TCb4oAZfPLuvjVeV54mJjP9eZsg4etuPT9lxCY0Lws/WdKCr7uDDDid5Rw0AxH38EVXT+vUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579544; c=relaxed/simple;
	bh=o7uJ1D+AEiS9SD66mTegf6KN6epDMi54+pW9bq/3KVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S74NIj9dUBKJHOwmKwmp0Z7bhldiE9oe7VY4od+0y640menQWTMENVBx/lVnQXXkeb4XDyGUnUMF35YO5P0ZkVDMhZJObCXh/4+xKnBSumDAWakp9ftyLEXoog0FbCWwViyEGtC+Zo3XLpG74FqOb2Nz0RnvmiMvnXo0XbyOxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EBSbc20m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RWpQCn1MqyoizoX+vDeh9HZxEtqyPzNYVKfjAJQ9aww=;
	b=EBSbc20mxDh+xB5JNdPEgNg4af/ws5EFIfCZJ9Pg1Td0FRkYoYJSc3N3UDpfOPxp7nOJnU
	xLavQm6qhUWibAfXDGaX7NHpmUYUCIkKxZYRV9PXWVuSRCGOeqU2SSeb+iIYWXL2pMah06
	WcHabzbiVL0ZA5Apx3pLee9jU7LaK5I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-w4TkIGVMM3a9FCTFbzqC1w-1; Mon, 04 Mar 2024 14:12:19 -0500
X-MC-Unique: w4TkIGVMM3a9FCTFbzqC1w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4488afb812so203658566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579538; x=1710184338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWpQCn1MqyoizoX+vDeh9HZxEtqyPzNYVKfjAJQ9aww=;
        b=GTqnXp3Ka48MJU0gllWWX9rB/UD5FtThHdlYbPf2TG7qG3VHwiXehixDrHqBw7lMTX
         1ymB3xSlcqJOwZd7K8O2hHOdMYnugq2e3qkNjWwbpEiibtZsPcP2yp5yu1sCoEGxmlZk
         6z+lrkpCxZ/UDWh0wws08OynKYk1muD7HLHuXD3PXrKFuL8r4XicZWAHBoGidqfIR9U0
         R2fo8NBae95N6PXWYOhzuDiYWFN+kJUjdlc2ZR/hxZfU9KP2sN61XS/8Nx1WlYjPvDXV
         flvp6lN3HpsMJovK9q3ulD97cYz8UK1eZyt3bG6I3BCHs2vQmv71ldTAqgBfKeTLRNmv
         8lpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUOZUlTlThFeFYAsghnb1QsscOugXz+heKbq/0/Nhu+HmP1QQ29zpfaoMwrqdzBFdrj9iIkBlUa2bBzxPl9uU3RFnQOAkIkRV9YPLBOA==
X-Gm-Message-State: AOJu0YyaWcnOCHuKrd7fx0sOC2bZqdqOmJGMfS3KqRKd0B4rdeUL9ARe
	fp0/wvZ1JS699LDbTH68jX4LW9ogNz/Zg+VOEFjfGKLY6gZ+iZdivfuIJlrwqw7asi2uQx5PYH3
	EmCkDi9lKSIEZRdf5PhyxJ+5YgGofXXY7qSQS42yy1Fci7KX+OpOJwmIIKtbmLg==
X-Received: by 2002:a17:906:34c6:b0:a45:7d2d:e30d with SMTP id h6-20020a17090634c600b00a457d2de30dmr1478216ejb.59.1709579538042;
        Mon, 04 Mar 2024 11:12:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+LKhizsky/7SBgic7k1nlQC+irhLE9MRjvAA/rgDkvG8WAek47SPe1EqbZrQt+AtMULBp8A==
X-Received: by 2002:a17:906:34c6:b0:a45:7d2d:e30d with SMTP id h6-20020a17090634c600b00a457d2de30dmr1478193ejb.59.1709579537332;
        Mon, 04 Mar 2024 11:12:17 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:16 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 07/24] fsverity: support block-based Merkle tree caching
Date: Mon,  4 Mar 2024 20:10:30 +0100
Message-ID: <20240304191046.157464-9-aalbersh@redhat.com>
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

In the current implementation fs-verity expects filesystem to
provide PAGEs filled with Merkle tree blocks. Then, when fs-verity
is done with processing the blocks, reference to PAGE is freed. This
doesn't fit well with the way XFS manages its memory.

To allow XFS integrate fs-verity this patch adds ability to
fs-verity verification code to take Merkle tree blocks instead of
PAGE reference. This way ext4, f2fs, and btrfs are still able to
pass PAGE references and XFS can pass reference to Merkle tree
blocks stored in XFS's buffer infrastructure.

Another addition is invalidation function which tells fs-verity to
mark part of Merkle tree as not verified. This function is used
by filesystem to tell fs-verity to invalidate block which was
evicted from memory.

Depending on Merkle tree block size fs-verity is using either bitmap
or PG_checked flag to track "verified" status of the blocks. With a
Merkle tree block caching (XFS) there is no PAGE to flag it as
verified. fs-verity always uses bitmap to track verified blocks for
filesystems which use block caching.

Further this patch allows filesystem to make additional processing
on verified pages via fsverity_drop_block() instead of just dropping
a reference. This will be used by XFS for internal buffer cache
manipulation in further patches. The btrfs, ext4, and f2fs just drop
the reference.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/verity/fsverity_private.h |   8 +++
 fs/verity/open.c             |   8 ++-
 fs/verity/read_metadata.c    |  64 +++++++++++-------
 fs/verity/verify.c           | 125 +++++++++++++++++++++++++++--------
 include/linux/fsverity.h     |  65 ++++++++++++++++++
 5 files changed, 217 insertions(+), 53 deletions(-)

diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index b3506f56e180..dad33e6ff0d6 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -154,4 +154,12 @@ static inline void fsverity_init_signature(void)
 
 void __init fsverity_init_workqueue(void);
 
+/*
+ * Drop 'block' obtained with ->read_merkle_tree_block(). Calls out back to
+ * filesystem if ->drop_block() is set, otherwise, drop the reference in the
+ * block->context.
+ */
+void fsverity_drop_block(struct inode *inode,
+			 struct fsverity_blockbuf *block);
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
index f58432772d9e..5da40b5a81af 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -18,50 +18,68 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 {
 	const struct fsverity_operations *vops = inode->i_sb->s_vop;
 	u64 end_offset;
-	unsigned int offs_in_page;
+	unsigned int offs_in_block;
 	pgoff_t index, last_index;
 	int retval = 0;
 	int err = 0;
+	const unsigned int block_size = vi->tree_params.block_size;
+	const u8 log_blocksize = vi->tree_params.log_blocksize;
 
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
+	 * a byte stream.
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
+		struct fsverity_blockbuf block = {
+			.size = block_size,
+		};
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
+		if (!vops->read_merkle_tree_block) {
+			unsigned int blocks_per_page =
+				vi->tree_params.blocks_per_page;
+			unsigned long page_idx =
+				round_down(index, blocks_per_page);
+			struct page *page = vops->read_merkle_tree_page(inode,
+					page_idx, num_ra_pages);
+
+			if (IS_ERR(page)) {
+				err = PTR_ERR(page);
+			} else {
+				block.kaddr = kmap_local_page(page) +
+					((index - page_idx) << log_blocksize);
+				block.context = page;
+			}
+		} else {
+			err = vops->read_merkle_tree_block(inode,
+					index << log_blocksize,
+					&block, log_blocksize, num_ra_pages);
+		}
+
+		if (err) {
 			fsverity_err(inode,
-				     "Error %d reading Merkle tree page %lu",
-				     err, index);
+				     "Error %d reading Merkle tree block %lu",
+				     err, index << log_blocksize);
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
 
 		retval += bytes_to_copy;
 		buf += bytes_to_copy;
@@ -72,7 +90,7 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 			break;
 		}
 		cond_resched();
-		offs_in_page = 0;
+		offs_in_block = 0;
 	}
 	return retval ? retval : err;
 }
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 4fcad0825a12..de71911d400c 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -13,14 +13,17 @@
 static struct workqueue_struct *fsverity_read_workqueue;
 
 /*
- * Returns true if the hash block with index @hblock_idx in the tree, located in
- * @hpage, has already been verified.
+ * Returns true if the hash block with index @hblock_idx in the tree has
+ * already been verified.
  */
-static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
+static bool is_hash_block_verified(struct inode *inode,
+				   struct fsverity_blockbuf *block,
 				   unsigned long hblock_idx)
 {
 	unsigned int blocks_per_page;
 	unsigned int i;
+	struct fsverity_info *vi = inode->i_verity_info;
+	struct page *hpage = (struct page *)block->context;
 
 	/*
 	 * When the Merkle tree block size and page size are the same, then the
@@ -34,6 +37,12 @@ static bool is_hash_block_verified(struct fsverity_info *vi, struct page *hpage,
 	if (!vi->hash_block_verified)
 		return PageChecked(hpage);
 
+	/*
+	 * Filesystems which use block based caching (e.g. XFS) always use
+	 * bitmap.
+	 */
+	if (inode->i_sb->s_vop->read_merkle_tree_block)
+		return test_bit(hblock_idx, vi->hash_block_verified);
 	/*
 	 * When the Merkle tree block size and page size differ, we use a bitmap
 	 * to indicate whether each hash block has been verified.
@@ -95,15 +104,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
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
@@ -144,10 +153,11 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		unsigned long next_hidx;
 		unsigned long hblock_idx;
 		pgoff_t hpage_idx;
+		u64 hblock_pos;
 		unsigned int hblock_offset_in_page;
 		unsigned int hoffset;
 		struct page *hpage;
-		const void *haddr;
+		struct fsverity_blockbuf *block = &hblocks[level].block;
 
 		/*
 		 * The index of the block in the current level; also the index
@@ -165,29 +175,49 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		hblock_offset_in_page =
 			(hblock_idx << params->log_blocksize) & ~PAGE_MASK;
 
+		/* Offset of the Merkle tree block into the tree */
+		hblock_pos = hblock_idx << params->log_blocksize;
+
 		/* Byte offset of the hash within the block */
 		hoffset = (hidx << params->log_digestsize) &
 			  (params->block_size - 1);
 
-		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
-				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
-		if (IS_ERR(hpage)) {
+		num_ra_pages = level == 0 ?
+			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
+
+		if (inode->i_sb->s_vop->read_merkle_tree_block) {
+			err = inode->i_sb->s_vop->read_merkle_tree_block(
+				inode, hblock_pos, block, params->log_blocksize,
+				num_ra_pages);
+		} else {
+			unsigned int blocks_per_page =
+				vi->tree_params.blocks_per_page;
+			hblock_idx = round_down(hblock_idx, blocks_per_page);
+			hpage = inode->i_sb->s_vop->read_merkle_tree_page(
+				inode, hpage_idx, (num_ra_pages << PAGE_SHIFT));
+
+			if (IS_ERR(hpage)) {
+				err = PTR_ERR(hpage);
+			} else {
+				block->kaddr = kmap_local_page(hpage) +
+					hblock_offset_in_page;
+				block->context = hpage;
+			}
+		}
+
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
+
+		if (is_hash_block_verified(inode, block, hblock_idx)) {
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
@@ -197,10 +227,11 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 descend:
 	/* Descend the tree verifying hash blocks. */
 	for (; level > 0; level--) {
-		struct page *hpage = hblocks[level - 1].page;
-		const void *haddr = hblocks[level - 1].addr;
+		struct fsverity_blockbuf *block = &hblocks[level - 1].block;
+		const void *haddr = block->kaddr;
 		unsigned long hblock_idx = hblocks[level - 1].index;
 		unsigned int hoffset = hblocks[level - 1].hoffset;
+		struct page *hpage = (struct page *)block->context;
 
 		if (fsverity_hash_block(params, inode, haddr, real_hash) != 0)
 			goto error;
@@ -217,8 +248,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 			SetPageChecked(hpage);
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
-		kunmap_local(haddr);
-		put_page(hpage);
+		fsverity_drop_block(inode, block);
 	}
 
 	/* Finally, verify the data block. */
@@ -235,10 +265,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		     params->hash_alg->name, hsize, want_hash,
 		     params->hash_alg->name, hsize, real_hash);
 error:
-	for (; level > 0; level--) {
-		kunmap_local(hblocks[level - 1].addr);
-		put_page(hblocks[level - 1].page);
-	}
+	for (; level > 0; level--)
+		fsverity_drop_block(inode, &hblocks[level - 1].block);
 	return false;
 }
 
@@ -362,3 +390,42 @@ void __init fsverity_init_workqueue(void)
 	if (!fsverity_read_workqueue)
 		panic("failed to allocate fsverity_read_queue");
 }
+
+/**
+ * fsverity_invalidate_block() - invalidate Merkle tree block
+ * @inode: inode to which this Merkle tree blocks belong
+ * @block: block to be invalidated
+ *
+ * This function invalidates/clears "verified" state of Merkle tree block
+ * in the fs-verity bitmap. The block needs to have ->offset set.
+ */
+void fsverity_invalidate_block(struct inode *inode,
+		struct fsverity_blockbuf *block)
+{
+	struct fsverity_info *vi = inode->i_verity_info;
+	const unsigned int log_blocksize = vi->tree_params.log_blocksize;
+
+	if (block->offset > vi->tree_params.tree_size) {
+		fsverity_err(inode,
+"Trying to invalidate beyond Merkle tree (tree %lld, offset %lld)",
+			     vi->tree_params.tree_size, block->offset);
+		return;
+	}
+
+	clear_bit(block->offset >> log_blocksize, vi->hash_block_verified);
+}
+EXPORT_SYMBOL_GPL(fsverity_invalidate_block);
+
+void fsverity_drop_block(struct inode *inode,
+		struct fsverity_blockbuf *block)
+{
+	if (inode->i_sb->s_vop->drop_block)
+		inode->i_sb->s_vop->drop_block(block);
+	else {
+		struct page *page = (struct page *)block->context;
+
+		kunmap_local(block->kaddr);
+		put_page(page);
+	}
+	block->kaddr = NULL;
+}
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index ac58b19f23d3..0973b521ac5a 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -26,6 +26,33 @@
 /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
 #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
 
+/**
+ * struct fsverity_blockbuf - Merkle Tree block buffer
+ * @kaddr: virtual address of the block's data
+ * @offset: block's offset into Merkle tree
+ * @size: the Merkle tree block size
+ * @context: filesystem private context
+ *
+ * Buffer containing single Merkle Tree block. These buffers are passed
+ *  - to filesystem, when fs-verity is building merkel tree,
+ *  - from filesystem, when fs-verity is reading merkle tree from a disk.
+ * Filesystems sets kaddr together with size to point to a memory which contains
+ * Merkle tree block. Same is done by fs-verity when Merkle tree is need to be
+ * written down to disk.
+ *
+ * While reading the tree, fs-verity calls ->read_merkle_tree_block followed by
+ * ->drop_block to let filesystem know that memory can be freed.
+ *
+ * The context is optional. This field can be used by filesystem to passthrough
+ * state from ->read_merkle_tree_block to ->drop_block.
+ */
+struct fsverity_blockbuf {
+	void *kaddr;
+	u64 offset;
+	unsigned int size;
+	void *context;
+};
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 
@@ -107,6 +134,32 @@ struct fsverity_operations {
 					      pgoff_t index,
 					      unsigned long num_ra_pages);
 
+	/**
+	 * Read a Merkle tree block of the given inode.
+	 * @inode: the inode
+	 * @pos: byte offset of the block within the Merkle tree
+	 * @block: block buffer for filesystem to point it to the block
+	 * @log_blocksize: log2 of the size of the expected block
+	 * @ra_bytes: The number of bytes that should be
+	 *		prefetched starting at @pos if the page at @pos
+	 *		isn't already cached.  Implementations may ignore this
+	 *		argument; it's only a performance optimization.
+	 *
+	 * This can be called at any time on an open verity file.  It may be
+	 * called by multiple processes concurrently.
+	 *
+	 * In case that block was evicted from the memory filesystem has to use
+	 * fsverity_invalidate_block() to let fsverity know that block's
+	 * verification state is not valid anymore.
+	 *
+	 * Return: 0 on success, -errno on failure
+	 */
+	int (*read_merkle_tree_block)(struct inode *inode,
+				      u64 pos,
+				      struct fsverity_blockbuf *block,
+				      unsigned int log_blocksize,
+				      u64 ra_bytes);
+
 	/**
 	 * Write a Merkle tree block to the given inode.
 	 *
@@ -122,6 +175,16 @@ struct fsverity_operations {
 	 */
 	int (*write_merkle_tree_block)(struct inode *inode, const void *buf,
 				       u64 pos, unsigned int size);
+
+	/**
+	 * Release the reference to a Merkle tree block
+	 *
+	 * @block: the block to release
+	 *
+	 * This is called when fs-verity is done with a block obtained with
+	 * ->read_merkle_tree_block().
+	 */
+	void (*drop_block)(struct fsverity_blockbuf *block);
 };
 
 #ifdef CONFIG_FS_VERITY
@@ -175,6 +238,8 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg);
 bool fsverity_verify_blocks(struct folio *folio, size_t len, size_t offset);
 void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
+void fsverity_invalidate_block(struct inode *inode,
+		struct fsverity_blockbuf *block);
 
 #else /* !CONFIG_FS_VERITY */
 
-- 
2.42.0


