Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DD647703B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Dec 2021 12:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233921AbhLPL3M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Dec 2021 06:29:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40592 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbhLPL3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:29:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28AD261A34;
        Thu, 16 Dec 2021 11:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBB7C36AE4;
        Thu, 16 Dec 2021 11:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639654150;
        bh=oBKeil5F44lwccqIU7AXSsB9JYywqOF7vqRJ4H6zzUc=;
        h=From:To:Cc:Subject:Date:From;
        b=f0Gkfdm8QHohmPI/UJYNageaaSftgdbxqKR1MR8YY1zyLnbuRmIeL3ur77P1o0BJW
         Qct0R7KoIfEM2N1r9u65OUAUR/eOWstjRokDns1xwrUYHvydMSHI+ilgF6quxjKeK4
         +4PPmryBy4z0dM89VhSFSkk3n6kWCh9LXn5ZCzoeacrZk/av7czxkj+HhHn0fBTqEQ
         Vo4yUUA0eKfUaVVOsH2dRBY+GJ6FXccH2ydIFJEyWzLGMPEmExTi92Q7yc1imKek9+
         lee5e0DiLB2Zn7oQgB1TkUPiMa/ONv6aqYLNgqzPuPkv8ljKpr3dK4JV/r/XAeBn3C
         IHHZgkkI5ux1g==
From:   Christian Brauner <brauner@kernel.org>
To:     Serge Hallyn <serge@hallyn.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 1/2] binfmt_misc: cleanup on filesystem umount
Date:   Thu, 16 Dec 2021 12:26:58 +0100
Message-Id: <20211216112659.310979-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15789; h=from:subject; bh=1EGwNR6ubkmOHPn0VPp2G4wTY2NnbRwY2nmRE0DZoF0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTuVsphiMiPK5KsFWFY/zvpbd+9zeVLPE5MkPx+iGfG88c/ M2RTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDaEi1MAJhIhxsjQkfdkVW3N8wvuHmzh0hF2pZ dPX11883RoeVv7R8VvFhNtGf4HTfy5y7VZJ907LHJicI62Of+Lc7NEbnx81pZxQqJH0ZwVAA==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Currently, registering a new binary type pins the binfmt_misc
filesystem. Specifically, this means that as long as there is at least
one binary type registered the binfmt_misc filesystem survives all
umounts, i.e. the superblock is not destroyed. Meaning that a umount
followed by another mount will end up with the same superblock and the
same binary type handlers. This is a behavior we tend to discourage for
any new filesystems (apart from a few special filesystems such as e.g.
configfs or debugfs). A umount operation without the filesystem being
pinned - by e.g. someone holding a file descriptor to an open file -
should usually result in the destruction of the superblock and all
associated resources. This makes introspection easier and leads to
clearly defined, simple and clean semantics. An administrator can rely
on the fact that a umount will guarantee a clean slate making it
possible to reinitialize a filesystem. Right now all binary types would
need to be explicitly deleted before that can happen.

This allows us to remove the heavy-handed calls to simple_pin_fs() and
simple_release_fs() when creating and deleting binary types. This in
turn allows us to replace the current brittle pinning mechanism abusing
dget() which has caused a range of bugs judging from prior fixes in [2]
and [3]. The additional dget() in load_misc_binary() pins the dentry but
only does so for the sake to prevent ->evict_inode() from freeing the
node when a user removes the binary type and kill_node() is run. Which
would mean ->interpreter and ->interp_file would be freed causing a UAF.

This isn't really nicely documented nor is it very clean because it
relies on simple_pin_fs() pinning the filesystem as long as at least one
binary type exists. Otherwise it would cause load_misc_binary() to hold
on to a dentry belonging to a superblock that has been shutdown.
Replace that implicit pinning with a clean and simple per-node refcount
and get rid of the ugly dget() pinning. A similar mechanism exists for
e.g. binderfs (cf. [4]). All the cleanup work can now be done in
->evict_inode().

In a follow-up patch we will make it possible to use binfmt_misc in
sandboxes. We will use the cleaner semantics where a umount for the
filesystem will cause the superblock and all resources to be
deallocated. In preparation for this apply the same semantics to the
initial binfmt_misc mount. Note, that this is a user-visible change and
as such a uapi change but one that we can reasonably risk. We've
discussed this in earlier versions of this patchset (cf. [1]).

