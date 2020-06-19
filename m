Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824D620115B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 17:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405076AbgFSPkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393976AbgFSPkb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:40:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83F3C0613EF
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 08:40:30 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so10092389wrm.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2020 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GhSNBxDKbn6nBfMJVSEklUqTmc5VYdnltMLc9NLyjws=;
        b=AmBkZxKjMUUlEx7k7N+LYnqXSSheZv4Sn5fmEWi/PMC8DAJ4aJb9chmEppUzWYWAcm
         tBqyAzu1N2/hc3SdmbwdXakKJf+Lo6Y02nQF7C1usnO1nv9mVk2PnZbXTRGEbcWypApd
         ksQ2Y78a/ZiM0JP8a2nbenivKl+tYsO6igupGCfwxQYLzl/oFfoflUD7VMin2RcKDIge
         V22B0axDaPmAFE+CYTMU3NclL+xlArH5LDMBZ2Siac1H2C3uDcL5A4rqvexaO5Sc1AQ3
         HpkUi7rSGYto/B+NmDFjRL+IyRTp6KZ0vTvVkXX5dmDJWb7tuYZ88uo0MKpcpcFYD2OE
         +33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GhSNBxDKbn6nBfMJVSEklUqTmc5VYdnltMLc9NLyjws=;
        b=WVJxKk5Euhg5brMrWzx0gwAZmQaYlZifkm0v+Yj/TvYFpI+TXUru+4dxwLq38skEL1
         Zt0bErwD4BWlto0e+T9FOqfVDmJ/HiECS1RK+GBhmQkwGPv1s5FM4ZmSysfu7OXx2dFh
         Tz4F/jXlDqFvOwABxZLRRaJa5tvTUUaXqCQ+AGE5i/MhPAo9EIGvm09Nk6oFdP/Icwl/
         GYCPSOYnkwPJQB5NbzPznTgK2hd010NXe0d5S1csRjwfEJwxLuR4liRarpeFVMGlq3B0
         yF3Fq0Ta/aNwgEVrrczZukhNi1e/XEMxxcs9Zgeb6GklA5i4X0tQdOHJVPgaNtifVuez
         iSpg==
X-Gm-Message-State: AOAM532cMkhwUh+WL0AjqgtgWHoMfekElBlHrXIeJkP7EnCXTIUjSuH7
        zqhl9aacjVeXGvCbkRn7GbLCtA==
X-Google-Smtp-Source: ABdhPJx23d5Sv/R7KejVajjLfNe+kLGkGC6dETXWq2zVirgiNViSZflKHvbILtKINIJMTDTwqo1cdg==
X-Received: by 2002:adf:e887:: with SMTP id d7mr4699820wrm.62.1592581229218;
        Fri, 19 Jun 2020 08:40:29 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id j5sm7632166wrm.57.2020.06.19.08.40.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 08:40:28 -0700 (PDT)
Subject: Re: [PATCH 3/3] io_uring: add support for zone-append
To:     Jens Axboe <axboe@kernel.dk>,
        "javier.gonz@samsung.com" <javier@javigon.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Kanchan Joshi <joshi.k@samsung.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "bcrl@kvack.org" <bcrl@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "selvakuma.s1@samsung.com" <selvakuma.s1@samsung.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>
References: <1592414619-5646-1-git-send-email-joshi.k@samsung.com>
 <CGME20200617172713epcas5p352f2907a12bd4ee3c97be1c7d8e1569e@epcas5p3.samsung.com>
 <1592414619-5646-4-git-send-email-joshi.k@samsung.com>
 <CY4PR04MB37510E916B6F243D189B4EB0E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200618083529.ciifu4chr4vrv2j5@mpHalley.local>
 <CY4PR04MB3751D5D6AFB0DA7B8A2DFF61E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200618091113.eu2xdp6zmdooy5d2@mpHalley.local>
 <20200619094149.uaorbger326s6yzz@mpHalley.local>
 <2ba2079c-9a5d-698a-a8f0-cbd6fdb9a9f0@lightnvm.io>
 <ca513fd1-4ca2-c16e-8b99-73cbd7fe6290@kernel.dk>
 <317fa6b5-ce64-114e-b34d-2be7b50c24f1@lightnvm.io>
 <26f41284-6e52-58d3-6119-8ed34511e5dc@kernel.dk>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <87f750fb-d217-ab37-9790-de9ad1ef4a87@lightnvm.io>
