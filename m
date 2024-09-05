Return-Path: <linux-fsdevel+bounces-28770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B296E153
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532851C23775
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80954315D;
	Thu,  5 Sep 2024 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUjtE9KZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9DF1C2E
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725558374; cv=none; b=f0eX9hxYZQZ97il16SR8ydYkxSAABqCbJqber4sJJ4cO+l16F/6xPXSFLGK4+QEXexqnuhIdKU+9eC0uXJhQ1OD6L8VXpPf8igdU0GaSziYkA1xxo71HNernKhDP3tJBWSxJ/6ysLtcVkU/GO2d8WDXrhaNz4AZpeZDXHyCt9Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725558374; c=relaxed/simple;
	bh=bFjl/xS0VXt3NhNjqiWWhFd0Bp2MxdEBaTZXdfi8Hlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ui37QzvIo/TpPmFtTP2R9v/FAYCBYTMbdOcaduIIQKmea0Yf+LSXLSZVJNhSN9knzadoPer4dvvaSJI8oUB0ZZHnF32UVa5KF+J4p2uCREVX8nRn0AfVolscp9EeoF19NH3i34ujsbU9rsmvxBHTvBlf7ua/umMuLGRtnpVr7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUjtE9KZ; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e026a2238d8so1143645276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Sep 2024 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725558371; x=1726163171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c4R+P/kIseeUV8zyn+elml3vf9PTAwWkool/9LfBfTw=;
        b=HUjtE9KZD4/bVHnLAba3VOglVzhiLOODEN6fww6eRh4flF/IddD6y90j/omqk2mlXz
         yX+qVErsIhOlQhpLNKVSgcoSYUz3YAHGZA/lHytB3GVJaeXkfIGnPTvX5iMMD+15XyhJ
         qYrI5GeXRmeMNIVG/YnMa2yykh1eQ7v+SBwEm/g3EpaDKz7lnFUJc0+F0K7XwaMst2QV
         7Xqzb1vT7uTvthIw4anKBLIISllPPwCXGBlbDy6jAsn8vLF8mv/mmKPLMT9JiLxqlC2L
         N450EgwJnAjctB9nx/U6bAT+rkfS64pBTs0KwzO1RFDFCxNwtl7lvXmtrqBzMP7IOY+9
         D35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725558371; x=1726163171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4R+P/kIseeUV8zyn+elml3vf9PTAwWkool/9LfBfTw=;
        b=tEhARCDK7Q1TJeG32fgxfuEvtRaQZRzRYa0lRWIGsP4O2J/D0h2zDgtM4eW+fy9c66
         CYh5RYsvE6IGz/GFfsrlb2sZq9rgp/L7OMYllgPPgi/cSR8mBmAzdJqg0SUaTSvTuIIM
         1IJYmjW676HVsUke5MfZ3B3xqw03NcYAtyXqUTCurJ1PDb/+IaNsrwQIumX9FXHFaexs
         Y67BZ1NFkTUD1T34m6IuKsgpIPw+oBFuv44JuoEvloP2W2wjiLietCo0U+mA+L5O87e1
         tU8K+BE5Bzd3x/QztZTNyPEua04blBN8gbcTgpZjkZ4ANno9Zmd1VJkgJqHM47Hycz0Z
         jXag==
X-Forwarded-Encrypted: i=1; AJvYcCWEtMQbWcjNvq5ysXmDZVs/pm2iWHDhPsYoAig89aoII5yyeLfyMuI2oTnlym08ZkPuspr/Tkt2ggHk0MBS@vger.kernel.org
X-Gm-Message-State: AOJu0YyMc2YLSWn3WT1FdyokRSucl5/Lt/fB5peOicXg1UHw26i+PwqI
	o1zFs3QwJldkXZTygVvOaeXwG9S5CZSxP9MOQOzmN72Y8qJz2Sbr
