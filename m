Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1221059FEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfF1Pu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfF1Pu6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:50:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CB4781E0D;
        Fri, 28 Jun 2019 15:50:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3934B26E58;
        Fri, 28 Jun 2019 15:50:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 4/6] vfs: Add superblock notifications [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:50:53 +0100
Message-ID: <156173705340.15650.11962465482712173627.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
References: <156173701358.15650.8735203424342507015.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 28 Jun 2019 15:50:57 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a superblock event notification facility whereby notifications about
superblock events, such as I/O errors (EIO), quota limits being hit
(EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
process asynchronously.  Note that this does not cover vfsmount topology
changes.  watch_mount() is used for that.

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
	watch_sb(AT_FDCWD, "/home/dhowells", 0, fd, 0x03);

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
---

 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
 arch/s390/kernel/syscalls/syscall.tbl       |    1 
 arch/sh/kernel/syscalls/syscall.tbl         |    1 
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
 fs/Kconfig                                  |   12 +++
 fs/super.c                                  |  125 +++++++++++++++++++++++++++
 include/linux/fs.h                          |   77 +++++++++++++++++
 include/linux/syscalls.h                    |    2 
 include/uapi/asm-generic/unistd.h           |    4 +
 include/uapi/linux/watch_queue.h            |   31 ++++++-
 kernel/sys_ni.c                             |    1 
 24 files changed, 267 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index fbf0d0f5cfb3..2fa4a8008892 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -476,3 +476,4 @@
 544	common	fsinfo				sys_fsinfo
 545	common	watch_devices			sys_watch_devices
 546	common	watch_mount			sys_watch_mount
+547	common	watch_sb			sys_watch_sb
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index a15324ed6419..29d110112053 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -450,3 +450,4 @@
 434	common	fsinfo				sys_fsinfo
 435	common	watch_devices			sys_watch_devices
 436	common	watch_mount			sys_watch_mount
+437	common	watch_sb			sys_watch_sb
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index d04eb26cfaeb..24480c2d95da 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		436
+#define __NR_compat_syscalls		437
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 2e7becfa2f56..43d789bebdc5 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -357,3 +357,4 @@
 434	common	fsinfo				sys_fsinfo
 435	common	watch_devices			sys_watch_devices
 436	common	watch_mount			sys_watch_mount
+437	common	watch_sb			sys_watch_sb
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 3431e8df17f5..3cc310a4aca2 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 434	common	fsinfo				sys_fsinfo
 435	common	watch_devices			sys_watch_devices
 436	common	watch_mount			sys_watch_mount
+437	common	watch_sb			sys_watch_sb
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index fbe3c932c3d8..63ec96cf2856 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -442,3 +442,4 @@
 434	common	fsinfo				sys_fsinfo
 435	common	watch_devices			sys_watch_devices
 436	common	watch_mount			sys_watch_mount
+437	common	watch_sb			sys_watch_sb
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index e2f6e92ed8c5..fa3f3973e46d 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -375,3 +375,4 @@
 434	n32	fsinfo				sys_fsinfo
 435	n32	watch_devices			sys_watch_devices
 436	n32	watch_mount			sys_watch_mount
+437	n32	watch_sb			sys_watch_sb
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index bdd1f98f3515..e4bb2b7fb1fe 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -351,3 +351,4 @@
 434	n64	fsinfo				sys_fsinfo
 435	n64	watch_devices			sys_watch_devices
 436	n64	watch_mount			sys_watch_mount
+437	n64	watch_sb			sys_watch_sb
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index ff992a6fdd95..0ac3fce74d0b 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -424,3 +424,4 @@
 434	o32	fsinfo				sys_fsinfo
 435	o32	watch_devices			sys_watch_devices
 436	o32	watch_mount			sys_watch_mount
+437	o32	watch_sb			sys_watch_sb
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 11ae6854d49c..cc841a941ebd 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 434	common	fsinfo				sys_fsinfo
 435	common	watch_devices			sys_watch_devices
 436	common	watch_mount			sys_watch_mount
+437	common	watch_sb			sys_watch_sb
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 7bc79d837385..7116d18f5189 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -518,3 +518,4 @@
 434	common	fsinfo				sys_fsinfo
 435	common	watch_devices			sys_watch_devices
 436	common	watch_mount			sys_watch_mount
+437	common	watch_sb			sys_watch_sb
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e2f8785d1c4a..1048060ea28d 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 434	common	fsinfo			sys_fsinfo			sys_fsinfo
 435	common	watch_devices		sys_watch_devices		sys_watch_devices
 436	common	watch_mount		sys_watch_mount			sys_watch_mount
+437	common	watch_sb		sys_watch_sb			sys_watch_sb
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index d94d71558742..d9dcab80b9b4 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 434	common	fsinfo				sys_fsinfo
 435	common	watch_devices			sys_watch_devices
 436	common	watch_mount			sys_watch_mount
+437	common	watch_sb			sys_watch_sb
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 9f7fa4f381cc..f5b052a7bd32 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -482,3 +482,4 @@
 434	common	fsinfo				sys_fsinfo
 435	common	watch_devices			sys_watch_devices
 436	common	watch_mount			sys_watch_mount
+437	common	watch_sb			sys_watch_sb
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ea34893de5b9..151459569d8e 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -441,3 +441,4 @@
 434	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
 435	i386	watch_devices		sys_watch_devices		__ia32_sys_watch_devices
 436	i386	watch_mount		sys_watch_mount			__ia32_sys_watch_mount
+437	i386	watch_sb		sys_watch_sb			__ia32_sys_watch_sb
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b6f3fdbee456..cd4c854607ba 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -358,6 +358,7 @@
 434	common	fsinfo			__x64_sys_fsinfo
 435	common	watch_devices		__x64_sys_watch_devices
 436	common	watch_mount		__x64_sys_watch_mount
+437	common	watch_sb		__x64_sys_watch_sb
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 570b23dc5582..7d07362460ba 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -407,3 +407,4 @@
 434	common	fsinfo				sys_fsinfo
 435	common	watch_devices			sys_watch_devices
 436	common	watch_mount			sys_watch_mount
+437	common	watch_sb			sys_watch_sb
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
index c04f9481a708..9f631cd4f93b 100644
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
@@ -1022,6 +1028,8 @@ int reconfigure_super(struct fs_context *fc)
 	/* Needs to be ordered wrt mnt_is_readonly() */
 	smp_wmb();
 	sb->s_readonly_remount = 0;
+	notify_sb(sb, NOTIFY_SUPERBLOCK_READONLY,
+		  remount_ro ? NOTIFY_SUPERBLOCK_IS_NOW_RO : 0);
 
 	/*
 	 * Some filesystems modify their metadata via some other path than the
@@ -1825,3 +1833,120 @@ int thaw_super(struct super_block *sb)
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
+		ret = security_watch_sb(watch, s);
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
index 61098cded376..42adb7a391a9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -40,6 +40,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/watch_queue.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1530,6 +1531,10 @@ struct super_block {
 
 	/* Superblock event notifications */
 	u64			s_unique_id;
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+	struct watch_list	*s_watchers;
+#endif
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
@@ -3554,4 +3559,76 @@ static inline struct sock *io_uring_get_socket(struct file *file)
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
+			.watch.info	= watch_sizeof(n) | info,
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
+			.s.watch.info	= watch_sizeof(n),
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
+			.watch.info	= watch_sizeof(n),
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
index 8b0ab1594a62..d27173aa22fe 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1004,6 +1004,8 @@ asmlinkage long sys_fsinfo(int dfd, const char __user *pathname,
 asmlinkage long sys_watch_devices(int watch_fd, int watch_id, unsigned int flags);
 asmlinkage long sys_watch_mount(int dfd, const char __user *path,
 				unsigned int at_flags, int watch_fd, int watch_id);
+asmlinkage long sys_watch_sb(int dfd, const char __user *path,
+			     unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 85977cfa853d..f74e6fb3c314 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -850,9 +850,11 @@ __SYSCALL(__NR_fsinfo, sys_fsinfo)
 __SYSCALL(__NR_watch_devices, sys_watch_devices)
 #define __NR_watch_mount 436
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
+#define __NR_watch_sb 437
+__SYSCALL(__NR_watch_sb, sys_watch_sb)
 
 #undef __NR_syscalls
-#define __NR_syscalls 437
+#define __NR_syscalls 438
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 1dce57287ded..c8f0adefd8de 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -14,7 +14,8 @@ enum watch_notification_type {
 	WATCH_TYPE_BLOCK_NOTIFY	= 2,	/* Block layer event notification */
 	WATCH_TYPE_USB_NOTIFY	= 3,	/* USB subsystem event notification */
 	WATCH_TYPE_MOUNT_NOTIFY	= 4,	/* Mount topology change notification */
-	WATCH_TYPE___NR		= 5
+	WATCH_TYPE_SB_NOTIFY	= 5,	/* Superblock event notification */
+	WATCH_TYPE___NR		= 6
 };
 
 enum watch_meta_notification_subtype {
@@ -197,4 +198,32 @@ struct mount_notification {
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
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3755d0e5d748..4d559ab64de4 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -54,6 +54,7 @@ COND_SYSCALL(io_uring_register);
 COND_SYSCALL(fsinfo);
 COND_SYSCALL(watch_devices);
 COND_SYSCALL(watch_mount);
+COND_SYSCALL(watch_sb);
 
 /* fs/xattr.c */
 

