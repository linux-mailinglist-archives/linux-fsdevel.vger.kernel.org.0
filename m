Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1393F2D89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 15:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbhHTN5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 09:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240766AbhHTN5v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 09:57:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60E796113E;
        Fri, 20 Aug 2021 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629467834;
        bh=2dVN9bRgCQzHt9RoFAWVLa7uXXnGB/aLhYKXe9gzkr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XCHG5fydvcqICkfu3+tbpYN3rOZmcgQvBnj2ixtRC6y+1VJS2zOdm2AyeMq4zoJZH
         WH2KPTqNByiIevZPZPXNdOrysOWyENEcp+GkTfG+NEPwa99FfU4A3kOqsmKQjOv5lv
         VdRxhfGmJo50Fb9A5QeEq7tHPE2n3h16IiY7AJi3hF+M/BcXs2KoqOSkCKtrPezzkR
         tM1LvG0WwiPuiJ5SVP6u0AKaaI8RkfTbY91aRiR/jrRTsush2w04qsxsHOGGEWx2Hq
         8YlwKIWfHq/fmwnf4ZiVRehRcSvRzSutTMmXRc+6cyM19Tj7F1coIOrdoqYHEqLAlL
         01ux1F/k1z+ow==
From:   Jeff Layton <jlayton@kernel.org>
To:     torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, david@redhat.com, willy@infradead.org,
        linux-nfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-doc@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org,
        akpm@linux-foundation.org, luto@kernel.org, bfields@fieldses.org,
        w@1wt.eu, rostedt@goodmis.org
Subject: [PATCH v2 2/2] fs: remove mandatory file locking support
Date:   Fri, 20 Aug 2021 09:57:07 -0400
Message-Id: <20210820135707.171001-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820135707.171001-1-jlayton@kernel.org>
References: <20210820135707.171001-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We added CONFIG_MANDATORY_FILE_LOCKING in 2015, and soon after turned it
off in Fedora and RHEL8. Several other distros have followed suit.

I've heard of one problem in all that time: Someone migrated from an
older distro that supported "-o mand" to one that didn't, and the host
had a fstab entry with "mand" in it which broke on reboot. They didn't
actually _use_ mandatory locking so they just removed the mount option
and moved on.

This patch rips out mandatory locking support wholesale from the kernel,
along with the Kconfig option and the Documentation file. It also
changes the mount code to ignore the "mand" mount option instead of
erroring out, and to throw a big, ugly warning.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 .../filesystems/mandatory-locking.rst         | 188 ------------------
 fs/9p/vfs_file.c                              |  12 --
 fs/Kconfig                                    |  10 -
 fs/afs/flock.c                                |   4 -
 fs/ceph/locks.c                               |   3 -
 fs/gfs2/file.c                                |   3 -
 fs/locks.c                                    | 116 +----------
 fs/namei.c                                    |   4 +-
 fs/namespace.c                                |  37 ++--
 fs/nfs/file.c                                 |   4 -
 fs/nfsd/nfs4state.c                           |  13 --
 fs/nfsd/vfs.c                                 |  15 --
 fs/ocfs2/locks.c                              |   4 -
 fs/open.c                                     |   8 +-
 fs/read_write.c                               |   7 -
 fs/remap_range.c                              |  10 -
 include/linux/fs.h                            |  84 --------
 mm/mmap.c                                     |   6 -
 mm/nommu.c                                    |   3 -
 19 files changed, 19 insertions(+), 512 deletions(-)
 delete mode 100644 Documentation/filesystems/mandatory-locking.rst

