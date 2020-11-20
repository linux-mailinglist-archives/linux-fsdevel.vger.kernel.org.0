Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989932BBA36
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Nov 2020 00:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgKTXdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 18:33:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKTXdk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:33:40 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74BA52240B;
        Fri, 20 Nov 2020 23:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1605915219;
        bh=gL+6V5nQ0C4us5yeUEMOZ4DAiQWOFVXFIqBNpK1mOkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=em2YocFlJIdEpjLcJkL+hvBruZzAJUC1SasATzoALDCQF1Zu2idf98v4dkDObOBC2
         mdhBpO3hZwmfzO8heER6rU5rjWQKYTMsg40dPu+Q7k/b2EocHlwOJwtz7wypquvEss
         JSVewi6HliXOR+r2ki9kxtqdMRfSpt5k/yvI4C80=
Date:   Fri, 20 Nov 2020 15:33:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, jeffv@google.com,
        kernel-team@android.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-mm@kvack.kernel.org, Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v6 1/2] Add UFFD_USER_MODE_ONLY
Message-Id: <20201120153337.431dc36c1975507bb1e44596@linux-foundation.org>
In-Reply-To: <20201120030411.2690816-2-lokeshgidra@google.com>
References: <20201120030411.2690816-1-lokeshgidra@google.com>
        <20201120030411.2690816-2-lokeshgidra@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 19 Nov 2020 19:04:10 -0800 Lokesh Gidra <lokeshgidra@google.com> wrote:

> userfaultfd handles page faults from both user and kernel code.
> Add a new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes
> the resulting userfaultfd object refuse to handle faults from kernel
> mode, treating these faults as if SIGBUS were always raised, causing
> the kernel code to fail with EFAULT.
> 
> A future patch adds a knob allowing administrators to give some
> processes the ability to create userfaultfd file objects only if they
> pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
> will exploit userfaultfd's ability to delay kernel page faults to open
> timing windows for future exploits.

Can we assume that an update to the userfaultfd(2) manpage is in the
works?

> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -405,6 +405,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  
>  	if (ctx->features & UFFD_FEATURE_SIGBUS)
>  		goto out;
> +	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
> +	    ctx->flags & UFFD_USER_MODE_ONLY) {
> +		printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
> +			"sysctl knob to 1 if kernel faults must be handled "
> +			"without obtaining CAP_SYS_PTRACE capability\n");
> +		goto out;
> +	}
>  
>  	/*
>  	 * If it's already released don't get it. This avoids to loop
> @@ -1965,10 +1972,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	BUG_ON(!current->mm);
>  
>  	/* Check the UFFD_* constants for consistency.  */
> +	BUILD_BUG_ON(UFFD_USER_MODE_ONLY & UFFD_SHARED_FCNTL_FLAGS);

Are we sure this is true for all architectures?

>  	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
>  	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
>  
> -	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
> +	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | UFFD_USER_MODE_ONLY))
>  		return -EINVAL;
>  
>  	ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index e7e98bde221f..5f2d88212f7c 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -257,4 +257,13 @@ struct uffdio_writeprotect {
>  	__u64 mode;
>  };
>  
> +/*
> + * Flags for the userfaultfd(2) system call itself.
> + */
> +
> +/*
> + * Create a userfaultfd that can handle page faults only in user mode.
> + */
> +#define UFFD_USER_MODE_ONLY 1
> +
>  #endif /* _LINUX_USERFAULTFD_H */

It would be nice to define this in include/linux/userfaultfd_k.h,
alongside the other flags.  But I guess it has to be here because it's
part of the userspace API.
