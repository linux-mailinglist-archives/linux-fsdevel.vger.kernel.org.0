Return-Path: <linux-fsdevel+bounces-7330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866C7823A62
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31071288134
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 01:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6495223;
	Thu,  4 Jan 2024 01:53:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A41FA4;
	Thu,  4 Jan 2024 01:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF53C433D9;
	Thu,  4 Jan 2024 01:53:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLCwN-00000000qhq-3STb;
	Wed, 03 Jan 2024 20:54:35 -0500
Message-ID: <20240104015435.682218477@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 03 Jan 2024 20:52:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ajay Kaher <akaher@vmware.com>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] eventfs: Stop using dcache_readdir() for getdents()
References: <20240104015247.075935881@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The eventfs creates dynamically allocated dentries and inodes. Using the
dcache_readdir() logic for its own directory lookups requires hiding the
cursor of the dcache logic and playing games to allow the dcache_readdir()
to still have access to the cursor while the eventfs saved what it created
and what it needs to release.

Instead, just have eventfs have its own iterate_shared callback function
that will fill in the dent entries. This simplifies the code quite a bit.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 194 +++++++++++++--------------------------
 1 file changed, 64 insertions(+), 130 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index c360300fb866..41af56f44f0a 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -52,9 +52,7 @@ enum {
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
-static int dcache_dir_open_wrapper(struct inode *inode, struct file *file);
-static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx);
-static int eventfs_release(struct inode *inode, struct file *file);
+static int eventfs_iterate(struct file *file, struct dir_context *ctx);
 
 static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
 {
@@ -148,11 +146,9 @@ static const struct inode_operations eventfs_file_inode_operations = {
 };
 
 static const struct file_operations eventfs_file_operations = {
-	.open		= dcache_dir_open_wrapper,
 	.read		= generic_read_dir,
-	.iterate_shared	= dcache_readdir_wrapper,
+	.iterate_shared	= eventfs_iterate,
 	.llseek		= generic_file_llseek,
-	.release	= eventfs_release,
 };
 
 /* Return the evenfs_inode of the "events" directory */
@@ -643,128 +639,87 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	return ret;
 }
 
-struct dentry_list {
-	void			*cursor;
-	struct dentry		**dentries;
-};
-
-/**
- * eventfs_release - called to release eventfs file/dir
- * @inode: inode to be released
- * @file: file to be released (not used)
- */
-static int eventfs_release(struct inode *inode, struct file *file)
-{
-	struct tracefs_inode *ti;
-	struct dentry_list *dlist = file->private_data;
-	void *cursor;
-	int i;
-
-	ti = get_tracefs(inode);
-	if (!(ti->flags & TRACEFS_EVENT_INODE))
-		return -EINVAL;
-
-	if (WARN_ON_ONCE(!dlist))
-		return -EINVAL;
-
-	for (i = 0; dlist->dentries && dlist->dentries[i]; i++) {
-		dput(dlist->dentries[i]);
-	}
-
-	cursor = dlist->cursor;
-	kfree(dlist->dentries);
-	kfree(dlist);
-	file->private_data = cursor;
-	return dcache_dir_close(inode, file);
-}
-
-static int add_dentries(struct dentry ***dentries, struct dentry *d, int cnt)
-{
-	struct dentry **tmp;
-
-	tmp = krealloc(*dentries, sizeof(d) * (cnt + 2), GFP_NOFS);
-	if (!tmp)
-		return -1;
-	tmp[cnt] = d;
-	tmp[cnt + 1] = NULL;
-	*dentries = tmp;
-	return 0;
-}
-
-/**
- * dcache_dir_open_wrapper - eventfs open wrapper
- * @inode: not used
- * @file: dir to be opened (to create it's children)
- *
- * Used to dynamic create file/dir with-in @file, all the
- * file/dir will be created. If already created then references
- * will be increased
+/*
+ * Walk the children of a eventfs_inode to fill in getdents().
  */
