Return-Path: <linux-fsdevel+bounces-22700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79BB91B340
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 02:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE68283341
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 00:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C61D17C2;
	Fri, 28 Jun 2024 00:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy/EnkFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78217CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533885; cv=none; b=JEF/SVamrKlO1kkJD5mMMOOT9ND6uNJoolPrjHb/QVhyTuTD10GgC6kpE0SduU9DawRNBDXJZp87vqMjvvexfCqc9GOZZLCEyfo+k7A1zqr9leZQ6Sm3bGPm2mxhEhfM8+J0ROnGz9DZEV+q/485dgGusws1ht92i6qDHZhwKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533885; c=relaxed/simple;
	bh=Jw0jD/tgRVQyUjNr4d2Zaa7FkY4X45EMV1YkXyaDe2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DL19Q3AeX4ECCqnQ4wfFSNACz73gFUZIrCjN0Fh43BZBshV9vXpk7AQ6h3yRsDt8sPGPmT/YOw5u+h1ztJEuhyHNrXpDhKw+c5scGbTuClh3T+mGhf8qTjYnwmpzyy/pEabAYIbiikI5Ay0INT2e2sfe0hu6ix4dESbAm5YRDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy/EnkFP; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-63036fa87dbso572797b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 17:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719533882; x=1720138682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtCVXouK0ecc2oaKjO7it0eUAWhlfIc3Mv7N5bEYISM=;
        b=Iy/EnkFP6Zo1laVtru5KH6wIyVRSH9XUfORtmMbpj/0CwqdYYcHT0zDO4tA1fyuohf
         vBeIaa3jz9MJaVpGi5Ww/vrwGiNBoq0QM9/5Uelrp0TAnrVxel3Qnu94eNQWFWiA4Q6l
         N0rlI/HWcvNkeUp31v/8l/Bj/sayG7aLjqsOxo2JZu/9laKUIo2f6pyXaTHSuLxxET72
         wPE6OCeO7UQdS3RIbPl/GPPs/bpxIdM8Zdy4CYwe3SQwhwx6L9rGd4LxcupfZj7MqsHv
         Zat9wzgtRUgZpQ8Cy3+avN0aRNk2UFgrBzFrgX3Zx5jYA7nlh0L71aFODLmJfx1GpYHs
         gTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719533882; x=1720138682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtCVXouK0ecc2oaKjO7it0eUAWhlfIc3Mv7N5bEYISM=;
        b=j13Bn+5yzNrYk9llZNsQlzZQomei5rcLvM+ps/JQg14jLHydY0fWk2mrJdIevFg6Sf
         xNeKxg36wAeTz/MXPDCVc/KpLPedqgiaVu3JjCHhZ1NhdY0x4TzttJbARZaQnIoM++j1
         va1dpAPtlcQoblYyB9+CAe8c0ULYvLL/m21P9ZVzYwHlW1tQzzNNg6rljR4I5pg69xkL
         sAJ0mVUQrj9aB64tGXjhGkts5GnvsVPrp5o+3TNrEavbF4Y/7HNisuC1WvgmsKfvksxR
         gfD4wKWX6Yr70/HLoZPJc6d+MmS3WX67V+qEWw/o8V8E/5eo3mg8v6yIz0poc7vu+wMn
         KJPA==
X-Forwarded-Encrypted: i=1; AJvYcCWfr9AXcAFH8MigXpm9GhP8sDNJjEW/+KkXCK0BwDbTzlAa8DCS8hom1bzvkWx76FGBZG8VAsLC1GQO0aCPfYKVGketJMpqypWJcFGl9A==
X-Gm-Message-State: AOJu0YyWEVjIN+zkl1mR5JX8GHqARpYIRSf/fXdp/owC4beM8K4yH3/G
	D+2ZFiH6V6eXRBxJuegIYQX0CgEwTM82WEyW2KKaWof99qOYG/fd
X-Google-Smtp-Source: AGHT+IHFFqtXOAcUcLiioJEiY3pjvYNQhKKJVlm+uZ/5zXP66JD10J4+R5W7A/OeAdTUYP3KE3a0JQ==
X-Received: by 2002:a81:a50c:0:b0:614:74f6:df18 with SMTP id 00721157ae682-64af4f65276mr794737b3.26.1719533882212;
        Thu, 27 Jun 2024 17:18:02 -0700 (PDT)
Received: from localhost (fwdproxy-nha-009.fbsv.net. [2a03:2880:25ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9a23c6dcsm1472987b3.55.2024.06.27.17.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 17:18:01 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: osandov@osandov.com,
	josef@toxicpanda.com,
	laoji.jx@alibaba-inc.com,
	kernel-team@meta.com
Subject: [PATCH] fuse: Enable dynamic configuration of FUSE_MAX_MAX_PAGES
Date: Thu, 27 Jun 2024 17:13:55 -0700
Message-ID: <20240628001355.243805-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the capability to dynamically configure the FUSE_MAX_MAX_PAGES
limit through a sysctl. This enhancement allows system administrators to
adjust the value based on system-specific requirements.

This removes the previous static limit of 256 max pages, which limits
the max write size of a request to 1 MiB (on 4096 pagesize systems).
Having the ability to up the max write size beyond 1 MiB allows for the
perf improvements detailed in this thread [1].

$ sysctl -a | grep fuse_max_max_pages
fs.fuse.fuse_max_max_pages = 256

$ sysctl -n fs.fuse.fuse_max_max_pages
256

$ echo 1024 | sudo tee /proc/sys/fs/fuse/fuse_max_max_pages
1024

$ sysctl -n fs.fuse.fuse_max_max_pages
1024

[1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#u

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 10 +++++++
 fs/fuse/Makefile                        |  2 +-
 fs/fuse/fuse_i.h                        | 14 +++++++---
 fs/fuse/inode.c                         | 11 +++++++-
 fs/fuse/ioctl.c                         |  4 ++-
 fs/fuse/sysctl.c                        | 35 +++++++++++++++++++++++++
 6 files changed, 70 insertions(+), 6 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 47499a1742bd..3f96e2f47b01 100644
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
+``/proc/sys/fs/fuse/fuse_max_max_pages`` is a read/write file for
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
index f23919610313..0c9aaf626341 100644
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
+extern unsigned int fuse_max_max_pages;
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
index 99e44ea7d875..5d29a92389e6 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -35,6 +35,8 @@ DEFINE_MUTEX(fuse_mutex);
 
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
+unsigned int fuse_max_max_pages = 256;
+
 unsigned max_user_bgreq;
 module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
 		  &max_user_bgreq, 0644);
@@ -932,7 +934,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
-	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
+	fc->max_pages_limit = fuse_max_max_pages;
 
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
index 000000000000..0dbcb9688f73
--- /dev/null
+++ b/fs/fuse/sysctl.c
@@ -0,0 +1,35 @@
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
+static struct ctl_table fuse_sysctl_table[] = {
+	{
+		.procname	= "fuse_max_max_pages",
+		.data		= &fuse_max_max_pages,
+		.maxlen		= sizeof(fuse_max_max_pages),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
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
2.43.0


