Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26C08105501
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 16:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKUPCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 10:02:51 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:38834 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUPCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:02:48 -0500
Received: by mail-ed1-f50.google.com with SMTP id s10so3056688edi.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E392Bey6gyqrThPXx8YcFlOe0YHcNWFPSVbftT0swoA=;
        b=NJJ7sFm/XhnCvz3aQIsC8DV3UH1stbe9RQHbzgpl5sHNyXkOsGrQVGp+Qs6j8qo5zj
         fg9/oaME/zYfyRDk17NyDNMWP9yJe2lqstRCyUdcUkpysCuHhCYYbVzooMPmvFArvyUO
         G4yExiKQS8gB+rnJw26mfMfAUFVidpcp/Rczl8pzrWaSkJmVU+BM7Di4dbXb5MjW5hzY
         1uMQRlDaEFKAjrijZfq4e6YthfzIdWro930ACoCpJb/lPL4kt2/UfOO1HCujzb2nOg4y
         POCRUYTWxs5amOzBkMhhN1eSh45LoPHrmo/hM7ojgkivTGLuPUCBIGA8PACefyRTsYTF
         P54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E392Bey6gyqrThPXx8YcFlOe0YHcNWFPSVbftT0swoA=;
        b=E1SMngk1fVJFx48eHt00D7l6Aw9EyEmW8JxtAUW2PdLUamUI3MXen7Vv9BFkMDTFtT
         9y2zZsDoRk2KfRa2a/5c0fyaJmK05Du0aTjjkTfdITh6ZiIscv2Sph9OWCx8ikJkAWe+
         1CC9+Ra0nFVOdWJai2CyrumjufTWZTnlL7vGUbFbbc1hkIKJ58kEANCVwppRSx0jPpMx
         YXLZs+ttde2u52uzjJj9kJQM7cjCjvrZ43YlSqK2hwdvhicY+2vUjmklf95GsthxK41I
         WCRE9Dy/OKRad6d9ATnpjCzY+LjeP3iE+7huvHgxl7Txco9wSCa3Iz/R0ETPrTK9Jz5q
         lrQQ==
X-Gm-Message-State: APjAAAVasIoRZ0/5TSH5xBZbZU+Y1lHZBPLaExzX5NFKpo6EDTyjQTNv
        JjEBEVHmm1gYruYLLEjShQFKLQ==
X-Google-Smtp-Source: APXvYqxyVsfWB8PAdeR3T5PNAaNZIDSuV0GxjDC7qwGEKfB7nsdRVF4BkBx3a/r6kSrG+4kav45Mtg==
X-Received: by 2002:a17:906:1da1:: with SMTP id u1mr14708052ejh.275.1574348566101;
        Thu, 21 Nov 2019 07:02:46 -0800 (PST)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id br8sm20496ejb.80.2019.11.21.07.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:02:45 -0800 (PST)
Subject: Re: single aio thread is migrated crazily by scheduler
To:     Phil Auld <pauld@redhat.com>, Ming Lei <ming.lei@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20191114235415.GL4614@dread.disaster.area>
 <20191115010824.GC4847@ming.t460p>
 <20191115045634.GN4614@dread.disaster.area>
 <20191115070843.GA24246@ming.t460p>
 <20191115234005.GO4614@dread.disaster.area>
 <20191118092121.GV4131@hirez.programming.kicks-ass.net>
 <20191118204054.GV4614@dread.disaster.area>
 <20191120191636.GI4097@hirez.programming.kicks-ass.net>
 <20191120220313.GC18056@pauld.bos.csb> <20191121041218.GK24548@ming.t460p>
 <20191121141207.GA18443@pauld.bos.csb>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <93de0f75-3664-c71e-9947-5b37ae935ddc@plexistor.com>
Date:   Thu, 21 Nov 2019 17:02:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121141207.GA18443@pauld.bos.csb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 21/11/2019 16:12, Phil Auld wrote:
<>
> 
> The scheduler doesn't know if the queued_work submitter is going to go to sleep.
> That's why I was singling out AIO. My understanding of it is that you submit the IO
> and then keep going. So in that case it might be better to pick a node-local nearby
> cpu instead. But this is a user of work queue issue not a scheduler issue. 
> 

We have a very similar long standing problem in our system (zufs), that we had to do
hacks to fix.

We have seen these CPU bouncing exacly as above in fio and more benchmarks, Our final
analysis was: 
 One thread is in wait_event() if the wake_up() is on the same CPU as the
waiter, on some systems usually real HW and not VMs, would bounce to a different CPU.
Now our system has an array of worker-threads bound to each CPU. an incoming thread chooses
a corresponding cpu worker-thread, let it run, waiting for a reply, then when the
worker-thread is done it will do a wake_up(). Usually its fine and the wait_event() stays
on the same CPU. But on some systems it will wakeup in a different CPU.

Now this is a great pity because in our case and the work_queue case and high % of places 
the thread calling wake_up() will then immediately go to sleep on something.
(Work done lets wait for new work)

I wish there was a flag to wake_up() or to the event object that says to relinquish
the remaning of the time-slice to the waiter on same CPU, since I will be soon sleeping.

Then scheduler need not guess if the wake_up() caller is going to soon sleep or if its
going to continue. Let the coder give an hint about that?

(The hack was to set the waiter CPU mask to the incoming CPU and restore afer wakeup)

> Interestingly in our fio case the 4k one does not sleep and we get the active balance
> case where it moves the actually running thread.  The 512 byte case seems to be 
> sleeping since the migrations are all at wakeup time I believe. 
> 

Yes this is the same thing we saw in our system. (And it happens only sometimes)

> Cheers,
> Phil
> 
> 
>> Thanks,
>> Ming
> 

Very thanks
Boaz
