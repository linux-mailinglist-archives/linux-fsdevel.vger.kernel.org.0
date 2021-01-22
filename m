Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7E5300E8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbhAVVIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 16:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730019AbhAVUxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:53:41 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64672C0698D8
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g3so3990066plp.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2V7g1H6LWShDD9huCMdhWXiMVqXne9qhiCCqnAMGfVE=;
        b=RFFVc0gv23H7tNtzOih2yo54XHbJAhM+LhAQMJiZxb4RtknuEsAiQzDkqJjfYeCeQb
         F45JbM/gnO2xIUl0DijvaKCI/S1SoGkYpPSMkg+YraQxJTeJMJsh2pWQzrPZUJv9Ziws
         SYI4oLk9amhIJ8uEGhLFwdaNGbEkV4kPqrvRPxNfYVq5CROoXFmXNu6FjoZaeChHL/wI
         da4GWbOTLBtYoa/0In5kRYx1NeCjLGE8uAbpdWarzZyTCdev7FSbakrFrUfzbWUqSaVP
         zYLKZXvjapo3vs/GR/hVEt52meNQANu8crc9WaZMUhrbDy6pQ6lu8UkQedtGBGoBznIM
         B77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2V7g1H6LWShDD9huCMdhWXiMVqXne9qhiCCqnAMGfVE=;
        b=BPFHCSMDqC7MIJG8OtWbLHywNSqWsK6FnQ+dEUY892jfYabI2S5SuglEBKqz89Oavx
         RxM1G5LnZlb4MIX5xkkI52IszDgzQZ7eWNQhll+EivdabO9679NOIKaIfydDoPk3I0Z5
         NQOnNMU4qUjklYZXaW4ZdKtMBMHDmGwn4HWDeASwNFmvV6flglouFXuE95P04hZT3bBa
         oqrRU8DDTOsyMEZzW+nBOFv7wONehqsackmSGpMTiUsrHZOtpZouuBpa0qqv/uVGSkm1
         yOzqPeU/xSHY2BM+5MRaAlN3dK9PcvWvlni/PgyLRGnGwY69W26N9/wNaVAdZVOmoRa9
         eTdg==
X-Gm-Message-State: AOAM530Gnv0NcFmUThR1PBZ4F5/A7pjmgrwtWWpoAsdB5YQjek9AcFgP
        Wb/NTj69Q1gxYoofSQ+B4U1ihg==
X-Google-Smtp-Source: ABdhPJyJS3WtSZ6yrKaYkqFuHLAWZpvV6Ta81xPgOooBJZmLA+GD76qo9QHlZLDBb4PJKqpXEK+6ug==
X-Received: by 2002:a17:90a:e28c:: with SMTP id d12mr1193342pjz.236.1611348530976;
        Fri, 22 Jan 2021 12:48:50 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id y16sm9865617pfb.83.2021.01.22.12.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:48:49 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 09/11] btrfs-progs: receive: process setflags ioctl commands
Date:   Fri, 22 Jan 2021 12:47:56 -0800
Message-Id: <705ef1b18d866593e610e421e1c8558e93e87656.1611347859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611347187.git.osandov@fb.com>
References: <cover.1611347187.git.osandov@fb.com>
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
index 897da372..61d3cecb 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1377,6 +1377,29 @@ static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
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
@@ -1401,6 +1424,7 @@ static struct btrfs_send_ops send_ops = {
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
2.30.0

