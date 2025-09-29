Return-Path: <linux-fsdevel+bounces-62986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F278BA7BBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B574189A314
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CEE2C11F4;
	Mon, 29 Sep 2025 01:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="P15rTLZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C532BF017
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107899; cv=none; b=pUdrqm+vDErQteI4KdJ/dM4lbt9q3HrRXA3I2+LBdXaKUuIfdY96uwXMenitJD4Hn/OtyJsUIJOUsq5sVuc7cK/jRDN7e9dqUrx5qbVrTvDPtHuiEjT/cx/DzCkCVKD/FIxzTesswatrhcNIaOtwsiQrTtPSueiU8vCiWHpReIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107899; c=relaxed/simple;
	bh=/p25wN3NUJJNuRoY3XDprKeWUbooH5B1sb7ey2HL834=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJ+EZjXpnUUUTMgbE/QBnSe88GvO0jvsEfXRvUGgW3a3WjrrGhAejDPc306gdJ6TwBCZLllKGL+IZoAAFmOyavn1ywwdJVQ+yTjOjItMGHrKnk+4NL71/1D5zGdxYPq/+oInA2mjAMWG33J6DTDSVDR/fdaIekSHTqNuhA9yhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=P15rTLZs; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4dfd1f48d4cso7220151cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107895; x=1759712695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2v75INyzNMPI4oEdp2NmuGRVQWzF+umEVMJPwM0ApE=;
        b=P15rTLZsu20GbwuziMOIqH3PYd9Ypt9KilmCFFAZ8eOQ9RVArqqevuRa3zw/N59m3V
         6rVWvYnHWdpuYxwqQvRT38BEzNl7KdRSMcCxBkq8pFZbwK98+9KCVlgymT12fexiWw+8
         Ly/P9kszLY73bC+MmHqOD4qpq706BcaWOGH0BkFQb9vU+bc9sGEtrWB3FeYUvioyWKNJ
         oZa0mRjpVZPYvi7WkSRTQHZtJjIJe+X4mYed7DnIz5PfirL/yNyo774Rv10hptZilXqA
         TCuUNyyXKPelTXq7nRwWE756fI2P3kYBXAz6Hhh7qVw8+mDtuzE3k38M7euDWzjhnE9Q
         sqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107895; x=1759712695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2v75INyzNMPI4oEdp2NmuGRVQWzF+umEVMJPwM0ApE=;
        b=OYsjFw63pMz/5t/dSi4hTGOsXgCRYQdoWsq2XmUqi7cVTefiuNE9Ig/GwOv4AvdVEX
         sNeLr/f3x5OrDchZbQMeXtfHyU5P2UIg8DBEgBkl15XMY4Rhhkxa6aZofDfySYNtcCGZ
         cneRyR6nh1sOVeEogVXYtNvJh3wV5iDY0yujjG28bfoeiJ5heXwAWUi37TSkUniIKmt8
         dbXufM+wCiRPUVG817BI0ng37yIODzl2b5FcC//8gX/2TqDBHdL+a3YhA/i8AxyiuS1x
         GMk9+G5q+UBDHbXH0Tjsw7751tffkY+GwyhDKmZHORC+7UeKR2EkMR8yBqazwkTDXBBr
         yiWw==
X-Forwarded-Encrypted: i=1; AJvYcCX6CBMgdRdSbQtzsnXeBJUq/0KOnqa6QoKNvU1VZ3hhKlmw7Sxl6LqQt6F/XyUIo9LGPPOUwmNU3dsVmotW@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbuTBuRkegZTFimDrqSXqHojockztySG40oBY0FmkVkoY2xpR
	QDfm6/Cb96yW+t9OdWJf8csSj4Xb5k+GSx4v6xzQPJH9oNpvNekdW5dRnSi6WTgkvCo=
