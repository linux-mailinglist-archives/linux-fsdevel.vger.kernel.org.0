Return-Path: <linux-fsdevel+bounces-68753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59374C6540B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 17:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 1580F2907D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41FE2FFDDE;
	Mon, 17 Nov 2025 16:50:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17502FD7CD;
	Mon, 17 Nov 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398246; cv=none; b=PTD/yEJhO6CmIhhBHIWqPduWIcMOktt3eKZyOumIsX2JeT512qvfCAhr3tkj+T30DoC/cOyEHs6ZmFizCPgoai0u/PpiiVV/NNbCxNYtupxhY0ecbhcFdQP6XQk4BwPrXJunuT1wXRdfFnsLkafmQeKGfvB4H8JadbekSKh4bWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398246; c=relaxed/simple;
	bh=WGqKFA3mz9XHJ6cj5G5VuhtGqL7z2AHwH/JWwrDAKcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4bzKaTle3EF/aEIHzTlaqClA/fKrNlMjpASwAq58HeKNhaVeN1gEisCtUr8qqe7qwHVHsmoIxUC8w5UEAEy0YwL9LTkl85vsmrJ0sWSTkEXfHbZWr2MzeK4FF1M3QvtxlS+O17Req3Mo47f7cKjPbH7j3Mk/DzA562QcJu8O88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d9D953HZVz9sSK;
	Mon, 17 Nov 2025 17:44:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iWUAGZWJZEEK; Mon, 17 Nov 2025 17:44:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d9D952NXHz9sS8;
	Mon, 17 Nov 2025 17:44:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CC7E8B769;
	Mon, 17 Nov 2025 17:44:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id TzQbKMy7QXZa; Mon, 17 Nov 2025 17:44:09 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C93EF8B763;
	Mon, 17 Nov 2025 17:44:07 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Ingo Molnar <mingo@redhat.com>,
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
	Nichlas Piggin <npiggin@gmail.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 0/4] uaccess: Prepare for masked user access on powerpc
Date: Mon, 17 Nov 2025 17:43:40 +0100
Message-ID: <cover.1763396724.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3522; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=WGqKFA3mz9XHJ6cj5G5VuhtGqL7z2AHwH/JWwrDAKcU=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWRKB+x//GA1v1ClgdYODW2ZTXLbzU/ZRjV/eKQu6mewe ZpfUUFuRykLgxgXg6yYIsvx/9y7ZnR9Sc2fuksfZg4rE8gQBi5OAZjIrP2MDE+3/HiwSHXz054e sW9T6m8y2UyYrVbctHBZQWh6hr3ILzlGhs8i3SbnnRO3ckQYW04rkjo930th+7PFh0R8ehe170m JYAEA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

This is v5 of the series "powerpc: Implement masked user access". This
version only includes the preparatory patches to enable merging of
powerpc architecture patches that depend on them on next cycle.

It applies on top of commit 6ec821f050e2 (tag: core-scoped-uaccess)
from tip tree.

Thomas, Peter, could you please take those preparatory patches
in tip tree for v6.19, then Maddy will take powerpc patches
into powerpc-next for v6.20.

Masked user access avoids the address/size verification by access_ok().
Allthough its main purpose is to skip the speculation in the
verification of user address and size hence avoid the need of spec
mitigation, it also has the advantage to reduce the amount of
instructions needed so it also benefits to platforms that don't
need speculation mitigation, especially when the size of the copy is
not know at build time.

Patches 1 and 2 are preparing to clean-up some redundant barrier_nospec()
introduced by commit 74e19ef0ff80 ("uaccess: Add speculation barrier
to copy_from_user()"). To do that, a speculation barrier is added to
copy_from_user_iter() so that the barrier in powerpc raw_copy_from_user()
which is redundant with the one in copy_from_user() can be removed. To
avoid impacting x86, copy_from_user_iter() is first converted to using
masked user access.

Patch 3 convert put_cmsg() to scoped user access.

Patch 4 replaces remaining wrong calls to masked_user_access_begin()
with calls to masked_user_read_access_begin() and
masked_user_write_access_begin() to match with user_read_access_end()
and user_write_access_end().

Entire series is availiable at https://git.kernel.org/pub/scm/linux/kernel/git/chleroy/linux branch masked-uaccess

Changes in v5:
- Taken comments from tglx
- Only include core preparatory patches, powerpc patches are kept for following kernel development cycle
- Reworded patch 1 to make it more explicit it needs to come before patch 2
- Added patch 3 to convert put_cmsg() to scoped user access instead of just fixing the direction of the uacess
- Renamed patch 4 as it now only handles fonctions from lib/strn*.c

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

Christophe Leroy (4):
  iov_iter: Convert copy_from_user_iter() to masked user access
  iov_iter: Add missing speculation barrier to copy_from_user_iter()
  scm: Convert put_cmsg() to scoped user access
  lib/strn*,uaccess: Use masked_user_{read/write}_access_begin when
    required

 lib/iov_iter.c          | 22 +++++++++++++++++-----
 lib/strncpy_from_user.c |  2 +-
 lib/strnlen_user.c      |  2 +-
 net/core/scm.c          | 20 +++++++-------------
 4 files changed, 26 insertions(+), 20 deletions(-)

-- 
2.49.0


