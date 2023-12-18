Return-Path: <linux-fsdevel+bounces-6423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED4817B4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 20:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C47A283E11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765987994E;
	Mon, 18 Dec 2023 19:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQHDaJM8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9F768ED;
	Mon, 18 Dec 2023 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1d3b5f9860bso7036415ad.3;
        Mon, 18 Dec 2023 11:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702928842; x=1703533642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvG+cZpIx58A97wp4Wv9KDO67cHjFWHy2MSXjMjbLxM=;
        b=iQHDaJM8b4iZFPlUr6vWjfen1MDDc5CfEUuYnuP1F2oHhnhQ2AfvqbooMWM3qV8a9t
         zCtkPhBPlFnmL/KgYe2xKzMe+iccy4V34Dm2nkLywE6oFgk8IhfCFZrWSWOTmMzaCjbB
         PauTdo2JUn6mIQBgKvq+6XO/WIFYy0ejATnUms8/gkVzNw7SMTaMPtWAlDsDzQPkoknr
         wAIdpw3DdCen1iJ+tUxc67dIk8ZiVlWOzPk13DaE2jwhPJ8oBH7/I/W9lvW/qjRlc+Q8
         P9warm1Yo4EsQUelheKR60nG+z1oz5UR8xhzAVkwQWAbbrG5dIcpLODCR5RpxCqcK5OV
         EjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928842; x=1703533642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvG+cZpIx58A97wp4Wv9KDO67cHjFWHy2MSXjMjbLxM=;
        b=RgaoXF8XeG0hbjZyAbfRVSeAuAPKApasRkKHDWMdNspaUM0BGN/Dv861ZMxVpWxzjA
         Lqwpqq05f886wXqIX+lvcnZJSfZoMpMeWOx/ekiDa/am9ROVrVUEmi26im8q+lwAfRJd
         QqaEKmHgkUEw33BQAHYNswBpx9L5wfUs6XdeS7BnSN9paU//ysrt1Cds7hdgDWLmCGq/
         PW8lma47aamDpb4fTi5kpFL1UlvysBwCzBzSHnb2XHnKUFbJgAY/VKtf2bQMLEY7IRXn
         IEHaHie45PFw6wQMKBE0RBzyigp25CRhSg/k7mJU9RvWudDQVxm+0qQsFI9tz4KuqaZo
         T2Dw==
X-Gm-Message-State: AOJu0Yw1RMBuDHnDrn5IpaQlw24FB4VUPltqLvx+itLMWG1rnsNMJVAt
	6719j/nR8g+CT22LAryqoQ==
X-Google-Smtp-Source: AGHT+IGBpwYLBgiYpwD3EufmLndGtkuui1m28L6ip1sQilNxlYgn8SBAySbYnvgRe6Mvp21xWBqpYw==
X-Received: by 2002:a17:902:e851:b0:1d3:c8ff:4f6e with SMTP id t17-20020a170902e85100b001d3c8ff4f6emr1169531plg.103.1702928841805;
        Mon, 18 Dec 2023 11:47:21 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001ce664c05b0sm19456335pll.33.2023.12.18.11.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:47:21 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v4 09/11] mm/mempolicy: add get_mempolicy2 syscall
Date: Mon, 18 Dec 2023 14:46:29 -0500
Message-Id: <20231218194631.21667-10-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231218194631.21667-1-gregory.price@memverge.com>
References: <20231218194631.21667-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_mempolicy2 is an extensible get_mempolicy interface which allows
a user to retrieve the memory policy for a task or address.

Defined as:

get_mempolicy2(struct mpol_args *args, size_t size,
               unsigned long addr, unsigned long flags)

Top level input values:

mpol_args:    The field which collects information about the mempolicy
              returned to userspace.
addr:         if MPOL_F_ADDR is passed in `flags`, this address will be
              used to return the mempolicy details of the vma the
              address belongs to
flags:        if MPOL_F_ADDR, return mempolicy info vma containing addr
              else, returns task mempolicy information

Input values include the following fields of mpol_args:

pol_nodes:    if set, the nodemask of the policy returned here
pol_maxnodes: if pol_nodes is set, must describe max number of nodes
              to be copied to pol_nodes

Output values include the following fields of mpol_args:

mode:         mempolicy mode
mode_flags:   mempolicy mode flags
home_node:    policy home node will be returned here, or -1 if not.
pol_nodes:    if set, the nodemask for the mempolicy
policy_node:  if the policy has extended node information, it will
              be placed here.  For example MPOL_INTERLEAVE will
              return the next node which will be used for allocation

