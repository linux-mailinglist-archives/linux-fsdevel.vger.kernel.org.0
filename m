Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A505A59F66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 17:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfF1Prq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 11:47:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11249 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfF1Prq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 11:47:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3B69356FF;
        Fri, 28 Jun 2019 15:47:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 222D75C88D;
        Fri, 28 Jun 2019 15:47:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/6] vfs: fsinfo sample: Mount listing program [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:47:42 +0100
Message-ID: <156173686263.14728.68077351918389381.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173681842.14728.9331700785061885270.stgit@warthog.procyon.org.uk>
References: <156173681842.14728.9331700785061885270.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 28 Jun 2019 15:47:45 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a program to demonstrate mount listing using the new fsinfo()
syscall, for example:

# ./test-mntinfo -M 21
MOUNT                                 MOUNT ID   CHANGE#    TYPE & DEVICE
------------------------------------- ---------- ---------- ---------------
21                                            21          8 sysfs 0:15
 \_ kernel/security                           24          0 securityfs 0:8
 \_ fs/cgroup                                 28         16 tmpfs 0:19
 |   \_ unified                               29          0 cgroup2 0:1a
 |   \_ systemd                               30          0 cgroup 0:1b
 |   \_ freezer                               34          0 cgroup 0:1f
 |   \_ cpu,cpuacct                           35          0 cgroup 0:20
 |   \_ devices                               36          0 cgroup 0:21
 |   \_ memory                                37          0 cgroup 0:22
 |   \_ cpuset                                38          0 cgroup 0:23
 |   \_ net_cls,net_prio                      39          0 cgroup 0:24
 |   \_ hugetlb                               40          0 cgroup 0:25
 |   \_ rdma                                  41          0 cgroup 0:26
 |   \_ blkio                                 42          0 cgroup 0:27
 |   \_ perf_event                            43          0 cgroup 0:28
 \_ fs/pstore                                 31          0 pstore 0:1c
 \_ firmware/efi/efivars                      32          0 efivarfs 0:1d
 \_ fs/bpf                                    33          0 bpf 0:1e
 \_ kernel/config                             92          0 configfs 0:10
 \_ fs/selinux                                44          0 selinuxfs 0:12
 \_ kernel/debug                              48          0 debugfs 0:7

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/vfs/Makefile       |    3 +
 samples/vfs/test-mntinfo.c |  241 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 samples/vfs/test-mntinfo.c

diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 3c542d3b9479..d377b1f7de79 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -3,6 +3,7 @@ hostprogs-y := \
 	test-fsinfo \
 	test-fs-query \
 	test-fsmount \
+	test-mntinfo \
 	test-statx
 
 # Tell kbuild to always build the programs
@@ -10,6 +11,8 @@ always := $(hostprogs-y)
 
 HOSTCFLAGS_test-fsinfo.o += -I$(objtree)/usr/include
 HOSTLDLIBS_test-fsinfo += -lm
+HOSTCFLAGS_test-mntinfo.o += -I$(objtree)/usr/include
+HOSTLDLIBS_test-mntinfo += -lm
 
 HOSTCFLAGS_test-fs-query.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
diff --git a/samples/vfs/test-mntinfo.c b/samples/vfs/test-mntinfo.c
new file mode 100644
index 000000000000..4e1b8f221841
--- /dev/null
+++ b/samples/vfs/test-mntinfo.c
@@ -0,0 +1,241 @@
+/* Test the fsinfo() system call
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
+#define _GNU_SOURCE
+#define _ATFILE_SOURCE
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <errno.h>
+#include <time.h>
+#include <math.h>
+#include <sys/syscall.h>
+#include <linux/fsinfo.h>
+#include <linux/socket.h>
+#include <linux/fcntl.h>
+#include <sys/stat.h>
+#include <arpa/inet.h>
+
+#ifndef __NR_fsinfo
+#define __NR_fsinfo -1
+#endif
+
+static __attribute__((unused))
+ssize_t fsinfo(int dfd, const char *filename, struct fsinfo_params *params,
+	       void *buffer, size_t buf_size)
+{
+	return syscall(__NR_fsinfo, dfd, filename, params, buffer, buf_size);
+}
+
+static char tree_buf[4096];
+static char bar_buf[4096];
+
+/*
+ * Get an fsinfo attribute in a statically allocated buffer.
+ */
+static void get_attr(unsigned int mnt_id, enum fsinfo_attribute attr,
+		     void *buf, size_t buf_size)
+{
+	struct fsinfo_params params = {
+		.at_flags	= AT_FSINFO_MOUNTID_PATH,
+		.request	= attr,
+	};
+	char file[32];
+	long ret;
+
+	sprintf(file, "%u", mnt_id);
+
+	memset(buf, 0xbd, buf_size);
+
+	ret = fsinfo(AT_FDCWD, file, &params, buf, buf_size);
+	if (ret == -1) {
+		fprintf(stderr, "mount-%s: %m\n", file);
+		exit(1);
+	}
+}
+
+/*
+ * Get an fsinfo attribute in a dynamically allocated buffer.
+ */
+static void *get_attr_alloc(unsigned int mnt_id, enum fsinfo_attribute attr,
+			    unsigned int Nth, size_t *_size)
+{
+	struct fsinfo_params params = {
+		.at_flags	= AT_FSINFO_MOUNTID_PATH,
+		.request	= attr,
+		.Nth		= Nth,
+	};
+	size_t buf_size = 4096;
+	char file[32];
+	void *r;
+	long ret;
+
+	sprintf(file, "%u", mnt_id);
+
+	for (;;) {
+		r = malloc(buf_size);
+		if (!r) {
+			perror("malloc");
+			exit(1);
+		}
+		memset(r, 0xbd, buf_size);
+
+		ret = fsinfo(AT_FDCWD, file, &params, r, buf_size);
+		if (ret == -1) {
+			fprintf(stderr, "mount-%s: %m\n", file);
+			exit(1);
+		}
+
+		if (ret <= buf_size) {
+			*_size = ret;
+			break;
+		}
+		buf_size = (ret + 4096 - 1) & ~(4096 - 1);
+	}
+
+	return r;
+}
+
+/*
+ * Display a mount and then recurse through its children.
+ */
+static void display_mount(unsigned int mnt_id, unsigned int depth, char *path)
+{
+	struct fsinfo_mount_child *children;
+	struct fsinfo_mount_info info;
+	struct fsinfo_ids ids;
+	unsigned int d;
+	size_t ch_size, p_size;
+	int i, n, s;
+
+	get_attr(mnt_id, FSINFO_ATTR_MOUNT_INFO, &info, sizeof(info));
+	get_attr(mnt_id, FSINFO_ATTR_IDS, &ids, sizeof(ids));
+	if (depth > 0)
+		printf("%s", tree_buf);
+
+	s = strlen(path);
+	printf("%s", !s ? "\"\"" : path);
+	if (!s)
+		s += 2;
+	s += depth;
+	if (s < 38)
+		s = 38 - s;
+	else
+		s = 1;
+	printf("%*.*s", s, s, "");
+
+	printf("%10u %10u %s %x:%x",
+	       info.mnt_id, info.change_counter,
+	       ids.f_fs_name, ids.f_dev_major, ids.f_dev_minor);
+	putchar('\n');
+
+	children = get_attr_alloc(mnt_id, FSINFO_ATTR_MOUNT_CHILDREN, 0, &ch_size);
+	n = ch_size / sizeof(children[0]) - 1;
+
+	bar_buf[depth + 1] = '|';
+	if (depth > 0) {
+		tree_buf[depth - 4 + 1] = bar_buf[depth - 4 + 1];
+		tree_buf[depth - 4 + 2] = ' ';
+	}
+
+	tree_buf[depth + 0] = ' ';
+	tree_buf[depth + 1] = '\\';
+	tree_buf[depth + 2] = '_';
+	tree_buf[depth + 3] = ' ';
+	tree_buf[depth + 4] = 0;
+	d = depth + 4;
+
+	for (i = 0; i < n; i++) {
+		if (i == n - 1)
+			bar_buf[depth + 1] = ' ';
+		path = get_attr_alloc(mnt_id, FSINFO_ATTR_MOUNT_SUBMOUNT, i, &p_size);
+		display_mount(children[i].mnt_id, d, path + 1);
+		free(path);
+	}
+
+	free(children);
+	if (depth > 0) {
+		tree_buf[depth - 4 + 1] = '\\';
+		tree_buf[depth - 4 + 2] = '_';
+	}
+	tree_buf[depth] = 0;
+}
+
+/*
+ * Find the ID of whatever is at the nominated path.
+ */
+static unsigned int lookup_mnt_by_path(const char *path)
+{
+	struct fsinfo_mount_info mnt;
+	struct fsinfo_params params = {
+		.request = FSINFO_ATTR_MOUNT_INFO,
+	};
+
+	if (fsinfo(AT_FDCWD, path, &params, &mnt, sizeof(mnt)) == -1) {
+		perror(path);
+		exit(1);
+	}
+
+	return mnt.mnt_id;
+}
+
+/*
+ *
+ */
+int main(int argc, char **argv)
+{
+	unsigned int mnt_id;
+	char *path;
+	bool use_mnt_id = false;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "M"))) {
+		switch (opt) {
+		case 'M':
+			use_mnt_id = true;
+			continue;
+		}
+		break;
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	switch (argc) {
+	case 0:
+		mnt_id = lookup_mnt_by_path("/");
+		path = "ROOT";
+		break;
+	case 1:
+		path = argv[0];
+		if (use_mnt_id) {
+			mnt_id = strtoul(argv[0], NULL, 0);
+			break;
+		}
+
+		mnt_id = lookup_mnt_by_path(argv[0]);
+		break;
+	default:
+		printf("Format: test-mntinfo\n");
+		printf("Format: test-mntinfo <path>\n");
+		printf("Format: test-mntinfo -M <mnt_id>\n");
+		exit(2);
+	}
+
+	printf("MOUNT                                 MOUNT ID   CHANGE#    TYPE & DEVICE\n");
+	printf("------------------------------------- ---------- ---------- ---------------\n");
+	display_mount(mnt_id, 0, path);
+	return 0;
+}

