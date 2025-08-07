Return-Path: <linux-fsdevel+bounces-56947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17195B1D08E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A5116CD55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B35264F96;
	Thu,  7 Aug 2025 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Nz1wzbJX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA658254841
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531126; cv=none; b=cf+Tm0F+69Ly30ATMOI3hDfp8sr/TVHeTh9rDhb3RqvQO0Tj2hV+QoGN9l/hL4mYRGsX4jhhMQkwmONCB5T30TyYEuY4fKYk10X5tQCHENqHAVnuNXuU72rDjiGyPpWUWe/rVrrXwBmRuAimyNotPtb4rerHezPNv10w+sR/48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531126; c=relaxed/simple;
	bh=kTWhEvbuCaicpRqRsa/P4zEbCOqm+ea1bZdGOKvfd+c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+oYravaKXpzPE4IJwVLecB1ns2GWRe9wBsXN718OpamwNHAQ77Ar18TBd/3163eeobH9wr1HYbkxMp9aH4/M0BjmTHdgm0I22OcQTYL6LhJciBlCzC5FqAKjsjY37t9VvDeGGmQlECmUiIsfrfqUaAQ9tE+IHorTbAnbPrNgug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Nz1wzbJX; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-709233a8609so6454426d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531121; x=1755135921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9F1hOcDAjab1iHPlBAL9eSJaLDlWaWMO1GBmtnwL/g=;
        b=Nz1wzbJXYiCG9uGQCHj+x1J2bP0LHLFmKfSJ9MKkkXZwvLM3P14OFnSQG7qeaysXYu
         4g/eArlJ6WQlKiWBMknguOD3O9q0DOuv8XloVg1deSect/mYaY1OYSUcdyt+0yGOoeAg
         /eW0JOs9Lk8IOx1Do590kLd1aZe8Vpcaarc1PhiULMXcupHYDpUP/JB1S3NeOFQTqXqz
         P932t26OJJYAGXn/UPe5uzauznzNdgSKBkqO4FmXFLMOngNZCQQm1EZCnKdYVp7XVRee
         wdwVqlw4Ulkjd4rYcALE2a/1ZWusox3iC9KaVgFVnAJYhX/STNFUpPiEVwZ8lzRRA9wC
         u0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531121; x=1755135921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9F1hOcDAjab1iHPlBAL9eSJaLDlWaWMO1GBmtnwL/g=;
        b=MWeHQuqf+ts+JRHqDc209GoZyMcWKVp5aZ4/dkaoKlkoeN52yP/GTwHwlTSk3Tk6hG
         QNFFfSJcbEnZKO76PWcobbYRVp2yGWHDVTwnIkek168lMZcbLEGOiaIEBkBk8zfoeKEM
         UzTVapdm5YcqPTnFfJgPLqbg5/c+ACTUp1U80uZbxDG9qeAvtJNX/QwiaVa6Hl4Yv0+/
         7yGBR/UsazjnOvP97X++LN1jH7VUXArS8nsiaY8ZXGf9yDFUXMR3JpL7Zq88LkJxWK4z
         qQMEoyWhO7lLNVddOae9U/Xvt580lhZd78bCgixp+kX2S/TTWy+NlXrzGvVnVTZC1FMH
         v1qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Yai4mnDS1tR4UN+hqQei5ZMzKJRIdmQHASGboLUDVDjkmQJlPcd8QE60i3klVY+2Ww8P5UEpLvQIiyfn@vger.kernel.org
X-Gm-Message-State: AOJu0YwTY4itY6uNEIxGcqFDPx5v+KLoEe8qp3ogh3jZGDjkX1ob6p2A
	VzE5rBpZxthw5MPjJfngG/HwMKysDDh6XGiGgvG7Zrxp3YJ674CfrurjvmPhD3NA6kg=
