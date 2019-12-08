Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57842116388
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 20:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfLHTML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Dec 2019 14:12:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38738 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfLHTMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Dec 2019 14:12:10 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ie1y2-00073k-US; Sun, 08 Dec 2019 19:11:43 +0000
Date:   Sun, 8 Dec 2019 19:11:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "yukuai (C)" <yukuai3@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, oleg@redhat.com,
        mchehab+samsung@kernel.org, corbet@lwn.net, tytso@mit.edu,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com, chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH V2 1/3] dcache: add a new enum type for
 'dentry_d_lock_class'
Message-ID: <20191208191142.GU4203@ZenIV.linux.org.uk>
References: <20191130020225.20239-1-yukuai3@huawei.com>
 <20191130020225.20239-2-yukuai3@huawei.com>
 <20191130034339.GI20752@bombadil.infradead.org>
 <e2e7c9f1-7152-1d74-c434-c2c4d57d0422@huawei.com>
 <20191130193615.GJ20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130193615.GJ20752@bombadil.infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 30, 2019 at 11:36:15AM -0800, Matthew Wilcox wrote:
> On Sat, Nov 30, 2019 at 03:53:10PM +0800, yukuai (C) wrote:
> > On 2019/11/30 11:43, Matthew Wilcox wrote:
> > > On Sat, Nov 30, 2019 at 10:02:23AM +0800, yu kuai wrote:
> > > > However, a single 'DENTRY_D_LOCK_NESTED' may not be enough if more than
> > > > two dentry are involed. So, add in 'DENTRY_D_LOCK_NESTED_TWICE'.
> > > 
> > > No.  These need meaningful names.  Indeed, I think D_LOCK_NESTED is
> > > a terrible name.
> > > 
> > > The exception is __d_move() where I think we should actually name the
> > > different lock classes instead of using a bare '2' and '3'.  Something
> > > like this, perhaps:
> > 
> > Thanks for looking into this, do you mind if I replace your patch with the
> > first two patches in the patchset?
> 
> That's fine by me, but I think we should wait for Al to give his approval
> before submitting a new version.

IMO this is a wrong approach.  It's papering over a confused code in
debugfs recursive removal and it would be better to get rid of _that_,
rather than try and slap bandaids on it.

I suspect that the following would be a better way to deal with it; it adds
a new primitive and converts debugfs and tracefs to that.  There are
followups converting other such places, still not finished.

commit 7e9c8a08889bf42bbe64e80e456d2eca824e5db2
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Nov 18 09:43:10 2019 -0500

    simple_recursive_removal(): kernel-side rm -rf for ramfs-style filesystems
    
    two requirements: no file creations in IS_DEADDIR and no cross-directory
    renames whatsoever.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 042b688ed124..da936c54d879 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -309,7 +309,10 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 		parent = debugfs_mount->mnt_root;
 
 	inode_lock(d_inode(parent));
-	dentry = lookup_one_len(name, parent, strlen(name));
+	if (unlikely(IS_DEADDIR(d_inode(parent))))
+		dentry = ERR_PTR(-ENOENT);
+	else
+		dentry = lookup_one_len(name, parent, strlen(name));
 	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
 		if (d_is_dir(dentry))
 			pr_err("Directory '%s' with parent '%s' already present!\n",
@@ -657,62 +660,15 @@ static void __debugfs_file_removed(struct dentry *dentry)
 		wait_for_completion(&fsd->active_users_drained);
 }
 
-static int __debugfs_remove(struct dentry *dentry, struct dentry *parent)
-{
-	int ret = 0;
-
-	if (simple_positive(dentry)) {
-		dget(dentry);
-		if (d_is_dir(dentry)) {
-			ret = simple_rmdir(d_inode(parent), dentry);
-			if (!ret)
-				fsnotify_rmdir(d_inode(parent), dentry);
-		} else {
-			simple_unlink(d_inode(parent), dentry);
-			fsnotify_unlink(d_inode(parent), dentry);
-		}
-		if (!ret)
-			d_delete(dentry);
-		if (d_is_reg(dentry))
-			__debugfs_file_removed(dentry);
-		dput(dentry);
-	}
-	return ret;
-}
-
-/**
- * debugfs_remove - removes a file or directory from the debugfs filesystem
- * @dentry: a pointer to a the dentry of the file or directory to be
- *          removed.  If this parameter is NULL or an error value, nothing
- *          will be done.
- *
- * This function removes a file or directory in debugfs that was previously
- * created with a call to another debugfs function (like
- * debugfs_create_file() or variants thereof.)
- *
- * This function is required to be called in order for the file to be
- * removed, no automatic cleanup of files will happen when a module is
- * removed, you are responsible here.
- */
-void debugfs_remove(struct dentry *dentry)
+static void remove_one(struct dentry *victim)
 {
-	struct dentry *parent;
-	int ret;
-
-	if (IS_ERR_OR_NULL(dentry))
-		return;
-
-	parent = dentry->d_parent;
-	inode_lock(d_inode(parent));
-	ret = __debugfs_remove(dentry, parent);
-	inode_unlock(d_inode(parent));
-	if (!ret)
-		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
+        if (d_is_reg(victim))
+		__debugfs_file_removed(victim);
+	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 }
-EXPORT_SYMBOL_GPL(debugfs_remove);
 
 /**
- * debugfs_remove_recursive - recursively removes a directory
+ * debugfs_remove - recursively removes a directory
  * @dentry: a pointer to a the dentry of the directory to be removed.  If this
  *          parameter is NULL or an error value, nothing will be done.
  *
@@ -724,65 +680,16 @@ EXPORT_SYMBOL_GPL(debugfs_remove);
  * removed, no automatic cleanup of files will happen when a module is
  * removed, you are responsible here.
  */
