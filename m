Return-Path: <linux-fsdevel+bounces-67686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52C0C46CE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7143A4B23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF8A311583;
	Mon, 10 Nov 2025 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEj9kd3J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E072F747F;
	Mon, 10 Nov 2025 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780400; cv=none; b=jIeRZ6tZkk8Yy1fiuMLWe5JkzrnaMTqm2uFu2JmS1baemi4u7Y2lAUVCN0swkYE5soNgUiRwbob7JKzGBqrLmbqAY8c4qLliVLMl5G+AxfixFMUacjGu0rN5Pt5stQ8B5o8K24Z6zOL5YXMeqQJgLBlGM5MfIF2dVY6nVrN2QIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780400; c=relaxed/simple;
	bh=ZI1dRC9P8hhWJfghFXkhPfDzyR+WE8GvvFBxFOz3OZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=skgdD1/QwZZg4uXkARgcxp8ZX6o7Rk8szWEbqk+pEZqNip9IXyw5wiFetbg6MW+kjlCHycwxLlWemKcvhaxVUQ20jo/XNghwDXcd+dumYVeCrDlDPs91i0xsNRlpAe7kINxNEyjNi7ItBrK9Ve5fca3EYT8y8jz/jPGyx1LKvHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEj9kd3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C5EC113D0;
	Mon, 10 Nov 2025 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762780399;
	bh=ZI1dRC9P8hhWJfghFXkhPfDzyR+WE8GvvFBxFOz3OZA=;
	h=From:Date:Subject:To:Cc:From;
	b=nEj9kd3Jd219E4mVzArDEkNzX9r4R3FTm2fBxLKflQKOOD6WG4xqDqMCLrPyJVKT1
	 ZNNWS3iN7xr1I9yGQwKwk/O3MR3gNuDYz9Qh0pPYteoGBajfnXyaDmb3DMN/mBSP1H
	 zNreGnPDqwnMT8Ze5vlygCu2TMU9pbV6jbB6JffW3PZsk5Y/7C0Gc1iiMwkTW3Jw/E
	 JxAMiTegU6wDHMaIkRbf4GafQa9IbV0zizXB3B+XNUnMtn/DCXt/k80BYRZ7Izncwt
	 BSLgKNubZXFSUXbif0m9A/v+XdbwpFCbtUJh3i7IfhyaOjBrNZsz+RJeuojVocYDVI
	 sW0NBKD9iR/sQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 10 Nov 2025 08:13:00 -0500
Subject: [PATCH v3] vfs: remove the excl argument from the ->create()
 inode_operation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-create-excl-v3-1-836a61d14fb0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MQQ6CMBCF4auQWVtDW1vUlfcwLugwhUYDZkoaD
 OHuFlaSuHwv+f4ZInGgCNdiBqYUYhj6PPShAOzqviURmrxBlcpIWRqBTPVIgiZ8CeW0tc3Fee0
 cZPFm8mHaavdH3l2I48CfLZ7k+v7vJCmkqE+IVGqDaMztSdzT6zhwC2soqV9c7bHK2NvqLK1pK
 q/9Di/L8gX4zXjY5AAAAA==
