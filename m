Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94C72BA0D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 04:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgKTDJu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 22:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgKTDJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 22:09:48 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C19C0617A7
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 19:09:47 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id i19so10868101ejx.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 19:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHaBikdORLgIWL2Zcc+GTT7BbTPgBYlKWDmbyDdvnI0=;
        b=BlMJXUOrMkE8p1dWkSA6E9qAZQAPL7vNYFrLTslEl0CJ6Tk5TIEsqYITg83d96s/zP
         Gn68dv0zAK/lYizr1/20RvnZ4ZrKPLNxWzZNgiIqGzbOPUKd/TSif/KO4B+fKTy5o9zO
         +N06jKbNsJzav1XU/O3kcsWYleXjdIcIckDilyv44CTt6GxudNElOH4rQFC2D+YPuzmk
         SMJ7WFpSIzX8I4th8i+uqUkyRjLXmxVhlVpJnF786qLWQ3hhCtP6YVwZmoR/KpQPhw46
         aHrCDm9+1u9Qz8gitoX9eR/5aw7h7yqbvEKXp5AgTV3oRjV2nq1o7MMTOaSq75sGn4k2
         NTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHaBikdORLgIWL2Zcc+GTT7BbTPgBYlKWDmbyDdvnI0=;
        b=ejRgd2NP0cvMqKynCkC22TwxDkPTyHAPEIJPEgtZqw53Ykfjq/Nd+AKwKsSDUdpbLE
         42Hv2iP9l2CB3ZCXlxN3DGw2FR5cG2z1QCIRK8WCCR4OUrZAqhuJ0zXdaqqthtwtVbQj
         Vtr08DtsVCsGEftCyw3QMuMqHzKN6Yc+EOEFPAA8iPvOwISyqiI/sw9e9GP/KokWbm03
         43NP5SrjZC+AFzHqH9iNSVwOncMmGI9cZVG/QsJf+RnElpRBxtn9EUiDMe9xnk5Nd5px
         kAdJX3nU/VIODe9+foPPanwJGMsRxKiSj+ilyEydgA12scVuj/xUdoLCQ302+HCfhmCh
         c1bw==
X-Gm-Message-State: AOAM531zhG761ObWyE1jGdO4mZr8FCbOV58A5c8tjzklWArh1begzhA0
        i+inYTw7AH7/EcM8cYG2mMTs64e4yF8IDn0NqiZpfw==
X-Google-Smtp-Source: ABdhPJx5v3n3B2swPuZb7KD4eIkmwhRaWF/FXiLbVFI6wx/oCnz34Y7gUKNQv8DzpME54THwdKVT1yn9jrayayaWLBg=
X-Received: by 2002:a17:906:1804:: with SMTP id v4mr31380199eje.201.1605841785662;
 Thu, 19 Nov 2020 19:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20201120030411.2690816-1-lokeshgidra@google.com> <20201120030411.2690816-2-lokeshgidra@google.com>
In-Reply-To: <20201120030411.2690816-2-lokeshgidra@google.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Thu, 19 Nov 2020 19:09:34 -0800
Message-ID: <CA+EESO6xfnRWD2xrmar6VrcWBA8P53J8gVZmOtR0Ri65yb-Q4w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] Add UFFD_USER_MODE_ONLY
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 7:04 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
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
>
> Signed-off-by: Daniel Colascione <dancol@google.com>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
> ---
>  fs/userfaultfd.c                 | 10 +++++++++-
>  include/uapi/linux/userfaultfd.h |  9 +++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 000b457ad087..605599fde015 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -405,6 +405,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
>
>         if (ctx->features & UFFD_FEATURE_SIGBUS)
>                 goto out;
> +       if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
> +           ctx->flags & UFFD_USER_MODE_ONLY) {
> +               printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
> +                       "sysctl knob to 1 if kernel faults must be handled "
> +                       "without obtaining CAP_SYS_PTRACE capability\n");
> +               goto out;
> +       }
>
>         /*
>          * If it's already released don't get it. This avoids to loop
> @@ -1965,10 +1972,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>         BUG_ON(!current->mm);
>
>         /* Check the UFFD_* constants for consistency.  */
> +       BUILD_BUG_ON(UFFD_USER_MODE_ONLY & UFFD_SHARED_FCNTL_FLAGS);
>         BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
>         BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
>
> -       if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
> +       if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | UFFD_USER_MODE_ONLY))
>                 return -EINVAL;
>
>         ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
> diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> index e7e98bde221f..5f2d88212f7c 100644
> --- a/include/uapi/linux/userfaultfd.h
> +++ b/include/uapi/linux/userfaultfd.h
> @@ -257,4 +257,13 @@ struct uffdio_writeprotect {
>         __u64 mode;
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
> 2.29.0.rc1.297.gfa9743e501-goog
>
Adding linux-mm@kvack.org mailing list
