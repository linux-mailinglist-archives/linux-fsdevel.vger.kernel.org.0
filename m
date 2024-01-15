Return-Path: <linux-fsdevel+bounces-7973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357B082DF89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B255828378E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62718C1B;
	Mon, 15 Jan 2024 18:23:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24326199BD;
	Mon, 15 Jan 2024 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TDKmr6Z5Kz9xHM9;
	Tue, 16 Jan 2024 02:05:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 62C5C1407FA;
	Tue, 16 Jan 2024 02:23:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0ia8d6VlgjybAA--.56873S8;
	Mon, 15 Jan 2024 19:23:21 +0100 (CET)
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
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
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
Subject: [PATCH v9 16/25] security: Introduce inode_post_set_acl hook
Date: Mon, 15 Jan 2024 19:18:00 +0100
Message-Id: <20240115181809.885385-17-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDn0ia8d6VlgjybAA--.56873S8
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDCFWrXr1UXr15Gw18Grg_yoWrWw4kpF
	4xt3Zag3yrXFy2gryktF4DC34SqFWYgry7J3yIgwnayFn7tr1jqFsIkF1YkFyrArW8GF1q
	ga1a9rsxC345Jr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU1hiSPUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5SShgAAs0

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the inode_post_set_acl hook.

At inode_set_acl hook, EVM verifies the file's existing HMAC value. At
inode_post_set_acl, EVM re-calculates the file's HMAC based on the modified
POSIX ACL and other file metadata.

Other LSMs could similarly take some action after successful POSIX ACL
change.

The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/posix_acl.c                |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  7 +++++++
 security/security.c           | 17 +++++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index a05fe94970ce..58e3c1e2fbbc 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -1137,6 +1137,7 @@ int vfs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		error = -EIO;
 	if (!error) {
 		fsnotify_xattr(dentry);
+		security_inode_post_set_acl(dentry, acl_name, kacl);
 		evm_inode_post_set_acl(dentry, acl_name, kacl);
 	}
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 5f90914d23e0..e1a9a4e0760c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -157,6 +157,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
+	 const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name)
 LSM_HOOK(int, 0, inode_remove_acl, struct mnt_idmap *idmap,
diff --git a/include/linux/security.h b/include/linux/security.h
index 1cb604282617..c372797e1617 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -372,6 +372,8 @@ int security_inode_setxattr(struct mnt_idmap *idmap,
 int security_inode_set_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name,
 			   struct posix_acl *kacl);
+void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
+				 struct posix_acl *kacl);
 int security_inode_get_acl(struct mnt_idmap *idmap,
 			   struct dentry *dentry, const char *acl_name);
 int security_inode_remove_acl(struct mnt_idmap *idmap,
@@ -915,6 +917,11 @@ static inline int security_inode_set_acl(struct mnt_idmap *idmap,
 	return 0;
 }
 
+static inline void security_inode_post_set_acl(struct dentry *dentry,
+					       const char *acl_name,
+					       struct posix_acl *kacl)
+{ }
+
 static inline int security_inode_get_acl(struct mnt_idmap *idmap,
 					 struct dentry *dentry,
 					 const char *acl_name)
diff --git a/security/security.c b/security/security.c
index 5bc7edc22923..82da3667c4ae 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2350,6 +2350,23 @@ int security_inode_set_acl(struct mnt_idmap *idmap,
 	return evm_inode_set_acl(idmap, dentry, acl_name, kacl);
 }
 
+/**
+ * security_inode_post_set_acl() - Update inode security from posix acls set
+ * @dentry: file
+ * @acl_name: acl name
+ * @kacl: acl struct
+ *
+ * Update inode security data after successfully setting posix acls on @dentry.
+ * The posix acls in @kacl are identified by @acl_name.
+ */
+void security_inode_post_set_acl(struct dentry *dentry, const char *acl_name,
+				 struct posix_acl *kacl)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_set_acl, dentry, acl_name, kacl);
+}
+
 /**
  * security_inode_get_acl() - Check if reading posix acls is allowed
  * @idmap: idmap of the mount
-- 
2.34.1


