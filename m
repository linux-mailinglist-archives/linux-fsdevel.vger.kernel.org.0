Return-Path: <linux-fsdevel+bounces-53381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16786AEE466
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44151188B90D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A136828FFEC;
	Mon, 30 Jun 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCXqEZwk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636728D8E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300436; cv=none; b=JNGnie7OFKTBpTcMHvXVRedKrJvSWLxBWrLwGiiq3oG4lU+5j0X4fizKPtlMHmpEvmhKLN0PEmdlNdRjgru8t1/fP5GrSQBQqGJAHGCuykWyvjkRMwqLoqZjW3Kg3NIC0dEaKS6LHo4HPIeuRwfCtxBRXVL06oJNTaM6dZJrZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300436; c=relaxed/simple;
	bh=405yist4yMaxw4IS6RXGFCYMQ8sbLn5sxnAxnQbkXig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LUyKKZRJxmLv5T062UPsu3J26CgwXSFaQPHWdp5ge3DT5TxkwD8S0OFEvCYJfo8nCapxG3xcQDcmjjVds7c/jNYOioFeDNoLGfSI+VLGsVqe3z4JDzUkaJ3s4Ol7LijhTtwfRNhflUp27heOO9vp68RSPTLHUJctwVwvPABj6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCXqEZwk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMw1MFnpojtypzHkn05zWpJethntAUQwYfXFArukH0Q=;
	b=PCXqEZwkCnUSDJMR6ErAYpj8eucvVijOgMTxm2OKtV9ISEEgMV2eQXXZpt1yo5PNDTsTry
	yOYEyIMkcwZlDro4ZEtZZ47QcEgPlvo5wzFbwRnkY0uELR6eRV9W0si7VBQkN8U5YFmP+4
	lBD48CAOlXKOQYAucohk6hxEVH1eBHY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-mbuE-pAVOXehlSglV59pnQ-1; Mon, 30 Jun 2025 12:20:30 -0400
X-MC-Unique: mbuE-pAVOXehlSglV59pnQ-1
X-Mimecast-MFC-AGG-ID: mbuE-pAVOXehlSglV59pnQ_1751300430
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451ecc3be97so21049925e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300430; x=1751905230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMw1MFnpojtypzHkn05zWpJethntAUQwYfXFArukH0Q=;
        b=D+WqyWGS0uMy/Vr2QE+lXg0X5IuYIpcAgd/Y6jQpWi2uGYe70sIHE9VRw6z9EbEcPE
         xB2EAalyX4T3gGfPru0kOIK/oZdI4p0t2pwp1WvjZ68yv7BcmLcRi6rZQa0+BKA04Lk/
         ggQFtR2xs9yAdAOKaa0KQOywrgFFRWdoEJDqeWokFKkW7stLyliNSkgXxl6ifRpc2+xA
         qFdLLAmiqeamri2/0EV3C16q5SovxjPwCMZDmbF+epWp+WGZAxT7sHrEJhKST8+mPtLS
         BtGtu9iiu1DHbUk9l3LnwLlnFfY57I1KaC4PBrZMFioWckelswNSM69B6glLJDB3bFzV
         bjVA==
X-Forwarded-Encrypted: i=1; AJvYcCWvGbWw8hLbVgN69Xjfqb1FeP9AO8LEgUWkT+M34teG/Ckl7NoIkkdQDLNdF3fdq6K/uzmVDJmZiXNvRbY4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LsKURTdsrtBO5VckZ+gUz9RehdltQYoUAV7M1gknMeRjCvPF
	DLTbBfl5PM2mbrHfbQ2xfaCEypFqklRcLRchRO90AQB34jaRrzHUcXa9rVG1VR0nHq/kMZInNAm
	HmV89AIBfe4xR5D2yzINLMMFEQxoWFQ8C/EWQvJ7zUTG2p3E4mPgVh+QcKdAM1NriIA==
