Return-Path: <linux-fsdevel+bounces-6098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A88137CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1031C282EB3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456A65EA3;
	Thu, 14 Dec 2023 17:12:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1CE1B6;
	Thu, 14 Dec 2023 09:12:51 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Srdpv48vhz9y7ZM;
	Fri, 15 Dec 2023 00:58:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 91EF7140661;
	Fri, 15 Dec 2023 01:12:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAHuGFtN3tlDa2DAg--.53313S3;
	Thu, 14 Dec 2023 18:12:40 +0100 (CET)
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
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 11/24] security: Introduce inode_post_removexattr hook
Date: Thu, 14 Dec 2023 18:08:21 +0100
Message-Id: <20231214170834.3324559-12-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwAHuGFtN3tlDa2DAg--.53313S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDWF4Utw4kuFy5XFWUurg_yoWrAw17pF
	s8K3Z5Kr4rJFy7WryktF4Duw4I9FW3Wry7A3y2gw1IyFn7Jr1IqrZIkF1UCry5JryjgF1q
	qFnFkrs5Cr13JwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY
	6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
	CY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQ_-PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj5OoNAADsw

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the inode_post_removexattr hook.

At inode_removexattr hook, EVM verifies the file's existing HMAC value. At
inode_post_removexattr, EVM re-calculates the file's HMAC with the passed
xattr removed and other file metadata.

Other LSMs could similarly take some action after successful xattr removal.

The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/xattr.c                    |  9 +++++----
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  5 +++++
 security/security.c           | 14 ++++++++++++++
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 09d927603433..f891c260a971 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -552,11 +552,12 @@ __vfs_removexattr_locked(struct mnt_idmap *idmap,
 		goto out;
 
 	error = __vfs_removexattr(idmap, dentry, name);
+	if (error)
+		return error;
 
-	if (!error) {
-		fsnotify_xattr(dentry);
-		evm_inode_post_removexattr(dentry, name);
-	}
+	fsnotify_xattr(dentry);
+	security_inode_post_removexattr(dentry, name);
+	evm_inode_post_removexattr(dentry, name);
 
 out:
 	return error;
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 091cddb4e6de..c3199bb69103 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -149,6 +149,8 @@ LSM_HOOK(int, 0, inode_getxattr, struct dentry *dentry, const char *name)
 LSM_HOOK(int, 0, inode_listxattr, struct dentry *dentry)
 LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
+	 const char *name)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(int, 0, inode_get_acl, struct mnt_idmap *idmap,
diff --git a/include/linux/security.h b/include/linux/security.h
index 664df46b22a9..922ea7709bae 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -380,6 +380,7 @@ int security_inode_getxattr(struct dentry *dentry, const char *name);
 int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
+void security_inode_post_removexattr(struct dentry *dentry, const char *name);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -940,6 +941,10 @@ static inline int security_inode_removexattr(struct mnt_idmap *idmap,
 	return cap_inode_removexattr(idmap, dentry, name);
 }
 
+static inline void security_inode_post_removexattr(struct dentry *dentry,
+						   const char *name)
+{ }
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index ce3bc7642e18..8aa6e9f316dd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2452,6 +2452,20 @@ int security_inode_removexattr(struct mnt_idmap *idmap,
 	return evm_inode_removexattr(idmap, dentry, name);
 }
 
+/**
+ * security_inode_post_removexattr() - Update the inode after a removexattr op
+ * @dentry: file
+ * @name: xattr name
+ *
+ * Update the inode after a successful removexattr operation.
+ */
+void security_inode_post_removexattr(struct dentry *dentry, const char *name)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_removexattr, dentry, name);
+}
+
 /**
  * security_inode_need_killpriv() - Check if security_inode_killpriv() required
  * @dentry: associated dentry
-- 
2.34.1


