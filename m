Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1D3728E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 12:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhEDK2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 06:28:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:31284 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhEDK1z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 06:27:55 -0400
IronPort-SDR: jov+n4u5TMk2kX2cHyNtLO/2il9ufHkGhn7fXmvvFo+3ebNnZ3wu7Fir+qIJD0DkOUeI7mrphy
 ArY5UkGbaE1A==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="198001091"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="198001091"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:27:00 -0700
IronPort-SDR: t+9PNJmu7DOwEhtuJLh/oPGjs+47jlLS8GQMhyX4/obku7jw9S6N/OtfNs+QI/3B5fjcBofq4C
 Uc0dWD9OalJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="396079648"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2021 03:26:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A7CB34F; Tue,  4 May 2021 13:27:17 +0300 (EEST)
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
Subject: [PATCH v2 03/14] lib/string_helpers: Drop indentation level in string_escape_mem()
Date:   Tue,  4 May 2021 13:26:37 +0300
Message-Id: <20210504102648.88057-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
References: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only one conditional is left on the upper level, move the rest
to the same level and drop indentation level. No functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/string_helpers.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index b10a18b4663b..e3ef9f86cc34 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -515,29 +515,29 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		 * In these cases we just pass through a character to the
 		 * output buffer.
 		 */
-		if (is_dict && !strchr(only, c)) {
-			/* do nothing */
-		} else {
-			if (isprint(c) &&
-			    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
-				continue;
+		if (is_dict && !strchr(only, c) &&
+					  escape_passthrough(c, &p, end))
+			continue;
 
-			if (flags & ESCAPE_SPACE && escape_space(c, &p, end))
-				continue;
+		if (isprint(c) &&
+		    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
+			continue;
 
-			if (flags & ESCAPE_SPECIAL && escape_special(c, &p, end))
-				continue;
+		if (flags & ESCAPE_SPACE && escape_space(c, &p, end))
+			continue;
 
-			if (flags & ESCAPE_NULL && escape_null(c, &p, end))
-				continue;
+		if (flags & ESCAPE_SPECIAL && escape_special(c, &p, end))
+			continue;
 
-			/* ESCAPE_OCTAL and ESCAPE_HEX always go last */
-			if (flags & ESCAPE_OCTAL && escape_octal(c, &p, end))
-				continue;
+		if (flags & ESCAPE_NULL && escape_null(c, &p, end))
+			continue;
 
-			if (flags & ESCAPE_HEX && escape_hex(c, &p, end))
-				continue;
-		}
+		/* ESCAPE_OCTAL and ESCAPE_HEX always go last */
+		if (flags & ESCAPE_OCTAL && escape_octal(c, &p, end))
+			continue;
+
+		if (flags & ESCAPE_HEX && escape_hex(c, &p, end))
+			continue;
 
 		escape_passthrough(c, &p, end);
 	}
-- 
2.30.2

