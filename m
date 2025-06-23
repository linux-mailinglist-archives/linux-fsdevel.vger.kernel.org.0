Return-Path: <linux-fsdevel+bounces-52643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8BEAE4DBB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 21:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B99189CD8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 19:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374EC2D5430;
	Mon, 23 Jun 2025 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="M5Uba4Iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7102D5417
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 19:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750707911; cv=none; b=LVTl08/SZlbFTMkbsK/ReePA8fXEYjFdryGfPvNYKGF1VvhcMHi8HW3KX/v18kz+LLchJDEygbYlAb9JzhoAVCPx0+oZ8MAKcdLQPFfVbj2j4VCtwBYxM286FdWA0N+LebJTsclWa5gWfnps8gJEbIXzT1t67+J2HovUo25AlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750707911; c=relaxed/simple;
	bh=7GN73VAH7Gib+8OU+sJ8tOTqzHfU8wd8HxrUZvJngdw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R8mIqo0U74taSyGhmDTQnKaGI2bVZWG8XfB0CqKv2eTzuaajUbPBTCv7KVbqgkKTdUi1P7Rp7Y+o7xGZt3cuKkhpY7J8JacDc79NlvEsnww7tibTuRKGo+gO7BOJqCNt2oc1T2ayrhzEdlyObfyjwme+E88oui1zra2F9oHRhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=M5Uba4Iy; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NIgF5N009297
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:45:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=QR1hhYctvbRGynYAk7
	wsNnWb34aSFx8GKjexVLGdwAE=; b=M5Uba4IyTFZov4gaUpix04KeJusO8rA8QH
	atEABSy+reWnARE5i1ylHkOFD/bvHJJBeP1mdOyqpWHRdZ0bmq/t0epMZDPqTaVA
	MzOuls0Gx4j6G7ZwZ1Veq/JLmjVsnuBZ+sS3KGrGgmr5ZQfwZp2CldtUmFj4syXf
	DmL1JzheoW54Qgd7K6VUlIZ3sYonHG99B12lorWSGvFVmvoPSUfHqvMlqAOH7ssy
	ErFPZ77t2OOZCnx8+3Dgej7HIpP1LRg2L1oy1IB1nCPaKQNPmmxvu/CfxW8g7KQE
	aANWYNGB2wXH9ctfPDkbT/hYoSOm/yti6OISISPwWgZteWzpGlQg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47en1xyyk8-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 12:45:08 -0700 (PDT)
Received: from twshared4564.15.prn3.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 23 Jun 2025 19:45:03 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 88D6430431D58; Mon, 23 Jun 2025 12:45:01 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <ibrahimjirdeh@meta.com>
CC: <jack@suse.cz>, <amir73il@gmail.com>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH] fanotify: selftests for fanotify permission events
Date: Mon, 23 Jun 2025 12:44:55 -0700
Message-ID: <20250623194455.2847844-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=bs5MBFai c=1 sm=1 tr=0 ts=6859aec4 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=6IFa9wvqVegA:10 a=VabnemYjAAAA:8 a=SlLpaudUyM84AMwXJDgA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEyOCBTYWx0ZWRfXwQubgk0wgi+I JCTgWqjyXLvLLy3LpAzfmzE9pEpy0PMV4Z+yDTfrFoKZnzc3W7raIOF6oaJCqosq/6ympElcBtS l+PL0wio1zZ0aVvRtZTWxV2nLCGw94ZVQPlNSkcwzcb6ssk0Ov4GMO2+F9G4l1gICBdQkXLWXW0
 hY6pFgMGVwiWsFDGHt24LcaqWLGJiT9wU2wWGkTqjq9/dtMSpVtfds7lx/DoQ9aMlozC9ERE6f0 jYcS1kj9j0IBwcre3Kn53N+D1/56rfbQDEbxZzc5vR6Fg5yiNHbJ4UppDsBKYoJAh/IGReNf1BL T2Q/hXQn32dPf+e4mG1CBZZOuzueNGevEoU6h06p/zElPE+Vi+9IxNQHkgjgbrsT99hSuYQpLcX
 DRks7B1d9iMZz2a1bn9NF25KbA4UOoe4PZ8SnolHRC1sX1/Cm1pnGCmByP5Cdpv9Zk1Kqqr8
