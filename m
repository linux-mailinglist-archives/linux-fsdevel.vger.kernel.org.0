Return-Path: <linux-fsdevel+bounces-43482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6EDA57301
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 21:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A993B2D73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E7D183CB0;
	Fri,  7 Mar 2025 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jbysp31G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3092571DF
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380055; cv=none; b=RbJNffgmIJ1oOalEWP3BQo6lXUniZZ30dUg2omOfOvn49NKl5SKon7uCS7uhjSTGL/Sve1HbnG958+SVmn0lc3osqCAfPauWHUqtx4WNDTZj5wDKdWM9ADUEZ+Z7Ix2Go+R4xRzGD1usz2ILUjK7lxP68LrWA8v7TlxFo+QKfXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380055; c=relaxed/simple;
	bh=/WWzGrAlKWN7w2lncMwX9c3aa3tX3rFAbr0d1AiTMgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g08aJ/OCz2avRhbBKeZaBLYpWEYkYAm19VF3735s/C4vLLsTtCcbxxNIzHcBEAp8CBLccUd79ybAYjywPeiZaUvkYCi46TimFiRx61Yz8tVEFClXn5AEtMvAv20tAsYDGIP4H7dz7vOe1qEgMI/QEvZ4p30Ai61hxptuD221ZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jbysp31G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741380051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wy6LEQEQOyEfpS3hbWbxv+U9DIJ3e8OmmXQ78lInqzA=;
	b=Jbysp31G9iX10FSWk3Dc5MFufJgyVxB91Rogd9eAwZPzg53B+o4Tza9LEjIufImHaAZtRQ
	ceNh3Q3Lxs7vCmWweRP4gRXkDjwy63FjveEmgPMO03ECk9vfBTvVfco+LtNrE2CEh6yxO3
	3PwxzBwLd8if6+rV4+iwpJgQvXVR+zc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-xsG5lLLaMY2vADVWc3FVEw-1; Fri, 07 Mar 2025 15:40:50 -0500
X-MC-Unique: xsG5lLLaMY2vADVWc3FVEw-1
X-Mimecast-MFC-AGG-ID: xsG5lLLaMY2vADVWc3FVEw_1741380049
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac22704d52aso193396666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 12:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741380049; x=1741984849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wy6LEQEQOyEfpS3hbWbxv+U9DIJ3e8OmmXQ78lInqzA=;
        b=NOXOssqim9dUO4RX1hV2M7xPdG4CnJsVQ+PGT0ZnzIa1oZBfSaI5tp3L2nCP8tAJlA
         BglJPIHXs7ZoIwA+cYY4Y+FB276SpYIwesN/NMLiUYIX9b6sz6V5e8gtiXzKE8evH96c
         9onSLyaG/9/3h9lQiI7W5dQ0zWQ0rE4J3ej9fkl6Sw2/yRdwzRHf9AiUhbtU3ZhPqTIm
         w3oaWtoLfQDZi+TF0SBBETDzlLiwvxJoxNbMK5fdoGBDrLLcBCyc9K70FpIP+tLc0mXF
         HNliAISuQmzTAa6EGKTh2Fd1VFUWpg79w+S3u0gIqvX2MqGCjx/c6n0J3dFAKHu3V53w
         ik6Q==
X-Gm-Message-State: AOJu0YwF8hCm0CQueSs5fTyObqcrEPsuygEiRhaMvw43X1879GBkXhm6
	izKDdUNoT9cPZ9aOdFRPUklk3Z5rpEatT7wXlpc0G3HNMJo8oR8ruxha5rcUuXV8R12aw6jNWye
	y7Y1oRB74p8VRSes/0E/cD4tW8ziD9HWEF6DUtpnpWwljqgOdElBZHkYk4RJoIOTE9IrD3O7WWi
	yUZY6lDFWUf12wVVBrClDibRO0DNkerusQuxW7jHHOoMnI/sOcUg==
X-Gm-Gg: ASbGncsAYp5OO9QTkPf5vESGFwQ3CinZL1oRRS8CHZyIyaTt5b1Kumb4XwYy/kSj7g/
	0suyBtv436DTg9WuiWu7YlEXPst8ffBr5hktSfrFM1Bzl7j6wSQj70oigNlQFQxbzLGe+oGX869
	gIH7R4Ud30QC44fIWS9wrMQwPSwjGePMy2aJW+gWOltRs5UohQjAznfDgLwYJoGpgtYzduIEy8o
	mHFVY8QgUijATMnGMWk2y5aymZmRzbjWEXUDjy923/7BcTR2JUHyqd2AJdEZOufGgCUc3V5r7ce
	oBe3KgsKwkOxO4H5YeM9edpeUhF19reIcYyZuIcZCggYJWb1sp/aFiH+t/yWyCYawjiHog==
