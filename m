Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D1CA009
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfJCOFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 10:05:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46073 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfJCOFq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:05:46 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so5704533iot.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 07:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Zd10yaCQtpl6TZ0TOAMtyatF9DypoM7H+hcM5WzFUVE=;
        b=U/T3eYaLtuoQ2ZqXaNtEC8/zsRl7vXbkvH0ur/mnuZdci8JHS25m8tVZhHzkHXcOoc
         WXUD7QLzxXLhhCHtQSsdWh88cGv6kpU+S7wFZp4bTseszz7PqWHfjNvElwKG0n86H2ue
         psO740nts7BGRk8Q0vM1D/p1IPXdardfp1FT/z0cuL8d+mIuaWkzkJmjYjFGlH47Tf0d
         Ph+8CkYQExEPukS9Qzgo/l3dXhUljVSa0XWe6A1cAOjC3UVbBtnJwKZYqUMqb2DsSOrS
         oKpZjKvBLPq6NmzXf6ktUHkVKcDGNxe4rwdVCKI1RtsND9eofEpN9ovUZ+Tc1RIG3L8q
         uFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zd10yaCQtpl6TZ0TOAMtyatF9DypoM7H+hcM5WzFUVE=;
        b=fS6VsfAtOMXW0jIz0dIxm9NPYV9u6rWdwhvaaZFWT+sgAZ48r2iXkfD6Tv6RHLLx9h
         C9lCKct2zuK553bd0NVpJhN8hSqBeNkVhzv9zCQabs+QsHDg2qncV2ESqN+3+NXxFXUn
         V/DlL9lWxwTiAThuYPduek9bn3mgj879EQSR8s4y4IispIJki8rYNBa0x9B0GJKGQ4nZ
         9W36TI3yQwDrSiEDN+mm3FwBh1XD/25wteeLl6T3Bw7tXPrTYclNFpvu89jjYiqz4k99
         1ANNlIgVnDlw9gdULaqTHPL1T8aMslXTH7l3aS6P1GLd6+Q9K6fzkWO2rj8yS5wITyHi
         auiQ==
X-Gm-Message-State: APjAAAVi0qnz8bqo86s6Jjg7TewDB31aBgmIiSBM0N43KAdW34VHtX0O
        Y2Ykwrcr6st9h7LJUIk1Ss2rpA==
X-Google-Smtp-Source: APXvYqxMC85P8p6nfEer1yrkDe1pPs1QGTYJo4ByBv6STdcpSYNzenOiPdhO4Vs5nrMYzAegJKsClw==
X-Received: by 2002:a92:ce4f:: with SMTP id a15mr10046137ilr.50.1570111545121;
        Thu, 03 Oct 2019 07:05:45 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z16sm889283iol.64.2019.10.03.07.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 07:05:44 -0700 (PDT)
Subject: Re: [5.4-rc1, regression] wb_workfn wakeup oops (was Re: frequent
 5.4-rc1 crash?)
To:     Chris Mason <clm@fb.com>, Gao Xiang <hsiangkao@aol.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        xfs <linux-xfs@vger.kernel.org>, "tj@kernel.org" <tj@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20191003015247.GI13108@magnolia>
 <20191003064022.GX16973@dread.disaster.area>
 <20191003084149.GA16347@hsiangkao-HP-ZHAN-66-Pro-G1>
 <41B90CA7-E093-48FA-BDFD-73BE7EB81FB6@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32f7c7d8-59d8-7657-4dcc-3741355bf63a@kernel.dk>
Date:   Thu, 3 Oct 2019 08:05:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <41B90CA7-E093-48FA-BDFD-73BE7EB81FB6@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/3/19 8:01 AM, Chris Mason wrote:
> 
> 
> On 3 Oct 2019, at 4:41, Gao Xiang wrote:
> 
>> Hi,
>>
>> On Thu, Oct 03, 2019 at 04:40:22PM +1000, Dave Chinner wrote:
>>> [cc linux-fsdevel, linux-block, tejun ]
>>>
>>> On Wed, Oct 02, 2019 at 06:52:47PM -0700, Darrick J. Wong wrote:
>>>> Hi everyone,
>>>>
>>>> Does anyone /else/ see this crash in generic/299 on a V4 filesystem
>>>> (tho
>>>> afaict V5 configs crash too) and a 5.4-rc1 kernel?  It seems to pop
>>>> up
>>>> on generic/299 though only 80% of the time.
>>>>
>>
>> Just a quick glance, I guess there could is a race between (complete
>> guess):
>>
>>
>>   160 static void finish_writeback_work(struct bdi_writeback *wb,
>>   161                                   struct wb_writeback_work *work)
>>   162 {
>>   163         struct wb_completion *done = work->done;
>>   164
>>   165         if (work->auto_free)
>>   166                 kfree(work);
>>   167         if (done && atomic_dec_and_test(&done->cnt))
>>
>>   ^^^ here
>>
>>   168                 wake_up_all(done->waitq);
>>   169 }
>>
>> since new wake_up_all(done->waitq); is completely on-stack,
>>   	if (done && atomic_dec_and_test(&done->cnt))
>> -		wake_up_all(&wb->bdi->wb_waitq);
>> +		wake_up_all(done->waitq);
>>   }
>>
>> which could cause use after free if on-stack wb_completion is gone...
>> (however previous wb->bdi is solid since it is not on-stack)
>>
>> see generic on-stack completion which takes a wait_queue spin_lock
>> between
>> test and wake_up...
>>
>> If I am wrong, ignore me, hmm...
> 
> It's a good guess ;)  Jens should have this queued up already:
> 
> https://lkml.org/lkml/2019/9/23/972

Yes indeed, it'll go out today or tomorrow for -rc2.

-- 
Jens Axboe

