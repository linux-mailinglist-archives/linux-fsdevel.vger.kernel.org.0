Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B094B3728ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 12:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhEDK2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 06:28:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:31284 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhEDK1z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 06:27:55 -0400
IronPort-SDR: nvD4mv+B57wNXi5EpQE4v0XA9nNyCHPP4OqK4Ct4sFfhQ6dwzEo1wt2Als6V2aebRPIo645sD9
 xlvhOTKHj97g==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="198001095"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198001095"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:27:00 -0700
IronPort-SDR: RPf0CfIh4/cHrx/dfr/pOTqqVbQvvdvmtmcXxNsVlI+nymVp4iHe7U5HbfTnkDWBQQAlVUmtnx
 mDXaf+rPsl4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396079650"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2021 03:26:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 82ADC35E; Tue,  4 May 2021 13:27:17 +0300 (EEST)
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
Subject: [PATCH v2 04/14] lib/string_helpers: Introduce ESCAPE_NA for escaping non-ASCII
Date:   Tue,  4 May 2021 13:26:38 +0300
Message-Id: <20210504102648.88057-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
References: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some users may want to have an ASCII based filter, provided by
isascii() function. Here is the addition of a such.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h |  1 +
 lib/string_helpers.c           | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index bf01e24edd89..d6cf6fe10f74 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -52,6 +52,7 @@ static inline int string_unescape_any_inplace(char *buf)
 #define ESCAPE_NP		BIT(4)
 #define ESCAPE_ANY_NP		(ESCAPE_ANY | ESCAPE_NP)
 #define ESCAPE_HEX		BIT(5)
+#define ESCAPE_NA		BIT(6)
 
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index e3ef9f86cc34..a963404b8c16 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -454,8 +454,8 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *
  *	1. The character is not matched to the one from @only string and thus
  *	   must go as-is to the output.
- *	2. The character is matched to the printable class, if asked, and in
- *	   case of match it passes through to the output.
+ *	2. The character is matched to the printable or ASCII class, if asked,
+ *	   and in case of match it passes through to the output.
  *	3. The character is checked if it falls into the class given by @flags.
  *	   %ESCAPE_OCTAL and %ESCAPE_HEX are going last since they cover any
  *	   character. Note that they actually can't go together, otherwise
@@ -463,7 +463,7 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *
  * Caller must provide valid source and destination pointers. Be aware that
  * destination buffer will not be NULL-terminated, thus caller have to append
- * it if needs.   The supported flags are::
+ * it if needs. The supported flags are::
  *
  *	%ESCAPE_SPACE: (special white space, not space itself)
  *		'\f' - form feed
@@ -482,11 +482,18 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *	%ESCAPE_ANY:
  *		all previous together
  *	%ESCAPE_NP:
- *		escape only non-printable characters (checked by isprint)
+ *		escape only non-printable characters, checked by isprint()
  *	%ESCAPE_ANY_NP:
  *		all previous together
  *	%ESCAPE_HEX:
  *		'\xHH' - byte with hexadecimal value HH (2 digits)
+ *	%ESCAPE_NA:
+ *		escape only non-ascii characters, checked by isascii()
+ *
+ * One notable caveat, the %ESCAPE_NP and %ESCAPE_NA have higher priority
+ * than the rest of the flags (%ESCAPE_NP is higher than %ESCAPE_NA).
+ * It doesn't make much sense to use either of them without %ESCAPE_OCTAL
+ * or %ESCAPE_HEX, because they cover most of the other character classes.
  *
  * Return:
  * The total size of the escaped output that would be generated for
@@ -510,6 +517,8 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		 *	  character under question
 		 *	- the character is printable, when @flags has
 		 *	  %ESCAPE_NP bit set
+		 *	- the character is ASCII, when @flags has
+		 *	  %ESCAPE_NA bit set
 		 *	- the character doesn't fall into a class of symbols
 		 *	  defined by given @flags
 		 * In these cases we just pass through a character to the
@@ -523,6 +532,10 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
 			continue;
 
+		if (isascii(c) &&
+		    flags & ESCAPE_NA && escape_passthrough(c, &p, end))
+			continue;
+
 		if (flags & ESCAPE_SPACE && escape_space(c, &p, end))
 			continue;
 
-- 
2.30.2

