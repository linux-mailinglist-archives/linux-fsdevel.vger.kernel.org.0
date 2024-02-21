Return-Path: <linux-fsdevel+bounces-12373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A7085EA7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6F41F25273
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514971350DC;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcGjqVa6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53DB12A159;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=Hhr/StRxHc3WsK2BxTkX0KRd+v3FRga5bJuGpWPjuU/aldbaUUz7WrcHeLO5+IHS1QkwzSz/ues9CHEKj8Kiwyz9h8hRy6GeGqphwY4qvDZ+kjdjKTC3XAqoRGlXEAArTy0Tv/IZWsydkqSEKRXXoBe3eo/PhI7g1WydDLRDx7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=bU1CcTjoAErUmCcImLT8MBeG6twr7o4CKTQE5qVrAgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R98W8t02rueguCO9l1ED1Zjm15qEUJfB5zTXEQztggDkyLx9HjvMHiT/cH/tMSZkJzJrHfPhDSaUDdHO12F7sN9d2brJhL1kC83EYAW7lE7CHXMdxnu6MNYaWYiT73M5oQQpm2kK6mCmQcMaYpY4JQzHKH+VlgZx0r1DFF6+W90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcGjqVa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 787C8C32785;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=bU1CcTjoAErUmCcImLT8MBeG6twr7o4CKTQE5qVrAgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FcGjqVa6LFtv3wIisQX3ULDicQYa/7JUNgjsOxVOxVbBN2XRKtt4vccq6xj9Gg/UL
	 5W+QHPa31Tm++/4yeexKz1kIqJWieCefTCFEudO9BXLtaxfQ56UTNPEKKXwFOECfG0
	 zaxRPGXu6muDcX8/b2TWgdd++UA+Jv8tMmcuP7dZUhlshRqWZWnxUUceHir+xqAXNL
	 /4Z/kBljMAkI3uBcjW2ihJRj0Z3WARjJKDXjYVmtXOC8oje28yVXhxoAoAEtkIumOt
	 PkCru4mDI9qYc3RH/TkC/DUCv/G5BSkUKupMfd8XJszSZMRYhatK4ijIx3sWYNSG/1
	 rXQxNtC4NzCyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64819C5478B;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:42 -0600
Subject: [PATCH v2 11/25] security: add hooks for set/get/remove of fscaps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-11-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6068; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=bU1CcTjoAErUmCcImLT8MBeG6twr7o4CKTQE5qVrAgQ=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1moiOmBWOkW3C2D6watYerA1n?=
 =?utf-8?q?6u6GpH/leMlBqw7_WLNKqEiJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqIgAKCRBTA5mu5fQxyX4hB/_4gHtUbOV115lPuC//xfy9D4S1XJ5dcZzKpX?=
 =?utf-8?q?27IoQgRAB8iadS9qTPZMY9JzN+fEAEJjKFFAFM94cF0_rLytBPDiTKSoKBhm83DGI?=
 =?utf-8?q?fLJyy9gdXXFGXFzmy5MzY4VkuLjCzBltyOieqCT8M64K49wiTDIWCrTku_mf3oZbj?=
 =?utf-8?q?kX8CKEyWzC5OjK08smBtBMLPrNQbDTlb5J2i75XOVmI2yrPuZMCJojB8IN39jKaJ8?=
 =?utf-8?q?UX3Hjc_HElICYbTk+WAYh9ZuZUpzzyo7IEH0c3YjbR8PLFH7Xg0ZTT5jPH6Ccksrf?=
 =?utf-8?q?7oNmjUcAAUf7e/S7Xd7K?= vW7wHQVxNqrw0G7gjCWEoB0nJW9wrt
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

