Return-Path: <linux-fsdevel+bounces-55230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CAEB088A2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82834581212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4F128A1C3;
	Thu, 17 Jul 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5z0VE8H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P43dV4eW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21892877D5;
	Thu, 17 Jul 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752742689; cv=none; b=et20bGfT4R2idwtjTDuSPe+os65xRqtqiDw0Vpr/PDvy7b1WwXrCTmTJiCIzrvdBzSAfPXQELX+QNQbaR61G32OuN9fNeVVtY7zmegAwXyGgJLUedJcjX/o+NLldhnTX/tUdqnu+KuwZ6iY6X308Whlti59SEbx1bFnHmPX+7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752742689; c=relaxed/simple;
	bh=saIRNuAtW0PuaxzDtIyoVCq5nkHnvB5u6afs3WS412A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jCsafVfyjtwIhqrRrM35eV/yDUmzw2873xnyh0Sv1jkDdz/vG2PHAkCcgcXlRbIJnG3cKPn+3mXQGWGMyxgBTj5so//K1CszKg0NTHbtlcqMiODcNcpweCD3Hq/tHxT0wEr7BemwJ9dJXuUsZLwDiFz+5Q1NdVsK2ceJB7WCxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5z0VE8H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P43dV4eW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752742132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fcKeWoAnZo1KFnR2UYBUI8HAy7QcEMFTjd3/M+NefdM=;
	b=R5z0VE8H2kxqLVIVUouFigCoqS7jlVvsu0iGBLhBPWhBc8RPDW0L0Bz8utiK2PfD5jd7qO
	HMVN8R0oGUIzl8GsHFp6IyMIVb1obEseDrsB0MJHIh5S8CisSJyYcDql2Iq1T19SeAPl5z
	16afVD4VYb6MfkPlLe5ihud3cl4p5tih5Ym1bZN1llML7LsRAiX8odgu7xIYGw3zTcu/2C
	ZpsfYZGbuaDGAt82h1cu197aHcgOfdF9DCvWW60i6WKgtFWrxHh3GBAqDKmKWxEqqQAE6f
	FMcY98vvBfRoIVlOpHEdwdaErzx+7cRTt/mqMPgxEWfQaf/WszKx4iFwlmfiiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752742132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fcKeWoAnZo1KFnR2UYBUI8HAy7QcEMFTjd3/M+NefdM=;
	b=P43dV4eWHr/SEZHgXo9QEjW+3c9LvyRORYSKoPGO1PinYU8ueEf4UHpC83PJjdIPZ+xZFr
	vuGbN9Gj+TOvaYDQ==
Subject: [PATCH v5 00/15] kunit: Introduce UAPI testing framework
Date: Thu, 17 Jul 2025 10:48:02 +0200
Message-Id: <20250717-kunit-kselftests-v5-0-442b711cde2e@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMO4eGgC/3XOQWrDMBAF0KsErauiGc3Ypqveo3RhyeNGJNhFU
 kxC8N0jhUJK6i7/wH/zrypJDJLU2+6qoiwhhXkqgV92yu/76Ut0GEpWaJDAAOvDaQpZH5Icxyw
 pJ80NttZ5MkSoSu07yhjOd/Ljs+R9SHmOl/uHBeq1YmwQ7F9sAW1072xru4F7Bnk/humU4zyF8
 +sg1f8pt/+UCR0xkrfO9E/lumbBxwIyWwhWhAmABLt2HLYQ+0AagA3EFoRZ7ADUeeebLYR+Idh
 sIFSXdG1j2NIoIz8j67reABYOUv/AAQAA
X-Change-ID: 20241015-kunit-kselftests-56273bc40442
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752742130; l=9092;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=saIRNuAtW0PuaxzDtIyoVCq5nkHnvB5u6afs3WS412A=;
 b=34JN5OQhwxD60lyJXRL77fTY52XiTsyu4xEaaAuhwbUfEfa2nLTIvj44L7jPZgAddJPa2fW8A
 t2+Thm5IHH2BYw/X8Fh6S9SqnijkRe6vvo/YteQSOkMim1QgwA0GUYJ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Currently testing of userspace and in-kernel API use two different
frameworks. kselftests for the userspace ones and Kunit for the
in-kernel ones. Besides their different scopes, both have different
strengths and limitations:

