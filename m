Return-Path: <linux-fsdevel+bounces-66679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D97AAC28623
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 20:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEC794EE1D6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 19:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E530101D;
	Sat,  1 Nov 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Q3V8++I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y7sVe5FL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334E82FF678;
	Sat,  1 Nov 2025 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024856; cv=none; b=iSJUMkL32R+/094n8OO7KA5i+hQPGUW7rNVxSJaspJA+lovf/uMDSzAgdAUA4tLZSj1cRO1R0bXhY4sB92Y6uRdRJqICCyrC0slcKe3FEsUzTyicJOwA1dAxZMwfOZDbD5XNoXIFyTS2m84+38TB3uu5eHBRoF1Z2SHOOFBhpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024856; c=relaxed/simple;
	bh=KHDhI+OMbYsFp6vu64Dav6dGQ4hKGh0ZnHirB5dDyjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ccPqIIH4+Rig4vsSRMC7Er+Vsv6ZwUbh/3ZaKN8hsGr0Sgxp0Mi9B37f81LZBReNwCAwaScb+akdD3ByyzqDEw8cbzCVICI+9B+EZhozQE0Mb9VudEgGvX87rhFCBAkAR6mrmu4mSXs+kwjOhTCQKiNbfbtSllT9HlNooibv92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Q3V8++I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y7sVe5FL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762024852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhGK+60JgBD3s2NPs/WG00WWgCrD3JAI9aGx3Giow6U=;
	b=4Q3V8++IhPzdnCkY/fLpB838bS06LVS94OomrBx0h8qStWpHMqKWCW7j3ayeDgp5U0Lo/o
	F+eq5PBK+kBuHixm5ic5qF0dA/DUmZ1MrUNzAo7FttEZuPrAzN9Bzo8DxZM1Me6JgPXR42
	bd7fUT2D+vvzoQ8rYAboiMu1rOqt4/bM+p0UPIVOd13XLnr2+1lXWXq6dN8HEyX63uQvDG
	YMGO6RzlzV2FncmPvQhB/oqPIK2uK0CKd+qE61wRVtsn0LfBbEhnqql3O3cjOpXguhyt9e
	L7TETIY2pp3GHotPjDUBWjvuikX2V/O9q40/uAEYspHz64dZunswmNCX7hLAtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762024852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zhGK+60JgBD3s2NPs/WG00WWgCrD3JAI9aGx3Giow6U=;
	b=Y7sVe5FL9smASbvnWfH1rQIQ1Cxz51UnrlRZ8UUXPH2YhpFaoGbhA2mwjMjxokyAuxFRtd
	t2+fvCz4NdQZAqDA==
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering
 <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa
 Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 18/72] nstree: add unified namespace list
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-18-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
 <20251029-work-namespace-nstree-listns-v4-18-2e6f823ebdc0@kernel.org>
Date: Sat, 01 Nov 2025 20:20:50 +0100
Message-ID: <87ecqhy2y5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian!

On Wed, Oct 29 2025 at 13:20, Christian Brauner wrote:
> --- a/kernel/time/namespace.c
> +++ b/kernel/time/namespace.c
> @@ -488,6 +488,7 @@ struct time_namespace init_time_ns = {
>  	.ns.ns_owner = LIST_HEAD_INIT(init_time_ns.ns.ns_owner),
>  	.frozen_offsets	= true,
>  	.ns.ns_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_list_node),
> +	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_unified_list_node),

Sorry that I did not catch that earlier, but

  1) this screws up the proper tabular struct initializer

  2) the churn of touching every compile time struct each time you add a
     new field and add the same stupid initialization to each of them
     can be avoided, when you do something like the uncompiled below.
     You get the idea.

Thanks,

        tglx
