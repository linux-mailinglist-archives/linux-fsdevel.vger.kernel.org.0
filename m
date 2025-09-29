Return-Path: <linux-fsdevel+bounces-62983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66E1BA7BC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4E63A3311
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8A2C032C;
	Mon, 29 Sep 2025 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="M8by+FzY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B32BDC2F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107896; cv=none; b=Y/9aMD2t4gAGtB/xHueYgrvB7IvJtbaKgo3qLFJuSCsve3eLlqW1rM4YelSKdZxwGnmGH/nQrdPfFaFNfB1zOdloZcReudqrFPk81ovrXbNbXsgoj+MqBMLd/SQqHkuPQuSM7XzYsamW3WuJR3vx7Ehtl4WWqIfFfENcTZbNKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107896; c=relaxed/simple;
	bh=IO1VyVAb8djvsCGtCT3kCdTlkiwVfW7taQgdIXRPTtw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTuy9ECBG7U7y9zR2AuXgzOLgsYLhLWB/jfcworWB79W+WeXH4gM9kF+mv6LXWOyyBEulS5ipBo0107Heo1BmFDDWTAMnVDlcsD7mP4cabcW3IRnIPi0xA1mFXAE5CDP/aKGpA66Y6Q4fitXlb0O1/PUCEY731Z/3M2bstyvzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=M8by+FzY; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4df4d23fb59so16775981cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107891; x=1759712691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qnDErCVzLoc/L71Odr4fuNY8x0m/A8ysS1VGAup5oYo=;
        b=M8by+FzY8xRJnamukkpq+ZEM/Wdw2JO1YzGbcxu42cN4zg/gvsRTpCtyleP/B0leOx
         IsZnJTgKpZJK7HRwY7eeIeKELh3PpJWFi1kmJQLP1ld+a/94axEQm1zI7S+MJxVydUMj
         tgeg+zoIEMrbf1U9trUa1fPpphWKiGSZPIANXyzOASN6eowm5s6qSkfzI0oVy6jd5IGc
         CUDGL0MbK01gursL5cvqZI7toHHCpGX0uiHyvcU8+TrnoQ5MBX6HOPqXQ/GoRl8zbphy
         xLgIOlwh/sFFnRxcYDpWEJF+ATuAjsG0yBK+PpQrNS1IEdqCELd0khs3hOzbPteX0o9w
         Ud3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107891; x=1759712691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnDErCVzLoc/L71Odr4fuNY8x0m/A8ysS1VGAup5oYo=;
        b=cRWxkUqs3Jiaoq8Y6fomzSUqPfwqt40h78/l0m+RPE1mUJdn9ek8uCZeR3gMGlD1xO
         HXkXEmVDah/ESpkiQZZsIfpJTMBaxFRAbFxdimN4zIFavW9Z87QWZkoX0X3jn0T5d7dC
         rHOVSw8pkT4njKJeH7D+ZcVDQkOOhw9fhvvYj0In1nvGUClm6rj0o4WykKV8p5BEjwuL
         Ma1FUVdzE+c8AosHF1vYfytxMyCXZElYzhZPJvJCovfNH7hVy5ozc+jWZEDhIc81ETu8
         Uj3oAKtpsHAkMyFAyC2VFLF0ffogRM9e6+QaJP8ZyhszNy99VGdf0dIlRIUo9reWWTFx
         N+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVeol2i+1zRtel7Ho0Hy7M1qHD6IV0OoCIKiRN3Gs5z7bsNtxzzqzLrEEUNX8bnyb60l6cXxdjaELn+aLXH@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDWcFE0hj69lxrATPeGPWPcEEoZi/IhXOjcoSwg5eKVPG8co3
	KErv1wnARk2G6X6J8bkmOwqC9MW+oaobiauCSmKB6jB+XDLlQi2Jb4OItKD/HRNDYyU=
