Return-Path: <linux-fsdevel+bounces-48613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B1AB154C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C75189DF44
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9F292095;
	Fri,  9 May 2025 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHLoXexF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CB2918F7
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797574; cv=none; b=gNn98W5P48wYRX3FW1b/YmzzTyyBebrZbOwTek6hyvRxg5fqDiRctnGZiOvPx5qCvJp3qGQdN++j57+TVC8NlYFIiPfXAZT5MYtoP7cqFbuIjY9TZcCj74iot/c5VEHzE12vtpWYhQOfo0m9D6gKQQv1BSN7/DMZkcdABnyhlzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797574; c=relaxed/simple;
	bh=m0qjCnjqBJkvh4LJc1QDdOUVkkw15MTsosSGP+c9qIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dA2C9FclYcqGZDO5HBLIdaGBtC6i7vqhjsUji2xhwgLGOHOmOsOQOB1qXbXY8IuNGjm3YX2GghhN8sU2KXo4bouE5SnS+SX9eDgxhYptoqdZFn4+4j7dSATWfkPFv0LzHK7tc05gZutVliunh/CCxzsygXq+OXwuxF2LtN+SqX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHLoXexF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so21436925e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797571; x=1747402371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j69MUcorVUpp/VfPYf98dLNGZsyZX0pjd+VYi3sfsec=;
        b=VHLoXexFEe1pjjmbIIT4eo0mn7mtjt+bnSvgdnPCvYeg6AfYlE7b/FdO+ap27v4olO
         4FjUW8g+swSv+TNyBiXYwR/dUi6m8FutM+GKB500bviw4qbINZus3A88DNuXzusdP+0n
         TCpVISqr9OeJCakvr1tHiNM4B0K4+/+3omU1dAHZ/xXRsBNuGtZi+XLS8A0/pN6orG08
         ItuV22lq/b/QrCsT1kgfk+VcXTZ96IxcDr9+afsm6TqH1ImYRdae1rxAd5cl+7GDmltk
         BYmV/do+VlSqQ3ZLRVsbULczEKZQCPOO05Rhg8iHDWrFTxx9ocnXZl1pn1dKesqer95H
         suBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797571; x=1747402371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j69MUcorVUpp/VfPYf98dLNGZsyZX0pjd+VYi3sfsec=;
        b=h/5PXad4LMJTcelN2UsoY4JHw/3gAek85GchlFzEzIxY7R1+WoASfYmcAtqAFbxkP4
         qB5oRejC2eg61EeE1ZvVM3VIMhY0xbm1RA6qW/nAZuR/AXXgmqANe49swiuF+c+kWHNS
         qAXG9MKkNBkFWEwHqiv7Pyxqi8VdPfARxT8UWhP+iuZ6fHESehs0O1v4TCGhS5PI7OX9
         1nUc7HuZPTNt9cML/vYxNiiqDnXMlNN9W9HdawdNxjKXX51aGUQi06xtM8Y8fr8GjI97
         sicMvyS9pgvE092p4KdOHTEwkSsTY5lPhOP4z6rhq8wWEeY+zWc1D9v6qUuelQ33hMYq
         B34Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzGjl3IRTsS4uKfCgYW/lYA7nXllNl1NlFoT3K5CGEVgLRQICrF0eZYdToOYwM9fog4WOi4z+zQIwWHpwy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3lWcl04PXmTXBFXYC3UzlyxAHEx4lBRtCGMEMUq6e4BTOQBDp
	xiU1Zc9SDOUm1zkEntJ+EqsjL8tVg5IcQLH3mWq6SEFfZ8Y4EBBr
X-Gm-Gg: ASbGncvbtO7n/U7zZYFRY3lLZfAn4hKFwaRjcr9ORNLwJ2NyF5YfLiC68RBNpLOKsiN
	eXBuA20bX7BKgAZkjbLh2MSCXyG8PDpLqf+PbPMQ/dUju86lhCmt8uzwB4RZhV970plsaIGIyOr
	L7l3q9tTAMYEMcb1SMuWAz2cl2NBrtogTj3stA3fIfUDP//ySX6B11/4y897fC+yMBNhe0gqzdk
	i7AH5zenWUUsbA19ZD8+2AaBzRNdcElNJoG2BrK2JAZX8MnZbVDGJyDoaye4pwQ4Umq9leUGjaQ
	H9t+rbhCL0H3mBdnTOGbGdk1n1mxeuBSbvttEgSDwPwh0gPcIQNYiK93qiO9wi38kacFSyOykc5
	kuumD4diuft/SmvmudluX2qkzCeZP7lIVxWdtog==
