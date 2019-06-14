Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C116466E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfFNSCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:02:30 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726389AbfFNSC3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:02:29 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5164D518500C396CC8B1;
        Fri, 14 Jun 2019 19:02:28 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:02:19 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 06/14] ima: add parser of compact digest list
Date:   Fri, 14 Jun 2019 19:55:05 +0200
Message-ID: <20190614175513.27097-7-roberto.sassu@huawei.com>
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

This patch introduces the parser of the compact digest list. The format is
optimized to store a large quantity of data with the same type. It is the
only format supported by the kernel.

Digest lists can be parsed directly by the kernel like the policy or, if
they are in a different format, they can be parsed by a user space parser,
and uploaded to IMA after they have been converted to the compact list
format.

A compact list is a set of consecutive data blocks, each consisting of a
header and a payload. The header indicates the type of data, how many
elements and the length of the payload.

The COMPACT_KEY data type indicates that the payload contains keys for
verifying digest list signatures. COMPACT_PARSER is used for digests of the
parser binary and shared libraries. COMPACT_FILE is used for digests of
regular files.

The header contains also a type modifier to indicate attributes of the
elements included in the payload. The COMPACT_MOD_IMMUTABLE modifier
indicates that a file can be opened only for read, if appraisal is in
enforcing mode.

This patch also introduces ima_lookup_loaded_digest() and
ima_add_digest_data_entry() to search and add digests in the new hash table
(ima_digests_htable).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/Kconfig           |  10 ++
 security/integrity/ima/Makefile          |   1 +
 security/integrity/ima/ima_digest_list.c | 152 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_list.h |  40 ++++++
 security/integrity/integrity.h           |  12 ++
 5 files changed, 215 insertions(+)
 create mode 100644 security/integrity/ima/ima_digest_list.c
 create mode 100644 security/integrity/ima/ima_digest_list.h

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 2ced99dde694..b3a7b46d21cf 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -297,3 +297,13 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_DIGEST_LIST
+	bool "Measure and appraise files with digest lists"
+	depends on IMA
+	default n
+	help
+	   This option allows users to load digest lists. If calculated digests
+	   of accessed files are found in one of those lists, no new entries are
+	   added to the measurement list, and access to the file is granted if
+	   appraisal is in enforcing mode.
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index d921dc4f9eb0..29b49c7aacd0 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -10,4 +10,5 @@ ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 	 ima_policy.o ima_template.o ima_template_lib.o
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
+ima-$(CONFIG_IMA_DIGEST_LIST) += ima_digest_list.o
 obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
