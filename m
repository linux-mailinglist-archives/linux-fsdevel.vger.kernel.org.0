Return-Path: <linux-fsdevel+bounces-35615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5099D662F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 00:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06739B23E6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 23:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A821D357B;
	Fri, 22 Nov 2024 23:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJs0KpGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D651C9B62;
	Fri, 22 Nov 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732316432; cv=none; b=rhJTMpYsfgyYoEMN6g/JHd4P/Uyhk+9qcqHze1Y5Idzslwt5xOPu1/myFI2CMSkBNgSt4wj7wkOS/WfTxLeAYrGSiZK+ZNIhiBYiEunbL7/TbXUqbRiT2MfPfZgtZaxQBfgQC2OF9rAo576PWIz20CDFtT3sSslVDnegvcnI+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732316432; c=relaxed/simple;
	bh=BuhYsZwi2iNHCmyWPxhYoAlpjwVMhcIi7lqtpfzyLwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD10L+WNCLsJ3HW6j2mKFLKorwAv3ocEKaqhOf9C5r8NkP2u34awcoNGumkhaz/YfkOHO7AougO6b+L9LQ2aUftxK2X7AGMsidiqtQ2qsIFdzgjiFRi4dPG7BXt1ZsHibYSViITBMs+SJ9/VokgL4fFef8xiiFdCqYUdjix2b+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJs0KpGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71269C4CECE;
	Fri, 22 Nov 2024 23:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732316431;
	bh=BuhYsZwi2iNHCmyWPxhYoAlpjwVMhcIi7lqtpfzyLwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJs0KpGX3MSaJBBq+ayaJ5702tBuCPvDK5Ccuwi9LNXT+/uJFNxslBMunCPk+lOky
	 ktJ4txqvLAm40xJX+SHSWvKofOzKhZBuzHgY52kTPvQmy6llGscd2JwZ5M2BYmOcqj
	 YXdins1suGJuypPoby9fdUzEjNaX5XusK8+QnJGVXPAeHbj0wbkHMEBcYKUFdVLzNl
	 bZGSBfFi2MNj06FsM/Q1Fxn3P3AWRkRenkv4OPP/cXj3Gy3IEv2OTZmLPczY8BUrfa
	 xmmXos0m1oApEe/4ksGd2cCuF3rVWGputi0M1xS3ErJVlYPp1G9FYVGpcDPnRFzDJF
	 DNGp/P0ezrDHQ==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify fiter
Date: Fri, 22 Nov 2024 14:59:58 -0800
Message-ID: <20241122225958.1775625-3-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241122225958.1775625-1-song@kernel.org>
References: <20241122225958.1775625-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This sample can run in two different mode: filter mode and block mode.
In filter mode, the filter only sends events in a subtree to user space.
To use it:

[root] insmod ./filter-mod.ko
[root] mkdir -p /tmp/a/b/c/d
[root] ./filter-user /tmp/ /tmp/a/b &
Running in filter mode
[root] touch /tmp/xx      # Doesn't generate event
[root]# touch /tmp/a/xxa  # Doesn't generate event
[root]# touch /tmp/a/b/xxab      # Generates an event
Accessing file xxab   # this is the output from filter-user
[root@]# touch /tmp/a/b/c/xxabc  # Generates an event
Accessing file xxabc  # this is the output from filter-user

In block mode, the filter will block accesses to file in a subtree. To
use it:

[root] insmod ./filter-mod.ko
[root] mkdir -p /tmp/a/b/c/d
[root] ./filter-user /tmp/ /tmp/a/b block &
Running in block mode
[root]# dd if=/dev/zero of=/tmp/a/b/xx    # this will fail
dd: failed to open '/tmp/a/b/xx': Operation not permitted

