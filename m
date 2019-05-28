Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208902CB09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 18:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfE1QC4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 12:02:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14825 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfE1QCz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 12:02:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD208C07F673;
        Tue, 28 May 2019 16:02:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C9555D9C5;
        Tue, 28 May 2019 16:02:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 7/7] Add sample notification program
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 May 2019 17:02:50 +0100
Message-ID: <155905937049.7587.16487253555712551165.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 28 May 2019 16:02:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This needs to be linked with -lkeyutils.

It is run like:

	./watch_test

and watches "/" for mount changes and the current session keyring for key
changes:

	# keyctl add user a a @s
	1035096409
	# keyctl unlink 1035096409 @s
	# mount -t tmpfs none /mnt/nfsv3tcp/
	# umount /mnt/nfsv3tcp

producing:

	# ./watch_test
	ptrs h=4 t=2 m=20003
	NOTIFY[00000004-00000002] ty=0003 sy=0002 i=01000010
	KEY 2ffc2e5d change=2[linked] aux=1035096409
	ptrs h=6 t=4 m=20003
	NOTIFY[00000006-00000004] ty=0003 sy=0003 i=01000010
	KEY 2ffc2e5d change=3[unlinked] aux=1035096409
	ptrs h=8 t=6 m=20003
	NOTIFY[00000008-00000006] ty=0001 sy=0000 i=02000010
	MOUNT 00000013 change=0[new_mount] aux=168
	ptrs h=a t=8 m=20003
	NOTIFY[0000000a-00000008] ty=0001 sy=0001 i=02000010
	MOUNT 00000013 change=1[unmount] aux=168

Other events may be produced, such as with a failing disk:

	ptrs h=5 t=2 m=6000004
	NOTIFY[00000005-00000002] ty=0004 sy=0006 i=04000018
	BLOCK 00800050 e=6[critical medium] s=5be8

This corresponds to:

	print_req_error: critical medium error, dev sdf, sector 23528 flags 0

in dmesg.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/Kconfig                  |    6 +
 samples/Makefile                 |    1 
 samples/watch_queue/Makefile     |    9 +
 samples/watch_queue/watch_test.c |  284 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 300 insertions(+)
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 0561a94f6fdb..a2b7a7babee5 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -160,4 +160,10 @@ config SAMPLE_VFS
 	  as mount API and statx().  Note that this is restricted to the x86
 	  arch whilst it accesses system calls that aren't yet in all arches.
 
