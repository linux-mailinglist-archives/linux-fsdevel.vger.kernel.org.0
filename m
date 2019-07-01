Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD8265C2CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfGASUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 14:20:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42232 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfGASUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:20:20 -0400
Received: from jaskaran-Intel-Server-Board-S1200V3RPS-UEFI-Development-Kit.corp.microsoft.com (unknown [131.107.160.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4A09C205CFD5;
        Mon,  1 Jul 2019 11:20:18 -0700 (PDT)
From:   Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
To:     gmazyland@gmail.com, ebiggers@google.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mdsakib@microsoft.com, mpatocka@redhat.com
Subject: [RFC PATCH v6 1/1] Add dm verity root hash pkcs7 sig validation.
Date:   Mon,  1 Jul 2019 11:19:58 -0700
Message-Id: <20190701181958.6493-2-jaskarankhurana@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701181958.6493-1-jaskarankhurana@linux.microsoft.com>
References: <20190701181958.6493-1-jaskarankhurana@linux.microsoft.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The verification is to support cases where the roothash is not secured by
Trusted Boot, UEFI Secureboot or similar technologies.
One of the use cases for this is for dm-verity volumes mounted after boot,
the root hash provided during the creation of the dm-verity volume has to
be secure and thus in-kernel validation implemented here will be used
before we trust the root hash and allow the block device to be created.

The signature being provided for verification must verify the root hash and
must be trusted by the builtin keyring for verification to succeed.

The hash is added as a key of type "user" and the description is passed to the
kernel so it can look it up and use it for verification.

Adds CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG which can be turned on if root hash
verification is needed.

Kernel commandline parameter require_signatures will indicate whether to force
(for all dm verity volumes) roothash signature verification.

Signed-off-by: Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
---
 Documentation/device-mapper/verity.txt |   7 ++
 drivers/md/Kconfig                     |  12 +++
 drivers/md/Makefile                    |   5 +
 drivers/md/dm-verity-target.c          |  43 +++++++-
 drivers/md/dm-verity-verify-sig.c      | 133 +++++++++++++++++++++++++
 drivers/md/dm-verity-verify-sig.h      |  60 +++++++++++
 drivers/md/dm-verity.h                 |   2 +
 7 files changed, 257 insertions(+), 5 deletions(-)
 create mode 100644 drivers/md/dm-verity-verify-sig.c
 create mode 100644 drivers/md/dm-verity-verify-sig.h

diff --git a/Documentation/device-mapper/verity.txt b/Documentation/device-mapper/verity.txt
index b3d2e4a42255..df7ef1d553cc 100644
--- a/Documentation/device-mapper/verity.txt
+++ b/Documentation/device-mapper/verity.txt
@@ -121,6 +121,13 @@ check_at_most_once
     blocks, and a hash block will not be verified any more after all the data
     blocks it covers have been verified anyway.
 
+root_hash_sig_key_desc <key_description>
+    This is the description of the USER_KEY that the kernel will lookup to get
+    the pkcs7 signature of the roothash. The pkcs7 signature is used to validate
+    the root hash during the creation of the device mapper block device.
+    Verification of roothash depends on the config DM_VERITY_VERIFY_ROOTHASH_SIG
+    being set in the kernel.
+
 Theory of operation
 ===================
 
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index db269a348b20..9d0bc609582c 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -489,6 +489,18 @@ config DM_VERITY
 
 	  If unsure, say N.
 
+config DM_VERITY_VERIFY_ROOTHASH_SIG
+	def_bool n
+	bool "Verity data device root hash signature verification support"
+	depends on DM_VERITY
+	select SYSTEM_DATA_VERIFICATION
+	  help
+	  The device mapper target created by DM-VERITY can be validated if the
+	  pre-generated tree of cryptographic checksums passed has a pkcs#7
+	  signature file that can validate the roothash of the tree.
+
+	  If unsure, say N.
+
 config DM_VERITY_FEC
 	bool "Verity forward error correction support"
 	depends on DM_VERITY
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index be7a6eb92abc..fe756c0dca14 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -81,3 +81,8 @@ endif
 ifeq ($(CONFIG_DM_VERITY_FEC),y)
 dm-verity-objs			+= dm-verity-fec.o
 endif
+
+ifeq ($(CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG),y)
+dm-verity-objs			+= dm-verity-verify-sig.o
+endif
+
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index f4c31ffaa88e..3dc7f6dcc337 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -16,7 +16,7 @@
 
 #include "dm-verity.h"
 #include "dm-verity-fec.h"
-
+#include "dm-verity-verify-sig.h"
 #include <linux/module.h>
 #include <linux/reboot.h>
 
@@ -34,7 +34,8 @@
 #define DM_VERITY_OPT_IGN_ZEROES	"ignore_zero_blocks"
 #define DM_VERITY_OPT_AT_MOST_ONCE	"check_at_most_once"
 
-#define DM_VERITY_OPTS_MAX		(2 + DM_VERITY_OPTS_FEC)
+#define DM_VERITY_OPTS_MAX		(2 + DM_VERITY_OPTS_FEC + \
+					 DM_VERITY_ROOT_HASH_VERIFICATION_OPTS)
 
 static unsigned dm_verity_prefetch_cluster = DM_VERITY_DEFAULT_PREFETCH_SIZE;
 
@@ -714,6 +715,8 @@ static void verity_status(struct dm_target *ti, status_type_t type,
 			args++;
 		if (v->validated_blocks)
 			args++;
+		if (v->signature_key_desc)
+			args += DM_VERITY_ROOT_HASH_VERIFICATION_OPTS;
 		if (!args)
 			return;
 		DMEMIT(" %u", args);
@@ -735,6 +738,9 @@ static void verity_status(struct dm_target *ti, status_type_t type,
 		if (v->validated_blocks)
 			DMEMIT(" " DM_VERITY_OPT_AT_MOST_ONCE);
 		sz = verity_fec_status_table(v, sz, result, maxlen);
+		if (v->signature_key_desc)
+			DMEMIT(" " DM_VERITY_ROOT_HASH_VERIFICATION_OPT_SIG_KEY
+				" %s", v->signature_key_desc);
 		break;
 	}
 }
@@ -800,6 +806,8 @@ static void verity_dtr(struct dm_target *ti)
 
 	verity_fec_dtr(v);
 
+	kfree(v->signature_key_desc);
+
 	kfree(v);
 }
 
