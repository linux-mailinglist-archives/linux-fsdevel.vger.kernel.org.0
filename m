Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF482237
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfHEQ2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 12:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbfHEQ2c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 12:28:32 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB60C2173B;
        Mon,  5 Aug 2019 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565022511;
        bh=WVMy2esgMxu2w5PG8N77zg75N5iEKNVcSBMie2++h2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2T54rqqg/DClyJbiF+KKLifENzePfTMiBDKGP49IB5/Re2bCykWH37VAfppmcJ1N
         EjaVjglxB7JA+HrUKvFgnNKrSLWcMIOA+qZMdLKJCdNsxLtzpGMvlmu2zgWuMeNwD+
         slinre6E/fMQXRL1/u3tlrOCnTH0L3VSMDT6XTuU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v8 02/20] fscrypt: use FSCRYPT_ prefix for uapi constants
Date:   Mon,  5 Aug 2019 09:25:03 -0700
Message-Id: <20190805162521.90882-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805162521.90882-1-ebiggers@kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Prefix all filesystem encryption UAPI constants except the ioctl numbers
with "FSCRYPT_" rather than with "FS_".  This namespaces the constants
more appropriately and makes it clear that they are related specifically
to the filesystem encryption feature, and to the 'fscrypt_*' structures.
With some of the old names like "FS_POLICY_FLAGS_VALID", it was not
immediately clear that the constant had anything to do with encryption.

This is also useful because we'll be adding more encryption-related
constants, e.g. for the policy version, and we'd otherwise have to
choose whether to use unclear names like FS_POLICY_V1 or inconsistent
names like FS_ENCRYPTION_POLICY_V1.

For source compatibility with existing userspace programs, keep the old
names defined as aliases to the new names.

Finally, as long as new names are being defined anyway, I skipped
defining new names for the fscrypt mode numbers that aren't actually
used: INVALID (0), AES_256_GCM (2), AES_256_CBC (3), SPECK128_256_XTS
(7), and SPECK128_256_CTS (8).

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/filesystems/fscrypt.rst | 40 ++++++++---------
 include/uapi/linux/fscrypt.h          | 65 +++++++++++++++++----------
 2 files changed, 62 insertions(+), 43 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 82efa41b0e6c02..d60b885c402401 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -225,9 +225,10 @@ a little endian number, except that:
   is encrypted with AES-256 where the AES-256 key is the SHA-256 hash
   of the file's data encryption key.
 
-- In the "direct key" configuration (FS_POLICY_FLAG_DIRECT_KEY set in
-  the fscrypt_policy), the file's nonce is also appended to the IV.
-  Currently this is only allowed with the Adiantum encryption mode.
+- In the "direct key" configuration (FSCRYPT_POLICY_FLAG_DIRECT_KEY
+  set in the fscrypt_policy), the file's nonce is also appended to the
+  IV.  Currently this is only allowed with the Adiantum encryption
+  mode.
 
 Filenames encryption
 --------------------
@@ -274,14 +275,14 @@ empty directory or verifies that a directory or regular file already
 has the specified encryption policy.  It takes in a pointer to a
 :c:type:`struct fscrypt_policy`, defined as follows::
 
-    #define FS_KEY_DESCRIPTOR_SIZE  8
+    #define FSCRYPT_KEY_DESCRIPTOR_SIZE  8
 
     struct fscrypt_policy {
             __u8 version;
             __u8 contents_encryption_mode;
             __u8 filenames_encryption_mode;
             __u8 flags;
-            __u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
+            __u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
     };
 
 This structure must be initialized as follows:
@@ -289,19 +290,18 @@ This structure must be initialized as follows:
 - ``version`` must be 0.
 
 - ``contents_encryption_mode`` and ``filenames_encryption_mode`` must
-  be set to constants from ``<linux/fs.h>`` which identify the
-  encryption modes to use.  If unsure, use
-  FS_ENCRYPTION_MODE_AES_256_XTS (1) for ``contents_encryption_mode``
-  and FS_ENCRYPTION_MODE_AES_256_CTS (4) for
-  ``filenames_encryption_mode``.
+  be set to constants from ``<linux/fscrypt.h>`` which identify the
+  encryption modes to use.  If unsure, use FSCRYPT_MODE_AES_256_XTS
+  (1) for ``contents_encryption_mode`` and FSCRYPT_MODE_AES_256_CTS
+  (4) for ``filenames_encryption_mode``.
 
