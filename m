Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE5AC27BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 23:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbfI3VDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 17:03:21 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:16490 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731678AbfI3VDS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:03:18 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 06149A18A5;
        Mon, 30 Sep 2019 20:34:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id ucvH_ulkmMdN; Mon, 30 Sep 2019 20:34:51 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v13 1/9] namei: obey trailing magic-link DAC permissions
Date:   Tue,  1 Oct 2019 04:33:08 +1000
Message-Id: <20190930183316.10190-2-cyphar@cyphar.com>
In-Reply-To: <20190930183316.10190-1-cyphar@cyphar.com>
References: <20190930183316.10190-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ability for userspace to "re-open" file descriptors through
/proc/self/fd has been a very useful tool for all sorts of usecases
(container runtimes are one common example). However, the current
interface for doing this has resulted in some pretty subtle security
holes. Userspace can re-open a file descriptor with more permissions
than the original, which can result in cases such as /proc/$pid/exe
being re-opened O_RDWR at a later date even though (by definition)
/proc/$pid/exe cannot be opened for writing. When combined with O_PATH
the results can get even more confusing.

We cannot block this outright. Aside from userspace already depending on
it, it's a useful feature which can actually increase the security of
userspace. For instance, LXC keeps an O_PATH of the container's
/dev/pts/ptmx that gets re-opened to create new ptys and then uses
TIOCGPTPEER to get the slave end. This allows for pty allocation without
resolving paths inside an (untrusted) container's rootfs. There isn't a
trivial way of doing this that is as straight-forward and safe as O_PATH
re-opening.

Instead we have to restrict it in such a way that it doesn't break
(good) users but does block potential attackers. The solution applied in
this patch is to restrict *re-opening* (not resolution through)
magic-links by requiring that mode of the link be obeyed. Normal
symlinks have modes of a+rwx but magic-links have other modes. These
magic-link modes were historically ignored during path resolution, but
they've now been re-purposed for more useful ends.

It is also necessary to define semantics for the mode of an O_PATH
descriptor, since re-opening a magic-link through an O_PATH needs to be
just as restricted as the corresponding magic-link -- otherwise the
above protection can be bypassed. There are two distinct cases:

 1. The target is a regular file (not a magic-link). Userspace depends
    on being able to re-open the O_PATH of a regular file, so we must
    define the mode to be a+rwx.

 2. The target is a magic-link. In this case, we simply copy the mode of
    the magic-link. This results in an O_PATH of a magic-link
    effectively acting as a no-op in terms of how much re-opening
    privileges a process has.

CAP_DAC_OVERRIDE can be used to override all of these restrictions, but
we only permit &init_userns's capabilities to affect these semantics.
The reason for this is that there isn't a clear way to track what
user_ns is the original owner of a given O_PATH chain -- thus an
unprivileged user could create a new userns and O_PATH the file
descriptor, owning it. All signs would indicate that the user really
does have CAP_DAC_OVERRIDE over the new descriptor and the protection
would be bypassed. We thus opt for the more conservative approach.

I have run this patch on several machines for several days. So far, the
only processes which have hit this case ("loadkeys" and "kbd_mode" from
the kbd package[1]) gracefully handle the permission error and do not
cause any user-visible problems. In order to give users a heads-up, a
warning is output to dmesg whenever may_open_magiclink() refuses access.

Additionally, in order to avoid an attack that Jann Horn found
(involving swapping a single fd between a re-openable file and a
non-reopenable one), we must recompute and save the relevant DAC mode
when doing the jump in nd_jump_link() -- rather than just using
nd->link_inode->i_mode. A PoC of this attack is included as a selftest
later in the patch series.

[1]: http://git.altlinux.org/people/legion/packages/kbd.git

Suggested-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/internal.h                  |   1 +
 fs/namei.c                     | 111 +++++++++++++++++++++++++++++----
 fs/open.c                      |   3 +-
 fs/proc/base.c                 |  49 ++++++++++-----
 fs/proc/fd.c                   |  45 ++++++++++---
 fs/proc/internal.h             |   2 +-
 fs/proc/namespaces.c           |   2 +-
 include/linux/fs.h             |   4 ++
 include/linux/namei.h          |   5 +-
 security/apparmor/apparmorfs.c |   2 +-
 10 files changed, 183 insertions(+), 41 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 315fcd8d237c..f48449a43626 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -119,6 +119,7 @@ struct open_flags {
 	int acc_mode;
 	int intent;
 	int lookup_flags;
+	fmode_t opath_mask;
 };
 extern struct file *do_filp_open(int dfd, struct filename *pathname,
 		const struct open_flags *op);
diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..0e3a47e6f12c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -504,6 +504,7 @@ struct nameidata {
 	struct filename	*name;
 	struct nameidata *saved;
 	struct inode	*link_inode;
+	umode_t last_magiclink_mode;
 	unsigned	root_seq;
 	int		dfd;
 } __randomize_layout;
@@ -859,14 +860,15 @@ static int nd_jump_root(struct nameidata *nd)
  * Helper to directly jump to a known parsed path from ->get_link,
  * caller must have taken a reference to path beforehand.
  */
-void nd_jump_link(struct path *path)
+void nd_jump_link(struct path *path, umode_t mode)
 {
 	struct nameidata *nd = current->nameidata;
 	path_put(&nd->path);
 
 	nd->path = *path;
 	nd->inode = nd->path.dentry->d_inode;
-	nd->flags |= LOOKUP_JUMPED;
+	nd->flags |= LOOKUP_JUMPED | LOOKUP_MAGICLINK_JUMPED;
+	nd->last_magiclink_mode = mode;
 }
 
 static inline void put_link(struct nameidata *nd)
@@ -1060,6 +1062,7 @@ const char *get_link(struct nameidata *nd)
 		return ERR_PTR(error);
 
 	nd->last_type = LAST_BIND;
+	nd->flags &= ~LOOKUP_MAGICLINK_JUMPED;
 	res = READ_ONCE(inode->i_link);
 	if (!res) {
 		const char * (*get)(struct dentry *, struct inode *,
@@ -3493,16 +3496,75 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	return error;
 }
 
-static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
+/**
+ * may_reopen_magiclink - Check permissions for opening a trailing magic-link
+ * @upgrade_mask: the upgrade-mask of the magic-link
+ * @acc_mode: ACC_MODE which the user is attempting
+ *
+ * We block magic-link re-opening if the @upgrade_mask is more strict than the
+ * @acc_mode being requested, unless the user is capable(CAP_DAC_OVERRIDE).
+ *
+ * Returns 0 if successful, -EACCES on error.
+ */
+static int may_open_magiclink(fmode_t upgrade_mask, int acc_mode)
 {
-	struct path path;
-	int error = path_lookupat(nd, flags, &path);
-	if (!error) {
-		audit_inode(nd->name, path.dentry, 0);
-		error = vfs_open(&path, file);
-		path_put(&path);
-	}
-	return error;
+	/*
+	 * We only allow for init_userns to be able to override magic-links.
+	 * This is done to avoid cases where an unprivileged userns could take
+	 * an O_PATH of the fd, resulting in it being very unclear whether
+	 * CAP_DAC_OVERRIDE should work on the new O_PATH fd (given that it
+	 * pipes through to the underlying file).
+	 */
+	if (capable(CAP_DAC_OVERRIDE))
+		return 0;
+
+	if ((acc_mode & MAY_READ) &&
+	    !(upgrade_mask & (FMODE_READ | FMODE_PATH_READ)))
+		goto err;
+	if ((acc_mode & MAY_WRITE) &&
+	    !(upgrade_mask & (FMODE_WRITE | FMODE_PATH_WRITE)))
+		goto err;
+
+	return 0;
+
+err:
+	pr_warn_ratelimited("%s[%d]: magic-link re-open blocked ('%s%s%s' requested with an upgrade-mask of '%s%s%s%s')",
+		current->comm, task_pid_nr(current),
+		(acc_mode & MAY_READ) ? "r" : "",
+		(acc_mode & MAY_WRITE) ? "w" : "",
+		(acc_mode & MAY_EXEC) ? "x" : "",
+		(upgrade_mask & FMODE_READ) ? "r" : "",
+		(upgrade_mask & FMODE_PATH_READ) ? "R" : "",
+		(upgrade_mask & FMODE_WRITE) ? "w" : "",
+		(upgrade_mask & FMODE_PATH_WRITE) ? "W" : "");
+	return -EACCES;
+}
+
+static int trailing_magiclink(struct nameidata *nd, int acc_mode,
+			      fmode_t *opath_mask)
+{
+	fmode_t upgrade_mask = 0;
+
+	/* Was the trailing_symlink() a magic-link? */
+	if (!(nd->flags & LOOKUP_MAGICLINK_JUMPED))
+		return 0;
+
+	/*
+	 * Figure out the upgrade-mask of nd->last_magiclink_mode (which was
+	 * stashed away during the jump with nd_jump_link()).
+	 *
+	 * Since these aren't strictly POSIX semantics we don't do an
+	 * acl_permission_check() here, so we only care that at least one bit
+	 * is set for each upgrade-mode.
+	 */
+	if (nd->last_magiclink_mode & S_IRUGO)
+		upgrade_mask |= FMODE_PATH_READ;
+	if (nd->last_magiclink_mode & S_IWUGO)
+		upgrade_mask |= FMODE_PATH_WRITE;
+	/* Restrict the O_PATH upgrade-mask of the caller. */
+	if (opath_mask)
+		*opath_mask &= upgrade_mask;
+	return may_open_magiclink(upgrade_mask, acc_mode);
 }
 
 static struct file *path_openat(struct nameidata *nd,
@@ -3518,13 +3580,38 @@ static struct file *path_openat(struct nameidata *nd,
 	if (unlikely(file->f_flags & __O_TMPFILE)) {
 		error = do_tmpfile(nd, flags, op, file);
 	} else if (unlikely(file->f_flags & O_PATH)) {
-		error = do_o_path(nd, flags, file);
+		/* Inlined path_lookupat() with a trailing_magiclink() check. */
+		fmode_t opath_mask = op->opath_mask;
+		const char *s = path_init(nd, flags);
+
+		while (!(error = link_path_walk(s, nd))
+			&& ((error = lookup_last(nd)) > 0)) {
+			s = trailing_symlink(nd);
+			error = trailing_magiclink(nd, op->acc_mode, &opath_mask);
+			if (error)
+				s = ERR_PTR(error);
+		}
+		if (!error)
+			error = complete_walk(nd);
+
+		if (!error && nd->flags & LOOKUP_DIRECTORY)
+			if (!d_can_lookup(nd->path.dentry))
+				error = -ENOTDIR;
+		if (!error) {
+			audit_inode(nd->name, nd->path.dentry, 0);
+			error = vfs_open(&nd->path, file);
+			file->f_mode |= opath_mask;
+		}
+		terminate_walk(nd);
 	} else {
 		const char *s = path_init(nd, flags);
 		while (!(error = link_path_walk(s, nd)) &&
 			(error = do_last(nd, file, op)) > 0) {
 			nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
 			s = trailing_symlink(nd);
+			error = trailing_magiclink(nd, op->acc_mode, NULL);
+			if (error)
+				s = ERR_PTR(error);
 		}
 		terminate_walk(nd);
 	}
diff --git a/fs/open.c b/fs/open.c
index b62f5c0923a8..44704f9184cc 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1009,8 +1009,9 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		acc_mode |= MAY_APPEND;
 
 	op->acc_mode = acc_mode;
-
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
+	/* For O_PATH backwards-compatibility we default to an all-set mask. */
+	op->opath_mask = FMODE_PATH_READ | FMODE_PATH_WRITE;
 
 	if (flags & O_CREAT) {
 		op->intent |= LOOKUP_CREATE;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..96c9ec66846f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -180,9 +180,11 @@ static int get_task_root(struct task_struct *task, struct path *root)
 	return result;
 }
 
-static int proc_cwd_link(struct dentry *dentry, struct path *path)
+static int proc_cwd_link(struct dentry *dentry, struct path *path,
+			 umode_t *mode)
 {
-	struct task_struct *task = get_proc_task(d_inode(dentry));
+	struct inode *inode = d_inode(dentry);
+	struct task_struct *task = get_proc_task(inode);
 	int result = -ENOENT;
 
 	if (task) {
@@ -194,18 +196,24 @@ static int proc_cwd_link(struct dentry *dentry, struct path *path)
 		task_unlock(task);
 		put_task_struct(task);
 	}
+	if (mode)
+		*mode = inode->i_mode;
 	return result;
 }
 
-static int proc_root_link(struct dentry *dentry, struct path *path)
+static int proc_root_link(struct dentry *dentry, struct path *path,
+			  umode_t *mode)
 {
-	struct task_struct *task = get_proc_task(d_inode(dentry));
+	struct inode *inode = d_inode(dentry);
+	struct task_struct *task = get_proc_task(inode);
 	int result = -ENOENT;
 
 	if (task) {
 		result = get_task_root(task, path);
 		put_task_struct(task);
 	}
+	if (mode)
+		*mode = inode->i_mode;
 	return result;
 }
 
@@ -1589,23 +1597,29 @@ static const struct file_operations proc_pid_set_comm_operations = {
 	.release	= single_release,
 };
 
-static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
+static int proc_exe_link(struct dentry *dentry, struct path *exe_path,
+			 umode_t *mode)
 {
+	int error = -ENOENT;
+	struct inode *inode = d_inode(dentry);
 	struct task_struct *task;
 	struct file *exe_file;
 
-	task = get_proc_task(d_inode(dentry));
+	task = get_proc_task(inode);
 	if (!task)
-		return -ENOENT;
+		return error;
 	exe_file = get_task_exe_file(task);
 	put_task_struct(task);
+
 	if (exe_file) {
 		*exe_path = exe_file->f_path;
 		path_get(&exe_file->f_path);
 		fput(exe_file);
-		return 0;
-	} else
-		return -ENOENT;
+		error = 0;
+	}
+	if (mode)
+		*mode = inode->i_mode;
+	return error;
 }
 
 static const char *proc_pid_get_link(struct dentry *dentry,
@@ -1613,6 +1627,7 @@ static const char *proc_pid_get_link(struct dentry *dentry,
 				     struct delayed_call *done)
 {
 	struct path path;
+	umode_t mode;
 	int error = -EACCES;
 
 	if (!dentry)
@@ -1622,11 +1637,11 @@ static const char *proc_pid_get_link(struct dentry *dentry,
 	if (!proc_fd_access_allowed(inode))
 		goto out;
 
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
+	error = PROC_I(inode)->op.proc_get_link(dentry, &path, &mode);
 	if (error)
 		goto out;
 
-	nd_jump_link(&path);
+	nd_jump_link(&path, mode);
 	return NULL;
 out:
 	return ERR_PTR(error);
@@ -1666,7 +1681,7 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
 	if (!proc_fd_access_allowed(inode))
 		goto out;
 
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
+	error = PROC_I(inode)->op.proc_get_link(dentry, &path, NULL);
 	if (error)
 		goto out;
 
@@ -2008,16 +2023,18 @@ static const struct dentry_operations tid_map_files_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int map_files_get_link(struct dentry *dentry, struct path *path)
+static int map_files_get_link(struct dentry *dentry, struct path *path,
+			      umode_t *mode)
 {
 	unsigned long vm_start, vm_end;
 	struct vm_area_struct *vma;
 	struct task_struct *task;
 	struct mm_struct *mm;
+	struct inode *inode = d_inode(dentry);
 	int rc;
 
 	rc = -ENOENT;
-	task = get_proc_task(d_inode(dentry));
+	task = get_proc_task(inode);
 	if (!task)
 		goto out;
 
@@ -2037,6 +2054,8 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
 	rc = -ENOENT;
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (vma && vma->vm_file) {
+		if (mode)
+			*mode = inode->i_mode;
 		*path = vma->vm_file->f_path;
 		path_get(path);
 		rc = 0;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..6253f32b3146 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -98,19 +98,38 @@ static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
 	return !!file;
 }
 
+static umode_t fd_mode_to_umode(fmode_t f_mode)
+{
+	umode_t i_mode = S_IFLNK;
+	/*
+	 * Always set +x (depending on the fmode type), since there currently
+	 * aren't FMODE_PATH_EXEC restrictions and there is no O_NOEXEC yet.
+	 * This might change in the future, in which case we will restrict +x.
+	 */
+	if (f_mode & FMODE_PATH)
+		i_mode |= S_IXGRP;
+	else
+		i_mode |= S_IXUSR;
+	/* Ordinary file modes (non-O_PATH). */
+	if (f_mode & FMODE_READ)
+		i_mode |= S_IRUSR;
+	if (f_mode & FMODE_WRITE)
+		i_mode |= S_IWUSR;
+	/* O_PATH pseudo-modes used for upgrade-checking purposes. */
+	if (f_mode & FMODE_PATH_READ)
+		i_mode |= S_IRGRP;
+	if (f_mode & FMODE_PATH_WRITE)
+		i_mode |= S_IWGRP;
+	return i_mode;
+}
+
 static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
 				fmode_t f_mode)
 {
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 
-	if (S_ISLNK(inode->i_mode)) {
-		unsigned i_mode = S_IFLNK;
-		if (f_mode & FMODE_READ)
-			i_mode |= S_IRUSR | S_IXUSR;
-		if (f_mode & FMODE_WRITE)
-			i_mode |= S_IWUSR | S_IXUSR;
-		inode->i_mode = i_mode;
-	}
+	if (S_ISLNK(inode->i_mode))
+		inode->i_mode = fd_mode_to_umode(f_mode);
 	security_task_to_inode(task, inode);
 }
 
@@ -144,7 +163,8 @@ static const struct dentry_operations tid_fd_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int proc_fd_link(struct dentry *dentry, struct path *path)
+static int proc_fd_link(struct dentry *dentry, struct path *path,
+			umode_t *mode)
 {
 	struct files_struct *files = NULL;
 	struct task_struct *task;
@@ -163,6 +183,13 @@ static int proc_fd_link(struct dentry *dentry, struct path *path)
 		spin_lock(&files->file_lock);
 		fd_file = fcheck_files(files, fd);
 		if (fd_file) {
+			/*
+			 * Re-compute the mode here with file_lock held. The
+			 * inode's i_mode might be incorrect for the later
+			 * check in may_open_magiclink().
+			 */
+			if (mode)
+				*mode = fd_mode_to_umode(fd_file->f_mode);
 			*path = fd_file->f_path;
 			path_get(&fd_file->f_path);
 			ret = 0;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index cd0c8d5ce9a1..a090fff984ed 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -74,7 +74,7 @@ extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
 union proc_op {
-	int (*proc_get_link)(struct dentry *, struct path *);
+	int (*proc_get_link)(struct dentry *, struct path *, umode_t *);
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index dd2b35f78b09..0142992eceea 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -54,7 +54,7 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		error = ns_get_path(&ns_path, task, ns_ops);
 		if (!error)
-			nd_jump_link(&ns_path);
+			nd_jump_link(&ns_path, inode->i_mode);
 	}
 	put_task_struct(task);
 	return error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d35763..70b90162e224 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -175,6 +175,10 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File does not contribute to nr_files count */
 #define FMODE_NOACCOUNT		((__force fmode_t)0x20000000)
 
+/* File is an O_PATH descriptor which can be upgraded to (read, write). */
+#define FMODE_PATH_READ		((__force fmode_t)0x40000000)
+#define FMODE_PATH_WRITE	((__force fmode_t)0x80000000)
+
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
  * that indicates that they should check the contents of the iovec are
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 397a08ade6a2..d1b9048fe0f1 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -38,6 +38,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_JUMPED		0x1000
 #define LOOKUP_ROOT		0x2000
 #define LOOKUP_ROOT_GRABBED	0x0008
+#define LOOKUP_EMPTY		0x4000
+#define LOOKUP_DOWN		0x8000
+#define LOOKUP_MAGICLINK_JUMPED	0x10000
 
 extern int path_pts(struct path *path);
 
@@ -68,7 +71,7 @@ extern int follow_up(struct path *);
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
-extern void nd_jump_link(struct path *path);
+extern void nd_jump_link(struct path *path, umode_t mode);
 
 static inline void nd_terminate_link(void *name, size_t len, size_t maxlen)
 {
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 45d13b6462aa..a1efe5585ffd 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -2461,7 +2461,7 @@ static const char *policy_get_link(struct dentry *dentry,
 	ns = aa_get_current_ns();
 	path.mnt = mntget(aafs_mnt);
 	path.dentry = dget(ns_dir(ns));
-	nd_jump_link(&path);
+	nd_jump_link(&path, inode->i_mode);
 	aa_put_ns(ns);
 
 	return NULL;
-- 
2.23.0

