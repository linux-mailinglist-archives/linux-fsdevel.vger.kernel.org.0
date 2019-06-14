Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97045466EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfFNSDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:03:00 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33015 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726835AbfFNSDA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:03:00 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id B66DC9C8D42CB2B4B75C;
        Fri, 14 Jun 2019 19:02:58 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:02:49 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 07/14] ima: restrict upload of converted digest lists
Date:   Fri, 14 Jun 2019 19:55:06 +0200
Message-ID: <20190614175513.27097-8-roberto.sassu@huawei.com>
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

If digest lists cannot be directly parsed by the kernel, access to the
securityfs file must be exclusively granted to the parser, to avoid that an
arbitrary process makes undesired modifications before uploading converted
lists to IMA. Digest lists are measured before they are converted and no
new measurement is taken after conversion.

This patch introduces ima_check_set_parser(), to verify whether the process
opening the interface to upload digest lists is the user space parser. It
checks whether the digest of the executable is found in a digest list and
if the type of found digest is COMPACT_PARSER.

It also introduces ima_set_parser() and ima_get_parser() to return the
task_struct of the process that opened digest_list_data. This will be used
to determine whether digest lists have been measured/appraised and, if not,
to prevent their usage.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_digest_list.c | 54 ++++++++++++++++++++++++
 security/integrity/ima/ima_digest_list.h | 14 ++++++
 2 files changed, 68 insertions(+)

diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
index 6c7dd2cfbb68..3c77a6cec29a 100644
--- a/security/integrity/ima/ima_digest_list.c
+++ b/security/integrity/ima/ima_digest_list.c
@@ -17,6 +17,8 @@
 
 #include <linux/vmalloc.h>
 #include <linux/module.h>
+#include <linux/file.h>
+#include <linux/sched/mm.h>
 
 #include "ima.h"
 #include "ima_digest_list.h"
@@ -150,3 +152,55 @@ int ima_parse_compact_list(loff_t size, void *buf)
 
 	return bufp - buf;
 }
+
+/****************
+ * Parser check *
+ ****************/
+bool ima_check_current_is_parser(void)
+{
+	struct integrity_iint_cache *parser_iint;
+	struct ima_digest *parser_digest = NULL;
+	struct file *parser_file;
+	struct mm_struct *mm;
+
+	mm = get_task_mm(current);
+	if (!mm)
+		return false;
+
+	parser_file = get_mm_exe_file(mm);
+	mmput(mm);
+
+	if (!parser_file)
+		return false;
+
+	parser_iint = integrity_iint_find(file_inode(parser_file));
+	fput(parser_file);
+
+	if (!parser_iint)
+		return false;
+
+	/* flag cannot be cleared due to write protection of executables */
+	if (!(parser_iint->flags & IMA_COLLECTED))
+		return false;
+
+	parser_digest = ima_lookup_digest(parser_iint->ima_hash->digest,
+					  parser_iint->ima_hash->algo);
+
+	return (parser_digest && parser_digest->type == COMPACT_PARSER);
+}
+
+/*
+ * Current parser set and reset respectively during open() and close() of
+ * /sys/kernel/security/ima/digest_list_data.
+ */
+static struct task_struct *current_parser;
+
+void ima_set_parser(struct task_struct *parser)
+{
+	current_parser = parser;
+}
+
+struct task_struct *ima_get_parser(void)
+{
+	return current_parser;
+}
diff --git a/security/integrity/ima/ima_digest_list.h b/security/integrity/ima/ima_digest_list.h
index 13cdc3d954bd..be07a4afd7b6 100644
--- a/security/integrity/ima/ima_digest_list.h
+++ b/security/integrity/ima/ima_digest_list.h
@@ -26,6 +26,9 @@ extern struct ima_h_table ima_digests_htable;
 
 struct ima_digest *ima_lookup_digest(u8 *digest, enum hash_algo algo);
 int ima_parse_compact_list(loff_t size, void *buf);
+bool ima_check_current_is_parser(void);
+void ima_set_parser(struct task_struct *parser);
+struct task_struct *ima_get_parser(void);
 #else
 static inline struct ima_digest *ima_lookup_digest(u8 *digest,
 						   enum hash_algo algo)
@@ -36,5 +39,16 @@ static inline int ima_parse_compact_list(loff_t size, void *buf)
 {
 	return -ENOTSUPP;
 }
+static inline bool ima_check_current_is_parser(void)
+{
+	return false;
+}
+static inline void ima_set_parser(struct task_struct *parser)
+{
+}
+static inline struct task_struct *ima_get_parser(void)
+{
+	return NULL;
+}
 #endif /*CONFIG_IMA_DIGEST_LIST*/
 #endif /*LINUX_IMA_DIGEST_LIST_H*/
-- 
2.17.1

