Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4331D19D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 17:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbgEMPr1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 11:47:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42847 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgEMPr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 11:47:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id k19so6972159pll.9;
        Wed, 13 May 2020 08:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKtoyXmk8DQV9UmBrwTh6/Xuuv7ELuyspspuuYsxWDw=;
        b=f9g9qN2JjWT8QQkmJ42kiedffM5T/P/0uCuB8AB2FURXTygVjQrhRnNURhSToPiXFa
         qMFTSZS3qnslVoHynfpGNEV8MVjQBBhpMut+XN3WmdPu8KhPD0NqzmJCNvGxSPZ2GXqW
         oeBM9v3oiGGboLHZIV9RxrYkt+Wp9lSIJ87zpmuUwajq9o2zpk1iwMFNJ862U7iWIM9H
         qrkViM3r/akymp+lEBzgeIZpVLSLu6ClUKgZJqTScSlJiiPvbc/aCpctPZEQe7sbn+gT
         oSYRHFtZkJJRJCQxM/v9iA5pvn+iZ7A/1UC8hxcB/m66Cfi4aSH0PHZgsQX+NpEeElHz
         oRHg==
X-Gm-Message-State: AOAM531b4vHsDVV+YIM2m3HCRWY3YobIcgn12F9S4W97djHLZI2SRWWu
        z8tEzNwPQy75Spxmdxsmt0Y=
X-Google-Smtp-Source: ABdhPJxQGn/vPjur1KgSFyLfTN6Jk0flECMISUEFHDdfsmuEssuMO+J1ElRVgoKK3xAAG73qE7Qfwg==
X-Received: by 2002:a17:902:fe0c:: with SMTP id g12mr1603468plj.322.1589384844976;
        Wed, 13 May 2020 08:47:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 98sm2298310pjo.12.2020.05.13.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:47:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B6FE04063E; Wed, 13 May 2020 15:47:22 +0000 (UTC)
Date:   Wed, 13 May 2020 15:47:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org, tytso@mit.edu, bunk@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        labbott@redhat.com, jeffm@suse.com, jikos@kernel.org, jeyu@suse.de,
        tiwai@suse.de, AnDavis@suse.com, rpalethorpe@suse.de