---
 fs/namespace.c            |    9 +--------
 include/linux/ns_common.h |   12 ++++++++++++
 init/version-timestamp.c  |    9 +--------
 ipc/msgutil.c             |    9 +--------
 kernel/pid.c              |    8 +-------
 kernel/time/namespace.c   |    9 +--------
 kernel/user.c             |    9 +--------
 7 files changed, 18 insertions(+), 47 deletions(-)

--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5985,19 +5985,12 @@ SYSCALL_DEFINE4(listmount, const struct
 }
 
 struct mnt_namespace init_mnt_ns = {
-	.ns.inum	= ns_init_inum(&init_mnt_ns),
+	.ns		= NS_COMMON_INIT(init_mnt_ns, 1, 1),
 	.ns.ops		= &mntns_operations,
 	.user_ns	= &init_user_ns,
-	.ns.__ns_ref	= REFCOUNT_INIT(1),
-	.ns.__ns_ref_active = ATOMIC_INIT(1),
-	.ns.ns_type	= ns_common_type(&init_mnt_ns),
 	.passive	= REFCOUNT_INIT(1),
 	.mounts		= RB_ROOT,
 	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
-	.ns.ns_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_list_node),
-	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_unified_list_node),
-	.ns.ns_owner_entry = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner_entry),
-	.ns.ns_owner = LIST_HEAD_INIT(init_mnt_ns.ns.ns_owner),
 };
 
 static void __init init_mount_tree(void)
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -129,6 +129,18 @@ struct ns_common {
 	};
 };
 
+#define NS_COMMON_INIT(nsname, refs, active)						\
+{											\
+	.ns_type		= ns_common_type(&nsname),				\
+	.inum			= ns_init_inum(&nsname),				\
+	.__ns_ref		= REFCOUNT_INIT(refs),					\
+	.__ns_ref_active	= ATOMIC_INIT(active),					\
+	.ns_list_node		= LIST_HEAD_INIT(nsname.ns.ns_list_node),		\
+	.ns_unified_list_node	= LIST_HEAD_INIT(nsname.ns.ns_unified_list_node),	\
+	.ns_owner_entry		= LIST_HEAD_INIT(nsname.ns.ns_owner_entry),		\
+	.ns_owner		= LIST_HEAD_INIT(nsname.ns.ns_owner),			\
+}
+
 int __ns_common_init(struct ns_common *ns, u32 ns_type, const struct proc_ns_operations *ops, int inum);
 void __ns_common_free(struct ns_common *ns);
 
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -8,9 +8,7 @@
 #include <linux/utsname.h>
 
 struct uts_namespace init_uts_ns = {
-	.ns.ns_type = ns_common_type(&init_uts_ns),
-	.ns.__ns_ref = REFCOUNT_INIT(2),
-	.ns.__ns_ref_active = ATOMIC_INIT(1),
+	.ns = NS_COMMON_INIT(init_uts_ns, 2, 1),
 	.name = {
 		.sysname	= UTS_SYSNAME,
 		.nodename	= UTS_NODENAME,
@@ -20,11 +18,6 @@ struct uts_namespace init_uts_ns = {
 		.domainname	= UTS_DOMAINNAME,
 	},
 	.user_ns = &init_user_ns,
-	.ns.inum = ns_init_inum(&init_uts_ns),
-	.ns.ns_list_node = LIST_HEAD_INIT(init_uts_ns.ns.ns_list_node),
-	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_uts_ns.ns.ns_unified_list_node),
-	.ns.ns_owner_entry = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner_entry),
-	.ns.ns_owner = LIST_HEAD_INIT(init_uts_ns.ns.ns_owner),
 #ifdef CONFIG_UTS_NS
 	.ns.ops = &utsns_operations,
 #endif
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -27,18 +27,11 @@ DEFINE_SPINLOCK(mq_lock);
  * and not CONFIG_IPC_NS.
  */
 struct ipc_namespace init_ipc_ns = {
-	.ns.__ns_ref = REFCOUNT_INIT(1),
-	.ns.__ns_ref_active = ATOMIC_INIT(1),
+	.ns = NS_COMMON_INIT(init_ipc_ns, 1, 1),
 	.user_ns = &init_user_ns,
-	.ns.inum = ns_init_inum(&init_ipc_ns),
-	.ns.ns_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_list_node),
-	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_unified_list_node),
-	.ns.ns_owner_entry = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner_entry),
-	.ns.ns_owner = LIST_HEAD_INIT(init_ipc_ns.ns.ns_owner),
 #ifdef CONFIG_IPC_NS
 	.ns.ops = &ipcns_operations,
 #endif
