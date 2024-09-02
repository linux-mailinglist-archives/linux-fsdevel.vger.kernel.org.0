Return-Path: <linux-fsdevel+bounces-28299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EE896903A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 01:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A521C22DA8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 23:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5900E1922E0;
	Mon,  2 Sep 2024 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MUkc6dP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531818EFF4;
	Mon,  2 Sep 2024 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317754; cv=none; b=eSt/MrvFeVsi1EoUUqqFYvXuJEGWa7OO6fBK1tiy1EnZqnGb4yq1ZFz1uuMLvlwaWF5Uy6KJ0y+ik8vW2DKk2fANe+pve/jBzIQU7EPtckY2VF0LvY+IsmtjZjd9wP9AsUsy3byipOkQPRYHuj+0oKzOw5/U86FZvYQxn3b5ce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317754; c=relaxed/simple;
	bh=ctoMyX+wFnKAslq32GiehDs2d9NVHwSI9o6O4oky+Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0lUe5/FNtclsErMlS2e6Gzb8Zyfh4yYcu3Zy6do/sGFXsmdv/iL/7KFSdKI8d379Ts+3bPwi43o4CuQWgyDKdvUfF5tQl7qbknz/83dLIEJ6QBKs1oOmotiUkIfRDnYSCvd6Cdms/IgtPTHfVoDHoKvNs3nWs+fXxkO2OYIOCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MUkc6dP8; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/2i9Fi4oBPYgwH3vxA7dodmgTyqTZhVfRjdU73qonMA=; b=MUkc6dP85J2EBxkw+6Qhzqiask
	MAcs/wENfzy2vgBdutdU+tLIzXJHJWvEXb+YKkQW4Cx1+KivoxLgdp3qtjc/V+dl5Mw+sg5vM6Mrm
	g05+BAjToGNLTCLlRVR6RBSyAhwVC+4Dz+00uGwTlQFGMCk1Apd3HRWvIsSOKYt02cbWaM19ftwbV
	iE8x2tByMFC1mef3SLSQ0rErkGSYtUhHFaKVr9ZE2fPU7zbzRMfWkP9bXEohOWSrK9t+1b00v1OYc
	21dU82fo9APqJY4Sqr+jD5E6+XiS76JLMSuod904d+98gnOSPV+8ajywtt96wblst17BIJ9tonnyZ
	wEL0cOGA==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1slFxY-008VrL-95; Tue, 03 Sep 2024 00:55:44 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 6/8] tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs dirs
Date: Mon,  2 Sep 2024 19:55:08 -0300
Message-ID: <20240902225511.757831-7-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902225511.757831-1-andrealmeid@igalia.com>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable setting flag FS_CASEFOLD_FL for tmpfs directories, when tmpfs is
mounted with casefold support. A special check is need for this flag,
since it can't be set for non-empty directories.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/shmem_fs.h |  6 +++---
 mm/shmem.c               | 40 +++++++++++++++++++++++++++++++++-------
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 1d06b1e5408a..8367ca2b99d9 100644
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
index 0f918010bc54..9a0fc7636629 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2617,9 +2617,26 @@ static int shmem_initxattrs(struct inode *, const struct xattr *, void *);
  * chattr's fsflags are unrelated to extended attributes,
  * but tmpfs has chosen to enable them under the same config option.
  */
-static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
+static int shmem_set_inode_flags(struct inode *inode, unsigned int fsflags, struct dentry *dentry)
 {
-	unsigned int i_flags = 0;
+	unsigned int i_flags = 0, old = inode->i_flags;
+	struct super_block *sb = inode->i_sb;
+
+	if (fsflags & FS_CASEFOLD_FL) {
+		if (!sb->s_encoding)
+			return -EOPNOTSUPP;
+
+		if (!S_ISDIR(inode->i_mode))
+			return -ENOTDIR;
+
+		if (dentry && !simple_empty(dentry))
+			return -ENOTEMPTY;
+
+		i_flags |= S_CASEFOLD;
+	} else if (old & S_CASEFOLD) {
+		if (dentry && !simple_empty(dentry))
+			return -ENOTEMPTY;
+	}
 
 	if (fsflags & FS_NOATIME_FL)
 		i_flags |= S_NOATIME;
@@ -2630,10 +2647,12 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
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
@@ -2680,7 +2699,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
 	if (info->fsflags)
-		shmem_set_inode_flags(inode, info->fsflags);
+		shmem_set_inode_flags(inode, info->fsflags, NULL);
 	INIT_LIST_HEAD(&info->shrinklist);
 	INIT_LIST_HEAD(&info->swaplist);
 	simple_xattrs_init(&info->xattrs);
@@ -3790,16 +3809,23 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
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
2.46.0


