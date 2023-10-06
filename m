Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A407BBF22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjJFSyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjJFSyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C63F0
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3gomcdSnORKGqO6JgH9QQWRoXUfHA8TCEcldyiCDCg=;
        b=WqUgK7TkCaQzYrzDmluX7ATicDSuEynULxcDYNvpnyYPV0QxcmlE3Jyo2xeWY+KIiGyDN2
        7aD/WKTOOhoGkMEYfatYuvbpf0Ezgg0P8uEuKc8o8YMSzFTkB3QsyG9V3Elm6MU0kFs1tM
        Q4gJ7fSXVNqE6I/MzcoXEL7670YJirg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-tRFm138HM9ipk8scB3GpgA-1; Fri, 06 Oct 2023 14:52:29 -0400
X-MC-Unique: tRFm138HM9ipk8scB3GpgA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b98bbf130cso207022766b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618348; x=1697223148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3gomcdSnORKGqO6JgH9QQWRoXUfHA8TCEcldyiCDCg=;
        b=RX6zc/ph8Td7P6X79hlzZSCjzTV+FKhmv+x16i9fsv03Y/WRgffYurXxzRnPdLmLj6
         M3kdCx+Q3lefbO30FtNbSikjW9HPQ3nTIMIEY+zp/C6qD7qHEJ5EEIeCGENx/yBb7e4p
         PtQxAKYQacRLAy3nNdlwkaI4pw0J8v3hZ8Z14W4TGo5gG8HhnI62nKB5n9vuuyuyJVyG
         aKQpG7sXJ63orsWJenKen9cMfegdL9JjxbSKsihHcBJgPKr5SWI+mCtaEz7jgeKDGtHl
         rDakNCO5cEnm25Rsgnpv7UHCtXsmDew6/3gGTtgUItIEjwtPlHC/ZM3nHNQPEIrkQX2V
         QLAg==
X-Gm-Message-State: AOJu0YxbTQR1tiKEsJoGVhatTEbZZ5W+N3j8/nYJiRk2Vesf8EzWaQ9B
        HCJf0ldCr6wQfUzXGdongwYfuTxCENMsb/yB0XYDwezEUwBoxgL+j72Utp5hmdO7M3WJaws9ERO
        LLQRD0ZfB6i1kUdvvsD4y2EoGXSDBctbQ
X-Received: by 2002:a17:906:7389:b0:9a5:b878:7336 with SMTP id f9-20020a170906738900b009a5b8787336mr9458675ejl.7.1696618348068;
        Fri, 06 Oct 2023 11:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlxgiiFCo6W/cxOloQkzFkz3BO5pAnKo80UorlqgbxkwRXthGuHA2XjbRabXXVlN6GGVvRXg==
X-Received: by 2002:a17:906:7389:b0:9a5:b878:7336 with SMTP id f9-20020a170906738900b009a5b8787336mr9458662ejl.7.1696618347793;
        Fri, 06 Oct 2023 11:52:27 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:27 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 10/28] fsverity: operate with Merkle tree blocks instead of pages
Date:   Fri,  6 Oct 2023 20:49:04 +0200
Message-Id: <20231006184922.252188-11-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fsverity expects filesystem to provide PAGEs with Merkle tree
blocks in it. Then, when fsverity is done with processing the
blocks, reference to PAGE is freed. This doesn't fit well with the
way XFS manages its memory.

This patch moves page reference management out of fsverity to
filesystem. This way fsverity expects a kaddr to the Merkle tree
block and filesystem can handle all caching and reference counting.

As btrfs, ext4 and f2fs return page with Merkle tree blocks this
patch also adds fsverity_read_merkle_tree_block() which wraps
addressing blocks in the page (not to implement it in every fs).

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/verity/open.c          |  15 ++---
 fs/verity/read_metadata.c |  41 +++++++-------
 fs/verity/verify.c        |  58 ++++++++-----------
 include/linux/fsverity.h  | 115 +++++++++++++++++++++++++++++++++-----
 4 files changed, 150 insertions(+), 79 deletions(-)

