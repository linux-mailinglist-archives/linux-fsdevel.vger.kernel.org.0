Return-Path: <linux-fsdevel+bounces-6014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2453C8121C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A923C1F21740
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 22:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518088185D;
	Wed, 13 Dec 2023 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHrRz53i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1141.google.com (mail-yw1-x1141.google.com [IPv6:2607:f8b0:4864:20::1141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4F131;
	Wed, 13 Dec 2023 14:41:37 -0800 (PST)
Received: by mail-yw1-x1141.google.com with SMTP id 00721157ae682-5e25d1d189eso346037b3.0;
        Wed, 13 Dec 2023 14:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702507296; x=1703112096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFZtjak2CwvvX5MkS8HUHtjjuq+Ft+krIgQ4CUvVabg=;
        b=eHrRz53i+z6fcLybYa8vNUfr1NyEeWOe/wLwss7GipiaXTwrePxiHc+uAg/zlQSN0Y
         x2bMIzFX9dcjbd9kKpEecCAJRPuisDukzCK7G0NZel1o80V19NaQAV2VWsg4el8D4JZ6
         2q/6L4W41qxC6RxttEW1Ux9qidZsbZrmuwNieiqoM5mzsTLUA4F2F73o0Jf7Fab9t73g
         u2Vp/qXNLhNkgC9MrVIFX8I7UBoJZjlXFaZDBC/qpadFswxY4tKR142ob9RLyka2jczy
         Yl7GnhY4EHNdUOhXrLz8ScQ39cI2odIY0Hl3IzmEOsZZJnN3oY8f/FprgyxXjRl5VWz3
         iAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702507296; x=1703112096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFZtjak2CwvvX5MkS8HUHtjjuq+Ft+krIgQ4CUvVabg=;
        b=EZxAvJlwNw8RgwzkvbdyV76I96aEDo9MFtjy3IHNDxk5JLJIqtVYwOsaf9U3Lj3MFs
         d8wdgMObE9Ov0qk2q2xyaiUA7W4HkWAkgWS0G30X0s+S7r+Rz5auOmZukxcXOp65Emwd
         ztdDt6S+TW74VtJMOYehaaJE0jkFKT0VAZBVauEDKKsFOfM+UGU2rJQQ/f/Yll+zjnG0
         ZbuDGSGiCgixmabF3fmeFlWZFnuQsQGWV4jXpUgXb5Hmf1EYGFQv3373kbUrC96N/QDV
         pkteOK43FcTVYzjzxldbAzXqF2Pat7lvWLjPWGkSd8VXeEbg1/tcZiW68RmMxOVhKNox
         6aRw==
X-Gm-Message-State: AOJu0YwDs+NoY/uBh8qbW+h/rAf+FVe44pvC2z88FusTMXnxFAfF74yJ
	wR61MiiATl6liM8icctBNg==
X-Google-Smtp-Source: AGHT+IHSK7U6o8BSRVd+yhL1FNHiRhJyBC/iU3XISLSgaJMQyDc/P+LL9/Y+Xk6PBoTI7w9Y5tChxg==
X-Received: by 2002:a0d:d909:0:b0:5d6:e87d:96c0 with SMTP id b9-20020a0dd909000000b005d6e87d96c0mr6888190ywe.1.1702507296621;
        Wed, 13 Dec 2023 14:41:36 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm5050583ywf.42.2023.12.13.14.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 14:41:36 -0800 (PST)
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
Subject: [PATCH v3 08/11] mm/mempolicy: add set_mempolicy2 syscall
Date: Wed, 13 Dec 2023 17:41:15 -0500
Message-Id: <20231213224118.1949-9-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231213224118.1949-1-gregory.price@memverge.com>
References: <20231213224118.1949-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_mempolicy2 is an extensible set_mempolicy interface which allows
a user to set the per-task memory policy.

Defined as:

set_mempolicy2(struct mpol_args *args, size_t size, unsigned long flags);

relevant mpol_args fields include the following:

mode:         The MPOL_* policy (DEFAULT, INTERLEAVE, etc.)
mode_flags:   The MPOL_F_* flags that were previously passed in or'd
              into the mode.  This was split to hopefully allow future
              extensions additional mode/flag space.
pol_nodes:    the nodemask to apply for the memory policy
pol_maxnodes: The max number of nodes described by pol_nodes

The usize arg is intended for the user to pass in sizeof(mpol_args)
to allow forward/backward compatibility whenever possible.

The flags argument is intended to future proof the syscall against
future extensions which may require interpreting the arguments in
the structure differently.

Semantics of `set_mempolicy` are otherwise the same as `set_mempolicy`
as of this patch.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     | 10 ++++++
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
 include/linux/syscalls.h                      |  2 ++
 include/uapi/asm-generic/unistd.h             |  4 ++-
 mm/mempolicy.c                                | 36 +++++++++++++++++++
 18 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index d5fcebdd7996..e57d400d0281 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -432,6 +432,8 @@ Set [Task] Memory Policy::
 
 	long set_mempolicy(int mode, const unsigned long *nmask,
 					unsigned long maxnode);
+	long set_mempolicy2(struct mpol_args args, size_t size,
+			    unsigned long flags);
 
 Set's the calling task's "task/process memory policy" to mode
 specified by the 'mode' argument and the set of nodes defined by
@@ -440,6 +442,12 @@ specified by the 'mode' argument and the set of nodes defined by
 'mode' argument with the flag (for example: MPOL_INTERLEAVE |
 MPOL_F_STATIC_NODES).
 
+set_mempolicy2() is an extended version of set_mempolicy() capable
+of setting a mempolicy which requires more information than can be
+passed via get_mempolicy().  For example, weighted interleave with
+task-local weights requires a weight array to be passed via the
+'mpol_args->il_weights' argument in the 'struct mpol_args' arg.
+
 See the set_mempolicy(2) man page for more details
 
 
@@ -496,6 +504,8 @@ Extended Mempolicy Arguments::
 The extended mempolicy argument structure is defined to allow the mempolicy
 interfaces future extensibility without the need for additional system calls.
 
+Extended interfaces (set_mempolicy2) use this argument structure.
+
 The core arguments (mode, mode_flags, pol_nodes, and pol_maxnodes) apply to
 all interfaces relative to their non-extended counterparts. Each additional
 field may only apply to specific extended interfaces.  See the respective
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 18c842ca6c32..0dc288a1118a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -496,3 +496,4 @@
 564	common	futex_wake			sys_futex_wake
 565	common	futex_wait			sys_futex_wait
 566	common	futex_requeue			sys_futex_requeue
+567	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 584f9528c996..50172ec0e1f5 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -470,3 +470,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 7a4b780e82cb..839d90c535f2 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 5b6a0b02b7de..567c8b883735 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -462,3 +462,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index a842b41c8e06..cc0640e16f2f 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -395,3 +395,4 @@
 454	n32	futex_wake			sys_futex_wake
 455	n32	futex_wait			sys_futex_wait
 456	n32	futex_requeue			sys_futex_requeue
+457	n32	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 525cc54bc63b..f7262fde98d9 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -444,3 +444,4 @@
 454	o32	futex_wake			sys_futex_wake
 455	o32	futex_wait			sys_futex_wait
 456	o32	futex_requeue			sys_futex_requeue
+457	o32	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index a47798fed54e..e10f0e8bd064 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 7fab411378f2..4f03f5f42b78 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -543,3 +543,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 86fec9b080f6..f98dadc2e9df 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 454  common	futex_wake		sys_futex_wake			sys_futex_wake
 455  common	futex_wait		sys_futex_wait			sys_futex_wait
 456  common	futex_requeue		sys_futex_requeue		sys_futex_requeue
+457  common	set_mempolicy2		sys_set_mempolicy2		sys_set_mempolicy2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 363fae0fe9bf..f47ba9f2d05d 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 7bcaa3d5ea44..53fb16616728 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -502,3 +502,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c8fac5205803..4b4dc41b24ee 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -461,3 +461,4 @@
 454	i386	futex_wake		sys_futex_wake
 455	i386	futex_wait		sys_futex_wait
 456	i386	futex_requeue		sys_futex_requeue
+457	i386	set_mempolicy2		sys_set_mempolicy2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c..1bc2190bec27 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -378,6 +378,7 @@
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
+457	common	set_mempolicy2		sys_set_mempolicy2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 06eefa9c1458..e26dc89399eb 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -427,3 +427,4 @@
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
 456	common	futex_requeue			sys_futex_requeue
+457	common	set_mempolicy2			sys_set_mempolicy2
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a52395ca3f00..451f0089601f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -823,6 +823,8 @@ asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long addr, unsigned long flags);
 asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
 				unsigned long maxnode);
