Return-Path: <linux-fsdevel+bounces-5406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B380A80B298
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 08:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423791F21226
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 07:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493231FD1;
	Sat,  9 Dec 2023 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDOTJwVr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38FE2136;
	Fri,  8 Dec 2023 23:00:21 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id af79cd13be357-77f3183f012so139964285a.0;
        Fri, 08 Dec 2023 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702105219; x=1702710019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/XyqqBkg5fuo33Ip2SFhoThrNsBfzrYojUCpknb6qg=;
        b=lDOTJwVrqAP3j8VcOewwWbbPMbLSpkZNm5S059hEw7CTu0f+bC1HNRfF575B5zSwOF
         wFreCEoAp8e2De4S3NxFWiFrkjVRpf5AcWddoauLZYxSAD7eZbI5We1y1HvOn350W7wa
         NBJm0RZ6mNpMl2w9FGkDfFhE/1NJI9O/akPYgup5r3CSNSFsxnru79W5tZdKVELGTUcz
         cuUdFyg77j2ZBqty88M9WwsuAKrF4+gwA+8G6bfOjEqwfjWBnXpjIzYL5nrfIHiwEK2v
         bE4TlcVJtO6mQ+QHJUxYMmtREmkaYFJDStrqf3kMpHi0Y3qmrrQn87twtU6CLf5QD9R0
         FmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105219; x=1702710019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/XyqqBkg5fuo33Ip2SFhoThrNsBfzrYojUCpknb6qg=;
        b=I8mWKy1Q8aH4REf7z+oWBjTFjkpau16YKkhYr9HvjwWY+pGZQLm8EI1HISYT3YI6r+
         PzGonL9WyZOjBqabL/bPT5I0ZGaJyVQpCaxgvorhkK+FWfZDugF9X1uyRCZ7pE6zT7qQ
         Fw8saKxNZTH7+tEzh5MQvmE454w1hmexVJCyeNSmwDXqBiZJ2zQHgnzo/eYZOD0Z5Fv7
         yPPToq1UXrI4Fo5p/K+GYvf3BBhVqLYiQ8ybrI5ZTCIYrWykeVblYPacN8O/iRAr1nHH
         jbea5kW4ukLUPcmvwYq1vDy9DyGgjiGYbS74li/39F1Rklr1JsZzVRXqyDG5bjr8Dc1U
         hrbA==
X-Gm-Message-State: AOJu0Yy5r+neIIPxWtZV6hmGdAklyDD/4Cwq7/3fvRSimdT8ADf7baDA
	JL6H8EobA6FAei8rJ/DfNg==
X-Google-Smtp-Source: AGHT+IG+mvJKnPRrBL3r0GmZB6X9O+Z0T8mESY8jq/MrpvJQq54w3SN+fxjeQ0TUX61npkiogxX9JQ==
X-Received: by 2002:a05:620a:2287:b0:77e:fba3:9383 with SMTP id o7-20020a05620a228700b0077efba39383mr1322911qkh.101.1702105219224;
        Fri, 08 Dec 2023 23:00:19 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x8-20020a81b048000000b005df5d592244sm326530ywk.78.2023.12.08.23.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 23:00:19 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
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
	Michal Hocko <mhocko@suse.com>,
	Frank van der Linden <fvdl@google.com>
Subject: [PATCH v2 10/11] mm/mempolicy: add the mbind2 syscall
Date: Sat,  9 Dec 2023 01:59:31 -0500
Message-Id: <20231209065931.3458-11-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231209065931.3458-1-gregory.price@memverge.com>
References: <20231209065931.3458-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mbind2 is an extensible mbind interface which allows a user to
set the mempolicy for one or more address ranges.

Defined as:

mbind2(struct mpol_args *args, size_t size, unsigned long flags)

Input values include the following fields of mpl_args:

mode:         The MPOL_* policy (DEFAULT, INTERLEAVE, etc.)
mode_flags:   The MPOL_F_* flags that were previously passed in or'd
	      into the mode.  This was split to hopefully allow future
	      extensions additional mode/flag space.
pol_nodes:    the nodemask to apply for the memory policy
pol_maxnodes: The max number of nodes described by pol_nodes
home_node:    if MPOL_MF_HOME_NODE, set home node of policy to this
vec:          the vector of (address, len) memory ranges to operate on
vlen:         the number of entries in vec

The semantics are otherwise the same as mbind(), except that
the home_node can be set, and all address ranges defined by
vec/vlen will be operated on.

Valid flags for mbind2 include the same flags as mbind, plus
MPOL_MF_HOME_NODE, which informs the syscall to utilize the value
of mpol_args->home_node to set the mempolicy home node.