-- ``flags`` must contain a value from ``<linux/fs.h>`` which
+- ``flags`` must contain a value from ``<linux/fscrypt.h>`` which
   identifies the amount of NUL-padding to use when encrypting
-  filenames.  If unsure, use FS_POLICY_FLAGS_PAD_32 (0x3).
-  In addition, if the chosen encryption modes are both
-  FS_ENCRYPTION_MODE_ADIANTUM, this can contain
-  FS_POLICY_FLAG_DIRECT_KEY to specify that the master key should be
-  used directly, without key derivation.
+  filenames.  If unsure, use FSCRYPT_POLICY_FLAGS_PAD_32 (0x3).  In
+  addition, if the chosen encryption modes are both
+  FSCRYPT_MODE_ADIANTUM, this can contain
+  FSCRYPT_POLICY_FLAG_DIRECT_KEY to specify that the master key should
+  be used directly, without key derivation.
 
 - ``master_key_descriptor`` specifies how to find the master key in
   the keyring; see `Adding keys`_.  It is up to userspace to choose a
@@ -401,11 +401,11 @@ followed by the 16-character lower case hex representation of the
 ``master_key_descriptor`` that was set in the encryption policy.  The
 key payload must conform to the following structure::
 
-    #define FS_MAX_KEY_SIZE 64
+    #define FSCRYPT_MAX_KEY_SIZE 64
 
     struct fscrypt_key {
             u32 mode;
-            u8 raw[FS_MAX_KEY_SIZE];
+            u8 raw[FSCRYPT_MAX_KEY_SIZE];
             u32 size;
     };
 
@@ -574,7 +574,7 @@ much confusion if an encryption policy were to be added to or removed
 from anything other than an empty directory.)  The struct is defined
 as follows::
 
-    #define FS_KEY_DESCRIPTOR_SIZE  8
+    #define FSCRYPT_KEY_DESCRIPTOR_SIZE  8
     #define FS_KEY_DERIVATION_NONCE_SIZE 16
 
     struct fscrypt_context {
@@ -582,7 +582,7 @@ as follows::
             u8 contents_encryption_mode;
             u8 filenames_encryption_mode;
             u8 flags;
-            u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
+            u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
             u8 nonce[FS_KEY_DERIVATION_NONCE_SIZE];
     };
 
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index 26f6d2c19afd3f..674b0452ef5759 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -10,35 +10,30 @@
 
 #include <linux/types.h>
 
-#define FS_KEY_DESCRIPTOR_SIZE	8
+#define FSCRYPT_KEY_DESCRIPTOR_SIZE	8
 
 /* Encryption policy flags */
-#define FS_POLICY_FLAGS_PAD_4		0x00
-#define FS_POLICY_FLAGS_PAD_8		0x01
-#define FS_POLICY_FLAGS_PAD_16		0x02
-#define FS_POLICY_FLAGS_PAD_32		0x03
-#define FS_POLICY_FLAGS_PAD_MASK	0x03
-#define FS_POLICY_FLAG_DIRECT_KEY	0x04	/* use master key directly */
-#define FS_POLICY_FLAGS_VALID		0x07
+#define FSCRYPT_POLICY_FLAGS_PAD_4		0x00
+#define FSCRYPT_POLICY_FLAGS_PAD_8		0x01
+#define FSCRYPT_POLICY_FLAGS_PAD_16		0x02
+#define FSCRYPT_POLICY_FLAGS_PAD_32		0x03
+#define FSCRYPT_POLICY_FLAGS_PAD_MASK		0x03
+#define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04	/* use master key directly */
+#define FSCRYPT_POLICY_FLAGS_VALID		0x07
 
 /* Encryption algorithms */