X-Gm-Gg: ASbGncvhdst0wAsBDd3JHD+zMUacL7/MrBR4BRAEabr4dAj0jobbDt7U3i9ByaP20kw
	e+vL2Hfoy6Kuai+ortywDibZBIbyBw95kV47mS4HjWWDJpKRvf5+grKzPOicBMKJ+zK5nKQAd2c
	mVjrsQkeIMPu0iinPNtefwKcqDGb3dZ2v+DOSssriCj+tKnSpWzZTmKXYbuS384wmuVUCpcwP1g
	3fAIPmrXTvU1GDY5lhsAVVXdHdCLIOkiIHEwc2zPkQyN3wrjuBlGQz53IzmPDnEsDfZoX7Nc1+p
	mLKKalfn0Q4CJc0E653rocrHOpPL
X-Received: by 2002:a05:600c:1e0d:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4538edeb1e3mr161343715e9.0.1751300429457;
        Mon, 30 Jun 2025 09:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdkljFvCKeSQ1u0BXXsAm74xNUPB3nS5Hy8RFzspogoQFN7rnotzQQPQAQkzWhiN8lH4Wb6A==
X-Received: by 2002:a05:600c:1e0d:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4538edeb1e3mr161343255e9.0.1751300428854;
        Mon, 30 Jun 2025 09:20:28 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:28 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 30 Jun 2025 18:20:11 +0200
Subject: [PATCH v6 1/6] fs: split fileattr related helpers into separate
 file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-xattrat-syscall-v6-1-c4e3bc35227b@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=20201; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=A9huJot8yJ6n24cQpc1B4SCSkRw4M/p64ocZxwkwKPA=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpJ2er1/wWyyk5njPCP7QZdlijMtuRYtntI8/6bIl
 f9hYgdWTfnWUcrCIMbFICumyLJOWmtqUpFU/hGDGnmYOaxMIEMYuDgFYCICKxn+5xzeNFFOMV7H
 h+vOUqsjn+db2Sic5D230YBfeLtf7pl7Fgz/DG/eXnvTrev1x0lm/Vt/Pbogs8n2vo4Rx/meOPb
 3Fron2AEDb0hD
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@kernel.org>

This patch moves function related to file extended attributes
manipulations to separate file. Refactoring only.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/Makefile              |   3 +-
 fs/file_attr.c           | 318 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ioctl.c               | 309 ---------------------------------------------
 include/linux/fileattr.h |   4 +
 4 files changed, 324 insertions(+), 310 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 79c08b914c47..334654f9584b 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -15,7 +15,8 @@ obj-y :=	open.o read_write.o file_table.o super.o \
 		pnode.o splice.o sync.o utimes.o d_path.o \
 		stack.o fs_struct.o statfs.o fs_pin.o nsfs.o \
 		fs_types.o fs_context.o fs_parser.o fsopen.o init.o \
-		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o
+		kernel_read_file.o mnt_idmapping.o remap_range.o pidfs.o \
+		file_attr.o
 
 obj-$(CONFIG_BUFFER_HEAD)	+= buffer.o mpage.o
 obj-$(CONFIG_PROC_FS)		+= proc_namespace.o
