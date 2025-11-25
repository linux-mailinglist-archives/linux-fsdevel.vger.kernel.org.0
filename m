Return-Path: <linux-fsdevel+bounces-69824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1ECC861DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 577D14EBF60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB08533291F;
	Tue, 25 Nov 2025 16:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="UenYKkM/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8B32AACE
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089986; cv=none; b=gDhqvKb9LtdIe75DQNWNsfSOqCiE2TplDmpGKQGiQBs7A7yl0cgrEJgtOiy0p2vrKIYD8jDdCJclrdSfqYhx7X9YDUeizhxRITcXaxrqzg+hoGa2chi/wGjVsSFpnuDV34f8NnoiUzBoiJ/q/hov/yiNZ5xlyGmdPi1Xkt5dFuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089986; c=relaxed/simple;
	bh=G7Q0itscrNM8vJpPgM2kTNcPU4YmQP4p7bNpWy/a7kk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRAqAy8CN8x/2u8zaGn1ECYd2WGjr8ALhPWk1lf+EX0C0/U5z+zkaxMDmJ4B0G7VrYD+GzgtciSeWVJpkK5jn2ZXoCJyAOX6Nr+ng0a/z1ZDzTJz2n/zQbMhfHLzAz5xvNEVjT/MffIW6vVFd6soZ2e9wlexBFDnKPpG32fGIas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=UenYKkM/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78ab03c30ceso19923187b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089982; x=1764694782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vFlri8REH/qac3zTP1mpTsu23ZBhs3xYfWJv9me6+k=;
        b=UenYKkM/KBIO10KPDFiut3GDa2YGiBynyrhPNKT5owCSZJWVhcYZ36ub05X50ZNk1e
         JRdljqFOImAexPoA7Es7HcPMyBwesh1MOc2m16b7s1t8IKlWW5ShfPykxdeVSn14OqYz
         cixbaKk9lBycxn+9ulbPn+qgHWeWOEEwEMbiRiywwM9moRAVNHO94zt0GM1bi9l4zyuI
         Ki5xKWJ+DijN19qZ2kGy/qZlNHVhDjKHwLtzBbQp2w3RiU3wOTnjviLPPVaQ3yhxzOB3
         xwHw8kF4NPbNUSqdiZ0H19cdzaN0MpQbaIqfOrrMgURHDmrZRNegOU1hZZ7Rfb+ZjQ3H
         vRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089982; x=1764694782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6vFlri8REH/qac3zTP1mpTsu23ZBhs3xYfWJv9me6+k=;
        b=J1yb7phSUmMLETh7jS9KVfBV+R/LW16mg316dOC7qrrv/UnwXYTR0sE+nn1HltofI2
         zMStGfKjd94Q9wWYYNU0/YoSByVW82SeZ23bHcR84fxZMe2e/jMgVwGLl5gbxAAL9BOr
         Iri2czy4nbF2cFrlrpu49XHGmdYoqbUbcuxoiiIGbzErTSxjQoxNsz/6pT2KfU074xJO
         dcsWUCLhUv9UVLNe13xRSO0PiZvNBHY+6qHd6kq5cV1EOUMDRGfm9qegGyHXghOg44QM
         FFOfNipivDl97FvBIlqNkKULkfAJOz4tUO/R23uMPFq7f3h88QWrNqTsPvYq5rvn/xCW
         6bzw==
X-Forwarded-Encrypted: i=1; AJvYcCVwWQX5HEP8Iy9myTVizITdkTy9ZuiWeA/x5w0hA5XAKWpHZoZxdlXaL1HIEVjNbE5Ws7BDsfx3PJLnHMJz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt35adCFvEgHn7J/hbXHDyyjSP0flzSwkQYVOGB1w19i77HIeB
	IMTYT9UokK4GgFCsCHpSgAtxBvV5pbI1IUXfKANra8gLQfba9BlsZ5r78ZJz8N8r9S0=
