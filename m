Return-Path: <linux-fsdevel+bounces-7329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E37F6823A5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 02:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE22E1C24BBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 01:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3055442E;
	Thu,  4 Jan 2024 01:53:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598EE4C67;
	Thu,  4 Jan 2024 01:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C0CC433C8;
	Thu,  4 Jan 2024 01:53:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLCwN-00000000qhL-2lQi;
	Wed, 03 Jan 2024 20:54:35 -0500
Message-ID: <20240104015435.517502710@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 03 Jan 2024 20:52:48 -0500
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
Subject: [PATCH v2 1/2] eventfs: Remove "lookup" parameter from create_dir/file_dentry()
References: <20240104015247.075935881@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The "lookup" parameter is a way to differentiate the call to
create_file/dir_dentry() from when it's just a lookup (no need to up the
dentry refcount) and accessed via a readdir (need to up the refcount).

But reality, it just makes the code more complex. Just up the refcount and
let the caller decide to dput() the result or not.

Link: https://lore.kernel.org/linux-trace-kernel/20240103102553.17a19cea@gandalf.local.home

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 55 +++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index f0677ea0ec24..c360300fb866 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -390,16 +390,14 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
  * @mode: The mode of the file.
  * @data: The data to use to set the inode of the file with on open()
  * @fops: The fops of the file to be created.
- * @lookup: If called by the lookup routine, in which case, dput() the created dentry.
  *
  * Create a dentry for a file of an eventfs_inode @ei and place it into the
- * address located at @e_dentry. If the @e_dentry already has a dentry, then
- * just do a dget() on it and return. Otherwise create the dentry and attach it.
+ * address located at @e_dentry.
  */
 static struct dentry *
 create_file_dentry(struct eventfs_inode *ei, int idx,
 		   struct dentry *parent, const char *name, umode_t mode, void *data,
-		   const struct file_operations *fops, bool lookup)
+		   const struct file_operations *fops)
 {
 	struct eventfs_attr *attr = NULL;
 	struct dentry **e_dentry = &ei->d_children[idx];
@@ -414,9 +412,7 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	}
 	/* If the e_dentry already has a dentry, use it */
 	if (*e_dentry) {
-		/* lookup does not need to up the ref count */
-		if (!lookup)
-			dget(*e_dentry);
+		dget(*e_dentry);
 		mutex_unlock(&eventfs_mutex);
 		return *e_dentry;
 	}
@@ -441,13 +437,12 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 		 * way to being freed, don't return it. If e_dentry is NULL
 		 * it means it was already freed.
 		 */
-		if (ei->is_freed)
+		if (ei->is_freed) {
 			dentry = NULL;
-		else
+		} else {
 			dentry = *e_dentry;
-		/* The lookup does not need to up the dentry refcount */
-		if (dentry && !lookup)
 			dget(dentry);
+		}
 		mutex_unlock(&eventfs_mutex);
 		return dentry;
 	}
@@ -465,9 +460,6 @@ create_file_dentry(struct eventfs_inode *ei, int idx,
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	if (lookup)
-		dput(dentry);
-
 	return dentry;
 }
 
@@ -500,13 +492,12 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
  * @pei: The eventfs_inode parent of ei.
  * @ei: The eventfs_inode to create the directory for
  * @parent: The dentry of the parent of this directory
- * @lookup: True if this is called by the lookup code
  *
  * This creates and attaches a directory dentry to the eventfs_inode @ei.
  */
 static struct dentry *
 create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
-		  struct dentry *parent, bool lookup)
+		  struct dentry *parent)
 {
 	struct dentry *dentry = NULL;
 
@@ -518,11 +509,9 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		return NULL;
 	}
 	if (ei->dentry) {
-		/* If the dentry already has a dentry, use it */
+		/* If the eventfs_inode already has a dentry, use it */
 		dentry = ei->dentry;
-		/* lookup does not need to up the ref count */
-		if (!lookup)
-			dget(dentry);
+		dget(dentry);
 		mutex_unlock(&eventfs_mutex);
 		return dentry;
 	}
@@ -542,7 +531,7 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 		 * way to being freed.
 		 */
 		dentry = ei->dentry;
-		if (dentry && !lookup)
+		if (dentry)
 			dget(dentry);
 		mutex_unlock(&eventfs_mutex);
 		return dentry;
@@ -562,9 +551,6 @@ create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
 	}
 	mutex_unlock(&eventfs_mutex);
 
-	if (lookup)
-		dput(dentry);
-
 	return dentry;
 }
 
@@ -589,8 +575,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	struct eventfs_inode *ei;
 	struct dentry *ei_dentry = NULL;
 	struct dentry *ret = NULL;
+	struct dentry *d;
 	const char *name = dentry->d_name.name;
-	bool created = false;
 	umode_t mode;
 	void *data;
 	int idx;
@@ -626,13 +612,10 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 		ret = simple_lookup(dir, dentry, flags);
 		if (IS_ERR(ret))
 			goto out;
-		create_dir_dentry(ei, ei_child, ei_dentry, true);
-		created = true;
-		break;
-	}
-
-	if (created)
+		d = create_dir_dentry(ei, ei_child, ei_dentry);
+		dput(d);
 		goto out;
+	}
 
 	for (i = 0; i < ei->nr_entries; i++) {
 		entry = &ei->entries[i];
@@ -650,8 +633,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 			ret = simple_lookup(dir, dentry, flags);
 			if (IS_ERR(ret))
 				goto out;
-			create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
-					   fops, true);
+			d = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
+			dput(d);
 			break;
 		}
 	}
@@ -768,9 +751,10 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 	inode_lock(parent->d_inode);
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
-		d = create_dir_dentry(ei, ei_child, parent, false);
+		d = create_dir_dentry(ei, ei_child, parent);
 		if (d) {
 			ret = add_dentries(&dentries, d, cnt);
+			dput(d);
 			if (ret < 0)
 				break;
 			cnt++;
@@ -790,9 +774,10 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 		mutex_unlock(&eventfs_mutex);
 		if (r <= 0)
 			continue;
-		d = create_file_dentry(ei, i, parent, name, mode, cdata, fops, false);
+		d = create_file_dentry(ei, i, parent, name, mode, cdata, fops);
 		if (d) {
 			ret = add_dentries(&dentries, d, cnt);
+			dput(d);
 			if (ret < 0)
 				break;
 			cnt++;
-- 
2.42.0