X-Change-ID: 20251105-create-excl-2b366d9bf3bb
To: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
 Marc Dionne <marc.dionne@auristor.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>, Chris Mason <clm@fb.com>, 
 Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
 Tyler Hicks <code@tyhicks.com>, Jeremy Kerr <jk@ozlabs.org>, 
 Ard Biesheuvel <ardb@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Miklos Szeredi <miklos@szeredi.hu>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
 Dave Kleikamp <shaggy@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, 
 Amir Goldstein <amir73il@gmail.com>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, Hans de Goede <hansg@kernel.org>, 
 Carlos Maiolino <cem@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: NeilBrown <neilb@ownmail.net>, linux-kernel@vger.kernel.org, 
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
 ecryptfs@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 gfs2@lists.linux.dev, linux-um@lists.infradead.org, linux-mm@kvack.org, 
 linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, 
 ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
 linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, 
 linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
 NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=35407; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZI1dRC9P8hhWJfghFXkhPfDzyR+WE8GvvFBxFOz3OZA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpEeTjN8LYHzCcDsHsqeBWCVf1LAgogmGtJNpxF
 ITkLUcwiM6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaRHk4wAKCRAADmhBGVaC
 FcWVD/wLdFDqUFtA+1rpwZK3ZP7aWhC2GPDUbJIkPvnG9pgCo1xWK5+1B9Z+Xk7as6bDMZ2L/Im
 0INI/FN4dbk3feC8CZybMi1NOW6bmeInd+ue3j5ANzMC1m3egU4Vv8mcPDFH4F7TjSxKyvz/iii
 3ZfmkbfwMRMkGzliQtjG+v+VjU4Hp3hHW3KfVSogLZIvSejAh7pnIe0kr3nz548gqoTGGYLH3G8
 +E89eNm0QtsPSrfdYrfODgQ1BjTcL2JT0cwvvFhGMFton3+sXd+4iDrCrB8zOjCfLIwm7AFisRD
 UN9KCOmYyrVgzR24GDr477nmmLJg9cqIGNv8fzWQ5DR0vwZM9ktS76pqGa2NP+RsmH2IjppiFoG
 dHBozj19UVVYwEJbpB+tLNtBxyAab9f7gL7Smp2X13Tf4u2s07YfQabsCDXEB1rW9/iRkkvXFzS
 fyotpUL1H9fqgRP1P1GfIhs+SeWDuekep3pRBFKeiFqrS1rJ+5rbw8gsbBgvGtOSixTNyYHfCs2
 22lJ6Ac9lhAnY/QtKKp54zQv0YA3i2IC0WaQtd9sSSnrFZyBZRXBm7SrznCbg7RsTwhZV7yybA0
 erexdHBQxQov20WwEHDCMbjuQ/9/ECjJPQYAwjjeAhxg4hMno98zY7c1W+x5EeFTgX8X21kUaSh
 IY7yonE0WwQBHpw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With three exceptions, ->create() methods provided by filesystems ignore
the "excl" flag.  Those exception are NFS, GFS2 and vboxsf which all also
provide ->atomic_open.

Since ce8644fcadc5 ("lookup_open(): expand the call of vfs_create()"),
the "excl" argument to the ->create() inode_operation is always set to
true in vfs_create(). The ->create() call in lookup_open() sets it
according to the O_EXCL open flag, but is never called if the filesystem
provides ->atomic_open().

The excl flag is therefore always either ignored or true.  Remove it,
and change NFS, GFS2 and vboxsf to act as if it were always true.

Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Minor update to fix vboxsf case that I somehow missed in the first
version, and some minor whitespace cleanup in the docs. Reminder that
this should be applied on top of the directory delegation series [1].

[1]: https://lore.kernel.org/linux-nfs/20251105-dir-deleg-ro-v5-0-7ebc168a88ac@kernel.org/
---
Changes in v3:
- fix use of excl in vboxsf_dir_mkfile()
- fix tab prefixes in Documentation/filesystems/vfs.rst
- Link to v2: https://lore.kernel.org/r/20251107-create-excl-v2-1-f678165d7f3f@kernel.org

