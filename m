Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C536E3FE0D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345734AbhIARDC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345715AbhIARC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:02:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3DCC061760
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Sep 2021 10:02:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s11so43455pgr.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Sep 2021 10:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyXX59s/SGELHPoRdfFjeP91X6Yzyo8UXkBTECdael0=;
        b=hwIsov2Yc0W9V/rlOPOPEgx69CNYrLreW56eYt1Y/Hyn1SYBoj4EtVzQweqRwZ+DE1
         ldBOBgFZ9lw/hsXZ4Nn9CP4j4jWdaqhY4o8mRTSxDnmWAiJkHkQqyyORsRjDseEKmbsI
         /DtnlaZ7y2ZDGQSGDFdgnPhyDwv5yEd4DHG24t+qvuPKzr/WrsAjsZjm7yGVMIg3Lhv5
         4MrU6lrrFBL5Cz8Q9kV1xOny4R7fnNdu8xqjq7ur2fV4gEnsYZkpiN0dHFmXYQ7f/Rkk
         NHSR6uXL7Dlrj/t9CCKiJ0v/1fGh/mWb9pHlRWufo9ve93hAtfhgM5Sbq1mffAuTDg8f
         louw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyXX59s/SGELHPoRdfFjeP91X6Yzyo8UXkBTECdael0=;
        b=VtVcfoxuOEChiUI9ln12cBZEQv02dFXKNB91Fj+cpjlbXfJDsfAEDG6+yLqJ+i8MwR
         6kOQhrYD6hccHyTQMKnZwv9M3DXDnPaDeh9kFgi1lij/QtgEE2bNgIpINpdrwaci8pPa
         JD3eWAwVLuAB1W6qTgfiCztO7xlC1NeWor535vyj0bGUtukKVOY56BUpOU6ZTTWyfyUv
         t5XMv8ZrfJYhpnJ8whhgdNJ6sAfWkWPvMLysUfILEi8anltmQkWFccxx0VKMJ38Sd7aX
         UzOtGf+RVbbIaw0eq6BQHu+oWlYFr2RTvm/jkimGS9OiyTB0R9PDRUmTDfVYvKc/RD1B
         6ycw==
X-Gm-Message-State: AOAM532CoV+P7MRp8fDn/r7q0LvZjNsUMssyBYJmGTCpI/5Jd+74MvzY
        mt3gnPRYEdIHjzlyUUxoLPK4AlYrvT9FxQ==
X-Google-Smtp-Source: ABdhPJxUpJ6t7PADziHTL/aVVaLmFPL55vSJScJRp23J/MAIr/yWrK+y0e9K5oYC/35HcH1i5hSqpQ==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id j11-20020a62e90b0000b029030e45308dcamr370332pfh.17.1630515721092;
        Wed, 01 Sep 2021 10:02:01 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:02:00 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 08/10] btrfs-progs: receive: process setflags ioctl commands
Date:   Wed,  1 Sep 2021 10:01:17 -0700
Message-Id: <45b2c23b6ed4fb3d6e9e9f3fbe4d6a245df3a612.1630515568.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
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
index 953d7217..f5060117 100644
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
2.33.0

