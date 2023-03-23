Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F75F6C63E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 10:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjCWJmb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 05:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjCWJm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:42:28 -0400
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB751A952;
        Thu, 23 Mar 2023 02:42:25 -0700 (PDT)
X-QQ-mid: bizesmtp81t1679564275tucju5hh
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Mar 2023 17:37:54 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: oAZ4GxcAC/U4hZiQyDBn8H5sWH7ScPQ86jUr7hjTo2DIrIVN/YIU2iiZ1kRJw
        +y7k5jY/d+3MuGGGhRuStbii8CIK4GvxIim8ngThprC70S6NaorS/pRTM5wFOfqjEPqlD3H
        hbvBDEMwjG3OtO53qCnwE+xzU14hpgyTeAOy90CBnbGOgCFBtNPgHmono8DxpsPXhKaRHFA
        /McrbzMwOgtepFDmmUOlWBqeCBuSFNqCm9xqyRSi17WGJ0BSlClCmKSSFPf2z1NaJiU9Ud/
        nP7ag8lJyZqesef1WuxW/pympfs9FZWBwB4uC6QTlF1mu4t78XY6hGlhd+/6iVlU4xKJG5w
        hRaa4F8ZtAHDNu37OGFreVYn4/wGDoIKLKWfgGKdl22VbAnSfMlKC7ntcNCCw==
X-QQ-GoodBg: 2
From:   gouhao@uniontech.com
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/buffer: adjust the order of might_sleep() in __getblk_gfp()
Date:   Thu, 23 Mar 2023 17:37:52 +0800
Message-Id: <20230323093752.17461-1-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gou Hao <gouhao@uniontech.com>

If 'bh' is found in cache, just return directly.
might_sleep() is only required on slow paths.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 fs/buffer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9e1e2add541e..e13eff504fb5 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1371,10 +1371,11 @@ __getblk_gfp(struct block_device *bdev, sector_t block,
 {
 	struct buffer_head *bh = __find_get_block(bdev, block, size);
 
+	if (bh)
+		return bh;
+
 	might_sleep();
-	if (bh == NULL)
-		bh = __getblk_slow(bdev, block, size, gfp);
-	return bh;
+	return __getblk_slow(bdev, block, size, gfp);
 }
 EXPORT_SYMBOL(__getblk_gfp);
 
-- 
2.20.1

