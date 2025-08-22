Return-Path: <linux-fsdevel+bounces-58760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD9B3152E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7CC1BA43C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 10:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E0C2D7DC4;
	Fri, 22 Aug 2025 10:20:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BE7291C3F;
	Fri, 22 Aug 2025 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858050; cv=none; b=EJ+IHjfNiHrqxzVRPYFFdCLNjRpPNAv8x2YBxBkiP6HsFxQ+8PUzno0RQ87BAw01fSmp1pbf7THrjonDOre7jc/d0NExVrnxS8SMyf7m5lj+TS5zzeOmFSAIff5HNGgWCqatNZtC4mpXB9dh0hkXqUa9/Fx5xkePru96m4V3x4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858050; c=relaxed/simple;
	bh=XwlsUHUFJUpz+VqDmhFyhZF843JW5vLl0ICFNZPjHwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXdfNvU1CQfQOxYjNzS+I5oo3L+smPNlCmR5UpDkOqo2nt9d8t5znAmWnRTMRG8eNIP45chgKuplnKRHeeq+NO2B/e5I05HV/3prMgA0xp00ohqPB4IJx8hbuuGV7l/DW96Z3y112f0Kg6KJLHYji8ZEgS2nAWQN1jVBA4Tbv4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4c7bGm4MbWz9sSN;
	Fri, 22 Aug 2025 11:58:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1R7C9v1g2tlo; Fri, 22 Aug 2025 11:58:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4c7bGm3cnpz9sSL;
	Fri, 22 Aug 2025 11:58:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 687F58B775;
	Fri, 22 Aug 2025 11:58:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 260MbcVDPASD; Fri, 22 Aug 2025 11:58:08 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 754DD8B781;
	Fri, 22 Aug 2025 11:58:07 +0200 (CEST)
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
Subject: [PATCH v2 02/10] uaccess: Add speculation barrier to copy_from_user_iter()
Date: Fri, 22 Aug 2025 11:57:58 +0200
Message-ID: <82b9c88e63a6f1f5926e39471364168b345d84cc.1755854833.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755854833.git.christophe.leroy@csgroup.eu>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755856678; l=1419; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=XwlsUHUFJUpz+VqDmhFyhZF843JW5vLl0ICFNZPjHwg=; b=OMJi7NtS5t9H8b/LM9QX7LNwGLYVRhm3b1ohh2Ifek1Ac+dVg5W2gO7XbDwDHd3D5fgUdFcH6 CiFpzXB8IzvDR8zy+bYW8ctsDTYL16XT29wlRQ8tKvZye/dJFBYy7QM
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

The results of "access_ok()" can be mis-speculated.  The result is that
you can end speculatively:

	if (access_ok(from, size))
		// Right here

For the same reason as done in copy_from_user() by
commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
copy_from_user()"), add a speculation barrier to copy_from_user_iter().

See commit 74e19ef0ff80 ("uaccess: Add speculation barrier to
copy_from_user()") for more details.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/iov_iter.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 48bd0cbce8c2..8d08b3435174 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -49,11 +49,19 @@ size_t copy_from_user_iter(void __user *iter_from, size_t progress,
 
 	if (should_fail_usercopy())
 		return len;
-	if (can_do_masked_user_access())
+	if (can_do_masked_user_access()) {
 		iter_from = mask_user_address(iter_from);
-	else if (!access_ok(iter_from, len))
-		return res;
+	} else {
+		if (!access_ok(iter_from, len))
+			return res;
 
+		/*
+		 * Ensure that bad access_ok() speculation will not
+		 * lead to nasty side effects *after* the copy is
+		 * finished:
+		 */
+		barrier_nospec();
+	}
 	to += progress;
 	instrument_copy_from_user_before(to, iter_from, len);
 	res = raw_copy_from_user(to, iter_from, len);
-- 
2.49.0


