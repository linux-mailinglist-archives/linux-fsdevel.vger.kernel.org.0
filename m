Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661C03721F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 22:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhECUuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 May 2021 16:50:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:30690 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhECUtx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 May 2021 16:49:53 -0400
IronPort-SDR: nB9KdXNa7vF74W65k6x6lubsH7lEJAUgQtmUdWzKC2hbqlhhpliHDoiqQprNMZphAn24ZefVJB
 cs5H52UiuB7Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="177365360"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="177365360"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 13:48:58 -0700
IronPort-SDR: jPiZco7VhqNh7plNoyOGjUekVh4P5oIajuCCG80565oPzKAuCj7MPpjNd3y/DrPReMFN//rW3O
 ajzHp35eNwXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="405822661"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 03 May 2021 13:48:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 798AE461; Mon,  3 May 2021 23:49:11 +0300 (EEST)
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
Subject: [PATCH v1 09/12] lib/test-string_helpers: Add test cases for new features
Date:   Mon,  3 May 2021 23:49:04 +0300
Message-Id: <20210503204907.34013-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
References: <20210503204907.34013-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have got new flags and hence new features of string_escape_mem().
Add test cases for that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/string_helpers.h |   4 +
 lib/test-string_helpers.c      | 141 +++++++++++++++++++++++++++++++--
 2 files changed, 137 insertions(+), 8 deletions(-)

diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
index f8728ed4d563..9b0eca2badf2 100644
--- a/include/linux/string_helpers.h
+++ b/include/linux/string_helpers.h
@@ -26,6 +26,8 @@ void string_get_size(u64 size, u64 blk_size, enum string_size_units units,
 #define UNESCAPE_ANY		\
 	(UNESCAPE_SPACE | UNESCAPE_OCTAL | UNESCAPE_HEX | UNESCAPE_SPECIAL)
 
+#define UNESCAPE_ALL_MASK	GENMASK(3, 0)
+
 int string_unescape(char *src, char *dst, size_t size, unsigned int flags);
 
 static inline int string_unescape_inplace(char *buf, unsigned int flags)
@@ -56,6 +58,8 @@ static inline int string_unescape_any_inplace(char *buf)
 #define ESCAPE_NAP		BIT(7)
 #define ESCAPE_APPEND		BIT(8)
 
+#define ESCAPE_ALL_MASK		GENMASK(8, 0)
+
 int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
 		unsigned int flags, const char *only);
 
diff --git a/lib/test-string_helpers.c b/lib/test-string_helpers.c
index 3e2def9ccfac..2185d71704f0 100644
--- a/lib/test-string_helpers.c
+++ b/lib/test-string_helpers.c
@@ -202,11 +202,25 @@ static const struct test_string_2 escape0[] __initconst = {{
 	},{
 		/* terminator */
 	}}
+},{
+	.in = "\007 \eb\"\x90\xCF\r",
+	.s1 = {{
+		.out = "\007 \eb\"\\220\\317\r",
+		.flags = ESCAPE_OCTAL | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\\x90\\xcf\r",
+		.flags = ESCAPE_HEX | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\xCF\r",
+		.flags = ESCAPE_NA,
+	},{
+		/* terminator */
+	}}
 },{
 	/* terminator */
 }};
 
