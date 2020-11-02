Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B8B2A3616
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 22:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKBVjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 16:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgKBVjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:39:36 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88850C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 13:39:35 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 62so4628141pgg.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 13:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FtSibvsdvA5rUVREdfoxJ1vc1kri00NcSUIMa32id/s=;
        b=ycjCRV279Di6GZducEQavbrEZb8VCpkB+B+XTo94i7BUa+daWWB+xqYhjBBgKK4fh/
         8cEojishyWBfJt4Ky2n8BpKLe9NV8dDt8NCJaZ8zEKTcXNmgtqkDRjNnY7A/duwn32hJ
         hTodV7RxYvyoCoz915HcGS5p+bdQANEW5X3bIHy0Ys5NpQgE2KpLYbuEhVPFEqgqU2mT
         mUO+wUtaTmJLopzszFpyNpl5oClyoULw+3Y6QbAQwhFviBWyvsgUFete4SGPDZZuzUzd
         iCLnrY1KDd+CuXo6iosCuWvM2ifwbL6qmrg5elVsJXA5kYy1W8Q7PPjv0PbR5x5a/jV8
         j+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FtSibvsdvA5rUVREdfoxJ1vc1kri00NcSUIMa32id/s=;
        b=EHQsoxS1Lu0JPfXovhGy5l6boYiec3W237dAk/yf44LCFrmhen69gAHCPN6QD4Tbp3
         8IBJyyvesRyoKPuZFOiWzPLdUT/1ib+vjgT+gDzKB7tp7Tzp8nqpzolCV16nvL+8jVRO
         VChCU8YAzUj0Zv6PLuvZJCcLWtxaTRqYANDytI3fNKO7e1ECN4CSEcuyMX346fwD04hs
         JRIjbca6BWT9k8lEjCQgS/CuzNunwalE9OILBEtKDy5Qz/9OVwLogdcF5tG2VoevXFRM
         e3pVeeOHCphRg1qtoPO75KBd2vrJsikvOwngRdU2cx0qe5hwm8TIq3O71hdC/4WqSB2H
         hBqA==
X-Gm-Message-State: AOAM533MWDZIRcYMfStBInwt8zQg3/xOA6CzxiGsCpPoQVLX1MUrSIt7
        cx3ePs7+hPtqJxY0A+tOsobiZw==
X-Google-Smtp-Source: ABdhPJwIWV5qLDMLpsaxZ1JpfY8hZganSzwNcbYL9T+70ZBF+NS40V/oYgHHkjldaZleNZmuf/jaNg==
X-Received: by 2002:a17:90a:a595:: with SMTP id b21mr184058pjq.3.1604353174988;
        Mon, 02 Nov 2020 13:39:34 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z10sm403283pjz.49.2020.11.02.13.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 13:39:34 -0800 (PST)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
From:   Jens Axboe <axboe@kernel.dk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
 <20201030184255.GP3576660@ZenIV.linux.org.uk>
 <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
 <20201030184918.GQ3576660@ZenIV.linux.org.uk>
 <d858ba48-624f-43be-93cf-07d94f0ebefd@kernel.dk>
 <20201030222213.GR3576660@ZenIV.linux.org.uk>
 <a1e17902-a204-f03d-2a51-469633eca751@kernel.dk>
 <87eelba7ai.fsf@x220.int.ebiederm.org>
 <f33a6b5e-ecc9-2bef-ab40-6bd8cc2030c2@kernel.dk>
 <87k0v38qlw.fsf@x220.int.ebiederm.org>
 <d77e2d82-22da-a7a0-54e0-f5d315f32a75@kernel.dk>
