Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D67609D28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 10:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJXIwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJXIwf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:52:35 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F37156BA3;
        Mon, 24 Oct 2022 01:52:33 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 40B871E80D74;
        Mon, 24 Oct 2022 16:51:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z6o2LBHNephC; Mon, 24 Oct 2022 16:51:13 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 5B6531E80CA5;
        Mon, 24 Oct 2022 16:51:13 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     krisman@collabora.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] unicode: mkutf8data: Add unicode_data_malloc function
Date:   Mon, 24 Oct 2022 16:52:22 +0800
Message-Id: <20221024085222.179528-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add unicode_data_malloc function, used to simplify unicode_data member
assignment use.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/unicode/mkutf8data.c | 43 +++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index bc1a7c8b5c8d..f86fa700f7dc 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -2113,6 +2113,16 @@ static int ignore_compatibility_form(char *type)
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
 static void nfdi_init(void)
 {
 	FILE *file;
@@ -2120,7 +2130,6 @@ static void nfdi_init(void)
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
 	char *s;
 	char *type;
-	unsigned int *um;
 	int count;
 	int i;
 	int ret;
@@ -2159,10 +2168,8 @@ static void nfdi_init(void)
 		}
 		mapping[i++] = 0;
 
-		um = malloc(i * sizeof(unsigned int));
-		memcpy(um, mapping, i * sizeof(unsigned int));
-		unicode_data[unichar].utf32nfdi = um;
-
+		unicode_data_malloc(mapping, &unicode_data[unichar].utf32nfdi,
+				i * sizeof(unsigned int));
 		if (verbose > 1)
 			print_utf32nfdi(unichar);
 		count++;
@@ -2181,7 +2188,6 @@ static void nfdicf_init(void)
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
 	char status;
 	char *s;
-	unsigned int *um;
 	int i;
 	int count;
 	int ret;
@@ -2215,10 +2221,8 @@ static void nfdicf_init(void)
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
@@ -2307,7 +2311,6 @@ static void corrections_init(void)
 	unsigned int minor;
 	unsigned int revision;
 	unsigned int age;
-	unsigned int *um;
 	unsigned int mapping[19]; /* Magic - guaranteed not to be exceeded. */
 	char *s;
 	int i;
@@ -2359,10 +2362,8 @@ static void corrections_init(void)
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
@@ -2437,7 +2438,6 @@ static void hangul_decompose(void)
 	/* unsigned int sc = (lc * nc); */
 	unsigned int unichar;
 	unsigned int mapping[4];
-	unsigned int *um;
         int count;
 	int i;
 
@@ -2458,15 +2458,12 @@ static void hangul_decompose(void)
 			mapping[i++] = tb + ti;
 		mapping[i++] = 0;
 
-		assert(!unicode_data[unichar].utf32nfdi);
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
-- 
2.18.2

