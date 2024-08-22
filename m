Return-Path: <linux-fsdevel+bounces-26671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF60D95AEBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B72E1F24FEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FED183092;
	Thu, 22 Aug 2024 07:14:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0417E01A;
	Thu, 22 Aug 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310846; cv=none; b=LLT9MgZ7GrwjkZo9esxNXjAX85iQInbFeLh/C4n54wO66kGj6LVoZqkk7yoc4XRGG2KD9aOw6XEZOV51YiU/DfYOuVqvGtfbGyIRBg3+wCI09sHRYWBBjNeBCwLqSy9TL5oV9B62CrDg9VvsAI4OJzh101PDKTWoBXpwTrSYzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310846; c=relaxed/simple;
	bh=6H7T4OtghNGIKLYUW15IDF5ngiuRyCUv+bUYaWIueQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG9D7Wx0d4QfT+xrwYeVBBD7SkYqYnAh5j4KI30FnKfU7iMP1WBtn5BpZjdH6SYq1p0esf/U6bBFtoBoMiLO5NdIp3BiCgv2xtNiIun7RLdnJt6m9IVQWCdQikvZsyl988F3XSng3alPrvTak0vBmPbfIQjkdon25byuxNi2egI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDvH1Lg0z9sSY;
	Thu, 22 Aug 2024 09:13:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HrgTAL98uEO3; Thu, 22 Aug 2024 09:13:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDvH0Z6sz9sSH;
	Thu, 22 Aug 2024 09:13:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 018F68B77D;
	Thu, 22 Aug 2024 09:13:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4Xoul67SwRYa; Thu, 22 Aug 2024 09:13:30 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EC72A8B763;
	Thu, 22 Aug 2024 09:13:29 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 08/17] powerpc: Add little endian variants of LWZX_BE and STWX_BE
Date: Thu, 22 Aug 2024 09:13:16 +0200
Message-ID: <cea04e5b971c959d823682e1e338c5c40d134f0c.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310794; l=906; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=6H7T4OtghNGIKLYUW15IDF5ngiuRyCUv+bUYaWIueQo=; b=hNY+LGr2Rcm1FruX/Pi4TXpEpJ3NK0USBgOJB07umxT2MU3l11Qrgf0kRkvOEtaehX9BImGb3 aPlCV4CucUaA5+VROpxaJP9JVn4u1j8nncN+Akg3rm5xpKRsYhQxEMu
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

To support getrandom in VDSO which is based on little endian storage,
add macros equivalent to LWZX_BE and STWX_BE for little endian
accesses.

Put them outside of __powerpc64__ #ifdef so that they can also be used
for PPC32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/asm-compat.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 2bc53c646ccd..6e53a80917ef 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -61,4 +61,12 @@
 
 #endif
 
+#ifdef __BIG_ENDIAN__
+#define LWZX_LE	stringify_in_c(lwbrx)
+#define STWX_LE	stringify_in_c(stwbrx)
+#else
+#define LWZX_LE	stringify_in_c(lwzx)
+#define STWX_LE	stringify_in_c(stwx)
+#endif
+
 #endif /* _ASM_POWERPC_ASM_COMPAT_H */
-- 
2.44.0


