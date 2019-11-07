Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5527F39E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 21:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfKGUxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 15:53:53 -0500
Received: from sandeen.net ([63.231.237.45]:35646 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbfKGUxp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:53:45 -0500
Received: by sandeen.net (Postfix, from userid 500)
        id CD9741911D; Thu,  7 Nov 2019 14:52:35 -0600 (CST)
From:   Eric Sandeen <sandeen@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
Subject: [PATCH 1/2] fs: avoid softlockups in s_inodes iterators
Date:   Thu,  7 Nov 2019 14:52:33 -0600
Message-Id: <1573159954-27846-2-git-send-email-sandeen@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573159954-27846-1-git-send-email-sandeen@redhat.com>
References: <1573159954-27846-1-git-send-email-sandeen@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Anything that walks all inodes on sb->s_inodes list without rescheduling
risks softlockups.

Previous efforts were made in 2 functions, see:

c27d82f fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
ac05fbb inode: don't softlockup when evicting inodes

but there hasn't been an audit of all walkers, so do that now.  This
also consistently moves the cond_resched() calls to the bottom of each
loop in cases where it already exists.

One loop remains: remove_dquot_ref(), because I'm not quite sure how
to deal with that one w/o taking the i_lock.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/drop_caches.c     | 2 +-
 fs/inode.c           | 7 +++++++
 fs/notify/fsnotify.c | 1 +
 fs/quota/dquot.c     | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d31b6c7..dc1a1d5 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -35,11 +35,11 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
-		cond_resched();
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 		iput(toput_inode);
 		toput_inode = inode;
 
+		cond_resched();
 		spin_lock(&sb->s_inode_list_lock);
 	}
 	spin_unlock(&sb->s_inode_list_lock);
diff --git a/fs/inode.c b/fs/inode.c
index fef457a..96d62d9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -676,6 +676,7 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 	struct inode *inode, *next;
 	LIST_HEAD(dispose);
 
+again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
@@ -698,6 +699,12 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
+		if (need_resched()) {
+			spin_unlock(&sb->s_inode_list_lock);
+			cond_resched();
+			dispose_list(&dispose);
+			goto again;
+		}
 	}
 	spin_unlock(&sb->s_inode_list_lock);
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2ecef61..ac9eb27 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -77,6 +77,7 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 
 		iput_inode = inode;
 
+		cond_resched();
 		spin_lock(&sb->s_inode_list_lock);
 	}
 	spin_unlock(&sb->s_inode_list_lock);
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b4..4a085b3 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -985,6 +985,7 @@ static int add_dquot_ref(struct super_block *sb, int type)
 		 * later.
 		 */
 		old_inode = inode;
+		cond_resched();
 		spin_lock(&sb->s_inode_list_lock);
 	}
 	spin_unlock(&sb->s_inode_list_lock);
-- 
1.8.3.1

