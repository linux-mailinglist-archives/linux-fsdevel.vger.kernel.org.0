Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285CC33DE03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240674AbhCPTqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbhCPTpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:45:06 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE64C0613E4
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:46 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so4108644pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wge42oy0DQ6NR7o79fLXvBmuilouGkgkiyMUSGJksCk=;
        b=yh5kyUAgt/XzkRvSLUngbm+49zedTzhVfIqb9E/l2FoBTv+IGejH/DM/u6CSYb5irq
         oziGF0qdK/pF7gh4rh1xbBdaLc11o6ck46mUbzZ6MKn3DVl4B7h7IqEmIv8HzNYQ4pAz
         FZP5Ao5YxrUT9dG/+F1/9bsAB3+N4Ba+C2FpbStzEo+ap6YuwPZE9JcSPBnrRHD1vTyd
         24qh5cOh9Nk0QGRcy1eF3tPo8GbmUAX7kArqSNXsCUhVpe/LBlE4cDlUG9nYSwwolCBv
         q9wBhTN7PzcoIndiZEffhz334cAziwNvARleiswB0evP9EoGTnKd51leD+oVCa5BBiSf
         jJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wge42oy0DQ6NR7o79fLXvBmuilouGkgkiyMUSGJksCk=;
        b=SqVYz3Em9zPLP8XuAjlHCCff3gC1cLbaRzyHDyokK3L8CKBmhv867JfG07Kci89s5z
         1264YUptXlnQ6GOk9+AgHetm/lf0TQeJ+mfKoCQpB1wVq9RxikbGtGJhOOXjzjMgAEEy
         iXUB/ToKDXeHjlENbUHMPk6a87RND/+R6sm8fI+f5wKhBsygIdz+dYNEJ1aIYWpcZ5oJ
         ZNGysr5zNKaubb6rSYL2YO3GAiQfzUEjj5IM4iV7q6ZN91JAh2M7nwzRoo17dlNAPBWv
         xuL9/5eBetgytqgI5xfiKKTXwAtpXdgsIGc7Gl2OhCAdYDrorE9VjpgaV+jj3+cj6q7K
         yacw==
X-Gm-Message-State: AOAM5300x72BDpimGvsMgr1zUn2D1AXiwUq/yg1BQ31qt4cnV5AWJoJI
        h/OElr7k6/DfODielEUtkCmPpw==
X-Google-Smtp-Source: ABdhPJwv2xuBFNcCxrY/DI9K/OQyCvg0WLQg1qiCLzeS7ufzXwOWb7okENo5JC/ZISaFGOXYSAy8rA==
X-Received: by 2002:a17:902:e74e:b029:e5:bde4:2b80 with SMTP id p14-20020a170902e74eb02900e5bde42b80mr967896plf.44.1615923885902;
        Tue, 16 Mar 2021 12:44:45 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id w22sm16919104pfi.133.2021.03.16.12.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:44:45 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 08/11] btrfs-progs: receive: process fallocate commands
Date:   Tue, 16 Mar 2021 12:44:02 -0700
Message-Id: <b86c55da3e62e3253884a2aeb8575fd4feebe4ef.1615922859.git.osandov@osandov.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922753.git.osandov@fb.com>
References: <cover.1615922753.git.osandov@fb.com>
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
index f0236f50..9103dabb 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1312,6 +1312,30 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
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
@@ -1335,6 +1359,7 @@ static struct btrfs_send_ops send_ops = {
 	.utimes = process_utimes,
 	.update_extent = process_update_extent,
 	.encoded_write = process_encoded_write,
+	.fallocate = process_fallocate,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index 044e101b..bc41396e 100644
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
2.30.2

