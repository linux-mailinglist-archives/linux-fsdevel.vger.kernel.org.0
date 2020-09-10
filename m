Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A202655CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgIJXtX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgIJXtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:49:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40FC0613ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 16:49:10 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so5804942pff.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IaBh+ddcuDpz6mDgalgDYidOFzTPwsq/h7xo4uSnjys=;
        b=OZvRIiWxvgbgV7rDrzwW/mo7pKOcUBLaRM/3F39IPc1E9icQFqomZHx0N4US35FTp7
         vSsnel87R3svfqBGdMoOlyN5B8k6YMqAy64tGhVQUCa1SGGb6+xnGqr9dmXdn7NgrUmc
         d/YNAWAvalvIjWW1alPmRiVUPHjkZXuTlKro4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IaBh+ddcuDpz6mDgalgDYidOFzTPwsq/h7xo4uSnjys=;
        b=jJBSctoE/rQglKlrmex8V/kBxWrjLwBVyrnC3uNxbxmo31zpSzfo2cl6aBu3tyCM8B
         H/L0awUSyd15tLS/27Ay9ZHzgDvzGdSIvEoSkeTUEq3/FwIK03pcLr9+5ITp/+tTJnqW
         lQSsTu/IkbibGVm041MIrGon/DqaJts0Mmrq94jhqOZR9jV0fFica55VAR17ATtWbAzw
         aXb66sGhoo7r2J30OiYsZK5jP6l5zbzoX+8l5bqW73DTynBvPcv8oxrHtfWQIq7I0SNZ
         KzT2hJL5JTRauMcXCX6MpLsUmlCWwdajK2HG6bn1gvMvZAiT+hVBRRUi4qc+1w1NTX2A
         qZZg==
X-Gm-Message-State: AOAM532Ua3Nc+6B3IxXvwjKOv/b5sUu+0uqdYV1D2wKEkx4IU2iYcAWx
        dU/sInDqZ3ByqR4o0Yt2UPCZTw==
X-Google-Smtp-Source: ABdhPJwZ1J9qu1mZJrqinh8jNTWdAMVS2FuQ2HVvvaEDccGanTL5jugLR2huQsSNnXe/gHlg9CGKaA==
X-Received: by 2002:a05:6a00:f:b029:13e:d13d:a089 with SMTP id h15-20020a056a00000fb029013ed13da089mr7496884pfk.32.1599781750231;
        Thu, 10 Sep 2020 16:49:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p190sm215398pfp.9.2020.09.10.16.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:49:09 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:49:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] security/fbfam: Detect a fork brute force attack
Message-ID: <202009101634.52ED6751AD@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-6-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910202107.3799376-6-keescook@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:21:06PM -0700, Kees Cook wrote:
> From: John Wood <john.wood@gmx.com>
> 
> To detect a fork brute force attack it is necessary to compute the
> crashing rate of the application. This calculation is performed in each
> fatal fail of a task, or in other words, when a core dump is triggered.
> If this rate shows that the application is crashing quickly, there is a
> clear signal that an attack is happening.
> 
> Since the crashing rate is computed in milliseconds per fault, if this
> rate goes under a certain threshold a warning is triggered.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  fs/coredump.c          |  2 ++
>  include/fbfam/fbfam.h  |  2 ++
>  security/fbfam/fbfam.c | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 76e7c10edfc0..d4ba4e1828d5 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -51,6 +51,7 @@
>  #include "internal.h"
>  
>  #include <trace/events/sched.h>
> +#include <fbfam/fbfam.h>
>  
>  int core_uses_pid;
>  unsigned int core_pipe_limit;
> @@ -825,6 +826,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  fail_creds:
>  	put_cred(cred);
>  fail:
> +	fbfam_handle_attack(siginfo->si_signo);

I don't think this is the right place for detecting a crash -- isn't
this only for the "dumping core" condition? In other words, don't you
want to do this in get_signal()'s "fatal" block? (i.e. very close to the
do_coredump, but without the "should I dump?" check?)

