Return-Path: <linux-fsdevel+bounces-53055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3335FAE95BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 08:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A787AED27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 06:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E507237180;
	Thu, 26 Jun 2025 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zjSwxNDA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6SWrBUdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CDB2264C3;
	Thu, 26 Jun 2025 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750918221; cv=none; b=fm/ENp1HnrEEetgDql1QgZltlOqyz4rN3w1rlR32ZM8nYnCkZ5B6NxZMPTC4ZlwPj2drsfcBHACeyedIJ8YVP5BsFeNAf66QOdw28lQlCia+boNBdU8yYhsyXHd4awZP1RYhdcYKCJLgbhZaWDCWzyNCCyet7xcW/INGOswIXS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750918221; c=relaxed/simple;
	bh=XzMifYxGP4fkI2Wkgun0SAdSBRagopcZYW5zEmzLABs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B5ObnUP68bagIJbZBo6xNUTMfCs2CmRbzO/C16vod0Eog2FTpnms9w1hBzUqBVe/rx6rMQsLOQxxTjdjXXDTC+HmmYu6UyNubndkvS/tjaREQ1+6L/kCSYbNRtyMAhx2HPZucQ0OM0x2hS7R9qK0E/es7lzAhNKCKcPu+eMYOP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zjSwxNDA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6SWrBUdE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750918216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7wMAT2zjIrnnqBvLyPpv57gpDeV2/7OKyziHXnTMJU4=;
	b=zjSwxNDAJpXihqsHBGHOpU5MvTeap5L2g4D9hPyaR5SdzIqI3F/MBhqmUMQoQPxgXFj37s
	d/YKVYmqFmnwV/6MTK7NPDo2bUXUCF+jzIdnYlm4rStWrhpVTBhxc2Yoftx/kRDrcvFw89
	79jL2njk1/LdsgUh3lLzlstdwNQXLtHx86j0lVRNeQYMYKEdHoWDf+BwkATv+C0vcrnhB6
	8LoNp0DVj18+7sGOgrZ8y44i+wNBAImh25TjZclorG9e4L3C/4Js28jj+7V9xJXLDXLcw+
	QzzHJMn1dT9i8RPbCMqQhb4FN0lMlVly4OYNjseHGkGNbwCZ2k3y2W4urcixiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750918216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7wMAT2zjIrnnqBvLyPpv57gpDeV2/7OKyziHXnTMJU4=;
	b=6SWrBUdEXVMuE5hm4afYSZoj3d+22he97Fv02iKmVTOTLkqxZcyzqXE5u5tDDvdUunDaxA
	eEsgQHyWPD7my/Ag==
Subject: [PATCH v4 00/15] kunit: Introduce UAPI testing framework
Date: Thu, 26 Jun 2025 08:10:08 +0200
Message-Id: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEDkXGgC/3XOQWrDMBAF0KsErauiGY1s01XvUbqwpHEjEuQgK
 SYl+O6RQiCQuss/8N/8q8icAmfxsbuKxEvIYY410NtOuP0Yf1gGX7NAhQQKjDycYyjykPk4Fc4
 lS9Nhr60jRYSi1k6Jp3C5k1/fNe9DLnP6vX9YoF0bZhSC/ostIJUcre714M1ogD+PIZ5LmmO4v
 Htu/qPc/1MmtGSQnLZqfCm3NQs+F5DaQrAhhgCIcegnv4XoJ9IBbCC6Isaw9kCDs657RdZ1vQH
 lfB1+ewEAAA==
X-Change-ID: 20241015-kunit-kselftests-56273bc40442
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-doc@vger.kernel.org, workflows@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750918216; l=8512;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=XzMifYxGP4fkI2Wkgun0SAdSBRagopcZYW5zEmzLABs=;
 b=ppxMKOfwsD3qz+8dOtgt02vlDye25mJNFxcNhVW1mmysm/uaAieqWPnrW6LnEB6e3nV5QWOyO
 /DWkBahyy7fAMyeZdP8GrYcnBY4ps6EBp+YXSQax5/r8Y/n39Zjjhqw
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
 lib/kunit/Makefile                                 |  27 +-
 lib/kunit/kunit-example-test.c                     |  15 +
 lib/kunit/kunit-example-uapi.c                     |  22 ++
 lib/kunit/kunit-test-uapi.c                        |  51 ++++
 lib/kunit/kunit-test.c                             |  23 +-
 lib/kunit/kunit-uapi.c                             | 305 +++++++++++++++++++++
 lib/kunit/uapi-preinit.c                           |  63 +++++
 tools/testing/kunit/kunit_parser.py                |  13 +-
 tools/testing/kunit/kunit_tool_test.py             |  11 +
 tools/testing/kunit/qemu_configs/loongarch.py      |   2 +
 .../test_is_test_passed-failure-nested.log         |  10 +
 .../test_data/test_is_test_passed-kselftest.log    |   3 +-
 30 files changed, 714 insertions(+), 13 deletions(-)
---
base-commit: 9d5898b413d17510b2a41664a42390a2c79f8bf4
change-id: 20241015-kunit-kselftests-56273bc40442

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


