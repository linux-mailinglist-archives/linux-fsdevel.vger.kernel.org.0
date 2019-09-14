Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0DCB2C33
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Sep 2019 18:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfINQQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Sep 2019 12:16:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58126 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfINQQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Sep 2019 12:16:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1i9Aik-0002jh-JO; Sat, 14 Sep 2019 16:16:22 +0000
Date:   Sat, 14 Sep 2019 17:16:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     jack@suse.cz, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        renxudong1@huawei.com, Hou Tao <houtao1@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Re: Possible FS race condition between iterate_dir and
 d_alloc_parallel
Message-ID: <20190914161622.GS1131@ZenIV.linux.org.uk>
References: <fd00be2c-257a-8e1f-eb1e-943a40c71c9a@huawei.com>
 <20190903154007.GJ1131@ZenIV.linux.org.uk>
 <20190903154114.GK1131@ZenIV.linux.org.uk>
 <b5876e84-853c-e1f6-4fef-83d3d45e1767@huawei.com>
 <afdfa1f4-c954-486b-1eb2-efea6fcc2e65@huawei.com>
 <20190909145910.GG1131@ZenIV.linux.org.uk>
 <14888449-3300-756c-2029-8e494b59348b@huawei.com>
 <7e32cda5-dc89-719d-9651-cf2bd06ae728@huawei.com>
 <20190910215357.GH1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910215357.GH1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	OK, folks, could you try the following?  It survives the local beating
so far.

	* replacement of next_positive() with different calling conventions:
it returns struct list_head * instead of struct dentry *; the latter is
passed in and out by reference, grabbing the result and dropping the original
value.
	* scan is under ->d_lock.  If we run out of timeslice, cursor is moved
after the last position we'd reached and we reschedule; then the scan continues
from that place.  To avoid livelocks between multiple lseek() (with cursors
getting moved past each other, never reaching the real entries) we always
skip the cursors, need_resched() or not.
	* returned list_head * is either ->d_child of dentry we'd found or
->d_subdirs of parent (if we got to the end of the list).
	* dcache_readdir() and dcache_dir_lseek() switched to new helper.
dcache_readdir() always holds a reference to dentry passed to dir_emit() now.
Cursor is moved to just before the entry where dir_emit() has failed or into
the very end of the list, if we'd run out.
	* move_cursor() eliminated - it had sucky calling conventions and
after fixing that it became simply list_move() (in lseek and scan_positives)
or list_move_tail() (in readdir).

	All operations with the list are under ->d_lock now, and we do not
depend upon having all file removals done with parent locked exclusive
anymore.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/libfs.c b/fs/libfs.c
index c9b2850c0f7c..e0b262e5fb34 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -89,58 +89,42 @@ int dcache_dir_close(struct inode *inode, struct file *file)
 EXPORT_SYMBOL(dcache_dir_close);
 
 /* parent is locked at least shared */
