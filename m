Return-Path: <linux-fsdevel+bounces-47236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F110EA9ADCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0B117B8A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE3427B4F5;
	Thu, 24 Apr 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="LhZ1CK44";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1tKZkGj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B43E27A932;
	Thu, 24 Apr 2025 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498625; cv=none; b=DhmzPwGZ+seNpZBtL2askXEtKqMMmfiw0Y6AQ/zS16AAr2iYASRwHfWrZR8iG8MywPPrt8h9Mi8OD3qoxwa46Bin7g7Z1ZODXq30fFzqg08sddZN+ek0XDmBva7woiWeWHlIH4fflI5H8XBuO/jzC5bNOfH/dkrf2ZnFyT/1Yus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498625; c=relaxed/simple;
	bh=bQfY9zY2C3i4/dIzkfCnaBbkXpjAy6X2zwvqHlfzbJI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uZa0zdUPlxq6SgiCfiziBtvgb1FVo+pdlvNVl+dKHXUmK9/wIv96VKP55dnjhpFVtfriJVIzv3gAhu1LJsckhj+PPdPrpyLHF9c7N5Tm9+399cBxmgtn6avaC+59uElBG+6Xav27gYfS226XnTUMzCQqiRmyOecNX6Fho6iVCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=LhZ1CK44; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1tKZkGj; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 1682C1D418E7;
	Thu, 24 Apr 2025 08:43:40 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-05.internal (MEProxy); Thu, 24 Apr 2025 08:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745498619;
	 x=1745505819; bh=3ObrDK0fk1EJ15u21LLFhjEhplqPLU1rqJNTCeuN8WM=; b=
	LhZ1CK44aG/5/GK/yghH7axGI7wGaBUo01bePd+Jf/SW3uA0nlefESy6uuP7I13a
	f10tnqyspSzr1i+DYuRAH5OmqoFOqf3X2C5T4e43CeCkp5lmsJzjGNnQoI8fN+hP
	QNEZjNAmOWcYtel5CSbtmTGvRuKcgvT/bT9M516DEuZRGkZzfDCIRfpW0uDJZbss
	+8dqm2vSiyM6RuBZWJs7BK4q01prtb5ewMCjcAjfh7hmI0g09VNR27v6pUomgqoW
	/dTIWHppsXgdt75pn/EQycY7wptyeGr6aZX3gY6gYF7bL/sz5JBrdi37nFZPPOmw
	+TBy4axKt95vDnDrpM3RaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745498619; x=
	1745505819; bh=3ObrDK0fk1EJ15u21LLFhjEhplqPLU1rqJNTCeuN8WM=; b=V
	1tKZkGjhvFBBh1zxKIkOjISYVdPMXpFFGNpbW5jJQbWrarQlEuJ7Wg84RDL/R18y
	sgVjKVOpEjLrERlUXWSp6XaEJ/uZjlGFlWzaeuEGFdhQcJhIbm0bL4a7LQoDAtLr
	NY0BGQfcZPZ9QKE7gXOu2nBeupqAxOsHNKAq0p2SEH8kpYxzswn8GoWnGZBdUQMs
	kwUQgvE2ip19HkN1+8AKJ4UxEHf8qlqHJjftCVdHFxRUOQLWTxLfqWMc9iwWxFd3
	yIHuAlwuI+vnC7YX2kHBhOsn/d7VMWHWou2uuWL9eLK5C/hLgg1t/2l6EC/cIFbV
	u/9hRhb3y5e59wK1np1+w==
X-ME-Sender: <xms:-TEKaL3_p1Mb63KV66q5OIN_VN3QLGSAHD109VjRULzn6Z2DO-UiJw>
    <xme:-TEKaKHNfX4OAItG7besy2Z-xPuSt1uW_Y8NqaR7ULRhWbf6LDaWWCJvSIpcbAWFF
    ULmCkbR1LHL5tJmF0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepleevtdeiudegudfhvdfhudffhfeffeeljeeu
    ledtuedvfeehkeegkeefheffleehnecuffhomhgrihhnpegvnhhtrhihqdgtohhmmhhonh
    drshgspdhshihstggrlhhlthgrsghlvgdrshgsnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtg
    hpthhtohephedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgv
    nhekrdguvgdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtph
    htthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheprghn
    ugihsghnrggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrnhhnhhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepshgrmhhithholhhvrghnvghnsehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehrihgtkhdrphdrvggughgvtghomhgsvgesihhnthgvlhdrtghomhdprhgtphhtthho
    pegsrhgruhhnvghrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-TEKaL6LGwg8GWrfKhcM3eK79ABvIPyxKWCzMvkfDQ0L_Ak5Gs1M9w>
    <xmx:-TEKaA2gUg8rslOWhf2xSSU--1zDibiXOYYcimJSFcKb0y7wZ22-sA>
    <xmx:-TEKaOGXOdABHzKoLdT1yrVbTn6OWBNLC2eHh_Qmw_WOgobQNar1Tg>
    <xmx:-TEKaB9tTAmprvmxFVdITTVNu6TzhGjtxQoYWgQMUJSdQsynMlAk1g>
    <xmx:-zEKaJtEsrq0R1ZanCsx-rQX-djlxtQZm8PGRpqyRhsgE9fQpRFR-vbe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B39072220073; Thu, 24 Apr 2025 08:43:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T386ba5040312548e
