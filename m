Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24853FE0B3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbhIARCo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345620AbhIARCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C730DC061575
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:01:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m4so73641pll.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEYLDqc78gFcwsoNG5Zb4Yjphj9Rc1Ierdad/AlgDro=;
        b=CNCgNZAMfW8O9ZJDRZxHgBRbXtskfhIunCs0KM1HGRw+QdTXqQNTh4YlUdzaSwNE4o
         aDmRkjuGpdtKYcZu8CD3mz3aZsCVQnCdxE3ZpypPfU5BXDS5pTLQ6fzKHrGAMPWY0zy/
         DU6NWLwLKsmZ4N6pUb+bQm1SeHQdq1CthnbGX2jFAs1yj09DlXBEtTcYf9YLCG+slyIE
         CYwn0yl9p8fYLZHhT3m/Qiq4HaW4dATiwkUs4azUMwqV7ftdiBZ4mIf+5AG+2EQhTCBt
         7mVy93zF37RAYKNMuVMElvKvSJmyyONPN7Br+lLUPZDvLEtNPIRkN0fXCewsXq0EC/uz
         7XcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEYLDqc78gFcwsoNG5Zb4Yjphj9Rc1Ierdad/AlgDro=;
        b=gcqz040+qvdLhQnkIKkUtNjxJg5pWWVUQ7YEmBBwxvgrnplCECqSVyQQ/DN//CirKy
         uDiEMGc1t5BZvVvGDwh5z60nTRVpUom66Bwe56DxPQm54PUTX8MdDnyvdF21tFizApib
         0BXuTRoxCDuJ1omv1R9x8/O78oP2zcFkF+9x6dzszGBQXUewVpU73oR4hLPGZ7R8zskA
         PMbBqZIedH8By9OU/QyD6BQ8g7welHrmAaZbJDUQIgt1ZVfCE48RIKZgPYmIoptUAvrV
         B1efns+wYfBSf4xbF5Mp8eX06GAdfcuEhtBjk6XmXDWJbQArmr4k4BQN8KZNSj6E6Jxk
         4fAw==
X-Gm-Message-State: AOAM5308rr3BK68V9sHj7lse22EEYwUU4gWxqXgztx5ZVdMEkiK9tufR
        xCDxdekhXFvX13JXsDo4f8Rs55YYOqt5OA==
X-Google-Smtp-Source: ABdhPJxHpLCikL1mEA9C/vZIpclsMy6i2iJ/s/YAgW8ihl1BegD8NAuA5meJ3dSmOHSPB5gOBi0gDQ==
X-Received: by 2002:a17:90a:3b0e:: with SMTP id d14mr399916pjc.164.1630515705221;
        Wed, 01 Sep 2021 10:01:45 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:44 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 13/14] btrfs: send: send compressed extents with encoded writes
Date:   Wed,  1 Sep 2021 10:01:08 -0700
Message-Id: <366f92a7ec5a69dc92290dc2cf6e8603f566495c.1630514529.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Now that all of the pieces are in place, we can use the ENCODED_WRITE
command to send compressed extents when appropriate.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h |   4 +
 fs/btrfs/inode.c |   6 +-
 fs/btrfs/send.c  | 230 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 220 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7753976bc3c7..caec0422a5c4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3223,6 +3223,10 @@ int btrfs_writepage_cow_fixup(struct page *page);
 void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 					  struct page *page, u64 start,
 					  u64 end, bool uptodate);
+int btrfs_encoded_io_compression_from_extent(int compress_type);
+int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 offset,
+					  u64 disk_io_size,
+					  struct page **pages);
 struct btrfs_ioctl_encoded_io_args;
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 			   struct btrfs_ioctl_encoded_io_args *encoded);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e751af96c198..6c40419eb2b1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10502,7 +10502,7 @@ void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
 	}
 }
 
-static int btrfs_encoded_io_compression_from_extent(int compress_type)
+int btrfs_encoded_io_compression_from_extent(int compress_type)
 {
 	switch (compress_type) {
 	case BTRFS_COMPRESS_NONE:
@@ -10705,8 +10705,8 @@ static void btrfs_encoded_read_endio(struct bio *bio)
 	bio_put(bio);
 }
 
-static int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 offset,
-						 u64 disk_io_size, struct page **pages)
+int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 offset,
+					  u64 disk_io_size, struct page **pages)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_encoded_read_private priv = {
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index a000efe2658a..0ba8dc3a9f56 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -595,6 +595,7 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 		return tlv_put(sctx, attr, &__tmp, sizeof(__tmp));	\
 	}
 
