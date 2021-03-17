Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA3633E9CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 07:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCQGfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 02:35:16 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:51377 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230123AbhCQGfG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:35:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0USEL4Xl_1615962899;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0USEL4Xl_1615962899)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Mar 2021 14:35:04 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] attr: replace if (cond) BUG() with BUG_ON()
Date:   Wed, 17 Mar 2021 14:34:59 +0800
Message-Id: <1615962899-77049-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following coccicheck warnings:

./fs/attr.c:349:2-5: WARNING: Use BUG_ON instead of if condition
followed by BUG.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/attr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 87ef39d..43f369e 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -344,9 +344,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 	 * no function will ever call notify_change with both ATTR_MODE and
 	 * ATTR_KILL_S*ID set.
 	 */
-	if ((ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID)) &&
-	    (ia_valid & ATTR_MODE))
-		BUG();
+	BUG_ON((ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID)) && (ia_valid & ATTR_MODE));
 
 	if (ia_valid & ATTR_KILL_SUID) {
 		if (mode & S_ISUID) {
-- 
1.8.3.1

