Return-Path: <linux-fsdevel+bounces-72714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D5AD010A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 06:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4874F305E375
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 05:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE332C0F7F;
	Thu,  8 Jan 2026 05:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uO/D3DK1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD2F2D7DD9
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 05:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767848878; cv=none; b=KaHSohpk2hH3U9PzDjRx9vTg+umD9J8jouQNgPskDUp8+Li2sjOgkBz67P8LTq0/7jADf7H7kXiK5ufGan3MKJxp+k6m7ikkJz1CGqbo9IE8dcYPiRuZyUiWp7Ad7Yg/ZWzr1J4Hj/+5DN73pgiuFPNoDGdNg6Cv2ulBsdQubPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767848878; c=relaxed/simple;
	bh=MP0u1zrI0fnXYNh85S3yYQJ3ZSNyI4Rv0qWzsYrRyFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UTNYAyGuuvwS7XKJCo8W8+gzhOk8daef9R7Rcf+20Fof4PWR5unwbzAsjWEE/QNcLgpKZGJ+0asmR0U8SaSMCLU5nsIr6rN4u8poh86q2UFGEt5Fhq9s89Lq31GLNRqssEf3pHpDzOWJ/rXGijlQxqfZN1o9q8Qsn9j1h030ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uO/D3DK1; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-65cfc52c912so4253276eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 21:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767848875; x=1768453675; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1hhEQ/dcIyjHD8R0p3IwfdlLsdWEz7YcUZfHbTaGDU=;
        b=uO/D3DK1TyKgddVvxSuZgMgRcGbGhQycuCtzvG6S+bt7DUKSGpBz3dzSE7ftmb7sJq
         zE/NARxC/NDERLW9yeO0dspWPreNG0+IQjT9XlqCKNE3FKs6vsE8/ukuzgTPzUztCmpN
         LTJRqFzY/Kd5REdqOyTejFbpT2yqxKnjQgyNdGHQv7XVYga+r1Ea6+ZOb9BOcdszAdcE
         0G7BWaNHUz9klzToS1CvatS1bjVgBLvEWDLRWycV4KCnKA4zLbQAmLQVQwwq07+71dn3
         mPuNcq714HFK4c/n1sZpH3XcLlzSHiLPI8aOZEMJNzfmFbMnYFmkRAz5/W8eExZsPLI7
         iBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767848875; x=1768453675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1hhEQ/dcIyjHD8R0p3IwfdlLsdWEz7YcUZfHbTaGDU=;
        b=r4IT+xoOl+weO3TT5gSBym7OBPKlxNAxwlgYHJB9k9uQgpjMhfOmsOAI3ln8vvigi2
         6cNAqdvOv/3j2066QmFr5USD32Dc5OO5URxqMA99/fyWwAszy7ESMz7IX89aIvpXJmnA
         FoACMFU49xJP7TCo+Z8FO+fgGvJzjUAAj1JoIp2wZkzaNpTzQUppXNYwxvTwtO/LMREM
         Sf+sB4s+2PUoRtDeIfkQqXygG/LkYqyNGBcc+JRuPJ1/nWGC4RYU9zjbqXEWWkDAB+Ja
         z4bUBRLJlME1gr8CvYXf0DiyMstcTD0WHnvNSmfmVEnYYykba6MWUyVGDC2Fl2cUU3wt
         QqVA==
X-Forwarded-Encrypted: i=1; AJvYcCU+1gb6qXStqVxpWwP0kpd2FcZvJqgBBjoGuhMr10BSlbzsmVsN01pisQv0dMCda+PlUk7/5M/DiqpuzyCP@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYI9OvMBXfgDI3xMRXCgMwY0ESRcgckstKV3fI41LyDTKpmFZ
	JpXcZIM7/0vV3xtvCqjKnXZbQzFM28HDwLMLY2Xo10NwQKmoMAmXj8NHGzGVEzEQta2SHMOa2Mw
	UJ7M12w==
X-Google-Smtp-Source: AGHT+IG6PRfdl7A+xXyBMjsVyyTg1K6TF0yM6mRQxM81LAutvzKwdfc7WseETy3uSVVUyTVIXphzxa2bYvw=
X-Received: from iobid13.prod.google.com ([2002:a05:6602:6a8d:b0:954:45e5:5098])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a4a:cb10:0:b0:65b:38e2:33b5
 with SMTP id 006d021491bc7-65f54f7b279mr1489724eaf.49.1767848875303; Wed, 07
 Jan 2026 21:07:55 -0800 (PST)
Date: Thu,  8 Jan 2026 05:07:48 +0000
In-Reply-To: <20260108050748.520792-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108050748.520792-1-avagin@google.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108050748.520792-4-avagin@google.com>
Subject: [PATCH 3/3] selftests/exec: add test for HWCAP inheritance
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, criu@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Koutny <mkoutny@suse.com>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Verify that HWCAPs are correctly inherited/preserved across execve() when
modified via prctl(PR_SET_MM_AUXV).

The test performs the following steps:
* reads the current AUXV using prctl(PR_GET_AUXV);
* finds an HWCAP entry and toggles its most significant bit;
* replaces the AUXV of the current process with the modified one using
  prctl(PR_SET_MM, PR_SET_MM_AUXV);
