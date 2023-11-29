Return-Path: <linux-fsdevel+bounces-4271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A88157FE349
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAFDD1C20A12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4615647A58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmCkgtjR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896361FC2;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 033B2C433BA;
	Wed, 29 Nov 2023 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294658;
	bh=RKuTcbYgZvHVKggTHC2zuvdJ26QENxjmgCweIZ3eegk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kmCkgtjRpxDsMEC0ScFiG7Rywqww7dZDZdR+Pvl32kQYeYkBhGbMSQ5A15W+uVQAp
	 zIU/dIEFszza21uQmGoWrZTNZOwdsKbhCNSWZEkfc/gNsaPlyBQiFbcyyQLvkIECRG
	 O2tXZprWsHPVckIsbdUyITzR4EIteUYDgn4DqMFwCawFTVm3RDkU8Lr+sNYYhs2lCf
	 JN0dIJ0OIL/kLZy3QYqigqL3elHHlVqRoeBjGiU3O/BUOZLcYzmLdWpTpFHGHg+hoF
	 gPc/oBvA+YOpi1ZYy+wbesrPM9mwGAGCu1dsm217JRrW67zGDbe7G7UZdsMhJk9m+X
	 /OfUFmXZuGZYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CDEC10F04;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:28 -0600
Subject: [PATCH 10/16] fs: add vfs_remove_fscaps()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-10-da5a26058a5b@kernel.org>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3668; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=RKuTcbYgZvHVKggTHC2zuvdJ26QENxjmgCweIZ3eegk=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7I64UBhX2GGFexH+bBTTpHN+?=
 =?utf-8?q?1ZZSs/s9GteH5Ya_Ao5bAXqJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyOgAKCRBTA5mu5fQxyZvhB/_9/0OH7uhQCHOgqtW6u1AsBk1GTbo0kK20Cn?=
 =?utf-8?q?bD4KJ5wbBLk1DZBgcWkKnbOEwoDBTbsYps5A36R5VNO_+3Jq2pg5sBcXDPdXt43p2?=
 =?utf-8?q?/gfipt41G5bIASpTWS8pnm/RFRtLvNURjT8VLyGrEcrY9H85teLbZ2qyC_PHy7qr5?=
 =?utf-8?q?+BlZwhbvKU3JmBQSjSS4CAP2nzCOumOJGM3t2SeYGZK15fNVExtZSKfg+ueOdR9Bc?=
 =?utf-8?q?eWrP2U_3Vp+H5E9v+M/1Sl3vEwEAdBaicRWTe69HeZD0cn0is1XhMgEf3iu940R8R?=
 =?utf-8?q?LLSo97mWrtbmWNopBk91?= XzbOBlAStUH2Ld9boVsTifWqMzAAuI
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Provide a type-safe interface for removing filesystem capabilities and
a generic implementation suitable for most filesystems. Also add an
internal interface, __vfs_remove_fscaps(), which is called with the
inode lock held and skips security checks for later use from the
capability code.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/xattr.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 2 files changed, 79 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 03cc824e4f87..f60ef2a79dfa 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -334,6 +334,83 @@ int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
 }
 EXPORT_SYMBOL(vfs_set_fscaps);
 
+static int generic_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	return __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
+}
+
+/**
+ * __vfs_remove_fscaps - remove filesystem capabilities without security checks
+ * @idmap: idmap of the mount the inode was found from
+ * @dentry: the dentry from which to remove filesystem capabilities
+ *
+ * This function removes any filesystem capabilities from the specified
+ * dentry. Does not perform any security checks, and callers must hold the
+ * inode lock.
+ *
+ * Return: 0 on success, a negative errno on error.
+ */
+int __vfs_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	int error;
+
+	if (inode->i_op->remove_fscaps)
+		error =  inode->i_op->remove_fscaps(idmap, dentry);
+	else
+		error = generic_remove_fscaps(idmap, dentry);
+
+	return error;
+}
+
+/**
+ * vfs_remove_fscaps - remove filesystem capabilities
+ * @idmap: idmap of the mount the inode was found from
+ * @dentry: the dentry from which to remove filesystem capabilities
+ *
+ * This function removes any filesystem capabilities from the specified
+ * dentry.
+ *
+ * Return: 0 on success, a negative errno on error.
+ */
+int vfs_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	struct inode *inode = dentry->d_inode;
+	struct inode *delegated_inode = NULL;
+	int error;
+
+retry_deleg:
+	inode_lock(inode);
+
+	error = xattr_permission(idmap, inode, XATTR_NAME_CAPS, MAY_WRITE);
+	if (error)
+		goto out_inode_unlock;
+
+	error = security_inode_removexattr(idmap, dentry, XATTR_NAME_CAPS);
+	if (error)
+		goto out_inode_unlock;
+
+	error = try_break_deleg(inode, &delegated_inode);
+	if (error)
+		goto out_inode_unlock;
+
+	error = __vfs_remove_fscaps(idmap, dentry);
+	if (!error)
+		fsnotify_xattr(dentry);
+
+out_inode_unlock:
+	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(vfs_remove_fscaps);
+
 int
 __vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	       struct inode *inode, const char *name, const void *value,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 80992e210b83..057bad11a4e6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2061,6 +2061,8 @@ extern int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
 			  struct vfs_caps *caps);
 extern int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
 			  const struct vfs_caps *caps, int flags);
+extern int __vfs_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry);
+extern int vfs_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry);
 
 enum freeze_holder {
 	FREEZE_HOLDER_KERNEL	= (1U << 0),

-- 
2.43.0