Suggested-by: Michal Hocko <mhocko@suse.com>
Suggested-by: Frank van der Linden <fvdl@google.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Rakie Kim <rakie.kim@sk.com>
Suggested-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 12 +++-
 arch/alpha/kernel/syscalls/syscall.tbl        |  1 +
 arch/arm/tools/syscall.tbl                    |  1 +
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
 include/linux/syscalls.h                      |  3 +
 include/uapi/asm-generic/unistd.h             |  4 +-
 include/uapi/linux/mempolicy.h                |  5 +-
 mm/mempolicy.c                                | 68 +++++++++++++++++++
 19 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index a52624ab659a..f1ba33de3a6e 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -475,12 +475,18 @@ Install VMA/Shared Policy for a Range of Task's Address Space::
 	long mbind(void *start, unsigned long len, int mode,
 		   const unsigned long *nmask, unsigned long maxnode,
 		   unsigned flags);
+	long mbind2(struct iovec *vec, size_t vlen, struct mpol_args args,
+		    size_t size, unsigned long flags);
 
 mbind() installs the policy specified by (mode, nmask, maxnodes) as a
 VMA policy for the range of the calling task's address space specified
 by the 'start' and 'len' arguments.  Additional actions may be
 requested via the 'flags' argument.
 
+mbind2() is an extended version of mbind() capable of operating on multiple
+memory ranges in one syscall, and which is capable of setting the home node
+for the memory policy without an additional call to set_mempolicy_home_node()
+
 See the mbind(2) man page for more details.
 
 Set home node for a Range of Task's Address Spacec::
@@ -496,6 +502,9 @@ closest to which page allocation will come from. Specifying the home node overri
 the default allocation policy to allocate memory close to the local node for an
 executing CPU.
 
