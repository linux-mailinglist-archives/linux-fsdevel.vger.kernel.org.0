Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F553728DA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 12:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhEDK1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 06:27:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:59878 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhEDK1y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 06:27:54 -0400
IronPort-SDR: AHXr5iImVKPIC1iVMXSwg9o0IKOd9uZFrgdP9+NJ0FJEtNUzeQBjJ8UBXmNrQr1EksxvrdCiNw
 h5ohwkE0Shqw==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="178157696"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="178157696"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 03:27:00 -0700
IronPort-SDR: j7ZC+jX07h0wB53DTfEwXv5sxfiCt2JbdpveInKFyKbwWtcg5q1bqhzjyyvY7K8nG0xBqzcrMl
 BOW2taLZGzNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="457836648"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 04 May 2021 03:26:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6697229A; Tue,  4 May 2021 13:27:17 +0300 (EEST)
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
Subject: [PATCH v2 01/14] lib/string_helpers: Switch to use BIT() macro
Date:   Tue,  4 May 2021 13:26:35 +0300
Message-Id: <20210504102648.88057-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
References: <20210504102648.88057-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch to use BIT() macro for flag definitions. No changes implied.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index fa06dcdc481e..bf01e24edd89 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_STRING_HELPERS_H_
 #define _LINUX_STRING_HELPERS_H_
 
+#include <linux/bits.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
 
@@ -18,10 +19,10 @@ enum string_size_units {
 void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
 		     char *buf, int len);
 
-#define UNESCAPE_SPACE		0x01
-#define UNESCAPE_OCTAL		0x02
-#define UNESCAPE_HEX		0x04
-#define UNESCAPE_SPECIAL	0x08
+#define UNESCAPE_SPACE		BIT(0)
+#define UNESCAPE_OCTAL		BIT(1)
+#define UNESCAPE_HEX		BIT(2)
+#define UNESCAPE_SPECIAL	BIT(3)
 #define UNESCAPE_ANY		\
 	(UNESCAPE_SPACE | UNESCAPE_OCTAL | UNESCAPE_HEX | UNESCAPE_SPECIAL)
 
@@ -42,15 +43,15 @@ static inline int string_unescape_any_inplace(char *buf)
 	return string_unescape_any(buf, buf, 0);
 }
 
-#define ESCAPE_SPACE		0x01
-#define ESCAPE_SPECIAL		0x02
-#define ESCAPE_NULL		0x04
-#define ESCAPE_OCTAL		0x08
+#define ESCAPE_SPACE		BIT(0)
+#define ESCAPE_SPECIAL		BIT(1)
+#define ESCAPE_NULL		BIT(2)
+#define ESCAPE_OCTAL		BIT(3)
 #define ESCAPE_ANY		\
 	(ESCAPE_SPACE | ESCAPE_OCTAL | ESCAPE_SPECIAL | ESCAPE_NULL)
-#define ESCAPE_NP		0x10
+#define ESCAPE_NP		BIT(4)
 #define ESCAPE_ANY_NP		(ESCAPE_ANY | ESCAPE_NP)
-#define ESCAPE_HEX		0x20
+#define ESCAPE_HEX		BIT(5)
 
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
-- 
2.30.2

