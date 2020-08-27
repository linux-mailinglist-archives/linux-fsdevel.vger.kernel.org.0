Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754F12542FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgH0J75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbgH0J7z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:59:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D125C061264;
        Thu, 27 Aug 2020 02:59:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id i10so3009427pgk.1;
        Thu, 27 Aug 2020 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zSO7t8JLbei6Mkj+1bgztLVBIuuXAqF2TwGRgopH69k=;
        b=ITjVYTcbuXoM1yEcbIndSTLWrMyJSy40Raf796g4G7i8oOTnmT6K8mShjxcA5+xIFH
         /reBbClG/4iP8GJwAx538h5OzMEo5mhSeHbmmJxaA6mGOAguwYUUFfIWapqmGxxOotiX
         K3fBuYX+xZkDNN6cxuotmtAyhya4n+az1GoomW9xJHzi7eepiB6SOFm4nkajoJA0oJ4u
         XbRTtguZAHtBz6dDtLQjk/88qqviS4Ilkc0+CSjOmK/luPTtawUwUPttsoWROtOwFNv3
         lkU3u/jLljKU1HWkEV6lVM0dHvdiSKwfiiGE54dQv1mqtAESrs6bLCE2ZeR/RVlHeYQx
         h8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zSO7t8JLbei6Mkj+1bgztLVBIuuXAqF2TwGRgopH69k=;
        b=U6ZjAIZs82FkbmdUhbjrTUJG+fM2pdXIANtw35lq1C7FaD/6UZVgK/Q1L+qcWL1s4/
         VSUg/HFMi6dSx4Lz/RHNoUfQjaDLYBQ8vqvtWiriM8VCX+rucVwrGdtnRD95v3y5kXhd
         Xz62ik1iNUjNgH/Uvxi8NdxudlAOkkOnwoHr0xjOF5bD+R6AouH8yf+TXnCg3vFiDZbY
         OBBPGpvB0SqMSqcYP44GVxOA9hcUlbkrdugDqKSuC7R0IOIkJAE74xQRPU9nEGzb+oCB
         tyuB8OIv3BKxYxRSLFlzF9CIyREZnMST4l6JVNfBbbnT9VemR+Pj0FgnonqUzF9tzy12
         0NmQ==
X-Gm-Message-State: AOAM5307osZFfkn3AlAnU0wNrVZ2P+AbMuHdoFETh82CD5/w0OfZrBfh
        d8LDoL/uaQjiJvyw3VjsoN7G0Hsvy60=
X-Google-Smtp-Source: ABdhPJwYwoim+2Ik0snH5X0ro7wAGbQHuVCNT8qXinkkzVCtz5WpWZc1+oqe9KBekX7nkrXfz7DMPw==
X-Received: by 2002:a65:58c4:: with SMTP id e4mr13752654pgu.108.1598522392452;
        Thu, 27 Aug 2020 02:59:52 -0700 (PDT)
