Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A2022C7ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGXO2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 10:28:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726726AbgGXO2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595600922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lr9Etkm6DVlQmv048YXafbStcrgAPMR6c7hyfkG2ij0=;
        b=C3INFemWKk2e6c9GjRET+ATPA+SAJN9ZCpj/FkkciEdAyhD2WpJS8TCBBKrhyo8ElYHk37
        NmLILzFNb/k/o5NWqyiNAYUrYkVPeu/f2Ielh5K0vWTMDSiM9a/AmeC4biToLIF/qcKzxH
        sJ+ZQCq/NY8Jm+lIu/gI6LRxxBs84Us=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-eHcdSATDOtWiM9f5lJKXKg-1; Fri, 24 Jul 2020 10:28:40 -0400
X-MC-Unique: eHcdSATDOtWiM9f5lJKXKg-1
Received: by mail-wm1-f70.google.com with SMTP id u68so3726806wmu.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 07:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lr9Etkm6DVlQmv048YXafbStcrgAPMR6c7hyfkG2ij0=;
        b=sgmFc6WLlKREfUWMJDO061AnQwsTjGVia4Y/2hq8p4ytFRqIqzG4NAMYiCF7XA8i+c
         s+8g0cIyU5vtQFJhjGIRiSPw66QiuM4TYoXkYlcPgtJAAM4gABSyXGwsYqh1LQc5VMP+
         oGsR9A1V0HBs2nbK5azR4V1M0iMP6ZxpwFw1ArnrMNB98le8KfE3dJR0vQ6LBIfk0kPI
         cGkTzFgwgyPs2B/UoSJISvIdcC/uzkHu/ddjCH4bv5BxfwktwiVC1oY7uFlaTGlqYwmu
         empSf3CiBznfhDbdHsSJRDYtGv17JBAC4yU3Nfavy3uetc8ryshr59L1A0gXGl5CluW9
         OXng==
X-Gm-Message-State: AOAM532JO9kllMoyvjB3t7lVEQCt/WQXBT25HXONedo/vGNz+zQuDTNf
        mY91whivApe4yrK+fpPz+JmB8fldMYh+KA0S0XHffjuT06Yl0otrbYrMQPXN+1coCwR8icsBV4a
        i2IWun/13lPdrqCURuDVfibyIWA==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr8538460wmk.127.1595600919601;
        Fri, 24 Jul 2020 07:28:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweAkCz6jqUgTCRtSnT+jtnvvd3TNnF9cP6oGan7bA1hezLM0XnPAmCXLixXMnOCHom0XLicQ==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr8538440wmk.127.1595600919291;
        Fri, 24 Jul 2020 07:28:39 -0700 (PDT)
Received: from redhat.com (bzq-79-179-105-63.red.bezeqint.net. [79.179.105.63])
        by smtp.gmail.com with ESMTPSA id t2sm7354008wmb.28.2020.07.24.07.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:28:37 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:28:33 -0400
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
Subject: Re: [PATCH 1/2] Add UFFD_USER_MODE_ONLY
Message-ID: <20200724100153-mutt-send-email-mst@kernel.org>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-2-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423002632.224776-2-dancol@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:26:31PM -0700, Daniel Colascione wrote:
> userfaultfd handles page faults from both user and kernel code.  Add a
> new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes the
> resulting userfaultfd object refuse to handle faults from kernel mode,
> treating these faults as if SIGBUS were always raised, causing the
> kernel code to fail with EFAULT.
> 
> A future patch adds a knob allowing administrators to give some
> processes the ability to create userfaultfd file objects only if they
> pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
> will exploit userfaultfd's ability to delay kernel page faults to open
> timing windows for future exploits.
> 
> Signed-off-by: Daniel Colascione <dancol@google.com>

Something to add here is that there is separate work on selinux to
support limiting specific userspace programs to only this type of
userfaultfd.

I also think Kees' comment about documenting what is the threat being solved
including some links to external sources still applies.

Finally, a question:

Is there any way at all to increase security without breaking
the assumption that copy_from_user is the same as userspace read?


As an example of a drastical approach that might solve some issues, how
about allocating some special memory and setting some VMA flag, then
limiting copy from/to user to just this subset of virtual addresses?
We can then do things like pin these pages in RAM, forbid
madvise/userfaultfd for these addresses, etc.

Affected userspace then needs to use a kind of a bounce buffer for any
calls into kernel.  This needs much more support from userspace and adds
much more overhead, but on the flip side, affects more ways userspace
can slow down the kernel.

Was this discussed in the past? Links would be appreciated.


> ---
>  fs/userfaultfd.c                 | 7 ++++++-
>  include/uapi/linux/userfaultfd.h | 9 +++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index e39fdec8a0b0..21378abe8f7b 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -418,6 +418,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>  
>  	if (ctx->features & UFFD_FEATURE_SIGBUS)
>  		goto out;
> +	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
> +	    ctx->flags & UFFD_USER_MODE_ONLY)
> +		goto out;
>  
>  	/*
>  	 * If it's already released don't get it. This avoids to loop
> @@ -2003,6 +2006,7 @@ static void init_once_userfaultfd_ctx(void *mem)
>  
>  SYSCALL_DEFINE1(userfaultfd, int, flags)
>  {
> +	static const int uffd_flags = UFFD_USER_MODE_ONLY;
>  	struct userfaultfd_ctx *ctx;
>  	int fd;
>  
> @@ -2012,10 +2016,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>  	BUG_ON(!current->mm);
>  
>  	/* Check the UFFD_* constants for consistency.  */
> +	BUILD_BUG_ON(uffd_flags & UFFD_SHARED_FCNTL_FLAGS);
>  	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
>  	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
>  
> -	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
> +	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | uffd_flags))
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
> -- 
> 2.26.2.303.gf8c07b1a785-goog
> 

