Return-Path: <linux-fsdevel+bounces-64469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 470E1BE829C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 949FE58038A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8B032B983;
	Fri, 17 Oct 2025 10:50:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EC5320A3B;
	Fri, 17 Oct 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698253; cv=none; b=QF0pjfCMfsMJMQtwFjKhklzhB4/Kcad8a9PjY5FjuDD9waARCheqedRSdTQsVa08KcX1X2TdpkxBpinrCtR1AXVD0qI+CR4q6+4Kyv0i43Ude0qPcj3ef+wlEatczqoWFkyE+o98aARnfC2qQ0G47I4gJaOzFxssALM2qeA4a+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698253; c=relaxed/simple;
	bh=NGpRihvRGLmZxaUb7q6Kyg1zoqkKk067tACLVGmS4Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZm2LbVRh57nyjRXmeQd7cFy10GtVgB3IOwuvirXxexTxOp8uwQHuThu6niuM+WJDFAOZkiKgBW51EAm9Zg8puBbXMaKKNWahvjD7xA+hACF3XsBukPVgzEbgSkhjmHJVFJe+LgpKMygRlaiM56FiNOFgdtc31td37AXW8KCckk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cp17m0sBZz9sSC;
	Fri, 17 Oct 2025 12:21:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ma1A-_kW4Zjq; Fri, 17 Oct 2025 12:21:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cp17l6vfqz9sS7;
	Fri, 17 Oct 2025 12:21:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D03878B786;
	Fri, 17 Oct 2025 12:21:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id UGiDsfLHLJ0I; Fri, 17 Oct 2025 12:21:23 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A28178B776;
	Fri, 17 Oct 2025 12:21:22 +0200 (CEST)
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
Subject: [PATCH v3 00/10] powerpc: Implement masked user access
Date: Fri, 17 Oct 2025 12:20:56 +0200
Message-ID: <cover.1760529207.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4010; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=NGpRihvRGLmZxaUb7q6Kyg1zoqkKk067tACLVGmS4Z0=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWR8kuhat/+o4e3tgp5tNjx394ivT+xa9eDbmm+PUyqZn IUta/dYdpSyMIhxMciKKbIc/8+9a0bXl9T8qbv0YeawMoEMYeDiFICJaM5lZJjpeWpinm69h/uD SOaEmFJVg/NP3//+LLx0a+I3V8WXt18xMsxzqhEpyjOV21GwfsPh5xfF7zzLP22mMnXRZv2nxeu azDkB
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
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
 arch/powerpc/include/asm/uaccess.h            | 135 +++++++++++++-----
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
 net/core/scm.c                                |   2 +-
 25 files changed, 174 insertions(+), 133 deletions(-)

-- 
2.49.0


