Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD0337FB51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 18:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhEMQQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 12:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbhEMQQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 12:16:51 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C1C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 May 2021 09:15:38 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id t1so928908qvz.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 May 2021 09:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CpBtM9FtVod+gxuw6KNEPrQb2ZhUJeUilXqd0/IO794=;
        b=DN5jcTcLpBHfkTzhvP2qoL4+j/duZboAI+AhIqXz9rIzbb88ZYycKnHkU0kuBuqXet
         az4OM1BI9TOBhEjJAWL1oC8m8bW7bOMXFivKDZU4MUjryJl9uI9HwJwQd4sPSQ41J3+k
         iPlIXalLS3sxhGUneTjqGGkBVO988Ct/AJxmm2h5fHv9X+cuy3gKxzied/lA5LWm1KO8
         8doAgeX0r+zTSE83qwhfAxg3P3KRMjwJuT4cA2YkTp8vcLXpC8egM2smWSHABaJb/Jy+
         U8e0daOmJZroEgrlejKt+Gmd0Rtu3uBWr1g16cEUPeUfm/DSCL2VuHjqcICKkO0azTo2
         uUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CpBtM9FtVod+gxuw6KNEPrQb2ZhUJeUilXqd0/IO794=;
        b=UXK31ET0hSIYwKa1AuV/1apnNDFjgYw+ots88tKXJQ1wzAiuwNb3oJRHxtiV3Lnwey
         XMKsnILZvvRiRwvA2psYnRCO1kBASb1DVLNRLI5X8wvcj4PWHiIfvt2oQCQBIAEaN8HB
         ja2hD5LdCEfhb1zRZ1E1Yx1VUKDwCLXs/2c0xXCRoTm9JN1zmxLz5JfajwLxENn/xCFB
         USC3ppMPFswiwMdT2XULIThycCBPYHsf2+L1TXqUNP9HqQEvdvUEnhBP7tMU8gPHCqTR
         crcBd+wNq3yCRdopt8rdbUTV5gItI8FhPSduA9qe/xTuLOfNIplhSCj5/vaHubQmD0NQ
         6/Xw==
X-Gm-Message-State: AOAM532Mqbpf/dyqKuDgDtmc/lpxhl/0X7tSgHpeGxJM6zS9T7Kla+CG
        ifMT/kTfbqiiwU/sfNHNHLF/Xg==
X-Google-Smtp-Source: ABdhPJywKKBopGqqNbrU7LyfT+1v4Ml63xfWJnUPwe6ZxHDg+JSo9DQGpYv8RHHtSCP02lk15n/ukA==
X-Received: by 2002:a05:6214:964:: with SMTP id do4mr42076512qvb.36.1620922537453;
        Thu, 13 May 2021 09:15:37 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::1214? ([2620:10d:c091:480::1:7c1f])
        by smtp.gmail.com with ESMTPSA id h12sm2764158qkj.52.2021.05.13.09.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 09:15:36 -0700 (PDT)
Subject: Re: [PATCH] sysctl: Limit the size of I/Os to PAGE_SIZE
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-abi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20210513160649.2280429-1-willy@infradead.org>
 <47a34aa5-ad1a-6259-d9cb-f85f314f9ffb@toxicpanda.com>
Message-ID: <b761c108-25c4-634a-8aed-d88cc00aedfe@toxicpanda.com>
Date:   Thu, 13 May 2021 12:15:34 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <47a34aa5-ad1a-6259-d9cb-f85f314f9ffb@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/13/21 12:12 PM, Josef Bacik wrote:
> On 5/13/21 12:06 PM, Matthew Wilcox (Oracle) wrote:
>> We currently allow a read or a write that is up to KMALLOC_MAX_SIZE.
>> This has caused problems when cat decides to do a 64kB read and
>> so we allocate a 64kB buffer for the sysctl handler to store into.
>> The immediate problem was fixed by switching to kvmalloc(), but it's
>> ridiculous to allocate so much memory to read what is likely to be a
>> few bytes.
>>
>> sysfs limits reads and writes to PAGE_SIZE, and I feel we should do the
>> same for sysctl.  The largest sysctl anyone's been able to come up with
>> is 433 bytes for /proc/sys/dev/cdrom/info
>>
>> This will allow simplifying the BPF sysctl code later, but I'll leave
>> that for someone who understands it better.
>>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>   fs/proc/proc_sysctl.c | 15 +++++++++------
>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
>> index dea0f5ee540c..a97a8a4ff270 100644
>> --- a/fs/proc/proc_sysctl.c
>> +++ b/fs/proc/proc_sysctl.c
>> @@ -562,11 +562,14 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, 
>> struct iov_iter *iter,
>>       if (!table->proc_handler)
>>           goto out;
>> -    /* don't even try if the size is too large */
>> +    /* reads may return short values; large writes must fail now */
>> +    if (count >= PAGE_SIZE) {
>> +        if (write)
>> +            goto out;
>> +        count = PAGE_SIZE;
>> +    }
>>       error = -ENOMEM;
>> -    if (count >= KMALLOC_MAX_SIZE)
>> -        goto out;
>> -    kbuf = kvzalloc(count + 1, GFP_KERNEL);
>> +    kbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>>       if (!kbuf)
>>           goto out;
> 
> Below here we have
> 
> kbuf[count] = '\0';
> 

Nevermind I just re-read it and it's

if (write)
	kbuf[count] = '\0';

I'm stupid, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
