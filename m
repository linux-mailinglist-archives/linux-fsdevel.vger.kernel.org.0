Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1721A3705C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 11:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfFFJmx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jun 2019 05:42:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfFFJmw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:42:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECCD230C3192;
        Thu,  6 Jun 2019 09:42:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC1CB65F47;
        Thu,  6 Jun 2019 09:42:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 05/10] vfs: Add superblock notifications [ver #3]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jun 2019 10:42:49 +0100
Message-ID: <155981416919.17513.7715903175984222836.stgit@warthog.procyon.org.uk>
In-Reply-To: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
References: <155981411940.17513.7137844619951358374.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 06 Jun 2019 09:42:52 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a superblock event notification facility whereby notifications about
superblock events, such as I/O errors (EIO), quota limits being hit
(EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
process asynchronously.  Note that this does not cover vfsmount topology
changes.  mount_notify() is used for that.

Firstly, an event queue needs to be created:

	fd = open("/dev/event_queue", O_RDWR);
	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);

then a notification can be set up to report notifications via that queue:

	struct watch_notification_filter filter = {
		.nr_filters = 1,
		.filters = {
			[0] = {
				.type = WATCH_TYPE_SB_NOTIFY,
				.subtype_filter[0] = UINT_MAX,
			},
		},
	};
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
	sb_notify(AT_FDCWD, "/home/dhowells", 0, fd, 0x03);

In this case, it would let me monitor my own homedir for events.  After
setting the watch, records will be placed into the queue when, for example,
as superblock switches between read-write and read-only.  Records are of
the following format:

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
	sb_notify(), shifted.

	n->watch.info & WATCH_INFO_FLAG_0 will be used for
	NOTIFY_SUPERBLOCK_READONLY, being set if the superblock becomes
	R/O, and being cleared otherwise.

	n->sb_id will be the ID of the superblock, as can be retrieved with
	the fsinfo() syscall, as part of the fsinfo_sb_notifications
	attribute in the the watch_id field.

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.  Note also that
the queue can be shared between multiple notifications of various types.

[*] QUESTION: Does this want to be per-sb, per-mount_namespace,
    per-some-new-notify-ns or per-system?  Or do multiple options make
    sense?

[*] QUESTION: I've done it this way so that anyone could theoretically
    monitor the superblock of any filesystem they can pathwalk to, but do
    we need other security controls?

[*] QUESTION: Should the LSM be able to filter the events a queue can
    receive?  For instance the opener of the queue would grant that queue
    subject creds (by ->f_cred) that could be used to govern what events
    could be seen, assuming the target superblock to have some object
    creds, based on, say, the mounter.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/Kconfig                             |   12 +++
 fs/super.c                             |  115 ++++++++++++++++++++++++++++++++
 include/linux/fs.h                     |   77 +++++++++++++++++++++
 include/linux/syscalls.h               |    2 +
 include/uapi/linux/watch_queue.h       |   26 +++++++
 kernel/sys_ni.c                        |    3 +
 8 files changed, 237 insertions(+)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index a8416a9a0ccb..429416ce60e1 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -440,3 +440,4 @@
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
 434	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
 435	i386	mount_notify		sys_mount_notify		__ia32_sys_mount_notify
+436	i386	sb_notify		sys_sb_notify			__ia32_sys_sb_notify
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ea052a94eb97..4ae146e472db 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -357,6 +357,7 @@
 433	common	fspick			__x64_sys_fspick
 434	common	fsinfo			__x64_sys_fsinfo
 435	common	mount_notify		__x64_sys_mount_notify
+436	common	sb_notify		__x64_sys_sb_notify
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/Kconfig b/fs/Kconfig
index a26bbe27a791..fc0fa4b35f3c 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -130,6 +130,18 @@ config MOUNT_NOTIFICATIONS
 	  device to handle the notification buffer and provides the
 	  mount_notify() system call to enable/disable watchpoints.
 
+config SB_NOTIFICATIONS
+	bool "Superblock event notifications"
+	select WATCH_QUEUE
+	help
+	  This option provides support for receiving superblock event
+	  notifications.  This makes use of the /dev/watch_queue misc device to
+	  handle the notification buffer and provides the sb_notify() system
+	  call to enable/disable watches.
+
+	  Events can include things like changing between R/W and R/O, EIO
+	  generation, ENOSPC generation and EDQUOT generation.
+
 source "fs/quota/Kconfig"
 
 source "fs/autofs/Kconfig"
diff --git a/fs/super.c b/fs/super.c
index 61819e8e5469..cddf23f1d648 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,8 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
+#include <linux/syscalls.h>
+#include <linux/namei.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -350,6 +352,10 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
+#ifdef CONFIG_SB_NOTIFICATIONS
+		if (s->s_watchers)
+			remove_watch_list(s->s_watchers);
+#endif
 		cleancache_invalidate_fs(s);
 		unregister_shrinker(&s->s_shrink);
 		fs->kill_sb(s);
@@ -990,6 +996,8 @@ int reconfigure_super(struct fs_context *fc)
 	/* Needs to be ordered wrt mnt_is_readonly() */
 	smp_wmb();
 	sb->s_readonly_remount = 0;
+	notify_sb(sb, NOTIFY_SUPERBLOCK_READONLY,
+		  remount_ro ? WATCH_INFO_FLAG_0 : 0);
 
 	/*
 	 * Some filesystems modify their metadata via some other path than the
@@ -1808,3 +1816,110 @@ int thaw_super(struct super_block *sb)
 	return thaw_super_locked(sb);
 }
 EXPORT_SYMBOL(thaw_super);
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+/*
+ * Post superblock notifications.
+ */
+void post_sb_notification(struct super_block *s, struct superblock_notification *n)
+{
+	post_watch_notification(s->s_watchers, &n->watch, current_cred(),
+				s->s_unique_id);
+}
+
+/**
+ * sys_sb_notify - Watch for superblock events.
+ * @dfd: Base directory to pathwalk from or fd referring to superblock.
+ * @filename: Path to superblock to place the watch upon
+ * @at_flags: Pathwalk control flags
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
+ */
+SYSCALL_DEFINE5(sb_notify,
+		int, dfd,
+		const char __user *, filename,
+		unsigned int, at_flags,
+		int, watch_fd,
+		int, watch_id)
+{
+	struct watch_queue *wqueue;
+	struct super_block *s;
+	struct watch_list *wlist = NULL;
+	struct watch *watch;
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
+	wqueue = get_watch_queue(watch_fd);
+	if (IS_ERR(wqueue))
+		goto err_path;
+
+	s = path.dentry->d_sb;
+	if (watch_id >= 0) {
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
+			}
+		}
+		up_write(&s->s_umount);
+		if (ret < 0)
+			kfree(watch);
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
index db05738b1951..02ba4bfb9cc3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -40,6 +40,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/watch_queue.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1531,6 +1532,10 @@ struct super_block {
 
 	/* Superblock event notifications */
 	u64			s_unique_id;
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+	struct watch_list	*s_watchers;
+#endif
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
@@ -3531,4 +3536,76 @@ static inline struct sock *io_uring_get_socket(struct file *file)
 }
 #endif
 
+extern void post_sb_notification(struct super_block *, struct superblock_notification *);
+
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
+			.watch.info	= sizeof(n) | info,
+			.sb_id		= s->s_unique_id,
+		};
+
+		post_sb_notification(s, &n);
+	}
+			     
+#endif
+}
+
+/**
+ * notify_sb_error: Post superblock error notification.
+ * @s: The superblock the notification is about.
+ * @error: The error number to be recorded.
+ */
+static inline int notify_sb_error(struct super_block *s, int error)
+{
+#ifdef CONFIG_SB_NOTIFICATIONS
+	if (unlikely(s->s_watchers)) {
+		struct superblock_error_notification n = {
+			.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
+			.s.watch.subtype = NOTIFY_SUPERBLOCK_ERROR,
+			.s.watch.info	= sizeof(n),
+			.s.sb_id	= s->s_unique_id,
+			.error_number	= error,
+			.error_cookie	= 0,
+		};
+
+		post_sb_notification(s, &n.s);
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
+			.watch.info	= sizeof(n),
+			.sb_id		= s->s_unique_id,
+		};
+
+		post_sb_notification(s, &n);
+	}
+#endif
+	return -EDQUOT;
+}
+
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7c2b66175f3c..204a6dbcc34a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1003,6 +1003,8 @@ asmlinkage long sys_fsinfo(int dfd, const char __user *path,
 			   void __user *buffer, size_t buf_size);
 asmlinkage long sys_mount_notify(int dfd, const char __user *path,
 				 unsigned int at_flags, int watch_fd, int watch_id);
+asmlinkage long sys_sb_notify(int dfd, const char __user *path,
+			      unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index cf3c0c03a747..66b0da7cf888 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -129,4 +129,30 @@ struct mount_notification {
 	__u32	changed_mount;		/* The mount that got changed */
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
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 97b025e7863c..565d1e3d1bed 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -108,6 +108,9 @@ COND_SYSCALL(quotactl);
 
 /* fs/read_write.c */
 
+/* fs/sb_notify.c */
+COND_SYSCALL(sb_notify);
+
 /* fs/sendfile.c */
 
 /* fs/select.c */

