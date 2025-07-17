Return-Path: <linux-fsdevel+bounces-55227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F2B08861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B1EA613B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D128DF28;
	Thu, 17 Jul 2025 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C3U2SXGe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ccz5GVRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D080428A40C;
	Thu, 17 Jul 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742148; cv=none; b=QIDx3Lc8UOnBuk1AbqacHkCCDWy9HnoIaSPduMVFb9xAdz0TrmOcQqj5LAK5mgbFGToEIDZjNX29rdcJHF8nzfXzNkTodaX1CMjR4bdkvuqGUu4dhaOXoJV2VhfwW/B8FG/HfQaavDeG9jnu/p0FcXHiXJYrEesxtZV2jcUwxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742148; c=relaxed/simple;
	bh=3PSdVbXQmTSX+u1cNcSDBelpx2lCw5SctfoPsq3CtY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VyyZJuWoQjEtoukcBwR3e8Ng22i5XiURX8vmUSt0PCbJHLBRKepecPiiLiyexylHzgcKp+8tqFPdFx7Qf8izMZevo6x6gkupBoZzIYpazXk/HvUdyBvSjIOXu1uMT8X4IASiK4aDyT2TGEjg1cz+O5gwsN4Qw5DsPTK9DUzndMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C3U2SXGe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ccz5GVRT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZPBaW6nQswmP9PfbPdPy5OGhGGfbO57Bjqn0Zo8Qlw=;
	b=C3U2SXGevfZa+II9ALnvwkUprEcBe7yrVzAVlvh3p+ggZxzsBVPq1UuJbRsUBkdBH6xoJu
	2ugNpZAPjUpBpNNEOBqdCUvJq75Yx3s7KcF3y9UFzJhNFHdlSh3OewXw729T+RHxw9TJPN
	oo03NrRBwLIRkljCm/AhHFOngqZ2DHloY3up6jiGenkOlue8M/w1Sij3oDmZJBs/WsFXxy
	PuWMhbdrSvB0x3PMGkT3hdA/TyNYs3FuKcNZM15UN7VrrO8vvqdOl9GxIghRsf30+rvtNZ
	E4J2NWNp3sNKTg2bi9luEeHcJofJeb9LwxydRyLSzmkhqTJ4UYqVAP0OY0Aq7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZPBaW6nQswmP9PfbPdPy5OGhGGfbO57Bjqn0Zo8Qlw=;
	b=Ccz5GVRTXNI9oDwdE3iTvJuEF6/RmFK/XHjj+nMPj/RXg6+5ymIRXmJFluoSaFFTLxfN2S
	KSNzJs7cHATQ0DAQ==
Date: Thu, 17 Jul 2025 10:48:17 +0200
Subject: [PATCH v5 15/15] kunit: uapi: Validate usability of /proc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-15-442b711cde2e@linutronix.de>
References: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
In-Reply-To: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Kees Cook <kees@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Nicolas Schier <nicolas.schier@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=4239;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=3PSdVbXQmTSX+u1cNcSDBelpx2lCw5SctfoPsq3CtY0=;
 b=dpqH8WrkFORXjxNS3hXpsNTuZ4sRMk81sUAzgVPKF74b5qC+n+XMeOFQB6CbApPBGO49JjXr6
 +CvsEb9GeXxADUWi8+WpQ2B2edvpGQowOi4XSfJ39LlpIO+6oeZLQKx
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Show that the selftests are executed from a fairly "normal"
userspace context.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 MAINTAINERS                 |  1 +
 lib/kunit/Makefile          |  9 ++++++++
 lib/kunit/kunit-test-uapi.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/kunit-test.c      | 23 +++++++++++++++++++-
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e81dfa180ab374ef91c7a45e546e6e9a8f454fa7..d86e8e0bfee75acecfeb9569d53ea8ea99727985 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13545,6 +13545,7 @@ M:	Thomas Weißschuh <thomas.weissschuh@linutronix.de>
 S:	Maintained
 F:	include/kunit/uapi.h
 F:	lib/kunit/kunit-example-uapi.c
