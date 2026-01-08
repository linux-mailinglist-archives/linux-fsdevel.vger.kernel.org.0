Return-Path: <linux-fsdevel+bounces-72908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBAD054C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 19:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC6E231B62C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E9034CFCF;
	Thu,  8 Jan 2026 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZjZZqoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820C288C3F;
	Thu,  8 Jan 2026 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892605; cv=none; b=ufRntVvIVr5ZKbFPwQH5y+QQhD2e/Eh+8HUeWp3z8cjMTNObijaspX8WQvaMtd7r2rnHA37PIRBL+MSn9kRfXVt4me86658qOsDp2Zf5/1UZBcsCNyraX9aRyQ2Jr0jwy/dBT7WnG9TSk516RSOpzVc94mbhb5pjML2Aqxf5ciU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892605; c=relaxed/simple;
	bh=U34+hUe1lITda+7ORuftTgPAZMgz7ZoTxRDwcTln1IQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvB6oRkshpbAHAfyjSMClQO9ZfTdDhVoSzd4WxT2nRUoDLuk9sRU6TP84IMFZ1DK8RNr9BjdyEbB1sbs46CHW6NnM6cj5XU6s3muAqlgzAvf5lzAgkGYFokzCO00OB5AkSVvC6kB7eXxSHe9yD/RQbuLpH/cpinP5ZYak80KfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZjZZqoM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB11DC16AAE;
	Thu,  8 Jan 2026 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892605;
	bh=U34+hUe1lITda+7ORuftTgPAZMgz7ZoTxRDwcTln1IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AZjZZqoMro8OC4j2JSC5fFQBVGoLjzGd+g7W4Wd8F70BL8kCK4wxnaL3br8EeNAG7
	 53eekAn5GCF2zr0zwlO71isFPOqg0/KCnLgpBsAccfbGKjixxdyIN0gk8ZxbdgCVDh
	 lc2d2R5Jhsdz4Mc5PxEYUHINU8AH7qfiJX4BhGf818jeYU0yx5RF//Ufht8VlDi+XZ
	 2c7eweiM/UH+bhVLuVOkFzBzN9tZXZ4LaH4fp/815596VAIheG1+JbAgHYYLn+jTf/
	 cOf71F/4vr1ESb3VjH1vgXrJOiK4oquaXEyJRON8a4InJAHH0r1HVCbwEpr9kVQVJ6
	 7P8hBG+o0uO9Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 08 Jan 2026 12:13:19 -0500
Subject: [PATCH 24/24] fs: remove simple_nosetlease()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-setlease-6-20-v1-24-ea4dec9b67fa@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8377; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=U34+hUe1lITda+7ORuftTgPAZMgz7ZoTxRDwcTln1IQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpX+W+X+qukMSLumza5qOM6NmvHiQt0us+6Qn9G
 Xk99Xqtmx2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV/lvgAKCRAADmhBGVaC
 FWTED/0cosgZvmGsMXyWMzhuGluOP45PKgABuWRRNfXyMl7zfLDBO85xoQGEdZuXH0HRywUdRoZ
 ZJvR12j10CgnQfru2AULyzJqBsg1bMu8TZ0B2+XwNdGunTdUGgqdYwyhf5QgVqrJtbNRHGgXLMp
 ijPOpIHpjau16MozGMdpfprfPnW2o5o/nmng69GQoMDQhEI1UFtknLYYVzUzlX/VvRuU94EBHCO
 g7gUiQPxwpvEfLdDkGz5KxmledEGu8B9Syx3wfKcKV4tM7ij3I6TP15LMd1iyUyhS0Tw/TVE6fD
 CNWRWZQV/EzgvZgKvq/LT3VHyrjwYzDlLBeAGBMv1A7tIgKdN7z/1YkkxZrBrUh9Yp0xbTZn72I
 f2cuvFx7ae+z3eCkwP3sMkZI6X9ph23LW6rUXTF79UfGqIFyJiAYmVqJkSr8BsEEOAhJOTAZYbq
 5Qr0OHsykNkZ6WyfY6Dx8+vUSRxwth+QTKKEwHuU2fsoeOt3i3TaY6dxuiT+JcP0yBgkj+9TIlE
 A2EDk5fLh4tSHzxnQSiRKJfj5HHzrzq6jcF6mRFxB/DABsJ5YZnSoEHemK4nhYu9Eslr6xQyKfp
 uA7kvGnKDARrGu/OHh0YzbafhXRjYsvc6VTH0BR8Qse+hafnHIOi0N3Xm+rQjr3KROxNWJeJN6g
 7MdoPn15h/8KXqQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Setting ->setlease() to a NULL pointer now has the same effect as