Date: Thu, 24 Apr 2025 14:43:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
 "Deepak Gupta" <debug@rivosinc.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Conor Dooley" <conor@kernel.org>,
 "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Oleg Nesterov" <oleg@redhat.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Kees Cook" <kees@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 shuah <shuah@kernel.org>, "Jann Horn" <jannh@google.com>,
 "Conor Dooley" <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "Richard Henderson" <richard.henderson@linaro.org>, jim.shu@sifive.com,
 andybnac@gmail.com, kito.cheng@sifive.com,
 "Charlie Jenkins" <charlie@rivosinc.com>,
 "Atish Patra" <atishp@rivosinc.com>, "Evan Green" <evan@rivosinc.com>,
 =?UTF-8?Q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Sami Tolvanen" <samitolvanen@google.com>,
 "Mark Brown" <broonie@kernel.org>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
 "Zong Li" <zong.li@sifive.com>,
 linux-riscv <linux-riscv-bounces@lists.infradead.org>
Message-Id: <5744a80e-f550-49e4-889f-446c272de9bb@app.fastmail.com>
In-Reply-To: <D9EV6ZHETDM6.36DJZQTQ487O1@ventanamicro.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-6-e51202b53138@rivosinc.com>
 <D92VG9GT3W5D.2B71FBI67EYJ6@ventanamicro.com>
 <aAmJweehK4ntbVoO@debug.ba.rivosinc.com>
 <D9EV6ZHETDM6.36DJZQTQ487O1@ventanamicro.com>
Subject: Re: [PATCH v12 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025, at 14:23, Radim Kr=C4=8Dm=C3=A1=C5=99 wrote:
> 2025-04-23T17:45:53-07:00, Deepak Gupta <debug@rivosinc.com>:
>> On Thu, Apr 10, 2025 at 12:03:44PM +0200, Radim Kr=C4=8Dm=C3=A1=C5=99=
 wrote:
>>>2025-03-14T14:39:25-07:00, Deepak Gupta <debug@rivosinc.com>:
>>>Why isn't the previous hunk be enough?  (Or why don't we do just this=
?)
>>>
>>>riscv_sys_mmap() eventually calls arch_calc_vm_prot_bits(), so I'd
>>>rather fix each code path just once.
>>
>> You're right. Above hunk (arch/riscv/include/asm/mman.h) alone should=
 be enough.
>> I did this change in `sys_riscv.c` out of caution. If it feels like u=
n-necessary,
>> I'll remove it. No hard feelings either way.
>
> I think it makes the code harder to reason about.  Here it is not clear
> why this caller of ksys_mmap_pgoff() has to do this, while others don'=
t.

Right, I've been meaning to clean this up for years: there should
really not be anything architecture specific in the sys_mmap() or
sys_mmap2() syscalls, but we never managed to have a global definition
for those and instead leave them up to the architectures and over
the years they have diverged.

See below for my earlier prototype of this.

       Arnd


From 42efb4468e119f34361f039d0779b8cd00d73de8 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Dec 2021 15:06:58 +0100
Subject: [PATCH] treewide: replace mmap_pgoff() with mmap2()

32-bit architectures generally implement sys_mmap2() as their primary
mmap() implementation, but common code only provides sys_mmap_pgoff(),
which has slightly different behavior when dealing with page sizes
other than 4096 bytes.

On m68k, arc and hexagon, the use of mmap_pgoff() appears to be
irreversible, as they do support multiple page sizes and user space
now relies on passing the argument in actual pages rather than
fixed-size units. m68k also has a misleading comment about SUN3
that needs to be rewritten to reflect that this is not broken but
required by libc now.

