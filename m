Return-Path: <linux-fsdevel+bounces-5975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974C48118C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105EA28256F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B03219D;
	Wed, 13 Dec 2023 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBiCXzha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF8ED0
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 08:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702483871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=47OasWDHmF9MLtT9DkXDuN5xK+wIgO6PdTPjtETxiE8=;
	b=iBiCXzha7SP62+bL0V0PnR0JmbaMHjiDbsH5au71WnCPWmnv8VR8y7Ad7m9JLEpjHEFbEv
	wCZUgTbuqNA0kPVbOI7XnfF5zP2T9oSh9kgFELG/VaV7B8cvp1BXvlgyoR0LXVzq6cLQ8Z
	FE76yivOjsaBDAoaD5dAM6HwHmpi1V8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-uW9DFkSLNCOrKiT2dFkl7A-1; Wed, 13 Dec 2023 11:11:09 -0500
X-MC-Unique: uW9DFkSLNCOrKiT2dFkl7A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50be79e7f71so5484437e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 08:11:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702483867; x=1703088667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47OasWDHmF9MLtT9DkXDuN5xK+wIgO6PdTPjtETxiE8=;
        b=oeoRhzPRQZ2gV8k46naCCJ3ipKnex9J+6wsx16GkKC2teSt/BtfAjIfeqdJsfNydcJ
         Ty1DKZP2MSPyo/gUCeCIsb95LKbViojGyXbPhAyvjli4NgukeK1rd4MiirfK8xte00RS
         Pp3YxlQNDRLKA1GoQfhCqCE7z9gfPuopRPSv9UzVRcYD6Rk0GooLNjDhYCa94Hdx8NsK
         V5bMNmNVDKaaxeLCXutbVF8vE9hQil/4CbnePzDEw8pPHhH3cs3lkz5LopS6LKkA9qcI
         sPMjwMShZwND8NapicNo3K7w8ndRZkiJEYOrfLOnT2UQvV9X0UgULl2BAyPiHrtwZeXz
         c8sg==
X-Gm-Message-State: AOJu0YzNjXk2LIbAds7eaVEFngs7cEnYv3qPD78+5+/9xNBKQV5RHfOY
	w+IsfhNaR91k+8BSHJeoXRcQsD5HTdsNotwREfNO7TSSaHnnQFoCr8vc1LS68Qc94YVn62GaajO
	p5azn0uC1cxXJQr7lFyFbiBVsIBAk15n4bQ==
X-Received: by 2002:a19:2d0e:0:b0:50c:4ab:7983 with SMTP id k14-20020a192d0e000000b0050c04ab7983mr3082339lfj.32.1702483866615;
        Wed, 13 Dec 2023 08:11:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCvN0cnaXGXwzJZS5fQn8KPxdEbSyER8x5GmFUZJwEoDRRDXJkHFqO9i1fN6ftoBnT/T12HA==
X-Received: by 2002:a19:2d0e:0:b0:50c:4ab:7983 with SMTP id k14-20020a192d0e000000b0050c04ab7983mr3082331lfj.32.1702483866229;
        Wed, 13 Dec 2023 08:11:06 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-183-22.pool.digikabel.hu. [91.82.183.22])
        by smtp.gmail.com with ESMTPSA id vq6-20020a170907a4c600b00a1d5444c2cdsm8188608ejc.140.2023.12.13.08.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:11:05 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] add selftest for statmount/listmount
Date: Wed, 13 Dec 2023 17:11:03 +0100
Message-ID: <20231213161104.403171-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial selftest for the new statmount() and listmount() syscalls.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../filesystems/statmount/.gitignore          |   2 +
 .../selftests/filesystems/statmount/Makefile  |   6 +
 .../filesystems/statmount/statmount_test.c    | 614 ++++++++++++++++++
 4 files changed, 623 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/statmount/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/statmount/Makefile
 create mode 100644 tools/testing/selftests/filesystems/statmount/statmount_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 3b2061d1c1a5..da2e1b0e4dd8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -26,6 +26,7 @@ TARGETS += filesystems
 TARGETS += filesystems/binderfs
 TARGETS += filesystems/epoll
 TARGETS += filesystems/fat
