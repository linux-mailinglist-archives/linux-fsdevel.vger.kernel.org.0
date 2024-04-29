Return-Path: <linux-fsdevel+bounces-18130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 178A38B5F9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2927AB23383
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD75127B65;
	Mon, 29 Apr 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWjl1urZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D85127B45;
	Mon, 29 Apr 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410326; cv=none; b=Rp+QpkUefA2BqkvkToUfF9ii72OPfLq8eNtDBQFyRB3DG0BFymKivmBvUBumt+9JixzASkBIXAaYO3iK6JYjvfZ+p/V8+nwxG2E3Lw0jrsTWNLXQWZMf43pI7jYLBwI+2hg0vopoTv+d8ArstA0B/1/NcYHNnpuNWWQ/Lu2n1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410326; c=relaxed/simple;
	bh=3okyjXHCMhcAJ0EEcEcf6cQaC7PkHdUAYWpAVtSMGPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9Ha8DuorZHcX14WXutGHsxgDMbf12TiG2nGcfRlbaKhZ99CzWRuZKHLpE6/osxN4V4yYhlQBToXuleoxeI/31E8OcapRPAnUwUgfQYb0gYAKxglUltpA00E6F2R9DoNWvf5qG9kFxpavWVs6oAIeFN/MCn6P8x6Ls1T50qUCDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWjl1urZ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ea2375d8d0so3895028a34.0;
        Mon, 29 Apr 2024 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410323; x=1715015123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UaofW1Ss7ysgCpPsl4E9jKgtjI2OUWLad4tGWrXZwU=;
        b=QWjl1urZ0wbXplKUjcZEeCDJu/tiuW9/z3PZllkb4HWCedlObKDJEIf9qfO4vL8vGy
         MdsnU/ljt0C/rdmmt6IM/FFh7EFpTIbzxeSXWO6OByBDZddD1v66lS0LQkVxQ2yHfZCa
         xzaw/T3226aH70LQCgip6axYFX5BLzsYFcHYz1x5Ttj4d/dOzfCMHOmegLw8QPtjftXU
         llTmnuvKXpcjM+dQa91ibhtoeoTdGQLSwwTYdsF4mznH3jg+HiajrkbA5n6gBfsj814q
         fGOArCb9Jml569izgdIZ3BYP2Q94sUBHT7Aq7pncfmd7/q2LbYOioY9KiViknmEuZ/Rd
         Xz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410323; x=1715015123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2UaofW1Ss7ysgCpPsl4E9jKgtjI2OUWLad4tGWrXZwU=;
        b=jbGwngemDJZtwriaUpvyNtI4DSl72RLKyVQ1cMP0QJpMrXWwxvM/q723yjUS0oSgn1
         y6lDuBq6RXYx/jervI9M6HM5tGxQ7ZECiHKRgDyW8xubuiI0rH/QqHnjk8iPQoUCO0y6
         ykL/iCkQUH/P4s++jDSsvi1h5jOeGx0VS6qpwmJg4Rj4KWVLWTTZhJqKKqhD73Bno9hI
         XvLooZMQe+6io5Skb/ItFGdb2Dy6KZqRBBxq5fMUYoNGYVIyz5p861iE5lFuaHpArptq
         MMonq3fH0N2qHTWepAV2mg/bLGnpR1s7WDgSQmid6af689d1nWHmEFb3P2aWIESYDTlh
         /nQA==
X-Forwarded-Encrypted: i=1; AJvYcCWbd4duhT5vSHMp4N2mW9Inm1xp6yU0l1Z71JJDSBVmUCXAvxy7yU3ZEL2w7638Ddkf61HBi8nhym2ID7lYcNwmycZHVp0MorcBwUhEt58D51xYhZkBc3VAfXYn2ShERvstmwbzuOYRLQ==
X-Gm-Message-State: AOJu0YzSsZCkpt5bhG+KO9Xoa7nrSjq1MA3eG8pmEsgXJjzKWoRB4sTD
	kBn7AIju8vpCRQ5p+dWM95DttvEKTeWPEaWpIYYHrTydpUEz3rBhEz+n+LhT
X-Google-Smtp-Source: AGHT+IFvD88Udyo+NvOBr4PNFG9gOR+wiZU+XL9Ie5iTR0+/Cv+NkgpNj5yEeSCkfCvrufai21KfAw==
X-Received: by 2002:a05:6830:4513:b0:6eb:d349:8c3f with SMTP id i19-20020a056830451300b006ebd3498c3fmr13821572otv.28.1714410323111;
        Mon, 29 Apr 2024 10:05:23 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.05.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:05:22 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	John Groves <john@groves.net>
Subject: [RFC PATCH v2 09/12] famfs: Introduce inode_operations and super_operations
Date: Mon, 29 Apr 2024 12:04:25 -0500
Message-Id: <ada861141fc80963d93cb0083da5537cd46633a0.1714409084.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1714409084.git.john@groves.net>
References: <cover.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The famfs inode and super operations are pretty much generic.