powerpc and riscv are additional exceptions here, as they have
checks for the 'prot' argument that need to be kept in place.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/asm/syscalls.h                    |  4 ++++
 arch/arm/include/asm/ftrace.h                      |  4 +---
 arch/arm/kernel/entry-common.S                     |  9 ---------
 arch/arm/mm/mmap.c                                 |  9 +++++++++
 arch/arm64/kernel/sys32.c                          | 16 ----------------
 arch/arm64/tools/syscall_32.tbl                    |  2 +-
 arch/csky/kernel/syscall.c                         | 15 ---------------
 arch/hexagon/kernel/syscalltab.c                   | 11 +++++++++--
 arch/m68k/include/asm/syscalls.h                   |  3 +++
 arch/m68k/kernel/sys_m68k.c                        | 11 +++++------
 arch/m68k/kernel/syscalltable.S                    |  2 --
 arch/microblaze/kernel/sys_microblaze.c            | 11 -----------
 arch/mips/kernel/syscall.c                         | 11 -----------
 arch/mips/kernel/syscalls/syscall_o32.tbl          |  2 +-
 arch/nios2/kernel/syscall_table.c                  |  2 --
 arch/parisc/kernel/sys_parisc.c                    | 10 ----------
 arch/powerpc/include/asm/syscalls.h                |  7 ++-----
 arch/powerpc/kernel/syscalls.c                     | 17 +++++----------=
--
 arch/powerpc/kernel/syscalls/syscall.tbl           |  4 ++--
 arch/riscv/include/asm/syscall.h                   |  8 ++++++++
 arch/riscv/kernel/sys_riscv.c                      |  5 +++--
 arch/riscv/kernel/syscall_table.c                  |  3 +++
 arch/sh/include/asm/syscalls.h                     |  3 ---
 arch/sh/kernel/sys_sh.c                            | 16 ----------------
 arch/sparc/kernel/sys_sparc_32.c                   | 12 ------------
 arch/x86/entry/syscalls/syscall_32.tbl             |  2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl            |  2 +-
 include/linux/syscalls.h                           |  2 +-
 mm/mmap.c                                          | 11 ++++++++---
 mm/nommu.c                                         | 11 ++++++++---

diff --git a/arch/arc/include/asm/syscalls.h b/arch/arc/include/asm/sysc=
alls.h
index c3f4714a4f5c..91e2d3fac623 100644
--- a/arch/arc/include/asm/syscalls.h
+++ b/arch/arc/include/asm/syscalls.h
@@ -17,6 +17,10 @@ int sys_arc_settls(void *);
 int sys_arc_gettls(void);
 int sys_arc_usr_cmpxchg(int *, int, int);
=20
+asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
+			       unsigned long prot, unsigned long flags,
+			       unsigned long fd, unsigned long pgoff);
+
 #include <asm-generic/syscalls.h>
=20
 #endif
diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace=
.h
index 5be3ddc96a50..3b2d84ec11f3 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -62,9 +62,7 @@ static inline void *return_address(unsigned int level)
 static inline bool arch_syscall_match_sym_name(const char *sym,
 					       const char *name)
 {
-	if (!strcmp(sym, "sys_mmap2"))
-		sym =3D "sys_mmap_pgoff";
-	else if (!strcmp(sym, "sys_statfs64_wrapper"))
+	if (!strcmp(sym, "sys_statfs64_wrapper"))
 		sym =3D "sys_statfs64";
 	else if (!strcmp(sym, "sys_fstatfs64_wrapper"))
 		sym =3D "sys_fstatfs64";
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-comm=
on.S
index f379c852dcb7..d7657d210c61 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -406,15 +406,6 @@ sys_fstatfs64_wrapper:
 		b	sys_fstatfs64
 ENDPROC(sys_fstatfs64_wrapper)
=20
-/*
- * Note: off_4k (r5) is always units of 4K.  If we can't do the request=
ed
- * offset, we return EINVAL.
- */
-sys_mmap2:
-		str	r5, [sp, #4]
-		b	sys_mmap_pgoff
-ENDPROC(sys_mmap2)
-
 #ifdef CONFIG_OABI_COMPAT
=20
 /*
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 3dbb383c26d5..8d7fb2df1349 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/personality.h>
 #include <linux/random.h>
+#include <linux/syscalls.h>
 #include <asm/cachetype.h>
=20
 #define COLOUR_ALIGN(addr,pgoff)		\
@@ -165,3 +166,11 @@ int valid_mmap_phys_addr_range(unsigned long pfn, s=
ize_t size)
 {
 	return (pfn + (size >> PAGE_SHIFT)) <=3D (1 + (PHYS_MASK >> PAGE_SHIFT=
));
 }
+
+/* arc glibc passes PAGE_SIZE units rather than the usual 4K */
+SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
+		long, prot, unsigned long, flags,
+		long, fd, unsigned long, pgoff)
+{
+      return ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
+}
diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 0e3aa4d762a3..8709521ef7bf 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -43,22 +43,6 @@ COMPAT_SYSCALL_DEFINE3(aarch32_fstatfs64, unsigned in=
t, fd, compat_size_t, sz,
 	return kcompat_sys_fstatfs64(fd, sz, buf);
 }
=20
-/*
- * Note: off_4k is always in units of 4K. If we can't do the
- * requested offset because it is not page-aligned, we return -EINVAL.
- */
-COMPAT_SYSCALL_DEFINE6(aarch32_mmap2, unsigned long, addr, unsigned lon=
g, len,
-		       unsigned long, prot, unsigned long, flags,
-		       unsigned long, fd, unsigned long, off_4k)
-{
-	if (off_4k & (~PAGE_MASK >> 12))
-		return -EINVAL;
-
-	off_4k >>=3D (PAGE_SHIFT - 12);
-
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off_4k);
-}
-
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define arg_u32p(name)	u32, name##_hi, u32, name##_lo
 #else
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_=
32.tbl
index 0765b3a8d6d6..893a33b94c74 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -204,7 +204,7 @@
 190	common	vfork			sys_vfork
 # SuS compliant getrlimit
 191	common	ugetrlimit		sys_getrlimit		compat_sys_getrlimit
