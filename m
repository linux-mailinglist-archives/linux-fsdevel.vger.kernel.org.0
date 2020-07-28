Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBD2314DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 23:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgG1VhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 17:37:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47324 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbgG1Vgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:36:31 -0400
Received: from dede-linux-virt.corp.microsoft.com (unknown [131.107.160.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7AA7020B4918;
        Tue, 28 Jul 2020 14:36:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AA7020B4918
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595972189;
        bh=TkIpD7b7YlSMtrUupwd0oewJ9IQRCyBAvTDz7hoBlic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SK9R4Y8+B6YUpsEKSIuXciK6Rew8JnbVsL27/rIlZZs6K1YoJxQmye7W/dOHPBhD+
         HN/7j6NnjHZlXP76ypvnWzaWDxlIJOnU/1ii5ok9VFruVG3tcOjdjb7lOIV4UjnEvZ
         gBo8X9rLN2dGKk7Spn+Bkh5LKpq0qhg3L31b6KwI=
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: [RFC PATCH v5 10/12] ipe: add property for dmverity roothash
Date:   Tue, 28 Jul 2020 14:36:11 -0700
Message-Id: <20200728213614.586312-12-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a property to allow IPE policy to express rules around a specific
root-hash of a dm-verity volume.

This can be used for revocation, (when combined with the previous dm-verity
property) or the authorization of a single dm-verity volume.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
---
 security/ipe/ipe-blobs.c                    |  11 ++
 security/ipe/ipe-engine.h                   |   3 +
 security/ipe/ipe.c                          |   4 +
 security/ipe/properties/Kconfig             |  13 +-
 security/ipe/properties/Makefile            |   1 +
 security/ipe/properties/dmverity-roothash.c | 153 ++++++++++++++++++++
 security/ipe/properties/prop-entry.h        |   9 ++
 7 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 security/ipe/properties/dmverity-roothash.c

diff --git a/security/ipe/ipe-blobs.c b/security/ipe/ipe-blobs.c
index 9d67b63497fc..18d5bf689c54 100644
--- a/security/ipe/ipe-blobs.c
+++ b/security/ipe/ipe-blobs.c
@@ -46,6 +46,7 @@ void ipe_bdev_free_security(struct block_device *bdev)
 	struct ipe_bdev_blob *bdev_sec = ipe_bdev(bdev);
 
 	kfree(bdev_sec->dmverity_rh_sig);
+	kfree(bdev_sec->dmverity_rh);
 
 	memset(bdev_sec, 0x0, sizeof(*bdev_sec));
 }
@@ -80,5 +81,15 @@ int ipe_bdev_setsecurity(struct block_device *bdev, const char *key,
 		return 0;
 	}
 
+	if (!strcmp(key, DM_VERITY_ROOTHASH_SEC_NAME)) {
+		bdev_sec->dmverity_rh = kmemdup(value, len, GFP_KERNEL);
+		if (!bdev_sec->dmverity_rh)
+			return -ENOMEM;
+
+		bdev_sec->rh_size = len;
+
+		return 0;
+	}
+
 	return -EOPNOTSUPP;
 }
diff --git a/security/ipe/ipe-engine.h b/security/ipe/ipe-engine.h
index 038c39a8973e..696baaa423ff 100644
--- a/security/ipe/ipe-engine.h
+++ b/security/ipe/ipe-engine.h
@@ -18,6 +18,9 @@
 struct ipe_bdev_blob {
 	u8	*dmverity_rh_sig;
 	size_t	dmv_rh_sig_len;
+
+	u8 *dmverity_rh;
+	size_t rh_size;
 };
 
 struct ipe_engine_ctx {
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index ad25ac3f2a4f..5d2535503c20 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -47,6 +47,10 @@ static int __init ipe_load_properties(void)
 	if (rc != 0)
 		return rc;
 
+	rc = ipe_init_dm_verity_rh();
+	if (rc != 0)
+		return rc;
+
 	return rc;
 }
 
diff --git a/security/ipe/properties/Kconfig b/security/ipe/properties/Kconfig
index 4046f7e5eaef..4f09092522d9 100644
--- a/security/ipe/properties/Kconfig
+++ b/security/ipe/properties/Kconfig
@@ -14,8 +14,19 @@ config IPE_BOOT_PROP
 
 	  if unsure, answer N.
 
+config IPE_DM_VERITY_ROOTHASH
+	bool "Enable property for authorizing dm-verity volumes via root-hash"
+	depends on DM_VERITY
+	help
+	  This option enables IPE's integration with Device-Mapper Verity.
+	  This enables the usage of the property "dmverity_roothash" in IPE's
+	  policy. This property allows authorization or revocation via a
+	  a hex-string representing the roothash of a dmverity volume.
+
+	  if unsure, answer Y.
+
 config IPE_DM_VERITY_SIGNATURE
-	bool "Enable property for signature verified dm-verity volumes"
+	bool "Enable property for verified dm-verity volumes"
 	depends on DM_VERITY_VERIFY_ROOTHASH_SIG
 	help
 	  This option enables IPE's integration with Device-Mapper Verity's
diff --git a/security/ipe/properties/Makefile b/security/ipe/properties/Makefile
index 6b67cbe36e31..d9a3807797f4 100644
--- a/security/ipe/properties/Makefile
+++ b/security/ipe/properties/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_SECURITY_IPE) += properties.o
 
 properties-$(CONFIG_IPE_BOOT_PROP) += boot-verified.o
 properties-$(CONFIG_IPE_DM_VERITY_SIGNATURE) += dmverity-signature.o
