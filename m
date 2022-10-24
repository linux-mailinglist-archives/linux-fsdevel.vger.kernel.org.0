Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E560996B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 06:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJXEv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 00:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJXEvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:51:55 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBD7C79924;
        Sun, 23 Oct 2022 21:51:54 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id B5CB01E80D76;
        Mon, 24 Oct 2022 12:50:38 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JBDSWh3XdTol; Mon, 24 Oct 2022 12:50:36 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 1DF461E80D74;
        Mon, 24 Oct 2022 12:50:36 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     krisman@collabora.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH 2/2] unicode: mkutf8data: Add malloc allocation check
Date:   Mon, 24 Oct 2022 12:51:50 +0800
Message-Id: <20221024045150.177521-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Increase the judgment of malloc allocation, and return NULL if the
condition is met.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/unicode/mkutf8data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
index e06404a6b106..a929ddf1438c 100644
--- a/fs/unicode/mkutf8data.c
+++ b/fs/unicode/mkutf8data.c
@@ -495,6 +495,9 @@ static struct node *alloc_node(struct node *parent)
 	int bitnum;
 
 	node = malloc(sizeof(*node));
+	if (!node)
+		return NULL;
+
 	node->left = node->right = NULL;
 	node->parent = parent;
 	node->leftnode = NODE;
-- 
2.18.2

