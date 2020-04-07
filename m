Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E61A1676
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 22:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgDGUGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 16:06:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43853 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgDGUGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:06:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id f206so1299568pfa.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2020 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=fukz/tfuybeiqmTM+2SV38GcrGMp3Az6WJlxhUcp1Jg=;
        b=zVLHo5qrTOfpYQNwKeA5+MIylxoUib8I0GtH/Y+Cmo++MYy64FE/v7wXZjNkQH002a
         zzUprnJvk1W0X2/SnK/xvoH7UojYXsg3WOwAES3ctkOqA/2FTGwcjiO1rLQU59bq5jOR
         hDa+ow+9amWea0ivFbDyXF7ofGg9e6tJRctBd0nCbV53fMDLKbGPb0JspwPE15KW5pGc
         2epGWoOEVA0ugWMwBForhSf6RWTnDJrZnfCgWqufmR1nvBp1atmKYlz5KZ2yVjdbjgLJ
         H67lm7vKqRz4Oo4q1MtRDG9kq+cpSSiIojY7BfFeyTUF6zAreIvfOmN0F0wCZo9Mu9cK
         YFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fukz/tfuybeiqmTM+2SV38GcrGMp3Az6WJlxhUcp1Jg=;
        b=gKCvHWgDqhXrJaVNFrTH8UhXy/z7RxiINOZSFM9IK1UcxdLaLEjMBB5h7Kx6vbKxe4
         aGEBfjYr1WX2ks6VWWibLUAJ8y+RjUHXnYK6YdouoYTox+wNH+FaZTAUPNpEcyONtJl3
         lu2mv0h9xixNlU7DSIXCktYOdnqjy/FNe9uew8RWiufOzOPFxrtRmHjybzakxqpzLNeX
         3jtjhduGyzHaEjhQCrJkZVULhLsboxPP/UoBptQ/yKnQols4T2WpNUAuGd82aqVUrntj
         ximlsXOAxPx+PW3UdOUZNAsG8SraTC4lxYuxq0dot0sa6uB9Wd22XdYY7X9QOdXMDX8x
         HCsw==
X-Gm-Message-State: AGi0PuZgrbum05x9GYqGxQQWqOR06C5cLQ4Jxumu71sS1fPUqlBQM5j2
        f6HTPQJitSUxnj/nn+zXypiEoT99ZT6/TQ==
X-Google-Smtp-Source: APiQypLHXQYs2KZJCJAwqvJ0ui6yuU+LpsEl6acBu+kqfe5a4Zhxr6gwepf3yior3ML4qF678231AQ==
X-Received: by 2002:a62:5a03:: with SMTP id o3mr4061495pfb.301.1586290012300;
        Tue, 07 Apr 2020 13:06:52 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id w63sm4433951pgb.5.2020.04.07.13.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 13:06:51 -0700 (PDT)
Subject: Re: [PATCH 1/2] eventfd: Make wake counter work for single fd instead
 of all
To:     zhe.he@windriver.com, viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
References: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f395813-a497-aa25-71cc-8aed345b9f75@kernel.dk>
Date:   Tue, 7 Apr 2020 13:06:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/7/20 3:59 AM, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
> introduces a percpu counter that tracks the percpu recursion depth and
> warn if it greater than one, to avoid potential deadlock and stack
> overflow.
> 
> However sometimes different eventfds may be used in parallel.
> Specifically, when high network load goes through kvm and vhost, working
> as below, it would trigger the following call trace.
> 
> -  100.00%
>    - 66.51%
>         ret_from_fork
>         kthread
>       - vhost_worker
>          - 33.47% handle_tx_kick
>               handle_tx
>               handle_tx_copy
>               vhost_tx_batch.isra.0
>               vhost_add_used_and_signal_n
>               eventfd_signal
>          - 33.05% handle_rx_net
>               handle_rx
>               vhost_add_used_and_signal_n
>               eventfd_signal
>    - 33.49%
>         ioctl
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         __x64_sys_ioctl
>         ksys_ioctl
>         do_vfs_ioctl
>         kvm_vcpu_ioctl
>         kvm_arch_vcpu_ioctl_run
>         vmx_handle_exit
>         handle_ept_misconfig
>         kvm_io_bus_write
>         __kvm_io_bus_write
>         eventfd_signal
> 
> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
> ---- snip ----
> 001: Call Trace:
> 001:  vhost_signal+0x15e/0x1b0 [vhost]
> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
> 001:  handle_rx+0xb9/0x900 [vhost_net]
> 001:  handle_rx_net+0x15/0x20 [vhost_net]
> 001:  vhost_worker+0xbe/0x120 [vhost]
> 001:  kthread+0x106/0x140
> 001:  ? log_used.part.0+0x20/0x20 [vhost]
> 001:  ? kthread_park+0x90/0x90
> 001:  ret_from_fork+0x35/0x40
> 001: ---[ end trace 0000000000000003 ]---
> 
> This patch moves the percpu counter into eventfd control structure and
> does the clean-ups, so that eventfd can still be protected from deadlock
> while allowing different ones to work in parallel.
> 
> As to potential stack overflow, we might want to figure out a better
> solution in the future to warn when the stack is about to overflow so it
> can be better utilized, rather than break the working flow when just the
> second one comes.

This doesn't work for the infinite recursion case, the state has to be
global, or per thread.

-- 
Jens Axboe

