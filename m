Return-Path: <linux-fsdevel+bounces-10793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3884E65D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF72904CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FDC12839A;
	Thu,  8 Feb 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlvaBWwl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D312838B
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412162; cv=none; b=LMfzw1mTIUoTndilBbK+apqlwnCJPkEBjvA7J4A/zCjA+wfWURzkZ5+/OZoszqTYAkORTk57RbaGEqbnpEb/ygEh26Ild7fdUWO+7kvibC0/2HP4bL0LVkNSBvbJp+aBmJjgaaaz8Y1HoHWsvj86QT8OUepJkzb1+M3xE+RIR2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412162; c=relaxed/simple;
	bh=Y4a8ONmfy01zSl12XVG7MMpHubS8p2u6Bb2qN+lS/og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7tvKluoaDLlXNg7nRgqTaGw0dUJlBz3J/Pwshx2Vv7/wkAEtYaODCQl8/pNxBXV6YQvrdua7f8LHNzTRw3pO4Gtsnd+Go4mZu/oCWs3KT86bWJFpTNMpzEyL9qmvK5TrxA5m8eLl6goW1RTnvgYaHLAc/Lp9V7nvuaL0YvWJvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlvaBWwl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-337d05b8942so1512880f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412158; x=1708016958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+07QqCKnKNNFqRpLri+3VdoKGKW2WdyvdWnhUQL2uTc=;
        b=NlvaBWwlcVcevCOYTCF+7IqX1GRKVc1mwoV25iO0hLqCi9U6A1tsIOzimOs+nWtvbT
         UEgLCm4uVRD6qEYqnJ8leXkLbspEYa2X0GRUiL0rWq77idZy5LTCpZPmXQLsm+D+5q4M
         P+KqOnu+wHB8FslaKx/+hAQkwj7gawMZbH7JRd1TRQ99eA4RyUcMKZYIUgMAepKK0ICL
         1qFzyGXY5SSxpxCxJ53DFGAwyo7IRDU1oJMSRD9o3mjFd0YR7nXZhLoXKEaDX+G53seX
         Div5X6FtG6tSUR6meJCVm1npLzM583ZrEbbhax3zAVyBU3sH3tX9gWoz+yy7806Cdvgo
         lztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412158; x=1708016958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+07QqCKnKNNFqRpLri+3VdoKGKW2WdyvdWnhUQL2uTc=;
        b=uLGfVGI5Ed2vcd1Vt8WxminJebPFkV15nwIURkII/bJWvN6c4GyHL9/R9aaej54XdX
         /jx/5aNzJCYzYnThutril2kx6L5ehkHcsj9DWrR5V/oLFO6SN+mlF+XvtmzGW3bri5u2
         6VjA2BJ51joMwlw85TR0axZIxuGYT20OzwKb4DxSjwv0aIAssiyAncbrh/k0PhJ3dLUA
         1JQ1uuAa4fAmIYpnlw9FIaKNlHFgh+hksQabLLdiMFaUeo6tWahTL79U67d9fJ/sLmpM
         gR6VNeQP/592sLLRSlTGf5xSPiQyWphgqHyRPOEugDbDMI//rUDv7kkmTY14kTVXz/U9
         YhUw==
X-Gm-Message-State: AOJu0YwlP064aqN/jatroBNXWuBWEQGmdwq1qIMCfa1TNP/vDpJP+Mi9
	unGakvavMlVYNq7r8G8mX9UICVUYG4C2JNQSLH3QuL6jxg7nCPPesKzj8Bcv
