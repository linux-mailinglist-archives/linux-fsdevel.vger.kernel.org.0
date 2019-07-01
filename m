Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0207D38CA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfFGOSe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 10:18:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbfFGOSe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:18:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00928C0741E1;
        Fri,  7 Jun 2019 14:18:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB29768C84;
        Fri,  7 Jun 2019 14:18:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/13] vfs: Add a mount-notification facility [ver #4]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 07 Jun 2019 15:18:30 +0100
Message-ID: <155991711016.15579.4449417925184028666.stgit@warthog.procyon.org.uk>
In-Reply-To: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 07 Jun 2019 14:18:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a mount notification facility whereby notifications about changes in
mount topology and configuration can be received.  Note that this only
covers vfsmount topology changes and not superblock events.  A separate
facility will be added for that.

Firstly, an event queue needs to be created:

	fd = open("/dev/event_queue", O_RDWR);
	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);

then a notification can be set up to report notifications via that queue:

	struct watch_notification_filter filter = {
		.nr_filters = 1,
		.filters = {
			[0] = {
				.type = WATCH_TYPE_MOUNT_NOTIFY,
				.subtype_filter[0] = UINT_MAX,
			},
		},
	};
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
	watch_mount(AT_FDCWD, "/", 0, fd, 0x02);

In this case, it would let me monitor the mount topology subtree rooted at
"/" for events.  Mount notifications propagate up the tree towards the
root, so a watch will catch all of the events happening in the subtree
rooted at the watch.

After setting the watch, records will be placed into the queue when, for
example, as superblock switches between read-write and read-only.  Records
are of the following format:

	struct mount_notification {
		struct watch_notification watch;
		__u32	triggered_on;
		__u32	changed_mount;
	} *n;

Where:

	n->watch.type will be WATCH_TYPE_MOUNT_NOTIFY.

	n->watch.subtype will indicate the type of event, such as
	NOTIFY_MOUNT_NEW_MOUNT.

	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
	record.

	n->watch.info & WATCH_INFO_ID will be the fifth argument to
	watch_mount(), shifted.

	n->watch.info & WATCH_INFO_FLAG_0 will be used for
	NOTIFY_MOUNT_READONLY, being set if the superblock becomes R/O, and
	being cleared otherwise, and for NOTIFY_MOUNT_NEW_MOUNT, being set
	if the new mount is a submount (e.g. an automount).

	n->triggered_on indicates the ID of the mount on which the watch
	was installed.

	n->changed_mount indicates the ID of the mount that was affected.

The mount IDs can be retrieved with the fsinfo() syscall, using the
fsinfo_mount_info and fsinfo_mount_child attributes.  There are
notification counters there too for when a buffer overrun occurs, thereby
allowing the mount tree to be quickly rescanned.

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.  Note also that
the queue can be shared between multiple notifications of various types.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    1 
 fs/Kconfig                             |    9 ++
 fs/Makefile                            |    1 
 fs/mount.h                             |   33 ++++--
 fs/mount_notify.c                      |  187 ++++++++++++++++++++++++++++++++
 fs/namespace.c                         |    9 +-
 include/linux/dcache.h                 |    1 
 include/linux/syscalls.h               |    2 
 include/uapi/linux/watch_queue.h       |   24 ++++
 kernel/sys_ni.c                        |    3 +
 11 files changed, 257 insertions(+), 14 deletions(-)
 create mode 100644 fs/mount_notify.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 03decae51513..91164735efe7 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -439,3 +439,4 @@
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
 434	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
+435	i386	watch_mount		sys_watch_mount			__ia32_sys_watch_mount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ea63df9a1020..858aff7a1239 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -356,6 +356,7 @@
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
 434	common	fsinfo			__x64_sys_fsinfo
+435	common	watch_mount		__x64_sys_watch_mount
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/fs/Kconfig b/fs/Kconfig
index 9e7d2f2c0111..a26bbe27a791 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -121,6 +121,15 @@ source "fs/crypto/Kconfig"
 
 source "fs/notify/Kconfig"
 
