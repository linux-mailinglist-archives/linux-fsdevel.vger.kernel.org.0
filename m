Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8719A12BB23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 21:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfL0Ubl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 15:31:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41257 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726527AbfL0Ubl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 15:31:41 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBRKVY3S011575
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Dec 2019 15:31:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C9153420485; Fri, 27 Dec 2019 15:31:33 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] memcg: fix a crash in wb_workfn when a device disappears
Date:   Fri, 27 Dec 2019 15:31:17 -0500
Message-Id: <20191227203117.152399-1-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191227194829.150110-1-tytso@mit.edu>
References: <20191227194829.150110-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Without memcg, there is a one-to-one mapping between the bdi and
bdi_writeback structures.  In this world, things are fairly
straightforward; the first thing bdi_unregister() does is to shutdown
the bdi_writeback structure (or wb), and part of that writeback
ensures that no other work queued against the wb, and that the wb is
fully drained.

With memcg, however, there is a one-to-many relationship between the
bdi and bdi_writeback structures; that is, there are multiple wb
objects which can all point to a single bdi.  There is a refcount
which prevents the bdi object from being released (and hence,
unregistered).  So in theory, the bdi_unregister() *should* only get
called once its refcount goes to zero (bdi_put will drop the refcount,
and when it is zero, release_bdi gets called, which calls
bdi_unregister).

Unfortunately, del_gendisk() in block/gen_hd.c never got the memo
about the Brave New memcg World, and calls bdi_unregister directly.
It does this without informing the file system, or the memcg code, or
anything else.  This causes the root wb associated with the bdi to be
unregistered, but none of the memcg-specific wb's are shutdown.  So when
one of these wb's are woken up to do delayed work, they try to
dereference their wb->bdi->dev to fetch the device name, but
unfortunately bdi->dev is now NULL, thanks to the bdi_unregister()
called by del_gendisk().   As a result, *boom*.

Fortunately, it looks like the rest of the writeback path is perfectly
happy with bdi->dev and bdi->owner being NULL, so the simplest fix is
to create a bdi_dev_name() function which can handle bdi->dev being
NULL.  This also allows us to bulletproof the writeback tracepoints to
prevent them from dereferencing a NULL pointer and crashing the kernel
if one is tracing with memcg's enabled, and an iSCSI device dies or a
USB storage stick is pulled.

Previous-Version-Link: https://lore.kernel.org/k/20191227194829.150110-1-tytso@mit.edu
Google-Bug-Id: 145475544
Tested: fs smoke test
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/fs-writeback.c                |  2 +-
 include/linux/backing-dev.h      | 10 +++++++++
 include/trace/events/writeback.h | 37 +++++++++++++++-----------------
 mm/backing-dev.c                 |  1 +
 4 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 335607b8c5c0..76ac9c7d32ec 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2063,7 +2063,7 @@ void wb_workfn(struct work_struct *work)
 						struct bdi_writeback, dwork);
 	long pages_written;
 
-	set_worker_desc("flush-%s", dev_name(wb->bdi->dev));
+	set_worker_desc("flush-%s", bdi_dev_name(wb->bdi));
 	current->flags |= PF_SWAPWRITE;
 
 	if (likely(!current_is_workqueue_rescuer() ||
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 97967ce06de3..f88197c1ffc2 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -13,6 +13,7 @@
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/blkdev.h>
+#include <linux/device.h>
 #include <linux/writeback.h>
 #include <linux/blk-cgroup.h>
 #include <linux/backing-dev-defs.h>
@@ -504,4 +505,13 @@ static inline int bdi_rw_congested(struct backing_dev_info *bdi)
 				  (1 << WB_async_congested));
 }
 
+extern const char *bdi_unknown_name;
+
+static inline const char *bdi_dev_name(struct backing_dev_info *bdi)
+{
+	if (!bdi || !bdi->dev)
+		return bdi_unknown_name;
+	return dev_name(bdi->dev);
+}
+
 #endif	/* _LINUX_BACKING_DEV_H */
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index ef50be4e5e6c..d94def25e4dc 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -67,8 +67,8 @@ DECLARE_EVENT_CLASS(writeback_page_template,
 
 	TP_fast_assign(
 		strscpy_pad(__entry->name,
-			    mapping ? dev_name(inode_to_bdi(mapping->host)->dev) : "(unknown)",
-			    32);
+			    bdi_dev_name(mapping ? inode_to_bdi(mapping->host) :
+					 NULL), 32);
 		__entry->ino = mapping ? mapping->host->i_ino : 0;
 		__entry->index = page->index;
 	),
@@ -111,8 +111,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
 
 		/* may be called for files on pseudo FSes w/ unregistered bdi */
