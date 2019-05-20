Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19FF23810
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 15:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfETNeE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 09:34:04 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:61390 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbfETNeD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 09:34:03 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 1CDAEA1039;
        Mon, 20 May 2019 15:33:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id oWht5QRrR2YG; Mon, 20 May 2019 15:33:55 +0200 (CEST)
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
        containers@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH RFC v8 01/10] namei: obey trailing magic-link DAC permissions
Date:   Mon, 20 May 2019 23:32:56 +1000
Message-Id: <20190520133305.11925-2-cyphar@cyphar.com>
In-Reply-To: <20190520133305.11925-1-cyphar@cyphar.com>
References: <20190520133305.11925-1-cyphar@cyphar.com>
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
just as restricted as the corresponding magic-link otherwise the above
protection can be bypassed. There are two distinct cases:

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

One final exception is given, which is that non-O_PATH file descriptors
are given re-open rights equivalent to the permissions available at
open-time. This allows for O_RDONLY file descriptors to be re-opened
O_RDWR as long as the user had MAY_WRITE access at the time of opening
the O_RDONLY descriptor. This is necessary to avoid breaking userspace
(some of the kernel's own selftests depended on this "feature").

Co-developed-by: Andy Lutomirski <luto@kernel.org>
Co-developed-by: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/internal.h         |   1 +
 fs/namei.c            | 117 ++++++++++++++++++++++++++++++++++++++++--
 fs/open.c             |   3 +-
 fs/proc/fd.c          |  16 ++++--
 include/linux/fs.h    |   4 ++
 include/linux/types.h |   2 +-
 6 files changed, 132 insertions(+), 11 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index bfd9bbbe369b..60d8a079a331 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -123,6 +123,7 @@ struct open_flags {
 	int acc_mode;
 	int intent;
 	int lookup_flags;
+	fmode_t opath_mask;
 };
 extern struct file *do_filp_open(int dfd, struct filename *pathname,
 		const struct open_flags *op);
diff --git a/fs/namei.c b/fs/namei.c
index 5ebd64b21970..5ff61624b8f0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -506,6 +506,8 @@ struct nameidata {
 	struct inode	*link_inode;
 	unsigned	root_seq;
 	int		dfd;
+	fmode_t 	opath_mask;
+	int		acc_mode; /* op.acc_mode */
 } __randomize_layout;
 
 static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
@@ -514,7 +516,14 @@ static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 	p->stack = p->internal;
 	p->dfd = dfd;
 	p->name = name;
-	p->total_link_count = old ? old->total_link_count : 0;
+	p->total_link_count = 0;
+	p->acc_mode = 0;
+	p->opath_mask = FMODE_PATH_READ | FMODE_PATH_WRITE;
+	if (old) {
+		p->total_link_count = old->total_link_count;
+		p->acc_mode = old->acc_mode;
+		p->opath_mask = old->opath_mask;
+	}
 	p->saved = old;
 	current->nameidata = p;
 }
@@ -1042,8 +1051,40 @@ static int may_create_in_sticky(struct dentry * const dir,
 	return 0;
 }
 
+/**
+ * may_reopen_magiclink - Check permissions for opening a trailing magic-link
+ * @opath_mask: the O_PATH mask of the magiclink
+ * @acc_mode: ACC_MODE which the user is attempting
+ *
+ * We block magic-link re-opening if the @opath_mask is more strict than the
+ * @acc_mode being requested, unless the user is capable(CAP_DAC_OVERRIDE).
+ *
+ * Returns 0 if successful, -ve on error.
+ */
+static int may_open_magiclink(fmode_t opath_mask, int acc_mode)
+{
+	/*
+	 * We only allow for init_userns to be able to override magic-links.
+	 * This is done to avoid cases where an unprivileger userns could take
+	 * an O_PATH of the fd, resulting in it being very unclear whether
+	 * CAP_DAC_OVERRIDE should work on the new O_PATH fd (given that it
+	 * pipes through to the underlying file).
+	 */
+	if (capable(CAP_DAC_OVERRIDE))
+		return 0;
+
+	if ((acc_mode & MAY_READ) &&
+	    !(opath_mask & (FMODE_READ | FMODE_PATH_READ)))
+		return -EACCES;
+	if ((acc_mode & MAY_WRITE) &&
+	    !(opath_mask & (FMODE_WRITE | FMODE_PATH_WRITE)))
+		return -EACCES;
+
+	return 0;
+}
+
 static __always_inline
-const char *get_link(struct nameidata *nd)
+const char *get_link(struct nameidata *nd, bool trailing)
 {
 	struct saved *last = nd->stack + nd->depth - 1;
 	struct dentry *dentry = last->link.dentry;
@@ -1081,6 +1122,50 @@ const char *get_link(struct nameidata *nd)
 		} else {
 			res = get(dentry, inode, &last->done);
 		}
