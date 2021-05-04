Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEB9372F8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 20:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhEDSKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 14:10:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:33853 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232257AbhEDSJF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 14:09:05 -0400
IronPort-SDR: GVYEer7655/pPEUbop6izsKFJwYpymkMIXsu28QbR7wfvf/SmUKINSYwaeddmZEEmYqoxat72D
 Plzqy+rh0cRg==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="178258333"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178258333"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:08:09 -0700
IronPort-SDR: IpNDWNrOXjw3wGXjKQPsaoRPPhUSyNI4EdFKeRy451rHowTnuK60ee25hrnIdtTXRayXpAHPNg
 9BMJSYrSh/YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="390052755"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 04 May 2021 11:08:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D212D35E; Tue,  4 May 2021 21:08:23 +0300 (EEST)
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
Subject: [PATCH v3 06/15] lib/string_helpers: Allow to append additional characters to be escaped
Date:   Tue,  4 May 2021 21:08:10 +0300
Message-Id: <20210504180819.73127-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
References: <20210504180819.73127-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a new flag to append additional characters, passed in 'only'
parameter, to be escaped if they fall in the corresponding class.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h |  1 +
 lib/string_helpers.c           | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index 811c6a627620..f8728ed4d563 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -54,6 +54,7 @@ static inline int string_unescape_any_inplace(char *buf)
 #define ESCAPE_HEX		BIT(5)
 #define ESCAPE_NA		BIT(6)
 #define ESCAPE_NAP		BIT(7)
+#define ESCAPE_APPEND		BIT(8)
 
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index ceca5fbbd92c..c15aea7a82e9 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -493,6 +493,11 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  *		escape only non-ascii characters, checked by isascii()
  *	%ESCAPE_NAP:
  *		escape only non-printable or non-ascii characters
+ *	%ESCAPE_APPEND:
+ *		append characters from @only to be escaped by the given classes
+ *
+ * %ESCAPE_APPEND would help to pass additional characters to the escaped, when
+ * one of %ESCAPE_NP, %ESCAPE_NA, or %ESCAPE_NAP is provided.
  *
  * One notable caveat, the %ESCAPE_NAP, %ESCAPE_NP and %ESCAPE_NA have the
  * higher priority than the rest of the flags (%ESCAPE_NAP is the highest).
@@ -513,9 +518,11 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 	char *p = dst;
 	char *end = p + osz;
 	bool is_dict = only && *only;
+	bool is_append = flags & ESCAPE_APPEND;
 
 	while (isz--) {
 		unsigned char c = *src++;
+		bool in_dict = is_dict && strchr(only, c);
 
 		/*
 		 * Apply rules in the following sequence:
@@ -531,20 +538,24 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		 *	  defined by given @flags
 		 * In these cases we just pass through a character to the
 		 * output buffer.
+		 *
+		 * When %ESCAPE_APPEND is passed, the characters from @only
+		 * have been excluded from the %ESCAPE_NAP, %ESCAPE_NP, and
+		 * %ESCAPE_NA cases.
 		 */
-		if (is_dict && !strchr(only, c) &&
+		if (!(is_append || in_dict) && is_dict &&
 					  escape_passthrough(c, &p, end))
 			continue;
 
-		if (isascii(c) && isprint(c) &&
+		if (!(is_append && in_dict) && isascii(c) && isprint(c) &&
 		    flags & ESCAPE_NAP && escape_passthrough(c, &p, end))
 			continue;
 
-		if (isprint(c) &&
+		if (!(is_append && in_dict) && isprint(c) &&
 		    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
 			continue;
 
-		if (isascii(c) &&
+		if (!(is_append && in_dict) && isascii(c) &&
 		    flags & ESCAPE_NA && escape_passthrough(c, &p, end))
 			continue;
 
-- 
2.30.2

