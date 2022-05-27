Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4D53622B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 14:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiE0MNW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbiE0MLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 08:11:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2A715A768;
        Fri, 27 May 2022 04:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 227D161E2A;
        Fri, 27 May 2022 11:58:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3CA1C385A9;
        Fri, 27 May 2022 11:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653652735;
        bh=8Xvx2MIcxZDbHjwzkoQfpdoBGzgQWatAXhXPa8e5VS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NxrpKW7mg//pPsL6j290DqQ/0N6GhSBhKSII4E0w0OISVoHPKMcFtW9UVLfi3r7NK
         isd/D24Ta81ZcCsYDR7tMr5wAfy6aadELVtckgKiuz+vscBNtlg1oL7jnQHxlkj0BI
         fn8YkSVONlR49C1VEoo3EOXKIEWGaEI7OV2D/v20=
Date:   Fri, 27 May 2022 13:49:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, peterz@infradead.org,
        mingo@redhat.com, ast@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-api@vger.kernel.org, fam.zheng@bytedance.com
Subject: Re: [PATCH] procfs: add syscall statistics
Message-ID: <YpC6vAKILgsugi+B@kroah.com>
References: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220527110959.54559-1-zhangyuchen.lcr@bytedance.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 07:09:59PM +0800, Zhang Yuchen wrote:
> Add /proc/syscalls to display percpu syscall count.
> 
> We need a less resource-intensive way to count syscall per cpu
> for system problem location.

Why?

How is this less resource intensive than perf?

> There is a similar utility syscount in the BCC project, but syscount
> has a high performance cost.

What is that cost?

> The following is a comparison on the same machine, using UnixBench
> System Call Overhead:
> 
>     ┏━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━┳━━━━━━━━┓
>     ┃ Change        ┃ Unixbench Score ┃ Loss   ┃
>     ┡━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━╇━━━━━━━━┩
>     │ no change     │ 1072.6          │ ---    │
>     │ syscall count │ 982.5           │ 8.40%  │
>     │ bpf syscount  │ 614.2           │ 42.74% │
>     └───────────────┴─────────────────┴────────┘

Again, what about perf?

> UnixBench System Call Use sys_gettid to test, this system call only reads
> one variable, so the performance penalty seems large. When tested with
> fork, the test scores were almost the same.
> 
> So the conclusion is that it does not have a significant impact on system
> call performance.

8% is huge for a system-wide decrease in performance.  Who would ever
use this?

> This function depends on CONFIG_FTRACE_SYSCALLS because the system call
> number is stored in syscall_metadata.
> 
> Signed-off-by: Zhang Yuchen <zhangyuchen.lcr@bytedance.com>
> ---
>  Documentation/filesystems/proc.rst       | 28 +++++++++
>  arch/arm64/include/asm/syscall_wrapper.h |  2 +-
>  arch/s390/include/asm/syscall_wrapper.h  |  4 +-
>  arch/x86/include/asm/syscall_wrapper.h   |  2 +-
>  fs/proc/Kconfig                          |  7 +++
>  fs/proc/Makefile                         |  1 +
>  fs/proc/syscall.c                        | 79 ++++++++++++++++++++++++
>  include/linux/syscalls.h                 | 51 +++++++++++++--
>  8 files changed, 165 insertions(+), 9 deletions(-)
>  create mode 100644 fs/proc/syscall.c
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 1bc91fb8c321..80394a98a192 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -686,6 +686,7 @@ files are there, and which are missing.
>   fs 	      File system parameters, currently nfs/exports	(2.4)
>   ide          Directory containing info about the IDE subsystem
>   interrupts   Interrupt usage
> + syscalls     Syscall count for each cpu
>   iomem 	      Memory map					(2.4)
>   ioports      I/O port usage
>   irq 	      Masks for irq to cpu affinity			(2.4)(smp?)
> @@ -1225,6 +1226,33 @@ Provides counts of softirq handlers serviced since boot time, for each CPU.
>      HRTIMER:         0          0          0          0
>  	RCU:      1678       1769       2178       2250
>  
> +syscalls
> +~~~~~~~~
> +
> +Provides counts of syscall since boot time, for each cpu.
> +
> +::
> +
> +    > cat /proc/syscalls
> +               CPU0       CPU1       CPU2       CPU3
> +      0:       3743       3099       3770       3242   sys_read
> +      1:        222        559        822        522   sys_write
> +      2:          0          0          0          0   sys_open
> +      3:       6481      18754      12077       7349   sys_close
> +      4:      11362      11120      11343      10665   sys_newstat
> +      5:       5224      13880       8578       5971   sys_newfstat
> +      6:       1228       1269       1459       1508   sys_newlstat
> +      7:         90         43         64         67   sys_poll
> +      8:       1635       1000       2071       1161   sys_lseek
> +    .... omit the middle line ....
> +    441:          0          0          0          0   sys_epoll_pwait2
> +    442:          0          0          0          0   sys_mount_setattr
> +    443:          0          0          0          0   sys_quotactl_fd
> +    447:          0          0          0          0   sys_memfd_secret
> +    448:          0          0          0          0   sys_process_mrelease
> +    449:          0          0          0          0   sys_futex_waitv
> +    450:          0          0          0          0   sys_set_mempolicy_home_node

So for systems with large numbers of CPUs, these are huge lines?  Have
you tested this on large systems?  If so, how big?

thanks,

greg k-h
