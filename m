Return-Path: <linux-fsdevel+bounces-51985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB5AADDE9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC343AE2EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108C296150;
	Tue, 17 Jun 2025 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k3uvYWxb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECA295528
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198522; cv=none; b=Q/jZd//7+PfAPHas3YI+RoDBGAempIiGBl6V27xRGMM6UOy1awIkwEr+63xEqY1xEGpLvtbMbvwSOaThgKbYJmoHwqftU5KK8S3Yg3PlyAR9bapWnolNmIppX94XJxRQK3gM/0lyM1c19ZGzn/XoBolhumRlGh+4Ngc1zoF/66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198522; c=relaxed/simple;
	bh=O41hjxZb2zNX12penWg+5xyEjdqJhMQtpNuAo7I0PHM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m9L24jUsxcn5YR/7CnkiVOipR7Fho/LNJNYD9n/mgXYSS1j8W3/bSAm/79pWgB3cmZ2f4oijDktMPaDEDin5qAiEJBtdnb+HJFhQo3gbwNzAgIL5lWt+yhy+5tm8byKnZS2xiRj9hYdg69rH3Mi7XoWaL9J8ZUD2t61CcxPA0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k3uvYWxb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3141a9a6888so2365538a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750198520; x=1750803320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=97cWcMp3hRxx2+tQ1zjI435kFk+yFY19PKnRazUc70E=;
        b=k3uvYWxbv+7WxBTY03WYE+LPtHHkVRbQQWHC2cU+XoNC2ZQ0dNf8RnOdIJfxwtag6u
         PVwSCDun2+xHSsqPV/vY6FRXJ50RG/5bHJcv/idDRlQeCgg3YZMpMxQFcLHGa9ehLomU
         8Y60AS8sdYyq9fOlVmSOVuHDQUDpUjCGUEKgiLcfpbm/iMf83US6WckIw+zcnqApUHTZ
         M5xK6gYedzkN/dW6JABkB719k9lFKH91F6ojvzbwCAil/4OU/p8laywOoQQ/YqMbZAWI
         UAq30n1yb5GIcb+bXkVht/m2OK+WZ5e3amBgOWkeBPUSceKBBAFwI4SajSzULbsfcIoA
         67jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750198520; x=1750803320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97cWcMp3hRxx2+tQ1zjI435kFk+yFY19PKnRazUc70E=;
        b=SR8HBPwxyZvv9937MXBj2V+wi/DDJxcgDtWo/QIQK4leUarRnIii6B0TH1FJMFzt5g
         E9dTL2wqgDXlxTrMT6rm0H+j/wyOCT7WRvi7IZJBO2klffCmtGwXhqd89rXPDfKXxlHc
         kpX23U9iGDY8O+NzllVDEVc0dljW8s3Vm6zvenorXxmHUvKrWgXzRIlbCi+PjmdF11Jd
         47Rk6q3vRxw64DfgKDoaLGig/yx/EDE5hEuRO+CSXuKhlYnuJY5ONIW9LPY+ZHjVMJvB
         a0afpTBsDM0ojlbQh3j8RHmmvbxK6sCd5xYtpQCfBdFWBuOpf4MN6i+6HXjQ146BAJLQ
         0h5A==
X-Forwarded-Encrypted: i=1; AJvYcCVM2x6n0iFqkuDeZYolHvoFg/MNh5A7uGe+ayoP9W06xseC91krSbc5aKJkUbjPE9uuucjFDTxoeEdKKa3D@vger.kernel.org
X-Gm-Message-State: AOJu0YyGrlgnyPerpP11A8BzE1BMmhN68znypZJFki2xaJXbSpfYccuJ
	fU5mKQWsgW+vtGPxRlbTIakvBVrzESQUED+G9WHCCmZDx6Nkgi7B+l13OYYrdXPN6FSgUddzh4c
	uNUS4upMR0T2Vcq2N/fTk5ljU47RCFQ==
