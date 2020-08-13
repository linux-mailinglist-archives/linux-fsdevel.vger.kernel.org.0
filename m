Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C7A243CAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 17:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHMPkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgHMPkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:40:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A31C061383
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 08:40:03 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so5568518qka.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2020 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K6SkAOrGKcjRY+yhyH0qCJ6Gsotdol6Tl8RV+rGqmCQ=;
        b=mhfJ083GRlJUkPiwVXMO9T1daKwgJ43+ouGmjEel2lLAE5cShfg6XTgVErn12vdSgi
         Pti3KERJIgMLjXfNqmJIJ5JkY36zA6jPoeIx6TDWSCDpRpVfw4r5KZOv+AvpMU/9PiNC
         T3aMkbTbky8P02pmTRD6kPjG4gHDeOscNuo4johMQe84MbUfiNPx2Gfuuqmns1+fGtHN
         O4DJzQ/VK/EmHkD7YOHM5RoLzhIejlHD7dJn2TgD0JkWDTBYDz/m4UEbv21Kb0l5fAM9
         YXAvhZRSXrGz+SKlsvsf+s4JRjnLi7K86irYNkB8Rb70C9L+lIt+qPY9m6voSTbou2TB
         exYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K6SkAOrGKcjRY+yhyH0qCJ6Gsotdol6Tl8RV+rGqmCQ=;
        b=b8LOFN4BhCHjaciokOju+4k55ESuRBa6fVH7+rfyDMybt8cqzyeju2R8RQEtBqKsdJ
         yZ/mCt+fMv707RVkN/2i0Jlf15POKrHJaWj6FbKRDwjNarG0q3Sg0KdGrOc2dhOfP2LD
         RF+nczn+q3p4E4h2kcQIiiibSB0Q1wdq+g90Yk6yCcBvQ49RA9UoIXoaGNP8b+HRiRrr
         To55NdjHnSxaO+RPPjqY35BTdtQgxjkTjfxvl+5FskO7UP5jA4LrC6KOI2eyEQaVufvZ
         U6bhQ0O8UUNu0iUNP2gXMD8Ky/Smc4w1EN/7PIN73zekgaHY3ZWjDBSC8TZyL9sZ6f/b
         LCqw==
X-Gm-Message-State: AOAM531vn8zexzmkqjVwJ2EnkEx5xfpOIENf2dOmLsDkxmXWfYmM0N0b
        oQwAiQEURWpRL1TFKoTxW8/X5A==
X-Google-Smtp-Source: ABdhPJzO7FfjFRSvgKU9zDx0wbHBiRPRxQpL1y0Z0l7g0EYvAarRoJ7G+2qB0t4ccDiGe3UcWAo+xw==
X-Received: by 2002:a05:620a:8c4:: with SMTP id z4mr5505141qkz.146.1597333202826;
        Thu, 13 Aug 2020 08:40:02 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a7? ([2620:10d:c091:480::1:8f88])
        by smtp.gmail.com with ESMTPSA id w2sm5557765qkf.6.2020.08.13.08.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:40:01 -0700 (PDT)
Subject: Re: [PATCH][v2] proc: use vmalloc for our kernel buffer
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@ZenIV.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        willy@infradead.org
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <20200813153356.857625-1-josef@toxicpanda.com>
 <20200813153722.GA13844@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
Date:   Thu, 13 Aug 2020 11:40:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813153722.GA13844@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/20 11:37 AM, Christoph Hellwig wrote:
> On Thu, Aug 13, 2020 at 11:33:56AM -0400, Josef Bacik wrote:
>> Since
>>
>>    sysctl: pass kernel pointers to ->proc_handler
>>
>> we have been pre-allocating a buffer to copy the data from the proc
>> handlers into, and then copying that to userspace.  The problem is this
>> just blind kmalloc()'s the buffer size passed in from the read, which in
>> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
>> awesome, and since we can potentially allocate up to our maximum order,
>> use vmalloc for these buffers.
>>
>> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>> v1->v2:
>> - Make vmemdup_user_nul actually do the right thing...sorry about that.
>>
>>   fs/proc/proc_sysctl.c  |  6 +++---
>>   include/linux/string.h |  1 +
>>   mm/util.c              | 27 +++++++++++++++++++++++++++
>>   3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index 6c1166ccdaea..207ac6e6e028 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -571,13 +571,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
>>   		goto out;
>>   
>>   	if (write) {
>> -		kbuf = memdup_user_nul(ubuf, count);
>> +		kbuf = vmemdup_user_nul(ubuf, count);
> 
> Given that this can also do a kmalloc and thus needs to be paired
> with kvfree shouldn't it be kvmemdup_user_nul?
> 

There's an existing vmemdup_user that does kvmalloc, so I followed the existing 
naming convention.  Do you want me to change them both?  Thanks,

Josef
