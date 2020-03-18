Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0FE189F3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 16:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCRPJl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 11:09:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22797 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbgCRPJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584544177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvfYzaZgcHcarqg0JSNvLqYTl3jz9CvQxMvRpyrX1NI=;
        b=KvRwr2e6RTJEExHRzAZS2CIBzZv6mElbU/rEQjaw0xlw2SyniWvnXYbdvFR16wknrkLY7+
        WBKe2WTJgifVGG2R6wiLtg9PRioMrOvIe4iRILr2rtzdYP7Nlckx7NQgdkZ6AQldrPCrNU
        GWBlbet6OdT9kr4BanejMpBgAz6aMqM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-3N367w1DNpOlq8KpYJxBNw-1; Wed, 18 Mar 2020 11:09:33 -0400
X-MC-Unique: 3N367w1DNpOlq8KpYJxBNw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A63D8017CC;
        Wed, 18 Mar 2020 15:09:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D60618D55E;
        Wed, 18 Mar 2020 15:09:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 09/13] fsinfo: sample: Mount listing program [ver #19]
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, jannh@google.com, darrick.wong@oracle.com,
        kzak@redhat.com, jlayton@redhat.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 15:09:28 +0000
Message-ID: <158454416808.2864823.12761694673837489787.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a program to demonstrate mount listing using the new fsinfo()
syscall.  For example, to dump the tree from mount 21:

# ./test-mntinfo -m 21
MOUNT                            MOUNT ID   CHANGE#  AT P DEV   TYPE
-------------------------------- ---------- -------- -- - ----- --------
21                                       21        0  e 4  0:14 sysfs
 \_ kernel/security                      24        0  e 4   0:8 securityfs
 \_ fs/cgroup                            28        4 2f 4  0:18 tmpfs
 |   \_ unified                          29        0  e 4  0:19 cgroup2
 |   \_ systemd                          30        0  e 4  0:1a cgroup
 |   \_ blkio                            34        0  e 4  0:1e cgroup
 |   \_ net_cls,net_prio                 35        0  e 4  0:1f cgroup
 |   \_ perf_event                       36        0  e 4  0:20 cgroup
 |   \_ freezer                          37        0  e 4  0:21 cgroup
 |   \_ devices                          38        0  e 4  0:22 cgroup
 |   \_ cpu,cpuacct                      39        0  e 4  0:23 cgroup
 |   \_ rdma                             40        0  e 4  0:24 cgroup
 |   \_ memory                           41        0  e 4  0:25 cgroup
 |   \_ cpuset                           42        0  e 4  0:26 cgroup
 |   \_ hugetlb                          43        0  e 4  0:27 cgroup
 \_ fs/pstore                            31        0  e 4  0:1b pstore
 \_ firmware/efi/efivars                 32        0  e 4  0:1c efivarfs
 \_ fs/bpf                               33        0  e 4  0:1d bpf
 \_ kernel/config                        92        0  0 4  0:28 configfs
 \_ fs/selinux                           44        0  0 4  0:11 selinuxfs
 \_ kernel/debug                         45        1  0 4   0:7 debugfs

Signed-off-by: David Howells <dhowells@redhat.com>
---

 samples/vfs/Makefile       |    2 
 samples/vfs/test-mntinfo.c |  279 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 281 insertions(+)
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
index 000000000000..d7e9942a70d6
--- /dev/null
+++ b/samples/vfs/test-mntinfo.c
@@ -0,0 +1,279 @@
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
+ssize_t fsinfo(int dfd, const char *filename,
+	       struct fsinfo_params *params, size_t params_size,
+	       void *result_buffer, size_t result_buf_size)
+{
+	return syscall(__NR_fsinfo, dfd, filename,
+		       params, params_size,
+		       result_buffer, result_buf_size);
+}
+
+static char tree_buf[4096];
+static char bar_buf[4096];
+static unsigned int children_list_interval;
+
+/*
+ * Get an fsinfo attribute in a statically allocated buffer.
+ */
+static void get_attr(unsigned int mnt_id, unsigned int attr, unsigned int Nth,
+		     void *buf, size_t buf_size)
+{
+	struct fsinfo_params params = {
+		.flags		= FSINFO_FLAGS_QUERY_MOUNT,
+		.request	= attr,
+		.Nth		= Nth,
+	};
+	char file[32];
+	long ret;
+
+	sprintf(file, "%u", mnt_id);
+
+	memset(buf, 0xbd, buf_size);
+
+	ret = fsinfo(AT_FDCWD, file, &params, sizeof(params), buf, buf_size);
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
+		ret = fsinfo(AT_FDCWD, file, &params, sizeof(params), r, buf_size);
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
+	struct fsinfo_mount_topology top;
+	struct fsinfo_mount_child child;
+	struct fsinfo_mount_info info;
+	struct fsinfo_ids ids;
+	void *children;
+	unsigned int d;
+	size_t ch_size, p_size;
+	char dev[64];
+	int i, n, s;
+
+	get_attr(mnt_id, FSINFO_ATTR_MOUNT_TOPOLOGY, 0, &top, sizeof(top));
+	get_attr(mnt_id, FSINFO_ATTR_MOUNT_INFO, 0, &info, sizeof(info));
+	get_attr(mnt_id, FSINFO_ATTR_IDS, 0, &ids, sizeof(ids));
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
+	printf("%10u %8x %2x %x %5s %s",
+	       info.mnt_id,
+	       (info.sb_changes +
+		info.sb_notifications +
+		info.mnt_attr_changes +
+		info.mnt_topology_changes +
+		info.mnt_subtree_notifications),
+	       info.attr, top.propagation,
+	       dev, ids.f_fs_name);
+	putchar('\n');
+
+	children = get_attr_alloc(mnt_id, FSINFO_ATTR_MOUNT_CHILDREN, 0, &ch_size);
+	n = ch_size / children_list_interval - 1;
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
+	memset(&child, 0, sizeof(child));
+	for (i = 0; i < n; i++) {
+		void *p = children + i * children_list_interval;
+
+		if (sizeof(child) >= children_list_interval)
+			memcpy(&child, p, children_list_interval);
+		else
+			memcpy(&child, p, sizeof(child));
+
+		if (i == n - 1)
+			bar_buf[depth + 1] = ' ';
+		path = get_attr_alloc(child.mnt_id, FSINFO_ATTR_MOUNT_POINT,
+				      0, &p_size);
+		display_mount(child.mnt_id, d, path + 1);
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
+	if (fsinfo(AT_FDCWD, path, &params, sizeof(params), &mnt, sizeof(mnt)) == -1) {
+		perror(path);
+		exit(1);
+	}
+
+	return mnt.mnt_id;
+}
+
+/*
+ * Determine the element size for the mount child list.
+ */
+static unsigned int query_list_element_size(int mnt_id, unsigned int attr)
+{
+	struct fsinfo_attribute_info attr_info;
+
+	get_attr(mnt_id, FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, attr,
+		 &attr_info, sizeof(attr_info));
+	return attr_info.size;
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
+	while ((opt = getopt(argc, argv, "m"))) {
+		switch (opt) {
+		case 'm':
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
+		printf("Format: test-mntinfo -m <mnt_id>\n");
+		exit(2);
+	}
+
+	children_list_interval =
+		query_list_element_size(mnt_id, FSINFO_ATTR_MOUNT_CHILDREN);
+
+	printf("MOUNT                                 MOUNT ID   CHANGE#  AT P DEV   TYPE\n");
+	printf("------------------------------------- ---------- -------- -- - ----- --------\n");
+	display_mount(mnt_id, 0, path);
+	return 0;
+}


