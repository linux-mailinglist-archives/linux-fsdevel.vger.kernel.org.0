Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8798378EAE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjHaKre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244986AbjHaKr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:47:29 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BD5170A;
        Thu, 31 Aug 2023 03:46:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4RbyFc2fVHz9xyNH;
        Thu, 31 Aug 2023 18:34:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXC7t9bvBkiGfdAQ--.39787S18;
        Thu, 31 Aug 2023 11:45:46 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 16/25] security: Introduce path_post_mknod hook
Date:   Thu, 31 Aug 2023 12:41:27 +0200
Message-Id: <20230831104136.903180-17-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBXC7t9bvBkiGfdAQ--.39787S18
X-Coremail-Antispam: 1UD129KBjvJXoWxWr47XFyUAF4UAryfZw43ZFb_yoWrGFW8pa
        18tFn3Kr4rGFyagr1kAFsrCa4Sv398u3y7JrZIgwnIyFnxtr1aqF4S9ryYkr93GrWq9ryx
        t3W3tr43Gr4Utr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
        80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
        c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UdfHUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj49c7wAAsN
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the path_post_mknod hook.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/namei.c                    |  5 +++++
 include/linux/lsm_hook_defs.h |  3 +++
 include/linux/security.h      |  9 +++++++++
 security/security.c           | 19 +++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 7dc4626859f0..c8c4ab26b52a 100644
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
+	security_path_post_mknod(idmap, &path, dentry, mode_stripped, dev);
 out2:
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 797f51da3f7d..b1634b5de98c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -93,6 +93,9 @@ LSM_HOOK(int, 0, path_mkdir, const struct path *dir, struct dentry *dentry,
 LSM_HOOK(int, 0, path_rmdir, const struct path *dir, struct dentry *dentry)
 LSM_HOOK(int, 0, path_mknod, const struct path *dir, struct dentry *dentry,
 	 umode_t mode, unsigned int dev)
+LSM_HOOK(void, LSM_RET_VOID, path_post_mknod, struct mnt_idmap *idmap,
+	 const struct path *dir, struct dentry *dentry, umode_t mode,
+	 unsigned int dev)
 LSM_HOOK(int, 0, path_truncate, const struct path *path)
 LSM_HOOK(int, 0, path_symlink, const struct path *dir, struct dentry *dentry,
 	 const char *old_name)
diff --git a/include/linux/security.h b/include/linux/security.h
index 7871009d59ae..f210bd66e939 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -1842,6 +1842,9 @@ int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t m
 int security_path_rmdir(const struct path *dir, struct dentry *dentry);
 int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
 			unsigned int dev);
+void security_path_post_mknod(struct mnt_idmap *idmap, const struct path *dir,
+			      struct dentry *dentry, umode_t mode,
+			      unsigned int dev);
 int security_path_truncate(const struct path *path);
 int security_path_symlink(const struct path *dir, struct dentry *dentry,
 			  const char *old_name);
@@ -1876,6 +1879,12 @@ static inline int security_path_mknod(const struct path *dir, struct dentry *den
 	return 0;
 }
 
+static inline void security_path_post_mknod(struct mnt_idmap *idmap,
+					    const struct path *dir,
+					    struct dentry *dentry, umode_t mode,
+					    unsigned int dev)
+{ }
+
 static inline int security_path_truncate(const struct path *path)
 {
 	return 0;
diff --git a/security/security.c b/security/security.c
index 3e648aa9292c..56c1c1e66fd1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1702,6 +1702,25 @@ int security_path_mknod(const struct path *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL(security_path_mknod);
 
+/**
+ * security_path_post_mknod() - Update inode security field after file creation
+ * @idmap: idmap of the mount
+ * @dir: parent directory
+ * @dentry: new file
+ * @mode: new file mode
+ * @dev: device number
+ *
+ * Update inode security field after a file has been created.
+ */
+void security_path_post_mknod(struct mnt_idmap *idmap, const struct path *dir,
+			      struct dentry *dentry, umode_t mode,
+			      unsigned int dev)
+{
+	if (unlikely(IS_PRIVATE(d_backing_inode(dir->dentry))))
+		return;
+	call_void_hook(path_post_mknod, idmap, dir, dentry, mode, dev);
+}
+
 /**
  * security_path_mkdir() - Check if creating a new directory is allowed
  * @dir: parent directory
-- 
2.34.1

