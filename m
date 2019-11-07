Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2CDF39E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 21:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfKGUxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 15:53:53 -0500
Received: from sandeen.net ([63.231.237.45]:35652 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfKGUxp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:53:45 -0500
Received: by sandeen.net (Postfix, from userid 500)
        id DC2F119120; Thu,  7 Nov 2019 14:52:35 -0600 (CST)
From:   Eric Sandeen <sandeen@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk
Subject: [PATCH 2/2] fs: call fsnotify_sb_delete after evict_inodes
Date:   Thu,  7 Nov 2019 14:52:34 -0600
Message-Id: <1573159954-27846-3-git-send-email-sandeen@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573159954-27846-1-git-send-email-sandeen@redhat.com>
References: <1573159954-27846-1-git-send-email-sandeen@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a filesystem is unmounted, we currently call fsnotify_sb_delete()
before evict_inodes(), which means that fsnotify_unmount_inodes()
must iterate over all inodes on the superblock, even though it will
only act on inodes with a refcount.  This is inefficient and can lead
to livelocks as it iterates over many unrefcounted inodes.

However, since fsnotify_sb_delete() and evict_inodes() are working
on orthogonal sets of inodes (fsnotify_sb_delete() only cares about
nonzero refcount, and evict_inodes() only cares about zero refcount),
we can swap the order of the calls.  The fsnotify call will then have
a much smaller list to walk (any refcounted inodes).

This should speed things up overall, and avoid livelocks in
fsnotify_unmount_inodes().

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c | 3 +++
 fs/super.c           | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index ac9eb27..f44e39c 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -57,6 +57,9 @@ static void fsnotify_unmount_inodes(struct super_block *sb)
 		 * doing an __iget/iput with SB_ACTIVE clear would actually
 		 * evict all inodes with zero i_count from icache which is
 		 * unnecessarily violent and may in fact be illegal to do.
+		 * However, we should have been called /after/ evict_inodes
+		 * removed all zero refcount inodes, in any case.  Test to
+		 * be sure.
 		 */
 		if (!atomic_read(&inode->i_count)) {
 			spin_unlock(&inode->i_lock);
diff --git a/fs/super.c b/fs/super.c
index cfadab2..cd35253 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -448,10 +448,12 @@ void generic_shutdown_super(struct super_block *sb)
 		sync_filesystem(sb);
 		sb->s_flags &= ~SB_ACTIVE;
 
-		fsnotify_sb_delete(sb);
 		cgroup_writeback_umount();
 
+		/* evict all inodes with zero refcount */
 		evict_inodes(sb);
+		/* only nonzero refcount inodes can have marks */
+		fsnotify_sb_delete(sb);
 
 		if (sb->s_dio_done_wq) {
 			destroy_workqueue(sb->s_dio_done_wq);
-- 
1.8.3.1

