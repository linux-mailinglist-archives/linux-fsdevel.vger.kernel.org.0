Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EC21056D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 17:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKUQTd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 11:19:33 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40199 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUQTd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:19:33 -0500
Received: by mail-il1-f194.google.com with SMTP id d83so3830866ilk.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2019 08:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kvj1OGlYWXQ7ytbrKDsR/TZrdswK2tP2241AuGz5/5c=;
        b=13PRjt8K4a2KOy8p0LkwxnTJWoXSCik2jil6eEf+nKpRFAw/WneYao35gDdiKIYb8a
         /xbKq7CVsVyzhDgT+qYN/CXr3mCN2tfs+V0MqYVdrCI2Jb32I4Ml32hjse8GLaNlaycf
         hYaBMSvPkL+QfF3Lvq/i3o6MjQtTDBiQupjgl92he/XUE3u4BgZxrZD9tAbZinpSEUYU
         2lSCSv9xThV5eLe3YZDmcM97/cNnOWZV98EnnXiUAMBXRqNCvJZBU5vH+6PmZW8aIykE
         9DEJv2ax5uyrJda8ehDfb4X3GDoJCPgbX91gZGQy8X+YmKVFC3yiYvNgQw+HOQ+Sveg+
         m5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kvj1OGlYWXQ7ytbrKDsR/TZrdswK2tP2241AuGz5/5c=;
        b=fsQG65VFHNhbE/3szLowp9UY5RJ49Lj48XQOwmZerUeHakR665/VLZAHAQrpW9u7s9
         WnLS43Ngyk8BziboTSqE7EqzikWTvF8XXLdXyBQZW2YzSkW7U7LCNhWQxc2JYxEGiWAq
         lv7Yw8AyKUsZ/5kb9jPB3FLNfhN6c3tI1+1hDVrlpnEJiPSa2nC8mVp87yNl9PDBUaSB
         j8Cl8vIi5zpnYOSOs0YkHhEHjI9YzYZgWpz4FvGF9lKE5UeobyH06ixIsYGQ8MWKUKdj
         hhvtfKWFS9gJTyvr8xcBp0w1SJzqDMR4KZRS6iVUMN8gkzgf4yEC7lhoqNL3xzz6ILGc
         9htw==
X-Gm-Message-State: APjAAAUEDXdhl62Gyig7BNNxHWZD20I/4/gYw4e/hwTSxbFTj2wK1V6A
        zV05D4Jr7DfN4PFIu4ajuMV32Q==
X-Google-Smtp-Source: APXvYqzH3122XVz+Xjvvs3/f2ovlox5AqFaHNu3z266z0L1JjdEWxY4sgwdfmFDwsQc2XOJwI0yKSQ==
X-Received: by 2002:a05:6e02:8e7:: with SMTP id n7mr10886315ilt.302.1574353172148;
        Thu, 21 Nov 2019 08:19:32 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b21sm1392809ilg.88.2019.11.21.08.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 08:19:31 -0800 (PST)
Subject: Re: single aio thread is migrated crazily by scheduler
To:     Boaz Harrosh <boaz@plexistor.com>, Phil Auld <pauld@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
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
 <93de0f75-3664-c71e-9947-5b37ae935ddc@plexistor.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c02ab43-3880-68db-f293-9958510fb29e@kernel.dk>
Date:   Thu, 21 Nov 2019 09:19:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <93de0f75-3664-c71e-9947-5b37ae935ddc@plexistor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/21/19 8:02 AM, Boaz Harrosh wrote:
> On 21/11/2019 16:12, Phil Auld wrote:
> <>
>>
>> The scheduler doesn't know if the queued_work submitter is going to go to sleep.
>> That's why I was singling out AIO. My understanding of it is that you submit the IO
>> and then keep going. So in that case it might be better to pick a node-local nearby
>> cpu instead. But this is a user of work queue issue not a scheduler issue.
>>
> 
> We have a very similar long standing problem in our system (zufs), that we had to do
> hacks to fix.
> 
> We have seen these CPU bouncing exacly as above in fio and more
> benchmarks, Our final analysis was:
>
> One thread is in wait_event() if the wake_up() is on the same CPU as
> the waiter, on some systems usually real HW and not VMs, would bounce
> to a different CPU.  Now our system has an array of worker-threads
> bound to each CPU. an incoming thread chooses a corresponding cpu
> worker-thread, let it run, waiting for a reply, then when the
> worker-thread is done it will do a wake_up(). Usually its fine and the
> wait_event() stays on the same CPU. But on some systems it will wakeup
> in a different CPU.
> 
> Now this is a great pity because in our case and the work_queue case
> and high % of places the thread calling wake_up() will then
> immediately go to sleep on something.  (Work done lets wait for new
> work)
> 
> I wish there was a flag to wake_up() or to the event object that says
> to relinquish the remaning of the time-slice to the waiter on same
> CPU, since I will be soon sleeping.

Isn't that basically what wake_up_sync() is?

-- 
Jens Axboe