X-Google-Smtp-Source: AGHT+IFZbZ0OAMbQxGShThyDpRqMVZfcRiXmXP1n+/duJAPeyrLyprq+2mMSPqtUBPH5wtnUtgK2/k+GprSC1MmG+OU=
X-Received: from pjboo14.prod.google.com ([2002:a17:90b:1c8e:b0:314:3438:8e79])
 (user=paullawrence job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2dd2:b0:312:f88d:25f9 with SMTP id 98e67ed59e1d1-313f1c7dacfmr24384558a91.7.1750198519778;
 Tue, 17 Jun 2025 15:15:19 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:14:53 -0700
In-Reply-To: <20250617221456.888231-1-paullawrence@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250617221456.888231-2-paullawrence@google.com>
Subject: [PATCH v1 1/2] fuse: Add backing file option to lookup
From: Paul Lawrence <paullawrence@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit starts the process of adding directory passthrough to fuse.

* Add the Kconfig option CONFIG_FUSE_PASSTHROUGH_DIR
* Add struct fuse_entry_backing_out, an optional second out arg to
  FUSE_LOOKUP. This will contain the fd to the backing file or
  directory
* Synchronously store the backing file in the args
* Add backing inode to fuse inode and backing path to fuse dentry
* If FUSE_LOOKUP returns a backing fd, store path and inode

Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/Kconfig           |  13 +++++
 fs/fuse/Makefile          |   1 +
 fs/fuse/backing.c         |  29 ++++++++++
 fs/fuse/dev.c             |  14 +++++
 fs/fuse/dir.c             | 114 +++++++++++++++++++++++++++++---------
 fs/fuse/fuse_i.h          |  22 +++++++-
 fs/fuse/inode.c           | 114 ++++++++++++++++++++++++++++++++++----
 include/uapi/linux/fuse.h |   4 ++
 8 files changed, 273 insertions(+), 38 deletions(-)
 create mode 100644 fs/fuse/backing.c

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index ca215a3cba3e..b8a05cb427df 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -75,3 +75,16 @@ config FUSE_IO_URING
 
 	  If you want to allow fuse server/client communication through io-uring,
 	  answer Y
+
+config FUSE_PASSTHROUGH_DIR
+	bool "FUSE directory passthrough operations support"
+	depends on FUSE_FS
+	select FS_STACK
+	help
+	  This allows bypassing FUSE server on a specified directory by mapping
+	  all FUSE operations to be performed directly on a backing directory.
+
+	  The bypass will automatically extend to all sub directories and files
+	  in that directory.
+
+	  If you want to allow directory passthrough operations, answer Y.
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 3f0f312a31c1..79ca3a68b993 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -16,5 +16,6 @@ fuse-$(CONFIG_FUSE_DAX) += dax.o
 fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
+fuse-$(CONFIG_FUSE_PASSTHROUGH_DIR) += backing.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
new file mode 100644
index 000000000000..1dcc617bf660
--- /dev/null
+++ b/fs/fuse/backing.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE-BPF: Filesystem in Userspace with BPF
+ * Copyright (c) 2021 Google LLC
+ */
+
+#include "fuse_i.h"
+
+int fuse_handle_backing(struct fuse_entry_backing *feb,
+	struct inode **backing_inode, struct path *backing_path)
+{
+	struct file *backing_file = feb->backing_file;
+
+	if (!backing_file)
+		return -EINVAL;
+	if (IS_ERR(backing_file))
+		return PTR_ERR(backing_file);
+
+	if (backing_inode)
+		iput(*backing_inode);
+	*backing_inode = backing_file->f_inode;
+	ihold(*backing_inode);
+
+	path_put(backing_path);
+	*backing_path = backing_file->f_path;
+	path_get(backing_path);
+
+	return 0;
+}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6dcbaa218b7a..db1fbd1fdb85 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2181,6 +2181,20 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		err = fuse_copy_out_args(cs, req->args, nbytes);
 	fuse_copy_finish(cs);
 
+	if (!err && req->in.h.opcode == FUSE_LOOKUP &&
+			req->args->out_args[1].size ==
+			sizeof(struct fuse_entry_backing_out)) {
+		struct fuse_entry_backing_out *febo =
+			(struct fuse_entry_backing_out *)
+				req->args->out_args[1].value;
+		struct fuse_entry_backing *feb =
+			container_of(febo, struct fuse_entry_backing, out);
+
+		feb->backing_file = fget(febo->backing_fd);
+		if (!feb->backing_file)
+			err = -EBADFD;
+	}
+
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
 	if (!fpq->connected)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 83ac192e7fdd..909463fae94d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -34,7 +34,7 @@ static void fuse_advise_use_readdirplus(struct inode *dir)
 	set_bit(FUSE_I_ADVISE_RDPLUS, &fi->state);
 }
 