new file mode 100644
index 000000000000..6c7dd2cfbb68
--- /dev/null
+++ b/security/integrity/ima/ima_digest_list.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2019 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_digest_list.c
+ *      Functions to manage digest lists.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+
+#include "ima.h"
+#include "ima_digest_list.h"
+
+struct ima_h_table ima_digests_htable = {
+	.len = ATOMIC_LONG_INIT(0),
+	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
+};
+
+/*********************
+ * Get/add functions *
+ *********************/
+struct ima_digest *ima_lookup_digest(u8 *digest, enum hash_algo algo)
+{
+	struct ima_digest *d = NULL;
+	int digest_len = hash_digest_size[algo];
+	unsigned int key = ima_hash_key(digest);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(d, &ima_digests_htable.queue[key], hnext)
+		if (d->algo == algo && !memcmp(d->digest, digest, digest_len))
+			break;
+
+	rcu_read_unlock();
+	return d;
+}
+
+static int ima_add_digest_data_entry(u8 *digest, enum hash_algo algo,
+				     enum compact_types type, u16 modifiers)
+{
+	struct ima_digest *d;
+	int digest_len = hash_digest_size[algo];
+	unsigned int key = ima_hash_key(digest);
+
+	d = ima_lookup_digest(digest, algo);
+	if (d) {
+		d->modifiers |= modifiers;
+		return -EEXIST;
+	}
+
+	d = kmalloc(sizeof(*d) + digest_len, GFP_KERNEL);
+	if (d == NULL)
+		return -ENOMEM;
+
+	d->algo = algo;
+	d->type = type;
+	d->modifiers = modifiers;
+
+	memcpy(d->digest, digest, digest_len);
+	hlist_add_head_rcu(&d->hnext, &ima_digests_htable.queue[key]);
+	atomic_long_inc(&ima_digests_htable.len);
+	return 0;
+}
+
+/***********************
+ * Compact list parser *
+ ***********************/
+struct compact_list_hdr {
+	u8 version;
+	u8 _reserved;
+	u16 type;
+	u16 modifiers;
+	u16 algo;
+	u32 count;
+	u32 datalen;
+} __packed;
+
+int ima_parse_compact_list(loff_t size, void *buf)
+{
+	u8 *digest;
+	void *bufp = buf, *bufendp = buf + size;
+	struct compact_list_hdr *hdr;
+	size_t digest_len;
+	int ret, i;
+
+	while (bufp < bufendp) {
+		if (bufp + sizeof(*hdr) > bufendp) {
+			pr_err("compact list, invalid data\n");
+			return -EINVAL;
+		}
+
+		hdr = bufp;
+
+		if (hdr->version != 1) {
+			pr_err("compact list, unsupported version\n");
+			return -EINVAL;
+		}
+
+		if (ima_canonical_fmt) {
+			hdr->type = le16_to_cpu(hdr->type);
+			hdr->modifiers = le16_to_cpu(hdr->modifiers);
+			hdr->algo = le16_to_cpu(hdr->algo);
+			hdr->count = le32_to_cpu(hdr->count);
+			hdr->datalen = le32_to_cpu(hdr->datalen);
+		}
+
+		if (hdr->algo >= HASH_ALGO__LAST)
+			return -EINVAL;
+
+		digest_len = hash_digest_size[hdr->algo];
+
+		if (hdr->type >= COMPACT__LAST) {
+			pr_err("compact list, invalid type %d\n", hdr->type);
+			return -EINVAL;
+		}
+
+		bufp += sizeof(*hdr);
+
+		for (i = 0; i < hdr->count; i++) {
+			if (bufp + digest_len > bufendp) {
+				pr_err("compact list, invalid data\n");
+				return -EINVAL;
+			}
+
+			digest = bufp;
+			bufp += digest_len;
+
+			ret = ima_add_digest_data_entry(digest, hdr->algo,
+							hdr->type,
+							hdr->modifiers);
+			if (ret < 0 && ret != -EEXIST)
+				return ret;
+		}
+
+		if (i != hdr->count ||
+		    bufp != (void *)hdr + sizeof(*hdr) + hdr->datalen) {
+			pr_err("compact list, invalid data\n");
+			return -EINVAL;
+		}
+	}
+
+	return bufp - buf;
+}
diff --git a/security/integrity/ima/ima_digest_list.h b/security/integrity/ima/ima_digest_list.h
new file mode 100644
index 000000000000..13cdc3d954bd
--- /dev/null
+++ b/security/integrity/ima/ima_digest_list.h
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2017-2019 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation, version 2 of the
+ * License.
+ *
+ * File: ima_digest_list.h
+ *      Header of ima_digest_list.c
+ */
+
+#ifndef __LINUX_IMA_DIGEST_LIST_H
+#define __LINUX_IMA_DIGEST_LIST_H
+
+static inline bool ima_digest_is_immutable(struct ima_digest *digest)
+{
+	return (digest->modifiers & (1 << COMPACT_MOD_IMMUTABLE));
+}
+
+#ifdef CONFIG_IMA_DIGEST_LIST
+extern struct ima_h_table ima_digests_htable;
+
+struct ima_digest *ima_lookup_digest(u8 *digest, enum hash_algo algo);
+int ima_parse_compact_list(loff_t size, void *buf);
+#else
+static inline struct ima_digest *ima_lookup_digest(u8 *digest,
+						   enum hash_algo algo)
+{
+	return NULL;
+}
+static inline int ima_parse_compact_list(loff_t size, void *buf)
+{
+	return -ENOTSUPP;
+}
+#endif /*CONFIG_IMA_DIGEST_LIST*/
+#endif /*LINUX_IMA_DIGEST_LIST_H*/
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 54a7ad4f6cc0..1a9bff2e01ec 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -11,6 +11,7 @@
 #include <crypto/sha.h>
 #include <linux/key.h>
 #include <linux/audit.h>
+#include <linux/hash_info.h>
 
 /* iint action cache flags */
 #define IMA_MEASURE		0x00000001
@@ -127,6 +128,17 @@ struct integrity_iint_cache {
 	struct ima_digest_data *ima_hash;
 };
 
+enum compact_types { COMPACT_KEY, COMPACT_PARSER, COMPACT_FILE, COMPACT__LAST };
+enum compact_modifiers { COMPACT_MOD_IMMUTABLE, COMPACT_MOD__LAST };
+
+struct ima_digest {
+	struct hlist_node hnext;
+	enum hash_algo algo;
+	enum compact_types type;
+	u16 modifiers;
+	u8 digest[0];
+};
+
 /* rbtree tree calls to lookup, insert, delete
  * integrity data associated with an inode.
  */
-- 
2.17.1

