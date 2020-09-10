Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921A0265556
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgIJXOn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgIJXOl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:14:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2346C061573
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 16:14:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so5720418pfp.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 16:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XRt6nSNPxJiqB4pOHgzoSIJ78PpEPBdKLumFlkWFQwM=;
        b=LphtKGn7Rgdt9LI14XrV7jiDNYBp3aZlcmx+ruu3B1nvRSEuXUQFe3FD4po4thh6g9
         u3IV9+HxnDny97gctunoDE95qy48iPv3EQp23Ghv5NklSgQksDkw4X1oGXPFNBRGP8gM
         OpDfYMZcwgJR5Fjc7PWxxlUiqQ+RNTNTHEvrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XRt6nSNPxJiqB4pOHgzoSIJ78PpEPBdKLumFlkWFQwM=;
        b=BjtVonyLL8hUgClKCsNsP3eAkkZUOWbO6QEtCUJr194Mf7F91ag14GjRPFu9Jrf6YO
         n3GlMbnNXaoZ3hcPTZlv3PS3E4ySEJlFkGyZMStZuPHxCHStSOAMD1qwbqk1Gm7YQnMI
         8SpnjRKbbaOXYiPcjy5rT84/ONqxurd8ojcZxxQrf86KiTYQrk2lNziN4WISf2IoufAg
         S7DMnc/IiMCmTtzLjVB8K7hnZP6ewsfTpJbnsqzY1Myj1XT/VRJ4H40ETMxqkjAxJ9IP
         bvEhl+g06nh9AxOd43/Tq6nQCODdn2t8C7we/pQoYyhMbW64bjt+kSppDugAA0I8Ypxu
         OS3w==
X-Gm-Message-State: AOAM532RaqJzUoJVduOkd6TE1M0iuuo5diF9j+XagobGAzSJD+ZUcO8X
        XdXkqxrFzXsmUw2fmfgH+LIBLQ==
X-Google-Smtp-Source: ABdhPJxDYVL86Urmgrp1lPYox3Iemaytipsn4FBXUP6Vsa6qVLV7QyJUGW6mgbI4ZgWGFABync3VFQ==
X-Received: by 2002:a62:864e:: with SMTP id x75mr7531560pfd.60.1599779680294;
        Thu, 10 Sep 2020 16:14:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fs24sm105321pjb.8.2020.09.10.16.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:14:39 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:14:38 -0700
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
Subject: Re: [RFC PATCH 4/6] security/fbfam: Add a new sysctl to control the
 crashing rate threshold
Message-ID: <202009101612.18BAD0241D@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-5-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910202107.3799376-5-keescook@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:21:05PM -0700, Kees Cook wrote:
> From: John Wood <john.wood@gmx.com>
> 
> This is a previous step to add the detection feature.
> 
> A fork brute force attack will be detected when an application crashes
> quickly. Since, a rate can be defined as a time per fault, add a new
> sysctl to control the crashing rate threshold.
> 
> This way, each system can tune the detection's sensibility adjusting the
> milliseconds per fault. So, if the application's crashing rate falls
> under this threshold an attack will be detected. So, the higher this
> value, the faster an attack will be detected.
> 
> Signed-off-by: John Wood <john.wood@gmx.com>
> ---
>  include/fbfam/fbfam.h   |  4 ++++
>  kernel/sysctl.c         |  9 +++++++++
>  security/fbfam/Makefile |  1 +
>  security/fbfam/fbfam.c  | 11 +++++++++++
>  security/fbfam/sysctl.c | 20 ++++++++++++++++++++
>  5 files changed, 45 insertions(+)
>  create mode 100644 security/fbfam/sysctl.c
> 
> diff --git a/include/fbfam/fbfam.h b/include/fbfam/fbfam.h
> index b5b7d1127a52..2cfe51d2b0d5 100644
> --- a/include/fbfam/fbfam.h
> +++ b/include/fbfam/fbfam.h
> @@ -3,8 +3,12 @@
>  #define _FBFAM_H_
>  
>  #include <linux/sched.h>
> +#include <linux/sysctl.h>
>  
>  #ifdef CONFIG_FBFAM
> +#ifdef CONFIG_SYSCTL
> +extern struct ctl_table fbfam_sysctls[];
> +#endif

Instead of doing the extern and adding to sysctl.c, this can all be done
directly (dynamically) from the fbfam.c file instead.

>  int fbfam_fork(struct task_struct *child);
>  int fbfam_execve(void);
>  int fbfam_exit(void);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 09e70ee2332e..c3b4d737bef3 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -77,6 +77,8 @@
>  #include <linux/uaccess.h>
>  #include <asm/processor.h>
>  
> +#include <fbfam/fbfam.h>
> +
>  #ifdef CONFIG_X86
>  #include <asm/nmi.h>
>  #include <asm/stacktrace.h>
> @@ -2660,6 +2662,13 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +#endif
> +#ifdef CONFIG_FBFAM
> +	{
> +		.procname	= "fbfam",
> +		.mode		= 0555,
> +		.child		= fbfam_sysctls,
> +	},
>  #endif
>  	{ }
>  };
> diff --git a/security/fbfam/Makefile b/security/fbfam/Makefile
> index f4b9f0b19c44..b8d5751ecea4 100644
> --- a/security/fbfam/Makefile
> +++ b/security/fbfam/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_FBFAM) += fbfam.o
> +obj-$(CONFIG_SYSCTL) += sysctl.o
> diff --git a/security/fbfam/fbfam.c b/security/fbfam/fbfam.c
> index 0387f95f6408..9be4639b72eb 100644
> --- a/security/fbfam/fbfam.c
> +++ b/security/fbfam/fbfam.c
> @@ -7,6 +7,17 @@
>  #include <linux/refcount.h>
>  #include <linux/slab.h>
>  
> +/**
> + * sysctl_crashing_rate_threshold - Crashing rate threshold.
> + *
> + * The rate's units are in milliseconds per fault.
> + *
> + * A fork brute force attack will be detected if the application's crashing rate
> + * falls under this threshold. So, the higher this value, the faster an attack
> + * will be detected.
> + */
> +unsigned long sysctl_crashing_rate_threshold = 30000;

I would move the sysctls here, instead. (Also, the above should be
const.)

> +
>  /**
>   * struct fbfam_stats - Fork brute force attack mitigation statistics.
>   * @refc: Reference counter.
> diff --git a/security/fbfam/sysctl.c b/security/fbfam/sysctl.c
> new file mode 100644
> index 000000000000..430323ad8e9f
> --- /dev/null
> +++ b/security/fbfam/sysctl.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/sysctl.h>
> +
> +extern unsigned long sysctl_crashing_rate_threshold;
> +static unsigned long ulong_one = 1;
> +static unsigned long ulong_max = ULONG_MAX;
> +
> +struct ctl_table fbfam_sysctls[] = {
> +	{
> +		.procname	= "crashing_rate_threshold",
> +		.data		= &sysctl_crashing_rate_threshold,
> +		.maxlen		= sizeof(sysctl_crashing_rate_threshold),
> +		.mode		= 0644,
> +		.proc_handler	= proc_doulongvec_minmax,
> +		.extra1		= &ulong_one,
> +		.extra2		= &ulong_max,
> +	},
> +	{ }
> +};

I wouldn't bother splitting this into a separate file. (Just leave it in
fbfam.c)

-- 
Kees Cook
