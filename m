Return-Path: <linux-fsdevel+bounces-67496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA2DC41B5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2D7F351D13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DB334887B;
	Fri,  7 Nov 2025 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="U8dLtQtY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457AA346FA8
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549576; cv=none; b=blB6GpJhxFXtSxfftP/qFp6Gl4w7Hk7T6SUO6cuvOMyFFN7eQ5Wm3j51Ji8NCan61iNSNkj/k9MqKkIP+j/C1l/Sy+uhVaXwUzFFb7b2lPhy/lmkiJ+25jvEeQ4LJjlUiLCtGRMjgOErs4oRPoDFthDssKp76C8HWEd3aevUqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549576; c=relaxed/simple;
	bh=ex9Ty+ajRZX6NEjdJenwudqrabq/5m4ytLE7jyNiaXU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qXgUJBKJWcbgdmWKNj4xOoxaoUhVPbute3DY7GQOBWhnOsEr0KXRXejY91QZRb39ALqZR+ep/HWZ6x6J5scZE3PehaC/U1R0lN9iKaNvbCxmZdOcyfadpIJQkeHMun9b66Qv3ho4xb0Ea8PKRDqo5/XGoWWxrxesI0icDJWlUIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=U8dLtQtY; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-786a8eeb047so13299467b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549571; x=1763154371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMSpKE1l2D+pbDUsxKcM6He86wroChEvKIhAzF63c/s=;
        b=U8dLtQtYJs1I6q+RGrFKe1vUk5v/5xhK9ST8sjPUhZYOHtU4P48MxrGHE7vzVq2t/O
         KOG/r3hHe2uXaJF7xomMuLV7wEeipasxJwanzqRqOjCTjxrAlPNuyJMkr2U+CWV+XXoQ
         RG1M0i4OIzW4uh2wtLjeGW7tDl62xc80TZ3xpOiPHEGGQVmd1VPhsm4eJxTYfC72iP5a
         tkTMpF+C3+DKySxu3d+bmrC1PGtucNg50X4TGn7ceRXxRXXBPpYCI70T+CczdcvCLAQ1
         iJofcNmB5cK4Ao/5olGvVxSb1/aQKDtdQEptSPJI4K2pL+X84lhtlE2IKEHs/LfrZiyd
         EEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549571; x=1763154371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wMSpKE1l2D+pbDUsxKcM6He86wroChEvKIhAzF63c/s=;
        b=v0hAlyctV7bnwFT7uUub9YUhz9v/EpEuLnhB06cJY3PkWW1692P2TDo7f0SKYSVgFl
         i2V/FC9UVBjy81VjM2DylGpN521riQPPoHjOZWMfGVnu3tkbpsI/CJ0faiD2FBwLtcy7
         0/dtdo++h+qrndl2DAv0I9lWR+9dleBH/bLTJUW7FKUEhwARdac0v+VYLxCKBJKEdLwV
         SoC6rNEpKJzupm5fYFr48Lzt05aduJhg10nLcxeQraa+1yc+Pa0ooNEFZorARbszzbZ4
         QZJTdgaiIxHB+J15tjdLOgUqaaLwC1aYJJKyaGD9f0NIYP8ItuIJ9wQbRtGnQa/NzgX+
         Zh6g==
X-Forwarded-Encrypted: i=1; AJvYcCWeHaFZd5baYxcXMK2Y4PKOQqXtwrL72eXgCDayaRw+bVsPxj/nej1UNh1XCGxJnWK+RA+5KhVMrUlhldMS@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQaYYlFkDdnEGjcnodCUuVS41RkR/4gGV+I0eOpvHEe1j7+NK
	hiO+wyFUwoEKKCG426jb0O7re+QvzNa/rQBNPRllZnaz65X3gbXuZqSkr/rnAVTirbg=