+config MOUNT_NOTIFICATIONS
+	bool "Mount topology change notifications"
+	select WATCH_QUEUE
+	help
+	  This option provides support for getting change notifications on the
+	  mount tree topology.  This makes use of the /dev/watch_queue misc
+	  device to handle the notification buffer and provides the
+	  mount_notify() system call to enable/disable watchpoints.
+
 source "fs/quota/Kconfig"
 
 source "fs/autofs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index 26eaeae4b9a1..c6a71daf2464 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -131,3 +131,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_MOUNT_NOTIFICATIONS) += mount_notify.o
diff --git a/fs/mount.h b/fs/mount.h
index 47795802f78e..a95b805d00d8 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -4,6 +4,7 @@
 #include <linux/poll.h>
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
+#include <linux/watch_queue.h>
 
 struct mnt_namespace {
 	atomic_t		count;
@@ -67,9 +68,13 @@ struct mount {
 	int mnt_id;			/* mount identifier */
 	int mnt_group_id;		/* peer group identifier */
 	int mnt_expiry_mark;		/* true if marked for expiry */
+	int mnt_nr_watchers;		/* The number of subtree watches tracking this */
 	struct hlist_head mnt_pins;
 	struct fs_pin mnt_umount;
 	struct dentry *mnt_ex_mountpoint;
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	struct watch_list *mnt_watchers; /* Watches on dentries within this mount */
+#endif
 	atomic_t mnt_notify_counter;	/* Number of notifications generated */
 } __randomize_layout;
 
@@ -153,18 +158,8 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 	return ns->seq == 0;
 }
 