diff --git a/fs/file_attr.c b/fs/file_attr.c
new file mode 100644
index 000000000000..2910b7047721
--- /dev/null
+++ b/fs/file_attr.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/security.h>
+#include <linux/fscrypt.h>
+#include <linux/fileattr.h>
+
+/**
+ * fileattr_fill_xflags - initialize fileattr with xflags
+ * @fa:		fileattr pointer
+ * @xflags:	FS_XFLAG_* flags
+ *
+ * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
+ * other fields are zeroed.
+ */
+void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
+{
+	memset(fa, 0, sizeof(*fa));
+	fa->fsx_valid = true;
+	fa->fsx_xflags = xflags;
+	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
+		fa->flags |= FS_IMMUTABLE_FL;
+	if (fa->fsx_xflags & FS_XFLAG_APPEND)
+		fa->flags |= FS_APPEND_FL;
+	if (fa->fsx_xflags & FS_XFLAG_SYNC)
+		fa->flags |= FS_SYNC_FL;
+	if (fa->fsx_xflags & FS_XFLAG_NOATIME)
+		fa->flags |= FS_NOATIME_FL;
+	if (fa->fsx_xflags & FS_XFLAG_NODUMP)
+		fa->flags |= FS_NODUMP_FL;
+	if (fa->fsx_xflags & FS_XFLAG_DAX)
+		fa->flags |= FS_DAX_FL;
+	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
+		fa->flags |= FS_PROJINHERIT_FL;
+}
+EXPORT_SYMBOL(fileattr_fill_xflags);
+
+/**
+ * fileattr_fill_flags - initialize fileattr with flags
+ * @fa:		fileattr pointer
+ * @flags:	FS_*_FL flags
+ *
+ * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
+ * All other fields are zeroed.
+ */
+void fileattr_fill_flags(struct fileattr *fa, u32 flags)
+{
+	memset(fa, 0, sizeof(*fa));
+	fa->flags_valid = true;
+	fa->flags = flags;
+	if (fa->flags & FS_SYNC_FL)
+		fa->fsx_xflags |= FS_XFLAG_SYNC;
+	if (fa->flags & FS_IMMUTABLE_FL)
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
+	if (fa->flags & FS_APPEND_FL)
+		fa->fsx_xflags |= FS_XFLAG_APPEND;
+	if (fa->flags & FS_NODUMP_FL)
+		fa->fsx_xflags |= FS_XFLAG_NODUMP;
+	if (fa->flags & FS_NOATIME_FL)
+		fa->fsx_xflags |= FS_XFLAG_NOATIME;
+	if (fa->flags & FS_DAX_FL)
+		fa->fsx_xflags |= FS_XFLAG_DAX;
+	if (fa->flags & FS_PROJINHERIT_FL)
+		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
+}
+EXPORT_SYMBOL(fileattr_fill_flags);
+
+/**
+ * vfs_fileattr_get - retrieve miscellaneous file attributes
+ * @dentry:	the object to retrieve from
+ * @fa:		fileattr pointer
+ *
+ * Call i_op->fileattr_get() callback, if exists.
+ *
+ * Return: 0 on success, or a negative error on failure.
+ */
+int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (!inode->i_op->fileattr_get)
+		return -ENOIOCTLCMD;
+
+	return inode->i_op->fileattr_get(dentry, fa);
+}
+EXPORT_SYMBOL(vfs_fileattr_get);
+
+/**
+ * copy_fsxattr_to_user - copy fsxattr to userspace.
+ * @fa:		fileattr pointer
+ * @ufa:	fsxattr user pointer
+ *
+ * Return: 0 on success, or -EFAULT on failure.
+ */
+int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
+{
+	struct fsxattr xfa;
+
+	memset(&xfa, 0, sizeof(xfa));
+	xfa.fsx_xflags = fa->fsx_xflags;
+	xfa.fsx_extsize = fa->fsx_extsize;
+	xfa.fsx_nextents = fa->fsx_nextents;
+	xfa.fsx_projid = fa->fsx_projid;
+	xfa.fsx_cowextsize = fa->fsx_cowextsize;
+
+	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(copy_fsxattr_to_user);
+
+static int copy_fsxattr_from_user(struct fileattr *fa,
+				  struct fsxattr __user *ufa)
+{
+	struct fsxattr xfa;
+
+	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
+		return -EFAULT;
+
+	fileattr_fill_xflags(fa, xfa.fsx_xflags);
+	fa->fsx_extsize = xfa.fsx_extsize;
+	fa->fsx_nextents = xfa.fsx_nextents;
+	fa->fsx_projid = xfa.fsx_projid;
+	fa->fsx_cowextsize = xfa.fsx_cowextsize;
+
+	return 0;
+}
+
+/*
+ * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
+ * any invalid configurations.
+ *
+ * Note: must be called with inode lock held.
+ */
+static int fileattr_set_prepare(struct inode *inode,
+			      const struct fileattr *old_ma,
+			      struct fileattr *fa)
+{
+	int err;
+
+	/*
+	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
+	 * the relevant capability.
+	 */
+	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
+	    !capable(CAP_LINUX_IMMUTABLE))
+		return -EPERM;
+
+	err = fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags);
+	if (err)
+		return err;
+
+	/*
+	 * Project Quota ID state is only allowed to change from within the init
+	 * namespace. Enforce that restriction only if we are trying to change
+	 * the quota ID state. Everything else is allowed in user namespaces.
+	 */
+	if (current_user_ns() != &init_user_ns) {
+		if (old_ma->fsx_projid != fa->fsx_projid)
+			return -EINVAL;
+		if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
+				FS_XFLAG_PROJINHERIT)
+			return -EINVAL;
+	} else {
+		/*
+		 * Caller is allowed to change the project ID. If it is being
+		 * changed, make sure that the new value is valid.
+		 */
+		if (old_ma->fsx_projid != fa->fsx_projid &&
+		    !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
+			return -EINVAL;
+	}
+
+	/* Check extent size hints. */
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
+			!S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
+	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+		return -EINVAL;
+
+	/*
+	 * It is only valid to set the DAX flag on regular files and
+	 * directories on filesystems.
+	 */
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
+	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
+		return -EINVAL;
+
+	/* Extent size hints of zero turn off the flags. */
+	if (fa->fsx_extsize == 0)
+		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
+	if (fa->fsx_cowextsize == 0)
+		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
+
+	return 0;
+}
+
+/**
+ * vfs_fileattr_set - change miscellaneous file attributes
+ * @idmap:	idmap of the mount
+ * @dentry:	the object to change
+ * @fa:		fileattr pointer
+ *
+ * After verifying permissions, call i_op->fileattr_set() callback, if
+ * exists.
+ *
+ * Verifying attributes involves retrieving current attributes with
+ * i_op->fileattr_get(), this also allows initializing attributes that have
+ * not been set by the caller to current values.  Inode lock is held
+ * thoughout to prevent racing with another instance.
+ *
+ * Return: 0 on success, or a negative error on failure.
+ */
+int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
+		     struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct fileattr old_ma = {};
+	int err;
+
+	if (!inode->i_op->fileattr_set)
+		return -ENOIOCTLCMD;
+
+	if (!inode_owner_or_capable(idmap, inode))
+		return -EPERM;
+
+	inode_lock(inode);
+	err = vfs_fileattr_get(dentry, &old_ma);
+	if (!err) {
+		/* initialize missing bits from old_ma */
+		if (fa->flags_valid) {
+			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
+			fa->fsx_extsize = old_ma.fsx_extsize;
+			fa->fsx_nextents = old_ma.fsx_nextents;
+			fa->fsx_projid = old_ma.fsx_projid;
+			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
+		} else {
+			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
+		}
+		err = fileattr_set_prepare(inode, &old_ma, fa);
+		if (!err)
+			err = inode->i_op->fileattr_set(idmap, dentry, fa);
+	}
+	inode_unlock(inode);
+
+	return err;
+}
+EXPORT_SYMBOL(vfs_fileattr_set);
+
+int ioctl_getflags(struct file *file, unsigned int __user *argp)
+{
+	struct fileattr fa = { .flags_valid = true }; /* hint only */
+	int err;
+
+	err = vfs_fileattr_get(file->f_path.dentry, &fa);
+	if (!err)
+		err = put_user(fa.flags, argp);
+	return err;
+}
+EXPORT_SYMBOL(ioctl_getflags);
+
+int ioctl_setflags(struct file *file, unsigned int __user *argp)
+{
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct dentry *dentry = file->f_path.dentry;
+	struct fileattr fa;
+	unsigned int flags;
+	int err;
+
+	err = get_user(flags, argp);
+	if (!err) {
+		err = mnt_want_write_file(file);
+		if (!err) {
+			fileattr_fill_flags(&fa, flags);
+			err = vfs_fileattr_set(idmap, dentry, &fa);
+			mnt_drop_write_file(file);
+		}
+	}
+	return err;
+}
+EXPORT_SYMBOL(ioctl_setflags);
+
+int ioctl_fsgetxattr(struct file *file, void __user *argp)
+{
+	struct fileattr fa = { .fsx_valid = true }; /* hint only */
+	int err;
+
+	err = vfs_fileattr_get(file->f_path.dentry, &fa);
+	if (!err)
+		err = copy_fsxattr_to_user(&fa, argp);
+
+	return err;
+}
+EXPORT_SYMBOL(ioctl_fsgetxattr);
+
+int ioctl_fssetxattr(struct file *file, void __user *argp)
+{
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
+	struct dentry *dentry = file->f_path.dentry;
+	struct fileattr fa;
+	int err;
+
+	err = copy_fsxattr_from_user(&fa, argp);
+	if (!err) {
+		err = mnt_want_write_file(file);
+		if (!err) {
+			err = vfs_fileattr_set(idmap, dentry, &fa);
+			mnt_drop_write_file(file);
+		}
+	}
+	return err;
+}
+EXPORT_SYMBOL(ioctl_fssetxattr);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 69107a245b4c..0248cb8db2d3 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -453,315 +453,6 @@ static int ioctl_file_dedupe_range(struct file *file,
 	return ret;
 }
 
