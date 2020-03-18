Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5B4189EF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCRPFw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:05:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59495 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727406AbgCRPFv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/SilXb6CQ3i8Ff2XrQR3oUaOBbw8dRnTTRnqUrI8S4=;
        b=emaXI1V49MbP5gyiW1NO0s43N0YguroFXc8QgcnJbIzQ8aOM/vS2W0I4fSu+JZifGRV7kO
        xCKVuhxvU84Xp8PueA5HWJHNSmOAP9n1Lh2kFtIvCD35CQWSZdwTO+Pz71RNZcXvtnpDHJ
        5ZjJ4/lqjjYEk1RMeJ6IZNWCDWqByDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-oFY5Z0U1PaGCiTh8qVYxqg-1; Wed, 18 Mar 2020 11:05:45 -0400
X-MC-Unique: oFY5Z0U1PaGCiTh8qVYxqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D481F18FF663;
        Wed, 18 Mar 2020 15:05:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D83EE5D9E2;
        Wed, 18 Mar 2020 15:05:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 16/17] watch_queue: Add superblock notifications [ver #5]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, casey@schaufler-ca.com, sds@tycho.nsa.gov,
        nicolas.dichtel@6wind.com, raven@themaw.net, christian@brauner.io,
        andres@anarazel.de, jlayton@redhat.com, dray@redhat.com,
        kzak@redhat.com, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:05:40 +0000
Message-ID: <158454394013.2863966.17628947547369936858.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a superblock event notification facility whereby notifications about
superblock events, such as I/O errors (EIO), quota limits being hit
(EDQUOT) and running out of space (ENOSPC) can be reported to a monitoring
process asynchronously.  Note that this does not cover vfsmount topology
changes.  watch_mount() is used for that.

Firstly, a watch queue needs to be created:

	pipe2(fds, O_NOTIFICATION_PIPE);
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);

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
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
	watch_sb(AT_FDCWD, "/home/dhowells", 0, fds[1], 0x03);

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

 Documentation/watch_queue.rst               |   12 ++
 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/arm64/include/asm/unistd.h             |    2 
 arch/arm64/include/asm/unistd32.h           |    2 
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
 fs/Kconfig                                  |   12 ++
 fs/super.c                                  |  181 +++++++++++++++++++++++++++
 include/linux/fs.h                          |   59 +++++++++
 include/linux/syscalls.h                    |    2 
 include/uapi/asm-generic/unistd.h           |    4 -
 include/uapi/linux/watch_queue.h            |   31 ++++-
 kernel/sys_ni.c                             |    3 
 26 files changed, 321 insertions(+), 3 deletions(-)

diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
index 3e647992be31..81d9d322b1c8 100644
--- a/Documentation/watch_queue.rst
+++ b/Documentation/watch_queue.rst
@@ -10,6 +10,8 @@ opened by userspace.  This can be used in conjunction with::
 
   * Mount notifications.
 
+  * Superblock notifications.
+
 The notifications buffers can be enabled by:
 
 	"General setup"/"General notification queue"
@@ -239,6 +241,12 @@ Any particular buffer can be fed from multiple sources.  Sources include:
     Notifications of this type indicate changes to mount attributes and the
     mount topology within the subtree at the indicated point.
 
+  * WATCH_TYPE_SB_NOTIFY
+
+    Notifications of this type indicate changes to superblock attributes and
+    configuration and events generated within a superblock such as I/O errors,
+    network status changes and out-of-space/out-of-quota errors.
+
 
 Event Filtering
 ===============
@@ -302,6 +310,7 @@ It can then be set to receive notifications::
 
 	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fds[1], 0x01);
 	watch_mount(AT_FDCWD, "/", 0, fds[1], 0x02);
+	watch_sb(AT_FDCWD, "/", 0, fds[1], 0x03);
 
 The notifications can then be consumed by something like the following::
 
@@ -341,6 +350,9 @@ The notifications can then be consumed by something like the following::
 				case WATCH_TYPE_MOUNT_NOTIFY:
 					saw_mount_change(&n.n);
 					break;
