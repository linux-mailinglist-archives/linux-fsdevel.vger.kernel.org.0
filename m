Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADBF3721E9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhECUtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 16:49:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:23675 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhECUtu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 16:49:50 -0400
IronPort-SDR: MCzzu1haOAupqz2alRnmy4n8VInu0anWPdA7iJmbpah9CIpFay/6U953GzNVGM0ByRWQUY02cH
 j9avGmZFmIfA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="259117118"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="259117118"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:48:55 -0700
IronPort-SDR: y4VnTBFW0ekiS3yyNYGolLD0vWSzxfAdeuZl8PGDqMy6tYwiRYwYnwqW7IunVoAapAFDNevhsq
 XaqdveWGcTDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="606761863"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 03 May 2021 13:48:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1DFD9B9; Mon,  3 May 2021 23:49:11 +0300 (EEST)
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
Subject: [PATCH v1 01/12] lib/string_helpers: Switch to use BIT() macro
Date:   Mon,  3 May 2021 23:48:56 +0300
Message-Id: <20210503204907.34013-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
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

