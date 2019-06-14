Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2846700
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfFNSEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:04:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFNSEq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:04:46 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 73E668B10894AC780E1D;
        Fri, 14 Jun 2019 19:04:45 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:04:34 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 10/14] ima: load parser digests and execute the parser at boot time
Date:   Fri, 14 Jun 2019 19:55:09 +0200
Message-ID: <20190614175513.27097-11-roberto.sassu@huawei.com>
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

Digest lists should be uploaded to IMA as soon as possible, otherwise file
digests would appear in the measurement list or access would be denied if
appraisal is in enforcing mode.

This patch adds a call to ima_load_parser_digest_list() in
integrity_load_keys(), so that the function is executed when rootfs becomes
available, before the init process is executed.

ima_load_parser_digest_list() loads a compact list containing the digests
of the parser and the shared libraries. This list is measured and
appraised depending on the current IMA policy. Then, the function executes
the parser executable with the User-Mode-Helper (UMH).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/iint.c                |  1 +
 security/integrity/ima/Kconfig           | 15 +++++++++
 security/integrity/ima/ima_digest_list.c | 42 ++++++++++++++++++++++++
 security/integrity/integrity.h           |  8 +++++
 4 files changed, 66 insertions(+)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index e12c4900510f..de73baccc847 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -213,6 +213,7 @@ void __init integrity_load_keys(void)
 {
 	ima_load_x509();
 	evm_load_x509();
+	ima_load_parser_digest_list();
 }
 
 static int __init integrity_fs_init(void)
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index b3a7b46d21cf..c1bb9fedeccc 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -307,3 +307,18 @@ config IMA_DIGEST_LIST
 	   of accessed files are found in one of those lists, no new entries are
 	   added to the measurement list, and access to the file is granted if
 	   appraisal is in enforcing mode.
+
+config IMA_PARSER_DIGEST_LIST_PATH
+	string "Path of the parser digest list"
+	depends on IMA_DIGEST_LIST
+	default "/etc/ima/digest_lists/compact-upload_digest_lists"
+	help
+	   This option defines the path of the digest list containing the
+	   digest of the parser.
+
+config IMA_PARSER_BINARY_PATH
+	string "Path of the parser binary"
+	depends on IMA_DIGEST_LIST
+	default "/usr/bin/upload_digest_lists"
+	help
+	   This option defines the path of the parser binary.
diff --git a/security/integrity/ima/ima_digest_list.c b/security/integrity/ima/ima_digest_list.c
index 3aaa26d6e8e3..532aaf5145ae 100644
--- a/security/integrity/ima/ima_digest_list.c
+++ b/security/integrity/ima/ima_digest_list.c
@@ -240,3 +240,45 @@ struct ima_digest *ima_digest_allow(struct ima_digest *digest, int action)
 
 	return digest;
 }
+
+/********************
+ * Parser execution *
+ ********************/
+static void ima_exec_parser(void)
+{
+	char *argv[2] = {NULL}, *envp[1] = {NULL};
+
+	argv[0] = (char *)CONFIG_IMA_PARSER_BINARY_PATH;
+	call_usermodehelper(argv[0], argv, envp, UMH_WAIT_PROC);
+}
+
+void __init ima_load_parser_digest_list(void)
+{
+	void *datap;
+	loff_t size;
+	int ret;
+
+	if (!(ima_digest_list_actions & ima_policy_flag))
+		return;
+
+	ima_set_parser(current);
+	ret = kernel_read_file_from_path(CONFIG_IMA_PARSER_DIGEST_LIST_PATH,
+					 &datap, &size, 0, READING_DIGEST_LIST);
+	ima_set_parser(NULL);
+
+	if (ret < 0) {
+		if (ret != -ENOENT)
+			pr_err("Unable to open file: %s (%d)",
+			       CONFIG_IMA_PARSER_DIGEST_LIST_PATH, ret);
+		return;
+	}
+
+	ret = ima_parse_compact_list(size, datap);
+
+	vfree(datap);
+
+	if (ret < 0)
+		return;
+
+	ima_exec_parser();
+}
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 1a9bff2e01ec..8c4cf5127a8b 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -213,6 +213,14 @@ static inline void evm_load_x509(void)
 }
 #endif
 
+#ifdef CONFIG_IMA_DIGEST_LIST
+void __init ima_load_parser_digest_list(void);
+#else
+static inline void ima_load_parser_digest_list(void)
+{
+}
+#endif
+
 #ifdef CONFIG_INTEGRITY_AUDIT
 /* declarations */
 void integrity_audit_msg(int audit_msgno, struct inode *inode,
-- 
2.17.1

