Return-Path: <linux-fsdevel+bounces-5405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EF080B294
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 08:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D944AB20EC5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B091FCE;
	Sat,  9 Dec 2023 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6j0+z2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE71FE6;
	Fri,  8 Dec 2023 23:00:11 -0800 (PST)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-5d34f8f211fso27274947b3.0;
        Fri, 08 Dec 2023 23:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702105211; x=1702710011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jYajdpOXFi/B/dNFku3CaKz4MM7mFJ22/+jEV7wLMU=;
        b=W6j0+z2NcPqjon8XouGzXKB4+xH4cj7iaBeZvEKfXRPdLbDG/E+Fsln76VSowEZ5W9
         ushC9QBXsJhzZmFfyEjES5jmYWGTeRlwXpUM/gtbKpqNrSqPidq7zmvxuoxVqwktSlK2
         nwGUgGmTqpkUMKqww01mDlkAjIwBcFP/E1V3JfQWhTR9RzEfnQZEJhlRHVUICj42bxry
         Vyk2lLRx/aG2xww4mTC6D5CuzDPGcxsDSeIt6X0xWQf/i1f4weB4x3sODW/Osg3PXla2
         XYvPAVtBFBc+Be8n995bkhr2Pl1UeEPEiBWoRhebK39TVEqk7HZcmdKYHD3SQ2Xm1lgE
         62eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702105211; x=1702710011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jYajdpOXFi/B/dNFku3CaKz4MM7mFJ22/+jEV7wLMU=;
        b=pQYq4SqfooPGUwg/aQ54Tcpb2PkDdv2X6vfyEQgeEN7IER6V1lO6CQP/zZgHyYTUmU
         TEwo2ePurIE5Tagp9v3Rc/6ts9M0I9SeVgLCG1yMek/Mgs5T7wVuDbkYV9i7ZXh1BLpz
         sV+tS5ygkFr5ZPmDL/lv7f9lsIzHaQZ1iyF9mPT5V+3kGfdGeopBOSJAxbXG/aDCQB5Q
         2cR6EetNzN/qwFD2c90o35OQ3aLSTCSTPH0RJhkKn76ZJaNLntmwkYrqSk5O1IGsbBMd
         s1s6p7F+S4REvHbi+GAKeMQkHmukwIbokCDF0Z6V09A13fZZfsuvq5NZgrKdTD48kb32
         nZxw==
X-Gm-Message-State: AOJu0YwHXZnyDvlOQiCaJieXcPZG1Zkm7K9F6mD8CGteIpFd84kfuC1P
	Br/tzUrBun/UGPNk9QepWw==
X-Google-Smtp-Source: AGHT+IF4HLQWZThd+U+NGJAyGUqIh0Nsy1W2x6Jmvx3yrk87lHkzFdoTufr1N2HCgYU1abpTa7t0eg==
X-Received: by 2002:a0d:cc05:0:b0:5d6:aea0:2232 with SMTP id o5-20020a0dcc05000000b005d6aea02232mr1034156ywd.19.1702105210686;
        Fri, 08 Dec 2023 23:00:10 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id x8-20020a81b048000000b005df5d592244sm326530ywk.78.2023.12.08.23.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 23:00:10 -0800 (PST)
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
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 09/11] mm/mempolicy: add get_mempolicy2 syscall
Date: Sat,  9 Dec 2023 01:59:30 -0500
Message-Id: <20231209065931.3458-10-gregory.price@memverge.com>
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

get_mempolicy2 is an extensible get_mempolicy interface which allows
a user to retrieve the memory policy for a task or address.

Defined as:

get_mempolicy2(struct mpol_args *args, size_t size, unsigned long flags)

Input values include the following fields of mpol_args:

pol_nodes:    if set, the nodemask of the policy returned here
pol_maxnodes: if pol_nodes is set, must describe max number of nodes
              to be copied to pol_nodes
addr:         if MPOL_F_ADDR is passed in `flags`, this address will be
              used to return the mempolicy details of the vma the
              address belongs to

flags:        if MPOL_F_MEMS_ALLOWED, returns mems_allowed in pol_nodes
              if MPOL_F_ADDR, return mempolicy info vma containing addr
              else, returns per-task mempolicy information