X-Gm-Gg: ASbGncvtoVnj9IFceffyGizuC2EQymlTBD9Ic+Irpy0EALJgxFY3WP3Pb0oTJd5ENC7
	q12aHVYvErtV1xYRjv21w2ufrDVPuMs7A5m7rjknWAqwNQvJO8Yd1lK9bXyOQ3gHFejHFIL+3SE
	m6ySMdHjzv8kA75y5XLmSiqzLIhVf1n+DvhFySc115DKvUZb/2J8Z5r/j5LMl3vpB3bScXuO21M
	9Xt9aiqtzocJenkKYVB/KIEfCv/NwiBgPz7dO1lX2hzSS/FDXjmfWDd/86YpvXCNTu6tNzoR45b
	+tPDRBM1AkQMlxrgkVDZZZio7dBDWjKhOt67XAqlQYD1jNBq+h1HMVSiFpJTXxLufwA4kp9wi9j
	sWmMMttZqK4qRe51LWLLySO8BauCG4Jb3oRtdVTiaPqUCvAJsHQpzGcC4k3Syo91iEddXCeZWi3
	lXuYSgL2M=
X-Google-Smtp-Source: AGHT+IGxz4bz/Ulq2oqYfhk12cyeqtFbLsr8uDXkWRvJE5REk0ihSw3RWoQtagO38Ya8siWyMamt7g==
X-Received: by 2002:ac8:7d8e:0:b0:4d0:7fc9:5c6 with SMTP id d75a77b69052e-4da4b42cbfcmr192806211cf.50.1759107890439;
        Sun, 28 Sep 2025 18:04:50 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:49 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
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
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 26/30] selftests/liveupdate: Add multi-kexec session lifecycle test
Date: Mon, 29 Sep 2025 01:03:17 +0000
Message-ID: <20250929010321.3462457-27-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce multi-stage selftest, luo_multi_kexec, to validate the
end-to-end lifecycle of Live Update Orchestrator sessions
across multiple kexec reboots.

The test operates in three stages, using a preserved memfd within a
dedicated "state_session" to track its progress across reboots. This
avoids reliance on filesystem flags and tests the core preservation
mechanism itself.

The test validates the following critical LUO functionalities:

1. Initial Preservation (Stage 1 -> 2):
- Creates multiple sessions (session-A, session-B, session-C) and
  populates them with memfd files containing unique data.
- Triggers a global LIVEUPDATE_PREPARE event and executes the first
  kexec.

2. Intermediate State Management (Stage 2 -> 3):
- After the first reboot, it verifies that all sessions were correctly
  preserved.
- It then tests divergent session lifecycles:
  - Session A: Is retrieved and explicitly finalized with a
    per-session LIVEUPDATE_FINISH event. This validates that a finished
    session is not carried over to the next kexec.
  - Session B: Is retrieved but left open. This validates that an
    active, retrieved session is correctly re-preserved during the next
    global PREPARE.
  - Session C: Is deliberately not retrieved. This validates that the
    global LIVEUPDATE_FINISH event correctly identifies and cleans up
    stale, unreclaimed sessions.
- The state-tracking memfd is updated by un-preserving and re-preserving
  it, testing in-place modification of a session's contents.
- A global FINISH followed by a global PREPARE is triggered before the
  second kexec.

3. Final Verification (Stage 3):
- After the second reboot, it confirms the final state:
  - Asserts that session-B (the re-preserved session) and the updated
    state session have survived.
  - Asserts that session-A (explicitly finished) and session-C
    (unreclaimed) were correctly cleaned up and no longer exist.

Example output:

root@debian-vm:~/liveupdate$ ./luo_multi_kexec
LUO state is NORMAL. Starting Stage 1.
[STAGE 1] Creating state file for next stage (2)...
[STAGE 1] Setting up Sessions A, B, C for first kexec...
  - Session 'session-A' created.
  - Session 'session-B' created.
  - Session 'session-C' created.
[STAGE 1] Triggering global PREPARE...
[STAGE 1] Executing kexec...
<---- cut reboot messages ---->
Debian GNU/Linux 12 debian-vm ttyS0

debian-vm login: root (automatic login)

root@debian-vm:~$ cd liveupdate/
root@debian-vm:~/liveupdate$ ./luo_multi_kexec
LUO state is UPDATED. Restoring state to determine stage...
State file indicates we are entering Stage 2.
[STAGE 2] Partially reclaiming and preparing for second kexec...
  - Verifying session 'session-A'...
    Success. All files verified.
  - Verifying session 'session-B'...
    Success. All files verified.
  - Finishing state session to allow modification...
  - Updating state file for next stage (3)...
  - Session A verified. Sending per-session FINISH.
  - Session B verified. Keeping FD open for next kexec.
  - NOT retrieving Session C to test global finish cleanup.
[STAGE 2] Triggering global FINISH...
[STAGE 2] Triggering global PREPARE for next kexec...
[STAGE 2] Executing second kexec...
<---- cut reboot messages ---->
Debian GNU/Linux 12 debian-vm ttyS0