-#define FS_ENCRYPTION_MODE_INVALID		0
-#define FS_ENCRYPTION_MODE_AES_256_XTS		1
-#define FS_ENCRYPTION_MODE_AES_256_GCM		2
-#define FS_ENCRYPTION_MODE_AES_256_CBC		3
-#define FS_ENCRYPTION_MODE_AES_256_CTS		4
-#define FS_ENCRYPTION_MODE_AES_128_CBC		5
-#define FS_ENCRYPTION_MODE_AES_128_CTS		6
-#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
-#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
-#define FS_ENCRYPTION_MODE_ADIANTUM		9
+#define FSCRYPT_MODE_AES_256_XTS		1
+#define FSCRYPT_MODE_AES_256_CTS		4
+#define FSCRYPT_MODE_AES_128_CBC		5
+#define FSCRYPT_MODE_AES_128_CTS		6
+#define FSCRYPT_MODE_ADIANTUM			9
 
 struct fscrypt_policy {
 	__u8 version;
 	__u8 contents_encryption_mode;
 	__u8 filenames_encryption_mode;
 	__u8 flags;
-	__u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
+	__u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
 };
 
 #define FS_IOC_SET_ENCRYPTION_POLICY	_IOR('f', 19, struct fscrypt_policy)
@@ -46,16 +41,40 @@ struct fscrypt_policy {
 #define FS_IOC_GET_ENCRYPTION_POLICY	_IOW('f', 21, struct fscrypt_policy)
 
 /* Parameters for passing an encryption key into the kernel keyring */
-#define FS_KEY_DESC_PREFIX		"fscrypt:"
-#define FS_KEY_DESC_PREFIX_SIZE		8
+#define FSCRYPT_KEY_DESC_PREFIX		"fscrypt:"
+#define FSCRYPT_KEY_DESC_PREFIX_SIZE		8
 
 /* Structure that userspace passes to the kernel keyring */
-#define FS_MAX_KEY_SIZE			64
+#define FSCRYPT_MAX_KEY_SIZE			64
 
 struct fscrypt_key {
 	__u32 mode;
-	__u8 raw[FS_MAX_KEY_SIZE];
+	__u8 raw[FSCRYPT_MAX_KEY_SIZE];
 	__u32 size;
 };
+/**********************************************************************/
+
+/* old names; don't add anything new here! */
+#define FS_KEY_DESCRIPTOR_SIZE		FSCRYPT_KEY_DESCRIPTOR_SIZE
+#define FS_POLICY_FLAGS_PAD_4		FSCRYPT_POLICY_FLAGS_PAD_4
+#define FS_POLICY_FLAGS_PAD_8		FSCRYPT_POLICY_FLAGS_PAD_8
+#define FS_POLICY_FLAGS_PAD_16		FSCRYPT_POLICY_FLAGS_PAD_16
+#define FS_POLICY_FLAGS_PAD_32		FSCRYPT_POLICY_FLAGS_PAD_32
+#define FS_POLICY_FLAGS_PAD_MASK	FSCRYPT_POLICY_FLAGS_PAD_MASK
+#define FS_POLICY_FLAG_DIRECT_KEY	FSCRYPT_POLICY_FLAG_DIRECT_KEY
+#define FS_POLICY_FLAGS_VALID		FSCRYPT_POLICY_FLAGS_VALID
+#define FS_ENCRYPTION_MODE_INVALID	0	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_XTS	FSCRYPT_MODE_AES_256_XTS
+#define FS_ENCRYPTION_MODE_AES_256_GCM	2	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_CBC	3	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_CTS	FSCRYPT_MODE_AES_256_CTS
+#define FS_ENCRYPTION_MODE_AES_128_CBC	FSCRYPT_MODE_AES_128_CBC
+#define FS_ENCRYPTION_MODE_AES_128_CTS	FSCRYPT_MODE_AES_128_CTS
+#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7	/* removed */
+#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8	/* removed */
+#define FS_ENCRYPTION_MODE_ADIANTUM	FSCRYPT_MODE_ADIANTUM
+#define FS_KEY_DESC_PREFIX		FSCRYPT_KEY_DESC_PREFIX
+#define FS_KEY_DESC_PREFIX_SIZE		FSCRYPT_KEY_DESC_PREFIX_SIZE
+#define FS_MAX_KEY_SIZE			FSCRYPT_MAX_KEY_SIZE
 
 #endif /* _UAPI_LINUX_FSCRYPT_H */
-- 
2.22.0.770.g0f2c4a37fd-goog

