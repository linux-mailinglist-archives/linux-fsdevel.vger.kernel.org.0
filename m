Return-Path: <linux-fsdevel+bounces-7269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028EF82376E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14AD286278
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFF11DA3E;
	Wed,  3 Jan 2024 22:04:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BBC1DA26;
	Wed,  3 Jan 2024 22:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BCCC433C8;
	Wed,  3 Jan 2024 22:04:52 +0000 (UTC)
Date: Wed, 3 Jan 2024 17:05:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
Message-ID: <20240103170556.28df7163@gandalf.local.home>
In-Reply-To: <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
References: <20240103102553.17a19cea@gandalf.local.home>
	<CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
	<CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
	<20240103145306.51f8a4cd@gandalf.local.home>
	<CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
	<CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 13:54:36 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, 3 Jan 2024 at 11:57, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Or, you know, you could do what I've told you to do at least TEN TIMES
> > already, which is to not mess with any of this, and just implement the
> > '->permission()' callback (and getattr() to just make 'ls' look sane
> > too, rather than silently saying "we'll act as if gid is set right,
> > but not show it").
> 
> Actually, an even simpler option might be to just do this all at
> d_revalidate() time.
> 
> Here's an updated patch that builds, and is PURELY AN EXAMPLE. I think
> it "works", but it currently always resets the inode mode/uid/gid
> unconditionally, which is wrong - it should not do so if the inode has
> been manually set.
> 
> So take this as a "this might work", but it probably needs a bit more
> work - eventfs_set_attr() should set some bit in the inode to say
> "these have been set manually", and then revalidate would say "I'll
> not touch inodes that have that bit set".
> 
> Or something.
> 
> Anyway, this patch is nwo relative to your latest pull request, so it
> has the check for dentry->d_inode in set_gid() (and still removes the
> whole function).
> 
> Again: UNTESTED, and meant as a "this is another way to avoid messing
> with the dentry tree manually, and just using the VFS interfaces we
> already have"
> 

I actually have something almost working too. Here's the WIP. It only works
for tracefs, and now eventfs needs to be updated as the "events" directory
no longer has the right ownership. So I need a way to link the eventfs
entries to use the tracefs default conditionally.

The issue I'm currently working on is to make the files of:

  /sys/kernel/tracing/events

default to the root of tracefs, but

 /sys/kernel/tracing/instances/foo/events

to default to what events was when it was created by "mkdir instances/foo".

But other than that, the tracefs part seems to work.

-- Steve

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index ae648deed019..9c55dc903d7d 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -141,10 +141,76 @@ static int tracefs_syscall_rmdir(struct inode *inode, struct dentry *dentry)
 	return ret;
 }
 
-static const struct inode_operations tracefs_dir_inode_operations = {
+static void set_tracefs_inode_owner(struct inode *inode)
+{
+	struct inode *root_inode = d_inode(inode->i_sb->s_root);
+	struct tracefs_inode *ti = get_tracefs(inode);
+
+	/*
+	 * If this inode has never been referenced, then update
+	 * the permissions to the superblock.
+	 */
+	if (!(ti->flags & TRACEFS_EVENT_UID_PERM_SET))
+		inode->i_uid = root_inode->i_uid;
+
+	if (!(ti->flags & TRACEFS_EVENT_GID_PERM_SET))
+		inode->i_gid = root_inode->i_gid;
+}
+
+static int tracefs_permission(struct mnt_idmap *idmap,
+			      struct inode *inode, int mask)
+{
+	set_tracefs_inode_owner(inode);
+	return generic_permission(idmap, inode, mask);
+}
+
+static int tracefs_getattr(struct mnt_idmap *idmap,
+			   const struct path *path, struct kstat *stat,
+			   u32 request_mask, unsigned int flags)
+{
+	struct inode *inode = d_backing_inode(path->dentry);
+
+	set_tracefs_inode_owner(inode);
+	generic_fillattr(idmap, request_mask, inode, stat);
+	return 0;
+}
+
+static int tracefs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
+			   struct iattr *attr)
+{
+	unsigned int ia_valid = attr->ia_valid;
+	struct inode *inode = d_inode(dentry);
+	struct tracefs_inode *ti = get_tracefs(inode);
+
+	if (ia_valid & ATTR_UID)
+		ti->flags |= TRACEFS_EVENT_UID_PERM_SET;
+
+	if (ia_valid & ATTR_GID)
+		ti->flags |= TRACEFS_EVENT_GID_PERM_SET;
+
+	return simple_setattr(idmap, dentry, attr);
+}
+
+static const struct inode_operations tracefs_instance_dir_inode_operations = {
 	.lookup		= simple_lookup,
 	.mkdir		= tracefs_syscall_mkdir,
 	.rmdir		= tracefs_syscall_rmdir,
+	.permission	= tracefs_permission,
+	.getattr	= tracefs_getattr,
+	.setattr	= tracefs_setattr,
+};
+
+static const struct inode_operations tracefs_dir_inode_operations = {
+	.lookup		= simple_lookup,
+	.permission	= tracefs_permission,
+	.getattr	= tracefs_getattr,
+	.setattr	= tracefs_setattr,
+};
+
+static const struct inode_operations tracefs_file_inode_operations = {
+	.permission	= tracefs_permission,
+	.getattr	= tracefs_getattr,
+	.setattr	= tracefs_setattr,
 };
 
 struct inode *tracefs_get_inode(struct super_block *sb)
