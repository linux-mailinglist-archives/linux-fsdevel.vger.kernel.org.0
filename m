Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB636B946
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 20:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhDZSpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 14:45:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47610 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239508AbhDZSn7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:43:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A0D821F422D6
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com, tytso@mit.edu, djwong@kernel.org
Cc:     david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH RFC 14/15] samples: Add fs error monitoring example
Date:   Mon, 26 Apr 2021 14:42:00 -0400
Message-Id: <20210426184201.4177978-15-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426184201.4177978-1-krisman@collabora.com>
References: <20210426184201.4177978-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce an example of a FAN_ERROR fanotify user to track filesystem
errors.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 samples/Kconfig               |   7 ++
 samples/Makefile              |   1 +
 samples/fanotify/Makefile     |   3 +
 samples/fanotify/fs-monitor.c | 135 ++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

diff --git a/samples/Kconfig b/samples/Kconfig
index e76cdfc50e25..a2968338517f 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -120,6 +120,13 @@ config SAMPLE_CONNECTOR
 	  with it.
 	  See also Documentation/driver-api/connector.rst
 
+config SAMPLE_FANOTIFY_ERROR
+	bool "Build fanotify error monitoring sample"
+	depends on FANOTIFY
+	help
+	  When enabled, this builds an example code that uses the FAN_ERROR
+	  fanotify mechanism to monitor filesystem errors.
+
 config SAMPLE_HIDRAW
 	bool "hidraw sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index c3392a595e4b..93e2d64bc9a7 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -5,6 +5,7 @@ subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
 subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
 obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
+obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+= fanotify/
 subdir-$(CONFIG_SAMPLE_HIDRAW)		+= hidraw
 obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
 obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
diff --git a/samples/fanotify/Makefile b/samples/fanotify/Makefile
new file mode 100644
index 000000000000..b3d5cc826e6f
--- /dev/null
+++ b/samples/fanotify/Makefile
@@ -0,0 +1,3 @@
+userprogs-always-y += fs-monitor
+
+userccflags += -I usr/include
diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
new file mode 100644
index 000000000000..cdece8344c20
--- /dev/null
+++ b/samples/fanotify/fs-monitor.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021, Collabora Ltd.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <err.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/fanotify.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+
+#ifndef FAN_ERROR
+
+#define FAN_ERROR		0x00100000
+#define FAN_PREALLOC_QUEUE      0x00000080
+
+#define FAN_EVENT_INFO_TYPE_LOCATION	4
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+#define FAN_EVENT_INFO_TYPE_FSDATA	6
+
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	int version;
+	int error;
+	long long unsigned fsid;
+};
+
+struct fanotify_event_info_location {
+	struct fanotify_event_info_header hdr;
+	int line;
+	char function[0];
+};
+
+struct fanotify_event_info_fsdata {
+	struct fanotify_event_info_header hdr;
+	char data[0];
+};
+
+struct ext4_error_inode_report {
+	unsigned long long inode;
+	unsigned long long block;
+	char desc[40];
+};
+#endif
+
+static void handle_notifications(char *buffer, int len)
+{
+	struct fanotify_event_metadata *metadata;
+	struct fanotify_event_info_header *hdr = 0;
+	char *off, *next;
+
+	for (metadata = (struct fanotify_event_metadata *) buffer;
+	     FAN_EVENT_OK(metadata, len); metadata = FAN_EVENT_NEXT(metadata, len)) {
+		next = (char*)metadata  + metadata->event_len;
+		if (!(metadata->mask == FAN_ERROR)) {
+			printf("unexpected FAN MARK: %llx\n", metadata->mask);
+			continue;
+		}
+		if (metadata->fd != FAN_NOFD) {
+			printf("bizar fd != FAN_NOFD\n");
+			continue;;
+		}
+
+		printf("FAN_ERROR found len=%d\n", metadata->event_len);
+
+		for (off = (char*)(metadata+1); off < next; off = off + hdr->len) {
+			hdr = (struct fanotify_event_info_header*)(off);
+
+			if (hdr->info_type == FAN_EVENT_INFO_TYPE_ERROR) {
+				struct fanotify_event_info_error *error =
+					(struct fanotify_event_info_error*) hdr;
+
+				printf("  Generic Error Record: len=%d\n", hdr->len);
+				printf("      version: %d\n", error->version);
+				printf("      error: %d\n", error->error);
+				printf("      fsid: %llx\n", error->fsid);
+
+			} else if(hdr->info_type == FAN_EVENT_INFO_TYPE_LOCATION) {
+				struct fanotify_event_info_location *loc =
+					(struct fanotify_event_info_location*) hdr;
+
+				printf("  Location Record Size = %d\n", loc->hdr.len);
+				printf("      loc=%s:%d\n", loc->function, loc->line);
+
+			} else if(hdr->info_type == FAN_EVENT_INFO_TYPE_FSDATA) {
+				struct fanotify_event_info_fsdata *data =
+					(struct fanotify_event_info_fsdata *)hdr;
+				struct ext4_error_inode_report *fsdata =
+					(struct ext4_error_inode_report*) ((char*)data->data);
+
+				printf("  Fsdata Record: len=%d\n", hdr->len);
+				printf("      inode=%llu\n", fsdata->inode);
+				if (fsdata->block != -1L)
+					printf("      block=%llu\n", fsdata->block);
+				printf("      desc=%s\n", fsdata->desc);
+			}
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int fd;
+	char buffer[BUFSIZ];
+
+	if (argc < 2) {
+		printf("Missing path argument\n");
+		return 1;
+	}
+
+	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_PREALLOC_QUEUE, O_RDONLY);
+	if (fd < 0)
+		errx(1, "fanotify_init");
+
+	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
+			  FAN_ERROR, AT_FDCWD, argv[1])) {
+		errx(1, "fanotify_mark");
+	}
+
+	while (1) {
+		int n = read(fd, buffer, BUFSIZ);
+		if (n < 0)
+			errx(1, "read");
+
+		handle_notifications(buffer, n);
+	}
+
+	return 0;
+}
-- 
2.31.0

