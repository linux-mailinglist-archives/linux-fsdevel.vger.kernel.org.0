Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0592F21F9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 23:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfEQVZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 17:25:08 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:51589 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfEQVZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 17:25:08 -0400
Received: by mail-yw1-f74.google.com with SMTP id k10so7530376ywb.18
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2019 14:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zl3/Rnw7EQS3Z+Zsbp/vOJNYpSsHIdTqkNKdqugEpeA=;
        b=I6a/LS+o2HJd5uUaVhavxbPxPjV96426L0jS9BGOerOlLlqkcalMt92xpBYK1GBWUB
         wPCL2e+tRqWjdbHDsKN3xXP0cP1A1zYHd2OKUKa2crnEXD7jNtt6amIrOpOUgM8hkPVe
         CpCJGpfYiYGKdAZpI38o++llgXwCJ4BormpqF0iSGgissHeoK86lTC+ebRY8wgTBf2rH
         JVLIrkyRtDt8s9JY8S8WvcYTNg+jSXY6dWncSjXwlpasXs2VtVN+itFiUsOSLJjUdpX6
         FIG7rFm6LGV7VNe9lz0YIUnNyjvYBW//dr2Czg4Vs9qMbUn1X5ltjNUTegKuTlHfQ8+Y
         yRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zl3/Rnw7EQS3Z+Zsbp/vOJNYpSsHIdTqkNKdqugEpeA=;
        b=AHSf7ge2agJ7tndN49c/hKYC8a7S3txWpOQTPh9L5PQQs8X2aIUBNnl3ESifF4c1/X
         DBt1ktR72BRIzu1gZ1tOZ68dJ7eeeahavVcT1ussh/JV+t842yVk6NyPHw+U1rbsYMKI
         e8GS56O6j9xwcKqU6JoXD8Wtu5mUcYE7ZEwMMFwNXjBoio49VjnAHNfW2GowZ14EfWZ5
         lQu2Y5Qk8dPQqN/R9i8598NF1N6fPc1d4+iDKu8RNPED4GUZ4lwcV2ZbLox8eYhsqsE/
         PP/5EprV7MVXB9a82txRE7AlC8H1wIW6O/3s3A10s2sXPWhxCiYp59GIsI2VbTgtnynP
         a+/w==
X-Gm-Message-State: APjAAAVWvYQraK3mTJmMDktni1FusLOOsuz3fZ7IibMWc7QQbDCXa+DV
        myHN/UPhQdD2qamykEp5Bx8QgDLndya3Y36F/s4+HQ==
X-Google-Smtp-Source: APXvYqxhoUxPRHt0GzeXmuwcl0k+JPbW78hOCSMGd+677rVy429jpB5wqwdyV7nSUIofDAT4zByzgzHe0FppDp2jyWFW5g==
X-Received: by 2002:a0d:edc5:: with SMTP id w188mr9387948ywe.17.1558128307137;
 Fri, 17 May 2019 14:25:07 -0700 (PDT)
Date:   Fri, 17 May 2019 14:24:47 -0700
In-Reply-To: <20190517212448.14256-1-matthewgarrett@google.com>
Message-Id: <20190517212448.14256-6-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190517212448.14256-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V3 5/6] IMA: Add a ima-vfs-sig measurement template
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Admins may wish to know whether measurements were sourced from the VFS
or calculated by IMA, so we should provide an additional tag to indicate
that. However, doing this by default would potentially break existing
log parsing pipelines, so add a new template type rather than changing
the default behaviour.

Signed-off-by: Matthew Garrett <mjg59@google.com>
---
 security/integrity/ima/Kconfig            |  7 +++-
 security/integrity/ima/ima.h              |  2 +-
 security/integrity/ima/ima_api.c          |  6 +++-
 security/integrity/ima/ima_crypto.c       |  7 ++--
 security/integrity/ima/ima_template.c     |  3 ++
 security/integrity/ima/ima_template_lib.c | 41 ++++++++++++++++++++---
 security/integrity/ima/ima_template_lib.h |  2 ++
 security/integrity/integrity.h            |  1 +
 8 files changed, 59 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a18f8c6d13b5..d2c7623d1dde 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -69,12 +69,16 @@ choice
 	  hash, defined as 20 bytes, and a null terminated pathname,
 	  limited to 255 characters.  The 'ima-ng' measurement list
 	  template permits both larger hash digests and longer
