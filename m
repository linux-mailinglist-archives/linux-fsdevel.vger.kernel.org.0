Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75940466CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfFNSAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:00:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33011 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbfFNSAu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:00:50 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id DE0129E82EEBBC0ED718;
        Fri, 14 Jun 2019 19:00:46 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:00:39 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 03/14] ima: generalize ima_write_policy() and raise uploaded data size limit
Date:   Fri, 14 Jun 2019 19:55:02 +0200
Message-ID: <20190614175513.27097-4-roberto.sassu@huawei.com>
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

ima_write_policy() is being used to load a new policy from user space. This
function can be reused to load different types of data.

This patch renames ima_write_policy() to ima_write_data() and executes the
appropriate actions depending on the opened file in the securityfs
filesystem.

Also, this patch raises the uploaded data size limit to 64M, to accept
files (e.g. digest lists) larger than a policy. The same limit is used
for the SELinux policy.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 68 +++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 02980b55a3f1..9a10b62e380f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -27,6 +27,14 @@
 
 static DEFINE_MUTEX(ima_write_mutex);
 
+static struct dentry *ima_dir;
+static struct dentry *ima_symlink;
+static struct dentry *binary_runtime_measurements;
+static struct dentry *ascii_runtime_measurements;
+static struct dentry *runtime_measurements_count;
+static struct dentry *violations;
+static struct dentry *ima_policy;
+
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -319,25 +327,32 @@ static ssize_t ima_read_file(char *path, enum kernel_read_file_id file_id)
 		return pathlen;
 }
 
-static ssize_t ima_write_policy(struct file *file, const char __user *buf,
-				size_t datalen, loff_t *ppos)
+static ssize_t ima_write_data(struct file *file, const char __user *buf,
+			      size_t datalen, loff_t *ppos)
 {
 	char *data;
 	ssize_t result;
-
-	if (datalen >= PAGE_SIZE)
-		datalen = PAGE_SIZE - 1;
+	struct dentry *dentry = file_dentry(file);
 
 	/* No partial writes. */
 	result = -EINVAL;
 	if (*ppos != 0)
 		goto out;
 
-	data = memdup_user_nul(buf, datalen);
-	if (IS_ERR(data)) {
-		result = PTR_ERR(data);
+	result = -EFBIG;
+	if (datalen + 1 > 64 * 1024 * 1024)
 		goto out;
-	}
+
+	result = -ENOMEM;
+	data = vmalloc(datalen + 1);
+	if (!data)
+		goto out;
+
+	result = -EFAULT;
+	if (copy_from_user(data, buf, datalen) != 0)
+		goto out_free;
+
+	data[datalen] = '\0';
 
 	result = mutex_lock_interruptible(&ima_write_mutex);
 	if (result < 0)
@@ -345,34 +360,31 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 
 	if (data[0] == '/') {
 		result = ima_read_file(data, READING_POLICY);
-	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
-		pr_err("signed policy file (specified as an absolute pathname) required\n");
-		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-				    "policy_update", "signed policy required",
-				    1, 0);
-		if (ima_appraise & IMA_APPRAISE_ENFORCE)
-			result = -EACCES;
+	} else if (dentry == ima_policy) {
+		if (ima_appraise & IMA_APPRAISE_POLICY) {
+			pr_err("signed policy file (specified as an absolute pathname) required\n");
+			integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
+					    "policy_update",
+					    "signed policy required", 1, 0);
+			if (ima_appraise & IMA_APPRAISE_ENFORCE)
+				result = -EACCES;
+		} else {
+			result = ima_parse_add_rule(data);
+		}
 	} else {
-		result = ima_parse_add_rule(data);
+		pr_err("Unknown data type\n");
+		result = -EINVAL;
 	}
 	mutex_unlock(&ima_write_mutex);
 out_free:
-	kfree(data);
+	vfree(data);
 out:
-	if (result < 0)
+	if (dentry == ima_policy && result < 0)
 		valid_policy = 0;
 
 	return result;
 }
 
-static struct dentry *ima_dir;
-static struct dentry *ima_symlink;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
-static struct dentry *runtime_measurements_count;
-static struct dentry *violations;
-static struct dentry *ima_policy;
-
 enum ima_fs_flags {
 	IMA_FS_BUSY,
 };
@@ -453,7 +465,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 static const struct file_operations ima_measure_policy_ops = {
 	.open = ima_open_policy,
-	.write = ima_write_policy,
+	.write = ima_write_data,
 	.read = seq_read,
 	.release = ima_release_policy,
 	.llseek = generic_file_llseek,
-- 
2.17.1

