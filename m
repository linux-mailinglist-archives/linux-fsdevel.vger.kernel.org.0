Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3295E378B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 17:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfFFPyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 11:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729570AbfFFPyL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:54:11 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E81F208CA;
        Thu,  6 Jun 2019 15:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559836449;
        bh=+E8JvbpMyItgjXoOMjVfR5rZeKHMwYyGGqPd/PRnb40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYby1uVLMg8QuBx0R67WNSfmZnu8VojEWts2IKZ8WZPIJP0ARsfVDXPJ9tBIu1RBx
         S4KBKJqUbQu3pUOgHXADxGjBEJrPtnkSkpL0Pxq11OTCNjJFusIkRCzIPsm8GtH2Fx
         UW9dhryHN/LKKw5iNvVzEUw3QIE18wcSSUot/NtY=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v4 13/16] fs-verity: support builtin file signatures
Date:   Thu,  6 Jun 2019 08:52:02 -0700
Message-Id: <20190606155205.2872-14-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606155205.2872-1-ebiggers@kernel.org>
References: <20190606155205.2872-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

To meet some users' needs, add optional support for having fs-verity
handle a portion of the authentication policy in the kernel.  An
".fs-verity" keyring is created to which X.509 certificates can be
added; then a sysctl 'fs.verity.require_signatures' can be set to cause
the kernel to enforce that all fs-verity files contain a signature of
their file measurement by a key in this keyring.

See the "Built-in signature verification" section of
Documentation/filesystems/fsverity.rst for the full documentation.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/verity/Kconfig            |  17 +++
 fs/verity/Makefile           |   2 +
 fs/verity/enable.c           |  20 +++-
 fs/verity/fsverity_private.h |  48 +++++++-
 fs/verity/init.c             |   6 +
 fs/verity/open.c             |  25 +++--
 fs/verity/signature.c        | 207 +++++++++++++++++++++++++++++++++++
 fs/verity/verify.c           |   6 +
 8 files changed, 318 insertions(+), 13 deletions(-)
 create mode 100644 fs/verity/signature.c

diff --git a/fs/verity/Kconfig b/fs/verity/Kconfig
index c2bca0b01ecf..88fb25119899 100644
--- a/fs/verity/Kconfig
+++ b/fs/verity/Kconfig
@@ -36,3 +36,20 @@ config FS_VERITY_DEBUG
 	  Enable debugging messages related to fs-verity by default.
 
 	  Say N unless you are an fs-verity developer.
+
+config FS_VERITY_BUILTIN_SIGNATURES
+	bool "FS Verity builtin signature support"
+	depends on FS_VERITY
+	select SYSTEM_DATA_VERIFICATION
+	help
+	  Support verifying signatures of verity files against the X.509
+	  certificates that have been loaded into the ".fs-verity"
+	  kernel keyring.
+
+	  This is meant as a relatively simple mechanism that can be
+	  used to provide an authenticity guarantee for verity files, as
+	  an alternative to IMA appraisal.  Userspace programs still
+	  need to check that the verity bit is set in order to get an
+	  authenticity guarantee.
+
+	  If unsure, say N.
diff --git a/fs/verity/Makefile b/fs/verity/Makefile
index 6f7675ae0a31..570e9136334d 100644
--- a/fs/verity/Makefile
+++ b/fs/verity/Makefile
@@ -6,3 +6,5 @@ obj-$(CONFIG_FS_VERITY) += enable.o \
 			   measure.o \
 			   open.o \
 			   verify.o
