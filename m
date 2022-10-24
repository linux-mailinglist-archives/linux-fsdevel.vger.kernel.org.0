Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABD1609968
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 06:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJXEuq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 00:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJXEuo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:50:44 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF3084E421;
        Sun, 23 Oct 2022 21:50:41 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 97FC41E80D74;
        Mon, 24 Oct 2022 12:49:24 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Os0l2vBq3zp6; Mon, 24 Oct 2022 12:49:21 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 8B8B41E80CA5;
        Mon, 24 Oct 2022 12:49:21 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     krisman@collabora.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH 1/2] unicode: mkutf8data: Add compound malloc function
Date:   Mon, 24 Oct 2022 12:50:30 +0800
Message-Id: <20221024045030.177438-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The patch has the following modifications.
1. Add unicode_data_malloc function, which realizes the combined use of
malloc and memcpy, and assigns values to dst.
2. Add unicode_data_remalloc function assigns 0 to the data in the
allocated memory pointer. When the integer free parameter specifies 1,
execute free (* dst), and finally assign the value to dst.
3. Remove the original um pointer related code and replace it with these
two functions.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/unicode/mkutf8data.c | 99 +++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 52 deletions(-)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index bc1a7c8b5c8d..adcf018f7985 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -2113,6 +2113,29 @@ static int ignore_compatibility_form(char *type)
 	return 0;
 }
 
+static void unicode_data_malloc(void *src, void **dst, size_t len)
+{
+	unsigned int *um = malloc(len);
+
+	if (um)
+		memcpy(um, src, len);
+
+	*dst = um;
+}
+
+static void unicode_data_remalloc(void **dst, size_t len, int free)
+{
+	unsigned int *um = malloc(len);
+
+	if (free == 1)
+		free(*dst);
+
+	if (um)
+		*um = 0
+
+	*dst = um;
+}
+
 static void nfdi_init(void)
 {
 	FILE *file;
@@ -2120,7 +2143,6 @@ static void nfdi_init(void)
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
 	char *s;
 	char *type;
-	unsigned int *um;
 	int count;
 	int i;
 	int ret;
@@ -2159,10 +2181,8 @@ static void nfdi_init(void)
 		}
 		mapping[i++] = 0;
 
-		um = malloc(i * sizeof(unsigned int));
-		memcpy(um, mapping, i * sizeof(unsigned int));
-		unicode_data[unichar].utf32nfdi = um;
-
+		unicode_data_malloc(mapping, &unicode_data[unichar].utf32nfdi,
+			i * sizeof(unsigned int));
 		if (verbose > 1)
 			print_utf32nfdi(unichar);
 		count++;
@@ -2181,7 +2201,6 @@ static void nfdicf_init(void)
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
 	char status;
 	char *s;
-	unsigned int *um;
 	int i;
 	int count;
 	int ret;
@@ -2215,10 +2234,8 @@ static void nfdicf_init(void)
 		}
 		mapping[i++] = 0;
 
-		um = malloc(i * sizeof(unsigned int));
-		memcpy(um, mapping, i * sizeof(unsigned int));
-		unicode_data[unichar].utf32nfdicf = um;
-
+		unicode_data_malloc(mapping, &unicode_data[unichar].utf32nfdicf,
+				i * sizeof(unsigned int));
 		if (verbose > 1)
 			print_utf32nfdicf(unichar);
 		count++;
@@ -2236,7 +2253,6 @@ static void ignore_init(void)
 	unsigned int unichar;
 	unsigned int first;
 	unsigned int last;
-	unsigned int *um;
 	int count;
 	int ret;
 
@@ -2255,14 +2271,10 @@ static void ignore_init(void)
 			if (!utf32valid(first) || !utf32valid(last))
 				line_fail(prop_name, line);
 			for (unichar = first; unichar <= last; unichar++) {
-				free(unicode_data[unichar].utf32nfdi);
-				um = malloc(sizeof(unsigned int));
-				*um = 0;
-				unicode_data[unichar].utf32nfdi = um;
-				free(unicode_data[unichar].utf32nfdicf);
-				um = malloc(sizeof(unsigned int));
-				*um = 0;
-				unicode_data[unichar].utf32nfdicf = um;
+				unicode_data_remalloc(&unicode_data[unichar].utf32nfdi,
+						sizeof(unsigned int), 1);
+				unicode_data_remalloc(&unicode_data[unichar].utf32nfdicf,
+						sizeof(unsigned int), 1);
 				count++;
 			}
 			if (verbose > 1)
@@ -2276,14 +2288,10 @@ static void ignore_init(void)
 				continue;
 			if (!utf32valid(unichar))
 				line_fail(prop_name, line);
