Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA901685F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgBUSDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:03:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36512 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbgBUSDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582308203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyuL36RI4EomTK5biSn/4+gCvgS7xDPk+kAPUGBWPZ8=;
        b=PZjS5jtZHQ81AaYfcA4lkq24KZQFV6EDdPhTm6N/Vuyc/+cT04YU42rQ3XF/9hOS+eLALv
        naRThWm4AgWI0r6gjgsPX1jKLR+Qwo2CGPqLIgXhNTDSdEtRKqjh53NtGpUq3m5ABXtvuE
        P9eHnZeXfFfNsO1clqSPfmPHO5p4L+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-MG5j9EiPOsaHlqyEN2O_Nw-1; Fri, 21 Feb 2020 13:03:20 -0500
X-MC-Unique: MG5j9EiPOsaHlqyEN2O_Nw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D87C805720;
        Fri, 21 Feb 2020 18:03:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 588135DDA8;
        Fri, 21 Feb 2020 18:03:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 11/17] fsinfo: sample: Mount listing program [ver #17]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 18:03:16 +0000
Message-ID: <158230819662.2185128.7616577805802640363.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

 samples/vfs/Makefile       |    2 
 samples/vfs/test-mntinfo.c |  243 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 245 insertions(+)
 create mode 100644 samples/vfs/test-mntinfo.c

diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 9159ad1d7fc5..19be60ab950e 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -4,12 +4,14 @@
 hostprogs := \
 	test-fsinfo \
 	test-fsmount \
+	test-mntinfo \
 	test-statx
 
 always-y := $(hostprogs)
 
 HOSTCFLAGS_test-fsinfo.o += -I$(objtree)/usr/include
 HOSTLDLIBS_test-fsinfo += -static -lm
+HOSTCFLAGS_test-mntinfo.o += -I$(objtree)/usr/include
 
 HOSTCFLAGS_test-fsmount.o += -I$(objtree)/usr/include
 HOSTCFLAGS_test-statx.o += -I$(objtree)/usr/include
diff --git a/samples/vfs/test-mntinfo.c b/samples/vfs/test-mntinfo.c
new file mode 100644
index 000000000000..f4d90d0671c5
--- /dev/null
+++ b/samples/vfs/test-mntinfo.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Test the fsinfo() system call
+ *
+ * Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
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
+static void get_attr(unsigned int mnt_id, unsigned int attr,
+		     void *buf, size_t buf_size)
+{
+	struct fsinfo_params params = {
+		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
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
+static void *get_attr_alloc(unsigned int mnt_id, unsigned int attr,
+			    unsigned int Nth, size_t *_size)
+{
+	struct fsinfo_params params = {
+		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
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
+			fprintf(stderr, "mount-%s: %x,%x,%x %m\n",
+				file, params.request, params.Nth, params.Mth);
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
+	char dev[64];
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
+	sprintf(dev, "%x:%x", ids.f_dev_major, ids.f_dev_minor);
+	printf("%10u %8x %2x %5s %s",
+	       info.mnt_id, info.change_counter,
+	       info.attr,
+	       dev, ids.f_fs_name);
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
+		path = get_attr_alloc(children[i].mnt_id, FSINFO_ATTR_MOUNT_POINT,
+				      0, &p_size);
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
+		.flags		= FSINFO_FLAGS_QUERY_PATH,
+		.request	= FSINFO_ATTR_MOUNT_INFO,
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
+	printf("MOUNT                                 MOUNT ID   CHANGE#  AT DEV   TYPE\n");
+	printf("------------------------------------- ---------- -------- -- ----- --------\n");
+	display_mount(mnt_id, 0, path);
+	return 0;
+}


