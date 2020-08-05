Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25CD23C318
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 03:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgHEBop (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 21:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHEBom (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:44:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFDAC06174A;
        Tue,  4 Aug 2020 18:44:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so1407181pfw.9;
        Tue, 04 Aug 2020 18:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H7BJuPQcZ5V/7UBDAvP8UACTKplyPBFmmLy/DLb8wI8=;
        b=MAKSAnD05LKUMQ8kuUvEdsOfKICcqnCV29ChGGtTJNnr4IpU5YOKzBryRhhhg54ib7
         kdZeZT+5+GjlzQM6LCeSo2zj5q1kj8XS90fPAjb2tNOTt9g9C+a6VE2J98pi/bAa4xwg
         eXwQIfGW+fr671TiIH8FcS0JKWhu2jtTpS9bBtQG6O5pPyE1jJnhvYqd+/5koSqr5iIN
         SsO7yy6IiPv+7cEk10gBZ8m0keJpkcNGLMTqt5W+cBiY0cLfQXGrn3LK5pBzUqwyMAJa
         6m9banQHsTzcoaKEHMvPVyhyT06LQDul29CTt2CqsXOx3PuDAqT/JLOSRDzEGi1vfbqv
         lvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H7BJuPQcZ5V/7UBDAvP8UACTKplyPBFmmLy/DLb8wI8=;
        b=gMVaLEeIsh8YSktcihiKkENv3giubhrWzuqObK16XYCUIysZ9S1lDhvGidMJVXbR6q
         PSfNSOPtGIwYR//XOgsfJ5BINibWq2zGplJ/Y4gqG+Ihmq/9Qyuld5vkkMECFYddOelM
         X+XmW6O33Kk0RadtgJEmYzvcCT08B1RXKbJWiWl8We/OOf2J9VhGexY+XmRQk7fnkYPA
         HiPWghvobSko1aUGq3PCUbAYmtRHqNTKYgfa+Z7wnigXb08k2JNdgHXadawOTudO4VGv
         rgf2R0zMuZHfxvUiiQHu2oLdK62U0nKnCdBL8uEP3OIu1w5V6MfNMH8NyAHWSKxegAt/
         ASxA==
X-Gm-Message-State: AOAM533zSYRhSQtIoXe2cUCt6+zY02TpTSotW+7x3l2dnjQvhY8RTdcy
        PH9rLSpISpmTyoWdqygCJ1CSo2MO
X-Google-Smtp-Source: ABdhPJwIk329Jse0FHZbrQnU0oOrRPnSdv1tfi6sxSo70DizzLpuKPvIUSHCr/ieY3v0WidLQkb7Kg==
X-Received: by 2002:aa7:9e5d:: with SMTP id z29mr1127451pfq.122.1596591881763;
        Tue, 04 Aug 2020 18:44:41 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:d05c:a260:d7a2:2303? ([2404:7a87:83e0:f800:d05c:a260:d7a2:2303])
        by smtp.gmail.com with ESMTPSA id c9sm510042pjr.35.2020.08.04.18.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 18:44:41 -0700 (PDT)
Subject: Re: [PATCH v2] exfat: integrates dir-entry getting and validation
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        Motai.Hirotaka@aj.MitsubishiElectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200715012304epcas1p23e9f45415afc551beea122e4e1bdb933@epcas1p2.samsung.com>
 <20200715012249.16378-1-kohada.t2@gmail.com>
 <015d01d6663e$1eb8c780$5c2a5680$@samsung.com>
 <TY2PR01MB287579A95A7994DE2B34E425904D0@TY2PR01MB2875.jpnprd01.prod.outlook.com>
 <001c01d669fe$8ab7cf80$a0276e80$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <05c5c1e9-2ccf-203d-5e8c-1c951004a7f9@gmail.com>
Date:   Wed, 5 Aug 2020 10:44:36 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <001c01d669fe$8ab7cf80$a0276e80$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>> +	i = 2;
>>>> +	while ((ep = exfat_get_validated_dentry(es, i++, TYPE_NAME))) {
>>> As Sungjong said, I think that TYPE_NAME seems right to be validated in exfat_get_dentry_set().
>>
>> First, it is possible to correctly determine that "Immediately follow the Stream Extension directory
>> entry as a consecutive series"
>> whether the TYPE_NAME check is implemented here or exfat_get_dentry_set().
>> It's functionally same, so it is also right to validate in either.
>>
>> Second, the current implementation does not care for NameLength field, as I replied to Sungjong.
>> If name is not terminated with zero, the name will be incorrect.(With or without my patch) I think
>> TYPE_NAME and NameLength validation should not be separated from the name extraction.
>> If validate TYPE_NAME in exfat_get_dentry_set(), NameLength validation and name extraction should also
>> be implemented there.
>> (Otherwise, a duplication check with exfat_get_dentry_set() and here.) I will add NameLength
>> validation here.
> Okay.

Thank you for your understanding.

>> Therefore, TYPE_NAME validation here should not be omitted.
>>
>> Third, getting dentry and entry-type validation should be integrated.
>> These no longer have to be primitive.
>> The integration simplifies caller error checking.



>>>> diff --git a/fs/exfat/file.c b/fs/exfat/file.c index
>>>> 6707f3eb09b5..b6b458e6f5e3 100644
>>>> --- a/fs/exfat/file.c
>>>> +++ b/fs/exfat/file.c
>>>> @@ -160,8 +160,8 @@ int __exfat_truncate(struct inode *inode, loff_t new_size)
>>>>   				ES_ALL_ENTRIES);
>>>>   		if (!es)
>>>>   			return -EIO;
>>>> -		ep = exfat_get_dentry_cached(es, 0);
>>>> -		ep2 = exfat_get_dentry_cached(es, 1);
>>>> +		ep = exfat_get_validated_dentry(es, 0, TYPE_FILE);
>>>> +		ep2 = exfat_get_validated_dentry(es, 1, TYPE_STREAM);
>>> TYPE_FILE and TYPE_STREAM was already validated in exfat_get_dentry_set().
>>> Isn't it unnecessary duplication check ?
>>
>> No, as you say.
>> Although TYPE is specified, it is not good not to check the null of ep/ep2.
>> However, with TYPE_ALL, it becomes difficult to understand what purpose ep/ep2 is used for.
>> Therefore, I proposed adding ep_file/ep_stream to es, and here
>> 	ep = es->ep_file;
>> 	ep2 = es->ep_stream;
>>
>> How about this?
> You can factor out exfat_get_dentry_cached() from exfat_get_validated_dentry() and use it here.

I actually implemented and use it, but I feel it is not so good.
- Since there are two functions to get from es, so it's a bit confusing which one is better for use.
- There was the same anxiety as using exfat_get_validated_dentry() in that there is no NULL check of
   ep got with exfat_get_dentry_cached().

Whichever function I use, there are places where I check the return value and where I don't.
This will cause  missing entry-type validation or missing return value check,in the future.
I think it's easier to use by including it as a validated object in the member of exfat_entry_set_cache.

> And then, You can rename ep and ep2 to ep_file and ep_stream.

I propose a slightly different approach than last.
Add members to exfat_entry_set_cache as below.
     struct exfat_de_file *de_file;
     struct exfat_de_stream *de_stream;
And, use these as below.
     es->de_file->attr = cpu_to_le16(exfat_make_attr(inode));
     es->de_stream->valid_size = cpu_to_le64(on_disk_size);

exfat_de_file/exfat_de_stream corresponds to the file dir-entry/stream dir-enty structure in the exfat_dentry union.
We can use the validated valid values ​​directly.
Furthermore, these are strongly typed.


>> Or is it better to specify TYPE_ALL?
>>
>>
>> BTW
>> It's been about a month since I posted this patch.
>> In the meantime, I created a NameLength check and a checksum validation based on this patch.
>> Can you review those as well?
> Let me see the patches.

Thanks a lot.
For now, I will create and post a V3 patch with this proposal.
After that, I will recreate the NameLength check and a checksum validation patches based on the V3 patch and post them.
(Should I post these as an RFC?)

BR
---
Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
