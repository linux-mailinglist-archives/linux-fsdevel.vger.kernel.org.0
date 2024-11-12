Return-Path: <linux-fsdevel+bounces-34552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 960EA9C634B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BC284533
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ECB21A4C4;
	Tue, 12 Nov 2024 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axTfAV+w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77B2170DF;
	Tue, 12 Nov 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446499; cv=none; b=Upx2n0mRPgN1Zw+UEVnOBWGUw0ChNSgZjj+mdDVoZve0w2LxNKACJNgG8kw0U/4xaN/fuKNmbOKGh2M1syF0+nFQamvnVmjQc2ZP1fZspFgtshJ9YqBTrBn8cw1eSzz2v3gjgPJLyVvAPkXFEB8BOeeOzE3xGuTwDJYxEsLJ3hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446499; c=relaxed/simple;
	bh=T96Qp/4AKc6FR7Cuqja+5rQrMnQ+Rqvh4z7bfEOWJlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B0BIFHQ9e0G4CfoRW8OVrpufYPqElPHcOKxynYX4lh2E8dFO5N4XaOkN/IL7WKqVh0fWAzIJQFQARNS9TvEdRyHwA609uxgXj31YXZMo3QruoMNclRVLbBKkcYFC3xbym8pIYzn0ajJJFJSn4UD4LfmAmwsqnnqlVd6crZJfmqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axTfAV+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EDDC4CECD;
	Tue, 12 Nov 2024 21:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731446498;
	bh=T96Qp/4AKc6FR7Cuqja+5rQrMnQ+Rqvh4z7bfEOWJlM=;
	h=From:Date:Subject:To:Cc:From;
	b=axTfAV+w0uuH9xfoN/RUQ+cX1Z1cuIoV8IG/oSt1AIsqNsNWXVsLdpePmtRFq/nnT
	 J2zCbbKkCZW5xdXQM03j/IEGtTN3u99v9YFAmJkreGvy4D72OBMma3UV18j8F/KVs3
	 nA7E+DFFL1xbEtusyd/9612suhaYOa0PbQSjYO1Gu/66xaW9wz+pQu9XZ9Jlm4RWKk
	 59YuuQu+zsQyXKfjGRYX6tRow/dFV6EkRfujIz6PF3A0rEMHH1EWk0uI39yjWc8Dak
	 N6PDxL3PuhKLH74WwhlRqYa3qdMwic24dWKNz2LnoBTEIZLJncUkJHAM4YWs5qFGWK
	 +VfGkSCWpMK5A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 12 Nov 2024 16:21:23 -0500
Subject: [PATCH] samples: add a mountinfo program to demonstrate
 statmount()/listmount()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-statmount-v1-1-d98090c4c8be@kernel.org>
X-B4-Tracking: v=1; b=H4sIANLGM2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQ0Mj3eKSxJLc/NK8El1zcwsDi6RkAyNjAyMloPqCotS0zAqwWdGxtbU
 AbAs+c1sAAAA=
X-Change-ID: 20241112-statmount-77808bc02302
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9224; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=T96Qp/4AKc6FR7Cuqja+5rQrMnQ+Rqvh4z7bfEOWJlM=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnM8bdn8OaUpJL42DXop6FssQy98VQ0L0c0wTUz
 EMMPjHZ/n+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzPG3QAKCRAADmhBGVaC
 FbIHEACPpO2HWM7cC+0wOxFx18yyb/3DaIkLHSjhfKVSDHU353dWVtvhSBUBWVEQhwIfQjSTjEg
 Bqp6MPokR5O/P0fdDJt1yu35pNQKBxgSTGn2Jr8novD8voj2gkoIyGyqyyKLXSwc56PPN8Ln+e5
 vTCvKDIoiHFaiv7FWbgbHJ8DEfm56x8ujw56oV/qqy8n7+M6X15a964kNeKqXY5XoO5WMXa2n+G
 HZGm2hs790DP6CXFG8X97m6ylvMyT71Fh9bYypQ1781plcwbuSrss4KctPnxH7pV5qOBNqBUq7l
 S2NjDx6Q/LIrKKspOuBUj0WatlAjz5PQmJrZVM/KhrMuWx2HLclJGpEdO2ju0IrYVq3xMuc6igw
 iD5uJaBQ7Nz+D8V4kZMBGMVmPY5Xa7vdo7Is2gyfWhkbPV6Uv99daZbqRe46ZLFewFF5YtpenBw
 kgfaDsip5c0kJ2cWL2N9/YIPhOfhcGXsQFdevA8HixtaGHpC8N4imxDrjZ3J2ilDADbtcvUja1Z
 c9ADapiuSE41EAAtcsCrnINrmddMcm4IJVAV0CkWxaPqXNaUKUjijb0sVz3SvBtTM87kn/3Q85S
 TaoqOSXSGY0Z/25pdUWi61Z+eTPymleX+KQGCeZKL73YUDy3Mz4Q35qiNcuzomrsd1Q3QvLv6Nj
 T0LVk7KWI3nIZ6w==
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
We had some recent queries internally asking how to use the new
statmount() and listmount() interfaces. I was doing some other work in
this area, so I whipped up this tool. My hope is that this will
represent something of a "rosetta stone" for how to translate between
mountinfo and statmount(), and an example for other people looking to
use the new interfaces.

It may also be possible to use this as the basis for a statmount()
testcase. We can call this program, and compare its output to the
mountinfo file.
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
index 0000000000000000000000000000000000000000..7f430835dd7fb1a3d87d98cad00c619dbb5c6f70
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
+		last_mnt_id = mntid[count - 1] + 1;
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

---
base-commit: 3def14eb3d2e9d452623af64e315605150292aa8
change-id: 20241112-statmount-77808bc02302

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


