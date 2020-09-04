Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D109825D320
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 10:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgIDH7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 03:59:53 -0400
Received: from song.cn.fujitsu.com ([218.97.8.244]:53253 "EHLO
        song.cn.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgIDH7u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:59:50 -0400
X-IronPort-AV: E=Sophos;i="5.76,388,1592841600"; 
   d="scan'208";a="4857907"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.250.3])
  by song.cn.fujitsu.com with ESMTP; 04 Sep 2020 15:59:41 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5D55241AF17F;
        Fri,  4 Sep 2020 15:59:41 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 4 Sep 2020 15:59:41 +0800
Received: from localhost.localdomain (10.167.225.206) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 4 Sep 2020 15:59:39 +0800
From:   Hao Li <lihao2018.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC:     <david@fromorbit.com>, <ira.weiny@intel.com>,
        <linux-xfs@vger.kernel.org>, <lihao2018.fnst@cn.fujitsu.com>,
        <y-goto@fujitsu.com>
Subject: [PATCH v2] fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()
Date:   Fri, 4 Sep 2020 15:59:39 +0800
Message-ID: <20200904075939.176366-1-lihao2018.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 5D55241AF17F.ABDC4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If generic_drop_inode() returns true, it means iput_final() can evict
this inode regardless of whether it is dirty or not. If we check
I_DONTCACHE in generic_drop_inode(), any inode with this bit set will be
evicted unconditionally. This is not the desired behavior because
I_DONTCACHE only means the inode shouldn't be cached on the LRU list.
As for whether we need to evict this inode, this is what
generic_drop_inode() should do. This patch corrects the usage of
I_DONTCACHE.

This patch was proposed in [1].

[1]: https://lore.kernel.org/linux-fsdevel/20200831003407.GE12096@dread.disaster.area/

Fixes: dae2f8ed7992 ("fs: Lift XFS_IDONTCACHE to the VFS layer")
Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
---
Changes in v2:
 - Adjust code format
 - Add Fixes tag in commit message

 fs/inode.c         | 4 +++-
 include/linux/fs.h | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..19ad823f781c 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1625,7 +1625,9 @@ static void iput_final(struct inode *inode)
 	else
 		drop = generic_drop_inode(inode);
 
-	if (!drop && (sb->s_flags & SB_ACTIVE)) {
+	if (!drop &&
+	    !(inode->i_state & I_DONTCACHE) &&
+	    (sb->s_flags & SB_ACTIVE)) {
 		inode_add_lru(inode);
 		spin_unlock(&inode->i_lock);
 		return;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e019ea2f1347..93caee80ce47 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2922,8 +2922,7 @@ extern int inode_needs_sync(struct inode *inode);
 extern int generic_delete_inode(struct inode *inode);
 static inline int generic_drop_inode(struct inode *inode)
 {
-	return !inode->i_nlink || inode_unhashed(inode) ||
-		(inode->i_state & I_DONTCACHE);
+	return !inode->i_nlink || inode_unhashed(inode);
 }
 extern void d_mark_dontcache(struct inode *inode);
 
-- 
2.28.0