The main user and provider of binfmt_misc is systemd. Systemd provides
binfmt_misc via autofs since it is configurable as a kernel module and
is used by a few exotic packages and users. As such a binfmt_misc mount
is triggered when /proc/sys/fs/binfmt_misc is accessed and is only
provided on demand. Other autofs on demand filesystems include EFI ESP
which systemd umounts if the mountpoint stays idle for a certain amount
of time. This doesn't apply to the binfmt_misc autofs mount which isn't
touched once it is mounted meaning this change can't accidently wipe
binary type handlers without someone having explicitly unmounted
binfmt_misc. After speaking to systemd folks they don't expect this
change to affect them.

In line with our general policy, if we see a regression for systemd or
other users with this change we will switch back to the old behavior for
the initial binfmt_misc mount and have binary types pin the filesystem
again. But while we touch this code let's take the chance and let's
improve on the status quo.

[1]: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu
[2]: commit 43a4f2619038 ("exec: binfmt_misc: fix race between load_misc_binary() and kill_node()"
[3]: commit 83f918274e4b ("exec: binfmt_misc: shift filp_close(interp_file) from kill_node() to bm_evict_inode()")
[4]: commit f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")

Link: https://lore.kernel.org/r/20211028103114.2849140-1-brauner@kernel.org (v1)
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com>
Cc: Henning Schild <henning.schild@siemens.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: linux-fsdevel@vger.kernel.org
Acked-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <christian.brauner@ubuntu.com>:
  - Add more comments that explain what's going on.
  - Rename functions while changing them to better reflect what they are
    doing to make the code easier to understand.
  - In the first version when a specific binary type handler was removed
    either through a write to the entry's file or all binary type
    handlers were removed by a write to the binfmt_misc mount's status
    file all cleanup work happened during inode eviction.
    That includes removal of the relevant entries from entry list. While
    that works fine I disliked that model after thinking about it for a
    bit. Because it means that there was a window were someone has
    already removed a or all binary handlers but they could still be
    safely reached from load_misc_binary() when it has managed to take
    the read_lock() on the entries list while inode eviction was already
    happening. Again, that perfectly benign but it's cleaner to remove
    the binary handler from the list immediately meaning that ones the
    write to then entry's file or the binfmt_misc status file returns
    the binary type cannot be executed anymore. That gives stronger
    guarantees to the user.
---
 fs/binfmt_misc.c | 213 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 165 insertions(+), 48 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index e1eae7ea823a..3fd99a20694b 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -60,12 +60,11 @@ typedef struct {
 	char *name;
 	struct dentry *dentry;
 	struct file *interp_file;
+	refcount_t users;		/* sync removal with load_misc_binary() */
 } Node;
 
 static DEFINE_RWLOCK(entries_lock);
 static struct file_system_type bm_fs_type;
-static struct vfsmount *bm_mnt;
-static int entry_count;
 
 /*
  * Max length of the register string.  Determined by:
@@ -82,19 +81,22 @@ static int entry_count;
  */
 #define MAX_REGISTER_LENGTH 1920
 
-/*
- * Check if we support the binfmt
- * if we do, return the node, else NULL
- * locking is done in load_misc_binary
+/**
+ * search_binfmt_handler - search for a binary handler for @bprm
+ * @bprm: binary for which we are looking for a handler
+ *
+ * Search for a binary type handler for @bprm in the list of registered binary
+ * type handlers.
+ *
+ * Return: binary type list entry on success, NULL on failure
  */
-static Node *check_file(struct linux_binprm *bprm)
+static Node *search_binfmt_handler(struct linux_binprm *bprm)
 {
 	char *p = strrchr(bprm->interp, '.');
-	struct list_head *l;
+	Node *e;
 
 	/* Walk all the registered handlers. */
-	list_for_each(l, &entries) {
-		Node *e = list_entry(l, Node, list);
+	list_for_each_entry(e, &entries, list) {
 		char *s;
 		int j;
 
@@ -123,9 +125,48 @@ static Node *check_file(struct linux_binprm *bprm)
 		if (j == e->size)
 			return e;
 	}
+
 	return NULL;
 }
 
+/**
+ * get_binfmt_handler - try to find a binary type handler
+ * @bprm: binary for which we are looking for a handler
+ *
+ * Try to find a binfmt handler for the binary type. If one is found take a
+ * reference to protect against removal via bm_{entry,status}_write().
+ *
+ * Return: binary type list entry on success, NULL on failure
+ */
+static Node *get_binfmt_handler(struct linux_binprm *bprm)
+{
+	Node *e;
+
+	read_lock(&entries_lock);
+	e = search_binfmt_handler(bprm);
+	if (e)
+		refcount_inc(&e->users);
+	read_unlock(&entries_lock);
+	return e;
+}
+
+/**
+ * put_binfmt_handler - put binary handler node
+ * @e: node to put
+ *
+ * Free node syncing with load_misc_binary() and defer final free to
+ * load_misc_binary() in case it is using the binary type handler we were
+ * requested to remove.
+ */
+static void put_binfmt_handler(Node *e)
+{
+	if (refcount_dec_and_test(&e->users)) {
+		if (e->flags & MISC_FMT_OPEN_FILE)
+			filp_close(e->interp_file, NULL);
+		kfree(e);
+	}
+}
+
 /*
  * the loader itself
  */
@@ -139,12 +180,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	if (!enabled)
 		return retval;
 
-	/* to keep locking time low, we copy the interpreter string */
-	read_lock(&entries_lock);
-	fmt = check_file(bprm);
-	if (fmt)
-		dget(fmt->dentry);
-	read_unlock(&entries_lock);
+	fmt = get_binfmt_handler(bprm);
 	if (!fmt)
 		return retval;
 
@@ -198,7 +234,16 @@ static int load_misc_binary(struct linux_binprm *bprm)
 
 	retval = 0;
 ret:
-	dput(fmt->dentry);
+
+	/*
+	 * If we actually put the node here all concurrent calls to
+	 * load_misc_binary() will have finished. We also know
+	 * that for the refcount to be zero ->evict_inode() must have removed
+	 * the node to be deleted from the list. All that is left for us is to
+	 * close and free.
+	 */
+	put_binfmt_handler(fmt);
+
 	return retval;
 }
 
@@ -553,30 +598,89 @@ static struct inode *bm_get_inode(struct super_block *sb, int mode)
 	return inode;
 }
 
