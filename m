Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2C466F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfFNSEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:04:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33017 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFNSEL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:04:11 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EADD767C6981C0E7D81F;
        Fri, 14 Jun 2019 19:04:09 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:03:59 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 09/14] ima: introduce new securityfs files
Date:   Fri, 14 Jun 2019 19:55:08 +0200
Message-ID: <20190614175513.27097-10-roberto.sassu@huawei.com>
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

This patch introduces two new files in the securityfs filesystem:
digest_list_data, loads a digest list from the specified path, if it is in
the compact format, or loads a digest list converted by the user space
parser; digests_count: shows the number of digests stored in the
ima_digests_htable hash table.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/fs.h              |  1 +
 security/integrity/ima/ima_fs.c | 44 ++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..0591a3c3cc2f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2921,6 +2921,7 @@ extern int do_pipe_flags(int *, int);
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(DIGEST_LIST, digest-list)	\
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 0f503b7cd396..b02b9a447d56 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -24,6 +24,7 @@
 #include <linux/vmalloc.h>
 
 #include "ima.h"
+#include "ima_digest_list.h"
 
 static DEFINE_MUTEX(ima_write_mutex);
 
@@ -34,6 +35,8 @@ static struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
 static struct dentry *violations;
 static struct dentry *ima_policy;
+static struct dentry *digests_count;
+static struct dentry *digest_list_data;
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -58,6 +61,10 @@ static ssize_t ima_show_htable_value(struct file *filp, char __user *buf,
 		val = &ima_htable.violations;
 	else if (filp->f_path.dentry == runtime_measurements_count)
 		val = &ima_htable.len;
+#ifdef CONFIG_IMA_DIGEST_LIST
+	else if (filp->f_path.dentry == digests_count)
+		val = &ima_digests_htable.len;
+#endif
 
 	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
@@ -296,6 +303,9 @@ static ssize_t ima_read_file(char *path, enum kernel_read_file_id file_id)
 			pr_debug("rule: %s\n", p);
 			rc = ima_parse_add_rule(p);
 			break;
+		case READING_DIGEST_LIST:
+			rc = ima_parse_compact_list(size, data);
+			break;
 		default:
 			break;
 		}
@@ -319,6 +329,10 @@ static ssize_t ima_write_data(struct file *file, const char __user *buf,
 	char *data;
 	ssize_t result;
 	struct dentry *dentry = file_dentry(file);
+	enum kernel_read_file_id id = READING_POLICY;
+
+	if (dentry == digest_list_data)
+		id = READING_DIGEST_LIST;
 
 	/* No partial writes. */
 	result = -EINVAL;
@@ -345,7 +359,7 @@ static ssize_t ima_write_data(struct file *file, const char __user *buf,
 		goto out_free;
 
 	if (data[0] == '/') {
-		result = ima_read_file(data, READING_POLICY);
+		result = ima_read_file(data, id);
 	} else if (dentry == ima_policy) {
 		if (ima_appraise & IMA_APPRAISE_POLICY) {
 			pr_err("signed policy file (specified as an absolute pathname) required\n");
@@ -357,6 +371,11 @@ static ssize_t ima_write_data(struct file *file, const char __user *buf,
 		} else {
 			result = ima_parse_add_rule(data);
 		}
+	} else if (dentry == digest_list_data) {
+		if (ima_check_current_is_parser())
+			result = ima_parse_compact_list(datalen, data);
+		else
+			result = -EACCES;
 	} else {
 		pr_err("Unknown data type\n");
 		result = -EINVAL;
@@ -373,6 +392,7 @@ static ssize_t ima_write_data(struct file *file, const char __user *buf,
 
 enum ima_fs_flags {
 	IMA_POLICY_BUSY,
+	IMA_DIGEST_LIST_DATA_BUSY,
 	IMA_FS_BUSY,
 };
 
@@ -382,6 +402,8 @@ static enum ima_fs_flags ima_get_dentry_flag(struct dentry *dentry)
 
 	if (dentry == ima_policy)
 		flag = IMA_POLICY_BUSY;
+	else if (dentry == digest_list_data)
+		flag = IMA_DIGEST_LIST_DATA_BUSY;
 
 	return flag;
 }
@@ -412,6 +434,8 @@ static int ima_open_data_upload(struct inode *inode, struct file *filp)
 		read_allowed = true;
 		seq_ops = &ima_policy_seqops;
 #endif
+	} else if (dentry == digest_list_data) {
+		ima_set_parser(current);
 	}
 
 	if (!(filp->f_flags & O_WRONLY)) {
@@ -444,6 +468,9 @@ static int ima_release_data_upload(struct inode *inode, struct file *file)
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
+	if (dentry == digest_list_data)
+		ima_set_parser(NULL);
+
 	if (dentry != ima_policy) {
 		clear_bit(flag, &ima_fs_flags);
 		return 0;
@@ -529,8 +556,23 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_policy))
 		goto out;
 
+#ifdef CONFIG_IMA_DIGEST_LIST
+	digests_count = securityfs_create_file("digests_count",
+					       S_IRUSR | S_IRGRP, ima_dir,
+					       NULL, &ima_htable_value_ops);
+	if (IS_ERR(digests_count))
+		goto out;
+
+	digest_list_data = securityfs_create_file("digest_list_data", S_IWUSR,
+						  ima_dir, NULL,
+						  &ima_data_upload_ops);
+	if (IS_ERR(digest_list_data))
+		goto out;
+#endif
 	return 0;
 out:
+	securityfs_remove(digest_list_data);
+	securityfs_remove(digests_count);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
-- 
2.17.1