setting it to simple_nosetlease(). Remove all of the setlease
file_operations that are set to simple_nosetlease, and the function
itself.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/9p/vfs_dir.c        |  2 --
 fs/9p/vfs_file.c       |  2 --
 fs/ceph/dir.c          |  2 --
 fs/ceph/file.c         |  1 -
 fs/fuse/dir.c          |  1 -
 fs/gfs2/file.c         |  2 --
 fs/libfs.c             | 18 ------------------
 fs/nfs/dir.c           |  1 -
 fs/nfs/file.c          |  1 -
 fs/smb/client/cifsfs.c |  1 -
 fs/vboxsf/dir.c        |  1 -
 fs/vboxsf/file.c       |  1 -
 include/linux/fs.h     |  1 -
 13 files changed, 34 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index af7f72abbb76aaff934b80d4002f32e3b0d17b6d..e0d34e4e9076e3b1a6c5ed07a3e009a50c9fa2a9 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -242,7 +242,6 @@ const struct file_operations v9fs_dir_operations = {
 	.iterate_shared = v9fs_dir_readdir,
 	.open = v9fs_file_open,
 	.release = v9fs_dir_release,
-	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_dir_operations_dotl = {
@@ -252,5 +251,4 @@ const struct file_operations v9fs_dir_operations_dotl = {
 	.open = v9fs_file_open,
 	.release = v9fs_dir_release,
 	.fsync = v9fs_file_fsync_dotl,
-	.setlease = simple_nosetlease,
 };
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 6f3880208587e39d965dcd4b4280a2079a36b4a2..c5e73c37baea55394294b939fdda7170db8503c0 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -517,7 +517,6 @@ const struct file_operations v9fs_file_operations = {
 	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
-	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -532,5 +531,4 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.splice_read = v9fs_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
-	.setlease = simple_nosetlease,
 };
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 804588524cd570078ba59bf38d2460950ca67daf..86d7aa594ea99335af3e91a95c0a418fdc1b8a8a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -2214,7 +2214,6 @@ const struct file_operations ceph_dir_fops = {
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
 	.flock = ceph_flock,
-	.setlease = simple_nosetlease,
 };
 
 const struct file_operations ceph_snapdir_fops = {
@@ -2222,7 +2221,6 @@ const struct file_operations ceph_snapdir_fops = {
 	.llseek = ceph_dir_llseek,
 	.open = ceph_open,
 	.release = ceph_release,
-	.setlease = simple_nosetlease,
 };
 
 const struct inode_operations ceph_dir_iops = {
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 983390069f737254e8c7bcad1718f375499f443e..31b691b2aea21f04c6d6c9aacbfd664c13a3ef64 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -3169,7 +3169,6 @@ const struct file_operations ceph_file_fops = {
 	.mmap_prepare = ceph_mmap_prepare,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
-	.setlease = simple_nosetlease,
 	.flock = ceph_flock,
 	.splice_read = ceph_splice_read,
 	.splice_write = iter_file_splice_write,
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff225dc389016017753b09fadff9d1..d6ee2d38fc2dad5c0995b62dd589e7a46d18424d 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2421,7 +2421,6 @@ static const struct file_operations fuse_dir_operations = {
 	.fsync		= fuse_dir_fsync,
 	.unlocked_ioctl	= fuse_dir_ioctl,
 	.compat_ioctl	= fuse_dir_compat_ioctl,
-	.setlease	= simple_nosetlease,
 };
 
 static const struct inode_operations fuse_common_inode_operations = {
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 6daa96d815e1e30f099938543a0ed19aa90c720c..3e061e8115ece08c7cb6594b8adb653ccec998ed 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1593,7 +1593,6 @@ const struct file_operations gfs2_file_fops = {
 	.flock		= gfs2_flock,
 	.splice_read	= copy_splice_read,
 	.splice_write	= gfs2_file_splice_write,
-	.setlease	= simple_nosetlease,
 	.fallocate	= gfs2_fallocate,
 	.fop_flags	= FOP_ASYNC_LOCK,
 };
@@ -1608,7 +1607,6 @@ const struct file_operations gfs2_dir_fops = {
 	.lock		= gfs2_lock,
 	.flock		= gfs2_flock,
 	.llseek		= default_llseek,
-	.setlease	= simple_nosetlease,
 	.fop_flags	= FOP_ASYNC_LOCK,
 };
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 697c6d5fc12786c036f0086886297fb5cd52ae00..f1860dff86f2703266beecf31e9d2667af7a9684 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1699,24 +1699,6 @@ struct inode *alloc_anon_inode(struct super_block *s)
 }
 EXPORT_SYMBOL(alloc_anon_inode);
 
-/**
- * simple_nosetlease - generic helper for prohibiting leases
- * @filp: file pointer
- * @arg: type of lease to obtain
- * @flp: new lease supplied for insertion
- * @priv: private data for lm_setup operation
- *
- * Generic helper for filesystems that do not wish to allow leases to be set.
- * All arguments are ignored and it just returns -EINVAL.
- */
-int
-simple_nosetlease(struct file *filp, int arg, struct file_lease **flp,
-		  void **priv)
-{
-	return -EINVAL;
-}
-EXPORT_SYMBOL(simple_nosetlease);
-
 /**
  * simple_get_link - generic helper to get the target of "fast" symlinks
  * @dentry: not used here
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 71df279febf797880ded19e45528c3df4cea2dde..23a78a742b619dea8b76ddf28f4f59a1c8a015e2 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -66,7 +66,6 @@ const struct file_operations nfs_dir_operations = {
 	.open		= nfs_opendir,
 	.release	= nfs_closedir,
 	.fsync		= nfs_fsync_dir,
-	.setlease	= simple_nosetlease,
 };
 
 const struct address_space_operations nfs_dir_aops = {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d020aab40c64ebda30d130b6acee1b9194621457..9d269561961825f88529551b0f0287920960ac62 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -962,7 +962,6 @@ const struct file_operations nfs_file_operations = {
 	.splice_read	= nfs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
-	.setlease	= simple_nosetlease,
 	.fop_flags	= FOP_DONTCACHE,
 };
 EXPORT_SYMBOL_GPL(nfs_file_operations);
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index a3dc7cb1ab541d35c2e43eefb7a2d2d23ad88bb3..8015df1f711e150a0afb44875899435303d9d406 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1709,7 +1709,6 @@ const struct file_operations cifs_dir_ops = {
 	.remap_file_range = cifs_remap_file_range,
 	.llseek = generic_file_llseek,
 	.fsync = cifs_dir_fsync,
-	.setlease = simple_nosetlease,
 };
 
 static void
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 230d7589d15cc98f6bc7e930ba40ca5f7dbf7e18..42bedc4ec7af7709c564a7174805d185ce86f854 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -186,7 +186,6 @@ const struct file_operations vboxsf_dir_fops = {
 	.release = vboxsf_dir_release,
 	.read = generic_read_dir,
 	.llseek = generic_file_llseek,
-	.setlease = simple_nosetlease,
 };
 
 /*
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 4bebd947314a796365728b3af1c46b0d7070abc1..111752010edb2ba48ee1fdf0e3729369c6521ee8 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -218,7 +218,6 @@ const struct file_operations vboxsf_reg_fops = {
 	.release = vboxsf_file_release,
 	.fsync = noop_fsync,
 	.splice_read = filemap_splice_read,
-	.setlease = simple_nosetlease,
 };
 
 const struct inode_operations vboxsf_reg_iops = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5c9cf28c4dcf9ec648f0fc4f3f4bb44d1b1c482..e46e8aad9339357f99c40eede8ca7b6b727284fe 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3217,7 +3217,6 @@ extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
 struct inode *anon_inode_make_secure_inode(struct super_block *sb, const char *name,
 					   const struct inode *context_inode);
-extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 
 extern struct dentry *simple_lookup(struct inode *, struct dentry *, unsigned int flags);
 extern ssize_t generic_read_dir(struct file *, char __user *, size_t, loff_t *);

-- 
2.52.0