-#if BITS_PER_LONG >= 64
+#if BITS_PER_LONG >= 64 && !defined(CONFIG_FUSE_PASSTHROUGH_DIR)
 static inline void __fuse_dentry_settime(struct dentry *entry, u64 time)
 {
 	entry->d_fsdata = (void *) time;
@@ -47,7 +47,12 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 
 #else
 union fuse_dentry {
-	u64 time;
+	struct {
+		u64 time;
+#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
+		struct path backing_path;
+#endif
+	};
 	struct rcu_head rcu;
 };
 
@@ -60,6 +65,11 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 {
 	return ((union fuse_dentry *) entry->d_fsdata)->time;
 }
+
+static inline union fuse_dentry *get_fuse_dentry(const struct dentry *entry)
+{
+	return entry->d_fsdata;
+}
 #endif
 
 static void fuse_dentry_settime(struct dentry *dentry, u64 time)
@@ -170,7 +180,8 @@ static void fuse_invalidate_entry(struct dentry *entry)
 
 static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 			     u64 nodeid, const struct qstr *name,
-			     struct fuse_entry_out *outarg)
+			     struct fuse_entry_out *outarg,
+			     struct fuse_entry_backing_out *febo)
 {
 	memset(outarg, 0, sizeof(struct fuse_entry_out));
 	args->opcode = FUSE_LOOKUP;
@@ -181,9 +192,12 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
 	args->in_args[1].value = name->name;
 	args->in_args[2].size = 1;
 	args->in_args[2].value = "";
-	args->out_numargs = 1;
+	args->out_argvar = true;
+	args->out_numargs = 2;
 	args->out_args[0].size = sizeof(struct fuse_entry_out);
 	args->out_args[0].value = outarg;
+	args->out_args[1].size = sizeof(struct fuse_entry_backing_out);
+	args->out_args[1].value = febo;
 }
 
 /*
@@ -209,6 +223,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
 		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
+		struct fuse_entry_backing feb;
 		FUSE_ARGS(args);
 		struct fuse_forget_link *forget;
 		u64 attr_version;
@@ -231,7 +246,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 		attr_version = fuse_get_attr_version(fm->fc);
 
 		fuse_lookup_init(fm->fc, &args, get_node_id(dir),
-				 name, &outarg);
+				 name, &outarg, &feb.out);
 		ret = fuse_simple_request(fm, &args);
 		/* Zero nodeid is same as -ENOENT */
 		if (!ret && !outarg.nodeid)
@@ -278,7 +293,7 @@ static int fuse_dentry_revalidate(struct inode *dir, const struct qstr *name,
 	goto out;
 }
 
-#if BITS_PER_LONG < 64
+#if BITS_PER_LONG < 64 || defined(CONFIG_FUSE_PASSTHROUGH_DIR)
 static int fuse_dentry_init(struct dentry *dentry)
 {
 	dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
@@ -290,6 +305,11 @@ static void fuse_dentry_release(struct dentry *dentry)
 {
 	union fuse_dentry *fd = dentry->d_fsdata;
 
+#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
+	if (fd && fd->backing_path.dentry)
+		path_put(&fd->backing_path);
+#endif
+
 	kfree_rcu(fd, rcu);
 }
 #endif
@@ -329,7 +349,7 @@ static struct vfsmount *fuse_dentry_automount(struct path *path)
 const struct dentry_operations fuse_dentry_operations = {
 	.d_revalidate	= fuse_dentry_revalidate,
 	.d_delete	= fuse_dentry_delete,
-#if BITS_PER_LONG < 64
+#if BITS_PER_LONG < 64 || defined(CONFIG_FUSE_PASSTHROUGH_DIR)
 	.d_init		= fuse_dentry_init,
 	.d_release	= fuse_dentry_release,
 #endif
@@ -360,10 +380,12 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
 }
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode)
+		     struct fuse_entry_out *outarg, struct dentry *entry,
+		     struct inode **inode)
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	FUSE_ARGS(args);
+	struct fuse_entry_backing backing_arg = {0};
 	struct fuse_forget_link *forget;
 	u64 attr_version, evict_ctr;
 	int err;
