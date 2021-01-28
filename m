Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5C2306B07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 03:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhA1CVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 21:21:11 -0500
Received: from mail.synology.com ([211.23.38.101]:51962 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231204AbhA1CUx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 21:20:53 -0500
Received: from localhost.localdomain (unknown [10.17.32.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id 98DD3CE781CA;
        Thu, 28 Jan 2021 10:20:11 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611800411; bh=Ml/b5oOFCX4UpBoR+iFec6zbr09wPprtwU9FAP+aKdI=;
        h=From:To:Cc:Subject:Date;
        b=ZrXDdAiFalHJUNRDweURhwaRuqqU/ys6eDz7Uv2GGmnpL0hpu1/RjCOibBDii99In
         /XuVgt4Vbtl+eqdNVXllQxXukeEDpkGlTroleHLep5j9P9hYylPkR6R7K2589ktglA
         Z3XRb4TUp9fu4WTyU7/cVG0RvD1MVvvEuKprslNM=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com
Subject: [PATCH 3/3] parser: add unsigned int parser
Date:   Thu, 28 Jan 2021 10:20:01 +0800
Message-Id: <1611800401-9790-1-git-send-email-bingjingc@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Will be used by fs parsing options

Reviewed-by: Robbie Ko<robbieko@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 fs/isofs/inode.c       | 16 ++--------------
 fs/udf/super.c         | 16 ++--------------
 include/linux/parser.h |  1 +
 lib/parser.c           | 22 ++++++++++++++++++++++
 4 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 342ac19..21edc42 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -335,18 +335,6 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
-static int isofs_match_uint(substring_t *s, unsigned int *res)
-{
-	int err = -ENOMEM;
-	char *buf = match_strdup(s);
-
-	if (buf) {
-		err = kstrtouint(buf, 10, res);
-		kfree(buf);
-	}
-	return err;
-}
-
 static int parse_options(char *options, struct iso9660_options *popt)
 {
 	char *p;
@@ -447,7 +435,7 @@ static int parse_options(char *options, struct iso9660_options *popt)
 		case Opt_ignore:
 			break;
 		case Opt_uid:
-			if (isofs_match_uint(&args[0], &uv))
+			if (match_uint(&args[0], &uv))
 				return 0;
 			popt->uid = make_kuid(current_user_ns(), uv);
 			if (!uid_valid(popt->uid))
@@ -455,7 +443,7 @@ static int parse_options(char *options, struct iso9660_options *popt)
 			popt->uid_set = 1;
 			break;
 		case Opt_gid:
-			if (isofs_match_uint(&args[0], &uv))
+			if (match_uint(&args[0], &uv))
 				return 0;
 			popt->gid = make_kgid(current_user_ns(), uv);
 			if (!gid_valid(popt->gid))
diff --git a/fs/udf/super.c b/fs/udf/super.c
index efeac8c..2f83c12 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -454,18 +454,6 @@ static const match_table_t tokens = {
 	{Opt_err,	NULL}
 };
 
-static int udf_match_uint(substring_t *s, unsigned int *res)
-{
-	int err = -ENOMEM;
-	char *buf = match_strdup(s);
-
-	if (buf) {
-		err = kstrtouint(buf, 10, res);
-		kfree(buf);
-	}
-	return err;
-}
-
 static int udf_parse_options(char *options, struct udf_options *uopt,
 			     bool remount)
 {
@@ -521,7 +509,7 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 			uopt->flags &= ~(1 << UDF_FLAG_USE_SHORT_AD);
 			break;
 		case Opt_gid:
-			if (udf_match_uint(args, &uv))
+			if (match_uint(args, &uv))
 				return 0;
 			uopt->gid = make_kgid(current_user_ns(), uv);
 			if (!gid_valid(uopt->gid))
@@ -529,7 +517,7 @@ static int udf_parse_options(char *options, struct udf_options *uopt,
 			uopt->flags |= (1 << UDF_FLAG_GID_SET);
 			break;
 		case Opt_uid:
-			if (udf_match_uint(args, &uv))
+			if (match_uint(args, &uv))
 				return 0;
 			uopt->uid = make_kuid(current_user_ns(), uv);
 			if (!uid_valid(uopt->uid))
diff --git a/include/linux/parser.h b/include/linux/parser.h
index 89e2b23..dd79f45 100644
--- a/include/linux/parser.h
+++ b/include/linux/parser.h
@@ -29,6 +29,7 @@ typedef struct {
 
 int match_token(char *, const match_table_t table, substring_t args[]);
 int match_int(substring_t *, int *result);
+int match_uint(substring_t *s, unsigned int *result);
 int match_u64(substring_t *, u64 *result);
 int match_octal(substring_t *, int *result);
 int match_hex(substring_t *, int *result);
diff --git a/lib/parser.c b/lib/parser.c
index f5b3e5d..2ec9c4f 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -189,6 +189,28 @@ int match_int(substring_t *s, int *result)
 EXPORT_SYMBOL(match_int);
 
 /**
+ * match_uint: - scan a decimal representation of an integer from a substring_t
+ * @s: substring_t to be scanned
+ * @result: resulting integer on success
+ *
+ * Description: Attempts to parse the &substring_t @s as a decimal integer. On
+ * success, sets @result to the integer represented by the string and returns 0.
+ * Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ */
+int match_uint(substring_t *s, unsigned int *result)
+{
+	int err = -ENOMEM;
+	char *buf = match_strdup(s);
+
+	if (buf) {
+		err = kstrtouint(buf, 10, result);
+		kfree(buf);
+	}
+	return err;
+}
+EXPORT_SYMBOL(match_uint);
+
+/**
  * match_u64: - scan a decimal representation of a u64 from
  *                  a substring_t
  * @s: substring_t to be scanned
-- 
2.7.4