debian-vm login: root (automatic login)

root@debian-vm:~$ cd liveupdate/
root@debian-vm:~/liveupdate$ ./luo_multi_kexec
LUO state is UPDATED. Restoring state to determine stage...
State file indicates we are entering Stage 3.
[STAGE 3] Final verification...
[STAGE 3] Verifying surviving sessions...
  - Verifying session 'session-B'...
    Success. All files verified.
[STAGE 3] Verifying Session A was cleaned up...
  Success. Session A not found as expected.
[STAGE 3] Verifying Session C was cleaned up...
  Success. Session C not found as expected.
[STAGE 3] Triggering final global FINISH...

--- TEST PASSED ---

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |  31 +++
 .../testing/selftests/liveupdate/do_kexec.sh  |   6 +
 .../selftests/liveupdate/luo_multi_kexec.c    | 182 +++++++++++++
 .../selftests/liveupdate/luo_test_utils.c     | 241 ++++++++++++++++++
 .../selftests/liveupdate/luo_test_utils.h     |  51 ++++
 6 files changed, 512 insertions(+)
 create mode 100755 tools/testing/selftests/liveupdate/do_kexec.sh
 create mode 100644 tools/testing/selftests/liveupdate/luo_multi_kexec.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.c
 create mode 100644 tools/testing/selftests/liveupdate/luo_test_utils.h

diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testing/selftests/liveupdate/.gitignore
index af6e773cf98f..de7ca45d3892 100644
--- a/tools/testing/selftests/liveupdate/.gitignore
+++ b/tools/testing/selftests/liveupdate/.gitignore
@@ -1 +1,2 @@
 /liveupdate
