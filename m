Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33463BA2DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jul 2021 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhGBPoL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jul 2021 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGBPoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jul 2021 11:44:10 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678CC061762;
        Fri,  2 Jul 2021 08:41:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f11so5817272plg.0;
        Fri, 02 Jul 2021 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KK3MxR0qLHegtXtjdBa6mIQL9eEFTmy8PehJd/2y4JU=;
        b=M/u0o3zzoTdUxRNJwuzLBn0niDD7CnupOn7tviEGUaHK+Bzi18vZvQHxNXmCP900bg
         +vGBi+hCung8BUDwhfbixkZ48kXrX7yv0hY3HCy1bAey2dlshbfRgHcXBTxWNQV2TWOU
         Ft+aMSodXV0FVKBHupX80apjyUyPxmPm+8nSUj9x22F3gaApHXsxrwdRGrlsrX4IwwI7
         36oHxj4bo4wgs/8jLfGv2E89hdXsTEh/O3O9Fx6uKD2FMUPfNl3SKa7B6tb1Ho///UaD
         vTOKCwPczAJlVTZ0l4y8VrnmzOAua+9zc0/x+0lL5q/7C7OKA60tBQZ4GzwJwyIp3LNk
         AjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KK3MxR0qLHegtXtjdBa6mIQL9eEFTmy8PehJd/2y4JU=;
        b=kmPaUFTVOGJh2UcUSRBIok6nQkCBNQGOYSmV/ZrhElWXTjSFIGoPAAF9T7b23FGaOv
         8CJ5+iD+/y/7/3FIONWDVY8XJvPZ3CDMvADGRxNWuFIAuY9yZ2yEdHZKsSM7m2DA9CxS
         Ev/jgTywtAq92EtoFSA8oikcMoTjIYh238f9061ZFz7xCmW4h8v9GtosUaot/xjGvYFI
         70s1XNmcbHv3UjLg4dpxmy+UB8BfY4I/GM7eh+as6G4yGH7n2hLPMps/X/12UuVzfPq3
         zg6KOJBE79j2UBQr7VrEle54QMiLvFOrfVQBxrc5C4H+zt+S3XeDFgfll96AM/ZxcB7o
         J9KQ==
X-Gm-Message-State: AOAM531LAcKRVZzoTxiI7WK1coBSZwD3XkMQqXR1s5reZ7Bco1654XBZ
        bBxMzATqzyTpyXXHgeDLumA=
X-Google-Smtp-Source: ABdhPJxWVhXOIeVyGwLHh6fRO+IXXvAEtIe9g3z+dOcJhuFS+UPcohpRnzYO4VG09ys1jwJ0ujcAcA==
X-Received: by 2002:a17:90a:8596:: with SMTP id m22mr405427pjn.110.1625240497630;
        Fri, 02 Jul 2021 08:41:37 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id na7sm12892376pjb.36.2021.07.02.08.41.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 08:41:37 -0700 (PDT)
Subject: Re: [PATCH 1/2] fcntl: fix potential deadlocks for &fown_struct.lock
To:     Jeff Layton <jlayton@kernel.org>, bfields@fieldses.org,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
References: <20210702091831.615042-1-desmondcheongzx@gmail.com>
 <20210702091831.615042-2-desmondcheongzx@gmail.com>
 <43b5f2c7e7e5e5ed35c8e3de2eafeb960f267836.camel@kernel.org>
 <9e2a46b9-5735-d73b-d35e-f88dc994f6b4@gmail.com>
 <47d655dba51cd7d3cf3011f30f42bf7120c656db.camel@kernel.org>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <3e88d502-99b6-0dac-8548-a7781beb727a@gmail.com>