Changes in v2:
- better describe why the argument isn't needed in the changelog
- updates do Documentation/
- Link to v1: https://lore.kernel.org/r/20251105-create-excl-v1-1-a4cce035cc55@kernel.org
---
 Documentation/filesystems/porting.rst | 12 ++++++++++++
 Documentation/filesystems/vfs.rst     | 13 ++++++++++---
 fs/9p/vfs_inode.c                     |  2 +-
 fs/9p/vfs_inode_dotl.c                |  2 +-
 fs/affs/affs.h                        |  2 +-
 fs/affs/namei.c                       |  2 +-
 fs/afs/dir.c                          |  4 ++--
 fs/bad_inode.c                        |  2 +-
 fs/bfs/dir.c                          |  2 +-
 fs/btrfs/inode.c                      |  2 +-
 fs/ceph/dir.c                         |  2 +-
 fs/coda/dir.c                         |  2 +-
 fs/ecryptfs/inode.c                   |  2 +-
 fs/efivarfs/inode.c                   |  2 +-
 fs/exfat/namei.c                      |  2 +-
 fs/ext2/namei.c                       |  2 +-
 fs/ext4/namei.c                       |  2 +-
 fs/f2fs/namei.c                       |  2 +-
 fs/fat/namei_msdos.c                  |  2 +-
 fs/fat/namei_vfat.c                   |  2 +-
 fs/fuse/dir.c                         |  2 +-
 fs/gfs2/inode.c                       |  5 ++---
 fs/hfs/dir.c                          |  2 +-
 fs/hfsplus/dir.c                      |  2 +-
 fs/hostfs/hostfs_kern.c               |  2 +-
 fs/hpfs/namei.c                       |  2 +-
 fs/hugetlbfs/inode.c                  |  2 +-
 fs/jffs2/dir.c                        |  4 ++--
 fs/jfs/namei.c                        |  2 +-
 fs/minix/namei.c                      |  2 +-
 fs/namei.c                            |  4 ++--
 fs/nfs/dir.c                          |  4 ++--
 fs/nfs/internal.h                     |  2 +-
 fs/nilfs2/namei.c                     |  2 +-
 fs/ntfs3/namei.c                      |  2 +-
 fs/ocfs2/dlmfs/dlmfs.c                |  3 +--
 fs/ocfs2/namei.c                      |  3 +--
 fs/omfs/dir.c                         |  2 +-
 fs/orangefs/namei.c                   |  3 +--
 fs/overlayfs/dir.c                    |  2 +-
 fs/ramfs/inode.c                      |  2 +-
 fs/smb/client/cifsfs.h                |  2 +-
 fs/smb/client/dir.c                   |  2 +-
 fs/ubifs/dir.c                        |  2 +-
 fs/udf/namei.c                        |  2 +-
 fs/ufs/namei.c                        |  3 +--
 fs/vboxsf/dir.c                       |  4 ++--
 fs/xfs/xfs_iops.c                     |  3 +--
 include/linux/fs.h                    |  4 ++--
 ipc/mqueue.c                          |  2 +-
 mm/shmem.c                            |  2 +-
 51 files changed, 78 insertions(+), 65 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 7233b04668fcce75f1ed170329a2cd18110a7d89..d71a3f5c626e578f0370986975ca50292c8e15c3 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1309,3 +1309,15 @@ a different length, use
 	vfs_parse_fs_qstr(fc, key, &QSTR_LEN(value, len))
 
 instead.
+
+---
+
+**mandatory**
+
+The ->create() operation has dropped the bool "excl" argument. This operation
+should now always provide O_EXCL semantics (i.e. fail with -EEXIST if the file
+exists). If the filesystem needs to handle the case where another entity could
+create the file on the backing store after a negative lookup or revalidate
+(e.g. it's a network filesystem and another client could create the file after
+a negative lookup), then it will require ->atomic_open() in addition to
+->create().
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 4f13b01e42eb5e2ad9d60cbbce7e47d09ad831e6..0752ed2b6475ab2b42482fde6dff870110a33eac 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -467,7 +467,7 @@ As of kernel 2.6.22, the following members are defined:
 .. code-block:: c
 
 	struct inode_operations {
-		int (*create) (struct mnt_idmap *, struct inode *,struct dentry *, umode_t, bool);
+		int (*create) (struct mnt_idmap *, struct inode *,struct dentry *, umode_t);
 		struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 		int (*link) (struct dentry *,struct inode *,struct dentry *);
 		int (*unlink) (struct inode *,struct dentry *);
@@ -505,7 +505,10 @@ otherwise noted.
 	if you want to support regular files.  The dentry you get should
 	not have an inode (i.e. it should be a negative dentry).  Here
 	you will probably call d_instantiate() with the dentry and the
-	newly created inode
+	newly created inode. This operation should always provide O_EXCL
+	semantics (i.e. it should fail with -EEXIST if the file exists).
+	If the filesystem needs to mediate non-exclusive creation,
+	then the filesystem must also provide an ->atomic_open() operation.
 
 ``lookup``
 	called when the VFS needs to look up an inode in a parent
@@ -654,7 +657,11 @@ otherwise noted.
 	handled by f_op->open().  If the file was created, FMODE_CREATED
 	flag should be set in file->f_mode.  In case of O_EXCL the
 	method must only succeed if the file didn't exist and hence
-	FMODE_CREATED shall always be set on success.
+	FMODE_CREATED shall always be set on success. This method is
+	usually needed on filesystems where the dentry to be created could
+	unexpectedly become positive after the kernel has looked it up or
+	revalidated it. (e.g. another host racing in and creating the file
+	on an NFS server).
 
 ``tmpfile``
 	called in the end of O_TMPFILE open().  Optional, equivalent to
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 69f378a837753e934c20b599660f8a756127e40a..595244d57cba62869b9af8b909af67d3c61e7f6c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -643,7 +643,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode *dir,
 
 static int
 v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		struct dentry *dentry, umode_t mode, bool excl)