X-Gm-Gg: ASbGncs//2I+iFmkd6JM44GsN1q7McVc3vG3xYi+F9ojeOpAEAIYIcg0H7mWEz0MVOK
	MqXRQlISPHPcUV/phFhg2EL3cSzQAV4hnKh30uuT5kAW23Y3NZe2oazyA/vETedphg741CWM6W+
	dQF0OjmfpMvhQd1McY0azahkweavONPnFUSX1k/eY+06apsMZ6X8JyJuQg4W5PQY/YyWBh3HI6R
	gwjXiVbf3RdLK44TMTHpO23WM+C+mvB30bS3RVOZUHBONUeOGxFqVBzXve2QtvC4Bfn46Qg5Uib
	qW7fB/j61DXYCVCg4Lz0I/1u9boOb//BBxY1i1XirP4JxaKOAmSWEOrtarO+/R1pllPlR6vrQLJ
	C3zYWwrA2HWBb5X7O78HXa1D8AhSbm2RAA4LME+SBamud5V1hFgSDHF8nGgJwsvStN0bPRVlIs4
	/T1oGj3os1XmXj
X-Google-Smtp-Source: AGHT+IHM8rbdi1dYANpxFGjhD02SFYyo5a7VYvH2dHy9m+NmOGj0IODQ2sFOof0qb62BBdLWP7jK6Q==
X-Received: by 2002:a05:6214:4006:b0:709:22f1:d657 with SMTP id 6a1803df08f44-7097afb978fmr57768486d6.40.1754531121390;
        Wed, 06 Aug 2025 18:45:21 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:20 -0700 (PDT)
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
	witu@nvidia.com