X-Gm-Gg: ASbGnct8t7EwjhAm/AjsvadGSUMSNdwpsEKlGxN3xIUfOY0/GLmsAi/l0jmfPp7z1jN
	iLUf+AzGO3HvO8d+DnBH+yWsZx52FWPFztnRv71sWGzFZvN8RwAmOeQGp8zOMdYILnN5kz0bou1
	HGvWt4EBjuQWhill4daXvMjx91XjoKKAlci6U3WZdLC1xNjTZjuF+tZV2cRqmav00Jcb1YSEgFd
	5o9cNUGO5365XhShoYwFY1pibEkl6gx9WtDlagzeeg/NmcShgjXVq/QhE/tNpm+6F5u/6Lwxc29
	NDOIfnciLyyitQ/rDtmGp1ZyERbGPeJ9ry/1Fi9rVtUG3N39DctN1kd1dAVMDaTB7i2YfDkl6rF
	zb0klpl7I2hbv0hF1xIK6FHROvP27Ra5b6TSvR83LTIXNbLBTg0KXROMBJXJq3TzYshzSIWL4mq
	UedceM8vTqKxD3kOy2R7Y84GgvyD9bPUN/kHr0zbZizZY8iXySKKC9NyZNGhcr8pI=
X-Google-Smtp-Source: AGHT+IFflyRO6w1q3DXVe7O2dxbNRv5YmoMD7A2svs64snuag/XfdkXNTRwcLqUkAwpierKFK5vHIg==
X-Received: by 2002:a05:690c:4d09:b0:786:4fbb:642 with SMTP id 00721157ae682-787d548410fmr7640347b3.60.1762549571027;
        Fri, 07 Nov 2025 13:06:11 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:06:10 -0800 (PST)
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
	zhangguopeng@kylinos.cn,
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
Subject: [PATCH v5 20/22] selftests/liveupdate: Add kexec-based selftest for session lifecycle
Date: Fri,  7 Nov 2025 16:03:18 -0500
Message-ID: <20251107210526.257742-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a kexec-based selftest, luo_kexec_simple, to validate the
end-to-end lifecycle of a Live Update Orchestrator (LUO) session across
a reboot.

While existing tests verify the uAPI in a pre-reboot context, this test
ensures that the core functionality—preserving state via Kexec Handover
and restoring it in a new kernel—works as expected.

The test operates in two stages, managing its state across the reboot by
preserving a dedicated "state session" containing a memfd. This
mechanism dogfoods the LUO feature itself for state tracking, making the
test self-contained.

The test validates the following sequence:

Stage 1 (Pre-kexec):
 - Creates a test session (test-session).
 - Creates and preserves a memfd with a known data pattern into the test
   session.
 - Creates the state-tracking session to signal progression to Stage 2.
 - Executes a kexec reboot via a helper script.

Stage 2 (Post-kexec):
 - Retrieves the state-tracking session to confirm it is in the
   post-reboot stage.
 - Retrieves the preserved test session.
 - Restores the memfd from the test session and verifies its contents
   match the original data pattern written in Stage 1.
 - Finalizes both the test and state sessions to ensure a clean
   teardown.

The test relies on a helper script (do_kexec.sh) to perform the reboot
and a shared utility library (luo_test_utils.c) for common LUO
operations, keeping the main test logic clean and focused.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |  32 ++++
 .../testing/selftests/liveupdate/do_kexec.sh  |   6 +
 .../selftests/liveupdate/luo_kexec_simple.c   | 114 ++++++++++++
 .../selftests/liveupdate/luo_test_utils.c     | 168 ++++++++++++++++++
 .../selftests/liveupdate/luo_test_utils.h     |  39 ++++
 6 files changed, 360 insertions(+)
 create mode 100755 tools/testing/selftests/liveupdate/do_kexec.sh
 create mode 100644 tools/testing/selftests/liveupdate/luo_kexec_simple.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.h

diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testing/selftests/liveupdate/.gitignore
index af6e773cf98f..daeef116174d 100644
--- a/tools/testing/selftests/liveupdate/.gitignore
+++ b/tools/testing/selftests/liveupdate/.gitignore
@@ -1 +1,2 @@
 /liveupdate
+/luo_kexec_simple
diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 2a573c36016e..1563ac84006a 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -1,7 +1,39 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+KHDR_INCLUDES ?= -I../../../../usr/include
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
+LDFLAGS += -static
+OUTPUT ?= .
+
+# --- Test Configuration (Edit this section when adding new tests) ---
+LUO_SHARED_SRCS := luo_test_utils.c
+LUO_SHARED_HDRS += luo_test_utils.h
+
+LUO_MANUAL_TESTS += luo_kexec_simple
+
+TEST_FILES += do_kexec.sh
 
 TEST_GEN_PROGS += liveupdate
 
