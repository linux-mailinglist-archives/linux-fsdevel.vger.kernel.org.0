Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C304D82D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 23:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbfJOVt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 17:49:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbfJOVt6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:49:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D8BC7FDF6;
        Tue, 15 Oct 2019 21:49:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-84.rdu2.redhat.com [10.10.121.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 56A7D6012E;
        Tue, 15 Oct 2019 21:49:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 14/21] Add sample notification program
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>, dhowells@redhat.com,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 15 Oct 2019 22:49:53 +0100
Message-ID: <157117619360.15019.2166885167840076061.stgit@warthog.procyon.org.uk>
In-Reply-To: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
References: <157117606853.15019.15459271147790470307.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 15 Oct 2019 21:49:57 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sample program is run like:

	./samples/watch_queue/watch_test

and watches "/" for mount changes and the current session keyring for key
changes:

	# keyctl add user a a @s
	1035096409
	# keyctl unlink 1035096409 @s

producing:

	# ./watch_test
	read() = 16
	NOTIFY[000]: ty=000001 sy=02 i=00000110
	KEY 2ffc2e5d change=2[linked] aux=1035096409
	read() = 16
	NOTIFY[000]: ty=000001 sy=02 i=00000110
	KEY 2ffc2e5d change=3[unlinked] aux=1035096409

Other events may be produced, such as with a failing disk:

	read() = 22
	NOTIFY[000]: ty=000003 sy=02 i=00000416
	USB 3-7.7 dev-reset e=0 r=0
	read() = 24
	NOTIFY[000]: ty=000002 sy=06 i=00000418
	BLOCK 00800050 e=6[critical medium] s=64000ef8

This corresponds to:

	blk_update_request: critical medium error, dev sdf, sector 1677725432 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0

in dmesg.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/Kconfig                  |    7 +
 samples/Makefile                 |    1 
 samples/watch_queue/Makefile     |    7 +
 samples/watch_queue/watch_test.c |  184 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

diff --git a/samples/Kconfig b/samples/Kconfig
index c8dacb4dda80..d0761f29ccb0 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -169,4 +169,11 @@ config SAMPLE_VFS
 	  as mount API and statx().  Note that this is restricted to the x86
 	  arch whilst it accesses system calls that aren't yet in all arches.
 
+config SAMPLE_WATCH_QUEUE
+	bool "Build example /dev/watch_queue notification consumer"
+	depends on HEADERS_INSTALL
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
index 000000000000..eec00dd0a8df
--- /dev/null
+++ b/samples/watch_queue/Makefile
@@ -0,0 +1,7 @@
+# List of programs to build
+hostprogs-y := watch_test
+
+# Tell kbuild to always build the programs
+always := $(hostprogs-y)
+
+HOSTCFLAGS_watch_test.o += -I$(objtree)/usr/include
diff --git a/samples/watch_queue/watch_test.c b/samples/watch_queue/watch_test.c
new file mode 100644
index 000000000000..19b82e9b0853
--- /dev/null
+++ b/samples/watch_queue/watch_test.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Use /dev/watch_queue to watch for notifications.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define _GNU_SOURCE
+#include <stdbool.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <sys/ioctl.h>
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
+#define BUF_SIZE 256
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
+static void saw_key_change(struct watch_notification *n, size_t len)
+{
+	struct key_notification *k = (struct key_notification *)n;
+
+	if (len != sizeof(struct key_notification)) {
+		fprintf(stderr, "Incorrect key message length\n");
+		return;
+	}
+
+	printf("KEY %08x change=%u[%s] aux=%u\n",
+	       k->key_id, n->subtype, key_subtypes[n->subtype], k->aux);
+}
+
+/*
+ * Consume and display events.
+ */
+static void consumer(int fd)
+{
+	unsigned char buffer[4096], *p, *end;
+	union {
+		struct watch_notification n;
+		unsigned char buf1[128];
+	} n;
+	ssize_t buf_len;
+
+	for (;;) {
+		buf_len = read(fd, buffer, sizeof(buffer));
+		if (buf_len == -1) {
+			perror("read");
+			exit(1);
+		}
+
+		if (buf_len == 0) {
+			printf("-- END --\n");
+			return;
+		}
+
+		if (buf_len > sizeof(buffer)) {
+			fprintf(stderr, "Read buffer overrun: %zd\n", buf_len);
+			return;
+		}
+
+		printf("read() = %zd\n", buf_len);
+
+		p = buffer;
+		end = buffer + buf_len;
+		while (p < end) {
+			size_t largest, len;
+
+			largest = end - p;
+			if (largest > 128)
+				largest = 128;
+			if (largest < sizeof(struct watch_notification)) {
+				fprintf(stderr, "Short message header: %zu\n", largest);
+				return;
+			}
+			memcpy(&n, p, largest);
+
+			printf("NOTIFY[%03zx]: ty=%06x sy=%02x i=%08x\n",
+			       p - buffer, n.n.type, n.n.subtype, n.n.info);
+
+			len = n.n.info & WATCH_INFO_LENGTH;
+			if (len < sizeof(n.n) || len > largest) {
+				fprintf(stderr, "Bad message length: %zu/%zu\n", len, largest);
+				exit(1);
+			}
+
+			switch (n.n.type) {
+			case WATCH_TYPE_META:
+				switch (n.n.subtype) {
+				case WATCH_META_REMOVAL_NOTIFICATION:
+					printf("REMOVAL of watchpoint %08x\n",
+					       (n.n.info & WATCH_INFO_ID) >>
+					       WATCH_INFO_ID__SHIFT);
+					break;
+				default:
+					printf("other meta record\n");
+					break;
+				}
+				break;
+			case WATCH_TYPE_KEY_NOTIFY:
+				saw_key_change(&n.n, len);
+				break;
+			default:
+				printf("other type\n");
+				break;
+			}
+
+			p += len;
+		}
+	}
+}
+
+static struct watch_notification_filter filter = {
+	.nr_filters	= 1,
+	.filters = {
+		[0]	= {
+			.type			= WATCH_TYPE_KEY_NOTIFY,
+			.subtype_filter[0]	= UINT_MAX,
+		},
+	},
+};
+
+int main(int argc, char **argv)
+{
+	int pipefd[2], fd;
+
+	if (pipe2(pipefd, O_TMPFILE) == -1) {
+		perror("pipe2");
+		exit(1);
+	}
+	fd = pipefd[0];
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
+	if (keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01) == -1) {
+		perror("keyctl");
+		exit(1);
+	}
+
+	if (keyctl_watch_key(KEY_SPEC_USER_KEYRING, fd, 0x02) == -1) {
+		perror("keyctl");
+		exit(1);
+	}
+
+	consumer(fd);
+	exit(0);
+}

