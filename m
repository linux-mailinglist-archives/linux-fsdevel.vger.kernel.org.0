Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0772ED45B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2019 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfJKQtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Oct 2019 12:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJKQtj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:49:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9F7FD30BCBA2;
        Fri, 11 Oct 2019 16:49:39 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5154D1001B33;
        Fri, 11 Oct 2019 16:49:39 +0000 (UTC)
To:     fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Josef Bacik <jbacik@fb.com>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] fs: avoid softlockups in s_inodes iterators
Message-ID: <841d0e0f-f04c-9611-2eea-0bcc40e5b084@redhat.com>
Date:   Fri, 11 Oct 2019 11:49:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 11 Oct 2019 16:49:39 +0000 (UTC)
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
loop.

One remains: remove_dquot_ref(), because I'm not quite sure how to deal
with that one w/o taking the i_lock.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d31b6c72b476..dc1a1d5d825b 100644
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
index fef457a42882..b0c789bb3dba 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -676,6 +676,7 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 	struct inode *inode, *next;
 	LIST_HEAD(dispose);
 
+again:
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
@@ -698,6 +699,13 @@ int invalidate_inodes(struct super_block *sb, bool kill_dirty)
 		inode_lru_list_del(inode);
 		spin_unlock(&inode->i_lock);
 		list_add(&inode->i_lru, &dispose);
+
+		if (need_resched()) {
+			spin_unlock(&sb->s_inode_list_lock);
+			cond_resched();
+			dispose_list(&dispose);
+			goto again;
+		}
 	}
 	spin_unlock(&sb->s_inode_list_lock);
 
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2ecef6155fc0..15f77cbbd188 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -67,22 +67,19 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
-		if (iput_inode)
-			iput(iput_inode);
-
+		iput(iput_inode);
 		/* for each watch, send FS_UNMOUNT and then remove it */
 		fsnotify(inode, FS_UNMOUNT, inode, FSNOTIFY_EVENT_INODE, NULL, 0);
-
 		fsnotify_inode_delete(inode);
 
 		iput_inode = inode;
 
+		cond_resched();
 		spin_lock(&sb->s_inode_list_lock);
 	}
 	spin_unlock(&sb->s_inode_list_lock);
+	iput(iput_inode);
 
-	if (iput_inode)
-		iput(iput_inode);
 	/* Wait for outstanding inode references from connectors */
 	wait_var_event(&sb->s_fsnotify_inode_refs,
 		       !atomic_long_read(&sb->s_fsnotify_inode_refs));
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 6e826b454082..4a085b3c7cac 100644
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

