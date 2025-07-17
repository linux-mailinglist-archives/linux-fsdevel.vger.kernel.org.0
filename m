Return-Path: <linux-fsdevel+bounces-55225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA14B0885C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E2EA6123D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B505628C2A1;
	Thu, 17 Jul 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IWAVZI3X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfSFKZ6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D3285C8A;
	Thu, 17 Jul 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742147; cv=none; b=FzDfUalNkYrl2ELvq7iR3QabdPpPOXtp9DgfIMGize9m6lYgRAGjxDQ0QfBe59W7t4T37WXwpAI6WyVfaT6fioAS/TgHtUUdtoAzDYgKCKjpyIKqde12SsEqwX7c37TzOeX74/ssUrg/vXbBZgqRkpyNRSgapF9mrNKdIIE0JvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742147; c=relaxed/simple;
	bh=K5hk0UAv11oD+jmCKZ8Qnmjw66cnIqh2YtZbJ/VkqiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeI3akWg4PFlNiMncPdcMGFEzwrktkJeP/q9wT0UOwtg8nOkaE04bi94OljVq8Ml2AN8o2++Xm3/08Qllg+OLyug0zwL4EKMQqVUtd57PrZIvFY9Zicdx+yhY+AM0vKdeSKsyDRYIvLMy8ey844qOvOo/InZMT83SpUq+/KBeA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IWAVZI3X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfSFKZ6e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tpX44ktUDNib4EBN7BoleLiitPrc6dl49XI3WpfGX0=;
	b=IWAVZI3Xxz1Rnpl9GzBO81p3Fzo7WG9Em3b2e0p/LszawIPQsKlE8iw8CH23Qv5/Or9r2t
	x4ayNwNt0d9y23ElwAEJ1kHJWftAyGrmC5PDMf2GI68asxzqN7McRYUXxLHUrREQuXmwyr
	SQEU0HdNp6r/Qy+utQg6Yg7BPcC3g9lGBDbBnokLsGau1jWqW8Neqfppc9uYv9uQtGQNAb
	+m+Vbq4JdKiDtTISuxGX7A7Y6r8yN0G44B82xntanqRn+PKgf6wlrIXYMPi6zpLFckLwBl
	bcI0NMHbXAS3a5XK2Su7gFU0/5u5inhQg4maWBI1xbb3xeiHGQqwiZIZdUk6VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0tpX44ktUDNib4EBN7BoleLiitPrc6dl49XI3WpfGX0=;
	b=pfSFKZ6eEi4f/R3r7nCDsIXukWedCrntCSrLuL278pXA0wmS6fBCiMT64swXhviqdbLBg8
	X2Aoi0TtV6YcrZAA==
Date: Thu, 17 Jul 2025 10:48:15 +0200
Subject: [PATCH v5 13/15] kunit: uapi: Add example for UAPI tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-13-442b711cde2e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=3733;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=K5hk0UAv11oD+jmCKZ8Qnmjw66cnIqh2YtZbJ/VkqiI=;
 b=r33QPStj/S9FFCRRI4esHKaPvv9Ls3MIK2qM/BTS+qoy1hp+sNE4jOra21z/8FITA3X5AXxOV
 L3xMf4fthUXDEB59JRa73Cinj2Z7n08NU/cijLnmJ3I7XsjCxPUQGXP
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Extend the example to show how to run a userspace executable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 MAINTAINERS                    |  1 +
 lib/kunit/Makefile             | 10 ++++++++++
 lib/kunit/kunit-example-test.c | 15 +++++++++++++++
 lib/kunit/kunit-example-uapi.c | 22 ++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f60501c6de570723123b24eb930d15f1bd956eb..b1405f0a0e638d1654d9dc9e51d784ddc838cf5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13544,6 +13544,7 @@ KUNIT UAPI TESTING FRAMEWORK (in addition to KERNEL UNIT TESTING FRAMEWORK)
 M:	Thomas Weißschuh <thomas.weissschuh@linutronix.de>
 S:	Maintained
 F:	include/kunit/uapi.h
+F:	lib/kunit/kunit-example-uapi.c
 F:	lib/kunit/kunit-uapi.c
 
 KVM PARAVIRT (KVM/paravirt)
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 6059621a2d32c8e7384acda59793f05826af8c81..2434470e998525e5667ebc207d11659835b5e888 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -1,3 +1,5 @@
+include $(srctree)/init/Makefile.nolibc
+
 obj-$(CONFIG_KUNIT) +=			kunit.o
 
 kunit-objs +=				test.o \
@@ -31,3 +33,11 @@ obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
 endif
 
 obj-$(CONFIG_KUNIT_EXAMPLE_TEST) +=	kunit-example-test.o
+
+userprogs +=				kunit-example-uapi
+kunit-example-uapi-userccflags :=	-static $(NOLIBC_USERCFLAGS)
+
+ifdef CONFIG_KUNIT_UAPI
+CFLAGS_kunit-example-test.o :=		-Wa,-I$(obj)
+$(obj)/kunit-example-test.o: $(obj)/kunit-example-uapi
+endif
diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 3056d6bc705d0a8f196f0f4412e679dbb0e03114..0c5e1e59f9358b84aee2621e342d824a2f99f9aa 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -8,6 +8,7 @@
 
 #include <kunit/test.h>
 #include <kunit/static_stub.h>
+#include <kunit/uapi.h>
 
 /*
  * This is the most fundamental element of KUnit, the test case. A test case
@@ -277,6 +278,19 @@ static void example_slow_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 1 + 1, 2);
 }
 
+/*
+ * This test shows the usage of UAPI tests.
+ */
+static void example_uapi_test(struct kunit *test)
+{
+	KUNIT_UAPI_EMBED_BLOB(kunit_example_uapi, "kunit-example-uapi");
+
+	if (IS_ENABLED(CONFIG_KUNIT_UAPI))
+		kunit_uapi_run_kselftest(test, &kunit_example_uapi);
+	else
+		kunit_skip(test, "CONFIG_KUNIT_UAPI is not enabled");
+}
+
 /*
  * Here we make a list of all the test cases we want to add to the test suite
  * below.
@@ -297,6 +311,7 @@ static struct kunit_case example_test_cases[] = {
 	KUNIT_CASE(example_priv_test),
 	KUNIT_CASE_PARAM(example_params_test, example_gen_params),
 	KUNIT_CASE_SLOW(example_slow_test),
+	KUNIT_CASE(example_uapi_test),
 	{}
 };
 
diff --git a/lib/kunit/kunit-example-uapi.c b/lib/kunit/kunit-example-uapi.c
new file mode 100644
index 0000000000000000000000000000000000000000..4ce657050dd4a576632a41ca0309c4cb5134ce14
--- /dev/null
+++ b/lib/kunit/kunit-example-uapi.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace example test.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ *
+ * This is *userspace* code.
+ */
+
+#include "../../tools/testing/selftests/kselftest.h"
+
+int main(void)
+{
+	ksft_print_header();
+	ksft_set_plan(4);
+	ksft_test_result_pass("userspace test 1\n");
+	ksft_test_result_pass("userspace test 2\n");
+	ksft_test_result_skip("userspace test 3: some reason\n");
+	ksft_test_result_pass("userspace test 4\n");
+	ksft_finished();
+}

-- 
2.50.0


