Return-Path: <linux-fsdevel+bounces-31633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238649992E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B132871E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE841D0483;
	Thu, 10 Oct 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ngCP2OSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66251EF949;
	Thu, 10 Oct 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589298; cv=none; b=fZipUbqKHeBT4rc07Hb/FHmzy7qEYLnJ4eoF1/jIZgkWKvVRGxKAy6vSPtP1U5BnOj/bPMcdzjOhfPVMnENOce6xRCw7aIeKK5l9r3STxDC7q9ch0RC6SR34hZ9zsadnh1oGDq/N9lH7NowForWBvCeYhqVyFYirpc2tLGjwFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589298; c=relaxed/simple;
	bh=9cm/RLr8Rzh1vFGh5pv0TyUOuYayhYnzXjVb8aJOmYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2oldi+B/MD+/wVqvPp70knXchTbvGzXqbsbTIidtC9YBu0bx5gWRm1uwpykE8mI5rr/4aEmZaJEXbo/bjYmPg7AGSS+s6gAZvxthvuTqII8kNQf2Fs3s55MEfFGT2uFzOuAa3D0fK6f7xN72AT1qpOXgEbRZXITlFHzJmiJlV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ngCP2OSX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zoE4RPJrEfLVHReDLgphj31bDW38mEz4OTwqDqkwzOs=; b=ngCP2OSX3FyNez4PeGc6ilBYL2
	VlvK0I+D6Vcx+oGjksNEOCAIhEsf2nmAeZ6yfNK0Xu7/OpLkbI9Ac8nl6cNsqLtwmiswOrnpbZ2gx
	qRLfHMUjuD1+lZ2yw3QPaZihs6cBD8JMFMVYgy6dvePodtMpof9Lx2cUBBFAsDX6KBRfeezxCmL5w
	S1dqfODKlVQn4QfZu47oIzYvKG0NwX/M1PCPVIyMbt4JPKJFsJcGhP1hNWgnn8Rnl5AfJcl1zk0uP
	s7whR7pHza136ZA/Y237m8Ul3amIqkqzFuST69DUr1vzeyb1T1+6Guvd38NpahdTd81nZP1a6LLnk
	Z7xNHMtg==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz2U-007SHz-0k; Thu, 10 Oct 2024 21:41:34 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:43 -0300
Subject: [PATCH v6 08/10] tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs
 dirs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-8-79f0ae02e4c8@igalia.com>
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
In-Reply-To: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Gabriel Krisman Bertazi <krisman@suse.de>
X-Mailer: b4 0.14.2

Enable setting flag FS_CASEFOLD_FL for tmpfs directories, when tmpfs is
mounted with casefold support. A special check is need for this flag,
since it can't be set for non-empty directories.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
Changes from v2:
- Fixed bug when adding a non-casefold flag in a non-empty dir
---
 include/linux/shmem_fs.h |  6 ++---
 mm/shmem.c               | 70 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 515a9a6a3c6f82c55952d821887514217a6a00d1..018da28c01e7d71b8fb00bfb23c000248c8a83f4 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -42,10 +42,10 @@ struct shmem_inode_info {
 	struct inode		vfs_inode;
 };
 
-#define SHMEM_FL_USER_VISIBLE		FS_FL_USER_VISIBLE
+#define SHMEM_FL_USER_VISIBLE		(FS_FL_USER_VISIBLE | FS_CASEFOLD_FL)
 #define SHMEM_FL_USER_MODIFIABLE \