+				case WATCH_TYPE_SB_NOTIFY:
+					saw_sb_event(&n.n);
+					break;
 				}
 
 				p += len;
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index b869428033ef..7c0115af9010 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -478,3 +478,4 @@
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	watch_mount			sys_watch_mount
+550	common	watch_sb			sys_watch_sb
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 9c389da9efcc..f256f009a89f 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -452,3 +452,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
+440	common	watch_sb			sys_watch_sb
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 75f04a1023be..bc0f923e0e04 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		440
+#define __NR_compat_syscalls		441
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 774f0339763f..5ba3dae4859b 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -885,6 +885,8 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_watch_mount 439
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
+#define __NR_watch_sb 440
+__SYSCALL(__NR_watch_sb, sys_watch_sb)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 6817f865cc71..a4dafc659647 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -359,3 +359,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
+440	common	watch_sb			sys_watch_sb
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index fbf85da75ecb..893fb4151547 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
+440	common	watch_sb			sys_watch_sb
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index b05b192da1e2..54aaf0d40c64 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
+440	common	watch_sb			sys_watch_sb
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 0f85d2a033f9..fd34dd0efed0 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -377,3 +377,4 @@
 437	n32	openat2				sys_openat2
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	watch_mount			sys_watch_mount
+440	n32	watch_sb			sys_watch_sb
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 905cf9ac0792..db0f4c0a0a0b 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -353,3 +353,4 @@
 437	n64	openat2				sys_openat2
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	watch_mount			sys_watch_mount
+440	n64	watch_sb			sys_watch_sb
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 834b26b08d74..ce2e1326de8f 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -426,3 +426,4 @@
 437	o32	openat2				sys_openat2
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	watch_mount			sys_watch_mount
+440	o32	watch_sb			sys_watch_sb
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index badd3449db43..6e4a7c08b64b 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
+440	common	watch_sb			sys_watch_sb
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index b404361bc929..08943f3b8206 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -520,3 +520,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
+440	common	watch_sb			sys_watch_sb
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 33071de24511..b3b8529d2b74 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 437  common	openat2			sys_openat2			sys_openat2
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount		sys_watch_mount			sys_watch_mount
+440	common	watch_sb		sys_watch_sb			sys_watch_sb
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 682c125122f4..89307a20657c 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
+440	common	watch_sb			sys_watch_sb
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index febf3cd675e3..4ff841a00450 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -484,3 +484,4 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
+440	common	watch_sb			sys_watch_sb
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 085bcc5afdf1..e2731d295f88 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -443,3 +443,4 @@
 437	i386	openat2			sys_openat2			__ia32_sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
 439	i386	watch_mount		sys_watch_mount			__ia32_sys_watch_mount
+440	i386	watch_sb		sys_watch_sb			__ia32_sys_watch_sb
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 9cfb6b2eb319..f4391176102c 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -360,6 +360,7 @@
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 439	common	watch_mount		__x64_sys_watch_mount
+440	common	watch_sb		__x64_sys_watch_sb
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 1a066a43a58b..8e7d731ed6cf 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -409,3 +409,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	watch_mount			sys_watch_mount
+440	common	watch_sb			sys_watch_sb
diff --git a/fs/Kconfig b/fs/Kconfig
index d7039137d538..fef1365c23a5 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -126,6 +126,18 @@ config MOUNT_NOTIFICATIONS
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
index ececa5695fd1..0646ed54237f 100644
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
 
@@ -333,6 +335,10 @@ void deactivate_locked_super(struct super_block *s)
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
@@ -972,6 +978,8 @@ int reconfigure_super(struct fs_context *fc)
 	/* Needs to be ordered wrt mnt_is_readonly() */
 	smp_wmb();
 	sb->s_readonly_remount = 0;
