Return-Path: <linux-fsdevel+bounces-3235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3617F1A68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772F8281E08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A603A22324;
	Mon, 20 Nov 2023 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEA5D51;
	Mon, 20 Nov 2023 09:35:52 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SYvT445wPz9ttD6;
	Tue, 21 Nov 2023 01:22:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXU3NimFtlBH8KAQ--.51496S10;
	Mon, 20 Nov 2023 18:35:24 +0100 (CET)
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
Subject: [PATCH v6 08/25] evm: Align evm_inode_post_setxattr() definition with LSM infrastructure
Date: Mon, 20 Nov 2023 18:33:01 +0100
Message-Id: <20231120173318.1132868-9-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
References: <20231120173318.1132868-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAXU3NimFtlBH8KAQ--.51496S10
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4rCrWDuF4fAFy8XF1xAFb_yoW5uw1kpF
	ZxKa4DCw1rJFyUWryvyF48u3sY9ayrWryjy3yDKw1IyFnxtr92qryxJr1j9ryrJr48GFnY
	qa1avrs5K3W3X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x
	07jxWrAUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBF1jj5KqaQABsg
X-CFilter-Loop: Reflected

From: Roberto Sassu <roberto.sassu@huawei.com>

Change evm_inode_post_setxattr() definition, so that it can be registered
as implementation of the inode_post_setxattr hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/evm.h               | 8 +++++---
 security/integrity/evm/evm_main.c | 4 +++-
 security/security.c               | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 7c6a74dbc093..437d4076a3b3 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -31,7 +31,8 @@ extern int evm_inode_setxattr(struct mnt_idmap *idmap,
 extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
-				    size_t xattr_value_len);
+				    size_t xattr_value_len,
+				    int flags);
 extern int evm_inode_removexattr(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
@@ -55,7 +56,7 @@ static inline void evm_inode_post_set_acl(struct dentry *dentry,
 					  const char *acl_name,
 					  struct posix_acl *kacl)
 {
-	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0);
+	return evm_inode_post_setxattr(dentry, acl_name, NULL, 0, 0);
 }
 
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
@@ -114,7 +115,8 @@ static inline int evm_inode_setxattr(struct mnt_idmap *idmap,
 static inline void evm_inode_post_setxattr(struct dentry *dentry,
 					   const char *xattr_name,
 					   const void *xattr_value,
-					   size_t xattr_value_len)
+					   size_t xattr_value_len,
+					   int flags)
 {
 	return;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 7fc083d53fdf..ea84a6f835ff 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -730,6 +730,7 @@ bool evm_revalidate_status(const char *xattr_name)
  * @xattr_name: pointer to the affected extended attribute name
  * @xattr_value: pointer to the new extended attribute value
  * @xattr_value_len: pointer to the new extended attribute value length
+ * @flags: flags to pass into filesystem operations
  *
  * Update the HMAC stored in 'security.evm' to reflect the change.
  *
@@ -738,7 +739,8 @@ bool evm_revalidate_status(const char *xattr_name)
  * i_mutex lock.
  */
 void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
-			     const void *xattr_value, size_t xattr_value_len)
+			     const void *xattr_value, size_t xattr_value_len,
+			     int flags)
 {
 	if (!evm_revalidate_status(xattr_name))
 		return;
diff --git a/security/security.c b/security/security.c
index ae3625198c9f..53793f3cb36a 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2367,7 +2367,7 @@ void security_inode_post_setxattr(struct dentry *dentry, const char *name,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return;
 	call_void_hook(inode_post_setxattr, dentry, name, value, size, flags);
-	evm_inode_post_setxattr(dentry, name, value, size);
+	evm_inode_post_setxattr(dentry, name, value, size, flags);
 }
 
 /**
-- 
2.34.1


