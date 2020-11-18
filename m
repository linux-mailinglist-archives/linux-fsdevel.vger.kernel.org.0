Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF82B84CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 20:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgKRTTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 14:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgKRTTl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:19:41 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A9FC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:41 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so2068843pfu.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 11:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3j6zZr0VDMJvc7zZVcwrRVz+yGAYinHXHs1QBoNG4M=;
        b=yrvZIKPZURujIFP5Vio+JkFgfLuiFrd6IC2/KC0DAKghdLiaqSAXvFG9Dw96eg0IpQ
         U5rjt9W9lz2AkcBEFS8Ab6Euy/SWTtRYRPJb8OsfF3zOg0QD+pBao9NOBcTwI8ZZdljO
         uY2g0IaXfVk62dwcTpK7uZX2m+lBtjqRxI71QTPhMWrigsBzEJe0EKQILrVB6grrFOnm
         7x458/pZCZ/bHxA5h6pjBNrzsTo5pOMJaDmmEw2U8qAXVhFEo8P6fhOLMFNOsuISFTTv
         eWHrrCH6zKfHYV6B+o//rJVn0Ch7v9Ce3rD9yovGPDuqCTueC0BP7o2MrVGAB5fMSY45
         ctWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3j6zZr0VDMJvc7zZVcwrRVz+yGAYinHXHs1QBoNG4M=;
        b=kGHDdC8gL+elWnmKZ/73mmy2i1asu42oG7h+l5ilt0pS4SMEwQFjSsGReq3m5sWvoA
         gyN4GImg4DQ8PRDj1RSHM5vwvKxp3nhpHUIzeVuQ8aQj1wGvcp44EG1szYWHzLfRz5Eo
         VbLPjHGbrTljDYEp51AcDervuvPKZshxG4QYEIf8TWaJLdH5zsKhkaGIKUTLbDyIRXAd
         vfQHqcN+3ZxrjvUA6R7oiGhPGOz8foN+r4zkMUBFhUdgKiJGjRVMW3xvVSmHugQWWAg7
         gKL6TMZdBbLYP/yJG33cbbGcfthVBpFtHEMKbglTpXoJXRNjEqzY3SRDO/Zqn+2DEtN8
         iVUg==
X-Gm-Message-State: AOAM533LiLucrvYTJIV4LvOQUGLZu5zqVW+OoTwzhtRZLJ1HgzFV1v1v
        4ZgK2ARJQjYq/7iAAKPiq0A9Sw==
X-Google-Smtp-Source: ABdhPJwTZa7tfZEaS8Ag0NQtDtafbzxzHuL/EumP+kMYVnhhH9fW02xHaqmCMvVWjSBDKP9VAIDR1g==
X-Received: by 2002:a17:90b:705:: with SMTP id s5mr547489pjz.22.1605727181145;
        Wed, 18 Nov 2020 11:19:41 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:8b43])
        by smtp.gmail.com with ESMTPSA id l9sm3197221pjy.10.2020.11.18.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 11:19:39 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/13] btrfs-progs: receive: process fallocate commands
Date:   Wed, 18 Nov 2020 11:18:57 -0800
Message-Id: <b901e5ae1aaad6082d067c411d4b8fd1f567dd73.1605723745.git.osandov@osandov.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605723600.git.osandov@fb.com>
References: <cover.1605723600.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 cmds/receive.c       | 25 +++++++++++++++++++++++++
 common/send-stream.c |  9 +++++++++
 common/send-stream.h |  2 ++
 4 files changed, 45 insertions(+)

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
index 361c7c8a..ca9c3f5a 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1357,6 +1357,30 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 				    compression);
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
+		return ret;
+	}
+	ret = open_inode_for_write(rctx, full_path, false);
+	if (ret < 0)
+		return ret;
+	ret = fallocate(rctx->write_fd, mode, offset, len);
+	if (ret < 0) {
+		ret = -errno;
+		error("fallocate: fallocate on %s failed: %m", path);
+		return ret;
+	}
+	return 0;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1380,6 +1404,7 @@ static struct btrfs_send_ops send_ops = {
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
2.29.2