@@ -382,23 +404,61 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	attr_version = fuse_get_attr_version(fm->fc);
 	evict_ctr = fuse_get_evict_ctr(fm->fc);
 
-	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg);
+	fuse_lookup_init(fm->fc, &args, nodeid, name, outarg, &backing_arg.out);
 	err = fuse_simple_request(fm, &args);
-	/* Zero nodeid is same as -ENOENT, but with valid timeout */
-	if (err || !outarg->nodeid)
-		goto out_put_forget;
 
-	err = -EIO;
-	if (fuse_invalid_attr(&outarg->attr))
-		goto out_put_forget;
-	if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
-		pr_warn_once("root generation should be zero\n");
-		outarg->generation = 0;
+#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
+	if (err == sizeof(backing_arg.out)) {
+		struct file *backing_file;
+		struct inode *backing_inode;
+
+		err = -ENOENT;
+		if (!entry)
+			goto out_put_forget;
+
+		err = -EINVAL;
+		backing_file = backing_arg.backing_file;
+		if (!backing_file)
+			goto out_put_forget;
+
+		if (IS_ERR(backing_file)) {
+			err = PTR_ERR(backing_file);
+			goto out_put_forget;
+		}
+
+		backing_inode = backing_file->f_inode;
+		*inode = fuse_iget_backing(sb, backing_inode);
+		if (!*inode)
+			goto out_put_forget;
+
+		err = fuse_handle_backing(&backing_arg,
+				&get_fuse_inode(*inode)->backing_inode,
+				&get_fuse_dentry(entry)->backing_path);
+		if (err) {
+			iput(*inode);
+			*inode = NULL;
+			goto out_put_forget;
+		}
+	} else
+#endif
+	{
+		/* Zero nodeid is same as -ENOENT, but with valid timeout */
+		if (err || !outarg->nodeid)
+			goto out_put_forget;
+
+		err = -EIO;
+		if (fuse_invalid_attr(&outarg->attr))
+			goto out_put_forget;
+		if (outarg->nodeid == FUSE_ROOT_ID && outarg->generation != 0) {
+			pr_warn_once("root generation should be zero\n");
+			outarg->generation = 0;
+		}
+
+		*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
+				&outarg->attr, ATTR_TIMEOUT(outarg),
+				attr_version, evict_ctr);
 	}
 
-	*inode = fuse_iget(sb, outarg->nodeid, outarg->generation,
-			   &outarg->attr, ATTR_TIMEOUT(outarg),
-			   attr_version, evict_ctr);
 	err = -ENOMEM;
 	if (!*inode) {
 		fuse_queue_forget(fm->fc, forget, outarg->nodeid, 1);
@@ -406,9 +466,11 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 	}
 	err = 0;
 
- out_put_forget:
+out_put_forget:
 	kfree(forget);
- out:
+out:
+	if (backing_arg.backing_file)
+		fput(backing_arg.backing_file);
 	return err;
 }
 
