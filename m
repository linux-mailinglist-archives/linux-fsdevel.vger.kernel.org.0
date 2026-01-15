Return-Path: <linux-fsdevel+bounces-74014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19027D28B0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 22:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B9F303EB9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D52EB5A1;
	Thu, 15 Jan 2026 21:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lowcPClJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965F1FBC8E;
	Thu, 15 Jan 2026 21:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511954; cv=none; b=P5Eb4l010Gc27Zc39sauqV/gcNbOMiJqrVsNg/noyTBCh8qZVPFpZbCoUMiEn1jRoTRU+nAamzlRH1fS8psFfUtQQNftgncS0pH1bslqIcqgCFwhCanWeGIaMrfRJ8DSJL+NA9t/0BjZnTrC28TJJIPwaE5l5jvr+yZgolPTMyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511954; c=relaxed/simple;
	bh=NnZBugE8FoLOkcpgGCkhFLP7dotfRV71PDFjUALuJ30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sfn0e7nxh+W4XkRp+mLsHLSNoEfZwQKO74l/q0Ax0SYmp2xHCYkzVzr5AfQKyDNMXAEoqF1zwV294Zfc6CDH52ed5oQ1w9PghMGHFSLuNYC9JztnCQgbXYrerurNzyTjOJ+crRb7PiKkFB702sOd0W/L9JyTCtopgauCsPPZcCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lowcPClJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F77C116D0;
	Thu, 15 Jan 2026 21:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768511954;
	bh=NnZBugE8FoLOkcpgGCkhFLP7dotfRV71PDFjUALuJ30=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lowcPClJ5IlP8hwN09S0CLu6RRAD3eR/l+MZZYQnMj9v5sjnopilgToWMzCaD3Qmy
	 VQwXs4Q3FKH2srdu7NVYyjT8JQ+uI0+ihk27r+pdp8sDBzskck29TETrj0aI4JnG4b
	 ojQRal/3d5QwuuT7L/1oQXvGz7gxWQAU3F6CpFG2+Y6s8dkg1T1GxnfckozUeOUmnV
	 T02FDtq4st6i4AMChfKQUqGCpOE3xdHGF4HcSmr+0UtNOMfw5hsYT2ZPp6sHpbSH2i
	 g2HQypFRrXQQz/R+Z8BLvIX5jSBul/W/wWLrOsI7nPPCJJlCdPz3Ggcif058VUNFG0
	 w0jxWv9JVsx0g==
Message-ID: <4a1c24ae-29b0-4c3e-a055-789edfed32fc@kernel.org>
Date: Thu, 15 Jan 2026 22:19:08 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 PATCH 1/1] fs/proc: Expose mm_cpumask in /proc/[pid]/status
To: Aaron Tomlin <atomlin@atomlin.com>, oleg@redhat.com,
 akpm@linux-foundation.org, gregkh@linuxfoundation.org, brauner@kernel.org,
 mingo@kernel.org
Cc: neelx@suse.com, sean@ashe.io, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "x86@kernel.org" <x86@kernel.org>
References: <20260115205407.3050262-1-atomlin@atomlin.com>
 <20260115205407.3050262-2-atomlin@atomlin.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260115205407.3050262-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 21:54, Aaron Tomlin wrote:
> This patch introduces two new fields to /proc/[pid]/status to display the
> set of CPUs, representing the CPU affinity of the process's active
> memory context, in both mask and list format: "Cpus_active_mm" and
> "Cpus_active_mm_list". The mm_cpumask is primarily used for TLB and
> cache synchronisation.
> 
> Exposing this information allows userspace to easily describe the
> relationship between CPUs where a memory descriptor is "active" and the
> CPUs where the thread is allowed to execute. The primary intent is to
> provide visibility into the "memory footprint" across CPUs, which is
> invaluable for debugging performance issues related to IPI storms and
> TLB shootdowns in large-scale NUMA systems. The CPU-affinity sets the
> boundary; the mm_cpumask records the arrival; they complement each
> other.
> 
> Frequent mm_cpumask changes may indicate instability in placement
> policies or excessive task migration overhead.
> 
> These fields are exposed only on architectures that explicitly opt-in
> via CONFIG_ARCH_WANT_PROC_CPUS_ACTIVE_MM. This is necessary because
> mm_cpumask semantics vary significantly across architectures; some
> (e.g., x86) actively maintain the mask for coherency, while others may
> never clear bits, rendering the data misleading for this specific use
> case. x86 is updated to select this feature by default.
> 
> The implementation reads the mask directly without introducing additional
> locks or snapshots. While this implies that the hex mask and list format
> could theoretically observe slightly different states on a rapidly
> changing system, this "best-effort" approach aligns with the standard
> design philosophy of /proc and avoids imposing locking overhead on
> critical memory management paths.


Yes, restricting to architectures that have the expected semantics is 
better.

... but we better get the blessing from x86 folks :)

(CCing the x86 MM folks)


> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>   Documentation/filesystems/proc.rst |  7 +++++++
>   arch/x86/Kconfig                   |  1 +
>   fs/proc/Kconfig                    | 14 ++++++++++++++
>   fs/proc/array.c                    | 28 +++++++++++++++++++++++++++-
>   4 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 8256e857e2d7..c6ced84c5c68 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -291,12 +291,19 @@ It's slow but very precise.
>    SpeculationIndirectBranch   indirect branch speculation mode
>    Cpus_allowed                mask of CPUs on which this process may run
>    Cpus_allowed_list           Same as previous, but in "list format"
> + Cpus_active_mm              mask of CPUs on which this process has an active
> +                             memory context
> + Cpus_active_mm_list         Same as previous, but in "list format"
>    Mems_allowed                mask of memory nodes allowed to this process
>    Mems_allowed_list           Same as previous, but in "list format"
>    voluntary_ctxt_switches     number of voluntary context switches
>    nonvoluntary_ctxt_switches  number of non voluntary context switches
>    ==========================  ===================================================
>   
> +Note "Cpus_active_mm" is currently only supported on x86. Its semantics are
> +architecture-dependent; on x86, it represents the set of CPUs that may hold
> +stale TLB entries for the process and thus require IPI-based TLB shootdowns to
> +maintain coherency.
>   
>   .. table:: Table 1-3: Contents of the statm fields (as of 2.6.8-rc3)
>   
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 80527299f859..f0997791dbdb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -152,6 +152,7 @@ config X86
>   	select ARCH_WANTS_THP_SWAP		if X86_64
>   	select ARCH_HAS_PARANOID_L1D_FLUSH
>   	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
> +	select ARCH_WANT_PROC_CPUS_ACTIVE_MM
>   	select BUILDTIME_TABLE_SORT
>   	select CLKEVT_I8253
>   	select CLOCKSOURCE_WATCHDOG
> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> index 6ae966c561e7..952c40cf3baa 100644
> --- a/fs/proc/Kconfig
> +++ b/fs/proc/Kconfig
> @@ -127,3 +127,17 @@ config PROC_PID_ARCH_STATUS
>   config PROC_CPU_RESCTRL
>   	def_bool n
>   	depends on PROC_FS
> +
> +config ARCH_WANT_PROC_CPUS_ACTIVE_MM
> +	bool
> +	depends on PROC_FS
> +	help
> +	  Selected by architectures that reliably maintain mm_cpumask for TLB
> +	  and cache synchronisation and wish to expose it in
> +	  /proc/[pid]/status. Exposing this information allows userspace to
> +	  easily describe the relationship between CPUs where a memory
> +	  descriptor is "active" and the CPUs where the thread is allowed to
> +	  execute. The primary intent is to provide visibility into the
> +	  "memory footprint" across CPUs, which is invaluable for debugging
> +	  performance issues related to IPI storms and TLB shootdowns in
> +	  large-scale NUMA systems.
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 42932f88141a..c16aad59e0a7 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -409,6 +409,29 @@ static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
>   		   cpumask_pr_args(&task->cpus_mask));
>   }
>   
> +/**
> + * task_cpus_active_mm - Show the mm_cpumask for a process
> + * @m: The seq_file structure for the /proc/PID/status output
> + * @mm: The memory descriptor of the process
> + *
> + * Prints the set of CPUs, representing the CPU affinity of the process's
> + * active memory context, in both mask and list format. This mask is
> + * primarily used for TLB and cache synchronisation.
> + */
> +#ifdef CONFIG_ARCH_WANT_PROC_CPUS_ACTIVE_MM
> +static void task_cpus_active_mm(struct seq_file *m, struct mm_struct *mm)
> +{
> +	seq_printf(m, "Cpus_active_mm:\t%*pb\n",
> +		   cpumask_pr_args(mm_cpumask(mm)));
> +	seq_printf(m, "Cpus_active_mm_list:\t%*pbl\n",
> +		   cpumask_pr_args(mm_cpumask(mm)));
> +}
> +#else
> +static inline void task_cpus_active_mm(struct seq_file *m, struct mm_struct *mm)
> +{
> +}
> +#endif
> +
>   static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
>   {
>   	seq_put_decimal_ull(m, "CoreDumping:\t", !!task->signal->core_state);
> @@ -450,12 +473,15 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>   		task_core_dumping(m, task);
>   		task_thp_status(m, mm);
>   		task_untag_mask(m, mm);
> -		mmput(mm);
>   	}
>   	task_sig(m, task);
>   	task_cap(m, task);
>   	task_seccomp(m, task);
>   	task_cpus_allowed(m, task);
> +	if (mm) {
> +		task_cpus_active_mm(m, mm);
> +		mmput(mm);
> +	}
>   	cpuset_task_status_allowed(m, task);
>   	task_context_switch_counts(m, task);
>   	arch_proc_pid_thread_features(m, task);


-- 
Cheers

David

