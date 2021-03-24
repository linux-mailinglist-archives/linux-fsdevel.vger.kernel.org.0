Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7C3474C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 10:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhCXJjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 05:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhCXJix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:38:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79491C061763;
        Wed, 24 Mar 2021 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tlE7gowY/JQvvN3vtmtqL6YeVObw7oIr+DM32xIg/4Y=; b=XkqYGWPk0EUc5bSZ3l+Kc5nPkc
        iCpQ2LXg/+3qkNv0scwWgEOoYOR/CaoN3QS3qVi1+mUfpEJ97L+AEidMtRlKhXyWGv+8I/BS+lNbT
        T7ppwLh6I/8nvMItbFSjaIZaPW3q+Pq72q1cAXcTwhSzMXqKb3YoxZMp62dR+azkLVSUbBTT6NIc0
        xk1jnCcFJS1+tW0COcVBLpBDkGhUKaiu6oliOkCAEcJ8zpm93dSjNp9PQQcxYhsqL6K12heT39tb+
        nXtSsRhyHg3ae1gteczsIW4zstzlPhzurKJ3xkfLx8C/n+q+VfBIb9OngaB4hRKDpiw7BSoMvZkqb
        SN895ErQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOzxQ-00BCbH-AP; Wed, 24 Mar 2021 09:37:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 231093007CD;
        Wed, 24 Mar 2021 10:37:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 049B1259421CD; Wed, 24 Mar 2021 10:37:42 +0100 (CET)
Date:   Wed, 24 Mar 2021 10:37:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
Message-ID: <YFsIZjhCFbxKyos3@hirez.programming.kicks-ass.net>
References: <20210323035706.572953-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323035706.572953-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:57:06PM -0700, Josh Don wrote:
> From: Paul Turner <pjt@google.com>
> 
> CPU scheduler marks need_resched flag to signal a schedule() on a
> particular CPU. But, schedule() may not happen immediately in cases
> where the current task is executing in the kernel mode (no
> preemption state) for extended periods of time.
> 
> This patch adds a warn_on if need_resched is pending for more than the
> time specified in sysctl resched_latency_warn_ms. If it goes off, it is
> likely that there is a missing cond_resched() somewhere. Monitoring is
> done via the tick and the accuracy is hence limited to jiffy scale. This
> also means that we won't trigger the warning if the tick is disabled.
> 
> This feature is default disabled. It can be toggled on using sysctl
> resched_latency_warn_enabled.
> 
> Signed-off-by: Paul Turner <pjt@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
> Delta from v1:
> - separate sysctl for enabling/disabling and triggering warn_once
>   behavior
> - add documentation
> - static branch for the enable
>  Documentation/admin-guide/sysctl/kernel.rst | 23 ++++++
>  include/linux/sched/sysctl.h                |  4 ++
>  kernel/sched/core.c                         | 78 ++++++++++++++++++++-
>  kernel/sched/debug.c                        | 10 +++
>  kernel/sched/sched.h                        | 10 +++
>  kernel/sysctl.c                             | 24 +++++++
>  6 files changed, 148 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 1d56a6b73a4e..2d4a21d3b79f 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -1077,6 +1077,29 @@ ROM/Flash boot loader. Maybe to tell it what to do after
>  rebooting. ???
>  
>  
> +resched_latency_warn_enabled
> +============================
> +
> +Enables/disables a warning that will trigger if need_resched is set for
> +longer than sysctl ``resched_latency_warn_ms``. This warning likely
> +indicates a kernel bug, such as a failure to call cond_resched().
> +
> +Requires ``CONFIG_SCHED_DEBUG``.
> +
> +
> +resched_latency_warn_ms
> +=======================
> +
> +See ``resched_latency_warn_enabled``.
> +
> +
> +resched_latency_warn_once
> +=========================
> +
> +If set, ``resched_latency_warn_enabled`` will only trigger one warning
> +per boot.
> +
> +
>  sched_energy_aware
>  ==================

Should we perhaps take out all SCHED_DEBUG sysctls and move them to
/debug/sched/ ? (along with the existing /debug/sched_{debug,features,preemp}
files)

Having all that in sysctl and documented gives them far too much sheen
of ABI.

Not saying this patch should do that, just as a general observation.
