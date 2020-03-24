Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1197A19077B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 09:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCXI1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 04:27:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:45716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgCXI1l (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:27:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62F7BADB5;
        Tue, 24 Mar 2020 08:27:38 +0000 (UTC)
Subject: Re: [PATCH V2] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, tglx@linutronix.de,
        penguin-kernel@I-love.SAKURA.ne.jp, akpm@linux-foundation.org,
        cocci@systeme.lip6.fr, linux-api@vger.kernel.org,
        kernel@gpiccoli.net
References: <20200323214618.28429-1-gpiccoli@canonical.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <b73a6519-0529-e36f-fac5-e4b638ceb3cf@suse.cz>
Date:   Tue, 24 Mar 2020 09:27:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323214618.28429-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/20 10:46 PM, Guilherme G. Piccoli wrote:
> Commit 401c636a0eeb ("kernel/hung_task.c: show all hung tasks before panic")
> introduced a change in that we started to show all CPUs backtraces when a
> hung task is detected _and_ the sysctl/kernel parameter "hung_task_panic"
> is set. The idea is good, because usually when observing deadlocks (that
> may lead to hung tasks), the culprit is another task holding a lock and
> not necessarily the task detected as hung.
> 
> The problem with this approach is that dumping backtraces is a slightly
> expensive task, specially printing that on console (and specially in many
> CPU machines, as servers commonly found nowadays). So, users that plan to
> collect a kdump to investigate the hung tasks and narrow down the deadlock
> definitely don't need the CPUs backtrace on dmesg/console, which will delay
> the panic and pollute the log (crash tool would easily grab all CPUs traces
> with 'bt -a' command).
> Also, there's the reciprocal scenario: some users may be interested in
> seeing the CPUs backtraces but not have the system panic when a hung task
> is detected. The current approach hence is almost as embedding a policy in
> the kernel, by forcing the CPUs backtraces' dump (only) on hung_task_panic.
> 
> This patch decouples the panic event on hung task from the CPUs backtraces
> dump, by creating (and documenting) a new sysctl/kernel parameter called
> "hung_task_all_cpu_backtrace", analog to the approach taken on soft/hard
> lockups, that have both a panic and an "all_cpu_backtrace" sysctl to allow
> individual control. The new mechanism for dumping the CPUs backtraces on
> hung task detection respects "hung_task_warnings" by not dumping the
> traces in case there's no warnings left.
> 
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---
> 
> 
> V2: Followed suggestions from Kees and Tetsuo (and other grammar
> improvements). Also, followed Tetsuo suggestion to itereate kernel
> testing community - but I don't really know a ML for that, so I've
> CCed Coccinelle community and kernel-api ML.
> 
> Also, Tetsuo suggested that this option could be default to 1 - I'm
> open to it, but given it is only available if hung_task panic is set
> as of now and the goal of this patch is give users more flexibility,
> I vote to keep default as 0. I can respin a V3 in case more people
> want to see it enabled by default. Thanks in advance for the review!
> Cheers,
> 
> Guilherme
> 
> 
>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>  Documentation/admin-guide/sysctl/kernel.rst   | 15 ++++++++++
>  include/linux/sched/sysctl.h                  |  7 +++++
>  kernel/hung_task.c                            | 30 +++++++++++++++++--
>  kernel/sysctl.c                               | 11 +++++++
>  5 files changed, 67 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..7a14caac6c94 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1453,6 +1453,12 @@
>  			x86-64 are 2M (when the CPU supports "pse") and 1G
>  			(when the CPU supports the "pdpe1gb" cpuinfo flag).
>  
> +	hung_task_all_cpu_backtrace=
> +			[KNL] Should kernel generate backtraces on all cpus
> +			when a hung task is detected. Defaults to 0 and can
> +			be controlled by hung_task_all_cpu_backtrace sysctl.
> +			Format: <integer>
> +

Before adding a new thing as both kernel parameter and sysctl, could we perhaps
not add the kernel parameter, in favor of the generic sysctl parameter solution?
[1] There were no objections and some support from Kees, so I will try to send a
new version ASAP that will work properly with all "static" sysctls - we don't
need to be blocked by a full solution for dynamically registered sysctls yet, I
guess?

Thanks,
Vlastimil

[1] https://lore.kernel.org/linux-api/20200317132105.24555-1-vbabka@suse.cz/