+# --- Automatic Rule Generation (Do not edit below) ---
+
+TEST_GEN_PROGS_EXTENDED += $(LUO_MANUAL_TESTS)
+
+# Define the full list of sources for each manual test.
+$(foreach test,$(LUO_MANUAL_TESTS), \
+	$(eval $(test)_SOURCES := $(test).c $(LUO_SHARED_SRCS)))
+
+# This loop automatically generates an explicit build rule for each manual test.
+# It includes dependencies on the shared headers and makes the output
+# executable.
+# Note the use of '$$' to escape automatic variables for the 'eval' command.
+$(foreach test,$(LUO_MANUAL_TESTS), \
+	$(eval $(OUTPUT)/$(test): $($(test)_SOURCES) $(LUO_SHARED_HDRS) \
+		$(call msg,LINK,,$$@) ; \
+		$(Q)$(LINK.c) $$^ $(LDLIBS) -o $$@ ; \
+		$(Q)chmod +x $$@ \
+	) \
+)
+
 include ../lib.mk
diff --git a/tools/testing/selftests/liveupdate/do_kexec.sh b/tools/testing/selftests/liveupdate/do_kexec.sh
new file mode 100755
index 000000000000..bb396a92c3b8
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/do_kexec.sh
@@ -0,0 +1,6 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+set -e
+
+kexec -l -s --reuse-cmdline /boot/bzImage
+kexec -e
diff --git a/tools/testing/selftests/liveupdate/luo_kexec_simple.c b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
new file mode 100644
index 000000000000..67ab6ebf9eec
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_kexec_simple.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * A simple selftest to validate the end-to-end lifecycle of a LUO session
+ * across a single kexec reboot.
+ */
+
+#include "luo_test_utils.h"
+
+/* Test-specific constants are now defined locally */
+#define KEXEC_SCRIPT "./do_kexec.sh"
+#define TEST_SESSION_NAME "test-session"
+#define TEST_MEMFD_TOKEN 0x1A
+#define TEST_MEMFD_DATA "hello kexec world"
+
+/* Constants for the state-tracking mechanism, specific to this test file. */
+#define STATE_SESSION_NAME "kexec_simple_state"
+#define STATE_MEMFD_TOKEN 999
+
+/* Stage 1: Executed before the kexec reboot. */
+static void run_stage_1(int luo_fd)
+{
+	int session_fd;
+
+	ksft_print_msg("[STAGE 1] Starting pre-kexec setup...\n");
+
+	ksft_print_msg("[STAGE 1] Creating state file for next stage (2)...\n");
+	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, 2);
+
+	ksft_print_msg("[STAGE 1] Creating session '%s' and preserving memfd...\n",
+		       TEST_SESSION_NAME);
+	session_fd = luo_create_session(luo_fd, TEST_SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("luo_create_session for '%s'", TEST_SESSION_NAME);
+
+	if (create_and_preserve_memfd(session_fd, TEST_MEMFD_TOKEN,
+				      TEST_MEMFD_DATA) < 0) {
+		fail_exit("create_and_preserve_memfd for token %#x",
+			  TEST_MEMFD_TOKEN);
+	}
+
+	ksft_print_msg("[STAGE 1] Executing kexec...\n");
+	if (system(KEXEC_SCRIPT) != 0)
+		fail_exit("kexec script failed");
+	exit(EXIT_FAILURE);
+}
+
+/* Stage 2: Executed after the kexec reboot. */
+static void run_stage_2(int luo_fd, int state_session_fd)
+{
+	int session_fd, mfd, stage;
+
+	ksft_print_msg("[STAGE 2] Starting post-kexec verification...\n");
+
+	restore_and_read_stage(state_session_fd, STATE_MEMFD_TOKEN, &stage);
+	if (stage != 2)
+		fail_exit("Expected stage 2, but state file contains %d", stage);
+
+	ksft_print_msg("[STAGE 2] Retrieving session '%s'...\n", TEST_SESSION_NAME);
+	session_fd = luo_retrieve_session(luo_fd, TEST_SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("luo_retrieve_session for '%s'", TEST_SESSION_NAME);
+
+	ksft_print_msg("[STAGE 2] Restoring and verifying memfd (token %#x)...\n",
+		       TEST_MEMFD_TOKEN);
+	mfd = restore_and_verify_memfd(session_fd, TEST_MEMFD_TOKEN,
+				       TEST_MEMFD_DATA);
+	if (mfd < 0)
+		fail_exit("restore_and_verify_memfd for token %#x", TEST_MEMFD_TOKEN);
+	close(mfd);
+
+	ksft_print_msg("[STAGE 2] Test data verified successfully.\n");
+	ksft_print_msg("[STAGE 2] Finalizing test session...\n");
+	if (luo_session_finish(session_fd) < 0)
+		fail_exit("luo_session_finish for test session");
+	close(session_fd);
+
+	ksft_print_msg("[STAGE 2] Finalizing state session...\n");
+	if (luo_session_finish(state_session_fd) < 0)
+		fail_exit("luo_session_finish for state session");
+	close(state_session_fd);
+
+	ksft_print_msg("\n--- SIMPLE KEXEC TEST PASSED ---\n");
+}
+
+int main(int argc, char *argv[])
+{
+	int luo_fd;
+	int state_session_fd;
+
+	luo_fd = luo_open_device();
+	if (luo_fd < 0)
+		ksft_exit_skip("Failed to open %s. Is the luo module loaded?\n",
+			       LUO_DEVICE);
+
+	/*
+	 * Determine the stage by attempting to retrieve the state session.
+	 * If it doesn't exist (ENOENT), we are in Stage 1 (pre-kexec).
+	 */
+	state_session_fd = luo_retrieve_session(luo_fd, STATE_SESSION_NAME);
+	if (state_session_fd == -ENOENT) {
+		run_stage_1(luo_fd);
+	} else if (state_session_fd >= 0) {
+		/* We got a valid handle, pass it directly to stage 2 */
+		run_stage_2(luo_fd, state_session_fd);
+	} else {
+		fail_exit("Failed to check for state session");
+	}
+
+	close(luo_fd);
+}
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/luo_test_utils.c
new file mode 100644
index 000000000000..0a24105cbc54
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <stdarg.h>
+
+#include "luo_test_utils.h"
+
+int luo_open_device(void)
+{
+	return open(LUO_DEVICE, O_RDWR);
+}
+
+int luo_create_session(int luo_fd, const char *name)
+{
+	struct liveupdate_ioctl_create_session arg = { .size = sizeof(arg) };
+
+	snprintf((char *)arg.name, LIVEUPDATE_SESSION_NAME_LENGTH, "%.*s",
+		 LIVEUPDATE_SESSION_NAME_LENGTH - 1, name);
+
+	if (ioctl(luo_fd, LIVEUPDATE_IOCTL_CREATE_SESSION, &arg) < 0)
+		return -errno;
+
+	return arg.fd;
+}
+
+int luo_retrieve_session(int luo_fd, const char *name)
+{
+	struct liveupdate_ioctl_retrieve_session arg = { .size = sizeof(arg) };
+
+	snprintf((char *)arg.name, LIVEUPDATE_SESSION_NAME_LENGTH, "%.*s",
+		 LIVEUPDATE_SESSION_NAME_LENGTH - 1, name);
+
+	if (ioctl(luo_fd, LIVEUPDATE_IOCTL_RETRIEVE_SESSION, &arg) < 0)
+		return -errno;
+
+	return arg.fd;
+}
+
+int create_and_preserve_memfd(int session_fd, int token, const char *data)
+{
+	struct liveupdate_session_preserve_fd arg = { .size = sizeof(arg) };
+	long page_size = sysconf(_SC_PAGE_SIZE);
+	void *map = MAP_FAILED;
+	int mfd = -1, ret = -1;
+
+	mfd = memfd_create("test_mfd", 0);
+	if (mfd < 0)
+		return -errno;
+
+	if (ftruncate(mfd, page_size) != 0)
+		goto out;
+
+	map = mmap(NULL, page_size, PROT_WRITE, MAP_SHARED, mfd, 0);
+	if (map == MAP_FAILED)
+		goto out;
+
+	snprintf(map, page_size, "%s", data);
+	munmap(map, page_size);
+
+	arg.fd = mfd;
+	arg.token = token;
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
+		goto out;
+
+	ret = 0;
+out:
+	if (ret != 0 && errno != 0)
+		ret = -errno;
+	if (mfd >= 0)
+		close(mfd);
+	return ret;
+}
+
+int restore_and_verify_memfd(int session_fd, int token,
+			     const char *expected_data)
+{
+	struct liveupdate_session_retrieve_fd arg = { .size = sizeof(arg) };
+	long page_size = sysconf(_SC_PAGE_SIZE);
+	void *map = MAP_FAILED;
+	int mfd = -1, ret = -1;
+
+	arg.token = token;
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg) < 0)
+		return -errno;
+	mfd = arg.fd;
+
+	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, mfd, 0);
+	if (map == MAP_FAILED)
+		goto out;
+
+	if (expected_data && strcmp(expected_data, map) != 0) {
+		ksft_print_msg("Data mismatch! Expected '%s', Got '%s'\n",
+			       expected_data, (char *)map);
+		ret = -EINVAL;
+		goto out_munmap;
+	}
+
+	ret = mfd;
+out_munmap:
+	munmap(map, page_size);
+out:
+	if (ret < 0 && errno != 0)
+		ret = -errno;
+	if (ret < 0 && mfd >= 0)
+		close(mfd);
+	return ret;
+}
+
+int luo_session_finish(int session_fd)
+{
+	struct liveupdate_session_finish arg = { .size = sizeof(arg) };
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_FINISH, &arg) < 0)
+		return -errno;
+
+	return 0;
+}
+
+void create_state_file(int luo_fd, const char *session_name, int token,
+		       int next_stage)
+{
+	char buf[32];
+	int state_session_fd;
+
+	state_session_fd = luo_create_session(luo_fd, session_name);
+	if (state_session_fd < 0)
+		fail_exit("luo_create_session for state tracking");
+
+	snprintf(buf, sizeof(buf), "%d", next_stage);
+	if (create_and_preserve_memfd(state_session_fd, token, buf) < 0)
+		fail_exit("create_and_preserve_memfd for state tracking");
+
+	/*
+	 * DO NOT close session FD, otherwise it is going to be unpreserved
+	 */
+}
+
+void restore_and_read_stage(int state_session_fd, int token, int *stage)
+{
+	char buf[32] = {0};
+	int mfd;
+
+	mfd = restore_and_verify_memfd(state_session_fd, token, NULL);
+	if (mfd < 0)
+		fail_exit("failed to restore state memfd");
+
+	if (read(mfd, buf, sizeof(buf) - 1) < 0)
+		fail_exit("failed to read state mfd");
+
+	*stage = atoi(buf);
+
+	close(mfd);
+}
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.h b/tools/testing/selftests/liveupdate/luo_test_utils.h
new file mode 100644
index 000000000000..093e787b9f4b
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * Utility functions for LUO kselftests.
+ */
+
+#ifndef LUO_TEST_UTILS_H
+#define LUO_TEST_UTILS_H
+
+#include <errno.h>
+#include <string.h>
+#include <linux/liveupdate.h>
+#include "../kselftest.h"
+
+#define LUO_DEVICE "/dev/liveupdate"
+
+#define fail_exit(fmt, ...)						\
+	ksft_exit_fail_msg("[%s:%d] " fmt " (errno: %s)\n",	\
+			   __func__, __LINE__, ##__VA_ARGS__, strerror(errno))
+
+/* Generic LUO and session management helpers */
+int luo_open_device(void);
+int luo_create_session(int luo_fd, const char *name);
+int luo_retrieve_session(int luo_fd, const char *name);
+int luo_session_finish(int session_fd);
+
+/* Generic file preservation and restoration helpers */
+int create_and_preserve_memfd(int session_fd, int token, const char *data);
+int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
+
+/* Kexec state-tracking helpers */
+void create_state_file(int luo_fd, const char *session_name, int token,
+		       int next_stage);
+void restore_and_read_stage(int state_session_fd, int token, int *stage);
+
+#endif /* LUO_TEST_UTILS_H */
-- 
2.51.2.1041.gc1ab5b90ca-goog


