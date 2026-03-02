Return-Path: <linux-fsdevel+bounces-78900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iENQG0GRpWmoDgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:31:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D06C91D9CD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4514A3067847
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E7B3F23C5;
	Mon,  2 Mar 2026 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="dr2IYEGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADCE37701A;
	Mon,  2 Mar 2026 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458132; cv=none; b=Ao49kKEBRSgDMXiwa8dOOP32xFlbD4YvfryNcoAhfr4GMawzi4ijhKsexHkMeC7LIeQSQf9BtWxdV8pJfSApkAoE/xMhezh69QGcHGRFacVkf2DlVorK8+lJRBO2CodClm7hPNvs6lZmZS3cM+8To4w+blHLOpaecf9bcKz1wZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458132; c=relaxed/simple;
	bh=IATyzkK6xWW9YiXL0DIDlHPO2PCygJ/MYODtpq9Z3Ms=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=el9IiXC5VJ7X1bT7CqA7wPnBrmK45PUJJci7bCXJxMdv6k9jU7oyTBO2Z80GKByiYDzQHCFciT/kwIV2mJTHy+6aPVFs5UozkrTGj0Yys4i1ECiI4wXcXNvQ0mOAMNxNK2GXXNcHpcbbbFqJ0sGCaXCX7s1Y53NrBa3Aw4i9XRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=dr2IYEGX; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jv-003ZDi-SM; Mon, 02 Mar 2026 14:28:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:To:From;
	bh=D3P/KaCqbTVRLW734Le3jm//dWEzoj6aOdRHjsDkHB0=; b=dr2IYEGXpLn70YtwZCSevHlElv
	/BDRdlUO4zDGofnTsHi42LvbEdi3VipTLE3qO2jms6/GGfUGILr2ElGxq76Qqa1IVjSRbEvOAc1Ro
	pNaEyMGT7NC4B24epdTZtJNVCwBM3fXGAKN7d+4ezQMOiK4oex69VUMtEUOAjx+EPd5g+ct38316h
	qxQXAxcAiiKRb6oyp9RzKKLymdA7Gx+8gSGQAGBZIzLD4BxE+G55Ccnmk/qMfgl9N6JGa4es8sujn
	nzOnVNpMKlbluysxX5nsv82z0JQ/qI/Tt/bJCX331CVLx9DxsrepkWNzyJUPNhYsRNbEfHp1c25Sv
	5z427ECQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jv-0001hG-7S; Mon, 02 Mar 2026 14:28:23 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Jh-008UTR-Jt; Mon, 02 Mar 2026 14:28:09 +0100
From: david.laight.linux@gmail.com
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andre Almeida <andrealmeid@igalia.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Darren Hart <dvhart@infradead.org>,
	David Laight <david.laight.linux@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	Kees Cook <kees@kernel.org>,
	akpm@linux-foundation.org
Subject: [PATCH v2 2/5] compiler.h: Add generic support for 'autoterminating nested for() loops'
Date: Mon,  2 Mar 2026 13:27:52 +0000
Message-Id: <20260302132755.1475451-3-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302132755.1475451-1-david.laight.linux@gmail.com>
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78900-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,igalia.com,citrix.com,linux.ibm.com,kernel.org,csgroup.eu,infradead.org,gmail.com,stgolabs.net,suse.cz,inria.fr,linux-foundation.org,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,efficios.com,ellerman.id.au,imag.fr,dabbelt.com,armlinux.org.uk,linutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	DKIM_TRACE(0.00)[runbox.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D06C91D9CD0
X-Rspamd-Action: no action

From: David Laight <david.laight.linux@gmail.com>

Autoterminating nested for() loops can be used inside #defines to
declare variables that are scoped to the statement that follows.
These are used by __scoped_user_access() but may have other uses
and the gory details are best separated from the use.

Using 'with (declaration)' and 'and_with (declaration)' seems to
read reasonably well and doesn't seem to collide with any existing
code.

As an example the scoped user access definition becomes:
	with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl)) \
		/* Force modified pointer usage within the scope */		\
		and_with (const auto uptr __cleanup(...) = _tmpptr)

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/compiler.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index af16624b29fd..1098a91b5591 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -369,6 +369,32 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define prevent_tail_call_optimization()	mb()
 
+/*
+ * Sometimes a #define needs to declare a variable that is scoped
+ * to the statement that follows without having mismatched {}.
+ *	with (int x = expression) {
+ *		statements
+ *	}
+ * is the same as:
+ *	{
+ *		int x = expression;
+ *		statements
+ *	}
+ * but lets it all be hidden from the call site, eg:
+ *	frobnicate(x, args) {
+ *		statements
+ *	} 
+ * Only a single variable can be defined, and_with() allows extra ones
+ * without adding an additional outer loop.
+ *
+ * The controlled scope can be terminated using return, break, continue or goto.
+ */
+#define with(declaration) \
+	for (bool _with_done = false; !_with_done; _with_done = true)	\
+		and_with (declaration)
+#define and_with(declaration) \
+	for (declaration; !_with_done; _with_done = true)
+
 #include <asm/rwonce.h>
 
 #endif /* __LINUX_COMPILER_H */
-- 
2.39.5


