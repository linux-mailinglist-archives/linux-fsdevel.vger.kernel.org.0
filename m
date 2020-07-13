Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E2021D060
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jul 2020 09:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgGMHZo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jul 2020 03:25:44 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36588 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbgGMHZo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:25:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U2XFDhX_1594625140;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0U2XFDhX_1594625140)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jul 2020 15:25:41 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk, dhowells@redhat.com
Cc:     linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH] vfs: fix the kernel-doc of find_inode_by_ino_rcu
Date:   Mon, 13 Jul 2020 15:25:27 +0800
Message-Id: <20200713072527.22377-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes: 3f19b2ab97a9 ("vfs, afs, ext4: Make the inode hash table RCU searchable")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/inode.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..1807c0d336b1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1494,21 +1494,13 @@ struct inode *find_inode_rcu(struct super_block *sb, unsigned long hashval,
 EXPORT_SYMBOL(find_inode_rcu);
 
 /**
- * find_inode_by_rcu - Find an inode in the inode cache
+ * find_inode_by_ino_rcu - Find an inode in the inode cache
  * @sb:		Super block of file system to search
  * @ino:	The inode number to match
  *
- * Search for the inode specified by @hashval and @data in the inode cache,
- * where the helper function @test will return 0 if the inode does not match
- * and 1 if it does.  The @test function must be responsible for taking the
- * i_lock spin_lock and checking i_state for an inode being freed or being
- * initialized.
+ * Search for the inode by inode number in the inode cache.
  *
- * If successful, this will return the inode for which the @test function
- * returned 1 and NULL otherwise.
- *
- * The @test function is not permitted to take a ref on any inode presented.
- * It is also not permitted to sleep.
+ * If successful, this will return the inode and NULL otherwise.
  *
  * The caller must hold the RCU read lock.
  */
-- 
2.27.0

