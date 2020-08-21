Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D02A24CF93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgHUHk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgHUHkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43180C061385
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:17 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id s14so519164plp.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SqT5HAFYRljt1AMWeBXhRdOtC1aJb3/tKpBWuypvUM=;
        b=vGjTBtegLouDINSX89/DUbl0rXrvGMosTXgf3yh/KvRO+XaYrs13qKTStO39lW2D1v
         e71FCzZqXXyTo5b5NdWFb+1SNsyZZ8ethiDK9sz1r9bj1nmuPBGtQ7q4JBohtBJNrQOQ
         sOwHxaI+rpxGbY/xTgxsHcDplJcvrf7KjcyapKfQRCu53rB60SgmSX03EzpYXweEtL5S
         KuruJfdEq/nKjJKKGIBvnwjYCcVvjlsp7rKcVwVCdbcFRDviA2Xk5/vZpD3V/ERoqMOx
         MbLlkRF9GoKP+ODevyrSHp0wqnZvkwbyK1QntGRoRyel+JVMu0bic9qDMBpTd61a9mYE
         3JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SqT5HAFYRljt1AMWeBXhRdOtC1aJb3/tKpBWuypvUM=;
        b=qipSiKbiDlElj1piNNwfvzE38KTa4kuUSXqnPC2nMVwlT/XLh1ONLr97LPZPUT6kgK
         2zo4nEDj7Wpla+qU2R0/b1gCf6fewXvQLyd3Ly/iQkaBnX/uBiOaI5DOBebg2M8V7FQD
         LXSgJMD8Uj1/HxQDq320Ublgy0TPnZqXLpz4xRzBKkvj6Biu1yTN5Ek7WvmQfaCX8aHJ
         tvaYrz2drEP3q8oVGPgU81fn1RrHvn2wKxeT9BTlu60NJniPwHOWKrNkaSVbDxlcosFh
         pUHmOyR1JRQ/VfdbNyrOTtbjYdRE+t6XrxawqI7cA6IMdHXlzar51Plcn6wJfdHBQ7ee
         4Q5A==
X-Gm-Message-State: AOAM530l5sLWwrv4i2LOOeDs3RdsKl3xCEU1PSs3M3CCk/BrpdvJoCQH
        MwVHNwZi49T4bOBJdf4sfuAu9w==
X-Google-Smtp-Source: ABdhPJxN9ZmKpfnmcT+flno4G92mVF8eJPuMYv1H6pNBYN2fp+LMtlORB8iGhREqfVBYgy4HaRl81Q==
X-Received: by 2002:a17:902:b60d:: with SMTP id b13mr1467416pls.48.1597995616710;
        Fri, 21 Aug 2020 00:40:16 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:14 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/9] btrfs: send: get rid of i_size logic in send_write()
Date:   Fri, 21 Aug 2020 00:39:51 -0700
Message-Id: <16f28691ff66e8aeb280532cc146c8ee49d6cda4.1597994106.git.osandov@osandov.com>
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

send_write()/fill_read_buf() have some logic for avoiding reading past
i_size. However, everywhere that we call
send_write()/send_extent_data(), we've already clamped the length down
to i_size. Get rid of the i_size handling, which simplifies the next
change.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/send.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7c7c09fc65e8..8af5e867e4ca 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4794,7 +4794,7 @@ static int process_all_new_xattrs(struct send_ctx *sctx)
 	return ret;
 }
 
-static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
+static int fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 {
 	struct btrfs_root *root = sctx->send_root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -4804,21 +4804,13 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 	pgoff_t index = offset >> PAGE_SHIFT;
 	pgoff_t last_index;
 	unsigned pg_offset = offset_in_page(offset);
-	ssize_t ret = 0;
+	int ret = 0;
+	size_t read = 0;
 
 	inode = btrfs_iget(fs_info->sb, sctx->cur_ino, root);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	if (offset + len > i_size_read(inode)) {
-		if (offset > i_size_read(inode))
-			len = 0;
-		else
-			len = offset - i_size_read(inode);
-	}
-	if (len == 0)
-		goto out;
-
 	last_index = (offset + len - 1) >> PAGE_SHIFT;
 
 	/* initial readahead */
@@ -4859,16 +4851,15 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 		}
 
 		addr = kmap(page);
-		memcpy(sctx->read_buf + ret, addr + pg_offset, cur_len);
+		memcpy(sctx->read_buf + read, addr + pg_offset, cur_len);
 		kunmap(page);
 		unlock_page(page);
 		put_page(page);
 		index++;
 		pg_offset = 0;
 		len -= cur_len;
-		ret += cur_len;
+		read += cur_len;
 	}
-out:
 	iput(inode);
 	return ret;
 }
@@ -4882,7 +4873,6 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret = 0;
 	struct fs_path *p;
-	ssize_t num_read = 0;
 
 	p = fs_path_alloc();
 	if (!p)
@@ -4890,12 +4880,9 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 
 	btrfs_debug(fs_info, "send_write offset=%llu, len=%d", offset, len);
 
-	num_read = fill_read_buf(sctx, offset, len);
-	if (num_read <= 0) {
-		if (num_read < 0)
-			ret = num_read;
+	ret = fill_read_buf(sctx, offset, len);
+	if (ret < 0)
 		goto out;
-	}
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_WRITE);
 	if (ret < 0)
@@ -4907,16 +4894,14 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
-	TLV_PUT(sctx, BTRFS_SEND_A_DATA, sctx->read_buf, num_read);
+	TLV_PUT(sctx, BTRFS_SEND_A_DATA, sctx->read_buf, len);
 
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
 out:
 	fs_path_free(p);
-	if (ret < 0)
-		return ret;
-	return num_read;
+	return ret;
 }
 
 /*
@@ -5095,9 +5080,7 @@ static int send_extent_data(struct send_ctx *sctx,
 		ret = send_write(sctx, offset + sent, size);
 		if (ret < 0)
 			return ret;
-		if (!ret)
-			break;
-		sent += ret;
+		sent += size;
 	}
 	return 0;
 }
-- 
2.28.0

