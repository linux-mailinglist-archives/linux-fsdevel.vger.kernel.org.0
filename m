Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9E1CB534
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHQwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 12:52:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31679 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEHQwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 12:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588956757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fJh7eTRaE+f6+UgQ6oEEyfJPgzAOQ9oHC0u2sEu1qMQ=;
        b=NA/3MflEzq9MzBmRp8S3eexurAHAdkd0lkCtU1gJFjZ5dyvBYtV1katad+1VU8mdHunFxf
        WYlE4Lxysy9WDDJvKg/I9Xb/PnkJ/XG09txjdcWcJsl5mW+CV+nCqtSSMDcmpkU7wHg5Y8
        c0uoCl0313Zl9FlVhovwBTBH/TVb1wo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-E3Brn4j3OVii9jsC0xxysA-1; Fri, 08 May 2020 12:52:35 -0400
X-MC-Unique: E3Brn4j3OVii9jsC0xxysA-1
Received: by mail-wm1-f70.google.com with SMTP id 14so3934469wmo.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 09:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fJh7eTRaE+f6+UgQ6oEEyfJPgzAOQ9oHC0u2sEu1qMQ=;
        b=HyKAsRFzWKnrz8lN4SC8LiypG/Dc3xSqCKNJereqaaV2IdFrCpEu17jKM6VQ82OO5Z
         Szp0j55obYwTdxD3xTFL6dstqwofXI6bebE99Zo3kGRP5z3U3S8D9JauAO3LETHFvfji
         4dIWbHJQVSwuC1mI4XSQ+qRPT5YVBYcaTvfjoksOQ4BA5cpbdTazGGvs+IFZ1M6kCqDr
         KtTkctt62EIgOELyvtEeK+JXknulHlAVBxIm2N2E+8sibT1AqDLnHL8oeMq8n+AOQp+j
         i6nNWLW67kkCt6kdpXNBO0cemz0XY/kZzqV5nVWu1sHOx/882gC8m7q3bxp6LqBq8g4E
         JeLg==
X-Gm-Message-State: AGi0PuYe/ECPn9yrrJOAQClq60oYdKpTAf48AKwKaGOe2UQZvH8tg/uA
        f/3F3cNHUwV0BddCFSu5c8ZGBs02GMO8YXERMVonoLy78Ews4gyrd58yyI/v/9A22k3yuho5H6e
        H65z04osD1SQVRnfKRyMvTvoTlg==
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr3763813wrn.69.1588956754390;
        Fri, 08 May 2020 09:52:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNC3zLVygJXfLYveDgf/DdabT6/WkviW9hhT/9vv8oZ8lW48F+6WHlhxGJtcP7hweCZKsfvQ==
X-Received: by 2002:adf:e9d0:: with SMTP id l16mr3763791wrn.69.1588956754117;
        Fri, 08 May 2020 09:52:34 -0700 (PDT)
Received: from redhat.com (bzq-79-179-68-225.red.bezeqint.net. [79.179.68.225])
        by smtp.gmail.com with ESMTPSA id k17sm13777897wmi.10.2020.05.08.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 09:52:33 -0700 (PDT)
Date:   Fri, 8 May 2020 12:52:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200508125054-mutt-send-email-mst@kernel.org>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-3-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423002632.224776-3-dancol@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:26:32PM -0700, Daniel Colascione wrote:
> This sysctl can be set to either zero or one. When zero (the default)
> the system lets all users call userfaultfd with or without
> UFFD_USER_MODE_ONLY, modulo other access controls. When
> unprivileged_userfaultfd_user_mode_only is set to one, users without
> CAP_SYS_PTRACE must pass UFFD_USER_MODE_ONLY to userfaultfd or the API
> will fail with EPERM. This facility allows administrators to reduce
> the likelihood that an attacker with access to userfaultfd can delay
> faulting kernel code to widen timing windows for other exploits.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>

The approach taken looks like a hard-coded security policy.
For example, it won't be possible to set the sysctl knob
in question on any sytem running kvm. So this is
no good for any general purpose system.

What's wrong with using a security policy for this instead?



> ---
>  Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
>  fs/userfaultfd.c                        | 11 ++++++++++-
>  include/linux/userfaultfd_k.h           |  1 +
>  kernel/sysctl.c                         |  9 +++++++++
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 0329a4d3fa9e..4296b508ab74 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -850,6 +850,19 @@ privileged users (with SYS_CAP_PTRACE capability).
>  
>  The default value is 1.
>  
> +unprivileged_userfaultfd_user_mode_only
> +========================================
> +
> +This flag controls whether unprivileged users can use the userfaultfd
> +system calls to handle page faults in kernel mode.  If set to zero,
> +userfaultfd works with or without UFFD_USER_MODE_ONLY, modulo
> +unprivileged_userfaultfd above.  If set to one, users without
> +SYS_CAP_PTRACE must pass UFFD_USER_MODE_ONLY in order for userfaultfd
> +to succeed.  Prohibiting use of userfaultfd for handling faults from
> +kernel mode may make certain vulnerabilities more difficult
> +to exploit.
> +
> +The default value is 0.
>  
>  user_reserve_kbytes
>  ===================
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 21378abe8f7b..85cc1ab74361 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -29,6 +29,7 @@
>  #include <linux/hugetlb.h>
>  
>  int sysctl_unprivileged_userfaultfd __read_mostly = 1;
> +int sysctl_unprivileged_userfaultfd_user_mode_only __read_mostly = 0;
>  
>  static struct kmem_cache *userfaultfd_ctx_cachep __read_mostly;
>  
> @@ -2009,8 +2010,16 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	static const int uffd_flags = UFFD_USER_MODE_ONLY;
>  	struct userfaultfd_ctx *ctx;
>  	int fd;
> +	bool need_cap_check = false;
>  
> -	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
> +	if (!sysctl_unprivileged_userfaultfd)
> +		need_cap_check = true;
> +
> +	if (sysctl_unprivileged_userfaultfd_user_mode_only &&
> +	    (flags & UFFD_USER_MODE_ONLY) == 0)
> +		need_cap_check = true;
> +
> +	if (need_cap_check && !capable(CAP_SYS_PTRACE))
>  		return -EPERM;
>  
>  	BUG_ON(!current->mm);
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index a8e5f3ea9bb2..d81e30074bf5 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -31,6 +31,7 @@
>  #define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
>  
>  extern int sysctl_unprivileged_userfaultfd;
> +extern int sysctl_unprivileged_userfaultfd_user_mode_only;
>  
>  extern vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason);
>  
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..9cbdf4483961 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1719,6 +1719,15 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "unprivileged_userfaultfd_user_mode_only",
> +		.data		= &sysctl_unprivileged_userfaultfd_user_mode_only,
> +		.maxlen		= sizeof(sysctl_unprivileged_userfaultfd_user_mode_only),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>  #endif
>  	{ }
>  };
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