Received: from [192.168.1.200] (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id g17sm1696014pjl.37.2020.08.27.02.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 02:59:51 -0700 (PDT)
Subject: Re: [PATCH v3] exfat: integrates dir-entry getting and validation
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200806010250epcas1p482847d6d906fbf0ccd618c7d1cacd12e@epcas1p4.samsung.com>
 <20200806010229.24690-1-kohada.t2@gmail.com>
 <003c01d66edc$edbb1690$c93143b0$@samsung.com>
 <ca3b2b52-1abc-939c-aa11-8c7d12e4eb2e@gmail.com>
 <000001d67787$d3abcbb0$7b036310$@samsung.com>
 <fdaff3a3-99ba-8b9e-bdaf-9bcf9d7208e0@gmail.com>
 <000101d67b44$ac458c80$04d0a580$@samsung.com>
 <d1df9cca-3020-9e1e-0f3d-9db6752a22b6@gmail.com>
 <002e01d67b60$0b7d82a0$227887e0$@samsung.com>
 <7d7ec460-b5ab-68da-658b-2104f393b4e8@gmail.com>
 <004301d67b7a$ff0dcf50$fd296df0$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <2b4c4409-7cb8-1651-3966-569636bcc429@gmail.com>
Date:   Thu, 27 Aug 2020 18:59:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <004301d67b7a$ff0dcf50$fd296df0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>>>> -	/* validiate cached dentries */
>>>>>>> -	for (i = 1; i < num_entries; i++) {
>>>>>>> -		ep = exfat_get_dentry_cached(es, i);
>>>>>>> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
>>>>>>> +	ep = exfat_get_dentry_cached(es, ENTRY_STREAM);
>>>>>>> +	if (!ep || ep->type != EXFAT_STREAM)
>>>>>>> +		goto free_es;
>>>>>>> +	es->de[ENTRY_STREAM] = ep;
>>>>>>
>>>>>> The value contained in stream-ext dir-entry should not be used
>>>>>> before validating the EntrySet
>>>> checksum.
>>>>>> So I would insert EntrySet checksum validation here.
>>>>>> In that case, the checksum verification loop would be followed by
>>>>>> the TYPE_NAME verification loop, can you acceptable?
>>>>> Yes. That would be great.
>>>>
>>>> OK.
>>>> I'll add TYPE_NAME verification after checksum verification, in next patch.
>>>> However, I think it is enough to validate TYPE_NAME when extracting name.
>>>> Could you please tell me why you think you need TYPE_NAME validation here?
>>> I've told you on previous mail. This function should return validated
>>> dentry set after checking
>>> file->stream->name in sequence.
>>
>> Yes. I understand that the current implementation checks in that order.
>> Sorry, my question was unclear.
>> Why do you think you should leave the TYPE_NAME validation in this function?
>> What kind of problem are you worried about if this function does not validate TYPE_NAME?
>> (for preserve the current behavior?)
> We have not checked the problem when it is removed because it was implemented
> according to the specification from the beginning.

I understand that the main reason to validate TYPE_NAME here is "according to the specification".
(No one knows the actual problem)

First, we should validate as 'dir-entry set' by SecondaryCount and SetChecksum described
in "6.3 Generic Primary DirectoryEntry Template".

Next, description about validity of 'File dir-entry set' is ...
7.4 File Directory Entry:
... For a File directory entry to be valid, exactly one Stream Extension directory entry and at least
one File Name directory entry must immediately follow the File directory entry.
7.7 File Name Directory Entry:
... File Name directory entries are valid only if they immediately follow the Stream Extension
directory entry as a consecutive series.

It is possible to validate the above correctly, with either exfat_get_dentry_set() or
exfat_get_uniname_from_name_entries().
Is this wrong?

> And your v3 patch are
> already checking the name entries as TYPE_SECONDARY. And it check them with
> TYPE_NAME again in exfat_get_uniname_from_ext_entry(). 

This is according to "6.3 Generic Primary DirectoryEntry Template".
"6.3 Generic Primary DirectoryEntry Template" only required TYPE_SECONDARY.
In v3, there is no checksum validation yet.

> If you check TYPE_NAME
> with stream->name_len, We don't need to perform the loop for extracting
> filename from the name entries if stream->name_len or name entry is invalid.

Don't worry, it's a rare case.
(Do you care about the run-time costs?)

> And I request to prove why we do not need to validate name entries in this
> function calling from somewhere. 

If you need, it's okey to validate in both.
However, name-length and type validation and name-extraction should not be separated.
These are closely related, so these should be placed physically and temporally close.

Well, why it's unnecessary.
Both can be validate correctly, as I wrote before.
And, I don't really trust the verification with TYPE_NAME.
(reliability of validation as 'file dir-entry set' by checksum is much higher)

> So as I suggested earlier, You can make it
> with an argument flags so that we skip the validation.

No need skip the validation, I think.
The run-time costs for validation are pretty low.
The reason I want to remove the validation is because I want to keep the code simple.
(KISS principle)


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>

