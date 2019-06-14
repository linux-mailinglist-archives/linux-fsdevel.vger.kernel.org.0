Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAE6C466BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfFNSAN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:00:13 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbfFNSAN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:00:13 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 93CCD93FF28E5468F8ED;
        Fri, 14 Jun 2019 19:00:11 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:00:04 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 02/14] ima: generalize ima_read_policy()
Date:   Fri, 14 Jun 2019 19:55:01 +0200
Message-ID: <20190614175513.27097-3-roberto.sassu@huawei.com>
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

Rename ima_read_policy() to ima_read_file(), and add file_id as a new
parameter. If file_id is equal to READING_POLICY, ima_read_file() behavior
remains unchanged. If file_id will be READING_DIGEST_LIST (not yet
defined), ima_read_file() will read and parse a digest list from a file
whose path is written to securityfs.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2000e8df0301..02980b55a3f1 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -272,7 +272,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
-static ssize_t ima_read_policy(char *path)
+static ssize_t ima_read_file(char *path, enum kernel_read_file_id file_id)
 {
 	void *data;
 	char *datap;
@@ -285,16 +285,26 @@ static ssize_t ima_read_policy(char *path)
 	datap = path;
 	strsep(&datap, "\n");
 
-	rc = kernel_read_file_from_path(path, &data, &size, 0, READING_POLICY);
+	rc = kernel_read_file_from_path(path, &data, &size, 0, file_id);
 	if (rc < 0) {
 		pr_err("Unable to open file: %s (%d)", path, rc);
 		return rc;
 	}
 
 	datap = data;
-	while (size > 0 && (p = strsep(&datap, "\n"))) {
-		pr_debug("rule: %s\n", p);
-		rc = ima_parse_add_rule(p);
+	while (size > 0) {
+		switch (file_id) {
+		case READING_POLICY:
+			p = strsep(&datap, "\n");
+			if (p == NULL)
+				break;
+
+			pr_debug("rule: %s\n", p);
+			rc = ima_parse_add_rule(p);
+			break;
+		default:
+			break;
+		}
 		if (rc < 0)
 			break;
 		size -= rc;
@@ -334,7 +344,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out_free;
 
 	if (data[0] == '/') {
-		result = ima_read_policy(data);
+		result = ima_read_file(data, READING_POLICY);
 	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-- 
2.17.1

