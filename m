Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304EA45621C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 19:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhKRSQO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 13:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbhKRSQM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:16:12 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF91FC061574;
        Thu, 18 Nov 2021 10:13:11 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id b15so30936681edd.7;
        Thu, 18 Nov 2021 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gLFEi1MVIyfiMkBm0VGfkY9rKz0iYTFKyUcPx3tqL4=;
        b=TAcaVsz0OQ2snZxOL0VsOsgeHED13kTaYXrtIXxsBtfa5tUZTapx2atZ9HFGADs6Vm
         na/amklExRo7JCGTTYjKDzV8f7h9ODJDtGrJjzUpyMNbSPcdSw3/9rsmhhvvK1Num1D1
         gYm2K4psBG+MFSW3UfwqJeqvU8HArEeqWMWWGHzQL/7fOF9No2B7t/A7/n9W1DQjLWIl
         C4ws4tfl0h78ua06mGs0ahrkZy/ye/K+9m2j1QasaKlVXgM9tJqRZedF/PXhjHoQozBP
         Gh45rSp+0LtXe0yQBXvpDvj0dfAyiFKBVEg208aA8HIDUooosD8sW//mPcdMqam7kCJD
         9JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gLFEi1MVIyfiMkBm0VGfkY9rKz0iYTFKyUcPx3tqL4=;
        b=TIDlJsvskagp+on4bNmDZYgnQ85I1jFwmfFXplpp/p94wncIj1olez9D/BrCpL4ep7
         5derdqArfmOJNqiG5JTE4XXt3cj1OK3emdTicekbJg+AaiMAwlDf/oy3H0cK0PQQL0C4
         Kb+sfdFk7TBDd8fjWOfGbhHG/iJvS7tR4elFoXYRscNOWvFfxtA3ReNaFDGRav4XG8Xy
         7ddH1Erud9QzpkG5rafKWoMTq8mKJoAPsL6kWTws/QrqqVzffr0XjiIbx9GUaa9t/phN
         tauTuKOkIKcJGUM3FoGXeC4WNRZh8mMSbsqUxNs5LqQVIzK5w+MEyWlsNiHDmqWQrjqt
         LOkg==
X-Gm-Message-State: AOAM533WvGrr9wGLDtxiC1rs3yUitBjOYwO/w0ievYUR0OItO0Sq1uam
        XLOfwrSD+oOfPfku3O+MebUI8swMHio=
X-Google-Smtp-Source: ABdhPJyHB+6+ntjrH/laT/hRSDBxyPFJ1jxaFfoeOL17G+JUe4BZ4nlA8WGBRUobzwBO3GgGlNwS6A==
X-Received: by 2002:a05:6402:4412:: with SMTP id y18mr13802789eda.103.1637259190310;
        Thu, 18 Nov 2021 10:13:10 -0800 (PST)
Received: from crow.. ([95.87.219.163])
        by smtp.gmail.com with ESMTPSA id d10sm224135eja.4.2021.11.18.10.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:13:10 -0800 (PST)
From:   "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        rostedt@goodmis.org, mingo@redhat.com, hagen@jauu.net,
        rppt@kernel.org, James.Bottomley@HansenPartnership.com,
        akpm@linux-foundation.org, vvs@virtuozzo.com, shakeelb@google.com,
        christian.brauner@ubuntu.com, mkoutny@suse.com,
        "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Subject: [RFC PATCH 2/4] namespacefs: Add methods to create/remove PID namespace directories
Date:   Thu, 18 Nov 2021 20:12:08 +0200
Message-Id: <20211118181210.281359-3-y.karadz@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211118181210.281359-1-y.karadz@gmail.com>
References: <20211118181210.281359-1-y.karadz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Each existing namespace on the system will be represented by a
corresponding directory in namespacesfs. When a namespace is created
a new directory will be added. When a namespace is destroyed, its
corresponding directory will be removed. When fully functional,
'namespacesfs' will provide a direct (1 to 1) mapping between the
hierarchy of all namespaces that are currently active on the system
and the hierarchy of directories in 'namespacesfs'.

As a first step towards this, here we add methods for creating and
removing PID namespace directories. For the moment the PID namespace
directory contains only one file called 'tasks'. This is a read only
pseudo file that provides a list of PIDs of all tasks enclosed inside
the namespace.

We modify 'struct ns_common' so that each namespaces will be able to
own a pointer to the 'dentry' of its corresponding directory in
'namespacesfs'. This pointer will be used to couple the creation and
destruction of a namespace with the creation and removal of its
corresponding directory.

In the patch we also add generic helper methods for printing the content
of an 'idr' ('id to pointer' translation service) into synthetic files
from sequences of records (seq_file). These new definitions are used by
'namespacefs' when printing the PIDs of the tasks in each PID namespace.

Signed-off-by: Yordan Karadzhov (VMware) <y.karadz@gmail.com>
---
 fs/namespacefs/inode.c      | 119 ++++++++++++++++++++++++++++++++++++
 include/linux/idr-seq.h     |   0
 include/linux/namespacefs.h |  13 ++++
 include/linux/ns_common.h   |   4 ++
 4 files changed, 136 insertions(+)
 delete mode 100644 include/linux/idr-seq.h

diff --git a/fs/namespacefs/inode.c b/fs/namespacefs/inode.c
index 0f6293b0877d..012c1c43b44d 100644
--- a/fs/namespacefs/inode.c
+++ b/fs/namespacefs/inode.c
@@ -10,6 +10,8 @@
 #include <linux/namei.h>
 #include <linux/fsnotify.h>
 #include <linux/magic.h>
