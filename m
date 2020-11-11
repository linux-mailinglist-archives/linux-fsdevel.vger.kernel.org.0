Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E913F2AFACE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 22:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgKKVw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 16:52:58 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49830 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgKKVw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:52:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 6716E1F45DC8
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     dhowells@redhat.com
Cc:     viro@zeniv.linux.org.uk, tytso@mit.edu, khazhy@google.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC v2 8/8] samples: watch_queue: Add sample of SB notifications
Date:   Wed, 11 Nov 2020 16:52:13 -0500
Message-Id: <20201111215213.4152354-9-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111215213.4152354-1-krisman@collabora.com>
References: <20201111215213.4152354-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This sample demonstrates how to use the watch_sb syscall.  It exposes
notifications like the following:

  root@host:~# ./watch_sb /mnt
  read() = 93
  NOTIFY[000]: ty=000002 sy=01 i=0300005d
    SB AT ext4_remount:5636 ERROR: 16 inode=0 block=0
    description: Abort forced by user
  read() = 96
  NOTIFY[000]: ty=000002 sy=01 i=03000060
    SB AT ext4_lookup:1706 ERROR: 0 inode=13 block=0
    description: iget: bogus i_mode (45)

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 samples/watch_queue/Makefile   |   2 +-
 samples/watch_queue/watch_sb.c | 114 +++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)
 create mode 100644 samples/watch_queue/watch_sb.c

diff --git a/samples/watch_queue/Makefile b/samples/watch_queue/Makefile
index c0db3a6bc524..6067d57a5bb1 100644
--- a/samples/watch_queue/Makefile
+++ b/samples/watch_queue/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-userprogs-always-y += watch_test
+userprogs-always-y += watch_test watch_sb
 
 userccflags += -I usr/include
diff --git a/samples/watch_queue/watch_sb.c b/samples/watch_queue/watch_sb.c
new file mode 100644
index 000000000000..51b660334f6b
--- /dev/null
+++ b/samples/watch_queue/watch_sb.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Use watch_sb to watch for SB notifications.
+ *
+ * Copyright (C) 2020 Collabora Ltd.
+ * Written by Gabriel Krisman Bertazi <krisman@collabora.com>
+ *   Based on watch_test.c by David Howells (dhowells@redhat.com)
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <err.h>
+#include <string.h>
+#include<sys/ioctl.h>
+#include <linux/watch_queue.h>
+
+#ifndef __NR_watch_sb
+# define __NR_watch_sb 441
+#endif
+
+static void consumer(int fd)
+{
+	unsigned char buffer[433], *p, *end;
+	union {
+		struct watch_notification n;
+		unsigned char buf1[128];
+		struct superblock_error_notification sen;
+		struct superblock_warning_notification swn;
+		struct superblock_msg_notification smn;
+	} n;
+	ssize_t buf_len;
+
+	for (;;) {
+		buf_len = read(fd, buffer, sizeof(buffer));
+		if (buf_len == -1)
+			err(1, "read");
+
+		if (buf_len == 0) {
+			printf("-- END --\n");
+			return;
+		}
+
+		if (buf_len > sizeof(buffer)) {
+			err(1, "Read buffer overrun: %zd\n", buf_len);
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
+			if (largest < sizeof(struct watch_notification))
+				err(1, "Short message header: %zu\n", largest);
+
+			memcpy(&n, p, largest);
+
+			printf("NOTIFY[%03zx]: ty=%06x sy=%02x i=%08x\n",
+			       p - buffer, n.n.type, n.n.subtype, n.n.info);
+
+			len = n.n.info & WATCH_INFO_LENGTH;
+			if (len < sizeof(n.n) || len > largest)
+				err(1, "Bad message length: %zu/%zu\n", len, largest);
+
+			switch (n.n.subtype) {
+			case NOTIFY_SUPERBLOCK_ERROR:
+				printf("\t SB AT %s:%d ERROR: %d inode=%llu block=%llu\n",
+				       n.sen.function, n.sen.line, n.sen.error_number,
+				       n.sen.inode, n.sen.block);
+				if (len > sizeof(n.sen))
+					printf("description: %s\n", n.sen.desc);
+				break;
+			case NOTIFY_SUPERBLOCK_MSG:
+				printf("\t Ext4 MSG: %s\n", n.smn.desc);
+				break;
+			case NOTIFY_SUPERBLOCK_WARNING:
+				printf("\t SB AT %s:%d WARNING inode=%llu block=%llu\n",
+				       n.swn.function, n.swn.line, n.swn.inode, n.swn.block);
+				if (len > sizeof(n.sen))
+					printf("description: %s\n", n.swn.desc);
+				break;
+			default:
+				printf("unknown subtype %c\n", n.n.subtype);
+			}
+			p += len;
+		}
+	}
+}
+
+int main (int argc, char **argv)
+{
+	int fd[2];
+
+	if (argc != 2)
+		errx(1, "Missing mount point\n");
+
+	if (syscall(293, fd, O_NOTIFICATION_PIPE) < 0)
+		err(1, "Failed to open pipe\n");
+
+	if (ioctl(fd[0], IOC_WATCH_QUEUE_SET_SIZE, 256) < 0)
+		err(1, "ioctl fail\n");
+
+	if (syscall(__NR_watch_sb, 0, argv[1], NULL, fd[0], 0x3) < 0)
+		err(1, "Failed to watch SB\n");
+
+	consumer(fd[0]);
+
+	return 0;
+}
-- 
2.29.2