@@ -183,77 +249,6 @@ struct tracefs_fs_info {
 	struct tracefs_mount_opts mount_opts;
 };
 
-static void change_gid(struct dentry *dentry, kgid_t gid)
-{
-	if (!dentry->d_inode)
-		return;
-	dentry->d_inode->i_gid = gid;
-}
-
-/*
- * Taken from d_walk, but without he need for handling renames.
- * Nothing can be renamed while walking the list, as tracefs
- * does not support renames. This is only called when mounting
- * or remounting the file system, to set all the files to
- * the given gid.
- */
-static void set_gid(struct dentry *parent, kgid_t gid)
-{
-	struct dentry *this_parent;
-	struct list_head *next;
-
-	this_parent = parent;
-	spin_lock(&this_parent->d_lock);
-
-	change_gid(this_parent, gid);
-repeat:
-	next = this_parent->d_subdirs.next;
-resume:
-	while (next != &this_parent->d_subdirs) {
-		struct list_head *tmp = next;
-		struct dentry *dentry = list_entry(tmp, struct dentry, d_child);
-		next = tmp->next;
-
-		spin_lock_nested(&dentry->d_lock, DENTRY_D_LOCK_NESTED);
-
-		change_gid(dentry, gid);
-
-		if (!list_empty(&dentry->d_subdirs)) {
-			spin_unlock(&this_parent->d_lock);
-			spin_release(&dentry->d_lock.dep_map, _RET_IP_);
-			this_parent = dentry;
-			spin_acquire(&this_parent->d_lock.dep_map, 0, 1, _RET_IP_);
-			goto repeat;
-		}
-		spin_unlock(&dentry->d_lock);
-	}
-	/*
-	 * All done at this level ... ascend and resume the search.
-	 */
-	rcu_read_lock();
-ascend:
-	if (this_parent != parent) {
-		struct dentry *child = this_parent;
-		this_parent = child->d_parent;
-
-		spin_unlock(&child->d_lock);
-		spin_lock(&this_parent->d_lock);
-
-		/* go into the first sibling still alive */
-		do {
-			next = child->d_child.next;
-			if (next == &this_parent->d_subdirs)
-				goto ascend;
-			child = list_entry(next, struct dentry, d_child);
-		} while (unlikely(child->d_flags & DCACHE_DENTRY_KILLED));
-		rcu_read_unlock();
-		goto resume;
-	}
-	rcu_read_unlock();
-	spin_unlock(&this_parent->d_lock);
-	return;
-}
-
 static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 {
 	substring_t args[MAX_OPT_ARGS];
@@ -326,10 +321,8 @@ static int tracefs_apply_options(struct super_block *sb, bool remount)
 	if (!remount || opts->opts & BIT(Opt_uid))
 		inode->i_uid = opts->uid;
 
-	if (!remount || opts->opts & BIT(Opt_gid)) {
-		/* Set all the group ids to the mount option */
-		set_gid(sb->s_root, opts->gid);
-	}
+	if (!remount || opts->opts & BIT(Opt_gid))
+		inode->i_gid = opts->gid;
 
 	return 0;
 }
@@ -612,6 +605,7 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
 		return tracefs_failed_creating(dentry);
 
 	inode->i_mode = mode;
+	inode->i_op = &tracefs_file_inode_operations;
 	inode->i_fop = fops ? fops : &tracefs_file_operations;
 	inode->i_private = data;
 	inode->i_uid = d_inode(dentry->d_parent)->i_uid;
@@ -671,7 +665,7 @@ struct dentry *tracefs_create_dir(const char *name, struct dentry *parent)
 	if (security_locked_down(LOCKDOWN_TRACEFS))
 		return NULL;
 
-	return __create_dir(name, parent, &simple_dir_inode_operations);
+	return __create_dir(name, parent, &tracefs_dir_inode_operations);
 }
 
 /**
@@ -702,7 +696,7 @@ __init struct dentry *tracefs_create_instance_dir(const char *name,
 	if (WARN_ON(tracefs_ops.mkdir || tracefs_ops.rmdir))
 		return NULL;
 
-	dentry = __create_dir(name, parent, &tracefs_dir_inode_operations);
+	dentry = __create_dir(name, parent, &tracefs_instance_dir_inode_operations);
 	if (!dentry)
 		return NULL;
 
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index ccee18ca66c7..20a021bd5acb 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -5,6 +5,8 @@
 enum {
 	TRACEFS_EVENT_INODE		= BIT(1),
 	TRACEFS_EVENT_TOP_INODE		= BIT(2),
+	TRACEFS_EVENT_GID_PERM_SET	= BIT(3),
+	TRACEFS_EVENT_UID_PERM_SET	= BIT(4),
 };
 
 struct tracefs_inode {

