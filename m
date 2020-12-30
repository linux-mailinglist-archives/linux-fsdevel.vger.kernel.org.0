Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928842E76BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Dec 2020 08:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgL3HCR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Dec 2020 02:02:17 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:35910 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726190AbgL3HCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Dec 2020 02:02:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UKD91kS_1609311686;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UKD91kS_1609311686)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Dec 2020 15:01:34 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] fs: fix: second lock in function d_prune_aliases().
Date:   Wed, 30 Dec 2020 15:01:25 +0800
Message-Id: <1609311685-99562-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Goto statement jumping will cause lock to be executed again without
executing unlock, placing the lock statement in front of goto
label to fix this problem.

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci <abaci@linux.alibaba.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 97e81a8..bf38446 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1050,6 +1050,6 @@ void d_prune_aliases(struct inode *inode)
 {
 	struct dentry *dentry;
-restart:
 	spin_lock(&inode->i_lock);
+restart:
 	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
 		spin_lock(&dentry->d_lock);
-- 
1.8.3.1

