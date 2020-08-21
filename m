Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45AE24CFAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 09:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgHUHlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 03:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgHUHkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:40:52 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A59C06134A
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:51 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f5so510022plr.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=imB0DQxAT8UunMGY6iRGaYrAjtodauS9bVt6p7lUxh8=;
        b=qEZIapEtUSXCOYAjJh9pfNtL2V5UP/ULp/F1qG8YiJdY62JXcBc9vIBxI4tSFJEh5I
         4nKw60kl556qYa3kE+L3GNho9GVg3XmPF8PcVBfFoiymS5pjI8GFPfyQ7nzQdoUsPxah
         KdC2WKm957IO1O+KzD0PGnuf2jSvuk2TLRQlRFgo/167LLjp4DQZQlImVZK38o4xpd9z
         zDWsQiNnxdpgO0qijN51OJ/a++/HzQrZkZAvzoAgWlRuZFxoVRPgu/xzWQZ9bdTljC7S
         zTE/g6dAEGg8sxc2uKSye0vN+i9vyrw2yb9CjB2Sv8mdNfrHX3TY1OrxdgthFlF5F861
         dVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=imB0DQxAT8UunMGY6iRGaYrAjtodauS9bVt6p7lUxh8=;
        b=nK/oyqshGKbaiO9yGX3SkaShCWiKBhST9Hp+08/zBBgPF/VQKrMncjfzlVvfE27vZ/
         qLHR5tOVtq+RSpt9RDkDfXDMiYlZ0Rb9xjHBtOF/vLVlFp5i4JUzu/ecizjE8g0+YViR
         CCJlEPfBFypfAUAkr5HH3IL7KPUO21Yq0EPv295BI9foNSJJGjaFCDdhNjsPzoW43eok
         SPvJDQtp1/wdUxIQoIAvUssvidjePW1VGo+b6/AA52Wpjk5BRlV4M3JJF5MZRYxWbpOI
         yaPvQR8mzLQRCQq5MObjNgxncwgH9Tq8acj4LidyUT3Nsm3EJA+lcbT/n7/rAJIV2EHe
         v0KA==
X-Gm-Message-State: AOAM531mMZpHDKqWqC2J++4xasq7Zg8BfxUBDHL6axbkdNwPkLkFeifY
        exj20R0TtpGxEvsEph9AjS26lg==
X-Google-Smtp-Source: ABdhPJyc/afzXaSJriTeoXao7RoNflEWnzbYOs3q8ATN+UmcRjuyXEnIaiZrqdNCqgL+nyNV36CRCA==
X-Received: by 2002:a17:90b:18b:: with SMTP id t11mr1422021pjs.105.1597995651357;
        Fri, 21 Aug 2020 00:40:51 -0700 (PDT)
Received: from exodia.tfbnw.net ([2620:10d:c090:400::5:f2a4])
        by smtp.gmail.com with ESMTPSA id jb1sm1080875pjb.9.2020.08.21.00.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:40:49 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/11] btrfs-progs: receive: process fallocate commands
Date:   Fri, 21 Aug 2020 00:40:07 -0700
Message-Id: <1957f12abea48a115fb27e62f7c7fc93976e80d3.1597994354.git.osandov@osandov.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597994106.git.osandov@osandov.com>
References: <cover.1597994106.git.osandov@osandov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Send stream v2 can emit fallocate commands, so receive must support them
as well. The implementation simply passes along the arguments to the
syscall. Note that mode is encoded as a u32 in send stream but fallocate
takes an int, so there is a unsigned->signed conversion there.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  |  9 +++++++++
 cmds/receive.c       | 26 ++++++++++++++++++++++++++
 common/send-stream.c |  9 +++++++++
 common/send-stream.h |  2 ++
 4 files changed, 46 insertions(+)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 20ec2b70..acc0ba32 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -329,6 +329,14 @@ static int print_encoded_write(const char *path, const void *data, u64 offset,
 			  unencoded_offset, compression, encryption);
 }
 
+static int print_fallocate(const char *path, int mode, u64 offset, u64 len,
+			   void *user)
+{
+	return PRINT_DUMP(user, path, "fallocate",
+			  "mode=%d offset=%llu len=%llu",
+			  mode, offset, len);
+}
+
 struct btrfs_send_ops btrfs_print_send_ops = {
 	.subvol = print_subvol,
 	.snapshot = print_snapshot,
@@ -352,4 +360,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.utimes = print_utimes,
 	.update_extent = print_update_extent,
 	.encoded_write = print_encoded_write,
+	.fallocate = print_fallocate,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index c67d4653..5c0930cb 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1356,6 +1356,31 @@ out:
 	return ret;
 }
 
+static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
+			     void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("fallocate: path invalid: %s", path);
+		goto out;
+	}
+	ret = open_inode_for_write(rctx, full_path, false);
+	if (ret < 0)
+		goto out;
+	ret = fallocate(rctx->write_fd, mode, offset, len);
+	if (ret < 0) {
+		ret = -errno;
+		error("fallocate: fallocate on %s failed: %m", path);
+		goto out;
+	}
+out:
+	return ret;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1379,6 +1404,7 @@ static struct btrfs_send_ops send_ops = {
 	.utimes = process_utimes,
 	.update_extent = process_update_extent,
 	.encoded_write = process_encoded_write,
+	.fallocate = process_fallocate,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index 1376e00b..d455cdfb 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -369,6 +369,7 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	u64 unencoded_offset;
 	int len;
 	int xattr_len;
+	int fallocate_mode;
 
 	ret = read_cmd(sctx);
 	if (ret)
@@ -514,6 +515,14 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	case BTRFS_SEND_C_END:
 		ret = 1;
 		break;
+	case BTRFS_SEND_C_FALLOCATE:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, &fallocate_mode);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, &offset);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_SIZE, &tmp);
+		ret = sctx->ops->fallocate(path, fallocate_mode, offset, tmp,
+					   sctx->user);
+		break;
 	}
 
 tlv_get_failed:
diff --git a/common/send-stream.h b/common/send-stream.h
index 607bc007..a58739bb 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -70,6 +70,8 @@ struct btrfs_send_ops {
 			     u64 len, u64 unencoded_file_len, u64 unencoded_len,
 			     u64 unencoded_offset, u32 compression,
 			     u32 encryption, void *user);
+	int (*fallocate)(const char *path, int mode, u64 offset, u64 len,
+			 void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
-- 
2.28.0

