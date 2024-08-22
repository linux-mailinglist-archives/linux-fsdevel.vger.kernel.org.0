Return-Path: <linux-fsdevel+bounces-26796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B87495BB0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE5A1C2350B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5456C1CE6F6;
	Thu, 22 Aug 2024 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="dSkZfuai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BD1CCEF5;
	Thu, 22 Aug 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724341951; cv=none; b=OCX8x+g6EE1rxtLbwU0q42mQHqn6pn21YJe+FyP0eiO8jiKXlqctzHOcB/jpcremtIztIklq6WnwJf0VGDg0bm4sPsPPKBYXhqSYmm2OQ3S4tDKuf1tZ+QEf6BsJvjzv2h1TnwFlEnDKG+NkZWx19qlBA2ce6LsV2S46X8MkVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724341951; c=relaxed/simple;
	bh=9h5FSLuJnpUl6DW5Y3Ja5OAwAdENnoC4y4wP6A2MlWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4bKecKwvhRt2eC1l05n2vS/TGO3S6GFVZ5MSiRfvkybX9IDO5uDQCgaXXIKuxAQorY2bsVaNFia/ptl1XN/l0EijLFaho+9BRe+n0lZ08NDnBaiHxp7ntDaValozWkq0uZ2UfO3TRreyxdrutqhfJAOAIxBEv8QdyNfCpiU+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=dSkZfuai; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id DDA6921E2;
	Thu, 22 Aug 2024 15:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341468;
	bh=iNn4KZvsZlbXO5dNMkzf967/FpvsJ3+J/AvQ5udPFZ4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=dSkZfuaiuEEwr0qiRsAZ3SwQYpu6jxlzg2l4NLCvNo7MAgCMJ+2akWzPM5NHlYd6Z
	 AtBZQDb9gNQNSbdoPP3ZBmQ65S/UdCoQEu3sCZHIbMgH5/OKn5FD8TPqnBax6+L4oK
	 WpBFNJYxRtQc5lBEQyNGxqCGP/6CMmdb72YJqDQ4=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:24 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 14/14] fs/ntfs3: Rename ntfs3_setattr into ntfs_setattr
Date: Thu, 22 Aug 2024 18:52:07 +0300
Message-ID: <20240822155207.600355-15-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Aligning names to a single naming convention.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c    | 8 ++++----
 fs/ntfs3/inode.c   | 2 +-
 fs/ntfs3/namei.c   | 4 ++--
 fs/ntfs3/ntfs_fs.h | 4 ++--
 fs/ntfs3/xattr.c   | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 77f96665744e..4fdcb5177ea1 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -789,10 +789,10 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 }
 
 /*
- * ntfs3_setattr - inode_operations::setattr
+ * ntfs_setattr - inode_operations::setattr
  */
-int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-		  struct iattr *attr)
+int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
 	struct ntfs_inode *ni = ntfs_i(inode);
@@ -1370,7 +1370,7 @@ static ssize_t ntfs_file_splice_write(struct pipe_inode_info *pipe,
 // clang-format off
 const struct inode_operations ntfs_file_inode_operations = {
 	.getattr	= ntfs_getattr,
-	.setattr	= ntfs3_setattr,
+	.setattr	= ntfs_setattr,
 	.listxattr	= ntfs_listxattr,
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index d142f15b24e7..1963a8928360 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -2083,7 +2083,7 @@ static const char *ntfs_get_link(struct dentry *de, struct inode *inode,
 // clang-format off
 const struct inode_operations ntfs_link_inode_operations = {
 	.get_link	= ntfs_get_link,
-	.setattr	= ntfs3_setattr,
+	.setattr	= ntfs_setattr,
 	.listxattr	= ntfs_listxattr,
 };
 
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index f16d318c4372..fc720ad9c57a 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -503,7 +503,7 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.rename		= ntfs_rename,
 	.get_acl	= ntfs_get_acl,
 	.set_acl	= ntfs_set_acl,
-	.setattr	= ntfs3_setattr,
+	.setattr	= ntfs_setattr,
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.fiemap		= ntfs_fiemap,
@@ -512,7 +512,7 @@ const struct inode_operations ntfs_dir_inode_operations = {
 };
 
 const struct inode_operations ntfs_special_inode_operations = {
-	.setattr	= ntfs3_setattr,
+	.setattr	= ntfs_setattr,
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
 	.get_acl	= ntfs_get_acl,
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index d8d71a211194..0629f0adf124 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -503,8 +503,8 @@ int ntfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		      struct fileattr *fa);
 int ntfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, u32 flags);
-int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
-		  struct iattr *attr);
+int ntfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+		 struct iattr *attr);
 int ntfs_file_open(struct inode *inode, struct file *file);
 int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		__u64 start, __u64 len);
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 0703e1ae32b2..e0055dcf8fe3 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -705,7 +705,7 @@ int ntfs_init_acl(struct mnt_idmap *idmap, struct inode *inode,
 #endif
 
 /*
- * ntfs_acl_chmod - Helper for ntfs3_setattr().
+ * ntfs_acl_chmod - Helper for ntfs_setattr().
  */
 int ntfs_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry)
 {
-- 
2.34.1