* executes itself to verify that the new program sees the modified HWCAP
  value.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/exec/.gitignore      |   1 +
 tools/testing/selftests/exec/Makefile        |   1 +
 tools/testing/selftests/exec/hwcap_inherit.c | 104 +++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 tools/testing/selftests/exec/hwcap_inherit.c

diff --git a/tools/testing/selftests/exec/.gitignore b/tools/testing/selftests/exec/.gitignore
index 7f3d1ae762ec..2ff245fd0ba6 100644
--- a/tools/testing/selftests/exec/.gitignore
+++ b/tools/testing/selftests/exec/.gitignore
@@ -19,3 +19,4 @@ null-argv
 xxxxxxxx*
 pipe
 S_I*.test
+hwcap_inherit
\ No newline at end of file
diff --git a/tools/testing/selftests/exec/Makefile b/tools/testing/selftests/exec/Makefile
index 45a3cfc435cf..e73005965e05 100644
--- a/tools/testing/selftests/exec/Makefile
+++ b/tools/testing/selftests/exec/Makefile
@@ -20,6 +20,7 @@ TEST_FILES := Makefile
 TEST_GEN_PROGS += recursion-depth
 TEST_GEN_PROGS += null-argv
 TEST_GEN_PROGS += check-exec
+TEST_GEN_PROGS += hwcap_inherit
 
 EXTRA_CLEAN := $(OUTPUT)/subdir.moved $(OUTPUT)/execveat.moved $(OUTPUT)/xxxxx*	\
 	       $(OUTPUT)/S_I*.test
diff --git a/tools/testing/selftests/exec/hwcap_inherit.c b/tools/testing/selftests/exec/hwcap_inherit.c
new file mode 100644
index 000000000000..ef80a010765d
--- /dev/null
+++ b/tools/testing/selftests/exec/hwcap_inherit.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <linux/prctl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <elf.h>
+#include <linux/auxvec.h>
+
+#include "../kselftest.h"
+
+static int find_msb(unsigned long v)
+{
+	return sizeof(v)*8 - __builtin_clzl(v) - 1;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long auxv[1024], hwcap, new_hwcap, hwcap_idx;
+	int size, hwcap_type = 0, hwcap_feature, count, status;
+	char hwcap_str[32], hwcap_type_str[32];
+	pid_t pid;
+
+	if (argc > 1 && strcmp(argv[1], "verify") == 0) {
+		unsigned long type = strtoul(argv[2], NULL, 16);
+		unsigned long expected = strtoul(argv[3], NULL, 16);
+		unsigned long hwcap = getauxval(type);
+
+		if (hwcap != expected) {
+			ksft_print_msg("HWCAP mismatch: type %lx, expected %lx, got %lx\n",
+					type, expected, hwcap);
+			return 1;
+		}
+		ksft_print_msg("HWCAP matched: %lx\n", hwcap);
+		return 0;
+	}
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	size = prctl(PR_GET_AUXV, auxv, sizeof(auxv), 0, 0);
+	if (size == -1)
+		ksft_exit_fail_perror("prctl(PR_GET_AUXV)");
+
+	count = size / sizeof(unsigned long);
+
+	/* Find the "latest" feature and try to mask it out. */
+	for (int i = 0; i < count - 1; i += 2) {
+		hwcap = auxv[i + 1];
+		if (hwcap == 0)
+			continue;
+		switch (auxv[i]) {
+		case AT_HWCAP4:
+		case AT_HWCAP3:
+		case AT_HWCAP2:
+		case AT_HWCAP:
+			hwcap_type = auxv[i];
+			hwcap_feature = find_msb(hwcap);
+			hwcap_idx = i + 1;
+			break;
+		default:
+			continue;
+		}
+	}
+	if (hwcap_type == 0)
+		ksft_exit_skip("No features found, skipping test\n");
+	new_hwcap = hwcap ^ (1UL << hwcap_feature);
+	auxv[hwcap_idx] = new_hwcap;
+
+	if (prctl(PR_SET_MM, PR_SET_MM_AUXV, auxv, size, 0) < 0) {
+		if (errno == EPERM)
+			ksft_exit_skip("prctl(PR_SET_MM_AUXV) requires CAP_SYS_RESOURCE\n");
+		ksft_exit_fail_perror("prctl(PR_SET_MM_AUXV)");
+	}
+
+	pid = fork();
+	if (pid < 0)
+		ksft_exit_fail_perror("fork");
+	if (pid == 0) {
+		char *new_argv[] = { argv[0], "verify", hwcap_type_str, hwcap_str, NULL };
+
+		snprintf(hwcap_str, sizeof(hwcap_str), "%lx", new_hwcap);
+		snprintf(hwcap_type_str, sizeof(hwcap_type_str), "%x", hwcap_type);
+
+		execv(argv[0], new_argv);
+		perror("execv");
+		exit(1);
+	}
+
+	if (waitpid(pid, &status, 0) == -1)
+		ksft_exit_fail_perror("waitpid");
+	if (status != 0)
+		ksft_exit_fail_msg("HWCAP inheritance failed (status %d)\n", status);
+
+	ksft_test_result_pass("HWCAP inheritance succeeded\n");
+	ksft_exit_pass();
+	return 0;
+}
-- 
2.52.0.351.gbe84eed79e-goog