X-Google-Smtp-Source: AGHT+IHEoEYC8i8wtUbfspgfJlgjTjX/h9yO2iqOy/zvUEbgXEajLhA4VUhYEPg2IDM0W47AxNpQpQ==
X-Received: by 2002:a5d:594f:0:b0:33a:e67f:cf8 with SMTP id e15-20020a5d594f000000b0033ae67f0cf8mr68892wri.20.1707412158028;
        Thu, 08 Feb 2024 09:09:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2yxJAGsL/P+uWbf1xNfXW4r23g3GJZlXv6NpxNZYDxOA0pihK5A7tkbaJwTVC4kogv8KMHeoludUo77zqEcOX2lpqrlTIXcOvyeKpBP+WHkC550oMVRP9JFG2bNGOajE=
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:09:14 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 8/9] fuse: introduce inode io modes
Date: Thu,  8 Feb 2024 19:06:02 +0200
Message-Id: <20240208170603.2078871-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170603.2078871-1-amir73il@gmail.com>
References: <20240208170603.2078871-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fuse inode io mode is determined by the mode of its open files/mmaps
and parallel dio opens and expressed in the value of fi->iocachectr:

 > 0 - caching io: files open in caching mode or mmap on direct_io file
 < 0 - parallel dio: direct io mode with parallel dio writes enabled
== 0 - direct io: no files open in caching mode and no files mmaped

Note that iocachectr value of 0 might become positive or negative,
while non-parallel dio is getting processed.

We use an internal FOPEN_CACHE_IO flag to mark a file that was open in
caching mode. This flag can not be set by the server.

direct_io mmap uses page cache, so first mmap will mark the file as
FOPEN_DIRECT_IO|FOPEN_CACHE_IO (i.e. mixed mode) and inode will enter
the caching io mode.

If the server opens the file in caching mode while it is already open
for parallel dio or vice versa the open fails.

This allows executing parallel dio when inode is not in caching mode
and no mmaps have been performed on the inode in question.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/Makefile          |   1 +
 fs/fuse/file.c            |  17 +++
 fs/fuse/fuse_i.h          |  21 +++-
 fs/fuse/iomode.c          | 218 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |   2 +
 5 files changed, 257 insertions(+), 2 deletions(-)
 create mode 100644 fs/fuse/iomode.c

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 0c48b35c058d..b734cc2a5e65 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
 fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
+fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 52181c69a527..29e18e5a6f6c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -113,6 +113,9 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 		struct fuse_release_args *ra = ff->release_args;
 		struct fuse_args *args = (ra ? &ra->args : NULL);
 