+F:	lib/kunit/kunit-test-uapi.c
 F:	lib/kunit/kunit-uapi.c
 F:	lib/kunit/uapi-preinit.c
 
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index e52a31b0852caef5669f11f6059c29ce5911aa43..44a93c59a48fb7b4bb34b26333a28283c704cdef 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -31,6 +31,15 @@ endif
 obj-$(if $(CONFIG_KUNIT),y) +=		hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
+
+userprogs +=				kunit-test-uapi
+kunit-test-uapi-userccflags :=		-static $(NOLIBC_USERCFLAGS)
+
+ifdef CONFIG_KUNIT_UAPI
+CFLAGS_kunit-test.o :=			-Wa,-I$(obj)
+$(obj)/kunit-test.o: $(obj)/kunit-test-uapi
+endif
+
 obj-$(CONFIG_KUNIT_TEST) +=		platform-test.o
 
 # string-stream-test compiles built-in only.
diff --git a/lib/kunit/kunit-test-uapi.c b/lib/kunit/kunit-test-uapi.c
new file mode 100644
index 0000000000000000000000000000000000000000..ec5395d809ee2a4bd3c47a573a576e2f98ef5c1b
--- /dev/null
+++ b/lib/kunit/kunit-test-uapi.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace selftest.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ *
+ * This is *userspace* code.
+ */
+
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "../../tools/testing/selftests/kselftest.h"
+
+static void test_procfs(void)
+{
+	char buf[256];
+	ssize_t r;
+	int fd;
+
+	fd = open("/proc/self/comm", O_RDONLY);
+	if (fd == -1) {
+		ksft_test_result_fail("procfs: open() failed: %s\n", strerror(errno));
+		return;
+	}
+
+	r = read(fd, buf, sizeof(buf));
+	close(fd);
+
+	if (r == -1) {
+		ksft_test_result_fail("procfs: read() failed: %s\n", strerror(errno));
+		return;
+	}
+
+	if (r != 16 || strncmp("kunit-test-uapi\n", buf, 16) != 0) {
+		ksft_test_result_fail("procfs: incorrect comm\n");
+		return;
+	}
+
+	ksft_test_result_pass("procfs\n");
+}
+
+int main(void)
+{
+	ksft_print_header();
+	ksft_set_plan(1);
+	test_procfs();
+	ksft_finished();
+}
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index d9c781c859fde1f3623eb71b6829e82aa4803762..03972a3cb172d4af61bec17be800ddfb4bbd7268 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -8,6 +8,7 @@
 #include "linux/gfp_types.h"
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <kunit/uapi.h>
 
 #include <linux/device.h>
 #include <kunit/device.h>
@@ -868,10 +869,30 @@ static struct kunit_suite kunit_current_test_suite = {
 	.test_cases = kunit_current_test_cases,
 };
 
+static void kunit_uapi_test(struct kunit *test)
+{
+	KUNIT_UAPI_EMBED_BLOB(kunit_test_uapi, "kunit-test-uapi");
+
+	if (IS_ENABLED(CONFIG_KUNIT_UAPI))
+		kunit_uapi_run_kselftest(test, &kunit_test_uapi);
+	else
+		kunit_skip(test, "CONFIG_KUNIT_UAPI is not enabled");
+}
+
+static struct kunit_case kunit_uapi_test_cases[] = {
+	KUNIT_CASE(kunit_uapi_test),
+	{}
+};
+
+static struct kunit_suite kunit_uapi_test_suite = {
+	.name = "kunit_uapi",
+	.test_cases = kunit_uapi_test_cases,
+};
+
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
 		  &kunit_log_test_suite, &kunit_status_test_suite,
 		  &kunit_current_test_suite, &kunit_device_test_suite,
-		  &kunit_fault_test_suite);
+		  &kunit_fault_test_suite, &kunit_uapi_test_suite);
 
 MODULE_DESCRIPTION("KUnit test for core test infrastructure");
 MODULE_LICENSE("GPL v2");

-- 
2.50.0


