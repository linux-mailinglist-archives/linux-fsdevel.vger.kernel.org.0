Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5578EA71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Aug 2023 12:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241408AbjHaKnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Aug 2023 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjHaKnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:43:24 -0400
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC14E4A;
        Thu, 31 Aug 2023 03:43:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Rby7V02Mkz9v7JW;
        Thu, 31 Aug 2023 18:28:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBXC7t9bvBkiGfdAQ--.39787S4;
        Thu, 31 Aug 2023 11:42:46 +0100 (CET)
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
Subject: [PATCH v2 02/25] ima: Align ima_post_path_mknod() definition with LSM infrastructure
Date:   Thu, 31 Aug 2023 12:41:13 +0200
Message-Id: <20230831104136.903180-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
References: <20230831104136.903180-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBXC7t9bvBkiGfdAQ--.39787S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyfuw43Ar4DXF4fXry3XFb_yoWrCF1kpF
        s5t3Z8Grn5Zry7uFy8AFW5Aa4FvasrXF45WFZYg34ayFnIqrn0qFsa9FWY9ryrKFWkCryx
        tF4UtrW5uw4UtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
        0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
        0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IU0jN
        t3UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj5NcxgAAs7
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

Change ima_post_path_mknod() definition, so that it can be registered as
implementation of the path_post_mknod hook. Since LSMs see a umask-stripped
mode from security_path_mknod(), pass the same to ima_post_path_mknod() as
well.

Also, make sure that ima_post_path_mknod() is executed only if
(mode & S_IFMT) is equal to zero or S_IFREG.

Add this check to take into account the different placement of the
path_post_mknod hook (to be introduced) in do_mknodat(). Since the new hook
will be placed after the switch(), the check ensures that
ima_post_path_mknod() is invoked as originally intended when it is
registered as implementation of path_post_mknod.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/namei.c                        |  9 ++++++---
 include/linux/ima.h               |  7 +++++--
 security/integrity/ima/ima_main.c | 10 +++++++++-
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index e56ff39a79bc..c5e96f716f98 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4024,6 +4024,7 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	struct path path;
 	int error;
 	unsigned int lookup_flags = 0;
+	umode_t mode_stripped;
 
 	error = may_mknod(mode);
 	if (error)
@@ -4034,8 +4035,9 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	if (IS_ERR(dentry))
 		goto out1;
 
-	error = security_path_mknod(&path, dentry,
-			mode_strip_umask(path.dentry->d_inode, mode), dev);
+	mode_stripped = mode_strip_umask(path.dentry->d_inode, mode);
+
+	error = security_path_mknod(&path, dentry, mode_stripped, dev);
 	if (error)
 		goto out2;
 
@@ -4045,7 +4047,8 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 			error = vfs_create(idmap, path.dentry->d_inode,
 					   dentry, mode, true);
 			if (!error)
-				ima_post_path_mknod(idmap, dentry);
+				ima_post_path_mknod(idmap, &path, dentry,
+						    mode_stripped, dev);
 			break;
 		case S_IFCHR: case S_IFBLK:
 			error = vfs_mknod(idmap, path.dentry->d_inode,
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 910a2f11a906..179ce52013b2 100644
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
index 365db0e43d7c..76eba92d7f10 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -696,18 +696,26 @@ void ima_post_create_tmpfile(struct mnt_idmap *idmap,
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
2.34.1

