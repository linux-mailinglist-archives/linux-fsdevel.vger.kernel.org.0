Return-Path: <linux-fsdevel+bounces-64459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E74F4BE822A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 12:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56085567354
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 10:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840FF32038D;
	Fri, 17 Oct 2025 10:50:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD62031D73F;
	Fri, 17 Oct 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698211; cv=none; b=E14bBN5Mx/S2xqnCACcaVFRyQpGkFfzufHEUPlRqywfeopvscfFqato146MsRXzjumuA3lNi04ONFzazvSCof2NTf/JxW9EHkcjMO3SodIQGZWEJDNgPWfojAFWMxewqIWLWfrnujb2U7UX3L24m7sAV40UWWsFPwtAoFSnzt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698211; c=relaxed/simple;
	bh=CInTZPEi9ILbXu4UpfN2lm4dHyQfqcOZ4rC45zzBAr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/E7cOXIlvBavSDMfA2KDZDgjhSQJFdSDPmo69pdzBWIdtmUYay+bJCq8xUk90DUCAUMgGNp6vzm7kzZePRb3TXXA7942+KfHxC32TmVC0pr5RTQP63ZDwBs40689nXFOUgw3P+JlS6Vm3Jg/e5d2FC7O7VAYABL/0Uil2r9u3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cp17n17Mlz9sSK;
	Fri, 17 Oct 2025 12:21:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kRVCKsionrA6; Fri, 17 Oct 2025 12:21:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cp17n0Pcsz9sSH;
	Fri, 17 Oct 2025 12:21:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E3A848B776;
	Fri, 17 Oct 2025 12:21:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Jnja7wOONEjS; Fri, 17 Oct 2025 12:21:24 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C5C1F8B780;
	Fri, 17 Oct 2025 12:21:23 +0200 (CEST)
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
Subject: [PATCH v3 01/10] iter: Avoid barrier_nospec() in copy_from_user_iter()
Date: Fri, 17 Oct 2025 12:20:57 +0200
Message-ID: <09c7c1c9515a2c0b2e1a059a4a5e32a9afe31704.1760529207.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760529207.git.christophe.leroy@csgroup.eu>
References: <cover.1760529207.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326; i=christophe.leroy@csgroup.eu; h=from:subject:message-id; bh=CInTZPEi9ILbXu4UpfN2lm4dHyQfqcOZ4rC45zzBAr0=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWR8kpjkJLj5Jud2ppKEBQcSri1LDDpe3F0ocnlh7mMLJ pMQjqk7OkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBEulYz/OHjur5ulURd7NlJ Zhtvq0ZmLne5e+yarr2/0I3kMzKOzh8Y/ucIVFowKD2e8P3YR+XNpks2pjIfUDy1dN/PWbYNG1W 3P+UGAA==
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


