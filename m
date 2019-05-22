Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E09269A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 20:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfEVSNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 14:13:41 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:37179 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbfEVSNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 14:13:41 -0400
Received: by mail-yw1-f73.google.com with SMTP id j68so2835272ywj.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 11:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W14yhZSbIYutl917bFZgD1LB9cP8MSc8qpJ30KN8/xY=;
        b=nshLQUz/xs28a0FBCodICoIzvpNx1PJyfnOnmdzn70d2gOdRdy7rnM8JdGkjNt3fie
         A28qlYr2fA+SSp7LWX8UC/l3v3YT3l7thwESJ/zj3QM0oRx/LoKlseqRtR7pr9IgeVbT
         CawAkF3e4TBZK/SD/qWeqw3a3DjVaq1y31i5loIHi3UwKIZqTGEL1K10Zgd5sKvojg8v
         lpzPZHjthq3XjJSruqoxiaePMPqHHQt5u6vE48jJLWWkQVmlThy+1TUgC0uyt2T9Xlwk
         HbFWynOPTcQG6Ur14E4ArgWIUqV3clymeXU7N8jVImENIJcanL/T2sPeJis9bbHNpeEP
         tp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W14yhZSbIYutl917bFZgD1LB9cP8MSc8qpJ30KN8/xY=;
        b=D2wZtERXkaOicFUlTTLjXHj2XZBydtApJ9TezUcHkaZB8Kc2RAhAe8FeZK6km2EHc5
         RDh8t0tRElxq/CwuO/En2jF8/dnFT1RbGW3sA6H6FlkR/NZYEjJT5ZoDZWxFAu1niejO
         7Bwv8gsfoBx+LUh5dkhWuTBfyzPEdC3w5/a4zwqSsQb1J+g1pZgWbjNW1NCx2aImPgC9
         zzaggkLcbGWCRgodxRKEO2TLwEuVH0EoN3K2nqQD0JWdcldz0/QESMmfO9s8aIb/8HWd
         frh1YQXOcG+blQBSNUhbJphLIO/QwsF658KeB/mTTUHuAW1/yoa6iQuxZQKHBvXUN2V4
         QowQ==
X-Gm-Message-State: APjAAAVKtQwgdCF81v+BS21Zq034HW3E6TWV47d5aRBYdSGB5H37CbQz
        0t0dt8sB2m/0LQ5dfBxazQZFin4X06TmNk1RMLrOGw==
X-Google-Smtp-Source: APXvYqxbky+LkwRGXyhlR2YyZYaXkAJZNhVmC8tXFtPRQpXY+UO0/lGmRXaCTlVy56bqUHTgigIYoKLR44BvZN5xuiRHVw==
X-Received: by 2002:a81:4d8a:: with SMTP id a132mr42404176ywb.326.1558548819594;
 Wed, 22 May 2019 11:13:39 -0700 (PDT)
Date:   Wed, 22 May 2019 11:13:25 -0700
In-Reply-To: <20190522181327.71980-1-matthewgarrett@google.com>
Message-Id: <20190522181327.71980-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190522181327.71980-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V4 3/5] IMA: Optionally make use of filesystem-provided hashes
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Garrett <mjg59@google.com>

Some filesystems may be able to provide hashes in an out of band manner,
and allowing them to do so is a performance win. This is especially true
of FUSE-based filesystems where otherwise we recalculate the hash on
every measurement. Make use of this if policy says we should, but provide
a parameter to force recalculation rather than trusting the filesystem.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 Documentation/ABI/testing/ima_policy          |  5 +++-
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 security/integrity/ima/ima.h                  |  3 ++-
 security/integrity/ima/ima_api.c              |  5 +++-
 security/integrity/ima/ima_crypto.c           | 23 ++++++++++++++++++-
 security/integrity/ima/ima_policy.c           |  8 ++++++-
 security/integrity/ima/ima_template_lib.c     |  2 +-
 security/integrity/integrity.h                |  1 +
 8 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 09a5def7e28a..6a517282068d 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -24,7 +24,8 @@ Description:
 				[euid=] [fowner=] [fsname=] [subtype=]]
 			lsm:	[[subj_user=] [subj_role=] [subj_type=]
 				 [obj_user=] [obj_role=] [obj_type=]]
-			option:	[[appraise_type=]] [permit_directio]
+			option:	[[appraise_type=] [permit_directio]
+			         [trust_vfs]]
 
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
@@ -41,6 +42,8 @@ Description:
 		lsm:  	are LSM specific
 		option:	appraise_type:= [imasig]
 			pcr:= decimal value
+			permit_directio:= allow directio accesses
+			trust_vfs:= trust VFS-provided hash values
 
 		default policy:
 			# PROC_SUPER_MAGIC
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 52e6fbb042cc..cc9302b79409 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1658,6 +1658,11 @@
 			different crypto accelerators. This option can be used
 			to achieve best performance for particular HW.
 
+	ima.force_hash= [IMA] Force hash calculation in IMA
+			Format: <bool>
+			Always calculate hashes rather than trusting the
+			filesystem to provide them to us.
+
 	init=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /sbin/init as init
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d213e835c498..cdaffe6c8a8d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -133,7 +133,8 @@ int ima_fs_init(void);
 int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename);
-int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash);
+int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash,
+		       bool trust_vfs);
 int ima_calc_buffer_hash(const void *buf, loff_t len,
 			 struct ima_digest_data *hash);
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c7505fb122d4..0def9cf43549 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -206,6 +206,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	int length;
 	void *tmpbuf;
 	u64 i_version;