+
+obj-$(CONFIG_FS_VERITY_BUILTIN_SIGNATURES) += signature.o
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 7e7ef9d3c376..ee9dd578e59f 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -147,7 +147,7 @@ static int enable_verity(struct file *filp,
 	const struct fsverity_operations *vops = inode->i_sb->s_vop;
 	struct merkle_tree_params params = { };
 	struct fsverity_descriptor *desc;
-	size_t desc_size = sizeof(*desc);
+	size_t desc_size = sizeof(*desc) + arg->sig_size;
 	struct fsverity_info *vi;
 	int err;
 
@@ -169,6 +169,16 @@ static int enable_verity(struct file *filp,
 	}
 	desc->salt_size = arg->salt_size;
 
+	/* Get the signature if the user provided one */
+	if (arg->sig_size &&
+	    copy_from_user(desc->signature,
+			   (const u8 __user *)(uintptr_t)arg->sig_ptr,
+			   arg->sig_size)) {
+		err = -EFAULT;
+		goto out;
+	}
+	desc->sig_size = cpu_to_le32(arg->sig_size);
+
 	desc->data_size = cpu_to_le64(inode->i_size);
 
 	pr_debug("Building Merkle tree...\n");
@@ -209,6 +219,10 @@ static int enable_verity(struct file *filp,
 		goto rollback;
 	}
 
+	if (arg->sig_size)
+		pr_debug("Storing a %u-byte PKCS#7 signature alongside the file\n",
+			 arg->sig_size);
+
 	/* Tell the filesystem to finish enabling verity on the file */
 	err = vops->end_enable_verity(filp, desc, desc_size, params.tree_size);
 	if (err) {
@@ -267,8 +281,8 @@ int fsverity_ioctl_enable(struct file *filp, const void __user *uarg)
 	if (arg.salt_size > FIELD_SIZEOF(struct fsverity_descriptor, salt))
 		return -EMSGSIZE;
 
-	if (arg.sig_size)
-		return -EINVAL;
+	if (arg.sig_size > FS_VERITY_MAX_SIGNATURE_SIZE)
+		return -EMSGSIZE;
 
 	/*
 	 * Require a regular file with write access.  But the actual fd must
diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
index 693ef030adbe..51a63fc8f1df 100644
--- a/fs/verity/fsverity_private.h
+++ b/fs/verity/fsverity_private.h
@@ -78,23 +78,41 @@ struct fsverity_info {
 };
 
 /*
- * Merkle tree properties.  The file measurement is the hash of this structure.
+ * Merkle tree properties.  The file measurement is the hash of this structure
+ * excluding the signature and with the sig_size field set to 0.
  */
 struct fsverity_descriptor {
 	__u8 version;		/* must be 1 */
 	__u8 hash_algorithm;	/* Merkle tree hash algorithm */
 	__u8 log_blocksize;	/* log2 of size of data and tree blocks */
 	__u8 salt_size;		/* size of salt in bytes; 0 if none */
-	__le32 sig_size;	/* reserved, must be 0 */
+	__le32 sig_size;	/* size of signature in bytes; 0 if none */
 	__le64 data_size;	/* size of file the Merkle tree is built over */
 	__u8 root_hash[64];	/* Merkle tree root hash */
 	__u8 salt[32];		/* salt prepended to each hashed block */
 	__u8 __reserved[144];	/* must be 0's */
+	__u8 signature[];	/* optional PKCS#7 signature */
 };
 
 /* Arbitrary limit to bound the kmalloc() size.  Can be changed. */
 #define FS_VERITY_MAX_DESCRIPTOR_SIZE	16384
 
+#define FS_VERITY_MAX_SIGNATURE_SIZE	(FS_VERITY_MAX_DESCRIPTOR_SIZE - \
+					 sizeof(struct fsverity_descriptor))
+
+/*
+ * Format in which verity file measurements are signed.  This is the same as
+ * 'struct fsverity_digest', except here some magic bytes are prepended to
+ * provide some context about what is being signed in case the same key is used
+ * for non-fsverity purposes, and here the fields have fixed endianness.
+ */
+struct fsverity_signed_digest {
+	char magic[8];			/* must be "FSVerity" */
+	__le16 digest_algorithm;
+	__le16 digest_size;
+	__u8 digest[];
+};
+
 /* hash_algs.c */
 
 extern struct fsverity_hash_alg fsverity_hash_algs[];
@@ -130,7 +148,7 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 				     const u8 *salt, size_t salt_size);
 
 struct fsverity_info *fsverity_create_info(const struct inode *inode,
-					   const void *desc, size_t desc_size);
+					   void *desc, size_t desc_size);
 
 void fsverity_set_info(struct inode *inode, struct fsverity_info *vi);
 