-192	common	mmap2			sys_mmap2		compat_sys_aarch32_mmap2
+192	common	mmap2			sys_mmap2
 193	common	truncate64		sys_truncate64		compat_sys_aarch32_truncate64
 194	common	ftruncate64		sys_ftruncate64		compat_sys_aarch32_ftruncate64
 195	common	stat64			sys_stat64
diff --git a/arch/csky/kernel/syscall.c b/arch/csky/kernel/syscall.c
index 4540a271ee39..ecde99520fd1 100644
--- a/arch/csky/kernel/syscall.c
+++ b/arch/csky/kernel/syscall.c
@@ -14,21 +14,6 @@ SYSCALL_DEFINE1(set_thread_area, unsigned long, addr)
 	return 0;
 }
=20
-SYSCALL_DEFINE6(mmap2,
-	unsigned long, addr,
-	unsigned long, len,
-	unsigned long, prot,
-	unsigned long, flags,
-	unsigned long, fd,
-	unsigned long, offset)
-{
-	if (unlikely(offset & (~PAGE_MASK >> 12)))
-		return -EINVAL;
-
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
-			       offset >> (PAGE_SHIFT - 12));
-}
-
 /*
  * for abiv1 the 64bits args should be even th, So we need mov the advi=
ce
  * forward.
diff --git a/arch/hexagon/kernel/syscalltab.c b/arch/hexagon/kernel/sysc=
alltab.c
index b53e2eead4ac..595ab60c9d7b 100644
--- a/arch/hexagon/kernel/syscalltab.c
+++ b/arch/hexagon/kernel/syscalltab.c
@@ -14,8 +14,6 @@
 #define __SYSCALL(nr, call) [nr] =3D (call),
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, =
native)
=20
-#define sys_mmap2 sys_mmap_pgoff
-
 SYSCALL_DEFINE6(hexagon_fadvise64_64, int, fd, int, advice,
 		SC_ARG64(offset), SC_ARG64(len))
 {
@@ -25,6 +23,15 @@ SYSCALL_DEFINE6(hexagon_fadvise64_64, int, fd, int, a=
dvice,
=20
 #define sys_sync_file_range sys_sync_file_range2
=20
+/* hexagon libc passes PAGE_SIZE units rather than the usual 4K */
+#define sys_mmap2 sys_mmap_pgoff
+SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
+		long, prot, unsigned long, flags,
+		long, fd, unsigned long, pgoff)
+{
+      return ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
+}
+
 void *sys_call_table[__NR_syscalls] =3D {
 #include <asm/syscall_table_32.h>
 };
diff --git a/arch/m68k/include/asm/syscalls.h b/arch/m68k/include/asm/sy=
scalls.h
index fb3639acd07b..70c5f01d8036 100644
--- a/arch/m68k/include/asm/syscalls.h
+++ b/arch/m68k/include/asm/syscalls.h
@@ -5,6 +5,9 @@
 #include <linux/compiler_types.h>
 #include <linux/linkage.h>
