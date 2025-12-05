Return-Path: <linux-fsdevel+bounces-70747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F95DCA5C69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 02:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CD7331B1850
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 00:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DDC2248A0;
	Fri,  5 Dec 2025 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYIksOdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15946207A38
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Dec 2025 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764896332; cv=none; b=V3ZAbbyZ79tz2GA75WB0JE55A7dC6zLRmaskW9M0ty5VIjG2GdDwI4DRC1rsYLQVPk45hrMsqcfhFn4TTFT+IV8Qbe/9rSrBW5loB+K8kFrM4TwiUZWVYFIDoOCKds1Q8P/3nj6VgYMs9gcyM0dirnVw30kPQlfkSAafUEDAjXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764896332; c=relaxed/simple;
	bh=UvSln048ohPOzbLPJhvVxAZd+2oA+tXy8HJRgRIhYLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HO/QUcvHERz6E7O6vX77dVSSDZB773SJLxDDo+1ufevqeIJWLHIm856dsd16Qve212RSTFoQbaS1pxN6u53R2GAwtY245xmlbYv93AeLbn41CpITSoBuRE7S4qn2bw0EOc5qrPAqYS+u+8g0MAWEl4mI4j/oenAjVsgLe2kRX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYIksOdr; arc=none smtp.client-ip=209.85.167.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-4538a8bc513so353069b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Dec 2025 16:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764896328; x=1765501128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K6yuyWg6J+6tRA6+qXQKoG2t2/jCR8bZmCcJlfiuOoE=;
        b=RYIksOdrOrb/vLo5JbUXC4JyB44TEW/Z6+ubFEpyQI+jC97o6S6q41NqHwvlISfDy1
         ytuGWjMqqfkzzl4YcBcr17C2P4l3nTTuAzrNH2+AkVa4D85xGQ64Tj3FhDGwnok1bzuM
         WDTPblnkY+T5UXIhIsqiHjc7dbcT8PmswhFF1vY0t1GC+CemR+omJRqF9spBlbCJTnDN
         M/hwHsC5ZZI4OVPCN4sGND6FqeqneQztCJ44XFmSd8+cGnJlHOZAlC4t6ccY4k7mr25t
         3TtH19JUu6paKfwWwn0QhS/uNjiICrYq2UG3nzDgsdHzWrgq1pWNTnp8JAvNdXL/WL0j
         V6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764896328; x=1765501128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K6yuyWg6J+6tRA6+qXQKoG2t2/jCR8bZmCcJlfiuOoE=;
        b=l8CyDA0l3Fpz3rfKoRbEsTaK3VzA8XfW2oOyzC9cBqPxJQIBGqWZeYt9DRSjRxgzAd
         VxC4LXXDiAGI+9D/NpWulGpou7qNXn5KycetztU8w+jw704wbuPtK9BaT0W4y4jyqtgJ
         w6yIqFFTBToqRRvmS8z/oB8oqacSomKZkbPJeWokw+wwLXQ9r8pbcctVA2UWpuiTRhgp
         dfzlhvDVM8XiVC//k/2kgAEw512Je5euSQf2zoO/ajY9iCIZB9Dk4/lQG+9/LD6SP/Gn
         HfjH7fjLUtie2d/VfNsB1KMxSqIgQueYdxMJAX+GeO7evHJq7j5fkrPrQqAboWufI6hv
         H/qw==
X-Forwarded-Encrypted: i=1; AJvYcCUUVpVucOM6wLKFSlUSp+hRpUA/Y7eq+H7QglUtPD4oi0eAtQ0iOUgbhFcgxJh7fKzJcDP/9Aq6PEY8LeSF@vger.kernel.org
X-Gm-Message-State: AOJu0YxFEY7pBWlqN5Msw+id+gONA47KjL8r/Cth/YYL4nj8wGjwYAH8
	wN1NpBqE7D8a8qRqTfin5qQnLdt/5QMHcL5AG9HGeFqI15MNl4kDNVlQzNu6N3dWkbadS9IWzXN
	8iSlf3w==
X-Google-Smtp-Source: AGHT+IFADxKy/vFest5snAc0m/D0WWFhbz7XE0sMmrJDgeiYPmoKVCscGluChmmNgyVRHEbkPAnHLRJv63w=
X-Received: from ioxv4.prod.google.com ([2002:a05:6602:584:b0:948:a326:e2d6])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:1899:b0:450:d09a:8ce7
 with SMTP id 5614622812f47-45379cc4f26mr2830491b6e.20.1764896328239; Thu, 04
 Dec 2025 16:58:48 -0800 (PST)
