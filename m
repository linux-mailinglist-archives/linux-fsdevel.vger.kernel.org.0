Return-Path: <linux-fsdevel+bounces-11687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3504B85600B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAFFB32B6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4DE134CD1;
	Thu, 15 Feb 2024 10:37:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B448128382;
	Thu, 15 Feb 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993425; cv=none; b=fVBZVpqQz7aGk6s/e5ci3cZtDos4i3LCeRVEKWXypZl+teH2MZhFEBgYZZss7ozNT+j+8xV4beNQvtYGE1u11YZO9CZTrIGTONAAh05SsqUzb61JWHJeWPlRCt24vEWg0eN3mLtshrNaPCfcARSKZNvJgLlnapx/iP509IvPtjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993425; c=relaxed/simple;
	bh=3ohd0+FK3i6DxMn4LeOCRryfTy2Al78p0Z5ydrSnuYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=inJXbET0weDf4L9fpgy0B8wtNbFSvJSJ7fGyYfC11K/GlbDmRW4AOm5vXN0Neiezni85IcGUBgQCjr04OO2scMHLfGDJz0a+9D7wQozMD9NgYtCpprVkZ5yQZxMl0+ao53gj08+tusOZp4W8maLzeh11wjJ6+WMAzjWuYvxFeFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tb9xC3J8Mz9xxnZ;
	Thu, 15 Feb 2024 18:17:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 20CC91405A2;
	Thu, 15 Feb 2024 18:36:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LxjQ6M1l4QeNAg--.58293S9;
	Thu, 15 Feb 2024 11:36:49 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com,
	casey@schaufler-ca.com,
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 17/25] security: Introduce inode_post_remove_acl hook
Date: Thu, 15 Feb 2024 11:31:05 +0100
Message-Id: <20240215103113.2369171-18-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
References: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwA3LxjQ6M1l4QeNAg--.58293S9
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUXFy3Kw1DWF43CrW3Wrg_yoWrCw17pF
	43K3Z8Wr4rXFy7WryktFWUuw4SvFWFgry7A3y2gwn2vFn7tr1jqFsxKFyjkry5ArW8KF1q
	qF1aqrsxC345Jr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UdfHUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5Zf3wAAsv

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the inode_post_remove_acl hook.

At inode_remove_acl hook, EVM verifies the file's existing HMAC value. At
inode_post_remove_acl, EVM re-calculates the file's HMAC with the passed
POSIX ACL removed and other file metadata.

Other LSMs could similarly take some action after successful POSIX ACL
removal.

The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 fs/posix_acl.c                |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 security/security.c           | 17 +++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 7556ee9f8a51..0d2371240c1b 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1246,6 +1246,7 @@ int vfs_remove_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
+		security_inode_post_remove_acl(idmap, dentry, acl_name);
 		evm_inode_post_remove_acl(idmap, dentry, acl_name);
 	}
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index b0125c99f80a..7e414ba26333 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -163,6 +163,8 @@ LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_remove_acl, struct mnt_idmap *idmap,
+	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_need_killpriv, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_killpriv, struct mnt_idmap *idmap,
 	 struct dentry *dentry)
diff --git a/include/linux/security.h b/include/linux/security.h
index c372797e1617..4b03c76b91f1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -378,6 +378,9 @@ int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name);
 int security_inode_remove_acl(struct mnt_idmap *idmap,
 			      struct dentry *dentry, const char *acl_name);
+void security_inode_post_remove_acl(struct mnt_idmap *idmap,
+				    struct dentry *dentry,
+				    const char *acl_name);
 void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags);
 int security_inode_getxattr(struct dentry *dentry, const char *name);
@@ -936,6 +939,11 @@ static inline int security_inode_remove_acl(struct mnt_idmap *idmap,
 	return 0;
 }
 
+static inline void security_inode_post_remove_acl(struct mnt_idmap *idmap,
+						  struct dentry *dentry,
+						  const char *acl_name)
+{ }
+
 static inline void security_inode_post_setxattr(struct dentry *dentry,
 		const char *name, const void *value, size_t size, int flags)
 { }
diff --git a/security/security.c b/security/security.c
index f7df58bd5f13..23cdf35b6070 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2414,6 +2414,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 	return evm_inode_remove_acl(idmap, dentry, acl_name);
 }
 
+/**
+ * security_inode_post_remove_acl() - Update inode security after rm posix acls
+ * @idmap: idmap of the mount
+ * @dentry: file
+ * @acl_name: acl name
+ *
+ * Update inode security data after successfully removing posix acls on
+ * @dentry in @idmap. The posix acls are identified by @acl_name.
+ */
+void security_inode_post_remove_acl(struct mnt_idmap *idmap,
+				    struct dentry *dentry, const char *acl_name)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
+}
+
 /**
  * security_inode_post_setxattr() - Update the inode after a setxattr operation
  * @dentry: file
-- 
2.34.1


