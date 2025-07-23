Return-Path: <linux-fsdevel+bounces-55870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35691B0F64A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696F817A967
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16201303DFB;
	Wed, 23 Jul 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="lrXB55ZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5C2F6F99
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282085; cv=none; b=PYiO1CXkuK1EoAVXWtozdJDAygsQpSd26yT/IwxR0XyvW89s1l9UrbpuS4dkiEkUmPKqYxat/rkerCbAIZw2VkeiN6Jx9OLFAHV74d6c7Uk6g5WfbgSD5cnZShN6D6feIRAd5OsnOWTBQ7BDiKKd29OjYkOlSiWIv+21VgQmM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282085; c=relaxed/simple;
	bh=kV/i7WzK++AoKinYUIyGUJOx4XSzNlPUkIXf9Vx78zI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpGkNeiK8dff11w7vn/97kmrlo7vHHfxJ4wsmyPIUusNJIjzi3cPaCj1xCmXDmoJCvnJ+4CwnjlMGinQJstZ0AXCHB6LsH05XV1/pWi5tA4sYpw9FoXaIwecR4XyoyZVTygcKDuFLIlZtp2m1LccLRCCZwdfd4Prb7a9nuMVbM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=lrXB55ZD; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-70e77831d68so62314347b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282078; x=1753886878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hShlI4m6hw+YtxzJd2p960yByHj9Zxa7UX6hlMU7/TY=;
        b=lrXB55ZDcWdmbgG4MC/uUtOOj23D/nwbN1bgbdaJ0FJM8aYReCA5/70ND1uAr9qL/Q
         RQeK+ugEIV8FAYYs5pxyQFwuw875rEJSS12BHFk6NIFmfARA5d0zLA0ZH22VmwzHkgiN
         k5nd0ka6Gj9B+rg1VBRw27AmhzmN6mBm9+9jUMx0rA5GmK5kSeo9dOKVYHamj8DrGtM/
         IfgYSkwOxBhj4g6Fl2Yq+FrdbTk35yv4fKAwjrCMkus/3mnaqV4ML33zLQbMGa/92AdI
         4Ot4KzPlHoyGLHjDzEozF44xbMtNl98/iZbhN9YApqq9nMY8UFBdp3oVHiPqIdGxE8Ji
         395g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282078; x=1753886878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hShlI4m6hw+YtxzJd2p960yByHj9Zxa7UX6hlMU7/TY=;
        b=wd+Exb+h5ZnaPFZkehr5bLq5yjMLvsaleR9yjPcVcRHBhrO0EczSr0fCaqWNDNormE
         AfSELlNLXqNu9Jq+KIpReyX4rSZO72tIYXHRZCPhWBtOFYtbg4aHY1bZw24KeW3OZmhI
         ShKCjk6a2AuC6W3P9qxd6GFqUrgkeZpEYHWZw/SxGuOAyOt1FpNzUAKes/+BUvGrDxLs
         71gVq9r7VHXD3WpzmMX+mWDUoOOl5+SQ8wgW5K7NYrVgge635ur4THVHBYa+L+lpExVt
         GgA4r7tJtmWaPEhm7+b5DhY8ftx7J+23shZ3N6QULJ1+XczLPilKeNtm38UvXghwTWIV
         szOg==
X-Forwarded-Encrypted: i=1; AJvYcCX1bQzVxDNs/lNk63Xl0zKKo/tq9KAlvn157r2ZlB9jAGuAClSy8zyMd/0XQHrzNPg94sEOZEQ2pHmmsgqQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYpqkIZhO/Zx91TFH4T7B5RIAhVSt+JnjC0KV0SbNqNfZZiv5
	pW/iWkHEbtrBTi8y1RsNtth56rjB2hHlHGFcI0hpYvaQRKMFRrP/Qg0IuEDXOYrxDk0=
X-Gm-Gg: ASbGncsAZshJtdRFvR7IQMZ2RFhJ2BR5eiOCuQXr9z0Qy/yd9t38ebUKZtqZqvbg8nm
	yey9vcHHFPeFfSDtjhu0/bm2OdU6+9gqzV4NATfUJILYCZZu6rpOCfsxv+hmIOzp76DAiATKPaH
	PILyMAeRrPJ7viijG+nh02ggr8ukuBSJ+KGKkWDtsJBT2OIU1Yuu175MLrasmKNcJaYuPYthZwN
	1ewI1Ht2ocGMefJ1T9V/gMPDTv9gcvOhzyuH+lNc1lXz5jEMNQRzyqvRn4AlmixFn95Y8YNxQ0a
	OidNKoVtCKl+DS95oRAYk4qR42Bp7yhn8Wk0+Ii/0n8i/0Yol7+qTw1qXRBwb/Oc5HR7baUrGfF
	ukIb5xNBChknKv27tK3nJ7o8E12KHIRr3+2XppgElTuBVVOYzrAKc/nRunhUgfgz8pGkfsdqpHl
	RWHDxA4zo2BPoM7w==