This commit builds but is still too incomplete to run

Signed-off-by: John Groves <john@groves.net>
---
 fs/famfs/famfs_inode.c | 113 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 3 deletions(-)

diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
index 61306240fc0b..e00e9cdecadf 100644
--- a/fs/famfs/famfs_inode.c
+++ b/fs/famfs/famfs_inode.c
@@ -28,6 +28,9 @@
 
 #define FAMFS_DEFAULT_MODE	0755
 
+static const struct inode_operations famfs_file_inode_operations;
+static const struct inode_operations famfs_dir_inode_operations;
+
 static struct inode *famfs_get_inode(struct super_block *sb,
 				     const struct inode *dir,
 				     umode_t mode, dev_t dev)
@@ -52,11 +55,11 @@ static struct inode *famfs_get_inode(struct super_block *sb,
 		init_special_inode(inode, mode, dev);
 		break;
 	case S_IFREG:
-		inode->i_op = NULL /* famfs_file_inode_operations */;
+		inode->i_op = &famfs_file_inode_operations;
 		inode->i_fop = NULL /* &famfs_file_operations */;
 		break;
 	case S_IFDIR:
-		inode->i_op = NULL /* famfs_dir_inode_operations */;
+		inode->i_op = &famfs_dir_inode_operations;
 		inode->i_fop = &simple_dir_operations;
 
 		/* Directory inodes start off with i_nlink == 2 (for ".") */
@@ -70,6 +73,110 @@ static struct inode *famfs_get_inode(struct super_block *sb,
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
+/*
+ * File creation. Allocate an inode, and we're done..
+ */
+static int
+famfs_mknod(struct mnt_idmap *idmap, struct inode *dir, struct dentry *dentry,
+	    umode_t mode, dev_t dev)
+{
+	struct famfs_fs_info *fsi = dir->i_sb->s_fs_info;
+	struct timespec64 tv;
+	struct inode *inode;
+
+	if (fsi->deverror)
+		return -ENODEV;
+
+	inode = famfs_get_inode(dir->i_sb, dir, mode, dev);
+	if (!inode)
+		return -ENOSPC;
+
+	d_instantiate(dentry, inode);
+	dget(dentry);	/* Extra count - pin the dentry in core */
+	tv = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, tv);
+	inode_set_atime_to_ts(inode, tv);
+
+	return 0;
+}
+
+static int famfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+		       struct dentry *dentry, umode_t mode)
+{
+	struct famfs_fs_info *fsi = dir->i_sb->s_fs_info;
+	int rc;
+
+	if (fsi->deverror)
+		return -ENODEV;
+
+	rc = famfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFDIR, 0);
+	if (rc)
+		return rc;
+
+	inc_nlink(dir);
+
+	return 0;
+}
+
+static int famfs_create(struct mnt_idmap *idmap, struct inode *dir,
+			struct dentry *dentry, umode_t mode, bool excl)
+{
+	struct famfs_fs_info *fsi = dir->i_sb->s_fs_info;
+
+	if (fsi->deverror)
+		return -ENODEV;
+
+	return famfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
+}
+
+static const struct inode_operations famfs_dir_inode_operations = {
+	.create		= famfs_create,
+	.lookup		= simple_lookup,
+	.link		= simple_link,
+	.unlink		= simple_unlink,
+	.mkdir		= famfs_mkdir,
+	.rmdir		= simple_rmdir,
+	.rename		= simple_rename,
+};
+
+/*****************************************************************************
+ * famfs super_operations
+ *
+ * TODO: implement a famfs_statfs() that shows size, free and available space,
+ * etc.
+ */
+
+/*
+ * famfs_show_options() - Display the mount options in /proc/mounts.
+ */
+static int famfs_show_options(struct seq_file *m, struct dentry *root)
+{
+	struct famfs_fs_info *fsi = root->d_sb->s_fs_info;
+
+	if (fsi->mount_opts.mode != FAMFS_DEFAULT_MODE)
+		seq_printf(m, ",mode=%o", fsi->mount_opts.mode);
+
+	return 0;
+}
+
+static const struct super_operations famfs_super_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+	.show_options	= famfs_show_options,
+};
+
+/*****************************************************************************/
+
 /*
  * famfs dax_operations  (for char dax)
  */
@@ -103,7 +210,7 @@ famfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize		= PAGE_SIZE;
 	sb->s_blocksize_bits	= PAGE_SHIFT;
 	sb->s_magic		= FAMFS_SUPER_MAGIC;
-	sb->s_op		= NULL /* famfs_super_ops */;
+	sb->s_op		= &famfs_super_ops;
 	sb->s_time_gran		= 1;
 
 	return rc;
-- 
2.43.0