X-Received: by 2002:a17:906:b385:b0:ac1:daba:c6c with SMTP id a640c23a62f3a-ac2526df221mr440559966b.24.1741380048412;
        Fri, 07 Mar 2025 12:40:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzWZCbjqzPnF5FrXuxv6TURADEwiHUslp4NduvdsT1PdaBcqFVAUlNNTi8U6Mc0AOVGR6URw==
X-Received: by 2002:a17:906:b385:b0:ac1:daba:c6c with SMTP id a640c23a62f3a-ac2526df221mr440557666b.24.1741380047858;
        Fri, 07 Mar 2025 12:40:47 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (91-82-178-230.pool.digikabel.hu. [91.82.178.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239482f9asm332388566b.51.2025.03.07.12.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 12:40:47 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] selftests: add tests for mount notification
Date: Fri,  7 Mar 2025 21:40:45 +0100
Message-ID: <20250307204046.322691-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide coverage for all mnt_notify_add() instances.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../filesystems/mount-notify/.gitignore       |   2 +
 .../filesystems/mount-notify/Makefile         |   6 +
 .../mount-notify/mount-notify_test.c          | 586 ++++++++++++++++++
 .../filesystems/statmount/statmount.h         |   2 +-
 5 files changed, 596 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/mount-notify/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/mount-notify/Makefile
 create mode 100644 tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8daac70c2f9d..2ebaf5e6942e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -35,6 +35,7 @@ TARGETS += filesystems/epoll
 TARGETS += filesystems/fat
 TARGETS += filesystems/overlayfs
 TARGETS += filesystems/statmount
+TARGETS += filesystems/mount-notify
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
diff --git a/tools/testing/selftests/filesystems/mount-notify/.gitignore b/tools/testing/selftests/filesystems/mount-notify/.gitignore
new file mode 100644
index 000000000000..82a4846cbc4b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount-notify/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/*_test
diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile b/tools/testing/selftests/filesystems/mount-notify/Makefile
new file mode 100644
index 000000000000..10be0227b5ae
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount-notify/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
+TEST_GEN_PROGS := mount-notify_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
new file mode 100644
index 000000000000..d39ff57bf163
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2025 Miklos Szeredi <miklos@szeredi.hu>
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <linux/fanotify.h>
+#include <unistd.h>
+#include <sys/fanotify.h>
+#include <sys/syscall.h>
+
+#include "../../kselftest_harness.h"
+#include "../statmount/statmount.h"
+
+static char root_mntpoint[] = "/tmp/mount-notify_test_root.XXXXXX";
+static int orig_root, ns_fd;
+static uint64_t root_id;
+
+static uint64_t get_mnt_id(const char *path)
+{
+	struct statx sx;
+	int ret;
+
+	ret = statx(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
+	if (ret == -1)
+		ksft_exit_fail_perror("retrieving mount ID");
+
+	if (!(sx.stx_mask & STATX_MNT_ID_UNIQUE))
+		ksft_exit_fail_msg("no mount ID available\n");
+
+	return sx.stx_mnt_id;
+}
+
+static void cleanup_namespace(void)
+{
+	int ret;
+
+	ret = fchdir(orig_root);
+	if (ret == -1)
+		ksft_perror("fchdir to original root");
+
+	ret = chroot(".");
+	if (ret == -1)
+		ksft_perror("chroot to original root");
+
+	umount2(root_mntpoint, MNT_DETACH);
+	chdir(root_mntpoint);
+	rmdir("a");
+	rmdir("b");
+	chdir("/");
+	rmdir(root_mntpoint);
+}
+
+static void setup_namespace(void)
+{
+	int ret;
+
+	ret = unshare(CLONE_NEWNS);
+	if (ret == -1)
+		ksft_exit_fail_perror("unsharing mountns and userns");
+
+	ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
+	if (ns_fd == -1)
+		ksft_exit_fail_perror("opening /proc/self/ns/mnt");
+
+	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+	if (ret == -1)
+		ksft_exit_fail_perror("making mount tree private");
+
+	if (!mkdtemp(root_mntpoint))
+		ksft_exit_fail_perror("creating temporary directory");
+
+	orig_root = open("/", O_PATH);
+	if (orig_root == -1)
+		ksft_exit_fail_perror("opening root directory");
+
+	atexit(cleanup_namespace);
+
+	ret = mount(root_mntpoint, root_mntpoint, NULL, MS_BIND, NULL);
+	if (ret == -1)
+		ksft_exit_fail_perror("mounting temp root");
+
+	ret = chroot(root_mntpoint);
+	if (ret == -1)
+		ksft_exit_fail_perror("chroot to temp root");
+
+	ret = chdir("/");
+	if (ret == -1)
+		ksft_exit_fail_perror("chdir to root");
+
+	ret = mkdir("a", 0700);
+	if (ret == -1)
+		ksft_exit_fail_perror("mkdir(a)");
+
+	ret = mkdir("b", 0700);
+	if (ret == -1)
+		ksft_exit_fail_perror("mkdir(b)");
+
+	root_id = get_mnt_id("/");
+}
+
+FIXTURE(fanotify) {
+	int fan_fd;
+	char buf[256];
+	unsigned int rem;
+	void *next;
+};
+
+#define MAX_MNTS 256
+#define MAX_PATH 256
+
+FIXTURE_SETUP(fanotify)
+{
+	uint64_t list[MAX_MNTS];
+	ssize_t num;
+	size_t bufsize = sizeof(struct statmount) + MAX_PATH;
+	struct statmount *buf = alloca(bufsize);
+	unsigned int i;
+	int ret;
+
+	// Clean up mount tree
+	ret = mount("", "/", NULL, MS_PRIVATE, NULL);
+	ASSERT_EQ(ret, 0);
+
+	num = listmount(LSMT_ROOT, 0, 0, list, MAX_MNTS, 0);
+	ASSERT_GE(num, 1);
+	ASSERT_LT(num, MAX_MNTS);
+
+	for (i = 0; i < num; i++) {
+		if (list[i] == root_id)
+			continue;
+		ret = statmount(list[i], 0, STATMOUNT_MNT_POINT, buf, bufsize, 0);
+		if (ret == 0 && buf->mask & STATMOUNT_MNT_POINT)
+			umount2(buf->str + buf->mnt_point, MNT_DETACH);
+	}
+	num = listmount(LSMT_ROOT, 0, 0, list, 2, 0);
+	ASSERT_EQ(num, 1);
+	ASSERT_EQ(list[0], root_id);
+
+	mkdir("/a", 0700);
+	mkdir("/b", 0700);
+
+	self->fan_fd = fanotify_init(FAN_REPORT_MNT, 0);
+	ASSERT_GE(self->fan_fd, 0);
+
+	ret = fanotify_mark(self->fan_fd, FAN_MARK_ADD | FAN_MARK_MNTNS,
+			    FAN_MNT_ATTACH | FAN_MNT_DETACH, ns_fd, NULL);
+	ASSERT_EQ(ret, 0);
+
+	self->rem = 0;
+}
+
+FIXTURE_TEARDOWN(fanotify)
+{
+	ASSERT_EQ(self->rem, 0);
+	close(self->fan_fd);
+}
+
+static uint64_t expect_notify(struct __test_metadata *const _metadata,
+			      FIXTURE_DATA(fanotify) *self,
+			      uint64_t *mask)
+{
+	struct fanotify_event_metadata *meta;
+	struct fanotify_event_info_mnt *mnt;
+	unsigned int thislen;
+
+	if (!self->rem) {
+		ssize_t len = read(self->fan_fd, self->buf, sizeof(self->buf));
+		ASSERT_GT(len, 0);
+
+		self->rem = len;
+		self->next = (void *) self->buf;
+	}
+
+	meta = self->next;
+	ASSERT_TRUE(FAN_EVENT_OK(meta, self->rem));
+
+	thislen = meta->event_len;
+	self->rem -= thislen;
+	self->next += thislen;
+
+	*mask = meta->mask;
+	thislen -= sizeof(*meta);
+
+	mnt = ((void *) meta) + meta->event_len - thislen;
+
+	ASSERT_EQ(thislen, sizeof(*mnt));
+
+	return mnt->mnt_id;
+}
+
+static void expect_notify_n(struct __test_metadata *const _metadata,
+				 FIXTURE_DATA(fanotify) *self,
+				 unsigned int n, uint64_t mask[], uint64_t mnts[])
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++)
+		mnts[i] = expect_notify(_metadata, self, &mask[i]);
+}
+
+static uint64_t expect_notify_mask(struct __test_metadata *const _metadata,
+				   FIXTURE_DATA(fanotify) *self,
+				   uint64_t expect_mask)
+{
+	uint64_t mntid, mask;
+
+	mntid = expect_notify(_metadata, self, &mask);
+	ASSERT_EQ(expect_mask, mask);
+
+	return mntid;
+}
+
+
+static void expect_notify_mask_n(struct __test_metadata *const _metadata,
+				 FIXTURE_DATA(fanotify) *self,
+				 uint64_t mask, unsigned int n, uint64_t mnts[])
+{
+	unsigned int i;
+
+	for (i = 0; i < n; i++)
+		mnts[i] = expect_notify_mask(_metadata, self, mask);
+}
+
+
+static void verify_mount_ids(struct __test_metadata *const _metadata,
+			     const uint64_t list1[], const uint64_t list2[],
+			     size_t num)
+{
+	unsigned int i, j;
+
+	// Check that neither list has any duplicates
+	for (i = 0; i < num; i++) {
+		for (j = 0; j < num; j++) {
+			if (i != j) {
+				ASSERT_NE(list1[i], list1[j]);
+				ASSERT_NE(list2[i], list2[j]);
+			}
+		}
+	}
+	// Check that all list1 memebers can be found in list2. Together with
+	// the above it means that the list1 and list2 represent the same sets.
+	for (i = 0; i < num; i++) {
+		for (j = 0; j < num; j++) {
+			if (list1[i] == list2[j])
+				break;
+		}
+		ASSERT_NE(j, num);
+	}
+}
+
+static void check_mounted(struct __test_metadata *const _metadata,
+			  const uint64_t mnts[], size_t num)
+{
+	ssize_t ret;
+	uint64_t *list;
+
+	list = malloc((num + 1) * sizeof(list[0]));
+	ASSERT_NE(list, NULL);
+
+	ret = listmount(LSMT_ROOT, 0, 0, list, num + 1, 0);
+	ASSERT_EQ(ret, num);
+
+	verify_mount_ids(_metadata, mnts, list, num);
+
+	free(list);
+}
+
+static void setup_mount_tree(struct __test_metadata *const _metadata,
+			    int log2_num)
+{
+	int ret, i;
+
+	ret = mount("", "/", NULL, MS_SHARED, NULL);
+	ASSERT_EQ(ret, 0);
+
+	for (i = 0; i < log2_num; i++) {
+		ret = mount("/", "/", NULL, MS_BIND, NULL);
+		ASSERT_EQ(ret, 0);
+	}
+}
+
+TEST_F(fanotify, bind)
+{
+	int ret;
+	uint64_t mnts[2] = { root_id };
+
+	ret = mount("/", "/", NULL, MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	mnts[1] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
+	ASSERT_NE(mnts[0], mnts[1]);
+
+	check_mounted(_metadata, mnts, 2);
+
+	// Cleanup
+	uint64_t detach_id;
+	ret = umount("/");
+	ASSERT_EQ(ret, 0);
+
+	detach_id = expect_notify_mask(_metadata, self, FAN_MNT_DETACH);
+	ASSERT_EQ(detach_id, mnts[1]);
+
+	check_mounted(_metadata, mnts, 1);
+}
+
+TEST_F(fanotify, move)
+{
+	int ret;
+	uint64_t mnts[2] = { root_id };
+	uint64_t move_id;
+
+	ret = mount("/", "/a", NULL, MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	mnts[1] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
+	ASSERT_NE(mnts[0], mnts[1]);
+
+	check_mounted(_metadata, mnts, 2);
+
+	ret = move_mount(AT_FDCWD, "/a", AT_FDCWD, "/b", 0);
+	ASSERT_EQ(ret, 0);
+
+	move_id = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH | FAN_MNT_DETACH);
+	ASSERT_EQ(move_id, mnts[1]);
+
+	// Cleanup
+	ret = umount("/b");
+	ASSERT_EQ(ret, 0);
+
+	check_mounted(_metadata, mnts, 1);
+}
+
+TEST_F(fanotify, propagate)
+{
+	const unsigned int log2_num = 4;
+	const unsigned int num = (1 << log2_num);
+	uint64_t mnts[num];
+
+	setup_mount_tree(_metadata, log2_num);
+
+	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH, num - 1, mnts + 1);
+
+	mnts[0] = root_id;
+	check_mounted(_metadata, mnts, num);
+
+	// Cleanup
+	int ret;
+	uint64_t mnts2[num];
+	ret = umount2("/", MNT_DETACH);
+	ASSERT_EQ(ret, 0);
+
+	ret = mount("", "/", NULL, MS_PRIVATE, NULL);
+	ASSERT_EQ(ret, 0);
+
+	mnts2[0] = root_id;
+	expect_notify_mask_n(_metadata, self, FAN_MNT_DETACH, num - 1, mnts2 + 1);
+	verify_mount_ids(_metadata, mnts, mnts2, num);
+
+	check_mounted(_metadata, mnts, 1);
+}
+
+TEST_F(fanotify, fsmount)
+{
+	int ret, fs, mnt;
+	uint64_t mnts[2] = { root_id };
+
+	fs = fsopen("tmpfs", 0);
+	ASSERT_GE(fs, 0);
+
+        ret = fsconfig(fs, FSCONFIG_CMD_CREATE, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+
+        mnt = fsmount(fs, 0, 0);
+	ASSERT_GE(mnt, 0);
+
+        close(fs);
+
+	ret = move_mount(mnt, "", AT_FDCWD, "/a", MOVE_MOUNT_F_EMPTY_PATH);
+	ASSERT_EQ(ret, 0);
+
+        close(mnt);
+
+	mnts[1] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
+	ASSERT_NE(mnts[0], mnts[1]);
+
+	check_mounted(_metadata, mnts, 2);
+
+	// Cleanup
+	uint64_t detach_id;
+	ret = umount("/a");
+	ASSERT_EQ(ret, 0);
+
+	detach_id = expect_notify_mask(_metadata, self, FAN_MNT_DETACH);
+	ASSERT_EQ(detach_id, mnts[1]);
+
+	check_mounted(_metadata, mnts, 1);
+}
+
+TEST_F(fanotify, reparent)
+{
+	uint64_t mnts[6] = { root_id };
+	uint64_t dmnts[3];
+	uint64_t masks[3];
+	unsigned int i;
+	int ret;
+
+	// Create setup with a[1] -> b[2] propagation
+	ret = mount("/", "/a", NULL, MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	ret = mount("", "/a", NULL, MS_SHARED, NULL);
+	ASSERT_EQ(ret, 0);
+
+	ret = mount("/a", "/b", NULL, MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	ret = mount("", "/b", NULL, MS_SLAVE, NULL);
+	ASSERT_EQ(ret, 0);
+
+	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH, 2, mnts + 1);
+
+	check_mounted(_metadata, mnts, 3);
+
+	// Mount on a[3], which is propagated to b[4]
+	ret = mount("/", "/a", NULL, MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH, 2, mnts + 3);
+
+	check_mounted(_metadata, mnts, 5);
+
+	// Mount on b[5], not propagated
+	ret = mount("/", "/b", NULL, MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	mnts[5] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
+
+	check_mounted(_metadata, mnts, 6);
+
+	// Umount a[3], which is propagated to b[4], but not b[5]
+	// This will result in b[5] "falling" on b[2]
+	ret = umount("/a");
+	ASSERT_EQ(ret, 0);
+
+	expect_notify_n(_metadata, self, 3, masks, dmnts);
+	verify_mount_ids(_metadata, mnts + 3, dmnts, 3);
+
+	for (i = 0; i < 3; i++) {
+		if (dmnts[i] == mnts[5]) {
+			ASSERT_EQ(masks[i], FAN_MNT_ATTACH | FAN_MNT_DETACH);
+		} else {
+			ASSERT_EQ(masks[i], FAN_MNT_DETACH);
+		}
+	}
+
+	mnts[3] = mnts[5];
+	check_mounted(_metadata, mnts, 4);
+
+	// Cleanup
+	ret = umount("/b");
+	ASSERT_EQ(ret, 0);
+
+	ret = umount("/a");
+	ASSERT_EQ(ret, 0);
+
+	ret = umount("/b");
+	ASSERT_EQ(ret, 0);
+
+	expect_notify_mask_n(_metadata, self, FAN_MNT_DETACH, 3, dmnts);
+	verify_mount_ids(_metadata, mnts + 1, dmnts, 3);
+
+	check_mounted(_metadata, mnts, 1);
+}
+
+TEST_F(fanotify, rmdir)
+{
+	uint64_t mnts[3] = { root_id };
+	int ret;
+
+	ret = mount("/", "/a", NULL, MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	ret = mount("/", "/a/b", NULL, MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH, 2, mnts + 1);
+
+	check_mounted(_metadata, mnts, 3);
+
+	ret = chdir("/a");
+	ASSERT_EQ(ret, 0);
+
+	ret = fork();
+	ASSERT_GE(ret, 0);
+
+	if (ret == 0) {
+		chdir("/");
+		unshare(CLONE_NEWNS);
+		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+		umount2("/a", MNT_DETACH);
+		// This triggers a detach in the other namespace
+		rmdir("/a");
+		exit(0);
+	}
+	wait(NULL);
+
+	expect_notify_mask_n(_metadata, self, FAN_MNT_DETACH, 2, mnts + 1);
+	check_mounted(_metadata, mnts, 1);
+
+	// Cleanup
+	ret = chdir("/");
+	ASSERT_EQ(ret, 0);
+
+	ret = mkdir("a", 0700);
+	ASSERT_EQ(ret, 0);
+}
+
+TEST_F(fanotify, pivot_root)
+{
+	uint64_t mnts[3] = { root_id };
+	uint64_t mnts2[3];
+	int ret;
+
+	ret = mount("tmpfs", "/a", "tmpfs", 0, NULL);
+	ASSERT_EQ(ret, 0);
+
+	mnts[2] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
+
+	ret = mkdir("/a/new", 0700);
+	ASSERT_EQ(ret, 0);
+
+	ret = mkdir("/a/old", 0700);
+	ASSERT_EQ(ret, 0);
+
+	ret = mount("/a", "/a/new", NULL, MS_BIND, NULL);
+	ASSERT_EQ(ret, 0);
+
+	mnts[1] = expect_notify_mask(_metadata, self, FAN_MNT_ATTACH);
+	check_mounted(_metadata, mnts, 3);
+
+	ret = syscall(SYS_pivot_root, "/a/new", "/a/new/old");
+	ASSERT_EQ(ret, 0);
+
+	expect_notify_mask_n(_metadata, self, FAN_MNT_ATTACH | FAN_MNT_DETACH, 2, mnts2);
+	verify_mount_ids(_metadata, mnts, mnts2, 2);
+	check_mounted(_metadata, mnts, 3);
+
+	// Cleanup
+	ret = syscall(SYS_pivot_root, "/old", "/old/a/new");
+	ASSERT_EQ(ret, 0);
+
+	ret = umount("/a/new");
+	ASSERT_EQ(ret, 0);
+
+	ret = umount("/a");
+	ASSERT_EQ(ret, 0);
+
+	check_mounted(_metadata, mnts, 1);
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+
+	ksft_print_header();
+
+	if (geteuid())
+		ksft_exit_skip("mount notify requires root privileges\n");
+
+	ret = fanotify_init(FAN_REPORT_MNT, 0);
+	if (ret == -1) {
+		if (errno == EINVAL)
+			ksft_exit_skip("FAN_REPORT_MNT not supported\n");
+		ksft_exit_fail_perror("fanotify_init(FAN_REPORT_MNT, 0)");
+	}
+	close(ret);
+
+	setup_namespace();
+
+	return test_harness_run(argc, argv);
+}
diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h b/tools/testing/selftests/filesystems/statmount/statmount.h
index f4294bab9d73..a7a5289ddae9 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount.h
+++ b/tools/testing/selftests/filesystems/statmount/statmount.h
@@ -25,7 +25,7 @@ static inline int statmount(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask,
 	return syscall(__NR_statmount, &req, buf, bufsize, flags);
 }
 
-static ssize_t listmount(uint64_t mnt_id, uint64_t mnt_ns_id,
+static inline ssize_t listmount(uint64_t mnt_id, uint64_t mnt_ns_id,
 			 uint64_t last_mnt_id, uint64_t list[], size_t num,
 			 unsigned int flags)
 {
-- 
2.48.1


