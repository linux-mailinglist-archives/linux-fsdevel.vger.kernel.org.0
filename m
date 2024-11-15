Return-Path: <linux-fsdevel+bounces-34950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 408949CF06D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70701F216FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662E11E282B;
	Fri, 15 Nov 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrOJatHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A81E261B;
	Fri, 15 Nov 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684965; cv=none; b=ea2UHIPMFifiWVC+Y23cjxNQclonPfCiZTYmvw4y++G6nWC6gZLp8Oc4rYd2eKoSAqjtEtV6vdKGp79/f9hC4O3ox1VkgoPqjvF/iWRLKTIYWbGEuBbPP5FMB6PQUiaZ5o4jy7hvxXEdA8+Tf9eELgQt01e6eEogFQin0+Vyhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684965; c=relaxed/simple;
	bh=Nz2g6aX7kYZa3fV4pgIXbRXHWIhB0kmiRiHE/o+ZHCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYdDf7T6LNHp5yJB7ekr2p01s/jv1tgGT/Ly9qP9RQBVlSarf9uZo3nvWllhBjPg4Vi/Euv/b7M/HVYtd3/w9fWvYyK2rlpdEL25OPu/rGI7PhKONotLheBDYSA7wk04nks+GPpiPULmaFKioi55tcVbbuf2QBqiFsFkCctzPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrOJatHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BA8C4CED6;
	Fri, 15 Nov 2024 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731684965;
	bh=Nz2g6aX7kYZa3fV4pgIXbRXHWIhB0kmiRiHE/o+ZHCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UrOJatHg4QKDUXg+rxYShXR2g6j3E/rsFfxJMd3ZG3woilx3x0NlYNQkighSV1k7N
	 eB1vHnzF+E4LlrkSg8DzS62fO7vf1KyTbIB1sm8lbWF9qB2nR+E1xloy1XrB5ADkJO
	 kI0aPOpVpUYFiH6VHKlu/muORWAeeo6L/bg7udReQjDPP6WtcrwmQoYK5ROqgDUNqO
	 QG72GkJJzpvYfubXVOq0nqEBEu8zg+hTkFDozsCe9hqMutUQ1fY5DobgRfzVw7mMtE
	 WVYv+NvlLCgyoqe9KaPW1mqIJt0PVVKRuCsBcxFITH7m+KBDh1COvry30PczdwGDqr
	 +M6tyFLlFp/bg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Nov 2024 10:35:52 -0500
Subject: [PATCH v2 1/2] samples: add a mountinfo program to demonstrate
 statmount()/listmount()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-statmount-v2-1-cd29aeff9cbb@kernel.org>
References: <20241115-statmount-v2-0-cd29aeff9cbb@kernel.org>
In-Reply-To: <20241115-statmount-v2-0-cd29aeff9cbb@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
 Amir Goldstein <amir73il@gmail.com>, Paul Moore <paul@paul-moore.com>, 
 Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8545; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Nz2g6aX7kYZa3fV4pgIXbRXHWIhB0kmiRiHE/o+ZHCE=;
 b=owEBbAKT/ZANAwAIAQAOaEEZVoIVAcsmYgBnN2piO47W0bewypcjon+glLvkfsamv33yeuqlH
 NwxQQ6Q2RyJAjIEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzdqYgAKCRAADmhBGVaC
 FY3TD/USu9O917a6rJF0c5mDPDM85AN5n2Ff8lvrH8V+xnRxICI+kWB3BECP51jg300JniXsxol
 TQ87eVhtSAwHPNtCjKU3ugnaw6bVrJNVUXizAF53KJpXeJJEgq34w8VJLU1t/d5szutCqN/YTc8
 vZZn9tvc/QT25Air9kcL+JMBZqOkGrcLbq65bYZaLqNN8FaFauRjvu5n+V/WNoQh1l1gZmNEN/5
 C6QGdtKIQoiJNFv2++kKGlUmm9+JnCAjWB4deRx7xgxak4Yk4dnjPNiZ8xwCXOoAHBbVpWxQjRd
 k0DMic4/n/WgwR6YKGEeW7TZ1a+ViU5Npjd8xqfs8aEjufPmYnFkOkRmr29nuzW8zP3ZMzeiCDE
 Tn9QSsOmGn4JehTa04ghFFKGte/Cx3yiRTTkZmMsQsZF3nr1A8A31DYKWh2gk9vM0yWj2hFfyoc
 JStXxgtGd/quhf1748ldNKgrjC74t3PA2OXpx72BaBHNoOB3xA6QJEXXXngg8OFFajaLQEflIMF
 46EH0JF2fMyOs7sAs4WlCa1PpECZgkMpkn3WQN5bSzXsrT2ZB69wjg3qa0TOU9FLYxXJG7+GBQP
 0xizGJALuQ3D74zBRPoxopdcPpc2XJopjT9ivT4cMVE54f84tZ4VpAb6RFeoSCy9nHgtHGjLvlz
 WsUAtwVoK/ZTY
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "mountinfo" sample userland program that demonstrates how to
use statmount() and listmount() to get at the same info that
/proc/pid/mountinfo provides.