X-Gm-Gg: ASbGncs64Xo/7+DMk6q1zD7F/7uwkJOwNamZyNoZKltqm4ATsT9JK+CgcqoV5iuFBS+
	xQLH9cNUISoQMmIFu9vzpoSEvFRO9cn+XyGIgnwiNRYzxt4qsdt0A2coNxRYV6vBZdTvg1xc6ge
	fTAer0MB9YvkJOoocYD4muuy4tdmWpwDTHAm0xTREW0HCYo2J494SLfz3nHDqAGBGXBTtgIijgO
	wsxe0lxTOImc9mjw6MH+VoVABQPaMmy0Q1GQsKBiZLHaTpTnwkSZ7mAL8AewOqcB3vYPO11QTBF
	7mYqphmVKJvY9oVnJFT5AXFTT5kLKpVmg9RFaDYDbwS7Vc8uqBx52ba0rGh2BHzEUZP4UvjBMDu
	SK2u450SKdy/U7l41x+6fR2217LMVJSNZPcXGVldHneTrn62AhMNMEK6IJAPSRrMmeEwhrLAZqJ
	rDvamVsMskQH/kraw+9MKM44afnfaG/ybR7w9qaedy/HObhZDalnzmulugQp1PK8rIFhnwp9ei5
	fw=
X-Google-Smtp-Source: AGHT+IHRC9KjSLkE1gdlWKz3GVcjnQbHxjnBnEjPOoxO9pY/zLR64stKUm4wy05jQAzAnoAL6WDFUg==
X-Received: by 2002:a05:690c:6c90:b0:783:7143:d825 with SMTP id 00721157ae682-78a8b497584mr142558557b3.25.1764089982243;
        Tue, 25 Nov 2025 08:59:42 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:41 -0800 (PST)
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
Subject: [PATCH v8 18/18] selftests/liveupdate: Add kexec test for multiple and empty sessions
Date: Tue, 25 Nov 2025 11:58:48 -0500
Message-ID: <20251125165850.3389713-19-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new kexec-based selftest, luo_kexec_multi_session, to
validate the end-to-end lifecycle of a more complex LUO scenario.

While the existing luo_kexec_simple test covers the basic end-to-end
lifecycle, it is limited to a single session with one preserved file.
This new test significantly expands coverage by verifying LUO's ability
to handle a mixed workload involving multiple sessions, some of which
are intentionally empty. This ensures that the LUO core correctly
preserves and restores the state of all session types across a reboot.

The test validates the following sequence:

Stage 1 (Pre-kexec):

  - Creates two empty test sessions (multi-test-empty-1,
    multi-test-empty-2).
  - Creates a session with one preserved memfd (multi-test-files-1).
  - Creates another session with two preserved memfds
    (multi-test-files-2), each containing unique data.
  - Creates a state-tracking session to manage the transition to
    Stage 2.
  - Executes a kexec reboot via the helper script.

Stage 2 (Post-kexec):

  - Retrieves the state-tracking session to confirm it is in the
    post-reboot stage.
  - Retrieves all four test sessions (both the empty and non-empty
    ones).
  - For the non-empty sessions, restores the preserved memfds and
    verifies their contents match the original data patterns.
  - Finalizes all test sessions and the state session to ensure a clean
    teardown and that all associated kernel resources are correctly
    released.

This test provides greater confidence in the robustness of the LUO
framework by validating its behavior in a more realistic, multi-faceted
scenario.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 .../selftests/liveupdate/luo_multi_session.c  | 162 ++++++++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/luo_multi_session.c

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index bbbec633970c..080754787ede 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -5,6 +5,7 @@ LIB_C += luo_test_utils.c
 TEST_GEN_PROGS += liveupdate
 
 TEST_GEN_PROGS_EXTENDED += luo_kexec_simple
+TEST_GEN_PROGS_EXTENDED += luo_multi_session
 
 TEST_FILES += do_kexec.sh
 
