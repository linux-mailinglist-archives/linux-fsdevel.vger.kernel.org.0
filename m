Return-Path: <linux-fsdevel+bounces-58767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF3B3153D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2151CE5DAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953B62D3EE3;
	Fri, 22 Aug 2025 10:21:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FDD2F872;
	Fri, 22 Aug 2025 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858084; cv=none; b=ZpIoN/fYP2bAwCsDp4mRcLNNS/6VAN+CMlESsuI0j2a3lkI8MSK293oiKv1AxYBLjFqvCsxTnPdwHLzd7nMHwHh/NQNIeMlR4aT+Yqt3FtyiuFsJgZ30eMgYeIB/DLDtZDfs3mVorceh2QPrQbirJ4r0hFF0qpT9EmngdFZeZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858084; c=relaxed/simple;
	bh=/phN/AgtMsLAd6ka2rRe1+fTTKRpm5UtXySxy3tBMG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ACaVQdkPgSVEQZKgPmQA+ZTMUIFjxXW/VypnAE/lkqbZRne3w3qeygvP8DhKmDUTL1UkjWl84vN43uVD4xDJSJp5ol2FSzQU+vSMU7XgAEveCD3rsZqBXEqYz2EVh3LvafRJFXsVVjqAQ7XeZvEsUvAtLD6HZ/Vlif/Dr+SK68E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c7bGk5BLBz9sS8;
	Fri, 22 Aug 2025 11:58:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IWDZVwqsS1ox; Fri, 22 Aug 2025 11:58:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c7bGk4BThz9sRs;
	Fri, 22 Aug 2025 11:58:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BEF38B781;
	Fri, 22 Aug 2025 11:58:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id eIHQVHg49t7f; Fri, 22 Aug 2025 11:58:06 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6BEC98B775;
	Fri, 22 Aug 2025 11:58:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Andre Almeida" <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: [PATCH v2 00/10] powerpc: Implement masked user access
Date: Fri, 22 Aug 2025 11:57:56 +0200
Message-ID: <cover.1755854833.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755856678; l=3745; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=/phN/AgtMsLAd6ka2rRe1+fTTKRpm5UtXySxy3tBMG8=; b=1V9AFEKpjDyk6FnUrGnkLYoDWwBrkQcqv5fCGwg429FpoGvEzmMQhX1fRZY0SIQqSAI16OrRi R6sNAdKx0x1A+t4how5qZX/b5neGHfNC9U+6+4eTmM1L60Bhm6fz49y
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Masked user access avoids the address/size verification by access_ok().
Allthough its main purpose is to skip the speculation in the
verification of user address and size hence avoid the need of spec
mitigation, it also has the advantage to reduce the amount of
instructions needed so it also benefits to platforms that don't
need speculation mitigation, especially when the size of the copy is
not know at build time.

Patches 1,2,4 are cleaning up some redundant barrier_nospec()
introduced by commit 74e19ef0ff80 ("uaccess: Add speculation barrier
to copy_from_user()"). To do that, a speculation barrier is added to
copy_from_user_iter() so that the barrier in powerpc raw_copy_from_user()
which is redundant with the one in copy_from_user() can be removed. To
avoid impacting x86, copy_from_user_iter() is first converted to using
masked user access.

Patch 3 adds masked_user_read_access_begin() and
masked_user_write_access_begin() to match with user_read_access_end()
and user_write_access_end().

Patches 5,6,7 are cleaning up powerpc uaccess functions.

Patches 8 and 9 prepare powerpc/32 for the necessary gap at the top
of userspace.

Last patch implements masked user access.

Changes in v2:
- Converted copy_from_user_iter() to using masked user access.
- Cleaned up powerpc uaccess function to minimise code duplication
when adding masked user access
- Automated TASK_SIZE calculation to minimise use of BUILD_BUG_ON()
- Tried to make some commit messages more clean based on feedback from
version 1 of the series.

Christophe Leroy (10):
  iter: Avoid barrier_nospec() in copy_from_user_iter()
  uaccess: Add speculation barrier to copy_from_user_iter()
  uaccess: Add masked_user_{read/write}_access_begin
  powerpc/uaccess: Move barrier_nospec() out of
    allow_read_{from/write}_user()
  powerpc/uaccess: Remove unused size and from parameters from
    allow_access_user()
  powerpc/uaccess: Remove
    {allow/prevent}_{read/write/read_write}_{from/to/}_user()
  powerpc/uaccess: Refactor user_{read/write/}_access_begin()
  powerpc/32s: Fix segments setup when TASK_SIZE is not a multiple of
    256M
  powerpc/32: Automatically adapt TASK_SIZE based on constraints
  powerpc/uaccess: Implement masked user access

 arch/powerpc/Kconfig                          |   3 +-
 arch/powerpc/include/asm/barrier.h            |   2 +-
 arch/powerpc/include/asm/book3s/32/kup.h      |   3 +-
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |   5 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h  |   4 -
 arch/powerpc/include/asm/book3s/64/kup.h      |   6 +-
 arch/powerpc/include/asm/kup.h                |  52 +------
 arch/powerpc/include/asm/nohash/32/kup-8xx.h  |   3 +-
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |   4 -
 arch/powerpc/include/asm/nohash/kup-booke.h   |   3 +-
 arch/powerpc/include/asm/task_size_32.h       |  28 +++-
 arch/powerpc/include/asm/uaccess.h            | 134 +++++++++++++-----
 arch/powerpc/kernel/asm-offsets.c             |   2 +-
 arch/powerpc/kernel/head_book3s_32.S          |   6 +-
 arch/powerpc/mm/book3s32/mmu.c                |   4 +-
 arch/powerpc/mm/mem.c                         |   2 -
 arch/powerpc/mm/nohash/8xx.c                  |   2 -
 arch/powerpc/mm/ptdump/segment_regs.c         |   2 +-
 fs/select.c                                   |   2 +-
 include/linux/uaccess.h                       |   7 +
 kernel/futex/futex.h                          |   4 +-
 lib/iov_iter.c                                |  22 ++-
 lib/strncpy_from_user.c                       |   2 +-
 lib/strnlen_user.c                            |   2 +-
 24 files changed, 172 insertions(+), 132 deletions(-)

-- 
2.49.0