MPOL_F_NODE has been dropped from get_mempolicy2 (EINVAL).

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 10 ++++-
 arch/alpha/kernel/syscalls/syscall.tbl        |  1 +
 arch/arm/tools/syscall.tbl                    |  1 +
 arch/arm64/include/asm/unistd.h               |  2 +-
 arch/arm64/include/asm/unistd32.h             |  2 +
 arch/m68k/kernel/syscalls/syscall.tbl         |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |  1 +
 arch/s390/kernel/syscalls/syscall.tbl         |  1 +
 arch/sh/kernel/syscalls/syscall.tbl           |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |  1 +
 include/linux/syscalls.h                      |  2 +
 include/uapi/asm-generic/unistd.h             |  4 +-
 kernel/sys_ni.c                               |  1 +
 mm/mempolicy.c                                | 43 +++++++++++++++++++
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  1 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  1 +
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  1 +
 25 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index e57d400d0281..8c1fcdb30602 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -456,11 +456,19 @@ Get [Task] Memory Policy or Related Information::
 	long get_mempolicy(int *mode,
 			   const unsigned long *nmask, unsigned long maxnode,
 			   void *addr, int flags);
+	long get_mempolicy2(struct mpol_args args, size_t size,
+			    unsigned long addr, unsigned long flags);
 
 Queries the "task/process memory policy" of the calling task, or the
 policy or location of a specified virtual address, depending on the
 'flags' argument.
 
+get_mempolicy2() is an extended version of get_mempolicy() capable of
+acquiring extended information about a mempolicy, including those
+that can only be set via set_mempolicy2() or mbind2().
+
+MPOL_F_NODE functionality has been removed from get_mempolicy2().
+
 See the get_mempolicy(2) man page for more details
 
 
@@ -504,7 +512,7 @@ Extended Mempolicy Arguments::
 The extended mempolicy argument structure is defined to allow the mempolicy
 interfaces future extensibility without the need for additional system calls.
 
-Extended interfaces (set_mempolicy2) use this argument structure.
+Extended interfaces (set_mempolicy2 and get_mempolicy2) use this structure.
 
 The core arguments (mode, mode_flags, pol_nodes, and pol_maxnodes) apply to
 all interfaces relative to their non-extended counterparts. Each additional
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 0dc288a1118a..0301a8b0a262 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -497,3 +497,4 @@
 565	common	futex_wait			sys_futex_wait
 566	common	futex_requeue			sys_futex_requeue
 567	common	set_mempolicy2			sys_set_mempolicy2
+568	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 50172ec0e1f5..771a33446e8e 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -471,3 +471,4 @@
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
+458	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 298313d2e0af..b63f870debaf 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		458
+#define __NR_compat_syscalls		459
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index cee8d669c342..f8d01007aee0 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -921,6 +921,8 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 #define __NR_set_mempolicy2 457
 __SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
+#define __NR_get_mempolicy2 458
+__SYSCALL(__NR_get_mempolicy2, sys_get_mempolicy2)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 839d90c535f2..048a409e684c 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -457,3 +457,4 @@
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
+458	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 567c8b883735..327b01bd6793 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -463,3 +463,4 @@
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
+458	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index cc0640e16f2f..921d58e1da23 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -396,3 +396,4 @@
 455	n32	futex_wait			sys_futex_wait
 456	n32	futex_requeue			sys_futex_requeue
 457	n32	set_mempolicy2			sys_set_mempolicy2
+458	n32	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index f7262fde98d9..9271c83c9993 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -445,3 +445,4 @@
 455	o32	futex_wait			sys_futex_wait
 456	o32	futex_requeue			sys_futex_requeue
 457	o32	set_mempolicy2			sys_set_mempolicy2
+458	o32	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e10f0e8bd064..0654f3f89fc7 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
+458	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 4f03f5f42b78..ac11d2064e7a 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -544,3 +544,4 @@
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
+458	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index f98dadc2e9df..1cdcafe1ccca 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -460,3 +460,4 @@
 455  common	futex_wait		sys_futex_wait			sys_futex_wait
 456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
 457  common	set_mempolicy2		sys_set_mempolicy2		sys_set_mempolicy2
+458  common	get_mempolicy2		sys_get_mempolicy2		sys_get_mempolicy2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index f47ba9f2d05d..f71742024c29 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -460,3 +460,4 @@
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
+458	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 53fb16616728..2fbf5dbe0620 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -503,3 +503,4 @@
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
+458	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 4b4dc41b24ee..0af813b9a118 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -462,3 +462,4 @@
 455	i386	futex_wait		sys_futex_wait
 456	i386	futex_requeue		sys_futex_requeue
 457	i386	set_mempolicy2		sys_set_mempolicy2