+#include <linux/idr.h>
+#include <linux/seq_file.h>
 
 static struct vfsmount *namespacefs_mount;
 static int namespacefs_mount_count;
@@ -188,6 +190,123 @@ void namespacefs_remove_dir(struct dentry *dentry)
 	release_namespacefs();
 }
 
+struct idr_seq_context {
+	struct idr	*idr;
+	int		index;
+};
+
+static void *idr_seq_get_next(struct idr_seq_context *idr_ctx, loff_t *pos)
+{
+	void *next = idr_get_next(idr_ctx->idr, &idr_ctx->index);
+
+	*pos = ++idr_ctx->index;
+	return next;
+}
+
+static void *idr_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct idr_seq_context *idr_ctx = m->private;
+
+	idr_lock(idr_ctx->idr);
+	idr_ctx->index = *pos;
+	return idr_seq_get_next(idr_ctx, pos);
+}
+
+static void *idr_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return idr_seq_get_next(m->private, pos);
+}
+
+static void idr_seq_stop(struct seq_file *m, void *p)
+{
+	struct idr_seq_context *idr_ctx = m->private;
+
+	idr_unlock(idr_ctx->idr);
+}
+
+static int idr_seq_open(struct file *file, struct idr *idr,
+			const struct seq_operations *ops)
+{
+	struct idr_seq_context *idr_ctx;
+
+	idr_ctx = __seq_open_private(file, ops, sizeof(*idr_ctx));
+	if (!idr_ctx)
+		return -ENOMEM;
+
+	idr_ctx->idr = idr;
+
+	return 0;
+}
+
+static inline int pid_seq_show(struct seq_file *m, void *v)
+{
+	struct pid *pid = v;
+
+	seq_printf(m, "%d\n", pid_nr(pid));
+	return 0;
+}
+
+static const struct seq_operations pid_seq_ops = {
+	.start		= idr_seq_start,
+	.next		= idr_seq_next,
+	.stop		= idr_seq_stop,
+	.show		= pid_seq_show,
+};
+
+static int pid_seq_open(struct inode *inode, struct file *file)
+{
+	struct idr *idr = inode->i_private;
+
+	return idr_seq_open(file, idr, &pid_seq_ops);
+}
+
+static const struct file_operations tasks_fops = {
+	.open		= pid_seq_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release_private,
+};
+
+static int create_inode_dir(struct ns_common *ns, struct dentry *parent_dentry,
+			    const struct user_namespace *user_ns)
+{
+	char *dir = kasprintf(GFP_KERNEL, "%u", ns->inum);
+
+	if (!dir)
+		return -ENOMEM;
+
+	ns->dentry = namespacefs_create_dir(dir, parent_dentry, user_ns);
+	kfree(dir);
+	if (IS_ERR(ns->dentry))
+		return PTR_ERR(ns->dentry);
+
+	return 0;
+}
+
+int namespacefs_create_pid_ns_dir(struct pid_namespace *ns)
+{
+	struct dentry *dentry;
+	int err;
+
+	err = create_inode_dir(&ns->ns, ns->parent->ns.dentry, ns->user_ns);
+	if (err)
+		return err;
+
+	dentry = namespacefs_create_file("tasks", ns->ns.dentry, ns->user_ns,
+					 &tasks_fops, &ns->idr);
+	if (IS_ERR(dentry)) {
+		dput(ns->ns.dentry);
+		return PTR_ERR(dentry);
+	}
+
+	return 0;
+}
+
+void namespacefs_remove_pid_ns_dir(struct pid_namespace *ns)
+{
+	namespacefs_remove_dir(ns->ns.dentry);
+}
+
 #define _NS_MOUNT_DIR	"namespaces"
 
 static int __init namespacefs_init(void)
diff --git a/include/linux/idr-seq.h b/include/linux/idr-seq.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/include/linux/namespacefs.h b/include/linux/namespacefs.h
index 44a760080df7..f41499a7635a 100644
--- a/include/linux/namespacefs.h
+++ b/include/linux/namespacefs.h
@@ -19,6 +19,8 @@ struct dentry *
 namespacefs_create_dir(const char *name, struct dentry *parent,
 		       const struct user_namespace *user_ns);
 void namespacefs_remove_dir(struct dentry *dentry);
+int namespacefs_create_pid_ns_dir(struct pid_namespace *ns);
+void namespacefs_remove_pid_ns_dir(struct pid_namespace *ns);
 
 #else
 
@@ -42,6 +44,17 @@ static inline void namespacefs_remove_dir(struct dentry *dentry)
 {
 }
 
+static inline int
+namespacefs_create_pid_ns_dir(struct pid_namespace *ns)
+{
+	return 0;
+}
+
+static inline void
+namespacefs_remove_pid_ns_dir(struct pid_namespace *ns)
+{
+}
+
 #endif /* CONFIG_NAMESPACE_FS */
 
 #endif
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 0f1d024bd958..1dec75c51b2c 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -11,6 +11,10 @@ struct ns_common {
 	const struct proc_ns_operations *ops;
 	unsigned int inum;
 	refcount_t count;
+
+#ifdef CONFIG_NAMESPACE_FS
+	struct dentry *dentry;
+#endif /* CONFIG_NAMESPACE_FS */
 };
 
 #endif
-- 
2.33.1