-void debugfs_remove_recursive(struct dentry *dentry)
+void debugfs_remove(struct dentry *dentry)
 {
-	struct dentry *child, *parent;
-
 	if (IS_ERR_OR_NULL(dentry))
 		return;
 
-	parent = dentry;
- down:
-	inode_lock(d_inode(parent));
- loop:
-	/*
-	 * The parent->d_subdirs is protected by the d_lock. Outside that
-	 * lock, the child can be unlinked and set to be freed which can
-	 * use the d_u.d_child as the rcu head and corrupt this list.
-	 */
-	spin_lock(&parent->d_lock);
-	list_for_each_entry(child, &parent->d_subdirs, d_child) {
-		if (!simple_positive(child))
-			continue;
-
-		/* perhaps simple_empty(child) makes more sense */
-		if (!list_empty(&child->d_subdirs)) {
-			spin_unlock(&parent->d_lock);
-			inode_unlock(d_inode(parent));
-			parent = child;
-			goto down;
-		}
-
-		spin_unlock(&parent->d_lock);
-
-		if (!__debugfs_remove(child, parent))
-			simple_release_fs(&debugfs_mount, &debugfs_mount_count);
-
-		/*
-		 * The parent->d_lock protects agaist child from unlinking
-		 * from d_subdirs. When releasing the parent->d_lock we can
-		 * no longer trust that the next pointer is valid.
-		 * Restart the loop. We'll skip this one with the
-		 * simple_positive() check.
-		 */
-		goto loop;
-	}
-	spin_unlock(&parent->d_lock);
-
-	inode_unlock(d_inode(parent));
-	child = parent;
-	parent = parent->d_parent;
-	inode_lock(d_inode(parent));
-
-	if (child != dentry)
-		/* go up */
-		goto loop;
-
-	if (!__debugfs_remove(child, parent))
-		simple_release_fs(&debugfs_mount, &debugfs_mount_count);
-	inode_unlock(d_inode(parent));
+	simple_pin_fs(&debug_fs_type, &debugfs_mount, &debugfs_mount_count);
+	simple_recursive_removal(dentry, remove_one);
+	simple_release_fs(&debugfs_mount, &debugfs_mount_count);
 }
-EXPORT_SYMBOL_GPL(debugfs_remove_recursive);
+EXPORT_SYMBOL_GPL(debugfs_remove);
 
 /**
  * debugfs_rename - rename a file/directory in the debugfs filesystem
diff --git a/fs/libfs.c b/fs/libfs.c
index 540611b99b9a..b67003a948ed 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -19,6 +19,7 @@
 #include <linux/buffer_head.h> /* sync_mapping_buffers */
 #include <linux/fs_context.h>
 #include <linux/pseudo_fs.h>
+#include <linux/fsnotify.h>
 
 #include <linux/uaccess.h>
 
