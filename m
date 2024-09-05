Return-Path: <linux-fsdevel+bounces-28781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A796E2A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF96DB211B7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197941AD277;
	Thu,  5 Sep 2024 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qRDe7y/i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128EC1AAE1A;
	Thu,  5 Sep 2024 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563028; cv=none; b=QPaKignvrG9I0HKKzpE2qdB3kedu2Si9f228yim0Y9DZlyl+ZRs9jiszI8bcCSrcl4pBRP+HXOYHlLB5qE7zFcDl/2rYSAt1++XQ0LZm0NSniCfYM0bjbgHYU2ixSomJyY6ArTFzkf6wZWoujfDU1CYovVxPSd6t47UR88IUiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563028; c=relaxed/simple;
	bh=udVdGInsZAbKFZEmGAi12TpwFH+Uj9R0zV/GtGqr7OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZWe/0W7jHQmXZ+6Lz7jUb1naB5KojqppKm/kqFOGY7EON819v6JsFq8kkfJXludQKmcCe78XzzB5BWU2ypH+VhxV/3bmzLdbcDrmGvr/BvjL4hwtexQWqDI9Mbgxk7JWNmrdaXpqeUTE8POkkPvqX9lS5ZfjkaYH71fQekoPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qRDe7y/i; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4vz8LJ8AGqtE46pXkxH06G/62SH6tsoXVW4UBJQz500=; b=qRDe7y/i3zJwIWrkmkWIlGSNG5
	S8C/1KxCMXfvhhaAOkFX3VUMNClSZ9JflAyBEbAWNSt9LmkJunrXCJ38rnWCAI3AkrbzWvxFUbSmB
	dHaJKveIWlR4idWLWfU0B9NTBUxH4379FDaEvV3v7uNz0wht/K27+ttfz58v1GqRiMoerG5SLowVh
	2Wlb+UhmxHeg+a0y9R4Nl1yT88f2AMWWVvksy2TJIWcOGGJoACJFsCmryE2FYHLXXx3FCuhhgCmVu
	KwLcBzQYqqKsXEV0Iuq84EY4KvQCcptkJ3q51oL+h/r4r4PaXqN95AQ9xJTeNPd/cAMDFK1FuCN4t
	5nN+1DJw==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smHla-00A6Ho-Is; Thu, 05 Sep 2024 21:03:38 +0200
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
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 7/9] tmpfs: Add flag FS_CASEFOLD_FL support for tmpfs dirs
Date: Thu,  5 Sep 2024 16:02:50 -0300
Message-ID: <20240905190252.461639-8-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905190252.461639-1-andrealmeid@igalia.com>
References: <20240905190252.461639-1-andrealmeid@igalia.com>
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
Changes from v2:
- Fixed bug when adding a non-casefold flag in a non-empty dir
---
 include/linux/shmem_fs.h |  6 ++--
 mm/shmem.c               | 70 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 67 insertions(+), 9 deletions(-)

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
index 6b61fc5dc0b1..d38977fb2097 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2613,13 +2613,62 @@ static int shmem_file_open(struct inode *inode, struct file *file)
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
@@ -2630,10 +2679,12 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
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
@@ -2680,7 +2731,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
 	if (info->fsflags)
-		shmem_set_inode_flags(inode, info->fsflags);
+		shmem_set_inode_flags(inode, info->fsflags, NULL);
 	INIT_LIST_HEAD(&info->shrinklist);
 	INIT_LIST_HEAD(&info->swaplist);
 	simple_xattrs_init(&info->xattrs);
@@ -3789,16 +3840,23 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
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


