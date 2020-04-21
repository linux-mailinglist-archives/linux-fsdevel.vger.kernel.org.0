Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DB01B220F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 10:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgDUIyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 04:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:41492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUIyu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:54:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9BE5ACAE;
        Tue, 21 Apr 2020 08:54:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 35A851E1233; Tue, 21 Apr 2020 10:54:48 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] writeback: Export inode_io_list_del()
Date:   Tue, 21 Apr 2020 10:54:44 +0200
Message-Id: <20200421085445.5731-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200421085445.5731-1-jack@suse.cz>
References: <20200421085445.5731-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ext4 needs to remove inode from writeback lists after it is out of
visibility of its journalling machinery (which can still dirty the
inode). Export inode_io_list_del() for it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c         | 1 +
 fs/internal.h             | 2 --
 include/linux/writeback.h | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 76ac9c7d32ec..e58bd5f758d0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1126,6 +1126,7 @@ void inode_io_list_del(struct inode *inode)
 	inode_io_list_del_locked(inode, wb);
 	spin_unlock(&wb->list_lock);
 }
+EXPORT_SYMBOL(inode_io_list_del);
 
 /*
  * mark an inode as under writeback on the sb
diff --git a/fs/internal.h b/fs/internal.h
index aa5d45524e87..8819d0d58b03 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -143,8 +143,6 @@ extern int dentry_needs_remove_privs(struct dentry *dentry);
 /*
  * fs-writeback.c
  */
-extern void inode_io_list_del(struct inode *inode);
-
 extern long get_nr_dirty_inodes(void);
 extern int invalidate_inodes(struct super_block *, bool);
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index a19d845dd7eb..902aa317621b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -197,6 +197,7 @@ void wakeup_flusher_threads(enum wb_reason reason);
 void wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 				enum wb_reason reason);
 void inode_wait_for_writeback(struct inode *inode);
+void inode_io_list_del(struct inode *inode);
 
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)
-- 
2.16.4