Hmm, but maybe I'm wrong? It looks like you're looking at noticing the
process taking a signal from SIG_KERNEL_COREDUMP_MASK ?

(Better yet: what are fatal conditions that do NOT match
SIG_KERNEL_COREDUMP_MASK, and should those be covered?)

Regardless, *this* looks like the only place without an LSM hook. And it
doesn't seem unreasonable to add one here. I assume it would probably
just take the siginfo pointer, which is also what you're checking.

e.g. for include/linux/lsm_hook_defs.h:

LSM_HOOK(int, 0, task_coredump, const kernel_siginfo_t *siginfo);


>  	return;
>  }
>  
> diff --git a/include/fbfam/fbfam.h b/include/fbfam/fbfam.h
> index 2cfe51d2b0d5..9ac8e33d8291 100644
> --- a/include/fbfam/fbfam.h
> +++ b/include/fbfam/fbfam.h
> @@ -12,10 +12,12 @@ extern struct ctl_table fbfam_sysctls[];
>  int fbfam_fork(struct task_struct *child);
>  int fbfam_execve(void);
>  int fbfam_exit(void);
> +int fbfam_handle_attack(int signal);
>  #else
>  static inline int fbfam_fork(struct task_struct *child) { return 0; }
>  static inline int fbfam_execve(void) { return 0; }
>  static inline int fbfam_exit(void) { return 0; }
> +static inline int fbfam_handle_attack(int signal) { return 0; }
>  #endif
>  
>  #endif /* _FBFAM_H_ */
> diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
> index 9be4639b72eb..3aa669e4ea51 100644
> --- a/security/fbfam/fbfam.c
> +++ b/security/fbfam/fbfam.c
> @@ -4,7 +4,9 @@
>  #include <linux/errno.h>
>  #include <linux/gfp.h>
>  #include <linux/jiffies.h>
> +#include <linux/printk.h>
>  #include <linux/refcount.h>
> +#include <linux/signal.h>
>  #include <linux/slab.h>
>  
>  /**
> @@ -172,3 +174,40 @@ int fbfam_exit(void)
>  	return 0;
>  }
>  
> +/**
> + * fbfam_handle_attack() - Fork brute force attack detection.
> + * @signal: Signal number that causes the core dump.
> + *
> + * The crashing rate of an application is computed in milliseconds per fault in
> + * each crash. So, if this rate goes under a certain threshold there is a clear
> + * signal that the application is crashing quickly. At this moment, a fork brute
> + * force attack is happening.
> + *
> + * Return: -EFAULT if the current task doesn't have statistical data. Zero
> + *         otherwise.
> + */
> +int fbfam_handle_attack(int signal)
> +{
> +	struct fbfam_stats *stats = current->fbfam_stats;
> +	u64 delta_jiffies, delta_time;
> +	u64 crashing_rate;
> +
> +	if (!stats)
> +		return -EFAULT;
> +
> +	if (!(signal == SIGILL || signal == SIGBUS || signal == SIGKILL ||
> +	      signal == SIGSEGV || signal == SIGSYS))
> +		return 0;

This will only be called for:

#define SIG_KERNEL_COREDUMP_MASK (\
        rt_sigmask(SIGQUIT)   |  rt_sigmask(SIGILL)    | \
        rt_sigmask(SIGTRAP)   |  rt_sigmask(SIGABRT)   | \
        rt_sigmask(SIGFPE)    |  rt_sigmask(SIGSEGV)   | \
        rt_sigmask(SIGBUS)    |  rt_sigmask(SIGSYS)    | \
        rt_sigmask(SIGXCPU)   |  rt_sigmask(SIGXFSZ)   | \
        SIGEMT_MASK                                    )

So you're skipping:

	SIGQUIT
	SIGTRAP
	SIGABRT
	SIGFPE
	SIGXCPU
	SIGXFSZ
	SIGEMT_MASK

I would include SIGABRT (e.g. glibc will call abort() for stack
canary, malloc, etc failures, which may indicate a mitigation has
fired).

-- 
Kees Cook
