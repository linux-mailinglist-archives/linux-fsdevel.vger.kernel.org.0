Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBFD3C328C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jul 2021 06:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhGJESP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Jul 2021 00:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhGJESP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Jul 2021 00:18:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB1FA613DC;
        Sat, 10 Jul 2021 04:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625890530;
        bh=fZW06Fo1ne0XzT2jTLDKAZu0qD9DOCEYSaRxO9QMayU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cb8b/2o682zFUYS/y/s7vKsrzR9+ktfhhFIjfzZdz0x+NTJ653SPVhWnM0KSi68fR
         kyP7eWeEkdPLOBmmJizPRzRK/DGNX140wu71Es3vHxJPReVrMZBJ5nNPq5m+Kd0Jh2
         +KrQ5vGe9+7qkoFGXS5FhbQVKg144rnfZm8Y5Y/w=
Date:   Fri, 9 Jul 2021 21:15:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vladimir Divjak <vladimir.divjak@bmw.de>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <mcgrof@kernel.org>, <oleg@redhat.com>
Subject: Re: [PATCH] coredump: allow PTRACE_ATTACH to coredump user mode
 helper
Message-Id: <20210709211529.59d4263a4780da8de14f351b@linux-foundation.org>
In-Reply-To: <20210705151019.989929-1-vladimir.divjak@bmw.de>
References: <20210705151019.989929-1-vladimir.divjak@bmw.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 5 Jul 2021 17:10:19 +0200 Vladimir Divjak <vladimir.divjak@bmw.de> wrote:

> This patch allows the coredump user mode helper process,
> if one is configured (in core_pattern),
> to perform ptrace operations on the dying process
> whose cordump it's handling.
> 
> The user mode helper process is expected to do so
> before consuming the coredump data from the pipe,
> and thereby, before the dying process is reaped by kernel.
> 
> Issuing a PTRACE_ATTACH request will pause the coredumping
> for that task until ptrace operation is finished.
> 
> The user mode helper process is also expected to
> issue a PTRACE_CONT request to the dying process,
> when it is done ptracing it, signaling the dying process
> coredumping can be resumed.
> 
> * Problem description / Rationale:
> In automotive and/or embedded environments,
> the storage capacity to store, and/or
> network capabilities to upload
> a complete core file can easily be a limiting factor,
> making offline issue analysis difficult.
> 
> * Solution:
> Allow the user mode coredump helper process
> to perform ptrace on the dying process in order to obtain
> useful information such as user mode stacktrace, and
> thereby greatly improve the offline debugging possibilities
> for such environments.
> 
> * Impact / Risk:
> The user mode helper process is already entrusted
> with handling the coredump data, so allowing it to read or even change
> the dying process memory should not pose an additional risk.
> 
> Furthermore, this change makes coredump emission somewhat slower
> due to the additional step of iterating over the core dump helper list
> and checking if ptrace completion needs to be awaited,
> during coredump emission.
> 

Seems useful.

>
> ...
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -41,6 +41,7 @@
>  #include <linux/fs.h>
>  #include <linux/path.h>
>  #include <linux/timekeeping.h>
> +#include <linux/jiffies.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -62,6 +63,64 @@ struct core_name {
>  	int used, size;
>  };
>  
> +DEFINE_MUTEX(cdh_mutex);
> +LIST_HEAD(cdh_list);

I think this could be static?

> +	struct task_struct *task_being_dumped;
> +	struct completion ptrace_done;
> +	pid_t helper_pid;
> +};
>
> ...
>
> @@ -692,9 +751,14 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		sub_info = call_usermodehelper_setup(helper_argv[0],
>  						helper_argv, NULL, GFP_KERNEL,
>  						umh_pipe_setup, NULL, &cprm);
> -		if (sub_info)
> +		if (sub_info) {
> +			mutex_lock(&cdh_mutex);
>  			retval = call_usermodehelper_exec(sub_info,
>  							  UMH_WAIT_EXEC);
> +			if (!retval)
> +				cdh_link_current_locked(sub_info->pid);
> +			mutex_unlock(&cdh_mutex);

Dumb question: can the usermode helper coredump and then try to take
cdh_mutex, causing a deadlock?

> +		}
>  
>  		kfree(helper_argv);
>  		if (retval) {
>
> ...
>
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c

It seems regrettable that the ptrace code has to be aware of the
coredump code in this fashion.

