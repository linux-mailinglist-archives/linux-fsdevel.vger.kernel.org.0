Return-Path: <linux-fsdevel+bounces-26663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C595AE7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457D9282FF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3714B968;
	Thu, 22 Aug 2024 07:13:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7313A3FD;
	Thu, 22 Aug 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310813; cv=none; b=EydwLLp1N0L1u874Kwyfn6vK2dKpPvHJSnj9UA+J5ayjIUEY5hyQt4N0XBn0EiDgPucWdJNLUcMGzBbGlPyu6f3GZ44a0zJWzae+nQ5DVVMwPTqgAl0Nvcbsk8Z+cR/nG2D+Wz5pdb7jXLR6THxsZN0eT6x5+PHjWKWEKG/c5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310813; c=relaxed/simple;
	bh=LDTg0Yi2fhuFH1uAWm1BFhSE+R7SP2TBN1LukDLSwAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npX4RPNDjb1ZABPNc1+T0M5RFCR0cz7jMtEBZ0CmeSLMzppp2F5HweE52bcU20PBVZp+6Km5x0v3yVq0bUkS3BhupJo+zPsGAlVhfg3Ust85IrQVrSOA6YB1D5ff0DqrSb0VJNzjpd6OMLcvKxqALjKefkwy4mduX0WHdCQjjYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDv65R16z9sSK;
	Thu, 22 Aug 2024 09:13:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0-VRwaKzoNbn; Thu, 22 Aug 2024 09:13:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDv64Pbrz9sSH;
	Thu, 22 Aug 2024 09:13:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 84A608B77E;
	Thu, 22 Aug 2024 09:13:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 27TFRoaI4C9O; Thu, 22 Aug 2024 09:13:22 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C3F08B763;
	Thu, 22 Aug 2024 09:13:21 +0200 (CEST)
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
Subject: [PATCH v2 00/17] Wire up getrandom() vDSO implementation on powerpc
Date: Thu, 22 Aug 2024 09:13:08 +0200
Message-ID: <cover.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310793; l=4901; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=LDTg0Yi2fhuFH1uAWm1BFhSE+R7SP2TBN1LukDLSwAc=; b=dv3IJ6HgpSk062fA80pC3beOaGyDkub2uRhJOU7nq6upvK1O1zJTzR6G/vOqsb7Bf92j66uNp R/+usMEBgmRBPUzWE5rLVkIDoO79FdFlAYqzoQmRCjL2crIMNd9IRbK
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This series wires up getrandom() vDSO implementation on powerpc.

Tested on PPC32.

Performance on powerpc 885 (using kernel selftest):
	~# ./vdso_test_getrandom bench-single
	   vdso: 2500000 times in 7.897495392 seconds
	   libc: 2500000 times in 56.091632232 seconds
	syscall: 2500000 times in 55.704851989 seconds

Performance on powerpc 8321 (using kernel selftest):
	~# ./vdso_test_getrandom bench-single
	   vdso: 2500000 times in 2.017183250 seconds
	   libc: 2500000 times in 13.088533630 seconds
	syscall: 2500000 times in 12.952458068 seconds

Only build tested on PPC64. There is a problem with vdso_test_getrandom
selftest, it doesn't find vDSO symbol __kernel_getrandom. There is the
same problem with vdso_test_gettimeofday so it is not related to
getrandom.

On strange things to be clarified, there is the format of the key passed
to __arch_chacha20_blocks_nostack(). In struct vgetrandom_state it is
declared as a table of u32, but in reality it seems it is a flat storage
that needs to be loaded in reversed byte order, so it should either be
defined as a table of bytes, or as a table of __le32 but not a table of
u32. But this has no impact and can be clarified later and fixed in a
follow-up patch.

Changes in v2:
- Define VM_DROPPABLE for powerpc/32
- Fixes generic vDSO getrandom headers to enable CONFIG_COMPAT build.
- Fixed size of generation counter
- Fixed selftests to work on non x86 architectures