Signed-off-by: Song Liu <song@kernel.org>
---
 MAINTAINERS                    |   1 +
 samples/Kconfig                |  20 ++++-
 samples/Makefile               |   2 +-
 samples/fanotify/.gitignore    |   1 +
 samples/fanotify/Makefile      |   5 +-
 samples/fanotify/filter-mod.c  | 105 ++++++++++++++++++++++++++
 samples/fanotify/filter-user.c | 131 +++++++++++++++++++++++++++++++++
 samples/fanotify/filter.h      |  19 +++++
 8 files changed, 281 insertions(+), 3 deletions(-)
 create mode 100644 samples/fanotify/filter-mod.c
 create mode 100644 samples/fanotify/filter-user.c
 create mode 100644 samples/fanotify/filter.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324..8939a48b2d99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8658,6 +8658,7 @@ S:	Maintained
 F:	fs/notify/fanotify/
 F:	include/linux/fanotify.h
 F:	include/uapi/linux/fanotify.h
+F:	samples/fanotify/
 
 FARADAY FOTG210 USB2 DUAL-ROLE CONTROLLER
 M:	Linus Walleij <linus.walleij@linaro.org>
diff --git a/samples/Kconfig b/samples/Kconfig
index b288d9991d27..9cc0a5cdf604 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -149,15 +149,33 @@ config SAMPLE_CONNECTOR
 	  with it.
 	  See also Documentation/driver-api/connector.rst
 
+config SAMPLE_FANOTIFY
+	bool "Build fanotify monitoring sample"
+	depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  When enabled, this builds samples for fanotify.
+	  There multiple samples for fanotify. Please see the
+	  following configs for more details of these
+	  samples.
+
 config SAMPLE_FANOTIFY_ERROR
 	bool "Build fanotify error monitoring sample"
-	depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
+	depends on SAMPLE_FANOTIFY
 	help
 	  When enabled, this builds an example code that uses the
 	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
 	  errors.
 	  See also Documentation/admin-guide/filesystem-monitoring.rst.
 
+config SAMPLE_FANOTIFY_FILTER
+	tristate "Build fanotify filter sample"
+	depends on SAMPLE_FANOTIFY && m
+	help
+	  When enabled, this builds kernel module that contains a
+	  fanotify filter handler.
+	  The filter handler filters out certain filename
+	  prefixes for the fanotify user.
+
 config SAMPLE_HIDRAW
 	bool "hidraw sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index b85fa64390c5..108360972626 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -6,7 +6,7 @@ subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
 subdir-$(CONFIG_SAMPLE_CGROUP) += cgroup
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
 obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
-obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+= fanotify/
+obj-$(CONFIG_SAMPLE_FANOTIFY)		+= fanotify/
 subdir-$(CONFIG_SAMPLE_HIDRAW)		+= hidraw
 obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
 obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
diff --git a/samples/fanotify/.gitignore b/samples/fanotify/.gitignore
index d74593e8b2de..df75eb5b8f95 100644
--- a/samples/fanotify/.gitignore
+++ b/samples/fanotify/.gitignore
@@ -1 +1,2 @@
 fs-monitor
+filter-user
diff --git a/samples/fanotify/Makefile b/samples/fanotify/Makefile
index e20db1bdde3b..c33e9460772e 100644
--- a/samples/fanotify/Makefile
+++ b/samples/fanotify/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
-userprogs-always-y += fs-monitor
+userprogs-always-$(CONFIG_SAMPLE_FANOTIFY_ERROR) += fs-monitor
 
 userccflags += -I usr/include -Wall
 
