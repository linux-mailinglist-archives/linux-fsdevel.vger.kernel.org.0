Return-Path: <linux-fsdevel+bounces-6097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056548137C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B951F21E34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845EF65EA1;
	Thu, 14 Dec 2023 17:12:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E418DA0;
	Thu, 14 Dec 2023 09:12:34 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Srdpb0KV5z9y7ZG;
	Fri, 15 Dec 2023 00:58:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 4415014073F;
	Fri, 15 Dec 2023 01:12:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAHuGFtN3tlDa2DAg--.53313S2;
	Thu, 14 Dec 2023 18:12:27 +0100 (CET)
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
Subject: [PATCH v8 10/24] security: Introduce inode_post_setattr hook
Date: Thu, 14 Dec 2023 18:08:20 +0100
Message-Id: <20231214170834.3324559-11-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAHuGFtN3tlDa2DAg--.53313S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykAw17WFW5XF48Cw18AFb_yoWrAr15pF
	WrK3WDKw4rWFW7WrykJF47ua1SgFy5urWUXrWqgwn0yFn7tw1aqF43Ka4jkr13GrW8Gr9I
	q3ZFvrsxCr15AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGw
	C20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48J
	MIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
	1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY
	6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgALBF1jj5OoNAACsx

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the inode_post_setattr hook.

At inode_setattr hook, EVM verifies the file's existing HMAC value. At
inode_post_setattr, EVM re-calculates the file's HMAC based on the modified
file attributes and other file metadata.

Other LSMs could similarly take some action after successful file attribute
change.

The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/attr.c                     |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  7 +++++++
 security/security.c           | 16 ++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/fs/attr.c b/fs/attr.c
index 498e673bdf06..221d2bb0a906 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -502,6 +502,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (!error) {
 		fsnotify_change(dentry, ia_valid);
+		security_inode_post_setattr(idmap, dentry, ia_valid);
 		ima_inode_post_setattr(idmap, dentry, ia_valid);
 		evm_inode_post_setattr(idmap, dentry, ia_valid);
 	}
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 752ed8a4f3c6..091cddb4e6de 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -137,6 +137,8 @@ LSM_HOOK(int, 0, inode_follow_link, struct dentry *dentry, struct inode *inode,
 LSM_HOOK(int, 0, inode_permission, struct inode *inode, int mask)
 LSM_HOOK(int, 0, inode_setattr, struct mnt_idmap *idmap, struct dentry *dentry,
 	 struct iattr *attr)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_setattr, struct mnt_idmap *idmap,
+	 struct dentry *dentry, int ia_valid)
 LSM_HOOK(int, 0, inode_getattr, const struct path *path)
 LSM_HOOK(int, 0, inode_setxattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name, const void *value,
diff --git a/include/linux/security.h b/include/linux/security.h
index 750130a7b9dd..664df46b22a9 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -361,6 +361,8 @@ int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
 int security_inode_permission(struct inode *inode, int mask);
 int security_inode_setattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry, struct iattr *attr);
+void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 int ia_valid);
 int security_inode_getattr(const struct path *path);
 int security_inode_setxattr(struct mnt_idmap *idmap,
 			    struct dentry *dentry, const char *name,
@@ -877,6 +879,11 @@ static inline int security_inode_setattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
+static inline void
+security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			    int ia_valid)
+{ }
+
 static inline int security_inode_getattr(const struct path *path)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 7935d11d58b5..ce3bc7642e18 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2222,6 +2222,22 @@ int security_inode_setattr(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL_GPL(security_inode_setattr);
 
+/**
+ * security_inode_post_setattr() - Update the inode after a setattr operation
+ * @idmap: idmap of the mount
+ * @dentry: file
+ * @ia_valid: file attributes set
+ *
+ * Update inode security field after successful setting file attributes.
+ */
+void security_inode_post_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+				 int ia_valid)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(inode_post_setattr, idmap, dentry, ia_valid);
+}
+
 /**
  * security_inode_getattr() - Check if getting file attributes is allowed
  * @path: file
-- 
2.34.1


