Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ADE3728D8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 12:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhEDK1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 06:27:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:42156 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhEDK1y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 06:27:54 -0400
IronPort-SDR: 2cYYoYfxNTC26ayvWvflYCd5aXufBmgGIHSPv4zd9ldAi0rGCc2tj4Yp49zSNEm/4JPXfqXz9i
 zR7qhG2v8MvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="283356644"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="283356644"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:27:00 -0700
IronPort-SDR: LIwYMv7BUEA9VuYGTG046Vd5PnGND78cVido1jlj30DY0tztuVj5m2TlhDdyb/+Z4l2MyOXUHt
 nk9SrB5Y3NXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="428858436"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 04 May 2021 03:26:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 71EE1348; Tue,  4 May 2021 13:27:17 +0300 (EEST)
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
Subject: [PATCH v2 02/14] lib/string_helpers: Move ESCAPE_NP check inside 'else' branch in a loop
Date:   Tue,  4 May 2021 13:26:36 +0300
Message-Id: <20210504102648.88057-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
References: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Refactor code to have better readability by moving ESCAPE_NP handling
inside 'else' branch in the loop.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/string_helpers.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 7f2d5fbaf243..b10a18b4663b 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -452,10 +452,10 @@ static bool escape_hex(unsigned char c, char **dst, char *end)
  * The process of escaping byte buffer includes several parts. They are applied
  * in the following sequence.
  *
- *	1. The character is matched to the printable class, if asked, and in
- *	   case of match it passes through to the output.
- *	2. The character is not matched to the one from @only string and thus
+ *	1. The character is not matched to the one from @only string and thus
  *	   must go as-is to the output.
+ *	2. The character is matched to the printable class, if asked, and in
+ *	   case of match it passes through to the output.
  *	3. The character is checked if it falls into the class given by @flags.
  *	   %ESCAPE_OCTAL and %ESCAPE_HEX are going last since they cover any
  *	   character. Note that they actually can't go together, otherwise
@@ -506,19 +506,22 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 
 		/*
 		 * Apply rules in the following sequence:
-		 *	- the character is printable, when @flags has
-		 *	  %ESCAPE_NP bit set
 		 *	- the @only string is supplied and does not contain a
 		 *	  character under question
+		 *	- the character is printable, when @flags has
+		 *	  %ESCAPE_NP bit set
 		 *	- the character doesn't fall into a class of symbols
 		 *	  defined by given @flags
 		 * In these cases we just pass through a character to the
 		 * output buffer.
 		 */
-		if ((flags & ESCAPE_NP && isprint(c)) ||
-		    (is_dict && !strchr(only, c))) {
+		if (is_dict && !strchr(only, c)) {
 			/* do nothing */
 		} else {
+			if (isprint(c) &&
+			    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
+				continue;
+
 			if (flags & ESCAPE_SPACE && escape_space(c, &p, end))
 				continue;
 
-- 
2.30.2