Kunit:
* Tests are normal kernel code.
* They use the regular kernel toolchain.
* They can be packaged and distributed as modules conveniently.

Kselftests:
* Tests are normal userspace code
* They need a userspace toolchain.
  A kernel cross toolchain is likely not enough.
* A fair amout of userland is required to run the tests,
  which means a full distro or handcrafted rootfs.
* There is no way to conveniently package and run kselftests with a
  given kernel image.
* The kselftests makefiles are not as powerful as regular kbuild.
  For example they are missing proper header dependency tracking or more
  complex compiler option modifications.

Therefore kunit is much easier to run against different kernel
configurations and architectures.
This series aims to combine kselftests and kunit, avoiding both their
limitations. It works by compiling the userspace kselftests as part of
the regular kernel build, embedding them into the kunit kernel or module
and executing them from there. If the kernel toolchain is not fit to
produce userspace because of a missing libc, the kernel's own nolibc can
be used instead.
The structured TAP output from the kselftest is integrated into the
kunit KTAP output transparently, the kunit parser can parse the combined
logs together.

Further room for improvements:
* Call each test in its completely dedicated namespace
* Handle additional test files besides the test executable through
  archives. CPIO, cramfs, etc.
* Compatibility with kselftest_harness.h (in progress)
* Expose the blobs in debugfs
* Provide some convience wrappers around compat userprogs
* Figure out a migration path/coexistence solution for
  kunit UAPI and tools/testing/selftests/

Output from the kunit example testcase, note the output of
"example_uapi_tests".

$ ./tools/testing/kunit/kunit.py run --kunitconfig lib/kunit example
...
Running tests with:
$ .kunit/linux kunit.filter_glob=example kunit.enable=1 mem=1G console=tty kunit_shutdown=halt
[11:53:53] ================== example (10 subtests) ===================
[11:53:53] [PASSED] example_simple_test
[11:53:53] [SKIPPED] example_skip_test
[11:53:53] [SKIPPED] example_mark_skipped_test
[11:53:53] [PASSED] example_all_expect_macros_test
[11:53:53] [PASSED] example_static_stub_test
[11:53:53] [PASSED] example_static_stub_using_fn_ptr_test
[11:53:53] [PASSED] example_priv_test
[11:53:53] =================== example_params_test  ===================
[11:53:53] [SKIPPED] example value 3
[11:53:53] [PASSED] example value 2
[11:53:53] [PASSED] example value 1
[11:53:53] [SKIPPED] example value 0
[11:53:53] =============== [PASSED] example_params_test ===============
[11:53:53] [PASSED] example_slow_test
[11:53:53] ======================= (4 subtests) =======================
[11:53:53] [PASSED] procfs
[11:53:53] [PASSED] userspace test 2
[11:53:53] [SKIPPED] userspace test 3: some reason
[11:53:53] [PASSED] userspace test 4
[11:53:53] ================ [PASSED] example_uapi_test ================
[11:53:53] ===================== [PASSED] example =====================
[11:53:53] ============================================================
[11:53:53] Testing complete. Ran 16 tests: passed: 11, skipped: 5
[11:53:53] Elapsed time: 67.543s total, 1.823s configuring, 65.655s building, 0.058s running

Based on v6.16-rc1.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v5:
- Initialize output variable of kernel_wait()
- Fix .incbin with in-tree builds
- Keep requirement of KTAP tests to have a number which was removed accidentally
- Only synthesize KTAP subtest failure if the outer one is TestStatus.FAILURE
- Use -I instead of -isystem in NOLIBC_USERCFLAGS to populate dependency files
- +To filesystem developers to all patches
- +To Luis Chamberlain for discussions about usage of usermodehelper
  (see patches 6 and 12)
- Link to v4: https://lore.kernel.org/r/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de

Changes in v4:
- Move Kconfig.nolibc from tools/ to init/
- Drop generic userprogs nolibc integration
- Drop generic blob framework
- Pick up review tags from David
- Extend new kunit TAP parser tests
- Add MAINTAINERS entry
- Allow CONFIG_KUNIT_UAPI=m
- Split /proc validation into dedicated UAPI test
- Trim recipient list a bit
- Use KUNIT_FAIL_AND_ABORT() over KUNIT_FAIL()
- Link to v3: https://lore.kernel.org/r/20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de

