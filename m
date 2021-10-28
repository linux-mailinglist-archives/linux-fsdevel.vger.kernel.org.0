Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B48443DEE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 12:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1Keq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 06:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229868AbhJ1Keo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 06:34:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD51560F9D;
        Thu, 28 Oct 2021 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635417137;
        bh=r9gquzTWxRrZquZRFuRIDUUj/Icze5kkfGbuFZYknuc=;
        h=From:To:Cc:Subject:Date:From;
        b=czcCfnQzKwcvEfpl0hAyZkXtiHuLx6ylFXX1UczXcSR/YPg8Kotb5/QS0f3ohEEsq
         DRGQ9taKcyleTp+TvomimCv5Pxk2qzuvUVw1pOeO92ms+ulmU6czm+6byyDRdzztro
         NZJNQgOUmbSlcn8rvLGj0zrO3SwKDPmu3JAH401LJ+UbK366jUMz5Z2g22/8tEHj15
         Hh+LR2ONWrULqq7dYQ01lDAZ4rW7FVHHb2SCCRQ23DJWFI5uGkJhXtUYHEyAZSRDX5
         4IexgVJwIePC9SZvhxtM+uSK5p/+rsmHIhbH78ooDaF0RbavMm72U2g3vfe9ohCCGE
         KNOGcOrK0iEOg==
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Laurent Vivier <laurent@vivier.eu>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/2] binfmt_misc: cleanup on filesystem umount
Date:   Thu, 28 Oct 2021 12:31:13 +0200
Message-Id: <20211028103114.2849140-1-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
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
Cc: Sargun Dhillon <sargun@sargun.me>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Jann Horn <jannh@google.com>
Cc: Henning Schild <henning.schild@siemens.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/binfmt_misc.c | 56 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index e1eae7ea823a..5a9d5e44c750 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -60,12 +60,11 @@ typedef struct {
 	char *name;
 	struct dentry *dentry;
 	struct file *interp_file;
+	refcount_t ref;
 } Node;
 
 static DEFINE_RWLOCK(entries_lock);
 static struct file_system_type bm_fs_type;
-static struct vfsmount *bm_mnt;
-static int entry_count;
 
 /*
  * Max length of the register string.  Determined by:
@@ -126,6 +125,16 @@ static Node *check_file(struct linux_binprm *bprm)
 	return NULL;
 }
 
+/* Free node if we are sure load_misc_binary() is done with it. */
+static void put_node(Node *e)
+{
+	if (refcount_dec_and_test(&e->ref)) {
+		if (e->flags & MISC_FMT_OPEN_FILE)
+			filp_close(e->interp_file, NULL);
+		kfree(e);
+	}
+}
+
 /*
  * the loader itself
  */
@@ -142,8 +151,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	/* to keep locking time low, we copy the interpreter string */
 	read_lock(&entries_lock);
 	fmt = check_file(bprm);
+	/* Make sure the node isn't freed behind our back. */
 	if (fmt)
-		dget(fmt->dentry);
+		refcount_inc(&fmt->ref);
 	read_unlock(&entries_lock);
 	if (!fmt)
 		return retval;
@@ -198,7 +208,16 @@ static int load_misc_binary(struct linux_binprm *bprm)
 
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
+	put_node(fmt);
+
 	return retval;
 }
 
@@ -557,26 +576,29 @@ static void bm_evict_inode(struct inode *inode)
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
+		list_del_init(&e->list);
+		write_unlock(&entries_lock);
+		put_node(e);
+	}
 }
 
 static void kill_node(Node *e)
 {
 	struct dentry *dentry;
 
-	write_lock(&entries_lock);
-	list_del_init(&e->list);
-	write_unlock(&entries_lock);
-
+	/*
+	 * It's fine to unconditionally drop the dentry since ->evict_inode()
+	 * will check the refcount before freeing the node and so it can't go
+	 * away behind load_misc_binary()'s back.
+	 */
 	dentry = e->dentry;
 	drop_nlink(d_inode(dentry));
 	d_drop(dentry);
 	dput(dentry);
-	simple_release_fs(&bm_mnt, &entry_count);
 }
 
 /* /<entry> */
@@ -683,13 +705,7 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 	if (!inode)
 		goto out2;
 
-	err = simple_pin_fs(&bm_fs_type, &bm_mnt, &entry_count);
-	if (err) {
-		iput(inode);
-		inode = NULL;
-		goto out2;
-	}
-
+	refcount_set(&e->ref, 1);
 	e->dentry = dget(dentry);
 	inode->i_private = e;
 	inode->i_fop = &bm_entry_operations;

base-commit: 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
-- 
2.30.2