-static struct dentry *next_positive(struct dentry *parent,
-				    struct list_head *from,
-				    int count)
+/*
+ * Returns an element of siblings' list.
+ * We are looking for <count>th positive after <p>; if
+ * found, dentry is grabbed and passed to caller via *<res>.
+ * If no such element exists, the anchor of list is returned
+ * and *<res> is set to NULL.
+ */
+static struct list_head *scan_positives(struct dentry *cursor,
+					struct list_head *p,
+					loff_t count,
+					struct dentry **res)
 {
-	unsigned *seq = &parent->d_inode->i_dir_seq, n;
-	struct dentry *res;
-	struct list_head *p;
-	bool skipped;
-	int i;
+	struct dentry *dentry = cursor->d_parent, *found = NULL;
 
-retry:
-	i = count;
-	skipped = false;
-	n = smp_load_acquire(seq) & ~1;
-	res = NULL;
-	rcu_read_lock();
-	for (p = from->next; p != &parent->d_subdirs; p = p->next) {
+	spin_lock(&dentry->d_lock);
+	while ((p = p->next) != &dentry->d_subdirs) {
 		struct dentry *d = list_entry(p, struct dentry, d_child);
-		if (!simple_positive(d)) {
-			skipped = true;
-		} else if (!--i) {
-			res = d;
+		// we must at least skip cursors, to avoid livelocks
+		if (d->d_flags & DCACHE_DENTRY_CURSOR)
+			continue;
+		if (simple_positive(d) && !--count) {
+			found = dget(d);
 			break;
 		}
+		if (need_resched()) {
+			list_move(&cursor->d_child, p);
+			p = &cursor->d_child;
+			spin_unlock(&dentry->d_lock);
+			cond_resched();
+			spin_lock(&dentry->d_lock);
+		}
 	}
-	rcu_read_unlock();
-	if (skipped) {
-		smp_rmb();
-		if (unlikely(*seq != n))
-			goto retry;
-	}
-	return res;
-}
-
-static void move_cursor(struct dentry *cursor, struct list_head *after)
-{
-	struct dentry *parent = cursor->d_parent;
-	unsigned n, *seq = &parent->d_inode->i_dir_seq;
-	spin_lock(&parent->d_lock);
-	for (;;) {
-		n = *seq;
-		if (!(n & 1) && cmpxchg(seq, n, n + 1) == n)
-			break;
-		cpu_relax();
-	}
-	__list_del(cursor->d_child.prev, cursor->d_child.next);
-	if (after)
-		list_add(&cursor->d_child, after);
-	else
-		list_add_tail(&cursor->d_child, &parent->d_subdirs);
-	smp_store_release(seq, n + 2);
-	spin_unlock(&parent->d_lock);
+	spin_unlock(&dentry->d_lock);
+	dput(*res);
+	*res = found;
+	return p;
 }
 
 loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
@@ -158,17 +142,28 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
 			return -EINVAL;
 	}
 	if (offset != file->f_pos) {
+		struct dentry *cursor = file->private_data;
+		struct dentry *to = NULL;
+		struct list_head *p;
+
 		file->f_pos = offset;
-		if (file->f_pos >= 2) {
-			struct dentry *cursor = file->private_data;
-			struct dentry *to;
-			loff_t n = file->f_pos - 2;
-
-			inode_lock_shared(dentry->d_inode);
-			to = next_positive(dentry, &dentry->d_subdirs, n);
-			move_cursor(cursor, to ? &to->d_child : NULL);
-			inode_unlock_shared(dentry->d_inode);
+		inode_lock_shared(dentry->d_inode);
+
+		if (file->f_pos > 2) {
+			p = scan_positives(cursor, &dentry->d_subdirs,
+					   file->f_pos - 2, &to);
+			spin_lock(&dentry->d_lock);
+			list_move(&cursor->d_child, p);
+			spin_unlock(&dentry->d_lock);
+		} else {
+			spin_lock(&dentry->d_lock);
+			list_del_init(&cursor->d_child);
+			spin_unlock(&dentry->d_lock);
 		}
+
+		dput(to);
+
+		inode_unlock_shared(dentry->d_inode);
 	}
 	return offset;
 }
@@ -190,25 +185,29 @@ int dcache_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry *dentry = file->f_path.dentry;
 	struct dentry *cursor = file->private_data;
-	struct list_head *p = &cursor->d_child;
-	struct dentry *next;
-	bool moved = false;
+	struct list_head *anchor = &dentry->d_subdirs;
+	struct dentry *next = NULL;
+	struct list_head *p;
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
 
 	if (ctx->pos == 2)
-		p = &dentry->d_subdirs;
-	while ((next = next_positive(dentry, p, 1)) != NULL) {
+		p = anchor;
+	else
+		p = &cursor->d_child;
+
+	while ((p = scan_positives(cursor, p, 1, &next)) != anchor) {
 		if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
 			      d_inode(next)->i_ino, dt_type(d_inode(next))))
 			break;
-		moved = true;
-		p = &next->d_child;
 		ctx->pos++;
 	}
-	if (moved)
-		move_cursor(cursor, p);
+	spin_lock(&dentry->d_lock);
+	list_move_tail(&cursor->d_child, p);
+	spin_unlock(&dentry->d_lock);
+	dput(next);
+
 	return 0;
 }
 EXPORT_SYMBOL(dcache_readdir);
