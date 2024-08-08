Return-Path: <linux-fsdevel+bounces-25452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E604094C507
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 21:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C511C2231F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 19:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694E01487DF;
	Thu,  8 Aug 2024 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYDK8PDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF543398E
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143782; cv=none; b=E3R+Ox8QKEv/uQMitkJuXt2M8315s1fb0r9MTeYfRptcAU8oTDswZIGEmnVHJX8RHjJplEsAXx63PoKZmcv0skxQ0kDyNP8dag9z543h6gppTw+YW1mYk8iq5qy22B7PFl8/O3MJD0srYrprhMDMdjlbnu68bSZ46upb+djRmTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143782; c=relaxed/simple;
	bh=jxeX3FbyWYz9W8DibtHIhgRJu4rXjLnRyJQDaGhQ1vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmRsZcM7++ZtyDunDigcEqPpwb4weyKPXjHudE9Mwg/PNf/PEK7ca//kKwSu+fOub4WiR7eZH8LOGl/uzVXSjgKcyMI/U7lb+aWL0BjXdWq3ltH48ma13y1X3fEMlW/95jiSsoq6MY4wTUExycuP9k8MFILXWNjvUX7A862FiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYDK8PDV; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0b2d502c6eso1280405276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Aug 2024 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723143780; x=1723748580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udHV2R2cBbIdvcF2V8FHfrmP0uVebXmueDFKdw9c5+8=;
        b=TYDK8PDVr6z9Cbk+CbVihpyqCBF4TgI8Ah5MmMNVSYGdccWKe8BYTXXpkA2UkQp7Zm
         LnXmQ7XN1eqrQsUjlEETcNzX6CkS3vT6hI2W0Id9ZhvY0TiuyVYai1jF3Lm0WT4ZojDU
         IOmiziAAO8EaUinXHujyKauRD/VQH2IDPJGo9AR/AXRO5V/+C0mFEdXgOdCAeahUmypG
         vfUlybzyt5asZzg1tEatX75RGRjpjl4SsxNyWEQbG0wHHpUUcCfi6puoPNOefbUasg8O
         Na1sSvZ4b0IVl76uj9gMLuP4o7qGC1calo2f/7k3ihoViBjZN8YZXlhK52jdYtp0FxOA
         32qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143780; x=1723748580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udHV2R2cBbIdvcF2V8FHfrmP0uVebXmueDFKdw9c5+8=;
        b=bZUi92ke7yfZpGmobTv1quyQuC+bUsR/qny8hlQcUVxegVCDweW64+D9vBHFJX1SSq
         3SpgQPp8dLdG4fnSeBOAVVlajNl8KpYcPZu8z/Gr5YmZyCrBKEigAEkpQKcGBeEy6/tc
         iIttoMc1pQUxlkOIKsvPp2ewsgH5xjFXoZ2pkHJ+jdugYoC7tSlFn2nEwv142gymthO4
         pS9wDc/Y6tkxkJAuFwTFEAJwN7X8+trIJ6kSGUQ7qWU3f6P4As6Pap5X8nKCHqeDFLr2
         JSUJlkqhTlrKStDCe436Buk5jzLq4yYuVNMALeOxPgLz1j5PCShO1+WR3RyM0/6CPn80
         fbbg==
X-Forwarded-Encrypted: i=1; AJvYcCVSjLTajQhZY/H17t3jn3Gb+oKJgc+3mRq3zsx871La2hDthaBSxPs4R7C44fByk7fP7XB9N4uuQG3rpaJrhxgyBPmCJCOZaD4vOVPahQ==
X-Gm-Message-State: AOJu0YwHrWLPL1KRh8NA93ydZj1YVIExY/E36cDNL2+yCn6e63T1oabI
	/RsSsNYdqG/9FiV77JTqdacJ0TLTtq+FzsiamOJuNIKHaZXzizgI
X-Google-Smtp-Source: AGHT+IEs/X23ncvSEa2WW75FBdEkXId81k8FLYPjv7cW7FBJX4FsA+fObZVv6Mi8dp60poxeBZlCig==
X-Received: by 2002:a05:6902:1b04:b0:e03:9dcb:6dc8 with SMTP id 3f1490d57ef6-e0e9db9aa93mr3114617276.38.1723143780056;
        Thu, 08 Aug 2024 12:03:00 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0be534a32csm2756561276.16.2024.08.08.12.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:02:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v3 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
Date: Thu,  8 Aug 2024 12:01:10 -0700
Message-ID: <20240808190110.3188039-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808190110.3188039-1-joannelkoong@gmail.com>
References: <20240808190110.3188039-1-joannelkoong@gmail.com>
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
index 2b616c5977b4..571fa36155da 100644
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


