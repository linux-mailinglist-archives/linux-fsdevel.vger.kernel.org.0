Return-Path: <linux-fsdevel+bounces-72885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C181BD04C9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 083C3301836B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6132F0661;
	Thu,  8 Jan 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niOHr0KO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE117277026;
	Thu,  8 Jan 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892431; cv=none; b=tWGdtcTXpIG6pyK6Bc2SvvbNZQH17H87xsYfXu4UVC7q7aLg2HvublGhHjN0DixUpF3Aja0w4UXJTlNM/2M+tgu6pzUTV76qeLHx2qiAP/39ySd+/9h1sHAJjtRzmvOVkVf5WAipVscNyre7RPx3rwi/rLaIH8BzVa7Wm+W1hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892431; c=relaxed/simple;
	bh=q6ECGD1+wntgmlJSkidx4XZzYvMNc2stbnRPzbVswr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLEx659Rcicv/xBAAPIV1w1W6xDcvWj5Kf0oxDtf9e/eCbwy1jb+VmBAR5l+rh4AevX33rQRcihefLOg5e8YQfr5JzBE9yJZNK3ebKD7ZN21kMvfXuNWMeXlqPT0tc37WQRxAD/hH6pcvRulWSFuo4LMgxFKFx74YEgIexIvaqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niOHr0KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785E6C116D0;
	Thu,  8 Jan 2026 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892429;
	bh=q6ECGD1+wntgmlJSkidx4XZzYvMNc2stbnRPzbVswr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=niOHr0KOpKsPbW3zcxSPJ4+HdeaSJcF9n2piB+6bV/P08brOPZY60SMqx3j4YVoxN
	 HY23AKzQOBHv5xbyCZODtdGvk8Iyuq3I5ZhrhCWp660sKVFvTkxAtvo6+2zeBPFcwG
	 4+6DEmOnuyk0FwVI8/H5Oeq3cw+B1HbnX3m1q/5DUy6tvj/EncQX0MDAdhOTB66vc6
	 Wa9Tx54LFEZPpTtzwjNRcJGznRwseKdLJWb0bgDU2EpAXO0/KhhvkoQcHVprarCLt0
	 WqAdXqVBexp4OOG3pfKO1KsQRyYLMdnkS6aXHz6qetxafVfPy72aJqgerrIX0uQpWw
	 vTe+PlRm/5SWg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:12:56 -0500
Subject: [PATCH 01/24] fs: add setlease to generic_ro_fops and read-only
 filesystem directory operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-1-ea4dec9b67fa@kernel.org>
References: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
In-Reply-To: <20260108-setlease-6-20-v1-0-ea4dec9b67fa@kernel.org>
To: Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, 
 Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, 
 Anders Larsen <al@alarsen.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, David Sterba <dsterba@suse.com>, 
 Chris Mason <clm@fb.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
 Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Jan Kara <jack@suse.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, 
 Dave Kleikamp <shaggy@kernel.org>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Carlos Maiolino <cem@kernel.org>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
 Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Andreas Gruenbacher <agruenba@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, Hans de Goede <hansg@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
 linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-mm@kvack.org, gfs2@lists.linux.dev, linux-doc@vger.kernel.org, 
 v9fs@lists.linux.dev, ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6119; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=q6ECGD1+wntgmlJSkidx4XZzYvMNc2stbnRPzbVswr4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W41MOFgO/l+aT/aQwWX6yzbWOrQUKMswYuC
 zwZ2N9iXuiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/luAAKCRAADmhBGVaC
 Fc7AEACr9C8Ts1FHYxAV8eYFq/mC6r3sgpT223unPjZiBqz0cBsE48A5R7g72u/qZwI83UTRJF1
 g0MThJcrJK2E67pZ+ZvH8T3pO2h3PKpZByut4pMdDc8HFu7Yytrz4TP4WTMD62O7eYsJLYX6N/g
 pNJ/yInFtIXZh/ysUQ6ruiczqr2LE06/01Cf7KHTZVDG+G9inw6x4jFdDmSSgmQEXxNbPFAnm1i
 TgiitrIv/g4OhfQBM9zycsFeMu1SX9hfL6aOgOJarrjgsuxErQqzjXDBvaP+/YDMkCvZdzQZHyK
 nYQkswujJYOnEZcN0GTnt7/8m6ZBIAhUwh+nh8MYp0nCy12JubPVU2a/DX2wx0bZfk2a0Tu9Uho
 INAlRmB9YHbI2XPziMpPuiHI7g4ALElxl1m1ttn6R+GBgUA0AMVmTG6gelfYyj/rAH36IO0XVtS
 W6o86sMi3zO5pVCs2ZU900ZMlh3Yq7+5XqW9e8IBoXGdhYHhyGqpN230Ws7usZnX7z1HUTdv0Og
 XQ00tTVueb23oPg9kHXoZNX9PdtOiilCirAcLAR9thMLLcvseGbqs+0AOBhOtr0jE0WUMqKewyr
 uMMPrn0ZRNxO4H9IhY13VzMbiPyBRz3WQFMnJi1DPqkZyCT8E4GaBKIGAJ/hhC4vg9x7K3AouKM
 MjNXCZhce9Ynapg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the setlease file_operation to generic_ro_fops, which covers file