X-Google-Smtp-Source: AGHT+IH675RnRNbWShRM8kSWIrUMBTag3AVm1BnglGtYW6J1tHoiU+7BSxfTq41Ub2U0xE0WezZ+cg==
X-Received: by 2002:a05:690c:9a0d:b0:719:671d:255 with SMTP id 00721157ae682-719b41e6aeamr42227787b3.3.1753282078060;
        Wed, 23 Jul 2025 07:47:58 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:57 -0700 (PDT)
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
Subject: [PATCH v2 31/32] libluo: introduce luoctl
Date: Wed, 23 Jul 2025 14:46:44 +0000
Message-ID: <20250723144649.1696299-32-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

luoctl is a utility to interact with the LUO state machine. It currently
supports viewing and change the current state of LUO. This can be used
by scripts, tools, or developers to control LUO state during the live
update process.

Example usage:

    $ luoctl state
    normal
    $ luoctl prepare
    $ luoctl state
    prepared
    $ luoctl cancel
    $ luoctl state
    normal

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 tools/lib/luo/Makefile       |   6 +-
 tools/lib/luo/cli/.gitignore |   1 +
 tools/lib/luo/cli/Makefile   |  18 ++++
 tools/lib/luo/cli/luoctl.c   | 178 +++++++++++++++++++++++++++++++++++
 4 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/luo/cli/.gitignore
 create mode 100644 tools/lib/luo/cli/Makefile
 create mode 100644 tools/lib/luo/cli/luoctl.c

diff --git a/tools/lib/luo/Makefile b/tools/lib/luo/Makefile
index e851c37d3d0a..e8f6bd3b9e85 100644
--- a/tools/lib/luo/Makefile
+++ b/tools/lib/luo/Makefile
@@ -13,7 +13,7 @@ LIB_NAME = libluo
 STATIC_LIB = $(LIB_NAME).a
 SHARED_LIB = $(LIB_NAME).so
 
-.PHONY: all clean install
+.PHONY: all clean install cli
 
 all: $(STATIC_LIB) $(SHARED_LIB)
 
@@ -26,8 +26,12 @@ $(SHARED_LIB): $(OBJS)
 %.o: %.c $(HEADERS)
 	$(CC) $(CFLAGS) -c $< -o $@
 
+cli: $(STATIC_LIB)
+	$(MAKE) -C cli
+
 clean:
 	rm -f $(OBJS) $(STATIC_LIB) $(SHARED_LIB)
+	$(MAKE) -C cli clean
 
 install: all
 	install -d $(DESTDIR)/usr/local/lib
