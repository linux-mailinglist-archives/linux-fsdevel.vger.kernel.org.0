Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAF85FE9E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJNH5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 03:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJNH5R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:57:17 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 597111B94F5;
        Fri, 14 Oct 2022 00:57:16 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 2F4F71E80D90;
        Fri, 14 Oct 2022 15:57:09 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N3Taxyhs6Dc4; Fri, 14 Oct 2022 15:57:06 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 348131E80D6E;
        Fri, 14 Oct 2022 15:57:06 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     krisman@collabora.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] unicode: mkutf8data: Add malloc return value detection
Date:   Fri, 14 Oct 2022 15:57:10 +0800
Message-Id: <20221014075710.310943-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the check and judgment statement of malloc return value.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/unicode/mkutf8data.c | 42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index bc1a7c8b5c8d..d7f7f7c4cf56 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -495,6 +495,9 @@ static struct node *alloc_node(struct node *parent)
 	int bitnum;
 
 	node = malloc(sizeof(*node));
+	if (unlikely(!node))
+		return NULL;
+
 	node->left = node->right = NULL;
 	node->parent = parent;
 	node->leftnode = NODE;
@@ -2160,6 +2163,9 @@ static void nfdi_init(void)
 		mapping[i++] = 0;
 
 		um = malloc(i * sizeof(unsigned int));
+		if (unlikely(!um))
+			return;
+
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdi = um;
 
@@ -2216,6 +2222,9 @@ static void nfdicf_init(void)
 		mapping[i++] = 0;
 
 		um = malloc(i * sizeof(unsigned int));
+		if (unlikely(!um))
+			return;
+
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdicf = um;
 
@@ -2257,10 +2266,16 @@ static void ignore_init(void)
 			for (unichar = first; unichar <= last; unichar++) {
 				free(unicode_data[unichar].utf32nfdi);
 				um = malloc(sizeof(unsigned int));
+				if (unlikely(!um))
+					return;
+
 				*um = 0;
 				unicode_data[unichar].utf32nfdi = um;
 				free(unicode_data[unichar].utf32nfdicf);
 				um = malloc(sizeof(unsigned int));
+				if (unlikely(!um))
+					return;
+
 				*um = 0;
 				unicode_data[unichar].utf32nfdicf = um;
 				count++;
@@ -2278,10 +2293,16 @@ static void ignore_init(void)
 				line_fail(prop_name, line);
 			free(unicode_data[unichar].utf32nfdi);
 			um = malloc(sizeof(unsigned int));
+			if (unlikely(!um))
+				return;
+
 			*um = 0;
 			unicode_data[unichar].utf32nfdi = um;
 			free(unicode_data[unichar].utf32nfdicf);
 			um = malloc(sizeof(unsigned int));
+			if (unlikely(!um))
+				return;
+
 			*um = 0;
 			unicode_data[unichar].utf32nfdicf = um;
 			if (verbose > 1)
@@ -2360,6 +2381,9 @@ static void corrections_init(void)
 		mapping[i++] = 0;
 
 		um = malloc(i * sizeof(unsigned int));
+		if (unlikely(!um))
+			return;
+
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		corrections[count].utf32nfdi = um;
 
@@ -2460,11 +2484,17 @@ static void hangul_decompose(void)
 
 		assert(!unicode_data[unichar].utf32nfdi);
 		um = malloc(i * sizeof(unsigned int));
+		if (unlikely(!um))
+			return;
+
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdi = um;
 
 		assert(!unicode_data[unichar].utf32nfdicf);
 		um = malloc(i * sizeof(unsigned int));
+		if (unlikely(!um))
+			return;
+
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdicf = um;
 
@@ -2474,6 +2504,9 @@ static void hangul_decompose(void)
 		 * trie.
 		 */
 		unicode_data[unichar].utf8nfdi = malloc(2);
+		if (unlikely(!(unicode_data[unichar].utf8nfdi)))
+			return;
+
 		unicode_data[unichar].utf8nfdi[0] = HANGUL;
 		unicode_data[unichar].utf8nfdi[1] = '\0';
 
@@ -2524,12 +2557,18 @@ static void nfdi_decompose(void)
 				break;
 			free(unicode_data[unichar].utf32nfdi);
 			um = malloc(i * sizeof(unsigned int));
+			if (unlikely(!um))
+				return;
+
 			memcpy(um, mapping, i * sizeof(unsigned int));
 			unicode_data[unichar].utf32nfdi = um;
 		}
 		/* Add this decomposition to nfdicf if there is no entry. */
 		if (!unicode_data[unichar].utf32nfdicf) {
 			um = malloc(i * sizeof(unsigned int));
+			if (unlikely(!um))
+				return;
+
 			memcpy(um, mapping, i * sizeof(unsigned int));
 			unicode_data[unichar].utf32nfdicf = um;
 		}
@@ -2578,6 +2617,9 @@ static void nfdicf_decompose(void)
 				break;
 			free(unicode_data[unichar].utf32nfdicf);
 			um = malloc(i * sizeof(unsigned int));
+			if (unlikely(!um))
+				return;
+
 			memcpy(um, mapping, i * sizeof(unsigned int));
 			unicode_data[unichar].utf32nfdicf = um;
 		}
-- 
2.18.2

