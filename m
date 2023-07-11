Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6474F4DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 18:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjGKQS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 12:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjGKQSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:18:25 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D353FE6F
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 09:18:22 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-cesqXmrcO4qN91k_C9676Q-1; Tue, 11 Jul 2023 12:18:05 -0400
X-MC-Unique: cesqXmrcO4qN91k_C9676Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68D6C3C0C487;
        Tue, 11 Jul 2023 16:18:02 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.45.225.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B797200B415;
        Tue, 11 Jul 2023 16:17:52 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     James.Bottomley@HansenPartnership.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, axboe@kernel.dk,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, christian@brauner.io, dalias@libc.org,
        davem@davemloft.net, deepa.kernel@gmail.com, deller@gmx.de,
        dhowells@redhat.com, fenghua.yu@intel.com, fweimer@redhat.com,
        geert@linux-m68k.org, glebfm@altlinux.org, gor@linux.ibm.com,
        hare@suse.com, hpa@zytor.com, ink@jurassic.park.msu.ru,
        jhogan@kernel.org, kim.phillips@arm.com, ldv@altlinux.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        luto@kernel.org, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, namhyung@kernel.org,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        sparclinux@vger.kernel.org, stefan@agner.ch, tglx@linutronix.de,
        tony.luck@intel.com, tycho@tycho.ws, will@kernel.org,
        x86@kernel.org, ysato@users.sourceforge.jp
Subject: [PATCH v4 5/5] selftests: Add fchmodat2 selftest
Date:   Tue, 11 Jul 2023 18:16:07 +0200
Message-Id: <4532a04a870ff589ba62ceeacf76f0bd81b9ba01.1689092120.git.legion@kernel.org>
In-Reply-To: <cover.1689092120.git.legion@kernel.org>
References: <cover.1689074739.git.legion@kernel.org> <cover.1689092120.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The test marks as skipped if a syscall with the AT_SYMLINK_NOFOLLOW flag
fails. This is because not all filesystems support changing the mode
bits of symlinks properly. These filesystems return an error but change
the mode bits:

