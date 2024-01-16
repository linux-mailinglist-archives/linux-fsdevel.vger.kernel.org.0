Return-Path: <linux-fsdevel+bounces-8120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3243082FC88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 23:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6EC1F2A544
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 22:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559F2D050;
	Tue, 16 Jan 2024 21:12:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE62CCDC;
	Tue, 16 Jan 2024 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439558; cv=none; b=R0MMZNVqqE4xsrZDEHXhMJhvY3O/wRbIb37Vml8pWiYnLnvX4LrweS7FobyiB7TOIWbrfOi6k9Iuck9fEgeANxuc9OWDgov+rpFIT2gTqgnCScUbB/5GeDc9lN3j3Qaj8qY1WI+oQvWwwu8uGC2WR9CSuqP8Vr2D/r9nXus48v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439558; c=relaxed/simple;
	bh=Sr8CiAzOXdegX3IcLCNNAKvNCbRuMazsiEFBfEvr3zc=;
	h=Received:Received:Message-ID:User-Agent:Date:From:To:Cc:Subject:
	 References:MIME-Version:Content-Type; b=TjDrRv71zrvqRmQJf4gY2JeqZnxoLhsVAVVj98QAiH1zYZKEXp3pOG2y3JuWqhKWfk7SKQ5Tzx3yhUuCax3LcrHZvNyZ5Y/osgkP0YyJPyzyVdh4JzRbi7LYdw3KLD0ww9XciI3F2ysjgVgHSfQkPRDYY07MjKo8IMUY2wcDMdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D63C433B2;
	Tue, 16 Jan 2024 21:12:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rPqkr-00000001PRT-3088;
	Tue, 16 Jan 2024 16:13:53 -0500
Message-ID: <20240116211353.573784051@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 16 Jan 2024 16:12:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al  Viro <viro@ZenIV.linux.org.uk>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 linux-fsdevel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 2/2] eventfs: Create list of files and directories at dir open
References: <20240116211217.968123837@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The original eventfs code added a wrapper around the dcache_readdir open
callback and created all the dentries and inodes at open, and increment
their ref count. A wrapper was added around the dcache_readdir release
function to decrement all the ref counts of those created inodes and
dentries. But this proved to be buggy[1] for when a kprobe was created
during a dir read, it would create a dentry between the open and the
release, and because the release would decrement all ref counts of all
files and directories, that would include the kprobe directory that was
not there to have its ref count incremented in open. This would cause the
ref count to go to negative and later crash the kernel.

To solve this, the dentries and inodes that were created and had their ref
count upped in open needed to be saved. That list needed to be passed from
the open to the release, so that the release would only decrement the ref
counts of the entries that were incremented in the open.

Unfortunately, the dcache_readdir logic was already using the
file->private_data, which is the only field that can be used to pass
information from the open to the release. What was done was the eventfs
created another descriptor that had a void pointer to save the
dcache_readdir pointer, and it wrapped all the callbacks, so that it could
save the list of entries that had their ref counts incremented in the
open, and pass it to the release. The wrapped callbacks would just put
back the dcache_readdir pointer and call the functions it used so it could
still use its data[2].

But Linus had an issue with the "hijacking" of the file->private_data
(unfortunately this discussion was on a security list, so no public link).
Which we finally agreed on doing everything within the iterate_shared
callback and leave the dcache_readdir out of it[3]. All the information
needed for the getents() could be created then.

But this ended up being buggy too[4]. The iterate_shared callback was not
the right place to create the dentries and inodes. Even Christian Brauner
had issues with that[5].

An attempt was to go back to creating the inodes and dentries at
the open, create an array to store the information in the
file->private_data, and pass that information to the other callbacks.[6]

The difference between that and the original method, is that it does not
use dcache_readdir. It also does not up the ref counts of the dentries and
pass them. Instead, it creates an array of a structure that saves the
dentry's name and inode number. That information is used in the
iterate_shared callback, and the array is freed in the dir release. The
dentries and inodes created in the open are not used for the iterate_share
or release callbacks. Just their names and inode numbers.

Linus did not like the creation of the dentries for the sole purpose of
getting their inode numbers. Instead, he suggested to just hard code them
even though they would not be unique.  With the hard coding of the inode
numbers, there's no need to create the dentries for readdir().

Now the list created at the dir open can just get the names from the meta
data and use the hard coded inode numbers.

This means that the state of the eventfs at the dir open remains the same
from the point of view of the getdents() function, until the dir is closed.
This also means that the getdents() will not fail. If there's an issue, it
fails at the dir open.

