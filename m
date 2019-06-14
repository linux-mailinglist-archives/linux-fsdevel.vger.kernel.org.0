Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFEE94670A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfFNSFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:05:12 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33019 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFNSFM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:05:12 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C83785E0BC96400BAF4F;
        Fri, 14 Jun 2019 19:05:10 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:05:04 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 11/14] ima: add support for measurement with digest lists
Date:   Fri, 14 Jun 2019 19:55:10 +0200
Message-ID: <20190614175513.27097-12-roberto.sassu@huawei.com>
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

IMA-Measure creates a new measurement entry every time a file is measured,
unless the same entry is already in the measurement list.

This patch introduces a new type of measurement list, recognizable by the
PCR number specified with the new ima_digest_list_pcr= kernel option. This
type of measurement list includes measurements of digest lists and files
not found in those lists.

The benefit of this patch is the availability of a predictable PCR that
can be used to seal data or TPM keys to the OS software. Unlike standard
measurements, digest lists measurements only indicate that files with a
digest in those lists could have been accessed, but not if and when. With
standard measurements, however, the chosen PCR is unlikely predictable.

Both standard and digest list measurements can be generated at the same
time by adding '+' as a prefix to the value of ima_digest_list_pcr=
(example: with ima_digest_list_pcr=+11, IMA generates standard measurements
with PCR 10 and digest list measurements with PCR 11).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++++
 security/integrity/ima/ima.h                  |  9 ++--
 security/integrity/ima/ima_api.c              | 43 ++++++++++++++++---
 security/integrity/ima/ima_digest_list.c      | 25 +++++++++++
 security/integrity/ima/ima_init.c             |  2 +-
 security/integrity/ima/ima_main.c             |  9 +++-
 security/integrity/ima/ima_policy.c           |  3 +-
 7 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0585194ca736..05862a0c402d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1599,6 +1599,14 @@
 			Use the canonical format for the binary runtime
 			measurements, instead of host native format.
 
+	ima_digest_list_pcr=
+			[IMA]
+			Specify which PCR is extended with digests not found
+			in loaded digest lists. Measurement entries for known
+			files are not created unless the '+' is added before
+			the chosen PCR.
+			Format: { [+]<unsigned int> }
+
 	ima_hash=	[IMA]
 			Format: { md5 | sha1 | rmd160 | sha256 | sha384
 				   | sha512 | ... }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 1729ecc4e3e7..42e4f2b64cd1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -52,6 +52,8 @@ extern int ima_policy_flag;
 extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
+extern int ima_digest_list_pcr;
+extern bool ima_plus_standard_pcr;
 
 extern int ima_digest_list_actions;
 
@@ -204,15 +206,16 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, int pcr,
-			   struct ima_template_desc *template_desc);
+			   struct ima_template_desc *template_desc,
+			   struct ima_digest *digest);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
 			    struct ima_template_entry **entry,
 			    struct ima_template_desc *template_desc);
 int ima_store_template(struct ima_template_entry *entry, int violation,
-		       struct inode *inode,
-		       const unsigned char *filename, int pcr);
+		       struct inode *inode, const unsigned char *filename,
+		       int pcr, struct ima_digest *digest);
 void ima_free_template_entry(struct ima_template_entry *entry);
 const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 3233cd69a91b..a3e23b8e2ec7 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -90,11 +90,13 @@ int ima_alloc_init_template(struct ima_event_data *event_data,
  */
 int ima_store_template(struct ima_template_entry *entry,
 		       int violation, struct inode *inode,
-		       const unsigned char *filename, int pcr)
+		       const unsigned char *filename, int pcr,
+		       struct ima_digest *digest)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "hashing_error";
 	char *template_name = entry->template_desc->name;
+	struct ima_template_entry *duplicated_entry = NULL;
 	int result;
 	struct {
 		struct ima_digest_data hdr;
@@ -117,8 +119,27 @@ int ima_store_template(struct ima_template_entry *entry,
 		}
 		memcpy(entry->digest, hash.hdr.digest, hash.hdr.length);
 	}
+
+	if (ima_plus_standard_pcr && !digest) {
+		duplicated_entry = kmemdup(entry,
+			sizeof(*entry) + entry->template_desc->num_fields *
+			sizeof(struct ima_field_data), GFP_KERNEL);
+		if (duplicated_entry)
+			duplicated_entry->pcr = ima_digest_list_pcr;
+	} else if (!ima_plus_standard_pcr && ima_digest_list_pcr >= 0) {
+		pcr = ima_digest_list_pcr;
+	}
+
 	entry->pcr = pcr;
+
 	result = ima_add_template_entry(entry, violation, op, inode, filename);
+	if (!result && duplicated_entry) {
+		result = ima_add_template_entry(duplicated_entry, violation, op,
+						inode, filename);
+		if (result < 0)
+			kfree(duplicated_entry);
+	}
+
 	return result;
 }
 
@@ -150,8 +171,8 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 		result = -ENOMEM;
 		goto err_out;
 	}
