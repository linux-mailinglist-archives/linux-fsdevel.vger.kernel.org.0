Return-Path: <linux-fsdevel+bounces-32507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6169A6FD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 18:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C65F1F2419D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF01FA241;
	Mon, 21 Oct 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ssz0k7vO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D51F9AA3;
	Mon, 21 Oct 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528695; cv=none; b=tryIfbi8PfMRwLZQGfKOAHvHkrXMcEjHJfPj5ekQjGY5MdNOvEzFPYweZF06RV69BFC/0h8ZCxKsuWsVZVCvSt6jjXj45lStUszJGOXbeXMF31v1qncwHtaFpflJaTsLo4E/B7xqn5Brteu3/HlIOfM0eu4BRnV95b/Ta+65jmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528695; c=relaxed/simple;
	bh=01bYUjlWniV+v35+bdxjtzAFjb1bKIBipNGTZ8G+Fks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mdxLyj0vGs4EqjP2UvlRaXKTah0Bjg7irtklKfuHLk74t2PW/sZwyfL88wjbHO0NgqgypcZMEpKLPMoFaxcJF90OpmA8WOglpRuM1cF12ZFYoX2CkaTAw4H33LniLIOBJWpGfKYdWcGyV6pYBWy3IFSX8JryIGEQMiYo6PiFo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ssz0k7vO; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q02ijIMJQIrChEbtR3X8eciq/6AW4aNz0epCTvb52no=; b=ssz0k7vOogf/9lEXxWRLIbMC5m
	40jx4wEKB2ZtppeN9mWGSaUBES5N5lWdcKfi0hwIOJgHsvASvu5gPHgDrFaAVBTQ6YkkzXKH3ZAXK
	6C56v9dkdm8F8B6ifSxy93lAyBcQ9tAi+lAnmf8WqLGyYF2RlwB7g7DjF+9Y53d5tubzSwaHaPKGy
	9zz04KLihV1oNnW7o4YG6j0R/Lg6LTuJg1uBMupZrF3+QfPlfu0Ya6rr6g+uG70qT+3iwnQshutQK
	leTL/FWI3B08fsxeZNbECooKTflrDqrm8LQdBO0eftBeBz67ztuJne0g/1pNTuwkGxDqvn1U6tGxs
	l4Hnu3aA==;
Received: from [191.204.195.205] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t2vQ2-00DECf-G9; Mon, 21 Oct 2024 18:38:10 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 21 Oct 2024 13:37:23 -0300
Subject: [PATCH v8 7/9] tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs
 dirs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241021-tonyk-tmpfs-v8-7-f443d5814194@igalia.com>
References: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
In-Reply-To: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 Gabriel Krisman Bertazi <krisman@suse.de>, 
 Gabriel Krisman Bertazi <gabriel@krisman.be>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Enable setting flag FS_CASEFOLD_FL for tmpfs directories, when tmpfs is
mounted with casefold support. A special check is need for this flag,
since it can't be set for non-empty directories.

Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
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
index f26488ff3d6ae1abb9b63d55ca74909249dbf4eb..ea01628e443423d82d44277e085b867ab9bf4b28 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2757,13 +2757,62 @@ static int shmem_file_open(struct inode *inode, struct file *file)
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
@@ -2774,10 +2823,12 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
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
@@ -2824,7 +2875,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
 	if (info->fsflags)
-		shmem_set_inode_flags(inode, info->fsflags);
+		shmem_set_inode_flags(inode, info->fsflags, NULL);
 	INIT_LIST_HEAD(&info->shrinklist);
 	INIT_LIST_HEAD(&info->swaplist);
 	simple_xattrs_init(&info->xattrs);
@@ -3931,16 +3982,23 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
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


