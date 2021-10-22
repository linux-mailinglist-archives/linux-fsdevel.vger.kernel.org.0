Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19685437A49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhJVPuI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 11:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhJVPuH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 11:50:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0834C061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 08:47:49 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r6so5549397oiw.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Oct 2021 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=98aqozTyb6imRb5769b/fP4VZY5mcr0bD6eAm2Im+go=;
        b=MhTuSOhn021Pjoh3MzA9VJHc+OL4jvnSFrLAbRMWsYU6G+U19D+mDOGRHLOAmG2Kok
         nxCLt2idVytSqMP3xA+IhLFQk3mPRQqxKb/X//hbIITQmUUpGas5q4TiJtP3JYxRFS5f
         bP0UuwVMWr26GxKtOkpgsUEds6xQfLuFf+V7K9zd42GQrvzgb7ZTX52CP86FXO4ALRVn
         1GH4D+L1Kt223rWrTjJOY1laai2xdhCCULnT6yo2F2/tVX0OpSBOQdOQO4Se4XHXty9t
         KKCoWSTp9gxw1f1GjdzaWo/UeHuMZhuTDrsqeUpbBNAiIe+9SCe72zLOUksxUADbCfvw
         KeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=98aqozTyb6imRb5769b/fP4VZY5mcr0bD6eAm2Im+go=;
        b=lmZ7K7dzmEzvfam7zDCc/R95C2A8vOipMzpFD71ywiQxJvW09rD6YjypRGBWvdRNqN
         JGvwZp0jLA7PokxaUqbbrK31npBs8QqDorQyro4HWVhlk8zjXWEeuPkohpGdDmQ8xB1Z
         2zUWfj9BBN+GCyb5IeOurNemBENYWHP3kkpUZjV9VkWafWQLbnUBAcfeTGKZVVeiQp3v
         LQ+kbf/wQIbX+O/nBzfc4o5NJxIbOFtJAW4bNv2LSxUCfyLkGkSAwyigxrMBGYrMzQzw
         8SK02aWkRlF4oCQbfIF9AKOtR7p+vtokuGGM3kGjbGsLw3YlLFtoyq090rGzgSjiAZQE
         FC7A==
X-Gm-Message-State: AOAM531Yh7uNISd2Y7VIl8TlUu6ZvM2xA9OVOcrONoNdmSTQ4YA6t+TP
        a69gjKhWn4EESG1fwTAU5+tlEg==
X-Google-Smtp-Source: ABdhPJy2LFGeh+v45Nh92qJQ3LN4T8PmSVR5XlIbvUsg1sND/zHpht5ZmBC133kBtn5X/cIiEq34qA==
X-Received: by 2002:aca:bec1:: with SMTP id o184mr10000565oif.43.1634917668950;
        Fri, 22 Oct 2021 08:47:48 -0700 (PDT)
Received: from [172.20.15.86] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id bc41sm1668658oob.2.2021.10.22.08.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 08:47:48 -0700 (PDT)
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments with
 a single argument
From:   Jens Axboe <axboe@kernel.dk>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org> <YXFHgy85MpdHpHBE@infradead.org>
 <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
 <YXF8X3RgRfZpL3Cb@infradead.org>
 <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
 <x49ee8ev21s.fsf@segfault.boston.devel.redhat.com>
 <6338ba2b-cd71-f66d-d596-629c2812c332@kernel.dk>
 <x497de6uubq.fsf@segfault.boston.devel.redhat.com>
 <7a697483-8e44-6dc3-361e-ae7b62b82074@kernel.dk>
 <x49wnm6t7r9.fsf@segfault.boston.devel.redhat.com>
 <x49sfwut7i8.fsf@segfault.boston.devel.redhat.com>
 <d67c3d6f-56a2-4ace-7b57-cb9c594ad82c@kernel.dk>
 <67127b02-2b58-5944-8bfb-e842182d6459@kernel.dk>
Message-ID: <f6b4b409-c86e-7e18-10f5-a37f2d762b0e@kernel.dk>
Date:   Fri, 22 Oct 2021 09:47:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <67127b02-2b58-5944-8bfb-e842182d6459@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/22/21 9:29 AM, Jens Axboe wrote:
> On 10/22/21 8:19 AM, Jens Axboe wrote:
>> On 10/21/21 3:03 PM, Jeff Moyer wrote:
>>> Jeff Moyer <jmoyer@redhat.com> writes:
>>>
>>>> Jens Axboe <axboe@kernel.dk> writes:
>>>>
>>>>> On 10/21/21 12:05 PM, Jeff Moyer wrote:
>>>>>>
>>>>>>>> I'll follow up if there are issues.
>>>>>>
>>>>>> s390 (big endian, 64 bit) is failing libaio test 21:
>>>>>>
>>>>>> # harness/cases/21.p
>>>>>> Expected -EAGAIN, got 4294967285
>>>>>>
>>>>>> If I print out both res and res2 using %lx, you'll see what happened:
>>>>>>
>>>>>> Expected -EAGAIN, got fffffff5,ffffffff
>>>>>>
>>>>>> The sign extension is being split up.
>>>>>
>>>>> Funky, does it work if you apply this on top?
>>>>>
>>>>> diff --git a/fs/aio.c b/fs/aio.c
>>>>> index 3674abc43788..c56437908339 100644
>>>>> --- a/fs/aio.c
>>>>> +++ b/fs/aio.c
>>>>> @@ -1442,8 +1442,8 @@ static void aio_complete_rw(struct kiocb *kiocb, u64 res)
>>>>>  	 * 32-bits of value at most for either value, bundle these up and
>>>>>  	 * pass them in one u64 value.
>>>>>  	 */
>>>>> -	iocb->ki_res.res = lower_32_bits(res);
>>>>> -	iocb->ki_res.res2 = upper_32_bits(res);
>>>>> +	iocb->ki_res.res = (long) (res & 0xffffffff);
>>>>> +	iocb->ki_res.res2 = (long) (res >> 32);
>>>>>  	iocb_put(iocb);
>>>>>  }
>>>>
>>>> I think you'll also need to clamp any ki_complete() call sites to 32
>>>> bits (cast to int, or what have you).  Otherwise that sign extension
>>>> will spill over into res2.
>>>>
>>>> fwiw, I tested with this:
>>>>
>>>> 	iocb->ki_res.res = (long)(int)lower_32_bits(res);
>>>> 	iocb->ki_res.res2 = (long)(int)upper_32_bits(res);
>>>>
>>>> Coupled with the call site changes, that made things work for me.
>>>
>>> This is all starting to feel like a minefield.  If you don't have any
>>> concrete numbers to show that there is a speedup, I think we should
>>> shelf this change.
>>
>> It's really not a minefield at all, we just need a proper help to encode
>> the value. I'm out until Tuesday, but I'll sort it out when I get back.
>> Can also provide some numbers on this.
> 
> I think this incremental should fix it, also providing a helper to
> properly pack these. The more I look at the gadget stuff the more I also
> get the feeling that it really is wonky and nobody uses res2, which
> would be a nice cleanup to continue. But I think it should be separate.

For the record, deferring all of this until next week when I'm back.
I'll pick it back up then, obviously this isn't an urgent thing at all,
would just love to sort out the useless argument going down the line.
We'd need to pack all of them, not just the odd ones out.

-- 
Jens Axboe

