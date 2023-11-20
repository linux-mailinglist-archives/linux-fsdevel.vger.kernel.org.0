Return-Path: <linux-fsdevel+bounces-3241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F627F1ABA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C52BB215FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8E22327;
	Mon, 20 Nov 2023 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B47D50;
	Mon, 20 Nov 2023 09:38:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4SYvWv4K4Bz9y0NG;
	Tue, 21 Nov 2023 01:24:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAHuGEqmVtlz4kHAQ--.4148S6;
	Mon, 20 Nov 2023 18:37:51 +0100 (CET)
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
Subject: [PATCH v6 14/25] security: Introduce path_post_mknod hook
Date: Mon, 20 Nov 2023 18:33:07 +0100
Message-Id: <20231120173318.1132868-15-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwAHuGEqmVtlz4kHAQ--.4148S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWr43Xr48uryrGF43CrWruFg_yoWrGw1fpa
	1rtFnxGr4rGFy3Wr1kAFsrCa4SvrW5u3y7JFZ0gwnIyFnxtrn0qF4Svr1Ykr9xGrWUKryI
	qa17tr43Gr4Utr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x
	07jxWrAUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAHBF1jj5apegADs1
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
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
---
 fs/namei.c                    |  5 +++++
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  5 +++++
 security/security.c           | 14 ++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index fb93d3e13df6..b7f433720b1e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4047,6 +4047,11 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
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
index 175ca00a6b1d..ee5ab180a312 100644
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
index 4c3585e3dcb4..5f595135c8f2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1884,6 +1884,7 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
 int security_path_rmdir(const struct path *dir, struct dentry *dentry);
 int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev);
+void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_path_truncate(const struct path *path);
 int security_path_symlink(const struct path *dir, struct dentry *dentry,
 			  const char *old_name);
@@ -1918,6 +1919,10 @@ static inline int security_path_mknod(const struct path *dir, struct dentry *den
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
index 9aa072ca5a19..b0203c488d17 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1800,6 +1800,20 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
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