The output of the program tries to mimic the mountinfo procfile
contents. With the -p flag, it can be pointed at an arbitrary pid to
print out info about its mount namespace. With the -r flag it will
attempt to walk all of the namespaces under the pid's mount namespace
and dump out mount info from all of them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 samples/vfs/.gitignore  |   1 +
 samples/vfs/Makefile    |   2 +-
 samples/vfs/mountinfo.c | 271 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+), 1 deletion(-)

diff --git a/samples/vfs/.gitignore b/samples/vfs/.gitignore
index 79212d91285bca72b0ff85f28aaccd2e803ac092..33a03cffe072fe2466c9df30ad47e9c58b0eea7c 100644
--- a/samples/vfs/.gitignore
+++ b/samples/vfs/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /test-fsmount
 /test-statx
+/mountinfo
diff --git a/samples/vfs/Makefile b/samples/vfs/Makefile
index 6377a678134acf0d682151d751d2f5042dbf5e0a..fb9bb33fdc751556e806aa897f0dbd48f7e3a4d8 100644
--- a/samples/vfs/Makefile
+++ b/samples/vfs/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-userprogs-always-y += test-fsmount test-statx
+userprogs-always-y += test-fsmount test-statx mountinfo
 
 userccflags += -I usr/include
diff --git a/samples/vfs/mountinfo.c b/samples/vfs/mountinfo.c
new file mode 100644
index 0000000000000000000000000000000000000000..d9f21113a93b7aa7606de2edfce5ad0d5bcf2056
--- /dev/null
+++ b/samples/vfs/mountinfo.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Use pidfds, nsfds, listmount() and statmount() mimic the
+ * contents of /proc/self/mountinfo.
+ */
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <linux/pidfd.h>
+#include <linux/mount.h>
+#include <linux/nsfs.h>
+#include <unistd.h>
+#include <alloca.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <errno.h>
+
+/* max mounts per listmount call */
+#define MAXMOUNTS		1024
+
+/* size of struct statmount (including trailing string buffer) */
+#define STATMOUNT_BUFSIZE	4096
+
+static bool ext_format;
+
+/*
+ * There are no bindings in glibc for listmount() and statmount() (yet),
+ * make our own here.
+ */
+static int statmount(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask,
+			    struct statmount *buf, size_t bufsize,
+			    unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = mnt_id,
+		.param = mask,
+	};
+
+	if (mnt_ns_id) {
+		req.size = MNT_ID_REQ_SIZE_VER1;
+		req.mnt_ns_id = mnt_ns_id;
+	}
+
+	return syscall(__NR_statmount, &req, buf, bufsize, flags);
+}
+
+static ssize_t listmount(uint64_t mnt_id, uint64_t mnt_ns_id,
+			 uint64_t last_mnt_id, uint64_t list[], size_t num,
+			 unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = mnt_id,
+		.param = last_mnt_id,
+	};
+
+	if (mnt_ns_id) {
+		req.size = MNT_ID_REQ_SIZE_VER1;
+		req.mnt_ns_id = mnt_ns_id;
+	}
+
+	return syscall(__NR_listmount, &req, list, num, flags);
+}
+
+static void show_mnt_attrs(uint64_t flags)
+{
+	printf("%s", flags & MOUNT_ATTR_RDONLY ? "ro" : "rw");
+
+	if (flags & MOUNT_ATTR_NOSUID)
+		printf(",nosuid");
+	if (flags & MOUNT_ATTR_NODEV)
+		printf(",nodev");
+	if (flags & MOUNT_ATTR_NOEXEC)
+		printf(",noexec");
+
+	switch (flags & MOUNT_ATTR__ATIME) {
+	case MOUNT_ATTR_RELATIME:
+		printf(",relatime");
+		break;
+	case MOUNT_ATTR_NOATIME:
+		printf(",noatime");
+		break;
+	case MOUNT_ATTR_STRICTATIME:
+		/* print nothing */
+		break;
+	}
+
+	if (flags & MOUNT_ATTR_NOSYMFOLLOW)
+		printf(",nosymfollow");
+	if (flags & MOUNT_ATTR_IDMAP)
+		printf(",idmapped");
+}
+
+static void show_propagation(struct statmount *sm)
+{
+	if (sm->mnt_propagation & MS_SHARED)
+		printf(" shared:%llu", sm->mnt_peer_group);
+	if (sm->mnt_propagation & MS_SLAVE) {
+		printf(" master:%llu", sm->mnt_master);
+		if (sm->mnt_master)
+			printf(" propagate_from:%llu", sm->propagate_from);
+	}
+	if (sm->mnt_propagation & MS_UNBINDABLE)
+		printf(" unbindable");
+}
+
+static void show_sb_flags(uint64_t flags)
+{
+	printf("%s", flags & MS_RDONLY ? "ro" : "rw");
+	if (flags & MS_SYNCHRONOUS)
+		printf(",sync");
+	if (flags & MS_DIRSYNC)
+		printf(",dirsync");
+	if (flags & MS_MANDLOCK)
+		printf(",mand");
+	if (flags & MS_LAZYTIME)
+		printf(",lazytime");
+}
+
+static int dump_mountinfo(uint64_t mnt_id, uint64_t mnt_ns_id)
+{
+	int ret;
+	struct statmount *buf = alloca(STATMOUNT_BUFSIZE);
+	const uint64_t mask = STATMOUNT_SB_BASIC | STATMOUNT_MNT_BASIC |
+				STATMOUNT_PROPAGATE_FROM | STATMOUNT_FS_TYPE |
+				STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT |
+				STATMOUNT_MNT_OPTS | STATMOUNT_FS_SUBTYPE |
+				STATMOUNT_SB_SOURCE;
+
+	ret = statmount(mnt_id, mnt_ns_id, mask, buf, STATMOUNT_BUFSIZE, 0);
+	if (ret < 0) {
+		perror("statmount");
+		return 1;
+	}
+
+	if (ext_format)
+		printf("0x%lx 0x%lx 0x%llx ", mnt_ns_id, mnt_id, buf->mnt_parent_id);
+
+	printf("%u %u %u:%u %s %s ", buf->mnt_id_old, buf->mnt_parent_id_old,
+				   buf->sb_dev_major, buf->sb_dev_minor,
+				   &buf->str[buf->mnt_root],
+				   &buf->str[buf->mnt_point]);
+	show_mnt_attrs(buf->mnt_attr);
+	show_propagation(buf);
+
+	printf(" - %s", &buf->str[buf->fs_type]);
+	if (buf->mask & STATMOUNT_FS_SUBTYPE)
+		printf(".%s", &buf->str[buf->fs_subtype]);
+	if (buf->mask & STATMOUNT_SB_SOURCE)
+		printf(" %s ", &buf->str[buf->sb_source]);
+	else
+		printf(" :none ");
+
+	show_sb_flags(buf->sb_flags);
+	if (buf->mask & STATMOUNT_MNT_OPTS)
+		printf(",%s", &buf->str[buf->mnt_opts]);
+	printf("\n");
+	return 0;
+}
+
+static int dump_mounts(uint64_t mnt_ns_id)
+{
+	uint64_t mntid[MAXMOUNTS];
+	uint64_t last_mnt_id = 0;
+	ssize_t count;
+	int i;
+
+	/*
+	 * Get a list of all mntids in mnt_ns_id. If it returns MAXMOUNTS
+	 * mounts, then go again until we get everything.
+	 */
+	do {
+		count = listmount(LSMT_ROOT, mnt_ns_id, last_mnt_id, mntid, MAXMOUNTS, 0);
+		if (count < 0 || count > MAXMOUNTS) {
+			errno = count < 0 ? errno : count;
+			perror("listmount");
+			return 1;
+		}
+
+		/* Walk the returned mntids and print info about each */
+		for (i = 0; i < count; ++i) {
+			int ret = dump_mountinfo(mntid[i], mnt_ns_id);
+
+			if (ret != 0)
+				return ret;
+		}
+		/* Set up last_mnt_id to pick up where we left off */
+		last_mnt_id = mntid[count - 1];
+	} while (count == MAXMOUNTS);
+	return 0;
+}
+
+static void usage(const char * const prog)
+{
+	printf("Usage:\n");
+	printf("%s [-e] [-p pid] [-r] [-h]\n", prog);
+	printf("    -e: extended format\n");
+	printf("    -h: print usage message\n");
+	printf("    -p: get mount namespace from given pid\n");
+	printf("    -r: recursively print all mounts in all child namespaces\n");
+}
+
+int main(int argc, char * const *argv)
+{
+	struct mnt_ns_info mni = { .size = MNT_NS_INFO_SIZE_VER0 };
+	int pidfd, mntns, ret, opt;
+	pid_t pid = getpid();
+	bool recursive = false;
+
+	while ((opt = getopt(argc, argv, "ehp:r")) != -1) {
+		switch (opt) {
+		case 'e':
+			ext_format = true;
+			break;
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		case 'p':
+			pid = atoi(optarg);
+			break;
+		case 'r':
+			recursive = true;
+			break;
+		}
+	}
+
+	/* Get a pidfd for pid */
+	pidfd = syscall(SYS_pidfd_open, pid, 0);
+	if (pidfd < 0) {
+		perror("pidfd_open");
+		return 1;
+	}
+
+	/* Get the mnt namespace for pidfd */
+	mntns = ioctl(pidfd, PIDFD_GET_MNT_NAMESPACE, NULL);
+	if (mntns < 0) {
+		perror("PIDFD_GET_MNT_NAMESPACE");
+		return 1;
+	}
+	close(pidfd);
+
+	/* get info about mntns. In particular, the mnt_ns_id */
+	ret = ioctl(mntns, NS_MNT_GET_INFO, &mni);
+	if (ret < 0) {
+		perror("NS_MNT_GET_INFO");
+		return 1;
+	}
+
+	do {
+		int ret;
+
+		ret = dump_mounts(mni.mnt_ns_id);
+		if (ret)
+			return ret;
+
+		if (!recursive)
+			break;
+
+		/* get the next mntns (and overwrite the old mount ns info) */
+		ret = ioctl(mntns, NS_MNT_GET_NEXT, &mni);
+		close(mntns);
+		mntns = ret;
+	} while (mntns >= 0);
+
+	return 0;
+}

-- 
2.47.0


