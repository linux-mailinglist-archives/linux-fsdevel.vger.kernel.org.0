Return-Path: <linux-fsdevel+bounces-22501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E003991813B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F5031C215B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECAE18732E;
	Wed, 26 Jun 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="lLuD6Xr2";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="QEUqjuWf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930751862B5;
	Wed, 26 Jun 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405805; cv=none; b=KZlnBQEbilx9t3sgOl7Wn4w67WaW2/4DL3ykEY16VEmlJOJd7i4lzF5soXpV7LqeuABCkDcu3tbjlSDkFIIFt2it5tP+i3zS8FPCEYlMjmywekSceZHcgHE5S9HSnfDp+5kMNX5dmfJp/ppkV1x9OaCtkGYz9z9rrKDuTJweSf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405805; c=relaxed/simple;
	bh=OYg3LbwZXxIPuouiCexT6HmRrSzKBvfRKf7IJKxvKyg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jmxqmjjbn+O3UNqav8jgnCWIot0fzj829/niLbC4sQ6stNqtR5rIs/BkpgBojUqEc8iZ6ZCX3udUVKyKdFTtvLAp4W/CPsgcFs+yEWcM6cwUehGDXqRSOtCqQcaRXNxByWPUmsFBe+xnl9yvsTaBoHTmZGFmCHsl0t6j5AGkoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=lLuD6Xr2; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=QEUqjuWf; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 8C8872181;
	Wed, 26 Jun 2024 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405318;
	bh=x6v42ltW2TQhJ4m1feV/8na7F0D5BNgM2y9jP2a9AyA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lLuD6Xr2f5hBHwOwmPXesHrbYY0303SO4rYMQRXppkTf+45m8Ltoc/jFafE/7ZbME
	 NFM8bNZ7MmOv08ffBo/LWxXahv0qy8xqOYRWTh1J+ug9yv1JYKuPC9mq21/Bxr5ra3
	 VJEMfZcKZSO+MWRwUbnBR7AtLUOaaNgfworJV/yk=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B8D7E3E3;
	Wed, 26 Jun 2024 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1719405801;
	bh=x6v42ltW2TQhJ4m1feV/8na7F0D5BNgM2y9jP2a9AyA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QEUqjuWf+wpbFd/ggiYmXQOYVvfQohjG0B6n595XR1QJ07+O2X/B9p4NyjVJCKQ5n
	 p2zEDRNqOV61ZtXCI1/NfHhmd3RO3PO+Nmu5NfbCYaMSr8f6I57FzYfFqY+HmU5w+Z
	 U8OogJHSKyMIvT1Ppnzswc7OK/dimrpx8IW8Rxf0=
Received: from ntfs3vm.paragon-software.com (192.168.211.129) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 26 Jun 2024 15:43:21 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 10/11] fs/ntfs3: Implement simple fileattr
Date: Wed, 26 Jun 2024 15:42:57 +0300
Message-ID: <20240626124258.7264-11-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
References: <20240626124258.7264-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

fileattr added to support chattr.
Supported attributes:  compressed and immutable.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c    | 76 +++++++++++++++++++++++++++++++++++++++++++---
 fs/ntfs3/namei.c   |  2 ++
 fs/ntfs3/ntfs_fs.h |  3 ++
 3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index e95e9ffe6c0f..1ba837b27497 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -13,6 +13,7 @@
 #include <linux/compat.h>
 #include <linux/falloc.h>
 #include <linux/fiemap.h>
+#include <linux/fileattr.h>
 
 #include "debug.h"
 #include "ntfs.h"
@@ -48,6 +49,62 @@ static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
 	return 0;
 }
 
+/*
+ * ntfs_fileattr_get - inode_operations::fileattr_get
+ */
+int ntfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ntfs_inode *ni = ntfs_i(inode);
+	u32 flags = 0;
+
+	if (inode->i_flags & S_IMMUTABLE)
+		flags |= FS_IMMUTABLE_FL;
+
+	if (inode->i_flags & S_APPEND)
+		flags |= FS_APPEND_FL;
+
+	if (is_compressed(ni))
+		flags |= FS_COMPR_FL;
+
+	if (is_encrypted(ni))
+		flags |= FS_ENCRYPT_FL;
+
+	fileattr_fill_flags(fa, flags);
+
+	return 0;
+}
+
+/*
+ * ntfs_fileattr_set - inode_operations::fileattr_set
+ */
+int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
+		      struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	u32 flags = fa->flags;
+	unsigned int new_fl = 0;
+
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
+
+	if (flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL))
+		return -EOPNOTSUPP;
+
+	if (flags & FS_IMMUTABLE_FL)
+		new_fl |= S_IMMUTABLE;
+
+	if (flags & FS_APPEND_FL)
+		new_fl |= S_APPEND;
+
+	inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
+
+	inode_set_ctime_current(inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
 long ntfs_ioctl(struct file *filp, u32 cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
@@ -77,20 +134,27 @@ int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct inode *inode = d_inode(path->dentry);
 	struct ntfs_inode *ni = ntfs_i(inode);
 
+	stat->result_mask |= STATX_BTIME;
+	stat->btime = ni->i_crtime;
+	stat->blksize = ni->mi.sbi->cluster_size; /* 512, 1K, ..., 2M */
+
+	if (inode->i_flags & S_IMMUTABLE)
+		stat->attributes |= STATX_ATTR_IMMUTABLE;
+
+	if (inode->i_flags & S_APPEND)
+		stat->attributes |= STATX_ATTR_APPEND;
+
 	if (is_compressed(ni))
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 
 	if (is_encrypted(ni))
 		stat->attributes |= STATX_ATTR_ENCRYPTED;
 
-	stat->attributes_mask |= STATX_ATTR_COMPRESSED | STATX_ATTR_ENCRYPTED;
+	stat->attributes_mask |= STATX_ATTR_COMPRESSED | STATX_ATTR_ENCRYPTED |
+				 STATX_ATTR_IMMUTABLE | STATX_ATTR_APPEND;
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 
-	stat->result_mask |= STATX_BTIME;
-	stat->btime = ni->i_crtime;
-	stat->blksize = ni->mi.sbi->cluster_size; /* 512, 1K, ..., 2M */
-
 	return 0;
 }
 
@@ -1223,6 +1287,8 @@ const struct inode_operations ntfs_file_inode_operations = {
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
+	.fileattr_set	= ntfs_fileattr_set,
 };
 
 const struct file_operations ntfs_file_operations = {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 71498421ce60..cc04be9a4394 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -509,6 +509,8 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.fiemap		= ntfs_fiemap,
+	.fileattr_get	= ntfs_fileattr_get,
+	.fileattr_set	= ntfs_fileattr_set,
 };
 
 const struct inode_operations ntfs_special_inode_operations = {
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 6240ed742e7b..e5255a251929 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -497,6 +497,9 @@ extern const struct file_operations ntfs_dir_operations;
 extern const struct file_operations ntfs_legacy_dir_operations;
 
 /* Globals from file.c */
+int ntfs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
+		      struct fileattr *fa);
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
 int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-- 
2.34.1