+		/* If we just jumped it was because of a magic-link. */
+		if (unlikely(nd->flags & LOOKUP_JUMPED)) {
+			/*
+			 * For trailing_symlink we check whether the symlink's
+			 * mode allows us to do what we want through acc_mode.
+			 * In addition, we need to stash away what the link
+			 * mode is in case we are about to O_PATH this
+			 * magic-link.
+			 *
+			 * This is only done for magic-links, as a security
+			 * measure to prevent users from being able to re-open
+			 * files with additional permissions or similar tricks
+			 * through procfs. This is not strictly POSIX-friendly,
+			 * but technically neither are magic-links.
+			 */
+			if (trailing) {
+				fmode_t opath_mask = 0;
+				int mode = inode->i_mode;
+
+				/*
+				 * Bare-bones acl_permission_check shift so
+				 * that opath_mask can be adjusted using creds.
+				 */
+				if (uid_eq(current_fsuid(), inode->i_uid))
+					mode >>= 6;
+				else if (in_group_p(inode->i_gid))
+					mode >>= 3;
+
+				/* Figure out the O_PATH mask. */
+				if (mode & MAY_READ)
+					opath_mask |= FMODE_PATH_READ;
+				if (mode & MAY_WRITE)
+					opath_mask |= FMODE_PATH_WRITE;
+
+				/*
+				 * Is the new opath_mask more restrictive than
+				 * the acc_mode being requested?
+				 */
+				error = may_open_magiclink(opath_mask, nd->acc_mode);
+				if (error)
+					return ERR_PTR(error);
+				nd->opath_mask &= opath_mask;
+			}
+		}
 		if (IS_ERR_OR_NULL(res))
 			return res;
 	}
@@ -2142,7 +2227,7 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 			return err;
 
 		if (err) {
-			const char *s = get_link(nd);
+			const char *s = get_link(nd, false);
 
 			if (IS_ERR(s))
 				return PTR_ERR(s);
@@ -2258,7 +2343,7 @@ static const char *trailing_symlink(struct nameidata *nd)
 		return ERR_PTR(error);
 	nd->flags |= LOOKUP_PARENT;
 	nd->stack[0].name = NULL;
-	s = get_link(nd);
+	s = get_link(nd, true);
 	return s ? s : "";
 }
 
@@ -3508,6 +3593,7 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 	if (!error) {
 		audit_inode(nd->name, path.dentry, 0);
 		error = vfs_open(&path, file);
+		file->f_mode |= nd->opath_mask;
 		path_put(&path);
 	}
 	return error;
@@ -3519,6 +3605,9 @@ static struct file *path_openat(struct nameidata *nd,
 	struct file *file;
 	int error;
 
+	nd->acc_mode = op->acc_mode;
+	nd->opath_mask = op->opath_mask;
+
 	file = alloc_empty_file(op->open_flag, current_cred());
 	if (IS_ERR(file))
 		return file;
@@ -3537,6 +3626,26 @@ static struct file *path_openat(struct nameidata *nd,
 		terminate_walk(nd);
 	}
 	if (likely(!error)) {
+		/*
+		 * In order to allow for re-opening of a read-only fds as
+		 * read-write (something that some userspace tools depend on,
+		 * including some kernel selftests), we give additional
+		 * permissions based on what permissions are available at
+		 * open-time. This must be scoped to opath_mask to avoid
+		 * obvious O_PATH attacks.
+		 */
+		if (likely(!(file->f_mode & FMODE_PATH))) {
+			fmode_t add_perms = 0;
+
+			if (!(nd->acc_mode & MAY_READ) &&
+			    !inode_permission(file->f_inode, MAY_READ))
+				add_perms |= FMODE_PATH_READ;
+			if (!(nd->acc_mode & MAY_WRITE) &&
+			    !inode_permission(file->f_inode, MAY_WRITE))
+				add_perms |= FMODE_PATH_WRITE;
+
+			file->f_mode |= add_perms & nd->opath_mask;
+		}
 		if (likely(file->f_mode & FMODE_OPENED))
 			return file;
 		WARN_ON(1);
diff --git a/fs/open.c b/fs/open.c
index a00350018a47..c1d4f343e85f 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -981,8 +981,9 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		acc_mode |= MAY_APPEND;
 
 	op->acc_mode = acc_mode;
-
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
+	/* For O_PATH backwards-compatibility we default to an all-set mask. */
+	op->opath_mask = FMODE_PATH_READ | FMODE_PATH_WRITE;
 
 	if (flags & O_CREAT) {
 		op->intent |= LOOKUP_CREATE;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..8c0ccf2b703b 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -104,11 +104,17 @@ static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 
 	if (S_ISLNK(inode->i_mode)) {
-		unsigned i_mode = S_IFLNK;
-		if (f_mode & FMODE_READ)
-			i_mode |= S_IRUSR | S_IXUSR;
-		if (f_mode & FMODE_WRITE)
-			i_mode |= S_IWUSR | S_IXUSR;
+		unsigned i_mode = S_IFLNK | S_IXUGO;
+		/*
+		 * Construct the mode bits based on the open-mode. Note that
+		 * giving o+rwx permissions here is not a problem since all
+		 * /proc/self/fd magic-link resolution is gated with
+		 * ptrace_may_access().
+		 */
+		if (f_mode & (FMODE_READ | FMODE_PATH_READ))
+			i_mode |= S_IRUGO;
+		if (f_mode & (FMODE_WRITE | FMODE_PATH_WRITE))
+			i_mode |= S_IWUGO;
 		inode->i_mode = i_mode;
 	}
 	security_task_to_inode(task, inode);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fe94c48481a6..0b2af61411cb 100644
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
diff --git a/include/linux/types.h b/include/linux/types.h
index cc0dbbe551d5..45aaf711885c 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -157,7 +157,7 @@ typedef u32 dma_addr_t;
 
 typedef unsigned int __bitwise gfp_t;
 typedef unsigned int __bitwise slab_flags_t;
-typedef unsigned int __bitwise fmode_t;
+typedef unsigned long __bitwise fmode_t;
 
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 typedef u64 phys_addr_t;
-- 
2.21.0