newfstatat(4, "regfile", {st_mode=S_IFREG|0640, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0
newfstatat(4, "symlink", {st_mode=S_IFLNK|0777, st_size=7, ...}, AT_SYMLINK_NOFOLLOW) = 0
syscall_0x1c3(0x4, 0x55fa1f244396, 0x180, 0x100, 0x55fa1f24438e, 0x34) = -1 EOPNOTSUPP (Operation not supported)
newfstatat(4, "regfile", {st_mode=S_IFREG|0640, st_size=0, ...}, AT_SYMLINK_NOFOLLOW) = 0

This happens with btrfs and xfs:

 $ tools/testing/selftests/fchmodat2/fchmodat2_test
 TAP version 13
 1..1
 ok 1 # SKIP fchmodat2(symlink)
 # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

 $ stat /tmp/ksft-fchmodat2.*/symlink
   File: /tmp/ksft-fchmodat2.3NCqlE/symlink -> regfile
   Size: 7               Blocks: 0          IO Block: 4096   symbolic link
 Device: 7,0     Inode: 133         Links: 1
 Access: (0600/lrw-------)  Uid: (    0/    root)   Gid: (    0/    root)

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/fchmodat2/.gitignore  |   2 +
 tools/testing/selftests/fchmodat2/Makefile    |   6 +
 .../selftests/fchmodat2/fchmodat2_test.c      | 162 ++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 tools/testing/selftests/fchmodat2/.gitignore
 create mode 100644 tools/testing/selftests/fchmodat2/Makefile
 create mode 100644 tools/testing/selftests/fchmodat2/fchmodat2_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 666b56f22a41..8dca8acdb671 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -18,6 +18,7 @@ TARGETS += drivers/net/bonding
 TARGETS += drivers/net/team
 TARGETS += efivarfs
 TARGETS += exec
+TARGETS += fchmodat2
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
 TARGETS += filesystems/epoll
diff --git a/tools/testing/selftests/fchmodat2/.gitignore b/tools/testing/selftests/fchmodat2/.gitignore
new file mode 100644
index 000000000000..82a4846cbc4b
--- /dev/null
+++ b/tools/testing/selftests/fchmodat2/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/*_test
diff --git a/tools/testing/selftests/fchmodat2/Makefile b/tools/testing/selftests/fchmodat2/Makefile
new file mode 100644
index 000000000000..45b519eab851
--- /dev/null
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
+TEST_GEN_PROGS := fchmodat2_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
new file mode 100644
index 000000000000..2d98eb215bc6
--- /dev/null
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <syscall.h>
+#include <unistd.h>
+
+#include "../kselftest.h"
+
+#ifndef __NR_fchmodat2
+	#if defined __alpha__
+		#define __NR_fchmodat2 562
+	#elif defined _MIPS_SIM
+		#if _MIPS_SIM == _MIPS_SIM_ABI32	/* o32 */
+			#define __NR_fchmodat2 (452 + 4000)
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_NABI32	/* n32 */
+			#define __NR_fchmodat2 (452 + 6000)
+		#endif
+		#if _MIPS_SIM == _MIPS_SIM_ABI64	/* n64 */
+			#define __NR_fchmodat2 (452 + 5000)
+		#endif
+	#elif defined __ia64__
+		#define __NR_fchmodat2 (452 + 1024)
+	#else
+		#define __NR_fchmodat2 452
+	#endif
+#endif
+
+int sys_fchmodat2(int dfd, const char *filename, mode_t mode, int flags)
+{
+	int ret = syscall(__NR_fchmodat2, dfd, filename, mode, flags);
+
+	return ret >= 0 ? ret : -errno;
+}
+
+int setup_testdir(void)
+{
+	int dfd, ret;
+	char dirname[] = "/tmp/ksft-fchmodat2.XXXXXX";
+
+	/* Make the top-level directory. */
+	if (!mkdtemp(dirname))
+		ksft_exit_fail_msg("%s: failed to create tmpdir\n", __func__);
+
+	dfd = open(dirname, O_PATH | O_DIRECTORY);
+	if (dfd < 0)
+		ksft_exit_fail_msg("%s: failed to open tmpdir\n", __func__);
+
+	ret = openat(dfd, "regfile", O_CREAT | O_WRONLY | O_TRUNC, 0644);
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: failed to create file in tmpdir\n",
+				__func__);
+	close(ret);
+
+	ret = symlinkat("regfile", dfd, "symlink");
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: failed to create symlink in tmpdir\n",
+				__func__);
+
+	return dfd;
+}
+
+int expect_mode(int dfd, const char *filename, mode_t expect_mode)
+{
+	struct stat st;
+	int ret = fstatat(dfd, filename, &st, AT_SYMLINK_NOFOLLOW);
+
+	if (ret)
+		ksft_exit_fail_msg("%s: %s: fstatat failed\n",
+				__func__, filename);
+
+	return (st.st_mode == expect_mode);
+}
+
+void test_regfile(void)
+{
+	int dfd, ret;
+
+	dfd = setup_testdir();
+
+	ret = sys_fchmodat2(dfd, "regfile", 0640, 0);
+
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: fchmodat2(noflag) failed\n", __func__);
+
+	if (!expect_mode(dfd, "regfile", 0100640))
+		ksft_exit_fail_msg("%s: wrong file mode bits after fchmodat2\n",
+				__func__);
+
+	ret = sys_fchmodat2(dfd, "regfile", 0600, AT_SYMLINK_NOFOLLOW);
+
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: fchmodat2(AT_SYMLINK_NOFOLLOW) failed\n",
+				__func__);
+
+	if (!expect_mode(dfd, "regfile", 0100600))
+		ksft_exit_fail_msg("%s: wrong file mode bits after fchmodat2 with nofollow\n",
+				__func__);
+
+	ksft_test_result_pass("fchmodat2(regfile)\n");
+}
+
+void test_symlink(void)
+{
+	int dfd, ret;
+
+	dfd = setup_testdir();
+
+	ret = sys_fchmodat2(dfd, "symlink", 0640, 0);
+
+	if (ret < 0)
+		ksft_exit_fail_msg("%s: fchmodat2(noflag) failed\n", __func__);
+
+	if (!expect_mode(dfd, "regfile", 0100640))
+		ksft_exit_fail_msg("%s: wrong file mode bits after fchmodat2\n",
+				__func__);
+
+	if (!expect_mode(dfd, "symlink", 0120777))
+		ksft_exit_fail_msg("%s: wrong symlink mode bits after fchmodat2\n",
+				__func__);
+
+	ret = sys_fchmodat2(dfd, "symlink", 0600, AT_SYMLINK_NOFOLLOW);
+
+	/*
+	 * On certain filesystems (xfs or btrfs), chmod operation fails. So we
+	 * first check the symlink target but if the operation fails we mark the
+	 * test as skipped.
+	 *
+	 * https://sourceware.org/legacy-ml/libc-alpha/2020-02/msg00467.html
+	 */
+	if (ret == 0 && !expect_mode(dfd, "symlink", 0120600))
+		ksft_exit_fail_msg("%s: wrong symlink mode bits after fchmodat2 with nofollow\n",
+				__func__);
+
+	if (!expect_mode(dfd, "regfile", 0100640))
+		ksft_exit_fail_msg("%s: wrong file mode bits after fchmodat2 with nofollow\n",
+				__func__);
+
+	if (ret != 0)
+		ksft_test_result_skip("fchmodat2(symlink)\n");
+	else
+		ksft_test_result_pass("fchmodat2(symlink)\n");
+}
+
+#define NUM_TESTS 2
+
+int main(int argc, char **argv)
+{
+	ksft_print_header();
+	ksft_set_plan(NUM_TESTS);
+
+	test_regfile();
+	test_symlink();
+
+	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
+		ksft_exit_fail();
+	else
+		ksft_exit_pass();
+}
-- 
2.33.8