X-Google-Smtp-Source: AGHT+IH6tVMBHUcareANjwKQMXcukblBzYtMNJmRMrmiu9uFYodJCMnd6HWU6p9HU4mATF2TfZnybw==
X-Received: by 2002:a05:6902:f82:b0:e1d:150c:18e4 with SMTP id 3f1490d57ef6-e1d3488d69bmr19602276.19.1725558371211;
        Thu, 05 Sep 2024 10:46:11 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a6266f406sm3071576276.23.2024.09.05.10.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 10:46:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	sweettea-kernel@dorminy.me,
	kernel-team@meta.com
Subject: [PATCH v2 RESEND] fuse: Enable dynamic configuration of fuse max pages limit (FUSE_MAX_MAX_PAGES)
Date: Thu,  5 Sep 2024 10:45:41 -0700
Message-ID: <20240905174541.392785-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the capability to dynamically configure the fuse max pages
limit (formerly #defined as FUSE_MAX_MAX_PAGES) through a sysctl.
This enhancement allows system administrators to adjust the value
based on system-specific requirements.

This removes the previous static limit of 256 max pages, which limits
the max write size of a request to 1 MiB (on 4096 pagesize systems).
Having the ability to up the max write size beyond 1 MiB allows for the
perf improvements detailed in this thread [1].

$ sysctl -a | grep max_pages_limit
fs.fuse.max_pages_limit = 256

$ sysctl -n fs.fuse.max_pages_limit
256

$ echo 1024 | sudo tee /proc/sys/fs/fuse/max_pages_limit
1024

$ sysctl -n fs.fuse.max_pages_limit
1024

$ echo 65536 | sudo tee /proc/sys/fs/fuse/max_pages_limit
tee: /proc/sys/fs/fuse/max_pages_limit: Invalid argument

$ echo 0 | sudo tee /proc/sys/fs/fuse/max_pages_limit
tee: /proc/sys/fs/fuse/max_pages_limit: Invalid argument

$ echo 65535 | sudo tee /proc/sys/fs/fuse/max_pages_limit
65535

$ sysctl -n fs.fuse.max_pages_limit
65535

v2 (original):
https://lore.kernel.org/linux-fsdevel/20240702014627.4068146-1-joannelkoong@gmail.com/

v1:
https://lore.kernel.org/linux-fsdevel/20240628001355.243805-1-joannelkoong@gmail.com/

Changes from v1:
- Rename fuse_max_max_pages to fuse_max_pages_limit internally
- Rename /proc/sys/fs/fuse/fuse_max_max_pages to
  /proc/sys/fs/fuse/max_pages_limit
- Restrict fuse max_pages_limit sysctl values to between 1 and 65535
  (inclusive)

[1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#u

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 10 +++++++
 fs/fuse/Makefile                        |  2 +-
 fs/fuse/fuse_i.h                        | 14 +++++++--
 fs/fuse/inode.c                         | 11 ++++++-
 fs/fuse/ioctl.c                         |  4 ++-
 fs/fuse/sysctl.c                        | 40 +++++++++++++++++++++++++
 6 files changed, 75 insertions(+), 6 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 47499a1742bd..fa25d7e718b3 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -332,3 +332,13 @@ Each "watch" costs roughly 90 bytes on a 32-bit kernel, and roughly 160 bytes
 on a 64-bit one.
 The current default value for ``max_user_watches`` is 4% of the
 available low memory, divided by the "watch" cost in bytes.
+
+5. /proc/sys/fs/fuse - Configuration options for FUSE filesystems
+=====================================================================
+
+This directory contains the following configuration options for FUSE
+filesystems:
+
+``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
+setting/getting the maximum number of pages that can be used for servicing
+requests in FUSE.
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 6e0228c6d0cb..cd4ef3e08ebf 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
-fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
+fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o sysctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f23919610313..bb252a3ea37b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -35,9 +35,6 @@
 /** Default max number of pages that can be used in a single read request */
 #define FUSE_DEFAULT_MAX_PAGES_PER_REQ 32
 
-/** Maximum of max_pages received in init_out */
-#define FUSE_MAX_MAX_PAGES 256
-
 /** Bias for fi->writectr, meaning new writepages must not be sent */
 #define FUSE_NOWRITE INT_MIN
 
@@ -47,6 +44,9 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/** Maximum of max_pages received in init_out */
+extern unsigned int fuse_max_pages_limit;
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
@@ -1472,4 +1472,12 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 				      size_t len, unsigned int flags);
 ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
 
+#ifdef CONFIG_SYSCTL
+extern int fuse_sysctl_register(void);
+extern void fuse_sysctl_unregister(void);
+#else
+#define fuse_sysctl_register()		(0)
+#define fuse_sysctl_unregister()	do { } while (0)
+#endif /* CONFIG_SYSCTL */
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 99e44ea7d875..973e58df816a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -35,6 +35,8 @@ DEFINE_MUTEX(fuse_mutex);
 
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
+unsigned int fuse_max_pages_limit = 256;
+
 unsigned max_user_bgreq;
 module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
 		  &max_user_bgreq, 0644);