diff --git a/fs/verity/open.c b/fs/verity/open.c
index dfb9fe6aaae9..8665d8b40081 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -126,19 +126,16 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	}
 
 	/*
-	 * With block_size != PAGE_SIZE, an in-memory bitmap will need to be
-	 * allocated to track the "verified" status of hash blocks.  Don't allow
-	 * this bitmap to get too large.  For now, limit it to 1 MiB, which
-	 * limits the file size to about 4.4 TB with SHA-256 and 4K blocks.
+	 * An in-memory bitmap will need to be allocated to track the "verified"
+	 * status of hash blocks.  Don't allow this bitmap to get too large.
+	 * For now, limit it to 1 MiB, which limits the file size to
+	 * about 4.4 TB with SHA-256 and 4K blocks.
 	 *
 	 * Together with the fact that the data, and thus also the Merkle tree,
 	 * cannot have more than ULONG_MAX pages, this implies that hash block
-	 * indices can always fit in an 'unsigned long'.  But to be safe, we
-	 * explicitly check for that too.  Note, this is only for hash block
-	 * indices; data block indices might not fit in an 'unsigned long'.
+	 * indices can always fit in an 'unsigned long'.
 	 */
-	if ((params->block_size != PAGE_SIZE && offset > 1 << 23) ||
-	    offset > ULONG_MAX) {
+	if (offset > (1 << 23)) {
 		fsverity_err(inode, "Too many blocks in Merkle tree");
 		err = -EFBIG;
 		goto out_err;
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 197624cab43e..182bddf5dec5 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -16,9 +16,9 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 				     const struct fsverity_info *vi,
 				     void __user *buf, u64 offset, int length)
 {
-	const struct fsverity_operations *vops = inode->i_sb->s_vop;
 	u64 end_offset;
-	unsigned int offs_in_page;
+	unsigned int offs_in_block;
+	unsigned int block_size = vi->tree_params.block_size;
 	pgoff_t index, last_index;
 	int retval = 0;
 	int err = 0;
@@ -26,8 +26,8 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 	end_offset = min(offset + length, vi->tree_params.tree_size);
 	if (offset >= end_offset)
 		return 0;
-	offs_in_page = offset_in_page(offset);
-	last_index = (end_offset - 1) >> PAGE_SHIFT;
+	offs_in_block = offset % block_size;
+	last_index = (end_offset - 1) >> vi->tree_params.log_blocksize;
 
 	/*
 	 * Iterate through each Merkle tree page in the requested range and copy
@@ -35,34 +35,31 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 	 * size isn't important here, as we are returning a byte stream; i.e.,
 	 * we can just work with pages even if the tree block size != PAGE_SIZE.
 	 */
-	for (index = offset >> PAGE_SHIFT; index <= last_index; index++) {
+	for (index = offset >> vi->tree_params.log_blocksize;
+			index <= last_index; index++) {
 		unsigned long num_ra_pages =
 			min_t(unsigned long, last_index - index + 1,
 			      inode->i_sb->s_bdi->io_pages);
 		unsigned int bytes_to_copy = min_t(u64, end_offset - offset,
-						   PAGE_SIZE - offs_in_page);
-		struct page *page;
-		const void *virt;
+						   block_size - offs_in_block);
+		struct fsverity_block block;
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages,
-						   vi->tree_params.log_blocksize);
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
-			fsverity_err(inode,
-				     "Error %d reading Merkle tree page %lu",
-				     err, index);
+		block.len = block_size;
+		if (fsverity_read_merkle_tree_block(inode,
+					index << vi->tree_params.log_blocksize,
+					&block, num_ra_pages)) {
+			fsverity_drop_block(inode, &block);
+			err = -EFAULT;
 			break;
 		}
 
-		virt = kmap_local_page(page);
-		if (copy_to_user(buf, virt + offs_in_page, bytes_to_copy)) {
-			kunmap_local(virt);
-			fsverity_drop_page(inode, page);
+		if (copy_to_user(buf, block.kaddr + offs_in_block, bytes_to_copy)) {
+			fsverity_drop_block(inode, &block);
 			err = -EFAULT;
 			break;
 		}
-		kunmap_local(virt);
-		fsverity_drop_page(inode, page);
+		fsverity_drop_block(inode, &block);
+		block.kaddr = NULL;
 
 		retval += bytes_to_copy;
 		buf += bytes_to_copy;
@@ -73,7 +70,7 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 			break;
 		}
 		cond_resched();
-		offs_in_page = 0;
+		offs_in_block = 0;
 	}
 	return retval ? retval : err;
 }
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index f556336ebd8d..dfe01f121843 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -44,15 +44,15 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
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
+		/* Block containing the hash block */
+		struct fsverity_block block;
 		/* Index of the hash block in the tree overall */
 		unsigned long index;
 		/* Byte offset of the wanted hash relative to @addr */
@@ -93,10 +93,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		unsigned long next_hidx;
 		unsigned long hblock_idx;
 		pgoff_t hpage_idx;
