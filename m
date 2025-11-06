Return-Path: <linux-fsdevel+bounces-67298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9629C3AC01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF373A8B23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718BE328602;
	Thu,  6 Nov 2025 11:50:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C0B3101DC;
	Thu,  6 Nov 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429846; cv=none; b=nW22boax026XFxT1lgSbPpsFOxdbSaZWLhHlI+JOCd8WfZfWx/DDUUM5cv+G7Ky6teQGJIuf6hijO+vbQtPMSI6qC7F9U5iMCiny3QYv0rturRyWI4lhcA0BLsqTjfoBZmkIkSu5zjVjJGOmeoUkQCh8D8lzM7BxtxPEWlNX1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429846; c=relaxed/simple;
	bh=W82BJoxsF/uaSl8+888M/Hm7CO4JVyWj0vi85xuDhyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=turtuIv8Ss0w+QnM0C5a10UB4+ImmffHyYiFYo7mu83butGcfFhzVduN7s+bnYwEnIA4qfGsVPd9/3fy/ZfHwIKmtXwCyxY9Ah6mAfj4YQJklQhfS+Giy73KH0LdMahBw4lcbiJFkJ+4EynivMc8Z1EZgVQUIny5lmPJkBdkW+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d2KmG0g3gz9sSN;
	Thu,  6 Nov 2025 12:32:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kumAkxYI07Um; Thu,  6 Nov 2025 12:32:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d2KmF6QcGz9sSL;
	Thu,  6 Nov 2025 12:32:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C72008B773;
	Thu,  6 Nov 2025 12:32:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Uo2LeIc8mkPM; Thu,  6 Nov 2025 12:32:13 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 05BB88B77E;
	Thu,  6 Nov 2025 12:32:12 +0100 (CET)
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
Subject: [PATCH v4 02/10] uaccess: Add speculation barrier to copy_from_user_iter()
Date: Thu,  6 Nov 2025 12:31:20 +0100
Message-ID: <598e9ec31716ce351f1456c81eee140477d4ecc4.1762427933.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1762427933.git.christophe.leroy@csgroup.eu>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=W82BJoxsF/uaSl8+888M/Hm7CO4JVyWj0vi85xuDhyA=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTytGve97+tP2FVN7v3eoEWN4s9bSpm+1+6PJ2l/vDvq t8873PdOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBELs1m+MPztej3jq2bH5ja rG9ssJMyjNktePpbi6LdgvWW2ft+zprE8M8scqPoI/46Z6HHk5kvRPc/uKp9c+OTpLgnTOEXlju 6O3MDAA==
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
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
index a589935bf3025..896760bad455f 100644
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


