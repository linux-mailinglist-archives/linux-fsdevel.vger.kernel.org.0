Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F073D5FAA6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 04:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJKCCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 22:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJKCCQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:02:16 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7426F72EEA
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Oct 2022 19:02:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VRv.cl3_1665453732;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VRv.cl3_1665453732)
          by smtp.aliyun-inc.com;
          Tue, 11 Oct 2022 10:02:13 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     shr@fb.com, jack@suse.cz, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: clarify the rerurn value check for inode_needs_update_time
Date:   Tue, 11 Oct 2022 10:02:12 +0800
Message-Id: <20221011020212.131100-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode_needs_update_time() can only returns >0 or 0, which means inode
needs sync or not.
So cleanup the callers return value check, and also cleanup redundant
check in the function before return.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index b608528efd3a..d8f4ba98549a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2071,9 +2071,6 @@ static int inode_needs_update_time(struct inode *inode, struct timespec64 *now)
 	if (IS_I_VERSION(inode) && inode_iversion_need_inc(inode))
 		sync_it |= S_VERSION;
 
-	if (!sync_it)
-		return 0;
-
 	return sync_it;
 }
 
@@ -2113,7 +2110,7 @@ int file_update_time(struct file *file)
 	struct timespec64 now = current_time(inode);
 
 	ret = inode_needs_update_time(inode, &now);
-	if (ret <= 0)
+	if (!ret)
 		return ret;
 
 	return __file_update_time(file, &now, ret);
@@ -2153,7 +2150,7 @@ static int file_modified_flags(struct file *file, int flags)
 		return 0;
 
 	ret = inode_needs_update_time(inode, &now);
-	if (ret <= 0)
+	if (!ret)
 		return ret;
 	if (flags & IOCB_NOWAIT)
 		return -EAGAIN;
-- 
2.24.4