[1] https://lore.kernel.org/linux-trace-kernel/20230919211804.230edf1e@gandalf.local.home/
[2] https://lore.kernel.org/linux-trace-kernel/20230922163446.1431d4fa@gandalf.local.home/
[3] https://lore.kernel.org/linux-trace-kernel/20240104015435.682218477@goodmis.org/
[4] https://lore.kernel.org/all/202401152142.bfc28861-oliver.sang@intel.com/
[5] https://lore.kernel.org/all/20240111-unzahl-gefegt-433acb8a841d@brauner/
[6] https://lore.kernel.org/all/20240116114711.7e8637be@gandalf.local.home/

Fixes: 493ec81a8fb8 ("eventfs: Stop using dcache_readdir() for getdents()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401152142.bfc28861-oliver.sang@intel.com
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 213 +++++++++++++++++++++++++++------------
 1 file changed, 149 insertions(+), 64 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5edf0b96758b..05cd825d4cc9 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -57,7 +57,9 @@ enum {
 static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
+static int eventfs_dir_open(struct inode *inode, struct file *file);
 static int eventfs_iterate(struct file *file, struct dir_context *ctx);
+static int eventfs_dir_release(struct inode *inode, struct file *file);
 
 static void update_attr(struct eventfs_attr *attr, struct iattr *iattr)
 {
@@ -216,7 +218,9 @@ static const struct inode_operations eventfs_file_inode_operations = {
 
 static const struct file_operations eventfs_file_operations = {
 	.read		= generic_read_dir,
+	.open		= eventfs_dir_open,
 	.iterate_shared	= eventfs_iterate,
+	.release	= eventfs_dir_release,
 	.llseek		= generic_file_llseek,
 };
 
@@ -716,117 +720,198 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	return ret;
 }
 
+struct eventfs_dents {
+	const char		*name;
+	int			ino;
+	int			type;
+};
+
+struct eventfs_list {
+	struct eventfs_dents	*dents;
+	int			count;
+};
+
+static int update_entry(struct eventfs_dents *dents, const char *name,
+			int type, int cnt)
+{
+	dents[cnt].name = kstrdup_const(name, GFP_KERNEL);
+	if (!dents[cnt].name)
+		return -ENOMEM;
+	if (type == DT_DIR)
+		dents[cnt].ino = EVENTFS_DIR_INODE_INO;
+	else
+		dents[cnt].ino = EVENTFS_FILE_INODE_INO;
+	dents[cnt].type = type;
+	return 0;
+}
+
+static int add_entry(struct eventfs_dents **edents, const char *name,
+		     int type, int cnt)
+{
+	struct eventfs_dents *tmp;
+
+	tmp = krealloc(*edents, sizeof(**edents) * (cnt + 1), GFP_NOFS);
+	if (!tmp)
+		return -ENOMEM;
+	*edents = tmp;
+
+	return update_entry(tmp, name, type, cnt);
+}
+
 /*
  * Walk the children of a eventfs_inode to fill in getdents().
  */
-static int eventfs_iterate(struct file *file, struct dir_context *ctx)
+static int eventfs_dir_open(struct inode *inode, struct file *file)
 {
 	const struct file_operations *fops;
 	struct inode *f_inode = file_inode(file);
 	const struct eventfs_entry *entry;
+	struct eventfs_list *edents;
 	struct eventfs_inode *ei_child;
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
-	struct dentry *ei_dentry = NULL;
-	struct dentry *dentry;
+	struct eventfs_dents *dents;
 	const char *name;
 	umode_t mode;
+	void *data;
+	int cnt = 0;
 	int idx;
-	int ret = -EINVAL;
-	int ino;
-	int i, r, c;
-
-	if (!dir_emit_dots(file, ctx))
-		return 0;
+	int ret;
+	int i;
+	int r;
 
 	ti = get_tracefs(f_inode);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
 		return -EINVAL;
 
-	c = ctx->pos - 2;
+	if (WARN_ON_ONCE(file->private_data))
+		return -EINVAL;
 
 	idx = srcu_read_lock(&eventfs_srcu);
 
 	mutex_lock(&eventfs_mutex);
 	ei = READ_ONCE(ti->private);
-	if (ei && !ei->is_freed)
-		ei_dentry = READ_ONCE(ei->dentry);
+	if (ei && ei->is_freed)
+		ei = NULL;
 	mutex_unlock(&eventfs_mutex);
 
-	if (!ei || !ei_dentry)
-		goto out;
+	if (!ei) {
+		srcu_read_unlock(&eventfs_srcu, idx);
+		return -ENOENT;
+	}
+
+	data = ei->data;
+
+	edents = kmalloc(sizeof(*edents), GFP_KERNEL);
+	if (!edents) {
+		srcu_read_unlock(&eventfs_srcu, idx);
+		return -ENOMEM;
+	}
 
 	/*
-	 * Need to create the dentries and inodes to have a consistent
-	 * inode number.
+	 * Need to make a struct eventfs_dent array, start by
+	 * allocating enough for just the files, which is a fixed
+	 * array. Then use realloc via add_entry() for the directories
+	 * which is stored in a linked list.
 	 */
-	ret = 0;
-
-	/* Start at 'c' to jump over already read entries */
-	for (i = c; i < ei->nr_entries; i++, ctx->pos++) {
-		void *cdata = ei->data;
+	dents = kcalloc(ei->nr_entries, sizeof(*dents), GFP_KERNEL);
+	if (!dents) {
+		srcu_read_unlock(&eventfs_srcu, idx);
+		kfree(edents);
+		return -ENOMEM;
+	}
 
+	for (i = 0; i < ei->nr_entries; i++) {
+		void *cdata = data;
 		entry = &ei->entries[i];
 		name = entry->name;
-
 		mutex_lock(&eventfs_mutex);
-		/* If ei->is_freed then just bail here, nothing more to do */
-		if (ei->is_freed) {
-			mutex_unlock(&eventfs_mutex);
-			goto out;
-		}
-		r = entry->callback(name, &mode, &cdata, &fops);
+		/* If ei->is_freed, then the event itself may be too */
+		if (!ei->is_freed)
+			r = entry->callback(name, &mode, &cdata, &fops);
+		else
+			r = -1;
 		mutex_unlock(&eventfs_mutex);
-		if (r <= 0)
+		/* If the ei is being freed, no need to continue */
+		if (r < 0) {
+			ret = -ENOENT;
+			goto fail;
+		}
+		/* callbacks returning zero just means skip this file */
+		if (r == 0)
 			continue;
+		ret = update_entry(dents, name, DT_REG, cnt);
 
-		dentry = create_file_dentry(ei, i, ei_dentry, name, mode, cdata, fops);
-		if (!dentry)
-			goto out;
-		ino = dentry->d_inode->i_ino;
-		dput(dentry);
+		if (ret < 0)
+		    goto fail;
 
-		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
-			goto out;
+		cnt++;
 	}
 
-	/* Subtract the skipped entries above */
-	c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
-
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
+		ret = add_entry(&dents, ei_child->name, DT_DIR, cnt);
+		if (ret < 0)
+			goto fail;
+		cnt++;
+	}
 
-		if (c > 0) {
-			c--;
-			continue;
-		}
+	edents->count = cnt;
+	edents->dents = dents;
 
-		ctx->pos++;
+	srcu_read_unlock(&eventfs_srcu, idx);
+	file->private_data = edents;
+	return 0;
+ fail:
+	srcu_read_unlock(&eventfs_srcu, idx);
+	for (; cnt >= 0; cnt--)
+		kfree_const(dents[cnt].name);
+	kfree(dents);
+	kfree(edents);
+	return ret;
+}
 
-		if (ei_child->is_freed)
-			continue;
+static int eventfs_dir_release(struct inode *inode, struct file *file)
+{
+	struct eventfs_list *edents = file->private_data;
+	struct tracefs_inode *ti;
+	int i;
 
-		name = ei_child->name;
+	ti = get_tracefs(inode);
+	if (!(ti->flags & TRACEFS_EVENT_INODE))
+		return -EINVAL;
 
-		dentry = create_dir_dentry(ei, ei_child, ei_dentry);
-		if (!dentry)
-			goto out_dec;
-		ino = dentry->d_inode->i_ino;
-		dput(dentry);
+	if (WARN_ON_ONCE(!edents))
+		return -EINVAL;
 
-		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
-			goto out_dec;
+	for (i = 0; i < edents->count; i++) {
+		kfree_const(edents->dents[i].name);
 	}
-	ret = 1;
- out:
-	srcu_read_unlock(&eventfs_srcu, idx);
 
-	return ret;
+	kfree(edents->dents);
+	kfree(edents);
+	return 0;
+}
+
+static int eventfs_iterate(struct file *file, struct dir_context *ctx)
+{
+	struct eventfs_list *edents = file->private_data;
+	int i, c;
 
- out_dec:
-	/* Incremented ctx->pos without adding something, reset it */
-	ctx->pos--;
-	goto out;
+	if (!dir_emit_dots(file, ctx))
+		return 0;
+
+	c = ctx->pos - 2;
+
+	/* Start at 'c' to jump over already read entries */
+	for (i = c; i < edents->count; i++, ctx->pos++) {
+
+		if (!dir_emit(ctx, edents->dents[i].name,
+			      strlen(edents->dents[i].name),
+			      edents->dents[i].ino, edents->dents[i].type))
+			break;
+	}
+	return 0;
 }
 
 /**


