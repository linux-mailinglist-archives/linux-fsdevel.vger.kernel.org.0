Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0A333DDF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240655AbhCPTpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240613AbhCPTpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25394C0613DA
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q12so6981670plr.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6OsUA50+8xoVcD2c3qd1aIdeBQH0nioyEP52OneAmPE=;
        b=KWBn17b9Obf/nBjJaUYsB3u1wpQIzCkKRQwXTYjxHnPCk0lt55ESCAoj5xqGNkZvVt
         +CqzYX/lucXshzWS4nmcnAUwmwrzkdgzoyZ5Jgk1a4TcEsuYMSZS/cBCKn6mbjPWYTn0
         +txMTFpXbhNOTjNvilIc3iWbBbzqNQ6QR4GHn4/NUnNGsVCb4aMEnF3ZXoWbA8bzwS6P
         jpkE4OfFr6vHy3I+WQxSKyBcrajSvfJU3WDarg6xcbc+PkOvSa/ycDRObPS3IR7OU3R6
         RjLgOwE0eD/zRvyC32FsW2vI/qoRrJZveR6jr6D0/49/5wZnqYDeAc5UlreDs8ydOjdt
         o+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6OsUA50+8xoVcD2c3qd1aIdeBQH0nioyEP52OneAmPE=;
        b=fEe82QLSbbUJhwsr4Yv9FR4ob2b51FV+ocCsq+NJiWL1Bn37tVpMTPzYJplKOtzJhi
         X8mfqCiiSESYzN19yHCGpPPN5/YMMPDtsPJd5OrOHCd8flRwr9JcD6B1k9xsK6JftbHq
         AOxGBVsKuWdwTd0p44TONfXgIxaMam7C60tuOPT4dzMubhCDEJruaTs1B3LJFR/fEiwu
         t1Q23eswXv6Gb/FB1QYxKVAGan1ftLAI6piYh1zYKEHt5r/Gzg5Ze+eUWO4WE+iSuJDY
         BL3HQRy++fJPvKLeihBgxPLGruPeMns8zxSLNBcQ/BZ5DukV122O96wWsIOR7WSwfvbA
         uLVA==
X-Gm-Message-State: AOAM53157NBSWoZSi9aBMRXjX8T//Rg+zK7B7PbRWuNB4NLMWeTlQ7BI
        Q8rkpN4TRSV9Pfn3AUzMgB/DgA==
X-Google-Smtp-Source: ABdhPJxKk0KhlNgwdEaDwDUGXPI/3mRTybXij/0/kfz1YkKBsJKqFbxT91wmEQ3EFLCvadSY6/asLA==
X-Received: by 2002:a17:902:7682:b029:e6:2bc5:f005 with SMTP id m2-20020a1709027682b02900e62bc5f005mr851951pll.32.1615923876233;
        Tue, 16 Mar 2021 12:44:36 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:35 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 4/5] btrfs: send: send compressed extents with encoded writes
Date:   Tue, 16 Mar 2021 12:43:57 -0700
Message-Id: <d2dd30f428d8d8a39882a57a4f5f610ad64a91be.1615922753.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
index 33a08ab5cb0e..402ffdce81ac 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3157,6 +3157,10 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end);
 void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					  u64 end, int uptodate);
+int encoded_iov_compression_from_btrfs(unsigned int compress_type);
+int btrfs_encoded_read_regular_fill_pages(struct inode *inode, u64 offset,
+					  u64 disk_io_size,
+					  struct page **pages);
 ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 			       struct encoded_iov *encoded);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c2fe76f57bf5..3c1c8879a9e1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9984,7 +9984,7 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
 	}
 }
 
-static int encoded_iov_compression_from_btrfs(unsigned int compress_type)
+int encoded_iov_compression_from_btrfs(unsigned int compress_type)
 {
 	switch (compress_type) {
 	case BTRFS_COMPRESS_NONE:
@@ -10190,8 +10190,8 @@ static void btrfs_encoded_read_endio(struct bio *bio)
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
index 25b1a60a568c..7516eba701af 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -595,6 +595,7 @@ static int tlv_put(struct send_ctx *sctx, u16 attr, const void *data, int len)
 		return tlv_put(sctx, attr, &__tmp, sizeof(__tmp));	\
 	}
 
+TLV_PUT_DEFINE_INT(32)
 TLV_PUT_DEFINE_INT(64)
 
 static int tlv_put_string(struct send_ctx *sctx, u16 attr,
@@ -5213,16 +5214,211 @@ static int send_hole(struct send_ctx *sctx, u64 end)
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
+	ret = encoded_iov_compression_from_btrfs(
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
+	ret = encoded_iov_compression_from_btrfs(
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
@@ -5293,12 +5489,9 @@ static int send_capabilities(struct send_ctx *sctx)
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
@@ -5322,7 +5515,7 @@ static int clone_range(struct send_ctx *sctx,
 	 */
 	if (clone_root->offset == 0 &&
 	    len == sctx->send_root->fs_info->sectorsize)
-		return send_extent_data(sctx, offset, len);
+		return send_extent_data(sctx, dst_path, offset, len);
 
 	path = alloc_path_for_send();
 	if (!path)
@@ -5419,7 +5612,8 @@ static int clone_range(struct send_ctx *sctx,
 
 			if (hole_len > len)
 				hole_len = len;
-			ret = send_extent_data(sctx, offset, hole_len);
+			ret = send_extent_data(sctx, dst_path, offset,
+					       hole_len);
 			if (ret < 0)
 				goto out;
 
@@ -5492,14 +5686,16 @@ static int clone_range(struct send_ctx *sctx,
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
@@ -5531,7 +5727,7 @@ static int clone_range(struct send_ctx *sctx,
 	}
 
 	if (len > 0)
-		ret = send_extent_data(sctx, offset, len);
+		ret = send_extent_data(sctx, dst_path, offset, len);
 	else
 		ret = 0;
 out:
@@ -5562,10 +5758,10 @@ static int send_write_or_clone(struct send_ctx *sctx,
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
2.30.2