-		strscpy_pad(__entry->name,
-			    bdi->dev ? dev_name(bdi->dev) : "(unknown)", 32);
+		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->flags		= flags;
@@ -193,7 +192,7 @@ TRACE_EVENT(inode_foreign_history,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name, dev_name(inode_to_bdi(inode)->dev), 32);
+		strncpy(__entry->name, bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
 		__entry->history	= history;
@@ -222,7 +221,7 @@ TRACE_EVENT(inode_switch_wbs,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,	dev_name(old_wb->bdi->dev), 32);
+		strncpy(__entry->name,	bdi_dev_name(old_wb->bdi), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->old_cgroup_ino	= __trace_wb_assign_cgroup(old_wb);
 		__entry->new_cgroup_ino	= __trace_wb_assign_cgroup(new_wb);
@@ -255,7 +254,7 @@ TRACE_EVENT(track_foreign_dirty,
 		struct address_space *mapping = page_mapping(page);
 		struct inode *inode = mapping ? mapping->host : NULL;
 
-		strncpy(__entry->name,	dev_name(wb->bdi->dev), 32);
+		strncpy(__entry->name,	bdi_dev_name(wb->bdi), 32);
 		__entry->bdi_id		= wb->bdi->id;
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
@@ -288,7 +287,7 @@ TRACE_EVENT(flush_foreign,
 	),
 
 	TP_fast_assign(
-		strncpy(__entry->name,	dev_name(wb->bdi->dev), 32);
+		strncpy(__entry->name,	bdi_dev_name(wb->bdi), 32);
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 		__entry->frn_bdi_id	= frn_bdi_id;
 		__entry->frn_memcg_id	= frn_memcg_id;
@@ -318,7 +317,7 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
 
 	TP_fast_assign(
 		strscpy_pad(__entry->name,
-			    dev_name(inode_to_bdi(inode)->dev), 32);
+			    bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->sync_mode	= wbc->sync_mode;
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
@@ -361,9 +360,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 		__field(ino_t, cgroup_ino)
 	),
 	TP_fast_assign(
-		strscpy_pad(__entry->name,
-			    wb->bdi->dev ? dev_name(wb->bdi->dev) :
-			    "(unknown)", 32);
+		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
 		__entry->nr_pages = work->nr_pages;
 		__entry->sb_dev = work->sb ? work->sb->s_dev : 0;
 		__entry->sync_mode = work->sync_mode;
@@ -416,7 +413,7 @@ DECLARE_EVENT_CLASS(writeback_class,
 		__field(ino_t, cgroup_ino)
 	),
 	TP_fast_assign(
-		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
 	TP_printk("bdi %s: cgroup_ino=%lu",
@@ -438,7 +435,7 @@ TRACE_EVENT(writeback_bdi_register,
 		__array(char, name, 32)
 	),
 	TP_fast_assign(
-		strscpy_pad(__entry->name, dev_name(bdi->dev), 32);
+		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
 	),
 	TP_printk("bdi %s",
 		__entry->name
@@ -463,7 +460,7 @@ DECLARE_EVENT_CLASS(wbc_class,
 	),
 
 	TP_fast_assign(
-		strscpy_pad(__entry->name, dev_name(bdi->dev), 32);
+		strscpy_pad(__entry->name, bdi_dev_name(bdi), 32);
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->pages_skipped	= wbc->pages_skipped;
 		__entry->sync_mode	= wbc->sync_mode;
@@ -514,7 +511,7 @@ TRACE_EVENT(writeback_queue_io,
 	),
 	TP_fast_assign(
 		unsigned long *older_than_this = work->older_than_this;
-		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
 		__entry->older	= older_than_this ?  *older_than_this : 0;
 		__entry->age	= older_than_this ?
 				  (jiffies - *older_than_this) * 1000 / HZ : -1;
@@ -600,7 +597,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 	),
 
 	TP_fast_assign(
-		strscpy_pad(__entry->bdi, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
 		__entry->write_bw	= KBps(wb->write_bandwidth);
 		__entry->avg_write_bw	= KBps(wb->avg_write_bandwidth);
 		__entry->dirty_rate	= KBps(dirty_rate);
@@ -665,7 +662,7 @@ TRACE_EVENT(balance_dirty_pages,
 
 	TP_fast_assign(
 		unsigned long freerun = (thresh + bg_thresh) / 2;
-		strscpy_pad(__entry->bdi, dev_name(wb->bdi->dev), 32);
+		strscpy_pad(__entry->bdi, bdi_dev_name(wb->bdi), 32);
 
 		__entry->limit		= global_wb_domain.dirty_limit;
 		__entry->setpoint	= (global_wb_domain.dirty_limit +
@@ -726,7 +723,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 
 	TP_fast_assign(
 		strscpy_pad(__entry->name,
-			    dev_name(inode_to_bdi(inode)->dev), 32);
+			    bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
@@ -800,7 +797,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 
 	TP_fast_assign(
 		strscpy_pad(__entry->name,
-			    dev_name(inode_to_bdi(inode)->dev), 32);
+			    bdi_dev_name(inode_to_bdi(inode)), 32);
 		__entry->ino		= inode->i_ino;
 		__entry->state		= inode->i_state;
 		__entry->dirtied_when	= inode->dirtied_when;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index c360f6a6c844..62f05f605fb5 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -21,6 +21,7 @@ struct backing_dev_info noop_backing_dev_info = {
 EXPORT_SYMBOL_GPL(noop_backing_dev_info);
 
 static struct class *bdi_class;
+const char *bdi_unknown_name = "(unknown)";
 
 /*
  * bdi_lock protects bdi_tree and updates to bdi_list. bdi_list has RCU
-- 
2.24.1