-static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
+static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 {
 	const struct file_operations *fops;
+	struct inode *f_inode = file_inode(file);
 	const struct eventfs_entry *entry;
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct dentry_list *dlist;
-	struct dentry **dentries = NULL;
-	struct dentry *parent = file_dentry(file);
-	struct dentry *d;
-	struct inode *f_inode = file_inode(file);
-	const char *name = parent->d_name.name;
+	struct dentry *ei_dentry = NULL;
+	struct dentry *dentry;
+	const char *name;
 	umode_t mode;
-	void *data;
-	int cnt = 0;
 	int idx;
-	int ret;
-	int i;
-	int r;
+	int ret = -EINVAL;
+	int ino;
+	int i, r, c;
+
+	if (!dir_emit_dots(file, ctx))
+		return 0;
 
 	ti = get_tracefs(f_inode);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
 		return -EINVAL;
 
-	if (WARN_ON_ONCE(file->private_data))
-		return -EINVAL;
+	c = ctx->pos - 2;
 
 	idx = srcu_read_lock(&eventfs_srcu);
 
 	mutex_lock(&eventfs_mutex);
 	ei = READ_ONCE(ti->private);
+	if (ei && !ei->is_freed)
+		ei_dentry = READ_ONCE(ei->dentry);
 	mutex_unlock(&eventfs_mutex);
 
-	if (!ei) {
-		srcu_read_unlock(&eventfs_srcu, idx);
-		return -EINVAL;
-	}
-
-
-	data = ei->data;
+	if (!ei || !ei_dentry)
+		goto out;
 
-	dlist = kmalloc(sizeof(*dlist), GFP_KERNEL);
-	if (!dlist) {
-		srcu_read_unlock(&eventfs_srcu, idx);
-		return -ENOMEM;
-	}
+	ret = 0;
 
-	inode_lock(parent->d_inode);
+	/*
+	 * Need to create the dentries and inodes to have a consistent
+	 * inode number.
+	 */
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
-		d = create_dir_dentry(ei, ei_child, parent);
-		if (d) {
-			ret = add_dentries(&dentries, d, cnt);
-			dput(d);
-			if (ret < 0)
-				break;
-			cnt++;
+
+		if (c > 0) {
+			c--;
+			continue;
 		}
+
+		if (ei_child->is_freed)
+			continue;
+
+		name = ei_child->name;
+
+		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
+		if (!dentry)
+			goto out;
+		ino = dentry->d_inode->i_ino;
+		dput(dentry);
+
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
+			goto out;
+		ctx->pos++;
 	}
 
 	for (i = 0; i < ei->nr_entries; i++) {
-		void *cdata = data;
+		void *cdata = ei->data;
+
+		if (c > 0) {
+			c--;
+			continue;
+		}
+
 		entry = &ei->entries[i];
 		name = entry->name;
+
 		mutex_lock(&eventfs_mutex);
 		/* If ei->is_freed, then the event itself may be too */
 		if (!ei->is_freed)
@@ -774,42 +729,21 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		mutex_unlock(&eventfs_mutex);
 		if (r <= 0)
 			continue;
-		d = create_file_dentry(ei, i, parent, name, mode, cdata, fops);
-		if (d) {
-			ret = add_dentries(&dentries, d, cnt);
-			dput(d);
-			if (ret < 0)
-				break;
-			cnt++;
-		}
-	}
-	inode_unlock(parent->d_inode);
-	srcu_read_unlock(&eventfs_srcu, idx);
-	ret = dcache_dir_open(inode, file);
 
-	/*
-	 * dcache_dir_open() sets file->private_data to a dentry cursor.
-	 * Need to save that but also save all the dentries that were
-	 * opened by this function.
-	 */
-	dlist->cursor = file->private_data;
-	dlist->dentries = dentries;
-	file->private_data = dlist;
-	return ret;
-}
+		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
+		if (!dentry)
+			goto out;
+		ino = dentry->d_inode->i_ino;
+		dput(dentry);
 
-/*
- * This just sets the file->private_data back to the cursor and back.
- */
-static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx)
-{
-	struct dentry_list *dlist = file->private_data;
-	int ret;
+		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
+			goto out;
+		ctx->pos++;
+	}
+	ret = 1;
+ out:
+	srcu_read_unlock(&eventfs_srcu, idx);
 
-	file->private_data = dlist->cursor;
-	ret = dcache_readdir(file, ctx);
-	dlist->cursor = file->private_data;
-	file->private_data = dlist;
 	return ret;
 }
 
-- 
2.42.0



