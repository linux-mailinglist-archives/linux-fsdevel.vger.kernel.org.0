Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB14D6E8FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 18:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfGSQnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 12:43:32 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:30784 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729549AbfGSQnc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:43:32 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 956EBA017C;
        Fri, 19 Jul 2019 18:43:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id MYpsYH2uBtOt; Fri, 19 Jul 2019 18:43:22 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
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
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v10 1/9] namei: obey trailing magic-link DAC permissions
Date:   Sat, 20 Jul 2019 02:42:17 +1000
Message-Id: <20190719164225.27083-2-cyphar@cyphar.com>
In-Reply-To: <20190719164225.27083-1-cyphar@cyphar.com>
References: <20190719164225.27083-1-cyphar@cyphar.com>
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

[1]: http://git.altlinux.org/people/legion/packages/kbd.git

Co-developed-by: Andy Lutomirski <luto@kernel.org>
Co-developed-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 Documentation/filesystems/path-lookup.rst |  12 +--
 fs/internal.h                             |   1 +
 fs/namei.c                                | 105 +++++++++++++++++++---
 fs/open.c                                 |   3 +-
 fs/proc/fd.c                              |  23 ++++-
 include/linux/fs.h                        |   4 +
 include/linux/namei.h                     |   1 +
 7 files changed, 130 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 434a07b0002b..a57d78ec8bee 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -1310,12 +1310,14 @@ longer needed.
 ``LOOKUP_JUMPED`` means that the current dentry was chosen not because
 it had the right name but for some other reason.  This happens when
 following "``..``", following a symlink to ``/``, crossing a mount point
-or accessing a "``/proc/$PID/fd/$FD``" symlink.  In this case the
-filesystem has not been asked to revalidate the name (with
-``d_revalidate()``).  In such cases the inode may still need to be
-revalidated, so ``d_op->d_weak_revalidate()`` is called if
+or accessing a "``/proc/$PID/fd/$FD``" symlink (also known as a "magic
+link"). In this case the filesystem has not been asked to revalidate the
+name (with ``d_revalidate()``).  In such cases the inode may still need
+to be revalidated, so ``d_op->d_weak_revalidate()`` is called if
 ``LOOKUP_JUMPED`` is set when the look completes - which may be at the
-final component or, when creating, unlinking, or renaming, at the penultimate component.
+final component or, when creating, unlinking, or renaming, at the
+penultimate component. ``LOOKUP_MAGICLINK_JUMPED`` is set alongside
+``LOOKUP_JUMPED`` if a magic-link was traversed.
 
 Final-component flags
 ~~~~~~~~~~~~~~~~~~~~~
diff --git a/fs/internal.h b/fs/internal.h
index a48ef81be37d..12847f502f49 100644
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
index 20831c2fbb34..c6ba4ccafc51 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -872,7 +872,7 @@ void nd_jump_link(struct path *path)
 
 	nd->path = *path;
 	nd->inode = nd->path.dentry->d_inode;
-	nd->flags |= LOOKUP_JUMPED;
+	nd->flags |= LOOKUP_JUMPED | LOOKUP_MAGICLINK_JUMPED;
 }
 
 static inline void put_link(struct nameidata *nd)
@@ -1066,6 +1066,7 @@ const char *get_link(struct nameidata *nd)
 		return ERR_PTR(error);
 
 	nd->last_type = LAST_BIND;
