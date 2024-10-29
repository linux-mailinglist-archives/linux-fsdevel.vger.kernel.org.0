Return-Path: <linux-fsdevel+bounces-33172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2B69B568F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 00:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08FA1C20BAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4618F20C030;
	Tue, 29 Oct 2024 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai0/Ku7Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944FF20BB3B;
	Tue, 29 Oct 2024 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730243591; cv=none; b=G+2xt8UTgFRmS6Cw4TxWhPJgPOI3BmIYcAy3mNeMqYNuRA7ozOZwkg/BdDldyyBN7S0ddeELSHIjtR7Tksdu0BUdJ2pSNsAE3HUCeNaHTeNxL6Man4Nuq0ToyTdfIVLTgId8Wp7ZABk5xFzCbopiEtsrgfVZT0CrcFFn/1CnyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730243591; c=relaxed/simple;
	bh=iWQUP4hNCzTd1WdML5oB3J0FqpvqKWa2lTUc2Xwx1yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9cEVbP312/6hbeJ4Ngb46nIe4AzY9Zk3paYgWd1wN7g28XMgHZ9E0pkhy97Xqach5xZRWKVC+WJdDxq8J4SDIH/HtfmSiM4tJYsM4mngQoRBLnh2nGziRXVZblj5tB88wNHQJvqJ03f7Drt+3MuYn3EjAaM23QFH99kpv/Ri9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ai0/Ku7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8DDC4CEE3;
	Tue, 29 Oct 2024 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730243591;
	bh=iWQUP4hNCzTd1WdML5oB3J0FqpvqKWa2lTUc2Xwx1yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ai0/Ku7QJ5xxwq27hB4KB9xQFczmc8b+ejL+RV6wm3+8U8NGLUYkJApO8mfTSkycz
	 CTLCTEZjbHNGvWNIGWfqAlhC5HIabpjyrUp19BZKBurhxYohs7/ZO41QBD6R/HDok9
	 Y/w3RyqGNvMdMXFMET6Q0iDaqunIv4CjH5Pxl9aJSaJHKhz7jLie90rfak98rREtzw
	 5mhZw/w+sr9vKBhS8Fpl0LjcdWb75FJl4LbJZb7JvbcK4xx6j0Fbyk9BEHw8xggEpC
	 P6iJmPxyh4dJksArDCXgZRnTbggBde5lI9161fqyEGrNB6D5XdvQXbbThqA2PhBD5e
	 sssGodVV7sa3w==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	Song Liu <song@kernel.org>
Subject: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample fanotify fastpath handler
Date: Tue, 29 Oct 2024 16:12:41 -0700
Message-ID: <20241029231244.2834368-3-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029231244.2834368-1-song@kernel.org>
References: <20241029231244.2834368-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fastpath handler filters out events for files with certain prefixes.
To use it:

  [root] insmod fastpath-mod.ko    # This requires root.

  [user] ./fastpath-user /tmp a,b,c &    # Root is not needed
  [user] touch /tmp/aa   # a is in the prefix list (a,b,c), no events
  [user] touch /tmp/xx   # x is not in the prefix list, generates events

  Accessing file xx   # this is the output from fastpath_user

