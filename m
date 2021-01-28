Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAAC30700E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbhA1HrM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:47:12 -0500
Received: from mail.synology.com ([211.23.38.101]:53534 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231669AbhA1HNz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:13:55 -0500
Received: from localhost.localdomain (unknown [10.17.32.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by synology.com (Postfix) with ESMTPSA id C84B2CE781B4;
        Thu, 28 Jan 2021 15:13:12 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1611817992; bh=viCDBq1ZSQaxBJ5WLC+woroikILxVup7UQRf4iZnYpk=;
        h=From:To:Cc:Subject:Date;
        b=H4BMfcdbfzYMIP4k3u+DfiGfJmEQZQcDiO7pPxev5PbCloM82HzJp5299iyKZzN3Z
         YwUEZcWO1BDrUIR+ToD9YmuvJTruy/9NwiM1Ia/QSXOwld+o/yYSFUVtHQHMj4OUP5
         5oyXMugtx8s6xrlFPTVLjFjnJfH5bULSDaLCgryY=
From:   bingjingc <bingjingc@synology.com>
To:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, cccheng@synology.com,
        bingjingc@synology.com, robbieko@synology.com, willy@infradead.org,
        rdunlap@infradead.org
Subject: [PATCH v2 1/3] parser: add unsigned int parser
Date:   Thu, 28 Jan 2021 15:13:03 +0800
Message-Id: <1611817983-2892-1-git-send-email-bingjingc@synology.com>
X-Mailer: git-send-email 2.7.4
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: BingJing Chang <bingjingc@synology.com>

Will be used by fs parsing options & fix kernel-doc typos

Reviewed-by: Robbie Ko<robbieko@synology.com>
Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
---
 include/linux/parser.h |  1 +
 lib/parser.c           | 44 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 11 deletions(-)

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
index f5b3e5d..f2b9a8e 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -11,7 +11,7 @@
 #include <linux/string.h>
 
 /**
- * match_one: - Determines if a string matches a simple pattern
+ * match_one - Determines if a string matches a simple pattern
  * @s: the string to examine for presence of the pattern
  * @p: the string containing the pattern
  * @args: array of %MAX_OPT_ARGS &substring_t elements. Used to return match
@@ -89,7 +89,7 @@ static int match_one(char *s, const char *p, substring_t args[])
 }
 
 /**
- * match_token: - Find a token (and optional args) in a string
+ * match_token - Find a token (and optional args) in a string
  * @s: the string to examine for token/argument pairs
  * @table: match_table_t describing the set of allowed option tokens and the
  * arguments that may be associated with them. Must be terminated with a
@@ -114,7 +114,7 @@ int match_token(char *s, const match_table_t table, substring_t args[])
 EXPORT_SYMBOL(match_token);
 
 /**
- * match_number: scan a number in the given base from a substring_t
+ * match_number - scan a number in the given base from a substring_t
  * @s: substring to be scanned
  * @result: resulting integer on success
  * @base: base to use when converting string
@@ -147,7 +147,7 @@ static int match_number(substring_t *s, int *result, int base)
 }
 
 /**
- * match_u64int: scan a number in the given base from a substring_t
+ * match_u64int - scan a number in the given base from a substring_t
  * @s: substring to be scanned
  * @result: resulting u64 on success
  * @base: base to use when converting string
@@ -174,7 +174,7 @@ static int match_u64int(substring_t *s, u64 *result, int base)
 }
 
 /**
- * match_int: - scan a decimal representation of an integer from a substring_t
+ * match_int - scan a decimal representation of an integer from a substring_t
  * @s: substring_t to be scanned
  * @result: resulting integer on success
  *
@@ -188,8 +188,30 @@ int match_int(substring_t *s, int *result)
 }
 EXPORT_SYMBOL(match_int);
 
+/*
+ * match_uint - scan a decimal representation of an integer from a substring_t
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
 /**
- * match_u64: - scan a decimal representation of a u64 from
+ * match_u64 - scan a decimal representation of a u64 from
  *                  a substring_t
  * @s: substring_t to be scanned
  * @result: resulting unsigned long long on success
@@ -206,7 +228,7 @@ int match_u64(substring_t *s, u64 *result)
 EXPORT_SYMBOL(match_u64);
 
 /**
- * match_octal: - scan an octal representation of an integer from a substring_t
+ * match_octal - scan an octal representation of an integer from a substring_t
  * @s: substring_t to be scanned
  * @result: resulting integer on success
  *
@@ -221,7 +243,7 @@ int match_octal(substring_t *s, int *result)
 EXPORT_SYMBOL(match_octal);
 
 /**
- * match_hex: - scan a hex representation of an integer from a substring_t
+ * match_hex - scan a hex representation of an integer from a substring_t
  * @s: substring_t to be scanned
  * @result: resulting integer on success
  *
@@ -236,7 +258,7 @@ int match_hex(substring_t *s, int *result)
 EXPORT_SYMBOL(match_hex);
 
 /**
- * match_wildcard: - parse if a string matches given wildcard pattern
+ * match_wildcard - parse if a string matches given wildcard pattern
  * @pattern: wildcard pattern
  * @str: the string to be parsed
  *
@@ -287,7 +309,7 @@ bool match_wildcard(const char *pattern, const char *str)
 EXPORT_SYMBOL(match_wildcard);
 
 /**
- * match_strlcpy: - Copy the characters from a substring_t to a sized buffer
+ * match_strlcpy - Copy the characters from a substring_t to a sized buffer
  * @dest: where to copy to
  * @src: &substring_t to copy
  * @size: size of destination buffer
@@ -310,7 +332,7 @@ size_t match_strlcpy(char *dest, const substring_t *src, size_t size)
 EXPORT_SYMBOL(match_strlcpy);
 
 /**
- * match_strdup: - allocate a new string with the contents of a substring_t
+ * match_strdup - allocate a new string with the contents of a substring_t
  * @s: &substring_t to copy
  *
  * Description: Allocates and returns a string filled with the contents of
-- 
2.7.4

