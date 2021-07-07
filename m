Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2763BE34E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 08:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhGGG5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 02:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhGGG4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 02:56:47 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3FFC061574;
        Tue,  6 Jul 2021 23:54:08 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c15so510017pls.13;
        Tue, 06 Jul 2021 23:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=29KlgInZ2jmDSdyaEuadEo1RRyP0XOU3F3wxMJ4gF08=;
        b=PIYRoDp9e45o2tqbnJDez56Ho6obbPuxHHPEF/IatZSzIYPH0i+N2/b1x4X+XWreCZ
         9yAcfanBPwYXOv47Y0ypjZMuNVkc6gIP3QVLTvmCLhJrpL4tjqaHHFAAtv/tuP9+vRg0
         yVMQObvdG80Sg1cFsxPq2XdWMT5zLd8HZHKkLT4zxIXKUd+NeHYuv4wtB41u92BjBjfv
         vQXM/2Qln3DCNdrCrj1Y9pHxvwwYucGYgTX2vpwjwhkyiKdoNchesCny/zptsAEggYRQ
         Vg8xLrkV3xwBoNpejL5cGxSA3Y0W+V+I9d8RYWMVJQT61W9EnZNusopKuBBXn5GrBcK5
         1kqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=29KlgInZ2jmDSdyaEuadEo1RRyP0XOU3F3wxMJ4gF08=;
        b=ryzPP5TSSvwnS3bQg6C43gik5iGFcDQVO6Yp2osQBEeBfoARHLa3BD5n6SE3FufgHC
         KuvUUTOFp9kpog4vY1CUAsla098zbMKBc1g/cueVymI6FBBCrBQ+9PJa9DuOjj9jLtDq
         xPwbb8Od+6LRdQ+WThKXL+QOYmS3jJr3s5ar0Tro7t6WmyvUrBOWc4ipfjug6N4LWXyK
         1DnIRL+CmBOGqbIOMS/IEWJsPgqhDbkTQBY/ZC5TK1ChjTTpOAtl8Cf1DzJVGJm9i3de
         5355hbaPjXpnp8aCaEBppJKHhDbrA6Zzrf9awQiHnPpIXOKg2Yf2PAfxCPdhHjDeAXAR
         7i6Q==
X-Gm-Message-State: AOAM530MklQCBlW3n8lHDkyufOPWIeee4toi4BRK+bwzde8dr9LRfHNY
        tGpwDBKhhBtjVMeXxSyRFmE=
X-Google-Smtp-Source: ABdhPJxZ1zdoUYOr/tVPvI2iKEfjV06YlGwS0CcDb679eyGv3+xgPB6ouNFj5g4/DI/XO9X/+SOqBQ==
X-Received: by 2002:a17:902:c981:b029:129:afe:8e30 with SMTP id g1-20020a170902c981b02901290afe8e30mr19863712plc.73.1625640847825;
        Tue, 06 Jul 2021 23:54:07 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id q17sm7934444pfk.186.2021.07.06.23.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 23:54:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] fcntl: fix potential deadlocks for
 &fown_struct.lock
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
References: <20210707023548.15872-1-desmondcheongzx@gmail.com>
 <20210707023548.15872-2-desmondcheongzx@gmail.com>
 <YOVENb3X/m/pNrYt@kroah.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <6bc70605-2ed3-98e8-cc48-9bb565cb05bd@gmail.com>
Date:   Wed, 7 Jul 2021 14:54:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOVENb3X/m/pNrYt@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/7/21 2:05 pm, Greg KH wrote:
> On Wed, Jul 07, 2021 at 10:35:47AM +0800, Desmond Cheong Zhi Xi wrote:
>> Syzbot reports a potential deadlock in do_fcntl:
>>
>> ========================================================
>> WARNING: possible irq lock inversion dependency detected
>> 5.12.0-syzkaller #0 Not tainted
>> --------------------------------------------------------
>> syz-executor132/8391 just changed the state of lock:
>> ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: f_getown_ex fs/fcntl.c:211 [inline]
>> ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: do_fcntl+0x8b4/0x1200 fs/fcntl.c:395
>> but this lock was taken by another, HARDIRQ-safe lock in the past:
>>   (&dev->event_lock){-...}-{2:2}
>>
>> and interrupts could create inverse lock ordering between them.
>>
>> other info that might help us debug this:
>> Chain exists of:
>>    &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
>>
>>   Possible interrupt unsafe locking scenario:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(&f->f_owner.lock);
>>                                 local_irq_disable();
>>                                 lock(&dev->event_lock);
>>                                 lock(&new->fa_lock);
>>    <Interrupt>
>>      lock(&dev->event_lock);
>>
>>   *** DEADLOCK ***
>>
>> This happens because there is a lock hierarchy of
>> &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
>> from the following call chain:
>>
>>    input_inject_event():
>>      spin_lock_irqsave(&dev->event_lock,...);
>>      input_handle_event():
>>        input_pass_values():
>>          input_to_handler():
>>            evdev_events():
>>              evdev_pass_values():
>>                spin_lock(&client->buffer_lock);
>>                __pass_event():
>>                  kill_fasync():
>>                    kill_fasync_rcu():
>>                      read_lock(&fa->fa_lock);
>>                      send_sigio():
>>                        read_lock_irqsave(&fown->lock,...);
>>
>> However, since &dev->event_lock is HARDIRQ-safe, interrupts have to be
>> disabled while grabbing &f->f_owner.lock, otherwise we invert the lock
>> hierarchy.
>>
>> Hence, we replace calls to read_lock/read_unlock on &f->f_owner.lock,
>> with read_lock_irq/read_unlock_irq.
>>
>> Here read_lock_irq/read_unlock_irq should be safe to use because the
>> functions f_getown_ex and f_getowner_uids are only called from
>> do_fcntl, and f_getown is only called from do_fnctl and
>> sock_ioctl. do_fnctl itself is only called from syscalls.
>>
>> For sock_ioctl, the chain is
>>    compat_sock_ioctl():
>>      compat_sock_ioctl_trans():
>>        sock_ioctl()
>>
>> And interrupts are not disabled on either path. We assert this
>> assumption with WARN_ON_ONCE(irqs_disabled()). This check is also
>> inserted into another use of write_lock_irq in f_modown.
>>
>> Reported-and-tested-by: syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>> ---
>>   fs/fcntl.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/fcntl.c b/fs/fcntl.c
>> index dfc72f15be7f..262235e02c4b 100644
>> --- a/fs/fcntl.c
>> +++ b/fs/fcntl.c
>> @@ -88,6 +88,7 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
>>   static void f_modown(struct file *filp, struct pid *pid, enum pid_type type,
>>                        int force)
>>   {
>> +	WARN_ON_ONCE(irqs_disabled());
> 
> If this triggers, you just rebooted the box :(
> 
> Please never do this, either properly handle the problem and return an
> error, or do not check for this.  It is not any type of "fix" at all,
> and at most, a debugging aid while you work on the root problem.
> 
> thanks,
> 
> greg k-h
> 

Hi Greg,

Thanks for the feedback. My bad, I was under the impression that 
WARN_ON_ONCE could be used to document assumptions for other developers, 
but I'll stick to using it for debugging in the future.

I think then in this case it would be best to keep the reasoning for why 
the *_irq() locks are safe to use in the commit message. I'll update the 
patch accordingly.

Best wishes,
Desmond
