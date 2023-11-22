Return-Path: <linux-fsdevel+bounces-3484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE157F5241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 22:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733F028188F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADA51C297;
	Wed, 22 Nov 2023 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6hm5JNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7FED71;
	Wed, 22 Nov 2023 13:12:27 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6cbc8199a2aso239252b3a.1;
        Wed, 22 Nov 2023 13:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700687546; x=1701292346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efc4LuxM+YClZeP0rF1BlV0TPdiTLe9TrsONK1dWGk4=;
        b=m6hm5JNStM0VWz+yvsA2T8+kuwVKJTjnNsyxYW0UBVYQR9VRzwQMOlRMW4gO4FVny+
         IuMUCSrYVu+kBczaLEpQFBrxnLlkuJIQcCWiDHYMtir4Atr2UIdQ8rvnIKOAH4VzGNgy
         TSxDRnw9LpeHDDZ1hmtBCUGhi0z7nLMNF2UCFWsWJXLE0SSmiSNV827X6ZLO3k2GCnxE
         wLJNS8sdXVo5Yf+bQZGCpnobEqmtClbsP6ESb0KG3qmoE/ulv1w5je6rTvbR1R7QNiGh
         v/aD0P+jx808rifVYlcwutiDAJXCq7RVwlGrwXTDYD7sadvjfmbFmMIhn1kljsgRqJWn
         aUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687546; x=1701292346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efc4LuxM+YClZeP0rF1BlV0TPdiTLe9TrsONK1dWGk4=;
        b=biRxU4sNL1MAAiG2lS+5X5+gkAHROBEV7IRX7INFQxwAnsiTi1rmqI5dXOvgO0gNtg
         sJkZYE+K0H7v/QnNxs+V3H0+hmOmi71VVTBkNpT+AwGYLyW3IwpLHAr9KBaTKZ8GueWd
         Ya98MieTnsH8QsFP2G1WPivjKkN4uKkpFcx+oUSpn1BxDlub1dhU/D7ZsaLhYSnk+QpX
         w8YzNdUqkwD0BkCuCw/k78aW3Jz06Vo4fztZoy0PwtxZlrvzQCZWkYJOQMSng04FkEzo
         hayCofMR9xYa2IEwjAjVh6OqmP+e3G0dYpseTQ/wQyfGu0SG24RgnB7cxekOyQ7P6gKg
         bM8w==
X-Gm-Message-State: AOJu0Yz5erGOqSOXIveiR/tcUMxgMbG3WVW/ien6vnTRL0t51J66O2YQ
	iqAtZworklb1a4DkwatPdQ==
X-Google-Smtp-Source: AGHT+IFyLKi/UX8cG8JtNK31D46LnIz+FKATE0AdMLHzg0L0sgRXSVvqGSyPkTSkfLO98TY33r1+qg==
X-Received: by 2002:a05:6a00:800d:b0:6c4:dc5b:5b2b with SMTP id eg13-20020a056a00800d00b006c4dc5b5b2bmr3826752pfb.20.1700687546091;
        Wed, 22 Nov 2023 13:12:26 -0800 (PST)
Received: from fedora.mshome.net ([75.167.214.230])
        by smtp.gmail.com with ESMTPSA id j18-20020a635512000000b005bdbce6818esm132136pgb.30.2023.11.22.13.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:12:25 -0800 (PST)
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
	Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 07/11] mm/mempolicy: add task mempolicy syscall variants
Date: Wed, 22 Nov 2023 16:11:56 -0500
Message-Id: <20231122211200.31620-8-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231122211200.31620-1-gregory.price@memverge.com>
References: <20231122211200.31620-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add system calls to allow one task to view or change another task's
mempolicy settings. The task mempolicy has traditionally been a feature
that could only be changed by the task itself.  This creates issues
with task migrations between cgroups where cpusets may differ.

Attempts were made to allow policy nodemasks to be shifted via a flag
(MPOL_F_RELATIVE_NODES), but this is not foolproof.

