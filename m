Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 905C814A423
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 13:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgA0Mvo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 07:51:44 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:50126 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgA0Mvn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:51:43 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 4E5BE2E0DBD;
        Mon, 27 Jan 2020 15:51:39 +0300 (MSK)
Received: from sas2-3e4aeb094591.qloud-c.yandex.net (sas2-3e4aeb094591.qloud-c.yandex.net [2a02:6b8:c08:7192:0:640:3e4a:eb09])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id eB2c93SM0d-pbmSUpmb;
        Mon, 27 Jan 2020 15:51:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1580129499; bh=L7X1k4eDAf2P7uN6axSXlVdpMKiQS7N+GE/E26wcBNA=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=za+d3Q3ddLp2bCGEeG0c8t8kr4cMsda8ABQqy2IgPO1/REOg6oFUg0BfzdhXnuT9U
         I5SJvFpLCPPY9SPTAg1YL/0ArT/bkIKqDqPVUVwXP3bBhVC3aAklSGPE2d63q7XEG0
         gnhicVcgLZA9UCNGWlLp2zpKMGrfshFA90J71yR4=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by sas2-3e4aeb094591.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4ycFeB9RGg-pbYaAS3o;
        Mon, 27 Jan 2020 15:51:37 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_mm_error sysctl
To:     Grzegorz Halat <ghalat@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, ssaner@redhat.com, atomlin@redhat.com,
        oleksandr@redhat.com, vbendel@redhat.com, kirill@shutemov.name,
        borntraeger@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20200127101100.92588-1-ghalat@redhat.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d58ef38a-a6a1-e0e1-bf00-462b4feeb182@yandex-team.ru>
Date:   Mon, 27 Jan 2020 15:51:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200127101100.92588-1-ghalat@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/01/2020 13.11, Grzegorz Halat wrote:
> Memory management subsystem performs various checks at runtime,
> if an inconsistency is detected then such event is being logged and kernel
> continues to run. While debugging such problems it is helpful to collect
> memory dump as early as possible. Currently, there is no easy way to panic
> kernel when such error is detected.
> 
> It was proposed[1] to panic the kernel if panic_on_oops is set but this
> approach was not accepted. One of alternative proposals was introduction of
> a new sysctl.
> 
> The patch adds panic_on_mm_error sysctl. If the sysctl is set then the
> kernel will be crashed when an inconsistency is detected by memory
> management. This currently means panic when bad page or bad PTE
> is detected(this may be extended to other places in MM).
> 
> Another use case of this sysctl may be in security-wise environments,
> it may be more desired to crash machine than continue to run with
> potentially damaged data structures.
> 
> [1] https://marc.info/?l=linux-mm&m=142649500728327&w=2
> 
> Signed-off-by: Grzegorz Halat <ghalat@redhat.com>
> ---
>   Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++++++++
>   include/linux/kernel.h                      |  1 +
>   kernel/sysctl.c                             |  9 +++++++++
>   mm/memory.c                                 |  7 +++++++
>   mm/page_alloc.c                             |  4 +++-
>   5 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index def074807cee..2fecd6b2547e 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -61,6 +61,7 @@ show up in /proc/sys/kernel:
>   - overflowgid
>   - overflowuid
>   - panic
> +- panic_on_mm_error
>   - panic_on_oops
>   - panic_on_stackoverflow
>   - panic_on_unrecovered_nmi
> @@ -611,6 +612,17 @@ an IO error.
>      and you can use this option to take a crash dump.
>   
>   
> +panic_on_mm_error:
> +==============
> +
> +Controls the kernel's behaviour when inconsistency is detected
> +by memory management code, for example bad page state or bad PTE.
> +
> +0: try to continue operation.
> +
> +1: panic immediately.
> +
> +
>   panic_on_oops:
>   ==============
>   
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 0d9db2a14f44..5f9d408512ff 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -518,6 +518,7 @@ extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in
>   extern int panic_timeout;
>   extern unsigned long panic_print;
>   extern int panic_on_oops;
> +extern int panic_on_mm_error;
>   extern int panic_on_unrecovered_nmi;
>   extern int panic_on_io_nmi;
>   extern int panic_on_warn;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 70665934d53e..6477e1cce28b 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1238,6 +1238,15 @@ static struct ctl_table kern_table[] = {
>   		.extra1		= SYSCTL_ZERO,
>   		.extra2		= SYSCTL_ONE,
>   	},
> +	{
> +		.procname	= "panic_on_mm_error",
> +		.data		= &panic_on_mm_error,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>   #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>   	{
>   		.procname	= "timer_migration",
> diff --git a/mm/memory.c b/mm/memory.c
> index 45442d9a4f52..cce74ff39447 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -71,6 +71,7 @@
>   #include <linux/dax.h>
>   #include <linux/oom.h>
>   #include <linux/numa.h>
> +#include <linux/module.h>
>   
>   #include <trace/events/kmem.h>
>   
> @@ -88,6 +89,8 @@
>   #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
>   #endif
>   
> +int panic_on_mm_error __read_mostly;
> +
>   #ifndef CONFIG_NEED_MULTIPLE_NODES
>   /* use the per-pgdat data instead for discontigmem - mbligh */
>   unsigned long max_mapnr;
> @@ -543,6 +546,10 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   		 vma->vm_ops ? vma->vm_ops->fault : NULL,
>   		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
>   		 mapping ? mapping->a_ops->readpage : NULL);
> +
> +	print_modules();

I'm not sure that printing all modules for each bad pte is a good idea.
It already prints 'readpage' which is enough to guess filesystem or driver.

Maybe print modules under if (panic...) below?

> +	if (panic_on_mm_error)
> +		panic("Bad page map detected");
>   	dump_stack();
>   	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>   }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d047bf7d8fd4..2ea6a65ba011 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -643,9 +643,11 @@ static void bad_page(struct page *page, const char *reason,
>   	if (bad_flags)
>   		pr_alert("bad because of flags: %#lx(%pGp)\n",
>   						bad_flags, &bad_flags);
> -	dump_page_owner(page);
>   
> +	dump_page_owner(page);
>   	print_modules();
> +	if (panic_on_mm_error)
> +		panic("Bad page state detected");
>   	dump_stack();
>   out:
>   	/* Leave bad fields for debug, except PageBuddy could make trouble */
> 