+config SAMPLE_WATCH_QUEUE
+	bool "Build example /dev/watch_queue notification consumer"
+	help
+	  Build example userspace program to use the new mount_notify(),
+	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index debf8925f06f..ed3b8bab6e9b 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
+subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
new file mode 100644
index 000000000000..42b694430d0f
--- /dev/null
+++ b/samples/watch_queue/Makefile
@@ -0,0 +1,9 @@
+# List of programs to build
+hostprogs-y := watch_test
+
+# Tell kbuild to always build the programs
+always := $(hostprogs-y)
+
+HOSTCFLAGS_watch_test.o += -I$(objtree)/usr/include
+
+HOSTLOADLIBES_watch_test += -lkeyutils
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
new file mode 100644
index 000000000000..0bbab492e237
--- /dev/null
+++ b/samples/watch_queue/watch_test.c
@@ -0,0 +1,284 @@
+/* Use /dev/watch_queue to watch for keyring and mount topology changes.
+ *
+ * Copyright (C) 2018 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public Licence
+ * as published by the Free Software Foundation; either version
+ * 2 of the Licence, or (at your option) any later version.
+ */
+
+#include <stdbool.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <errno.h>
+#include <sys/wait.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <poll.h>
+#include <limits.h>
+#include <linux/watch_queue.h>
+#include <linux/unistd.h>
+#include <linux/keyctl.h>
+
+#ifndef __NR_mount_notify
+#define __NR_mount_notify -1
+#endif
+#ifndef __NR_sb_notify
+#define __NR_sb_notify -1
+#endif
+#ifndef __NR_block_notify
+#define __NR_block_notify -1
+#endif
+#ifndef KEYCTL_WATCH_KEY
+#define KEYCTL_WATCH_KEY -1
+#endif
+
+#define BUF_SIZE 4
+
+static const char *key_subtypes[256] = {
+	[NOTIFY_KEY_INSTANTIATED]	= "instantiated",
+	[NOTIFY_KEY_UPDATED]		= "updated",
+	[NOTIFY_KEY_LINKED]		= "linked",
+	[NOTIFY_KEY_UNLINKED]		= "unlinked",
+	[NOTIFY_KEY_CLEARED]		= "cleared",
+	[NOTIFY_KEY_REVOKED]		= "revoked",
+	[NOTIFY_KEY_INVALIDATED]	= "invalidated",
+	[NOTIFY_KEY_SETATTR]		= "setattr",
+};
+
+static void saw_key_change(struct watch_notification *n)
+{
+	struct key_notification *k = (struct key_notification *)n;
+	unsigned int len = n->info & WATCH_INFO_LENGTH;
+
+	if (len != sizeof(struct key_notification))
+		return;
+
+	printf("KEY %08x change=%u[%s] aux=%u\n",
+	       k->key_id, n->subtype, key_subtypes[n->subtype], k->aux);
+}
+
+static const char *mount_subtypes[256] = {
+	[NOTIFY_MOUNT_NEW_MOUNT]	= "new_mount",
+	[NOTIFY_MOUNT_UNMOUNT]		= "unmount",
+	[NOTIFY_MOUNT_EXPIRY]		= "expiry",
+	[NOTIFY_MOUNT_READONLY]		= "readonly",
+	[NOTIFY_MOUNT_SETATTR]		= "setattr",
+	[NOTIFY_MOUNT_MOVE_FROM]	= "move_from",
+	[NOTIFY_MOUNT_MOVE_TO]		= "move_to",
+};
+
+static long keyctl_watch_key(int key, int watch_fd, int watch_id)
+{
+	return syscall(__NR_keyctl, KEYCTL_WATCH_KEY, key, watch_fd, watch_id);
+}
+
+static void saw_mount_change(struct watch_notification *n)
+{
+	struct mount_notification *m = (struct mount_notification *)n;
+	unsigned int len = n->info & WATCH_INFO_LENGTH;
+
+	if (len != sizeof(struct mount_notification))
+		return;
+
+	printf("MOUNT %08x change=%u[%s] aux=%u\n",
+	       m->triggered_on, n->subtype, mount_subtypes[n->subtype], m->changed_mount);
+}
+
+static const char *super_subtypes[256] = {
+	[NOTIFY_SUPERBLOCK_READONLY]	= "readonly",
+	[NOTIFY_SUPERBLOCK_ERROR]	= "error",
+	[NOTIFY_SUPERBLOCK_EDQUOT]	= "edquot",
+	[NOTIFY_SUPERBLOCK_NETWORK]	= "network",
+};
+
+static void saw_super_change(struct watch_notification *n)
+{
+	struct superblock_notification *s = (struct superblock_notification *)n;
+	unsigned int len = n->info & WATCH_INFO_LENGTH;
+
+	if (len < sizeof(struct superblock_notification))
+		return;
+
+	printf("SUPER %08llx change=%u[%s]\n",
+	       s->sb_id, n->subtype, super_subtypes[n->subtype]);
+}
+
+static const char *block_subtypes[256] = {
+	[NOTIFY_BLOCK_ERROR_TIMEOUT]			= "timeout",
+	[NOTIFY_BLOCK_ERROR_NO_SPACE]			= "critical space allocation",
+	[NOTIFY_BLOCK_ERROR_RECOVERABLE_TRANSPORT]	= "recoverable transport",
+	[NOTIFY_BLOCK_ERROR_CRITICAL_TARGET]		= "critical target",
+	[NOTIFY_BLOCK_ERROR_CRITICAL_NEXUS]		= "critical nexus",
+	[NOTIFY_BLOCK_ERROR_CRITICAL_MEDIUM]		= "critical medium",
+	[NOTIFY_BLOCK_ERROR_PROTECTION]			= "protection",
+	[NOTIFY_BLOCK_ERROR_KERNEL_RESOURCE]		= "kernel resource",
+	[NOTIFY_BLOCK_ERROR_DEVICE_RESOURCE]		= "device resource",
+	[NOTIFY_BLOCK_ERROR_IO]				= "I/O",
+};
+
+static void saw_block_change(struct watch_notification *n)
+{
+	struct block_notification *b = (struct block_notification *)n;
+	unsigned int len = n->info & WATCH_INFO_LENGTH;
+
+	if (len < sizeof(struct block_notification))
+		return;
+
+	printf("BLOCK %08llx e=%u[%s] s=%llx\n",
+	       (unsigned long long)b->dev,
+	       n->subtype, block_subtypes[n->subtype],
+	       (unsigned long long)b->sector);
+}
+
+/*
+ * Consume and display events.
+ */
+static int consumer(int fd, struct watch_queue_buffer *buf)
+{
+	struct watch_notification *n;
+	struct pollfd p[1];
+	unsigned int head, tail, mask = buf->meta.mask;
+
+	for (;;) {
+		p[0].fd = fd;
+		p[0].events = POLLIN | POLLERR;
+		p[0].revents = 0;
+
+		if (poll(p, 1, -1) == -1) {
+			perror("poll");
+			break;
+		}
+
+		printf("ptrs h=%x t=%x m=%x\n",
+		       buf->meta.head, buf->meta.tail, buf->meta.mask);
+
+		while (head = buf->meta.head,
+		       tail = buf->meta.tail,
+		       tail != head
+		       ) {
+			asm ("lfence" : : : "memory" );
+			n = &buf->slots[tail & mask];
+			printf("NOTIFY[%08x-%08x] ty=%04x sy=%04x i=%08x\n",
+			       head, tail, n->type, n->subtype, n->info);
+			if ((n->info & WATCH_INFO_LENGTH) == 0)
+				goto out;
+
+			switch (n->type) {
+			case WATCH_TYPE_META:
+				if (n->subtype == WATCH_META_REMOVAL_NOTIFICATION)
+					printf("REMOVAL of watchpoint %08x\n",
+					       n->info & WATCH_INFO_ID);
+				break;
+			case WATCH_TYPE_MOUNT_NOTIFY:
+				saw_mount_change(n);
+				break;
+			case WATCH_TYPE_SB_NOTIFY:
+				saw_super_change(n);
+				break;
+			case WATCH_TYPE_KEY_NOTIFY:
+				saw_key_change(n);
+				break;
+			case WATCH_TYPE_BLOCK_NOTIFY:
+				saw_block_change(n);
+				break;
+			}
+
+			tail += (n->info & WATCH_INFO_LENGTH) >> WATCH_LENGTH_SHIFT;
+			asm("mfence" ::: "memory");
+			buf->meta.tail = tail;
+		}
+	}
+
+out:
+	return 0;
+}
+
+static struct watch_notification_filter filter = {
+	.nr_filters	= 4,
+	.__reserved	= 0,
+	.filters = {
+		[0] = {
+			.type			= WATCH_TYPE_MOUNT_NOTIFY,
+			// Reject move-from notifications
+			.subtype_filter[0]	= UINT_MAX & ~(1 << NOTIFY_MOUNT_MOVE_FROM),
+		},
+		[1]	= {
+			.type			= WATCH_TYPE_SB_NOTIFY,
+			// Only accept notification of changes to R/O state
+			.subtype_filter[0]	= (1 << NOTIFY_SUPERBLOCK_READONLY),
+			// Only accept notifications of change-to-R/O
+			.info_mask		= WATCH_INFO_FLAG_0,
+			.info_filter		= WATCH_INFO_FLAG_0,
+		},
+		[2]	= {
+			.type			= WATCH_TYPE_KEY_NOTIFY,
+			.subtype_filter[0]	= UINT_MAX,
+		},
+		[3]	= {
+			.type			= WATCH_TYPE_BLOCK_NOTIFY,
+			.subtype_filter[0]	= UINT_MAX,
+		},
+	},
+};
+
+int main(int argc, char **argv)
+{
+	struct watch_queue_buffer *buf;
+	size_t page_size;
+	int fd;
+
+	fd = open("/dev/watch_queue", O_RDWR);
+	if (fd == -1) {
+		perror("/dev/watch_queue");
+		exit(1);
+	}
+
+	if (ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE) == -1) {
+		perror("/dev/watch_queue(size)");
+		exit(1);
+	}
+
+	if (ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter) == -1) {
+		perror("/dev/watch_queue(filter)");
+		exit(1);
+	}
+
+	page_size = sysconf(_SC_PAGESIZE);
+	buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, fd, 0);
+	if (buf == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	if (keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01) == -1) {
+		perror("keyctl");
+		exit(1);
+	}
+
+	if (syscall(__NR_mount_notify, AT_FDCWD, "/", 0, fd, 0x02) == -1) {
+		perror("mount_notify");
+		exit(1);
+	}
+
+	if (syscall(__NR_sb_notify, AT_FDCWD, "/mnt", 0, fd, 0x03) == -1) {
+		perror("sb_notify");
+		exit(1);
+	}
+
+	if (syscall(__NR_block_notify, fd, 0x04) == -1) {
+		perror("block_notify");
+		exit(1);
+	}
+
+	return consumer(fd, buf);
+}