-	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL)
-#define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL)
+	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL | FS_CASEFOLD_FL)
+#define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL | FS_CASEFOLD_FL)
 
 struct shmem_quota_limits {
 	qsize_t usrquota_bhardlimit; /* Default user quota block hard limit */
diff --git a/mm/shmem.c b/mm/shmem.c
index 935e824990799d927098fd88ebaba384a6284f42..1c130a7d58ff3a4f5f920374414f9e7a29347ed9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2760,13 +2760,62 @@ static int shmem_file_open(struct inode *inode, struct file *file)
 #ifdef CONFIG_TMPFS_XATTR
 static int shmem_initxattrs(struct inode *, const struct xattr *, void *);
 
+#if IS_ENABLED(CONFIG_UNICODE)
+/*
+ * shmem_inode_casefold_flags - Deal with casefold file attribute flag
+ *
+ * The casefold file attribute needs some special checks. I can just be added to
+ * an empty dir, and can't be removed from a non-empty dir.
+ */
+static int shmem_inode_casefold_flags(struct inode *inode, unsigned int fsflags,
+				      struct dentry *dentry, unsigned int *i_flags)
+{
+	unsigned int old = inode->i_flags;
+	struct super_block *sb = inode->i_sb;
+
+	if (fsflags & FS_CASEFOLD_FL) {
+		if (!(old & S_CASEFOLD)) {
+			if (!sb->s_encoding)
+				return -EOPNOTSUPP;
+
+			if (!S_ISDIR(inode->i_mode))
+				return -ENOTDIR;
+
+			if (dentry && !simple_empty(dentry))
+				return -ENOTEMPTY;
+		}
+
+		*i_flags = *i_flags | S_CASEFOLD;
+	} else if (old & S_CASEFOLD) {
+		if (dentry && !simple_empty(dentry))
+			return -ENOTEMPTY;
+	}
+
+	return 0;
+}
+#else
+static int shmem_inode_casefold_flags(struct inode *inode, unsigned int fsflags,
+				      struct dentry *dentry, unsigned int *i_flags)
+{
+	if (fsflags & FS_CASEFOLD_FL)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+#endif
+
 /*
  * chattr's fsflags are unrelated to extended attributes,
  * but tmpfs has chosen to enable them under the same config option.
  */
-static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
+static int shmem_set_inode_flags(struct inode *inode, unsigned int fsflags, struct dentry *dentry)
 {
 	unsigned int i_flags = 0;
+	int ret;
+
+	ret = shmem_inode_casefold_flags(inode, fsflags, dentry, &i_flags);
+	if (ret)
+		return ret;
 
 	if (fsflags & FS_NOATIME_FL)
 		i_flags |= S_NOATIME;
@@ -2777,10 +2826,12 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
 	/*
 	 * But FS_NODUMP_FL does not require any action in i_flags.
 	 */
-	inode_set_flags(inode, i_flags, S_NOATIME | S_APPEND | S_IMMUTABLE);
+	inode_set_flags(inode, i_flags, S_NOATIME | S_APPEND | S_IMMUTABLE | S_CASEFOLD);
+
+	return 0;
 }
 #else
-static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
+static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags, struct dentry *dentry)
 {
 }
 #define shmem_initxattrs NULL
@@ -2827,7 +2878,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
 	if (info->fsflags)
-		shmem_set_inode_flags(inode, info->fsflags);
+		shmem_set_inode_flags(inode, info->fsflags, NULL);
 	INIT_LIST_HEAD(&info->shrinklist);
 	INIT_LIST_HEAD(&info->swaplist);
 	simple_xattrs_init(&info->xattrs);
@@ -3934,16 +3985,23 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	int ret, flags;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 	if (fa->flags & ~SHMEM_FL_USER_MODIFIABLE)
 		return -EOPNOTSUPP;
 
-	info->fsflags = (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
+	flags = (info->fsflags & ~SHMEM_FL_USER_MODIFIABLE) |
 		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
 
-	shmem_set_inode_flags(inode, info->fsflags);
+	ret = shmem_set_inode_flags(inode, flags, dentry);
+
+	if (ret)
+		return ret;
+
+	info->fsflags = flags;
+
 	inode_set_ctime_current(inode);
 	inode_inc_iversion(inode);
 	return 0;

-- 
2.47.0


