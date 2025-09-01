Return-Path: <linux-fsdevel+bounces-59833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF275B3E43B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82A1F4E29E5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D4D33A003;
	Mon,  1 Sep 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4YsDfs0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC01ADFFB;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732250; cv=none; b=JvNlFGMj6Mw60AlDyaQZEy7ftCtKcbjyg8dYpuONxAKjCvbyIrXcK1HDmll0I0O1PG2TKJVAOXGL0qn+esTGydgPqRBu+pFlKNHoREhSnyO6Sf+YFNEwYLHJcRZJbnMbMMpPfu2NVUXIC6NtwZVVFNyzopTBHYi5GMuTnEKPPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732250; c=relaxed/simple;
	bh=VOxu8arS/s7gFRMCG19RKI+wB0Hc+6Kyu4sWG8FSmZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IxX6lbnRQ5hNJt9T2XTWV568w8GBkxJNt4nnlq8nMs4NoRc77x95hE/L4A9yBvGxQFjxHkNVD+OZyYPVs50zGD2U+Jprh14iychFSi4HpV+8tM/I4gLoBHJxwzDqSqOswo8aFhB06RB6GjCVYTt4L+EQtdksow2wlvFLkGsv59w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4YsDfs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A16E2C2BCB7;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732249;
	bh=VOxu8arS/s7gFRMCG19RKI+wB0Hc+6Kyu4sWG8FSmZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=j4YsDfs041pcEA4PsPM9Fv3cx+Fety1JSDdn80JTlpQfdfbDx49Pj5d73mfbToakx
	 PgLya/HeSbiEPI6JiRWwnf1/+pAmv8a8iYyHCBp4Ds6IqCe4hIez3MU/eu+hu2SbYz
	 lB4Gfs5Y6gmt4q60PKIgOXRBHP3WM5szwT1cuKL2dPIwcwbo6IwaMAPb7M6vbKuZPg
	 afObqthiKmeuNnWe2LTyybg0Ox7TgWLw5aDYxA3PnhAkUwFQMdAsEPqIaAFdzVpS01
	 mAjgyzCoEp77jX8f+cQSGeAlXuVYIZcMVOt/vaDMeLJVmMQHLoFTN/48ISQ6HnWeAn
	 I5XBnsB1pmvdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDDCA0FF0;
	Mon,  1 Sep 2025 13:10:49 +0000 (UTC)
From: Simon Schuster via B4 Relay <devnull+schuster.simon.siemens-energy.com@kernel.org>
Date: Mon, 01 Sep 2025 15:09:53 +0200
Subject: [PATCH v2 4/4] nios2: implement architecture-specific portion of
 sys_clone3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-nios2-implement-clone3-v2-4-53fcf5577d57@siemens-energy.com>
References: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
In-Reply-To: <20250901-nios2-implement-clone3-v2-0-53fcf5577d57@siemens-energy.com>
To: Dinh Nguyen <dinguyen@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Kees Cook <kees@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Kentaro Takeda <takedakn@nttdata.co.jp>, 
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Michal Simek <monstr@monstr.eu>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, 
 Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
 selinux@vger.kernel.org, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, 
 Simon Schuster <schuster.simon@siemens-energy.com>
X-Mailer: b4 0.14.3-dev-2ce6c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756732247; l=2260;
 i=schuster.simon@siemens-energy.com; s=20250818;
 h=from:subject:message-id;
 bh=af84J4YQt0c2u1+xik140Isbk9cuIhCMOLjW6thJwsY=;
 b=d7NLA1iQDxLQGisMH0KtrKIUv8tslRZQ31+BK5A9IfF7XRRqtN0/NtBHPN1763CSVsp/AaVUs
 Xc5SawZJT/gDUL4ePU56689mSaXuGDc8R0/3KXZ7O8sV4jJB/D/Z4M0
X-Developer-Key: i=schuster.simon@siemens-energy.com; a=ed25519;
 pk=PUhOMiSp43aSeRE1H41KApxYOluamBFFiMfKlBjocvo=
X-Endpoint-Received: by B4 Relay for
 schuster.simon@siemens-energy.com/20250818 with auth_id=495
X-Original-From: Simon Schuster <schuster.simon@siemens-energy.com>
Reply-To: schuster.simon@siemens-energy.com

From: Simon Schuster <schuster.simon@siemens-energy.com>

This commit adds the sys_clone3 entry point for nios2. An
architecture-specific wrapper (__sys_clone3) is required to save and
restore additional registers to the kernel stack via SAVE_SWITCH_STACK
and RESTORE_SWITCH_STACK.

Signed-off-by: Simon Schuster <schuster.simon@siemens-energy.com>
---
 arch/nios2/include/asm/syscalls.h | 1 +
 arch/nios2/include/asm/unistd.h   | 2 --
 arch/nios2/kernel/entry.S         | 6 ++++++
 arch/nios2/kernel/syscall_table.c | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/nios2/include/asm/syscalls.h b/arch/nios2/include/asm/syscalls.h
index b4d4ed3bf9c8..0e214b0a0ac8 100644
--- a/arch/nios2/include/asm/syscalls.h
+++ b/arch/nios2/include/asm/syscalls.h
@@ -7,6 +7,7 @@
 
 int sys_cacheflush(unsigned long addr, unsigned long len,
 				unsigned int op);
+asmlinkage long __sys_clone3(struct clone_args __user *uargs, size_t size);
 
 #include <asm-generic/syscalls.h>
 
diff --git a/arch/nios2/include/asm/unistd.h b/arch/nios2/include/asm/unistd.h
index 1146e56473c5..213f6de3cf7b 100644
--- a/arch/nios2/include/asm/unistd.h
+++ b/arch/nios2/include/asm/unistd.h
@@ -7,6 +7,4 @@
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SET_GET_RLIMIT
 
-#define __ARCH_BROKEN_SYS_CLONE3
-
 #endif
diff --git a/arch/nios2/kernel/entry.S b/arch/nios2/kernel/entry.S
index 99f0a65e6234..dd40dfd908e5 100644
--- a/arch/nios2/kernel/entry.S
+++ b/arch/nios2/kernel/entry.S
@@ -403,6 +403,12 @@ ENTRY(sys_clone)
 	addi    sp, sp, 4
 	RESTORE_SWITCH_STACK
 	ret
+/* long syscall(SYS_clone3, struct clone_args *cl_args, size_t size); */
+ENTRY(__sys_clone3)
+	SAVE_SWITCH_STACK
+	call	sys_clone3
+	RESTORE_SWITCH_STACK
+	ret
 
 ENTRY(sys_rt_sigreturn)
 	SAVE_SWITCH_STACK
diff --git a/arch/nios2/kernel/syscall_table.c b/arch/nios2/kernel/syscall_table.c
index 434694067d8f..c99818aac9e1 100644
--- a/arch/nios2/kernel/syscall_table.c
+++ b/arch/nios2/kernel/syscall_table.c
@@ -13,6 +13,7 @@
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, native)
 
 #define sys_mmap2 sys_mmap_pgoff
+#define sys_clone3 __sys_clone3
 
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,

-- 
2.39.5



