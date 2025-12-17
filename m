Return-Path: <linux-fsdevel+bounces-71578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0481CC9166
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 18:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51BCD30391B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD33F340D90;
	Wed, 17 Dec 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj9NEYt0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA40C3346A0
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765992837; cv=none; b=BPyLcelC2oyW6TD+XdbhkJ8sflHIVpvkSlpBsjwYlnWAnHE3kyOW2jX3e/xFt/aoHPrDVRm/SDqEJKuLwVd4O3dWMNZweOsfAuqF6AneB3f7uL9HPOKHyS3uGHeVIooxfN3aVwvtvh4eOTFZRmakL8uOw7uctUz1h8krqxiwluU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765992837; c=relaxed/simple;
	bh=kuAZBCSnNBL9V/n+rhZ+YxfCpI1HKs034UQEsn8vyy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od2ktZXi8P2n6zEG1kQUEKbZdycXgfi/Eo9CPLuBua0ypt8Y+pmvYlzM+eHRAlrlj9j4XQxzwbPQFeDW6rSu01qQBIv8rZUUmVXbn6PzEvX566j/VeI9Pw5gTbFaOIzKTWhqfjRDC6o4vFDpLuPFCUFI15fFBUu5NrjsV9wynYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=fail smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj9NEYt0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765992833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTOQjH2WVKdvzEgOIBmSJCwOUcL4LQU8kkqeURW75fg=;
	b=Bj9NEYt0c/0T3WewBdw1Ptj68y7ab1WSyEEX+jmft9/sF1hjLbkeaCGV1f5AabdsV5Ti5y
	s1WCegh7+OcoVXZxJbNhS3Saj5JX0TDKYc7gWdNUK1133qhCaJV0Pfxj8moUoJPSN2+MJh
	TRctaBsAZrxMLxLZrsMPINbcvaRdLlw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-R6YyjY8vPaSbUAhIt3n7Ag-1; Wed,
 17 Dec 2025 12:33:48 -0500
X-MC-Unique: R6YyjY8vPaSbUAhIt3n7Ag-1
X-Mimecast-MFC-AGG-ID: R6YyjY8vPaSbUAhIt3n7Ag_1765992826
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B79AB18814D9;
	Wed, 17 Dec 2025 17:33:31 +0000 (UTC)
Received: from fedora (unknown [10.44.33.39])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8E3031956056;
	Wed, 17 Dec 2025 17:33:28 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Dec 2025 18:33:31 +0100 (CET)
Date: Wed, 17 Dec 2025 18:33:26 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: akpm@linux-foundation.org, gregkh@linuxfoundation.org, david@kernel.org,
	brauner@kernel.org, mingo@kernel.org, sean@ashe.io,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: Expose mm_cpumask in /proc/[pid]/status
Message-ID: <aULpZoSf2AATA_kT@redhat.com>
References: <20251217024603.1846651-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217024603.1846651-1-atomlin@atomlin.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Can't really comment this patch... I mean the intent.
Just a couple of nits:

	- I think this patch should also update Documentation/filesystems/proc.rst

	- I won't object, but do we really need/want another "if (mm)" block ?

	- I guess this is just my poor English, but the usage of "affinity"
	  in the changelog/comment looks a bit confusing to me ;) As if this
	  refers to task_struct.cpus_mask.

	  Fortunately "Cpus_active_mm..." in task_cpus_active_mm() makes it
	  more clear, so feel free to ignore.

Oleg.

On 12/16, Aaron Tomlin wrote:
>
> This patch introduces two new fields to /proc/[pid]/status to display the
> set of CPUs, representing the CPU affinity of the process's active
> memory context, in both mask and list format: "Cpus_active_mm" and
> "Cpus_active_mm_list". The mm_cpumask is primarily used for TLB and
> cache synchronisation.
>
> Exposing this information allows userspace to easily identify
> memory-task affinity, insight to NUMA alignment, CPU isolation and
> real-time workload placement.
>
> Frequent mm_cpumask changes may indicate instability in placement
> policies or excessive task migration overhead.
>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  fs/proc/array.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 42932f88141a..8887c5e38e51 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -409,6 +409,23 @@ static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
>  		   cpumask_pr_args(&task->cpus_mask));
>  }
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
> +static void task_cpus_active_mm(struct seq_file *m, struct mm_struct *mm)
> +{
> +	seq_printf(m, "Cpus_active_mm:\t%*pb\n",
> +		   cpumask_pr_args(mm_cpumask(mm)));
> +	seq_printf(m, "Cpus_active_mm_list:\t%*pbl\n",
> +		   cpumask_pr_args(mm_cpumask(mm)));
> +}
> +
>  static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
>  {
>  	seq_put_decimal_ull(m, "CoreDumping:\t", !!task->signal->core_state);
> @@ -450,12 +467,15 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>  		task_core_dumping(m, task);
>  		task_thp_status(m, mm);
>  		task_untag_mask(m, mm);
> -		mmput(mm);
>  	}
>  	task_sig(m, task);
>  	task_cap(m, task);
>  	task_seccomp(m, task);
>  	task_cpus_allowed(m, task);
> +	if (mm) {
> +		task_cpus_active_mm(m, mm);
> +		mmput(mm);
> +	}
>  	cpuset_task_status_allowed(m, task);
>  	task_context_switch_counts(m, task);
>  	arch_proc_pid_thread_features(m, task);
> --
> 2.51.0
>