-#define	TEST_STRING_2_DICT_1		"b\\ \t\r"
+#define	TEST_STRING_2_DICT_1		"b\\ \t\r\xCF"
 static const struct test_string_2 escape1[] __initconst = {{
 	.in = "\f\\ \n\r\t\v",
 	.s1 = {{
@@ -215,14 +229,38 @@ static const struct test_string_2 escape1[] __initconst = {{
 	},{
 		.out = "\f\\x5c\\x20\n\\x0d\\x09\v",
 		.flags = ESCAPE_HEX,
+	},{
+		.out = "\f\\134\\040\n\\015\\011\v",
+		.flags = ESCAPE_ANY | ESCAPE_APPEND,
+	},{
+		.out = "\\014\\134\\040\\012\\015\\011\\013",
+		.flags = ESCAPE_OCTAL | ESCAPE_APPEND | ESCAPE_NAP,
+	},{
+		.out = "\\x0c\\x5c\\x20\\x0a\\x0d\\x09\\x0b",
+		.flags = ESCAPE_HEX | ESCAPE_APPEND | ESCAPE_NAP,
+	},{
+		.out = "\f\\134\\040\n\\015\\011\v",
+		.flags = ESCAPE_OCTAL | ESCAPE_APPEND | ESCAPE_NA,
+	},{
+		.out = "\f\\x5c\\x20\n\\x0d\\x09\v",
+		.flags = ESCAPE_HEX | ESCAPE_APPEND | ESCAPE_NA,
 	},{
 		/* terminator */
 	}}
 },{
-	.in = "\\h\\\"\a\e\\",
+	.in = "\\h\\\"\a\xCF\e\\",
 	.s1 = {{
-		.out = "\\134h\\134\"\a\e\\134",
+		.out = "\\134h\\134\"\a\\317\e\\134",
 		.flags = ESCAPE_OCTAL,
+	},{
+		.out = "\\134h\\134\"\a\\317\e\\134",
+		.flags = ESCAPE_ANY | ESCAPE_APPEND,
+	},{
+		.out = "\\134h\\134\"\\007\\317\\033\\134",
+		.flags = ESCAPE_OCTAL | ESCAPE_APPEND | ESCAPE_NAP,
+	},{
+		.out = "\\134h\\134\"\a\\317\e\\134",
+		.flags = ESCAPE_OCTAL | ESCAPE_APPEND | ESCAPE_NA,
 	},{
 		/* terminator */
 	}}
@@ -234,6 +272,88 @@ static const struct test_string_2 escape1[] __initconst = {{
 	},{
 		/* terminator */
 	}}
+},{
+	.in = "\007 \eb\"\x90\xCF\r",
+	.s1 = {{
+		.out = "\007 \eb\"\x90\xCF\r",
+		.flags = ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\xCF\r",
+		.flags = ESCAPE_SPACE | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\xCF\r",
+		.flags = ESCAPE_SPECIAL | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\xCF\r",
+		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\\317\r",
+		.flags = ESCAPE_OCTAL | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\\317\r",
+		.flags = ESCAPE_SPACE | ESCAPE_OCTAL | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\\317\r",
+		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\\317\r",
+		.flags = ESCAPE_ANY | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\\xcf\r",
+		.flags = ESCAPE_HEX | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\\xcf\r",
+		.flags = ESCAPE_SPACE | ESCAPE_HEX | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\\xcf\r",
+		.flags = ESCAPE_SPECIAL | ESCAPE_HEX | ESCAPE_NA,
+	},{
+		.out = "\007 \eb\"\x90\\xcf\r",
+		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_HEX | ESCAPE_NA,
+	},{
+		/* terminator */
+	}}
+},{
+	.in = "\007 \eb\"\x90\xCF\r",
+	.s1 = {{
+		.out = "\007 \eb\"\x90\xCF\r",
+		.flags = ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\xCF\\r",
+		.flags = ESCAPE_SPACE | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\xCF\r",
+		.flags = ESCAPE_SPECIAL | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\xCF\\r",
+		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\\317\\015",
+		.flags = ESCAPE_OCTAL | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\\317\\r",
+		.flags = ESCAPE_SPACE | ESCAPE_OCTAL | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\\317\\015",
+		.flags = ESCAPE_SPECIAL | ESCAPE_OCTAL | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\\317\r",
+		.flags = ESCAPE_ANY | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\\xcf\\x0d",
+		.flags = ESCAPE_HEX | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\\xcf\\r",
+		.flags = ESCAPE_SPACE | ESCAPE_HEX | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\\xcf\\x0d",
+		.flags = ESCAPE_SPECIAL | ESCAPE_HEX | ESCAPE_NAP,
+	},{
+		.out = "\007 \eb\"\x90\\xcf\\r",
+		.flags = ESCAPE_SPACE | ESCAPE_SPECIAL | ESCAPE_HEX | ESCAPE_NAP,
+	},{
+		/* terminator */
+	}}
 },{
 	/* terminator */
 }};
@@ -315,8 +435,13 @@ static __init void test_string_escape(const char *name,
 		/* NULL injection */
 		if (flags & ESCAPE_NULL) {
 			in[p++] = '\0';
-			out_test[q_test++] = '\\';
-			out_test[q_test++] = '0';
+			/* '\0' passes isascii() test */
+			if (flags & ESCAPE_NA && !(flags & ESCAPE_APPEND && esc)) {
+				out_test[q_test++] = '\0';
+			} else {
+				out_test[q_test++] = '\\';
+				out_test[q_test++] = '0';
+			}
 		}
 
 		/* Don't try strings that have no output */
@@ -459,17 +584,17 @@ static int __init test_string_helpers_init(void)
 	unsigned int i;
 
 	pr_info("Running tests...\n");
-	for (i = 0; i < UNESCAPE_ANY + 1; i++)
+	for (i = 0; i < UNESCAPE_ALL_MASK + 1; i++)
 		test_string_unescape("unescape", i, false);
 	test_string_unescape("unescape inplace",
 			     get_random_int() % (UNESCAPE_ANY + 1), true);
 
 	/* Without dictionary */
-	for (i = 0; i < (ESCAPE_ANY_NP | ESCAPE_HEX) + 1; i++)
+	for (i = 0; i < ESCAPE_ALL_MASK + 1; i++)
 		test_string_escape("escape 0", escape0, i, TEST_STRING_2_DICT_0);
 
 	/* With dictionary */
-	for (i = 0; i < (ESCAPE_ANY_NP | ESCAPE_HEX) + 1; i++)
+	for (i = 0; i < ESCAPE_ALL_MASK + 1; i++)
 		test_string_escape("escape 1", escape1, i, TEST_STRING_2_DICT_1);
 
 	/* Test string_get_size() */
-- 
2.30.2

