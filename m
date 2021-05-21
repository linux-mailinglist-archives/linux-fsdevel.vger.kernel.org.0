Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA46D38BC93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 04:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbhEUCn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 22:43:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54980 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbhEUCn5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 22:43:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id BB6161F43D30
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH 10/11] samples: Add fs error monitoring example
Date:   Thu, 20 May 2021 22:41:33 -0400
Message-Id: <20210521024134.1032503-11-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210521024134.1032503-1-krisman@collabora.com>
References: <20210521024134.1032503-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce an example of a FAN_ERROR fanotify user to track filesystem
errors.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 samples/Kconfig               |  8 +++
 samples/Makefile              |  1 +
 samples/fanotify/Makefile     |  3 ++
 samples/fanotify/fs-monitor.c | 91 +++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

diff --git a/samples/Kconfig b/samples/Kconfig
index b5a1a7aa7e23..e421556ec3e5 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -120,6 +120,14 @@ config SAMPLE_CONNECTOR
 	  with it.
 	  See also Documentation/driver-api/connector.rst
 
+config SAMPLE_FANOTIFY_ERROR
+	bool "Build fanotify error monitoring sample"
+	depends on FANOTIFY
+	help
+	  When enabled, this builds an example code that uses the FAN_ERROR
+	  fanotify mechanism to monitor filesystem errors.
+	  Documentation/admin-guide/filesystem-monitoring.rst
+
 config SAMPLE_HIDRAW
 	bool "hidraw sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index 087e0988ccc5..931a81847c48 100644
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
index 000000000000..49d3e2a872e4
--- /dev/null
+++ b/samples/fanotify/fs-monitor.c
@@ -0,0 +1,91 @@
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
+#define FAN_ERROR		0x00008000
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	int error;
+	__kernel_fsid_t fsid;
+	unsigned long inode;
+	__u32 error_count;
+};
+#endif
+
+static void handle_notifications(char *buffer, int len)
+{
+	struct fanotify_event_metadata *metadata;
+	struct fanotify_event_info_error *error;
+
+	for (metadata = (struct fanotify_event_metadata *) buffer;
+	     FAN_EVENT_OK(metadata, len); metadata = FAN_EVENT_NEXT(metadata, len)) {
+		if (!(metadata->mask == FAN_ERROR)) {
+			printf("unexpected FAN MARK: %llx\n", metadata->mask);
+			continue;
+		} else if (metadata->fd != FAN_NOFD) {
+			printf("Unexpected fd (!= FAN_NOFD)\n");
+			continue;
+		}
+
+		printf("FAN_ERROR found len=%d\n", metadata->event_len);
+
+		error = (struct fanotify_event_info_error *) (metadata+1);
+		if (error->hdr.info_type == FAN_EVENT_INFO_TYPE_ERROR) {
+			printf("unknown record: %d\n", error->hdr.info_type);
+			continue;
+		}
+
+		printf("  Generic Error Record: len=%d\n", error->hdr.len);
+		printf("      fsid: %llx\n", error->fsid);
+		printf("      error: %d\n", error->error);
+		printf("      inode: %lu\n", error->inode);
+		printf("      error_count: %d\n", error->error_count);
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
+	fd = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY);
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
+
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