-	result = ima_store_template(entry, violation, inode,
-				    filename, CONFIG_IMA_MEASURE_PCR_IDX);
+	result = ima_store_template(entry, violation, inode, filename,
+				    CONFIG_IMA_MEASURE_PCR_IDX, NULL);
 	if (result < 0)
 		ima_free_template_entry(entry);
 err_out:
@@ -285,13 +306,14 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 			   struct file *file, const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, int pcr,
-			   struct ima_template_desc *template_desc)
+			   struct ima_template_desc *template_desc,
+			   struct ima_digest *digest)
 {
 	static const char op[] = "add_template_measure";
 	static const char audit_cause[] = "ENOMEM";
 	int result = -ENOMEM;
 	struct inode *inode = file_inode(file);
-	struct ima_template_entry *entry;
+	struct ima_template_entry *entry = NULL;
 	struct ima_event_data event_data = { .iint = iint,
 					     .file = file,
 					     .filename = filename,
@@ -302,6 +324,11 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 	if (iint->measured_pcrs & (0x1 << pcr))
 		return;
 
+	if (digest && !ima_plus_standard_pcr && ima_digest_list_pcr >= 0) {
+		result = -EEXIST;
+		goto out;
+	}
+
 	result = ima_alloc_init_template(&event_data, &entry, template_desc);
 	if (result < 0) {
 		integrity_audit_msg(AUDIT_INTEGRITY_PCR, inode, filename,
@@ -309,12 +336,14 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
 		return;
 	}
 
-	result = ima_store_template(entry, violation, inode, filename, pcr);
+	result = ima_store_template(entry, violation, inode, filename, pcr,
+				    digest);
+out:
 	if ((!result || result == -EEXIST) && !(file->f_flags & O_DIRECT)) {
 		iint->flags |= IMA_MEASURED;
 		iint->measured_pcrs |= (0x1 << pcr);
 	}
-	if (result < 0)
+	if (result < 0 && entry)
 		ima_free_template_entry(entry);
 }
 
diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
index 532aaf5145ae..c9c079ae82c7 100644
--- a/security/integrity/ima/ima_digest_list.c
+++ b/security/integrity/ima/ima_digest_list.c
@@ -28,6 +28,31 @@ struct ima_h_table ima_digests_htable = {
 	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
 };
 
+static int __init digest_list_pcr_setup(char *str)
+{
+	int pcr, ret;
+
+	ret = kstrtouint(str, 10, &pcr);
+	if (ret) {
+		pr_err("Invalid PCR number %s\n", str);
+		return 1;
+	}
+
+	if (pcr == CONFIG_IMA_MEASURE_PCR_IDX) {
+		pr_err("Default PCR cannot be used for digest lists\n");
+		return 1;
+	}
+
+	ima_digest_list_pcr = pcr;
+	ima_digest_list_actions |= IMA_MEASURE;
+
+	if (*str == '+')
+		ima_plus_standard_pcr = true;
+
+	return 1;
+}
+__setup("ima_digest_list_pcr=", digest_list_pcr_setup);
+
 /*********************
  * Get/add functions *
  *********************/
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d55ade5f3b9..5ca9250b913a 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -76,7 +76,7 @@ static int __init ima_add_boot_aggregate(void)
 
 	result = ima_store_template(entry, violation, NULL,
 				    boot_aggregate_name,
-				    CONFIG_IMA_MEASURE_PCR_IDX);
+				    CONFIG_IMA_MEASURE_PCR_IDX, NULL);
 	if (result < 0) {
 		ima_free_template_entry(entry);
 		audit_cause = "store_entry";
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 15eb00fb6b6d..eca55e788c28 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -39,6 +39,10 @@ int ima_appraise;
 
 /* Actions (measure/appraisal) for which digest lists can be used */
 int ima_digest_list_actions;
+/* PCR used for digest list measurements */
+int ima_digest_list_pcr = -1;
+/* Flag to include standard measurement if digest list PCR is specified */
+bool ima_plus_standard_pcr;
 
 int ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
@@ -384,7 +388,10 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (action & IMA_MEASURE)
 		ima_store_measurement(iint, file, pathname,
 				      xattr_value, xattr_len, pcr,
-				      template_desc);
+				      template_desc,
+				      ima_digest_allow(found_digest,
+						       IMA_MEASURE));
+
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		inode_lock(inode);
 		rc = ima_appraise_measurement(func, iint, file, pathname,
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 0e1c81a29ac1..5537b91272f0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1135,7 +1135,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			ima_log_string(ab, "pcr", args[0].from);
 
 			result = kstrtoint(args[0].from, 10, &entry->pcr);
-			if (result || INVALID_PCR(entry->pcr))
+			if (result || INVALID_PCR(entry->pcr) ||
+			    entry->pcr == ima_digest_list_pcr)
 				result = -EINVAL;
 			else
 				entry->flags |= IMA_PCR;
-- 
2.17.1