Signed-off-by: Song Liu <song@kernel.org>
---
 MAINTAINERS                      |   1 +
 samples/Kconfig                  |  20 ++++-
 samples/Makefile                 |   2 +-
 samples/fanotify/.gitignore      |   1 +
 samples/fanotify/Makefile        |   5 +-
 samples/fanotify/fastpath-mod.c  | 138 +++++++++++++++++++++++++++++++
 samples/fanotify/fastpath-user.c |  90 ++++++++++++++++++++
 7 files changed, 254 insertions(+), 3 deletions(-)
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
index 000000000000..06c4b42ff114
--- /dev/null
+++ b/samples/fanotify/fastpath-mod.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/fsnotify.h>
+#include <linux/fanotify.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/string.h>
+
+struct prefix_item {
+	const char *prefix;
+	struct list_head list;
+};
+
+struct sample_fp_data {
+	/*
+	 * str_table contains all the prefixes to ignore. For example,
+	 * "prefix1\0prefix2\0prefix3"
+	 */
+	char *str_table;
+
+	/* item->prefix points to different prefixes in the str_table. */
+	struct list_head item_list;
+};
+
+static int sample_fp_handler(struct fsnotify_group *group,
+			     struct fanotify_fastpath_hook *fp_hook,
+			     struct fanotify_fastpath_event *fp_event)
+{
+	const struct qstr *file_name = fp_event->file_name;
+	struct sample_fp_data *fp_data;
+	struct prefix_item *item;
+
+	if (!file_name)
+		return FAN_FP_RET_SEND_TO_USERSPACE;
+	fp_data = fp_hook->data;
+
+	list_for_each_entry(item, &fp_data->item_list, list) {
+		if (strstr(file_name->name, item->prefix) == (char *)file_name->name)
+			return FAN_FP_RET_SKIP_EVENT;
+	}
+
+	return FAN_FP_RET_SEND_TO_USERSPACE;
+}
+
+static int add_item(struct sample_fp_data *fp_data, const char *prev)
+{
+	struct prefix_item *item;
+
+	item = kzalloc(sizeof(*item), GFP_KERNEL);
+	if (!item)
+		return -ENOMEM;
+	item->prefix = prev;
+	list_add_tail(&item->list, &fp_data->item_list);
+	return 0;
+}
+
+static void free_sample_fp_data(struct sample_fp_data *fp_data)
+{
+	struct prefix_item *item, *tmp;
+
+	list_for_each_entry_safe(item, tmp, &fp_data->item_list, list) {
+		list_del_init(&item->list);
+		kfree(item);
+	}
+	kfree(fp_data->str_table);
+	kfree(fp_data);
+}
+
+static int sample_fp_init(struct fanotify_fastpath_hook *fp_hook, const char *args)
+{
+	struct sample_fp_data *fp_data = kzalloc(sizeof(struct sample_fp_data), GFP_KERNEL);
+	char *p, *prev;
+	int ret;
+
+	if (!fp_data)
+		return -ENOMEM;
+
+	/* Make a copy of the list of prefix to ignore */
+	fp_data->str_table = kstrndup(args, FAN_FP_ARGS_MAX, GFP_KERNEL);
+	if (!fp_data->str_table) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	INIT_LIST_HEAD(&fp_data->item_list);
+	prev = fp_data->str_table;
+	p = fp_data->str_table;
+
+	/* Update the list replace ',' with '\n'*/
+	while ((p = strchr(p, ',')) != NULL) {
+		*p = '\0';
+		ret = add_item(fp_data, prev);
+		if (ret)
+			goto err_out;
+		p = p + 1;
+		prev = p;
+	}
+
+	ret = add_item(fp_data, prev);
+	if (ret)
+		goto err_out;
+
+	fp_hook->data = fp_data;
+
+	return 0;
+
+err_out:
+	free_sample_fp_data(fp_data);
+	return ret;
+}
+
+static void sample_fp_free(struct fanotify_fastpath_hook *fp_hook)
+{
+	free_sample_fp_data(fp_hook->data);
+}
+
+static struct fanotify_fastpath_ops fan_fp_ignore_a_ops = {
+	.fp_handler = sample_fp_handler,
+	.fp_init = sample_fp_init,
+	.fp_free = sample_fp_free,
+	.name = "ignore-prefix",
+	.owner = THIS_MODULE,
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
index 000000000000..f301c4e0d21a
--- /dev/null
+++ b/samples/fanotify/fastpath-user.c
@@ -0,0 +1,90 @@
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
+		.name = "ignore-prefix",
+		.version = 1,
+		.flags = 0,
+	};
+	char buffer[BUFSIZ];
+	int fd;
+
+	if (argc < 3) {
+		printf("Usage\n"
+		       "\t %s <path to monitor> <prefix to ignore>\n",
+			argv[0]);
+		return 1;
+	}
+
+	args.init_args = (__u64)argv[2];
+	args.init_args_len = strlen(argv[2]) + 1;
+
+	fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_NAME | FAN_REPORT_DIR_FID, O_RDONLY);
+	if (fd < 0)
+		errx(1, "fanotify_init");
+
+	if (fanotify_mark(fd, FAN_MARK_ADD,
+			  FAN_OPEN | FAN_ONDIR | FAN_EVENT_ON_CHILD,
+			  AT_FDCWD, argv[1])) {
+		errx(1, "fanotify_mark");
+	}
+
+	if (ioctl(fd, FAN_IOC_ADD_FP, &args))
+		errx(1, "ioctl");
+
+	while (total_event_cnt < 10) {
+		int n = read(fd, buffer, BUFSIZ);
+
+		if (n < 0)
+			errx(1, "read");
+
+		handle_notifications(buffer, n);
+	}
+
+	ioctl(fd, FAN_IOC_DEL_FP);
+	close(fd);
+
+	return 0;
+}
-- 
2.43.5


