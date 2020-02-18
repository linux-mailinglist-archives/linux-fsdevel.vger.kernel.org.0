Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D33162B7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBRRHF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 12:07:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51491 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727578AbgBRRHF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iSYFeIQYQY6r8mdc6BD4IFGy0DmOMi/u7MK7IFtOL/8=;
        b=W0ubm5v7VbJN/Hd9ZGJOqdFARbxMYaoN0ZbdBJm8zCbNTzWem9cc1Ob1H95UNdtbA+N4M2
        8CP7NhxyOawtFRN/7+P+4IXh1wvHIXz6mcaz/eU2C0gLX5AZI2WGLfQYktJLCUCRKTdcYn
        mFZqiZw0vlSOerE/YEjXCcV41AlFXxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-E1exFPF_OHyke4lrdD17Cg-1; Tue, 18 Feb 2020 12:06:54 -0500
X-MC-Unique: E1exFPF_OHyke4lrdD17Cg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 823A913E6;
        Tue, 18 Feb 2020 17:06:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC29890089;
        Tue, 18 Feb 2020 17:06:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 15/19] vfs: Add superblock notifications [ver #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:06:51 +0000
Message-ID: <158204561120.3299825.5242636508455859327.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index 72bc7b33c59d..cd39492e4f7d 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -479,3 +479,4 @@
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	fsinfo				sys_fsinfo
 550	common	watch_mount			sys_watch_mount
+551	common	watch_sb			sys_watch_sb
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 67777fd0b19e..a26bc42b9464 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -453,3 +453,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
 440	common	watch_mount			sys_watch_mount
+441	common	watch_sb			sys_watch_sb
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 75f04a1023be..388eeb71cff0 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		440
+#define __NR_compat_syscalls		442
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index cd18dc112902..b13b94de9a01 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -360,3 +360,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
 440	common	watch_mount			sys_watch_mount
+441	common	watch_sb			sys_watch_sb
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index de5c7303899f..4a163d0200b2 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 # 435 reserved for clone3
 439	common	fsinfo				sys_fsinfo
 440	common	watch_mount			sys_watch_mount
+441	common	watch_sb			sys_watch_sb
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 7387a44767c3..b0fed3b73462 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -445,3 +445,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
 440	common	watch_mount			sys_watch_mount
+441	common	watch_sb			sys_watch_sb
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index e2c76157a580..8a33cc08ed39 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -378,3 +378,4 @@
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	fsinfo				sys_fsinfo
 440	n32	watch_mount			sys_watch_mount
+441	n32	watch_sb			sys_watch_sb
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index e5da9a13b074..8a11d81717d3 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -354,3 +354,4 @@
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	fsinfo				sys_fsinfo
 440	n64	watch_mount			sys_watch_mount
+441	n64	watch_sb			sys_watch_sb
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index fe135759d2a8..76787af4a8f2 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -427,3 +427,4 @@
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	fsinfo				sys_fsinfo
 440	o32	watch_mount			sys_watch_mount
+441	o32	watch_sb			sys_watch_sb
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 5ac7a58af305..1c35cf2c0938 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -437,3 +437,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
 440	common	watch_mount			sys_watch_mount
+441	common	watch_sb			sys_watch_sb
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index c77a1cf377ec..c5ea6f8e95b6 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -521,3 +521,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
 440	common	watch_mount			sys_watch_mount
+441	common	watch_sb			sys_watch_sb
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index d81d30d02aaf..4577426e09f5 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -442,3 +442,4 @@
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	fsinfo			sys_fsinfo			sys_fsinfo
 440	common	watch_mount		sys_watch_mount			sys_watch_mount
+441	common	watch_sb		sys_watch_sb			sys_watch_sb
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index dcdc747fa430..e57c03fd5ba3 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -442,3 +442,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
 440	common	watch_mount			sys_watch_mount
+441	common	watch_sb			sys_watch_sb
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index b4f82e5a08bf..1b2b19873319 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -485,3 +485,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
 440	common	watch_mount			sys_watch_mount
+441	common	watch_sb			sys_watch_sb
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 07572644779d..8b3a00860524 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -444,3 +444,4 @@
 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
 439	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
 440	i386	watch_mount		sys_watch_mount			__ia32_sys_watch_mount
+441	i386	watch_sb		sys_watch_sb			__ia32_sys_watch_sb
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1b51791fe104..8522ff13308c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -361,6 +361,7 @@
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 439	common	fsinfo			__x64_sys_fsinfo
 440	common	watch_mount		__x64_sys_watch_mount
+441	common	watch_sb		__x64_sys_watch_sb
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index dfcdd3036d3e..70f0292ed37a 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -410,3 +410,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
 440	common	watch_mount			sys_watch_mount
+441	common	watch_sb			sys_watch_sb
diff --git a/fs/Kconfig b/fs/Kconfig
index 76224bc015cb..01d0d436b3cd 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -133,6 +133,18 @@ config MOUNT_NOTIFICATIONS
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
index a63073e6127e..ec16e6f88c16 100644
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
 
@@ -354,6 +356,10 @@ void deactivate_locked_super(struct super_block *s)
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
@@ -993,6 +999,8 @@ int reconfigure_super(struct fs_context *fc)
 	/* Needs to be ordered wrt mnt_is_readonly() */
 	smp_wmb();
 	sb->s_readonly_remount = 0;
+	notify_sb(sb, NOTIFY_SUPERBLOCK_READONLY,
+		  remount_ro ? NOTIFY_SUPERBLOCK_IS_NOW_RO : 0);
 
 	/*
 	 * Some filesystems modify their metadata via some other path than the
@@ -1891,3 +1899,120 @@ int thaw_super(struct super_block *sb)
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
index e5db22d536a3..423a6f03cdf8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -40,6 +40,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/watch_queue.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1553,6 +1554,10 @@ struct super_block {
 
 	/* Superblock event notifications */
 	u64			s_unique_id;
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+	struct watch_list	*s_watchers;
+#endif
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
@@ -3659,4 +3664,76 @@ static inline int inode_drain_writes(struct inode *inode)
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
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
index 1687e064751d..af66fe97a586 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1009,6 +1009,8 @@ asmlinkage long sys_fsinfo(int dfd, const char __user *pathname,
 			   void __user *buffer, size_t buf_size);
 asmlinkage long sys_watch_mount(int dfd, const char __user *path,
 				unsigned int at_flags, int watch_fd, int watch_id);
+asmlinkage long sys_watch_sb(int dfd, const char __user *path,
+			     unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index d6b6c45ad31a..882c0fae4f37 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -859,9 +859,11 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_fsinfo, sys_fsinfo)
 #define __NR_watch_mount 440
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
+#define __NR_watch_sb 441
+__SYSCALL(__NR_watch_sb, sys_watch_sb)
 
 #undef __NR_syscalls
-#define __NR_syscalls 441
+#define __NR_syscalls 442
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index b0f35cf51394..190d27073302 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -15,7 +15,8 @@ enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
 	WATCH_TYPE_KEY_NOTIFY	= 1,	/* Key change event notification */
 	WATCH_TYPE_MOUNT_NOTIFY	= 2,	/* Mount topology change notification */
-	WATCH_TYPE___NR		= 3
+	WATCH_TYPE_SB_NOTIFY	= 3,	/* Superblock event notification */
+	WATCH_TYPE___NR		= 4
 };
 
 enum watch_meta_notification_subtype {
@@ -131,4 +132,32 @@ struct mount_notification {
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
index 1a1eb7b61914..bc2e6885ef2d 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -53,6 +53,7 @@ COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
 COND_SYSCALL(fsinfo);
 COND_SYSCALL(watch_mount);
+COND_SYSCALL(watch_sb);
 
 /* fs/xattr.c */
 


