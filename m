Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9410257728
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 12:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHaKNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 06:13:20 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6214 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgHaKNU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:13:20 -0400
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="98733246"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Aug 2020 18:13:15 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3772C48990D9;
        Mon, 31 Aug 2020 18:13:14 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 31 Aug 2020 18:13:18 +0800
Received: from localhost.localdomain (10.167.225.206) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 18:13:17 +0800
From:   Hao Li <lihao2018.fnst@cn.fujitsu.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <david@fromorbit.com>, <ira.weiny@intel.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <lihao2018.fnst@cn.fujitsu.com>,
        <y-goto@fujitsu.com>
Subject: [PATCH] fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()
Date:   Mon, 31 Aug 2020 18:13:13 +0800
Message-ID: <20200831101313.168889-1-lihao2018.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3772C48990D9.AE7C8
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

Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
---
 fs/inode.c         | 3 ++-
 include/linux/fs.h | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..4e45d5ea3d0f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1625,7 +1625,8 @@ static void iput_final(struct inode *inode)
 	else
 		drop = generic_drop_inode(inode);
 
-	if (!drop && (sb->s_flags & SB_ACTIVE)) {
+	if (!drop && !(inode->i_state & I_DONTCACHE) &&
+			(sb->s_flags & SB_ACTIVE)) {
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



