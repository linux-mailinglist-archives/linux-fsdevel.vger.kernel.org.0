Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E7B1A3760
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgDIPog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 11:44:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37070 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgDIPog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:44:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id r4so5150509pgg.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 08:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A+392dlFffMR2Zs+A393uuNHfV4VZPU06/pi7V42CWo=;
        b=QzPSCCjxge96HH4Z1pNDVxNSXwUJqh+j7B4xiHHJa0l5CW9u6HF6oYrhEeAHDG+Pcy
         uwdqlVIbZRVvmuFK7iDLty12pv+IlKRZrgwOAvuxUltShrZ/UZwJEz/2RqMX58HiZGI8
         IEkVbAsLxDrAd58J5A7mIc+EmqS9bDyfOr+XDMxQLKLKlONgFr32/6s59XOVLkJIUZha
         lJ6Ga9jC7m5Y8sVBK1grNp22LMOcJvXlZLT9cu72BA4CTsrHttSI7PfJPOEjTHZjnky9
         CItk90pdMO8goJ2ZqZ+VzidVE6oLlq92WGFbzgMGGmhRXPKaEvYczPPAusQlMEVhsCg+
         SCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A+392dlFffMR2Zs+A393uuNHfV4VZPU06/pi7V42CWo=;
        b=uF4JZAIiIkr+SVy9K7UHl/j1RP8T2QEK7OJ/zGV47w67T5ZZCa2VXJabSJ362pOLX6
         tww69d+RKvc5ieTOKDod5T7RUcxXMDtZz/ZiWW9yQ0agd6SAvwVcuOOLHZMX2L+3lp3v
         qRkTmYtfpBRcOkLuhBh8SeLW4su/DGZHAyfx6edvh6ANAFbxcpN8HZmC0NhDEcigbmiY
         +tvRq/SrJ9fNvkv7mNC1LriTSYMRH2Dhfxw5FILq4WVkPP4U84lwiG/CkBF3CG1+eZtm
         o637cqOfjd5YlQQhtVVEnnGvLrMWRfe8sN82mY5baIHqVxrEJlpmBWTneMnlQNpF2arb
         +gwQ==
X-Gm-Message-State: AGi0Puak+7V4RKdFnk+zmdIQ1GQa07rfJpvLpm9HsMKFiljkPST0QpIX
        LjyJWX0o22uC5q9D2tihjnFLvbGZyDYyeg==
X-Google-Smtp-Source: APiQypIjSwzOBqrE82xVArWQ+8D49YrVJaHLYvOy2PdLKBwNQX1oTmSbPPavNVc6xsV7URWcWhmV/Q==
X-Received: by 2002:a63:a556:: with SMTP id r22mr16479pgu.429.1586447073271;
        Thu, 09 Apr 2020 08:44:33 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:70f8:a8e1:daca:d677? ([2605:e000:100e:8c61:70f8:a8e1:daca:d677])
        by smtp.gmail.com with ESMTPSA id m9sm19123222pff.93.2020.04.09.08.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:44:32 -0700 (PDT)
Subject: Re: [PATCH 1/2] eventfd: Make wake counter work for single fd instead
 of all
To:     He Zhe <zhe.he@windriver.com>, viro@zeniv.linux.org.uk,
        bcrl@kvack.org, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-kernel@vger.kernel.org
References: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
 <3f395813-a497-aa25-71cc-8aed345b9f75@kernel.dk>
 <c4984e43-480c-3f9a-2316-249c61507bf2@windriver.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b4aa4cb-0e76-89c2-c48a-cf24e1a36bc2@kernel.dk>