diff --git a/tools/lib/luo/cli/.gitignore b/tools/lib/luo/cli/.gitignore
new file mode 100644
index 000000000000..3a5e2d287f60
--- /dev/null
+++ b/tools/lib/luo/cli/.gitignore
@@ -0,0 +1 @@
+/luoctl
diff --git a/tools/lib/luo/cli/Makefile b/tools/lib/luo/cli/Makefile
new file mode 100644
index 000000000000..6c0cbf92a420
--- /dev/null
+++ b/tools/lib/luo/cli/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: LGPL-3.0-or-later
+LUOCTL = luoctl
+INCLUDE_DIR = ../include
+HEADERS = $(wildcard $(INCLUDE_DIR)/*.h)
+
+CC = gcc
+CFLAGS = -Wall -Wextra -O2 -g -I$(INCLUDE_DIR)
+LDFLAGS = -L.. -l:libluo.a
+
+.PHONY: all clean
+
+all: $(LUOCTL)
+
+luoctl: luoctl.c ../libluo.a $(HEADERS)
+	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
+
+clean:
+	rm -f $(LUOCTL)
diff --git a/tools/lib/luo/cli/luoctl.c b/tools/lib/luo/cli/luoctl.c
new file mode 100644
index 000000000000..39ba0bdd44f0
--- /dev/null
+++ b/tools/lib/luo/cli/luoctl.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: LGPL-3.0-or-later
+/**
+ * @file luoctl.c
+ * @brief Simple utility to interact with LUO
+ *
+ * This utility allows viewing and controlling LUO state.
+ *
+ * Copyright (C) 2025 Amazon.com Inc. or its affiliates.
+ * Author: Pratyush Yadav <ptyadav@amazon.de>
+ */
+
+#include <libluo.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <getopt.h>
+
+#define fatal(fmt, ...)					\
+	do {						\
+		fprintf(stderr, "Error: " fmt, ##__VA_ARGS__);	\
+		exit(1);				\
+	} while (0)
+
+struct command {
+	char *name;
+	int (*handler)(void);
+};
+
+static void usage(const char *prog_name)
+{
+	printf("Usage: %s [command]\n\n", prog_name);
+	printf("Commands:\n");
+	printf("  state         - Show current LUO state\n");
+	printf("  prepare       - Prepare for live update\n");
+	printf("  cancel        - Cancel live update preparation\n");
+	printf("  finish        - Signal completion of restoration\n");
+}
+
+static enum liveupdate_state get_state(void)
+{
+	enum liveupdate_state state;
+	int ret;
+
+	ret = luo_get_state(&state);
+	if (ret)
+		fatal("failed to get LUO state: %s\n", strerror(-ret));
+
+	return state;
+}
+
+static int show_state(void)
+{
+	enum liveupdate_state state;
+
+	state = get_state();
+	printf("%s\n", luo_state_to_string(state));
+	return 0;
+}
+
+static int do_prepare(void)
+{
+	enum liveupdate_state state;
+	int ret;
+
+	state = get_state();
+	if (state != LIVEUPDATE_STATE_NORMAL)
+		fatal("can only switch to prepared state from normal state. Current state: %s\n",
+		      luo_state_to_string(state));
+
+	ret = luo_prepare();
+	if (ret)
+		fatal("failed to prepare for live update: %s\n", strerror(-ret));
+
+	return 0;
+}
+
+static int do_cancel(void)
+{
+	enum liveupdate_state state;
+	int ret;
+
+	state = get_state();
+	if (state != LIVEUPDATE_STATE_PREPARED)
+		fatal("can only cancel from normal state. Current state: %s\n",
+		      luo_state_to_string(state));
+
+	ret = luo_cancel();
+	if (ret)
+		fatal("failed to cancel live update: %s\n", strerror(-ret));
+
+	return 0;
+}
+
+static int do_finish(void)
+{
+	enum liveupdate_state state;
+	int ret;
+
+	state = get_state();
+	if (state != LIVEUPDATE_STATE_UPDATED)
+		fatal("can only finish from updated state. Current state: %s\n",
+		      luo_state_to_string(state));
+
+	ret = luo_finish();
+	if (ret)
+		fatal("failed to finish live update: %s\n", strerror(-ret));
+
+	return 0;
+}
+
+static struct command commands[] = {
+	{"state", show_state},
+	{"prepare", do_prepare},
+	{"cancel", do_cancel},
+	{"finish", do_finish},
+	{NULL, NULL},
+};
+
+int main(int argc, char *argv[])
+{
+	struct option long_options[] = {
+		{"help", no_argument, 0, 'h'},
+		{0, 0, 0, 0}
+	};
+	struct command *command;
+	int ret = -EINVAL, opt;
+	char *cmd;
+
+	if (!luo_is_available()) {
+		fprintf(stderr, "LUO is not available on this system\n");
+		return 1;
+	}
+
+	while ((opt = getopt_long(argc, argv, "ht:e:", long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'h':
+			usage(argv[0]);
+			return 0;
+		default:
+			fprintf(stderr, "Try '%s --help' for more information.\n", argv[0]);
+			return 1;
+		}
+	}
+
+	if (argc - optind != 1) {
+		usage(argv[0]);
+		return 1;
+	}
+
+	cmd = argv[optind];
+
+	ret = luo_init();
+	if (ret < 0) {
+		fprintf(stderr, "Failed to initialize LibLUO: %s\n", strerror(-ret));
+		return 1;
+	}
+
+	command = &commands[0];
+	while (command->name) {
+		if (!strcmp(cmd, command->name)) {
+			ret = command->handler();
+			break;
+		}
+		command++;
+	}
+
+	if (!command->name) {
+		fprintf(stderr, "Unknown command %s. Try '%s --help' for more information\n",
+			cmd, argv[0]);
+		ret = -EINVAL;
+	}
+
+	luo_cleanup();
+	return (ret < 0) ? 1 : 0;
+}
-- 
2.50.0.727.gbf7dc18ff4-goog


