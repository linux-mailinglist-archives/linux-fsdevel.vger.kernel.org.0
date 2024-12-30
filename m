Return-Path: <linux-fsdevel+bounces-38271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 585079FE546
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 11:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205F91882737
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Dec 2024 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F141A841E;
	Mon, 30 Dec 2024 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pa3rkFgn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iLCQXA3I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902A1A7046;
	Mon, 30 Dec 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735553868; cv=none; b=kAEVQkodvzIbS1LkMvI6ih6jBKmmNyrtk1EdErmnRfnZ+SebypxeGUcLW1Watv8mM7PMZUOO1ZXCcCpBn7aaIfjhznOZgLvxrhPVTDWZG9FAi9jrIbsDEivTbIlOU8avkvnz/mZJYvv92yWWpmgCyL5SwVUIGQOQZcKZTBfwLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735553868; c=relaxed/simple;
	bh=5agZGZ4E/E7vTaXtwgIuWjP92+kOXYG9bSrRAVatQqw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yo+Bt4VtgyYcnTHaAjmPS1DD2RMAVDIqcm+SFZUGmFmhJ23xLej2BGwi8uLdj+V0DA7cAF1xBmXg07Cwe77pV+F5LxPGWqQd48J9sv6edjbsDyPznNbbT1aLrBqH1okfaULwPh3G2NS45A6DC8EfCG0IJI7diYk/N4R/zctJ72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pa3rkFgn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iLCQXA3I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735553858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UGV6zzG7Sb0fSoeidR//wSyXLCXAxbZbFaUE4/Pif+w=;
	b=Pa3rkFgnPlofY+rJPr0oAkyCEjQk0ll0dWWnhCb9y3uHkAJIlg5vedlj1xU8UZegKNWcbN
	YH4Ftx1mxfjTp6j44k6o4JxdHTfRVubqZabByN18SNo6WbVmlopw22PCQOD60dNcfyL0K1
	JjZhhqO7GCOGYePu3IvFLqhkXz6gzK8kJddvRTRl5aAIKJurV3PE9/0nGGx8JbM3kIOAhr
	TYl7sGRQroCxKbI7u+1fMCPdKAFzbplPmdOCMEqIM36b1oeLQIMtgy1KepBTYOV9Z48J3L
	MAuh5HQ68z32EPZCwNhFPGIg0mP2LEL1DYp1GzPlbFXwoncgXoMz4PlY49GQ3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735553858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UGV6zzG7Sb0fSoeidR//wSyXLCXAxbZbFaUE4/Pif+w=;
	b=iLCQXA3I2CXPDR4EC3zMr7hm1rSyuIswx9YVK9ldjcS/6F9GzSsHwX0DNCDRlljJ8UwW3Y
	3HbArJtk+Cyr1iAg==
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	John Ogness <john.ogness@linutronix.de>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 2/2] selftests: coredump: Add stackdump test
Date: Mon, 30 Dec 2024 11:17:31 +0100
Message-Id: <d4b5d4c69eebd694f68ca8e7b92309d60adbe02a.1735550994.git.namcao@linutronix.de>
In-Reply-To: <cover.1735550994.git.namcao@linutronix.de>
References: <cover.1735550994.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a test which checks that the kstkesp field in /proc/pid/stat can be
read for all threads of a coredumping process.

For full details including the motivation for this test and how it works,
see the README file added by this commit.

Reviewed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/testing/selftests/coredump/Makefile     |   7 +
 tools/testing/selftests/coredump/README.rst   |  50 ++++++
 tools/testing/selftests/coredump/stackdump    |  14 ++
 .../selftests/coredump/stackdump_test.c       | 154 ++++++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 tools/testing/selftests/coredump/Makefile
 create mode 100644 tools/testing/selftests/coredump/README.rst
 create mode 100755 tools/testing/selftests/coredump/stackdump
 create mode 100644 tools/testing/selftests/coredump/stackdump_test.c

