Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C377372F7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhEDSJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 14:09:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:43157 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232369AbhEDSJU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 14:09:20 -0400
IronPort-SDR: iblq22Th16vHjgTbCFEQWzQOXDuQVwPE4cwVBxwH4RklYNhHIm0DVbzGugZsKxyrZNecM1w7ID
 1oCKTYIC9lng==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="195997142"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="195997142"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:08:09 -0700
IronPort-SDR: lo9M6W0jgVReKtO6JrQFQPsigrwiLS8ObJ4ML7WIchkrqwaUC6zT+T5q+fkM4XSJ10b07CtlKA
 sXqvP0S46Qqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="451366819"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2021 11:08:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C69A634F; Tue,  4 May 2021 21:08:23 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 05/15] lib/string_helpers: Introduce ESCAPE_NAP to escape non-ASCII and non-printable
Date:   Tue,  4 May 2021 21:08:09 +0300
Message-Id: <20210504180819.73127-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some users may want to have an ASCII based filter for printable only characters,
provided by conjunction of isascii() and isprint() functions.

Here is the addition of a such.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h |  1 +
 lib/string_helpers.c           | 20 ++++++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index d6cf6fe10f74..811c6a627620 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -53,6 +53,7 @@ static inline int string_unescape_any_inplace(char *buf)
 #define ESCAPE_ANY_NP		(ESCAPE_ANY | ESCAPE_NP)
 #define ESCAPE_HEX		BIT(5)
 #define ESCAPE_NA		BIT(6)
+#define ESCAPE_NAP		BIT(7)
 
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index a963404b8c16..ceca5fbbd92c 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -454,9 +454,11 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *
  *	1. The character is not matched to the one from @only string and thus
  *	   must go as-is to the output.
- *	2. The character is matched to the printable or ASCII class, if asked,
+ *	2. The character is matched to the printable and ASCII classes, if asked,
  *	   and in case of match it passes through to the output.
- *	3. The character is checked if it falls into the class given by @flags.
+ *	3. The character is matched to the printable or ASCII class, if asked,
+ *	   and in case of match it passes through to the output.
+ *	4. The character is checked if it falls into the class given by @flags.
  *	   %ESCAPE_OCTAL and %ESCAPE_HEX are going last since they cover any
  *	   character. Note that they actually can't go together, otherwise
  *	   %ESCAPE_HEX will be ignored.
@@ -489,11 +491,15 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *		'\xHH' - byte with hexadecimal value HH (2 digits)
  *	%ESCAPE_NA:
  *		escape only non-ascii characters, checked by isascii()
+ *	%ESCAPE_NAP:
+ *		escape only non-printable or non-ascii characters
  *
- * One notable caveat, the %ESCAPE_NP and %ESCAPE_NA have higher priority
- * than the rest of the flags (%ESCAPE_NP is higher than %ESCAPE_NA).
+ * One notable caveat, the %ESCAPE_NAP, %ESCAPE_NP and %ESCAPE_NA have the
+ * higher priority than the rest of the flags (%ESCAPE_NAP is the highest).
  * It doesn't make much sense to use either of them without %ESCAPE_OCTAL
  * or %ESCAPE_HEX, because they cover most of the other character classes.
+ * %ESCAPE_NAP can utilize %ESCAPE_SPACE or %ESCAPE_SPECIAL in addition to
+ * the above.
  *
  * Return:
  * The total size of the escaped output that would be generated for
@@ -515,6 +521,8 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		 * Apply rules in the following sequence:
 		 *	- the @only string is supplied and does not contain a
 		 *	  character under question
+		 *	- the character is printable and ASCII, when @flags has
+		 *	  %ESCAPE_NAP bit set
 		 *	- the character is printable, when @flags has
 		 *	  %ESCAPE_NP bit set
 		 *	- the character is ASCII, when @flags has
@@ -528,6 +536,10 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 					  escape_passthrough(c, &p, end))
 			continue;
 
+		if (isascii(c) && isprint(c) &&
+		    flags & ESCAPE_NAP && escape_passthrough(c, &p, end))
+			continue;
+
 		if (isprint(c) &&
 		    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
 			continue;
-- 
2.30.2