+TARGETS += filesystems/statmount
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
new file mode 100644
index 000000000000..82a4846cbc4b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/statmount/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/*_test
diff --git a/tools/testing/selftests/filesystems/statmount/Makefile b/tools/testing/selftests/filesystems/statmount/Makefile
new file mode 100644
index 000000000000..07a0d5b545ca
--- /dev/null
+++ b/tools/testing/selftests/filesystems/statmount/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+TEST_GEN_PROGS := statmount_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
new file mode 100644
index 000000000000..a0fd907137f6
--- /dev/null
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -0,0 +1,614 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+
+#include <assert.h>
+#include <stdint.h>
+#include <sched.h>
+#include <fcntl.h>
+#include <sys/param.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/statfs.h>
+#include <linux/mount.h>
+#include <linux/stat.h>
+#include <asm/unistd.h>
+
+#include "../../kselftest.h"
+
+static const char *const known_fs[] = {
+	"9p", "adfs", "affs", "afs", "aio", "anon_inodefs", "apparmorfs",
+	"autofs", "bcachefs", "bdev", "befs", "bfs", "binder", "binfmt_misc",
+	"bpf", "btrfs", "btrfs_test_fs", "ceph", "cgroup", "cgroup2", "cifs",
+	"coda", "configfs", "cpuset", "cramfs", "cxl", "dax", "debugfs",
+	"devpts", "devtmpfs", "dmabuf", "drm", "ecryptfs", "efivarfs", "efs",
+	"erofs", "exfat", "ext2", "ext3", "ext4", "f2fs", "functionfs",
+	"fuse", "fuseblk", "fusectl", "gadgetfs", "gfs2", "gfs2meta", "hfs",
+	"hfsplus", "hostfs", "hpfs", "hugetlbfs", "ibmasmfs", "iomem",
+	"ipathfs", "iso9660", "jffs2", "jfs", "minix", "mqueue", "msdos",
+	"nfs", "nfs4", "nfsd", "nilfs2", "nsfs", "ntfs", "ntfs3", "ocfs2",
+	"ocfs2_dlmfs", "ocxlflash", "omfs", "openpromfs", "overlay", "pipefs",
+	"proc", "pstore", "pvfs2", "qnx4", "qnx6", "ramfs", "reiserfs",
+	"resctrl", "romfs", "rootfs", "rpc_pipefs", "s390_hypfs", "secretmem",
+	"securityfs", "selinuxfs", "smackfs", "smb3", "sockfs", "spufs",
+	"squashfs", "sysfs", "sysv", "tmpfs", "tracefs", "ubifs", "udf",
+	"ufs", "v7", "vboxsf", "vfat", "virtiofs", "vxfs", "xenfs", "xfs",
+	"zonefs", NULL };
+
+static int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
+		     size_t bufsize, unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = mnt_id,
+		.param = mask,
+	};
+
+	return syscall(__NR_statmount, &req, buf, bufsize, flags);
+}
+
+static struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mask, unsigned int flags)
+{
+	size_t bufsize = 1 << 15;
+	struct statmount *buf = NULL, *tmp = alloca(bufsize);
+	int tofree = 0;
+	int ret;
+
+	for (;;) {
+		ret = statmount(mnt_id, mask, tmp, bufsize, flags);
+		if (ret != -1)
+			break;
+		if (tofree)
+			free(tmp);
+		if (errno != EOVERFLOW)
+			return NULL;
+		bufsize <<= 1;
+		tofree = 1;
+		tmp = malloc(bufsize);
+		if (!tmp)
+			return NULL;
+	}
+	buf = malloc(tmp->size);
+	if (buf)
+		memcpy(buf, tmp, tmp->size);
+	if (tofree)
+		free(tmp);
+
+	return buf;
+}
+
+static void write_file(const char *path, const char *val)
+{
+	int fd = open(path, O_WRONLY);
+	size_t len = strlen(val);
+	int ret;
+
+	if (fd == -1)
+		ksft_exit_fail_msg("opening %s for write: %s\n", path, strerror(errno));
+
+	ret = write(fd, val, len);
+	if (ret == -1)
+		ksft_exit_fail_msg("writing to %s: %s\n", path, strerror(errno));
+	if (ret != len)
+		ksft_exit_fail_msg("short write to %s\n", path);
+
+	ret = close(fd);
+	if (ret == -1)
+		ksft_exit_fail_msg("closing %s\n", path);
+}
+
+static uint64_t get_mnt_id(const char *name, const char *path, uint64_t mask)
+{
+	struct statx sx;
+	int ret;
+
+	ret = statx(AT_FDCWD, path, 0, mask, &sx);
+	if (ret == -1)
+		ksft_exit_fail_msg("retrieving %s mount ID for %s: %s\n",
+				   mask & STATX_MNT_ID_UNIQUE ? "unique" : "old",
+				   name, strerror(errno));
+	if (!(sx.stx_mask & mask))
+		ksft_exit_fail_msg("no %s mount ID available for %s\n",
+				   mask & STATX_MNT_ID_UNIQUE ? "unique" : "old",
+				   name);
+
+	return sx.stx_mnt_id;
+}
+
+
+static char root_mntpoint[] = "/tmp/statmount_test_root.XXXXXX";
+static int orig_root;
+static uint64_t root_id, parent_id;
+static uint32_t old_root_id, old_parent_id;
+
+
+static void cleanup_namespace(void)
+{
+	fchdir(orig_root);
+	chroot(".");
+	umount2(root_mntpoint, MNT_DETACH);
+	rmdir(root_mntpoint);
+}
+
+static void setup_namespace(void)
+{
+	int ret;
+	char buf[32];
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+
+	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER);
+	if (ret == -1)
+		ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
+				   strerror(errno));
+
+	sprintf(buf, "0 %d 1", uid);
+	write_file("/proc/self/uid_map", buf);
+	write_file("/proc/self/setgroups", "deny");
+	sprintf(buf, "0 %d 1", gid);
+	write_file("/proc/self/gid_map", buf);
+
+	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+	if (ret == -1)
+		ksft_exit_fail_msg("making mount tree private: %s\n",
+				   strerror(errno));
+
+	if (!mkdtemp(root_mntpoint))
+		ksft_exit_fail_msg("creating temporary directory %s: %s\n",
+				   root_mntpoint, strerror(errno));
+
+	old_parent_id = get_mnt_id("parent", root_mntpoint, STATX_MNT_ID);
+	parent_id = get_mnt_id("parent", root_mntpoint, STATX_MNT_ID_UNIQUE);
+
+	orig_root = open("/", O_PATH);
+	if (orig_root == -1)
+		ksft_exit_fail_msg("opening root directory: %s",
+				   strerror(errno));
+
+	atexit(cleanup_namespace);
+
+	ret = mount(root_mntpoint, root_mntpoint, NULL, MS_BIND, NULL);
+	if (ret == -1)
+		ksft_exit_fail_msg("mounting temp root %s: %s\n",
+				   root_mntpoint, strerror(errno));
+
+	ret = chroot(root_mntpoint);
+	if (ret == -1)
+		ksft_exit_fail_msg("chroot to temp root %s: %s\n",
+				   root_mntpoint, strerror(errno));
+
+	ret = chdir("/");
+	if (ret == -1)
+		ksft_exit_fail_msg("chdir to root: %s\n", strerror(errno));
+
+	old_root_id = get_mnt_id("root", "/", STATX_MNT_ID);
+	root_id = get_mnt_id("root", "/", STATX_MNT_ID_UNIQUE);
+}
+
+static int setup_mount_tree(int log2_num)
+{
+	int ret, i;
+
+	ret = mount("", "/", NULL, MS_REC|MS_SHARED, NULL);
+	if (ret == -1) {
+		ksft_test_result_fail("making mount tree shared: %s\n",
+				   strerror(errno));
+		return -1;
+	}
+
+	for (i = 0; i < log2_num; i++) {
+		ret = mount("/", "/", NULL, MS_BIND, NULL);
+		if (ret == -1) {
+			ksft_test_result_fail("mounting submount %s: %s\n",
+					      root_mntpoint, strerror(errno));
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
+			 uint64_t list[], size_t num, unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = mnt_id,
+		.param = last_mnt_id,
+	};
+
+	return syscall(__NR_listmount, &req, list, num, flags);
+}
+
+static void test_listmount_empty_root(void)
+{
+	ssize_t res;
+	const unsigned int size = 32;
+	uint64_t list[size];
+
+	res = listmount(LSMT_ROOT, 0, list, size, 0);
+	if (res == -1) {
+		ksft_test_result_fail("listmount: %s\n", strerror(errno));
+		return;
+	}
+	if (res != 1) {
+		ksft_test_result_fail("listmount result is %zi != 1\n", res);
+		return;
+	}
+
+	if (list[0] != root_id) {
+		ksft_test_result_fail("listmount ID doesn't match 0x%llx != 0x%llx\n",
+				      (unsigned long long) list[0],
+				      (unsigned long long) root_id);
+		return;
+	}
+
+	ksft_test_result_pass("listmount empty root\n");
+}
+
+static void test_statmount_zero_mask(void)
+{
+	struct statmount sm;
+	int ret;
+
+	ret = statmount(root_id, 0, &sm, sizeof(sm), 0);
+	if (ret == -1) {
+		ksft_test_result_fail("statmount zero mask: %s\n",
+				      strerror(errno));
+		return;
+	}
+	if (sm.size != sizeof(sm)) {
+		ksft_test_result_fail("unexpected size: %u != %u\n",
+				      sm.size, (uint32_t) sizeof(sm));
+		return;
+	}
+	if (sm.mask != 0) {
+		ksft_test_result_fail("unexpected mask: 0x%llx != 0x0\n",
+				      (unsigned long long) sm.mask);
+		return;
+	}
+
+	ksft_test_result_pass("statmount zero mask\n");
+}
+
+static void test_statmount_mnt_basic(void)
+{
+	struct statmount sm;
+	int ret;
+	uint64_t mask = STATMOUNT_MNT_BASIC;
+
+	ret = statmount(root_id, mask, &sm, sizeof(sm), 0);
+	if (ret == -1) {
+		ksft_test_result_fail("statmount mnt basic: %s\n",
+				      strerror(errno));
+		return;
+	}
+	if (sm.size != sizeof(sm)) {
+		ksft_test_result_fail("unexpected size: %u != %u\n",
+				      sm.size, (uint32_t) sizeof(sm));
+		return;
+	}
+	if (sm.mask != mask) {
+		ksft_test_result_skip("statmount mnt basic unavailable\n");
+		return;
+	}
+
+	if (sm.mnt_id != root_id) {
+		ksft_test_result_fail("unexpected root ID: 0x%llx != 0x%llx\n",
+				      (unsigned long long) sm.mnt_id,
+				      (unsigned long long) root_id);
+		return;
+	}
+
+	if (sm.mnt_id_old != old_root_id) {
+		ksft_test_result_fail("unexpected old root ID: %u != %u\n",
+				      sm.mnt_id_old, old_root_id);
+		return;
+	}
+
+	if (sm.mnt_parent_id != parent_id) {
+		ksft_test_result_fail("unexpected parent ID: 0x%llx != 0x%llx\n",
+				      (unsigned long long) sm.mnt_parent_id,
+				      (unsigned long long) parent_id);
+		return;
+	}
+
+	if (sm.mnt_parent_id_old != old_parent_id) {
+		ksft_test_result_fail("unexpected old parent ID: %u != %u\n",
+				      sm.mnt_parent_id_old, old_parent_id);
+		return;
+	}
+
+	if (sm.mnt_propagation != MS_PRIVATE) {
+		ksft_test_result_fail("unexpected propagation: 0x%llx\n",
+				      (unsigned long long) sm.mnt_propagation);
+		return;
+	}
+
+	ksft_test_result_pass("statmount mnt basic\n");
+}
+
+
+static void test_statmount_sb_basic(void)
+{
+	struct statmount sm;
+	int ret;
+	uint64_t mask = STATMOUNT_SB_BASIC;
+	struct statx sx;
+	struct statfs sf;
+
+	ret = statmount(root_id, mask, &sm, sizeof(sm), 0);
+	if (ret == -1) {
+		ksft_test_result_fail("statmount sb basic: %s\n",
+				      strerror(errno));
+		return;
+	}
+	if (sm.size != sizeof(sm)) {
+		ksft_test_result_fail("unexpected size: %u != %u\n",
+				      sm.size, (uint32_t) sizeof(sm));
+		return;
+	}
+	if (sm.mask != mask) {
+		ksft_test_result_skip("statmount sb basic unavailable\n");
+		return;
+	}
+
+	ret = statx(AT_FDCWD, "/", 0, 0, &sx);
+	if (ret == -1) {
+		ksft_test_result_fail("stat root failed: %s\n",
+				      strerror(errno));
+		return;
+	}
+
+	if (sm.sb_dev_major != sx.stx_dev_major ||
+	    sm.sb_dev_minor != sx.stx_dev_minor) {
+		ksft_test_result_fail("unexpected sb dev %u:%u != %u:%u\n",
+				      sm.sb_dev_major, sm.sb_dev_minor,
+				      sx.stx_dev_major, sx.stx_dev_minor);
+		return;
+	}
+
+	ret = statfs("/", &sf);
+	if (ret == -1) {
+		ksft_test_result_fail("statfs root failed: %s\n",
+				      strerror(errno));
+		return;
+	}
+
+	if (sm.sb_magic != sf.f_type) {
+		ksft_test_result_fail("unexpected sb magic: 0x%llx != 0x%lx\n",
+				      (unsigned long long) sm.sb_magic,
+				      sf.f_type);
+		return;
+	}
+
+	ksft_test_result_pass("statmount sb basic\n");
+}
+
+static void test_statmount_mnt_point(void)
+{
+	struct statmount *sm;
+
+	sm = statmount_alloc(root_id, STATMOUNT_MNT_POINT, 0);
+	if (!sm) {
+		ksft_test_result_fail("statmount mount point: %s\n",
+				      strerror(errno));
+		return;
+	}
+
+	if (strcmp(sm->str + sm->mnt_point, "/") != 0) {
+		ksft_test_result_fail("unexpected mount point: '%s' != '/'\n",
+				      sm->str + sm->mnt_point);
+		goto out;
+	}
+	ksft_test_result_pass("statmount mount point\n");
+out:
+	free(sm);
+}
+
+static void test_statmount_mnt_root(void)
+{
+	struct statmount *sm;
+	const char *mnt_root, *last_dir, *last_root;
+
+	last_dir = strrchr(root_mntpoint, '/');
+	assert(last_dir);
+	last_dir++;
+
+	sm = statmount_alloc(root_id, STATMOUNT_MNT_ROOT, 0);
+	if (!sm) {
+		ksft_test_result_fail("statmount mount root: %s\n",
+				      strerror(errno));
+		return;
+	}
+	mnt_root = sm->str + sm->mnt_root;
+	last_root = strrchr(mnt_root, '/');
+	if (last_root)
+		last_root++;
+	else
+		last_root = mnt_root;
+
+	if (strcmp(last_dir, last_root) != 0) {
+		ksft_test_result_fail("unexpected mount root last component: '%s' != '%s'\n",
+				      last_root, last_dir);
+		goto out;
+	}
+	ksft_test_result_pass("statmount mount root\n");
+out:
+	free(sm);
+}
+
+static void test_statmount_fs_type(void)
+{
+	struct statmount *sm;
+	const char *fs_type;
+	const char *const *s;
+
+	sm = statmount_alloc(root_id, STATMOUNT_FS_TYPE, 0);
+	if (!sm) {
+		ksft_test_result_fail("statmount fs type: %s\n",
+				      strerror(errno));
+		return;
+	}
+	fs_type = sm->str + sm->fs_type;
+	for (s = known_fs; s != NULL; s++) {
+		if (strcmp(fs_type, *s) == 0)
+			break;
+	}
+	if (!s)
+		ksft_print_msg("unknown filesystem type: %s\n", fs_type);
+
+	ksft_test_result_pass("statmount fs type\n");
+	free(sm);
+}
+
+static void test_statmount_string(uint64_t mask, size_t off, const char *name)
+{
+	struct statmount *sm;
+	size_t len, shortsize, exactsize;
+	uint32_t start, i;
+	int ret;
+
+	sm = statmount_alloc(root_id, mask, 0);
+	if (!sm) {
+		ksft_test_result_fail("statmount %s: %s\n", name,
+				      strerror(errno));
+		goto out;
+	}
+	if (sm->size < sizeof(*sm)) {
+		ksft_test_result_fail("unexpected size: %u < %u\n",
+				      sm->size, (uint32_t) sizeof(*sm));
+		goto out;
+	}
+	if (sm->mask != mask) {
+		ksft_test_result_skip("statmount %s unavailable\n", name);
+		goto out;
+	}
+	len = sm->size - sizeof(*sm);
+	start = ((uint32_t *) sm)[off];
+
+	for (i = start;; i++) {
+		if (i >= len) {
+			ksft_test_result_fail("string out of bounds\n");
+			goto out;
+		}
+		if (!sm->str[i])
+			break;
+	}
+	exactsize = sm->size;
+	shortsize = sizeof(*sm) + i;
+
+	//ksft_print_msg("%s: %s\n", name, sm->str + start);
+
+	ret = statmount(root_id, mask, sm, exactsize, 0);
+	if (ret == -1) {
+		ksft_test_result_fail("statmount exact size: %s\n",
+				      strerror(errno));
+		goto out;
+	}
+	errno = 0;
+	ret = statmount(root_id, mask, sm, shortsize, 0);
+	if (ret != -1 || errno != EOVERFLOW) {
+		ksft_test_result_fail("should have failed with EOVERFLOW: %s\n",
+				      strerror(errno));
+		goto out;
+	}
+
+	ksft_test_result_pass("statmount string %s\n", name);
+out:
+	free(sm);
+}
+
+static void test_listmount_tree(void)
+{
+	ssize_t res;
+	const unsigned int log2_num = 4;
+	const unsigned int step = 3;
+	const unsigned int size = (1 << log2_num) + step + 1;
+	size_t num, expect = 1 << log2_num;
+	uint64_t list[size];
+	uint64_t list2[size];
+	size_t i;
+
+
+	res = setup_mount_tree(log2_num);
+	if (res == -1)
+		return;
+
+	num = res = listmount(LSMT_ROOT, 0, list, size, 0);
+	if (res == -1) {
+		ksft_test_result_fail("listmount: %s\n", strerror(errno));
+		return;
+	}
+	if (num != expect) {
+		ksft_test_result_fail("listmount result is %zi != %zi\n",
+				      res, expect);
+		return;
+	}
+
+	for (i = 0; i < size - step;) {
+		res = listmount(LSMT_ROOT, i ? list2[i - 1] : 0, list2 + i, step, 0);
+		if (res == -1)
+			ksft_test_result_fail("short listmount: %s\n",
+					      strerror(errno));
+		i += res;
+		if (res < step)
+			break;
+	}
+	if (i != num) {
+		ksft_test_result_fail("different number of entries: %zu != %zu\n",
+				      i, num);
+		return;
+	}
+	for (i = 0; i < num; i++) {
+		if (list2[i] != list[i]) {
+			ksft_test_result_fail("differet value for entry %zu: 0x%llx != 0x%llx\n",
+					      i,
+					      (unsigned long long) list2[i],
+					      (unsigned long long) list[i]);
+		}
+	}
+
+	ksft_test_result_pass("listmount tree\n");
+}
+
+#define str_off(memb) (offsetof(struct statmount, memb) / sizeof(uint32_t))
+
+int main(void)
+{
+	int ret;
+	uint64_t all_mask = STATMOUNT_SB_BASIC | STATMOUNT_MNT_BASIC |
+		STATMOUNT_PROPAGATE_FROM | STATMOUNT_MNT_ROOT |
+		STATMOUNT_MNT_POINT | STATMOUNT_FS_TYPE;
+
+	ksft_print_header();
+
+	ret = statmount(0, 0, NULL, 0, 0);
+	assert(ret == -1);
+	if (errno == ENOSYS)
+		ksft_exit_skip("statmount() syscall not supported\n");
+
+	setup_namespace();
+
+	ksft_set_plan(14);
+	test_listmount_empty_root();
+	test_statmount_zero_mask();
+	test_statmount_mnt_basic();
+	test_statmount_sb_basic();
+	test_statmount_mnt_root();
+	test_statmount_mnt_point();
+	test_statmount_fs_type();
+	test_statmount_string(STATMOUNT_MNT_ROOT, str_off(mnt_root), "mount root");
+	test_statmount_string(STATMOUNT_MNT_POINT, str_off(mnt_point), "mount point");
+	test_statmount_string(STATMOUNT_FS_TYPE, str_off(fs_type), "fs type");
+	test_statmount_string(all_mask, str_off(mnt_root), "mount root & all");
+	test_statmount_string(all_mask, str_off(mnt_point), "mount point & all");
+	test_statmount_string(all_mask, str_off(fs_type), "fs type & all");
+
+	test_listmount_tree();
+
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
-- 
2.43.0