X-Google-Smtp-Source: AGHT+IEqUkMxgM4zA0G+DfsG14p4DoYg4h+3ub+XhPrAgnpqTnM+N/FZzcFjomNhh+hgNWrWP6d/bA==
X-Received: by 2002:a05:600c:a409:b0:43c:e7a7:aea0 with SMTP id 5b1f17b1804b1-442d780033fmr17592925e9.26.1746797570289;
        Fri, 09 May 2025 06:32:50 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3232899f8f.4.2025.05.09.06.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:32:49 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 8/8] selftests/fs/mount-notify: add a test variant running inside userns
Date: Fri,  9 May 2025 15:32:40 +0200
Message-Id: <20250509133240.529330-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509133240.529330-1-amir73il@gmail.com>
References: <20250509133240.529330-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unshare userns in addition to mntns and verify that:

1. watching tmpfs mounted inside userns is allowed with any mark type
2. watching orig root with filesystem mark type is not allowed
3. watching mntns of orig userns is not allowed
4. watching mntns in userns where fanotify_init was called is allowed

mount events are only tested with the last case of mntns mark.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../filesystems/mount-notify/.gitignore       |   1 +
 .../filesystems/mount-notify/Makefile         |   3 +-
 .../mount-notify/mount-notify_test_ns.c       | 557 ++++++++++++++++++
 3 files changed, 560 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c