In preparation for moving fscaps out of the xattr code paths, add new
security hooks. These hooks are largely needed because common kernel
code will pass around struct vfs_caps pointers, which EVM will need to
convert to raw xattr data for verification and updates of its hashes.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/lsm_hook_defs.h |  7 +++++
 include/linux/security.h      | 33 +++++++++++++++++++++
 security/security.c           | 69 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 76458b6d53da..7b3c23f9e4a5 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -152,6 +152,13 @@ LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
+LSM_HOOK(int, 0, inode_set_fscaps, struct mnt_idmap *idmap,
+	 struct dentry *dentry, const struct vfs_caps *caps, int flags);
+LSM_HOOK(void, LSM_RET_VOID, inode_post_set_fscaps, struct mnt_idmap *idmap,
+	 struct dentry *dentry, const struct vfs_caps *caps, int flags);
+LSM_HOOK(int, 0, inode_get_fscaps, struct mnt_idmap *idmap, struct dentry *dentry);
+LSM_HOOK(int, 0, inode_remove_fscaps, struct mnt_idmap *idmap,
+	 struct dentry *dentry);
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
 	 struct dentry *dentry)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..40be548e5e12 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -378,6 +378,13 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
 int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
+int security_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+			      const struct vfs_caps *caps, int flags);
+void security_inode_post_set_fscaps(struct mnt_idmap *idmap,
+				    struct dentry *dentry,
+				    const struct vfs_caps *caps, int flags);
+int security_inode_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry);
+int security_inode_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -935,6 +942,32 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
 	return cap_inode_removexattr(idmap, dentry, name);
 }
 
+static inline int security_inode_set_fscaps(struct mnt_idmap *idmap,
+					    struct dentry *dentry,
+					    const struct vfs_caps *caps,
+					    int flags)
+{
+	return 0;
+}
+static void security_inode_post_set_fscaps(struct mnt_idmap *idmap,
+					   struct dentry *dentry,
+					   const struct vfs_caps *caps,
+					   int flags)
+{
+}
+
+static int security_inode_get_fscaps(struct mnt_idmap *idmap,
+				     struct dentry *dentry)
+{
+	return 0;
+}
+
+static int security_inode_remove_fscaps(struct mnt_idmap *idmap,
+					struct dentry *dentry)
+{
+	return 0;
+}
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index 3aaad75c9ce8..0d210da9862c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2351,6 +2351,75 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 	return evm_inode_remove_acl(idmap, dentry, acl_name);
 }
 
+/**
+ * security_inode_set_fscaps() - Check if setting fscaps is allowed
+ * @idmap: idmap of the mount
+ * @dentry: file
+ * @caps: fscaps to be written
+ * @flags: flags for setxattr
+ *
+ * Check permission before setting the file capabilities given in @vfs_caps.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
+			      const struct vfs_caps *caps, int flags)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+	return call_int_hook(inode_set_fscaps, 0, idmap, dentry, caps, flags);
+}
+
+/**
+ * security_inode_post_set_fscaps() - Update the inode after setting fscaps
+ * @idmap: idmap of the mount
+ * @dentry: file
+ * @caps: fscaps to be written
+ * @flags: flags for setxattr
+ *
+ * Update inode security field after successfully setting fscaps.
+ *
+ */
+void security_inode_post_set_fscaps(struct mnt_idmap *idmap,
+				    struct dentry *dentry,
+				    const struct vfs_caps *caps, int flags)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_set_fscaps, idmap, dentry, caps, flags);
+}
+
+/**
+ * security_inode_get_fscaps() - Check if reading fscaps is allowed
+ * @dentry: file
+ *
+ * Check permission before getting fscaps.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+	return call_int_hook(inode_get_fscaps, 0, idmap, dentry);
+}
+
+/**
+ * security_inode_remove_fscaps() - Check if removing fscaps is allowed
+ * @idmap: idmap of the mount
+ * @dentry: file
+ *
+ * Check permission before removing fscaps.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return 0;
+	return call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
+}
+
 /**
  * security_inode_post_setxattr() - Update the inode after a setxattr operation
  * @dentry: file

-- 
2.43.0


