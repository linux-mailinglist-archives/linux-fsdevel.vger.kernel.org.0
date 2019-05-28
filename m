Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F602C9E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfE1PM3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:12:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfE1PM3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:12:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BF7A3092670;
        Tue, 28 May 2019 15:12:28 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3820173CD;
        Tue, 28 May 2019 15:12:25 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 10/25] vfs: fsinfo sample: Mount listing program [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:12:25 +0100
Message-ID: <155905634517.1662.7843563955043166854.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 28 May 2019 15:12:28 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a program to demonstrate mount listing using the new fsinfo()
syscall, for example:

# ./test-mntinfo
ROOT                                          5d        c ext4 8:12
 \_ sys                                       13        8 sysfs 0:13
 |   \_ kernel/security                       16        0 securityfs 0:7
 |   \_ fs/cgroup                             1a       10 tmpfs 0:17
 |   |   \_ unified                           1b        0 cgroup2 0:18
 |   |   \_ systemd                           1c        0 cgroup 0:19
 |   |   \_ freezer                           20        0 cgroup 0:1d
 |   |   \_ cpu,cpuacct                       21        0 cgroup 0:1e
 |   |   \_ memory                            22        0 cgroup 0:1f
 |   |   \_ cpuset                            23        0 cgroup 0:20
 |   |   \_ hugetlb                           24        0 cgroup 0:21
 |   |   \_ net_cls,net_prio                  25        0 cgroup 0:22
 |   |   \_ blkio                             26        0 cgroup 0:23
 |   |   \_ perf_event                        27        0 cgroup 0:24
 |   |   \_ devices                           28        0 cgroup 0:25
 |   |   \_ rdma                              29        0 cgroup 0:26
 |   \_ fs/pstore                             1d        0 pstore 0:1a
 |   \_ firmware/efi/efivars                  1e        0 efivarfs 0:1b
 |   \_ fs/bpf                                1f        0 bpf 0:1c
 |   \_ kernel/config                         5a        0 configfs 0:10
 |   \_ fs/selinux                            2a        0 selinuxfs 0:12
 |   \_ kernel/debug                          2e        0 debugfs 0:8
 \_ dev                                       15        4 devtmpfs 0:6
 |   \_ shm                                   17        0 tmpfs 0:14
 |   \_ pts                                   18        0 devpts 0:15
 |   \_ hugepages                             2b        0 hugetlbfs 0:27
 |   \_ mqueue                                2c        0 mqueue 0:11
 \_ run                                       19        1 tmpfs 0:16
 |   \_ user/0                               1b4        0 tmpfs 0:2d
 \_ proc                                      14        1 proc 0:4
 |   \_ sys/fs/binfmt_misc                    2d        0 autofs 0:28
 \_ tmp                                       2f      7d0 tmpfs 0:29
 \_ var/cache/fscache                         71        0 tmpfs 0:2a
 \_ boot                                      74        0 ext4 8:15
 \_ home                                      74        0 ext4 8:15
 \_ var/lib/nfs/rpc_pipefs                    bf        0 rpc_pipefs 0:2b
 \_ mnt                                      15b        5 tmpfs 0:2c
 |   \_ foo                                  164        0 tmpfs 0:2e
 |   \_ foo1                                 16d        0 tmpfs 0:2f
 |   \_ foo2                                 176        0 tmpfs 0:30
 |   \_ foo3                                 17f        0 tmpfs 0:31
 |   \_ foo4                                 188        1 tmpfs 0:32
 |       \_ ""                               191        0 tmpfs 0:33
 \_ afs                                      19a        2 afs 0:34
     \_ procyon.org.uk                       1a3        0 afs 0:35
     \_ grand.central.org                    1ac        0 afs 0:36

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/vfs/Makefile       |    3 +
 samples/vfs/test-mntinfo.c |  239 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+)
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
index 000000000000..00fbefae98fa
--- /dev/null
+++ b/samples/vfs/test-mntinfo.c
@@ -0,0 +1,239 @@
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
+	if (s < 40)
+		s = 40 - s;
+	else
+		s = 1;
+	printf("%*.*s", s, s, "");
+
+	printf("%8x %8x %s %x:%x",
+	       info.mnt_id, info.notify_counter,
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
+	display_mount(mnt_id, 0, path);
+	return 0;
+}