-/**
- * fileattr_fill_xflags - initialize fileattr with xflags
- * @fa:		fileattr pointer
- * @xflags:	FS_XFLAG_* flags
- *
- * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
- * other fields are zeroed.
- */
-void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
-{
-	memset(fa, 0, sizeof(*fa));
-	fa->fsx_valid = true;
-	fa->fsx_xflags = xflags;
-	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
-		fa->flags |= FS_IMMUTABLE_FL;
-	if (fa->fsx_xflags & FS_XFLAG_APPEND)
-		fa->flags |= FS_APPEND_FL;
-	if (fa->fsx_xflags & FS_XFLAG_SYNC)
-		fa->flags |= FS_SYNC_FL;
-	if (fa->fsx_xflags & FS_XFLAG_NOATIME)
-		fa->flags |= FS_NOATIME_FL;
-	if (fa->fsx_xflags & FS_XFLAG_NODUMP)
-		fa->flags |= FS_NODUMP_FL;
-	if (fa->fsx_xflags & FS_XFLAG_DAX)
-		fa->flags |= FS_DAX_FL;
-	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
-		fa->flags |= FS_PROJINHERIT_FL;
-}
-EXPORT_SYMBOL(fileattr_fill_xflags);
-
-/**
- * fileattr_fill_flags - initialize fileattr with flags
- * @fa:		fileattr pointer
- * @flags:	FS_*_FL flags
- *
- * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
- * All other fields are zeroed.
- */
-void fileattr_fill_flags(struct fileattr *fa, u32 flags)
-{
-	memset(fa, 0, sizeof(*fa));
-	fa->flags_valid = true;
-	fa->flags = flags;
-	if (fa->flags & FS_SYNC_FL)
-		fa->fsx_xflags |= FS_XFLAG_SYNC;
-	if (fa->flags & FS_IMMUTABLE_FL)
-		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
-	if (fa->flags & FS_APPEND_FL)
-		fa->fsx_xflags |= FS_XFLAG_APPEND;
-	if (fa->flags & FS_NODUMP_FL)
-		fa->fsx_xflags |= FS_XFLAG_NODUMP;
-	if (fa->flags & FS_NOATIME_FL)
-		fa->fsx_xflags |= FS_XFLAG_NOATIME;
-	if (fa->flags & FS_DAX_FL)
-		fa->fsx_xflags |= FS_XFLAG_DAX;
-	if (fa->flags & FS_PROJINHERIT_FL)
-		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
-}
-EXPORT_SYMBOL(fileattr_fill_flags);
-
-/**
- * vfs_fileattr_get - retrieve miscellaneous file attributes
- * @dentry:	the object to retrieve from
- * @fa:		fileattr pointer
- *
- * Call i_op->fileattr_get() callback, if exists.
- *
- * Return: 0 on success, or a negative error on failure.
- */
-int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
-{
-	struct inode *inode = d_inode(dentry);
-
-	if (!inode->i_op->fileattr_get)
-		return -ENOIOCTLCMD;
-
-	return inode->i_op->fileattr_get(dentry, fa);
-}
-EXPORT_SYMBOL(vfs_fileattr_get);
-
-/**
- * copy_fsxattr_to_user - copy fsxattr to userspace.
- * @fa:		fileattr pointer
- * @ufa:	fsxattr user pointer
- *
- * Return: 0 on success, or -EFAULT on failure.
- */
-int copy_fsxattr_to_user(const struct fileattr *fa, struct fsxattr __user *ufa)
-{
-	struct fsxattr xfa;
-
-	memset(&xfa, 0, sizeof(xfa));
-	xfa.fsx_xflags = fa->fsx_xflags;
-	xfa.fsx_extsize = fa->fsx_extsize;
-	xfa.fsx_nextents = fa->fsx_nextents;
-	xfa.fsx_projid = fa->fsx_projid;
-	xfa.fsx_cowextsize = fa->fsx_cowextsize;
-
-	if (copy_to_user(ufa, &xfa, sizeof(xfa)))
-		return -EFAULT;
-
-	return 0;
-}
-EXPORT_SYMBOL(copy_fsxattr_to_user);
-
-static int copy_fsxattr_from_user(struct fileattr *fa,
-				  struct fsxattr __user *ufa)
-{
-	struct fsxattr xfa;
-
-	if (copy_from_user(&xfa, ufa, sizeof(xfa)))
-		return -EFAULT;
-
-	fileattr_fill_xflags(fa, xfa.fsx_xflags);
-	fa->fsx_extsize = xfa.fsx_extsize;
-	fa->fsx_nextents = xfa.fsx_nextents;
-	fa->fsx_projid = xfa.fsx_projid;
-	fa->fsx_cowextsize = xfa.fsx_cowextsize;
-
-	return 0;
-}
-
-/*
- * Generic function to check FS_IOC_FSSETXATTR/FS_IOC_SETFLAGS values and reject
- * any invalid configurations.
- *
- * Note: must be called with inode lock held.
- */
-static int fileattr_set_prepare(struct inode *inode,
-			      const struct fileattr *old_ma,
-			      struct fileattr *fa)
-{
-	int err;
-
-	/*
-	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-	 * the relevant capability.
-	 */
-	if ((fa->flags ^ old_ma->flags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
-
-	err = fscrypt_prepare_setflags(inode, old_ma->flags, fa->flags);
-	if (err)
-		return err;
-
-	/*
-	 * Project Quota ID state is only allowed to change from within the init
-	 * namespace. Enforce that restriction only if we are trying to change
-	 * the quota ID state. Everything else is allowed in user namespaces.
-	 */
-	if (current_user_ns() != &init_user_ns) {
-		if (old_ma->fsx_projid != fa->fsx_projid)
-			return -EINVAL;
-		if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
-				FS_XFLAG_PROJINHERIT)
-			return -EINVAL;
-	} else {
-		/*
-		 * Caller is allowed to change the project ID. If it is being
-		 * changed, make sure that the new value is valid.
-		 */
-		if (old_ma->fsx_projid != fa->fsx_projid &&
-		    !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
-			return -EINVAL;
-	}
-
-	/* Check extent size hints. */
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
-			!S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
-	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	/*
-	 * It is only valid to set the DAX flag on regular files and
-	 * directories on filesystems.
-	 */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
-	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
-		return -EINVAL;
-
-	/* Extent size hints of zero turn off the flags. */
-	if (fa->fsx_extsize == 0)
-		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
-	if (fa->fsx_cowextsize == 0)
-		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
-
-	return 0;
-}
-
-/**
- * vfs_fileattr_set - change miscellaneous file attributes
- * @idmap:	idmap of the mount
- * @dentry:	the object to change
- * @fa:		fileattr pointer
- *
- * After verifying permissions, call i_op->fileattr_set() callback, if
- * exists.
- *
- * Verifying attributes involves retrieving current attributes with
- * i_op->fileattr_get(), this also allows initializing attributes that have
- * not been set by the caller to current values.  Inode lock is held
- * thoughout to prevent racing with another instance.
- *
- * Return: 0 on success, or a negative error on failure.
- */
-int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
-		     struct fileattr *fa)
-{
-	struct inode *inode = d_inode(dentry);
-	struct fileattr old_ma = {};
-	int err;
-
-	if (!inode->i_op->fileattr_set)
-		return -ENOIOCTLCMD;
-
-	if (!inode_owner_or_capable(idmap, inode))
-		return -EPERM;
-
-	inode_lock(inode);
-	err = vfs_fileattr_get(dentry, &old_ma);
-	if (!err) {
-		/* initialize missing bits from old_ma */
-		if (fa->flags_valid) {
-			fa->fsx_xflags |= old_ma.fsx_xflags & ~FS_XFLAG_COMMON;
-			fa->fsx_extsize = old_ma.fsx_extsize;
-			fa->fsx_nextents = old_ma.fsx_nextents;
-			fa->fsx_projid = old_ma.fsx_projid;
-			fa->fsx_cowextsize = old_ma.fsx_cowextsize;
-		} else {
-			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
-		}
-		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (!err)
-			err = inode->i_op->fileattr_set(idmap, dentry, fa);
-	}
-	inode_unlock(inode);
-
-	return err;
-}
-EXPORT_SYMBOL(vfs_fileattr_set);
-
-static int ioctl_getflags(struct file *file, unsigned int __user *argp)
-{
-	struct fileattr fa = { .flags_valid = true }; /* hint only */
-	int err;
-
-	err = vfs_fileattr_get(file->f_path.dentry, &fa);
-	if (!err)
-		err = put_user(fa.flags, argp);
-	return err;
-}
-
-static int ioctl_setflags(struct file *file, unsigned int __user *argp)
-{
-	struct mnt_idmap *idmap = file_mnt_idmap(file);
-	struct dentry *dentry = file->f_path.dentry;
-	struct fileattr fa;
-	unsigned int flags;
-	int err;
-
-	err = get_user(flags, argp);
-	if (!err) {
-		err = mnt_want_write_file(file);
-		if (!err) {
-			fileattr_fill_flags(&fa, flags);
-			err = vfs_fileattr_set(idmap, dentry, &fa);
-			mnt_drop_write_file(file);
-		}
-	}
-	return err;
-}
-
-static int ioctl_fsgetxattr(struct file *file, void __user *argp)
-{
-	struct fileattr fa = { .fsx_valid = true }; /* hint only */
-	int err;
-
-	err = vfs_fileattr_get(file->f_path.dentry, &fa);
-	if (!err)
-		err = copy_fsxattr_to_user(&fa, argp);
-
-	return err;
-}
-
-static int ioctl_fssetxattr(struct file *file, void __user *argp)
-{
-	struct mnt_idmap *idmap = file_mnt_idmap(file);
-	struct dentry *dentry = file->f_path.dentry;
-	struct fileattr fa;
-	int err;
-
-	err = copy_fsxattr_from_user(&fa, argp);
-	if (!err) {
-		err = mnt_want_write_file(file);
-		if (!err) {
-			err = vfs_fileattr_set(idmap, dentry, &fa);
-			mnt_drop_write_file(file);
-		}
-	}
-	return err;
-}
-
 static int ioctl_getfsuuid(struct file *file, void __user *argp)
 {
 	struct super_block *sb = file_inode(file)->i_sb;
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 47c05a9851d0..6030d0bf7ad3 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -55,5 +55,9 @@ static inline bool fileattr_has_fsx(const struct fileattr *fa)
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		     struct fileattr *fa);
+int ioctl_getflags(struct file *file, unsigned int __user *argp);
+int ioctl_setflags(struct file *file, unsigned int __user *argp);
+int ioctl_fsgetxattr(struct file *file, void __user *argp);
+int ioctl_fssetxattr(struct file *file, void __user *argp);
 
 #endif /* _LINUX_FILEATTR_H */

-- 
2.47.2