diff --git a/Documentation/filesystems/mandatory-locking.rst b/Documentation/filesystems/mandatory-locking.rst
deleted file mode 100644
index 9ce73544a8f0..000000000000
--- a/Documentation/filesystems/mandatory-locking.rst
+++ /dev/null
@@ -1,188 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-=====================================================
-Mandatory File Locking For The Linux Operating System
-=====================================================
-
-		Andy Walker <andy@lysaker.kvaerner.no>
-
-			   15 April 1996
-
-		     (Updated September 2007)
-
-0. Why you should avoid mandatory locking
------------------------------------------
-
-The Linux implementation is prey to a number of difficult-to-fix race
-conditions which in practice make it not dependable:
-
-	- The write system call checks for a mandatory lock only once
-	  at its start.  It is therefore possible for a lock request to
-	  be granted after this check but before the data is modified.
-	  A process may then see file data change even while a mandatory
-	  lock was held.
-	- Similarly, an exclusive lock may be granted on a file after
-	  the kernel has decided to proceed with a read, but before the
-	  read has actually completed, and the reading process may see
-	  the file data in a state which should not have been visible
-	  to it.
-	- Similar races make the claimed mutual exclusion between lock
-	  and mmap similarly unreliable.
-
-1. What is  mandatory locking?
-------------------------------
-
-Mandatory locking is kernel enforced file locking, as opposed to the more usual
-cooperative file locking used to guarantee sequential access to files among
-processes. File locks are applied using the flock() and fcntl() system calls
-(and the lockf() library routine which is a wrapper around fcntl().) It is
-normally a process' responsibility to check for locks on a file it wishes to
-update, before applying its own lock, updating the file and unlocking it again.
-The most commonly used example of this (and in the case of sendmail, the most
-troublesome) is access to a user's mailbox. The mail user agent and the mail
-transfer agent must guard against updating the mailbox at the same time, and
-prevent reading the mailbox while it is being updated.
-
-In a perfect world all processes would use and honour a cooperative, or
-"advisory" locking scheme. However, the world isn't perfect, and there's
-a lot of poorly written code out there.
-
-In trying to address this problem, the designers of System V UNIX came up
-with a "mandatory" locking scheme, whereby the operating system kernel would
-block attempts by a process to write to a file that another process holds a
-"read" -or- "shared" lock on, and block attempts to both read and write to a 
-file that a process holds a "write " -or- "exclusive" lock on.
-
-The System V mandatory locking scheme was intended to have as little impact as
-possible on existing user code. The scheme is based on marking individual files
-as candidates for mandatory locking, and using the existing fcntl()/lockf()
-interface for applying locks just as if they were normal, advisory locks.
-
-.. Note::
-
-   1. In saying "file" in the paragraphs above I am actually not telling
-      the whole truth. System V locking is based on fcntl(). The granularity of
-      fcntl() is such that it allows the locking of byte ranges in files, in
-      addition to entire files, so the mandatory locking rules also have byte
-      level granularity.
-
-   2. POSIX.1 does not specify any scheme for mandatory locking, despite
-      borrowing the fcntl() locking scheme from System V. The mandatory locking
-      scheme is defined by the System V Interface Definition (SVID) Version 3.
-
-2. Marking a file for mandatory locking
----------------------------------------
-
-A file is marked as a candidate for mandatory locking by setting the group-id
-bit in its file mode but removing the group-execute bit. This is an otherwise
-meaningless combination, and was chosen by the System V implementors so as not
-to break existing user programs.
-
-Note that the group-id bit is usually automatically cleared by the kernel when
-a setgid file is written to. This is a security measure. The kernel has been
-modified to recognize the special case of a mandatory lock candidate and to
-refrain from clearing this bit. Similarly the kernel has been modified not
-to run mandatory lock candidates with setgid privileges.
-
-3. Available implementations
-----------------------------
-
-I have considered the implementations of mandatory locking available with
-SunOS 4.1.x, Solaris 2.x and HP-UX 9.x.
-
-Generally I have tried to make the most sense out of the behaviour exhibited
-by these three reference systems. There are many anomalies.
-
-All the reference systems reject all calls to open() for a file on which
-another process has outstanding mandatory locks. This is in direct
-contravention of SVID 3, which states that only calls to open() with the
-O_TRUNC flag set should be rejected. The Linux implementation follows the SVID
-definition, which is the "Right Thing", since only calls with O_TRUNC can
-modify the contents of the file.
-
-HP-UX even disallows open() with O_TRUNC for a file with advisory locks, not
-just mandatory locks. That would appear to contravene POSIX.1.
-
-mmap() is another interesting case. All the operating systems mentioned
-prevent mandatory locks from being applied to an mmap()'ed file, but  HP-UX
-also disallows advisory locks for such a file. SVID actually specifies the
-paranoid HP-UX behaviour.
-
-In my opinion only MAP_SHARED mappings should be immune from locking, and then
-only from mandatory locks - that is what is currently implemented.
-
-SunOS is so hopeless that it doesn't even honour the O_NONBLOCK flag for
-mandatory locks, so reads and writes to locked files always block when they
-should return EAGAIN.
-
-I'm afraid that this is such an esoteric area that the semantics described
-below are just as valid as any others, so long as the main points seem to
-agree. 
-
-4. Semantics
-------------
-
-1. Mandatory locks can only be applied via the fcntl()/lockf() locking
-   interface - in other words the System V/POSIX interface. BSD style
-   locks using flock() never result in a mandatory lock.
-
-2. If a process has locked a region of a file with a mandatory read lock, then
-   other processes are permitted to read from that region. If any of these
-   processes attempts to write to the region it will block until the lock is
-   released, unless the process has opened the file with the O_NONBLOCK
-   flag in which case the system call will return immediately with the error
-   status EAGAIN.
-
-3. If a process has locked a region of a file with a mandatory write lock, all
-   attempts to read or write to that region block until the lock is released,
-   unless a process has opened the file with the O_NONBLOCK flag in which case
-   the system call will return immediately with the error status EAGAIN.
-
-4. Calls to open() with O_TRUNC, or to creat(), on a existing file that has
-   any mandatory locks owned by other processes will be rejected with the
-   error status EAGAIN.
-
-5. Attempts to apply a mandatory lock to a file that is memory mapped and
-   shared (via mmap() with MAP_SHARED) will be rejected with the error status
-   EAGAIN.
-
-6. Attempts to create a shared memory map of a file (via mmap() with MAP_SHARED)
-   that has any mandatory locks in effect will be rejected with the error status
-   EAGAIN.
-
-5. Which system calls are affected?
------------------------------------
-
-Those which modify a file's contents, not just the inode. That gives read(),
-write(), readv(), writev(), open(), creat(), mmap(), truncate() and
-ftruncate(). truncate() and ftruncate() are considered to be "write" actions
-for the purposes of mandatory locking.
-
-The affected region is usually defined as stretching from the current position
-for the total number of bytes read or written. For the truncate calls it is
-defined as the bytes of a file removed or added (we must also consider bytes
-added, as a lock can specify just "the whole file", rather than a specific
-range of bytes.)
-
-Note 3: I may have overlooked some system calls that need mandatory lock
-checking in my eagerness to get this code out the door. Please let me know, or
-better still fix the system calls yourself and submit a patch to me or Linus.
-
-6. Warning!
------------
-
-Not even root can override a mandatory lock, so runaway processes can wreak
-havoc if they lock crucial files. The way around it is to change the file
-permissions (remove the setgid bit) before trying to read or write to it.
-Of course, that might be a bit tricky if the system is hung :-(
-
-7. The "mand" mount option
---------------------------
-Mandatory locking is disabled on all filesystems by default, and must be
-administratively enabled by mounting with "-o mand". That mount option
-is only allowed if the mounting task has the CAP_SYS_ADMIN capability.
-
-Since kernel v4.5, it is possible to disable mandatory locking
-altogether by setting CONFIG_MANDATORY_FILE_LOCKING to "n". A kernel
-with this disabled will reject attempts to mount filesystems with the
-"mand" mount option with the error status EPERM.
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 59c32c9b799f..153a99e8c620 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -121,10 +121,6 @@ static int v9fs_file_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	p9_debug(P9_DEBUG_VFS, "filp: %p lock: %p\n", filp, fl);
 
-	/* No mandatory locks */
-	if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
-		return -ENOLCK;
-
 	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
@@ -312,10 +308,6 @@ static int v9fs_file_lock_dotl(struct file *filp, int cmd, struct file_lock *fl)
 	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
 		 filp, cmd, fl, filp);
 
