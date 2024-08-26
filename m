Return-Path: <linux-fsdevel+bounces-27236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB89B95FAB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 22:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633C92821B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1464419A296;
	Mon, 26 Aug 2024 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT/DHa2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64451990C8
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724704395; cv=none; b=OyyNYVwfmALMezXPdEZNo/oQU9Whd9XEdBe3L6Cfo6i66rFdQigmkACv2nOSq7mYol5gNKmVfxL+5mlpdsMjvDUDHyxIwrkYCTDnVYrpAVsunXXJmbe7sebq0Sl16ESit7ftHjXJfw40IHogZAaSLb1kFzNBdJyVr14cKYCXx4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724704395; c=relaxed/simple;
	bh=Q4ZNwWtTA2XYZ+G01VTdumCNPh+u5mFWxaM+LDGCqIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqwtTXLGXScYvfyipWqEvt0btQgHgA+J4OEXoloT4y6qeJZTP9meuP+AFuI/WOln8GB5e6SQhjO+dET3UgO8MS1CvnfNqRHQwqCxIaIMPcTVjGSZglz5NtaEQKzOdo0AhaNtiTefRO65Y25n/DkBggDc0Fn0/8A7csRH3dtj650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT/DHa2v; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6c0e22218d0so50126697b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 13:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724704393; x=1725309193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNzQTdiVvl55WaVXlmS0iy1xWGsDflURZ7ZHKLXW+TY=;
        b=lT/DHa2vcNJdYJhqnjm8Fl4bt6onaTGRzYTa7uHT5+KU+Mjm1uLI/7biwEgDyc84ht
         YM/+xJ98NX5BxP+ak4fxT7ZarWM0CQ/y7TJGXFrbfBRm2ydV4fb/AoiZ/Ihnc7HP7vSZ
         MCOBs4faCFDv94l361JrJBS9HjUih30vm2eSWnMfFAN+4G5JpltuvK4dMoy2gv4UzT3R
         9Nk0al094+qV845JLGycoiMx8bSudJm+0YqjNJmTts+apZ1WT5QXDDT3cBpkjNfC08aO
         QQwMnPufVtuANDMRJMiu4fI8jh3BnPQtmSYn0MJmQox83ceYoVzhfZSj3XnUGZGfFjna
         S77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724704393; x=1725309193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNzQTdiVvl55WaVXlmS0iy1xWGsDflURZ7ZHKLXW+TY=;
        b=E9HfeuHfnho7YIDLMQbQMTIwEzRRr8rj9X4sIssXoPeJ2X904D4CGW++MaDY56nWwp
         DNfWxAt80DvavKU6bw8tCLXjLIf1I66N8tPedEzRPGiBNj7t3tdQjYgIg5IvxYoUYdLz
         T3v2+EIKmwthD5/sNjP2wkksioyqjG110HcQVKdUpAPyZQVclZSBpv1t5T8jLOoaSvyu
         iLhOH+bwpwvCKNpOzWNeWztb4FbI+nVmLA7ss9y2LCd1B1cQ7dnhpqtaeIonlm/SnqKo
         nYdTKp9jLpcJ0sEYThU2YDDdd+PJ0uHIa6FF3hSDT6vcxa6sUrJvtmKIh85VG1+ioyyo
         IrXA==
X-Forwarded-Encrypted: i=1; AJvYcCWc/Z9Uo7qzVMGfIH6hzFZ9XYqZV6ucyWcLpbnP6jWUkWX7G15YkZDbL5W+4kMqw6WKSXwrQbStKKHkFQn9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EF1xwge8e+reWL1T70LfxTwJYFm91FY6wwY8UuffD5Syo3Ft
	iWhpL8vEqRtlnqa0JoHoSlXkdZNF0HsowGaE+G7sA56SVIcWKDnF
X-Google-Smtp-Source: AGHT+IE/onRzbmv2jsII5xXOrhit7HeEicYWgtpAGNjgSCPRAnGYBWsasPktYQTLETaNzd3is+mvVA==
X-Received: by 2002:a05:690c:d83:b0:64b:2f31:296b with SMTP id 00721157ae682-6c624228d38mr138386477b3.4.1724704392661;
        Mon, 26 Aug 2024 13:33:12 -0700 (PDT)