+mbind2() also provides a way for the home node to be set at the time the
+mempolicy is set. See the mbind(2) man page for more details.
+
 Extended Mempolicy Arguments::
 
 	struct mpol_args {
@@ -512,7 +521,8 @@ Extended Mempolicy Arguments::
 The extended mempolicy argument structure is defined to allow the mempolicy
 interfaces future extensibility without the need for additional system calls.
 
-Extended interfaces (set_mempolicy2 and get_mempolicy2) use this structure.
+Extended interfaces (set_mempolicy2, get_mempolicy2, and mbind2) use this
+this argument structure.
 
 The core arguments (mode, mode_flags, pol_nodes, and pol_maxnodes) apply to
 all interfaces relative to their non-extended counterparts. Each additional
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 0301a8b0a262..e8239293c35a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -498,3 +498,4 @@
 566	common	futex_requeue			sys_futex_requeue
 567	common	set_mempolicy2			sys_set_mempolicy2
 568	common	get_mempolicy2			sys_get_mempolicy2
+569	common	mbind2				sys_mbind2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 771a33446e8e..a3f39750257a 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -472,3 +472,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 048a409e684c..9a12dface18e 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -458,3 +458,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 327b01bd6793..6cb740123137 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -464,3 +464,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 921d58e1da23..52cf720f8ae2 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -397,3 +397,4 @@
 456	n32	futex_requeue			sys_futex_requeue
 457	n32	set_mempolicy2			sys_set_mempolicy2
 458	n32	get_mempolicy2			sys_get_mempolicy2
+459	n32	mbind2				sys_mbind2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 9271c83c9993..fd37c5301a48 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -446,3 +446,4 @@
 456	o32	futex_requeue			sys_futex_requeue
 457	o32	set_mempolicy2			sys_set_mempolicy2
 458	o32	get_mempolicy2			sys_get_mempolicy2
+459	o32	mbind2				sys_mbind2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 0654f3f89fc7..fcd67bc405b1 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -457,3 +457,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index ac11d2064e7a..89715417014c 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -545,3 +545,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 1cdcafe1ccca..c8304e0d0aa7 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
 457  common	set_mempolicy2		sys_set_mempolicy2		sys_set_mempolicy2
 458  common	get_mempolicy2		sys_get_mempolicy2		sys_get_mempolicy2
+459  common	mbind2			sys_mbind2			sys_mbind2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index f71742024c29..e5c51b6c367f 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 2fbf5dbe0620..74527f585500 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -504,3 +504,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0af813b9a118..be2e2aa17dd8 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -463,3 +463,4 @@
 456	i386	futex_requeue		sys_futex_requeue
 457	i386	set_mempolicy2		sys_set_mempolicy2
 458	i386	get_mempolicy2		sys_get_mempolicy2
+459	i386	mbind2			sys_mbind2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 0b777876fc15..6e2347eb8773 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -380,6 +380,7 @@
 456	common	futex_requeue		sys_futex_requeue
 457	common	set_mempolicy2		sys_set_mempolicy2
 458	common	get_mempolicy2		sys_get_mempolicy2
+459	common	mbind2			sys_mbind2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 4536c9a4227d..f00a21317dc0 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -429,3 +429,4 @@
 456	common	futex_requeue			sys_futex_requeue
 457	common	set_mempolicy2			sys_set_mempolicy2
 458	common	get_mempolicy2			sys_get_mempolicy2
+459	common	mbind2				sys_mbind2
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 774512b7934e..487dd9155b25 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -816,6 +816,9 @@ asmlinkage long sys_mbind(unsigned long start, unsigned long len,
 				const unsigned long __user *nmask,
 				unsigned long maxnode,
 				unsigned flags);
+asmlinkage long sys_mbind2(const struct iovec __user *vec, size_t vlen,
+			   const struct mpol_args __user *uargs, size_t usize,
+			   unsigned long flags);
 asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long __user *nmask,
 				unsigned long maxnode,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 719accc731db..cd31599bb9cc 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -832,9 +832,11 @@ __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 __SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
 #define __NR_get_mempolicy2 458
 __SYSCALL(__NR_get_mempolicy2, sys_get_mempolicy2)
+#define __NR_mbind2 459
+__SYSCALL(__NR_mbind2, sys_mbind2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 459
+#define __NR_syscalls 460
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 00a673e30047..506ea0f8f34e 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -56,13 +56,14 @@ struct mpol_args {
 #define MPOL_F_ADDR	(1<<1)	/* look up vma using address */
 #define MPOL_F_MEMS_ALLOWED (1<<2) /* return allowed memories */
 
-/* Flags for mbind */
+/* Flags for mbind/mbind2 */
 #define MPOL_MF_STRICT	(1<<0)	/* Verify existing pages in the mapping */
 #define MPOL_MF_MOVE	 (1<<1)	/* Move pages owned by this process to conform
 				   to policy */
 #define MPOL_MF_MOVE_ALL (1<<2)	/* Move every page to conform to policy */
 #define MPOL_MF_LAZY	 (1<<3)	/* UNSUPPORTED FLAG: Lazy migrate on fault */
-#define MPOL_MF_INTERNAL (1<<4)	/* Internal flags start here */
+#define MPOL_MF_HOME_NODE (1<<4)	/* mbind2: set home node */
+#define MPOL_MF_INTERNAL (1<<5)	/* Internal flags start here */
 
 #define MPOL_MF_VALID	(MPOL_MF_STRICT   | 	\
 			 MPOL_MF_MOVE     | 	\
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index cfe22156ef13..8f609204fbe7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1600,6 +1600,74 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 	return kernel_mbind(start, len, mode, nmask, maxnode, flags);
 }
 
+SYSCALL_DEFINE5(mbind2, const struct iovec __user *, vec, size_t, vlen,
+		const struct mpol_args __user *, uargs, size_t, usize,
+		unsigned long, flags)
+{
+	struct mpol_args kargs;
+	struct mempolicy_args margs;
+	nodemask_t policy_nodes;
+	unsigned long __user *nodes_ptr;
+	struct iovec iovstack[UIO_FASTIOV];
+	struct iovec *iov = iovstack;
+	struct iov_iter iter;
+	int err;
+
+	if (!vec || !vlen)
+		return -EINVAL;
+
+	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
+	if (err)
+		return -EINVAL;
+
+	err = validate_mpol_flags(kargs.mode, &kargs.mode_flags);
+	if (err)
+		return err;
+
+	margs.mode = kargs.mode;
+	margs.mode_flags = kargs.mode_flags;
+	margs.addr = kargs.addr;
+
+	/* if home node given, validate it is online */
+	if (flags & MPOL_MF_HOME_NODE) {
+		if ((kargs.home_node >= MAX_NUMNODES) ||
+			!node_online(kargs.home_node))
+			return -EINVAL;
+		margs.home_node = kargs.home_node;
+	} else
+		margs.home_node = NUMA_NO_NODE;
+	flags &= ~MPOL_MF_HOME_NODE;
+
+	if (kargs.pol_nodes) {
+		nodes_ptr = u64_to_user_ptr(kargs.pol_nodes);
+		err = get_nodes(&policy_nodes, nodes_ptr,
+				kargs.pol_maxnodes);
+		if (err)
+			return err;
+		margs.policy_nodes = &policy_nodes;
+	} else
+		margs.policy_nodes = NULL;
+
+	/* For each address range in vector, do_mbind */
+	err = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack), &iov,
+			   &iter);
+	if (err)
+		return err;
+	while (iov_iter_count(&iter)) {
+		unsigned long start, len;
+
+		start = untagged_addr((unsigned long)iter_iov_addr(&iter));
+		len = iter_iov_len(&iter);
+		err = do_mbind(start, len, &margs, flags);
+		if (err)
+			break;
+		iov_iter_advance(&iter, iter_iov_len(&iter));
+	}
+
+	kfree(iov);
+	return err;
+}
+
 /* Set the process memory policy */
 static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 				 unsigned long maxnode)
-- 
2.39.1