@@ -427,7 +489,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 
 	locked = fuse_lock_inode(dir);
 	err = fuse_lookup_name(dir->i_sb, get_node_id(dir), &entry->d_name,
-			       &outarg, &inode);
+			       &outarg, entry, &inode);
 	fuse_unlock_inode(dir, locked);
 	if (err == -ENOENT) {
 		outarg_valid = false;
@@ -455,9 +517,9 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 		fuse_advise_use_readdirplus(dir);
 	return newent;
 
- out_iput:
+out_iput:
 	iput(inode);
- out_err:
+out_err:
 	return ERR_PTR(err);
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index d56d4fd956db..1dc04bc6ac49 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -106,6 +106,11 @@ struct fuse_backing {
 	struct rcu_head rcu;
 };
 
+struct fuse_entry_backing {
+	struct fuse_entry_backing_out out;
+	struct file *backing_file;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -213,6 +218,14 @@ struct fuse_inode {
 	/** Reference to backing file in passthrough mode */
 	struct fuse_backing *fb;
 #endif
+
+#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
+	/**
+	 * Backing inode, if this inode is from a backing file system.
+	 * If this is set, nodeid is 0.
+	 */
+	struct inode *backing_inode;
+#endif
 };
 
 /** FUSE inode state bits */
@@ -1114,13 +1127,17 @@ extern const struct dentry_operations fuse_root_dentry_operations;
 /**
  * Get a filled in inode
  */
+struct inode *fuse_iget_backing(struct super_block *sb,
+			struct inode *backing_inode);
+
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
 			u64 attr_valid, u64 attr_version,
 			u64 evict_ctr);
 
 int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name,
-		     struct fuse_entry_out *outarg, struct inode **inode);
+		     struct fuse_entry_out *outarg, struct dentry *entry,
+		     struct inode **inode);
 
 /**
  * Send FORGET command
@@ -1577,4 +1594,7 @@ extern void fuse_sysctl_unregister(void);
 #define fuse_sysctl_unregister()	do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+/* backing.c */
+int fuse_handle_backing(struct fuse_entry_backing *feb,
+	struct inode **backing_inode, struct path *backing_path);
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index fd48e8d37f2e..404d8cbe5f25 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -35,6 +35,8 @@ struct list_head fuse_conn_list;
 DEFINE_MUTEX(fuse_mutex);
 
 static int set_global_limit(const char *val, const struct kernel_param *kp);
+static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
+	const struct fuse_inode *fi);
 
 unsigned int fuse_max_pages_limit = 256;
 /* default is no timeout */
@@ -195,6 +197,16 @@ static void fuse_evict_inode(struct inode *inode)
 	}
 }
 
+#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
+static void fuse_destroy_inode(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (fi->backing_inode)
+		iput(fi->backing_inode);
+}
+#endif
+
 static int fuse_reconfigure(struct fs_context *fsc)
 {
 	struct super_block *sb = fsc->root->d_sb;
@@ -443,22 +455,93 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 		inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE;
 }
 
+struct fuse_inode_identifier {
+	u64 nodeid;
+	struct inode *backing_inode;
+};
+
 static int fuse_inode_eq(struct inode *inode, void *_nodeidp)
 {
-	u64 nodeid = *(u64 *) _nodeidp;
-	if (get_node_id(inode) == nodeid)
-		return 1;
-	else
-		return 0;
+	struct fuse_inode_identifier *fii =
+		(struct fuse_inode_identifier *) _nodeidp;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return fii->nodeid == fi->nodeid;
+}
+
+static int fuse_inode_backing_eq(struct inode *inode, void *_nodeidp)
+{
+	struct fuse_inode_identifier *fii =
+		(struct fuse_inode_identifier *) _nodeidp;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return fii->nodeid == fi->nodeid
+		&& fii->backing_inode == fi->backing_inode;
 }
 
 static int fuse_inode_set(struct inode *inode, void *_nodeidp)
 {
-	u64 nodeid = *(u64 *) _nodeidp;
-	get_fuse_inode(inode)->nodeid = nodeid;
+	struct fuse_inode_identifier *fii =
+		(struct fuse_inode_identifier *) _nodeidp;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	fi->nodeid = fii->nodeid;
+
+	return 0;
+}
+
+static int fuse_inode_backing_dir_set(struct inode *inode, void *_nodeidp)
+{
+	struct fuse_inode_identifier *fii =
+		(struct fuse_inode_identifier *) _nodeidp;
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	fi->nodeid = fii->nodeid;
+#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
+	fi->backing_inode = fii->backing_inode;
+	if (fi->backing_inode)
+		ihold(fi->backing_inode);
+#endif
+
 	return 0;
 }
 
