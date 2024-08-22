Return-Path: <linux-fsdevel+bounces-26669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECDC95AEA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD301F249F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABD917DFE8;
	Thu, 22 Aug 2024 07:13:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B6917CA1F;
	Thu, 22 Aug 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310837; cv=none; b=mPsyv3SIngb/JgF8IPryaUzEuHuoxdY952kP77u5A5kwno+JPPX1geFZ0e+PRI69m7XbZf01/P7+JLfbl5BOV8s5E/9wya9tZP8C8InpKn0Fdh/pgL1+DE+9xec4avVfmnBN59fa/uhiry0BnPXPnBzpr04gWyFU3nm7g+A7gpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310837; c=relaxed/simple;
	bh=Tu05MKphwEOYciYKJrZW1zS/5ujWTK6L6L6gDjvRdHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFaBdC3/MEVe9VYB6cCOyu/jJfs8406kDtoDFDMElW72JgMih9LHWuIvYjl+T+im08CsBUIYyhurrwQaTWYhnxcR0DCotLoqpMHc3EqZgPlxCHi62qw2zTM5tes3sZi76DMFWuaGd2wqKIYXbWtm4nf6uFunw31rL53HPGvgfqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDvD04KVz9sST;
	Thu, 22 Aug 2024 09:13:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1MT9tMdHKEz; Thu, 22 Aug 2024 09:13:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDvC6NsKz9sSH;
	Thu, 22 Aug 2024 09:13:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C8F7C8B763;
	Thu, 22 Aug 2024 09:13:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Bo_6-yJM0v5v; Thu, 22 Aug 2024 09:13:27 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C10D08B77E;
	Thu, 22 Aug 2024 09:13:26 +0200 (CEST)
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
Subject: [PATCH v2 05/17] vdso: Avoid call to memset() by getrandom
Date: Thu, 22 Aug 2024 09:13:13 +0200
Message-ID: <5deb67090b214f0e6eae96b7c406546d1a16f89b.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310794; l=1449; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Tu05MKphwEOYciYKJrZW1zS/5ujWTK6L6L6gDjvRdHs=; b=u0fyVWP390/v2lcPCFKdHXUzbaZAGOJ9fxQFiyRBtDUCKlOBBFypazkoFT3x/4k36OQuZN9O+ 8qHLZBslISeCEi/TEk76Xkmo8/onzIZnJ6KuWgXgE5X334zHCd965Tw
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

With the current implementation, __cvdso_getrandom_data() calls
memset(), which is unexpected in the VDSO.

Rewrite opaque data initialisation to avoid memset().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/vdso/getrandom.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index cab153c5f9be..4a56f45141b4 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/minmax.h>
+#include <linux/array_size.h>
 #include <vdso/datapage.h>
 #include <vdso/getrandom.h>
 #include <vdso/unaligned.h>
@@ -74,11 +75,15 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 	u32 counter[2] = { 0 };
 
 	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
-		*(struct vgetrandom_opaque_params *)opaque_state = (struct vgetrandom_opaque_params) {
-			.size_of_opaque_state = sizeof(*state),
-			.mmap_prot = PROT_READ | PROT_WRITE,
-			.mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS
-		};
+		struct vgetrandom_opaque_params *params = opaque_state;
+		int i;
+
+		params->size_of_opaque_state = sizeof(*state);
+		params->mmap_prot = PROT_READ | PROT_WRITE;
+		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
+		for (i = 0; i < ARRAY_SIZE(params->reserved); i++)
+			params->reserved[i] = 0;
+
 		return 0;
 	}
 
-- 
2.44.0