+asmlinkage long sys_set_mempolicy2(struct mpol_args __user *args, size_t size,
+				   unsigned long flags);
 asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
 				const unsigned long __user *from,
 				const unsigned long __user *to);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 756b013fb832..55486aba099f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -828,9 +828,11 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
+#define __NR_set_mempolicy2 457
+__SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
 
 #undef __NR_syscalls
-#define __NR_syscalls 457
+#define __NR_syscalls 458
 
 /*
  * 32 bit systems traditionally used different
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 705ddf1ccdd9..4bf563f3732b 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1636,6 +1636,42 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
 	return kernel_set_mempolicy(mode, nmask, maxnode);
 }
 
+SYSCALL_DEFINE3(set_mempolicy2, struct mpol_args __user *, uargs, size_t, usize,
+		unsigned long, flags)
+{
+	struct mpol_args kargs;
+	struct mempolicy_args margs;
+	int err;
+	nodemask_t policy_nodemask;
+	unsigned long __user *nodes_ptr;
+
+	if (flags)
+		return -EINVAL;
+
+	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
+	if (err)
+		return err;
+
+	err = validate_mpol_flags(kargs.mode, &kargs.mode_flags);
+	if (err)
+		return err;
+
+	memset(&margs, 0, sizeof(margs));
+	margs.mode = kargs.mode;
+	margs.mode_flags = kargs.mode_flags;
+	if (kargs.pol_nodes) {
+		nodes_ptr = u64_to_user_ptr(kargs.pol_nodes);
+		err = get_nodes(&policy_nodemask, nodes_ptr,
+				kargs.pol_maxnodes);
+		if (err)
+			return err;
+		margs.policy_nodes = &policy_nodemask;
+	} else
+		margs.policy_nodes = NULL;
+
+	return do_set_mempolicy(&margs);
+}
+
 static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 				const unsigned long __user *old_nodes,
 				const unsigned long __user *new_nodes)
-- 
2.39.1


