Return-Path: <linux-fsdevel+bounces-25842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E7695107A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EC51C218EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CAE1ABECF;
	Tue, 13 Aug 2024 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CooNH6lr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F31AB53B
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723591449; cv=none; b=LCjnEjSS4eXU42UdK9JCNs/suh8Ndb4n3JR8/VOgGdLGZhdxsMu9nGkIoobbV1KEzdCkUnefFGLfyWgLiGpOmWj4zuPwZj7B2dGC121kVmdoYtvZbNkT+6j0zN91nT4oOSXC3WuW0NBU2imLW5VfN7zV53tfQWapnHbH45irbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723591449; c=relaxed/simple;
	bh=Vr1PhQNaNN5RM/+8HM0q3U5NK+jQWztVDEWUM3SYEUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSiLZX+PtpYViC8L9Eq5XHw71wiDxr3xHQ8bghVAfnzIsXRqEZwPvW5NHJKIEvRW5bOctFNw7vICvB+jyFx1R/zdGX2W6DXOjNTOFXuo0lcWUZx8gnqhrIH3YS3/b8ZDlqh2S00Yfcu0+kUjxD6gj6bAlFlcIHzzl0/lZQD+Dvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CooNH6lr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0bfd14aff7so5453730276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 16:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723591447; x=1724196247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsp6HHJ+7arbCu4WAjC7NdtXnMa/jS5lvmR1mfta7BU=;
        b=CooNH6lrdhGF01/vcwQiDoiGcxYkiBYcJB6JKoM2IxgJgc1WWXzzXMDbmV0tAczHgX
         Dir/6FumON7IS7cl45Ctmna+oVjTbfZjweM3swyaXc4CO39Pw7r2JDL6RuXgtpqMjvnV
         uhJnt2/eraL3i/tD1Y2h1gukeOCQYpBpO08qim/a/ylpWT+E0WBI8OVHjhJbfHCSgHuo
         1JWyDqKdj8RyODvsgBvoK6QFkagyPBLKPRSxiIyhiCLm/egw/eLR3S6LknIW1vlj//00
         OnEHnMaxW82QrCgbCX2dtxbuu0bOY0gHV96zDJsIll+doZ2ANzrHPtOemq7gIL0WOMV0
         KAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723591447; x=1724196247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsp6HHJ+7arbCu4WAjC7NdtXnMa/jS5lvmR1mfta7BU=;
        b=CtHsxlb6e374SkgsGzhDwJ347GOx7/De2UhnT3miiADRZFYosvyv1Ois2fXgXTFnFU
         fl19zH3l0ohV+YjEt3Tda9eL87cvFzGezTsM2MNucnRvB3mU8ppTdg2AObEM+GGvfRF1
         Me0e5PEmRM1kp6OroYJqTOv4ErpCSuAJJ6Q4P4lvX0ZdKbg+RBQWZAqvBmV/e4qatBc4
         qzfMv/WNXXmx2S+46V2qnmBmMxpwaEC/BQy/6PUR/tweBXi7P28g2Tp8otRZ9NSwGSKr
         oC0wqPNxkAViA+GkM+7j0SVGGA8zxCBLOYk4bfB+AYpauglkoyMaTlRDULlrp/oTrngC
         KGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd9EvMl6jMuRl3DBCPS62ZuRR3nVS7izC0i7lLEVSG861KhCtRXRT0olbjDBJDZV9YEY95jVHd+e7eNs+i5kQWrvMqc4CSOzbOcmtRCA==
X-Gm-Message-State: AOJu0YxFPpwwYDM26QamdDtk2JidoD4JF9OpU4UdpYGw+2LRRTir+jel
	faHCpo3wl1Q0fwq9Cd9wwynK8X9x5czX4kmjkS/Rhhj3Bp8yWuEC
X-Google-Smtp-Source: AGHT+IE0bMa3qC6ZRkmB5FKe7HV2foyDtznqvXRhMWTTtFnsIpQDcNkfEPyxyEjAFj+CYzMYZIwUCA==
X-Received: by 2002:a05:6902:13c9:b0:e0b:a34f:9792 with SMTP id 3f1490d57ef6-e1155aaec0cmr1295946276.22.1723591446547;
        Tue, 13 Aug 2024 16:24:06 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8be7610sm1670261276.24.2024.08.13.16.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 16:24:06 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v4 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
Date: Tue, 13 Aug 2024 16:22:41 -0700
Message-ID: <20240813232241.2369855-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813232241.2369855-1-joannelkoong@gmail.com>
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce two new sysctls, "default_request_timeout" and
"max_request_timeout". These control timeouts on replies by the
server to kernel-issued fuse requests.

"default_request_timeout" sets a timeout if no timeout is specified by
the fuse server on mount. 0 (default) indicates no timeout should be enforced.

"max_request_timeout" sets a maximum timeout for fuse requests. If the
fuse server attempts to set a timeout greater than max_request_timeout,
the system will default to max_request_timeout. Similarly, if the max
default timeout is greater than the max request timeout, the system will
default to the max request timeout. 0 (default) indicates no timeout should
be enforced.

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
 Documentation/admin-guide/sysctl/fs.rst | 17 ++++++++++
 fs/fuse/Makefile                        |  2 +-
 fs/fuse/fuse_i.h                        | 16 ++++++++++
 fs/fuse/inode.c                         | 19 ++++++++++-
 fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++++
 5 files changed, 94 insertions(+), 2 deletions(-)
 create mode 100644 fs/fuse/sysctl.c

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 47499a1742bd..44fd495f69b4 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -332,3 +332,20 @@ Each "watch" costs roughly 90 bytes on a 32-bit kernel, and roughly 160 bytes
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
+specify a timeout at mount. 0 indicates no timeout.
+
+``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
+setting/getting the maximum timeout (in seconds) for a fuse server to
+reply to a kernel-issued request. If the server attempts to set a
+timeout greater than max_request_timeout, the system will use
+max_request_timeout as the timeout. 0 indicates no timeout.
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
index 0a2fa487a3bf..dae9977fa050 100644
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
 
@@ -1486,4 +1494,12 @@ ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
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