+	notify_sb(sb, NOTIFY_SUPERBLOCK_READONLY,
+		  remount_ro ? NOTIFY_SUPERBLOCK_IS_NOW_RO : 0);
 
 	/*
 	 * Some filesystems modify their metadata via some other path than the
@@ -1891,3 +1899,176 @@ void vfs_generate_unique_id(u64 *_id)
 
 	*_id = id;
 }
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+/*
+ * Post superblock notifications.
+ */
+static void post_sb_notification(struct super_block *s, struct superblock_notification *n)
+{
+	post_watch_notification(s->s_watchers, &n->watch, current_cred(),
+				s->s_unique_id);
+}
+
+/*
+ * Post simple superblock notification.
+ */
+void __notify_sb(struct super_block *s,
+		 enum superblock_notification_type subtype,
+		 u32 info)
+{
+	struct superblock_notification n = {
+		.watch.type	= WATCH_TYPE_SB_NOTIFY,
+		.watch.subtype	= subtype,
+		.watch.info	= watch_sizeof(n) | info,
+		.sb_id		= s->s_unique_id,
+	};
+
+	post_sb_notification(s, &n);
+}
+
+/*
+ * Post superblock error notification.
+ */
+void __notify_sb_error(struct super_block *s, int error)
+{
+	struct superblock_error_notification n = {
+		.s.watch.type	= WATCH_TYPE_SB_NOTIFY,
+		.s.watch.subtype = NOTIFY_SUPERBLOCK_ERROR,
+		.s.watch.info	= watch_sizeof(n),
+		.s.sb_id	= s->s_unique_id,
+		.error_number	= error,
+		.error_cookie	= 0,
+	};
+
+	post_sb_notification(s, &n.s);
+}
+
+/*
+ * Post superblock quota overrun notification.
+ */
+void __notify_sb_EQDUOT(struct super_block *s)
+{
+	struct superblock_notification n = {
+		.watch.type	= WATCH_TYPE_SB_NOTIFY,
+		.watch.subtype	= NOTIFY_SUPERBLOCK_EDQUOT,
+		.watch.info	= watch_sizeof(n),
+		.sb_id		= s->s_unique_id,
+	};
+
+	post_sb_notification(s, &n);
+}
+
+static void sb_release_watch(struct watch *watch)
+{
+	put_super(watch->private);
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
+	bool drop_s_count = false;
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
+		if (!READ_ONCE(s->s_watchers)) {
+			wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
+			if (!wlist)
+				goto err_wqueue;
+			init_watch_list(wlist, sb_release_watch);
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
+			spin_lock(&sb_lock);
+			s->s_count++;
+			spin_unlock(&sb_lock);
+			ret = add_watch_to_object(watch, s->s_watchers);
+			if (ret == 0)
+				watch = NULL; /* It worked */
+			else
+				drop_s_count = true;
+		}
+		up_write(&s->s_umount);
+		if (drop_s_count)
+			put_super(s);
+	} else {
+		ret = -EBADSLT;
+		down_write(&s->s_umount);
+		ret = remove_watch_from_object(s->s_watchers, wqueue,
+					       s->s_unique_id, false);
+		up_write(&s->s_umount);
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
index 9de6bfe41016..b8d639540dc2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -40,6 +40,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/watch_queue.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1551,6 +1552,12 @@ struct super_block {
 
 	/* Superblock event notifications */
 	u64			s_unique_id;
+
+#ifdef CONFIG_SB_NOTIFICATIONS
+	struct watch_list	*s_watchers;
+#endif
+	atomic_t		s_change_counter;	/* Count of config change notifications */
+	atomic_t		s_notify_counter;	/* Count of other notifications */
 } __randomize_layout;
 
 /* Helper functions so that in most cases filesystems will
@@ -3654,4 +3661,56 @@ static inline int inode_drain_writes(struct inode *inode)
 	return filemap_write_and_wait(inode->i_mapping);
 }
 
+extern void __notify_sb(struct super_block *s,
+			enum superblock_notification_type subtype,
+			u32 info);
+extern void __notify_sb_error(struct super_block *s, int error);
+extern void __notify_sb_EQDUOT(struct super_block *s);
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
+	atomic_inc(&s->s_change_counter);
+	if (unlikely(READ_ONCE(s->s_watchers)))
+		__notify_sb(s, subtype, info);
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
+	atomic_inc(&s->s_notify_counter);
+	if (unlikely(READ_ONCE(s->s_watchers)))
+		__notify_sb_error(s, error);
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
+	atomic_inc(&s->s_notify_counter);
+	if (unlikely(READ_ONCE(s->s_watchers)))
+		__notify_sb_EQDUOT(s);
+#endif
+	return -EDQUOT;
+}
+
 #endif /* _LINUX_FS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1fd43af3b22d..c84440d57f52 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1005,6 +1005,8 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
 asmlinkage long sys_watch_mount(int dfd, const char __user *path,
 				unsigned int at_flags, int watch_fd, int watch_id);
+asmlinkage long sys_watch_sb(int dfd, const char __user *path,
+			     unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 6b5748287883..5bff318b7ffa 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -857,9 +857,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_watch_mount 439
 __SYSCALL(__NR_watch_mount, sys_watch_mount)
+#define __NR_watch_sb 440
+__SYSCALL(__NR_watch_sb, sys_watch_sb)
 
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index 6b6cd2afc590..9edb1bf15bcb 100644
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
@@ -135,4 +136,32 @@ struct mount_notification {
 	__u32	__padding;
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
+	__u64	sb_id;			/* 64-bit superblock ID */
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
index 3e1c5c9d2efe..0ce01f86e5db 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -119,6 +119,9 @@ COND_SYSCALL_COMPAT(signalfd4);
 
 /* fs/sync.c */
 
+/* fs/super.c */
+COND_SYSCALL(watch_sb);
+
 /* fs/timerfd.c */
 COND_SYSCALL(timerfd_create);
 COND_SYSCALL(timerfd_settime);