+		struct dentry *dentry, umode_t mode)
 {
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(dir);
 	u32 perm = unixmode2p9mode(v9ses, mode);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 0b404e8484d22e2cbe60d846e0fa653001cdc4b1..de8fe9954d433c9b14ff5dd72ba13c3d5a67ebe7 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -218,7 +218,7 @@ int v9fs_open_to_dotl_flags(int flags)
  */
 static int
 v9fs_vfs_create_dotl(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry, umode_t omode, bool excl)
+		     struct dentry *dentry, umode_t omode)
 {
 	return v9fs_vfs_mknod_dotl(idmap, dir, dentry, omode, 0);
 }
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index ac4e9a02910b72d63c8ec5291347b54518e67f4b..665be23c42cfa206dc0a2c9ffa119b7c3c747389 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -167,7 +167,7 @@ extern int	affs_hash_name(struct super_block *sb, const u8 *name, unsigned int l
 extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, unsigned int);
 extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
 extern int	affs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool);
+			struct dentry *dentry, umode_t mode);
 extern struct dentry *affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode);
 extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index f883be50db122d3b09f0ae4d24618bd49b55186b..5591e1b5a2f68fc7600115e241f01f81d3aac010 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -243,7 +243,7 @@ affs_unlink(struct inode *dir, struct dentry *dentry)
 
 int
 affs_create(struct mnt_idmap *idmap, struct inode *dir,
-	    struct dentry *dentry, umode_t mode, bool excl)
+	    struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode	*inode;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 89d36e3e5c7999c2e448b78e86896d8893a8a7a9..09224aca8cad37ad273fd0c1ac292f0c15e078b5 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -32,7 +32,7 @@ static bool afs_lookup_one_filldir(struct dir_context *ctx, const char *name, in
 static bool afs_lookup_filldir(struct dir_context *ctx, const char *name, int nlen,
 			      loff_t fpos, u64 ino, unsigned dtype);
 static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl);
+		      struct dentry *dentry, umode_t mode);
 static struct dentry *afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				struct dentry *dentry, umode_t mode);
 static int afs_rmdir(struct inode *dir, struct dentry *dentry);
@@ -1637,7 +1637,7 @@ static const struct afs_operation_ops afs_create_operation = {
  * create a regular file on an AFS filesystem
  */
 static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	struct afs_operation *op;
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index 0ef9bcb744dd620bf47caa024d97a1316ff7bc89..5701361cf98155a61cb75a4ec602e8fc615eb3ae 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -29,7 +29,7 @@ static const struct file_operations bad_file_ops =
 
 static int bad_inode_create(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
-			    umode_t mode, bool excl)
+			    umode_t mode)
 {
 	return -EIO;
 }
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index c375e22c4c0c15ba27307d266adfe3f093b90ab8..6beb8605c523cc2c7250d7b1a61508e103f0f3fd 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -76,7 +76,7 @@ const struct file_operations bfs_dir_operations = {
 };
 
 static int bfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	int err;
 	struct inode *inode;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3b1b3a0553eea06229255ad0284d76074bdb958a..8e06baeabae594850607366ea4f4f0fa41e3b464 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6816,7 +6816,7 @@ static int btrfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int btrfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index d18c0eaef9b7e7be7eb517c701d6c4af08fd78ac..308903dc0780dbed2382228005d0221f185c61ee 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -976,7 +976,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int ceph_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	return ceph_mknod(idmap, dir, dentry, mode, 0);
 }
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index ca99900172657d80a479b2eb27f50effdf834995..554e7fd44e5df1aae6da2c41a492a02ae9e0d616 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -134,7 +134,7 @@ static inline void coda_dir_drop_nlink(struct inode *dir)
 
 /* creation routines: create, mknod, mkdir, link, symlink */
 static int coda_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *de, umode_t mode, bool excl)