=20
+asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
+	unsigned long prot, unsigned long flags,
+	unsigned long fd, unsigned long pgoff);
 asmlinkage int sys_cacheflush(unsigned long addr, int scope, int cache,
 			      unsigned long len);
 asmlinkage int sys_atomic_cmpxchg_32(unsigned long newval, int oldval, =
int d3,
diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 1af5e6082467..87a251d05554 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -37,15 +37,14 @@
=20
 #include "../mm/fault.h"
=20
-asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
+/*
+ * m68k user space expects to pass units of PAGE_SIZE rather than 4KB,
+ * so provide a custom wrapper around ksys_mmap_pgoff()
+ */
+asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	/*
-	 * This is wrong for sun3 - there PAGE_SIZE is 8Kb,
-	 * so we need to shift the argument down by 1; m68k mmap64(3)
-	 * (in libc) expects the last argument of mmap2 in 4Kb units.
-	 */
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
 }
=20
diff --git a/arch/m68k/kernel/syscalltable.S b/arch/m68k/kernel/syscallt=
able.S
index e25ef4a9df30..d7b8f4840eb4 100644
--- a/arch/m68k/kernel/syscalltable.S
+++ b/arch/m68k/kernel/syscalltable.S
@@ -14,9 +14,7 @@
=20
 #include <linux/linkage.h>
=20
-#ifndef CONFIG_MMU
 #define sys_mmap2	sys_mmap_pgoff
-#endif
=20
 #define __SYSCALL(nr, entry) .long entry
 	.section .rodata
diff --git a/arch/microblaze/kernel/sys_microblaze.c b/arch/microblaze/k=
ernel/sys_microblaze.c
index 0850b099f300..7fde269b5ef3 100644
--- a/arch/microblaze/kernel/sys_microblaze.c
+++ b/arch/microblaze/kernel/sys_microblaze.c
@@ -42,14 +42,3 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned l=
ong, len,
=20
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff >> PAGE_SHIFT=
);
 }
-
-SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
-		unsigned long, prot, unsigned long, flags, unsigned long, fd,
-		unsigned long, pgoff)
-{
-	if (pgoff & (~PAGE_MASK >> 12))
-		return -EINVAL;
-
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
-			       pgoff >> (PAGE_SHIFT - 12));
-}
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 1bfc34a2e5b3..f050b7cd6dc0 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -69,17 +69,6 @@ SYSCALL_DEFINE6(mips_mmap, unsigned long, addr, unsig=
ned long, len,
 			       offset >> PAGE_SHIFT);
 }
=20
-SYSCALL_DEFINE6(mips_mmap2, unsigned long, addr, unsigned long, len,
-	unsigned long, prot, unsigned long, flags, unsigned long, fd,
-	unsigned long, pgoff)
-{
-	if (pgoff & (~PAGE_MASK >> 12))
-		return -EINVAL;
-
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
-			       pgoff >> (PAGE_SHIFT - 12));
-}
-
 save_static_function(sys_fork);
 save_static_function(sys_clone);
 save_static_function(sys_clone3);
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kerne=
l/syscalls/syscall_o32.tbl
index 114a5a1a6230..961379b9ef7b 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -221,7 +221,7 @@
 207	o32	sendfile			sys_sendfile			compat_sys_sendfile
 208	o32	getpmsg				sys_ni_syscall
 209	o32	putpmsg				sys_ni_syscall
-210	o32	mmap2				sys_mips_mmap2
+210	o32	mmap2				sys_mmap2
 211	o32	truncate64			sys_truncate64			sys_32_truncate64
 212	o32	ftruncate64			sys_ftruncate64			sys_32_ftruncate64
 213	o32	stat64				sys_stat64			sys_newstat
diff --git a/arch/nios2/kernel/syscall_table.c b/arch/nios2/kernel/sysca=
ll_table.c
index 434694067d8f..88ecde1b96f3 100644
--- a/arch/nios2/kernel/syscall_table.c
+++ b/arch/nios2/kernel/syscall_table.c
@@ -12,8 +12,6 @@
 #define __SYSCALL(nr, call) [nr] =3D (call),
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, =
native)
=20
-#define sys_mmap2 sys_mmap_pgoff
-
 void *sys_call_table[__NR_syscalls] =3D {
 	[0 ... __NR_syscalls-1] =3D sys_ni_syscall,
 #include <asm/syscall_table_32.h>
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_pa=
risc.c
index f852fe274abe..c56d4d3dff32 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -182,16 +182,6 @@ unsigned long arch_get_unmapped_area_topdown(struct=
 file *filp,
 			addr, len, pgoff, flags, DOWN);
 }