+TLV_PUT_DEFINE_INT(32)
 TLV_PUT_DEFINE_INT(64)
 
 static int tlv_put_string(struct send_ctx *sctx, u16 attr,
@@ -5203,16 +5204,211 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	return ret;
 }
 
-static int send_extent_data(struct send_ctx *sctx,
-			    const u64 offset,
-			    const u64 len)
+static int send_encoded_inline_extent(struct send_ctx *sctx,
+				      struct btrfs_path *path, u64 offset,
+				      u64 len)
 {
+	struct btrfs_root *root = sctx->send_root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct inode *inode;
+	struct fs_path *p;
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_key key;
+	struct btrfs_file_extent_item *ei;
+	u64 ram_bytes;
+	size_t inline_size;
+	int ret;
+
+	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	p = fs_path_alloc();
+	if (!p) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_ENCODED_WRITE);
+	if (ret < 0)
+		goto out;
+
+	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+	if (ret < 0)
+		goto out;
+
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+	ei = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_extent_item);
+	ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
+	inline_size = btrfs_file_extent_inline_item_len(leaf,
+						btrfs_item_nr(path->slots[0]));
+
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
+		    min(key.offset + ram_bytes - offset, len));
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN, ram_bytes);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET, offset - key.offset);
+	ret = btrfs_encoded_io_compression_from_extent(
+				btrfs_file_extent_compression(leaf, ei));
+	if (ret < 0)
+		goto out;
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_ENCRYPTION, 0);
+
+	ret = put_data_header(sctx, inline_size);
+	if (ret < 0)
+		goto out;
+	read_extent_buffer(leaf, sctx->send_buf + sctx->send_size,
+			   btrfs_file_extent_inline_start(ei), inline_size);
+	sctx->send_size += inline_size;
+
+	ret = send_cmd(sctx);
+
+tlv_put_failure:
+out:
+	fs_path_free(p);
+	iput(inode);
+	return ret;
+}
+
+static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
+			       u64 offset, u64 len)
+{
+	struct btrfs_root *root = sctx->send_root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct inode *inode;
+	struct fs_path *p;
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_key key;
+	struct btrfs_file_extent_item *ei;
+	u64 block_start;
+	u64 block_len;
+	u32 data_offset;
+	struct btrfs_cmd_header *hdr;
+	u32 crc;
+	int ret;
+
+	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	p = fs_path_alloc();
+	if (!p) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_ENCODED_WRITE);
+	if (ret < 0)
+		goto out;
+
+	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+	if (ret < 0)
+		goto out;
+
+	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
+	ei = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_extent_item);
+	block_start = btrfs_file_extent_disk_bytenr(leaf, ei);
+	block_len = btrfs_file_extent_disk_num_bytes(leaf, ei);
+
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_FILE_LEN,
+		    min(key.offset + btrfs_file_extent_num_bytes(leaf, ei) - offset,
+			len));
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_LEN,
+		    btrfs_file_extent_ram_bytes(leaf, ei));
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_UNENCODED_OFFSET,
+		    offset - key.offset + btrfs_file_extent_offset(leaf, ei));
+	ret = btrfs_encoded_io_compression_from_extent(
+				btrfs_file_extent_compression(leaf, ei));
+	if (ret < 0)
+		goto out;
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_COMPRESSION, ret);
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_ENCRYPTION, 0);
+
+	ret = put_data_header(sctx, block_len);
+	if (ret < 0)
+		goto out;
+
+	data_offset = ALIGN(sctx->send_size, PAGE_SIZE);
+	if (data_offset > sctx->send_max_size ||
+	    sctx->send_max_size - data_offset < block_len) {
+		ret = -EOVERFLOW;
+		goto out;
+	}
+
+	ret = btrfs_encoded_read_regular_fill_pages(inode, block_start,
+						    block_len,
+						    sctx->send_buf_pages +
+						    (data_offset >> PAGE_SHIFT));
+	if (ret)
+		goto out;
+
+	hdr = (struct btrfs_cmd_header *)sctx->send_buf;
+	hdr->len = cpu_to_le32(sctx->send_size + block_len - sizeof(*hdr));
+	hdr->crc = 0;
+	crc = btrfs_crc32c(0, sctx->send_buf, sctx->send_size);
+	crc = btrfs_crc32c(crc, sctx->send_buf + data_offset, block_len);
+	hdr->crc = cpu_to_le32(crc);
+
+	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
+			&sctx->send_off);
+	if (!ret) {
+		ret = write_buf(sctx->send_filp, sctx->send_buf + data_offset,
+				block_len, &sctx->send_off);
+	}
+	sctx->total_send_size += sctx->send_size + block_len;
+	sctx->cmd_send_size[le16_to_cpu(hdr->cmd)] +=
+		sctx->send_size + block_len;
+	sctx->send_size = 0;
+
+tlv_put_failure:
+out:
+	fs_path_free(p);
+	iput(inode);
+	return ret;
+}
+
+static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
+			    const u64 offset, const u64 len)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_file_extent_item *ei;
 	u64 read_size = max_send_read_size(sctx);
 	u64 sent = 0;
 
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, len);
 