Subject: [PATCH v3 23/30] selftests/liveupdate: add subsystem/state tests
Date: Thu,  7 Aug 2025 01:44:29 +0000
Message-ID: <20250807014442.3829950-24-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduces a new set of userspace selftests for the LUO. These tests
verify the functionality LUO by using the kernel-side selftest ioctls
provided by the LUO module, primarily focusing on subsystem management
and basic LUO state transitions.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/liveupdate/.gitignore |   1 +
 tools/testing/selftests/liveupdate/Makefile   |   7 +
 tools/testing/selftests/liveupdate/config     |   6 +
 .../testing/selftests/liveupdate/liveupdate.c | 406 ++++++++++++++++++
 5 files changed, 421 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/.gitignore
 create mode 100644 tools/testing/selftests/liveupdate/Makefile
 create mode 100644 tools/testing/selftests/liveupdate/config
 create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 030da61dbff3..3f76ee8ddda6 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -53,6 +53,7 @@ TARGETS += kvm
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
index 000000000000..382c85b89570
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/config
@@ -0,0 +1,6 @@
+CONFIG_KEXEC_FILE=y
+CONFIG_KEXEC_HANDOVER=y
+CONFIG_KEXEC_HANDOVER_DEBUG=y
+CONFIG_LIVEUPDATE=y
+CONFIG_LIVEUPDATE_SYSFS_API=y
+CONFIG_LIVEUPDATE_SELFTESTS=y
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
new file mode 100644
index 000000000000..b59767a7aaba
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+
+#include <linux/liveupdate.h>
+
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+#include "../../../../kernel/liveupdate/luo_selftests.h"
+
+struct subsystem_info {
+	void *data_page;
+	void *verify_page;
+	char test_name[LUO_NAME_LENGTH];
+	bool registered;
+};
+
+FIXTURE(subsystem) {
+	int fd;
+	int fd_dbg;
+	struct subsystem_info si[LUO_MAX_SUBSYSTEMS];
+};
+
+FIXTURE(state) {
+	int fd;
+	int fd_dbg;
+};
+
+#define LUO_DEVICE	"/dev/liveupdate"
+#define LUO_DBG_DEVICE	"/sys/kernel/debug/liveupdate/luo_selftest"
+#define LUO_SYSFS_STATE	"/sys/kernel/liveupdate/state"
+static size_t page_size;
+
+const char *const luo_state_str[] = {
+	[LIVEUPDATE_STATE_UNDEFINED]   = "undefined",
+	[LIVEUPDATE_STATE_NORMAL]   = "normal",
+	[LIVEUPDATE_STATE_PREPARED] = "prepared",
+	[LIVEUPDATE_STATE_FROZEN]   = "frozen",
+	[LIVEUPDATE_STATE_UPDATED]  = "updated",
+};
+
+static int run_luo_selftest_cmd(int fd_dbg, __u64 cmd_code,
+				struct luo_arg_subsystem *subsys_arg)
+{
+	struct liveupdate_selftest k_arg;
+
+	k_arg.cmd = cmd_code;
+	k_arg.arg = (__u64)(unsigned long)subsys_arg;
+
+	return ioctl(fd_dbg, LIVEUPDATE_IOCTL_SELFTESTS, &k_arg);
+}
+
+static int register_subsystem(int fd_dbg, struct subsystem_info *si)
+{
+	struct luo_arg_subsystem subsys_arg;
+	int ret;
+
+	memset(&subsys_arg, 0, sizeof(subsys_arg));
+	snprintf(subsys_arg.name, LUO_NAME_LENGTH, "%s", si->test_name);
+	subsys_arg.data_page = si->data_page;
+
+	ret = run_luo_selftest_cmd(fd_dbg, LUO_CMD_SUBSYSTEM_REGISTER,
+				   &subsys_arg);
+	if (!ret)
+		si->registered = true;
+
+	return ret;
+}
+
+static int unregister_subsystem(int fd_dbg, struct subsystem_info *si)
+{
+	struct luo_arg_subsystem subsys_arg;
+	int ret;
+
+	memset(&subsys_arg, 0, sizeof(subsys_arg));
+	snprintf(subsys_arg.name, LUO_NAME_LENGTH, "%s", si->test_name);
+
+	ret = run_luo_selftest_cmd(fd_dbg, LUO_CMD_SUBSYSTEM_UNREGISTER,
+				   &subsys_arg);
+	if (!ret)
+		si->registered = false;
+
+	return ret;
+}
+
+static int get_sysfs_state(void)
+{
+	char buf[64];
+	ssize_t len;
+	int fd, i;
+
+	fd = open(LUO_SYSFS_STATE, O_RDONLY);
+	if (fd < 0) {
+		ksft_print_msg("Failed to open sysfs state file '%s': %s\n",
+			       LUO_SYSFS_STATE, strerror(errno));
+		return -errno;
+	}
+
+	len = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+
+	if (len <= 0) {
+		ksft_print_msg("Failed to read sysfs state file '%s': %s\n",
+			       LUO_SYSFS_STATE, strerror(errno));
+		return -errno;
+	}
+	if (buf[len - 1] == '\n')
+		buf[len - 1] = '\0';
+	else
+		buf[len] = '\0';
+
+	for (i = 0; i < ARRAY_SIZE(luo_state_str); i++) {
+		if (!strcmp(buf, luo_state_str[i]))
+			return i;
+	}
+
+	return -EIO;
+}
+
+FIXTURE_SETUP(state)
+{
+	int state;
+
+	page_size = sysconf(_SC_PAGE_SIZE);
+	self->fd = open(LUO_DEVICE, O_RDWR);
+	if (self->fd < 0)
+		SKIP(return, "open(%s) failed [%d]", LUO_DEVICE, errno);
+
+	self->fd_dbg = open(LUO_DBG_DEVICE, O_RDWR);
+	ASSERT_GE(self->fd_dbg, 0);
+
+	state = get_sysfs_state();
+	if (state < 0) {
+		if (state == -ENOENT || state == -EACCES)
+			SKIP(return, "sysfs state not accessible (%d)", state);
+	}
+}
+
+FIXTURE_TEARDOWN(state)
+{
+	struct liveupdate_ioctl_set_event cancel = {
+		.size = sizeof(cancel),
+		.event = LIVEUPDATE_CANCEL,
+	};
+	struct liveupdate_ioctl_get_state ligs = {.size = sizeof(ligs)};
+
+	ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &ligs);
+	if (ligs.state != LIVEUPDATE_STATE_NORMAL)
+		ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &cancel);
+	close(self->fd);
+}
+
+FIXTURE_SETUP(subsystem)
+{
+	int i;
+
+	page_size = sysconf(_SC_PAGE_SIZE);
+	memset(&self->si, 0, sizeof(self->si));
+	self->fd = open(LUO_DEVICE, O_RDWR);
+	if (self->fd < 0)
+		SKIP(return, "open(%s) failed [%d]", LUO_DEVICE, errno);
+
+	self->fd_dbg = open(LUO_DBG_DEVICE, O_RDWR);
+	ASSERT_GE(self->fd_dbg, 0);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++) {
+		snprintf(self->si[i].test_name, LUO_NAME_LENGTH,
+			 NAME_NORMAL ".%d", i);
+
+		self->si[i].data_page = mmap(NULL, page_size,
+					     PROT_READ | PROT_WRITE,
+					     MAP_PRIVATE | MAP_ANONYMOUS,
+					     -1, 0);
+		ASSERT_NE(MAP_FAILED, self->si[i].data_page);
+		memset(self->si[i].data_page, 'A' + i, page_size);
+
+		self->si[i].verify_page = mmap(NULL, page_size,
+					       PROT_READ | PROT_WRITE,
+					       MAP_PRIVATE | MAP_ANONYMOUS,
+					       -1, 0);
+		ASSERT_NE(MAP_FAILED, self->si[i].verify_page);
+		memset(self->si[i].verify_page, 0, page_size);
+	}
+}
+
+FIXTURE_TEARDOWN(subsystem)
+{
+	struct liveupdate_ioctl_set_event cancel = {
+		.size = sizeof(cancel),
+		.event = LIVEUPDATE_CANCEL,
+	};
+	enum liveupdate_state state = LIVEUPDATE_STATE_NORMAL;
+	int i;
+
+	ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &state);
+	if (state != LIVEUPDATE_STATE_NORMAL)
+		ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &cancel);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++) {
+		if (self->si[i].registered)
+			unregister_subsystem(self->fd_dbg, &self->si[i]);
+		munmap(self->si[i].data_page, page_size);
+		munmap(self->si[i].verify_page, page_size);
+	}
+
+	close(self->fd);
+}
+
+TEST_F(state, normal)
+{
+	struct liveupdate_ioctl_get_state ligs = {.size = sizeof(ligs)};
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &ligs));
+	ASSERT_EQ(ligs.state, LIVEUPDATE_STATE_NORMAL);
+}
+
+TEST_F(state, prepared)
+{
+	struct liveupdate_ioctl_get_state ligs = {.size = sizeof(ligs)};
+	struct liveupdate_ioctl_set_event prepare = {
+		.size = sizeof(prepare),
+		.event = LIVEUPDATE_PREPARE,
+	};
+	struct liveupdate_ioctl_set_event cancel = {
+		.size = sizeof(cancel),
+		.event = LIVEUPDATE_CANCEL,
+	};
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &prepare));
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &ligs));
+	ASSERT_EQ(ligs.state, LIVEUPDATE_STATE_PREPARED);
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &cancel));
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &ligs));
+	ASSERT_EQ(ligs.state, LIVEUPDATE_STATE_NORMAL);
+}
+
+TEST_F(state, sysfs_normal)
+{
+	ASSERT_EQ(LIVEUPDATE_STATE_NORMAL, get_sysfs_state());
+}
+
+TEST_F(state, sysfs_prepared)
+{
+	struct liveupdate_ioctl_set_event prepare = {
+		.size = sizeof(prepare),
+		.event = LIVEUPDATE_PREPARE,
+	};
+	struct liveupdate_ioctl_set_event cancel = {
+		.size = sizeof(cancel),
+		.event = LIVEUPDATE_CANCEL,
+	};
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &prepare));
+	ASSERT_EQ(LIVEUPDATE_STATE_PREPARED, get_sysfs_state());
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &cancel));
+	ASSERT_EQ(LIVEUPDATE_STATE_NORMAL, get_sysfs_state());
+}
+
+TEST_F(state, sysfs_frozen)
+{
+	struct liveupdate_ioctl_set_event prepare = {
+		.size = sizeof(prepare),
+		.event = LIVEUPDATE_PREPARE,
+	};
+	struct liveupdate_ioctl_set_event cancel = {
+		.size = sizeof(cancel),
+		.event = LIVEUPDATE_CANCEL,
+	};
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &prepare));
+
+	ASSERT_EQ(LIVEUPDATE_STATE_PREPARED, get_sysfs_state());
+
+	ASSERT_EQ(0, ioctl(self->fd_dbg, LIVEUPDATE_IOCTL_FREEZE, NULL));
+	ASSERT_EQ(LIVEUPDATE_STATE_FROZEN, get_sysfs_state());
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &cancel));
+	ASSERT_EQ(LIVEUPDATE_STATE_NORMAL, get_sysfs_state());
+}
+
+TEST_F(subsystem, register_unregister)
+{
+	ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[0]));
+	ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[0]));
+}
+
+TEST_F(subsystem, double_unregister)
+{
+	ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[0]));
+	ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[0]));
+	EXPECT_NE(0, unregister_subsystem(self->fd_dbg, &self->si[0]));
+	EXPECT_TRUE(errno == EINVAL || errno == ENOENT);
+}
+
+TEST_F(subsystem, register_unregister_many)
+{
+	int i;
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[i]));
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
+}
+
+TEST_F(subsystem, getdata_verify)
+{
+	struct liveupdate_ioctl_get_state ligs = {.size = sizeof(ligs), .state = 0};
+	struct liveupdate_ioctl_set_event prepare = {
+		.size = sizeof(prepare),
+		.event = LIVEUPDATE_PREPARE,
+	};
+	struct liveupdate_ioctl_set_event cancel = {
+		.size = sizeof(cancel),
+		.event = LIVEUPDATE_CANCEL,
+	};
+	int i;
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[i]));
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &prepare));
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &ligs));
+	ASSERT_EQ(ligs.state, LIVEUPDATE_STATE_PREPARED);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++) {
+		struct luo_arg_subsystem subsys_arg;
+
+		memset(&subsys_arg, 0, sizeof(subsys_arg));
+		snprintf(subsys_arg.name, LUO_NAME_LENGTH, "%s",
+			 self->si[i].test_name);
+		subsys_arg.data_page = self->si[i].verify_page;
+
+		ASSERT_EQ(0, run_luo_selftest_cmd(self->fd_dbg,
+						  LUO_CMD_SUBSYSTEM_GETDATA,
+						  &subsys_arg));
+		ASSERT_EQ(0, memcmp(self->si[i].data_page,
+				    self->si[i].verify_page,
+				    page_size));
+	}
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &cancel));
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_GET_STATE, &ligs));
+	ASSERT_EQ(ligs.state, LIVEUPDATE_STATE_NORMAL);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
+}
+
+TEST_F(subsystem, prepare_fail)
+{
+	struct liveupdate_ioctl_set_event prepare = {
+		.size = sizeof(prepare),
+		.event = LIVEUPDATE_PREPARE,
+	};
+	struct liveupdate_ioctl_set_event cancel = {
+		.size = sizeof(cancel),
+		.event = LIVEUPDATE_CANCEL,
+	};
+	int i;
+
+	snprintf(self->si[LUO_MAX_SUBSYSTEMS - 1].test_name, LUO_NAME_LENGTH,
+		 NAME_PREPARE_FAIL ".%d", LUO_MAX_SUBSYSTEMS - 1);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[i]));
+
+	ASSERT_EQ(-1, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &prepare));
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
+
+	snprintf(self->si[LUO_MAX_SUBSYSTEMS - 1].test_name, LUO_NAME_LENGTH,
+		 NAME_NORMAL ".%d", LUO_MAX_SUBSYSTEMS - 1);
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, register_subsystem(self->fd_dbg, &self->si[i]));
+
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &prepare));
+	ASSERT_EQ(0, ioctl(self->fd_dbg, LIVEUPDATE_IOCTL_FREEZE, NULL));
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &cancel));
+	ASSERT_EQ(LIVEUPDATE_STATE_NORMAL, get_sysfs_state());
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
+}
+
+TEST_HARNESS_MAIN
-- 
2.50.1.565.gc32cd1483b-goog


