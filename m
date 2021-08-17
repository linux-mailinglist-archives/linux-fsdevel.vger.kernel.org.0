Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5393EF49D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 23:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhHQVIc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 17:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhHQVIV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 17:08:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E4C0617AE
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mq3so1176309pjb.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GL7kTQRpdfv05EOFJFMTZLDfqqVbitIBD8BnDOwV+Yg=;
        b=uQhretdNSYH7JRd2blU4dJjPz4go/K2/BH+I1A/j+pTeQTPcfBsI2wdIzzyF83imE7
         G/TOBnz1bP1MYD77+HDsV/72EXbSgEdcijymh2wLYoOsJIh3T+FDSaOqny1m/JsjfP6z
         iPTJCyvGCR373bvb1PGQelGtrXgqLToRO+mg/DhFHtfDNmxM46SPjsN+kLXVP49x8qQ8
         TbJvVtJ04QKJd1Qz4mTx9xTLvC6bGps/EEA/ZJdSVWPQuppnajoWd0i4vMMGVui0DMp/
         FJ6VEi9OJo6TlzR8IQvyHMO6C4UNnIyXJoIEBgq+BFJzT+TaY5eRu8TlGzLjRJeRbbkR
         zy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GL7kTQRpdfv05EOFJFMTZLDfqqVbitIBD8BnDOwV+Yg=;
        b=siVnpSz7mQXX8HarTVwv/PiwP89XqJXCPrXxb8IfkDUEJ6kk9ZnP+Y3QDusPgvj18K
         Z5LFFHbD8FMKdLGJ8QhCwiR+KeZKR0/DWYV2v0UW9HzHsvuQ2Y5E5V8BRJrC9gUOi2BL
         eNs5it49GifCqunnZqElQWqEOHeb3THPxDkOZn28zQTqUaTo1lWKcspG/NjYIRbAKq2E
         jKgB26cevTWV/tw9STA90aFWSSCgRnmnOlCrsvXMFNbq2QNAB79mkm5GLP8Q6ng9ldje
         tYvobbk0v49EzTS43qBbfNwXGHbCatWOGs8kf/CoR1NsGWjmrMF8GYCGEtLM33P9tKgY
         f+hw==
X-Gm-Message-State: AOAM532qlCHVBibKyKfocX5vETrAHref6ZNjsk+aAU3Yqy2d8/ovJFtb
        xdvuh5YSizArLHfgbOAm5EXb8w==
X-Google-Smtp-Source: ABdhPJwmQbe4h8ISmpqkmF12Z5k0TvnfLoMpXpR1ZfpWyC+ZhGlFgFDhdDwLxIFkDFOmuPpp0+eBwg==
X-Received: by 2002:a17:90a:bc84:: with SMTP id x4mr5623491pjr.36.1629234466432;
        Tue, 17 Aug 2021 14:07:46 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:45 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 08/10] btrfs-progs: receive: process setflags ioctl commands
Date:   Tue, 17 Aug 2021 14:06:54 -0700
Message-Id: <2ba15dceb2b4bd52e63f558f92b9483a958087c6.1629234282.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
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
 cmds/receive.c       | 25 +++++++++++++++++++++++++
 common/send-stream.c |  7 +++++++
 common/send-stream.h |  1 +
 4 files changed, 39 insertions(+)

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
index dd27af95..255e138c 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -38,6 +38,7 @@
 #include <sys/types.h>
 #include <sys/uio.h>
 #include <sys/xattr.h>
+#include <linux/fs.h>
 #include <uuid/uuid.h>
 
 #include <lzo/lzo1x.h>
@@ -1288,6 +1289,29 @@ static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
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
+	ret = open_inode_for_write(rctx, full_path);
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
@@ -1312,6 +1336,7 @@ static struct btrfs_send_ops send_ops = {
 	.update_extent = process_update_extent,
 	.encoded_write = process_encoded_write,
 	.fallocate = process_fallocate,
+	.setflags = process_setflags,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index bc41396e..b9d35a34 100644
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
2.32.0