+/luo_multi_kexec
diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 2a573c36016e..1cbc816ed5c5 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -1,7 +1,38 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+KHDR_INCLUDES ?= -I../../../usr/include
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
+LDFLAGS += -static
+
+# --- Test Configuration (Edit this section when adding new tests) ---
+LUO_SHARED_SRCS := luo_test_utils.c
+LUO_SHARED_HDRS += luo_test_utils.h
+
+LUO_MANUAL_TESTS += luo_multi_kexec
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
diff --git a/tools/testing/selftests/liveupdate/luo_multi_kexec.c b/tools/testing/selftests/liveupdate/luo_multi_kexec.c
new file mode 100644
index 000000000000..1f350990ee67
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_multi_kexec.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include "luo_test_utils.h"
+
+#define KEXEC_SCRIPT "./do_kexec.sh"
+
+#define NUM_SESSIONS 3
+
+/* Helper to set up one session and all its files */
+static void setup_session(int luo_fd, struct session_info *s, int session_idx)
+{
+	int i;
+
+	snprintf(s->name, sizeof(s->name), "session-%c", 'A' + session_idx);
+
+	s->fd = luo_create_session(luo_fd, s->name);
+	if (s->fd < 0)
+		fail_exit("luo_create_session for %s", s->name);
+
+	for (i = 0; i < 2; i++) {
+		s->file_tokens[i] = (session_idx * 100) + i;
+		snprintf(s->file_data[i], sizeof(s->file_data[i]),
+			 "Data for %.*s-File%d",
+			 (int)sizeof(s->name), s->name, i);
+
+		if (create_and_preserve_memfd(s->fd, s->file_tokens[i],
+					      s->file_data[i]) < 0)
+			fail_exit("create_and_preserve_memfd for token %d",
+				  s->file_tokens[i]);
+	}
+}
+
+/* Run before the first kexec */
+static void run_stage_1(int luo_fd)
+{
+	struct session_info sessions[NUM_SESSIONS] = {0};
+	int i;
+
+	ksft_print_msg("[STAGE 1] Creating state file for next stage (2)...\n");
+	create_state_file(luo_fd, 2);
+
+	ksft_print_msg("[STAGE 1] Setting up Sessions A, B, C for first kexec...\n");
+	for (i = 0; i < NUM_SESSIONS; i++) {
+		setup_session(luo_fd, &sessions[i], i);
+		ksft_print_msg("  - Session '%s' created.\n", sessions[i].name);
+	}
+
+	ksft_print_msg("[STAGE 1] Triggering global PREPARE...\n");
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_PREPARE) < 0)
+		fail_exit("luo_set_global_event(PREPARE)");
+
+	ksft_print_msg("[STAGE 1] Executing kexec...\n");
+	if (system(KEXEC_SCRIPT) != 0)
+		fail_exit("kexec script failed");
+
+	/* Should not be reached */
+	sleep(10);
+	exit(EXIT_FAILURE);
+}
+
+/* Run after first kexec, before second kexec */
+static void run_stage_2(int luo_fd, int state_session_fd)
+{
+	struct session_info sessions[NUM_SESSIONS] = {0};
+	int session_fd_A;
+
+	ksft_print_msg("[STAGE 2] Partially reclaiming and preparing for second kexec...\n");
+
+	reinit_all_sessions(sessions, NUM_SESSIONS);
+
+	session_fd_A = verify_session_and_get_fd(luo_fd, &sessions[0]);
+	verify_session_and_get_fd(luo_fd, &sessions[1]);
+
+	ksft_print_msg("  - Finishing state session to allow modification...\n");
+	if (luo_set_session_event(state_session_fd, LIVEUPDATE_FINISH) < 0)
+		fail_exit("luo_set_session_event(FINISH) for state_session");
+
+	ksft_print_msg("  - Updating state file for next stage (3)...\n");
+	update_state_file(state_session_fd, 3);
+
+	ksft_print_msg("  - Session A verified. Sending per-session FINISH.\n");
+	if (luo_set_session_event(session_fd_A, LIVEUPDATE_FINISH) < 0)
+		fail_exit("luo_set_session_event(FINISH) for Session A");
+	close(session_fd_A);
+
+	ksft_print_msg("  - Session B verified. Its FD will be auto-closed for next kexec.\n");
+	ksft_print_msg("  - NOT retrieving Session C to test global finish cleanup.\n");
+
+	ksft_print_msg("[STAGE 2] Triggering global FINISH...\n");
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_FINISH) < 0)
+		fail_exit("luo_set_global_event(FINISH)");
+
+	ksft_print_msg("[STAGE 2] Triggering global PREPARE for next kexec...\n");
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_PREPARE) < 0)
+		fail_exit("luo_set_global_event(PREPARE)");
+
+	ksft_print_msg("[STAGE 2] Executing second kexec...\n");
+	if (system(KEXEC_SCRIPT) != 0)
+		fail_exit("kexec script failed");
+
+	sleep(10);
+	exit(EXIT_FAILURE);
+}
+
+/* Run after second kexec */
+static void run_stage_3(int luo_fd)
+{
+	struct session_info sessions[NUM_SESSIONS] = {0};
+	int ret;
+
+	ksft_print_msg("[STAGE 3] Final verification...\n");
+
+	reinit_all_sessions(sessions, NUM_SESSIONS);
+
+	ksft_print_msg("[STAGE 3] Verifying surviving sessions...\n");
+	/* Session B */
+	verify_session_and_get_fd(luo_fd, &sessions[1]);
+
+	ksft_print_msg("[STAGE 3] Verifying Session A was cleaned up...\n");
+	ret = luo_retrieve_session(luo_fd, sessions[0].name);
+	if (ret != -ENOENT)
+		fail_exit("Expected ENOENT for Session A, but got %d", ret);
+	ksft_print_msg("  Success. Session A not found as expected.\n");
+
+	ksft_print_msg("[STAGE 3] Verifying Session C was cleaned up...\n");
+	ret = luo_retrieve_session(luo_fd, sessions[2].name);
+	if (ret != -ENOENT)
+		fail_exit("Expected ENOENT for Session C, but got %d", ret);
+	ksft_print_msg("  Success. Session C not found as expected.\n");
+
+	ksft_print_msg("[STAGE 3] Triggering final global FINISH...\n");
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_FINISH) < 0)
+		fail_exit("luo_set_global_event(FINISH)");
+
+	ksft_print_msg("\n--- MULTI-KEXEC TEST PASSED ---\n");
+}
+
+int main(int argc, char *argv[])
+{
+	enum liveupdate_state state;
+	int luo_fd, stage = 0;
+
+	luo_fd = luo_open_device();
+	if (luo_fd < 0) {
+		ksft_exit_skip("Failed to open %s. Is the luo module loaded?\n",
+			       LUO_DEVICE);
+	}
+
+	if (luo_get_global_state(luo_fd, &state) < 0)
+		fail_exit("luo_get_global_state");
+
+	if (state == LIVEUPDATE_STATE_NORMAL) {
+		ksft_print_msg("LUO state is NORMAL. Starting Stage 1.\n");
+		run_stage_1(luo_fd);
+	} else if (state == LIVEUPDATE_STATE_UPDATED) {
+		int state_session_fd;
+
+		ksft_print_msg("LUO state is UPDATED. Restoring state to determine stage...\n");
+		state_session_fd = restore_and_read_state(luo_fd, &stage);
+		if (state_session_fd < 0)
+			fail_exit("Could not restore test state");
+
+		if (stage == 2) {
+			ksft_print_msg("State file indicates we are entering Stage 2.\n");
+			run_stage_2(luo_fd, state_session_fd);
+		} else if (stage == 3) {
+			ksft_print_msg("State file indicates we are entering Stage 3.\n");
+			run_stage_3(luo_fd);
+		} else {
+			fail_exit("Invalid stage found in state file: %d",
+				  stage);
+		}
+	}
+
+	close(luo_fd);
+	ksft_exit_pass();
+}
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/luo_test_utils.c
new file mode 100644
index 000000000000..c0840e6e66fd
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.c
@@ -0,0 +1,241 @@
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
+#include "../kselftest.h"
+
+/* The fail_exit function is now a macro in the header. */
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
+	if (ioctl(luo_fd, LIVEUPDATE_IOCTL_CREATE_SESSION, &arg) < 0)
+		return -errno;
+	return arg.fd;
+}
+
+int luo_retrieve_session(int luo_fd, const char *name)
+{
+	struct liveupdate_ioctl_retrieve_session arg = { .size = sizeof(arg) };
+
+	snprintf((char *)arg.name, LIVEUPDATE_SESSION_NAME_LENGTH, "%.*s",
+		 LIVEUPDATE_SESSION_NAME_LENGTH - 1, name);
+	if (ioctl(luo_fd, LIVEUPDATE_IOCTL_RETRIEVE_SESSION, &arg) < 0)
+		return -errno;
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
+	ret = 0; /* Success */
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
+	struct liveupdate_session_restore_fd arg = { .size = sizeof(arg) };
+	long page_size = sysconf(_SC_PAGE_SIZE);
+	void *map = MAP_FAILED;
+	int mfd = -1, ret = -1;
+
+	arg.token = token;
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_RESTORE_FD, &arg) < 0)
+		return -errno;
+	mfd = arg.fd;
+
+	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, mfd, 0);
+	if (map == MAP_FAILED)
+		goto out;
+
+	if (expected_data && strcmp(expected_data, map) != 0) {
+		ksft_print_msg("Data mismatch for token %d!\n", token);
+		ret = -EINVAL;
+		goto out_munmap;
+	}
+
+	ret = mfd; /* Success, return the new fd */
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
+int luo_set_session_event(int session_fd, enum liveupdate_event event)
+{
+	struct liveupdate_session_set_event arg = { .size = sizeof(arg) };
+
+	arg.event = event;
+	return ioctl(session_fd, LIVEUPDATE_SESSION_SET_EVENT, &arg);
+}
+
+int luo_set_global_event(int luo_fd, enum liveupdate_event event)
+{
+	struct liveupdate_ioctl_set_event arg = { .size = sizeof(arg) };
+
+	arg.event = event;
+	return ioctl(luo_fd, LIVEUPDATE_IOCTL_SET_EVENT, &arg);
+}
+
+int luo_get_global_state(int luo_fd, enum liveupdate_state *state)
+{
+	struct liveupdate_ioctl_get_state arg = { .size = sizeof(arg) };
+
+	if (ioctl(luo_fd, LIVEUPDATE_IOCTL_GET_STATE, &arg) < 0)
+		return -errno;
+	*state = arg.state;
+	return 0;
+}
+
+void create_state_file(int luo_fd, int next_stage)
+{
+	char buf[32];
+	int state_session_fd;
+
+	state_session_fd = luo_create_session(luo_fd, STATE_SESSION_NAME);
+	if (state_session_fd < 0)
+		fail_exit("luo_create_session failed");
+
+	snprintf(buf, sizeof(buf), "%d", next_stage);
+	if (create_and_preserve_memfd(state_session_fd,
+				      STATE_MEMFD_TOKEN, buf) < 0) {
+		fail_exit("create_and_preserve_memfd failed");
+	}
+}
+
+int restore_and_read_state(int luo_fd, int *stage)
+{
+	char buf[32] = {0};
+	int state_session_fd, mfd;
+
+	state_session_fd = luo_retrieve_session(luo_fd, STATE_SESSION_NAME);
+	if (state_session_fd < 0)
+		return state_session_fd;
+
+	mfd = restore_and_verify_memfd(state_session_fd, STATE_MEMFD_TOKEN,
+				       NULL);
+	if (mfd < 0)
+		fail_exit("failed to restore state memfd");
+
+	if (read(mfd, buf, sizeof(buf) - 1) < 0)
+		fail_exit("failed to read state mfd");
+
+	*stage = atoi(buf);
+
+	close(mfd);
+	return state_session_fd;
+}
+
+void update_state_file(int session_fd, int next_stage)
+{
+	char buf[32];
+	struct liveupdate_session_unpreserve_fd arg = { .size = sizeof(arg) };
+
+	arg.token = STATE_MEMFD_TOKEN;
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_UNPRESERVE_FD, &arg) < 0)
+		fail_exit("unpreserve failed");
+
+	snprintf(buf, sizeof(buf), "%d", next_stage);
+	if (create_and_preserve_memfd(session_fd, STATE_MEMFD_TOKEN, buf) < 0)
+		fail_exit("create_and_preserve failed");
+}
+
+void reinit_all_sessions(struct session_info *sessions, int num)
+{
+	int i, j;
+
+	for (i = 0; i < num; i++) {
+		snprintf(sessions[i].name, sizeof(sessions[i].name),
+			 "session-%c", 'A' + i);
+		for (j = 0; j < 2; j++) {
+			sessions[i].file_tokens[j] = (i * 100) + j;
+			snprintf(sessions[i].file_data[j],
+				 sizeof(sessions[i].file_data[j]),
+				 "Data for %.*s-File%d",
+				 LIVEUPDATE_SESSION_NAME_LENGTH,
+				 sessions[i].name, j);
+		}
+	}
+}
+
+int verify_session_and_get_fd(int luo_fd, struct session_info *s)
+{
+	int i, session_fd;
+
+	ksft_print_msg("  - Verifying session '%s'...\n", s->name);
+
+	session_fd = luo_retrieve_session(luo_fd, s->name);
+	if (session_fd < 0)
+		fail_exit("luo_retrieve_session for %s", s->name);
+
+	for (i = 0; i < 2; i++) {
+		int mfd = restore_and_verify_memfd(session_fd,
+						   s->file_tokens[i],
+						   s->file_data[i]);
+		if (mfd < 0) {
+			fail_exit("restore_and_verify_memfd for token %d",
+				  s->file_tokens[i]);
+		}
+		close(mfd);
+	}
+	ksft_print_msg("    Success. All files verified.\n");
+	return session_fd;
+}
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.h b/tools/testing/selftests/liveupdate/luo_test_utils.h
new file mode 100644
index 000000000000..e30cfcb0a596
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
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
+#define STATE_SESSION_NAME "state_session"
+#define STATE_MEMFD_TOKEN 999
+
+#define MAX_FILES_PER_SESSION 5
+
+struct session_info {
+	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
+	int fd;
+	int file_tokens[MAX_FILES_PER_SESSION];
+	char file_data[MAX_FILES_PER_SESSION][128];
+};
+
+#define fail_exit(fmt, ...)						\
+	ksft_exit_fail_msg("[%s] " fmt " (errno: %s)\n",		\
+			   __func__, ##__VA_ARGS__, strerror(errno))
+
+int luo_open_device(void);
+
+int luo_create_session(int luo_fd, const char *name);
+int luo_retrieve_session(int luo_fd, const char *name);
+
+int create_and_preserve_memfd(int session_fd, int token, const char *data);
+int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
+int verify_session_and_get_fd(int luo_fd, struct session_info *s);
+
+int luo_set_session_event(int session_fd, enum liveupdate_event event);
+int luo_set_global_event(int luo_fd, enum liveupdate_event event);
+int luo_get_global_state(int luo_fd, enum liveupdate_state *state);
+
+void create_state_file(int luo_fd, int next_stage);
+int restore_and_read_state(int luo_fd, int *stage);
+void update_state_file(int session_fd, int next_stage);
+void reinit_all_sessions(struct session_info *sessions, int num);
+
+#endif /* LUO_TEST_UTILS_H */
-- 
2.51.0.536.g15c5d4f767-goog