Output values include the following fields of mpol_args:

mode:         mempolicy mode
mode_flags:   mempolicy mode flags
pol_nodes:    if set, the nodemask for the mempolicy
policy_node:  if the policy has extended node information, it will
              be placed here.  For example MPOL_INTERLEAVE will
              return the next node which will be used for allocation
addr_node:    If MPOL_F_ADDR is set, the numa node that the address
              is located on will be returned.
home_node:    policy home node will be returned here, or -1 if not.

MPOL_F_NODE has been dropped from get_mempolicy2 (it is ignored) in
favor or returning explicit values in `policy_node` and `addr_node`.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     |  8 +++-
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
 include/linux/syscalls.h                      |  2 +
 include/uapi/asm-generic/unistd.h             |  4 +-
 mm/mempolicy.c                                | 47 +++++++++++++++++++
 18 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index aabc24db92d3..a52624ab659a 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -456,11 +456,17 @@ Get [Task] Memory Policy or Related Information::
 	long get_mempolicy(int *mode,
 			   const unsigned long *nmask, unsigned long maxnode,
 			   void *addr, int flags);
+	long get_mempolicy2(struct mpol_args args, size_t size,
+			    unsigned long flags);
 
 Queries the "task/process memory policy" of the calling task, or the
 policy or location of a specified virtual address, depending on the
 'flags' argument.
 
+get_mempolicy2() is an extended version of get_mempolicy() capable of
+acquiring extended information about a mempolicy, including those
+that can only be set via set_mempolicy2() or mbind2()..
+
 See the get_mempolicy(2) man page for more details
 
 
@@ -506,7 +512,7 @@ Extended Mempolicy Arguments::
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
index 3244cd990858..774512b7934e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -820,6 +820,8 @@ asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long __user *nmask,
 				unsigned long maxnode,
 				unsigned long addr, unsigned long flags);
+asmlinkage long sys_get_mempolicy2(struct mpol_args *args, size_t size,
+				   unsigned long flags);
 asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
 				unsigned long maxnode);
 asmlinkage long sys_set_mempolicy2(struct mpol_args *args, size_t size,
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
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a56ff02f780e..cfe22156ef13 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1859,6 +1859,53 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 	return kernel_get_mempolicy(policy, nmask, maxnode, addr, flags);
 }
 
+SYSCALL_DEFINE3(get_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
+		unsigned long, flags)
+{
+	struct mpol_args kargs;
+	struct mempolicy_args margs;
+	int err;
+	nodemask_t policy_nodemask;
+	unsigned long __user *nodes_ptr;
+
+	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
+	if (err)
+		return -EINVAL;
+
+	if (flags & MPOL_F_MEMS_ALLOWED) {
+		if (!margs.policy_nodes)
+			return -EINVAL;
+		err = do_get_mems_allowed(&policy_nodemask);
+		if (err)
+			return err;
+		nodes_ptr = u64_to_user_ptr(kargs.pol_nodes);
+		return copy_nodes_to_user(nodes_ptr, kargs.pol_maxnodes,
+					  &policy_nodemask);
+	}
+
+	margs.policy_nodes = kargs.pol_nodes ? &policy_nodemask : NULL;
+	if (flags & MPOL_F_ADDR) {
+		margs.addr = kargs.addr;
+		err = do_get_vma_mempolicy(&margs);
+	} else
+		err = do_get_task_mempolicy(&margs);
+
+	if (err)
+		return err;
+
+	kargs.mode = margs.mode;
+	kargs.mode_flags = margs.mode_flags;
+	kargs.policy_node = margs.policy_node;
+	kargs.addr_node = (flags & MPOL_F_ADDR) ? margs.addr_node : -1;
+	if (kargs.pol_nodes) {
+		nodes_ptr = u64_to_user_ptr(kargs.pol_nodes);
+		err = copy_nodes_to_user(nodes_ptr, kargs.pol_maxnodes,
+					 margs.policy_nodes);
+	}
+
+	return copy_to_user(uargs, &kargs, usize) ? -EFAULT : 0;
+}
+
 bool vma_migratable(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
-- 
2.39.1


