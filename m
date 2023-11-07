Return-Path: <linux-fsdevel+bounces-2251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6967E40CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 14:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08DD1C20C6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 13:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141EB30FA7;
	Tue,  7 Nov 2023 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7130D1C;
	Tue,  7 Nov 2023 13:46:13 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99CA268B;
	Tue,  7 Nov 2023 05:46:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SPpwv51p6z9xsll;
	Tue,  7 Nov 2023 21:29:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnFXUiP0plvHc3AA--.54683S9;
	Tue, 07 Nov 2023 14:45:41 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
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
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 17/23] security: Introduce inode_post_remove_acl hook
Date: Tue,  7 Nov 2023 14:40:06 +0100
Message-Id: <20231107134012.682009-18-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
References: <20231107134012.682009-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAnFXUiP0plvHc3AA--.54683S9
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDCFW3JF48AF4rArWfAFb_yoWrAr48pF
	srK3ZxWw4rXFy2gryktFWDuw1SvFWFgry7A3y2gw4IyFn2yr1jqFsxGFyjkry5ArW8KF1q
	qF1aqrsxC343Jr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUoeOJUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5IbfQAAsN
X-CFilter-Loop: Reflected

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
---
 fs/posix_acl.c                |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 security/security.c           | 17 +++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 58e3c1e2fbbc..e3fbe1a9f3f5 100644
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
index 6a671616196f..2bf128f7cbae 100644
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
index d71d0b08e9fe..7cd7126f6545 100644
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
@@ -934,6 +937,11 @@ static inline int security_inode_remove_acl(struct mnt_idmap *idmap,
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
index d2dbea54a63a..6eb7c9cff1e5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2413,6 +2413,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
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