=20
-asmlinkage unsigned long sys_mmap2(unsigned long addr, unsigned long le=
n,
-	unsigned long prot, unsigned long flags, unsigned long fd,
-	unsigned long pgoff)
-{
-	/* Make sure the shift for mmap2 is constant (12), no matter what PAGE=
_SIZE
-	   we have. */
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
-			       pgoff >> (PAGE_SHIFT - 12));
-}
-
 asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
 		unsigned long prot, unsigned long flags, unsigned long fd,
 		unsigned long offset)
diff --git a/arch/powerpc/include/asm/syscalls.h b/arch/powerpc/include/=
asm/syscalls.h
index 6d51b007b59e..711785d630c2 100644
--- a/arch/powerpc/include/asm/syscalls.h
+++ b/arch/powerpc/include/asm/syscalls.h
@@ -52,10 +52,10 @@ long compat_sys_ppc64_personality(unsigned long pers=
onality);
=20
 long sys_swapcontext(struct ucontext __user *old_ctx,
 		     struct ucontext __user *new_ctx, long ctx_size);
-long sys_mmap(unsigned long addr, size_t len,
+long sys_ppc_mmap(unsigned long addr, size_t len,
 	      unsigned long prot, unsigned long flags,
 	      unsigned long fd, off_t offset);
-long sys_mmap2(unsigned long addr, size_t len,
+long sys_ppc32_mmap2(unsigned long addr, size_t len,
 	       unsigned long prot, unsigned long flags,
 	       unsigned long fd, unsigned long pgoff);
 long sys_switch_endian(void);
@@ -113,9 +113,6 @@ long sys_ppc_fallocate(int fd, int mode, u32 offset1=
, u32 offset2,
 		       u32 len1, u32 len2);
 #endif
 #ifdef CONFIG_COMPAT
-long compat_sys_mmap2(unsigned long addr, size_t len,
-		      unsigned long prot, unsigned long flags,
-		      unsigned long fd, unsigned long pgoff);
 long compat_sys_ppc_pread64(unsigned int fd,
 			    char __user *ubuf, compat_size_t count,
 			    u32 reg6, u32 pos1, u32 pos2);
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscal=
ls.c
index 68ebb23a5af4..003ad44eaa5f 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -49,24 +49,17 @@ static long do_mmap2(unsigned long addr, size_t len,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> shift);
 }
=20
-SYSCALL_DEFINE6(mmap2, unsigned long, addr, size_t, len,
+/*
+ * like the normal mmap2(), but checks the prot argument
+ */
+SYSCALL_DEFINE6(ppc32_mmap2, unsigned long, addr, size_t, len,
 		unsigned long, prot, unsigned long, flags,
 		unsigned long, fd, unsigned long, pgoff)
 {
 	return do_mmap2(addr, len, prot, flags, fd, pgoff, PAGE_SHIFT-12);
 }
=20
-#ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(mmap2,
-		       unsigned long, addr, size_t, len,
-		       unsigned long, prot, unsigned long, flags,
-		       unsigned long, fd, unsigned long, off_4k)
-{
-	return do_mmap2(addr, len, prot, flags, fd, off_4k, PAGE_SHIFT-12);
-}
-#endif
-
-SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
+SYSCALL_DEFINE6(ppc_mmap, unsigned long, addr, size_t, len,
 		unsigned long, prot, unsigned long, flags,
 		unsigned long, fd, off_t, offset)
 {
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/ker=
nel/syscalls/syscall.tbl
index 9a084bdb8926..b7d83806d48f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -124,7 +124,7 @@
 89	32	readdir				sys_old_readdir			compat_sys_old_readdir
 89	64	readdir				sys_ni_syscall
 89	spu	readdir				sys_ni_syscall
-90	common	mmap				sys_mmap
+90	common	mmap				sys_ppc_mmap
 91	common	munmap				sys_munmap
 92	common	truncate			sys_truncate			compat_sys_truncate
 93	common	ftruncate			sys_ftruncate			compat_sys_ftruncate
@@ -249,7 +249,7 @@
 191	32	readahead			sys_ppc_readahead		compat_sys_ppc_readahead
 191	64	readahead			sys_readahead
 191	spu	readahead			sys_readahead
-192	32	mmap2				sys_mmap2			compat_sys_mmap2
+192	32	mmap2				sys_mmap2
 193	32	truncate64			sys_ppc_truncate64		compat_sys_ppc_truncate64
 194	32	ftruncate64			sys_ppc_ftruncate64		compat_sys_ppc_ftruncate64
 195	32	stat64				sys_stat64
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/s=
yscall.h
index 34313387f977..20cbf0c63e20 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -121,4 +121,12 @@ asmlinkage long sys_riscv_flush_icache(uintptr_t, u=
intptr_t, uintptr_t);
=20
 asmlinkage long sys_riscv_hwprobe(struct riscv_hwprobe *, size_t, size_=
t,
 				  unsigned long *, unsigned int);
+
+asmlinkage long sys_riscv_mmap2(unsigned long addr, unsigned long len,
+			unsigned long prot, unsigned long flags,
+			unsigned long fd, unsigned long pgoff);
+asmlinkage long sys_riscv_mmap(unsigned long addr, unsigned long len,
+			unsigned long prot, unsigned long flags,
+			unsigned long fd, off_t pgoff);
+
 #endif	/* _ASM_RISCV_SYSCALL_H */
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv=
.c
index d77afe05578f..8e8c32241db6 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -20,8 +20,9 @@ static long riscv_sys_mmap(unsigned long addr, unsigne=
d long len,
 			       offset >> (PAGE_SHIFT - page_shift_offset));
 }
=20
+/* same as the generic version, but checks the prot argument */
 #ifdef CONFIG_64BIT
-SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+SYSCALL_DEFINE6(riscv_mmap, unsigned long, addr, unsigned long, len,
 	unsigned long, prot, unsigned long, flags,
 	unsigned long, fd, unsigned long, offset)
 {
@@ -30,7 +31,7 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned lo=
ng, len,
 #endif
=20
 #if defined(CONFIG_32BIT) || defined(CONFIG_COMPAT)
-SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
+SYSCALL_DEFINE6(riscv_mmap2, unsigned long, addr, unsigned long, len,
 	unsigned long, prot, unsigned long, flags,
 	unsigned long, fd, unsigned long, offset)
 {
diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/sysca=
ll_table.c
index 43363a80d722..def8e888d262 100644
--- a/arch/riscv/kernel/syscall_table.c
+++ b/arch/riscv/kernel/syscall_table.c
@@ -15,6 +15,9 @@
 #define __SYSCALL(nr, call)	asmlinkage long __riscv_##call(const struct=
 pt_regs *);
 #include <asm/syscall_table.h>
=20
+#define __riscv_sys_mmap  __riscv_sys_riscv_mmap
+#define __riscv_sys_mmap2 __riscv_sys_riscv_mmap2
+
 #undef __SYSCALL
 #define __SYSCALL(nr, call)	[nr] =3D __riscv_##call,
=20
diff --git a/arch/sh/include/asm/syscalls.h b/arch/sh/include/asm/syscal=
ls.h
index 39240e06e8aa..d54c69633acc 100644
--- a/arch/sh/include/asm/syscalls.h
+++ b/arch/sh/include/asm/syscalls.h
@@ -5,9 +5,6 @@
 asmlinkage int old_mmap(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
 			int fd, unsigned long off);
-asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
-			  unsigned long prot, unsigned long flags,
-			  unsigned long fd, unsigned long pgoff);
 asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, in=
t op);
=20
 #include <asm/syscalls_32.h>
diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
index a5a7b33ed81a..45abd5e1246e 100644
--- a/arch/sh/kernel/sys_sh.c
+++ b/arch/sh/kernel/sys_sh.c
@@ -38,22 +38,6 @@ asmlinkage int old_mmap(unsigned long addr, unsigned =
long len,
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off>>PAGE_SHIFT);
 }
=20
-asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
-	unsigned long prot, unsigned long flags,
-	unsigned long fd, unsigned long pgoff)
-{
-	/*
-	 * The shift for mmap2 is constant, regardless of PAGE_SIZE
-	 * setting.
-	 */
-	if (pgoff & ((1 << (PAGE_SHIFT - 12)) - 1))
-		return -EINVAL;
-
-	pgoff >>=3D PAGE_SHIFT - 12;
-
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
-}
-
 /* sys_cacheflush -- flush (part of) the processor cache.  */
 asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, in=
t op)
 {
diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sp=
arc_32.c
index fb31bc0c5b48..2331ba5bad8b 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -104,18 +104,6 @@ int sparc_mmap_check(unsigned long addr, unsigned l=
ong len)
 	return 0;
 }
=20
-/* Linux version of mmap */
-
-SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
-	unsigned long, prot, unsigned long, flags, unsigned long, fd,
-	unsigned long, pgoff)
-{
-	/* Make sure the shift for mmap2 is constant (12), no matter what PAGE=
_SIZE
-	   we have. */
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
-			       pgoff >> (PAGE_SHIFT - 12));
-}
-
 SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 	unsigned long, prot, unsigned long, flags, unsigned long, fd,
 	unsigned long, off)
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/sys=
calls/syscall_32.tbl
index ac007ea00979..e11dba577071 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -204,7 +204,7 @@
 189	i386	putpmsg
 190	i386	vfork			sys_vfork
 191	i386	ugetrlimit		sys_getrlimit			compat_sys_getrlimit