Date:   Fri, 19 Jun 2020 17:40:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <26f41284-6e52-58d3-6119-8ed34511e5dc@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 19/06/2020 17.20, Jens Axboe wrote:
> On 6/19/20 9:14 AM, Matias Bjørling wrote:
>> On 19/06/2020 16.18, Jens Axboe wrote:
>>> On 6/19/20 5:15 AM, Matias Bjørling wrote:
>>>> On 19/06/2020 11.41, javier.gonz@samsung.com wrote:
>>>>> Jens,
>>>>>
>>>>> Would you have time to answer a question below in this thread?
>>>>>
>>>>> On 18.06.2020 11:11, javier.gonz@samsung.com wrote:
>>>>>> On 18.06.2020 08:47, Damien Le Moal wrote:
>>>>>>> On 2020/06/18 17:35, javier.gonz@samsung.com wrote:
>>>>>>>> On 18.06.2020 07:39, Damien Le Moal wrote:
>>>>>>>>> On 2020/06/18 2:27, Kanchan Joshi wrote:
>>>>>>>>>> From: Selvakumar S <selvakuma.s1@samsung.com>
>>>>>>>>>>
>>>>>>>>>> Introduce three new opcodes for zone-append -
>>>>>>>>>>
>>>>>>>>>>     IORING_OP_ZONE_APPEND     : non-vectord, similiar to
>>>>>>>>>> IORING_OP_WRITE
>>>>>>>>>>     IORING_OP_ZONE_APPENDV    : vectored, similar to IORING_OP_WRITEV
>>>>>>>>>>     IORING_OP_ZONE_APPEND_FIXED : append using fixed-buffers
>>>>>>>>>>
>>>>>>>>>> Repurpose cqe->flags to return zone-relative offset.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
>>>>>>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>>>>>>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>>>>>>> Signed-off-by: Javier Gonzalez <javier.gonz@samsung.com>
>>>>>>>>>> ---
>>>>>>>>>> fs/io_uring.c                 | 72
>>>>>>>>>> +++++++++++++++++++++++++++++++++++++++++--
>>>>>>>>>> include/uapi/linux/io_uring.h |  8 ++++-
>>>>>>>>>> 2 files changed, 77 insertions(+), 3 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>>>>>>> index 155f3d8..c14c873 100644
>>>>>>>>>> --- a/fs/io_uring.c
>>>>>>>>>> +++ b/fs/io_uring.c
>>>>>>>>>> @@ -649,6 +649,10 @@ struct io_kiocb {
>>>>>>>>>>       unsigned long        fsize;
>>>>>>>>>>       u64            user_data;
>>>>>>>>>>       u32            result;
>>>>>>>>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>>>>>>>>> +    /* zone-relative offset for append, in bytes */
>>>>>>>>>> +    u32            append_offset;
>>>>>>>>> this can overflow. u64 is needed.
>>>>>>>> We chose to do it this way to start with because struct io_uring_cqe
>>>>>>>> only has space for u32 when we reuse the flags.
>>>>>>>>
>>>>>>>> We can of course create a new cqe structure, but that will come with
>>>>>>>> larger changes to io_uring for supporting append.
>>>>>>>>
>>>>>>>> Do you believe this is a better approach?
>>>>>>> The problem is that zone size are 32 bits in the kernel, as a number
>>>>>>> of sectors.
>>>>>>> So any device that has a zone size smaller or equal to 2^31 512B
>>>>>>> sectors can be
>>>>>>> accepted. Using a zone relative offset in bytes for returning zone
>>>>>>> append result
>>>>>>> is OK-ish, but to match the kernel supported range of possible zone
>>>>>>> size, you
>>>>>>> need 31+9 bits... 32 does not cut it.
>>>>>> Agree. Our initial assumption was that u32 would cover current zone size
>>>>>> requirements, but if this is a no-go, we will take the longer path.
>>>>> Converting to u64 will require a new version of io_uring_cqe, where we
>>>>> extend at least 32 bits. I believe this will need a whole new allocation
>>>>> and probably ioctl().
>>>>>
>>>>> Is this an acceptable change for you? We will of course add support for
>>>>> liburing when we agree on the right way to do this.
>>>> I took a quick look at the code. No expert, but why not use the existing
>>>> userdata variable? use the lowest bits (40 bits) for the Zone Starting
>>>> LBA, and use the highest (24 bits) as index into the completion data
>>>> structure?
>>>>
>>>> If you want to pass the memory address (same as what fio does) for the
>>>> data structure used for completion, one may also play some tricks by
>>>> using a relative memory address to the data structure. For example, the
>>>> x86_64 architecture uses 48 address bits for its memory addresses. With
>>>> 24 bit, one can allocate the completion entries in a 32MB memory range,
>>>> and then use base_address + index to get back to the completion data
>>>> structure specified in the sqe.
>>> For any current request, sqe->user_data is just provided back as
>>> cqe->user_data. This would make these requests behave differently
>>> from everything else in that sense, which seems very confusing to me
>>> if I was an application writer.
>>>
>>> But generally I do agree with you, there are lots of ways to make
>>> < 64-bit work as a tag without losing anything or having to jump
>>> through hoops to do so. The lack of consistency introduced by having
>>> zone append work differently is ugly, though.
>>>
>> Yep, agree, and extending to three cachelines is big no-go. We could add
>> a flag that said the kernel has changes the userdata variable. That'll
>> make it very explicit.
> Don't like that either, as it doesn't really change the fact that you're
> now doing something very different with the user_data field, which is
> just supposed to be passed in/out directly. Adding a random flag to
> signal this behavior isn't very explicit either, imho. It's still some
> out-of-band (ish) notification of behavior that is different from any
> other command. This is very different from having a flag that says
> "there's extra information in this other field", which is much cleaner.
>
Ok. Then it's pulling in the bits from cqe->res and cqe->flags that you 
mention in the other mail. Sounds good.

