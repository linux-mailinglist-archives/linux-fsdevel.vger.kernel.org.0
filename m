Return-Path: <linux-fsdevel+bounces-52390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 658E5AE2F55
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205FA18927FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0B1D63C5;
	Sun, 22 Jun 2025 10:20:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3D51422AB;
	Sun, 22 Jun 2025 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750587640; cv=none; b=pxEnSG9Lptp3i6OrCIRNpmDN4C2nFsNQW1Xg8j4wMKg8D5jBvxK3v6sKkywvV+G9nDYsEQRYqdUiosDmbotMeoHT8XrQmEI7ZD5frCbI5QCu2/ehEsczQclE9SHqULrTjJY6ewXkGTgrQ3Cij08GBwH9Aio4gihSpD+SJ48LUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750587640; c=relaxed/simple;
	bh=HySJmJimN0Mbor6aO2XQhe3eawUJ2DpD2MDAE2rsTBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3/YrTDGvGEX+vD4wdm3XF7tLG6j+VK1TjmI8Q+uQeEnDof8jmztxfNNN5LkH2QBAPiKT+6qK/viZP5CF0qe84RcmVlBzYOnYq/TT5/fqJfoBXnqhKOZbUJLZu9JiC6NZ1YULHlfH6u3oaZeJV/7eKXCoSTvEoI1aaFfeV3VHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bQ62n4sxNz9sWb;
	Sun, 22 Jun 2025 11:52:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pIyFw4tvJjvf; Sun, 22 Jun 2025 11:52:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bQ62n3Qplz9sTD;
	Sun, 22 Jun 2025 11:52:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6704E8B765;
	Sun, 22 Jun 2025 11:52:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SWopfc0YWtyj; Sun, 22 Jun 2025 11:52:49 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 6A6848B763;
	Sun, 22 Jun 2025 11:52:48 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
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
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] powerpc: Implement masked user access
Date: Sun, 22 Jun 2025 11:52:38 +0200
Message-ID: <cover.1750585239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750585958; l=2465; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=HySJmJimN0Mbor6aO2XQhe3eawUJ2DpD2MDAE2rsTBw=; b=avw+yxifZez04tL6hY4uI10f64fY7knh0RlaYqBAin24xTC5w1XQBwEkR2nEsI8dapqkvp3tb 3bSsrPI4uwKB/yFAZpo4xgJKt+m/LB7sfSbDkCIdrD3prqpxjkg79xc
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Masked user access avoids the address/size verification by access_ok().
Allthough its main purpose is to skip the speculation in the
verification of user address and size hence avoid the need of spec
mitigation, it also has the advantage to reduce the amount of
instructions needed so it also benefits to platforms that don't
need speculation mitigation, especially when the size of the copy is
not know at build time.

Unlike x86_64 which masks the address to 'all bits set' when the
user address is invalid, here the address is set to an address in
the gap. It avoids relying on the zero page to catch offseted
accesses. On book3s/32 it makes sure the opening remains on user
segment. The overcost is a single instruction in the masking.

First patch adds masked_user_read_access_begin() and
masked_user_write_access_begin() to match with user_read_access_end()
and user_write_access_end().

Second patch adds speculation barrier to copy_from_user_iter() so that
the barrier in powerpc raw_copy_from_user() which is redundant with
the one in copy_from_user() can be removed.

Third patch removes the redundant barrier_nospec() in
raw_copy_from_user().

Fourth patch removes the unused size parameter when enabling/disabling
user access.

Last patch implements masked user access.

Christophe Leroy (5):
  uaccess: Add masked_user_{read/write}_access_begin
  uaccess: Add speculation barrier to copy_from_user_iter()
  powerpc: Remove unused size parametre to KUAP enabling/disabling
    functions
  powerpc: Move barrier_nospec() out of allow_read_{from/write}_user()
  powerpc: Implement masked user access

 arch/powerpc/Kconfig                         |   2 +-
 arch/powerpc/include/asm/book3s/32/kup.h     |   2 +-
 arch/powerpc/include/asm/book3s/64/kup.h     |   4 +-
 arch/powerpc/include/asm/kup.h               |  24 ++--
 arch/powerpc/include/asm/nohash/32/kup-8xx.h |   2 +-
 arch/powerpc/include/asm/nohash/kup-booke.h  |   2 +-
 arch/powerpc/include/asm/uaccess.h           | 140 ++++++++++++++++---
 fs/select.c                                  |   2 +-
 include/linux/uaccess.h                      |   8 ++
 kernel/futex/futex.h                         |   4 +-
 lib/iov_iter.c                               |   7 +
 lib/strncpy_from_user.c                      |   2 +-
 lib/strnlen_user.c                           |   2 +-
 13 files changed, 158 insertions(+), 43 deletions(-)

-- 
2.49.0


