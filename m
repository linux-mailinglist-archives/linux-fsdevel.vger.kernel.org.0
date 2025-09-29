Return-Path: <linux-fsdevel+bounces-62974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060FBA7B77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C287AD1BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867527EC99;
	Mon, 29 Sep 2025 01:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="MZStL5Ln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C12263C69
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107883; cv=none; b=j4mll2WXadTFTzWwpON3DXmSvsEaFQa9dhkyAUYzhVp0smC8pX6tx0By5T1FevXN1wAirgp+TKz74GTbjrRFLfoDySp+aLg4l1hmh92EmrIv4OAbptLCVOzmsUfg6knF/R7N17Kt+QtX8SAoqdyr8+qL9zTSNI7ywO6lh4UqjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107883; c=relaxed/simple;
	bh=L6ao1Nu+sGNUW1SHO/j5boKkbrSZSkTVDZP0p9xXls8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/s6aawhqSWQvBiBCrx/xzHEJLn/yEJ3tqQhUkD1itANFEeUPvn6PQpImH3Lt1SDOpKk6Rjs7AON7C1YaAl9zdVuIeBFpy8jdMPJ3RWS4S1fYZzAb60SjRhTalkGkaVi6K9HVFx2d9FdYvaxyHraogiERUo8yQPVSTGU4fIkWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=MZStL5Ln; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4dce9229787so33647121cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107879; x=1759712679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hWJ63KeQmpqYfuZrXZOnIQWXyJkptFNNQr+9KCQ8c70=;
        b=MZStL5LnjrV0W2GN+iOHhhY4L2HZXuX/F5JU41Om2kidaQ71QBWs9X5CvEDewVfCBK
         lgr5sshX22zCiRELuHlkd2aCVRKAvUWvzq1JOCwmh4E1t2blWthE8JiLTUjB1Hyv2KsH
         /GqQFC9VZnv7wnL2U4BO5ZFlOj4u4Lsimv8W0pL+EuUSmMjHEn0ohuYbrPm3F5m+6YG9
         Ay3FgHeEYj4v2TBfziFlI9MiMV+R9kfHvZ3w0PWr3GnQ+DLG3KQIsG1hOH5piRuESQSm
         Yj1DUKALslbFAVD8orwy/W9XYme/lzpSE8S9q1ZTEVvDovXXiF1jKSylW5OCT1MD5h6p
         eY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107879; x=1759712679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWJ63KeQmpqYfuZrXZOnIQWXyJkptFNNQr+9KCQ8c70=;
        b=hr4Qlv48+XAKyHYel118cm0FqX+MTaWPfqz8yj5VXlHwRNxGa0nbQvn421j9FSE1NP
         8ADmTxgN2RTC+XH9C6c2KkqGtLoWV1h0tXH+3NA/349Sdgw5VXQt3XJL9hrenoHwT+A6
         w8x0T42sJjvKvkqujpoZR+JGT6ha3Z7fs8LOCAMf7oPfNWz70AllBv7hDf6eL9TJ5U4m
         DkO2heXDmN10OuNJgQLYcU8KrgUBl2KgeGvuCP824dCzJSnXSC1xS9EysILGFXljou62
         2rVinpGUO36clvgVvkH0E+QaCdP7I+VuF+ybH/MPIMhMo3BMF+IXJ6LaAt2gBCyQqghB
         Bpcw==
X-Forwarded-Encrypted: i=1; AJvYcCW2FB4GTh14MYCYbvEAc0C6ekRKRpNV9pJCayCpUGcd8dhe6Y8iLUiLztAVBf2+ip++DWUjh7j2XtOIEGOS@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXdIZrN+q1mZ2kH3R7cXFS4dym39zptocnV7+rpjOVQuvTTpH
	/Aggfx7lFV6LWSy9mB5DUaO7jkkCHIRDeTsUOXwZEIFu4HAktCFVZ05ujnCE+d1H1mI=
X-Gm-Gg: ASbGnct3n7vnrgd/jpbDXYqstzUNe9N73kWMkR5iJ+YSArdmS9uSh4kvGVIh/gpbTaq
	zkDUi0wk6Fh0ZkpkMla8en2hV3fWmJj54TODZCqpOYAPUHaCqChB58CPEmyiBzA/BEcWGzrf9ID
	HBaJb24fGQI8fffPdtcwiLFMDzMdavuHkRPfCdQr+iOMysFPZPJ6IEvHANY6D0EFFbmp9bfjYZZ
	AWh5Jh6t+A8+qqFam5ne6IwVlOb+hNb13dfYUOl6DqI0jSfL2mGz7bkyKozUnzMDBuBBCB+gKWB
	MNufcBDsqNeYKeLxDDqYpZ7fzoR5jra5I9ohT1QBetsuMKtE78Ug0pUIDUZQgJL3jdegZUYJODQ
	UzUUmt5QZweV+V4JNhcrelTZWieD6qmVUV14U+Jboj3/UAPsRvavDOFjyf7xO2GbImqR1mWcndI
	2HIL/NeiQ=
X-Google-Smtp-Source: AGHT+IGQ9JesfWQ9VOblraXsGcOaxMqov/TZFk+utQcihiAURpdIQFxS9/FIvzoyuC4KA4xQDrrIxg==
X-Received: by 2002:a05:622a:5c8:b0:4e0:b5ef:2ba3 with SMTP id d75a77b69052e-4e0b5ef2f60mr33124721cf.37.1759107879208;
        Sun, 28 Sep 2025 18:04:39 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:38 -0700 (PDT)
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
Subject: [PATCH v4 18/30] selftests/liveupdate: add subsystem/state tests
Date: Mon, 29 Sep 2025 01:03:09 +0000
Message-ID: <20250929010321.3462457-19-pasha.tatashin@soleen.com>
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
 .../testing/selftests/liveupdate/liveupdate.c | 348 ++++++++++++++++++
 5 files changed, 363 insertions(+)
 create mode 100644 tools/testing/selftests/liveupdate/.gitignore
 create mode 100644 tools/testing/selftests/liveupdate/Makefile
 create mode 100644 tools/testing/selftests/liveupdate/config
 create mode 100644 tools/testing/selftests/liveupdate/liveupdate.c

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
index 000000000000..7c0ceaac0283
--- /dev/null
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -0,0 +1,348 @@
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
+FIXTURE_SETUP(state)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	self->fd = open(LUO_DEVICE, O_RDWR);
+	if (self->fd < 0)
+		SKIP(return, "open(%s) failed [%d]", LUO_DEVICE, errno);
+
+	self->fd_dbg = open(LUO_DBG_DEVICE, O_RDWR);
+	ASSERT_GE(self->fd_dbg, 0);
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
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &cancel));
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
+	ASSERT_EQ(0, ioctl(self->fd_dbg, LIVEUPDATE_IOCTL_FREEZE, NULL));
+	ASSERT_EQ(0, ioctl(self->fd, LIVEUPDATE_IOCTL_SET_EVENT, &cancel));
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
+
+	for (i = 0; i < LUO_MAX_SUBSYSTEMS; i++)
+		ASSERT_EQ(0, unregister_subsystem(self->fd_dbg, &self->si[i]));
+}
+
+TEST_HARNESS_MAIN
-- 
2.51.0.536.g15c5d4f767-goog