Additionally, as new policies emerge (like weighted interleave), it
may be necessary to allow not just the policy to be changed, but
individual attributes of the policy (such as a node weight) in
response to other system events - such as memory hotplug.

If pid is 0, this behaves the same as the original mempolicy syscalls,
otherwise this interface requires CAP_SYS_NICE.

Syscalls in this patch:
	sys_set_task_mempolicy
	sys_get_task_mempolicy
	sys_set_task_mempolicy_home_node
	sys_task_mbind

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   4 +
 arch/x86/entry/syscalls/syscall_64.tbl |   4 +
 include/linux/syscalls.h               |  14 +++
 include/uapi/asm-generic/unistd.h      |  10 ++-
 include/uapi/linux/mempolicy.h         |  10 +++
 mm/mempolicy.c                         | 119 +++++++++++++++++++++++++
 6 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c8fac5205803..358bd91d7461 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -461,3 +461,7 @@
 454	i386	futex_wake		sys_futex_wake
 455	i386	futex_wait		sys_futex_wait
 456	i386	futex_requeue		sys_futex_requeue
+457	i386	set_task_mempolicy	sys_set_task_mempolicy
+458	i386	get_task_mempolicy	sys_get_task_mempolicy
+459	i386	set_task_mempolicy_home_node	sys_set_task_mempolicy_home_node
+460	i386	task_mbind		sys_task_mbind
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c..c83b0c5c1ff9 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -378,6 +378,10 @@
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
+457	common	set_task_mempolicy	sys_set_task_mempolicy
+458	common	get_task_mempolicy	sys_get_task_mempolicy
+459	common	set_task_mempolicy_home_node	sys_set_task_mempolicy_home_node
+460	common	task_mbind		sys_task_mbind
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fd9d12de7e92..fd1a8863b5c1 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -816,12 +816,21 @@ asmlinkage long sys_mbind(unsigned long start, unsigned long len,
 				const unsigned long __user *nmask,
 				unsigned long maxnode,
 				unsigned flags);
+asmlinkage long sys_task_mbind(const struct mbind_args __user *uargs,
+			       size_t usize);
 asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long __user *nmask,
 				unsigned long maxnode,
 				unsigned long addr, unsigned long flags);
 asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
 				unsigned long maxnode);
+asmlinkage long sys_get_task_mempolicy(pid_t pid, int __user *policy,
+				unsigned long __user *nmask,
+				unsigned long maxnode,
+				unsigned long addr, unsigned long flags);
+asmlinkage long sys_set_task_mempolicy(pid_t pid, int mode,
+				       const unsigned long __user *nmask,
+				       unsigned long maxnode);
 asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
 				const unsigned long __user *from,
 				const unsigned long __user *to);
@@ -945,6 +954,11 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_set_task_mempolicy_home_node(pid_t pid,
+						 unsigned long start,
+						 unsigned long len,
+						 unsigned long home_node,
+						 unsigned long flags);
 asmlinkage long sys_cachestat(unsigned int fd,
 		struct cachestat_range __user *cstat_range,
 		struct cachestat __user *cstat, unsigned int flags);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 756b013fb832..f179715f1d59 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -828,9 +828,17 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
+#define __NR_set_task_mempolicy 457
+__SYSCALL(__NR_set_task_mempolicy, sys_set_task_mempolicy)
+#define __NR_get_task_mempolicy 458
+__SYSCALL(__NR_get_task_mempolicy, sys_get_task_mempolicy)
+#define __NR_set_task_mempolicy_home_node 459
+__SYSCALL(__NR_set_task_mempolicy_home_node, sys_set_task_mempolicy_home_node)
+#define __NR_task_mbind 460
+__SYSCALL(__NR_task_mbind, sys_task_mbind)
 
 #undef __NR_syscalls
-#define __NR_syscalls 457
+#define __NR_syscalls 461
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index a8963f7ef4c2..c29cfb25db29 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -26,6 +26,16 @@ enum {
 	MPOL_MAX,	/* always last member of enum */
 };
 
