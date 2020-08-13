Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43669243E29
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMRTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 13:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHMRTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:19:23 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F47C061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 10:19:22 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id x6so2969356qvr.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 10:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gG3QhBSmvxEmkeggBu4YpeOeDbfqTTnXI4PDot46vj4=;
        b=YL0Vf/WekjB5AM1fC7TEY+E6+AVRqgLtZXfd25s9QHxsEHencNoK4s9J8XEWbUDCyW
         eipm4TQKkJVy8x2OpmcGo/sSjuWf6h1Ph9avHZp3SteAHGcWiS94x3uw7HzqpCzxgTIE
         D+FH60umOiEqnTrvVxKMqMaOflUpIvT5m6kMH+MLbYn1/puoRaw2wFJmWDCBJkinxKHj
         axsDdmko2LluqA+kzh89WeY+fF+/RFduhpJHvBSQ4nddTp2aOnUXLZ2wtToC5hYz14dz
         XUBVgKD4pu9wtN/UovuOeR8caAetpMTxc5RWl/MaEC9UKQv3mEKOai25E/h/okkbAbxs
         BnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gG3QhBSmvxEmkeggBu4YpeOeDbfqTTnXI4PDot46vj4=;
        b=hUnIZwo1+NQlRFIcV169OQS6IZF0GppqaoLFOs/wlsAtaaYQyl6HRHXbT6UVHRxPb4
         IqVMhRIPH4ecyrZdTWXbEy55iADw0PoRkn0A4VXaUgldALh3spzOytQAOucJfhLQM7de
         Oznp5zqgdx3od+Fxs3Z86OhOG4EY8h9LWFO4xD0hMboBdbcv2X08G53WW+4XzZtQNY3F
         lwVTwPaPL0GV5GS/fsawtGXXBcSZ/gPjD4+qf9rW/ViY4LXKcRgutwrtnz50P1vHo/pg
         Y6hLHfgEYmGE6kgwbloA4tySrYTSXeYfL0BCaOJB4dFSHpumrN9SjW4okhdjKAm4XVS7
         Ax1A==
X-Gm-Message-State: AOAM532+NsNDhyjclPFJKMZdTLC6BbOUk64cGZo5nDwrvopdYd+pkEaD
        teWOe7aelCbwp4Dzb3ccd6jqTw==
X-Google-Smtp-Source: ABdhPJwWp3EFYJ40IG50E8vXi2UTR2lQo5LyYbQiLWLmjIS0cYtoZwiOj9S4sgM/8CXPlK0MQJKrYg==
X-Received: by 2002:a0c:f64a:: with SMTP id s10mr5666652qvm.196.1597339160681;
        Thu, 13 Aug 2020 10:19:20 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a7? ([2620:10d:c091:480::1:fe9c])
        by smtp.gmail.com with ESMTPSA id l13sm6749820qth.77.2020.08.13.10.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:19:19 -0700 (PDT)
Subject: Re: [PATCH][v2] proc: use vmalloc for our kernel buffer
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com, willy@infradead.org
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <20200813153356.857625-1-josef@toxicpanda.com>
 <20200813153722.GA13844@lst.de>
 <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
 <20200813154117.GA14149@lst.de> <20200813162002.GX1236603@ZenIV.linux.org.uk>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9e4d3860-5829-df6f-aad4-44d07c62535b@toxicpanda.com>
Date:   Thu, 13 Aug 2020 13:19:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813162002.GX1236603@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/20 12:20 PM, Al Viro wrote:
> On Thu, Aug 13, 2020 at 05:41:17PM +0200, Christoph Hellwig wrote:
>> On Thu, Aug 13, 2020 at 11:40:00AM -0400, Josef Bacik wrote:
>>> On 8/13/20 11:37 AM, Christoph Hellwig wrote:
>>>> On Thu, Aug 13, 2020 at 11:33:56AM -0400, Josef Bacik wrote:
>>>>> Since
>>>>>
>>>>>     sysctl: pass kernel pointers to ->proc_handler
>>>>>
>>>>> we have been pre-allocating a buffer to copy the data from the proc
>>>>> handlers into, and then copying that to userspace.  The problem is this
>>>>> just blind kmalloc()'s the buffer size passed in from the read, which in
>>>>> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
>>>>> awesome, and since we can potentially allocate up to our maximum order,
>>>>> use vmalloc for these buffers.
>>>>>
>>>>> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
>>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>>> ---
>>>>> v1->v2:
>>>>> - Make vmemdup_user_nul actually do the right thing...sorry about that.
>>>>>
>>>>>    fs/proc/proc_sysctl.c  |  6 +++---
>>>>>    include/linux/string.h |  1 +
>>>>>    mm/util.c              | 27 +++++++++++++++++++++++++++
>>>>>    3 files changed, 31 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>>>>> index 6c1166ccdaea..207ac6e6e028 100644
>>>>> --- a/fs/proc/proc_sysctl.c
>>>>> +++ b/fs/proc/proc_sysctl.c
>>>>> @@ -571,13 +571,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
>>>>>    		goto out;
>>>>>      	if (write) {
>>>>> -		kbuf = memdup_user_nul(ubuf, count);
>>>>> +		kbuf = vmemdup_user_nul(ubuf, count);
>>>>
>>>> Given that this can also do a kmalloc and thus needs to be paired
>>>> with kvfree shouldn't it be kvmemdup_user_nul?
>>>>
>>>
>>> There's an existing vmemdup_user that does kvmalloc, so I followed the
>>> existing naming convention.  Do you want me to change them both?  Thanks,
>>
>> I personally would, and given that it only has a few users it might
>> even be feasible.
> 
> FWIW, how about following or combining that with "allocate count + 1 bytes on
> the read side"?  Allows some nice cleanups - e.g.
>                  len = sprintf(tmpbuf, "0x%04x", *(unsigned int *) table->data);
>                  if (len > left)
>                          len = left;
>                  memcpy(buffer, tmpbuf, len);
>                  if ((left -= len) > 0) {
>                          *((char *)buffer + len) = '\n';
>                          left--;
>                  }
> in sunrpc proc_dodebug() turns into
> 		left -= snprintf(buffer, left, "0x%04x\n",
> 				 *(unsigned int *) table->data);
> and that's not the only example.
> 

We wouldn't even need the extra +1 part, since we're only copying in how much 
the user wants anyway, we could just go ahead and convert this to

left -= snprintf(buffer, left, "0x%04x\n", *(unsigned int *) table->data);

and be fine, right?  Or am I misunderstanding what you're looking for?  Thanks,

Josef