+/**
+ * bm_evict_inode - cleanup data associated with @inode
+ * @inode: inode to which the data is attached
+ *
+ * Cleanup the binary type handler data associated with @inode if a binary type
+ * entry is removed or the filesystem is unmounted and the super block is
+ * shutdown.
+ *
+ * If the ->evict call was not caused by a super block shutdown but by a write
+ * to remove the entry or all entries via bm_{entry,status}_write() the entry
+ * will have already been removed from the list. We keep the list_empty() check
+ * to make that explicit.
+*/
 static void bm_evict_inode(struct inode *inode)
 {
 	Node *e = inode->i_private;
 
-	if (e && e->flags & MISC_FMT_OPEN_FILE)
-		filp_close(e->interp_file, NULL);
-
 	clear_inode(inode);
-	kfree(e);
+
+	if (e) {
+		write_lock(&entries_lock);
+		if (!list_empty(&e->list))
+			list_del_init(&e->list);
+		write_unlock(&entries_lock);
+		put_binfmt_handler(e);
+	}
 }
 
-static void kill_node(Node *e)
+/**
+ * unlink_binfmt_dentry - remove the dentry for the binary type handler
+ * @dentry: dentry associated with the binary type handler
+ *
+ * Do the actual filesystem work to remove a dentry for a registered binary
+ * type handler. Since binfmt_misc only allows simple files to be created
+ * directly under the root dentry of the filesystem we ensure that we are
+ * indeed passed a dentry directly beneath the root dentry, that the inode
+ * associated with the root dentry is locked, and that it is a regular file we
+ * are asked to remove.
+ */
+static void unlink_binfmt_dentry(struct dentry *dentry)
 {
-	struct dentry *dentry;
+	struct dentry *parent = dentry->d_parent;
+	struct inode *inode, *parent_inode;
+
+	/* All entries are immediate descendants of the root dentry. */
+	if (WARN_ON_ONCE(dentry->d_sb->s_root != parent))
+		return;
 
+	/* We only expect to be called on regular files. */
+	inode = d_inode(dentry);
+	if (WARN_ON_ONCE(!S_ISREG(inode->i_mode)))
+		return;
+
+	/* The parent inode must be locked. */
+	parent_inode = d_inode(parent);
+	if (WARN_ON_ONCE(!inode_is_locked(parent_inode)))
+		return;
+
+	if (simple_positive(dentry)) {
+		dget(dentry);
+		simple_unlink(parent_inode, dentry);
+		d_delete(dentry);
+		dput(dentry);
+	}
+}
+
+/**
+ * remove_binfmt_handler - remove a binary type handler
+ * @e: binary type handler to remove
+ *
+ * Remove a binary type handler from the list of binary type handlers and
+ * remove its associated dentry. This is called from
+ * binfmt_{entry,status}_write(). In the future, we might want to think about
+ * adding a proper ->unlink() method to binfmt_misc instead of forcing caller's
+ * to use writes to files in order to delete binary type handlers. But it has
+ * worked for so long that it's not a pressing issue.
+ */
+static void remove_binfmt_handler(Node *e)
+{
 	write_lock(&entries_lock);
 	list_del_init(&e->list);
 	write_unlock(&entries_lock);
-
-	dentry = e->dentry;
-	drop_nlink(d_inode(dentry));
-	d_drop(dentry);
-	dput(dentry);
-	simple_release_fs(&bm_mnt, &entry_count);
+	unlink_binfmt_dentry(e->dentry);
 }
 
 /* /<entry> */
