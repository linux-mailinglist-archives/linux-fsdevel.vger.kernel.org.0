Return-Path: <linux-fsdevel+bounces-37154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9969EE614
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1765286CD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E242153F5;
	Thu, 12 Dec 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/QmgRuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DDB212F86
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004592; cv=none; b=tuSHN5TKLlZ4xYhe0X/CE1WA2oeig9URn4Yd55Xnm2/amykz+3GK6aPRYJleH8dUxZ3059l21gMbmGeU8z7xuva0msEDdbsVDr4XtoWgX5YPtAX1PHYKVqFimQqjp4nFgiPH1d4ELDbh1f3RZ/OXtjqe253jVfi0V5rfN8D27WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004592; c=relaxed/simple;
	bh=sml9215PPcFAlh8pcjjb9M8oaHdJe+E09N8aBMLleno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3CQSyBGtDrS4kqKSLVrUl7CzmToOO23wzIjX4X4d1X1WoCJrGhmgKc1Y+s4emMCFAxeP+l0VIyOCEYPH+GGHemEB0yGYeFdc8O9wsrZQi9ZBJzE2m+NZIIn0dZ9ko03pY4wuO8g1GJ8/uPr2pZvIYN/IpMEOrZW+XBiZMIbzBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/QmgRuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B26AC4CED0;
	Thu, 12 Dec 2024 11:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734004590;
	bh=sml9215PPcFAlh8pcjjb9M8oaHdJe+E09N8aBMLleno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i/QmgRuLtL9kDPwVH5x0FF6l1xOq9VmvLV/UUlBRN2CLf/xfAv9a4NY9VqPANb8Xm
	 Zl2VaqbiJT7eycjT+a0w9+s02DacbD0/OXA784CdGH8b8H/yWuTDVh6HpJOEZbUG97
	 5zyxbSTFJghUukTjyjWatd3NoOn8VTWzJZaLH2INwCKAt4Y2gMnhFM+pMB9k3I83h9
	 IVR9yE7SDcGkDFqy9W7jmgLYsNL4UlkstyguZoBXqUL1TUmSmAH4Qwrs0OlOFBe94+
	 rWsPj/aNXZl0sis0OzT7FsxU7cvdpegOItRepbaejL1o3LrTzdPCfHGW3a5yP+r/UU
	 RjeIcC5QNtP/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Dec 2024 12:56:07 +0100
Subject: [PATCH v2 8/8] samples: add test-list-all-mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-work-mount-rbtree-lockless-v2-8-4fe6cef02534@kernel.org>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7958; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sml9215PPcFAlh8pcjjb9M8oaHdJe+E09N8aBMLleno=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHnY9JaXmUWi9rf7Hq6IJot/ot/4o/+d9hunvi/f6is
 10zQ26ZdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkW42R4WXnKdcfpp/EJ15L
 +lvzbeGbE2ezUg31L1bPesHP3q+8PIyR4cAE5hnfTVNuMHusk22arNLF+cpIeOYyXWmJe7Lc+2Z
 u4gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a sample program illustrating how to list all mounts in all mount
namespaces.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 samples/vfs/.gitignore             |   1 +
 samples/vfs/Makefile               |   2 +-
 samples/vfs/test-list-all-mounts.c | 235 +++++++++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+), 1 deletion(-)

diff --git a/samples/vfs/.gitignore b/samples/vfs/.gitignore
index 79212d91285bca72b0ff85f28aaccd2e803ac092..8694dd17b318768b975ece5c7cd450c2cca67318 100644
--- a/samples/vfs/.gitignore
+++ b/samples/vfs/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /test-fsmount
+/test-list-all-mounts
 /test-statx
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 6377a678134acf0d682151d751d2f5042dbf5e0a..301be72a52a0e376c7ebe235cc2058992919cc78 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-userprogs-always-y += test-fsmount test-statx
+userprogs-always-y += test-fsmount test-statx test-list-all-mounts
 
 userccflags += -I usr/include