Message-ID: <3abc1742-733e-c682-5476-c6337a630e05@kernel.dk>
Date:   Mon, 2 Nov 2020 14:39:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d77e2d82-22da-a7a0-54e0-f5d315f32a75@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/2/20 1:31 PM, Jens Axboe wrote:
> On 11/2/20 1:12 PM, Eric W. Biederman wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>>
>>> On 11/2/20 12:27 PM, Eric W. Biederman wrote:
>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>>
>>>>> On 10/30/20 4:22 PM, Al Viro wrote:
>>>>>> On Fri, Oct 30, 2020 at 02:33:11PM -0600, Jens Axboe wrote:
>>>>>>> On 10/30/20 12:49 PM, Al Viro wrote:
>>>>>>>> On Fri, Oct 30, 2020 at 12:46:26PM -0600, Jens Axboe wrote:
>>>>>>>>
>>>>>>>>> See other reply, it's being posted soon, just haven't gotten there yet
>>>>>>>>> and it wasn't ready.
>>>>>>>>>
>>>>>>>>> It's a prep patch so we can call do_renameat2 and pass in a filename
>>>>>>>>> instead. The intent is not to have any functional changes in that prep
>>>>>>>>> patch. But once we can pass in filenames instead of user pointers, it's
>>>>>>>>> usable from io_uring.
>>>>>>>>
>>>>>>>> You do realize that pathname resolution is *NOT* offloadable to helper
>>>>>>>> threads, I hope...
>>>>>>>
>>>>>>> How so? If we have all the necessary context assigned, what's preventing
>>>>>>> it from working?
>>>>>>
>>>>>> Semantics of /proc/self/..., for starters (and things like /proc/mounts, etc.
>>>>>> *do* pass through that, /dev/stdin included)
>>>>>
>>>>> Don't we just need ->thread_pid for that to work?
>>>>
>>>> No.  You need ->signal.
>>>>
>>>> You need ->signal->pids[PIDTYPE_TGID].  It is only for /proc/thread-self
>>>> that ->thread_pid is needed.
>>>>
>>>> Even more so than ->thread_pid, it is a kernel invariant that ->signal
>>>> does not change.
>>>
>>> I don't care about the pid itself, my suggestion was to assign ->thread_pid
>>> over the lookup operation to ensure that /proc/self/ worked the way that
>>> you'd expect.
>>
>> I understand that.
>>
>> However /proc/self/ refers to the current process not to the current
>> thread.  So ->thread_pid is not what you need to assign to make that
>> happen.  What the code looks at is: ->signal->pids[PIDTYPE_TGID].
>>
>> It will definitely break invariants to assign to ->signal.
>>
>> Currently only exchange_tids assigns ->thread_pid and it is nasty.  It
>> results in code that potentially results in infinite loops in
>> kernel/signal.c
>>
>> To my knowledge nothing assigns ->signal->pids[PIDTYPE_TGID].  At best
>> it might work but I expect the it would completely confuse something in
>> the pid to task or pid to process mappings.  Which is to say even if it
>> does work it would be an extremely fragile solution.
> 
> Thanks Eric, that's useful. Sounds to me like we're better off, at least
> for now, to just expressly forbid async lookup of /proc/self/. Which
> isn't really the end of the world as far as I'm concerned.

Alternatively, we just teach task_pid_ptr() where to look for an
alternate, if current->flags & PF_IO_WORKER is true. Then we don't have
to assign anything that's visible in task_struct, and in fact the async
worker can retain this stuff on the stack. As all requests are killed
before a task is allowed to exit, that should be safe.


diff --git a/kernel/pid.c b/kernel/pid.c
index 74ddbff1a6ba..5fd421a4864c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -42,6 +42,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
 #include <linux/idr.h>
+#include <linux/io_uring.h>
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 
@@ -320,6 +321,12 @@ EXPORT_SYMBOL_GPL(find_vpid);
 
 static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
 {
+	if ((task->flags & PF_IO_WORKER) && task->io_uring) {
+		return (type == PIDTYPE_PID) ?
+			&task->io_uring->thread_pid :
+			&task->io_uring->pids[type];
+	}
+
 	return (type == PIDTYPE_PID) ?
 		&task->thread_pid :
 		&task->signal->pids[type];

-- 
Jens Axboe