@@ -603,8 +707,8 @@ bm_entry_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
-	struct dentry *root;
-	Node *e = file_inode(file)->i_private;
+	struct inode *inode = file_inode(file);
+	Node *e = inode->i_private;
 	int res = parse_command(buffer, count);
 
 	switch (res) {
@@ -618,13 +722,22 @@ static ssize_t bm_entry_write(struct file *file, const char __user *buffer,
 		break;
 	case 3:
 		/* Delete this handler. */
-		root = file_inode(file)->i_sb->s_root;
-		inode_lock(d_inode(root));
+		inode = d_inode(inode->i_sb->s_root);
+		inode_lock(inode);
 
+		/*
+		 * In order to add new element or remove elements from the list
+		 * via bm_{entry,register,status}_write() inode_lock() on the
+		 * root inode must be held.
+		 * The lock is exclusive ensuring that the list can't be
+		 * modified. Only load_misc_binary() can access but does so
+		 * read-only. So we only need to take the write lock when we
+		 * actually remove the entry from the list.
+		 */
 		if (!list_empty(&e->list))
-			kill_node(e);
+			remove_binfmt_handler(e);
 
-		inode_unlock(d_inode(root));
+		inode_unlock(inode);
 		break;
 	default:
 		return res;
@@ -683,13 +796,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	if (!inode)
 		goto out2;
 
-	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
-	if (err) {
-		iput(inode);
-		inode = NULL;
-		goto out2;
-	}
-
+	refcount_set(&e->users, 1);
 	e->dentry = dget(dentry);
 	inode->i_private = e;
 	inode->i_fop = &bm_entry_operations;
@@ -733,7 +840,8 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		size_t count, loff_t *ppos)
 {
 	int res = parse_command(buffer, count);
-	struct dentry *root;
+	Node *e, *next;
+	struct inode *inode;
 
 	switch (res) {
 	case 1:
@@ -746,13 +854,22 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 		break;
 	case 3:
 		/* Delete all handlers. */
-		root = file_inode(file)->i_sb->s_root;
-		inode_lock(d_inode(root));
+		inode = d_inode(file_inode(file)->i_sb->s_root);
+		inode_lock(inode);
 
-		while (!list_empty(&entries))
-			kill_node(list_first_entry(&entries, Node, list));
+		/*
+		 * In order to add new element or remove elements from the list
+		 * via bm_{entry,register,status}_write() inode_lock() on the
+		 * root inode must be held.
+		 * The lock is exclusive ensuring that the list can't be
+		 * modified. Only load_misc_binary() can access but does so
+		 * read-only. So we only need to take the write lock when we
+		 * actually remove the entry from the list.
+		 */
+		list_for_each_entry_safe(e, next, &entries, list)
+			remove_binfmt_handler(e);
 
-		inode_unlock(d_inode(root));
+		inode_unlock(inode);
 		break;
 	default:
 		return res;

base-commit: d58071a8a76d779eedab38033ae4c821c30295a5
-- 
2.30.2