+		if (ra && ra->inode)
+			fuse_file_io_release(ff, ra->inode);
+
 		if (!args) {
 			/* Do nothing when server does not implement 'open' */
 		} else if (sync) {
@@ -204,6 +207,11 @@ int fuse_finish_open(struct inode *inode, struct file *file)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	int err;
+
+	err = fuse_file_io_open(file, inode);
+	if (err)
+		return err;
 
 	if (ff->open_flags & FOPEN_STREAM)
 		stream_open(inode, file);
@@ -2507,6 +2515,7 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fm->fc;
+	int rc;
 
 	/* DAX mmap is superior to direct_io mmap */
 	if (FUSE_IS_DAX(file_inode(file)))
@@ -2522,6 +2531,13 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 		invalidate_inode_pages2(file->f_mapping);
 
+		/*
+		 * First mmap of direct_io file enters caching inode io mode.
+		 */
+		rc = fuse_file_io_mmap(ff, file_inode(file));
+		if (rc)
+			return rc;
+
 		if (!(vma->vm_flags & VM_MAYSHARE)) {
 			/* MAP_PRIVATE */
 			return generic_file_mmap(file, vma);
@@ -3294,6 +3310,7 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
 	fi->writectr = 0;
+	fi->iocachectr = 0;
 	init_waitqueue_head(&fi->page_waitq);
 	fi->writepages = RB_ROOT;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 9ad5f882bd0a..5e5465f6a1ac 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -111,7 +111,7 @@ struct fuse_inode {
 	u64 attr_version;
 
 	union {
-		/* Write related fields (regular file only) */
+		/* read/write io cache (regular file only) */
 		struct {
 			/* Files usable in writepage.  Protected by fi->lock */
 			struct list_head write_files;
@@ -123,6 +123,9 @@ struct fuse_inode {
 			 * (FUSE_NOWRITE) means more writes are blocked */
 			int writectr;
 
+			/** Number of files/maps using page cache */
+			int iocachectr;
+
 			/* Waitq for writepage completion */
 			wait_queue_head_t page_waitq;
 
@@ -187,6 +190,8 @@ enum {
 	FUSE_I_BAD,
 	/* Has btime */
 	FUSE_I_BTIME,
+	/* Wants or already has page cache IO */
+	FUSE_I_CACHE_IO_MODE,
 };
 
 struct fuse_conn;
@@ -246,6 +251,9 @@ struct fuse_file {
 
 	/** Has flock been performed on this file? */
 	bool flock:1;
+
+	/** Was file opened for io? */
+	bool io_opened:1;
 };
 
 /** One input argument of a request */
@@ -1346,8 +1354,17 @@ int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa);
 
-/* file.c */
+/* iomode.c */
+int fuse_file_cached_io_start(struct inode *inode);
+void fuse_file_cached_io_end(struct inode *inode);
+int fuse_file_uncached_io_start(struct inode *inode);
+void fuse_file_uncached_io_end(struct inode *inode);
 
+int fuse_file_io_open(struct file *file, struct inode *inode);
+int fuse_file_io_mmap(struct fuse_file *ff, struct inode *inode);
+void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
+
+/* file.c */
 struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 				 unsigned int open_flags, bool isdir);
 void fuse_file_release(struct inode *inode, struct fuse_file *ff,
diff --git a/fs/fuse/iomode.c b/fs/fuse/iomode.c
new file mode 100644
index 000000000000..13faae77aec4
--- /dev/null
+++ b/fs/fuse/iomode.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE inode io modes.
+ *
+ * Copyright (c) 2024 CTERA Networks.
+ */
+
+#include "fuse_i.h"
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+
+/*
+ * Request an open in caching mode.
+ * Return 0 if in caching mode.
+ */
+static int fuse_inode_get_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (fi->iocachectr < 0)
+		return -ETXTBSY;
+	if (fi->iocachectr++ == 0)
+		set_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+	return 0;
+}
+
+/*
+ * Release an open in caching mode.
+ * Return 0 if in neutral (direct io) mode.
+ */
+static int fuse_inode_put_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (WARN_ON(fi->iocachectr <= 0))
+		return -EIO;
+	if (--fi->iocachectr == 0)
+		clear_bit(FUSE_I_CACHE_IO_MODE, &fi->state);
+	return fi->iocachectr;
+}
+
+/*
+ * Requets to deny new opens in caching mode.
+ * Return 0 if denying new opens in caching mode.
+ */
+static int fuse_inode_deny_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (fi->iocachectr > 0)
+		return -ETXTBSY;
+	fi->iocachectr--;
+	return 0;
+}
+
+/*
+ * Release a request to deny open in caching mode.
+ * Return 0 if allowing new opens in caching mode.
+ */
+static int fuse_inode_allow_io_cache(struct fuse_inode *fi)
+{
+	assert_spin_locked(&fi->lock);
+	if (WARN_ON(fi->iocachectr >= 0))
+		return -EIO;
+	fi->iocachectr++;
+	return -fi->iocachectr;
+}
+
+/* Start cached io mode where parallel dio writes are not allowed */
+int fuse_file_cached_io_start(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	int err;
+
+	spin_lock(&fi->lock);
+	err = fuse_inode_get_io_cache(fi);
+	spin_unlock(&fi->lock);
+	return err;
+}
+
+void fuse_file_cached_io_end(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	spin_lock(&fi->lock);
+	fuse_inode_put_io_cache(get_fuse_inode(inode));
+	spin_unlock(&fi->lock);
+}
+
+/* Start strictly uncached io mode where cache access is not allowed */
+int fuse_file_uncached_io_start(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	int err;
+
+	spin_lock(&fi->lock);
+	err = fuse_inode_deny_io_cache(fi);
+	spin_unlock(&fi->lock);
+	return err;
+}
+
+void fuse_file_uncached_io_end(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	spin_lock(&fi->lock);
+	fuse_inode_allow_io_cache(fi);
+	spin_unlock(&fi->lock);
+}
+
+/* Open flags to determine regular file io mode */
+#define FOPEN_IO_MODE_MASK \
+	(FOPEN_DIRECT_IO | FOPEN_CACHE_IO)
+
+/* Request access to submit new io to inode via open file */
+int fuse_file_io_open(struct file *file, struct inode *inode)
+{
+	struct fuse_file *ff = file->private_data;
+	int iomode_flags = ff->open_flags & FOPEN_IO_MODE_MASK;
+	int err;
+
+	err = -EBADF;
+	if (WARN_ON(!S_ISREG(inode->i_mode)))
+		goto fail;
+
+	err = -EBUSY;
+	if (WARN_ON(ff->io_opened))
+		goto fail;
+
+	/*
+	 * io modes are not relevant with DAX and with server that does not
+	 * implement open.
+	 */
+	err = -EINVAL;
+	if (FUSE_IS_DAX(inode) || !ff->release_args) {
+		if (iomode_flags)
+			goto fail;
+		return 0;
+	}
+
+	/*
+	 * FOPEN_CACHE_IO is an internal flag that is set on file not open in
+	 * direct io mode and it cannot be set explicitly by the server.
+	 * This includes a file open with O_DIRECT, but server did not specify
+	 * FOPEN_DIRECT_IO. In this case, a later fcntl() could remove O_DIRECT,
+	 * so we put the inode in caching mode to prevent parallel dio.
+	 * FOPEN_PARALLEL_DIRECT_WRITES requires FOPEN_DIRECT_IO.
+	 */
+	if (ff->open_flags & FOPEN_CACHE_IO) {
+		goto fail;
+	} else if (!(ff->open_flags & FOPEN_DIRECT_IO)) {
+		ff->open_flags |= FOPEN_CACHE_IO;
+		ff->open_flags &= ~FOPEN_PARALLEL_DIRECT_WRITES;
+	}
+
+	/*
+	 * First caching file open enters caching inode io mode.
+	 * First parallel dio open denies caching inode io mode.
+	 */
+	err = 0;
+	if (ff->open_flags & FOPEN_CACHE_IO)
+		err = fuse_file_cached_io_start(inode);
+	else if (ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES)
+		err = fuse_file_uncached_io_start(inode);
+	if (err)
+		goto fail;
+
+	ff->io_opened = true;
+	return 0;
+
+fail:
+	pr_debug("failed to open file in requested io mode (open_flags=0x%x, err=%i).\n",
+		 ff->open_flags, err);
+	/*
+	 * The file open mode determines the inode io mode.
+	 * Using incorrect open mode is a server mistake, which results in
+	 * user visible failure of open() with EIO error.
+	 */
+	return -EIO;
+}
+
+/* Request access to submit new io to inode via mmap */
+int fuse_file_io_mmap(struct fuse_file *ff, struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	int err = 0;
+
+	/* There are no io modes if server does not implement open */
+	if (!ff->release_args)
+		return 0;
+
+	if (WARN_ON(!ff->io_opened))
+		return -ENODEV;
+
+	spin_lock(&fi->lock);
+	/* First mmap of direct_io file enters caching inode io mode */
+	if (!(ff->open_flags & FOPEN_CACHE_IO)) {
+		err = fuse_inode_get_io_cache(fi);
+		if (!err)
+			ff->open_flags |= FOPEN_CACHE_IO;
+	}
+	spin_unlock(&fi->lock);
+
+	return err;
+}
+
+/* No more pending io and no new io possible to inode via open/mmapped file */
+void fuse_file_io_release(struct fuse_file *ff, struct inode *inode)
+{
+	if (!ff->io_opened)
+		return;
+
+	/* Last caching file close exits caching inode io mode */
+	if (ff->open_flags & FOPEN_CACHE_IO)
+		fuse_file_cached_io_end(inode);
+
+	ff->io_opened = false;
+}
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e7418d15fe39..1f452d9a5024 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -353,6 +353,7 @@ struct fuse_file_lock {
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
  * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
+ * FOPEN_CACHE_IO: internal flag for mmap of direct_io (resereved for future use)
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -361,6 +362,7 @@ struct fuse_file_lock {
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
 #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
+#define FOPEN_CACHE_IO		(1 << 7)
 
 /**
  * INIT request/reply flags
-- 
2.34.1


