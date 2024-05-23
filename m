Return-Path: <linux-fsdevel+bounces-20028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0918CCA42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D11F223E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 01:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C46D1C3E;
	Thu, 23 May 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="meSiAd/e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEAB1852;
	Thu, 23 May 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426629; cv=none; b=SD4cGZpye1bZO8AU54ZQloCp5tfLuqiyXlJrilovhq7X79QnMH8rN2/ISlGyNqkPRgXYghMEv9PHRdzn9YfPKXT9xl+4/uKYCbwKoImmDGFRzfMiYspS5IQLy6z9gl2gQ+caW4atrapk1vV9N5aOff1HyNAQLrAUoU8Pjrrjfxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426629; c=relaxed/simple;
	bh=HuabYTS3Zl5v6/6WFiOvVPLXMeztOjewve7QRboY710=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XH5cLbSeerTtUXpELdRmf4bvWida+QpgwSWDvmXguEPvAFjy+g3IIh6aNEoeeuw6KNoYjV2SRFpCOMsXVvgqQYK9cwV28/k3U+ARL1l5kIFw79xbqp9OFFzi5hQ+nThAIEm6/rNPYQZ/+TgrCL+bjb6w9rggs3qku/V7/5R//sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=meSiAd/e; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1716426619;
	bh=HuabYTS3Zl5v6/6WFiOvVPLXMeztOjewve7QRboY710=;
	h=From:To:Cc:Subject:Date:From;
	b=meSiAd/eAAYfZN+PnzeKmSM0BUtJPFulNm+7lK9QRN3oEvIX00G0AL97KKVjr7529
	 MSKiifh7JU1yXuYDQXqxrBKyEgODMGAbhfXa4e84i0iNShuUt8ylpWA+pTq64fAVPF
	 XmdW+BIDXCSYIvCL3L5dEpA/2yS4VG8QEfwVTE8OG9K+qUQN8NA1syDi8F5gC7Wsus
	 cLLvbmeLDobWqje3e8rxCppza+NokIeDkaOnhQY6Ae8DrM46liZrbc91gRgNCl/X/G
	 9jBvRTuNIbV5aYTDdHDEH9V7Gx5mhilTLJcIng1SxLKFTfXjeOtGsS8fJtmiYye/5p
	 vD+AL3ufzfC5Q==
Received: from localhost.localdomain (unknown [203.23.179.41])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vl9893bQRz10hQ;
	Wed, 22 May 2024 21:10:17 -0400 (EDT)
From: Michael Jeanson <mjeanson@efficios.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Jeanson <mjeanson@efficios.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	Seth Forshee <sforshee@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] exfat: handle idmapped mounts
Date: Wed, 22 May 2024 21:10:07 -0400
Message-ID: <20240523011007.40649-1-mjeanson@efficios.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass the idmapped mount information to the different helper
functions. Adapt the uid/gid checks in exfat_setattr to use the
vfsuid/vfsgid helpers.

Based on the fat implementation in commit 4b7899368108
("fat: handle idmapped mounts") by Christian Brauner.

Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sungjong Seo <sj1557.seo@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
---
 fs/exfat/file.c  | 22 +++++++++++++---------
 fs/exfat/super.c |  2 +-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 9adfc38ca7da..64c31867bc76 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -89,12 +89,14 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	return -EIO;
 }
 
-static bool exfat_allow_set_time(struct exfat_sb_info *sbi, struct inode *inode)
+static bool exfat_allow_set_time(struct mnt_idmap *idmap,
+				 struct exfat_sb_info *sbi, struct inode *inode)
 {
 	mode_t allow_utime = sbi->options.allow_utime;
 
-	if (!uid_eq(current_fsuid(), inode->i_uid)) {
-		if (in_group_p(inode->i_gid))
+	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
+			    current_fsuid())) {
+		if (vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)))
 			allow_utime >>= 3;
 		if (allow_utime & MAY_WRITE)
 			return true;
@@ -283,7 +285,7 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct inode *inode = d_backing_inode(path->dentry);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 
-	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
+	generic_fillattr(idmap, request_mask, inode, stat);
 	exfat_truncate_atime(&stat->atime);
 	stat->result_mask |= STATX_BTIME;
 	stat->btime.tv_sec = ei->i_crtime.tv_sec;
@@ -311,20 +313,22 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	/* Check for setting the inode time. */
 	ia_valid = attr->ia_valid;
 	if ((ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) &&
-	    exfat_allow_set_time(sbi, inode)) {
+	    exfat_allow_set_time(idmap, sbi, inode)) {
 		attr->ia_valid &= ~(ATTR_MTIME_SET | ATTR_ATIME_SET |
 				ATTR_TIMES_SET);
 	}
 
-	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	error = setattr_prepare(idmap, dentry, attr);
 	attr->ia_valid = ia_valid;
 	if (error)
 		goto out;
 
 	if (((attr->ia_valid & ATTR_UID) &&
-	     !uid_eq(attr->ia_uid, sbi->options.fs_uid)) ||
+	      (!uid_eq(from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid),
+	       sbi->options.fs_uid))) ||
 	    ((attr->ia_valid & ATTR_GID) &&
-	     !gid_eq(attr->ia_gid, sbi->options.fs_gid)) ||
+	      (!gid_eq(from_vfsgid(idmap, i_user_ns(inode), attr->ia_vfsgid),
+	       sbi->options.fs_gid))) ||
 	    ((attr->ia_valid & ATTR_MODE) &&
 	     (attr->ia_mode & ~(S_IFREG | S_IFLNK | S_IFDIR | 0777)))) {
 		error = -EPERM;
@@ -343,7 +347,7 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (attr->ia_valid & ATTR_SIZE)
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
-	setattr_copy(&nop_mnt_idmap, inode, attr);
+	setattr_copy(idmap, inode, attr);
 	exfat_truncate_inode_atime(inode);
 
 	if (attr->ia_valid & ATTR_SIZE) {
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 3d5ea2cfad66..1f2b3b0c4923 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -788,7 +788,7 @@ static struct file_system_type exfat_fs_type = {
 	.init_fs_context	= exfat_init_fs_context,
 	.parameters		= exfat_parameters,
 	.kill_sb		= exfat_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 
 static void exfat_inode_init_once(void *foo)
-- 
2.45.1