Subject: Re: [PATCH v4] kernel: add panic_on_taint
Message-ID: <20200513154722.GR11244@42.do-not-panic.com>
References: <20200513150026.1039987-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513150026.1039987-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 13, 2020 at 11:00:26AM -0400, Rafael Aquini wrote:
> Analogously to the introduction of panic_on_warn, this patch
> introduces a kernel option named panic_on_taint in order to
> provide a simple and generic way to stop execution and catch
> a coredump when the kernel gets tainted by any given taint flag.
> 
> This is useful for debugging sessions as it avoids rebuilding
> the kernel to explicitly add calls to panic() or BUG() into
> code sites that introduce the taint flags of interest.
> For instance, if one is interested in following up with
> a post mortem analysis at the point a code path is hitting
> a bad page (i.e. unaccount_page_cache_page(), or slab_bug()),
> a crashdump could be collected by rebooting the kernel with
> 'panic_on_taint=0x20' amended to the command line string.
> 
> Another, perhaps less frequent, use for this option would be
> as a mean for assuring a security policy case where only a
> subset of taints, or no single taint (in paranoid mode),
> is allowed for the running system.
> The optional switch 'nousertaint' is handy in this particular
> scenario as it will avoid userspace induced crashes by writes
> to /proc/sys/kernel/tainted causing false positive hits for
> such policies.
> 
> Suggested-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Rafael Aquini <aquini@redhat.com>
> ---
> Changelog:
> * v2: get rid of unnecessary/misguided compiler hints		(Luis)
>       enhance documentation text for the new kernel parameter	(Randy)
> * v3: drop sysctl interface, keep it only as a kernel parameter (Luis)
> * v4: change panic_on_taint input from alphabetical taint flags
>       to hexadecimal bitmasks, for clarity and extendability	(Luis)
> 
>  Documentation/admin-guide/kdump/kdump.rst     |  7 ++++
>  .../admin-guide/kernel-parameters.txt         | 13 +++++++
>  include/linux/kernel.h                        |  4 +++
>  kernel/panic.c                                | 34 +++++++++++++++++++
>  kernel/sysctl.c                               | 11 +++++-
>  5 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index ac7e131d2935..2707de840fd3 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -521,6 +521,13 @@ will cause a kdump to occur at the panic() call.  In cases where a user wants
>  to specify this during runtime, /proc/sys/kernel/panic_on_warn can be set to 1
>  to achieve the same behaviour.
>  
> +Trigger Kdump on add_taint()
> +============================
> +
> +The kernel parameter panic_on_taint facilitates calling panic() from within
> +add_taint() whenever the value set in this bitmask matches with the bit flag
> +being set by add_taint(). This will cause a kdump to occur at the panic() call.
> +
>  Contact
>  =======
>  
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7bc83f3d9bdf..ce17fdbec7d1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3401,6 +3401,19 @@
>  			bit 4: print ftrace buffer
>  			bit 5: print all printk messages in buffer
>  
> +	panic_on_taint=	Bitmask for conditionally call panic() in add_taint()
> +			Format: <hex>[,nousertaint]
> +			Hexadecimal bitmask representing the set of TAINT flags
> +			that will cause the kernel to panic when add_taint() is
> +			called with any of the flags in this set.
> +			The optional switch "nousertaint" can be utilized to
> +			prevent userland forced crashes by writing to sysctl
> +			/proc/sys/kernel/tainted any flagset matching with the
> +			bitmask set on panic_on_taint.
> +			See Documentation/admin-guide/tainted-kernels.rst for
> +			extra details on the taint flags that users can pick
> +			to compose the bitmask to assign to panic_on_taint.
> +
>  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
>  			on a WARN().
>  
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 9b7a8d74a9d6..70712944dffc 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -528,6 +528,8 @@ extern int panic_on_oops;
>  extern int panic_on_unrecovered_nmi;
>  extern int panic_on_io_nmi;
>  extern int panic_on_warn;
> +extern unsigned long panic_on_taint;
> +extern bool panic_on_taint_nousertaint;
>  extern int sysctl_panic_on_rcu_stall;
>  extern int sysctl_panic_on_stackoverflow;
>  
> @@ -597,6 +599,8 @@ extern enum system_states {
>  #define TAINT_RANDSTRUCT		17
>  #define TAINT_FLAGS_COUNT		18
>  
> +#define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
> +
>  struct taint_flag {
>  	char c_true;	/* character printed when tainted */
>  	char c_false;	/* character printed when not tainted */
> diff --git a/kernel/panic.c b/kernel/panic.c
> index b69ee9e76cb2..94b5c973770c 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -44,6 +44,8 @@ static int pause_on_oops_flag;
>  static DEFINE_SPINLOCK(pause_on_oops_lock);
>  bool crash_kexec_post_notifiers;
>  int panic_on_warn __read_mostly;
> +unsigned long panic_on_taint;
> +bool panic_on_taint_nousertaint = false;
>  
>  int panic_timeout = CONFIG_PANIC_TIMEOUT;
>  EXPORT_SYMBOL_GPL(panic_timeout);
> @@ -434,6 +436,11 @@ void add_taint(unsigned flag, enum lockdep_ok lockdep_ok)
>  		pr_warn("Disabling lock debugging due to kernel taint\n");
>  
>  	set_bit(flag, &tainted_mask);
> +
> +	if (tainted_mask & panic_on_taint) {
> +		panic_on_taint = 0;
> +		panic("panic_on_taint set ...");
> +	}
>  }
>  EXPORT_SYMBOL(add_taint);
>  
> @@ -686,3 +693,30 @@ static int __init oops_setup(char *s)
>  	return 0;
>  }
>  early_param("oops", oops_setup);
> +
> +static int __init panic_on_taint_setup(char *s)
> +{
> +	char *taint_str;
> +
> +	if (!s)
> +		return -EINVAL;
> +
> +	taint_str = strsep(&s, ",");
> +	if (kstrtoul(taint_str, 16, &panic_on_taint))
> +		return -EINVAL;
> +
> +	/* make sure panic_on_taint doesn't hold out-of-range TAINT flags */
> +	panic_on_taint &= TAINT_FLAGS_MAX;

While it may have made sennse for simplicity to not pr_warn_once on the
proc_taint() case I think in this case we do want to pr_warn_once() as
the user is wishing to DEFINITELY PANIC if such a taint flag is present.

> +
> +	if (!panic_on_taint)
> +		return -EINVAL;
> +
> +	if (s && !strcmp(s, "nousertaint"))
> +		panic_on_taint_nousertaint = true;
> +
> +	pr_info("panic_on_taint: bitmask=0x%lx nousertaint_mode=%sabled\n",
> +		panic_on_taint, panic_on_taint_nousertaint ? "en" : "dis");
> +
> +	return 0;
> +}
> +early_param("panic_on_taint", panic_on_taint_setup);
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 8a176d8727a3..e257c965683a 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2623,11 +2623,20 @@ static int proc_taint(struct ctl_table *table, int write,
>  		return err;
>  
>  	if (write) {
> +		int i;
> +
> +		/*
> +		 * If we are relying on panic_on_taint not producing
> +		 * false positives due to userland input, bail out
> +		 * before setting the requested taint flags.
> +		 */
> +		if (panic_on_taint_nousertaint && (tmptaint & panic_on_taint))
> +			return -EINVAL;
> +

I like the compromise, but I think you also have to update this sysctl's
documentation to reflect this is disabled if this new boot param is used.

  Luis
