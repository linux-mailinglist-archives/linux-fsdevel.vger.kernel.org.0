Return-Path: <linux-fsdevel+bounces-22908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAF591ECD1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 03:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8D7B22734
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A88B64A;
	Tue,  2 Jul 2024 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1xqTr0x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21E8BFC
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719884883; cv=none; b=NWtc9VkJmFIsKIrpoYsPd45nUNR3cZipwdXpHGwzXROIZFpqHZ+EGlbnLpe7cSc8lDh4oYDNRWA7oPSzk1zCq3t1VOp8Qa7Yczoro7lh5DIUNZztL1m55eoMlGRBRiJeOMvuaoMmaoSS5YViR4N6OFCp4g4jpQUyhWGDt4qfAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719884883; c=relaxed/simple;
	bh=huCoMpq9Lmfb0lZxmChQ/QIGIi2BxRoL1r1PttMU1CI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mTTH6hh7oVhr2HQwQ1z8WfoSXurVpk9Mo1Puq4IWHUlqHHwCfP2hXKHd/zvyNxR0uz2EjaNf/2/PJ9QiuWWgB56pbGk7b4NNRNZ9UdqJxmuMiZgsVf4JZsamJIg8Vl8xx/PhIHF10n1sB8Uh+W555z/bCMUOu+oENiz1TRNeAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1xqTr0x; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64b05fab14eso33639017b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jul 2024 18:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719884867; x=1720489667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VMbEFB1HNilLPcyCtFzH9hy8K3FEalSVRRXHxOKHcZA=;
        b=A1xqTr0xzLH/Eu0nMz6I4+etv0mFYVbKtSpKj6vjV8o/nP+hKYx3+zbps1/xfZ1f5N
         mEzvQpI/BMcNQWm6er9N/Mzzr4LeWFgqcNZoGz9hCUnHfR1xGnfOGfgSCKihSh1oKa4j
         k1jYqbh8iniFoGYjmcEt40IRvamlHLYKSEzn7ni/G5MFyqNAuNbNXVExKdmty9EvBEG/
         GkiM8LveZRaRVQFfrfzQb7hER//fi88SzqaaNLRNsRVfQrJCWD/OBGprs6tZ1MITP5j7
         SGfia2ne+6N+OeBW+N6Lb1kTM7SvtYu91YixnvO56Q0xNUdu9lzHZiRIMurTx9BPMRYk
         z2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719884867; x=1720489667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMbEFB1HNilLPcyCtFzH9hy8K3FEalSVRRXHxOKHcZA=;
        b=lYnYmQ1oUJ3PnYtXy0NQyuRe3okH+5MdyuE/VWD0mFALl5fWlrHJyRiw95WXgRuaGB
         8vmJfRydYkzTLBgkLPfPU+fPJ9/j7rn1K9VMdpahmK5qRSIuxop3F1p8ZCiJhGMpf5ih
         HS3YAOcyoyTOrMIMl7E9L0dZXtlyVFjC3hCBVeN0Z1Vn3nrjPwCcnI2Nsyun+g9IC9NC
         rCB3JCryPZJ9Lls534zImUR2wJHxUj6h/jKAukw2xxqjYyClmbwBWk/03xn5vWlzK6BR
         05GiHaP/r70f905OHJgdUliUUXFAs1M6m3zkNJsKpjiQ48fXHzriqgCtuLOoz3ogK0j5
         rX0g==
X-Forwarded-Encrypted: i=1; AJvYcCX5ZTLWLFXBv8N0hFelSEv+XGLbeIxLVhHZTFWAR2g10y3Qz+weLiBvLTJMOvt/xjh22Tjf2UctcUvoLezpfl5HY/pxenH5vlSt+bKr3Q==
X-Gm-Message-State: AOJu0YzEmcqI3RONzEcJIQybBiigGIQDIM34FByNU/z7TM2P6f90EfNY
	JvJqKTx4G+HfWDTtZoOlsP7TSMTpOONVK4i7IrjqC2oeYZDQ2xR7
X-Google-Smtp-Source: AGHT+IFc11cD9kPbx6F9bwVZdc2a3iMCX4UHQitXmvSMbx1pw1p3ROiv08KTYDb4umN9VOgeJoNE4g==
X-Received: by 2002:a81:ad1e:0:b0:61b:3304:b702 with SMTP id 00721157ae682-64c70c76485mr70848357b3.5.1719884866598;
        Mon, 01 Jul 2024 18:47:46 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64b1fda3b14sm14223517b3.71.2024.07.01.18.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 18:47:46 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	sweettea-kernel@dorminy.me,
	osandov@osandov.com,
	kernel-team@meta.com
Subject: [PATCH v2] fuse: Enable dynamic configuration of fuse max pages limit (FUSE_MAX_MAX_PAGES)
Date: Mon,  1 Jul 2024 18:46:27 -0700
Message-ID: <20240702014627.4068146-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.0
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

v1 can be found at
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
2.43.0


