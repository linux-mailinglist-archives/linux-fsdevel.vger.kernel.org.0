Return-Path: <linux-fsdevel+bounces-34742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEC59C8504
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA511F21924
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 08:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC991F76B2;
	Thu, 14 Nov 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIkqJ0x1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3F1F76A8;
	Thu, 14 Nov 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573860; cv=none; b=Y/zWrU/1RRerHXOPuJo7lOhNGmuDxh8+32yvMEs+F2QyoCqWWz+bvDh5Z7OTfzHrDRCTcLCrg4OJ+fSyo8iNxLZUPjdwHFmEElp9/e0atqoxYa7oYGpZixcdRyPsSZmZmj8mh4+uuacR1Bpyn6u2Z8WBw3DFC40aB4oEjLYjuwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573860; c=relaxed/simple;
	bh=HK4iU8O22NadzfqP2gnHIsvdLo88uc0RAYaz8YOCi1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWQlEIg8sdad2o+GT2XbicwT9/rVL8uDJGEh/qR5rckYlg/mukh1CY9k5uMP8K+kcrBu428clFm7/Lrj3IAbzGdeqh15bOWwu333Gt9+mBbLShzPFhDotA7vy0kZL/vSiH4klBI2z6ELlKXlcjgMXOMamK9Ku7/kSqjV0u1z3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIkqJ0x1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CEDC4CECD;
	Thu, 14 Nov 2024 08:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731573857;
	bh=HK4iU8O22NadzfqP2gnHIsvdLo88uc0RAYaz8YOCi1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIkqJ0x1Cdhxh2ZeHDRWqKxo6mm5f28jQTlfQKXY+nF1LtB9NRRrPzYUBB+K/rro0
	 ASgvIB9zTtRwtD7h15vw1Eo2uJ5LytxdNohe6KrS1sIrn2NyhYQja2mR9UWcW29AGA
	 yPEX7zN41Den97QAS0e8O/hMlk7nj8ZbbHStx4J6fUD85mq9YsLaMfrPoqTmBmNJ2b
	 jLYDK5XCsZCEVv6g4nes5IErI2R1mL2aIUZZjnagFk53SLUc+mz6rHiGXyY3U5VZGn
	 ta7bfVBjrBRjVxKjklIWuT5bN5NQXlpJq5JjyrLmD5sBeA2zFT/qz358x/kM8aFPBv
	 EfHn3eVzXMEFQ==
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
Subject: [RFC/PATCH v2 bpf-next fanotify 2/7] samples/fanotify: Add a sample fanotify fastpath handler
Date: Thu, 14 Nov 2024 00:43:40 -0800
Message-ID: <20241114084345.1564165-3-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114084345.1564165-1-song@kernel.org>
References: <20241114084345.1564165-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fastpath handler monitors a subtree inside a mount point.
To use it:

[root] insmod ./fastpath-mod.ko
[root] mkdir -p /tmp/a/b/c/d
[root] ./fastpath-user /tmp/ /tmp/a/b &
[root] touch /tmp/xx      # Doesn't generate event
[root]# touch /tmp/a/xxa  # Doesn't generate event
[root]# touch /tmp/a/b/xxab      # Generates an event
Accessing file xxab   # this is the output from fastpath-user
[root@]# touch /tmp/a/b/c/xxabc  # Generates an event
Accessing file xxabc  # this is the output from fastpath-user

Signed-off-by: Song Liu <song@kernel.org>
---
 MAINTAINERS                      |   1 +
 samples/Kconfig                  |  20 +++++-
 samples/Makefile                 |   2 +-
 samples/fanotify/.gitignore      |   1 +
 samples/fanotify/Makefile        |   5 +-
 samples/fanotify/fastpath-mod.c  |  82 +++++++++++++++++++++++
 samples/fanotify/fastpath-user.c | 111 +++++++++++++++++++++++++++++++
 7 files changed, 219 insertions(+), 3 deletions(-)
 create mode 100644 samples/fanotify/fastpath-mod.c
 create mode 100644 samples/fanotify/fastpath-user.c

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
index b288d9991d27..b0d3dff48bb0 100644
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
 
+config SAMPLE_FANOTIFY_FASTPATH
+	tristate "Build fanotify fastpath sample"
+	depends on SAMPLE_FANOTIFY && m
+	help
+	  When enabled, this builds kernel module that contains a
+	  fanotify fastpath handler.
+	  The fastpath handler filters out certain filename
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
index d74593e8b2de..306e1ddec4e0 100644
--- a/samples/fanotify/.gitignore
+++ b/samples/fanotify/.gitignore
@@ -1 +1,2 @@
 fs-monitor
