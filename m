Return-Path: <linux-fsdevel+bounces-26677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A984495AEDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC13F1C23F62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D7186615;
	Thu, 22 Aug 2024 07:14:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96F186603;
	Thu, 22 Aug 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310871; cv=none; b=XwU/ysWmfqBCyKi6Yt8qd3jRZ2yIO+ZRLQqXYhSVfWWhY+GDs7Xkh1ufamgRzVlV2FlmvEk68Zh9Z5hvlQnjTwqWkhqkddw4HuxTunGj4Sr9e6feMFdu3unaFU+1xjn8T76gWKq9MVVQJX0C+oTfkHHlIehLfSxHgLeivtJ/uvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310871; c=relaxed/simple;
	bh=XmrEpCsMzE9+kz6qQUG5kHUCZS2KlgNDovuZDzi1tW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/7bLIfRo0o8nergPeYAZuILjwd15KdwJU6Msabgvw/qCHzK/HvrvXVUIDPjLgoA5Rg2mQmJLcuC63emX7mCuMmoSaNqEOHhiC9xaVqoL8Bn/w/WarIs2n1vuWn0ZQ9OH68gye5Q+dULsbrwkpwe5373hDZKjKuL3fZQW17Pztk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDvP4Td1z9sT1;
	Thu, 22 Aug 2024 09:13:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 09leES4wh1IT; Thu, 22 Aug 2024 09:13:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDvP3ZyDz9sSy;
	Thu, 22 Aug 2024 09:13:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 677238B77E;
	Thu, 22 Aug 2024 09:13:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id RlobwgkX-7ZS; Thu, 22 Aug 2024 09:13:37 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 57A568B763;
	Thu, 22 Aug 2024 09:13:36 +0200 (CEST)
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
Subject: [PATCH v2 14/17] selftests: vdso: Make test_vdso_getrandom look for the right vDSO function
Date: Thu, 22 Aug 2024 09:13:22 +0200
Message-ID: <04d1de23a2ff14e2709edd8b75e27b81d703bc57.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310794; l=2750; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=XmrEpCsMzE9+kz6qQUG5kHUCZS2KlgNDovuZDzi1tW8=; b=OQ+cTCj7yV9Xo8q0GnJliOhCQVzFZ+ijay4M06NYygaEBLMtMi7pCe4Q4I/Ci+O/oMyq9e4UF iUvY6HCYUMlDrWIesk4eenuoXEY5x27+R68IZY9KDwMCYTEXHBIsX+v
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Don't hard-code x86 specific names, use vdso_config definitions
to find the correct function matching the architecture.

Add random VDSO function names in names[][]. Remove the #ifdef
CONFIG_VDSO32, having the name there all the time is harmless
and guaranties a steady index for following strings.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/testing/selftests/vDSO/vdso_config.h         | 8 +++-----
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 8 ++++++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 00bfed6e4922..740ce8c98d2e 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -68,16 +68,15 @@ static const char *versions[7] = {
 	"LINUX_5.10"
 };
 
-static const char *names[2][6] = {
+static const char *names[2][7] = {
 	{
 		"__kernel_gettimeofday",
 		"__kernel_clock_gettime",
 		"__kernel_time",
 		"__kernel_clock_getres",
 		"__kernel_getcpu",
-#if defined(VDSO_32BIT)
 		"__kernel_clock_gettime64",
-#endif
+		"__kernel_getrandom",
 	},
 	{
 		"__vdso_gettimeofday",
@@ -85,9 +84,8 @@ static const char *names[2][6] = {
 		"__vdso_time",
 		"__vdso_clock_getres",
 		"__vdso_getcpu",
-#if defined(VDSO_32BIT)
 		"__vdso_clock_gettime64",
-#endif
+		"__vdso_getrandom",
 	},
 };
 
diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
index 05122425a873..02bcffc23e0c 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
@@ -21,6 +21,7 @@
 
 #include "../kselftest.h"
 #include "parse_vdso.h"
+#include "vdso_config.h"
 
 #ifndef timespecsub
 #define	timespecsub(tsp, usp, vsp)					\
@@ -107,6 +108,9 @@ static void vgetrandom_put_state(void *state)
 
 static void vgetrandom_init(void)
 {
+	const char *version = versions[VDSO_VERSION];
+	const char **name = (const char **)&names[VDSO_NAMES];
+
 	if (pthread_key_create(&grnd_ctx.key, vgetrandom_put_state) != 0)
 		return;
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
@@ -115,9 +119,9 @@ static void vgetrandom_init(void)
 		exit(KSFT_SKIP);
 	}
 	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
-	grnd_ctx.fn = (__typeof__(grnd_ctx.fn))vdso_sym("LINUX_2.6", "__vdso_getrandom");
+	grnd_ctx.fn = (__typeof__(grnd_ctx.fn))vdso_sym(version, name[6]);
 	if (!grnd_ctx.fn) {
-		printf("__vdso_getrandom is missing!\n");
+		printf("%s is missing!\n", name[6]);
 		exit(KSFT_FAIL);
 	}
 	if (grnd_ctx.fn(NULL, 0, 0, &grnd_ctx.params, ~0UL) != 0) {
-- 
2.44.0


