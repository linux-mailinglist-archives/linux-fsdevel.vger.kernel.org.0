Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA53287FA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 02:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgJIAzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Oct 2020 20:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgJIAzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Oct 2020 20:55:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D6DC0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2020 17:55:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e10so5430921pfj.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Oct 2020 17:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=96SG6wG1EzdWabmC3NwLr5pFbLC7Ex0RqbFipjBgyx0=;
        b=gzQVqE0y8i8X6Vlk0sl8S/6ixQXqrLWeTanP+PWmDQvDu1NXMxbbFYiJSqJKros2VY
         q9+/bO8fDSmD/wB5/BbgXxjSwP2oR0cG2yhMhbZAWK8ggVAbfG8l16IA4Tz2Yl1DPjGE
         XfInfBd06vDTrM9lgSjWICC/9OO1/SaTh6WxV5ArDSWECJSUJaZX1GgWSzTA8xh/pAlp
         Cp2RnlHPA0Ww5pDgJcHdzsYA36sXNc1liFVjJMc8o6OCPqSXt8dc2InzQVAJiVAW/uel
         WJcmgI49Rw54ZVGs4IYZ4XNo7Mm4SNUbD9Xk8e8fbHMoPqQ8mR/MEQbyBX+nm2dmBdk8
         Z8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=96SG6wG1EzdWabmC3NwLr5pFbLC7Ex0RqbFipjBgyx0=;
        b=t4LW7pdlz5zxplqdnIE93y7m2zIlyci4iiPVl2zGMBNvo2z3oy9WytVU2ZYfIGH6nE
         SwkTDMj4f1bBWCKyEwPv5T3pgjv9Y0kmoRV68ziLb6qgY+2hu5oLDgy60DjL7uDTmbLh
         NTchqLMdm/Iq/gIFPF+FKmG23F2lgsRYK/zCfkZTmTAHbNlsQvqQhcOLuSIUVMgiK6M2
         ZSp43oH8db5P412BYukKoTc3ZwTgt8mW5LLqzwGhs10cExqwcaYBt3t2caZlJc5sm1O1
         /lAodwbMxT/04AuugKjh4wrAUtqxNjx1Cjn57bGi7c0lBvqCEgMDUR4xoG3f1jh9gC+C
         57PQ==
X-Gm-Message-State: AOAM533iFh8/BHefMRRhXw06Qe40GCv9IkCFYK9IA3nF5wlLC0hZAVu7
        xDh0pO2+Lsobl/grfZf4LiTqCg==
X-Google-Smtp-Source: ABdhPJz8lKf0b4fcitxEpXw3lv3qbmOMTDRwfUE/lgebrlw3AXlnTEiY3NfKwf3yAWi3Da3d2mP57w==
X-Received: by 2002:a17:90a:ad8b:: with SMTP id s11mr1700807pjq.40.1602204920471;
        Thu, 08 Oct 2020 17:55:20 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l21sm8467041pjq.54.2020.10.08.17.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 17:55:19 -0700 (PDT)
Subject: Re: inconsistent lock state in xa_destroy
To:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+cdcbdc0bd42e559b52b9@syzkaller.appspotmail.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000045ac4605b12a1720@google.com>
 <000000000000c35f0805b12f5099@google.com>
 <20201008222753.GP20115@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a7462a4-9be8-c7f9-e9dd-d16e22f312c8@kernel.dk>
Date:   Thu, 8 Oct 2020 18:55:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008222753.GP20115@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/8/20 4:27 PM, Matthew Wilcox wrote:
> 
> If I understand the lockdep report here, this actually isn't an XArray
> issue, although I do think there is one.
> 
> On Thu, Oct 08, 2020 at 02:14:20PM -0700, syzbot wrote:
>> ================================
>> WARNING: inconsistent lock state
>> 5.9.0-rc8-next-20201008-syzkaller #0 Not tainted
>> --------------------------------
>> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
>> swapper/0/0 [HC0[0]:SC1[1]:HE0:SE0] takes:
>> ffff888025f65018 (&xa->xa_lock#7){+.?.}-{2:2}, at: xa_destroy+0xaa/0x350 lib/xarray.c:2205
>> {SOFTIRQ-ON-W} state was registered at:
>>   lock_acquire+0x1f2/0xaa0 kernel/locking/lockdep.c:5419
>>   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>>   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
>>   spin_lock include/linux/spinlock.h:354 [inline]
>>   io_uring_add_task_file fs/io_uring.c:8607 [inline]
> 
> You're using the XArray in a non-interrupt-disabling mode.
> 
>>  _raw_spin_lock_irqsave+0x94/0xd0 kernel/locking/spinlock.c:159
>>  xa_destroy+0xaa/0x350 lib/xarray.c:2205
>>  __io_uring_free+0x60/0xc0 fs/io_uring.c:7693
>>  io_uring_free include/linux/io_uring.h:40 [inline]
>>  __put_task_struct+0xff/0x3f0 kernel/fork.c:732
>>  put_task_struct include/linux/sched/task.h:111 [inline]
>>  delayed_put_task_struct+0x1f6/0x340 kernel/exit.c:172
>>  rcu_do_batch kernel/rcu/tree.c:2484 [inline]
> 
> But you're calling xa_destroy() from in-interrupt context.
> So (as far as lockdep is concerned), no matter what I do in
> xa_destroy(), this potential deadlock is there.  You'd need to be
> using xa_init_flags(XA_FLAGS_LOCK_IRQ) if you actually needed to call
> xa_destroy() here.

Yeah good point, I guess that last free is in softirq from RCU.

> Fortunately, it seems you don't need to call xa_destroy() at all, so
> that problem is solved, but the patch I have here wouldn't help.

Right, it wouldn't have helped this case.

-- 
Jens Axboe