+fastpath-user
diff --git a/samples/fanotify/Makefile b/samples/fanotify/Makefile
index e20db1bdde3b..f5bbd7380104 100644
--- a/samples/fanotify/Makefile
+++ b/samples/fanotify/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
-userprogs-always-y += fs-monitor
+userprogs-always-$(CONFIG_SAMPLE_FANOTIFY_ERROR) += fs-monitor
 
 userccflags += -I usr/include -Wall
 
+obj-$(CONFIG_SAMPLE_FANOTIFY_FASTPATH) += fastpath-mod.o
+
+userprogs-always-$(CONFIG_SAMPLE_FANOTIFY_FASTPATH) += fastpath-user
diff --git a/samples/fanotify/fastpath-mod.c b/samples/fanotify/fastpath-mod.c
new file mode 100644
index 000000000000..7e2e1878f8e7
--- /dev/null
+++ b/samples/fanotify/fastpath-mod.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/fsnotify.h>
+#include <linux/fanotify.h>
+#include <linux/module.h>
+#include <linux/path.h>
+#include <linux/file.h>
+
+static int sample_fp_handler(struct fsnotify_group *group,
+			     struct fanotify_fastpath_hook *fp_hook,
+			     struct fanotify_fastpath_event *fp_event)
+{
+	struct dentry *dentry;
+	struct path *subtree;
+
+	dentry = fsnotify_data_dentry(fp_event->data, fp_event->data_type);
+	if (!dentry)
+		return FAN_FP_RET_SEND_TO_USERSPACE;
+
+	subtree = fp_hook->data;
+
+	if (is_subdir(dentry, subtree->dentry))
+		return FAN_FP_RET_SEND_TO_USERSPACE;
+	return FAN_FP_RET_SKIP_EVENT;
+}
+
+static int sample_fp_init(struct fanotify_fastpath_hook *fp_hook, void *args)
+{
+	struct path *subtree;
+	struct file *file;
+	int fd;
+
+	fd = *(int *)args;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+	subtree = kzalloc(sizeof(struct path), GFP_KERNEL);
+	if (!subtree) {
+		fput(file);
+		return -ENOMEM;
+	}
+	path_get(&file->f_path);
+	*subtree = file->f_path;
+	fput(file);
+	fp_hook->data = subtree;
+	return 0;
+}
+
+static void sample_fp_free(struct fanotify_fastpath_hook *fp_hook)
+{
+	struct path *subtree = fp_hook->data;
+
+	path_put(subtree);
+	kfree(subtree);
+}
+
+static struct fanotify_fastpath_ops fan_fp_ignore_a_ops = {
+	.fp_handler = sample_fp_handler,
+	.fp_init = sample_fp_init,
+	.fp_free = sample_fp_free,
+	.name = "monitor-subtree",
+	.owner = THIS_MODULE,
+	.flags = FAN_FP_F_SYS_ADMIN_ONLY,
+	.desc = "only emit events under a subtree",
+	.init_args = "struct {\n\tint subtree_fd;\n};",
+};
+
+static int __init fanotify_fastpath_sample_init(void)
+{
+	return fanotify_fastpath_register(&fan_fp_ignore_a_ops);
+}
+static void __exit fanotify_fastpath_sample_exit(void)
+{
+	fanotify_fastpath_unregister(&fan_fp_ignore_a_ops);
+}
+
+module_init(fanotify_fastpath_sample_init);
+module_exit(fanotify_fastpath_sample_exit);
+
+MODULE_AUTHOR("Song Liu");
+MODULE_DESCRIPTION("Example fanotify fastpath handler");
+MODULE_LICENSE("GPL");
diff --git a/samples/fanotify/fastpath-user.c b/samples/fanotify/fastpath-user.c
new file mode 100644
index 000000000000..abe33a6b6b41
--- /dev/null
+++ b/samples/fanotify/fastpath-user.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <err.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/fanotify.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
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
+	struct fanotify_fastpath_args args = {
+		.name = "monitor-subtree",
+		.version = 1,
+		.flags = 0,
+	};
+	char buffer[BUFSIZ];
+	const char *msg;
+	int fanotify_fd;
+	int subtree_fd;
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
+	args.init_args = (__u64)&subtree_fd;
+	args.init_args_size = sizeof(int);
+
+	fanotify_fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_NAME | FAN_REPORT_DIR_FID,
+				    O_RDONLY);
+	if (fanotify_fd < 0) {
+		close(subtree_fd);
+		errx(1, "fanotify_init");
+	}
+
+	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+			  FAN_OPEN | FAN_ONDIR | FAN_EVENT_ON_CHILD,
+			  AT_FDCWD, argv[1])) {
+		msg = "fanotify_mark";
+		goto err_out;
+	}
+
+	if (ioctl(fanotify_fd, FAN_IOC_ADD_FP, &args)) {
+		msg = "ioctl";
+		goto err_out;
+	}
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
+	ioctl(fanotify_fd, FAN_IOC_DEL_FP);
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
-- 
2.43.5