@@ -139,8 +157,32 @@ void fsverity_free_info(struct fsverity_info *vi);
 int __init fsverity_init_info_cache(void);
 void __init fsverity_exit_info_cache(void);
 
+/* signature.c */
+
+#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
+int fsverity_verify_signature(const struct fsverity_info *vi,
+			      const struct fsverity_descriptor *desc,
+			      size_t desc_size);
+
+int __init fsverity_init_signature(void);
+#else /* !CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
+static inline int
+fsverity_verify_signature(const struct fsverity_info *vi,
+			  const struct fsverity_descriptor *desc,
+			  size_t desc_size)
+{
+	return 0;
+}
+
+static inline int fsverity_init_signature(void)
+{
+	return 0;
+}
+#endif /* !CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
+
 /* verify.c */
 
 int __init fsverity_init_workqueue(void);
+void __init fsverity_exit_workqueue(void);
 
 #endif /* _FSVERITY_PRIVATE_H */
diff --git a/fs/verity/init.c b/fs/verity/init.c
index b593805aafcc..94c104e00861 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -45,9 +45,15 @@ static int __init fsverity_init(void)
 	if (err)
 		goto err_exit_info_cache;
 
+	err = fsverity_init_signature();
+	if (err)
+		goto err_exit_workqueue;
+
 	pr_debug("Initialized fs-verity\n");
 	return 0;
 
+err_exit_workqueue:
+	fsverity_exit_workqueue();
 err_exit_info_cache:
 	fsverity_exit_info_cache();
 	return err;
diff --git a/fs/verity/open.c b/fs/verity/open.c
index 731c7e810719..005ee057a997 100644
--- a/fs/verity/open.c
+++ b/fs/verity/open.c
@@ -128,12 +128,22 @@ int fsverity_init_merkle_tree_params(struct merkle_tree_params *params,
 	return err;
 }
 
