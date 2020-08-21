Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5945824CF99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHUHkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgHUHkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:19 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98220C061387
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 189so599926pgg.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rV0Iw2CCSZHG6p1G4uFOZPtC+8d3NmwhtMPWnU59b4o=;
        b=yF3ZUILBJ6pRuJOTEVflPp/vEYfpVErHnkY9F4KHaPMN2rchhmZ4blW6ivIKX/t5kk
         Bc4jBnsEvq0Al4xyHfDG4KcvMwGdOqguFCG/BabKcZLu4fgFmeNlh3/vqHK4mqim4N5n
         wPoJpKwrMsQiiES8kp/0YZWkWxUeXm2Ar0tWDe/Zh3t62KJ9z/HdxmIdwHaUyck3BnKe
         UanAV49SOd2H+bW+EVEGqhpOvnCElcpIIzhcoLeKJBy4juaDdohUU1H1H4WUZ85079tf
         IGbrthiM0giWDVo/bWkwdWKRRtp1blu0V3440gZZ0AugisuBgt+CCGN94WASxhEDo/Nr
         0Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rV0Iw2CCSZHG6p1G4uFOZPtC+8d3NmwhtMPWnU59b4o=;
        b=W5j5DtTMSH4Oq4/3XqiEd8e4Q5uxQGKW8jRdpwBiuMKrnMsURHThut8n7/TlUMj1CL
         tsV2uaH1l0PNcQnH8gqK0VICyyIOyDJy4e5B8Rm+Irzh1LUKsYkCvCGM88G+dyucxARe
         LP7A/Z2hgj9mdBgr6/kTV21JrIR/9pbPBlJaV8whZFV8msG9vcwK2DLZn9hwwS2S8owh
         tNu7f3bzt/Ewh76Z77F9JrLCC+pZyTbrxE0K12ennJxyHjhJ11baJte5el8yX12K8x8W
         yryB/Bkjvdzf89+pfOr7MXPsiyWrU49iE2peMd4ohCMW7ySAG5W++J3T5Z1KCXBRfqBE
         4AUA==
X-Gm-Message-State: AOAM530kH0RBGLGCARxOL/k/SYiPSJLNItg75XMFtq8WgJZbBHcAGRIM
        k9NWBFheWjyh1YWNZ16xIpUMUl1KSeMbVw==
X-Google-Smtp-Source: ABdhPJx5BYSVv2feYz5UTuKAlmjkIsTLVPVDIM/X9wiNoLdnQYy0W7Vg3XqVJIGd7kHmLA05UdiIAQ==
X-Received: by 2002:a62:9246:: with SMTP id o67mr1416722pfd.249.1597995619020;
        Fri, 21 Aug 2020 00:40:19 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:17 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] btrfs: send: avoid copying file data
Date:   Fri, 21 Aug 2020 00:39:52 -0700
Message-Id: <be54e8e7658f85dd5e62627a1ad02beb7a4aeed8.1597994106.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