+	bool trust_vfs;
 	struct {
 		struct ima_digest_data hdr;
 		char digest[IMA_MAX_DIGEST_SIZE];
@@ -225,10 +226,12 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	/* Initialize hash digest to 0's in case of failure */
 	memset(&hash.digest, 0, sizeof(hash.digest));
 
+	trust_vfs = iint->flags & IMA_TRUST_VFS;
+
 	if (buf)
 		result = ima_calc_buffer_hash(buf, size, &hash.hdr);
 	else
-		result = ima_calc_file_hash(file, &hash.hdr);
+		result = ima_calc_file_hash(file, &hash.hdr, trust_vfs);
 
 	if (result && result != -EBADF && result != -EINVAL)
 		goto out;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index a32878e10ebc..1c83d23d21a6 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -32,6 +32,10 @@ static unsigned long ima_ahash_minsize;
 module_param_named(ahash_minsize, ima_ahash_minsize, ulong, 0644);
 MODULE_PARM_DESC(ahash_minsize, "Minimum file size for ahash use");
 
+static bool ima_force_hash;
+module_param_named(force_hash, ima_force_hash, bool_enable_only, 0644);
+MODULE_PARM_DESC(force_hash, "Always calculate hashes");
+
 /* default is 0 - 1 page. */
 static int ima_maxorder;
 static unsigned int ima_bufsize = PAGE_SIZE;
@@ -401,11 +405,14 @@ static int ima_calc_file_shash(struct file *file, struct ima_digest_data *hash)
  * shash for the hash calculation.  If ahash fails, it falls back to using
  * shash.
  */
-int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
+int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash,
+		       bool trust_vfs)
 {
 	loff_t i_size;
 	int rc;
 	struct file *f = file;
+	struct dentry *dentry = file_dentry(file);
+	struct inode *inode = d_backing_inode(dentry);
 	bool new_file_instance = false, modified_flags = false;
 
 	/*
@@ -418,6 +425,20 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
 		return -EINVAL;
 	}
 
+	/*
+	 * If policy says we should trust VFS-provided hashes, and
+	 * we're not configured to force hashing, and if the
+	 * filesystem is trusted, ask the VFS if it can obtain the
+	 * hash without us having to calculate it ourself.
+	 */
+	if (trust_vfs && !ima_force_hash &&
+	    !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER)) {
+		hash->length = hash_digest_size[hash->algo];
+		rc = vfs_get_hash(file, hash->algo, hash->digest, hash->length);
+		if (!rc)
+			return 0;
+	}
+
 	/* Open a new file instance in O_RDONLY if we cannot read */
 	if (!(file->f_mode & FMODE_READ)) {
 		int flags = file->f_flags & ~(O_WRONLY | O_APPEND |
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index bb4e265823a7..c293cbc6c578 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -681,7 +681,7 @@ enum {
 	Opt_uid_gt, Opt_euid_gt, Opt_fowner_gt,
 	Opt_uid_lt, Opt_euid_lt, Opt_fowner_lt,
 	Opt_appraise_type, Opt_permit_directio,
-	Opt_pcr, Opt_err
+	Opt_pcr, Opt_trust_vfs, Opt_err
 };
 
 static const match_table_t policy_tokens = {
@@ -716,6 +716,7 @@ static const match_table_t policy_tokens = {
 	{Opt_appraise_type, "appraise_type=%s"},
 	{Opt_permit_directio, "permit_directio"},
 	{Opt_pcr, "pcr=%s"},
+	{Opt_trust_vfs, "trust_vfs"},
 	{Opt_err, NULL}
 };
 
@@ -1062,6 +1063,9 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		case Opt_permit_directio:
 			entry->flags |= IMA_PERMIT_DIRECTIO;
 			break;
+		case Opt_trust_vfs:
+			entry->flags |= IMA_TRUST_VFS;
+			break;
 		case Opt_pcr:
 			if (entry->action != MEASURE) {
 				result = -EINVAL;
@@ -1358,6 +1362,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, "appraise_type=imasig ");
 	if (entry->flags & IMA_PERMIT_DIRECTIO)
 		seq_puts(m, "permit_directio ");
+	if (entry->flags & IMA_TRUST_VFS)
+		seq_puts(m, "trust_vfs ");
 	rcu_read_unlock();
 	seq_puts(m, "\n");
 	return 0;
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 513b457ae900..26f71c5805f0 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -291,7 +291,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	inode = file_inode(event_data->file);
 	hash.hdr.algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
 	    ima_hash_algo : HASH_ALGO_SHA1;
-	result = ima_calc_file_hash(event_data->file, &hash.hdr);
+	result = ima_calc_file_hash(event_data->file, &hash.hdr, false);
 	if (result) {
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
 				    event_data->filename, "collect_data",
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7de59f44cba3..a03f859c1602 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -36,6 +36,7 @@
 #define IMA_NEW_FILE		0x04000000
 #define EVM_IMMUTABLE_DIGSIG	0x08000000
 #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
+#define IMA_TRUST_VFS		0x20000000
 
 #define IMA_DO_MASK		(IMA_MEASURE | IMA_APPRAISE | IMA_AUDIT | \
 				 IMA_HASH | IMA_APPRAISE_SUBMASK)
-- 
2.21.0.1020.gf2820cf01a-goog

