Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959106A9F0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 19:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjCCSiN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 13:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjCCSiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:38:03 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65496151C;
        Fri,  3 Mar 2023 10:37:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PSwxm5nMgz9xtRT;
        Sat,  4 Mar 2023 02:10:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBnMVgKOgJk5iFpAQ--.12605S4;
        Fri, 03 Mar 2023 19:19:24 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     viro@zeniv.linux.org.uk, chuck.lever@oracle.com,
        jlayton@kernel.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 02/28] ima: Align ima_post_path_mknod() definition with LSM infrastructure
Date:   Fri,  3 Mar 2023 19:18:16 +0100
Message-Id: <20230303181842.1087717-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
References: <20230303181842.1087717-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnMVgKOgJk5iFpAQ--.12605S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy3AryDtw1DWrW8trykuFg_yoW5Kr4kpF
        s5t3Z8Gr95Zry7uF18Aay5A34Fgas2qF4UWFWSgwnIyrnxtrn0qFsa9r1Y9ryrKFWqkryI
        qF15trW5uw4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
        v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVWxJr0_GcWlIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07j7
        hLnUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4YvdAABsu
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Change ima_post_path_mknod() definition, so that it can be registered as
implementation of the path_post_mknod hook.

Also, make sure that ima_post_path_mknod() is executed only if
(mode & S_IFMT) is equal to zero or S_IFREG.

Add this check to take into account the different placement of the
path_post_mknod hook (to be introduced) in do_mknodat(). Since the new hook
will be placed after the switch(), the check ensures that
ima_post_path_mknod() is invoked as originally intended when it is
registered as implementation of path_post_mknod.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/namei.c                        |  3 ++-
 include/linux/ima.h               |  7 +++++--
 security/integrity/ima/ima_main.c | 10 +++++++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index edfedfbccae..b5a1ec29193 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3966,7 +3966,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 			error = vfs_create(idmap, path.dentry->d_inode,
 					   dentry, mode, true);
 			if (!error)
-				ima_post_path_mknod(idmap, dentry);
+				ima_post_path_mknod(idmap, &path, dentry, mode,
+						    dev);
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 910a2f11a90..179ce52013b 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -32,7 +32,8 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct mnt_idmap *idmap,
-				struct dentry *dentry);
+				const struct path *dir, struct dentry *dentry,
+				umode_t mode, unsigned int dev);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
@@ -114,7 +115,9 @@ static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
 }
 
 static inline void ima_post_path_mknod(struct mnt_idmap *idmap,
-				       struct dentry *dentry)
+				       const struct path *dir,
+				       struct dentry *dentry,
+				       umode_t mode, unsigned int dev)
 {
 	return;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d66a0a36415..8941305376b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -692,18 +692,26 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
 /**
  * ima_post_path_mknod - mark as a new inode
  * @idmap: idmap of the mount the inode was found from
+ * @dir: path structure of parent of the new file
  * @dentry: newly created dentry
+ * @mode: mode of the new file
+ * @dev: undecoded device number
  *
  * Mark files created via the mknodat syscall as new, so that the
  * file data can be written later.
  */
 void ima_post_path_mknod(struct mnt_idmap *idmap,
-			 struct dentry *dentry)
+			 const struct path *dir, struct dentry *dentry,
+			 umode_t mode, unsigned int dev)
 {
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
+	/* See do_mknodat(), IMA is executed for case 0: and case S_IFREG: */
+	if ((mode & S_IFMT) != 0 && (mode & S_IFMT) != S_IFREG)
+		return;
+
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
-- 
2.25.1