-192	i386	mmap2			sys_mmap_pgoff
+192	i386	mmap2			sys_mmap2
 193	i386	truncate64		sys_ia32_truncate64
 194	i386	ftruncate64		sys_ia32_ftruncate64
 195	i386	stat64			sys_stat64			compat_sys_ia32_stat64
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kerne=
l/syscalls/syscall.tbl
index f657a77314f8..e13e73fab37c 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -89,7 +89,7 @@
 78	common	flistxattr			sys_flistxattr
 79	common	fremovexattr			sys_fremovexattr
 # File Map / Shared Memory Operations
-80	common	mmap2				sys_mmap_pgoff
+80	common	mmap2				sys_mmap2
 81	common	munmap				sys_munmap
 82	common	mprotect			sys_mprotect
 83	common	brk				sys_brk
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e5603cc91963..0df21f8f6e24 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1198,7 +1198,7 @@ asmlinkage long sys_ipc(unsigned int call, int fir=
st, unsigned long second,
 		unsigned long third, void __user *ptr, long fifth);
=20
 /* obsolete */
-asmlinkage long sys_mmap_pgoff(unsigned long addr, unsigned long len,
+asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
 			unsigned long prot, unsigned long flags,
 			unsigned long fd, unsigned long pgoff);
 asmlinkage long sys_old_mmap(struct mmap_arg_struct __user *arg);
diff --git a/mm/mmap.c b/mm/mmap.c
index bd210aaf7ebd..73ba0e5cae07 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -611,11 +611,16 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, =
unsigned long len,
 	return retval;
 }
=20
-SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
-		unsigned long, fd, unsigned long, pgoff)
+		unsigned long, fd, unsigned long, off_4k)
 {
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
+	if (off_4k & (~PAGE_MASK >> 12))
+		return -EINVAL;
+
+	off_4k >>=3D (PAGE_SHIFT - 12);
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off_4k);
 }
=20
 #ifdef __ARCH_WANT_SYS_OLD_MMAP
diff --git a/mm/nommu.c b/mm/nommu.c
index 76c3096206fa..86cca5b21e87 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1247,11 +1247,16 @@ unsigned long ksys_mmap_pgoff(unsigned long addr=
, unsigned long len,
 	return retval;
 }
=20
-SYSCALL_DEFINE6(mmap_pgoff, unsigned long, addr, unsigned long, len,
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
 		unsigned long, prot, unsigned long, flags,
-		unsigned long, fd, unsigned long, pgoff)
+		unsigned long, fd, unsigned long, off_4k)
 {
-	return ksys_mmap_pgoff(addr, len, prot, flags, fd, pgoff);
+	if (off_4k & (~PAGE_MASK >> 12))
+		return -EINVAL;
+
+	off_4k >>=3D (PAGE_SHIFT - 12);
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off_4k);
 }
=20
 #ifdef __ARCH_WANT_SYS_OLD_MMAP
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/=
perf/arch/powerpc/entry/syscalls/syscall.tbl
index 9a084bdb8926..ddfeff063a6d 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -124,7 +124,7 @@
 89	32	readdir				sys_old_readdir			compat_sys_old_readdir
 89	64	readdir				sys_ni_syscall
 89	spu	readdir				sys_ni_syscall
-90	common	mmap				sys_mmap
+90	common	mmap				sys_ppc_mmap
 91	common	munmap				sys_munmap
 92	common	truncate			sys_truncate			compat_sys_truncate
 93	common	ftruncate			sys_ftruncate			compat_sys_ftruncate
@@ -249,7 +249,7 @@
 191	32	readahead			sys_ppc_readahead		compat_sys_ppc_readahead
 191	64	readahead			sys_readahead
 191	spu	readahead			sys_readahead
-192	32	mmap2				sys_mmap2			compat_sys_mmap2
+192	32	mmap2				sys_ppc32_mmap2
 193	32	truncate64			sys_ppc_truncate64		compat_sys_ppc_truncate64
 194	32	ftruncate64			sys_ppc_ftruncate64		compat_sys_ppc_ftruncate64
 195	32	stat64				sys_stat64

