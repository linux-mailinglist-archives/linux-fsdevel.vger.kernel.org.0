Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966CA2B84D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgKRTTo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgKRTTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:43 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D896AC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:43 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id j5so1531615plk.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMykUAF1jBHiR3hoO57Gb2atrtMf3A6zHbbf8nZiQAw=;
        b=ctJn0jyRQWnOpDMJwzJ+5wGIlsnQ3VJ3TXetiT77zEVZfeZInXDICwBHskcwPaagfw
         hVFzGIgVWpn/RmBRX3h+aVFw4RBIaLTXiMBWXUP0Pbb9VJttVxZuBwkUofvTQBbzVOgz
         Kct6Hqn5DOOCDvLZw1BEHq3M9yE8NW0PIpiunBFr4tWy31Zz/S5wczAJcdR2eHrNtyaB
         V3rR9mK5JV/NaVSjDhsX4Qki6XSsWcY3lY1WCPTrVuSxwqaEMbIxnBqRUAZCzUkWlIGs
         sDCcta50NGCyweNXAWog7CT4ioEj8vmkYsz98Y5K4Xn8bOj5F2rgUWIjojE5CAtLtt0o
         Mxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMykUAF1jBHiR3hoO57Gb2atrtMf3A6zHbbf8nZiQAw=;
        b=mmX4sRmzNfJB8RouAiv7jaonIXi2LiTqqmto/aaBX5KXi84oKQvcoPTsXk1mgptXdf
         JHAXHM4VKHKNNNW3JnvXwcPcCG0A70YM7PC2eg3RAa9pX3ZkKUnzmDao6y6IYSPOIl6G
         0oGrVycSp53MaSTfuj/gtfMJnkuPpgpc96xAGwdIXQHv/YdkCUM5YfjuXolJDrRIioym
         rYJTCh5k/1Jgf1K9/ZIY4LjMXnPN/9r6neUVXUSyQ3sbG7sJnEMao0ABGyjN0yrbLT18
         6Irl840kYbOPyup1cXnQf9Sl50sG8lI5x7dxJzrMirCS+oDeyagJA9Ckd3YndwRBnpF6
         Mmxw==
X-Gm-Message-State: AOAM533CypetC8mYyq8KyaiwwqX6jKTbXOslK+h2gVZDNn3NgkqS3API
        uqWj3DMyY3XtAtcmGbL15FMXZ9oRy3HrTw==
X-Google-Smtp-Source: ABdhPJyjyV39XZbRXV15OJ4+YJbkxyshR9NPZsrXzqNxm89Fj2aeHfQnMcTtwS6DMunK8J7vfAGITQ==
X-Received: by 2002:a17:902:9b93:b029:d6:d0e3:10c6 with SMTP id y19-20020a1709029b93b02900d6d0e310c6mr5855545plp.41.1605727183352;
        Wed, 18 Nov 2020 11:19:43 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:42 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/13] btrfs-progs: receive: process setflags ioctl commands
Date:   Wed, 18 Nov 2020 11:18:58 -0800
Message-Id: <40b7cf2fb2602cc6029eb36c15eab361ac4e5340.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boris Burkov <boris@bur.io>

In send stream v2, send can emit a command for setting inode flags via
the setflags ioctl. Pass the flags attribute through to the ioctl call
in receive.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  |  6 ++++++
 cmds/receive.c       | 24 ++++++++++++++++++++++++
 common/send-stream.c |  7 +++++++
 common/send-stream.h |  1 +
 4 files changed, 38 insertions(+)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index acc0ba32..40f07ad4 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -337,6 +337,11 @@ static int print_fallocate(const char *path, int mode, u64 offset, u64 len,
 			  mode, offset, len);
 }
 
+static int print_setflags(const char *path, int flags, void *user)
+{
+	return PRINT_DUMP(user, path, "setflags", "flags=%d", flags);
+}
+
 struct btrfs_send_ops btrfs_print_send_ops = {
 	.subvol = print_subvol,
 	.snapshot = print_snapshot,
@@ -361,4 +366,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.update_extent = print_update_extent,
 	.encoded_write = print_encoded_write,
 	.fallocate = print_fallocate,
+	.setflags = print_setflags,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index ca9c3f5a..1863f881 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1381,6 +1381,29 @@ static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
 	return 0;
 }
 
+static int process_setflags(const char *path, int flags, void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("setflags: path invalid: %s", path);
+		return ret;
+	}
+	ret = open_inode_for_write(rctx, full_path, false);
+	if (ret < 0)
+		return ret;
+	ret = ioctl(rctx->write_fd, FS_IOC_SETFLAGS, &flags);
+	if (ret < 0) {
+		ret = -errno;
+		error("setflags: setflags ioctl on %s failed: %m", path);
+		return ret;
+	}
+	return 0;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1405,6 +1428,7 @@ static struct btrfs_send_ops send_ops = {
 	.update_extent = process_update_extent,
 	.encoded_write = process_encoded_write,
 	.fallocate = process_fallocate,
+	.setflags = process_setflags,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index d455cdfb..da0c0e5d 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -370,6 +370,7 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	int len;
 	int xattr_len;
 	int fallocate_mode;
+	int setflags_flags;
 
 	ret = read_cmd(sctx);
 	if (ret)
@@ -523,8 +524,14 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 		ret = sctx->ops->fallocate(path, fallocate_mode, offset, tmp,
 					   sctx->user);
 		break;
+	case BTRFS_SEND_C_SETFLAGS:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_U32(sctx, BTRFS_SEND_A_SETFLAGS_FLAGS, &setflags_flags);
+		ret = sctx->ops->setflags(path, setflags_flags, sctx->user);
+		break;
 	}
 
+
 tlv_get_failed:
 out:
 	free(path);
diff --git a/common/send-stream.h b/common/send-stream.h
index a58739bb..5373bf69 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -72,6 +72,7 @@ struct btrfs_send_ops {
 			     u32 encryption, void *user);
 	int (*fallocate)(const char *path, int mode, u64 offset, u64 len,
 			 void *user);
+	int (*setflags)(const char *path, int flags, void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
-- 
2.29.2

