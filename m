Return-Path: <linux-fsdevel+bounces-11684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7DB855FDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 11:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960121F263BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E44133981;
	Thu, 15 Feb 2024 10:36:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F712DD8A;
	Thu, 15 Feb 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993383; cv=none; b=DA3LpkUHC9eyDnlR04140RlSC98UnOjyyyTqpoCYOa07QpRp6XTc8AhiCAdXYLmjRTS8T1KWDZq8GJ5akAN+Tr3vHRPXLOcIQqvCGp98IR1T5VkQa/3DCEzE0VXx9kbPg1wEpjJoqT+8RjjmZoPJuEnQbiUbz4suOoG08uE3Hj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993383; c=relaxed/simple;
	bh=7U/Hluo2JXn9fIBbrObOrmuIk6veMU1+jX/b84qJfPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c19UTPOx8UnEFdFbmVpxgrDRat3aH0XR5TovqdSLR3BLl2yh18rfa7rEFp1msrcCDMS/2AyjoLtqlzQ9swMxdq+kMGx5tSOTx0qhqbrsOx7/fCTAhhYD8SLRnMQ+YIe9QFEH3OqTZ6WW0eldRzjTpVdYUzMG4Gv26tE7sSmkWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TbB0s5QQkz9yTLZ;
	Thu, 15 Feb 2024 18:21:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 411991406BE;
	Thu, 15 Feb 2024 18:36:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwA3LxjQ6M1l4QeNAg--.58293S6;
	Thu, 15 Feb 2024 11:36:07 +0100 (CET)
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
Subject: [PATCH v10 14/25] security: Introduce path_post_mknod hook
Date: Thu, 15 Feb 2024 11:31:02 +0100
Message-Id: <20240215103113.2369171-15-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwA3LxjQ6M1l4QeNAg--.58293S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43Xr48uryrGF43ur4xCrg_yoWrWFyUpa
	18tFnxGrWrGFy3Wr1kAFsrCa4SvrW5u3y7JFZ0gwnIyFnxtrnYqF4S9r1Y9r9xGrWUKryI
	va17tr43Gr4Utr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5Zf2wAAsr

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the path_post_mknod hook.

IMA-appraisal requires all existing files in policy to have a file
hash/signature stored in security.ima. An exception is made for empty files
created by mknod, by tagging them as new files.

LSMs could also take some action after files are created.

The new hook cannot return an error and cannot cause the operation to be
reverted.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/namei.c                    |  5 +++++
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  5 +++++
 security/security.c           | 14 ++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index ef867f1d6704..9280aa5d60a7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4063,6 +4063,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 					  dentry, mode, 0);
 			break;
 	}
+
+	if (error)
+		goto out2;
+
+	security_path_post_mknod(idmap, dentry);
 out2:
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7f9e9240606e..dba5d8204dc5 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -94,6 +94,8 @@ LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
 LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
 LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
 	 umode_t mode, unsigned int dev)
+LSM_HOOK(void, LSM_RET_VOID, path_post_mknod, struct mnt_idmap *idmap,
+	 struct dentry *dentry)
 LSM_HOOK(int, 0, path_truncate, const struct path *path)
 LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
 	 const char *old_name)
diff --git a/include/linux/security.h b/include/linux/security.h
index 2997348afcb7..977dd9f7f51a 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1893,6 +1893,7 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
 int security_path_rmdir(const struct path *dir, struct dentry *dentry);
 int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev);
+void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_path_truncate(const struct path *path);
 int security_path_symlink(const struct path *dir, struct dentry *dentry,
 			  const char *old_name);
@@ -1927,6 +1928,10 @@ static inline int security_path_mknod(const struct path *dir, struct dentry *den
 	return 0;
 }
 
+static inline void security_path_post_mknod(struct mnt_idmap *idmap,
+					    struct dentry *dentry)
+{ }
+
 static inline int security_path_truncate(const struct path *path)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 145e3141339c..b55f9ad294cc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1801,6 +1801,20 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL(security_path_mknod);
 
+/**
+ * security_path_post_mknod() - Update inode security field after file creation
+ * @idmap: idmap of the mount
+ * @dentry: new file
+ *
+ * Update inode security field after a file has been created.
+ */
+void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
+		return;
+	call_void_hook(path_post_mknod, idmap, dentry);
+}
+
 /**
  * security_path_mkdir() - Check if creating a new directory is allowed
  * @dir: parent directory
-- 
2.34.1


