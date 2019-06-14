Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C74466DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfFNSBy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:01:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33013 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727012AbfFNSBy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:01:54 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id C84BC33E3C655E10B946;
        Fri, 14 Jun 2019 19:01:52 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:01:44 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 05/14] ima: use ima_show_htable_value to show violations and hash table data
Date:   Fri, 14 Jun 2019 19:55:04 +0200
Message-ID: <20190614175513.27097-6-roberto.sassu@huawei.com>
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

ima_show_htable_violations() and ima_show_measurements_count() both call
ima_show_htable_value() to copy the value of an atomic_long_t variable to
a buffer.

This patch modifies the definition of ima_show_htable_value(), so that this
function can be used in any file_operations structure. The atomic_long_t
variable used as source is chosen depending on the opened file in the
securityfs filesystem.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_fs.c | 38 +++++++++++----------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index c8bbc56f735e..0f503b7cd396 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -47,38 +47,24 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
 
-static ssize_t ima_show_htable_value(char __user *buf, size_t count,
-				     loff_t *ppos, atomic_long_t *val)
+static ssize_t ima_show_htable_value(struct file *filp, char __user *buf,
+				     size_t count, loff_t *ppos)
 {
+	atomic_long_t *val = NULL;
 	char tmpbuf[32];	/* greater than largest 'long' string value */
 	ssize_t len;
 
+	if (filp->f_path.dentry == violations)
+		val = &ima_htable.violations;
+	else if (filp->f_path.dentry == runtime_measurements_count)
+		val = &ima_htable.len;
+
 	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
 }
 
-static ssize_t ima_show_htable_violations(struct file *filp,
-					  char __user *buf,
-					  size_t count, loff_t *ppos)
-{
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.violations);
-}
-
-static const struct file_operations ima_htable_violations_ops = {
-	.read = ima_show_htable_violations,
-	.llseek = generic_file_llseek,
-};
-
-static ssize_t ima_show_measurements_count(struct file *filp,
-					   char __user *buf,
-					   size_t count, loff_t *ppos)
-{
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
-
-}
-
-static const struct file_operations ima_measurements_count_ops = {
-	.read = ima_show_measurements_count,
+static const struct file_operations ima_htable_value_ops = {
+	.read = ima_show_htable_value,
 	.llseek = generic_file_llseek,
 };
 
@@ -527,13 +513,13 @@ int __init ima_fs_init(void)
 	runtime_measurements_count =
 	    securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
-				   &ima_measurements_count_ops);
+				   &ima_htable_value_ops);
 	if (IS_ERR(runtime_measurements_count))
 		goto out;
 
 	violations =
 	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
-				   ima_dir, NULL, &ima_htable_violations_ops);
+				   ima_dir, NULL, &ima_htable_value_ops);
 	if (IS_ERR(violations))
 		goto out;
 
-- 
2.17.1

