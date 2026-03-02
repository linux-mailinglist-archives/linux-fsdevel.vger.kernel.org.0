Return-Path: <linux-fsdevel+bounces-78899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGVhLzSRpWmoDgYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:31:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 374581D9CC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 14:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C3513064CCF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6303F23AC;
	Mon,  2 Mar 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="pfYMBjDr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034E3346AD;
	Mon,  2 Mar 2026 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458131; cv=none; b=bTJEPPzZVHH3qBrzApwsRbYQwi8c2cteM5XeE2GQ7CYWqjld25UdhUXyWZSvKlvN6TDImnFJFzOBnY/RNUyI7cLPACWtppnPtcgyngRqKfCKvK9JEWoMpjFaSEFfsNl5UESmEdbUo/iLBOy+1shtlSm/y32TwgIJB3sksUwFrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458131; c=relaxed/simple;
	bh=/vw1o/tgaqgXlymwWBfNq0gtWd8qwqkw++waY5+/oWo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shbsRoCRMfdXnziC/NzqGtgzuCVaMbvSrTSeFN6X1X3yAwEV/K9CzSJBBx6zTmWcsDfQgkmoeESoEl3T9nwTt1N5sDbyS8vw8yEWqJJEFQlX7b+24kzRUwBGZOu4txG3fv3uNNDwcKInK1diIdZubSCMklZMNNOwGpHXTt5irh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=pfYMBjDr; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jw-003ZE4-Au; Mon, 02 Mar 2026 14:28:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:To:From;
	bh=7cjIEqDAe6MTPa2yql8v8L5e7mjA+roV54bcD0Te3Y4=; b=pfYMBjDrxtDGIuseYyHfRKhdlY
	wxGF1P6KMNx6ObRuGN6ZC4wsAsw2hRQ/moIf5DlPtJ4OdcFDVbbZfYlXOaHjFV7UCzwT+RFpEzmxH
	qWXXDA4ONYMAsNi6ePJIKCLTLb8MT74QJNuqJ6sdh6Tq/4chxS0eBiQlHuCMuynNI3HaM4H+mIWD+
	MfMF3aDGj96f3wG2XdkXTZREX71lpkYTiXzClo5Rgz07oqNqD1x1j5Sva9T4TMi13zMpJPrbafMuY
	y2tpwibHn24xe00sD61gejFnTEEHP9CDzwhRxR2Z0zEadqZouQs+4eZ2DS+v9eN8M5kbcQczC3zdl
	N7bMTDQg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vx3Jv-0003tI-NG; Mon, 02 Mar 2026 14:28:23 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vx3Ji-008UTR-OY; Mon, 02 Mar 2026 14:28:10 +0100
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
Subject: [PATCH v2 3/5] uaccess.h: Use with() and and_with() in __scoped_user_access()
Date: Mon,  2 Mar 2026 13:27:53 +0000
Message-Id: <20260302132755.1475451-4-david.laight.linux@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-78899-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 374581D9CC2
X-Rspamd-Action: no action

From: David Laight <david.laight.linux@gmail.com>

Wrappers for autoterminating nested for() loops have been added to
compiler.h, use them to hide the gory details.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 include/linux/uaccess.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 809e4f7dfdbd..64bc2492eb99 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -736,13 +736,10 @@ static __always_inline void __scoped_user_rw_access_end(const void *p)
  *
  * Don't use directly. Use scoped_masked_user_$MODE_access() instead.
  */
-#define __scoped_user_access(mode, uptr, size, elbl)				\
-for (bool done = false; !done; done = true)					\
-	for (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl);	\
-	     !done; done = true)						\
-		/* Force modified pointer usage within the scope */		\
-		for (const auto uptr  __cleanup(__scoped_user_##mode##_access_end) = \
-		     _tmpptr; !done; done = true)
+#define __scoped_user_access(mode, uptr, size, elbl)					\
+	with (auto _tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl))	\
+		/* Force modified pointer usage within the scope */			\
+		and_with (const auto uptr __cleanup(__scoped_user_##mode##_access_end) = _tmpptr)
 
 /**
  * scoped_user_read_access_size - Start a scoped user read access with given size
-- 
2.39.5