diff --git a/tools/testing/selftests/coredump/Makefile b/tools/testing/self=
tests/coredump/Makefile
new file mode 100644
index 000000000000..ed210037b29d
--- /dev/null
+++ b/tools/testing/selftests/coredump/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS =3D $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS :=3D stackdump_test
+TEST_FILES :=3D stackdump
+
+include ../lib.mk
diff --git a/tools/testing/selftests/coredump/README.rst b/tools/testing/se=
lftests/coredump/README.rst
new file mode 100644
index 000000000000..164a7aa181c8
--- /dev/null
+++ b/tools/testing/selftests/coredump/README.rst
@@ -0,0 +1,50 @@
+coredump selftest
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Background context
+------------------
+
+`coredump` is a feature which dumps a process's memory space when the proc=
ess terminates
+unexpectedly (e.g. due to segmentation fault), which can be useful for deb=
ugging. By default,
+`coredump` dumps the memory to the file named `core`, but this behavior ca=
n be changed by writing a
+different file name to `/proc/sys/kernel/core_pattern`. Furthermore, `core=
dump` can be piped to a
+user-space program by writing the pipe symbol (`|`) followed by the comman=
d to be executed to
+`/proc/sys/kernel/core_pattern`. For the full description, see `man 5 core=
`.
+
+The piped user program may be interested in reading the stack pointers of =
the crashed process. The
+crashed process's stack pointers can be read from `procfs`: it is the `kst=
kesp` field in
+`/proc/$PID/stat`. See `man 5 proc` for all the details.
+
+The problem
+-----------
+While a thread is active, the stack pointer is unsafe to read and therefor=
e the `kstkesp` field
+reads zero. But when the thread is dead (e.g. during a coredump), this fie=
ld should have valid
+value.
+
+However, this was broken in the past and `kstkesp` was zero even during co=
redump:
+
+* commit 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in /proc/PID/s=
tat") changed kstkesp to
+  always be zero
+
+* commit fd7d56270b52 ("fs/proc: Report eip/esp in /prod/PID/stat for core=
dumping") fixed it for the
+  coredumping thread. However, other threads in a coredumping process stil=
l had the problem.
+
+* commit cb8f381f1613 ("fs/proc/array.c: allow reporting eip/esp for all c=
oredumping threads") fixed
+  for all threads in a coredumping process.
+
+* commit 92307383082d ("coredump:  Don't perform any cleanups before dumpi=
ng core") broke it again
+  for the other threads in a coredumping process.
+
+The problem has been fixed now, but considering the history, it may appear=
 again in the future.
+
+The goal of this test
+---------------------
+This test detects problem with reading `kstkesp` during coredump by doing =
the following:
+
+#. Tell the kernel to execute the "stackdump" script when a coredump happe=
ns. This script
+   reads the stack pointers of all threads of crashed processes.
+
+#. Spawn a child process who creates some threads and then crashes.
+
+#. Read the output from the "stackdump" script, and make sure all stack po=
inter values are
+   non-zero.
diff --git a/tools/testing/selftests/coredump/stackdump b/tools/testing/sel=
ftests/coredump/stackdump
new file mode 100755
index 000000000000..96714ce42d12
--- /dev/null
+++ b/tools/testing/selftests/coredump/stackdump
@@ -0,0 +1,14 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+CRASH_PROGRAM_ID=3D$1
+STACKDUMP_FILE=3D$2
+
+TMP=3D$(mktemp)
+
+for t in /proc/$CRASH_PROGRAM_ID/task/*; do
+	tid=3D$(basename $t)
+	cat /proc/$tid/stat | awk '{print $29}' >> $TMP
+done
+
+mv $TMP $STACKDUMP_FILE
diff --git a/tools/testing/selftests/coredump/stackdump_test.c b/tools/test=
ing/selftests/coredump/stackdump_test.c
new file mode 100644
index 000000000000..b86202aa2f04
--- /dev/null
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fcntl.h>
+#include <libgen.h>
+#include <linux/limits.h>
+#include <pthread.h>
+#include <string.h>
+#include <sys/resource.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define STACKDUMP_FILE "/tmp/kselftest_stackdump"
+#define STACKDUMP_SCRIPT "stackdump"
+#define NUM_THREAD_SPAWN 128
+
+static void *do_nothing(void *)
+{
+	while (1)
+		pause();
+}
+
+static void crashing_child(void)
+{
+	pthread_t thread;
+	int i;
+
+	for (i =3D 0; i < NUM_THREAD_SPAWN; ++i)
+		pthread_create(&thread, NULL, do_nothing, NULL);
+
+	/* crash on purpose */
+	i =3D *(int *)NULL;
+}
+
+static void empty_function(int) {}
+
+FIXTURE(coredump)
+{
+	char original_core_pattern[256];
+};
+
+FIXTURE_SETUP(coredump)
+{
+	char buf[PATH_MAX];
+	FILE *file;
+	char *dir;
+	int ret;
+
+	file =3D fopen("/proc/sys/kernel/core_pattern", "r");
+	ASSERT_NE(NULL, file);
+
+	ret =3D fread(self->original_core_pattern, 1, sizeof(self->original_core_=
pattern), file);
+	ASSERT_TRUE(ret || feof(file));
+	ASSERT_LT(ret, sizeof(self->original_core_pattern));
+
+	self->original_core_pattern[ret] =3D '\0';
+
+	ret =3D fclose(file);
+	ASSERT_EQ(0, ret);
+}
+
+FIXTURE_TEARDOWN(coredump)
+{
+	const char *reason;
+	FILE *file;
+	int ret;
+
+	file =3D fopen("/proc/sys/kernel/core_pattern", "w");
+	if (!file) {
+		reason =3D "Unable to open core_pattern";
+		goto fail;
+	}
+
+	ret =3D fprintf(file, "%s", self->original_core_pattern);
+	if (ret < 0) {
+		reason =3D "Unable to write to core_pattern";
+		goto fail;
+	}
+
+	ret =3D fclose(file);
+	if (ret) {
+		reason =3D "Unable to close core_pattern";
+		goto fail;
+	}
+
+	return;
+fail:
+	/* This should never happen */
+	fprintf(stderr, "Failed to cleanup stackdump test: %s\n", reason);
+}
+
+TEST_F(coredump, stackdump)
+{
+	struct sigaction action =3D {};
+	unsigned long long stack;
+	char *test_dir, *line;
+	size_t line_length;
+	char buf[PATH_MAX];
+	int ret, i;
+	FILE *file;
+	pid_t pid;
+
+	/* This file may be left behind by a previous test run */
+	unlink(STACKDUMP_FILE);
+
+	/*
+	 * Step 1: Setup core_pattern so that the stackdump script is executed wh=
en the child
+	 * process crashes
+	 */
+	ret =3D readlink("/proc/self/exe", buf, sizeof(buf));
+	ASSERT_NE(-1, ret);
+	ASSERT_LT(ret, sizeof(buf));
+	buf[ret] =3D '\0';
+
+	test_dir =3D dirname(buf);
+
+	file =3D fopen("/proc/sys/kernel/core_pattern", "w");
+	ASSERT_NE(NULL, file);
+
+	ret =3D fprintf(file, "|%s/%s %%P %s", test_dir, STACKDUMP_SCRIPT, STACKD=
UMP_FILE);
+	ASSERT_LT(0, ret);
+
+	ret =3D fclose(file);
+	ASSERT_EQ(0, ret);
+
+	/* Step 2: Create a process who spawns some threads then crashes */
+	pid =3D fork();
+	ASSERT_TRUE(pid >=3D 0);
+	if (pid =3D=3D 0)
+		crashing_child();
+
+	/*
+	 * Step 3: Wait for the stackdump script to write the stack pointers to t=
he stackdump file
+	 */
+	for (i =3D 0; i < 10; ++i) {
+		file =3D fopen(STACKDUMP_FILE, "r");
+		if (file)
+			break;
+		sleep(1);
+	}
+	ASSERT_NE(file, NULL);
+
+	/* Step 4: Make sure all stack pointer values are non-zero */
+	for (i =3D 0; -1 !=3D getline(&line, &line_length, file); ++i) {
+		stack =3D strtoull(line, NULL, 10);
+		ASSERT_NE(stack, 0);
+	}
+
+	ASSERT_EQ(i, 1 + NUM_THREAD_SPAWN);
+
+	fclose(file);
+}
+
+TEST_HARNESS_MAIN
--=20
2.39.5