+458	i386	get_mempolicy2		sys_get_mempolicy2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1bc2190bec27..0b777876fc15 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -379,6 +379,7 @@
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
 457	common	set_mempolicy2		sys_set_mempolicy2
+458	common	get_mempolicy2		sys_get_mempolicy2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index e26dc89399eb..4536c9a4227d 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -428,3 +428,4 @@
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
+458	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 451f0089601f..f696855cbe8c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -821,6 +821,8 @@ asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long __user *nmask,
 				unsigned long maxnode,
 				unsigned long addr, unsigned long flags);
+asmlinkage long sys_get_mempolicy2(struct mpol_args __user *args, size_t size,
+				   unsigned long addr, unsigned long flags);
 asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
 				unsigned long maxnode);
 asmlinkage long sys_set_mempolicy2(struct mpol_args __user *args, size_t size,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 55486aba099f..719accc731db 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -830,9 +830,11 @@ __SYSCALL(__NR_futex_wait, sys_futex_wait)
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 #define __NR_set_mempolicy2 457
 __SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
+#define __NR_get_mempolicy2 458
+__SYSCALL(__NR_get_mempolicy2, sys_get_mempolicy2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 458
+#define __NR_syscalls 459
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 7d6eb0eec056..e4883eaa4e61 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -188,6 +188,7 @@ COND_SYSCALL(process_mrelease);
 COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
 COND_SYSCALL(get_mempolicy);
+COND_SYSCALL(get_mempolicy2);
 COND_SYSCALL(set_mempolicy);
 COND_SYSCALL(set_mempolicy2);
 COND_SYSCALL(migrate_pages);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index eb296ed507e6..ebb08261d7cb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1863,6 +1863,49 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 	return kernel_get_mempolicy(policy, nmask, maxnode, addr, flags);
 }
 
+SYSCALL_DEFINE4(get_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
+		unsigned long, addr, unsigned long, flags)
+{
+	struct mpol_args kargs;
+	struct mempolicy_args margs;
+	int err;
+	nodemask_t policy_nodemask;
+	unsigned long __user *nodes_ptr;
+
+	if (flags & ~(MPOL_F_ADDR))
+		return -EINVAL;
+
+	/* initialize any memory liable to be copied to userland */
+	memset(&margs, 0, sizeof(margs));
+
+	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
+	if (err)
+		return -EINVAL;
+
+	margs.policy_nodes = kargs.pol_nodes ? &policy_nodemask : NULL;
+	if (flags & MPOL_F_ADDR)
+		err = do_get_vma_mempolicy(untagged_addr(addr), NULL, &margs);
+	else
+		err = do_get_task_mempolicy(&margs);
+
+	if (err)
+		return err;
+
+	kargs.mode = margs.mode;
+	kargs.mode_flags = margs.mode_flags;
+	kargs.policy_node = margs.policy_node;
+	kargs.home_node = margs.home_node;
+	if (kargs.pol_nodes) {
+		nodes_ptr = u64_to_user_ptr(kargs.pol_nodes);
+		err = copy_nodes_to_user(nodes_ptr, kargs.pol_maxnodes,
+					 margs.policy_nodes);
+		if (err)
+			return err;
+	}
+
+	return copy_to_user(uargs, &kargs, usize) ? -EFAULT : 0;
+}
+
 bool vma_migratable(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index bb1351df51d9..c34c6877379e 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -372,3 +372,4 @@
 455	n64	futex_wait			sys_futex_wait
 456	n64	futex_requeue			sys_futex_requeue
 457	n64	set_mempolicy2			sys_set_mempolicy2
+458	n64	get_mempolicy2			sys_get_mempolicy2
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 4f03f5f42b78..ac11d2064e7a 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -544,3 +544,4 @@
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
+458	common	get_mempolicy2			sys_get_mempolicy2
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index f98dadc2e9df..1cdcafe1ccca 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -460,3 +460,4 @@
 455  common	futex_wait		sys_futex_wait			sys_futex_wait
 456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
 457  common	set_mempolicy2		sys_set_mempolicy2		sys_set_mempolicy2
+458  common	get_mempolicy2		sys_get_mempolicy2		sys_get_mempolicy2
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 21f2579679d4..edf338f32645 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -379,6 +379,7 @@
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
 457	common 	set_mempolicy2		sys_set_mempolicy2
+458	common 	get_mempolicy2		sys_get_mempolicy2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
-- 
2.39.1