operations for several read-only filesystems (BEFS, EFS, ISOFS, QNX4,
QNX6, CRAMFS, FREEVXFS). Also add setlease to the directory
file_operations for these filesystems.	A future patch will change the
default behavior to reject lease attempts with -EINVAL when there is no
setlease file operation defined. Add generic_setlease to retain the
ability to set leases on these filesystems.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/befs/linuxvfs.c        | 2 ++
 fs/cramfs/inode.c         | 2 ++
 fs/efs/dir.c              | 2 ++
 fs/freevxfs/vxfs_lookup.c | 2 ++
 fs/isofs/dir.c            | 2 ++
 fs/qnx4/dir.c             | 2 ++
 fs/qnx6/dir.c             | 2 ++
 fs/read_write.c           | 2 ++
 8 files changed, 16 insertions(+)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 9fcfdd6b8189aaf5cc3b68aa8dff4798af5bdcbc..d7c5d9270387bf6c3e94942e6331b449f90fe428 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -14,6 +14,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/errno.h>
+#include <linux/filelock.h>
 #include <linux/stat.h>
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
@@ -79,6 +80,7 @@ static const struct file_operations befs_dir_operations = {
 	.read		= generic_read_dir,
 	.iterate_shared	= befs_readdir,
 	.llseek		= generic_file_llseek,
+	.setlease	= generic_setlease,
 };
 
 static const struct inode_operations befs_dir_inode_operations = {
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index e54ebe402df79d43a2c7cf491d669829f7ef81b7..41b1a869cf135d014003d6bf1c343d590ae7a084 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/ramfs.h>
 #include <linux/init.h>
@@ -938,6 +939,7 @@ static const struct file_operations cramfs_directory_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= cramfs_readdir,
+	.setlease	= generic_setlease,
 };
 
 static const struct inode_operations cramfs_dir_inode_operations = {
diff --git a/fs/efs/dir.c b/fs/efs/dir.c
index f892ac7c2a35e0094a314eeded06a974154e46d7..35ad0092c11547af68ef8baf4965b50a0a7593fe 100644
--- a/fs/efs/dir.c
+++ b/fs/efs/dir.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/buffer_head.h>
+#include <linux/filelock.h>
 #include "efs.h"
 
 static int efs_readdir(struct file *, struct dir_context *);
@@ -14,6 +15,7 @@ const struct file_operations efs_dir_operations = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
 	.iterate_shared	= efs_readdir,
+	.setlease	= generic_setlease,
 };
 
 const struct inode_operations efs_dir_inode_operations = {
diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index 1b0bca8b4cc686043d92246042dcf833d37712e4..138e08de976ea762a46043316f27e9a031f60c32 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -8,6 +8,7 @@
  * Veritas filesystem driver - lookup and other directory related code.
  */
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/highmem.h>
@@ -36,6 +37,7 @@ const struct file_operations vxfs_dir_operations = {
 	.llseek =		generic_file_llseek,
 	.read =			generic_read_dir,
 	.iterate_shared =	vxfs_readdir,
+	.setlease =		generic_setlease,
 };
 
 
diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index 09df40b612fbf27a1a93af2b4fbf6a607f4a1ab4..2ca16c3fe5ef3427e5bbd0631eb8323ef3c58bf1 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -12,6 +12,7 @@
  *  isofs directory handling functions
  */
 #include <linux/gfp.h>
+#include <linux/filelock.h>
 #include "isofs.h"
 
 int isofs_name_translate(struct iso_directory_record *de, char *new, struct inode *inode)
@@ -271,6 +272,7 @@ const struct file_operations isofs_dir_operations =
 	.llseek = generic_file_llseek,
 	.read = generic_read_dir,
 	.iterate_shared = isofs_readdir,
+	.setlease = generic_setlease,
 };
 
 /*
diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
index 42a529e26bd68b6de1a7738c409d5942a92066f8..6402715ab377e5686558371dd76e5a4c1cfbb787 100644
--- a/fs/qnx4/dir.c
+++ b/fs/qnx4/dir.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/buffer_head.h>
+#include <linux/filelock.h>
 #include "qnx4.h"
 
 static int qnx4_readdir(struct file *file, struct dir_context *ctx)
@@ -71,6 +72,7 @@ const struct file_operations qnx4_dir_operations =
 	.read		= generic_read_dir,
 	.iterate_shared	= qnx4_readdir,
 	.fsync		= generic_file_fsync,
+	.setlease	= generic_setlease,
 };
 
 const struct inode_operations qnx4_dir_inode_operations =
diff --git a/fs/qnx6/dir.c b/fs/qnx6/dir.c
index b4d10e45f2e41b45568fe813a3cc0aa253bcab6e..ae0c9846833d916beb7f356cfa6e9de01a6f6963 100644
--- a/fs/qnx6/dir.c
+++ b/fs/qnx6/dir.c
@@ -11,6 +11,7 @@
  *
  */
 
+#include <linux/filelock.h>
 #include "qnx6.h"
 
 static unsigned qnx6_lfile_checksum(char *name, unsigned size)
@@ -275,6 +276,7 @@ const struct file_operations qnx6_dir_operations = {
 	.read		= generic_read_dir,
 	.iterate_shared	= qnx6_readdir,
 	.fsync		= generic_file_fsync,
+	.setlease	= generic_setlease,
 };
 
 const struct inode_operations qnx6_dir_inode_operations = {
diff --git a/fs/read_write.c b/fs/read_write.c
index 833bae068770a4e410e4895132586313a9687fa2..50bff7edc91f36fe5ee24198bd51a33c278d40a2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/filelock.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -30,6 +31,7 @@ const struct file_operations generic_ro_fops = {
 	.read_iter	= generic_file_read_iter,
 	.mmap_prepare	= generic_file_readonly_mmap_prepare,
 	.splice_read	= filemap_splice_read,
+	.setlease	= generic_setlease,
 };
 
 EXPORT_SYMBOL(generic_ro_fops);

-- 
2.52.0