send_write() currently copies from the page cache to sctx->read_buf, and
then from sctx->read_buf to sctx->send_buf. Similarly, send_hole()
zeroes sctx->read_buf and then copies from sctx->read_buf to
sctx->send_buf. However, if we write the TLV header manually, we can
copy to sctx->send_buf directly and get rid of sctx->read_buf.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 65 +++++++++++++++++++++++++++++--------------------
 fs/btrfs/send.h |  1 -
 2 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 8af5e867e4ca..e70f5ceb3261 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -122,8 +122,6 @@ struct send_ctx {
 
 	struct file_ra_state ra;
 
-	char *read_buf;
-
 	/*
 	 * We process inodes by their increasing order, so if before an
 	 * incremental send we reverse the parent/child relationship of
@@ -4794,7 +4792,25 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	return ret;
 }
 
-static int fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
+static u64 max_send_read_size(struct send_ctx *sctx)
+{
+	return sctx->send_max_size - SZ_16K;
+}
+
+static int put_data_header(struct send_ctx *sctx, u32 len)
+{
+	struct btrfs_tlv_header *hdr;
+
+	if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
+		return -EOVERFLOW;
+	hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
+	hdr->tlv_type = cpu_to_le16(BTRFS_SEND_A_DATA);
+	hdr->tlv_len = cpu_to_le16(len);
+	sctx->send_size += sizeof(*hdr);
+	return 0;
+}
+
+static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 {
 	struct btrfs_root *root = sctx->send_root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -4804,8 +4820,11 @@ static int fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 	pgoff_t index = offset >> PAGE_SHIFT;
 	pgoff_t last_index;
 	unsigned pg_offset = offset_in_page(offset);
-	int ret = 0;
-	size_t read = 0;
+	int ret;
+
+	ret = put_data_header(sctx, len);
+	if (ret)
+		return ret;
 
 	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
 	if (IS_ERR(inode))
@@ -4851,14 +4870,15 @@ static int fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 		}
 
 		addr = kmap(page);
-		memcpy(sctx->read_buf + read, addr + pg_offset, cur_len);
+		memcpy(sctx->send_buf + sctx->send_size, addr + pg_offset,
+		       cur_len);
 		kunmap(page);
 		unlock_page(page);
 		put_page(page);
 		index++;
 		pg_offset = 0;
 		len -= cur_len;
-		read += cur_len;
+		sctx->send_size += cur_len;
 	}
 	iput(inode);
 	return ret;
@@ -4880,10 +4900,6 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 
 	btrfs_debug(fs_info, "send_write offset=%llu, len=%d", offset, len);
 
-	ret = fill_read_buf(sctx, offset, len);
-	if (ret < 0)
-		goto out;
-
 	ret = begin_cmd(sctx, BTRFS_SEND_C_WRITE);
 	if (ret < 0)
 		goto out;
@@ -4894,7 +4910,9 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
-	TLV_PUT(sctx, BTRFS_SEND_A_DATA, sctx->read_buf, len);
+	ret = put_file_data(sctx, offset, len);
+	if (ret < 0)
+		goto out;
 
 	ret = send_cmd(sctx);
 
@@ -5013,8 +5031,8 @@ static int send_update_extent(struct send_ctx *sctx,
 static int send_hole(struct send_ctx *sctx, u64 end)
 {
 	struct fs_path *p = NULL;
+	u64 read_size = max_send_read_size(sctx);
 	u64 offset = sctx->cur_inode_last_extent;
-	u64 len;
 	int ret = 0;
 
 	/*
@@ -5041,16 +5059,19 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
 	if (ret < 0)
 		goto tlv_put_failure;
-	memset(sctx->read_buf, 0, BTRFS_SEND_READ_SIZE);
 	while (offset < end) {
-		len = min_t(u64, end - offset, BTRFS_SEND_READ_SIZE);
+		u64 len = min(end - offset, read_size);
 
 		ret = begin_cmd(sctx, BTRFS_SEND_C_WRITE);
 		if (ret < 0)
 			break;
 		TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 		TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
-		TLV_PUT(sctx, BTRFS_SEND_A_DATA, sctx->read_buf, len);
+		ret = put_data_header(sctx, len);
+		if (ret < 0)
+			break;
+		memset(sctx->send_buf + sctx->send_size, 0, len);
+		sctx->send_size += len;
 		ret = send_cmd(sctx);
 		if (ret < 0)
 			break;
@@ -5066,17 +5087,16 @@ static int send_extent_data(struct send_ctx *sctx,
 			    const u64 offset,
 			    const u64 len)
 {
+	u64 read_size = max_send_read_size(sctx);
 	u64 sent = 0;
 
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, len);
 
 	while (sent < len) {
-		u64 size = len - sent;
+		u64 size = min(len - sent, read_size);
 		int ret;
 
-		if (size > BTRFS_SEND_READ_SIZE)
-			size = BTRFS_SEND_READ_SIZE;
 		ret = send_write(sctx, offset + sent, size);
 		if (ret < 0)
 			return ret;
@@ -7145,12 +7165,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 		goto out;
 	}
 
-	sctx->read_buf = kvmalloc(BTRFS_SEND_READ_SIZE, GFP_KERNEL);
-	if (!sctx->read_buf) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	sctx->pending_dir_moves = RB_ROOT;
 	sctx->waiting_dir_moves = RB_ROOT;
 	sctx->orphan_dirs = RB_ROOT;
@@ -7354,7 +7368,6 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 
 		kvfree(sctx->clone_roots);
 		kvfree(sctx->send_buf);
-		kvfree(sctx->read_buf);
 
 		name_cache_free(sctx);
 
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index ead397f7034f..de91488b7cd0 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -13,7 +13,6 @@
 #define BTRFS_SEND_STREAM_VERSION 1
 
 #define BTRFS_SEND_BUF_SIZE SZ_64K
-#define BTRFS_SEND_READ_SIZE (48 * SZ_1K)
 
 enum btrfs_tlv_type {
 	BTRFS_TLV_U8,
-- 
2.28.0

