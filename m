Return-Path: <linux-fsdevel+bounces-9706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389584479B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E571C227CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D040BEF;
	Wed, 31 Jan 2024 18:54:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB7C3FB17;
	Wed, 31 Jan 2024 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706727298; cv=none; b=BAYy97ifRs0NZXugeBopta7uQXCnhHgiBnr7vUffjvoUsHZyeXS6VAOXZ1Y2R79oPRnOQvlupq0DYq4nM1D5b+xHDIu59/XaaMoyDYVxMp0dJ4VsyLiMAJXlQl9Yhgsd84iCAJvau9H7bL28kUE1cH5Hif2Mp2MYFQFUyZHMxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706727298; c=relaxed/simple;
	bh=hGyxi7rkpGN3rfWPDjLksvDJVIhdaDvsVYxgi+1VBlw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Y1F1ION4gVzmrWHTwGQB+nyBrjMGF/N5HzrTewUtnh4OhbsL3UIlnS3GgUI8brLQ9cw/DUAYl1WU5l6MGlOCSe3IEkiMCL7ypVBMh6qzY1DTfVZfYEMqP1GJQfgVWj5D3UpANtA3ZVTtaz691mQnuvGbKRJXZCC4Pxk0xnqNng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B96C43390;
	Wed, 31 Jan 2024 18:54:57 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rVFjs-000000055RK-3x34;
	Wed, 31 Jan 2024 13:55:12 -0500
Message-ID: <20240131185512.799813912@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 31 Jan 2024 13:49:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 4/7] tracefs: dentry lookup crapectomy
References: <20240131184918.945345370@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Linus Torvalds <torvalds@linux-foundation.org>

The dentry lookup for eventfs files was very broken, and had lots of
signs of the old situation where the filesystem names were all created
statically in the dentry tree, rather than being looked up dynamically
based on the eventfs data structures.

You could see it in the naming - how it claimed to "create" dentries
rather than just look up the dentries that were given it.

You could see it in various nonsensical and very incorrect operations,
like using "simple_lookup()" on the dentries that were passed in, which
only results in those dentries becoming negative dentries.  Which meant
that any other lookup would possibly return ENOENT if it saw that
negative dentry before the data was then later filled in.

You could see it in the immense amount of nonsensical code that didn't
actually just do lookups.

Link: https://lore.kernel.org/linux-trace-kernel/202401291043.e62e89dc-oliver.sang@intel.com/

Cc: stable@vger.kernel.org
Fixes: c1504e510238 ("eventfs: Implement eventfs dir creation functions")
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240130190355.11486-3-torvalds@linux-foundation.org

- Fixed the lookup case of not found dentry, to return an error.
  This was added in a later patch when it should have been in this one.

- Removed the calls to eventfs_{start,end,failed}_creating()

 fs/tracefs/event_inode.c | 285 ++++++++-------------------------------
 fs/tracefs/inode.c       |  69 ----------
 fs/tracefs/internal.h    |   3 -
 3 files changed, 58 insertions(+), 299 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index e9819d719d2a..4878f4d578be 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -230,7 +230,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 {
 	struct eventfs_inode *ei;
 
-	mutex_lock(&eventfs_mutex);
 	do {
 		// The parent is stable because we do not do renames
 		dentry = dentry->d_parent;
@@ -247,7 +246,6 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		}
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
-	mutex_unlock(&eventfs_mutex);
 
 	update_top_events_attr(ei, dentry->d_sb);
 
@@ -280,11 +278,10 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
 }
 
 /**
- * create_file - create a file in the tracefs filesystem
- * @name: the name of the file to create.
+ * lookup_file - look up a file in the tracefs filesystem
+ * @dentry: the dentry to look up
  * @mode: the permission that the file should have.
  * @attr: saved attributes changed by user
- * @parent: parent dentry for this file.
  * @data: something that the caller will want to get to later on.
  * @fop: struct file_operations that should be used for this file.
  *
@@ -292,13 +289,13 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
  * directory. The inode.i_private pointer will point to @data in the open()
  * call.
  */