Date: Fri,  5 Dec 2025 00:58:31 +0000
In-Reply-To: <20251205005841.3942668-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251205005841.3942668-1-avagin@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251205005841.3942668-4-avagin@google.com>
Subject: [PATCH 2/3] selftests/cgroup: Add a test for the misc.mask cgroup interface
From: Andrei Vagin <avagin@google.com>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest for the misc.mask cgroup interface. The test verifies
that the misc.mask file is present and has the correct default value,
that it is possible to write a new mask to the file, and that the mask is
inherited by sub-cgroups.

Signed-off-by: Andrei Vagin <avagin@google.com>
---
 tools/testing/selftests/cgroup/.gitignore  |   1 +
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/config      |   1 +
 tools/testing/selftests/cgroup/test_misc.c | 118 +++++++++++++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_misc.c

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index 952e4448bf07..3ced02a3634b 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -7,6 +7,7 @@ test_hugetlb_memcg
 test_kill
 test_kmem
 test_memcontrol
+test_misc
 test_pids
 test_zswap
 wait_inotify
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index e01584c2189a..6e9e92f89d8a 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_PROGS += test_hugetlb_memcg
 TEST_GEN_PROGS += test_kill
 TEST_GEN_PROGS += test_kmem
 TEST_GEN_PROGS += test_memcontrol
+TEST_GEN_PROGS += test_misc
 TEST_GEN_PROGS += test_pids
 TEST_GEN_PROGS += test_zswap
 
@@ -31,5 +32,6 @@ $(OUTPUT)/test_hugetlb_memcg: $(LIBCGROUP_O)
 $(OUTPUT)/test_kill: $(LIBCGROUP_O)
 $(OUTPUT)/test_kmem: $(LIBCGROUP_O)
 $(OUTPUT)/test_memcontrol: $(LIBCGROUP_O)
+$(OUTPUT)/test_misc: $(LIBCGROUP_O)
 $(OUTPUT)/test_pids: $(LIBCGROUP_O)
 $(OUTPUT)/test_zswap: $(LIBCGROUP_O)
diff --git a/tools/testing/selftests/cgroup/config b/tools/testing/selftests/cgroup/config
index 39f979690dd3..9e3d03736f5a 100644
--- a/tools/testing/selftests/cgroup/config
+++ b/tools/testing/selftests/cgroup/config
@@ -1,6 +1,7 @@
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_MISC=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_MEMCG=y
 CONFIG_PAGE_COUNTER=y
diff --git a/tools/testing/selftests/cgroup/test_misc.c b/tools/testing/selftests/cgroup/test_misc.c
new file mode 100644
index 000000000000..50e8acb51852
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_misc.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <linux/limits.h>
+#include <signal.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+/*
+ * This test checks that misc.mask works correctly.
+ */
+static int test_misc_mask(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cg_misc, *cg_misc_sub = NULL;
+
+	cg_misc = cg_name(root, "misc_test");
+	if (!cg_misc)
+		goto cleanup;
+
+	cg_misc_sub = cg_name(root, "misc_test/sub");
+	if (!cg_misc_sub)
+		goto cleanup;
+
+	if (cg_create(cg_misc))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_misc, "misc.mask",
+			   "AT_HWCAP\t0x00000000000000\t0x00000000000000\n"))
+		goto cleanup;
+
+	if (cg_write(cg_misc, "misc.mask", "AT_HWCAP 0xf0000000000000"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_misc, "misc.mask",
+			   "AT_HWCAP\t0xf0000000000000\t0xf0000000000000\n"))
+		goto cleanup;
+
+	if (cg_write(cg_misc, "cgroup.subtree_control", "+misc"))
+		goto cleanup;
+
+	if (cg_create(cg_misc_sub))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_misc_sub, "misc.mask",
+			   "AT_HWCAP\t0x00000000000000\t0xf0000000000000\n"))
+		goto cleanup;
+
+	if (cg_write(cg_misc_sub, "misc.mask", "AT_HWCAP 0x01000000000000"))
+		goto cleanup;
+
+	if (cg_read_strcmp(cg_misc_sub, "misc.mask",
+			   "AT_HWCAP\t0x01000000000000\t0xf1000000000000\n"))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	cg_enter_current(root);
+	cg_destroy(cg_misc_sub);
+	cg_destroy(cg_misc);
+	free(cg_misc);
+	free(cg_misc_sub);
+
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct misc_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] = {
+	T(test_misc_mask),
+};
+#undef T
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
+	if (cg_find_unified_root(root, sizeof(root), NULL))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	/*
+	 * Check that misc controller is available:
+	 * misc is listed in cgroup.controllers
+	 */
+	if (cg_read_strstr(root, "cgroup.controllers", "misc"))
+		ksft_exit_skip("misc controller isn't available\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "misc"))
+		if (cg_write(root, "cgroup.subtree_control", "+misc"))
+			ksft_exit_skip("Failed to set misc controller\n");
+
+	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	ksft_finished();
+}
-- 
2.52.0.223.gf5cc29aaa4-goog


