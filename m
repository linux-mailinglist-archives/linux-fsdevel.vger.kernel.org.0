Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3254466D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfFNSBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:01:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33012 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726758AbfFNSBX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:01:23 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 61CBBF107AFE943A80B4;
        Fri, 14 Jun 2019 19:01:22 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:01:14 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 04/14] ima: generalize policy file operations
Date:   Fri, 14 Jun 2019 19:55:03 +0200
Message-ID: <20190614175513.27097-5-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614175513.27097-1-roberto.sassu@huawei.com>
References: <20190614175513.27097-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch renames ima_open_policy() and ima_release_policy() respectively
to ima_open_data_upload() and ima_release_data_upload(). They will be used
to implement file operations for interfaces allowing to load data from user
space.

A new flag (IMA_POLICY_BUSY) has been defined to prevent concurrent policy
upload.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 58 ++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 15 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 9a10b62e380f..c8bbc56f735e 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -386,9 +386,20 @@ static ssize_t ima_write_data(struct file *file, const char __user *buf,
 }
 
 enum ima_fs_flags {
+	IMA_POLICY_BUSY,
 	IMA_FS_BUSY,
 };
 
+static enum ima_fs_flags ima_get_dentry_flag(struct dentry *dentry)
+{
+	enum ima_fs_flags flag = IMA_FS_BUSY;
+
+	if (dentry == ima_policy)
+		flag = IMA_POLICY_BUSY;
+
+	return flag;
+}
+
 static unsigned long ima_fs_flags;
 
 #ifdef	CONFIG_IMA_READ_POLICY
@@ -401,22 +412,32 @@ static const struct seq_operations ima_policy_seqops = {
 #endif
 
 /*
- * ima_open_policy: sequentialize access to the policy file
+ * ima_open_data_upload: sequentialize access to the data upload interface
  */
-static int ima_open_policy(struct inode *inode, struct file *filp)
+static int ima_open_data_upload(struct inode *inode, struct file *filp)
 {
+	struct dentry *dentry = file_dentry(filp);
+	const struct seq_operations *seq_ops = NULL;
+	enum ima_fs_flags flag = ima_get_dentry_flag(dentry);
+	bool read_allowed = false;
+
+	if (dentry == ima_policy) {
+#ifdef	CONFIG_IMA_READ_POLICY
+		read_allowed = true;
+		seq_ops = &ima_policy_seqops;
+#endif
+	}
+
 	if (!(filp->f_flags & O_WRONLY)) {
-#ifndef	CONFIG_IMA_READ_POLICY
-		return -EACCES;
-#else
+		if (!read_allowed)
+			return -EACCES;
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		return seq_open(filp, &ima_policy_seqops);
-#endif
+		return seq_open(filp, seq_ops);
 	}
-	if (test_and_set_bit(IMA_FS_BUSY, &ima_fs_flags))
+	if (test_and_set_bit(flag, &ima_fs_flags))
 		return -EBUSY;
 	return 0;
 }
@@ -428,13 +449,20 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  * point to the new policy rules, and remove the securityfs policy file,
  * assuming a valid policy.
  */
-static int ima_release_policy(struct inode *inode, struct file *file)
+static int ima_release_data_upload(struct inode *inode, struct file *file)
 {
+	struct dentry *dentry = file_dentry(file);
 	const char *cause = valid_policy ? "completed" : "failed";
+	enum ima_fs_flags flag = ima_get_dentry_flag(dentry);
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
+	if (dentry != ima_policy) {
+		clear_bit(flag, &ima_fs_flags);
+		return 0;
+	}
+
 	if (valid_policy && ima_check_policy() < 0) {
 		cause = "failed";
 		valid_policy = 0;
@@ -447,7 +475,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	if (!valid_policy) {
 		ima_delete_rules();
 		valid_policy = 1;
-		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+		clear_bit(flag, &ima_fs_flags);
 		return 0;
 	}
 
@@ -456,18 +484,18 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	securityfs_remove(ima_policy);
 	ima_policy = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
-	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+	clear_bit(flag, &ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
 	inode->i_mode &= ~S_IWUSR;
 #endif
 	return 0;
 }
 
-static const struct file_operations ima_measure_policy_ops = {
-	.open = ima_open_policy,
+static const struct file_operations ima_data_upload_ops = {
+	.open = ima_open_data_upload,
 	.write = ima_write_data,
 	.read = seq_read,
-	.release = ima_release_policy,
+	.release = ima_release_data_upload,
 	.llseek = generic_file_llseek,
 };
 
@@ -511,7 +539,7 @@ int __init ima_fs_init(void)
 
 	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
-					    &ima_measure_policy_ops);
+					    &ima_data_upload_ops);
 	if (IS_ERR(ima_policy))
 		goto out;
 
-- 
2.17.1