-	  pathnames.
+	  pathnames. The 'ima-vfs-ng' measurement list template includes
+	  an additional vfs: tag if the measurement was sourced directly
+	  from the filesystem.
 
 	config IMA_TEMPLATE
 		bool "ima"
 	config IMA_NG_TEMPLATE
 		bool "ima-ng (default)"
+	config IMA_VFS_NG_TEMPLATE
+	        bool "ima-vfs-ng"
 	config IMA_SIG_TEMPLATE
 		bool "ima-sig"
 endchoice
@@ -85,6 +89,7 @@ config IMA_DEFAULT_TEMPLATE
 	default "ima" if IMA_TEMPLATE
 	default "ima-ng" if IMA_NG_TEMPLATE
 	default "ima-sig" if IMA_SIG_TEMPLATE
+	default "ima-vfs-ng" if IMA_VFS_NG_TEMPLATE
 
 choice
 	prompt "Default integrity hash algorithm"
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cdaffe6c8a8d..d99b867bdc53 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -134,7 +134,7 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 			   const char *op, struct inode *inode,
 			   const unsigned char *filename);
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash,
-		       bool trust_vfs);
+		       bool *trust_vfs);
 int ima_calc_buffer_hash(const void *buf, loff_t len,
 			 struct ima_digest_data *hash);
 int ima_calc_field_array_hash(struct ima_field_data *field_data,
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 0def9cf43549..55bafce3d9c0 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -231,7 +231,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	if (buf)
 		result = ima_calc_buffer_hash(buf, size, &hash.hdr);
 	else
-		result = ima_calc_file_hash(file, &hash.hdr, trust_vfs);
+		result = ima_calc_file_hash(file, &hash.hdr, &trust_vfs);
 
 	if (result && result != -EBADF && result != -EINVAL)
 		goto out;
@@ -247,6 +247,10 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	memcpy(iint->ima_hash, &hash, length);
 	iint->version = i_version;
 
+	/* Record whether we got this measurement from the VFS or not */
+	if (trust_vfs)
+		set_bit(IMA_TRUSTED_VFS, &iint->atomic_flags);
+
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
 		iint->flags |= IMA_COLLECTED;
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index cceedce750d3..721893073607 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -407,7 +407,7 @@ static int ima_calc_file_shash(struct file *file, struct ima_digest_data *hash)
  * shash.
  */
 int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash,
-		       bool trust_vfs)
+		       bool *trust_vfs)
 {
 	loff_t i_size;
 	int rc;
@@ -432,7 +432,7 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash,
 	 * filesystem is trusted, ask the VFS if it can obtain the
 	 * hash without us having to calculate it ourself.
 	 */
-	if (trust_vfs && !ima_force_hash &&
+	if (*trust_vfs == true && !ima_force_hash &&
 	    !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER)) {
 		hash->length = hash_digest_size[hash->algo];
 		rc = vfs_get_hash(file, hash->algo, hash->digest, hash->length);
@@ -440,6 +440,9 @@ int ima_calc_file_hash(struct file *file, struct ima_digest_data *hash,
 			return 0;
 	}
 
+	/* If we're here then we're not using the VFS to obtain the hash */
+	*trust_vfs = false;
+
 	/* Open a new file instance in O_RDONLY if we cannot read */
 	if (!(file->f_mode & FMODE_READ)) {
 		int flags = file->f_flags & ~(O_WRONLY | O_APPEND |
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index b631b8bc7624..78bd8fea8b35 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -25,6 +25,7 @@ enum header_fields { HDR_PCR, HDR_DIGEST, HDR_TEMPLATE_NAME,
 static struct ima_template_desc builtin_templates[] = {
 	{.name = IMA_TEMPLATE_IMA_NAME, .fmt = IMA_TEMPLATE_IMA_FMT},
 	{.name = "ima-ng", .fmt = "d-ng|n-ng"},
+	{.name = "ima-vfs-ng", .fmt = "d-vng|n-ng"},
 	{.name = "ima-sig", .fmt = "d-ng|n-ng|sig"},
 	{.name = "", .fmt = ""},	/* placeholder for a custom format */
 };
@@ -41,6 +42,8 @@ static const struct ima_template_field supported_fields[] = {
 	 .field_show = ima_show_template_digest_ng},
 	{.field_id = "n-ng", .field_init = ima_eventname_ng_init,
 	 .field_show = ima_show_template_string},
+	{.field_id = "d-vng", .field_init = ima_eventdigest_vfs_ng_init,
+	 .field_show = ima_show_template_digest_ng},
 	{.field_id = "sig", .field_init = ima_eventsig_init,
 	 .field_show = ima_show_template_sig},
 };
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 26f71c5805f0..863e95281c4b 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -224,7 +224,9 @@ int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 }
 
 static int ima_eventdigest_init_common(u8 *digest, u32 digestsize, u8 hash_algo,
-				       struct ima_field_data *field_data)
+				       struct ima_event_data *event_data,
+				       struct ima_field_data *field_data,
+				       bool from_vfs)
 {
 	/*
 	 * digest formats:
@@ -237,10 +239,13 @@ static int ima_eventdigest_init_common(u8 *digest, u32 digestsize, u8 hash_algo,
 	enum data_formats fmt = DATA_FMT_DIGEST;
 	u32 offset = 0;
 
+	if (from_vfs)
+		offset += snprintf(buffer, 5, "vfs:");
+
 	if (hash_algo < HASH_ALGO__LAST) {
 		fmt = DATA_FMT_DIGEST_WITH_ALGO;
-		offset += snprintf(buffer, CRYPTO_MAX_ALG_NAME + 1, "%s",
-				   hash_algo_name[hash_algo]);
+		offset += snprintf(buffer + offset, CRYPTO_MAX_ALG_NAME + 1,
+				   "%s", hash_algo_name[hash_algo]);
 		buffer[offset] = ':';
 		offset += 2;
 	}
@@ -302,7 +307,7 @@ int ima_eventdigest_init(struct ima_event_data *event_data,
 	cur_digestsize = hash.hdr.length;
 out:
 	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
-					   HASH_ALGO__LAST, field_data);
+			       HASH_ALGO__LAST, event_data, field_data, false);
 }
 
 /*
@@ -323,7 +328,33 @@ int ima_eventdigest_ng_init(struct ima_event_data *event_data,
 	hash_algo = event_data->iint->ima_hash->algo;
 out:
 	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
-					   hash_algo, field_data);
+				     hash_algo, event_data, field_data, false);
+}
+
+/*
+ * This function is identical to ima_eventdigest_ng_init but tags events whose
+ * digest came from the VFS
+ */
+int ima_eventdigest_vfs_ng_init(struct ima_event_data *event_data,
+				struct ima_field_data *field_data)
+{
+	u8 *cur_digest = NULL, hash_algo = HASH_ALGO_SHA1;
+	u32 cur_digestsize = 0;
+	bool vfs = false;
+
+	if (test_bit(IMA_TRUSTED_VFS, &event_data->iint->atomic_flags))
+		vfs = true;
+
+	if (event_data->violation)	/* recording a violation. */
+		goto out;
+
+	cur_digest = event_data->iint->ima_hash->digest;
+	cur_digestsize = event_data->iint->ima_hash->length;
+
+	hash_algo = event_data->iint->ima_hash->algo;
+out:
+	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
+				       hash_algo, event_data, field_data, vfs);
 }
 
 static int ima_eventname_init_common(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 6a3d8b831deb..3f320299e0a0 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -38,6 +38,8 @@ int ima_eventname_init(struct ima_event_data *event_data,
 		       struct ima_field_data *field_data);
 int ima_eventdigest_ng_init(struct ima_event_data *event_data,
 			    struct ima_field_data *field_data);
+int ima_eventdigest_vfs_ng_init(struct ima_event_data *event_data,
+				struct ima_field_data *field_data);
 int ima_eventname_ng_init(struct ima_event_data *event_data,
 			  struct ima_field_data *field_data);
 int ima_eventsig_init(struct ima_event_data *event_data,
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index a03f859c1602..9d74119bcdfd 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -68,6 +68,7 @@
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
 #define IMA_MUST_MEASURE	4
+#define IMA_TRUSTED_VFS		5
 
 enum evm_ima_xattr_type {
 	IMA_XATTR_DIGEST = 0x01,
-- 
2.21.0.1020.gf2820cf01a-goog

