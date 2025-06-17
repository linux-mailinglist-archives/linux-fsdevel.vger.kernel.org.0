Return-Path: <linux-fsdevel+bounces-51986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61977ADDE9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E367A3FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187442980B0;
	Tue, 17 Jun 2025 22:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QyX9T05P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0B22980A1
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 22:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198525; cv=none; b=KconK4Oc4eB4Feb7ygft3WCVqpHQM0dk3w7pYfVp2awND5d+zzlpKYoznmMCDBI5rdUu43Tx8ywUcBiastpGhT15s1CSSNP0kILzwfLbCeGWkr7Ya6Cd5tUrNWNL7DCDQkldl/Vg9ghj1pKdmOVOu8aXnT3pi13iPD6gpTHOc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198525; c=relaxed/simple;
	bh=FFWNTKvzri1cH3Wbyv4g1IAG9PgKcFE9SJcaiySPcKw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r8F4ybzjR9nS0POv921IEJL1GjFcKXkLvbO0pCpuLlWJnC+EYVxZlY7sKIL4nfvxCV/zd3NaVOmjsXRPsYl+R9sWpbZpWS9mIFdcmFOpVYfECzBipNN3QQu6j3xsMr8WwAMFI1IzYJ9wrDU+bjw3JIIu1tz3jqTYlNcaZydfiIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QyX9T05P; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--paullawrence.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b115383fcecso4000478a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Jun 2025 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750198523; x=1750803323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YiiJDii3e/1E9h1xyTOh07ocmo2tEpRDvB1I6e8ccIw=;
        b=QyX9T05P1ize9qZoDTkRVv3vbnlh4wRw7NHXLJ64WzJGrzjp/Q3w/bPQsmlY+AU73u
         Smb4Xcos3/m5UALbJS2I/KZ7clizP5EGQXzuzBcMciMoIwFuJsW2JO4t+DvHFFtBAqOf
         3/LB/IrSonZGUQlfH52L+rtSnxU5Vb/qC4XXuoVExYlCDevn4r4PxsrdJzSiNKUxgdvo
         5IQcbTSunvJZRPDOZp9RR4LFcxHIaq2Mtbpx3cKJ3QJVB4ygxEDY7vr4XrW4VmU6rJPw
         TnZHszF3S4rVhKFnoRzl+aCnlkCNwetHC/TEBv/9CjaZIbZUc8G9rNiBfsociQpKcD/0
         SjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750198523; x=1750803323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiiJDii3e/1E9h1xyTOh07ocmo2tEpRDvB1I6e8ccIw=;
        b=bJn815DtizbM05dVjgdZFShm/yVES9qkIu6ezUVZhKDYl6fgqPUyPF5pFV6dftQdI+
         LD1ormJzt/3hazwLQEE8HjcIQnDErn7tWw1sDqI8FAsQ7nZz6vH4LVZdej1WrkWmAhLr
         m0sEmfMk5tFYfHJjqBTLzC1dSfVy6+o/DhfOg+OXbae6klmYhml2JbSH2PRkTcM+E0Bl
         WjbWYX45LpyN9J0IT+nmz5t7VmN26ekUdOvj/knr8QdPGb/z/e/Sr067k0k3YCh1kqgI
         rsVwlyTC/xkrL95/aBtoUcTNISjET37uakDD8oBlrJUL/8BrKfCw8ogSALU7GlXAbLLD
         24pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTZCgptnLrsqKYxDWNbZSPAHZxst3eJPmFEPm6XNbsI3hu09aFcjvdpQ1yk+R5Q4ZZJ1bO8th6xksCBNn4@vger.kernel.org
X-Gm-Message-State: AOJu0YxW93kTgkQgP4WrpeV+N0v4QkEPxtGmuhHje6S/xwDMKdlO/MrC
	Zktxq/mh8QVs66SBZMsiy/XYToUO1VqmFsQeplHgnHLBR0q2NnKOFiLEoCEfjnkyf8MTzH0V8gZ
	9DnjVJQxDaT+/4xqWI43U72jjwPVLXQ==