diff --git a/tools/testing/selftests/liveupdate/luo_multi_session.c b/tools/testing/selftests/liveupdate/luo_multi_session.c
new file mode 100644
index 000000000000..0ee2d795beef
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_multi_session.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ *
+ * A selftest to validate the end-to-end lifecycle of multiple LUO sessions
+ * across a kexec reboot, including empty sessions and sessions with multiple
+ * files.
+ */
+
+#include "luo_test_utils.h"
+
+#define SESSION_EMPTY_1 "multi-test-empty-1"
+#define SESSION_EMPTY_2 "multi-test-empty-2"
+#define SESSION_FILES_1 "multi-test-files-1"
+#define SESSION_FILES_2 "multi-test-files-2"
+
+#define MFD1_TOKEN 0x1001
+#define MFD2_TOKEN 0x2002
+#define MFD3_TOKEN 0x3003
+
+#define MFD1_DATA "Data for session files 1"
+#define MFD2_DATA "First file for session files 2"
+#define MFD3_DATA "Second file for session files 2"
+
+#define STATE_SESSION_NAME "kexec_multi_state"
+#define STATE_MEMFD_TOKEN 998
+
+/* Stage 1: Executed before the kexec reboot. */
+static void run_stage_1(int luo_fd)
+{
+	int s_empty1_fd, s_empty2_fd, s_files1_fd, s_files2_fd;
+
+	ksft_print_msg("[STAGE 1] Starting pre-kexec setup for multi-session test...\n");
+
+	ksft_print_msg("[STAGE 1] Creating state file for next stage (2)...\n");
+	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_MEMFD_TOKEN, 2);
+
+	ksft_print_msg("[STAGE 1] Creating empty sessions '%s' and '%s'...\n",
+		       SESSION_EMPTY_1, SESSION_EMPTY_2);
+	s_empty1_fd = luo_create_session(luo_fd, SESSION_EMPTY_1);
+	if (s_empty1_fd < 0)
+		fail_exit("luo_create_session for '%s'", SESSION_EMPTY_1);
+
+	s_empty2_fd = luo_create_session(luo_fd, SESSION_EMPTY_2);
+	if (s_empty2_fd < 0)
+		fail_exit("luo_create_session for '%s'", SESSION_EMPTY_2);
+
+	ksft_print_msg("[STAGE 1] Creating session '%s' with one memfd...\n",
+		       SESSION_FILES_1);
+
+	s_files1_fd = luo_create_session(luo_fd, SESSION_FILES_1);
+	if (s_files1_fd < 0)
+		fail_exit("luo_create_session for '%s'", SESSION_FILES_1);
+	if (create_and_preserve_memfd(s_files1_fd, MFD1_TOKEN, MFD1_DATA) < 0) {
+		fail_exit("create_and_preserve_memfd for token %#x",
+			  MFD1_TOKEN);
+	}
+
+	ksft_print_msg("[STAGE 1] Creating session '%s' with two memfds...\n",
+		       SESSION_FILES_2);
+
+	s_files2_fd = luo_create_session(luo_fd, SESSION_FILES_2);
+	if (s_files2_fd < 0)
+		fail_exit("luo_create_session for '%s'", SESSION_FILES_2);
+	if (create_and_preserve_memfd(s_files2_fd, MFD2_TOKEN, MFD2_DATA) < 0) {
+		fail_exit("create_and_preserve_memfd for token %#x",
+			  MFD2_TOKEN);
+	}
+	if (create_and_preserve_memfd(s_files2_fd, MFD3_TOKEN, MFD3_DATA) < 0) {
+		fail_exit("create_and_preserve_memfd for token %#x",
+			  MFD3_TOKEN);
+	}
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+/* Stage 2: Executed after the kexec reboot. */
+static void run_stage_2(int luo_fd, int state_session_fd)
+{
+	int s_empty1_fd, s_empty2_fd, s_files1_fd, s_files2_fd;
+	int mfd1, mfd2, mfd3, stage;
+
+	ksft_print_msg("[STAGE 2] Starting post-kexec verification...\n");
+
+	restore_and_read_stage(state_session_fd, STATE_MEMFD_TOKEN, &stage);
+	if (stage != 2) {
+		fail_exit("Expected stage 2, but state file contains %d",
+			  stage);
+	}
+
+	ksft_print_msg("[STAGE 2] Retrieving all sessions...\n");
+	s_empty1_fd = luo_retrieve_session(luo_fd, SESSION_EMPTY_1);
+	if (s_empty1_fd < 0)
+		fail_exit("luo_retrieve_session for '%s'", SESSION_EMPTY_1);
+
+	s_empty2_fd = luo_retrieve_session(luo_fd, SESSION_EMPTY_2);
+	if (s_empty2_fd < 0)
+		fail_exit("luo_retrieve_session for '%s'", SESSION_EMPTY_2);
+
+	s_files1_fd = luo_retrieve_session(luo_fd, SESSION_FILES_1);
+	if (s_files1_fd < 0)
+		fail_exit("luo_retrieve_session for '%s'", SESSION_FILES_1);
+
+	s_files2_fd = luo_retrieve_session(luo_fd, SESSION_FILES_2);
+	if (s_files2_fd < 0)
+		fail_exit("luo_retrieve_session for '%s'", SESSION_FILES_2);
+
+	ksft_print_msg("[STAGE 2] Verifying contents of session '%s'...\n",
+		       SESSION_FILES_1);
+	mfd1 = restore_and_verify_memfd(s_files1_fd, MFD1_TOKEN, MFD1_DATA);
+	if (mfd1 < 0)
+		fail_exit("restore_and_verify_memfd for token %#x", MFD1_TOKEN);
+	close(mfd1);
+
+	ksft_print_msg("[STAGE 2] Verifying contents of session '%s'...\n",
+		       SESSION_FILES_2);
+
+	mfd2 = restore_and_verify_memfd(s_files2_fd, MFD2_TOKEN, MFD2_DATA);
+	if (mfd2 < 0)
+		fail_exit("restore_and_verify_memfd for token %#x", MFD2_TOKEN);
+	close(mfd2);
+
+	mfd3 = restore_and_verify_memfd(s_files2_fd, MFD3_TOKEN, MFD3_DATA);
+	if (mfd3 < 0)
+		fail_exit("restore_and_verify_memfd for token %#x", MFD3_TOKEN);
+	close(mfd3);
+
+	ksft_print_msg("[STAGE 2] Test data verified successfully.\n");
+
+	ksft_print_msg("[STAGE 2] Finalizing all test sessions...\n");
+	if (luo_session_finish(s_empty1_fd) < 0)
+		fail_exit("luo_session_finish for '%s'", SESSION_EMPTY_1);
+	close(s_empty1_fd);
+
+	if (luo_session_finish(s_empty2_fd) < 0)
+		fail_exit("luo_session_finish for '%s'", SESSION_EMPTY_2);
+	close(s_empty2_fd);
+
+	if (luo_session_finish(s_files1_fd) < 0)
+		fail_exit("luo_session_finish for '%s'", SESSION_FILES_1);
+	close(s_files1_fd);
+
+	if (luo_session_finish(s_files2_fd) < 0)
+		fail_exit("luo_session_finish for '%s'", SESSION_FILES_2);
+	close(s_files2_fd);
+
+	ksft_print_msg("[STAGE 2] Finalizing state session...\n");
+	if (luo_session_finish(state_session_fd) < 0)
+		fail_exit("luo_session_finish for state session");
+	close(state_session_fd);
+
+	ksft_print_msg("\n--- MULTI-SESSION KEXEC TEST PASSED ---\n");
+}
+
+int main(int argc, char *argv[])
+{
+	return luo_test(argc, argv, STATE_SESSION_NAME,
+			run_stage_1, run_stage_2);
+}
-- 
2.52.0.460.gd25c4c69ec-goog