Changes in v3:
- Reintroduce CONFIG_CC_CAN_LINK_STATIC
- Enable CONFIG_ARCH_HAS_NOLIBC for m68k and SPARC
- Properly handle 'clean' target for userprogs
- Use ramfs over tmpfs to reduce dependencies
- Inherit userprogs byte order and ABI from kernel
- Drop now unnecessary "#ifndef NOLIBC"
- Pick up review tags
- Drop usage of __private in blob.h,
  sparse complains and it is not really necessary
- Fix execution on loongarch when using clang
- Drop userprogs libgcc handling, it was ugly and is not yet necessary
- Link to v2: https://lore.kernel.org/r/20250407-kunit-kselftests-v2-0-454114e287fd@linutronix.de

Changes in v2:
- Rebase onto v6.15-rc1
- Add documentation and kernel docs
- Resolve invalid kconfig breakages
- Drop already applied patch "kbuild: implement CONFIG_HEADERS_INSTALL for Usermode Linux"
- Drop userprogs CONFIG_WERROR integration, it doesn't need to be part of this series
- Replace patch prefix "kconfig" with "kbuild"
- Rename kunit_uapi_run_executable() to kunit_uapi_run_kselftest()
- Generate private, conflict-free symbols in the blob framework
- Handle kselftest exit codes
- Handle SIGABRT
- Forward output also to kunit debugfs log
- Install a fd=0 stdin filedescriptor
- Link to v1: https://lore.kernel.org/r/20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de

---
Thomas Weißschuh (15):
      kbuild: userprogs: avoid duplication of flags inherited from kernel
      kbuild: userprogs: also inherit byte order and ABI from kernel
      kbuild: doc: add label for userprogs section
      init: re-add CONFIG_CC_CAN_LINK_STATIC
      init: add nolibc build support
      fs,fork,exit: export symbols necessary for KUnit UAPI support
      kunit: tool: Add test for nested test result reporting
      kunit: tool: Don't overwrite test status based on subtest counts
      kunit: tool: Parse skipped tests from kselftest.h
      kunit: Always descend into kunit directory during build
      kunit: qemu_configs: loongarch: Enable LSX/LSAX
      kunit: Introduce UAPI testing framework
      kunit: uapi: Add example for UAPI tests
      kunit: uapi: Introduce preinit executable
      kunit: uapi: Validate usability of /proc

 Documentation/dev-tools/kunit/api/index.rst        |   5 +
 Documentation/dev-tools/kunit/api/uapi.rst         |  14 +
 Documentation/kbuild/makefiles.rst                 |   2 +
 MAINTAINERS                                        |  11 +
 Makefile                                           |   7 +-
 fs/exec.c                                          |   2 +
 fs/file.c                                          |   1 +
 fs/filesystems.c                                   |   2 +
 fs/fs_struct.c                                     |   1 +
 fs/pipe.c                                          |   2 +
 include/kunit/uapi.h                               |  77 ++++++
 init/Kconfig                                       |   7 +
 init/Kconfig.nolibc                                |  15 +
 init/Makefile.nolibc                               |  13 +
 kernel/exit.c                                      |   3 +
 kernel/fork.c                                      |   2 +
 lib/Makefile                                       |   4 -
 lib/kunit/Kconfig                                  |  14 +
 lib/kunit/Makefile                                 |  30 +-
 lib/kunit/kunit-example-test.c                     |  15 +
 lib/kunit/kunit-example-uapi.c                     |  22 ++
 lib/kunit/kunit-test-uapi.c                        |  51 ++++
 lib/kunit/kunit-test.c                             |  23 +-
 lib/kunit/kunit-uapi.c                             | 305 +++++++++++++++++++++
 lib/kunit/uapi-preinit.c                           |  63 +++++
 tools/testing/kunit/kunit_parser.py                |  11 +-
 tools/testing/kunit/kunit_tool_test.py             |  11 +
 tools/testing/kunit/qemu_configs/loongarch.py      |   2 +
 .../test_is_test_passed-failure-nested.log         |  10 +
 .../test_data/test_is_test_passed-kselftest.log    |   3 +-
 30 files changed, 715 insertions(+), 13 deletions(-)
---
base-commit: 9d5898b413d17510b2a41664a42390a2c79f8bf4
change-id: 20241015-kunit-kselftests-56273bc40442

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