-			free(unicode_data[unichar].utf32nfdi);
-			um = malloc(sizeof(unsigned int));
-			*um = 0;
-			unicode_data[unichar].utf32nfdi = um;
-			free(unicode_data[unichar].utf32nfdicf);
-			um = malloc(sizeof(unsigned int));
-			*um = 0;
-			unicode_data[unichar].utf32nfdicf = um;
+			unicode_data_remalloc(&unicode_data[unichar].utf32nfdi,
+					sizeof(unsigned int), 1);
+			unicode_data_remalloc(&unicode_data[unichar].utf32nfdicf,
+					sizeof(unsigned int), 1);
 			if (verbose > 1)
 				printf(" %X Default_Ignorable_Code_Point\n",
 					unichar);
@@ -2307,7 +2315,6 @@ static void corrections_init(void)
 	unsigned int minor;
 	unsigned int revision;
 	unsigned int age;
-	unsigned int *um;
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
 	char *s;
 	int i;
@@ -2359,10 +2366,8 @@ static void corrections_init(void)
 		}
 		mapping[i++] = 0;
 
-		um = malloc(i * sizeof(unsigned int));
-		memcpy(um, mapping, i * sizeof(unsigned int));
-		corrections[count].utf32nfdi = um;
-
+		unicode_data_malloc(mapping, &corrections[count].utf32nfdi,
+				i * sizeof(unsigned int));
 		if (verbose > 1)
 			printf(" %X -> %s -> %s V%d_%d_%d\n",
 				unichar, buf0, buf1, major, minor, revision);
@@ -2437,7 +2442,6 @@ static void hangul_decompose(void)
 	/* unsigned int sc = (lc * nc); */
 	unsigned int unichar;
 	unsigned int mapping[4];
-	unsigned int *um;
         int count;
 	int i;
 
@@ -2459,14 +2463,12 @@ static void hangul_decompose(void)
 		mapping[i++] = 0;
 
 		assert(!unicode_data[unichar].utf32nfdi);
-		um = malloc(i * sizeof(unsigned int));
-		memcpy(um, mapping, i * sizeof(unsigned int));
-		unicode_data[unichar].utf32nfdi = um;
+		unicode_data_malloc(mapping, &unicode_data[unichar].utf32nfdi,
+				i * sizeof(unsigned int));
 
 		assert(!unicode_data[unichar].utf32nfdicf);
-		um = malloc(i * sizeof(unsigned int));
-		memcpy(um, mapping, i * sizeof(unsigned int));
-		unicode_data[unichar].utf32nfdicf = um;
+		unicode_data_malloc(mapping, &unicode_data[unichar].utf32nfdicf,
+				i * sizeof(unsigned int));
 
 		/*
 		 * Add a cookie as a reminder that the hangul syllable
@@ -2490,7 +2492,6 @@ static void nfdi_decompose(void)
 {
 	unsigned int unichar;
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
-	unsigned int *um;
 	unsigned int *dc;
 	int count;
 	int i;
@@ -2522,16 +2523,13 @@ static void nfdi_decompose(void)
 			mapping[i++] = 0;
 			if (ret)
 				break;
-			free(unicode_data[unichar].utf32nfdi);
-			um = malloc(i * sizeof(unsigned int));
-			memcpy(um, mapping, i * sizeof(unsigned int));
-			unicode_data[unichar].utf32nfdi = um;
+			unicode_data_remalloc(&unicode_data[unichar].utf32nfdi,
+					i * sizeof(unsigned int), 1);
 		}
 		/* Add this decomposition to nfdicf if there is no entry. */
 		if (!unicode_data[unichar].utf32nfdicf) {
-			um = malloc(i * sizeof(unsigned int));
-			memcpy(um, mapping, i * sizeof(unsigned int));
-			unicode_data[unichar].utf32nfdicf = um;
+			unicode_data_remalloc(&unicode_data[unichar].utf32nfdicf,
+					i * sizeof(unsigned int), 0);
 		}
 		if (verbose > 1)
 			print_utf32nfdi(unichar);
@@ -2545,7 +2543,6 @@ static void nfdicf_decompose(void)
 {
 	unsigned int unichar;
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
-	unsigned int *um;
 	unsigned int *dc;
 	int count;
 	int i;
@@ -2576,10 +2573,8 @@ static void nfdicf_decompose(void)
 			mapping[i++] = 0;
 			if (ret)
 				break;
-			free(unicode_data[unichar].utf32nfdicf);
-			um = malloc(i * sizeof(unsigned int));
-			memcpy(um, mapping, i * sizeof(unsigned int));
-			unicode_data[unichar].utf32nfdicf = um;
+			unicode_data_remalloc(&unicode_data[unichar].utf32nfdicf,
+					i * sizeof(unsigned int), 1);
 		}
 		if (verbose > 1)
 			print_utf32nfdicf(unichar);
-- 
2.18.2