Christophe Leroy (17):
  asm-generic/unaligned.h: Extract common header for vDSO
  vdso: Clean header inclusion in getrandom
  vdso: Add __arch_get_k_vdso_rng_data()
  vdso: Add missing c-getrandom-y in Makefile
  vdso: Avoid call to memset() by getrandom
  vdso: Change getrandom's generation to unsigned long
  mm: Define VM_DROPPABLE for powerpc/32
  powerpc: Add little endian variants of LWZX_BE and STWX_BE
  powerpc/vdso32: Add crtsavres
  powerpc/vdso: Refactor CFLAGS for CVDSO build
  powerpc/vdso: Wire up getrandom() vDSO implementation
  selftests: vdso: Fix powerpc64 vdso_config
  selftests: vdso: Don't hard-code location of vDSO sources
  selftests: vdso: Make test_vdso_getrandom look for the right vDSO
    function
  selftests: vdso: Fix build of test_vdso_chacha
  selftests: vdso: Make VDSO function call more generic
  selftests: vdso: Add support for vdso_test_random for powerpc

 arch/powerpc/Kconfig                          |   1 +
 arch/powerpc/include/asm/asm-compat.h         |   8 +
 arch/powerpc/include/asm/mman.h               |   2 +-
 arch/powerpc/include/asm/vdso/getrandom.h     |  67 ++++
 arch/powerpc/include/asm/vdso/vsyscall.h      |   6 +
 arch/powerpc/include/asm/vdso_datapage.h      |   2 +
 arch/powerpc/kernel/asm-offsets.c             |   1 +
 arch/powerpc/kernel/vdso/Makefile             |  45 ++-
 arch/powerpc/kernel/vdso/getrandom.S          |  58 ++++
 arch/powerpc/kernel/vdso/gettimeofday.S       |  13 -
 arch/powerpc/kernel/vdso/vdso32.lds.S         |   1 +
 arch/powerpc/kernel/vdso/vdso64.lds.S         |   1 +
 arch/powerpc/kernel/vdso/vgetrandom-chacha.S  | 297 ++++++++++++++++++
 arch/powerpc/kernel/vdso/vgetrandom.c         |  14 +
 arch/x86/entry/vdso/vma.c                     |   3 +
 arch/x86/include/asm/pvclock.h                |   1 +
 arch/x86/include/asm/vdso/vsyscall.h          |  10 +-
 drivers/char/random.c                         |   5 +-
 fs/proc/task_mmu.c                            |   4 +-
 include/asm-generic/unaligned.h               |  11 +-
 include/linux/mm.h                            |   4 +-
 include/trace/events/mmflags.h                |   4 +-
 include/vdso/datapage.h                       |   2 +-
 include/vdso/getrandom.h                      |   2 +-
 include/vdso/helpers.h                        |   1 +
 include/vdso/unaligned.h                      |  15 +
 lib/vdso/Makefile                             |   1 +
 lib/vdso/getrandom.c                          |  30 +-
 tools/arch/powerpc/vdso                       |   1 +
 tools/arch/x86/vdso                           |   1 +
 tools/include/linux/linkage.h                 |   4 +
 tools/testing/selftests/vDSO/Makefile         |  12 +-
 tools/testing/selftests/vDSO/vdso_call.h      |  52 +++
 tools/testing/selftests/vDSO/vdso_config.h    |  14 +-
 .../selftests/vDSO/vdso_test_getrandom.c      |  11 +-
 35 files changed, 628 insertions(+), 76 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/getrandom.h
 create mode 100644 arch/powerpc/kernel/vdso/getrandom.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom-chacha.S
 create mode 100644 arch/powerpc/kernel/vdso/vgetrandom.c
 create mode 100644 include/vdso/unaligned.h
 create mode 120000 tools/arch/powerpc/vdso
 create mode 120000 tools/arch/x86/vdso
 create mode 100644 tools/testing/selftests/vDSO/vdso_call.h

-- 
2.44.0