-		unsigned int hblock_offset_in_page;
 		unsigned int hoffset;
-		struct page *hpage;
-		const void *haddr;
+		struct fsverity_block *block = &hblocks[level].block;
 
 		/*
 		 * The index of the block in the current level; also the index
@@ -110,34 +108,28 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
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
-					params->tree_pages - hpage_idx) : 0,
-				params->log_blocksize);
-		if (IS_ERR(hpage)) {
+		block->len = params->block_size;
+		num_ra_pages = level == 0 ?
+			min(max_ra_pages, params->tree_pages - hpage_idx) : 0;
+		err = fsverity_read_merkle_tree_block(
+			inode, hblock_idx << params->log_blocksize, block,
+			num_ra_pages);
+		if (err) {
 			fsverity_err(inode,
-				     "Error %ld reading Merkle tree page %lu",
-				     PTR_ERR(hpage), hpage_idx);
+				     "Error %d reading Merkle tree block %lu",
+				     err, hblock_idx);
 			goto error;
 		}
-		haddr = kmap_local_page(hpage) + hblock_offset_in_page;
-		if (is_hash_block_verified(vi, hblock_idx, PageChecked(hpage))) {
-			memcpy(_want_hash, haddr + hoffset, hsize);
+		if (is_hash_block_verified(vi, hblock_idx, block->cached)) {
+			memcpy(_want_hash, block->kaddr + hoffset, hsize);
 			want_hash = _want_hash;
-			kunmap_local(haddr);
-			fsverity_drop_page(inode, hpage);
+			fsverity_drop_block(inode, block);
 			goto descend;
 		}
-		hblocks[level].page = hpage;
-		hblocks[level].addr = haddr;
 		hblocks[level].index = hblock_idx;
 		hblocks[level].hoffset = hoffset;
 		hidx = next_hidx;
@@ -147,8 +139,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 descend:
 	/* Descend the tree verifying hash blocks. */
 	for (; level > 0; level--) {
-		struct page *hpage = hblocks[level - 1].page;
-		const void *haddr = hblocks[level - 1].addr;
+		struct fsverity_block *block = &hblocks[level - 1].block;
+		const void *haddr = block->kaddr;
 		unsigned long hblock_idx = hblocks[level - 1].index;
 		unsigned int hoffset = hblocks[level - 1].hoffset;
 
@@ -161,14 +153,11 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		 * idempotent, as the same hash block might be verified by
 		 * multiple threads concurrently.
 		 */
-		if (vi->hash_block_verified)
-			set_bit(hblock_idx, vi->hash_block_verified);
-		else
-			SetPageChecked(hpage);
+		set_bit(hblock_idx, vi->hash_block_verified);
+		block->verified = true;
 		memcpy(_want_hash, haddr + hoffset, hsize);
 		want_hash = _want_hash;
-		kunmap_local(haddr);
-		fsverity_drop_page(inode, hpage);
+		fsverity_drop_block(inode, block);
 	}
 
 	/* Finally, verify the data block. */
@@ -186,8 +175,7 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 		     params->hash_alg->name, hsize, real_hash);
 error:
 	for (; level > 0; level--) {
-		kunmap_local(hblocks[level - 1].addr);
-		fsverity_drop_page(inode, hblocks[level - 1].page);
+		fsverity_drop_block(inode, &hblocks[level - 1].block);
 	}
 	return false;
 }
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index cac012d4c86a..ce37a430bc97 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -26,6 +26,24 @@
 /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
 #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
 
