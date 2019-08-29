Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8AFCA2597
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfH2SbQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 14:31:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbfH2SbQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:31:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DDE7368CF;
        Thu, 29 Aug 2019 18:31:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-255.rdu2.redhat.com [10.10.120.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A56E160872;
        Thu, 29 Aug 2019 18:31:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/11] Add sample notification program [ver #6]
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
Date:   Thu, 29 Aug 2019 19:31:09 +0100
Message-ID: <156710346992.10009.11796541518423091336.stgit@warthog.procyon.org.uk>
In-Reply-To: <156710338860.10009.12524626894838499011.stgit@warthog.procyon.org.uk>
References: <156710338860.10009.12524626894838499011.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 29 Aug 2019 18:31:15 +0000 (UTC)
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

producing:

	# ./watch_test
	ptrs h=4 t=2 m=20003
	NOTIFY[00000004-00000002] ty=0003 sy=0002 i=01000010
	KEY 2ffc2e5d change=2[linked] aux=1035096409
	ptrs h=6 t=4 m=20003
	NOTIFY[00000006-00000004] ty=0003 sy=0003 i=01000010
	KEY 2ffc2e5d change=3[unlinked] aux=1035096409

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
 samples/watch_queue/Makefile     |    8 +
 samples/watch_queue/watch_test.c |  233 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 248 insertions(+)
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

diff --git a/samples/Kconfig b/samples/Kconfig
index c8dacb4dda80..2c3e07addd38 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -169,4 +169,10 @@ config SAMPLE_VFS
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
index 7d6e4ca28d69..a61a39047d02 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
 obj-y					+= vfio-mdev/
 subdir-$(CONFIG_SAMPLE_VFS)		+= vfs
+subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
new file mode 100644
index 000000000000..6ee61e3ca8d2
--- /dev/null
+++ b/samples/watch_queue/Makefile
@@ -0,0 +1,8 @@
+# List of programs to build
+hostprogs-y := watch_test
+
+# Tell kbuild to always build the programs
+always := $(hostprogs-y)
+
+HOSTCFLAGS_watch_test.o += -I$(objtree)/usr/include
+HOSTLDLIBS_watch_test += -lkeyutils
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
new file mode 100644
index 000000000000..6cd7101cb28c
--- /dev/null
+++ b/samples/watch_queue/watch_test.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Use /dev/watch_queue to watch for notifications.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
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
+#ifndef KEYCTL_WATCH_KEY
+#define KEYCTL_WATCH_KEY -1
+#endif
+#ifndef __NR_watch_devices
+#define __NR_watch_devices -1
+#endif
+
+#define BUF_SIZE 4
+
+static long keyctl_watch_key(int key, int watch_fd, int watch_id)
+{
+	return syscall(__NR_keyctl, KEYCTL_WATCH_KEY, key, watch_fd, watch_id);
+}
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
+	unsigned int len = (n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT;
+
+	if (len != sizeof(struct key_notification) / WATCH_LENGTH_GRANULARITY)
+		return;
+
+	printf("KEY %08x change=%u[%s] aux=%u\n",
+	       k->key_id, n->subtype, key_subtypes[n->subtype], k->aux);
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
+	unsigned int len = (n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT;
+
+	if (len < sizeof(struct block_notification) / WATCH_LENGTH_GRANULARITY)
+		return;
+
+	printf("BLOCK %08llx e=%u[%s] s=%llx\n",
+	       (unsigned long long)b->dev,
+	       n->subtype, block_subtypes[n->subtype],
+	       (unsigned long long)b->sector);
+}
+
+static const char *usb_subtypes[256] = {
+	[NOTIFY_USB_DEVICE_ADD]		= "dev-add",
+	[NOTIFY_USB_DEVICE_REMOVE]	= "dev-remove",
+	[NOTIFY_USB_BUS_ADD]		= "bus-add",
+	[NOTIFY_USB_BUS_REMOVE]		= "bus-remove",
+	[NOTIFY_USB_DEVICE_RESET]	= "dev-reset",
+	[NOTIFY_USB_DEVICE_ERROR]	= "dev-error",
+};
+
+static void saw_usb_event(struct watch_notification *n)
+{
+	struct usb_notification *u = (struct usb_notification *)n;
+	unsigned int len = (n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT;
+
+	if (len < sizeof(struct usb_notification) / WATCH_LENGTH_GRANULARITY)
+		return;
+
+	printf("USB %*.*s %s e=%x r=%x\n",
+	       u->name_len, u->name_len, u->name,
+	       usb_subtypes[n->subtype],
+	       u->error, u->reserved);
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
+		while (head = __atomic_load_n(&buf->meta.head, __ATOMIC_ACQUIRE),
+		       tail = buf->meta.tail,
+		       tail != head
+		       ) {
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
+					       (n->info & WATCH_INFO_ID) >>
+					       WATCH_INFO_ID__SHIFT);
+				break;
+			case WATCH_TYPE_KEY_NOTIFY:
+				saw_key_change(n);
+				break;
+			case WATCH_TYPE_BLOCK_NOTIFY:
+				saw_block_change(n);
+				break;
+			case WATCH_TYPE_USB_NOTIFY:
+				saw_usb_event(n);
+				break;
+			}
+
+			tail += (n->info & WATCH_INFO_LENGTH) >> WATCH_INFO_LENGTH__SHIFT;
+			__atomic_store_n(&buf->meta.tail, tail, __ATOMIC_RELEASE);
+		}
+	}
+
+out:
+	return 0;
+}
+
+static struct watch_notification_filter filter = {
+	.nr_filters	= 3,
+	.__reserved	= 0,
+	.filters = {
+		[0]	= {
+			.type			= WATCH_TYPE_KEY_NOTIFY,
+			.subtype_filter[0]	= UINT_MAX,
+		},
+		[1]	= {
+			.type			= WATCH_TYPE_BLOCK_NOTIFY,
+			.subtype_filter[0]	= UINT_MAX,
+		},
+		[2]	= {
+			.type			= WATCH_TYPE_USB_NOTIFY,
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
+	if (syscall(__NR_watch_devices, fd, 0x04, 0) == -1) {
+		perror("watch_devices");
+		exit(1);
+	}
+
+	return consumer(fd, buf);
+}