-/*
- * Type of mount topology change notification.
- */
-enum mount_notification_subtype {
-	NOTIFY_MOUNT_NEW_MOUNT	= 0, /* New mount added */
-	NOTIFY_MOUNT_UNMOUNT	= 1, /* Mount removed manually */
-	NOTIFY_MOUNT_EXPIRY	= 2, /* Automount expired */
-	NOTIFY_MOUNT_READONLY	= 3, /* Mount R/O state changed */
-	NOTIFY_MOUNT_SETATTR	= 4, /* Mount attributes changed */
-	NOTIFY_MOUNT_MOVE_FROM	= 5, /* Mount moved from here */
-	NOTIFY_MOUNT_MOVE_TO	= 6, /* Mount moved to here (compare op_id) */
-};
+extern void post_mount_notification(struct mount *changed,
+				    struct mount_notification *notify);
 
 static inline void notify_mount(struct mount *changed,
 				struct mount *aux,
@@ -172,4 +167,18 @@ static inline void notify_mount(struct mount *changed,
 				u32 info_flags)
 {
 	atomic_inc(&changed->mnt_notify_counter);
+
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	{
+		struct mount_notification n = {
+			.watch.type	= WATCH_TYPE_MOUNT_NOTIFY,
+			.watch.subtype	= subtype,
+			.watch.info	= info_flags | sizeof(n),
+			.triggered_on	= changed->mnt_id,
+			.changed_mount	= aux ? aux->mnt_id : 0,
+		};
+
+		post_mount_notification(changed, &n);
+	}
+#endif
 }
diff --git a/fs/mount_notify.c b/fs/mount_notify.c
new file mode 100644
index 000000000000..2ba81f17cc20
--- /dev/null
+++ b/fs/mount_notify.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Provide mount topology/attribute change notifications.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/syscalls.h>
+#include <linux/slab.h>
+#include <linux/security.h>
+#include "mount.h"
+
+/*
+ * Post mount notifications to all watches going rootwards along the tree.
+ *
+ * Must be called with the mount_lock held.
+ */
+void post_mount_notification(struct mount *changed,
+			     struct mount_notification *notify)
+{
+	const struct cred *cred = current_cred();
+	struct path cursor;
+	struct mount *mnt;
+	unsigned seq;
+
+	seq = 0;
+	rcu_read_lock();
+restart:
+	cursor.mnt = &changed->mnt;
+	cursor.dentry = changed->mnt.mnt_root;
+	mnt = real_mount(cursor.mnt);
+	notify->watch.info &= ~WATCH_INFO_IN_SUBTREE;
+
+	read_seqbegin_or_lock(&rename_lock, &seq);
+	for (;;) {
+		if (mnt->mnt_watchers &&
+		    !hlist_empty(&mnt->mnt_watchers->watchers)) {
+			if (cursor.dentry->d_flags & DCACHE_MOUNT_WATCH)
+				post_watch_notification(mnt->mnt_watchers,
+							&notify->watch, cred,
+							(unsigned long)cursor.dentry);
+		} else {
+			cursor.dentry = mnt->mnt.mnt_root;
+		}
+		notify->watch.info |= WATCH_INFO_IN_SUBTREE;
+
+		if (cursor.dentry == cursor.mnt->mnt_root ||
+		    IS_ROOT(cursor.dentry)) {
+			struct mount *parent = READ_ONCE(mnt->mnt_parent);
+
+			/* Escaped? */
+			if (cursor.dentry != cursor.mnt->mnt_root)
+				break;
+
+			/* Global root? */
+			if (mnt == parent)
+				break;
+
+			cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
+			mnt = parent;
+			cursor.mnt = &mnt->mnt;
+		} else {
+			cursor.dentry = cursor.dentry->d_parent;
+		}
+	}
+
+	if (need_seqretry(&rename_lock, seq)) {
+		seq = 1;
+		goto restart;
+	}
+
+	done_seqretry(&rename_lock, seq);
+	rcu_read_unlock();
+}
+
+static void release_mount_watch(struct watch *watch)
+{
+	struct vfsmount *mnt = watch->private;
+	struct dentry *dentry = (struct dentry *)(unsigned long)watch->id;
+
+	dput(dentry);
+	mntput(mnt);
+}
+
+/**
+ * sys_watch_mount - Watch for mount topology/attribute changes
+ * @dfd: Base directory to pathwalk from or fd referring to mount.
+ * @filename: Path to mount to place the watch upon
+ * @at_flags: Pathwalk control flags
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
+ */
+SYSCALL_DEFINE5(watch_mount,
+		int, dfd,
+		const char __user *, filename,
+		unsigned int, at_flags,
+		int, watch_fd,
+		int, watch_id)
+{
+	struct watch_queue *wqueue;
+	struct watch_list *wlist = NULL;
+	struct watch *watch;
+	struct mount *m;
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
+	ret = user_path_at(dfd, filename, lookup_flags, &path);
+	if (ret)
+		return ret;
+
+	wqueue = get_watch_queue(watch_fd);
+	if (IS_ERR(wqueue))
+		goto err_path;
+
+	m = real_mount(path.mnt);
+
+	if (watch_id >= 0) {
+		ret = -ENOMEM;
+		if (!m->mnt_watchers) {
+			wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
+			if (!wlist)
+				goto err_wqueue;
+			init_watch_list(wlist, release_mount_watch);
+		}
+
+		watch = kzalloc(sizeof(*watch), GFP_KERNEL);
+		if (!watch)
+			goto err_wlist;
+
+		init_watch(watch, wqueue);
+		watch->id		= (unsigned long)path.dentry;
+		watch->private		= path.mnt;
+		watch->info_id		= (u32)watch_id << 24;
+
+		ret = security_watch_mount(watch, &path);
+		if (ret < 0)
+			goto err_watch;
+
+		down_write(&m->mnt.mnt_sb->s_umount);
+		if (!m->mnt_watchers) {
+			m->mnt_watchers = wlist;
+			wlist = NULL;
+		}
+
+		ret = add_watch_to_object(watch, m->mnt_watchers);
+		if (ret == 0) {
+			spin_lock(&path.dentry->d_lock);
+			path.dentry->d_flags |= DCACHE_MOUNT_WATCH;
+			spin_unlock(&path.dentry->d_lock);
+			path_get(&path);
+			watch = NULL;
+		}
+		up_write(&m->mnt.mnt_sb->s_umount);
+	} else {
+		ret = -EBADSLT;
+		if (m->mnt_watchers) {
+			down_write(&m->mnt.mnt_sb->s_umount);
+			ret = remove_watch_from_object(m->mnt_watchers, wqueue,
+						       (unsigned long)path.dentry,
+						       false);
+			up_write(&m->mnt.mnt_sb->s_umount);
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
diff --git a/fs/namespace.c b/fs/namespace.c
index 2ec7d9d1905a..b4758486ee33 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -515,7 +515,8 @@ static int mnt_make_readonly(struct mount *mnt)
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
 	unlock_mount_hash();
 	if (ret == 0)
-		notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0x10000);
+		notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY,
+			     WATCH_INFO_FLAG_0);
 	return ret;
 }
 
@@ -1478,6 +1479,10 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 		list_del_init(&p->mnt_expire);
 		list_del_init(&p->mnt_list);
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+		if (p->mnt_watchers)
+			remove_watch_list(p->mnt_watchers);
+#endif
 		ns = p->mnt_ns;
 		if (ns) {
 			ns->mounts--;
@@ -2115,7 +2120,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_NEW_MOUNT,
 			     source_mnt->mnt.mnt_sb->s_flags & SB_SUBMOUNT ?
-			     0x10000 : 0);
+			     WATCH_INFO_FLAG_0 : 0);
 		commit_tree(source_mnt);
 	}
 
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 361305ddd75e..5db8e244d9a0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -217,6 +217,7 @@ struct dentry_operations {
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_MOUNT_WATCH		0x80000000 /* There's a mount watch here */
 
 extern seqlock_t rename_lock;
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 217d25b62b4f..f2e7f18b323a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1001,6 +1001,8 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 asmlinkage long sys_fsinfo(int dfd, const char __user *path,
 			   struct fsinfo_params __user *params,
 			   void __user *buffer, size_t buf_size);
+asmlinkage long sys_watch_mount(int dfd, const char __user *path,
+				unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 32177bcf85f1..cf3c0c03a747 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -105,4 +105,28 @@ struct key_notification {
 	__u32	aux;		/* Per-type auxiliary data */
 };
 
+/*
+ * Type of mount topology change notification.
+ */
+enum mount_notification_subtype {
+	NOTIFY_MOUNT_NEW_MOUNT	= 0, /* New mount added */
+	NOTIFY_MOUNT_UNMOUNT	= 1, /* Mount removed manually */
+	NOTIFY_MOUNT_EXPIRY	= 2, /* Automount expired */
+	NOTIFY_MOUNT_READONLY	= 3, /* Mount R/O state changed */
+	NOTIFY_MOUNT_SETATTR	= 4, /* Mount attributes changed */
+	NOTIFY_MOUNT_MOVE_FROM	= 5, /* Mount moved from here */
+	NOTIFY_MOUNT_MOVE_TO	= 6, /* Mount moved to here (compare op_id) */
+};
+
+/*
+ * Mount topology/configuration change notification record.
+ * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
+ * - watch.subtype = enum mount_notification_subtype
+ */
+struct mount_notification {
+	struct watch_notification watch; /* WATCH_TYPE_MOUNT_NOTIFY */
+	__u32	triggered_on;		/* The mount that the notify was on */
+	__u32	changed_mount;		/* The mount that got changed */
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index d1d9d76cae1e..97b025e7863c 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -88,6 +88,9 @@ COND_SYSCALL(ioprio_get);
 /* fs/locks.c */
 COND_SYSCALL(flock);
 
+/* fs/mount_notify.c */
+COND_SYSCALL(mount_notify);
+
 /* fs/namei.c */
 
 /* fs/namespace.c */

