Return-Path: <linux-fsdevel+bounces-52389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4226DAE2F52
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 12:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933E03AED9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 10:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247761CAA7D;
	Sun, 22 Jun 2025 10:20:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205B11422AB;
	Sun, 22 Jun 2025 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750587636; cv=none; b=fLN7i4BdVzL+UoPwMMxz0iYh44Aacvgw+n2GZoX91yUnF5yLW0650P+m4nFuseqXBXmjEMsUGHOtPeiGGOgSA0sMe653M20yYHuFK9BAMSqmTZfN5ooHGoUfRwDQBkf954T/HJcnvJCbkP5VsOaVg9Y0j6VpvpokrKCQpxBfWRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750587636; c=relaxed/simple;
	bh=UYxQJS6ZJHCmE3zbSwM0x0YAEUS01DTZiXJZEvopO2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4gaoou2pGk97zYSIgdAyBQ7pTpxAcEGkE5e4AZxdGixCA8RPzuHw2FUFFASAp3I1y81bH1VgbrqP7QWyBtnO2x4uopd2XSrVpn9PFu/vRTVgUG7Sk3w8r6JOxsDVYBOSHXmp/dfCdMRLaj1xUN4pFpwjLt98k1M3FIkZxekMtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bQ62q2tJCz9sbF;
	Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OYHyRMeMBap9; Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bQ62q20ksz9sXD;
	Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CD248B764;
	Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ItRVmE4jH7_E; Sun, 22 Jun 2025 11:52:51 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E5C18B763;
	Sun, 22 Jun 2025 11:52:50 +0200 (CEST)
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
Subject: [PATCH 2/5] uaccess: Add speculation barrier to copy_from_user_iter()
Date: Sun, 22 Jun 2025 11:52:40 +0200
Message-ID: <f4b2a32853b5daba7aeac9e9b96ec1ab88981589.1750585239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750585239.git.christophe.leroy@csgroup.eu>
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750585958; l=1183; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=UYxQJS6ZJHCmE3zbSwM0x0YAEUS01DTZiXJZEvopO2E=; b=CZDMdcFmnufRcPRhMzoZv84scqPZFsLBFe6GrnY1YvrDPqC/h/DYWJVikSKeIb35hKqIXPgrn /bJG+wBOUX6CLrIA00TjhTQhNdgXy5elmLQw6y5gHEPFOZkqvKJl1vx
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
 lib/iov_iter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f49..ebf524a37907 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -50,6 +50,13 @@ size_t copy_from_user_iter(void __user *iter_from, size_t progress,
 	if (should_fail_usercopy())
 		return len;
 	if (access_ok(iter_from, len)) {
+		/*
+		 * Ensure that bad access_ok() speculation will not
+		 * lead to nasty side effects *after* the copy is
+		 * finished:
+		 */
+		barrier_nospec();
+
 		to += progress;
 		instrument_copy_from_user_before(to, iter_from, len);
 		res = raw_copy_from_user(to, iter_from, len);
-- 
2.49.0