+	ei = btrfs_item_ptr(leaf, path->slots[0],
+			    struct btrfs_file_extent_item);
+	if ((sctx->flags & BTRFS_SEND_FLAG_COMPRESSED) &&
+	    btrfs_file_extent_compression(leaf, ei) != BTRFS_COMPRESS_NONE) {
+		bool is_inline = (btrfs_file_extent_type(leaf, ei) ==
+				  BTRFS_FILE_EXTENT_INLINE);
+
+		/*
+		 * Send the compressed extent unless the compressed data is
+		 * larger than the decompressed data. This can happen if we're
+		 * not sending the entire extent, either because it has been
+		 * partially overwritten/truncated or because this is a part of
+		 * the extent that we couldn't clone in clone_range().
+		 */
+		if (is_inline &&
+		    btrfs_file_extent_inline_item_len(leaf,
+					btrfs_item_nr(path->slots[0])) <= len) {
+			return send_encoded_inline_extent(sctx, path, offset,
+							  len);
+		} else if (!is_inline &&
+			   btrfs_file_extent_disk_num_bytes(leaf, ei) <= len) {
+			return send_encoded_extent(sctx, path, offset, len);
+		}
+	}
+
 	while (sent < len) {
 		u64 size = min(len - sent, read_size);
 		int ret;
@@ -5283,12 +5479,9 @@ static int send_capabilities(struct send_ctx *sctx)
 	return ret;
 }
 
-static int clone_range(struct send_ctx *sctx,
-		       struct clone_root *clone_root,
-		       const u64 disk_byte,
-		       u64 data_offset,
-		       u64 offset,
-		       u64 len)
+static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
+		       struct clone_root *clone_root, const u64 disk_byte,
+		       u64 data_offset, u64 offset, u64 len)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
@@ -5312,7 +5505,7 @@ static int clone_range(struct send_ctx *sctx,
 	 */
 	if (clone_root->offset == 0 &&
 	    len == sctx->send_root->fs_info->sectorsize)
-		return send_extent_data(sctx, offset, len);
+		return send_extent_data(sctx, dst_path, offset, len);
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -5409,7 +5602,8 @@ static int clone_range(struct send_ctx *sctx,
 
 			if (hole_len > len)
 				hole_len = len;
-			ret = send_extent_data(sctx, offset, hole_len);
+			ret = send_extent_data(sctx, dst_path, offset,
+					       hole_len);
 			if (ret < 0)
 				goto out;
 
@@ -5482,14 +5676,16 @@ static int clone_range(struct send_ctx *sctx,
 					if (ret < 0)
 						goto out;
 				}
-				ret = send_extent_data(sctx, offset + slen,
+				ret = send_extent_data(sctx, dst_path,
+						       offset + slen,
 						       clone_len - slen);
 			} else {
 				ret = send_clone(sctx, offset, clone_len,
 						 clone_root);
 			}
 		} else {
-			ret = send_extent_data(sctx, offset, clone_len);
+			ret = send_extent_data(sctx, dst_path, offset,
+					       clone_len);
 		}
 
 		if (ret < 0)
@@ -5521,7 +5717,7 @@ static int clone_range(struct send_ctx *sctx,
 	}
 
 	if (len > 0)
-		ret = send_extent_data(sctx, offset, len);
+		ret = send_extent_data(sctx, dst_path, offset, len);
 	else
 		ret = 0;
 out:
@@ -5552,10 +5748,10 @@ static int send_write_or_clone(struct send_ctx *sctx,
 				    struct btrfs_file_extent_item);
 		disk_byte = btrfs_file_extent_disk_bytenr(path->nodes[0], ei);
 		data_offset = btrfs_file_extent_offset(path->nodes[0], ei);
-		ret = clone_range(sctx, clone_root, disk_byte, data_offset,
-				  offset, end - offset);
+		ret = clone_range(sctx, path, clone_root, disk_byte,
+				  data_offset, offset, end - offset);
 	} else {
-		ret = send_extent_data(sctx, offset, end - offset);
+		ret = send_extent_data(sctx, path, offset, end - offset);
 	}
 	sctx->cur_inode_next_write_offset = end;
 	return ret;
-- 
2.33.0

