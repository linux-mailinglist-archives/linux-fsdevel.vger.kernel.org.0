Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFBD4E6FE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352556AbiCYJQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 05:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242046AbiCYJQ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:16:58 -0400
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com [221.176.66.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24284CF490
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 02:15:18 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9])
        by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1623d8823304-74b51;
        Fri, 25 Mar 2022 17:15:16 +0800 (CST)
X-RM-TRANSID: 2ee1623d8823304-74b51
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.97])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5623d881e783-e50a8;
        Fri, 25 Mar 2022 17:15:16 +0800 (CST)
X-RM-TRANSID: 2ee5623d881e783-e50a8
From:   jianchunfu <jianchunfu@cmss.chinamobile.com>
To:     krisman@collabora.com
Cc:     linux-fsdevel@vger.kernel.org,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: [RFC] fs:unicode:mkutf8data.c: Fix the potential stack overflow risk
Date:   Fri, 25 Mar 2022 17:14:43 +0800
Message-Id: <20220325091443.59677-1-jianchunfu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm not sure why there are so many missing checks of the malloc function,
is it because the memory allocated is only a few bytes
so no checks are needed?

Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>
---
 fs/unicode/mkutf8data.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index 8c2ace050..1f9e3ab1e 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -2164,6 +2164,10 @@ static void nfdi_init(void)
 		mapping[i++] = 0;
 
 		um = malloc(i * sizeof(unsigned int));
+		if (!um) {
+			printf("Memory allocation failed\n");
+			exit(1);
+		}
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdi = um;
 
@@ -2220,6 +2224,10 @@ static void nfdicf_init(void)
 		mapping[i++] = 0;
 
 		um = malloc(i * sizeof(unsigned int));
+		if (!um) {
+			printf("Memory allocation failed\n");
+			exit(1);
+		}
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdicf = um;
 
@@ -2261,10 +2269,18 @@ static void ignore_init(void)
 			for (unichar = first; unichar <= last; unichar++) {
 				free(unicode_data[unichar].utf32nfdi);
 				um = malloc(sizeof(unsigned int));
+				if (!um) {
+					ret = -ENOMEM;
+					goto error_nomem;
+				}
 				*um = 0;
 				unicode_data[unichar].utf32nfdi = um;
 				free(unicode_data[unichar].utf32nfdicf);
 				um = malloc(sizeof(unsigned int));
+				if (!um) {
+					ret = -ENOMEM;
+					goto error_nomem;
+				}
 				*um = 0;
 				unicode_data[unichar].utf32nfdicf = um;
 				count++;
@@ -2282,10 +2298,18 @@ static void ignore_init(void)
 				line_fail(prop_name, line);
 			free(unicode_data[unichar].utf32nfdi);
 			um = malloc(sizeof(unsigned int));
+			if (!um) {
+				ret = -ENOMEM;
+				goto error_nomem;
+			}
 			*um = 0;
 			unicode_data[unichar].utf32nfdi = um;
 			free(unicode_data[unichar].utf32nfdicf);
 			um = malloc(sizeof(unsigned int));
+			if (!um) {
+				ret = -ENOMEM;
+				goto error_nomem;
+			}
 			*um = 0;
 			unicode_data[unichar].utf32nfdicf = um;
 			if (verbose > 1)
@@ -2301,6 +2325,12 @@ static void ignore_init(void)
 		printf("Found %d entries\n", count);
 	if (count == 0)
 		file_fail(prop_name);
+
+error_nomem:
+	if (ret == -ENOMEM) {
+		printf("Memory allocation failed\n");
+		exit(1);
+	}
 }
 
 static void corrections_init(void)
@@ -2364,6 +2394,10 @@ static void corrections_init(void)
 		mapping[i++] = 0;
 
 		um = malloc(i * sizeof(unsigned int));
+		if (!um) {
+			printf("Memory allocation failed\n");
+			exit(1);
+		}
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		corrections[count].utf32nfdi = um;
 
@@ -2464,11 +2498,19 @@ static void hangul_decompose(void)
 
 		assert(!unicode_data[unichar].utf32nfdi);
 		um = malloc(i * sizeof(unsigned int));
+		if (!um) {
+			printf("Memory allocation failed\n");
+			exit(1);
+		}
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdi = um;
 
 		assert(!unicode_data[unichar].utf32nfdicf);
 		um = malloc(i * sizeof(unsigned int));
+		if (!um) {
+			printf("Memory allocation failed\n");
+			exit(1);
+		}
 		memcpy(um, mapping, i * sizeof(unsigned int));
 		unicode_data[unichar].utf32nfdicf = um;
 
@@ -2528,12 +2570,20 @@ static void nfdi_decompose(void)
 				break;
 			free(unicode_data[unichar].utf32nfdi);
 			um = malloc(i * sizeof(unsigned int));
+			if (!um) {
+				printf("Memory allocation failed\n");
+				exit(1);
+			}
 			memcpy(um, mapping, i * sizeof(unsigned int));
 			unicode_data[unichar].utf32nfdi = um;
 		}
 		/* Add this decomposition to nfdicf if there is no entry. */
 		if (!unicode_data[unichar].utf32nfdicf) {
 			um = malloc(i * sizeof(unsigned int));
+			if (!um) {
+				printf("Memory allocation failed\n");
+				exit(1);
+			}
 			memcpy(um, mapping, i * sizeof(unsigned int));
 			unicode_data[unichar].utf32nfdicf = um;
 		}
@@ -2582,6 +2632,10 @@ static void nfdicf_decompose(void)
 				break;
 			free(unicode_data[unichar].utf32nfdicf);
 			um = malloc(i * sizeof(unsigned int));
+			if (!um) {
+				printf("Memory allocation failed\n");
+				exit(1);
+			}
 			memcpy(um, mapping, i * sizeof(unsigned int));
 			unicode_data[unichar].utf32nfdicf = um;
 		}
-- 
2.18.4



