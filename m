Return-Path: <linux-fsdevel+bounces-28079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8DB9666DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 18:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69691281D21
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1571B3B11;
	Fri, 30 Aug 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjI/LHdA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071B1B5ED2
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035235; cv=none; b=GpoxdcIv8FemExwMtekUj/G3XZdByjrf48ateOBdUV/zzjbDvyp6k/TC43irQQedvV6+3+pF2VHqyuP/Xwu5y4zwwOFmmHxmdtSdmOV00ZFK/+q3otno1XffAzSFBStzaPggVAZ9Jpk+GPE8C41zAQYU42Ql5cZ5M1fh/+JuTEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035235; c=relaxed/simple;
	bh=o9SHl9iWNlO17FdAKFQPlDkJUBP2FUcDQwNYYWM0L0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxYQUoNofCSXzCaCeCmY9YpK6rzmTeOhU1XQ2ABfCMxuaFfseZxdz2Dlmy8giMKuECzXJZ1V7JXn8aob/UJnojcYWtpO+CvhlJcHSGk+JouEjfK8W4cFDhqyAT5upfte9y75LqwraRUVa9Kk8tOz21FLCSjNF8HFHTVgXauJti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjI/LHdA; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6d3f017f80eso8568677b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725035232; x=1725640032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2brgYHySZFrAU/wM0WMuEyX6Nv1TjqFD4WLXrDS+LVs=;
        b=cjI/LHdAIBZZFxXduWPbvCg/XuDgZYfvUK9vuM+1IV5TWu2LFtKAWjYYXjZB79rF17
         MpstK5rK+E2oj32kOUT/CQuGAw8vFMewSaF2Txw9L8qCLrRcsV3WqIbS4V0QbsCjACrR
         zlEJcj3e6e5eQTY5PMKPF6BXpXOr8kYeYmpCI6BVs/4hQtE5a1iVMBEbDfnCnf7jDM09
         q5l1FjmB4gVrI+eO9yEifgwANRLB2pUizHDnmrpq3qN2IR5TU2LfecO6fJJy5QFfkhCJ
         cfgJfjKBk0uiPeoqrLEQS5WhSMS0aUTseyo7djA9IXKjuuB/VloWVEhb6zDoN4+kvPoN
         XkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035232; x=1725640032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2brgYHySZFrAU/wM0WMuEyX6Nv1TjqFD4WLXrDS+LVs=;
        b=s/A5STjAY9S6dJFNdj1w4S1EYN/n4X5sHcoFGFu2rfVl3C4Zfr5R6Ow/3iOtXklc7I
         5k32eViEO58JGsAZwDOWh3uIfQ4mnK4Kf1oCrvzIvHyzuedrF8rpPd08L9GaQjVjWblp
         G9Jm7sByz1nDpWKNC6HffwQ6Bc7zKHobfH3kHd1qQGa9WczGnVXHBqXGseHQVfXUclox
         au6NFGK+aqKWvCEZ3UAU76yvuSEpdKnl5mjsnGNoFFvfHDTF9YGN/t97etiP7QJAr3rh
         TdHgFAuy+/ZqCCwivtBNJPSULNwojiBcwLSeHi4YyECV6OHZFgmAGkmbey8KgIeiOwPB
         gLMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/o1mhCYT+dAk0QzxMOoT0skh5AwHXKOuVHt7zz+X2muQD4H/Xp5fUQ4d7Wfsmnit4GOiyISLQLeK599UD@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdSypZU/PYVavYmMG7ySZZs/djqTAtDaL25MLPFP9/V765S1D
	ZWEseeI2wtROp7fsGjlbCFIutp1+t9XQVjs873k2Ww2QoHoAUIptXsvMkg==
X-Google-Smtp-Source: AGHT+IHOhx+UcZ8V7VvVvnC+ZEjaYelZJ+wINcZVczIlcBuJAQvj5MRzz00cM2iZ+6gVygEx/mKXMA==
X-Received: by 2002:a05:690c:460d:b0:6b4:ace4:31a6 with SMTP id 00721157ae682-6d40f92253dmr23222597b3.20.1725035232197;
        Fri, 30 Aug 2024 09:27:12 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d2d39c73cdsm6673097b3.3.2024.08.30.09.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:27:12 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v6 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
Date: Fri, 30 Aug 2024 09:26:49 -0700
Message-ID: <20240830162649.3849586-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830162649.3849586-1-joannelkoong@gmail.com>
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
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
 fs/fuse/Makefile                        |  1 +
 fs/fuse/fuse_i.h                        | 16 ++++++++++
 fs/fuse/inode.c                         | 19 ++++++++++-
 fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++++
 5 files changed, 108 insertions(+), 1 deletion(-)
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
index 6e0228c6d0cb..dabc852a7ff1 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -11,5 +11,6 @@ fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
+fuse-$(CONFIG_SYSCTL) += sysctl.o
 
 virtiofs-y := virtio_fs.o
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


