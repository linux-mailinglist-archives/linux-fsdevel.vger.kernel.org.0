Return-Path: <linux-fsdevel+bounces-11685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 467C8855FE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A86C1C2012B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296DF1339B4;
	Thu, 15 Feb 2024 10:36:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373E12DD8A;
	Thu, 15 Feb 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993391; cv=none; b=K3l4qZCwdhbSiX54S6VgslyxyCnZgij3VQevqCqxDFmjUpuSzxIwHfzUxaqKQ0YM/2m8w3MbnZUXmpjMZKs3cyedL/Bu3pEc4RYKFfK4DX7HkNbA/fPfTeb8dklkPd/rPARff4hIOZQ7u2OYxOGM8BkgDRvQRHejtvGLCfjIJ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993391; c=relaxed/simple;
	bh=qsEmOSd56g6d5IKM7ouUB7aPuWWfG5P7bW4is9DECkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoogkE1doAQlCn9k6LsTUj4DKji5KH10GHnTRUKru77L1m7bmeOjOow2FJOI8d0SaKJ6pgMQ2X8yn3Ma/8dfmgFTF3dN1cCEuqF2DhJo0spQqq4muhPVEm5HCBhzkd/ChPqt1S7Z04t1rfxyW1JhM6Xm7DMwlGvusivm/17S+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TbB136gPCz9yB7S;
	Thu, 15 Feb 2024 18:21:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 34C3614064F;
	Thu, 15 Feb 2024 18:36:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LxjQ6M1l4QeNAg--.58293S7;
	Thu, 15 Feb 2024 11:36:21 +0100 (CET)
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
Subject: [PATCH v10 15/25] security: Introduce inode_post_create_tmpfile hook
Date: Thu, 15 Feb 2024 11:31:03 +0100
Message-Id: <20240215103113.2369171-16-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwA3LxjQ6M1l4QeNAg--.58293S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUZFy3urWkKr1rZrWrKrg_yoWrWry5pF
	WxK3W5Gws5XFy7Wr1vyF4Uuw1Sgay5WrW7JrZagw1DAFn7tr1ftF1Skr12kF13JrW8G342
	q3ZFkrZxGr1UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5Zf2wABsq

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the inode_post_create_tmpfile hook.

As temp files can be made persistent, treat new temp files like other new
files, so that the file hash is calculated and stored in the security
xattr.

LSMs could also take some action after temp files have been created.

The new hook cannot return an error and cannot cause the operation to be
canceled.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/namei.c                    |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  6 ++++++
 security/security.c           | 15 +++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 9280aa5d60a7..c7ac7fdf0f25 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3705,6 +3705,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
+	security_inode_post_create_tmpfile(idmap, inode);
 	ima_post_create_tmpfile(idmap, inode);
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index dba5d8204dc5..87f60b47dfca 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -121,6 +121,8 @@ LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
+	 struct inode *inode)
 LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
 	 struct dentry *new_dentry)
 LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
diff --git a/include/linux/security.h b/include/linux/security.h
index 977dd9f7f51a..1cb604282617 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -344,6 +344,8 @@ int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode);
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
+void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
+					struct inode *inode);
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry);
 int security_inode_unlink(struct inode *dir, struct dentry *dentry);
@@ -811,6 +813,10 @@ static inline int security_inode_create(struct inode *dir,
 	return 0;
 }
 
+static inline void
+security_inode_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *inode)
+{ }
+
 static inline int security_inode_link(struct dentry *old_dentry,
 				       struct inode *dir,
 				       struct dentry *new_dentry)
diff --git a/security/security.c b/security/security.c
index b55f9ad294cc..59d49e5c2671 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2014,6 +2014,21 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
+/**
+ * security_inode_post_create_tmpfile() - Update inode security of new tmpfile
+ * @idmap: idmap of the mount
+ * @inode: inode of the new tmpfile
+ *
+ * Update inode security data after a tmpfile has been created.
+ */
+void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
+					struct inode *inode)
+{
+	if (unlikely(IS_PRIVATE(inode)))
+		return;
+	call_void_hook(inode_post_create_tmpfile, idmap, inode);
+}
+
 /**
  * security_inode_link() - Check if creating a hard link is allowed
  * @old_dentry: existing file
-- 
2.34.1


