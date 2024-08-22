Return-Path: <linux-fsdevel+bounces-26668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2894795AEA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81333B238D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410217C7BF;
	Thu, 22 Aug 2024 07:13:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237B17B51B;
	Thu, 22 Aug 2024 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310834; cv=none; b=Pze96Uv9icR6CFZ5jLLsqq4nPnbVCLn8IRHTSMIcX4EnAoxII2J73RhQEYDvQyQmfbZAL7YeL3hVN/E5sjRrkhGsZXp2+/0y2xCC4NgfL6ID38bvC2SOI7G7mVFZPQVbwz8WyslUekS2xxgSHEZ2PvfKq/0X6cUbMqrNi4DCgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310834; c=relaxed/simple;
	bh=DHKz0nvjKBEZw1qFdyeiMuLRmQ0ExqxUlDOlPsu+3EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJt1wnMr/NKFKsB7R/004cXRZJck7mYtlK+L4bcpC/RJpXK7mwNoRghx+b8RwVSyHgSTGsXLDoLhsFsOZdcCIMhcW1ctQGUgZk8n0dpaMUFY4jXzP4QCt1j+9mcOEtTOIazpUa1DME1vJ4ks7qSCxS1oGq9AdI78v3H0zm/IZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDvF1Dg6z9sSW;
	Thu, 22 Aug 2024 09:13:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RkC5cLxZ4aFG; Thu, 22 Aug 2024 09:13:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDvD6yC3z9sSH;
	Thu, 22 Aug 2024 09:13:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D585A8B763;
	Thu, 22 Aug 2024 09:13:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6SSl1lnhD-ee; Thu, 22 Aug 2024 09:13:28 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CBB698B77D;
	Thu, 22 Aug 2024 09:13:27 +0200 (CEST)
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
Subject: [PATCH v2 06/17] vdso: Change getrandom's generation to unsigned long
Date: Thu, 22 Aug 2024 09:13:14 +0200
Message-ID: <525b48eb79978ddba2d1b8ee23b27bd6c5b0b4ee.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310794; l=1276; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=DHKz0nvjKBEZw1qFdyeiMuLRmQ0ExqxUlDOlPsu+3EA=; b=6rTkR9UfUapFGijZerpzLYHhj4PimSMK+GNZzXry6VAozVYosYDA1h8oocTbDByNjWJQ8Sh+H SV2G/Pz6kbDAVsKqsh13uCcc2q8jEtNaLgRwvLicmTZ4KYZyiB5QJXR
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Performing SMP atomic operations on u64 fails on powerpc32.

Random driver generation is handled as unsigned long not u64,
see for instance base_cnrg or struct crng.

Use the same type for vDSO's getrandom as it gets copied
from the above. This is also in line with the local
current_generation which is already an unsigned long.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/vdso/datapage.h  | 2 +-
 include/vdso/getrandom.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index b85f24cac3f5..00b66a9b5778 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -123,7 +123,7 @@ struct vdso_data {
  * @is_ready:	boolean signaling whether the RNG is initialized
  */
 struct vdso_rng_data {
-	u64	generation;
+	unsigned long	generation;
 	u8	is_ready;
 };
 
diff --git a/include/vdso/getrandom.h b/include/vdso/getrandom.h
index a8b7c14b0ae0..36fd166bf330 100644
--- a/include/vdso/getrandom.h
+++ b/include/vdso/getrandom.h
@@ -38,7 +38,7 @@ struct vgetrandom_state {
 		};
 		u8		batch_key[CHACHA_BLOCK_SIZE * 2];
 	};
-	u64			generation;
+	unsigned long		generation;
 	u8			pos;
 	bool 			in_use;
 };
-- 
2.44.0