+		       struct dentry *de, umode_t mode)
 {
 	int error;
 	const char *name=de->d_name.name;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index ba15e7359dfa6e150b577205991010873a633511..9a1ba68b16f3d6c4551e2d75e1e27309159c062e 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -262,7 +262,7 @@ int ecryptfs_initialize_file(struct dentry *ecryptfs_dentry,
 static int
 ecryptfs_create(struct mnt_idmap *idmap,
 		struct inode *directory_inode, struct dentry *ecryptfs_dentry,
-		umode_t mode, bool excl)
+		umode_t mode)
 {
 	struct inode *ecryptfs_inode;
 	int rc;
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 2891614abf8d554f563319187b6d54c2bc006a91..043b3e3a4f0adefe27855f8156b946c1dc4bd184 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -75,7 +75,7 @@ static bool efivarfs_valid_name(const char *str, int len)
 }
 
 static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			   struct dentry *dentry, umode_t mode, bool excl)
+			   struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode = NULL;
 	struct efivar_entry *var;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 7eb9c67fd35f4c54e18061a948806f20455675cf..c272a522c571044fd0cdc7630be30bdcec2ab8e5 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -543,7 +543,7 @@ static int exfat_add_entry(struct inode *inode, const char *path,
 }
 
 static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index bde617a66cecd4a2bf12a713a2297bb4fee45916..edea7784ad39acd4afffc7f5ae6e50a20c04999d 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -101,7 +101,7 @@ struct dentry *ext2_get_parent(struct dentry *child)
  */
 static int ext2_create (struct mnt_idmap * idmap,
 			struct inode * dir, struct dentry * dentry,
-			umode_t mode, bool excl)
+			umode_t mode)
 {
 	struct inode *inode;
 	int err;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2cd36f59c9e363124ee949f742adccd88447295a..a1e77390a7ce300db02db9af90e45d69efabfea5 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2806,7 +2806,7 @@ static int ext4_add_nondir(handle_t *handle,
  * with d_instantiate().
  */
 static int ext4_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	handle_t *handle;
 	struct inode *inode;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e469971dcf4e7a42416f9fbb8a5d9bf39..9bcbb8b521501b22d0fe2238b7729c342e95baa4 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -351,7 +351,7 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idmap,
 }
 
 static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
 	struct inode *inode;
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 0b920ee40a7f9fe3c57af5d939d3efedf001a3d9..905ffa9e5b99f1507734d99b7c16dcad21d7b5b5 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -262,7 +262,7 @@ static int msdos_add_entry(struct inode *dir, const unsigned char *name,
 
 /***** Create a file */
 static int msdos_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 5dbc4cbb8fce3d9b891cbc597f876c2c7b8d6aa0..8396b1ec4ec582fcdfadbcb12b04694ef0b8c5fc 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -754,7 +754,7 @@ static struct dentry *vfat_lookup(struct inode *dir, struct dentry *dentry,
 }
 
 static int vfat_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 667774cc72a1d49796f531fcb342d2e4878beb85..b7a2cee9b18313f88e745c5bb406bcc72866e390 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -889,7 +889,7 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *entry, umode_t mode, bool excl)
+		       struct dentry *entry, umode_t mode)
 {
 	return fuse_mknod(idmap, dir, entry, mode, 0);
 }
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8a7ed80d9f2d6e829b240629bdd18b5e0d30b5fc..b8e399dd1182b6ede0bcf1aa78bd7f9f2dca8b2b 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -942,15 +942,14 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
  * @dir: The directory in which to create the file
  * @dentry: The dentry of the new file
  * @mode: The mode of the new file
- * @excl: Force fail if inode exists
  *
  * Returns: errno
  */
 
 static int gfs2_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
