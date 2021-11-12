Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C118244ECE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 19:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbhKLSzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 13:55:44 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35504 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbhKLSzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 13:55:42 -0500
Received: by mail-ed1-f47.google.com with SMTP id g14so41444226edz.2;
        Fri, 12 Nov 2021 10:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Iawy8hM8eRyCMBEMC4y1moygOWRTeool6h66VnaFg/k=;
        b=mk6+zpysjmFtbDhz3YmEP43UMP5XlulmrJiguYG+ErK5MzVXRVX53gOnKGI4PB317U
         uLdPppJpm8GjU29VD4pDhne5ZiO0x0kLx+Y/dow1uxvTROFd+ucTzzDQUy2lH8fr4T/r
         z5H4iR5qNzNAuLWOx/lV+ZY3gwCwPFFVGKYnaG671Vk3AUnF6usWBlCnoMBMr8tay4Bi
         Vi2jyQkkzezG5JsT510QqM4MBoUdI6wJ3tGBwW/+SmjKgi/tYCehMwK07Z8hWHbvlD8l
         1f4gRxcH1/bP3aJg1/dnR1CXnNRw3u63ynOuOjehIYCEkdpT/0HML6Q/2v9UrS3at8tw
         bN3A==
X-Gm-Message-State: AOAM531eq3J+cbVMzH722ok6FYiwOemQZ1pT0Qrr8S1wsInsN3HHpAUj
        vgiTkz0kkEAyCp+MsE3Wexw=
X-Google-Smtp-Source: ABdhPJwoNfruuYTvSVpxsn9iT2utV+KOqOD0XFVXh8/k9BMPHVsZUaxfTQcSxhRcSsx36Ytc7ut/oA==
X-Received: by 2002:a50:e608:: with SMTP id y8mr23538543edm.39.1636743169660;
        Fri, 12 Nov 2021 10:52:49 -0800 (PST)
Received: from [10.9.0.26] ([46.166.133.199])
        by smtp.gmail.com with ESMTPSA id cz7sm3348384edb.55.2021.11.12.10.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Nov 2021 10:52:49 -0800 (PST)
Message-ID: <ac989387-3359-f8da-23f9-f5f6deca4db8@linux.com>
Date:   Fri, 12 Nov 2021 21:52:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Reply-To: alex.popov@linux.com
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     notify@kernel.org
References: <20211027233215.306111-1-alex.popov@linux.com>
From:   Alexander Popov <alex.popov@linux.com>
In-Reply-To: <20211027233215.306111-1-alex.popov@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.10.2021 02:32, Alexander Popov wrote:
> Hello! This is the v2 of pkill_on_warn.
> Changes from v1 and tricks for testing are described below.

Hello everyone!
Friendly ping for your feedback.

Thanks.
Alexander

> Rationale
> =========
> 
> Currently, the Linux kernel provides two types of reaction to kernel
> warnings:
>   1. Do nothing (by default),
>   2. Call panic() if panic_on_warn is set. That's a very strong reaction,
>      so panic_on_warn is usually disabled on production systems.
> 
>  From a safety point of view, the Linux kernel misses a middle way of
> handling kernel warnings:
>   - The kernel should stop the activity that provokes a warning,
>   - But the kernel should avoid complete denial of service.
> 
>  From a security point of view, kernel warning messages provide a lot of
> useful information for attackers. Many GNU/Linux distributions allow
> unprivileged users to read the kernel log, so attackers use kernel
> warning infoleak in vulnerability exploits. See the examples:
> https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html
> https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
> https://googleprojectzero.blogspot.com/2018/09/a-cache-invalidation-bug-in-linux.html
> 
> Let's introduce the pkill_on_warn sysctl.
> If this parameter is set, the kernel kills all threads in a process that
> provoked a kernel warning. This behavior is reasonable from a safety point of
> view described above. It is also useful for kernel security hardening because
> the system kills an exploit process that hits a kernel warning.
> 
> Moreover, bugs usually don't come alone, and a kernel warning may be
> followed by memory corruption or other bad effects. So pkill_on_warn allows
> the kernel to stop the process when the first signs of wrong behavior
> are detected.
> 
> 
> Changes from v1
> ===============
> 
> 1) Introduce do_pkill_on_warn() and call it in all warning handling paths.
> 
> 2) Do refactoring without functional changes in a separate patch.
> 
> 3) Avoid killing init and kthreads.
> 
> 4) Use do_send_sig_info() instead of do_group_exit().
> 
> 5) Introduce sysctl instead of using core_param().
> 
> 
> Tricks for testing
> ==================
> 
> 1) This patch series was tested on x86_64 using CONFIG_LKDTM.
> The kernel kills a process that performs this:
>    echo WARNING > /sys/kernel/debug/provoke-crash/DIRECT
> 
> 2) The warn_slowpath_fmt() path was tested using this trick:
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index 84b87538a15d..3106c203ebb6 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -73,7 +73,7 @@ do {                                                          \
>    * were to trigger, we'd rather wreck the machine in an attempt to get the
>    * message out than not know about it.
>    */
> -#define __WARN_FLAGS(flags)                                    \
> +#define ___WARN_FLAGS(flags)                                   \
>   do {                                                           \
>          instrumentation_begin();                                \
>          _BUG_FLAGS(ASM_UD2, BUGFLAG_WARNING|(flags));           \
> 
> 3) Testing pkill_on_warn with kthreads was done using this trick:
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index bce848e50512..13c56f472681 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2133,6 +2133,8 @@ static int __noreturn rcu_gp_kthread(void *unused)
>                  WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANUP);
>                  rcu_gp_cleanup();
>                  WRITE_ONCE(rcu_state.gp_state, RCU_GP_CLEANED);
> +
> +               WARN_ONCE(1, "hello from kthread\n");
>          }
>   }
> 
> 4) Changing drivers/misc/lkdtm/bugs.c:lkdtm_WARNING() allowed me
> to test all warning flavours:
>   - WARN_ON()
>   - WARN()
>   - WARN_TAINT()
>   - WARN_ON_ONCE()
>   - WARN_ONCE()
>   - WARN_TAINT_ONCE()
> 
> Thanks!
> 
> Alexander Popov (2):
>    bug: do refactoring allowing to add a warning handling action
>    sysctl: introduce kernel.pkill_on_warn
> 
>   Documentation/admin-guide/sysctl/kernel.rst | 14 ++++++++
>   include/asm-generic/bug.h                   | 37 +++++++++++++++------
>   include/linux/panic.h                       |  3 ++
>   kernel/panic.c                              | 22 +++++++++++-
>   kernel/sysctl.c                             |  9 +++++
>   lib/bug.c                                   | 22 ++++++++----
>   6 files changed, 90 insertions(+), 17 deletions(-)
> 