+obj-$(CONFIG_SAMPLE_FANOTIFY_FILTER) += filter-mod.o
+
+userprogs-always-$(CONFIG_SAMPLE_FANOTIFY_FILTER) += filter-user
diff --git a/samples/fanotify/filter-mod.c b/samples/fanotify/filter-mod.c
new file mode 100644
index 000000000000..eafe55b1840a
--- /dev/null
+++ b/samples/fanotify/filter-mod.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <linux/fsnotify.h>
+#include <linux/fanotify.h>
+#include <linux/module.h>
+#include <linux/path.h>
+#include <linux/file.h>
+#include "filter.h"
+
+struct fan_filter_sample_data {
+	struct path subtree_path;
+	enum fan_filter_sample_mode mode;
+};
+
+static int sample_filter(struct fsnotify_group *group,
+			 struct fanotify_filter_hook *filter_hook,
+			 struct fanotify_filter_event *filter_event)
+{
+	struct fan_filter_sample_data *data;
+	struct dentry *dentry;
+
+	dentry = fsnotify_data_dentry(filter_event->data, filter_event->data_type);
+	if (!dentry)
+		return FAN_FILTER_RET_SEND_TO_USERSPACE;
+
+	data = filter_hook->data;
+
+	if (is_subdir(dentry, data->subtree_path.dentry)) {
+		if (data->mode == FAN_FILTER_SAMPLE_MODE_BLOCK)
+			return -EPERM;
+		return FAN_FILTER_RET_SEND_TO_USERSPACE;
+	}
+	return FAN_FILTER_RET_SKIP_EVENT;
+}
+
+static int sample_filter_init(struct fsnotify_group *group,
+			      struct fanotify_filter_hook *filter_hook,
+			      void *argp)
+{
+	struct fan_filter_sample_args *args;
+	struct fan_filter_sample_data *data;
+	struct file *file;
+	int fd;
+
+	args = (struct fan_filter_sample_args *)argp;
+	fd = args->subtree_fd;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+	data = kzalloc(sizeof(struct fan_filter_sample_data), GFP_KERNEL);
+	if (!data) {
+		fput(file);
+		return -ENOMEM;
+	}
+	path_get(&file->f_path);
+	data->subtree_path = file->f_path;
+	fput(file);
+	data->mode = args->mode;
+	filter_hook->data = data;
+	return 0;
+}
+
+static void sample_filter_free(struct fanotify_filter_hook *filter_hook)
+{
+	struct fan_filter_sample_data *data = filter_hook->data;
+
+	path_put(&data->subtree_path);
+	kfree(data);
+}
+
+static struct fanotify_filter_ops fan_filter_sample_ops = {
+	.filter = sample_filter,
+	.filter_init = sample_filter_init,
+	.filter_free = sample_filter_free,
+	.name = "monitor-subtree",
+	.owner = THIS_MODULE,
+	.flags = FAN_FILTER_F_SYS_ADMIN_ONLY,
+	.init_args_size = sizeof(struct fan_filter_sample_args),
+	.desc =
+	"mode = 1: only emit events under a subtree\n"
+	"mode = 2: block accesses under a subtree",
+	.init_args =
+	"struct fan_filter_sample_args {\n"
+	"    int subtree_fd;\n"
+	"    enum fan_filter_sample_mode mode;\n"
+	"};",
+};
+
+static int __init fanotify_filter_sample_init(void)
+{
+	return fanotify_filter_register(&fan_filter_sample_ops);
+}
+static void __exit fanotify_filter_sample_exit(void)
+{
+	fanotify_filter_unregister(&fan_filter_sample_ops);
+}
+
+module_init(fanotify_filter_sample_init);
+module_exit(fanotify_filter_sample_exit);
+
+MODULE_AUTHOR("Song Liu");
+MODULE_DESCRIPTION("Example fanotify filter handler");
+MODULE_LICENSE("GPL");
diff --git a/samples/fanotify/filter-user.c b/samples/fanotify/filter-user.c
new file mode 100644
index 000000000000..8cdf8ff2bd6d
--- /dev/null
+++ b/samples/fanotify/filter-user.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/fanotify.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include "filter.h"
+
+static int total_event_cnt;
+
+static void handle_notifications(char *buffer, int len)
+{
+	struct fanotify_event_metadata *event =
+		(struct fanotify_event_metadata *) buffer;
+	struct fanotify_event_info_header *info;
+	struct fanotify_event_info_fid *fid;
+	struct file_handle *handle;
+	char *name;
+	int off;
+
+	for (; FAN_EVENT_OK(event, len); event = FAN_EVENT_NEXT(event, len)) {
+		for (off = sizeof(*event) ; off < event->event_len;
+		     off += info->len) {
+			info = (struct fanotify_event_info_header *)
+				((char *) event + off);
+			switch (info->info_type) {
+			case FAN_EVENT_INFO_TYPE_DFID_NAME:
+				fid = (struct fanotify_event_info_fid *) info;
+				handle = (struct file_handle *)&fid->handle;
+				name = (char *)handle + sizeof(*handle) + handle->handle_bytes;
+
+				printf("Accessing file %s\n", name);
+				total_event_cnt++;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct fanotify_filter_args args = {
+		.name = "monitor-subtree",
+	};
+	struct fan_filter_sample_args init_args;
+	int fanotify_fd, subtree_fd;
+	char buffer[BUFSIZ];
+	const char *msg;
+	__u64 mask;
+	int flags;
+
+	if (argc < 3) {
+		printf("Usage:\n"
+		       "\t %s <mount point> <subtree to monitor>\n",
+			argv[0]);
+		return 1;
+	}
+
+	subtree_fd = open(argv[2], O_RDONLY | O_CLOEXEC);
+
+	if (subtree_fd < 0)
+		errx(1, "open subtree_fd");
+
+	init_args.subtree_fd = subtree_fd;
+
+	if (argc == 4 && strcmp(argv[3], "block") == 0)
+		init_args.mode = FAN_FILTER_SAMPLE_MODE_BLOCK;
+	else
+		init_args.mode = FAN_FILTER_SAMPLE_MODE_FILTER;
+
+	args.init_args = (__u64)&init_args;
+	args.init_args_size = sizeof(init_args);
+
+	flags = FAN_CLASS_NOTIF | FAN_REPORT_NAME | FAN_REPORT_DIR_FID;
+	mask = FAN_OPEN | FAN_ONDIR | FAN_EVENT_ON_CHILD;
+
+	if (init_args.mode == FAN_FILTER_SAMPLE_MODE_BLOCK) {
+		flags = FAN_CLASS_CONTENT;
+		mask |= FAN_OPEN_PERM;
+	}
+
+	fanotify_fd = fanotify_init(flags, O_RDWR);
+	if (fanotify_fd < 0) {
+		close(subtree_fd);
+		errx(1, "fanotify_init");
+	}
+
+
+	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+			  mask, AT_FDCWD, argv[1])) {
+		msg = "fanotify_mark";
+		goto err_out;
+	}
+
+	if (ioctl(fanotify_fd, FAN_IOC_ADD_FILTER, &args)) {
+		msg = "ioctl";
+		goto err_out;
+	}
+
+	printf("Running in %s mode\n",
+	       init_args.mode == FAN_FILTER_SAMPLE_MODE_BLOCK ? "block" : "filter");
+
+	while (total_event_cnt < 10) {
+		int n = read(fanotify_fd, buffer, BUFSIZ);
+
+		if (n < 0) {
+			msg = "read";
+			goto err_out;
+		}
+
+		handle_notifications(buffer, n);
+	}
+
+	ioctl(fanotify_fd, FAN_IOC_DEL_FILTER);
+	close(fanotify_fd);
+	close(subtree_fd);
+	return 0;
+
+err_out:
+	close(fanotify_fd);
+	close(subtree_fd);
+	errx(1, msg);
+	return 0;
+}
diff --git a/samples/fanotify/filter.h b/samples/fanotify/filter.h
new file mode 100644
index 000000000000..cdb97499019a
--- /dev/null
+++ b/samples/fanotify/filter.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#ifndef _SAMPLES_FANOTIFY_FILTER_H
+#define _SAMPLES_FANOTIFY_FILTER_H
+
+enum fan_filter_sample_mode {
+	/* Only show event in the subtree */
+	FAN_FILTER_SAMPLE_MODE_FILTER = 1,
+	/* Block access to files in the subtree */
+	FAN_FILTER_SAMPLE_MODE_BLOCK = 2,
+};
+
+struct fan_filter_sample_args {
+	int subtree_fd;
+	enum fan_filter_sample_mode mode;
+};
+
+#endif /* _SAMPLES_FANOTIFY_FILTER_H */
-- 
2.43.5


