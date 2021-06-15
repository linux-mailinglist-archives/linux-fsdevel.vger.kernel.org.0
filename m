Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5953A8D11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 01:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhFOX7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 19:59:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40120 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbhFOX66 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 19:58:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 182E61F4334C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     kernel@collabora.com, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2 13/14] samples: Add fs error monitoring example
Date:   Tue, 15 Jun 2021 19:55:55 -0400
Message-Id: <20210615235556.970928-14-krisman@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210615235556.970928-1-krisman@collabora.com>
References: <20210615235556.970928-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
errors.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - minor fixes
---
 samples/Kconfig               |  9 ++++
 samples/Makefile              |  1 +
 samples/fanotify/Makefile     |  3 ++
 samples/fanotify/fs-monitor.c | 95 +++++++++++++++++++++++++++++++++++
 4 files changed, 108 insertions(+)
 create mode 100644 samples/fanotify/Makefile
 create mode 100644 samples/fanotify/fs-monitor.c

diff --git a/samples/Kconfig b/samples/Kconfig
index b5a1a7aa7e23..f2f9c939035f 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -120,6 +120,15 @@ config SAMPLE_CONNECTOR
 	  with it.
 	  See also Documentation/driver-api/connector.rst
 
+config SAMPLE_FANOTIFY_ERROR
+	bool "Build fanotify error monitoring sample"
+	depends on FANOTIFY
+	help
+	  When enabled, this builds an example code that uses the
+	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
+	  errors.
+	  See also Documentation/admin-guide/filesystem-monitoring.rst.
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
index 000000000000..cb23a2592337
--- /dev/null
+++ b/samples/fanotify/fs-monitor.c
@@ -0,0 +1,95 @@
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
+#ifndef FAN_FS_ERROR
+#define FAN_FS_ERROR		0x00008000
+#define FAN_EVENT_INFO_TYPE_ERROR	4
+
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+	__kernel_fsid_t fsid;
+	__u64 ino;
+	__u32 ino_generation;
+};
+#endif
+
+static void handle_notifications(char *buffer, int len)
+{
+	struct fanotify_event_metadata *metadata;
+	struct fanotify_event_info_error *error;
+
+	for (metadata = (struct fanotify_event_metadata *) buffer;
+	     FAN_EVENT_OK(metadata, len);
+	     metadata = FAN_EVENT_NEXT(metadata, len)) {
+		if (metadata->mask != FAN_FS_ERROR) {
+			printf("unexpected FAN MARK: %llx\n", metadata->mask);
+			continue;
+		} else if (metadata->fd != FAN_NOFD) {
+			printf("Unexpected fd (!= FAN_NOFD)\n");
+			continue;
+		}
+
+		printf("FAN_FS_ERROR found len=%d\n", metadata->event_len);
+
+		error = (struct fanotify_event_info_error *) (metadata+1);
+		if (error->hdr.info_type != FAN_EVENT_INFO_TYPE_ERROR) {
+			printf("unknown record: %d\n", error->hdr.info_type);
+			continue;
+		}
+
+		printf("\tGeneric Error Record: len=%d\n", error->hdr.len);
+		printf("\tfsid: %x%x\n", error->fsid.val[0],
+		       error->fsid.val[1]);
+		printf("\terror: %d\n", error->error);
+		printf("\tinode: %llu\tgen:%u\n", error->ino,
+		       error->ino_generation);
+		printf("\terror_count: %d\n", error->error_count);
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
+			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
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