Date:   Fri, 2 Jul 2021 23:41:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <47d655dba51cd7d3cf3011f30f42bf7120c656db.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/7/21 10:27 pm, Jeff Layton wrote:
> On Fri, 2021-07-02 at 21:55 +0800, Desmond Cheong Zhi Xi wrote:
>> On 2/7/21 7:44 pm, Jeff Layton wrote:
>>> On Fri, 2021-07-02 at 17:18 +0800, Desmond Cheong Zhi Xi wrote:
>>>> Syzbot reports a potential deadlock in do_fcntl:
>>>>
>>>> ========================================================
>>>> WARNING: possible irq lock inversion dependency detected
>>>> 5.12.0-syzkaller #0 Not tainted
>>>> --------------------------------------------------------
>>>> syz-executor132/8391 just changed the state of lock:
>>>> ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: f_getown_ex fs/fcntl.c:211 [inline]
>>>> ffff888015967bf8 (&f->f_owner.lock){.+..}-{2:2}, at: do_fcntl+0x8b4/0x1200 fs/fcntl.c:395
>>>> but this lock was taken by another, HARDIRQ-safe lock in the past:
>>>>    (&dev->event_lock){-...}-{2:2}
>>>>
>>>> and interrupts could create inverse lock ordering between them.
>>>>
>>>> other info that might help us debug this:
>>>> Chain exists of:
>>>>     &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
>>>>
>>>>    Possible interrupt unsafe locking scenario:
>>>>
>>>>          CPU0                    CPU1
>>>>          ----                    ----
>>>>     lock(&f->f_owner.lock);
>>>>                                  local_irq_disable();
>>>>                                  lock(&dev->event_lock);
>>>>                                  lock(&new->fa_lock);
>>>>     <Interrupt>
>>>>       lock(&dev->event_lock);
>>>>
>>>>    *** DEADLOCK ***
>>>>
>>>> This happens because there is a lock hierarchy of
>>>> &dev->event_lock --> &new->fa_lock --> &f->f_owner.lock
>>>> from the following call chain:
>>>>
>>>>     input_inject_event():
>>>>       spin_lock_irqsave(&dev->event_lock,...);
>>>>       input_handle_event():
>>>>         input_pass_values():
>>>>           input_to_handler():
>>>>             evdev_events():
>>>>               evdev_pass_values():
>>>>                 spin_lock(&client->buffer_lock);
>>>>                 __pass_event():
>>>>                   kill_fasync():
>>>>                     kill_fasync_rcu():
>>>>                       read_lock(&fa->fa_lock);
>>>>                       send_sigio():
>>>>                         read_lock_irqsave(&fown->lock,...);
>>>>
>>>> However, since &dev->event_lock is HARDIRQ-safe, interrupts have to be
>>>> disabled while grabbing &f->f_owner.lock, otherwise we invert the lock
>>>> hierarchy.
>>>>
>>>> Hence, we replace calls to read_lock/read_unlock on &f->f_owner.lock,
>>>> with read_lock_irq/read_unlock_irq.
>>>>
>>>
>>> Patches look reasonable overall, but why does this one use read_lock_irq
>>> and the other one use read_lock_irqsave? Don't we need to *_irqsasve in
>>> both patches?
>>>
>>>
>>
>> My thinking was that the functions f_getown_ex and f_getowner_uids are
>> only called from do_fcntl, and f_getown is only called from do_fnctl and
>> sock_ioctl. do_fnctl itself is only called from syscalls.
>>
>> For sock_ioctl, the chain is
>>     compat_sock_ioctl():
>>       compat_sock_ioctl_trans():
>>         sock_ioctl()
>>
>> For both paths, it doesn't seem that interrupts are disabled, so I used
>> the *irq variants.
>>
>> But of course, I might be very mistaken on this, and I'd be happy to
>> make the change to *_irqsave.
>>
>> Also, on further inspection, if these calls should be changed to
>> *_irqsave, then I believe the call to write_lock_irq in f_modown (called
>> from do_fcntl() --> f_setown() --> __f_setown() --> f_modown()) should
>> also be changed to *_irqsave.
>>
>> There's also a call to write_lock_irq(&fa->fa_lock) in
>> fasync_remove_entry and fasync_insert_entry. Whether these should be
>> changed as well isn't as clear to me, but since it's safe to do, perhaps
>> it makes sense to use *_irqsave for them too. Thoughts?
>>
> 
> 
> I think your reasoning is probably valid here and we don't need to
> save/restore. It wasn't obvious to me until you pointed it out though.
> It might be worth a comment, or maybe even this at the top of both
> functions:
> 
>      WARN_ON_ONCE(irqs_disabled());
> 

Adding the WARN_ON_ONCE makes sense. I'll test it with Syzbot then 
prepare a v2 series.

> I'll pick these into linux-next soon and plan to merge them for v5.15.
> Let me know if you think they need to go in sooner.
> 
> 

Sounds good to me. Thanks for the feedback, Jeff.

>>>> Reported-and-tested-by: syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
>>>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>>>> ---
>>>>    fs/fcntl.c | 13 +++++++------
>>>>    1 file changed, 7 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/fs/fcntl.c b/fs/fcntl.c
>>>> index dfc72f15be7f..cf9e81dfa615 100644
>>>> --- a/fs/fcntl.c
>>>> +++ b/fs/fcntl.c
>>>> @@ -150,7 +150,8 @@ void f_delown(struct file *filp)
>>>>    pid_t f_getown(struct file *filp)
>>>>    {
>>>>    	pid_t pid = 0;
>>>> -	read_lock(&filp->f_owner.lock);
>>>> +
>>>> +	read_lock_irq(&filp->f_owner.lock);
>>>>    	rcu_read_lock();
>>>>    	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type)) {
>>>>    		pid = pid_vnr(filp->f_owner.pid);
>>>> @@ -158,7 +159,7 @@ pid_t f_getown(struct file *filp)
>>>>    			pid = -pid;
>>>>    	}
>>>>    	rcu_read_unlock();
>>>> -	read_unlock(&filp->f_owner.lock);
>>>> +	read_unlock_irq(&filp->f_owner.lock);
>>>>    	return pid;
>>>>    }
>>>>    
>>>> @@ -208,7 +209,7 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
>>>>    	struct f_owner_ex owner = {};
>>>>    	int ret = 0;
>>>>    
>>>> -	read_lock(&filp->f_owner.lock);
>>>> +	read_lock_irq(&filp->f_owner.lock);
>>>>    	rcu_read_lock();
>>>>    	if (pid_task(filp->f_owner.pid, filp->f_owner.pid_type))
>>>>    		owner.pid = pid_vnr(filp->f_owner.pid);
>>>> @@ -231,7 +232,7 @@ static int f_getown_ex(struct file *filp, unsigned long arg)
>>>>    		ret = -EINVAL;
>>>>    		break;
>>>>    	}
>>>> -	read_unlock(&filp->f_owner.lock);
>>>> +	read_unlock_irq(&filp->f_owner.lock);
>>>>    
>>>>    	if (!ret) {
>>>>    		ret = copy_to_user(owner_p, &owner, sizeof(owner));
>>>> @@ -249,10 +250,10 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
>>>>    	uid_t src[2];
>>>>    	int err;
>>>>    
>>>> -	read_lock(&filp->f_owner.lock);
>>>> +	read_lock_irq(&filp->f_owner.lock);
>>>>    	src[0] = from_kuid(user_ns, filp->f_owner.uid);
>>>>    	src[1] = from_kuid(user_ns, filp->f_owner.euid);
>>>> -	read_unlock(&filp->f_owner.lock);
>>>> +	read_unlock_irq(&filp->f_owner.lock);
>>>>    
>>>>    	err  = put_user(src[0], &dst[0]);
>>>>    	err |= put_user(src[1], &dst[1]);
>>>
>>
> 