+	nd->flags &= ~LOOKUP_MAGICLINK_JUMPED;
 	res = READ_ONCE(inode->i_link);
 	if (!res) {
 		const char * (*get)(struct dentry *, struct inode *,
@@ -3501,16 +3502,73 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	return error;
 }
 
-static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
+/**
+ * may_reopen_magiclink - Check permissions for opening a trailing magic-link
+ * @opath_mask: the O_PATH mask of the magic-link
+ * @acc_mode: ACC_MODE which the user is attempting
+ *
+ * We block magic-link re-opening if the @opath_mask is more strict than the
+ * @acc_mode being requested, unless the user is capable(CAP_DAC_OVERRIDE).
+ *
+ * Returns 0 if successful, -ve on error.
+ */
+static int may_open_magiclink(fmode_t opath_mask, int acc_mode)
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
+	    !(opath_mask & (FMODE_READ | FMODE_PATH_READ)))
+		goto err;
+	if ((acc_mode & MAY_WRITE) &&
+	    !(opath_mask & (FMODE_WRITE | FMODE_PATH_WRITE)))
+		goto err;
+
+	return 0;
+
+err:
+	pr_warn_ratelimited("%s[%d]: magic-link re-open blocked (acc_mode=%s%s%s, opath_mask=%s%s%s%s)",
+		current->comm, task_pid_nr(current),
+		(acc_mode & MAY_READ) ? "r": "",
+		(acc_mode & MAY_WRITE) ? "w": "",
+		(acc_mode & MAY_EXEC) ? "x": "",
+		(opath_mask & FMODE_READ) ? "R" : "",
+		(opath_mask & FMODE_PATH_READ) ? "r" : "",
+		(opath_mask & FMODE_WRITE) ? "W" : "",
+		(opath_mask & FMODE_PATH_WRITE) ? "w" : "");
+	return -EACCES;
+}
+
+static int trailing_magiclink(struct nameidata *nd, int acc_mode,
+			      fmode_t *opath_mask)
+{
+	struct inode *inode = nd->link_inode;
+	fmode_t new_mask = 0;
+
+	/* Trailing symlink was not a magic-link. */
+	if (!(nd->flags & LOOKUP_MAGICLINK_JUMPED))
+		return 0;
+
+	/*
+	 * Figure out the O_PATH mask. Rather than using acl_permission_check,
+	 * we check whether any of the rw bits are set in the mode.
+	 */
+	if (inode->i_mode & S_IRUGO)
+		new_mask |= FMODE_PATH_READ;
+	if (inode->i_mode & S_IWUGO)
+		new_mask |= FMODE_PATH_WRITE;
+	if (opath_mask)
+		*opath_mask &= new_mask;
+
+	/* Is the new opath_mask more restrictive than acc_mode? */
+	return may_open_magiclink(new_mask, acc_mode);
 }
 
 static struct file *path_openat(struct nameidata *nd,
@@ -3526,13 +3584,38 @@ static struct file *path_openat(struct nameidata *nd,
 	if (unlikely(file->f_flags & __O_TMPFILE)) {
 		error = do_tmpfile(nd, flags, op, file);
 	} else if (unlikely(file->f_flags & O_PATH)) {
-		error = do_o_path(nd, flags, file);
+		/* Inlined path_lookupat() with a trailing_magiclink() check. */
+		const char *s = path_init(nd, flags);
+		fmode_t opath_mask = op->opath_mask;
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
index b5b80469b93d..ab20eae39df7 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -982,8 +982,9 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		acc_mode |= MAY_APPEND;
 
 	op->acc_mode = acc_mode;
-
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
+	/* For O_PATH backwards-compatibility we default to an all-set mask. */
+	op->opath_mask = FMODE_PATH_READ | FMODE_PATH_WRITE;
 
 	if (flags & O_CREAT) {
 		op->intent |= LOOKUP_CREATE;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..9b7d8becb002 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -104,11 +104,30 @@ static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 
 	if (S_ISLNK(inode->i_mode)) {
+		/*
+		 * Always set +x (depending on the fmode type), since there
+		 * currently aren't FMODE_PATH_EXEC restrictions and there is
+		 * no O_MAYEXEC yet. This might change in the future, in which
+		 * case we will restrict +x.
+		 */
 		unsigned i_mode = S_IFLNK;
+		if (f_mode & FMODE_PATH)
+			i_mode |= S_IXGRP;
+		else
+			i_mode |= S_IXUSR;
+		/*
+		 * Construct the mode bits based on the open-mode. The u+rwx
+		 * bits are for "ordinary" open modes while g+rwx are for
+		 * O_PATH modes.
+		 */
 		if (f_mode & FMODE_READ)
-			i_mode |= S_IRUSR | S_IXUSR;
+			i_mode |= S_IRUSR;
 		if (f_mode & FMODE_WRITE)
-			i_mode |= S_IWUSR | S_IXUSR;
+			i_mode |= S_IWUSR;
+		if (f_mode & FMODE_PATH_READ)
+			i_mode |= S_IRGRP;
+		if (f_mode & FMODE_PATH_WRITE)
+			i_mode |= S_IWGRP;
 		inode->i_mode = i_mode;
 	}
 	security_task_to_inode(task, inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..f7df213405ea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -173,6 +173,10 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
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
index 9138b4471dbf..bd6d3eb7764d 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -49,6 +49,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_ROOT		0x2000
 #define LOOKUP_EMPTY		0x4000
 #define LOOKUP_DOWN		0x8000
+#define LOOKUP_MAGICLINK_JUMPED	0x10000
 
 extern int path_pts(struct path *path);
 
-- 
2.22.0