+struct mbind_args {
+	pid_t pid;
+	unsigned long start;
+	unsigned long len;
+	unsigned long mode;
+	unsigned long *nmask;
+	unsigned long maxnode;
+	unsigned int flags;
+};
+
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3d2171ac4098..fb295ade8ad7 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1654,6 +1654,32 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 	return __set_mempolicy_home_node(current, start, len, home_node, flags);
 }
 
+SYSCALL_DEFINE5(set_task_mempolicy_home_node, pid_t, pid, unsigned long, start,
+		unsigned long, len, unsigned long, home_node,
+		unsigned long, flags)
+{
+	struct task_struct *task;
+	int err;
+
+	if (pid && !capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	rcu_read_lock();
+	task = pid ? find_task_by_vpid(pid) : current;
+	if (!task) {
+		rcu_read_unlock();
+		err = -ESRCH;
+		goto out;
+	}
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	err = __set_mempolicy_home_node(task, start, len, home_node, flags);
+	put_task_struct(task);
+out:
+	return err;
+}
+
 SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 		unsigned long, mode, const unsigned long __user *, nmask,
 		unsigned long, maxnode, unsigned int, flags)
@@ -1661,6 +1687,48 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 	return kernel_mbind(current, start, len, mode, nmask, maxnode, flags);
 }
 
+static long kernel_task_mbind(const struct mbind_args __user *uargs,
+			      size_t usize)
+{
+	struct mbind_args kargs;
+	struct task_struct *task;
+	int err;
+
+	if (usize < sizeof(kargs))
+		return -EINVAL;
+
+	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
+	if (err)
+		return err;
+
+
+	if (kargs.pid && !capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	rcu_read_lock();
+	task = kargs.pid ? find_task_by_vpid(kargs.pid) : current;
+	if (!task) {
+		rcu_read_unlock();
+		err = -ESRCH;
+		goto out;
+	}
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	err = kernel_mbind(task, kargs.start, kargs.len, kargs.mode,
+			   kargs.nmask, kargs.maxnode, kargs.flags);
+
+	put_task_struct(task);
+out:
+	return err;
+}
+
+SYSCALL_DEFINE2(task_mbind, const struct mbind_args __user *, args,
+		size_t, size)
+{
+	return kernel_task_mbind(args, size);
+}
+
 /* Set the process memory policy */
 static long kernel_set_mempolicy(struct task_struct *task, int mode,
 				 const unsigned long __user *nmask,
@@ -1688,6 +1756,31 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
 	return kernel_set_mempolicy(current, mode, nmask, maxnode);
 }
 
+SYSCALL_DEFINE4(set_task_mempolicy, pid_t, pid, int, mode,
+		const unsigned long __user *, nmask, unsigned long, maxnode)
+{
+	struct task_struct *task;
+	int err;
+
+	if (pid && !capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	rcu_read_lock();
+	task = pid ? find_task_by_vpid(pid) : current;
+	if (!task) {
+		rcu_read_unlock();
+		err = -ESRCH;
+		goto out;
+	}
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	err = kernel_set_mempolicy(task, mode, nmask, maxnode);
+	put_task_struct(task);
+out:
+	return err;
+}
+
 static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 				const unsigned long __user *old_nodes,
 				const unsigned long __user *new_nodes)
@@ -1821,6 +1914,32 @@ SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 				    flags);
 }
 
+SYSCALL_DEFINE6(get_task_mempolicy, pid_t, pid, int __user *, policy,
+		unsigned long __user *, nmask, unsigned long, maxnode,
+		unsigned long, addr, unsigned long, flags)
+{
+	struct task_struct *task;
+	int err;
+
+	if (pid && !capable(CAP_SYS_NICE))
+		return -EPERM;
+
+	rcu_read_lock();
+	task = pid ? find_task_by_vpid(pid) : current;
+	if (!task) {
+		rcu_read_unlock();
+		err = -ESRCH;
+		goto out;
+	}
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	err = kernel_get_mempolicy(task, policy, nmask, maxnode, addr, flags);
+	put_task_struct(task);
+out:
+	return err;
+}
+
 bool vma_migratable(struct vm_area_struct *vma)
 {
 	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
-- 
2.39.1