@@ -239,6 +240,75 @@ const struct inode_operations simple_dir_inode_operations = {
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
+static struct dentry *find_next_child(struct dentry *parent, struct dentry *prev)
+{
+	struct dentry *child = NULL;
+	struct list_head *p = prev ? &prev->d_child : &parent->d_subdirs;
+
+	spin_lock(&parent->d_lock);
+	while ((p = p->next) != &parent->d_subdirs) {
+		struct dentry *d = container_of(p, struct dentry, d_child);
+		if (simple_positive(d)) {
+			spin_lock_nested(&d->d_lock, DENTRY_D_LOCK_NESTED);
+			if (simple_positive(d))
+				child = dget_dlock(d);
+			spin_unlock(&d->d_lock);
+			if (likely(child))
+				break;
+		}
+	}
+	spin_unlock(&parent->d_lock);
+	dput(prev);
+	return child;
+}
+
+void simple_recursive_removal(struct dentry *dentry,
+                              void (*callback)(struct dentry *))
+{
+	struct dentry *this = dentry;
+	while (true) {
+		struct dentry *victim = NULL, *child;
+		struct inode *inode = this->d_inode;
+
+		inode_lock(inode);
+		if (d_is_dir(this))
+			inode->i_flags |= S_DEAD;
+		while ((child = find_next_child(this, victim)) == NULL) {
+			// kill and ascend
+			// update metadata while it's still locked
+			inode->i_ctime = current_time(inode);
+			clear_nlink(inode);
+			inode_unlock(inode);
+			victim = this;
+			this = this->d_parent;
+			inode = this->d_inode;
+			inode_lock(inode);
+			if (simple_positive(victim)) {
+				d_invalidate(victim);	// avoid lost mounts
+				if (d_is_dir(victim))
+					fsnotify_rmdir(inode, victim);
+				else
+					fsnotify_unlink(inode, victim);
+				if (callback)
+					callback(victim);
+				dput(victim);		// unpin it
+			}
+			if (victim == dentry) {
+				inode->i_ctime = inode->i_mtime =
+					current_time(inode);
+				if (d_is_dir(dentry))
+					drop_nlink(inode);
+				inode_unlock(inode);
+				dput(dentry);
+				return;
+			}
+		}
+		inode_unlock(inode);
+		this = child;
+	}
+}
+EXPORT_SYMBOL(simple_recursive_removal);
+
 static const struct super_operations simple_super_operations = {
 	.statfs		= simple_statfs,
 };
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index eeeae0475da9..2a16c0eb97e4 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -329,7 +329,10 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
 		parent = tracefs_mount->mnt_root;
 
 	inode_lock(parent->d_inode);
-	dentry = lookup_one_len(name, parent, strlen(name));
+	if (unlikely(IS_DEADDIR(parent->d_inode)))
+		dentry = ERR_PTR(-ENOENT);
+	else
+		dentry = lookup_one_len(name, parent, strlen(name));
 	if (!IS_ERR(dentry) && dentry->d_inode) {
 		dput(dentry);
 		dentry = ERR_PTR(-EEXIST);
@@ -495,122 +498,27 @@ __init struct dentry *tracefs_create_instance_dir(const char *name,
 	return dentry;
 }
 
-static int __tracefs_remove(struct dentry *dentry, struct dentry *parent)
+static void remove_one(struct dentry *victim)
 {
-	int ret = 0;
-
-	if (simple_positive(dentry)) {
-		if (dentry->d_inode) {
-			dget(dentry);
-			switch (dentry->d_inode->i_mode & S_IFMT) {
-			case S_IFDIR:
-				ret = simple_rmdir(parent->d_inode, dentry);
-				if (!ret)
-					fsnotify_rmdir(parent->d_inode, dentry);
-				break;
-			default:
-				simple_unlink(parent->d_inode, dentry);
-				fsnotify_unlink(parent->d_inode, dentry);
-				break;
-			}
-			if (!ret)
-				d_delete(dentry);
-			dput(dentry);
-		}
-	}
-	return ret;
-}
-
-/**
- * tracefs_remove - removes a file or directory from the tracefs filesystem
- * @dentry: a pointer to a the dentry of the file or directory to be
- *          removed.
- *
- * This function removes a file or directory in tracefs that was previously
- * created with a call to another tracefs function (like
- * tracefs_create_file() or variants thereof.)
- */
-void tracefs_remove(struct dentry *dentry)
-{
-	struct dentry *parent;
-	int ret;
-
-	if (IS_ERR_OR_NULL(dentry))
-		return;
-
-	parent = dentry->d_parent;
-	inode_lock(parent->d_inode);
-	ret = __tracefs_remove(dentry, parent);
-	inode_unlock(parent->d_inode);
-	if (!ret)
-		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
+	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
 }
 
 /**
- * tracefs_remove_recursive - recursively removes a directory
+ * tracefs_remove - recursively removes a directory
  * @dentry: a pointer to a the dentry of the directory to be removed.
  *
  * This function recursively removes a directory tree in tracefs that
  * was previously created with a call to another tracefs function
  * (like tracefs_create_file() or variants thereof.)
  */
-void tracefs_remove_recursive(struct dentry *dentry)
+void tracefs_remove(struct dentry *dentry)
 {
-	struct dentry *child, *parent;
-
 	if (IS_ERR_OR_NULL(dentry))
 		return;
 
-	parent = dentry;
- down:
-	inode_lock(parent->d_inode);
- loop:
-	/*
-	 * The parent->d_subdirs is protected by the d_lock. Outside that
-	 * lock, the child can be unlinked and set to be freed which can
-	 * use the d_u.d_child as the rcu head and corrupt this list.
-	 */
-	spin_lock(&parent->d_lock);
-	list_for_each_entry(child, &parent->d_subdirs, d_child) {
-		if (!simple_positive(child))
-			continue;
-
-		/* perhaps simple_empty(child) makes more sense */
-		if (!list_empty(&child->d_subdirs)) {
-			spin_unlock(&parent->d_lock);
-			inode_unlock(parent->d_inode);
-			parent = child;
-			goto down;
-		}
-
-		spin_unlock(&parent->d_lock);
-
-		if (!__tracefs_remove(child, parent))
-			simple_release_fs(&tracefs_mount, &tracefs_mount_count);
-
-		/*
-		 * The parent->d_lock protects agaist child from unlinking
-		 * from d_subdirs. When releasing the parent->d_lock we can
-		 * no longer trust that the next pointer is valid.
-		 * Restart the loop. We'll skip this one with the
-		 * simple_positive() check.
-		 */
-		goto loop;
-	}
-	spin_unlock(&parent->d_lock);
-
-	inode_unlock(parent->d_inode);
-	child = parent;
-	parent = parent->d_parent;
-	inode_lock(parent->d_inode);
-
-	if (child != dentry)
-		/* go up */
-		goto loop;
-
-	if (!__tracefs_remove(child, parent))
-		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
-	inode_unlock(parent->d_inode);
+	simple_pin_fs(&trace_fs_type, &tracefs_mount, &tracefs_mount_count);
+	simple_recursive_removal(dentry, remove_one);
+	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
 }
 
 /**
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 58424eb3b329..0a817d763f0f 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -82,7 +82,7 @@ struct dentry *debugfs_create_automount(const char *name,
 					void *data);
 
 void debugfs_remove(struct dentry *dentry);
-void debugfs_remove_recursive(struct dentry *dentry);
+#define debugfs_remove_recursive debugfs_remove
 
 const struct file_operations *debugfs_real_fops(const struct file *filp);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 997a530ff4e9..73ffc8654987 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3242,6 +3242,8 @@ extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
 extern int simple_rename(struct inode *, struct dentry *,
 			 struct inode *, struct dentry *, unsigned int);
+extern void simple_recursive_removal(struct dentry *,
+                              void (*callback)(struct dentry *));
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
 extern int noop_set_page_dirty(struct page *page);
 extern void noop_invalidatepage(struct page *page, unsigned int offset,
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 88d279c1b863..99912445974c 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -28,7 +28,6 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 struct dentry *tracefs_create_dir(const char *name, struct dentry *parent);
 
 void tracefs_remove(struct dentry *dentry);
-void tracefs_remove_recursive(struct dentry *dentry);
 
 struct dentry *tracefs_create_instance_dir(const char *name, struct dentry *parent,
 					   int (*mkdir)(const char *name),
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 563e80f9006a..88d94dc3ed37 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8366,7 +8366,7 @@ struct trace_array *trace_array_create(const char *name)
 
 	ret = event_trace_add_tracer(tr->dir, tr);
 	if (ret) {
-		tracefs_remove_recursive(tr->dir);
+		tracefs_remove(tr->dir);
 		goto out_free_tr;
 	}
 
@@ -8422,7 +8422,7 @@ static int __remove_instance(struct trace_array *tr)
 	event_trace_del_tracer(tr);
 	ftrace_clear_pids(tr);
 	ftrace_destroy_function_files(tr);
-	tracefs_remove_recursive(tr->dir);
+	tracefs_remove(tr->dir);
 	free_trace_buffers(tr);
 
 	for (i = 0; i < tr->nr_topts; i++) {
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 648930823b57..25bb3e8fb170 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -696,7 +696,7 @@ static void remove_subsystem(struct trace_subsystem_dir *dir)
 		return;
 
 	if (!--dir->nr_events) {
-		tracefs_remove_recursive(dir->entry);
+		tracefs_remove(dir->entry);
 		list_del(&dir->list);
 		__put_system_dir(dir);
 	}
@@ -715,7 +715,7 @@ static void remove_event_file_dir(struct trace_event_file *file)
 		}
 		spin_unlock(&dir->d_lock);
 
-		tracefs_remove_recursive(dir);
+		tracefs_remove(dir);
 	}
 
 	list_del(&file->list);
@@ -3032,7 +3032,7 @@ int event_trace_del_tracer(struct trace_array *tr)
 
 	down_write(&trace_event_sem);
 	__trace_remove_event_dirs(tr);
-	tracefs_remove_recursive(tr->event_dir);
+	tracefs_remove(tr->event_dir);
 	up_write(&trace_event_sem);
 
 	tr->event_dir = NULL;
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index fa95139445b2..fa45a031848c 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -551,7 +551,7 @@ static int init_tracefs(void)
 	return 0;
 
  err:
-	tracefs_remove_recursive(top_dir);
+	tracefs_remove(top_dir);
 	return -ENOMEM;
 }
 
