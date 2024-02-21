Return-Path: <linux-fsdevel+bounces-12375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F04CC85EAA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D7BB278AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774FC13664C;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDKdLcLA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C577212AACD;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=IHNZD6d39L87TCy94cWelc33WtjygsZ0xr1PBrYKxK7if0yUx4JyzPKrinCJd4vh1l8IAw50RWqvPAb4L5wtGGLojCpv/g8881Qts1rXwR01C84mKsVJsJ+wCAdUXGKB+RQu3gNzokSxI7NIXSBTFKWkDvTTBzw+LfLaS6tlO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=YiCWnmvB8338QqWiqSd4eJ/jOoBDPxjCWf8ETipJD0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akAcypcQxT6ZiaFrOTP/g/cWCqiY7eFXCr5a5oNEHRT8HM99wRgr66l/vsepBhDAN+NtIAOROtw0RDx/l9IAPgBIz0R0ms5PzrXzMqRz0Wciw0QmaOBgBIxn+KRvTbzdZqyvqyzfVBcsblmDRsKBlsD69oHKKSOM0VI7leJTdg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDKdLcLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9CD28C3278C;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=YiCWnmvB8338QqWiqSd4eJ/jOoBDPxjCWf8ETipJD0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PDKdLcLANpifEiadIoWlJMyghRFtRhfHhPnLCDlmoF9CpDfb3TjWhrTzGIU/Wpz9U
	 lIrdLZr+Zm1PHC17yDX79paaM5tsJ7NiwiBNfLdHj1o94zBqB4JBXHMVMqPZagmkRE
	 X5T5YIA58J1NPm32Q19UguByGYvoS31Pif76BDl/jJgbUKjljzVqzDwEWuGIj7z0JE
	 Q0uYK7UhKkAuFddDuuBrsjjZ+xRqcN+64ggZh8XRl7Fk/Nxuu0foiy8jn8w/+M89CX
	 Uc+8vcTLrl7Ws+2GJAyH9cgg4J2tFXM0JkhaJAQ97zLf495Cb/p2ioXvFr8VjIocKu
	 DE4eLm26q/HyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89496C48BEB;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:44 -0600
Subject: [PATCH v2 13/25] smack: add hooks for fscaps operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-13-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3419; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=YiCWnmvB8338QqWiqSd4eJ/jOoBDPxjCWf8ETipJD0I=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1mokwpT6Wd5LYVT0NdW4vUmGJ?=
 =?utf-8?q?H9U+1d+cLjm5vxy_ILld6IGJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqJAAKCRBTA5mu5fQxyRbFB/_99rEgJl1COtBpH35uJRkwXLKAW2bI3ehYcq?=
 =?utf-8?q?wDZaWHYMV9allq0ZPBy2JON08GqXpiydvLVO/Ln9mCh_rrBTyNabTPZ5+6inOHWHz?=
 =?utf-8?q?Yen+5m4e//T+aD3C35Iu+fYOp1VWDMreKV9CBPDc+o7smjDrcwTT5U3HU_T+MiwUE?=
 =?utf-8?q?lmV0hrCl9mx1x6ZQ+OZDxR0wxJWjByWHuSobI8LpfwHLfOtNvETMAFmzDNRcoKxdH?=
 =?utf-8?q?lFIdgb_mLUONM0sKkjjuohgodnMIV64F6StQ4LkZuRqT/sMkNOSOPTPg69udW4Cj0?=
 =?utf-8?q?fS+JLVxodaQqo5+IAO07?= HkN+gK7eFDKtfF0Q+djswLOfkjsTiZ
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Add hooks for set/get/remove fscaps operations which perform the same
checks as the xattr hooks would have done for XATTR_NAME_CAPS.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 security/smack/smack_lsm.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0fdbf04cc258..1eaa89dede6b 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -1530,6 +1530,74 @@ static int smack_inode_remove_acl(struct mnt_idmap *idmap,
 	return rc;
 }
 
+/**
+ * smack_inode_set_fscaps - Smack check for setting file capabilities
+ * @mnt_userns: the userns attached to the source mnt for this request
+ * @detry: the object
+ * @caps: the file capabilities
+ * @flags: unused
+ *
+ * Returns 0 if the access is permitted, or an error code otherwise.
+ */
+static int smack_inode_set_fscaps(struct mnt_idmap *idmap,
+				  struct dentry *dentry,
+				  const struct vfs_caps *caps, int flags)
+{
+	struct smk_audit_info ad;
+	int rc;
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	return rc;
+}
+
+/**
+ * smack_inode_get_fscaps - Smack check for getting file capabilities
+ * @dentry: the object
+ *
+ * Returns 0 if access is permitted, an error code otherwise
+ */
+static int smack_inode_get_fscaps(struct mnt_idmap *idmap,
+				  struct dentry *dentry)
+{
+	struct smk_audit_info ad;
+	int rc;
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+
+	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_READ, &ad);
+	rc = smk_bu_inode(d_backing_inode(dentry), MAY_READ, rc);
+	return rc;
+}
+
+/**
+ * smack_inode_remove_acl - Smack check for removing file capabilities
+ * @idmap: idmap of the mnt this request came from
+ * @dentry: the object
+ *
+ * Returns 0 if access is permitted, an error code otherwise
+ */
+static int smack_inode_remove_fscaps(struct mnt_idmap *idmap,
+				     struct dentry *dentry)
+{
+	struct smk_audit_info ad;
+	int rc;
+
+	rc = cap_inode_removexattr(idmap, dentry, XATTR_NAME_CAPS);
+	if (rc != 0)
+		return rc;
+
+	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_DENTRY);
+	smk_ad_setfield_u_fs_path_dentry(&ad, dentry);
+
+	rc = smk_curacc(smk_of_inode(d_backing_inode(dentry)), MAY_WRITE, &ad);
+	rc = smk_bu_inode(d_backing_inode(dentry), MAY_WRITE, rc);
+	return rc;
+}
+
 /**
  * smack_inode_getsecurity - get smack xattrs
  * @idmap: idmap of the mount
@@ -5045,6 +5113,9 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_set_acl, smack_inode_set_acl),
 	LSM_HOOK_INIT(inode_get_acl, smack_inode_get_acl),
 	LSM_HOOK_INIT(inode_remove_acl, smack_inode_remove_acl),
+	LSM_HOOK_INIT(inode_set_fscaps, smack_inode_set_fscaps),
+	LSM_HOOK_INIT(inode_get_fscaps, smack_inode_get_fscaps),
+	LSM_HOOK_INIT(inode_remove_fscaps, smack_inode_remove_fscaps),
 	LSM_HOOK_INIT(inode_getsecurity, smack_inode_getsecurity),
 	LSM_HOOK_INIT(inode_setsecurity, smack_inode_setsecurity),
 	LSM_HOOK_INIT(inode_listsecurity, smack_inode_listsecurity),

-- 
2.43.0


