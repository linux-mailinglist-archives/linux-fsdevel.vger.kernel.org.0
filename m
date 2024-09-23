Return-Path: <linux-fsdevel+bounces-29882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C4D97EFC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89337B2156A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A5419F129;
	Mon, 23 Sep 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLRh+V/8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD6019F104
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727111621; cv=none; b=TYOtwNlaD4bZBNKn9ZqC+urKLkgSgmvodc/FXzOx25ZUiqpiy1KpH8g8byo/76NaITZOcMtEgi8rDAiSl1w4e0bsHJAjqn/AVVbfr6e1HNHnuhCcju14GMfVynoYYo4Vv/5beSsgsENjCUjuXmGkPT/4tS+vjBnipiam6+8UXFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727111621; c=relaxed/simple;
	bh=i9GOV2Fe+RgyLB4RFwskZkpU5IK1j83+htllmoK5Y8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtsJy0akGyrHzoNMx7f0CEYgAtkOHM05hKvXIgsmKQzwZClV+ujqtbiRdoKt8lxV/qsve06H1/O9HIwVHwCq6XUROdiTzq0bJjqPST97sTH4RwmPkR6f+sOsAsal/UanbAuySzeF7zAvLwgxl6FsYG8+xPkfCEcnZzQ9W4rGxhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLRh+V/8; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1a8ae00f5eso3880774276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727111618; x=1727716418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Wi0INO/QJHbDLK4Q5fePTvrM6v1dURunWCiuC/Jkt8=;
        b=WLRh+V/83NS261driUTbiVLfVM+1/ZEY3XdwOt+nssN90iBpneFY+zgv3HysCcvzn4
         L9pCa4r9OxYnji5YiH4U7b6t4/xJSYhfpuBJRbTmV4VXz9DUc8W+bNKzMoLwVULDZORB
         akyHST26lBoYd5IkrBytgoQMOYa2OZ0/mBP9bozcczc0CIZ/qTFCSSVIFDrlow2WUFYY
         m0+r+rW6pJWQtDfVPWlB17dBa57AfOa7tI8Pm7Sk7pRrsETLHNdoJL7qquQf/XuRXdKD
         lHSul7DvRPE0oRYT4t7/fKf3WFo21BJleUMCn/GiKpaOTbx/vDH7BjVSQhTsZnz/gSdk
         dssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727111618; x=1727716418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Wi0INO/QJHbDLK4Q5fePTvrM6v1dURunWCiuC/Jkt8=;
        b=wE1PmDSlwodUji1mGzAtOgNPqRh9WxFjnULr+kWi6XdeocMBF5baiGOWGPEkx1xrPZ
         H/gd9/R1oDPqTUabNHhUZJMyaUeW0E6po+7zznehF/HDaiypRCT8/RajGU8imIuICqOV
         zypuH6BwC9FqYd3w7uhJHc0p4DnfXaqTjTXuu4qgteebah2Jxn6d4FVOvRI8ra0FVHrx
         WPo51TclLTx1bp8ry/32jSow+5gyxsa7I53H8cB4ibeeEMoyPAfSm9jMk+Ot0R3gtsBE
         2kID4OXFFNMImBSbpsukeRiP7MXiENsLhmHfg+XW2QP1pME/pYuE+yv/ZxlycUFkBW9i
         VelQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9cKM2oVigUfm7LJNE7MV1t8NPwj/IP9v7o7tS/5QPTk90fGSm08fNnv16fWmum6nocuU/kT9FMvZ0rIhj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1bQ9UPJ2vWwrzthHW4FnzdNFc+mqeh8TT/neltT+VvS59f1Fw
	V+phhmDM7Qx3PUvju0fnCi/9LJOA2NoXu1a2lasda8lxSdtH3KA+
X-Google-Smtp-Source: AGHT+IEvMl727PR3IR9cAlyhTmxNOFh/gmV6xC7o1fnMROCidYJle+VWbCGB4CPsMvnUghTsxwVv9w==
X-Received: by 2002:a05:690c:610d:b0:6d5:6719:4d64 with SMTP id 00721157ae682-6dfeed3403cmr89599007b3.18.1727111618350;
        Mon, 23 Sep 2024 10:13:38 -0700 (PDT)
Received: from localhost (fwdproxy-nha-005.fbsv.net. [2a03:2880:25ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2ed00c1sm34347407b3.83.2024.09.23.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 10:13:38 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	sweettea-kernel@dorminy.me,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 1/1] fuse: enable dynamic configuration of fuse max pages limit (FUSE_MAX_MAX_PAGES)
Date: Mon, 23 Sep 2024 10:13:11 -0700
Message-ID: <20240923171311.1561917-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240923171311.1561917-1-joannelkoong@gmail.com>
References: <20240923171311.1561917-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the capability to dynamically configure the max pages limit
(FUSE_MAX_MAX_PAGES) through a sysctl. This allows system administrators
to dynamically set the maximum number of pages that can be used for
servicing requests in fuse. 

Previously, this is gated by FUSE_MAX_MAX_PAGES which is statically set
to 256 pages. One result of this is that the buffer size for a write
request is limited to 1 MiB on a 4k-page system.

The default value for this sysctl is the original limit (256 pages).

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

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 Documentation/admin-guide/sysctl/fs.rst | 10 +++++++
 fs/fuse/Makefile                        |  1 +
 fs/fuse/fuse_i.h                        | 14 +++++++--
 fs/fuse/inode.c                         | 11 ++++++-
 fs/fuse/ioctl.c                         |  4 ++-
 fs/fuse/sysctl.c                        | 40 +++++++++++++++++++++++++
 6 files changed, 75 insertions(+), 5 deletions(-)
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
index ce0ff7a9007b..2c372180d631 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -14,5 +14,6 @@ fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
+fuse-$(CONFIG_SYSCTL) += sysctl.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e6cc3d552b13..7ff00bae4a84 100644
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
 
@@ -1480,4 +1480,12 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
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
index fd3321e29a3e..30a95cd9f497 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -35,6 +35,8 @@ DEFINE_MUTEX(fuse_mutex);
 
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
+unsigned int fuse_max_pages_limit = 256;
+
 unsigned max_user_bgreq;
 module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
 		  &max_user_bgreq, 0644);
@@ -944,7 +946,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
-	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
+	fc->max_pages_limit = fuse_max_pages_limit;
 
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_files_init(fc);
@@ -2063,8 +2065,14 @@ static int __init fuse_fs_init(void)
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
@@ -2077,6 +2085,7 @@ static void fuse_fs_cleanup(void)
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


