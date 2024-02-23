Return-Path: <linux-fsdevel+bounces-12607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF655861A54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06ADC1C2343A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3131448D3;
	Fri, 23 Feb 2024 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgtNX9H+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9452143C6A;
	Fri, 23 Feb 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710174; cv=none; b=ju1/kkSi/VB/IkGJwloo24rF9Q/Gp2dz0+kkgb15t+eXsJQWgd5jHIv2+dzky6nUTQwBy9EytRt/UJ8yL7cdUp9NFsRPeARxCsZiMktxYVZn+DOAwsbN292fN9/Jy2lhSXQ2bUkzGZ3YxEGUJgNzOHWS+5v1SEkDM+rlV4lTjnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710174; c=relaxed/simple;
	bh=VCUvYUMBePLjAnqLXIh0xC3E0ySm6TUv3Sa00+ZpFwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZ7x0dKWCC/hWhNDHW8lWITYfPJ/zsx0AlcQ0ZCkQRcaI/v8VC1G0hZLfzLN4xZ3Z7LxEZd1oG/N9/AZfAxUBKJ5evAoPgEiaMq3ad7XiDd+5zpVyXjlLxr8ZmNX2XYo7uuTSWHqkcQfYBKcthyFoEEhwf9YN80qsh92c25gAPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgtNX9H+; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21f70f72fb5so627842fac.1;
        Fri, 23 Feb 2024 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710172; x=1709314972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6QjmLkc27iMh7yi/z9o9l9CtGVPifxNLsali304Bg4=;
        b=RgtNX9H+kqUWjxLDyFr2RFG9MQRbtobQujYZvqCo1BjLgI9OLOcgkUzyhLlcRCLJoj
         M0fS9+4xJdC0A9THjSXQnxuJIO1QYaPMAnrXV4AqgCA6p3cOBNl8c9JERglzWOstd8O+
         22y/9lbsgetJiXmdBp6PJFNHH6bpfBbQr6R//BpvEFDf2kcQKMLJ7ZXoNDcURWW+t+0U
         0SZwoOIp3d+eYjIswQ1jKHLHj70CTyHVhyxH56qoABwMSv31LqXhvrr8KLKElTYENSsf
         es4r3jTZsSGcdN4fJOpoyRT1aDYALD1c2LoKDbN2DmUIZchryxJFZ6vFfhqFhVztHUuC
         sI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710172; x=1709314972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p6QjmLkc27iMh7yi/z9o9l9CtGVPifxNLsali304Bg4=;
        b=F3tQT/Tz1jktYzfDGtXTaqeCrl4gCCAbuE8zpwSz3j0CPIoY4f4kzOiAdsVsnj5kMu
         +EyiOiFc8ECVmnM4h4WiDFxLwb1f5FocFeOEQm66K4t1WFuw8Wm0KHDh589Ze0+fIJkE
         srnYamTfTq4L9PkIqP2Nnzf/OHlGnpl8ayhkXwWXArbluWdFhADRcxaqdJO+bzU5qdfh
         90G8rgptjshUAR9chvLrWuoGuUy4HqBPnLBh8K65lr8arxBdV/u4H/CYJeYSnZ1jzrN1
         zJiqjgGcb/P+7bnTTNOrLSgj2lkjrp8i+9v0YMQItDRg57rrKfc8jJY0ZEOBW9lCNn1d
         sIGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFpEp8yQn2e8FgUbPKR0Em8leuiKlDlYcLPbNsiM1Ym5qR2XLDqh/jxKgmF5SQbQDJTeQQUfXcfNKxjt8FvMwR1p24cqImG8TVrlnXWP1Q3iUApj8ujor6pBXYd4L5wp/fjlxhH5Rk0373Fi06IM3SuqQylhob9mpczo0QZiPiPzhtRSkm49qdyfhvRp/DlIVz9NH/+fbCpxHImAM+9Ihvfg==
X-Gm-Message-State: AOJu0Yx41x8JwHQI/OYOThoLmcyTL+ZKBgQM6HJQhi9RaTKRd8KM3Btb
	Q8esfJOxv0xxmVpgOK0UjekF6w9D6eQUmzxzb320q9b1xSywgx8I
X-Google-Smtp-Source: AGHT+IFezMCWeCzZ2eHSXHjvcw2Pn5jzFcobtVWDICBBvL3Y3KmXgoiFcjq7tWPA9c/bY5ifdb19lg==
X-Received: by 2002:a05:6871:4585:b0:21f:6758:d5b0 with SMTP id nl5-20020a056871458500b0021f6758d5b0mr489470oab.50.1708710171814;
        Fri, 23 Feb 2024 09:42:51 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:51 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John@Groves.net,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	John Groves <john@groves.net>