diff --git a/tools/testing/selftests/filesystems/mount-notify/.gitignore b/tools/testing/selftests/filesystems/mount-notify/.gitignore
index 82a4846cbc4b..124339ea7845 100644
--- a/tools/testing/selftests/filesystems/mount-notify/.gitignore
+++ b/tools/testing/selftests/filesystems/mount-notify/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /*_test
+/*_test_ns
diff --git a/tools/testing/selftests/filesystems/mount-notify/Makefile b/tools/testing/selftests/filesystems/mount-notify/Makefile
index 55a2e5399e8a..836a4eb7be06 100644
--- a/tools/testing/selftests/filesystems/mount-notify/Makefile
+++ b/tools/testing/selftests/filesystems/mount-notify/Makefile
@@ -3,8 +3,9 @@
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
-TEST_GEN_PROGS := mount-notify_test
+TEST_GEN_PROGS := mount-notify_test mount-notify_test_ns
 
 include ../../lib.mk
 
 $(OUTPUT)/mount-notify_test: ../utils.c
+$(OUTPUT)/mount-notify_test_ns: ../utils.c
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
new file mode 100644
index 000000000000..62dda5bec1e5
--- /dev/null
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -0,0 +1,557 @@
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
+#include <unistd.h>
+#include <sys/syscall.h>
+
+#include "../../kselftest_harness.h"
+#include "../../pidfd/pidfd.h"
+#include "../statmount/statmount.h"
+#include "../utils.h"
+
+// Needed for linux/fanotify.h
+#ifndef __kernel_fsid_t
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#endif
+
+#include <sys/fanotify.h>
+
+static const char root_mntpoint_templ[] = "/tmp/mount-notify_test_root.XXXXXX";
+
+static const int mark_types[] = {
+	FAN_MARK_FILESYSTEM,
+	FAN_MARK_MOUNT,
+	FAN_MARK_INODE
+};
+
+static const int mark_cmds[] = {
+	FAN_MARK_ADD,
+	FAN_MARK_REMOVE,
+	FAN_MARK_FLUSH
+};
+
+#define NUM_FAN_FDS ARRAY_SIZE(mark_cmds)
+
+FIXTURE(fanotify) {
+	int fan_fd[NUM_FAN_FDS];
+	char buf[256];
+	unsigned int rem;
+	void *next;
+	char root_mntpoint[sizeof(root_mntpoint_templ)];
+	int orig_root;
+	int orig_ns_fd;
+	int ns_fd;
+	uint64_t root_id;
+};
+
+FIXTURE_SETUP(fanotify)
+{
+	int i, ret;
+
+	self->orig_ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
+	ASSERT_GE(self->orig_ns_fd, 0);
+
+	ret = setup_userns();
+	ASSERT_EQ(ret, 0);
+
+	self->ns_fd = open("/proc/self/ns/mnt", O_RDONLY);
+	ASSERT_GE(self->ns_fd, 0);
+
+	strcpy(self->root_mntpoint, root_mntpoint_templ);
+	ASSERT_NE(mkdtemp(self->root_mntpoint), NULL);
+
+	self->orig_root = open("/", O_PATH | O_CLOEXEC);
+	ASSERT_GE(self->orig_root, 0);
+
+	ASSERT_EQ(mount("tmpfs", self->root_mntpoint, "tmpfs", 0, NULL), 0);
+
+	ASSERT_EQ(chroot(self->root_mntpoint), 0);
+
+	ASSERT_EQ(chdir("/"), 0);
+
+	ASSERT_EQ(mkdir("a", 0700), 0);
+
+	ASSERT_EQ(mkdir("b", 0700), 0);
+
+	self->root_id = get_unique_mnt_id("/");
+	ASSERT_NE(self->root_id, 0);
+
+	for (i = 0; i < NUM_FAN_FDS; i++) {
+		int fan_fd = fanotify_init(FAN_REPORT_FID, 0);
+		// Verify that watching tmpfs mounted inside userns is allowed
+		ret = fanotify_mark(fan_fd, FAN_MARK_ADD | mark_types[i],
+				    FAN_OPEN, AT_FDCWD, "/");
+		ASSERT_EQ(ret, 0);
+		// ...but watching entire orig root filesystem is not allowed
+		ret = fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
+				    FAN_OPEN, self->orig_root, ".");
+		ASSERT_NE(ret, 0);
+		close(fan_fd);
+
+		self->fan_fd[i] = fanotify_init(FAN_REPORT_MNT | FAN_NONBLOCK,
+						0);
+		ASSERT_GE(self->fan_fd[i], 0);
+		// Verify that watching mntns where group was created is allowed
+		ret = fanotify_mark(self->fan_fd[i], FAN_MARK_ADD |
+				    FAN_MARK_MNTNS,
+				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    self->ns_fd, NULL);
+		ASSERT_EQ(ret, 0);
+		// ...but watching orig mntns is not allowed
+		ret = fanotify_mark(self->fan_fd[i], FAN_MARK_ADD |
+				    FAN_MARK_MNTNS,
+				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    self->orig_ns_fd, NULL);
+		ASSERT_NE(ret, 0);
+		// On fd[0] we do an extra ADD that changes nothing.
+		// On fd[1]/fd[2] we REMOVE/FLUSH which removes the mark.
+		ret = fanotify_mark(self->fan_fd[i], mark_cmds[i] |
+				    FAN_MARK_MNTNS,
+				    FAN_MNT_ATTACH | FAN_MNT_DETACH,
+				    self->ns_fd, NULL);
+		ASSERT_EQ(ret, 0);
+	}
+
+	self->rem = 0;
+}
+
+FIXTURE_TEARDOWN(fanotify)
+{
+	int i;
+
+	ASSERT_EQ(self->rem, 0);
+	for (i = 0; i < NUM_FAN_FDS; i++)
+		close(self->fan_fd[i]);
+
+	ASSERT_EQ(fchdir(self->orig_root), 0);
+
+	ASSERT_EQ(chroot("."), 0);
+
+	EXPECT_EQ(umount2(self->root_mntpoint, MNT_DETACH), 0);
+	EXPECT_EQ(chdir(self->root_mntpoint), 0);
+	EXPECT_EQ(chdir("/"), 0);
+	EXPECT_EQ(rmdir(self->root_mntpoint), 0);
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
+		ssize_t len;
+		int i;
+
+		for (i = NUM_FAN_FDS - 1; i >= 0; i--) {
+			len = read(self->fan_fd[i], self->buf,
+				   sizeof(self->buf));
+			if (i > 0) {
+				// Groups 1,2 should get EAGAIN
+				ASSERT_EQ(len, -1);
+				ASSERT_EQ(errno, EAGAIN);
+			} else {
+				// Group 0 should get events
+				ASSERT_GT(len, 0);
+			}
+		}
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
+	uint64_t mnts[2] = { self->root_id };
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
+	uint64_t mnts[2] = { self->root_id };
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
+	mnts[0] = self->root_id;
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
+	mnts2[0] = self->root_id;
+	expect_notify_mask_n(_metadata, self, FAN_MNT_DETACH, num - 1, mnts2 + 1);
+	verify_mount_ids(_metadata, mnts, mnts2, num);
+
+	check_mounted(_metadata, mnts, 1);
+}
+
+TEST_F(fanotify, fsmount)
+{
+	int ret, fs, mnt;
+	uint64_t mnts[2] = { self->root_id };
+
+	fs = fsopen("tmpfs", 0);
+	ASSERT_GE(fs, 0);
+
+	ret = fsconfig(fs, FSCONFIG_CMD_CREATE, 0, 0, 0);
+	ASSERT_EQ(ret, 0);
+
+	mnt = fsmount(fs, 0, 0);
+	ASSERT_GE(mnt, 0);
+
+	close(fs);
+
+	ret = move_mount(mnt, "", AT_FDCWD, "/a", MOVE_MOUNT_F_EMPTY_PATH);
+	ASSERT_EQ(ret, 0);
+
+	close(mnt);
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
+	uint64_t mnts[6] = { self->root_id };
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
+	uint64_t mnts[3] = { self->root_id };
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
+}
+
+TEST_F(fanotify, pivot_root)
+{
+	uint64_t mnts[3] = { self->root_id };
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
+TEST_HARNESS_MAIN
-- 
2.34.1


