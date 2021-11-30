Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9A462BEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 06:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhK3FP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 00:15:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:36600 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhK3FP2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:15:28 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="236375368"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="236375368"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 21:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="540280897"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2021 21:12:06 -0800
Date:   Tue, 30 Nov 2021 13:12:06 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, siglesias@igalia.com,
        kernel@gpiccoli.net
Subject: Re: [PATCH 2/3] panic: Add option to dump all CPUs backtraces in
 panic_print
Message-ID: <20211130051206.GB89318@shbuild999.sh.intel.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-3-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109202848.610874-3-gpiccoli@igalia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 09, 2021 at 05:28:47PM -0300, Guilherme G. Piccoli wrote:
> Currently the "panic_print" parameter/sysctl allows some interesting debug
> information to be printed during a panic event. This is useful for example
> in cases the user cannot kdump due to resource limits, or if the user
> collects panic logs in a serial output (or pstore) and prefers a fast
> reboot instead of a kdump.
> 
> Happens that currently there's no way to see all CPUs backtraces in
> a panic using "panic_print" on architectures that support that. We do
> have "oops_all_cpu_backtrace" sysctl, but although partially overlapping
> in the functionality, they are orthogonal in nature: "panic_print" is
> a panic tuning (and we have panics without oopses, like direct calls to
> panic() or maybe other paths that don't go through oops_enter()
> function), and the original purpose of "oops_all_cpu_backtrace" is to
> provide more information on oopses for cases in which the users desire
> to continue running the kernel even after an oops, i.e., used in
> non-panic scenarios.
> 
> So, we hereby introduce an additional bit for "panic_print" to allow
> dumping the CPUs backtraces during a panic event.

This looks to be helpful for debugging panic.

Reviewed-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng


> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 1 +
>  Documentation/admin-guide/sysctl/kernel.rst     | 1 +
>  kernel/panic.c                                  | 4 ++++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0905d2cdb2d5..569d035c4332 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3690,6 +3690,7 @@
>  			bit 3: print locks info if CONFIG_LOCKDEP is on
>  			bit 4: print ftrace buffer
>  			bit 5: print all printk messages in buffer
> +			bit 6: print all CPUs backtrace (if available in the arch)
>  
>  	panic_on_taint=	Bitmask for conditionally calling panic() in add_taint()
>  			Format: <hex>[,nousertaint]
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 70b7df9b081a..1666c1a9dbba 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -796,6 +796,7 @@ bit 2  print timer info
>  bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
>  bit 4  print ftrace buffer
>  bit 5: print all printk messages in buffer
> +bit 6: print all CPUs backtrace (if available in the arch)
>  =====  ============================================
>  
>  So for example to print tasks and memory info on panic, user can::
> diff --git a/kernel/panic.c b/kernel/panic.c
> index cefd7d82366f..5da71fa4e5f1 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -65,6 +65,7 @@ EXPORT_SYMBOL_GPL(panic_timeout);
>  #define PANIC_PRINT_LOCK_INFO		0x00000008
>  #define PANIC_PRINT_FTRACE_INFO		0x00000010
>  #define PANIC_PRINT_ALL_PRINTK_MSG	0x00000020
> +#define PANIC_PRINT_ALL_CPU_BT		0x00000040
>  unsigned long panic_print;
>  
>  ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
> @@ -151,6 +152,9 @@ static void panic_print_sys_info(void)
>  	if (panic_print & PANIC_PRINT_ALL_PRINTK_MSG)
>  		console_flush_on_panic(CONSOLE_REPLAY_ALL);
>  
> +	if (panic_print & PANIC_PRINT_ALL_CPU_BT)
> +		trigger_all_cpu_backtrace();
> +
>  	if (panic_print & PANIC_PRINT_TASK_INFO)
>  		show_state();
>  
> -- 
> 2.33.1
