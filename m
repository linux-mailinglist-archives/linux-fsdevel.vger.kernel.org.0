Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571062942D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 21:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438053AbgJTTQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 15:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438038AbgJTTQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 15:16:02 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CABBC0613CE;
        Tue, 20 Oct 2020 12:16:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2C2641F44C3B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH RFC 4/7] vfs: Add superblock notifications
Date:   Tue, 20 Oct 2020 15:15:40 -0400
Message-Id: <20201020191543.601784-5-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020191543.601784-1-krisman@collabora.com>
References: <20201020191543.601784-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Add a superblock event notification facility whereby notifications about
superblock events, such as I/O errors (EIO), quota limits being hit
(EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
process asynchronously.  Note that this does not cover vfsmount topology
changes.  watch_mount() is used for that.

Records are of the following format:

	struct superblock_notification {
		struct watch_notification watch;
		__u64	sb_id;
	} *n;

Where:

	n->watch.type will be WATCH_TYPE_SB_NOTIFY.

	n->watch.subtype will indicate the type of event, such as
	NOTIFY_SUPERBLOCK_READONLY.

	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
	record.

	n->watch.info & WATCH_INFO_ID will be the fifth argument to
	watch_sb(), shifted.

	n->watch.info & NOTIFY_SUPERBLOCK_IS_NOW_RO will be used for
	NOTIFY_SUPERBLOCK_READONLY, being set if the superblock becomes
	R/O, and being cleared otherwise.

	n->sb_id will be the ID of the superblock, as can be retrieved with
	the fsinfo() syscall, as part of the fsinfo_sb_notifications
	attribute in the the watch_id field.

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.  Note also that
the queue can be shared between multiple notifications of various types.

Signed-off-by: David Howells <dhowells@redhat.com>
[Rebase to mainline.  Update API and commit message]
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 fs/Kconfig                             |  12 +++
 fs/super.c                             | 127 +++++++++++++++++++++++++
 include/linux/fs.h                     |  83 ++++++++++++++++
 include/linux/syscalls.h               |   2 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/watch_queue.h       |  32 ++++++-
 kernel/sys_ni.c                        |   3 +
 9 files changed, 263 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0d0667a9fbd7..c481ab8c4454 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -445,3 +445,4 @@
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
 440	i386	process_madvise		sys_process_madvise
+441	i386	watch_sb		sys_watch_sb
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1f47e24fb65c..be860d4d69ba 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -362,6 +362,7 @@
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
 440	common	process_madvise		sys_process_madvise
+441	common	watch_sb		sys_watch_sb
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c12282301..4e96521c37a1 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -117,6 +117,18 @@ source "fs/verity/Kconfig"
 
 source "fs/notify/Kconfig"
 
+config SB_NOTIFICATIONS
+	bool "Superblock event notifications"
+	select WATCH_QUEUE
+	help
+	  This option provides support for receiving superblock event
+	  notifications.  This makes use of the watch_queue API to
+	  handle the notification buffer and provides the sb_notify()
+	  system call to enable/disable watches.
+
+	  Events can include things like changing between R/W and R/O, EIO
+	  generation, ENOSPC generation and EDQUOT generation.
+
 source "fs/quota/Kconfig"
 
 source "fs/autofs/Kconfig"
diff --git a/fs/super.c b/fs/super.c
index a51c2083cd6b..8178a595a336 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -37,6 +37,8 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
+#include <linux/syscalls.h>
+#include <linux/namei.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -330,6 +332,10 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
+#ifdef CONFIG_SB_NOTIFICATIONS
+		if (s->s_watchers)
+			remove_watch_list(s->s_watchers, s->s_unique_id);
+#endif
 		cleancache_invalidate_fs(s);
 		unregister_shrinker(&s->s_shrink);
 		fs->kill_sb(s);
@@ -969,6 +975,8 @@ int reconfigure_super(struct fs_context *fc)
 	/* Needs to be ordered wrt mnt_is_readonly() */
 	smp_wmb();
 	sb->s_readonly_remount = 0;
+	notify_sb(sb, NOTIFY_SUPERBLOCK_READONLY,
+		  remount_ro ? NOTIFY_SUPERBLOCK_IS_NOW_RO : 0);
 
 	/*
 	 * Some filesystems modify their metadata via some other path than the
@@ -1867,3 +1875,122 @@ int thaw_super(struct super_block *sb)
 	return thaw_super_locked(sb);
 }
 EXPORT_SYMBOL(thaw_super);
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+/*
+ * Post superblock notifications.
+ */
+
+void post_sb_notification(struct super_block *s, struct superblock_notification *n,
+			  const char *fmt, va_list *args)
+{
+	post_watch_notification_string(s->s_watchers, &n->watch, current_cred(),
+				       s->s_unique_id, fmt, args);
+}
+
+/**
+ * sys_watch_sb - Watch for superblock events.
+ * @dfd: Base directory to pathwalk from or fd referring to superblock.
+ * @filename: Path to superblock to place the watch upon
+ * @at_flags: Pathwalk control flags
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
+ */
+SYSCALL_DEFINE5(watch_sb,
+		int, dfd,
+		const char __user *, filename,
+		unsigned int, at_flags,
+		int, watch_fd,
+		int, watch_id)
+{
+	struct watch_queue *wqueue;
+	struct super_block *s;
+	struct watch_list *wlist = NULL;
+	struct watch *watch = NULL;
+	struct path path;
+	unsigned int lookup_flags =
+		LOOKUP_DIRECTORY | LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
+	int ret;
+
+	if (watch_id < -1 || watch_id > 0xff)
+		return -EINVAL;
+	if ((at_flags & ~(AT_NO_AUTOMOUNT | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+	if (at_flags & AT_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (at_flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	ret = user_path_at(dfd, filename, at_flags, &path);
+	if (ret)
+		return ret;
+
+	ret = inode_permission(path.dentry->d_inode, MAY_EXEC);
+	if (ret)
+		goto err_path;
+
+	wqueue = get_watch_queue(watch_fd);
+	if (IS_ERR(wqueue))
+		goto err_path;
+
+	s = path.dentry->d_sb;
+	if (watch_id >= 0) {
+		ret = -ENOMEM;
+		if (!s->s_watchers) {
+			wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
+			if (!wlist)
+				goto err_wqueue;
+			init_watch_list(wlist, NULL);
+		}
+
+		watch = kzalloc(sizeof(*watch), GFP_KERNEL);
+		if (!watch)
+			goto err_wlist;
+
+		init_watch(watch, wqueue);
+		watch->id		= s->s_unique_id;
+		watch->private		= s;
+		watch->info_id		= (u32)watch_id << 24;
+
+		ret = security_watch_sb(s);
+		if (ret < 0)
+			goto err_watch;
+
+		down_write(&s->s_umount);
+		ret = -EIO;
+		if (atomic_read(&s->s_active)) {
+			if (!s->s_watchers) {
+				s->s_watchers = wlist;
+				wlist = NULL;
+			}
+
+			ret = add_watch_to_object(watch, s->s_watchers);
+			if (ret == 0) {
+				spin_lock(&sb_lock);
+				s->s_count++;
+				spin_unlock(&sb_lock);
+				watch = NULL;
+			}
+		}
+		up_write(&s->s_umount);
+	} else {
+		ret = -EBADSLT;
+		if (READ_ONCE(s->s_watchers)) {
+			down_write(&s->s_umount);
+			ret = remove_watch_from_object(s->s_watchers, wqueue,
+						       s->s_unique_id, false);
+			up_write(&s->s_umount);
+		}
+	}
+
+err_watch:
+	kfree(watch);
+err_wlist:
+	kfree(wlist);
+err_wqueue:
+	put_watch_queue(wqueue);
+err_path:
+	path_put(&path);
+	return ret;
+}
+#endif
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c4ae9cafbbba..d24905e10623 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -39,6 +39,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/watch_queue.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1547,6 +1548,13 @@ struct super_block {
 
 	spinlock_t		s_inode_wblist_lock;
 	struct list_head	s_inodes_wb;	/* writeback inodes */
+
+	/* Superblock event notifications */
+	u64			s_unique_id;
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+	struct watch_list	*s_watchers;
+#endif
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
@@ -3478,4 +3486,79 @@ static inline int inode_drain_writes(struct inode *inode)
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
+extern void post_sb_notification(struct super_block *, struct superblock_notification *,
+				 const char *fmt, va_list *args);
+/**
+ * notify_sb: Post simple superblock notification.
+ * @s: The superblock the notification is about.
+ * @subtype: The type of notification.
+ * @info: WATCH_INFO_FLAG_* flags to be set in the record.
+ */
+static inline void notify_sb(struct super_block *s,
+			     enum superblock_notification_type subtype,
+			     u32 info)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_notification n = {
+			.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.watch.subtype	= subtype,
+			.watch.info	= watch_sizeof(n) | info,
+			.sb_id		= s->s_unique_id,
+		};
+
+		post_sb_notification(s, &n, NULL, NULL);
+	}
+
+#endif
+}
+
+/**
+ * notify_sb_error: Post superblock error notification.
+ * @s: The superblock the notification is about.
+ * @error: The error number to be recorded.
+ * @fmt: Formating string for extra information appended to the notification
+ * @args: arguments for extra information string appended to the notification
+ */
+static inline int notify_sb_error(struct super_block *s, int error,
+				  const char *fmt, va_list *args)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_error_notification n = {
+			.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.s.watch.subtype = NOTIFY_SUPERBLOCK_ERROR,
+			.s.watch.info	= watch_sizeof(n),
+			.s.sb_id	= s->s_unique_id,
+			.error_number	= error,
+			.error_cookie	= 0,
+		};
+
+		post_sb_notification(s, &n.s, fmt, args);
+	}
+#endif
+	return error;
+}
+
+/**
+ * notify_sb_EDQUOT: Post superblock quota overrun notification.
+ * @s: The superblock the notification is about.
+ */
+static inline int notify_sb_EQDUOT(struct super_block *s)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_notification n = {
+			.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.watch.subtype	= NOTIFY_SUPERBLOCK_EDQUOT,
+			.watch.info	= watch_sizeof(n),
+			.sb_id		= s->s_unique_id,
+		};
+
+		post_sb_notification(s, &n, NULL, NULL);
+	}
+#endif
+	return -EDQUOT;
+}
+
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2eda7678fe1d..e37de06c6af9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1008,6 +1008,8 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
+asmlinkage long sys_watch_sb(int dfd, const char __user *path,
+			     unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2056318988f7..5eec69e2b312 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -859,9 +859,11 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
+#define __NR_watch_sb 441
+__SYSCALL(__NR_watch_sb, sys_watch_sb)
 
 #undef __NR_syscalls
-#define __NR_syscalls 441
+#define __NR_syscalls 442
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index c3d8320b5d3a..5899936534f4 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -14,7 +14,8 @@
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
 	WATCH_TYPE_KEY_NOTIFY	= 1,	/* Key change event notification */
-	WATCH_TYPE__NR		= 2
+	WATCH_TYPE_SB_NOTIFY	= 2,
+	WATCH_TYPE__NR		= 3
 };
 
 enum watch_meta_notification_subtype {
@@ -101,4 +102,33 @@ struct key_notification {
 	__u32	aux;		/* Per-type auxiliary data */
 };
 
+/*
+ * Type of superblock notification.
+ */
+enum superblock_notification_type {
+	NOTIFY_SUPERBLOCK_READONLY	= 0, /* Filesystem toggled between R/O and R/W */
+	NOTIFY_SUPERBLOCK_ERROR		= 1, /* Error in filesystem or blockdev */
+	NOTIFY_SUPERBLOCK_EDQUOT	= 2, /* EDQUOT notification */
+	NOTIFY_SUPERBLOCK_NETWORK	= 3, /* Network status change */
+};
+
+#define NOTIFY_SUPERBLOCK_IS_NOW_RO	WATCH_INFO_FLAG_0 /* Superblock changed to R/O */
+
+/*
+ * Superblock notification record.
+ * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
+ * - watch.subtype = enum superblock_notification_subtype
+ */
+struct superblock_notification {
+	struct watch_notification watch; /* WATCH_TYPE_SB_NOTIFY */
+	__u64	sb_id;			/* 64-bit superblock ID [fsinfo_ids::f_sb_id] */
+};
+
+struct superblock_error_notification {
+	struct superblock_notification s; /* subtype = notify_superblock_error */
+	__u32	error_number;
+	__u32	error_cookie;
+	char	desc[0];
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f27ac94d5fa7..3e97984bc4c8 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -51,6 +51,9 @@ COND_SYSCALL_COMPAT(io_pgetevents);
 COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
+COND_SYSCALL(fsinfo);
+COND_SYSCALL(watch_mount);
+COND_SYSCALL(watch_sb);
 
 /* fs/xattr.c */
 
-- 
2.28.0