diff --git a/samples/vfs/test-list-all-mounts.c b/samples/vfs/test-list-all-mounts.c
new file mode 100644
index 0000000000000000000000000000000000000000..f372d5aea4717fd1ab3d4b3f9af79316cd5dd3d3
--- /dev/null
+++ b/samples/vfs/test-list-all-mounts.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Christian Brauner <brauner@kernel.org>
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <limits.h>
+#include <linux/types.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+
+#include "../../tools/testing/selftests/pidfd/pidfd.h"
+
+#define die_errno(format, ...)                                             \
+	do {                                                               \
+		fprintf(stderr, "%m | %s: %d: %s: " format "\n", __FILE__, \
+			__LINE__, __func__, ##__VA_ARGS__);                \
+		exit(EXIT_FAILURE);                                        \
+	} while (0)
+
+/* Get the id for a mount namespace */
+#define NS_GET_MNTNS_ID _IO(0xb7, 0x5)
+/* Get next mount namespace. */
+
+struct mnt_ns_info {
+	__u32 size;
+	__u32 nr_mounts;
+	__u64 mnt_ns_id;
+};
+
+#define MNT_NS_INFO_SIZE_VER0 16 /* size of first published struct */
+
+/* Get information about namespace. */
+#define NS_MNT_GET_INFO _IOR(0xb7, 10, struct mnt_ns_info)
+/* Get next namespace. */
+#define NS_MNT_GET_NEXT _IOR(0xb7, 11, struct mnt_ns_info)
+/* Get previous namespace. */
+#define NS_MNT_GET_PREV _IOR(0xb7, 12, struct mnt_ns_info)
+
+#define PIDFD_GET_MNT_NAMESPACE _IO(0xFF, 3)
+
+#ifndef __NR_listmount
+#define __NR_listmount 458
+#endif
+
+#ifndef __NR_statmount
+#define __NR_statmount 457
+#endif
+
+/* @mask bits for statmount(2) */
+#define STATMOUNT_SB_BASIC		0x00000001U /* Want/got sb_... */
+#define STATMOUNT_MNT_BASIC		0x00000002U /* Want/got mnt_... */
+#define STATMOUNT_PROPAGATE_FROM	0x00000004U /* Want/got propagate_from */
+#define STATMOUNT_MNT_ROOT		0x00000008U /* Want/got mnt_root  */
+#define STATMOUNT_MNT_POINT		0x00000010U /* Want/got mnt_point */
+#define STATMOUNT_FS_TYPE		0x00000020U /* Want/got fs_type */
+#define STATMOUNT_MNT_NS_ID		0x00000040U /* Want/got mnt_ns_id */
+#define STATMOUNT_MNT_OPTS		0x00000080U /* Want/got mnt_opts */
+
+#define STATX_MNT_ID_UNIQUE 0x00004000U /* Want/got extended stx_mount_id */
+
+struct statmount {
+	__u32 size;
+	__u32 mnt_opts;
+	__u64 mask;
+	__u32 sb_dev_major;
+	__u32 sb_dev_minor;
+	__u64 sb_magic;
+	__u32 sb_flags;
+	__u32 fs_type;
+	__u64 mnt_id;
+	__u64 mnt_parent_id;
+	__u32 mnt_id_old;
+	__u32 mnt_parent_id_old;
+	__u64 mnt_attr;
+	__u64 mnt_propagation;
+	__u64 mnt_peer_group;
+	__u64 mnt_master;
+	__u64 propagate_from;
+	__u32 mnt_root;
+	__u32 mnt_point;
+	__u64 mnt_ns_id;
+	__u64 __spare2[49];
+	char str[];
+};
+
+struct mnt_id_req {
+	__u32 size;
+	__u32 spare;
+	__u64 mnt_id;
+	__u64 param;
+	__u64 mnt_ns_id;
+};
+
+#define MNT_ID_REQ_SIZE_VER1 32 /* sizeof second published struct */
+
+#define LSMT_ROOT 0xffffffffffffffff /* root mount */
+
+static int __statmount(__u64 mnt_id, __u64 mnt_ns_id, __u64 mask,
+		       struct statmount *stmnt, size_t bufsize,
+		       unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size		= MNT_ID_REQ_SIZE_VER1,
+		.mnt_id		= mnt_id,
+		.param		= mask,
+		.mnt_ns_id	= mnt_ns_id,
+	};
+
+	return syscall(__NR_statmount, &req, stmnt, bufsize, flags);
+}
+
+static struct statmount *sys_statmount(__u64 mnt_id, __u64 mnt_ns_id,
+				       __u64 mask, unsigned int flags)
+{
+	size_t bufsize = 1 << 15;
+	struct statmount *stmnt = NULL, *tmp = NULL;
+	int ret;
+
+	for (;;) {
+		tmp = realloc(stmnt, bufsize);
+		if (!tmp)
+			goto out;
+
+		stmnt = tmp;
+		ret = __statmount(mnt_id, mnt_ns_id, mask, stmnt, bufsize, flags);
+		if (!ret)
+			return stmnt;
+
+		if (errno != EOVERFLOW)
+			goto out;
+
+		bufsize <<= 1;
+		if (bufsize >= UINT_MAX / 2)
+			goto out;
+	}
+
+out:
+	free(stmnt);
+	return NULL;
+}
+
+static ssize_t sys_listmount(__u64 mnt_id, __u64 last_mnt_id, __u64 mnt_ns_id,
+			     __u64 list[], size_t num, unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size		= MNT_ID_REQ_SIZE_VER1,
+		.mnt_id		= mnt_id,
+		.param		= last_mnt_id,
+		.mnt_ns_id	= mnt_ns_id,
+	};
+
+	return syscall(__NR_listmount, &req, list, num, flags);
+}
+
+int main(int argc, char *argv[])
+{
+#define LISTMNT_BUFFER 10
+	__u64 list[LISTMNT_BUFFER], last_mnt_id = 0;
+	int ret, pidfd, fd_mntns;
+	struct mnt_ns_info info = {};
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	if (pidfd < 0)
+		die_errno("pidfd_open failed");
+
+	fd_mntns = ioctl(pidfd, PIDFD_GET_MNT_NAMESPACE, 0);
+	if (fd_mntns < 0)
+		die_errno("ioctl(PIDFD_GET_MNT_NAMESPACE) failed");
+
+	ret = ioctl(fd_mntns, NS_MNT_GET_INFO, &info);
+	if (ret < 0)
+		die_errno("ioctl(NS_GET_MNTNS_ID) failed");
+
+	printf("Listing %u mounts for mount namespace %llu\n",
+	       info.nr_mounts, info.mnt_ns_id);
+	for (;;) {
+		ssize_t nr_mounts;
+next:
+		nr_mounts = sys_listmount(LSMT_ROOT, last_mnt_id,
+					  info.mnt_ns_id, list, LISTMNT_BUFFER,
+					  0);
+		if (nr_mounts <= 0) {
+			int fd_mntns_next;
+
+			printf("Finished listing %u mounts for mount namespace %llu\n\n",
+			       info.nr_mounts, info.mnt_ns_id);
+			fd_mntns_next = ioctl(fd_mntns, NS_MNT_GET_NEXT, &info);
+			if (fd_mntns_next < 0) {
+				if (errno == ENOENT) {
+					printf("Finished listing all mount namespaces\n");
+					exit(0);
+				}
+				die_errno("ioctl(NS_MNT_GET_NEXT) failed");
+			}
+			close(fd_mntns);
+			fd_mntns = fd_mntns_next;
+			last_mnt_id = 0;
+			printf("Listing %u mounts for mount namespace %llu\n",
+			       info.nr_mounts, info.mnt_ns_id);
+			goto next;
+		}
+
+		for (size_t cur = 0; cur < nr_mounts; cur++) {
+			struct statmount *stmnt;
+
+			last_mnt_id = list[cur];
+
+			stmnt = sys_statmount(last_mnt_id, info.mnt_ns_id,
+					      STATMOUNT_SB_BASIC |
+					      STATMOUNT_MNT_BASIC |
+					      STATMOUNT_MNT_ROOT |
+					      STATMOUNT_MNT_POINT |
+					      STATMOUNT_MNT_NS_ID |
+					      STATMOUNT_MNT_OPTS |
+					      STATMOUNT_FS_TYPE, 0);
+			if (!stmnt) {
+				printf("Failed to statmount(%llu) in mount namespace(%llu)\n",
+				       last_mnt_id, info.mnt_ns_id);
+				continue;
+			}
+
+			printf("mnt_id:\t\t%llu\nmnt_parent_id:\t%llu\nfs_type:\t%s\nmnt_root:\t%s\nmnt_point:\t%s\nmnt_opts:\t%s\n\n",
+			       stmnt->mnt_id,
+			       stmnt->mnt_parent_id,
+			       stmnt->str + stmnt->fs_type,
+			       stmnt->str + stmnt->mnt_root,
+			       stmnt->str + stmnt->mnt_point,
+			       stmnt->str + stmnt->mnt_opts);
+			free(stmnt);
+		}
+	}
+
+	exit(0);
+}

-- 
2.45.2


