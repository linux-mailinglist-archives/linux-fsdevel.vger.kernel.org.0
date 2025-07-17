Return-Path: <linux-fsdevel+bounces-55226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EB0B08858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C40F4A878A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65FC28C2BB;
	Thu, 17 Jul 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dWFD09ri";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iYbpEPZM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7984285CAC;
	Thu, 17 Jul 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742147; cv=none; b=H65o4JRWMizrOywURfpcQIhWvPLsOha0/zqnqCyXlIVIzvWWg0nBuKsjHKBEqgEcTr661GhsKDi68m90t5TLpwpKxJF+RxeZofe1Jgoi86P98+rnx8ufO11/yr6JCzcfn5PfYdCEcVBh74rVlE99+rHCyhF1Rnv4Gt0+B7diKgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742147; c=relaxed/simple;
	bh=rsRst4GAUSvhO7BiyO660CynxR9JGWccwNT8lkt95Wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dr5IVH8gVmdXDQDpUX7nnzgwACTPLOT/lYWwOKMyxFSTWVD60Fq+uXLbjSni5vH2FS+H3G7kWYFCJ2vwCiuqUXnHF9aFGZoc596srIIk0aNpsrkkyU8XBLctqGgwepcB8RsN0/+zdCeaWNq59qa8IJud8uVWZoayMSdZ3DKyo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dWFD09ri; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iYbpEPZM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRrnBoH8IFFRjQzyw//nS3EiPMvLn5TdGq4dYEYIlJg=;
	b=dWFD09riE4O4+tZjIAy3cTk4M3sVWb5h8/ILsyaeqeEdqCqkgho5ZFfoKgaxrWjZ+asFn+
	ByYwC5aZ9i5Q/ZhdRB9tKzakPfrtG6P9wjdX3b9kLtZRPN1sBvmqeSSSoo4kBYqi+ek43s
	TIBuzJAR0k6euvl3OQVP4TFknbVpXjXiRCSX+uxATx7CQNAThIPaHO0V+Qht46YUdybipO
	/v4Fjb4Vpe2PambZaOYX/jIWSfdUP4x+5HjzEONzlfJTw16k7yRm4WkXYDaYCbNeScHpKL
	lJCW3gOQEgjFFRWsf3Ffu7gVojL1IqRL8YC3RbASjBfB70Tc46TnYCaJAC27vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRrnBoH8IFFRjQzyw//nS3EiPMvLn5TdGq4dYEYIlJg=;
	b=iYbpEPZMe/vqrYdB5bRCpT8IjAvhzc4BJ9D9ik//CupsJl2UzOYHlpo8v+/8U00zmS8llO
	sYN2CUYEXI+HBtBw==
Date: Thu, 17 Jul 2025 10:48:16 +0200
Subject: [PATCH v5 14/15] kunit: uapi: Introduce preinit executable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250717-kunit-kselftests-v5-14-442b711cde2e@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=4791;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=rsRst4GAUSvhO7BiyO660CynxR9JGWccwNT8lkt95Wk=;
 b=7dAV+lyPvW4Xt9wGzS6ae0Dt5BYPoxtZ/NSDbgwLz5AEC5rxIHcjV1gwBzTHFSJP+u1XG6RWh
 DRZ0Mhl86nyDlbvkt2qSCmxOUhu50WR2b7u/wwforIfclfyjskegjFf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

UAPI selftests may expect a "normal" userspace environment.
For example the normal kernel API pseudo-filesystems should be mounted.
This could be done from kernel code but it is non-idiomatic.

Add a preinit userspace executable which performs these setup steps
before running the final test executable.
This preinit executable is only ever run from the kernel.
Give it access to autoconf.h and kconfig.h to adapt itself to the
tested kernel.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 MAINTAINERS              |  1 +
 lib/kunit/Makefile       |  7 ++++++
 lib/kunit/kunit-uapi.c   |  9 +++++--
 lib/kunit/uapi-preinit.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1405f0a0e638d1654d9dc9e51d784ddc838cf5b..e81dfa180ab374ef91c7a45e546e6e9a8f454fa7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13546,6 +13546,7 @@ S:	Maintained
 F:	include/kunit/uapi.h
 F:	lib/kunit/kunit-example-uapi.c
 F:	lib/kunit/kunit-uapi.c
+F:	lib/kunit/uapi-preinit.c
 
 KVM PARAVIRT (KVM/paravirt)
 M:	Paolo Bonzini <pbonzini@redhat.com>
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 2434470e998525e5667ebc207d11659835b5e888..e52a31b0852caef5669f11f6059c29ce5911aa43 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -14,8 +14,15 @@ kunit-objs +=				test.o \
 					device.o \
 					platform.o
 