-	/* No mandatory locks */
-	if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
-		goto out_err;
-
 	if ((IS_SETLK(cmd) || IS_SETLKW(cmd)) && fl->fl_type != F_UNLCK) {
 		filemap_write_and_wait(inode->i_mapping);
 		invalidate_mapping_pages(&inode->i_data, 0, -1);
@@ -348,10 +340,6 @@ static int v9fs_file_flock_dotl(struct file *filp, int cmd,
 	p9_debug(P9_DEBUG_VFS, "filp: %p cmd:%d lock: %p name: %pD\n",
 		 filp, cmd, fl, filp);
 
-	/* No mandatory locks */
-	if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
-		goto out_err;
-
 	if (!(fl->fl_flags & FL_FLOCK))
 		goto out_err;
 
diff --git a/fs/Kconfig b/fs/Kconfig
index 141a856c50e7..4e8747885459 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -101,16 +101,6 @@ config FILE_LOCKING
           for filesystems like NFS and for the flock() system
           call. Disabling this option saves about 11k.
 
-config MANDATORY_FILE_LOCKING
-	bool "Enable Mandatory file locking"
-	depends on FILE_LOCKING
-	default y
-	help
-	  This option enables files appropriately marked files on appropriely
-	  mounted filesystems to support mandatory locking.
-
-	  To the best of my knowledge this is dead code that no one cares about.
-
 source "fs/crypto/Kconfig"
 
 source "fs/verity/Kconfig"
diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index cb3054c7843e..c4210a3964d8 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -772,10 +772,6 @@ int afs_lock(struct file *file, int cmd, struct file_lock *fl)
 	       fl->fl_type, fl->fl_flags,
 	       (long long) fl->fl_start, (long long) fl->fl_end);
 
-	/* AFS doesn't support mandatory locks */
-	if (__mandatory_lock(&vnode->vfs_inode) && fl->fl_type != F_UNLCK)
-		return -ENOLCK;
-
 	if (IS_GETLK(cmd))
 		return afs_do_getlk(file, fl);
 
diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index fa8a847743d0..bdeb271f47d9 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -240,9 +240,6 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
-	/* No mandatory locks */
-	if (__mandatory_lock(file->f_mapping->host) && fl->fl_type != F_UNLCK)
-		return -ENOLCK;
 
 	dout("ceph_lock, fl_owner: %p\n", fl->fl_owner);
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 84ec053d43b4..c559827cb6f9 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1237,9 +1237,6 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
-	if (__mandatory_lock(&ip->i_inode) && fl->fl_type != F_UNLCK)
-		return -ENOLCK;
-
 	if (cmd == F_CANCELLK) {
 		/* Hack: */
 		cmd = F_SETLK;
diff --git a/fs/locks.c b/fs/locks.c
index 74b2a1dfe8d8..da6a6d4ee480 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1397,103 +1397,6 @@ static int posix_lock_inode_wait(struct inode *inode, struct file_lock *fl)
 	return error;
 }
 
-#ifdef CONFIG_MANDATORY_FILE_LOCKING
-/**
- * locks_mandatory_locked - Check for an active lock
- * @file: the file to check
- *
- * Searches the inode's list of locks to find any POSIX locks which conflict.
- * This function is called from locks_verify_locked() only.
- */
-int locks_mandatory_locked(struct file *file)
-{
-	int ret;
-	struct inode *inode = locks_inode(file);
-	struct file_lock_context *ctx;
-	struct file_lock *fl;
-
-	ctx = smp_load_acquire(&inode->i_flctx);
-	if (!ctx || list_empty_careful(&ctx->flc_posix))
-		return 0;
-
-	/*
-	 * Search the lock list for this inode for any POSIX locks.
-	 */
-	spin_lock(&ctx->flc_lock);
-	ret = 0;
-	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
-		if (fl->fl_owner != current->files &&
-		    fl->fl_owner != file) {
-			ret = -EAGAIN;
-			break;
-		}
-	}
-	spin_unlock(&ctx->flc_lock);
-	return ret;
-}
-
-/**
- * locks_mandatory_area - Check for a conflicting lock
- * @inode:	the file to check
- * @filp:       how the file was opened (if it was)
- * @start:	first byte in the file to check
- * @end:	lastbyte in the file to check
- * @type:	%F_WRLCK for a write lock, else %F_RDLCK
- *
- * Searches the inode's list of locks to find any POSIX locks which conflict.
- */
-int locks_mandatory_area(struct inode *inode, struct file *filp, loff_t start,
-			 loff_t end, unsigned char type)
-{
-	struct file_lock fl;
-	int error;
-	bool sleep = false;
-
-	locks_init_lock(&fl);
-	fl.fl_pid = current->tgid;
-	fl.fl_file = filp;
-	fl.fl_flags = FL_POSIX | FL_ACCESS;
-	if (filp && !(filp->f_flags & O_NONBLOCK))
-		sleep = true;
-	fl.fl_type = type;
-	fl.fl_start = start;
-	fl.fl_end = end;
-
-	for (;;) {
-		if (filp) {
-			fl.fl_owner = filp;
-			fl.fl_flags &= ~FL_SLEEP;
-			error = posix_lock_inode(inode, &fl, NULL);
-			if (!error)
-				break;
-		}
-
-		if (sleep)
-			fl.fl_flags |= FL_SLEEP;
-		fl.fl_owner = current->files;
-		error = posix_lock_inode(inode, &fl, NULL);
-		if (error != FILE_LOCK_DEFERRED)
-			break;
-		error = wait_event_interruptible(fl.fl_wait,
-					list_empty(&fl.fl_blocked_member));
-		if (!error) {
-			/*
-			 * If we've been sleeping someone might have
-			 * changed the permissions behind our back.
-			 */
-			if (__mandatory_lock(inode))
-				continue;
-		}
-
-		break;
-	}
-	locks_delete_block(&fl);
-
-	return error;
-}
-EXPORT_SYMBOL(locks_mandatory_area);
-#endif /* CONFIG_MANDATORY_FILE_LOCKING */
-
 static void lease_clear_pending(struct file_lock *fl, int arg)
 {
 	switch (arg) {
@@ -2486,14 +2389,6 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 	if (file_lock == NULL)
 		return -ENOLCK;
 
-	/* Don't allow mandatory locks on files that may be memory mapped
-	 * and shared.
-	 */
-	if (mandatory_lock(inode) && mapping_writably_mapped(filp->f_mapping)) {
-		error = -EAGAIN;
-		goto out;
-	}
-
 	error = flock_to_posix_lock(filp, file_lock, flock);
 	if (error)
 		goto out;
@@ -2618,14 +2513,6 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 	if (file_lock == NULL)
 		return -ENOLCK;
 
-	/* Don't allow mandatory locks on files that may be memory mapped
-	 * and shared.
-	 */
-	if (mandatory_lock(inode) && mapping_writably_mapped(filp->f_mapping)) {
-		error = -EAGAIN;
-		goto out;
-	}
-
 	error = flock64_to_posix_lock(filp, file_lock, flock);
 	if (error)
 		goto out;
@@ -2857,8 +2744,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
 			seq_puts(f, "POSIX ");
 
 		seq_printf(f, " %s ",
-			     (inode == NULL) ? "*NOINODE*" :
-			     mandatory_lock(inode) ? "MANDATORY" : "ADVISORY ");
+			     (inode == NULL) ? "*NOINODE*" : "ADVISORY ");
 	} else if (IS_FLOCK(fl)) {
 		if (fl->fl_type & LOCK_MAND) {
 			seq_puts(f, "FLOCK  MSNFS     ");
diff --git a/fs/namei.c b/fs/namei.c
index 79b0ff9b151e..3502719e5a2d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3010,9 +3010,7 @@ static int handle_truncate(struct user_namespace *mnt_userns, struct file *filp)
 	/*
 	 * Refuse to truncate files with mandatory locks held on them.
 	 */
-	error = locks_verify_locked(filp);
-	if (!error)
-		error = security_path_truncate(path);
+	error = security_path_truncate(path);
 	if (!error) {
 		error = do_truncate(mnt_userns, path->dentry, 0,
 				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
diff --git a/fs/namespace.c b/fs/namespace.c
index ffab0bb1e649..dbe0e5d41d90 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1715,26 +1715,20 @@ static inline bool may_mount(void)
 	return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
 
-#ifdef	CONFIG_MANDATORY_FILE_LOCKING
 static bool warned_mand;
-static inline bool may_mandlock(void)
-{
-	if (!warned_mand) {
-		warned_mand = true;
-		pr_warn("======================================================\n");
-		pr_warn("WARNING: the mand mount option is being deprecated and\n");
-		pr_warn("         will be removed in v5.15!\n");
-		pr_warn("======================================================\n");
-	}
-	return capable(CAP_SYS_ADMIN);
-}
-#else
-static inline bool may_mandlock(void)
+static void warn_mand_option(void)
 {
-	pr_warn("VFS: \"mand\" mount option not supported");
-	return false;
+	if (warned_mand)
+		return;
+
+	warned_mand = true;
+
+	pr_warn("=======================================================\n");
+	pr_warn("WARNING: The mand mount option has been deprecated and\n");
+	pr_warn("         and is ignored by this kernel. Remove the mand\n");
+	pr_warn("         option from the mount to silence this warning.\n");
+	pr_warn("=======================================================\n");
 }
-#endif
 
 static int can_umount(const struct path *path, int flags)
 {
@@ -3187,8 +3181,8 @@ int path_mount(const char *dev_name, struct path *path,
 		return ret;
 	if (!may_mount())
 		return -EPERM;
-	if ((flags & SB_MANDLOCK) && !may_mandlock())
-		return -EPERM;
+	if (flags & SB_MANDLOCK)
+		warn_mand_option();
 
 	/* Default to relatime unless overriden */
 	if (!(flags & MS_NOATIME))
@@ -3571,9 +3565,8 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 	if (fc->phase != FS_CONTEXT_AWAITING_MOUNT)
 		goto err_unlock;
 
-	ret = -EPERM;
-	if ((fc->sb_flags & SB_MANDLOCK) && !may_mandlock())
-		goto err_unlock;
+	if (fc->sb_flags & SB_MANDLOCK)
+		warn_mand_option();
 
 	newmount.mnt = vfs_create_mount(fc);
 	if (IS_ERR(newmount.mnt)) {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1fef107961bc..514be5d28d70 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -806,10 +806,6 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	nfs_inc_stats(inode, NFSIOS_VFSLOCK);
 
-	/* No mandatory locks over NFS */
-	if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
-		goto out_err;
-
 	if (NFS_SERVER(inode)->flags & NFS_MOUNT_LOCAL_FCNTL)
 		is_local = 1;
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b517a8794400..3aa9ffb539d7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5628,16 +5628,6 @@ check_special_stateids(struct net *net, svc_fh *current_fh, stateid_t *stateid,
 				NFS4_SHARE_DENY_READ);
 }
 
-/*
- * Allow READ/WRITE during grace period on recovered state only for files
- * that are not able to provide mandatory locking.
- */
-static inline int
-grace_disallows_io(struct net *net, struct inode *inode)
-{
-	return opens_in_grace(net) && mandatory_lock(inode);
-}
-
 static __be32 check_stateid_generation(stateid_t *in, stateid_t *ref, bool has_session)
 {
 	/*
@@ -5928,9 +5918,6 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	if (nfp)
 		*nfp = NULL;
 
-	if (grace_disallows_io(net, ino))
-		return nfserr_grace;
-
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
 		status = check_special_stateids(net, fhp, stateid, flags);
 		goto done;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 15adf1f6ab21..f16ed7049192 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -348,14 +348,6 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (host_err)
 		goto out_nfserrno;
 
-	host_err = locks_verify_truncate(inode, NULL, iap->ia_size);
-	if (host_err)
-		goto out_put_write_access;
-	return 0;
-
-out_put_write_access:
-	put_write_access(inode);
-out_nfserrno:
 	return nfserrno(host_err);
 }
 
@@ -750,13 +742,6 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 	err = nfserr_perm;
 	if (IS_APPEND(inode) && (may_flags & NFSD_MAY_WRITE))
 		goto out;
-	/*
-	 * We must ignore files (but only files) which might have mandatory
-	 * locks on them because there is no way to know if the accesser has
-	 * the lock.
-	 */
-	if (S_ISREG((inode)->i_mode) && mandatory_lock(inode))
-		goto out;
 
 	if (!inode->i_fop)
 		goto out;
diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index fab7c6a4a7d0..73a3854b2afb 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -101,8 +101,6 @@ int ocfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (!(fl->fl_flags & FL_FLOCK))
 		return -ENOLCK;
-	if (__mandatory_lock(inode))
-		return -ENOLCK;
 
 	if ((osb->s_mount_opt & OCFS2_MOUNT_LOCALFLOCKS) ||
 	    ocfs2_mount_local(osb))
@@ -121,8 +119,6 @@ int ocfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
-	if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
-		return -ENOLCK;
 
 	return ocfs2_plock(osb->cconn, OCFS2_I(inode)->ip_blkno, file, cmd, fl);
 }
diff --git a/fs/open.c b/fs/open.c
index 53bc0573c0ec..8bded6279598 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -105,9 +105,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (error)
 		goto put_write_and_out;
 
-	error = locks_verify_truncate(inode, NULL, length);
-	if (!error)
-		error = security_path_truncate(path);
+	error = security_path_truncate(path);
 	if (!error)
 		error = do_truncate(mnt_userns, path->dentry, length, 0, NULL);
 
@@ -189,9 +187,7 @@ long do_sys_ftruncate(unsigned int fd, loff_t length, int small)
 	if (IS_APPEND(file_inode(f.file)))
 		goto out_putf;
 	sb_start_write(inode->i_sb);
-	error = locks_verify_truncate(inode, f.file, length);
-	if (!error)
-		error = security_path_truncate(&f.file->f_path);
+	error = security_path_truncate(&f.file->f_path);
 	if (!error)
 		error = do_truncate(file_mnt_user_ns(f.file), dentry, length,
 				    ATTR_MTIME | ATTR_CTIME, f.file);
diff --git a/fs/read_write.c b/fs/read_write.c
index 9db7adf160d2..ffe821b8588e 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -388,13 +388,6 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 			if (!unsigned_offsets(file))
 				return retval;
 		}
-
-		if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
-			retval = locks_mandatory_area(inode, file, pos, pos + count - 1,
-					read_write == READ ? F_RDLCK : F_WRLCK);
-			if (retval < 0)
-				return retval;
-		}
 	}
 
 	return security_file_permission(file,
diff --git a/fs/remap_range.c b/fs/remap_range.c
index e4a5fdd7ad7b..ec6d26c526b3 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -107,16 +107,6 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 	if (unlikely((loff_t) (pos + len) < 0))
 		return -EINVAL;
 
-	if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
-		loff_t end = len ? pos + len - 1 : OFFSET_MAX;
-		int retval;
-
-		retval = locks_mandatory_area(inode, file, pos, end,
-				write ? F_WRLCK : F_RDLCK);
-		if (retval < 0)
-			return retval;
-	}
-
 	return security_file_permission(file, write ? MAY_WRITE : MAY_READ);
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 02bf57e6f6e2..eec877b1008c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2570,90 +2570,6 @@ extern struct kobject *fs_kobj;
 
 #define MAX_RW_COUNT (INT_MAX & PAGE_MASK)
 
-#ifdef CONFIG_MANDATORY_FILE_LOCKING
-extern int locks_mandatory_locked(struct file *);
-extern int locks_mandatory_area(struct inode *, struct file *, loff_t, loff_t, unsigned char);
-
-/*
- * Candidates for mandatory locking have the setgid bit set
- * but no group execute bit -  an otherwise meaningless combination.
- */
-
-static inline int __mandatory_lock(struct inode *ino)
-{
-	return (ino->i_mode & (S_ISGID | S_IXGRP)) == S_ISGID;
-}
-
-/*
- * ... and these candidates should be on SB_MANDLOCK mounted fs,
- * otherwise these will be advisory locks
- */
-
-static inline int mandatory_lock(struct inode *ino)
-{
-	return IS_MANDLOCK(ino) && __mandatory_lock(ino);
-}
-
-static inline int locks_verify_locked(struct file *file)
-{
-	if (mandatory_lock(locks_inode(file)))
-		return locks_mandatory_locked(file);
-	return 0;
-}
-
-static inline int locks_verify_truncate(struct inode *inode,
-				    struct file *f,
-				    loff_t size)
-{
-	if (!inode->i_flctx || !mandatory_lock(inode))
-		return 0;
-
-	if (size < inode->i_size) {
-		return locks_mandatory_area(inode, f, size, inode->i_size - 1,
-				F_WRLCK);
-	} else {
-		return locks_mandatory_area(inode, f, inode->i_size, size - 1,
-				F_WRLCK);
-	}
-}
-
-#else /* !CONFIG_MANDATORY_FILE_LOCKING */
-
-static inline int locks_mandatory_locked(struct file *file)
-{
-	return 0;
-}
-
-static inline int locks_mandatory_area(struct inode *inode, struct file *filp,
-                                       loff_t start, loff_t end, unsigned char type)
-{
-	return 0;
-}
-
-static inline int __mandatory_lock(struct inode *inode)
-{
-	return 0;
-}
-
-static inline int mandatory_lock(struct inode *inode)
-{
-	return 0;
-}
-
-static inline int locks_verify_locked(struct file *file)
-{
-	return 0;
-}
-
-static inline int locks_verify_truncate(struct inode *inode, struct file *filp,
-					size_t size)
-{
-	return 0;
-}
-
-#endif /* CONFIG_MANDATORY_FILE_LOCKING */
-
-
 #ifdef CONFIG_FILE_LOCKING
 static inline int break_lease(struct inode *inode, unsigned int mode)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index aa9de981b659..737ff2018327 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1518,12 +1518,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			if (IS_APPEND(inode) && (file->f_mode & FMODE_WRITE))
 				return -EACCES;
 
-			/*
-			 * Make sure there are no mandatory locks on the file.
-			 */
-			if (locks_verify_locked(file))
-				return -EAGAIN;
-
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			if (!(file->f_mode & FMODE_WRITE))
 				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
diff --git a/mm/nommu.c b/mm/nommu.c
index affda71641ca..b6543254d3ee 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -826,9 +826,6 @@ static int validate_mmap_request(struct file *file,
 			    (file->f_mode & FMODE_WRITE))
 				return -EACCES;
 
-			if (locks_verify_locked(file))
-				return -EAGAIN;
-
 			if (!(capabilities & NOMMU_MAP_DIRECT))
 				return -ENODEV;
 
-- 
2.31.1