-static struct dentry *create_file(const char *name, umode_t mode,
+static struct dentry *lookup_file(struct dentry *dentry,
+				  umode_t mode,
 				  struct eventfs_attr *attr,
-				  struct dentry *parent, void *data,
+				  void *data,
 				  const struct file_operations *fop)
 {
 	struct tracefs_inode *ti;
-	struct dentry *dentry;
 	struct inode *inode;
 
 	if (!(mode & S_IFMT))
@@ -307,15 +304,9 @@ static struct dentry *create_file(const char *name, umode_t mode,
 	if (WARN_ON_ONCE(!S_ISREG(mode)))
 		return NULL;
 
-	WARN_ON_ONCE(!parent);
-	dentry = eventfs_start_creating(name, parent);
-
-	if (IS_ERR(dentry))
-		return dentry;
-
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return eventfs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 
 	/* If the user updated the directory's attributes, use them */
 	update_inode_attr(dentry, inode, attr, mode);
@@ -329,32 +320,29 @@ static struct dentry *create_file(const char *name, umode_t mode,
 
 	ti = get_tracefs(inode);
 	ti->flags |= TRACEFS_EVENT_INODE;
-	d_instantiate(dentry, inode);
+
+	d_add(dentry, inode);
 	fsnotify_create(dentry->d_parent->d_inode, dentry);
-	return eventfs_end_creating(dentry);
+	return dentry;
 };
 
 /**
- * create_dir - create a dir in the tracefs filesystem
+ * lookup_dir_entry - look up a dir in the tracefs filesystem
+ * @dentry: the directory to look up
  * @ei: the eventfs_inode that represents the directory to create
- * @parent: parent dentry for this file.
  *
- * This function will create a dentry for a directory represented by
+ * This function will look up a dentry for a directory represented by
  * a eventfs_inode.
  */
-static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent)
+static struct dentry *lookup_dir_entry(struct dentry *dentry,
+	struct eventfs_inode *pei, struct eventfs_inode *ei)
 {
 	struct tracefs_inode *ti;
-	struct dentry *dentry;
 	struct inode *inode;
 
-	dentry = eventfs_start_creating(ei->name, parent);
-	if (IS_ERR(dentry))
-		return dentry;
-
 	inode = tracefs_get_inode(dentry->d_sb);
 	if (unlikely(!inode))
-		return eventfs_failed_creating(dentry);
+		return ERR_PTR(-ENOMEM);
 
 	/* If the user updated the directory's attributes, use them */
 	update_inode_attr(dentry, inode, &ei->attr,
@@ -371,11 +359,14 @@ static struct dentry *create_dir(struct eventfs_inode *ei, struct dentry *parent
 	/* Only directories have ti->private set to an ei, not files */
 	ti->private = ei;
 
+	dentry->d_fsdata = ei;
+        ei->dentry = dentry;	// Remove me!
+
 	inc_nlink(inode);
-	d_instantiate(dentry, inode);
+	d_add(dentry, inode);
 	inc_nlink(dentry->d_parent->d_inode);
 	fsnotify_mkdir(dentry->d_parent->d_inode, dentry);
-	return eventfs_end_creating(dentry);
+	return dentry;
 }
 
 static void free_ei(struct eventfs_inode *ei)
@@ -425,7 +416,7 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 }
 
 /**
- * create_file_dentry - create a dentry for a file of an eventfs_inode
+ * lookup_file_dentry - create a dentry for a file of an eventfs_inode
  * @ei: the eventfs_inode that the file will be created under
  * @idx: the index into the d_children[] of the @ei
  * @parent: The parent dentry of the created file.
@@ -438,157 +429,21 @@ void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry)
  * address located at @e_dentry.
  */
 static struct dentry *
-create_file_dentry(struct eventfs_inode *ei, int idx,
-		   struct dentry *parent, const char *name, umode_t mode, void *data,
+lookup_file_dentry(struct dentry *dentry,
+		   struct eventfs_inode *ei, int idx,
+		   umode_t mode, void *data,
 		   const struct file_operations *fops)
 {
 	struct eventfs_attr *attr = NULL;
 	struct dentry **e_dentry = &ei->d_children[idx];
-	struct dentry *dentry;
-
-	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
 
-	mutex_lock(&eventfs_mutex);
-	if (ei->is_freed) {
-		mutex_unlock(&eventfs_mutex);
-		return NULL;
-	}
-	/* If the e_dentry already has a dentry, use it */
-	if (*e_dentry) {
-		dget(*e_dentry);
-		mutex_unlock(&eventfs_mutex);
-		return *e_dentry;
-	}
-
-	/* ei->entry_attrs are protected by SRCU */
 	if (ei->entry_attrs)
 		attr = &ei->entry_attrs[idx];
 
-	mutex_unlock(&eventfs_mutex);
-
-	dentry = create_file(name, mode, attr, parent, data, fops);
-
-	mutex_lock(&eventfs_mutex);
-
-	if (IS_ERR_OR_NULL(dentry)) {
-		/*
-		 * When the mutex was released, something else could have
-		 * created the dentry for this e_dentry. In which case
-		 * use that one.
-		 *
-		 * If ei->is_freed is set, the e_dentry is currently on its
-		 * way to being freed, don't return it. If e_dentry is NULL
-		 * it means it was already freed.
-		 */
-		if (ei->is_freed) {
-			dentry = NULL;
-		} else {
-			dentry = *e_dentry;
-			dget(dentry);
-		}
-		mutex_unlock(&eventfs_mutex);
-		return dentry;
-	}
-
-	if (!*e_dentry && !ei->is_freed) {
-		*e_dentry = dentry;
-		dentry->d_fsdata = ei;
-	} else {
-		/*
-		 * Should never happen unless we get here due to being freed.
-		 * Otherwise it means two dentries exist with the same name.
-		 */
-		WARN_ON_ONCE(!ei->is_freed);
-		dentry = NULL;
-	}
-	mutex_unlock(&eventfs_mutex);
-
-	return dentry;
-}
-
-/**
- * eventfs_post_create_dir - post create dir routine
- * @ei: eventfs_inode of recently created dir
- *
- * Map the meta-data of files within an eventfs dir to their parent dentry
- */
-static void eventfs_post_create_dir(struct eventfs_inode *ei)
-{
-	struct eventfs_inode *ei_child;
-
-	lockdep_assert_held(&eventfs_mutex);
-
-	/* srcu lock already held */
-	/* fill parent-child relation */
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
-		ei_child->d_parent = ei->dentry;
-	}
-}
-
-/**
- * create_dir_dentry - Create a directory dentry for the eventfs_inode
- * @pei: The eventfs_inode parent of ei.
- * @ei: The eventfs_inode to create the directory for
- * @parent: The dentry of the parent of this directory
- *
- * This creates and attaches a directory dentry to the eventfs_inode @ei.
- */
-static struct dentry *
-create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
-		  struct dentry *parent)
-{
-	struct dentry *dentry = NULL;
-
-	WARN_ON_ONCE(!inode_is_locked(parent->d_inode));
-
-	mutex_lock(&eventfs_mutex);
-	if (pei->is_freed || ei->is_freed) {
-		mutex_unlock(&eventfs_mutex);
-		return NULL;
-	}
-	if (ei->dentry) {
-		/* If the eventfs_inode already has a dentry, use it */
-		dentry = ei->dentry;
-		dget(dentry);
-		mutex_unlock(&eventfs_mutex);
-		return dentry;
-	}
-	mutex_unlock(&eventfs_mutex);
+	dentry->d_fsdata = ei;		// NOTE: ei of _parent_
+	lookup_file(dentry, mode, attr, data, fops);
 
-	dentry = create_dir(ei, parent);
-
-	mutex_lock(&eventfs_mutex);
-
-	if (IS_ERR_OR_NULL(dentry) && !ei->is_freed) {
-		/*
-		 * When the mutex was released, something else could have
-		 * created the dentry for this e_dentry. In which case
-		 * use that one.
-		 *
-		 * If ei->is_freed is set, the e_dentry is currently on its
-		 * way to being freed.
-		 */
-		dentry = ei->dentry;
-		if (dentry)
-			dget(dentry);
-		mutex_unlock(&eventfs_mutex);
-		return dentry;
-	}
-
-	if (!ei->dentry && !ei->is_freed) {
-		ei->dentry = dentry;
-		eventfs_post_create_dir(ei);
-		dentry->d_fsdata = ei;
-	} else {
-		/*
-		 * Should never happen unless we get here due to being freed.
-		 * Otherwise it means two dentries exist with the same name.
-		 */
-		WARN_ON_ONCE(!ei->is_freed);
-		dentry = NULL;
-	}
-	mutex_unlock(&eventfs_mutex);
+	*e_dentry = dentry;	// Remove me
 
 	return dentry;
 }
@@ -607,79 +462,55 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags)
 {
-	const struct file_operations *fops;
-	const struct eventfs_entry *entry;
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct dentry *ei_dentry = NULL;
-	struct dentry *ret = NULL;
-	struct dentry *d;
 	const char *name = dentry->d_name.name;
-	umode_t mode;
-	void *data;
-	int idx;
-	int i;
-	int r;
+	struct dentry *result = NULL;
 
 	ti = get_tracefs(dir);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
-		return NULL;
-
-	/* Grab srcu to prevent the ei from going away */
-	idx = srcu_read_lock(&eventfs_srcu);
+		return ERR_PTR(-EIO);
 
-	/*
-	 * Grab the eventfs_mutex to consistent value from ti->private.
-	 * This s
-	 */
 	mutex_lock(&eventfs_mutex);
-	ei = READ_ONCE(ti->private);
-	if (ei && !ei->is_freed)
-		ei_dentry = READ_ONCE(ei->dentry);
-	mutex_unlock(&eventfs_mutex);
-
-	if (!ei || !ei_dentry)
-		goto out;
 
-	data = ei->data;
+	ei = ti->private;
+	if (!ei || ei->is_freed)
+		goto enoent;
 
-	list_for_each_entry_srcu(ei_child, &ei->children, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
+	list_for_each_entry(ei_child, &ei->children, list) {
 		if (strcmp(ei_child->name, name) != 0)
 			continue;
-		ret = simple_lookup(dir, dentry, flags);
-		if (IS_ERR(ret))
-			goto out;
-		d = create_dir_dentry(ei, ei_child, ei_dentry);
-		dput(d);
+		if (ei_child->is_freed)
+			goto enoent;
+		lookup_dir_entry(dentry, ei, ei_child);
 		goto out;
 	}
 
-	for (i = 0; i < ei->nr_entries; i++) {
-		entry = &ei->entries[i];
-		if (strcmp(name, entry->name) == 0) {
-			void *cdata = data;
-			mutex_lock(&eventfs_mutex);
-			/* If ei->is_freed, then the event itself may be too */
-			if (!ei->is_freed)
-				r = entry->callback(name, &mode, &cdata, &fops);
-			else
-				r = -1;
-			mutex_unlock(&eventfs_mutex);
-			if (r <= 0)
-				continue;
-			ret = simple_lookup(dir, dentry, flags);
-			if (IS_ERR(ret))
-				goto out;
-			d = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
-			dput(d);
-			break;
-		}
+	for (int i = 0; i < ei->nr_entries; i++) {
+		void *data;
+		umode_t mode;
+		const struct file_operations *fops;
+		const struct eventfs_entry *entry = &ei->entries[i];
+
+		if (strcmp(name, entry->name) != 0)
+			continue;
+
+		data = ei->data;
+		if (entry->callback(name, &mode, &data, &fops) <= 0)
+			goto enoent;
+
+		lookup_file_dentry(dentry, ei, i, mode, data, fops);
+		goto out;
 	}
+
+ enoent:
+	/* Don't cache negative lookups, just return an error */
+	result = ERR_PTR(-ENOENT);
+
  out:
-	srcu_read_unlock(&eventfs_srcu, idx);
-	return ret;
+	mutex_unlock(&eventfs_mutex);
+	return result;
 }
 
 /*
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 888e42087847..5c84460feeeb 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -495,75 +495,6 @@ struct dentry *tracefs_end_creating(struct dentry *dentry)
 	return dentry;
 }
 
-/**
- * eventfs_start_creating - start the process of creating a dentry
- * @name: Name of the file created for the dentry
- * @parent: The parent dentry where this dentry will be created
- *
- * This is a simple helper function for the dynamically created eventfs
- * files. When the directory of the eventfs files are accessed, their
- * dentries are created on the fly. This function is used to start that
- * process.
- */
-struct dentry *eventfs_start_creating(const char *name, struct dentry *parent)
-{
-	struct dentry *dentry;
-	int error;
-
-	/* Must always have a parent. */
-	if (WARN_ON_ONCE(!parent))
-		return ERR_PTR(-EINVAL);
-
-	error = simple_pin_fs(&trace_fs_type, &tracefs_mount,
-			      &tracefs_mount_count);
-	if (error)
-		return ERR_PTR(error);
-
-	if (unlikely(IS_DEADDIR(parent->d_inode)))
-		dentry = ERR_PTR(-ENOENT);
-	else
-		dentry = lookup_one_len(name, parent, strlen(name));
-
-	if (!IS_ERR(dentry) && dentry->d_inode) {
-		dput(dentry);
-		dentry = ERR_PTR(-EEXIST);
-	}
-
-	if (IS_ERR(dentry))
-		simple_release_fs(&tracefs_mount, &tracefs_mount_count);
-
-	return dentry;
-}
-
-/**
- * eventfs_failed_creating - clean up a failed eventfs dentry creation
- * @dentry: The dentry to clean up
- *
- * If after calling eventfs_start_creating(), a failure is detected, the
- * resources created by eventfs_start_creating() needs to be cleaned up. In
- * that case, this function should be called to perform that clean up.
- */
-struct dentry *eventfs_failed_creating(struct dentry *dentry)
-{
-	dput(dentry);
-	simple_release_fs(&tracefs_mount, &tracefs_mount_count);
-	return NULL;
-}
-
-/**
- * eventfs_end_creating - Finish the process of creating a eventfs dentry
- * @dentry: The dentry that has successfully been created.
- *
- * This function is currently just a place holder to match
- * eventfs_start_creating(). In case any synchronization needs to be added,
- * this function will be used to implement that without having to modify
- * the callers of eventfs_start_creating().
- */
-struct dentry *eventfs_end_creating(struct dentry *dentry)
-{
-	return dentry;
-}
-
 /* Find the inode that this will use for default */
 static struct inode *instance_inode(struct dentry *parent, struct inode *inode)
 {
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 7d84349ade87..09037e2c173d 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -80,9 +80,6 @@ struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
 struct dentry *tracefs_end_creating(struct dentry *dentry);
 struct dentry *tracefs_failed_creating(struct dentry *dentry);
 struct inode *tracefs_get_inode(struct super_block *sb);
-struct dentry *eventfs_start_creating(const char *name, struct dentry *parent);
-struct dentry *eventfs_failed_creating(struct dentry *dentry);
-struct dentry *eventfs_end_creating(struct dentry *dentry);
 void eventfs_set_ei_status_free(struct tracefs_inode *ti, struct dentry *dentry);
 
 #endif /* _TRACEFS_INTERNAL_H */
-- 
2.43.0



