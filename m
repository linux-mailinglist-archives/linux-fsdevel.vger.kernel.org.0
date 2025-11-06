Return-Path: <linux-fsdevel+bounces-67297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67177C3ABC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 12:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 780A2500937
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD93271E1;
	Thu,  6 Nov 2025 11:50:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDBE31690D;
	Thu,  6 Nov 2025 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429841; cv=none; b=ciogZjCB+PvRB5TBMZ1NmIAXZYpRdhImeWeKMNqi9Kuc7vg6PHiA3Je0qeE+sfTeTFuJVOw+qPpFVa70yYLLIGe5Bgazq136uKIol/kN3oB2FsmTkNoX53/vDBS2Cw3bqPuf1D1G6z++fYHEuvwQW0b2fNG5TVGPlYSGfx9J4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429841; c=relaxed/simple;
	bh=2jZ+xzmq5Is/HiK11WD2Oq0DGl6cQ84EV8xTG8t9Azo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLXH8hlaH97MWY2JimdDyT5kkSFjQGrsBYzoXXakLo37xGZgfwOKt/E5UPACAixTWFvNIz/lr+CfYtDOI3psBKaLBSKgij6EddDGE3WNk87uxdaNEDDBR7tR/T/o2HNfm+l3UUlAIBFcFkKHMbmM9mz3S/t8RtrNXPn2LE349dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d2KmD3Svwz9sS7;
	Thu,  6 Nov 2025 12:32:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cCTQDw47kCCS; Thu,  6 Nov 2025 12:32:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d2KmD2Sndz9sRy;
	Thu,  6 Nov 2025 12:32:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3EAEC8B77E;
	Thu,  6 Nov 2025 12:32:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id N6iiMNbKWsaO; Thu,  6 Nov 2025 12:32:12 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EA078B773;
	Thu,  6 Nov 2025 12:32:11 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Andre Almeida" <andrealmeid@igalia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 00/10] powerpc: Implement masked user access
Date: Thu,  6 Nov 2025 12:31:18 +0100
Message-ID: <cover.1762427933.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4465; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=2jZ+xzmq5Is/HiK11WD2Oq0DGl6cQ84EV8xTG8t9Azo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTytHN/S4vin/Hzpl7wRhb5xCN8od1HtvyfJfLSOF9kp 8O0eVHMHaUsDGJcDLJiiizH/3PvmtH1JTV/6i59mDmsTCBDGLg4BWAiamcYGZ7NOrnD3taXp3nd 1gyPk5Vf7Ft5llTklwqsn7iE5yj35GSG/0Vbenl2sTbdsy5O2hbwfIanX7P+9ynZaclCBwSSnrd 8ZgYA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

This is a rebase on top of commit 6ec821f050e2 (tag: core-scoped-uaccess)
from tip tree.

Thomas, Peter, could you please take non-powerpc patches (1, 2, 3)
in tip tree for v6.19, then Maddy will take powerpc patches (4-10)
into powerpc-next for v6.20.

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

Patch 3 replaces wrong calls to masked_user_access_begin() with calls
to masked_user_read_access_begin() and masked_user_write_access_begin()
to match with user_read_access_end() and user_write_access_end().

Patches 5,6,7 are cleaning up powerpc uaccess functions.

Patches 8 and 9 prepare powerpc/32 for the necessary gap at the top
of userspace.

Last patch implements masked user access.

Changes in v4:
- Rebased on top of commit 6ec821f050e2 (tag: core-scoped-uaccess) from tip tree
- Patch 3: Simplified as masked_user_read_access_begin() and masked_user_write_access_begin() are already there.
- Patch 10: Simplified mask_user_address_simple() as suggested by Gabriel.

Changes in v3:
- Rebased on top of v6.18-rc1
- Patch 3: Impact on recently modified net/core/scm.c
- Patch 10: Rewrite mask_user_address_simple() for a smaller result on powerpc64, suggested by Gabriel

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
  uaccess: Use masked_user_{read/write}_access_begin when required
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
 arch/powerpc/include/asm/uaccess.h            | 132 +++++++++++++-----
 arch/powerpc/kernel/asm-offsets.c             |   2 +-
 arch/powerpc/kernel/head_book3s_32.S          |   6 +-
 arch/powerpc/mm/book3s32/mmu.c                |   4 +-
 arch/powerpc/mm/mem.c                         |   2 -
 arch/powerpc/mm/nohash/8xx.c                  |   2 -
 arch/powerpc/mm/ptdump/segment_regs.c         |   2 +-
 lib/iov_iter.c                                |  22 ++-
 lib/strncpy_from_user.c                       |   2 +-
 lib/strnlen_user.c                            |   2 +-
 net/core/scm.c                                |   2 +-
 22 files changed, 161 insertions(+), 130 deletions(-)

-- 
2.49.0