Received: from localhost (fwdproxy-nha-009.fbsv.net. [2a03:2880:25ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39dd475c5sm16520027b3.124.2024.08.26.13.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:33:12 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v5 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
Date: Mon, 26 Aug 2024 13:32:34 -0700
Message-ID: <20240826203234.4079338-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240826203234.4079338-1-joannelkoong@gmail.com>
References: <20240826203234.4079338-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce two new sysctls, "default_request_timeout" and
"max_request_timeout". These control how long (in seconds) a server can
take to reply to a request. If the server does not reply by the timeout,
then the connection will be aborted.

"default_request_timeout" sets the default timeout if no timeout is
specified by the fuse server on mount. 0 (default) indicates no default
timeout should be enforced. If the server did set a timeout, then
default_request_timeout will be ignored.

"max_request_timeout" sets the upper bound on how long the server may
take to reply to a request. 0 (default) indicates no maximum timeout. If
the max_request_timeout is set and the fuse server attempts to set a
timeout greater than max_request_timeout, the system will default to
max_request_timeout. Similarly, if default_request_timeout is greater
than max_request_timeout, the system will default to
max_request_timeout. If the server does not request a timeout and
default_request_timeout is set to 0 but max_request_timeout is set, then
the timeout will be max_request_timeout.

$ sysctl -a | grep fuse
fs.fuse.default_request_timeout = 0
fs.fuse.max_request_timeout = 0

$ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_timeout
tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument

$ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_timeout
0xFFFFFFFF

$ sysctl -a | grep fuse
fs.fuse.default_request_timeout = 4294967295
fs.fuse.max_request_timeout = 0

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 31 ++++++++++++++++++
 fs/fuse/Makefile                        |  2 +-
 fs/fuse/fuse_i.h                        | 16 ++++++++++
 fs/fuse/inode.c                         | 19 ++++++++++-
 fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 2 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 47499a1742bd..3d5a2b5cbba0 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -332,3 +332,34 @@ Each "watch" costs roughly 90 bytes on a 32-bit kernel, and roughly 160 bytes
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
+``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
+setting/getting the default timeout (in seconds) for a fuse server to
+reply to a kernel-issued request in the event where the server did not
+specify a timeout at mount. If the server set a timeout,
+then default_request_timeout will be ignored.  The default
+"default_request_timeout" is set to 0. 0 indicates a no-op (eg
+requests will not have a default request timeout set if no timeout was
+specified by the server).
+
+``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
+setting/getting the maximum timeout (in seconds) for a fuse server to
+reply to a kernel-issued request. A value greater than 0 automatically opts
+the server into a timeout that will be at most "max_request_timeout", even if
+the server did not specify a timeout and default_request_timeout is set to 0.
+If max_request_timeout is greater than 0 and the server set a timeout greater
+than max_request_timeout or default_request_timeout is set to greater than
+max_request_timeout, the system will use max_request_timeout as the timeout.
+0 indicates a no-op (eg requests will not have an upper bound on the timeout
+and if the server did not request a timeout and default_request_timeout was not
+set, there will be no timeout).
+
+Please note that for the timeout options, if the server does not respond to
+the request by the time the timeout elapses, then the connection to the fuse
+server will be aborted.
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
index 97dacafa4289..04daf366735d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -47,6 +47,14 @@
 /** Number of dentries for each connection in the control filesystem */
 #define FUSE_CTL_NUM_DENTRIES 5
 
+/*
+ * Default timeout (in seconds) for the server to reply to a request
+ * if no timeout was specified on mount
+ */
+extern u32 fuse_default_req_timeout;
+/** Max timeout (in seconds) for the server to reply to a request */
+extern u32 fuse_max_req_timeout;
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
@@ -1480,4 +1488,12 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
 				      size_t len, unsigned int flags);
 ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
 
+#ifdef CONFIG_SYSCTL
+int fuse_sysctl_register(void);
+void fuse_sysctl_unregister(void);
+#else
+static inline int fuse_sysctl_register(void) { return 0; }
+static inline void fuse_sysctl_unregister(void) { return; }
+#endif /* CONFIG_SYSCTL */
+
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 9e69006fc026..cf333448f2d3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -35,6 +35,10 @@ DEFINE_MUTEX(fuse_mutex);
 
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
+/* default is no timeout */
+u32 fuse_default_req_timeout = 0;
+u32 fuse_max_req_timeout = 0;
+
 unsigned max_user_bgreq;
 module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
 		  &max_user_bgreq, 0644);
@@ -1678,6 +1682,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	struct fuse_conn *fc = fm->fc;
 	struct inode *root;
 	struct dentry *root_dentry;
+	u32 req_timeout;
 	int err;
 
 	err = -EINVAL;
@@ -1730,10 +1735,16 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->group_id = ctx->group_id;
 	fc->legacy_opts_show = ctx->legacy_opts_show;
 	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
-	fc->req_timeout = ctx->req_timeout * HZ;
 	fc->destroy = ctx->destroy;
 	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
+	req_timeout = ctx->req_timeout ?: fuse_default_req_timeout;
+	if (!fuse_max_req_timeout)
+		fc->req_timeout = req_timeout * HZ;
+	else if (!req_timeout)
+		fc->req_timeout = fuse_max_req_timeout * HZ;
+	else
+		fc->req_timeout = min(req_timeout, fuse_max_req_timeout) * HZ;
 
 	err = -ENOMEM;
 	root = fuse_get_root_inode(sb, ctx->rootmode);
@@ -2046,8 +2057,14 @@ static int __init fuse_fs_init(void)
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
diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
new file mode 100644
index 000000000000..c87bb0ecbfa9
--- /dev/null
+++ b/fs/fuse/sysctl.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+* linux/fs/fuse/fuse_sysctl.c
+*
+* Sysctl interface to fuse parameters
+*/
+#include <linux/sysctl.h>
+
+#include "fuse_i.h"
+
+static struct ctl_table_header *fuse_table_header;
+
+static struct ctl_table fuse_sysctl_table[] = {
+	{
+		.procname	= "default_request_timeout",
+		.data		= &fuse_default_req_timeout,
+		.maxlen		= sizeof(fuse_default_req_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
+	},
+	{
+		.procname	= "max_request_timeout",
+		.data		= &fuse_max_req_timeout,
+		.maxlen		= sizeof(fuse_max_req_timeout),
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
2.43.5


