Return-Path: <linux-fsdevel+bounces-68589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 287B8C60DB3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20E703623FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D4230EF7C;
	Sat, 15 Nov 2025 23:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="F+5BhBuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9930E0C0
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249699; cv=none; b=WZxDn+TERJQKucmrGg7qS9B6/M35YQiJeNxzGOKBbDta55gYbR4X0bdeH9/EjXPTxkG3ryEQylwNFSauKWrh5ArrtlG2HwNn0sYd446sDQ3yqTUwnSxpkl1sDz+6mJjvDXxk0SQKL9pUjXJ2+8erCve4EBF0C/ZqgNzL/sGGXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249699; c=relaxed/simple;
	bh=3LgFVG3WGye/XbBR8rtyEtDV89N7U1RgNovIzVAnT8c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cq94rFfR5W9/yiY3EEu+WHStCoQaMtfuYG7qYucd3wI20zsZpSxvWTOfylQyDBkXUBTG+OMEGNxEnykV5TCjBtmRnsLE5Yx6QieOpxuOxvEtcAxB9m8vxYrX3WJLSw+QW5ljZW7vVyi6Crs6pGEid/Dv4GT/co4XP5CfccG2Ovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=F+5BhBuL; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63fc72db706so2862234d50.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249696; x=1763854496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5S0vcOaGPBc/xPnnYkmK3BuBrLvlvg5l9MZinPrpq0=;
        b=F+5BhBuLgzB/En5elX2EfYQ15gFDywalmOJ2l9iWyePdjKHpor84l4UB7BGPbg2a2W
         LtK/juj5dZlr7sABmaedc1MGNRceFja7wyGvVYpCTxNWxVJsskTIzEaQo5GDpe2pVZrj
         Cv8pwblkrjDOGttDgupSz1qNuM6YRSMRrsWgxHKono2x5rqLwLHqBFU93azUwQe76We2
         4M8rSFJT205sLox70IRof6RNzN3M7bM3ph28M4Lj1CQL/X6uqHdv3S0dSh7RRCJqqpF3
         g8AKjdOkQS8qmYWopriCA7Nf4T1V++Jv0eNqEJE6d/t1MxZr6OxCuKHSCh00tLDJf0WM
         W7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249696; x=1763854496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f5S0vcOaGPBc/xPnnYkmK3BuBrLvlvg5l9MZinPrpq0=;
        b=LfbM4jXgzfcgslvNK0RDlz2cx7NsLbcCwtmGZ4DlR0ipdGvSAuI9kNmiIFNfKFeRlo
         VG/iWUDn+7miLC6Ih56V/Vde1SDR+2i3fmRB0Bgw1ai1t8EuiP/gxiy1nJhQkKBNH7p9
         FA+jQSj9sgMAkNIcoqnpq4Jmt8CqS5rCAuOPdb66fxwxXRcV11g9ybYZNSXK9MmRO5Om
         ulfeaoefMG3gPw4Q7m8EBbx8nNo2ZdSTPIvk+9HDROEZlbALf/lLnpGPGLE/0UCTav5K
         DoNFHlzud+JAItJijJIs2ggGbyQY4yc3GuArmmMGM+DoVAxrJ+PiyTx/wSnXXI/Yc6sK
         T5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXBoUCF7E8H0Rj5JdGwpa1YAWmp0FLxi0h9Qhr/mYobJW4wT66ENMQInTgPceUFQ3tO5KeUzDdYCOSjtLr4@vger.kernel.org
X-Gm-Message-State: AOJu0YwenYtFxebOTziCEcbfn3XRSEy01diUtDAqrZFaaSTfM8YzmpfA
	AfP4DTlnYrlZj6KKltzaEo71c/0zu2wC/ZsoqXG039w9lmJjOPf2goe1m0D/ywy1X5E=
