Return-Path: <linux-fsdevel+bounces-1342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 106727D9213
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 10:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410DB1C21093
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A39156E2;
	Fri, 27 Oct 2023 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44E10940
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 08:40:42 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8A010EB;
	Fri, 27 Oct 2023 01:40:35 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SGwl252M7z9yKWt;
	Fri, 27 Oct 2023 16:27:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCX8JGqdjtlDvIBAw--.29710S16;
	Fri, 27 Oct 2023 09:40:06 +0100 (CET)
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
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 14/23] security: Introduce path_post_mknod hook
Date: Fri, 27 Oct 2023 10:35:49 +0200
Message-Id: <20231027083558.484911-15-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
References: <20231027083558.484911-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCX8JGqdjtlDvIBAw--.29710S16
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43Xr48uryrGF43Gw4xtFb_yoWrGF1Upa
	1rtFn3Gr4rGFy3Wr1kAanrCa4SvrW5u34UJFZ0gwnIyFnxtr15XF4SvryYkr9xGrWUKryI
	va17tr43Gr4jqr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
	C2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
	7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5GTnwACsr
X-CFilter-Loop: Reflected

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
---
 fs/namei.c                    |  5 +++++
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  5 +++++
 security/security.c           | 14 ++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 4b1c86934637..955a03aa51b7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4061,6 +4061,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
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
index 21da4cadcad3..0163c781f950 100644
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
index 47c3502d8600..9673a7f45bf0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1883,6 +1883,7 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
 int security_path_rmdir(const struct path *dir, struct dentry *dentry);
 int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev);
+void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_path_truncate(const struct path *path);
 int security_path_symlink(const struct path *dir, struct dentry *dentry,
 			  const char *old_name);
@@ -1917,6 +1918,10 @@ static inline int security_path_mknod(const struct path *dir, struct dentry *den
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
index e3586a37d62c..35e5b5d901ac 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1793,6 +1793,20 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
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


