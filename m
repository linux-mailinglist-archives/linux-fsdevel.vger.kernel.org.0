Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F52466F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfFNSDg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:03:36 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33016 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFNSDf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:03:35 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 3A58543FD37D8D34A0D7;
        Fri, 14 Jun 2019 19:03:34 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:03:24 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 08/14] ima: prevent usage of digest lists that are not measured/appraised
Date:   Fri, 14 Jun 2019 19:55:07 +0200
Message-ID: <20190614175513.27097-9-roberto.sassu@huawei.com>
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

The Digest Lists extension creates a new measurement only when a file is
unknown (i.e. its digest is not found in the uploaded digest lists).
However, if digest lists are not measured, a remote verifier cannot
determine which files could have possibly been accessed. If they are not
appraised, a user would be able to access files that are not signed or
protected with a HMAC.

This patch prevents this issue by monitoring the process that opened
digest_list_data and that can upload digests. If the process opens a file
that is not measured, digest list queries by IMA-Measure will be always
negative (ima_digest_allow() will always return a NULL pointer). The same
happens for IMA-Appraise.

This patch also ensures that the parser can only execute shared libraries
with type COMPACT_PARSER (i.e. libraries adding support for custom digest
list formats).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h             |  2 ++
 security/integrity/ima/ima_digest_list.c | 36 ++++++++++++++++++++++++
 security/integrity/ima/ima_digest_list.h | 15 ++++++++++
 security/integrity/ima/ima_main.c        | 17 ++++++++++-
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b4a0d2a02ff2..1729ecc4e3e7 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -53,6 +53,8 @@ extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 
+extern int ima_digest_list_actions;
+
 /* IMA event related data */
 struct ima_event_data {
 	struct integrity_iint_cache *iint;
diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
index 3c77a6cec29a..3aaa26d6e8e3 100644
--- a/security/integrity/ima/ima_digest_list.c
+++ b/security/integrity/ima/ima_digest_list.c
@@ -163,6 +163,9 @@ bool ima_check_current_is_parser(void)
 	struct file *parser_file;
 	struct mm_struct *mm;
 
+	if (!(ima_digest_list_actions & ima_policy_flag))
+		return false;
+
 	mm = get_task_mm(current);
 	if (!mm)
 		return false;
@@ -204,3 +207,36 @@ struct task_struct *ima_get_parser(void)
 {
 	return current_parser;
 }
+
+/**********************
+ * Digest usage check *
+ **********************/
+void ima_check_parser_action(struct inode *inode, enum ima_hooks hook,
+			     int mask, int action, bool check_digest,
+			     struct ima_digest *digest)
+{
+	int action_mask = (IMA_DO_MASK & ~IMA_APPRAISE_SUBMASK);
+
+	if (current != current_parser)
+		return;
+
+	if (!(mask & (MAY_READ | MAY_EXEC)))
+		return;
+
+	if (hook == MMAP_CHECK && mask == MAY_EXEC && check_digest &&
+	    (!digest || digest->type != COMPACT_PARSER))
+		action_mask = 0;
+
+	if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
+		action_mask = 0;
+
+	ima_digest_list_actions &= (action & action_mask);
+}
+
+struct ima_digest *ima_digest_allow(struct ima_digest *digest, int action)
+{
+	if (!(ima_digest_list_actions & action))
+		return NULL;
+
+	return digest;
+}
diff --git a/security/integrity/ima/ima_digest_list.h b/security/integrity/ima/ima_digest_list.h
index be07a4afd7b6..49798688f9c8 100644
--- a/security/integrity/ima/ima_digest_list.h
+++ b/security/integrity/ima/ima_digest_list.h
@@ -29,6 +29,10 @@ int ima_parse_compact_list(loff_t size, void *buf);
 bool ima_check_current_is_parser(void);
 void ima_set_parser(struct task_struct *parser);
 struct task_struct *ima_get_parser(void);
+void ima_check_parser_action(struct inode *inode, enum ima_hooks hook,
+			     int mask, int action, bool check_digest,
+			     struct ima_digest *digest);
+struct ima_digest *ima_digest_allow(struct ima_digest *digest, int action);
 #else
 static inline struct ima_digest *ima_lookup_digest(u8 *digest,
 						   enum hash_algo algo)
@@ -50,5 +54,16 @@ static inline struct task_struct *ima_get_parser(void)
 {
 	return NULL;
 }
+static inline void ima_check_parser_action(struct inode *inode,
+					   enum ima_hooks hook, int mask,
+					   int action, bool check_digest,
+					   struct ima_digest *digest)
+{
+}
+static inline struct ima_digest *ima_digest_allow(struct ima_digest *digest,
+						  int action)
+{
+	return NULL;
+}
 #endif /*CONFIG_IMA_DIGEST_LIST*/
 #endif /*LINUX_IMA_DIGEST_LIST_H*/
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index dc53ed8b0dd0..15eb00fb6b6d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -29,6 +29,7 @@
 #include <linux/fs.h>
 
 #include "ima.h"
+#include "ima_digest_list.h"
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
@@ -36,6 +37,9 @@ int ima_appraise = IMA_APPRAISE_ENFORCE;
 int ima_appraise;
 #endif
 
+/* Actions (measure/appraisal) for which digest lists can be used */
+int ima_digest_list_actions;
+
 int ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
 
@@ -252,11 +256,15 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	const char *pathname = NULL;
 	int rc = 0, action, must_appraise = 0;
 	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	struct ima_digest *found_digest = NULL;
 	struct evm_ima_xattr_data *xattr_value = NULL;
 	int xattr_len = 0;
 	bool violation_check;
 	enum hash_algo hash_algo;
 
+	ima_check_parser_action(inode, func, mask, ima_policy_flag, false,
+				NULL);
+
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
 
@@ -268,6 +276,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				&template_desc);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
+
+	ima_check_parser_action(inode, func, mask, action, false, NULL);
+
 	if (!action && !violation_check)
 		return 0;
 
@@ -312,7 +323,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
 	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
 	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
-	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
+	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS)) ||
+	    ima_get_parser() == current) {
 		iint->flags &= ~IMA_DONE_MASK;
 		iint->measured_pcrs = 0;
 	}
@@ -366,6 +378,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
+	found_digest = ima_lookup_digest(iint->ima_hash->digest, hash_algo);
+	ima_check_parser_action(inode, func, mask, action, true, found_digest);
+
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, pcr,
-- 
2.17.1