+struct inode *fuse_iget_backing(struct super_block *sb,
+				struct inode *backing_inode)
+{
+	struct inode *inode;
+	struct fuse_inode *fi;
+	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_inode_identifier fii = {
+		.nodeid = 0,
+		.backing_inode = backing_inode,
+	};
+	struct fuse_attr attr;
+	unsigned long hash = (unsigned long) backing_inode;
+
+	fuse_fill_attr_from_inode(&attr, get_fuse_inode(backing_inode));
+	inode = iget5_locked(sb, hash, fuse_inode_backing_eq,
+			     fuse_inode_backing_dir_set, &fii);
+	if (!inode)
+		return NULL;
+
+	if ((inode->i_state & I_NEW)) {
+		inode->i_flags |= S_NOATIME;
+		if (!fc->writeback_cache)
+			inode->i_flags |= S_NOCMTIME;
+		fuse_init_common(inode);
+		unlock_new_inode(inode);
+	}
+
+	fi = get_fuse_inode(inode);
+	fuse_init_inode(inode, &attr, fc);
+	spin_lock(&fi->lock);
+	fi->nlookup++;
+	spin_unlock(&fi->lock);
+
+	return inode;
+}
+
 struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			int generation, struct fuse_attr *attr,
 			u64 attr_valid, u64 attr_version,
@@ -467,6 +550,9 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	struct inode *inode;
 	struct fuse_inode *fi;
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
+	struct fuse_inode_identifier fii = {
+		.nodeid = nodeid,
+	};
 
 	/*
 	 * Auto mount points get their node id from the submount root, which is
@@ -498,7 +584,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	}
 
 retry:
-	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &nodeid);
+	inode = iget5_locked(sb, nodeid, fuse_inode_eq, fuse_inode_set, &fii);
 	if (!inode)
 		return NULL;
 
@@ -533,13 +619,16 @@ struct inode *fuse_ilookup(struct fuse_conn *fc, u64 nodeid,
 {
 	struct fuse_mount *fm_iter;
 	struct inode *inode;
+	struct fuse_inode_identifier fii = {
+		.nodeid = nodeid,
+	};
 
 	WARN_ON(!rwsem_is_locked(&fc->killsb));
 	list_for_each_entry(fm_iter, &fc->mounts, fc_entry) {
 		if (!fm_iter->sb)
 			continue;
 
-		inode = ilookup5(fm_iter->sb, nodeid, fuse_inode_eq, &nodeid);
+		inode = ilookup5(fm_iter->sb, nodeid, fuse_inode_eq, &fii);
 		if (inode) {
 			if (fm)
 				*fm = fm_iter;
@@ -1072,7 +1161,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 			goto out_err;
 
 		err = fuse_lookup_name(sb, handle->nodeid, &name, &outarg,
-				       &inode);
+				       NULL, &inode);
 		if (err && err != -ENOENT)
 			goto out_err;
 		if (err || !inode) {
@@ -1173,7 +1262,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 		return ERR_PTR(-ESTALE);
 
 	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
-			       &dotdot_name, &outarg, &inode);
+			       &dotdot_name, &outarg, NULL, &inode);
 	if (err) {
 		if (err == -ENOENT)
 			return ERR_PTR(-ESTALE);
@@ -1201,6 +1290,9 @@ static const struct export_operations fuse_export_operations = {
 
 static const struct super_operations fuse_super_operations = {
 	.alloc_inode    = fuse_alloc_inode,
+#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
+	.destroy_inode  = fuse_destroy_inode,
+#endif
 	.free_inode     = fuse_free_inode,
 	.evict_inode	= fuse_evict_inode,
 	.write_inode	= fuse_write_inode,
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5ec43ecbceb7..f1bd8e7734ec 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -690,6 +690,10 @@ struct fuse_entry_out {
 	struct fuse_attr attr;
 };
 
+struct fuse_entry_backing_out {
+	uint64_t	backing_fd;
+};
+
 struct fuse_forget_in {
 	uint64_t	nlookup;
 };
-- 
2.49.0.1112.g889b7c5bd8-goog