-	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, excl);
+	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, 1);
 }
 
 /**
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474a95f283f6a0908582efadde80892..c585942aa985686ca428d2d17f4401aa845a0eb8 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -190,7 +190,7 @@ static int hfs_dir_release(struct inode *inode, struct file *file)
  * the directory and the name (and its length) of the new file.
  */
 static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	int res;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 1b3e27a0d5e038b559bd19b37d769078b2996d1b..c5ea04e078340a91b992095e189e978a3345f03c 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -518,7 +518,7 @@ static int hfsplus_mknod(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int hfsplus_create(struct mnt_idmap *idmap, struct inode *dir,
-			  struct dentry *dentry, umode_t mode, bool excl)
+			  struct dentry *dentry, umode_t mode)
 {
 	return hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 }
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 1e1acf5775ab5f6daf13bb917966d05f410d5ff5..18ca8cb9aa15e4015582ee5bd3db968c6b32de4b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -593,7 +593,7 @@ static struct inode *hostfs_iget(struct super_block *sb, char *name)
 }
 
 static int hostfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			 struct dentry *dentry, umode_t mode, bool excl)
+			 struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	char *name;
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 353e13a615f56664638f08a3408f90a727f5458b..809113d8248d50c0eaa57047b6c4bd87b9a5c6be 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -129,7 +129,7 @@ static struct dentry *hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	const unsigned char *name = dentry->d_name.name;
 	unsigned len = dentry->d_name.len;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9c94ed8c3ab0028772b7afb5d03a91d280c38106..0fd0d73e450bdedd92b953b9dd00f6babe1246e7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1001,7 +1001,7 @@ static struct dentry *hugetlbfs_mkdir(struct mnt_idmap *idmap, struct inode *dir
 
 static int hugetlbfs_create(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
-			    umode_t mode, bool excl)
+			    umode_t mode)
 {
 	return hugetlbfs_mknod(idmap, dir, dentry, mode | S_IFREG, 0);
 }
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index dd91f725ded69ccb3a240aafd72a4b552f21bcd9..e77c84e43621a8c53e9852843f18cc3514315650 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -25,7 +25,7 @@
 static int jffs2_readdir (struct file *, struct dir_context *);
 
 static int jffs2_create (struct mnt_idmap *, struct inode *,
-		         struct dentry *, umode_t, bool);
+			 struct dentry *, umode_t);
 static struct dentry *jffs2_lookup (struct inode *,struct dentry *,
 				    unsigned int);
 static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
@@ -161,7 +161,7 @@ static int jffs2_readdir(struct file *file, struct dir_context *ctx)
 
 
 static int jffs2_create(struct mnt_idmap *idmap, struct inode *dir_i,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct jffs2_raw_inode *ri;
 	struct jffs2_inode_info *f, *dir_f;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 65a218eba8faf9508f5727515b812f6de2661618..48111f8d3efe40becadd857c56c84ed09de867ef 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -60,7 +60,7 @@ static inline void free_ea_wmap(struct inode *inode)
  *
  */
 static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	int rc = 0;
 	tid_t tid;		/* transaction id */
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3cf65c7e57f88f1819689365951fea..6540574f54781eab487074de7fe10ed38b1a8d1e 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -64,7 +64,7 @@ static int minix_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int minix_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	return minix_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 }
diff --git a/fs/namei.c b/fs/namei.c
index d5ab28947b2b6c6e19c7bb4a9140ccec407dc07c..83da60fc298e523096e881b25c727d14f9553476 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3493,7 +3493,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 	error = try_break_deleg(dir, di);
 	if (error)
 		return error;
-	error = dir->i_op->create(idmap, dir, dentry, mode, true);
+	error = dir->i_op->create(idmap, dir, dentry, mode);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -3802,7 +3802,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		}
 
 		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
+						mode);
 		if (error)
 			goto out_dput;
 	}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 46d9c65d50f83fc1dc73f3d7f5868b84132bb0fd..7fe18efcd37b08030c7a4e17832801abfc19a3bd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2377,9 +2377,9 @@ static int nfs_do_create(struct inode *dir, struct dentry *dentry,
 }
 
 int nfs_create(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, umode_t mode, bool excl)