Date:   Thu, 9 Apr 2020 08:44:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c4984e43-480c-3f9a-2316-249c61507bf2@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/9/20 3:37 AM, He Zhe wrote:
> 
> 
> On 4/8/20 4:06 AM, Jens Axboe wrote:
>> On 4/7/20 3:59 AM, zhe.he@windriver.com wrote:
>>> From: He Zhe <zhe.he@windriver.com>
>>>
>>> commit b5e683d5cab8 ("eventfd: track eventfd_signal() recursion depth")
>>> introduces a percpu counter that tracks the percpu recursion depth and
>>> warn if it greater than one, to avoid potential deadlock and stack
>>> overflow.
>>>
>>> However sometimes different eventfds may be used in parallel.
>>> Specifically, when high network load goes through kvm and vhost, working
>>> as below, it would trigger the following call trace.
>>>
>>> -  100.00%
>>>    - 66.51%
>>>         ret_from_fork
>>>         kthread
>>>       - vhost_worker
>>>          - 33.47% handle_tx_kick
>>>               handle_tx
>>>               handle_tx_copy
>>>               vhost_tx_batch.isra.0
>>>               vhost_add_used_and_signal_n
>>>               eventfd_signal
>>>          - 33.05% handle_rx_net
>>>               handle_rx
>>>               vhost_add_used_and_signal_n
>>>               eventfd_signal
>>>    - 33.49%
>>>         ioctl
>>>         entry_SYSCALL_64_after_hwframe
>>>         do_syscall_64
>>>         __x64_sys_ioctl
>>>         ksys_ioctl
>>>         do_vfs_ioctl
>>>         kvm_vcpu_ioctl
>>>         kvm_arch_vcpu_ioctl_run
>>>         vmx_handle_exit
>>>         handle_ept_misconfig
>>>         kvm_io_bus_write
>>>         __kvm_io_bus_write
>>>         eventfd_signal
>>>
>>> 001: WARNING: CPU: 1 PID: 1503 at fs/eventfd.c:73 eventfd_signal+0x85/0xa0
>>> ---- snip ----
>>> 001: Call Trace:
>>> 001:  vhost_signal+0x15e/0x1b0 [vhost]
>>> 001:  vhost_add_used_and_signal_n+0x2b/0x40 [vhost]
>>> 001:  handle_rx+0xb9/0x900 [vhost_net]
>>> 001:  handle_rx_net+0x15/0x20 [vhost_net]
>>> 001:  vhost_worker+0xbe/0x120 [vhost]
>>> 001:  kthread+0x106/0x140
>>> 001:  ? log_used.part.0+0x20/0x20 [vhost]
>>> 001:  ? kthread_park+0x90/0x90
>>> 001:  ret_from_fork+0x35/0x40
>>> 001: ---[ end trace 0000000000000003 ]---
>>>
>>> This patch moves the percpu counter into eventfd control structure and
>>> does the clean-ups, so that eventfd can still be protected from deadlock
>>> while allowing different ones to work in parallel.
>>>
>>> As to potential stack overflow, we might want to figure out a better
>>> solution in the future to warn when the stack is about to overflow so it
>>> can be better utilized, rather than break the working flow when just the
>>> second one comes.
>> This doesn't work for the infinite recursion case, the state has to be
>> global, or per thread.
> 
> Thanks, but I'm not very clear about why the counter has to be global
> or per thread.
> 
> If the recursion happens on the same eventfd, the attempt to re-grab
> the same ctx->wqh.lock would be blocked by the fd-specific counter in
> this patch.
> 
> If the recursion happens with a chain of different eventfds, that
> might lead to a stack overflow issue. The issue should be handled but
> it seems unnecessary to stop the just the second ring(when the counter
> is going to be 2) of the chain.
> 
> Specifically in the vhost case, it runs very likely with heavy network
> load which generates loads of eventfd_signal. Delaying the
> eventfd_signal to worker threads will still end up violating the
> global counter later and failing as above.
> 
> So we might want to take care of the potential overflow later,
> hopefully with a measurement that can tell us if it's about to
> overflow.

The worry is different eventfds, recursion on a single one could be
detected by keeping state in the ctx itself. And yeah, I agree that one
level isn't very deep, but wakeup chains can be deep and we can't allow
a whole lot more. I'm sure folks would be open to increasing it, if some
worst case kind of data was collected to prove it's fine to go deeper.

-- 
Jens Axboe