X-Google-Smtp-Source: AGHT+IEixQwwCtMPZRMitwflJn+MCNzNcpkE0nQ6bs8Ogs5i3eXyrNXuFEV7NYlLJ90/9v4833OID4nJ/hWxw3RrBEI=
X-Received: from pjxx16.prod.google.com ([2002:a17:90b:58d0:b0:312:2b3:7143])
 (user=paullawrence job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1805:b0:311:c5d9:2c7c with SMTP id 98e67ed59e1d1-313f1daa6b2mr21592430a91.23.1750198523160;
 Tue, 17 Jun 2025 15:15:23 -0700 (PDT)
Date: Tue, 17 Jun 2025 15:14:54 -0700
In-Reply-To: <20250617221456.888231-1-paullawrence@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com>
X-Mailer: git-send-email 2.50.0.rc2.696.g1fc2a0284f-goog
Message-ID: <20250617221456.888231-3-paullawrence@google.com>
Subject: [PATCH v1 2/2] fuse: open/close backing file
From: Paul Lawrence <paullawrence@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for opening and closing the backing file on a passthrough
directory.

* Add backing file to fuse file
* Add fuse_inode_has_backing - this is how we will detect whether to use
  traditional fuse operations or the added backing file operations
* Add backing operations to open, flush and close

Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dir.c     | 16 -----------
 fs/fuse/file.c    | 34 ++++++++++++++++--------
 fs/fuse/fuse_i.h  | 39 +++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 1dcc617bf660..04265bd06695 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -6,6 +6,64 @@
 
 #include "fuse_i.h"
 
+#include <linux/backing-file.h>
+
+int fuse_open_backing(struct inode *inode, struct file *file, bool isdir)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_file *ff;
+	int retval;
+	int mask;
+	union fuse_dentry *fd = get_fuse_dentry(file->f_path.dentry);
+	struct file *backing_file;
+	uint32_t flags = file->f_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
+
+	ff = fuse_file_alloc(fm, true);
+	if (!ff)
+		return -ENOMEM;
+
+	switch (flags & O_ACCMODE) {
+	case O_RDONLY:
+		mask = MAY_READ;
+		break;
+
+	case O_WRONLY:
+		mask = MAY_WRITE;
+		break;
+
+	case O_RDWR:
+		mask = MAY_READ | MAY_WRITE;
+		break;
+
+	default:
+		retval = -EINVAL;
+		goto outerr;
+	}
+
+	retval = inode_permission(&nop_mnt_idmap,
+				  get_fuse_inode(inode)->backing_inode, mask);
+	if (retval)
+		goto outerr;
+
+	backing_file = backing_file_open(&file->f_path, file->f_flags,
+		&fd->backing_path, current_cred());
+
+	if (IS_ERR(backing_file)) {
+		retval = PTR_ERR(backing_file);
+		goto outerr;
+	}
+
+	ff->backing_file = backing_file;
+	ff->nodeid = get_fuse_inode(inode)->nodeid;
+	file->private_data = ff;
+	return 0;
+
+outerr:
+	if (retval)
+		fuse_file_free(ff);
+	return retval;
+}
+
 int fuse_handle_backing(struct fuse_entry_backing *feb,
 	struct inode **backing_inode, struct path *backing_path)
 {
@@ -27,3 +85,13 @@ int fuse_handle_backing(struct fuse_entry_backing *feb,
 
 	return 0;
 }
+
+int fuse_flush_backing(struct file *file, fl_owner_t id)
+{
+	struct fuse_file *fuse_file = file->private_data;
+	struct file *backing_file = fuse_file->backing_file;
+
+	if (backing_file->f_op->flush)
+		return backing_file->f_op->flush(backing_file, id);
+	return 0;
+}
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 909463fae94d..658898f324b5 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -44,18 +44,7 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 {
 	return (u64)entry->d_fsdata;
 }
-
 #else
-union fuse_dentry {
-	struct {
-		u64 time;
-#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
-		struct path backing_path;
-#endif
-	};
-	struct rcu_head rcu;
-};
-
 static inline void __fuse_dentry_settime(struct dentry *dentry, u64 time)
 {
 	((union fuse_dentry *) dentry->d_fsdata)->time = time;
@@ -65,11 +54,6 @@ static inline u64 fuse_dentry_time(const struct dentry *entry)
 {
 	return ((union fuse_dentry *) entry->d_fsdata)->time;
 }
-
-static inline union fuse_dentry *get_fuse_dentry(const struct dentry *entry)
-{
-	return entry->d_fsdata;
-}
 #endif
 
 static void fuse_dentry_settime(struct dentry *dentry, u64 time)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 754378dd9f71..0cd0a94073c7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -21,6 +21,7 @@
 #include <linux/filelock.h>
 #include <linux/splice.h>
 #include <linux/task_io_accounting_ops.h>
+#include <linux/file.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -105,19 +106,24 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 		struct fuse_release_args *ra = &ff->args->release_args;
 		struct fuse_args *args = (ra ? &ra->args : NULL);
 
-		if (ra && ra->inode)
-			fuse_file_io_release(ff, ra->inode);
-
-		if (!args) {
-			/* Do nothing when server does not implement 'open' */
-		} else if (sync) {
-			fuse_simple_request(ff->fm, args);
+		if (ff->backing_file) {
 			fuse_release_end(ff->fm, args, 0);
+			fput(ff->backing_file);
 		} else {
-			args->end = fuse_release_end;
-			if (fuse_simple_background(ff->fm, args,
-						   GFP_KERNEL | __GFP_NOFAIL))
-				fuse_release_end(ff->fm, args, -ENOTCONN);
+			if (ra && ra->inode)
+				fuse_file_io_release(ff, ra->inode);
+
+			if (!args) {
+				/* Do nothing when server does not implement 'open' */
+			} else if (sync) {
+				fuse_simple_request(ff->fm, args);
+				fuse_release_end(ff->fm, args, 0);
+			} else {
+				args->end = fuse_release_end;
+				if (fuse_simple_background(ff->fm, args,
+							GFP_KERNEL | __GFP_NOFAIL))
+					fuse_release_end(ff->fm, args, -ENOTCONN);
+			}
 		}
 		kfree(ff);
 	}
@@ -248,6 +254,9 @@ static int fuse_open(struct inode *inode, struct file *file)
 	if (err)
 		return err;
 
+	if (fuse_inode_has_backing(inode))
+		return fuse_open_backing(inode, file, false);
+
 	if (is_wb_truncate || dax_truncate)
 		inode_lock(inode);
 
@@ -522,6 +531,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	FUSE_ARGS(args);
 	int err;
 
+	if (fuse_inode_has_backing(file->f_inode))
+		return fuse_flush_backing(file, id);
+
 	if (fuse_is_bad(inode))
 		return -EIO;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1dc04bc6ac49..a27c05810bab 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -96,6 +96,25 @@ struct fuse_submount_lookup {
 	struct fuse_forget_link *forget;
 };
 
+
+/** FUSE specific dentry data */
+#if BITS_PER_LONG < 64 || defined(CONFIG_FUSE_PASSTHROUGH_DIR)
+union fuse_dentry {
+	struct {
+		u64 time;
+#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
+		struct path backing_path;
+#endif
+	};
+	struct rcu_head rcu;
+};
+
+static inline union fuse_dentry *get_fuse_dentry(const struct dentry *entry)
+{
+	return entry->d_fsdata;
+}
+#endif
+
 /** Container for data related to mapping to backing file */
 struct fuse_backing {
 	struct file *file;
@@ -287,6 +306,14 @@ struct fuse_file {
 
 	} readdir;
 
+#ifdef CONFIG_FUSE_PASSTHROUGH_DIR
+	/**
+	 * TODO: Reconcile with passthrough file
+	 * backing file when in bpf mode
+	 */
+	struct file *backing_file;
+#endif
+
 	/** RB node to be linked on fuse_conn->polled_files */
 	struct rb_node polled_node;
 
@@ -1597,4 +1624,16 @@ extern void fuse_sysctl_unregister(void);
 /* backing.c */
 int fuse_handle_backing(struct fuse_entry_backing *feb,
 	struct inode **backing_inode, struct path *backing_path);
+
+
+static inline bool fuse_inode_has_backing(struct inode *inode)
+{
+	struct fuse_inode *fuse_inode = get_fuse_inode(inode);
+
+	return fuse_inode && fuse_inode->backing_inode;
+}
+
+int fuse_open_backing(struct inode *inode, struct file *file, bool isdir);
+int fuse_flush_backing(struct file *file, fl_owner_t id);
+
 #endif /* _FS_FUSE_I_H */
-- 
2.49.0.1112.g889b7c5bd8-goog