@@ -855,7 +863,8 @@ static int verity_alloc_zero_digest(struct dm_verity *v)
 	return r;
 }
 
-static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v)
+static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
+				 struct dm_verity_sig_opts *verify_args)
 {
 	int r;
 	unsigned argc;
@@ -904,6 +913,14 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v)
 			if (r)
 				return r;
 			continue;
+		} else if (verity_verify_is_sig_opt_arg(arg_name)) {
+			r = verity_verify_sig_parse_opt_args(as, v,
+							     verify_args,
+							     &argc, arg_name);
+			if (r)
+				return r;
+			continue;
+
 		}
 
 		ti->error = "Unrecognized verity feature request";
@@ -930,6 +947,7 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v)
 static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 {
 	struct dm_verity *v;
+	struct dm_verity_sig_opts verify_args = {0};
 	struct dm_arg_set as;
 	unsigned int num;
 	unsigned long long num_ll;
@@ -937,6 +955,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	int i;
 	sector_t hash_position;
 	char dummy;
+	char *root_hash_digest_to_validate;
 
 	v = kzalloc(sizeof(struct dm_verity), GFP_KERNEL);
 	if (!v) {
@@ -1070,6 +1089,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		r = -EINVAL;
 		goto bad;
 	}
+	root_hash_digest_to_validate = argv[8];
 
 	if (strcmp(argv[9], "-")) {
 		v->salt_size = strlen(argv[9]) / 2;
@@ -1095,11 +1115,20 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 		as.argc = argc;
 		as.argv = argv;
 
-		r = verity_parse_opt_args(&as, v);
+		r = verity_parse_opt_args(&as, v, &verify_args);
 		if (r < 0)
 			goto bad;
 	}
 
+	/* Root hash signature is  a optional parameter*/
+	r = verity_verify_root_hash(root_hash_digest_to_validate,
+				    strlen(root_hash_digest_to_validate),
+				    verify_args.sig,
+				    verify_args.sig_size);
+	if (r < 0) {
+		ti->error = "Root hash verification failed";
+		goto bad;
+	}
 	v->hash_per_block_bits =
 		__fls((1 << v->hash_dev_block_bits) / v->digest_size);
 
@@ -1165,9 +1194,13 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 	ti->per_io_data_size = roundup(ti->per_io_data_size,
 				       __alignof__(struct dm_verity_io));
 
+	verity_verify_sig_opts_cleanup(&verify_args);
+
 	return 0;
 
 bad:
+
+	verity_verify_sig_opts_cleanup(&verify_args);
 	verity_dtr(ti);
 
 	return r;
@@ -1175,7 +1208,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 
 static struct target_type verity_target = {
 	.name		= "verity",
-	.version	= {1, 4, 0},
+	.version	= {1, 5, 0},
 	.module		= THIS_MODULE,
 	.ctr		= verity_ctr,
 	.dtr		= verity_dtr,
diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-verify-sig.c
new file mode 100644
index 000000000000..614e43db93aa
--- /dev/null
+++ b/drivers/md/dm-verity-verify-sig.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Microsoft Corporation.
+ *
+ * Author:  Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
+ *
+ */
+#include <linux/device-mapper.h>
+#include <linux/verification.h>
+#include <keys/user-type.h>
+#include <linux/module.h>
+#include "dm-verity.h"
+#include "dm-verity-verify-sig.h"
+
+#define DM_VERITY_VERIFY_ERR(s) DM_VERITY_ROOT_HASH_VERIFICATION " " s
+
+static bool require_signatures;
+module_param(require_signatures, bool, false);
+MODULE_PARM_DESC(require_signatures,
+		"Verify the roothash of dm-verity hash tree");
+
+#define DM_VERITY_IS_SIG_FORCE_ENABLED() \
+	(require_signatures != false)
+
+bool verity_verify_is_sig_opt_arg(const char *arg_name)
+{
+	return (!strcasecmp(arg_name,
+			    DM_VERITY_ROOT_HASH_VERIFICATION_OPT_SIG_KEY));
+}
+
+static int verity_verify_get_sig_from_key(const char *key_desc,
+					struct dm_verity_sig_opts *sig_opts)
+{
+	struct key *key;
+	const struct user_key_payload *ukp;
+	int ret = 0;
+
+	key = request_key(&key_type_user,
+			key_desc, NULL);
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	down_read(&key->sem);
+
+	ukp = user_key_payload_locked(key);
+	if (!ukp) {
+		ret = -EKEYREVOKED;
+		goto end;
+	}
+
+	sig_opts->sig = kmalloc(ukp->datalen, GFP_KERNEL);
+	if (!sig_opts->sig) {
+		ret = -ENOMEM;
+		goto end;
+	}
+	sig_opts->sig_size = ukp->datalen;
+
+	memcpy(sig_opts->sig, ukp->data, sig_opts->sig_size);
+
+end:
+	up_read(&key->sem);
+	key_put(key);
+
+	return ret;
+}
+
+int verity_verify_sig_parse_opt_args(struct dm_arg_set *as,
+				     struct dm_verity *v,
+				     struct dm_verity_sig_opts *sig_opts,
+				     unsigned int *argc,
+				     const char *arg_name)
+{
+	struct dm_target *ti = v->ti;
+	int ret = 0;
+	const char *sig_key = NULL;
+
+	if (!*argc) {
+		ti->error = DM_VERITY_VERIFY_ERR("Signature key not specified");
+		return -EINVAL;
+	}
+
+	sig_key = dm_shift_arg(as);
+	(*argc)--;
+
+	ret = verity_verify_get_sig_from_key(sig_key, sig_opts);
+	if (ret < 0)
+		ti->error = DM_VERITY_VERIFY_ERR("Invalid key specified");
+
+	v->signature_key_desc = kstrdup(sig_key, GFP_KERNEL);
+	if (!v->signature_key_desc)
+		return -ENOMEM;
+
+	return ret;
+}
+
+/*
+ * verify_verify_roothash - Verify the root hash of the verity hash device
+ *			     using builtin trusted keys.
+ *
+ * @root_hash: For verity, the roothash/data to be verified.
+ * @root_hash_len: Size of the roothash/data to be verified.
+ * @sig_data: The trusted signature that verifies the roothash/data.
+ * @sig_len: Size of the signature.
+ *
+ */
+int verity_verify_root_hash(const void *root_hash, size_t root_hash_len,
+			    const void *sig_data, size_t sig_len)
+{
+	int ret;
+
+	if (!root_hash || root_hash_len == 0)
+		return -EINVAL;
+
+	if (!sig_data  || sig_len == 0) {
+		if (DM_VERITY_IS_SIG_FORCE_ENABLED())
+			return -ENOKEY;
+		else
+			return 0;
+	}
+
+	ret = verify_pkcs7_signature(root_hash, root_hash_len, sig_data,
+				sig_len, NULL, VERIFYING_UNSPECIFIED_SIGNATURE,
+				NULL, NULL);
+
+	return ret;
+}
+
+void verity_verify_sig_opts_cleanup(struct dm_verity_sig_opts *sig_opts)
+{
+	kfree(sig_opts->sig);
+	sig_opts->sig = NULL;
+	sig_opts->sig_size = 0;
+}
diff --git a/drivers/md/dm-verity-verify-sig.h b/drivers/md/dm-verity-verify-sig.h
new file mode 100644
index 000000000000..19b1547aa741
--- /dev/null
+++ b/drivers/md/dm-verity-verify-sig.h
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Microsoft Corporation.
+ *
+ * Author:  Jaskaran Singh Khurana <jaskarankhurana@linux.microsoft.com>
+ *
+ */
+#ifndef DM_VERITY_SIG_VERIFICATION_H
+#define DM_VERITY_SIG_VERIFICATION_H
+
+#define DM_VERITY_ROOT_HASH_VERIFICATION "DM Verity Sig Verification"
+#define DM_VERITY_ROOT_HASH_VERIFICATION_OPT_SIG_KEY "root_hash_sig_key_desc"
+
+struct dm_verity_sig_opts {
+	unsigned int sig_size;
+	u8 *sig;
+};
+
+#ifdef CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG
+
+#define DM_VERITY_ROOT_HASH_VERIFICATION_OPTS 2
+
+int verity_verify_root_hash(const void *data, size_t data_len,
+			    const void *sig_data, size_t sig_len);
+bool verity_verify_is_sig_opt_arg(const char *arg_name);
+
+int verity_verify_sig_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
+				    struct dm_verity_sig_opts *sig_opts,
+				    unsigned int *argc, const char *arg_name);
+
+void verity_verify_sig_opts_cleanup(struct dm_verity_sig_opts *sig_opts);
+
+#else
+
+#define DM_VERITY_ROOT_HASH_VERIFICATION_OPTS 0
+
+int verity_verify_root_hash(const void *data, size_t data_len,
+			    const void *sig_data, size_t sig_len)
+{
+	return 0;
+}
+
+bool verity_verify_is_sig_opt_arg(const char *arg_name)
+{
+	return false;
+}
+
+int verity_verify_sig_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
+				    struct dm_verity_sig_opts *sig_opts,
+				    unsigned int *argc, const char *arg_name)
+{
+	return -EINVAL;
+}
+
+void verity_verify_sig_opts_cleanup(struct dm_verity_sig_opts *sig_opts)
+{
+}
+
+#endif /* CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG */
+#endif /* DM_VERITY_SIG_VERIFICATION_H */
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 3441c10b840c..42183a3903ae 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -64,6 +64,8 @@ struct dm_verity {
 
 	struct dm_verity_fec *fec;	/* forward error correction */
 	unsigned long *validated_blocks; /* bitset blocks validated */
+
+	char *signature_key_desc; /* signature keyring reference */
 };
 
 struct dm_verity_io {
-- 
2.17.1