-/* Compute the file measurement by hashing the fsverity_descriptor. */
+/*
+ * Compute the file measurement by hashing the fsverity_descriptor excluding the
+ * signature and with the sig_size field set to 0.
+ */
 static int compute_file_measurement(const struct fsverity_hash_alg *hash_alg,
-				    const struct fsverity_descriptor *desc,
+				    struct fsverity_descriptor *desc,
 				    u8 *measurement)
 {
-	return fsverity_hash_buffer(hash_alg, desc, sizeof(*desc), measurement);
+	__le32 sig_size = desc->sig_size;
+	int err;
+
+	desc->sig_size = 0;
+	err = fsverity_hash_buffer(hash_alg, desc, sizeof(*desc), measurement);
+	desc->sig_size = sig_size;
+
+	return err;
 }
 
 /*
@@ -141,9 +151,9 @@ static int compute_file_measurement(const struct fsverity_hash_alg *hash_alg,
  * it.  The signature (if present) is also checked.
  */
 struct fsverity_info *fsverity_create_info(const struct inode *inode,
-					   const void *_desc, size_t desc_size)
+					   void *_desc, size_t desc_size)
 {
-	const struct fsverity_descriptor *desc = _desc;
+	struct fsverity_descriptor *desc = _desc;
 	struct fsverity_info *vi;
 	int err;
 
@@ -159,8 +169,7 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (desc->sig_size ||
-	    memchr_inv(desc->__reserved, 0, sizeof(desc->__reserved))) {
+	if (memchr_inv(desc->__reserved, 0, sizeof(desc->__reserved))) {
 		fsverity_err(inode, "Reserved bits set in descriptor");
 		return ERR_PTR(-EINVAL);
 	}
@@ -205,6 +214,8 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
 	pr_debug("Computed file measurement: %s:%*phN\n",
 		 vi->tree_params.hash_alg->name,
 		 vi->tree_params.digest_size, vi->measurement);
+
+	err = fsverity_verify_signature(vi, desc, desc_size);
 out:
 	if (err) {
 		fsverity_free_info(vi);
diff --git a/fs/verity/signature.c b/fs/verity/signature.c
new file mode 100644
index 000000000000..b8e7b7ad6974
--- /dev/null
+++ b/fs/verity/signature.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs/verity/signature.c: verification of builtin signatures
+ *
+ * Copyright 2019 Google LLC
+ */
+
+#include "fsverity_private.h"
+
+#include <linux/cred.h>
+#include <linux/key.h>
+#include <linux/verification.h>
+
+/*
+ * /proc/sys/fs/verity/require_signatures
+ * If 1, all verity files must have a valid builtin signature.
+ */
+static int fsverity_require_signatures;
+
+/*
+ * Keyring that contains the trusted X.509 certificates.
+ *
+ * Only root (kuid=0) can modify this.  Also, root may use
+ * keyctl_restrict_keyring() to prevent any more additions.
+ */
+static struct key *fsverity_keyring;
+
+struct verify_arg {
+	const struct fsverity_info *vi;
+	u8 measurement[FS_VERITY_MAX_DIGEST_SIZE];
+	bool have_measurement;
+};
+
+static int extract_measurement(void *ctx, const void *data, size_t len,
+			       size_t asn1hdrlen)
+{
+	struct verify_arg *arg = ctx;
+	const struct fsverity_info *vi = arg->vi;
+	const struct inode *inode = vi->inode;
+	const struct fsverity_signed_digest *d = data;
+	const struct fsverity_hash_alg *hash_alg;
+
+	if (len < sizeof(*d) || memcmp(d->magic, "FSVerity", 8) != 0) {
+		fsverity_warn(inode,
+			      "Signed file measurement uses unrecognized format");
+		return -EBADMSG;
+	}
+
+	hash_alg = fsverity_get_hash_alg(inode,
+					 le16_to_cpu(d->digest_algorithm));
+	if (IS_ERR(hash_alg))
+		return PTR_ERR(hash_alg);
+
+	if (le16_to_cpu(d->digest_size) != hash_alg->digest_size) {
+		fsverity_warn(inode,
+			      "Wrong digest_size in signed file measurement: wanted %u for algorithm %s, but got %u",
+			      hash_alg->digest_size, hash_alg->name,
+			      le16_to_cpu(d->digest_size));
+		return -EBADMSG;
+	}
+
+	if (len < sizeof(*d) + hash_alg->digest_size) {
+		fsverity_warn(inode, "Signed file measurement is truncated");
+		return -EBADMSG;
+	}
+
+	if (hash_alg != vi->tree_params.hash_alg) {
+		fsverity_warn(inode,
+			      "Signed file measurement uses %s, but file uses %s",
+			      hash_alg->name, vi->tree_params.hash_alg->name);
+		return -EBADMSG;
+	}
+
+	memcpy(arg->measurement, d->digest, hash_alg->digest_size);
+	arg->have_measurement = true;
+	return 0;
+}
+
+/**
+ * fsverity_verify_signature - check a verity file's signature
+ *
+ * Verify a signed fsverity_measurement against the certificates in the
+ * fs-verity keyring.  The signature is given as a PKCS#7 formatted message, and
+ * the signed data is included in the message (not detached).
+ *
+ * Return: 0 on success (signature valid or not required); -errno on failure
+ */
+int fsverity_verify_signature(const struct fsverity_info *vi,
+			      const struct fsverity_descriptor *desc,
+			      size_t desc_size)
+{
+	const struct inode *inode = vi->inode;
+	const struct fsverity_hash_alg *hash_alg = vi->tree_params.hash_alg;
+	const unsigned int digest_size = hash_alg->digest_size;
+	const u32 sig_size = le32_to_cpu(desc->sig_size);
+	struct verify_arg arg = {
+		.vi = vi,
+		.have_measurement = false,
+	};
+	int err;
+
+	if (sig_size == 0) {
+		if (fsverity_require_signatures) {
+			fsverity_err(inode,
+				     "require_signatures=1, rejecting unsigned file!");
+			return -EBADMSG;
+		}
+		return 0;
+	}
+
+	if (sig_size > desc_size - sizeof(*desc)) {
+		fsverity_err(inode, "Signature overflows verity descriptor");
+		return -EBADMSG;
+	}
+
+	err = verify_pkcs7_signature(NULL, 0, desc->signature, sig_size,
+				     fsverity_keyring,
+				     VERIFYING_UNSPECIFIED_SIGNATURE,
+				     extract_measurement, &arg);
+	if (err) {
+		fsverity_err(inode, "Error %d verifying PKCS#7 signature", err);
+		return err;
+	}
+
+	if (!arg.have_measurement) {
+		fsverity_err(inode, "PKCS#7 message is missing internal data");
+		return -EBADMSG;
+	}
+
+	if (memcmp(arg.measurement, vi->measurement, digest_size) != 0) {
+		fsverity_err(inode,
+			     "FILE CORRUPTED (signed measurement differs from actual measurement): signed %s:%*phN, actual %s:%*phN",
+			     hash_alg->name, digest_size, arg.measurement,
+			     hash_alg->name, digest_size, vi->measurement);
+		return -EBADMSG;
+	}
+
+	pr_debug("Valid signature for measurement: %s:%*phN\n",
+		 hash_alg->name, digest_size, vi->measurement);
+	return 0;
+}
+
+#ifdef CONFIG_SYSCTL
+static int zero;
+static int one = 1;
+static struct ctl_table_header *fsverity_sysctl_header;
+
+static const struct ctl_path fsverity_sysctl_path[] = {
+	{ .procname = "fs", },
+	{ .procname = "verity", },
+	{ }
+};
+
+static struct ctl_table fsverity_sysctl_table[] = {
+	{
+		.procname       = "require_signatures",
+		.data           = &fsverity_require_signatures,
+		.maxlen         = sizeof(int),
+		.mode           = 0644,
+		.proc_handler   = proc_dointvec_minmax,
+		.extra1         = &zero,
+		.extra2         = &one,
+	},
+	{ }
+};
+
+static int __init fsverity_sysctl_init(void)
+{
+	fsverity_sysctl_header = register_sysctl_paths(fsverity_sysctl_path,
+						       fsverity_sysctl_table);
+	if (!fsverity_sysctl_header) {
+		pr_err("sysctl registration failed!\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+#else /* !CONFIG_SYSCTL */
+static inline int fsverity_sysctl_init(void)
+{
+	return 0;
+}
+#endif /* !CONFIG_SYSCTL */
+
+int __init fsverity_init_signature(void)
+{
+	struct key *ring;
+	int err;
+
+	ring = keyring_alloc(".fs-verity", KUIDT_INIT(0), KGIDT_INIT(0),
+			     current_cred(), KEY_POS_SEARCH |
+				KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE |
+				KEY_USR_SEARCH | KEY_USR_SETATTR,
+			     KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
+	if (IS_ERR(ring))
+		return PTR_ERR(ring);
+
+	err = fsverity_sysctl_init();
+	if (err)
+		goto err_put_ring;
+
+	fsverity_keyring = ring;
+	return 0;
+
+err_put_ring:
+	key_put(ring);
+	return err;
+}
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 2a0f9e2ebc9f..783f4042b679 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -273,3 +273,9 @@ int __init fsverity_init_workqueue(void)
 		return -ENOMEM;
 	return 0;
 }
+
+void __init fsverity_exit_workqueue(void)
+{
+	destroy_workqueue(fsverity_read_workqueue);
+	fsverity_read_workqueue = NULL;
+}
-- 
2.21.0