+properties-$(CONFIG_IPE_DM_VERITY_ROOTHASH) += dmverity-roothash.o
diff --git a/security/ipe/properties/dmverity-roothash.c b/security/ipe/properties/dmverity-roothash.c
new file mode 100644
index 000000000000..09112e1af753
--- /dev/null
+++ b/security/ipe/properties/dmverity-roothash.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Microsoft Corporation. All rights reserved.
+ */
+
+#include "../ipe.h"
+#include "../ipe-pin.h"
+#include "../ipe-property.h"
+#include "../utility.h"
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/audit.h>
+#include <linux/kernel.h>
+
+#define PROPERTY_NAME "dmverity_roothash"
+
+struct counted_array {
+	u8 *arr;
+	size_t len;
+};
+
+static void audit(struct audit_buffer *ab, const void *value)
+{
+	const struct counted_array *a = (const struct counted_array *)value;
+
+	if (!a || a->len == 0)
+		audit_log_format(ab, "NULL");
+	else
+		audit_log_n_hex(ab, a->arr, a->len);
+}
+
+static inline void audit_rule_value(struct audit_buffer *ab,
+				    const void *value)
+{
+	audit(ab, value);
+}
+
+static inline void audit_ctx(struct audit_buffer *ab,
+			     const struct ipe_engine_ctx *ctx)
+{
+	struct counted_array a;
+
+	if (!has_bdev(ctx->file))
+		return audit(ab, NULL);
+
+	a.arr = ctx->sec_bdev->dmverity_rh;
+	a.len = ctx->sec_bdev->rh_size;
+
+	return audit(ab, &a);
+}
+
+static bool evaluate(const struct ipe_engine_ctx *ctx,
+		     const void *value)
+{
+	const struct counted_array *a = (const struct counted_array *)value;
+
+	if (!has_bdev(ctx->file))
+		return false;
+
+	if (a->len != ctx->sec_bdev->rh_size)
+		return false;
+
+	return memcmp(a->arr, ctx->sec_bdev->dmverity_rh, a->len) == 0;
+}
+
+static int parse(const char *val_str, void **value)
+{
+	struct counted_array *arr = NULL;
+	int rv = 0;
+
+	arr = kzalloc(sizeof(*arr), GFP_KERNEL);
+	if (!arr) {
+		rv = -ENOMEM;
+		goto err;
+	}
+
+	arr->len = strlen(val_str) / 2;
+
+	arr->arr = kzalloc(arr->len, GFP_KERNEL);
+	if (!arr->arr) {
+		rv = -ENOMEM;
+		goto err;
+	}
+
+	rv = hex2bin(arr->arr, val_str, arr->len);
+	if (rv != 0)
+		goto err;
+
+	*value = arr;
+	return rv;
+err:
+	if (arr)
+		kfree(arr->arr);
+	kfree(arr);
+	return rv;
+}
+
+static int duplicate(const void *src, void **dest)
+{
+	struct counted_array *arr = NULL;
+	const struct counted_array *src_arr = src;
+	int rv = 0;
+
+	arr = kmemdup(src_arr, sizeof(*arr), GFP_KERNEL);
+	if (!arr) {
+		rv = -ENOMEM;
+		goto err;
+	}
+
+	arr->arr = kmemdup(src_arr->arr, src_arr->len, GFP_KERNEL);
+	if (!arr->arr) {
+		rv = -ENOMEM;
+		goto err;
+	}
+
+	*dest = arr;
+	return rv;
+err:
+	if (arr)
+		kfree(arr->arr);
+	kfree(arr);
+
+	return rv;
+}
+
+static void free_val(void **value)
+{
+	struct counted_array *a = (struct counted_array *)*value;
+
+	if (a)
+		kfree(a->arr);
+	kfree(a);
+	*value = NULL;
+}
+
+static const struct ipe_property dmv_roothash = {
+	.property_name = PROPERTY_NAME,
+	.version = 1,
+	.eval = evaluate,
+	.parse = parse,
+	.rule_audit = audit_rule_value,
+	.ctx_audit = audit_ctx,
+	.dup = duplicate,
+	.free_val = free_val,
+};
+
+int ipe_init_dm_verity_rh(void)
+{
+	return ipe_register_property(&dmv_roothash);
+}
diff --git a/security/ipe/properties/prop-entry.h b/security/ipe/properties/prop-entry.h
index 85366366ff0d..86a360570f3b 100644
--- a/security/ipe/properties/prop-entry.h
+++ b/security/ipe/properties/prop-entry.h
@@ -26,4 +26,13 @@ static inline int __init ipe_init_dm_verity_signature(void)
 int __init ipe_init_dm_verity_signature(void);
 #endif /* CONFIG_IPE_DM_VERITY_SIGNATURE */
 
+#ifndef CONFIG_IPE_DM_VERITY_ROOTHASH
+static inline int __init ipe_init_dm_verity_rh(void)
+{
+	return 0;
+}
+#else
+int __init ipe_init_dm_verity_rh(void);
+#endif /* CONFIG_IPE_DM_VERITY_ROOTHASH */
+
 #endif /* IPE_PROP_ENTRY_H */
-- 
2.27.0