Subject: [RFC PATCH 12/20] famfs: Add inode_operations and file_system_type
Date: Fri, 23 Feb 2024 11:41:56 -0600
Message-Id: <bd2bbdd7523d1c74ca559d8912984e7facabe5c6.1708709155.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <cover.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces the famfs inode_operations. There is nothing really
unique to famfs here in the inode_operations..

This commit also introduces the famfs_file_system_type struct and the
famfs_kill_sb() function.

Signed-off-by: John Groves <john@groves.net>
---
 fs/famfs/famfs_inode.c | 132 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
index f98f82962d7b..ab46ec50b70d 100644
--- a/fs/famfs/famfs_inode.c
+++ b/fs/famfs/famfs_inode.c
@@ -85,6 +85,109 @@ static struct inode *famfs_get_inode(
 	return inode;
 }
 
+/***************************************************************************
+ * famfs inode_operations: these are currently pretty much boilerplate
+ */
+
+static const struct inode_operations famfs_file_inode_operations = {
+	/* All generic */
+	.setattr	   = simple_setattr,
+	.getattr	   = simple_getattr,
+};
+
+
+/*
+ * File creation. Allocate an inode, and we're done..
+ */
+/* SMP-safe */
+static int
+famfs_mknod(
+	struct mnt_idmap *idmap,
+	struct inode     *dir,
+	struct dentry    *dentry,
+	umode_t           mode,
+	dev_t             dev)
+{
+	struct inode *inode = famfs_get_inode(dir->i_sb, dir, mode, dev);
+	int error           = -ENOSPC;
+
+	if (inode) {
+		struct timespec64       tv;
+
+		d_instantiate(dentry, inode);
+		dget(dentry);	/* Extra count - pin the dentry in core */
+		error = 0;
+		tv = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, tv);
+		inode_set_atime_to_ts(inode, tv);
+	}
+	return error;
+}
+
+static int famfs_mkdir(
+	struct mnt_idmap *idmap,
+	struct inode     *dir,
+	struct dentry    *dentry,
+	umode_t           mode)
+{
+	int retval = famfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
+
+	if (!retval)
+		inc_nlink(dir);
+
+	return retval;
+}
+
+static int famfs_create(
+	struct mnt_idmap *idmap,
+	struct inode     *dir,
+	struct dentry    *dentry,
+	umode_t           mode,
+	bool              excl)
+{
+	return famfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
+}
+
+static int famfs_symlink(
+	struct mnt_idmap *idmap,
+	struct inode     *dir,
+	struct dentry    *dentry,
+	const char       *symname)
+{
+	struct inode *inode;
+	int error = -ENOSPC;
+
+	inode = famfs_get_inode(dir->i_sb, dir, S_IFLNK | 0777, 0);
+	if (inode) {
+		int l = strlen(symname)+1;
+
+		error = page_symlink(inode, symname, l);
+		if (!error) {
+			struct timespec64       tv;
+
+			d_instantiate(dentry, inode);
+			dget(dentry);
+			tv = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode, tv);
+			inode_set_atime_to_ts(inode, tv);
+		} else
+			iput(inode);
+	}
+	return error;
+}
+
+static const struct inode_operations famfs_dir_inode_operations = {
+	.create		= famfs_create,
+	.lookup		= simple_lookup,
+	.link		= simple_link,
+	.unlink		= simple_unlink,
+	.symlink	= famfs_symlink,
+	.mkdir		= famfs_mkdir,
+	.rmdir		= simple_rmdir,
+	.mknod		= famfs_mknod,
+	.rename		= simple_rename,
+};
+
 /**********************************************************************************
  * famfs super_operations
  *
@@ -329,5 +432,34 @@ static int famfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void famfs_kill_sb(struct super_block *sb)
+{
+	struct famfs_fs_info *fsi = sb->s_fs_info;
+
+	mutex_lock(&famfs_context_mutex);
+	list_del(&fsi->fsi_list);
+	mutex_unlock(&famfs_context_mutex);
+
+	if (fsi->bdev_handle)
+		bdev_release(fsi->bdev_handle);
+	if (fsi->dax_devp)
+		fs_put_dax(fsi->dax_devp, fsi);
+	if (fsi->dax_filp) /* This only happens if it's char dax */
+		filp_close(fsi->dax_filp, NULL);
+
+	if (fsi && fsi->rootdev)
+		kfree(fsi->rootdev);
+	kfree(fsi);
+	kill_litter_super(sb);
+}
+
+#define MODULE_NAME "famfs"
+static struct file_system_type famfs_fs_type = {
+	.name		  = MODULE_NAME,
+	.init_fs_context  = famfs_init_fs_context,
+	.parameters	  = famfs_fs_parameters,
+	.kill_sb	  = famfs_kill_sb,
+	.fs_flags	  = FS_USERNS_MOUNT,
+};
 
 MODULE_LICENSE("GPL");
-- 
2.43.0


