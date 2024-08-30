Return-Path: <linux-fsdevel+bounces-28069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ED0966646
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37244B21846
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17421B86D7;
	Fri, 30 Aug 2024 15:57:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A741B81DE;
	Fri, 30 Aug 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033451; cv=none; b=kf/V+BH3MympbYVwF84lRKwQO82CZ1O8BpWcXHrGmWPAoTrFqDNP2yOMwWE3MqOMjM8qTp3BbLnIPxvi4lV4poWSXX1aboTu10GVk2v2OuiqQE3elimRZXRXfM/yKQ/Bk6+WccRK7CXOwK6RVtqDEXABMhFon2O/7LdX3LK/MA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033451; c=relaxed/simple;
	bh=/uJanEimm/Fnr8lBP4NFr4vOoV+ijz2MaIjmXbR52ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swSithceii69RaS4UpVUoJzKtwbvI4SziaeoMWJI7vCbhToahcBE1m+Vkv28s7hHmE+nslW7ePwWn35F9ujSIG/DGnlr7FPr3elpIxk7UXb1o3z/8IUPKG5JVJeMvoELvga3Pyuel5JBk8KGpYCb1Na6RcC1hD/WeDXUHPPrqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WwN7y1Dknz9sSC;
	Fri, 30 Aug 2024 17:57:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lm1E0y2khmaS; Fri, 30 Aug 2024 17:57:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WwN7x6THCz9sS7;
	Fri, 30 Aug 2024 17:57:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CC6B38B799;
	Fri, 30 Aug 2024 17:57:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id yyiLWwKmUyql; Fri, 30 Aug 2024 17:57:17 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.133])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D53208B794;
	Fri, 30 Aug 2024 17:57:16 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Shuah Khan <shuah@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v3 1/5] mm: Define VM_DROPPABLE for powerpc/32
Date: Fri, 30 Aug 2024 17:57:05 +0200
Message-ID: <a0454ec1a8ab3455abc8205357681eaa685cd49b.1725031952.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1725031952.git.christophe.leroy@csgroup.eu>
References: <cover.1725031952.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725033425; l=2812; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=/uJanEimm/Fnr8lBP4NFr4vOoV+ijz2MaIjmXbR52ek=; b=1tf5k5ovFZ5zvOOs0ROZ1zJin8FeyXW/XMwB35JKUkbdy50HnTLPUu5Rthe/j4vD2d3CUhq9h mkc1aRp0CyZAmDFhvAq0sK2FUPIXeJUTM5Pd+7zIiWOaabJTjWYkZRQ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always
lazily freeable mappings") only adds VM_DROPPABLE for 64 bits
architectures.

In order to also use the getrandom vDSO implementation on powerpc/32,
use VM_ARCH_1 for VM_DROPPABLE on powerpc/32. This is possible because
VM_ARCH_1 is used for VM_SAO on powerpc and VM_SAO is only for
powerpc/64.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Fixed build failure reported by robots.
---
 fs/proc/task_mmu.c             | 4 +++-
 include/linux/mm.h             | 4 +++-
 include/trace/events/mmflags.h | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5f171ad7b436..3a07e13e2f81 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -987,8 +987,10 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
 		[ilog2(VM_DROPPABLE)] = "dp",
+#endif
+#ifdef CONFIG_64BIT
 		[ilog2(VM_SEALED)] = "sl",
 #endif
 	};
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6549d0979b28..028847f39442 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -359,7 +359,7 @@ extern unsigned int kobjsize(const void *objp);
 
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
-#elif defined(CONFIG_PPC)
+#elif defined(CONFIG_PPC64)
 # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
 #elif defined(CONFIG_PARISC)
 # define VM_GROWSUP	VM_ARCH_1
@@ -409,6 +409,8 @@ extern unsigned int kobjsize(const void *objp);
 #ifdef CONFIG_64BIT
 #define VM_DROPPABLE_BIT	40
 #define VM_DROPPABLE		BIT(VM_DROPPABLE_BIT)
+#elif defined(CONFIG_PPC32)
+#define VM_DROPPABLE		VM_ARCH_1
 #else
 #define VM_DROPPABLE		VM_NONE
 #endif
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index b63d211bd141..37265977d524 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -143,7 +143,7 @@ IF_HAVE_PG_ARCH_X(arch_3)
 
 #if defined(CONFIG_X86)
 #define __VM_ARCH_SPECIFIC_1 {VM_PAT,     "pat"           }
-#elif defined(CONFIG_PPC)
+#elif defined(CONFIG_PPC64)
 #define __VM_ARCH_SPECIFIC_1 {VM_SAO,     "sao"           }
 #elif defined(CONFIG_PARISC)
 #define __VM_ARCH_SPECIFIC_1 {VM_GROWSUP,	"growsup"	}
@@ -165,7 +165,7 @@ IF_HAVE_PG_ARCH_X(arch_3)
 # define IF_HAVE_UFFD_MINOR(flag, name)
 #endif
 
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
 # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
 #else
 # define IF_HAVE_VM_DROPPABLE(flag, name)
-- 
2.44.0


