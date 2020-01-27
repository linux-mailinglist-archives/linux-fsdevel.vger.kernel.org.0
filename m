Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB0C314A1FB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgA0Kap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:30:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34917 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729293AbgA0Kam (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580121040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B5seMdInBob5KBB/Ici0anA5L1DZMOsToJq/Z5iUw2E=;
        b=ZaRBVqh53GrDj+2qvr883CdRc2tEezHo0rjXuh+gBGc3uOpmL5sjBD9zmtEKNRdRHGLnAP
        S9BP09vUXKIrHZjyIDDU46pmNjpquuxPBgRoOOY1r14LEYETfdM+m66g9Ifar6WgEK/R0n
        iVnbx5jQTAyqibCaIekSI6F0ruFNktU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-asALZdzQNV6PH_YcoB2bbw-1; Mon, 27 Jan 2020 05:30:37 -0500
X-MC-Unique: asALZdzQNV6PH_YcoB2bbw-1
Received: by mail-wm1-f71.google.com with SMTP id b202so1204896wmb.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 02:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B5seMdInBob5KBB/Ici0anA5L1DZMOsToJq/Z5iUw2E=;
        b=pELxXIFB71fF6LV0uYI5wIrAETAK/WexnMwoVDYNAsF7chqRDGbXfZd8HqBO+ueLWS
         L9hXyeJ1FNLUgfd5Vq5789I68In3+MtG0vDohY4OSDY+rUhrracfmiVXCAs0xl0uJM8u
         1w+uQcRxT5tdq+igEqJHeEk63mol7y+71oA2nTYzuG/PXIEO5aRhmHSi7wB40L2ch62O
         VZNMNAEfqUkgEgp1H333dXwmXm/YilLhHb5lQpTackFb6I3zlx+gHcI630j4ko8kiTG+
         wYI0wd+xXwbA4DV6bUKPlC/T+mwImiO8TfAD/AuoEPbryE5KPPrgfGE2KEEZ3ASEjlyO
         0XMg==
X-Gm-Message-State: APjAAAVEutKPzbbWb5BZA76G3eH1bMFhpgG/MUZi+cxcAxAF8eAxXcg9
        EZYRiDYVpHaJMcyQ6En+unqfDlCqnumaDamPGg8WTWgJhcFEcGKyqDqqSlbvdz1g3koyhaG85+I
        0GFcle0rWDljyyJQXUYa+OTFL
X-Received: by 2002:a05:600c:20c1:: with SMTP id y1mr5646035wmm.164.1580121036577;
        Mon, 27 Jan 2020 02:30:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNP1yLOiuz11SqkgN+NSgVx33ZKZPJzCymBsy7575Ijof+Xt9mNxslTm1pwcw9yz9/cYbQrg==
X-Received: by 2002:a05:600c:20c1:: with SMTP id y1mr5646000wmm.164.1580121036206;
        Mon, 27 Jan 2020 02:30:36 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id w22sm17514661wmk.34.2020.01.27.02.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 02:30:35 -0800 (PST)
Date:   Mon, 27 Jan 2020 10:30:34 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Grzegorz Halat <ghalat@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        ssaner@redhat.com, oleksandr@redhat.com, vbendel@redhat.com,
        kirill@shutemov.name, khlebnikov@yandex-team.ru,
        borntraeger@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_mm_error sysctl
Message-ID: <20200127103034.lb2piuvtohwqysbs@atomlin.usersys.com>
References: <20200127101100.92588-1-ghalat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200127101100.92588-1-ghalat@redhat.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
User-Agent: NeoMutt/20180716-1637-ee8449
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 2020-01-27 11:11 +0100, Grzegorz Halat wrote:
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
>  Documentation/admin-guide/sysctl/kernel.rst | 12 ++++++++++++
>  include/linux/kernel.h                      |  1 +
>  kernel/sysctl.c                             |  9 +++++++++
>  mm/memory.c                                 |  7 +++++++
>  mm/page_alloc.c                             |  4 +++-
>  5 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index def074807cee..2fecd6b2547e 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -61,6 +61,7 @@ show up in /proc/sys/kernel:
>  - overflowgid
>  - overflowuid
>  - panic
> +- panic_on_mm_error
>  - panic_on_oops
>  - panic_on_stackoverflow
>  - panic_on_unrecovered_nmi
> @@ -611,6 +612,17 @@ an IO error.
>     and you can use this option to take a crash dump.
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
>  panic_on_oops:
>  ==============
>  
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 0d9db2a14f44..5f9d408512ff 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -518,6 +518,7 @@ extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in
>  extern int panic_timeout;
>  extern unsigned long panic_print;
>  extern int panic_on_oops;
> +extern int panic_on_mm_error;
>  extern int panic_on_unrecovered_nmi;
>  extern int panic_on_io_nmi;
>  extern int panic_on_warn;
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 70665934d53e..6477e1cce28b 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1238,6 +1238,15 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "panic_on_mm_error",
> +		.data		= &panic_on_mm_error,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
>  	{
>  		.procname	= "timer_migration",
> diff --git a/mm/memory.c b/mm/memory.c
> index 45442d9a4f52..cce74ff39447 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -71,6 +71,7 @@
>  #include <linux/dax.h>
>  #include <linux/oom.h>
>  #include <linux/numa.h>
> +#include <linux/module.h>
>  
>  #include <trace/events/kmem.h>
>  
> @@ -88,6 +89,8 @@
>  #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
>  #endif
>  
> +int panic_on_mm_error __read_mostly;
> +
>  #ifndef CONFIG_NEED_MULTIPLE_NODES
>  /* use the per-pgdat data instead for discontigmem - mbligh */
>  unsigned long max_mapnr;
> @@ -543,6 +546,10 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>  		 vma->vm_ops ? vma->vm_ops->fault : NULL,
>  		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
>  		 mapping ? mapping->a_ops->readpage : NULL);
> +
> +	print_modules();
> +	if (panic_on_mm_error)
> +		panic("Bad page map detected");
>  	dump_stack();
>  	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
>  }
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d047bf7d8fd4..2ea6a65ba011 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -643,9 +643,11 @@ static void bad_page(struct page *page, const char *reason,
>  	if (bad_flags)
>  		pr_alert("bad because of flags: %#lx(%pGp)\n",
>  						bad_flags, &bad_flags);
> -	dump_page_owner(page);
>  
> +	dump_page_owner(page);
>  	print_modules();
> +	if (panic_on_mm_error)
> +		panic("Bad page state detected");
>  	dump_stack();
>  out:
>  	/* Leave bad fields for debug, except PageBuddy could make trouble */

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

