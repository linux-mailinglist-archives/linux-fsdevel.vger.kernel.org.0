Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBA8609E7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiJXKDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 06:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiJXKDA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:03:00 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F24F57266;
        Mon, 24 Oct 2022 03:02:52 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 8E59A1E80D74;
        Mon, 24 Oct 2022 18:01:34 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U1Q5bK8zPeXr; Mon, 24 Oct 2022 18:01:31 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id CD0E91E80CA5;
        Mon, 24 Oct 2022 18:01:31 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     krisman@collabora.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] unicode: mkutf8data: Add unicode_data_remalloc function
Date:   Mon, 24 Oct 2022 18:02:46 +0800
Message-Id: <20221024100246.180280-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add unicode_data_remalloc function, used to simplify unicode_data member
assignment use.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/unicode/mkutf8data.c | 58 ++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index bc1a7c8b5c8d..366de944fed3 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -2230,13 +2230,25 @@ static void nfdicf_init(void)
 		file_fail(fold_name);
 }
 
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
 static void ignore_init(void)
 {
 	FILE *file;
 	unsigned int unichar;
 	unsigned int first;
 	unsigned int last;
-	unsigned int *um;
 	int count;
 	int ret;
 
@@ -2255,14 +2267,10 @@ static void ignore_init(void)
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
@@ -2276,14 +2284,11 @@ static void ignore_init(void)
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
+
+			unicode_data_remalloc(&unicode_data[unichar].utf32nfdi,
+					sizeof(unsigned int), 1);
+			unicode_data_remalloc(&unicode_data[unichar].utf32nfdicf,
+					sizeof(unsigned int), 1);
 			if (verbose > 1)
 				printf(" %X Default_Ignorable_Code_Point\n",
 					unichar);
@@ -2490,7 +2495,6 @@ static void nfdi_decompose(void)
 {
 	unsigned int unichar;
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
-	unsigned int *um;
 	unsigned int *dc;
 	int count;
 	int i;
@@ -2522,16 +2526,13 @@ static void nfdi_decompose(void)
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
@@ -2545,7 +2546,6 @@ static void nfdicf_decompose(void)
 {
 	unsigned int unichar;
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
-	unsigned int *um;
 	unsigned int *dc;
 	int count;
 	int i;
@@ -2576,10 +2576,8 @@ static void nfdicf_decompose(void)
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

