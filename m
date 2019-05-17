Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06EC021F97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfEQVZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:25:05 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:51744 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfEQVZF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:25:05 -0400
Received: by mail-vs1-f74.google.com with SMTP id h22so1646086vso.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 14:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BLoKd5JLJMfKPW5l7eN3gWFm7KhsRgY404yjUUoL80c=;
        b=InQsJZsY17kRCzgIuq9O1BqfkYYkn7JZ8zXK8Agx7WKP6EFPA+7YP08NhWs5MQvg+Z
         CmEuWbbcydHLXSGXzfwkSEsWZBnBHxmEiu4IYT0j/fvPmYyrxsZPY4hw6bCfJC1YuXQI
         cVouqAfox+PDZeN2qN3q+GkbIKEP4ac7gqCwAM5WETsV3zoRq3VNDA6+HnFQAOTPT/Xj
         sVVD8EtJEDkJzX6gq3T3VhIEbCTJugrTPahj42u2p5Q7S0PvWh8zvXx/A+KVZeqdWIJn
         ByPcE+tCMGTeXJDAlLNAo0pwSYZ+uhxtdtmKfMw3bt2uK+dsPJfBX1wcDG9y6Pd5UGDZ
         vmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BLoKd5JLJMfKPW5l7eN3gWFm7KhsRgY404yjUUoL80c=;
        b=Kg5Q6NCod6I3Dgc7Zjd0yaYToQQzD7GvGwErF0Zt5FZ8+DVqaBlX2rrrnXVIAz7K/7
         BeNf4Bk8zNzLxoLFUN2JrPjP85GBKi11P6evOEo+rOe7dE3a3AJFzhxq2fRrFmDwlrfz
         1vTtxm0xy5zhZuCXSD1elxMWXJ+XzXsgy/H5oWFB8W7Oiev2e2Mx9iexjs20GFmBHtLW
         QLRV6X3iyIIgxqUV7oDRUyXMweyCs5n2lkAgh6yoCo/BUDYnYTCoDl02qhaX35HUeMje
         iVvicS9dbp2OtmTOc1hAZsCtybrvdloIyi3jDvqLb79ZQDq+C7FXGNpYmODlo1amInRk
         aRfg==
X-Gm-Message-State: APjAAAX7726NpgKI8uSCYLvfA67ulEUbw8Uh5UArMZhBcO8+w8pucRQ+
        2MsQ/DyGHqBkeknXoy9CTGTjt9gTvs3xc+lOx/jAXQ==
X-Google-Smtp-Source: APXvYqzC7i1k3xBs8Acb5XaZfkwAAikudoJJANjPJZDxtyVJ8Y+ZEfTYfb/4AJ98KHvnjToAdMaIKI1mUuDuEWw575MSAw==
X-Received: by 2002:a67:eb13:: with SMTP id a19mr18982363vso.233.1558128304247;
 Fri, 17 May 2019 14:25:04 -0700 (PDT)
Date:   Fri, 17 May 2019 14:24:46 -0700
In-Reply-To: <20190517212448.14256-1-matthewgarrett@google.com>
Message-Id: <20190517212448.14256-5-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190517212448.14256-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V3 4/6] IMA: Optionally make use of filesystem-provided hashes
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
index 2b8ee90bb644..573cef13d268 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1656,6 +1656,11 @@
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
index 16a4f45863b1..cceedce750d3 100644
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
@@ -402,11 +406,14 @@ static int ima_calc_file_shash(struct file *file, struct ima_digest_data *hash)
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
@@ -419,6 +426,20 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash)
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