+	       struct dentry *dentry, umode_t mode)
 {
-	return nfs_do_create(dir, dentry, mode, excl ? O_EXCL : 0);
+	return nfs_do_create(dir, dentry, mode, O_EXCL);
 }
 EXPORT_SYMBOL_GPL(nfs_create);
 
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2ecd38e1d17a8053a9134702588d57efc35f49e9..b122c4f34f7b53c5102a8b5138efe269af433c81 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -398,7 +398,7 @@ extern unsigned long nfs_access_cache_scan(struct shrinker *shrink,
 struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
 void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
 int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
-	       umode_t, bool);
+	       umode_t);
 struct dentry *nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
 			 umode_t);
 int nfs_rmdir(struct inode *, struct dentry *);
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 40f4b1a28705b6e0eb8f0978cf3ac18b43aa1331..31d1d466c03048aaaab23f64c3f413c095939770 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -86,7 +86,7 @@ nilfs_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
  * with d_instantiate().
  */
 static int nilfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct nilfs_transaction_info ti;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 82c8ae56beee6d79046dd6c8f02ff0f35e9a1ad3..49fe635b550d3f51f81138649b47c9c831a73e3b 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -105,7 +105,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
  * ntfs_create - inode_operations::create
  */
 static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode, 0,
 				 NULL, 0, NULL);
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index cccaa1d6fbbac13ebcaf14a9183277890708e643..bd4b2269598b49c6f88dd8d201e246ee5ed855a6 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -454,8 +454,7 @@ static struct dentry *dlmfs_mkdir(struct mnt_idmap * idmap,
 static int dlmfs_create(struct mnt_idmap *idmap,
 			struct inode *dir,
 			struct dentry *dentry,
-			umode_t mode,
-			bool excl)
+			umode_t mode)
 {
 	int status = 0;
 	struct inode *inode;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c90b254da75eb5b90d2af5e37d41e781efe8b836..7443f468f45657cf68779a02e4edf4e38fb70f59 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -666,8 +666,7 @@ static struct dentry *ocfs2_mkdir(struct mnt_idmap *idmap,
 static int ocfs2_create(struct mnt_idmap *idmap,
 			struct inode *dir,
 			struct dentry *dentry,
-			umode_t mode,
-			bool excl)
+			umode_t mode)
 {
 	int ret;
 
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 2ed541fccf331d796805dd1594fbf05c1f7f3b9a..a09a98f7e30bc66deca60725f9462d081b5e4784 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -286,7 +286,7 @@ static struct dentry *omfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int omfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	return omfs_add_node(dir, dentry, mode | S_IFREG);
 }
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index bec5475de094dada6bb29eaf8520a875880f3bab..0ebaa7f000f26f1c1ecffd22cfe4272f20a783ed 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -18,8 +18,7 @@
 static int orangefs_create(struct mnt_idmap *idmap,
 			struct inode *dir,
 			struct dentry *dentry,
-			umode_t mode,
-			bool exclusive)
+			umode_t mode)
 {
 	struct orangefs_inode_s *parent = ORANGEFS_I(dir);
 	struct orangefs_kernel_op_s *new_op;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a5e9ddf3023b3942fafb9adb2770f26780a1b86b..0f70b3835f4a08c29d6bba8ae9143df55895e56b 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -704,7 +704,7 @@ static int ovl_create_object(struct dentry *dentry, int mode, dev_t rdev,
 }
 
 static int ovl_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	return ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
 }
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 41f9995da7cab0d11395cb40a98fb4936d52597f..b6502aaa4fb44d27c939da9fae4449af7edd28d4 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -129,7 +129,7 @@ static struct dentry *ramfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int ramfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	return ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
 }
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index e9534258d1efd0bb34f36bf2c725c64d0a8ca8f4..294c66cea2eca3344e09cd77619761e9cb79a807 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -50,7 +50,7 @@ extern void cifs_sb_deactive(struct super_block *sb);
 extern const struct inode_operations cifs_dir_inode_ops;
 extern struct inode *cifs_root_iget(struct super_block *);
 extern int cifs_create(struct mnt_idmap *, struct inode *,
-		       struct dentry *, umode_t, bool excl);
+		       struct dentry *, umode_t);
 extern int cifs_atomic_open(struct inode *, struct dentry *,
 			    struct file *, unsigned, umode_t);
 extern struct dentry *cifs_lookup(struct inode *, struct dentry *,
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index da5597dbf5b9f140c6801158ac2357fa911c52ab..b00bc214db9f0e9533f481f41ac99ac8937610ac 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -566,7 +566,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 }
 
 int cifs_create(struct mnt_idmap *idmap, struct inode *inode,
-		struct dentry *direntry, umode_t mode, bool excl)
+		struct dentry *direntry, umode_t mode)
 {
 	int rc;
 	unsigned int xid = get_xid();
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 3c3d3ad4fa6cb719e9ec08fa2164c55371c017c1..4840a6f7974e254eba4ca249357e968764e326e0 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -303,7 +303,7 @@ static int ubifs_prepare_create(struct inode *dir, struct dentry *dentry,
 }
 
 static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 5f2e9a892bffa9579143cedf71d80efa7ad6e9fb..f83b5564cbc4c68c02c07bb3ab2109bfabdc799d 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -371,7 +371,7 @@ static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 }
 
 static int udf_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode = udf_new_inode(dir, mode);
 
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 5b3c85c9324298f4ff6aa3d4feeb962ce5ede539..5012e056200aca671364d34a7faf647e6747e1d2 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -70,8 +70,7 @@ static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry, unsi
  * with d_instantiate(). 
  */
 static int ufs_create (struct mnt_idmap * idmap,
-		struct inode * dir, struct dentry * dentry, umode_t mode,
-		bool excl)
+		struct inode * dir, struct dentry * dentry, umode_t mode)
 {
 	struct inode *inode;
 
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 42bedc4ec7af7709c564a7174805d185ce86f854..330dade582d081e965c0e365bd2f96ae31d92ccc 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -298,9 +298,9 @@ static int vboxsf_dir_create(struct inode *parent, struct dentry *dentry,
 
 static int vboxsf_dir_mkfile(struct mnt_idmap *idmap,
 			     struct inode *parent, struct dentry *dentry,
-			     umode_t mode, bool excl)
+			     umode_t mode)
 {
-	return vboxsf_dir_create(parent, dentry, mode, false, excl, NULL);
+	return vboxsf_dir_create(parent, dentry, mode, false, true, NULL);
 }
 
 static struct dentry *vboxsf_dir_mkdir(struct mnt_idmap *idmap,
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index caff0125faeac093c1c05a722d3588e3f2e99926..2bc7faac35678b5b78acd6a50695a0d7b1c9a263 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -293,8 +293,7 @@ xfs_vn_create(
 	struct mnt_idmap	*idmap,
 	struct inode		*dir,
 	struct dentry		*dentry,
-	umode_t			mode,
-	bool			flags)
+	umode_t			mode)
 {
 	return xfs_generic_create(idmap, dir, dentry, mode, 0, NULL);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 64323e618724bc20dc101db13035b042f5f88e4d..b9a32e10078f5a1a0bbeb0d8913ac3e4b5b3a85d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2345,8 +2345,8 @@ struct inode_operations {
 
 	int (*readlink) (struct dentry *, char __user *,int);
 
-	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,
-		       umode_t, bool);
+	int (*create) (struct mnt_idmap *, struct inode *, struct dentry *,
+		       umode_t);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 093551fe66a7eb884fc34ef853a0ca92b95770af..9ae28c79fe0578bf96b2d22daed45b48aba0b946 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -610,7 +610,7 @@ static int mqueue_create_attr(struct dentry *dentry, umode_t mode, void *arg)
 }
 
 static int mqueue_create(struct mnt_idmap *idmap, struct inode *dir,
-			 struct dentry *dentry, umode_t mode, bool excl)
+			 struct dentry *dentry, umode_t mode)
 {
 	return mqueue_create_attr(dentry, mode, NULL);
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index b9081b817d28f3db1fbdd90ed3f04b6904d6ff18..8fdc9cbecb908e127f8173ca8888b5e038354fed 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3912,7 +3912,7 @@ static struct dentry *shmem_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 static int shmem_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	return shmem_mknod(idmap, dir, dentry, mode | S_IFREG, 0);
 }

---
base-commit: 76ddfe7d66d631e5e31ef4e5dd59797fa03acbf7
change-id: 20251105-create-excl-2b366d9bf3bb

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


