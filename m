Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2165D4EA577
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 04:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiC2Cvy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 22:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiC2Cvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:51:53 -0400
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [221.176.66.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D82B21B2C7E
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Mar 2022 19:50:08 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1])
        by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7624273de4e6-a6e3f;
        Tue, 29 Mar 2022 10:50:06 +0800 (CST)
X-RM-TRANSID: 2ee7624273de4e6-a6e3f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.97])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1624273d7365-c47dc;
        Tue, 29 Mar 2022 10:50:06 +0800 (CST)
X-RM-TRANSID: 2ee1624273d7365-c47dc
From:   jianchunfu <jianchunfu@cmss.chinamobile.com>
To:     krisman@collabora.com, ebiggers@kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: [PATCH] unicode: Handle memory allocation failures in mkutf8data
Date:   Tue, 29 Mar 2022 10:49:54 +0800
Message-Id: <20220329024954.12721-1-jianchunfu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding and using a helper function "xmalloc()"
to handle memory allocation failures.

Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>
---
 fs/unicode/mkutf8data.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index bc1a7c8b5..baf1d7eda 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -486,6 +486,16 @@ static void tree_walk(struct tree *tree)
 	       nodes, leaves, singletons);
 }
 
+static void *xmalloc(size_t size)
+{
+	void *p = malloc(size);
+
+	if (p)
+		return p;
+	fprintf(stderr, "Out of memory.\n");
+	exit(1);
+}
+
 /*
  * Allocate an initialize a new internal node.
  */
@@ -494,7 +504,7 @@ static struct node *alloc_node(struct node *parent)
 	struct node *node;
 	int bitnum;
 
-	node = malloc(sizeof(*node));
+	node = xmalloc(sizeof(*node));
 	node->left = node->right = NULL;
 	node->parent = parent;
 	node->leftnode = NODE;
@@ -2159,7 +2169,7 @@ static void nfdi_init(void)
 		}
 		mapping[i++] = 0;
 
-		um = malloc(i * sizeof(unsigned int));
+		um = xmalloc(i * sizeof(unsigned int));
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdi = um;
 
@@ -2215,7 +2225,7 @@ static void nfdicf_init(void)
 		}
 		mapping[i++] = 0;
 
-		um = malloc(i * sizeof(unsigned int));
+		um = xmalloc(i * sizeof(unsigned int));
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdicf = um;
 
@@ -2256,11 +2266,11 @@ static void ignore_init(void)
 				line_fail(prop_name, line);
 			for (unichar = first; unichar <= last; unichar++) {
 				free(unicode_data[unichar].utf32nfdi);
-				um = malloc(sizeof(unsigned int));
+				um = xmalloc(sizeof(unsigned int));
 				*um = 0;
 				unicode_data[unichar].utf32nfdi = um;
 				free(unicode_data[unichar].utf32nfdicf);
-				um = malloc(sizeof(unsigned int));
+				um = xmalloc(sizeof(unsigned int));
 				*um = 0;
 				unicode_data[unichar].utf32nfdicf = um;
 				count++;
@@ -2277,11 +2287,11 @@ static void ignore_init(void)
 			if (!utf32valid(unichar))
 				line_fail(prop_name, line);
 			free(unicode_data[unichar].utf32nfdi);
-			um = malloc(sizeof(unsigned int));
+			um = xmalloc(sizeof(unsigned int));
 			*um = 0;
 			unicode_data[unichar].utf32nfdi = um;
 			free(unicode_data[unichar].utf32nfdicf);
-			um = malloc(sizeof(unsigned int));
+			um = xmalloc(sizeof(unsigned int));
 			*um = 0;
 			unicode_data[unichar].utf32nfdicf = um;
 			if (verbose > 1)
@@ -2359,7 +2369,7 @@ static void corrections_init(void)
 		}
 		mapping[i++] = 0;
 
-		um = malloc(i * sizeof(unsigned int));
+		um = xmalloc(i * sizeof(unsigned int));
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		corrections[count].utf32nfdi = um;
 
@@ -2459,12 +2469,12 @@ static void hangul_decompose(void)
 		mapping[i++] = 0;
 
 		assert(!unicode_data[unichar].utf32nfdi);
-		um = malloc(i * sizeof(unsigned int));
+		um = xmalloc(i * sizeof(unsigned int));
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdi = um;
 
 		assert(!unicode_data[unichar].utf32nfdicf);
-		um = malloc(i * sizeof(unsigned int));
+		um = xmalloc(i * sizeof(unsigned int));
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdicf = um;
 
@@ -2473,7 +2483,7 @@ static void hangul_decompose(void)
 		 * decompositions must not be stored in the generated
 		 * trie.
 		 */
-		unicode_data[unichar].utf8nfdi = malloc(2);
+		unicode_data[unichar].utf8nfdi = xmalloc(2);
 		unicode_data[unichar].utf8nfdi[0] = HANGUL;
 		unicode_data[unichar].utf8nfdi[1] = '\0';
 
@@ -2523,13 +2533,13 @@ static void nfdi_decompose(void)
 			if (ret)
 				break;
 			free(unicode_data[unichar].utf32nfdi);
-			um = malloc(i * sizeof(unsigned int));
+			um = xmalloc(i * sizeof(unsigned int));
 			memcpy(um, mapping, i * sizeof(unsigned int));
 			unicode_data[unichar].utf32nfdi = um;
 		}
 		/* Add this decomposition to nfdicf if there is no entry. */
 		if (!unicode_data[unichar].utf32nfdicf) {
-			um = malloc(i * sizeof(unsigned int));
+			um = xmalloc(i * sizeof(unsigned int));
 			memcpy(um, mapping, i * sizeof(unsigned int));
 			unicode_data[unichar].utf32nfdicf = um;
 		}
@@ -2577,7 +2587,7 @@ static void nfdicf_decompose(void)
 			if (ret)
 				break;
 			free(unicode_data[unichar].utf32nfdicf);
-			um = malloc(i * sizeof(unsigned int));
+			um = xmalloc(i * sizeof(unsigned int));
 			memcpy(um, mapping, i * sizeof(unsigned int));
 			unicode_data[unichar].utf32nfdicf = um;
 		}
-- 
2.18.4