X-Gm-Gg: ASbGncvMWA5W0vBisYWnfe5Dn6PF4ldYC07X98TIp/fOQcaIL4v/+FL7iYI+dqBaL5D
	9B/sy7ILMKWtbg3ANn9zQ+JLQYd8p0OsgbE8swkbXX2x3kHJo1gU2L/vWNRiT2lQObRKcKRATjH
	6iSWR/rRvbfngps/0jk+uN4+bEg0/hfFAuYShgQq8lvRy7iX4ZAy3G6wvCnKGkuSW5Uz6aE9mz6
	NQCpss4cvWn/w5IWxIqgsr7gQLZiLP6/UKUrdJOOtCqrNeBiBzMDlAiNyPzoz2LQqWyhUnrv5Q3
	hEDsY7Z81BOoTLz072/gLJAQbdE9EZwbavwUFhaeciIZkQ+XaEswHQR2J8kaDxRxoKzrCQZ3foW
	GgdJBHqdJy31i6xvMxa9BS8flCjlELHoabAEHo63rUrL2sms+YYWtGFqprPn9/FZT4aogMxOhfs
	tYbtvF0AA=
X-Google-Smtp-Source: AGHT+IGNYpnFHhEDZ7IQxe60li51JF8Ceu8MZliO1sqTV6jJCplnwCE0LZP4epB2zRmz4aDw8ZyDcw==
X-Received: by 2002:a05:622a:1e89:b0:4cc:d6f0:2e41 with SMTP id d75a77b69052e-4da47354de0mr216005241cf.6.1759107894911;
        Sun, 28 Sep 2025 18:04:54 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:54 -0700 (PDT)
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
Subject: [PATCH v4 29/30] selftests/liveupdate: Add test for unreclaimed resource cleanup
Date: Mon, 29 Sep 2025 01:03:20 +0000
Message-ID: <20250929010321.3462457-30-pasha.tatashin@soleen.com>
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

Introduce a new selftest, luo_unreclaimed, to specifically validate that
the LUO framework correctly identifies and cleans up preserved
resources that are not restored by userspace after a kexec reboot.

Ensuring proper cleanup of unreclaimed (or "abandoned") resources is
critical for preventing resource leaks in the kernel. This test provides
a focused scenario to verify this cleanup path, which is a key aspect of
the LUO's robustness.

The test performs a full kexec cycle with the following simple flow:

1. Pre-kexec:
  - A single session is created.
  - Two memfd files are preserved: File A (which will be restored) and
    File B (which will be abandoned).
  - The global LIVEUPDATE_PREPARE event is triggered, and the system
    reboots.
2. Post-kexec:
  - The preserved session is retrieved.
  - Only File A is restored and its contents are verified to confirm the
    basic preservation mechanism is working.
  - File B is intentionally not restored.
  - The global LIVEUPDATE_FINISH event is triggered.
3. Verification:
  - The test passes if File A is verified successfully.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/liveupdate/Makefile   |   1 +
 .../selftests/liveupdate/luo_unreclaimed.c    | 107 ++++++++++++++++++
 2 files changed, 108 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/luo_unreclaimed.c

diff --git a/tools/testing/selftests/liveupdate/Makefile b/tools/testing/selftests/liveupdate/Makefile
index 72892942dd61..ffce73233149 100644
--- a/tools/testing/selftests/liveupdate/Makefile
+++ b/tools/testing/selftests/liveupdate/Makefile
@@ -12,6 +12,7 @@ LUO_SHARED_HDRS += luo_test_utils.h
 LUO_MANUAL_TESTS += luo_multi_file
 LUO_MANUAL_TESTS += luo_multi_kexec
 LUO_MANUAL_TESTS += luo_multi_session
+LUO_MANUAL_TESTS += luo_unreclaimed
 
 TEST_FILES += do_kexec.sh
 
