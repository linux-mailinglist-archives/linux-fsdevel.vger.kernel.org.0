Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DED3721FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhECUuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 16:50:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:35564 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229802AbhECUtv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 16:49:51 -0400
IronPort-SDR: p+WX4TbqP3d7fMudjnSId6LpMC/6tA8ECJztpwtkXpVwlATbY0Fsj9w3JK4zBeE+Bugrr/Fhf+
 DP3u4b0wFVEA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="195776789"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="195776789"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:48:58 -0700
IronPort-SDR: CaMNnu6I1bn+Sw39L4bDQ90XgkhYtT2AFRSn6Y6kZkKzrmBkWhmEjSs9otyEMyhMTk64BBVpMb
 4iLYKmBgf4RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="618189776"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 03 May 2021 13:48:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 54AA1348; Mon,  3 May 2021 23:49:11 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 05/12] lib/string_helpers: Drop indentation level in string_escape_mem()
Date:   Mon,  3 May 2021 23:49:00 +0300
Message-Id: <20210503204907.34013-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only one conditional is left on the upper level, move the rest
to the same level and drop indentation level. No functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/string_helpers.c | 47 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 26e35018684f..8e58e2c6f83d 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -532,37 +532,36 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		 * In these cases we just pass through a character to the
 		 * output buffer.
 		 */
-		if (is_dict && !strchr(only, c)) {
-			/* do nothing */
-		} else {
-			if (isascii(c) && isprint(c) &&
-			    flags & ESCAPE_NAP && escape_passthrough(c, &p, end))
-				continue;
+		if (is_dict && !strchr(only, c) && escape_passthrough(c, &p, end))
+			continue;
 
-			if (isprint(c) &&
-			    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
-				continue;
+		if (isascii(c) && isprint(c) &&
+		    flags & ESCAPE_NAP && escape_passthrough(c, &p, end))
+			continue;
 
-			if (isascii(c) &&
-			    flags & ESCAPE_NA && escape_passthrough(c, &p, end))
-				continue;
+		if (isprint(c) &&
+		    flags & ESCAPE_NP && escape_passthrough(c, &p, end))
+			continue;
 
-			if (flags & ESCAPE_SPACE && escape_space(c, &p, end))
-				continue;
+		if (isascii(c) &&
+		    flags & ESCAPE_NA && escape_passthrough(c, &p, end))
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