+userprogs +=				uapi-preinit
+uapi-preinit-userccflags +=		-static $(NOLIBC_USERCFLAGS) \
+					-include include/generated/autoconf.h \
+					-include $(srctree)/tools/include/linux/kconfig.h
 obj-$(CONFIG_KUNIT_UAPI) +=		kunit-uapi.o
 
+CFLAGS_kunit-uapi.o :=			-Wa,-I$(obj)
+$(obj)/kunit-uapi.o: $(obj)/uapi-preinit
+
 ifeq ($(CONFIG_KUNIT_DEBUGFS),y)
 kunit-objs +=				debugfs.o
 endif
diff --git a/lib/kunit/kunit-uapi.c b/lib/kunit/kunit-uapi.c
index 24356f68eca0df07032fb8a9e92daffde01b21d3..382a2bfee3c78a6e042a56a9ccdefcd55b5265a1 100644
--- a/lib/kunit/kunit-uapi.c
+++ b/lib/kunit/kunit-uapi.c
@@ -25,6 +25,8 @@
 #define KSFT_XPASS	3
 #define KSFT_SKIP	4
 
+KUNIT_UAPI_EMBED_BLOB(kunit_uapi_preinit, "uapi-preinit");
+
 static struct vfsmount *kunit_uapi_mount_ramfs(void)
 {
 	struct file_system_type *type;
@@ -146,7 +148,7 @@ static int kunit_uapi_user_mode_thread_init(void *data)
 	kernel_sigaction(SIGABRT, SIG_DFL);
 
 	complete(&ctx->setup_done);
-	ctx->exec_err = kernel_execve(ctx->executable, argv, NULL);
+	ctx->exec_err = kernel_execve(kbasename(kunit_uapi_preinit.path), argv, NULL);
 	if (!ctx->exec_err)
 		return 0;
 	do_exit(0);
@@ -255,7 +257,10 @@ static int kunit_uapi_run_executable(struct kunit *test,
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
-	err = kunit_uapi_write_executable(mnt, executable);
+	err = kunit_uapi_write_executable(mnt, &kunit_uapi_preinit);
+
+	if (!err)
+		err = kunit_uapi_write_executable(mnt, executable);
 
 	if (!err)
 		err = kunit_uapi_run_executable_in_mount(test, exe_name, mnt);
diff --git a/lib/kunit/uapi-preinit.c b/lib/kunit/uapi-preinit.c
new file mode 100644
index 0000000000000000000000000000000000000000..81182039965a8c93aebb2d5d76f4113bfef277a6
--- /dev/null
+++ b/lib/kunit/uapi-preinit.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit Userspace environment setup.
+ *
+ * Copyright (C) 2025, Linutronix GmbH.
+ * Author: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
+ *
+ * This is *userspace* code.
+ */
+
+#include <sys/mount.h>
+#include <sys/stat.h>
+
+#include "../../tools/testing/selftests/kselftest.h"
+
+static int setup_api_mount(const char *target, const char *fstype)
+{
+	int ret;
+
+	ret = mkdir(target, 0755);
+	if (ret && errno != EEXIST)
+		return -errno;
+
+	ret = mount("none", target, fstype, 0, NULL);
+	if (ret && errno != EBUSY)
+		return -errno;
+
+	return 0;
+}
+
+static void exit_failure(const char *stage, int err)
+{
+	/* If preinit fails synthesize a failed test report. */
+	ksft_print_header();
+	ksft_set_plan(1);
+	ksft_test_result_fail("Failed during test setup: %s: %s\n", stage, strerror(-err));
+	ksft_finished();
+}
+
+int main(int argc, char **argv, char **envp)
+{
+	int ret;
+
+	ret = setup_api_mount("/proc", "proc");
+	if (ret)
+		exit_failure("mount /proc", ret);
+
+	ret = setup_api_mount("/sys", "sysfs");
+	if (ret)
+		exit_failure("mount /sys", ret);
+
+	if (IS_ENABLED(CONFIG_DEVTMPFS)) {
+		ret = setup_api_mount("/dev", "devtmpfs");
+		if (ret)
+			exit_failure("mount /dev", ret);
+	}
+
+	ret = execve(argv[0], argv, envp);
+	if (ret)
+		exit_failure("execve", ret);
+
+	return 0;
+}

-- 
2.50.0