+/**
+ * struct fsverity_block - Merkle Tree block
+ * @kaddr: virtual address of the block's data
+ * @len: length of the data
+ * @cached: true if block was already in cache, false otherwise
+ * @verified: true if block is verified against Merkle tree
+ * @context: filesystem private context
+ *
+ * Merkle Tree blocks passed and requested from filesystem
+ */
+struct fsverity_block {
+	void *kaddr;
+	unsigned int len;
+	bool cached;
+	bool verified;
+	void *context;
+};
+
 /* Verity operations for filesystems */
 struct fsverity_operations {
 
@@ -107,6 +125,24 @@ struct fsverity_operations {
 					      pgoff_t index,
 					      unsigned long num_ra_pages,
 					      u8 log_blocksize);
+	/**
+	 * Read a Merkle tree block of the given inode.
+	 * @inode: the inode
+	 * @index: 0-based index of the block within the Merkle tree
+	 * @num_ra_pages: The number of pages with blocks that should be
+	 *		  prefetched starting at @index if the page at @index
+	 *		  isn't already cached.  Implementations may ignore this
+	 *		  argument; it's only a performance optimization.
+	 *
+	 * This can be called at any time on an open verity file.  It may be
+	 * called by multiple processes concurrently.
+	 *
+	 * Return: 0 on success, -errno on failure
+	 */
+	int (*read_merkle_tree_block)(struct inode *inode,
+				      unsigned int index,
+				      struct fsverity_block *block,
+				      unsigned long num_ra_pages);
 
 	/**
 	 * Write a Merkle tree block to the given inode.
@@ -125,14 +161,14 @@ struct fsverity_operations {
 				       u64 pos, unsigned int size);
 
 	/**
-	 * Release the reference to a Merkle tree page
+	 * Release the reference to a Merkle tree block
 	 *
-	 * @page: the page to release
+	 * @page: the block to release
 	 *
-	 * This is called when fs-verity is done with a page obtained with
-	 * ->read_merkle_tree_page().
+	 * This is called when fs-verity is done with a block obtained with
+	 * ->read_merkle_tree_block().
 	 */
-	void (*drop_page)(struct page *page);
+	void (*drop_block)(struct fsverity_block *block);
 };
 
 #ifdef CONFIG_FS_VERITY
@@ -188,22 +224,66 @@ void fsverity_verify_bio(struct bio *bio);
 void fsverity_enqueue_verify_work(struct work_struct *work);
 
 /**
- * fsverity_drop_page() - drop page obtained with ->read_merkle_tree_page()
+ * fsverity_drop_block() - drop block obtained with ->read_merkle_tree_block()
  * @inode: inode in use for verification or metadata reading
- * @page: page to be dropped
+ * @block: block to be dropped
  *
- * Generic put_page() method. Calls out back to filesystem if ->drop_page() is
- * set, otherwise just drops the reference to a page.
+ * Generic put_page() method. Calls out back to filesystem if ->drop_block() is
+ * set, otherwise do nothing.
  *
  */
-static inline void fsverity_drop_page(struct inode *inode, struct page *page)
+static inline void fsverity_drop_block(struct inode *inode,
+		struct fsverity_block *block)
 {
-	if (inode->i_sb->s_vop->drop_page)
-		inode->i_sb->s_vop->drop_page(page);
-	else
+	if (inode->i_sb->s_vop->drop_block)
+		inode->i_sb->s_vop->drop_block(block);
+	else {
+		struct page *page = (struct page *)block->context;
+
+		if (block->verified)
+			SetPageChecked(page);
+
 		put_page(page);
+	}
 }
 
+/**
+ * fsverity_read_block_from_page() - layer between fs using read page
+ * and read block
+ * @inode: inode in use for verification or metadata reading
+ * @index: index of the block in the tree (offset into the tree)
+ * @block: block to be read
+ * @num_ra_pages: number of pages to readahead, may be ignored
+ *
+ * Depending on fs implementation use read_merkle_tree_block or
+ * read_merkle_tree_page.
+ */
+static inline int fsverity_read_merkle_tree_block(struct inode *inode,
+					unsigned int index,
+					struct fsverity_block *block,
+					unsigned long num_ra_pages)
+{
+	struct page *page;
+
+	if (inode->i_sb->s_vop->read_merkle_tree_block)
+		return inode->i_sb->s_vop->read_merkle_tree_block(
+			inode, index, block, num_ra_pages);
+
+	page = inode->i_sb->s_vop->read_merkle_tree_page(
+			inode, index >> PAGE_SHIFT, num_ra_pages,
+			block->len);
+
+	block->kaddr = page_address(page) + (index % PAGE_SIZE);
+	block->cached = PageChecked(page);
+	block->context = page;
+
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+	else
+		return 0;
+}
+
+
 
 #else /* !CONFIG_FS_VERITY */
 
@@ -287,6 +367,15 @@ static inline void fsverity_drop_page(struct inode *inode, struct page *page)
 	WARN_ON_ONCE(1);
 }
 
+static inline int fsverity_read_merkle_tree_block(struct inode *inode,
+					unsigned int index,
+					struct fsverity_block *block,
+					unsigned long num_ra_pages)
+{
+	WARN_ON_ONCE(1);
+	return -EOPNOTSUPP;
+}
+
 #endif	/* !CONFIG_FS_VERITY */
 
 static inline bool fsverity_verify_folio(struct folio *folio)
-- 
2.40.1