@@ -932,7 +934,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
-	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
+	fc->max_pages_limit = fuse_max_pages_limit;
 
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_files_init(fc);
@@ -2039,8 +2041,14 @@ static int __init fuse_fs_init(void)
 	if (err)
 		goto out3;
 
+	err = fuse_sysctl_register();
+	if (err)
+		goto out4;
+
 	return 0;
 
+ out4:
+	unregister_filesystem(&fuse_fs_type);
  out3:
 	unregister_fuseblk();
  out2:
@@ -2053,6 +2061,7 @@ static void fuse_fs_cleanup(void)
 {
 	unregister_filesystem(&fuse_fs_type);
 	unregister_fuseblk();
+	fuse_sysctl_unregister();
 
 	/*
 	 * Make sure all delayed rcu free inodes are flushed before we
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 572ce8a82ceb..a6c8ee551635 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -10,6 +10,8 @@
 #include <linux/fileattr.h>
 #include <linux/fsverity.h>
 
+#define FUSE_VERITY_ENABLE_ARG_MAX_PAGES 256
+
 static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *args,
 			       struct fuse_ioctl_out *outarg)
 {
@@ -140,7 +142,7 @@ static int fuse_setup_enable_verity(unsigned long arg, struct iovec *iov,
 {
 	struct fsverity_enable_arg enable;
 	struct fsverity_enable_arg __user *uarg = (void __user *)arg;
-	const __u32 max_buffer_len = FUSE_MAX_MAX_PAGES * PAGE_SIZE;
+	const __u32 max_buffer_len = FUSE_VERITY_ENABLE_ARG_MAX_PAGES * PAGE_SIZE;
 
 	if (copy_from_user(&enable, uarg, sizeof(enable)))
 		return -EFAULT;
diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
new file mode 100644
index 000000000000..b272bb333005
--- /dev/null
+++ b/fs/fuse/sysctl.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/fs/fuse/fuse_sysctl.c
+ *
+ * Sysctl interface to fuse parameters
+ */
+#include <linux/sysctl.h>
+
+#include "fuse_i.h"
+
+static struct ctl_table_header *fuse_table_header;
+
+/* Bound by fuse_init_out max_pages, which is a u16 */
+static unsigned int sysctl_fuse_max_pages_limit = 65535;
+
+static struct ctl_table fuse_sysctl_table[] = {
+	{
+		.procname	= "max_pages_limit",
+		.data		= &fuse_max_pages_limit,
+		.maxlen		= sizeof(fuse_max_pages_limit),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= &sysctl_fuse_max_pages_limit,
+	},
+};
+
+int fuse_sysctl_register(void)
+{
+	fuse_table_header = register_sysctl("fs/fuse", fuse_sysctl_table);
+	if (!fuse_table_header)
+		return -ENOMEM;
+	return 0;
+}
+
+void fuse_sysctl_unregister(void)
+{
+	unregister_sysctl_table(fuse_table_header);
+	fuse_table_header = NULL;
+}
-- 
2.43.5