diff --git a/tools/testing/selftests/liveupdate/luo_unreclaimed.c b/tools/testing/selftests/liveupdate/luo_unreclaimed.c
new file mode 100644
index 000000000000..c3921b21b97b
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/luo_unreclaimed.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include "luo_test_utils.h"
+#include "../kselftest.h"
+
+#define KEXEC_SCRIPT "./do_kexec.sh"
+
+#define SESSION_NAME "unreclaimed_session"
+#define TOKEN_A 100
+#define TOKEN_B 200
+#define DATA_A "This is file A, the one we retrieve."
+#define DATA_B "This is file B, the one we abandon."
+
+static void run_pre_kexec(int luo_fd)
+{
+	int session_fd;
+
+	ksft_print_msg("[PRE-KEXEC] Starting workload...\n");
+
+	session_fd = luo_create_session(luo_fd, SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("Failed to create session '%s'", SESSION_NAME);
+
+	ksft_print_msg("[PRE-KEXEC] Preserving memfd A (to be restored).\n");
+	if (create_and_preserve_memfd(session_fd, TOKEN_A, DATA_A) < 0)
+		fail_exit("Failed to preserve memfd A");
+
+	ksft_print_msg("[PRE-KEXEC] Preserving memfd B (to be abandoned).\n");
+	if (create_and_preserve_memfd(session_fd, TOKEN_B, DATA_B) < 0)
+		fail_exit("Failed to preserve memfd B");
+
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_PREPARE) < 0)
+		fail_exit("Failed to set global PREPARE event");
+
+	ksft_print_msg("[PRE-KEXEC] System is ready. Executing kexec...\n");
+	if (system(KEXEC_SCRIPT) != 0)
+		fail_exit("kexec script failed");
+
+	sleep(10);
+	exit(EXIT_FAILURE);
+}
+
+static void run_post_kexec(int luo_fd)
+{
+	int session_fd, mfd_a;
+
+	ksft_print_msg("[POST-KEXEC] Starting workload...\n");
+
+	session_fd = luo_retrieve_session(luo_fd, SESSION_NAME);
+	if (session_fd < 0)
+		fail_exit("Failed to retrieve session '%s'", SESSION_NAME);
+
+	ksft_print_msg("[POST-KEXEC] Restoring and verifying memfd A (token %d)...\n",
+		       TOKEN_A);
+	mfd_a = restore_and_verify_memfd(session_fd, TOKEN_A, DATA_A);
+	if (mfd_a < 0)
+		fail_exit("Failed to restore or verify memfd A");
+	close(mfd_a);
+	ksft_print_msg("  Data verification PASSED for memfd A.\n");
+
+	ksft_print_msg("[POST-KEXEC] NOT restoring memfd B (token %d) to test cleanup.\n",
+		       TOKEN_B);
+
+	ksft_print_msg("[POST-KEXEC] Driving global state to FINISH...\n");
+	if (luo_set_global_event(luo_fd, LIVEUPDATE_FINISH) < 0)
+		fail_exit("Failed to set global FINISH event");
+
+	close(session_fd);
+
+	ksft_print_msg("\n--- TEST PASSED ---\n");
+	ksft_print_msg("Check dmesg for cleanup log of token %d in session '%s'.\n",
+		       TOKEN_B, SESSION_NAME);
+}
+
+int main(int argc, char *argv[])
+{
+	enum liveupdate_state state;
+	int luo_fd;
+
+	luo_fd = luo_open_device();
+	if (luo_fd < 0) {
+		ksft_exit_skip("Failed to open %s. Is the luo module loaded?\n",
+			       LUO_DEVICE);
+	}
+
+	if (luo_get_global_state(luo_fd, &state) < 0)
+		fail_exit("Failed to get LUO state");
+
+	switch (state) {
+	case LIVEUPDATE_STATE_NORMAL:
+		run_pre_kexec(luo_fd);
+		break;
+	case LIVEUPDATE_STATE_UPDATED:
+		run_post_kexec(luo_fd);
+		break;
+	default:
+		fail_exit("Test started in an unexpected state: %d", state);
+	}
+
+	close(luo_fd);
+	ksft_exit_pass();
+}
-- 
2.51.0.536.g15c5d4f767-goog