X-Gm-Gg: ASbGncufbSJ17+YXtMDqJo7FH6cdmb1pJ4a8Yj0zmnyGpobcpyfIyj7byrm/nywwbpO
	OVlR2uOOa0D+Jz6leGN4wrWzhw73arSf6IsdgJJ/pFp7F3kd6rTE8dPhEYzWWNnzk3jFwOy8UAf
	m7dXDH9Md4He1BT9rIx2aqycJ8fIS58iYWhm3kkxaK17vwsGsr9f7v+9Zr5WqKN1myluveZiFWb
	xEVGNCVp1/U/aG527TI6WAzSVeAh08Yg7VJ7tKQMxfogGCv+3wI8B/q+KknT9z4YadN1OuoD/+4
	ndWBzUJRCAtcTyvtoC/Q0tS9LYhPuC9aO0+w+lWBEtDbPWGSGKjr//nExttdkpSmUNviz0OrkEP
	6CZ4ZquP6mOJF/wGVt2QCgSVwlqMnkp6n+43QVWk2J8EsARZGviq2v18epbCNtDQ3JNHUEsL6ln
	SY22IIByN4He3EmFAy5QJY0R8MmgXBYk4UFtYiWl/Ys2hQgMYzNnHtudHhHO6uQ5aHcg+jzukew
	Jta+z4=
X-Google-Smtp-Source: AGHT+IGi+GT9ZHanKi9MAwv46wj31I6UW4wvg+DCMOJo43hhLaMJSMVLxpTF87yQuYFejJEJXTbohQ==
X-Received: by 2002:a53:b10e:0:b0:63f:a228:1859 with SMTP id 956f58d0204a3-641e75ef062mr5298448d50.38.1763249695703;
        Sat, 15 Nov 2025 15:34:55 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:55 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v6 17/20] selftests/liveupdate: Add userspace API selftests
Date: Sat, 15 Nov 2025 18:34:03 -0500
Message-ID: <20251115233409.768044-18-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a selftest suite for LUO. These tests validate the core
userspace-facing API provided by the /dev/liveupdate device and its
associated ioctls.

The suite covers fundamental device behavior, session management, and
the file preservation mechanism using memfd as a test case. This
provides regression testing for the LUO uAPI.

The following functionality is verified:

Device Access:
	Basic open and close operations on /dev/liveupdate.
	Enforcement of exclusive device access (verifying EBUSY on a
	second open).

Session Management:
	Successful creation of sessions with unique names.
	Failure to create sessions with duplicate names.

File Preservation:
	Preserving a single memfd and verifying its content remains
	intact post-preservation.
	Preserving multiple memfds within a single session, each with
	unique data.
	A complex scenario involving multiple sessions, each containing
	a mix of empty and data-filled memfds.

Note: This test suite is limited to verifying the pre-kexec
functionality of LUO (e.g., session creation, file preservation).
The post-kexec restoration of resources is not covered, as the kselftest
framework does not currently support orchestrating a reboot and
continuing execution in the new kernel.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |   7 +
 tools/testing/selftests/liveupdate/config     |   5 +
 .../testing/selftests/liveupdate/liveupdate.c | 348 ++++++++++++++++++
 6 files changed, 363 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/.gitignore
 create mode 100644 tools/testing/selftests/liveupdate/Makefile
 create mode 100644 tools/testing/selftests/liveupdate/config
 create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ffe4425adbf..5a1ed783de20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14477,6 +14477,7 @@ F:	include/linux/liveupdate/
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
 F:	mm/memfd_luo.c
+F:	tools/testing/selftests/liveupdate/
 
 LLC (802.2)
 L:	netdev@vger.kernel.org
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c46ebdb9b8ef..56e44a98d6a5 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -54,6 +54,7 @@ TARGETS += kvm
 TARGETS += landlock
 TARGETS += lib
 TARGETS += livepatch
+TARGETS += liveupdate
 TARGETS += lkdtm
 TARGETS += lsm
 TARGETS += membarrier
diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testing/selftests/liveupdate/.gitignore
new file mode 100644
index 000000000000..af6e773cf98f
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/.gitignore
@@ -0,0 +1 @@
+/liveupdate
diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
new file mode 100644
index 000000000000..2a573c36016e
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -Wall -O2 -Wno-unused-function
+CFLAGS += $(KHDR_INCLUDES)
+
+TEST_GEN_PROGS += liveupdate
+
+include ../lib.mk
diff --git a/tools/testing/selftests/liveupdate/config b/tools/testing/selftests/liveupdate/config
new file mode 100644
index 000000000000..c0c7e7cc484e
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/config
@@ -0,0 +1,5 @@
+CONFIG_KEXEC_FILE=y
+CONFIG_KEXEC_HANDOVER=y
+CONFIG_KEXEC_HANDOVER_DEBUGFS=y
+CONFIG_KEXEC_HANDOVER_DEBUG=y
+CONFIG_LIVEUPDATE=y
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
new file mode 100644
index 000000000000..c2878e3d5ef9
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/*
+ * Selftests for the Live Update Orchestrator.
+ * This test suite verifies the functionality and behavior of the
+ * /dev/liveupdate character device and its session management capabilities.
+ *
+ * Tests include:
+ * - Device access: basic open/close, and enforcement of exclusive access.
+ * - Session management: creation of unique sessions, and duplicate name detection.
+ * - Resource preservation: successfully preserving individual and multiple memfds,
+ *   verifying contents remain accessible.
+ * - Complex multi-session scenarios involving mixed empty and populated files.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include <linux/liveupdate.h>
+
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+
+#define LIVEUPDATE_DEV "/dev/liveupdate"
+
+FIXTURE(liveupdate_device) {
+	int fd1;
+	int fd2;
+};
+
+FIXTURE_SETUP(liveupdate_device)
+{
+	self->fd1 = -1;
+	self->fd2 = -1;
+}
+
+FIXTURE_TEARDOWN(liveupdate_device)
+{
+	if (self->fd1 >= 0)
+		close(self->fd1);
+	if (self->fd2 >= 0)
+		close(self->fd2);
+}
+
+/*
+ * Test Case: Basic Open and Close
+ *
+ * Verifies that the /dev/liveupdate device can be opened and subsequently
+ * closed without errors. Skips if the device does not exist.
+ */
+TEST_F(liveupdate_device, basic_open_close)
+{
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist.", LIVEUPDATE_DEV);
+
+	ASSERT_GE(self->fd1, 0);
+	ASSERT_EQ(close(self->fd1), 0);
+	self->fd1 = -1;
+}
+
+/*
+ * Test Case: Exclusive Open Enforcement
+ *
+ * Verifies that the /dev/liveupdate device can only be opened by one process
+ * at a time. It checks that a second attempt to open the device fails with
+ * the EBUSY error code.
+ */
+TEST_F(liveupdate_device, exclusive_open)
+{
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist.", LIVEUPDATE_DEV);
+
+	ASSERT_GE(self->fd1, 0);
+	self->fd2 = open(LIVEUPDATE_DEV, O_RDWR);
+	EXPECT_LT(self->fd2, 0);
+	EXPECT_EQ(errno, EBUSY);
+}
+
+/* Helper function to create a LUO session via ioctl. */
+static int create_session(int lu_fd, const char *name)
+{
+	struct liveupdate_ioctl_create_session args = {};
+
+	args.size = sizeof(args);
+	strncpy((char *)args.name, name, sizeof(args.name) - 1);
+
+	if (ioctl(lu_fd, LIVEUPDATE_IOCTL_CREATE_SESSION, &args))
+		return -errno;
+
+	return args.fd;
+}
+
+/*
+ * Test Case: Create Duplicate Session
+ *
+ * Verifies that attempting to create two sessions with the same name fails
+ * on the second attempt with EEXIST.
+ */
+TEST_F(liveupdate_device, create_duplicate_session)
+{
+	int session_fd1, session_fd2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd1 = create_session(self->fd1, "duplicate-session-test");
+	ASSERT_GE(session_fd1, 0);
+
+	session_fd2 = create_session(self->fd1, "duplicate-session-test");
+	EXPECT_LT(session_fd2, 0);
+	EXPECT_EQ(-session_fd2, EEXIST);
+
+	ASSERT_EQ(close(session_fd1), 0);
+}
+
+/*
+ * Test Case: Create Distinct Sessions
+ *
+ * Verifies that creating two sessions with different names succeeds.
+ */
+TEST_F(liveupdate_device, create_distinct_sessions)
+{
+	int session_fd1, session_fd2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd1 = create_session(self->fd1, "distinct-session-1");
+	ASSERT_GE(session_fd1, 0);
+
+	session_fd2 = create_session(self->fd1, "distinct-session-2");
+	ASSERT_GE(session_fd2, 0);
+
+	ASSERT_EQ(close(session_fd1), 0);
+	ASSERT_EQ(close(session_fd2), 0);
+}
+
+static int preserve_fd(int session_fd, int fd_to_preserve, __u64 token)
+{
+	struct liveupdate_session_preserve_fd args = {};
+
+	args.size = sizeof(args);
+	args.fd = fd_to_preserve;
+	args.token = token;
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &args))
+		return -errno;
+
+	return 0;
+}
+
+/*
+ * Test Case: Preserve MemFD
+ *
+ * Verifies that a valid memfd can be successfully preserved in a session and
+ * that its contents remain intact after the preservation call.
+ */
+TEST_F(liveupdate_device, preserve_memfd)
+{
+	const char *test_str = "hello liveupdate";
+	char read_buf[64] = {};
+	int session_fd, mem_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "preserve-memfd-test");
+	ASSERT_GE(session_fd, 0);
+
+	mem_fd = memfd_create("test-memfd", 0);
+	ASSERT_GE(mem_fd, 0);
+
+	ASSERT_EQ(write(mem_fd, test_str, strlen(test_str)), strlen(test_str));
+	ASSERT_EQ(preserve_fd(session_fd, mem_fd, 0x1234), 0);
+	ASSERT_EQ(close(session_fd), 0);
+
+	ASSERT_EQ(lseek(mem_fd, 0, SEEK_SET), 0);
+	ASSERT_EQ(read(mem_fd, read_buf, sizeof(read_buf)), strlen(test_str));
+	ASSERT_STREQ(read_buf, test_str);
+	ASSERT_EQ(close(mem_fd), 0);
+}
+
+/*
+ * Test Case: Preserve Multiple MemFDs
+ *
+ * Verifies that multiple memfds can be preserved in a single session,
+ * each with a unique token, and that their contents remain distinct and
+ * correct after preservation.
+ */
+TEST_F(liveupdate_device, preserve_multiple_memfds)
+{
+	const char *test_str1 = "data for memfd one";
+	const char *test_str2 = "data for memfd two";
+	char read_buf[64] = {};
+	int session_fd, mem_fd1, mem_fd2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "preserve-multi-memfd-test");
+	ASSERT_GE(session_fd, 0);
+
+	mem_fd1 = memfd_create("test-memfd-1", 0);
+	ASSERT_GE(mem_fd1, 0);
+	mem_fd2 = memfd_create("test-memfd-2", 0);
+	ASSERT_GE(mem_fd2, 0);
+
+	ASSERT_EQ(write(mem_fd1, test_str1, strlen(test_str1)), strlen(test_str1));
+	ASSERT_EQ(write(mem_fd2, test_str2, strlen(test_str2)), strlen(test_str2));
+
+	ASSERT_EQ(preserve_fd(session_fd, mem_fd1, 0xAAAA), 0);
+	ASSERT_EQ(preserve_fd(session_fd, mem_fd2, 0xBBBB), 0);
+
+	memset(read_buf, 0, sizeof(read_buf));
+	ASSERT_EQ(lseek(mem_fd1, 0, SEEK_SET), 0);
+	ASSERT_EQ(read(mem_fd1, read_buf, sizeof(read_buf)), strlen(test_str1));
+	ASSERT_STREQ(read_buf, test_str1);
+
+	memset(read_buf, 0, sizeof(read_buf));
+	ASSERT_EQ(lseek(mem_fd2, 0, SEEK_SET), 0);
+	ASSERT_EQ(read(mem_fd2, read_buf, sizeof(read_buf)), strlen(test_str2));
+	ASSERT_STREQ(read_buf, test_str2);
+
+	ASSERT_EQ(close(mem_fd1), 0);
+	ASSERT_EQ(close(mem_fd2), 0);
+	ASSERT_EQ(close(session_fd), 0);
+}
+
+/*
+ * Test Case: Preserve Complex Scenario
+ *
+ * Verifies a more complex scenario with multiple sessions and a mix of empty
+ * and non-empty memfds distributed across them.
+ */
+TEST_F(liveupdate_device, preserve_complex_scenario)
+{
+	const char *data1 = "data for session 1";
+	const char *data2 = "data for session 2";
+	char read_buf[64] = {};
+	int session_fd1, session_fd2;
+	int mem_fd_data1, mem_fd_empty1, mem_fd_data2, mem_fd_empty2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd1 = create_session(self->fd1, "complex-session-1");
+	ASSERT_GE(session_fd1, 0);
+	session_fd2 = create_session(self->fd1, "complex-session-2");
+	ASSERT_GE(session_fd2, 0);
+
+	mem_fd_data1 = memfd_create("data1", 0);
+	ASSERT_GE(mem_fd_data1, 0);
+	ASSERT_EQ(write(mem_fd_data1, data1, strlen(data1)), strlen(data1));
+
+	mem_fd_empty1 = memfd_create("empty1", 0);
+	ASSERT_GE(mem_fd_empty1, 0);
+
+	mem_fd_data2 = memfd_create("data2", 0);
+	ASSERT_GE(mem_fd_data2, 0);
+	ASSERT_EQ(write(mem_fd_data2, data2, strlen(data2)), strlen(data2));
+
+	mem_fd_empty2 = memfd_create("empty2", 0);
+	ASSERT_GE(mem_fd_empty2, 0);
+
+	ASSERT_EQ(preserve_fd(session_fd1, mem_fd_data1, 0x1111), 0);
+	ASSERT_EQ(preserve_fd(session_fd1, mem_fd_empty1, 0x2222), 0);
+	ASSERT_EQ(preserve_fd(session_fd2, mem_fd_data2, 0x3333), 0);
+	ASSERT_EQ(preserve_fd(session_fd2, mem_fd_empty2, 0x4444), 0);
+
+	ASSERT_EQ(lseek(mem_fd_data1, 0, SEEK_SET), 0);
+	ASSERT_EQ(read(mem_fd_data1, read_buf, sizeof(read_buf)), strlen(data1));
+	ASSERT_STREQ(read_buf, data1);
+
+	memset(read_buf, 0, sizeof(read_buf));
+	ASSERT_EQ(lseek(mem_fd_data2, 0, SEEK_SET), 0);
+	ASSERT_EQ(read(mem_fd_data2, read_buf, sizeof(read_buf)), strlen(data2));
+	ASSERT_STREQ(read_buf, data2);
+
+	ASSERT_EQ(lseek(mem_fd_empty1, 0, SEEK_SET), 0);
+	ASSERT_EQ(read(mem_fd_empty1, read_buf, sizeof(read_buf)), 0);
+
+	ASSERT_EQ(lseek(mem_fd_empty2, 0, SEEK_SET), 0);
+	ASSERT_EQ(read(mem_fd_empty2, read_buf, sizeof(read_buf)), 0);
+
+	ASSERT_EQ(close(mem_fd_data1), 0);
+	ASSERT_EQ(close(mem_fd_empty1), 0);
+	ASSERT_EQ(close(mem_fd_data2), 0);
+	ASSERT_EQ(close(mem_fd_empty2), 0);
+	ASSERT_EQ(close(session_fd1), 0);
+	ASSERT_EQ(close(session_fd2), 0);
+}
+
+/*
+ * Test Case: Preserve Unsupported File Descriptor
+ *
+ * Verifies that attempting to preserve a file descriptor that does not have
+ * a registered Live Update handler fails gracefully.
+ * Uses /dev/null as a representative of a file type (character device)
+ * that is not supported by the orchestrator.
+ */
+TEST_F(liveupdate_device, preserve_unsupported_fd)
+{
+	int session_fd, unsupported_fd;
+	int ret;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "unsupported-fd-test");
+	ASSERT_GE(session_fd, 0);
+
+	unsupported_fd = open("/dev/null", O_RDWR);
+	ASSERT_GE(unsupported_fd, 0);
+
+	ret = preserve_fd(session_fd, unsupported_fd, 0xDEAD);
+	EXPECT_EQ(ret, -ENOENT);
+
+	ASSERT_EQ(close(unsupported_fd), 0);
+	ASSERT_EQ(close(session_fd), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.52.0.rc1.455.g30608eb744-goog