-	.ns.ns_type = ns_common_type(&init_ipc_ns),
 };
 
 struct msg_msgseg {
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -71,18 +71,12 @@ static int pid_max_max = PID_MAX_LIMIT;
  * the scheme scales to up to 4 million PIDs, runtime.
  */
 struct pid_namespace init_pid_ns = {
-	.ns.__ns_ref = REFCOUNT_INIT(2),
-	.ns.__ns_ref_active = ATOMIC_INIT(1),
+	.ns = NS_COMMON_INIT(init_pid_ns, 2, 1),
 	.idr = IDR_INIT(init_pid_ns.idr),
 	.pid_allocated = PIDNS_ADDING,
 	.level = 0,
 	.child_reaper = &init_task,
 	.user_ns = &init_user_ns,
-	.ns.inum = ns_init_inum(&init_pid_ns),
-	.ns.ns_list_node = LIST_HEAD_INIT(init_pid_ns.ns.ns_list_node),
-	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_pid_ns.ns.ns_unified_list_node),
-	.ns.ns_owner_entry = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner_entry),
-	.ns.ns_owner = LIST_HEAD_INIT(init_pid_ns.ns.ns_owner),
 #ifdef CONFIG_PID_NS
 	.ns.ops = &pidns_operations,
 #endif
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -478,17 +478,10 @@ const struct proc_ns_operations timens_f
 };
 
 struct time_namespace init_time_ns = {
-	.ns.ns_type	= ns_common_type(&init_time_ns),
-	.ns.__ns_ref	= REFCOUNT_INIT(3),
-	.ns.__ns_ref_active = ATOMIC_INIT(1),
+	.ns		= NS_COMMON_INIT(init_time_ns, 3, 1),
 	.user_ns	= &init_user_ns,
-	.ns.inum	= ns_init_inum(&init_time_ns),
 	.ns.ops		= &timens_operations,
-	.ns.ns_owner_entry = LIST_HEAD_INIT(init_time_ns.ns.ns_owner_entry),
-	.ns.ns_owner = LIST_HEAD_INIT(init_time_ns.ns.ns_owner),
 	.frozen_offsets	= true,
-	.ns.ns_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_list_node),
-	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_unified_list_node),
 };
 
 void __init time_ns_init(void)
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -65,16 +65,9 @@ struct user_namespace init_user_ns = {
 			.nr_extents = 1,
 		},
 	},
-	.ns.ns_type = ns_common_type(&init_user_ns),
-	.ns.__ns_ref = REFCOUNT_INIT(3),
-	.ns.__ns_ref_active = ATOMIC_INIT(1),
+	.ns = NS_COMMON_INIT(init_user_ns, 3, 1),
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
-	.ns.inum = ns_init_inum(&init_user_ns),
-	.ns.ns_list_node = LIST_HEAD_INIT(init_user_ns.ns.ns_list_node),
-	.ns.ns_unified_list_node = LIST_HEAD_INIT(init_user_ns.ns.ns_unified_list_node),
-	.ns.ns_owner_entry = LIST_HEAD_INIT(init_user_ns.ns.ns_owner_entry),
-	.ns.ns_owner = LIST_HEAD_INIT(init_user_ns.ns.ns_owner),
 #ifdef CONFIG_USER_NS
 	.ns.ops = &userns_operations,
 #endif

