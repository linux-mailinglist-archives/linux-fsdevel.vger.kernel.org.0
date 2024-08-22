Return-Path: <linux-fsdevel+bounces-26670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7567195AEB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 09:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A873D1C23414
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 07:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF9C17E919;
	Thu, 22 Aug 2024 07:14:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE217E01A;
	Thu, 22 Aug 2024 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310842; cv=none; b=pVjMl/AvH2qJTQyvVDaN1UFkR6JaK21CvfdnUU07bBQ0tHSSMlIhNc3GQux1UoYNH4oTJuWl0Y41FVK+XhQ5UCA6nrUeT4g9zoG6H6fJ+DJHvNwMtBPMmqePbXgGp0kvxsTlzDTAW2ujXTHqEe8c98tn6v33D3NrVT8GbyIvg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310842; c=relaxed/simple;
	bh=OlEqmFYyA/zYCHsi3M5a6YAHLTZymd8rahW36+TnP9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5IVpAvMmWyVG1gs8JsZJSru7PQLUuAQSHrEVM/v0vg+QLG3+V+qq4MyCmGz03/VF07FpXkLmtd0AJuV37ofWg2LuYZL3stLOAUlLqBnEZgZqou02qJA4TU6ZbWwTlpn/xCgoh7BnZv/yuJduel+gAgSucgPTIXJxr+d5XzkXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqDvG1Hfxz9sSX;
	Thu, 22 Aug 2024 09:13:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cfcB8-hHUiZb; Thu, 22 Aug 2024 09:13:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqDvG0NQrz9sSH;
	Thu, 22 Aug 2024 09:13:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ED0E58B77D;
	Thu, 22 Aug 2024 09:13:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id mLRSvJmx548r; Thu, 22 Aug 2024 09:13:29 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D75308B77E;
	Thu, 22 Aug 2024 09:13:28 +0200 (CEST)
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
Subject: [PATCH v2 07/17] mm: Define VM_DROPPABLE for powerpc/32
Date: Thu, 22 Aug 2024 09:13:15 +0200
Message-ID: <315e3a268b165b6edad7dcb723b0d8a506a56c4e.1724309198.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724309198.git.christophe.leroy@csgroup.eu>
References: <cover.1724309198.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724310794; l=2716; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=OlEqmFYyA/zYCHsi3M5a6YAHLTZymd8rahW36+TnP9o=; b=0KtX+75e5aHacqDKWQzqJJ0c3IpXSB6kgpJ4hqMZLLHdQ8eM9uPGFxsA9pxzj08bhyJT2vwTC Mzj8u0pdGU1Avply/I3zb6bed28Vac+xMEzM29FNgP7xAAaRupkUHDN
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
 fs/proc/task_mmu.c             | 4 +++-
 include/linux/mm.h             | 4 +++-
 include/trace/events/mmflags.h | 4 ++--
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5f171ad7b436..4a3fe961cbf6 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -987,8 +987,10 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
-#ifdef CONFIG_64BIT
+#if VM_DROPPABLE != VM_NONE
 		[ilog2(VM_DROPPABLE)] = "dp",
+#endif
+#ifdef CONFIG_64BIT
 		[ilog2(VM_SEALED)] = "sl",
 #endif
 	};
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..865d3e21ee5e 100644
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
index b63d211bd141..9820cbfbcb14 100644
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
+#if VM_DROPPABLE != VM_NONE
 # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
 #else
 # define IF_HAVE_VM_DROPPABLE(flag, name)
-- 
2.44.0


