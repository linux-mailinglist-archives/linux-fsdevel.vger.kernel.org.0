Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3BE2ACB5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 03:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgKJC4r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 21:56:47 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:14918 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727311AbgKJC4q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:56:46 -0500
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="101126641"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Nov 2020 10:56:43 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 7A0BB4CE3A70;
        Tue, 10 Nov 2020 10:56:41 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 10 Nov 2020 10:56:40 +0800
Received: from localhost.localdomain (10.167.225.206) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 10 Nov 2020 10:56:40 +0800
From:   Hao Li <lihao2018.fnst@cn.fujitsu.com>
To:     <torvalds@linux-foundation.org>
CC:     <dchinner@redhat.com>, <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>
Subject: [PATCH] fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()
Date:   Tue, 10 Nov 2020 10:56:40 +0800
Message-ID: <20201110025640.5115-1-lihao2018.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7A0BB4CE3A70.ABA2C
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
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
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
This patch may have been forgotten.
Original patch: https://lore.kernel.org/linux-fsdevel/20200904075939.176366-1-lihao2018.fnst@cn.fujitsu.com/

 fs/inode.c         | 4 +++-
 include/linux/fs.h | 3 +--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d78c37b00b8..5eea9912a0b9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1627,7 +1627,9 @@ static void iput_final(struct inode *inode)
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
index 21cc971fd960..fce52d09fc9c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2862,8 +2862,7 @@ extern int inode_needs_sync(struct inode *inode);
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



