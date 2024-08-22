Return-Path: <linux-fsdevel+bounces-26678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6C695AEE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94041B251B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECD318733C;
	Thu, 22 Aug 2024 07:14:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D2186E4F;
	Thu, 22 Aug 2024 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310875; cv=none; b=JVDa3EB1fLWuz4VK34LJoMcIx1HejAWvyYyHWD+UKZXrtVqLqwNFBR35oryQB7zlGmNHXIIPPO1MK4pb2jWQm0CWvM5yCL5ipAcjq/9r/UNJ8cpB3bk+3+gke4qKXYQnt3Lt5axc+Br/GQQOQqHkDwIGa0DbDJImGSi8BprPT2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310875; c=relaxed/simple;
	bh=myEwghlIo0VFEa/kCbUR8jkMcaOa8Dz8PO/V1GnGZDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHR8jR0diuBAG8Y1FKBY8S21ZkwTZcldcM0d8Ni35IN2RJp7tYqwqzKD5Z+WQWqM7I93/2NTiUxVx7bb8CCII6DSMNwmtVZfX91/Ul02We7zN9XQN9BbuUb6cih/t5kf4xHYmnjPcFVBdWBVjWPtVJg6cr1OfoyU9UGvEN7tEqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDvQ4rYFz9sT7;
	Thu, 22 Aug 2024 09:13:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n4SVLNdodNdx; Thu, 22 Aug 2024 09:13:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDvQ3xMdz9sSy;
	Thu, 22 Aug 2024 09:13:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 73F9A8B77E;
	Thu, 22 Aug 2024 09:13:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id HFEB0Yp4iArX; Thu, 22 Aug 2024 09:13:38 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6065C8B77D;
	Thu, 22 Aug 2024 09:13:37 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 15/17] selftests: vdso: Fix build of test_vdso_chacha
Date: Thu, 22 Aug 2024 09:13:23 +0200
Message-ID: <50cc36936b310d8dd6d7539c552cc8dd84052020.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310795; l=3948; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=myEwghlIo0VFEa/kCbUR8jkMcaOa8Dz8PO/V1GnGZDU=; b=3pzQ86+owF0quZVMNfNkNt1pF9agoztEqTpacb3+y5tzmYnNz4M7kg6ndA6tudWCTTaQ+v5Ls uth/LEL3EsrDJl98Nr2BREqhGR2wN0QN52ZMiThEVDzt+0TzB1GKIi/
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Building test_vdso_chacha on powerpc leads to following issue:

  In file included from /home/chleroy/linux-powerpc/include/linux/limits.h:7,
                   from /opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/local_lim.h:38,
                   from /opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/posix1_lim.h:161,
                   from /opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/limits.h:195,
                   from /opt/powerpc64-e5500--glibc--stable-2024.02-1/lib/gcc/powerpc64-buildroot-linux-gnu/12.3.0/include-fixed/limits.h:203,
                   from /opt/powerpc64-e5500--glibc--stable-2024.02-1/lib/gcc/powerpc64-buildroot-linux-gnu/12.3.0/include-fixed/syslimits.h:7,
                   from /opt/powerpc64-e5500--glibc--stable-2024.02-1/lib/gcc/powerpc64-buildroot-linux-gnu/12.3.0/include-fixed/limits.h:34,
                   from /tmp/sodium/usr/local/include/sodium/export.h:7,
                   from /tmp/sodium/usr/local/include/sodium/crypto_stream_chacha20.h:14,
                   from vdso_test_chacha.c:6:
  /opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/xopen_lim.h:99:6: error: missing binary operator before token "("
     99 | # if INT_MAX == 32767
        |      ^~~~~~~
  /opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/xopen_lim.h:102:7: error: missing binary operator before token "("
    102 | #  if INT_MAX == 2147483647
        |       ^~~~~~~
  /opt/powerpc64-e5500--glibc--stable-2024.02-1/powerpc64-buildroot-linux-gnu/sysroot/usr/include/bits/xopen_lim.h:126:6: error: missing binary operator before token "("
    126 | # if LONG_MAX == 2147483647
        |      ^~~~~~~~

This is due to kernel include/linux/limits.h being included instead of libc's
limits.h

This is because directory include/ is added through option -isystem so it goes
prior to glibc's include directory.

Replace -isystem by -idirafter

But this implies that now tools/include/linux/linkage.h is
included instead of include/linux/linkage.h, so define a stub
for SYM_FUNC_START() and SYM_FUNC_END().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/include/linux/linkage.h         | 4 ++++
 tools/testing/selftests/vDSO/Makefile | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/linkage.h b/tools/include/linux/linkage.h
index bc763d500262..a48ff086899c 100644
--- a/tools/include/linux/linkage.h
+++ b/tools/include/linux/linkage.h
@@ -1,4 +1,8 @@
 #ifndef _TOOLS_INCLUDE_LINUX_LINKAGE_H
 #define _TOOLS_INCLUDE_LINUX_LINKAGE_H
 
+#define SYM_FUNC_START(x) .globl x; x:
+
+#define SYM_FUNC_END(x)
+
 #endif /* _TOOLS_INCLUDE_LINUX_LINKAGE_H */
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index c9a819cacbf2..10ffdda3f2fa 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -42,7 +42,7 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
 
 $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vgetrandom-chacha.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
-                                      -isystem $(top_srcdir)/arch/$(ARCH)/include \
-                                      -isystem $(top_srcdir)/include \
+                                      -idirafter $(top_srcdir)/arch/$(ARCH)/include \
+                                      -idirafter $(top_srcdir)/include \
                                       -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 \
                                       -Wa,--noexecstack $(SODIUM)
-- 
2.44.0


