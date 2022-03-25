Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA74E6D30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 05:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347045AbiCYE2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 00:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345757AbiCYE2U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 00:28:20 -0400
X-Greylist: delayed 182 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 21:26:46 PDT
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com [221.176.66.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 268093EB99
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Mar 2022 21:26:45 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15])
        by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb623d43cc07c-70810;
        Fri, 25 Mar 2022 12:23:41 +0800 (CST)
X-RM-TRANSID: 2eeb623d43cc07c-70810
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.108.79.97])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee8623d43c7431-d7472;
        Fri, 25 Mar 2022 12:23:40 +0800 (CST)
X-RM-TRANSID: 2ee8623d43c7431-d7472
From:   jianchunfu <jianchunfu@cmss.chinamobile.com>
To:     krisman@collabora.com
Cc:     linux-fsdevel@vger.kernel.org,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: [PATCH] fs:unicode: Fix the potential stack overflow risk
Date:   Fri, 25 Mar 2022 12:23:15 +0800
Message-Id: <20220325042315.46118-1-jianchunfu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.18.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add judgment to fix the potential stack overflow risk.

Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>
---
 fs/unicode/mkutf8data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index bc1a7c8b5..8c2ace050 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -495,6 +495,10 @@ static struct node *alloc_node(struct node *parent)
 	int bitnum;
 
 	node = malloc(sizeof(*node));
+	if (!node) {
+		printf("Memory allocation failed\n");
+		exit(1);
+	}
 	node->left = node->right = NULL;
 	node->parent = parent;
 	node->leftnode = NODE;
-- 
2.18.4



