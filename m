Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4EA190200
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 00:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCWXjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 19:39:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgCWXjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=TEUZhCjfShs/MS4UZq1VHSw7JcuxY18OqcwtWtp0bLM=; b=IBayBFhlOFrtLI4GQitRSAxT4p
        YfYtYcm3rr9WoyfzPh1kErg35kzKMlOOaFuqQKuo2SC7JafYpPtats4RcJywhuZWw2mO0W20BIvYG
        iKBysCDo6RipS4Bxof13jZY9nZBTiCQ5LHNmE3MGBkoX9x79lnr8rJ2X+qMmNqrb82YvFHouNVpAA
        cNs8ZA/K/OV5+MileG370xj+Z2EJ990t/uP7EcykvTcmLVhFILIVRUfmBnM/1ed+6HoTqYNqfOhpv
        1njFpvw5nt5FvWpMhLAlD/nz6o64Pgy31Mab9MJZXlUW4WHIBpvd+I768Z8Izmfql6fB+1ujFMsqH
        kIkgiB/g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGWfJ-0008ER-S0; Mon, 23 Mar 2020 23:39:29 +0000
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a64729ec-9027-a386-58c6-7dc9fe9a4730@infradead.org>
Date:   Mon, 23 Mar 2020 16:39:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323214618.28429-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 3/23/20 2:46 PM, Guilherme G. Piccoli wrote:

> 
>  .../admin-guide/kernel-parameters.txt         |  6 ++++
>  Documentation/admin-guide/sysctl/kernel.rst   | 15 ++++++++++
>  include/linux/sched/sysctl.h                  |  7 +++++
>  kernel/hung_task.c                            | 30 +++++++++++++++++--
>  kernel/sysctl.c                               | 11 +++++++
>  5 files changed, 67 insertions(+), 2 deletions(-)
> 

admin-guide/kernel-parameters.txt predominantly uses "CPUs" for plural CPUs
when not part of a cmdline keyword etc., so please adjust below:

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

			                                               CPUs

> +			when a hung task is detected. Defaults to 0 and can
> +			be controlled by hung_task_all_cpu_backtrace sysctl.
> +			Format: <integer>
> +
>  	hung_task_panic=
>  			[KNL] Should the hung task detector generate panics.
>  			Format: <integer>
> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index def074807cee..8b4ff69d2348 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -40,6 +40,7 @@ show up in /proc/sys/kernel:
>  - hotplug
>  - hardlockup_all_cpu_backtrace
>  - hardlockup_panic
> +- hung_task_all_cpu_backtrace
>  - hung_task_panic
>  - hung_task_check_count
>  - hung_task_timeout_secs
> @@ -338,6 +339,20 @@ Path for the hotplug policy agent.
>  Default value is "/sbin/hotplug".
>  
>  
> +hung_task_all_cpu_backtrace:
> +================
> +
> +If this option is set, the kernel will send an NMI to all CPUs to dump
> +their backtraces when a hung task is detected. This file shows up if
> +CONFIG_DETECT_HUNG_TASK and CONFIG_SMP are enabled.
> +
> +0: Won't show all CPUs backtraces when a hung task is detected.
> +This is the default behavior.
> +
> +1: Will non-maskably interrupt all CPUs and dump their backtraces when
> +a hung task is detected.
> +
> +
>  hung_task_panic:
>  ================
>  


thanks.

-- 
~Randy

