Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5472F220FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGOOxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 10:53:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52439 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726863AbgGOOxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594824793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d9gLBZH3xrp5bh9Hcfk99uaWsYU1ho/1zy2f3F6QJLA=;
        b=GcBmqaBeGaE6Xh0fJyDB73bl8SUWYodxOY7pC8VhbuREBT+v3lxrF+AwOfBhEaB/WkMOTf
        geJ+bGYn7p3aDpWphOffX6onYmB8410QFQ+06tmNvlT++WIgx5bkM2w9Y8NparXQ4WasBL
        PIp497SJHe0r+NGBcwJ4QNkoDKPpddQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-vxqMJMi2PhGPvdwM3iMhzQ-1; Wed, 15 Jul 2020 10:52:03 -0400
X-MC-Unique: vxqMJMi2PhGPvdwM3iMhzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5E7F800EB6;
        Wed, 15 Jul 2020 14:52:00 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CDEC60BF1;
        Wed, 15 Jul 2020 14:51:53 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?q?Micha=C5=82=20C=C5=82api=C5=84ski?= 
        <mclapinski@google.com>, Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 6/6] selftests: add clone3() CAP_CHECKPOINT_RESTORE test
Date:   Wed, 15 Jul 2020 16:49:54 +0200
Message-Id: <20200715144954.1387760-7-areber@redhat.com>
In-Reply-To: <20200715144954.1387760-1-areber@redhat.com>
References: <20200715144954.1387760-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a test that changes its UID, uses capabilities to
get CAP_CHECKPOINT_RESTORE and uses clone3() with set_tid to
create a process with a given PID as non-root.

Signed-off-by: Adrian Reber <areber@redhat.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 tools/testing/selftests/clone3/Makefile       |   4 +-
 .../clone3/clone3_cap_checkpoint_restore.c    | 203 ++++++++++++++++++
 2 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c

diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index cf976c732906..ef7564cb7abe 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -g -I../../../../usr/include/
+LDLIBS += -lcap
 
-TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid
+TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
+	clone3_cap_checkpoint_restore
 
 include ../lib.mk
diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
new file mode 100644
index 000000000000..2cc3d57b91f2
--- /dev/null
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Based on Christian Brauner's clone3() example.
+ * These tests are assuming to be running in the host's
+ * PID namespace.
+ */
+
+/* capabilities related code based on selftests/bpf/test_verifier.c */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/capability.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <sched.h>
+
+#include "../kselftest.h"
+#include "clone3_selftests.h"
+
+#ifndef MAX_PID_NS_LEVEL
+#define MAX_PID_NS_LEVEL 32
+#endif
+
+static void child_exit(int ret)
+{
+	fflush(stdout);
+	fflush(stderr);
+	_exit(ret);
+}
+
+static int call_clone3_set_tid(pid_t * set_tid, size_t set_tid_size)
+{
+	int status;
+	pid_t pid = -1;
+
+	struct clone_args args = {
+		.exit_signal = SIGCHLD,
+		.set_tid = ptr_to_u64(set_tid),
+		.set_tid_size = set_tid_size,
+	};
+
+	pid = sys_clone3(&args, sizeof(struct clone_args));
+	if (pid < 0) {
+		ksft_print_msg("%s - Failed to create new process\n",
+			       strerror(errno));
+		return -errno;
+	}
+
+	if (pid == 0) {
+		int ret;
+		char tmp = 0;
+
+		ksft_print_msg
+		    ("I am the child, my PID is %d (expected %d)\n",
+		     getpid(), set_tid[0]);
+
+		if (set_tid[0] != getpid())
+			child_exit(EXIT_FAILURE);
+		child_exit(EXIT_SUCCESS);
+	}
+
+	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
+		       getpid(), pid);
+
+	if (waitpid(pid, &status, 0) < 0) {
+		ksft_print_msg("Child returned %s\n", strerror(errno));
+		return -errno;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+static int test_clone3_set_tid(pid_t * set_tid,
+			       size_t set_tid_size, int expected)
+{
+	int ret;
+
+	ksft_print_msg("[%d] Trying clone3() with CLONE_SET_TID to %d\n",
+		       getpid(), set_tid[0]);
+	ret = call_clone3_set_tid(set_tid, set_tid_size);
+
+	ksft_print_msg
+	    ("[%d] clone3() with CLONE_SET_TID %d says :%d - expected %d\n",
+	     getpid(), set_tid[0], ret, expected);
+	if (ret != expected) {
+		ksft_test_result_fail
+		    ("[%d] Result (%d) is different than expected (%d)\n",
+		     getpid(), ret, expected);
+		return -1;
+	}
+	ksft_test_result_pass
+	    ("[%d] Result (%d) matches expectation (%d)\n", getpid(), ret,
+	     expected);
+
+	return 0;
+}
+
+struct libcap {
+	struct __user_cap_header_struct hdr;
+	struct __user_cap_data_struct data[2];
+};
+
+static int set_capability()
+{
+	cap_value_t cap_values[] = { CAP_SETUID, CAP_SETGID };
+	struct libcap *cap;
+	int ret = -1;
+	cap_t caps;
+
+	caps = cap_get_proc();
+	if (!caps) {
+		perror("cap_get_proc");
+		return -1;
+	}
+
+	/* Drop all capabilities */
+	if (cap_clear(caps)) {
+		perror("cap_clear");
+		goto out;
+	}
+
+	cap_set_flag(caps, CAP_EFFECTIVE, 2, cap_values, CAP_SET);
+	cap_set_flag(caps, CAP_PERMITTED, 2, cap_values, CAP_SET);
+
+	cap = (struct libcap *) caps;
+
+	/* 40 -> CAP_CHECKPOINT_RESTORE */
+	cap->data[1].effective |= 1 << (40 - 32);
+	cap->data[1].permitted |= 1 << (40 - 32);
+
+	if (cap_set_proc(caps)) {
+		perror("cap_set_proc");
+		goto out;
+	}
+	ret = 0;
+out:
+	if (cap_free(caps))
+		perror("cap_free");
+	return ret;
+}
+
+int main(int argc, char *argv[])
+{
+	pid_t pid;
+	int status;
+	int ret = 0;
+	pid_t set_tid[1];
+	uid_t uid = getuid();
+
+	ksft_print_header();
+	test_clone3_supported();
+	ksft_set_plan(2);
+
+	if (uid != 0) {
+		ksft_cnt.ksft_xskip = ksft_plan;
+		ksft_print_msg("Skipping all tests as non-root\n");
+		return ksft_exit_pass();
+	}
+
+	memset(&set_tid, 0, sizeof(set_tid));
+
+	/* Find the current active PID */
+	pid = fork();
+	if (pid == 0) {
+		ksft_print_msg("Child has PID %d\n", getpid());
+		child_exit(EXIT_SUCCESS);
+	}
+	if (waitpid(pid, &status, 0) < 0)
+		ksft_exit_fail_msg("Waiting for child %d failed", pid);
+
+	/* After the child has finished, its PID should be free. */
+	set_tid[0] = pid;
+
+	if (set_capability())
+		ksft_test_result_fail
+		    ("Could not set CAP_CHECKPOINT_RESTORE\n");
+	prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
+	/* This would fail without CAP_CHECKPOINT_RESTORE */
+	setgid(1000);
+	setuid(1000);
+	set_tid[0] = pid;
+	ret |= test_clone3_set_tid(set_tid, 1, -EPERM);
+	if (set_capability())
+		ksft_test_result_fail
+		    ("Could not set CAP_CHECKPOINT_RESTORE\n");
+	/* This should work as we have CAP_CHECKPOINT_RESTORE as non-root */
+	ret |= test_clone3_set_tid(set_tid, 1, 0);
+
+	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+}
-- 
2.26.2

