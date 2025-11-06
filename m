Return-Path: <linux-fsdevel+bounces-67294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1BC3ABB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 12:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CADE1A48333
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2A231D732;
	Thu,  6 Nov 2025 11:50:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8331C584;
	Thu,  6 Nov 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429827; cv=none; b=AaZCy6QILGeT+sGNfxITOk5M2o3XKCUEzSoC8fyYCfOiBNqNw5y7up2bTL7tK9w8yrUK9rmXkpTq2FL+0BQFNxjZENzhfy7+wMG5JljFVOt9xYK7M3eKGA4M6mLN/ZZqWMjIM5+eZ3ouo6mSmrYhu7NBSdumTit/roiD8BLBgdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429827; c=relaxed/simple;
	bh=CInTZPEi9ILbXu4UpfN2lm4dHyQfqcOZ4rC45zzBAr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlONuJfgefjCU1UvQkXPoVcwbe3bz1sonqP0sdtxN/buLJ6UwHFSgqHKzic/KK6HbqFrVsrxT9NM92CVYD0IrfxxQcxARjIMKrec+p1SDNv/3wENCErPFdyW6Yibri6btap82vfa4sD0h/wgV3MkFpC9VUY4QNIfvCaXgzN06cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4d2KmF1dFkz9sS8;
	Thu,  6 Nov 2025 12:32:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 343GnQeFijfY; Thu,  6 Nov 2025 12:32:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4d2KmF0qPPz9sRy;
	Thu,  6 Nov 2025 12:32:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 03FE98B773;
	Thu,  6 Nov 2025 12:32:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 5UWr0kMelD5U; Thu,  6 Nov 2025 12:32:12 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3723C8B77B;
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
Subject: [PATCH v4 01/10] iter: Avoid barrier_nospec() in copy_from_user_iter()
Date: Thu,  6 Nov 2025 12:31:19 +0100
Message-ID: <1c3b7384c5231dff292a3d447e0bfafa61015d64.1762427933.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1762427933.git.christophe.leroy@csgroup.eu>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=CInTZPEi9ILbXu4UpfN2lm4dHyQfqcOZ4rC45zzBAr0=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWTytGvuVHhy9KbbDsPkpU2r9d8dfDpFfuKFsmQW9hDDq 7e3FvL/6ShlYRDjYpAVU2Q5/p9714yuL6n5U3fpw8xhZQIZwsDFKQATmZ3D8L9C6W/6lK8J3p37 lbyv2GhNrn45dU+58XqlPZUHVdpNs8UY/tmG9ys7NYupMV914dmx7f0fh8UnP02okW3kXffjuZD ZP0YA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Following patch will add missing barrier_nospec() to
copy_from_user_iter().

Avoid it for architectures supporting masked user
accesses, the same way as done for copy_from_user() by
commit 0fc810ae3ae1 ("x86/uaccess: Avoid barrier_nospec()
in 64-bit copy_from_user()")

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: New in v2
---
 lib/iov_iter.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2fe66a6b8789e..a589935bf3025 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -49,12 +49,16 @@ size_t copy_from_user_iter(void __user *iter_from, size_t progress,
 
 	if (should_fail_usercopy())
 		return len;
-	if (access_ok(iter_from, len)) {
-		to += progress;
-		instrument_copy_from_user_before(to, iter_from, len);
-		res = raw_copy_from_user(to, iter_from, len);
-		instrument_copy_from_user_after(to, iter_from, len, res);
-	}
+	if (can_do_masked_user_access())
+		iter_from = mask_user_address(iter_from);
+	else if (!access_ok(iter_from, len))
+		return res;
+
+	to += progress;
+	instrument_copy_from_user_before(to, iter_from, len);
+	res = raw_copy_from_user(to, iter_from, len);
+	instrument_copy_from_user_after(to, iter_from, len, res);
+
 	return res;
 }
 
-- 
2.49.0