X-Proofpoint-ORIG-GUID: vBEisAG98UKCltUicAChT4RxrnEkHxBg
X-Proofpoint-GUID: vBEisAG98UKCltUicAChT4RxrnEkHxBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_06,2025-06-23_07,2025-03-28_01

This adds selftests which exercise generating / responding to
permission events. They requre root privileges since
FAN_CLASS_PRE_CONTENT requires it.

Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/fanotify/.gitignore |   2 +
 .../selftests/filesystems/fanotify/Makefile   |   8 +
 .../filesystems/fanotify/fanotify_perm_test.c | 386 ++++++++++++++++++
 4 files changed, 397 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/fanotify/.gitigno=
re
 create mode 100644 tools/testing/selftests/filesystems/fanotify/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fanotify/fanotify=
_perm_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
index 339b31e6a6b5..9cae71edca9f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -32,6 +32,7 @@ TARGETS +=3D fchmodat2
 TARGETS +=3D filesystems
 TARGETS +=3D filesystems/binderfs
 TARGETS +=3D filesystems/epoll
+TARGETS +=3D filesystems/fanotify
 TARGETS +=3D filesystems/fat
 TARGETS +=3D filesystems/overlayfs
 TARGETS +=3D filesystems/statmount
diff --git a/tools/testing/selftests/filesystems/fanotify/.gitignore b/to=
ols/testing/selftests/filesystems/fanotify/.gitignore
new file mode 100644
index 000000000000..a9f51c9aca9f
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fanotify/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+fanotify_perm_test
diff --git a/tools/testing/selftests/filesystems/fanotify/Makefile b/tool=
s/testing/selftests/filesystems/fanotify/Makefile
new file mode 100644
index 000000000000..931bedd989b9
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fanotify/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS +=3D -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+LDLIBS +=3D -lcap
+
+TEST_GEN_PROGS :=3D fanotify_perm_test
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/fanotify/fanotify_perm_t=
est.c b/tools/testing/selftests/filesystems/fanotify/fanotify_perm_test.c
new file mode 100644
index 000000000000..87d718323b1a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fanotify/fanotify_perm_test.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <sys/syscall.h>
+#include <limits.h>
+
+#include "../../kselftest_harness.h"
+
+// Needed for linux/fanotify.h
+#ifndef __kernel_fsid_t
+typedef struct {
+	int val[2];
+} __kernel_fsid_t;
+#endif
+#include <sys/fanotify.h>
+
+static const char test_dir_templ[] =3D "/tmp/fanotify_perm_test.XXXXXX";
+
+FIXTURE(fanotify)
+{
+	char test_dir[sizeof(test_dir_templ)];
+	char test_dir2[sizeof(test_dir_templ)];
+	int fan_fd;
+	int fan_fd2;
+	char test_file_path[PATH_MAX];
+	char test_file_path2[PATH_MAX];
+	char test_exec_path[PATH_MAX];
+};
+
+FIXTURE_SETUP(fanotify)
+{
+	int ret;
+
+	/* Setup test directories and files */
+	strcpy(self->test_dir, test_dir_templ);
+	ASSERT_NE(mkdtemp(self->test_dir), NULL);
+	strcpy(self->test_dir2, test_dir_templ);
+	ASSERT_NE(mkdtemp(self->test_dir2), NULL);
+
+	snprintf(self->test_file_path, PATH_MAX, "%s/test_file",
+		 self->test_dir);
+	snprintf(self->test_file_path2, PATH_MAX, "%s/test_file2",
+		 self->test_dir2);
+	snprintf(self->test_exec_path, PATH_MAX, "%s/test_exec",
+		 self->test_dir);
+
+	ret =3D open(self->test_file_path, O_CREAT | O_RDWR, 0644);
+	ASSERT_GE(ret, 0);
+	ASSERT_EQ(write(ret, "test data", 9), 9);
+	close(ret);
+
+	ret =3D open(self->test_file_path2, O_CREAT | O_RDWR, 0644);
+	ASSERT_GE(ret, 0);
+	ASSERT_EQ(write(ret, "test data2", 9), 9);
+	close(ret);
+
+	ret =3D open(self->test_exec_path, O_CREAT | O_RDWR, 0755);
+	ASSERT_GE(ret, 0);
+	ASSERT_EQ(write(ret, "#!/bin/bash\necho test\n", 22), 22);
+	close(ret);
+
+	self->fan_fd =3D fanotify_init(
+		FAN_CLASS_PRE_CONTENT | FAN_NONBLOCK | FAN_CLOEXEC, O_RDONLY);
+	ASSERT_GE(self->fan_fd, 0);
+
+	self->fan_fd2 =3D fanotify_init(FAN_CLASS_PRE_CONTENT | FAN_NONBLOCK |
+					      FAN_CLOEXEC | FAN_ENABLE_EVENT_ID,
+				      O_RDONLY);
+	ASSERT_GE(self->fan_fd2, 0);
+
+	/* Mark the directories for permission events */
+	ret =3D fanotify_mark(self->fan_fd, FAN_MARK_ADD,
+			    FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM |
+				    FAN_EVENT_ON_CHILD,
+			    AT_FDCWD, self->test_dir);
+	ASSERT_EQ(ret, 0);
+
+	ret =3D fanotify_mark(self->fan_fd2, FAN_MARK_ADD,
+			    FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM |
+				    FAN_EVENT_ON_CHILD,
+			    AT_FDCWD, self->test_dir2);
+	ASSERT_EQ(ret, 0);
+}
+
+FIXTURE_TEARDOWN(fanotify)
+{
+	/* Clean up test directory and files */
+	if (self->fan_fd > 0)
+		close(self->fan_fd);
+	if (self->fan_fd2 > 0)
+		close(self->fan_fd2);
+
+	EXPECT_EQ(unlink(self->test_file_path), 0);
+	EXPECT_EQ(unlink(self->test_file_path2), 0);
+	EXPECT_EQ(unlink(self->test_exec_path), 0);
+	EXPECT_EQ(rmdir(self->test_dir), 0);
+	EXPECT_EQ(rmdir(self->test_dir2), 0);
+}
+
+static struct fanotify_event_metadata *get_event(int fd)
+{
+	struct fanotify_event_metadata *metadata;
+	ssize_t len;
+	char buf[256];
+
+	len =3D read(fd, buf, sizeof(buf));
+	if (len <=3D 0)
+		return NULL;
+
+	metadata =3D (void *)buf;
+	if (!FAN_EVENT_OK(metadata, len))
+		return NULL;
+
+	return metadata;
+}
+
+static int respond_to_event(int fd, struct fanotify_event_metadata *meta=
data,
+			    uint32_t response, bool useEventId)
+{
+	struct fanotify_response resp;
+
+	if (useEventId) {
+		resp.event_id =3D metadata->event_id;
+	} else {
+		resp.fd =3D metadata->fd;
+	}
+	resp.response =3D response;
+
+	return write(fd, &resp, sizeof(resp));
+}
+
+static void verify_event(struct __test_metadata *const _metadata,
+			 struct fanotify_event_metadata *event,
+			 uint64_t expect_mask, int expect_pid)
+{
+	ASSERT_NE(event, NULL);
+	ASSERT_EQ(event->mask, expect_mask);
+
+	if (expect_pid > 0)
+		ASSERT_EQ(event->pid, expect_pid);
+}
+
+TEST_F(fanotify, open_perm_allow)
+{
+	struct fanotify_event_metadata *event;
+	int fd, ret;
+	pid_t child;
+
+	child =3D fork();
+	ASSERT_GE(child, 0);
+
+	if (child =3D=3D 0) {
+		/* Try to open the file - this should trigger FAN_OPEN_PERM */
+		fd =3D open(self->test_file_path, O_RDONLY);
+		if (fd < 0)
+			exit(EXIT_FAILURE);
+		close(fd);
+		exit(EXIT_SUCCESS);
+	}
+
+	usleep(100000);
+	event =3D get_event(self->fan_fd);
+	verify_event(_metadata, event, FAN_OPEN_PERM, child);
+
+	/* Allow the open operation */
+	close(event->fd);
+	ret =3D respond_to_event(self->fan_fd, event, FAN_ALLOW,
+			       false /* useEventId */);
+	ASSERT_EQ(ret, sizeof(struct fanotify_response));
+
+	int status;
+
+	ASSERT_EQ(waitpid(child, &status, 0), child);
+	ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
+}
+
+TEST_F(fanotify, open_perm_deny)
+{
+	struct fanotify_event_metadata *event;
+	int ret;
+	pid_t child;
+
+	child =3D fork();
+	ASSERT_GE(child, 0);
+
+	if (child =3D=3D 0) {
+		/* Try to open the file - this should trigger FAN_OPEN_PERM */
+		int fd =3D open(self->test_file_path, O_RDONLY);
+
+		/* If open succeeded, this is an error as we expect it to be denied */
+		if (fd >=3D 0) {
+			close(fd);
+			exit(EXIT_FAILURE);
+		}
+
+		/* Verify the expected error */
+		if (errno =3D=3D EPERM)
+			exit(EXIT_SUCCESS);
+
+		exit(EXIT_FAILURE);
+	}
+
+	usleep(100000);
+	event =3D get_event(self->fan_fd);
+	verify_event(_metadata, event, FAN_OPEN_PERM, child);
+
+	/* Deny the open operation */
+	close(event->fd);
+	ret =3D respond_to_event(self->fan_fd, event, FAN_DENY,
+			       false /* useEventId */);
+	ASSERT_EQ(ret, sizeof(struct fanotify_response));
+
+	int status;
+
+	ASSERT_EQ(waitpid(child, &status, 0), child);
+	ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
+}
+
+TEST_F(fanotify, exec_perm_allow)
+{
+	struct fanotify_event_metadata *event;
+	int ret;
+	pid_t child;
+
+	child =3D fork();
+	ASSERT_GE(child, 0);
+
+	if (child =3D=3D 0) {
+		/* Try to execute the file - this should trigger FAN_OPEN_EXEC_PERM */
+		execl(self->test_exec_path, "test_exec", NULL);
+
+		/* If we get here, execl failed */
+		exit(EXIT_FAILURE);
+	}
+
+	usleep(100000);
+	event =3D get_event(self->fan_fd);
+	verify_event(_metadata, event, FAN_OPEN_EXEC_PERM, child);
+
+	/* Allow the exec operation + ignore subsequent events */
+	ASSERT_GE(fanotify_mark(self->fan_fd,
+				FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
+					FAN_MARK_IGNORED_SURV_MODIFY,
+				FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM, event->fd,
+				NULL),
+		  0);
+	close(event->fd);
+	ret =3D respond_to_event(self->fan_fd, event, FAN_ALLOW,
+			       false /* useEventId */);
+	ASSERT_EQ(ret, sizeof(struct fanotify_response));
+
+	int status;
+
+	ASSERT_EQ(waitpid(child, &status, 0), child);
+	ASSERT_EQ(WIFEXITED(status), 1);
+}
+
+TEST_F(fanotify, exec_perm_deny)
+{
+	struct fanotify_event_metadata *event;
+	int ret;
+	pid_t child;
+
+	child =3D fork();
+	ASSERT_GE(child, 0);
+
+	if (child =3D=3D 0) {
+		/* Try to execute the file - this should trigger FAN_OPEN_EXEC_PERM */
+		execl(self->test_exec_path, "test_exec", NULL);
+
+		/* If execl failed with EPERM, that's what we expect */
+		if (errno =3D=3D EPERM)
+			exit(EXIT_SUCCESS);
+
+		exit(EXIT_FAILURE);
+	}
+
+	usleep(100000);
+	event =3D get_event(self->fan_fd);
+	verify_event(_metadata, event, FAN_OPEN_EXEC_PERM, child);
+
+	/* Deny the exec operation */
+	close(event->fd);
+	ret =3D respond_to_event(self->fan_fd, event, FAN_DENY,
+			       false /* useEventId */);
+	ASSERT_EQ(ret, sizeof(struct fanotify_response));
+
+	int status;
+
+	ASSERT_EQ(waitpid(child, &status, 0), child);
+	ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
+}
+
+TEST_F(fanotify, default_response)
+{
+	struct fanotify_event_metadata *event;
+	int ret;
+	pid_t child;
+	struct fanotify_response resp;
+
+	/* Set default response to deny */
+	resp.fd =3D FAN_NOFD;
+	resp.response =3D FAN_DENY | FAN_DEFAULT;
+	ret =3D write(self->fan_fd, &resp, sizeof(resp));
+	ASSERT_EQ(ret, sizeof(resp));
+
+	child =3D fork();
+	ASSERT_GE(child, 0);
+
+	if (child =3D=3D 0) {
+		close(self->fan_fd);
+		/* Try to open the file - this should trigger FAN_OPEN_PERM */
+		int fd =3D open(self->test_file_path, O_RDONLY);
+
+		/* If open succeeded, this is an error as we expect it to be denied */
+		if (fd >=3D 0) {
+			close(fd);
+			exit(EXIT_FAILURE);
+		}
+
+		/* Verify the expected error */
+		if (errno =3D=3D EPERM)
+			exit(EXIT_SUCCESS);
+
+		exit(EXIT_FAILURE);
+	}
+
+	usleep(100000);
+	event =3D get_event(self->fan_fd);
+	verify_event(_metadata, event, FAN_OPEN_PERM, child);
+
+	/* Close fanotify group to return default response (DENY) */
+	close(self->fan_fd);
+	self->fan_fd =3D -1;
+
+	int status;
+
+	ASSERT_EQ(waitpid(child, &status, 0), child);
+	ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
+}
+
+TEST_F(fanotify, respond_via_event_id)
+{
+	struct fanotify_event_metadata *event;
+	int fd, ret;
+	pid_t child;
+
+	child =3D fork();
+	ASSERT_GE(child, 0);
+
+	if (child =3D=3D 0) {
+		/* Try to open the file - this should trigger FAN_OPEN_PERM */
+		fd =3D open(self->test_file_path2, O_RDONLY);
+		if (fd < 0)
+			exit(EXIT_FAILURE);
+		close(fd);
+		exit(EXIT_SUCCESS);
+	}
+
+	usleep(100000);
+	event =3D get_event(self->fan_fd2);
+	verify_event(_metadata, event, FAN_OPEN_PERM, child);
+	ASSERT_EQ(event->event_id, 1);
+
+	/* Allow the open operation */
+	close(event->fd);
+	ret =3D respond_to_event(self->fan_fd2, event, FAN_ALLOW,
+			       true /* useEventId */);
+	ASSERT_EQ(ret, sizeof(struct fanotify_response));
+
+	int status;
+
+	ASSERT_EQ(waitpid(child, &status, 0), child);
+	ASSERT_EQ(WEXITSTATUS(status), EXIT_SUCCESS);
+}
+
+TEST_HARNESS_MAIN
--=20
2.47.1


