Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487EC2526B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 08:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgHZGHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 02:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgHZGH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 02:07:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C05C061574;
        Tue, 25 Aug 2020 23:07:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mw10so383578pjb.2;
        Tue, 25 Aug 2020 23:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0iJwaCSx+3r+rI0OH/E9AfkKeJSKpzXpEFMS5ankSbc=;
        b=EswcXKT55DMjQALoe9Y39PlK86DdyQ8H07XSBKfU3TiU+njua9N+ssGnkHT/YoZluh
         4cGWYDa7IeGFd2hyYa011HWtxbyL9j9EvuMaTtxAYlncC+kmkGoHvMvrcLKgvnM7wAbA
         DSo/NitpuIk3RoBwm3Y8NJXcZN0bXqkFTZxUC/0ohptBT9UMADnxxhooTbVuu2KpYz8W
         e1xwl7Jkqln2p18ZZdA/aMt2XksmiguFDo40VRyaVBfdf5Oe0WVdjr4TpjYs4raB0FLc
         CG3dYr8pYuZ52cc/TdSCKN0JYSGkQPB86HtuIHvNJoRq7eIj0txgLirJUtdvLzpwe7u8
         8FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0iJwaCSx+3r+rI0OH/E9AfkKeJSKpzXpEFMS5ankSbc=;
        b=FsarhQKVZTzUIzhgDUj9sSXnb5PYO9OW4SO2G8YFMXyQdBfET2N0tlxKKGKCbYBah1
         YbDefRKoCGLyWCqsvfF+Z6+69zlK58sDu2yjAQVkuM+ylO9UHSNXRiU2Md9Na2ncszwy
         zC3bnQ2mJWEv6J7cZodG/CfvfX9Z9upSYrbMpK78wsltGuWTDDWjN+44FtLTJAnOwXwm
         HMtGZEVrbdsonp00onWj+hKc/wIg5FsZFyku0z6tyIrnxIJWdjJrcfpRJqYtrnPLEouw
         wFYVrrvg0vREFVzaJq6lM44L6wStNeN3sLBRzaP1AKYrzf3HASITHXYq3OOYZQMyR6Fq
         SyNA==
X-Gm-Message-State: AOAM532VMg6Dy5zWkN74VsUYE7S9SWP+Hgz0MJKNxSXxnR2SrvIrWH4N
        9CJQxPdwU3Ytmlx7SGFKwcUP8950M/k=
X-Google-Smtp-Source: ABdhPJyOxXdfOHpurIXqzkD7Op7IuaE0Q+ch1b/A7moZMXfisLtcNVzsttOjAJdvnUagc9CwOj24uA==
X-Received: by 2002:a17:90a:bd8f:: with SMTP id z15mr4687594pjr.58.1598422047640;
        Tue, 25 Aug 2020 23:07:27 -0700 (PDT)
Received: from [192.168.1.200] (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id t10sm1361921pfq.77.2020.08.25.23.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 23:07:27 -0700 (PDT)
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
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <7d7ec460-b5ab-68da-658b-2104f393b4e8@gmail.com>
Date:   Wed, 26 Aug 2020 15:07:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <002e01d67b60$0b7d82a0$227887e0$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for quick reply!

On 2020/08/26 13:19, Namjae Jeon wrote:
>> On 2020/08/26 10:03, Namjae Jeon wrote:
>>>> Second: Range validation and type validation should not be separated.
>>>> When I started making this patch, I intended to add only range validation.
>>>> However, after the caller gets the ep, the type validation follows.
>>>> Get ep, null check of ep (= range verification), type verification is a series of procedures.
>>>> There would be no reason to keep them independent anymore.
>>>> Range and type validation is enforced when the caller uses ep.
>>> You can add a validate flags as argument of exfat_get_dentry_set(), e.g. none, basic and strict.
>>> none : only range validation.
>>> basic : range + type validation.
>>> strict : range + type + checksum and name length, etc.
>>
>> Currently, various types of verification will not be needed.
>> Let's add it when we need it.
>>>
>>>>> -	/* validiate cached dentries */
>>>>> -	for (i = 1; i < num_entries; i++) {
>>>>> -		ep = exfat_get_dentry_cached(es, i);
>>>>> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
>>>>> +	ep = exfat_get_dentry_cached(es, ENTRY_STREAM);
>>>>> +	if (!ep || ep->type != EXFAT_STREAM)
>>>>> +		goto free_es;
>>>>> +	es->de[ENTRY_STREAM] = ep;
>>>>
>>>> The value contained in stream-ext dir-entry should not be used before validating the EntrySet
>> checksum.
>>>> So I would insert EntrySet checksum validation here.
>>>> In that case, the checksum verification loop would be followed by the
>>>> TYPE_NAME verification loop, can you acceptable?
>>> Yes. That would be great.
>>
>> OK.
>> I'll add TYPE_NAME verification after checksum verification, in next patch.
>> However, I think it is enough to validate TYPE_NAME when extracting name.
>> Could you please tell me why you think you need TYPE_NAME validation here?
> I've told you on previous mail. This function should return validated dentry set after checking
> file->stream->name in sequence.

Yes. I understand that the current implementation checks in that order.
Sorry, my question was unclear.
Why do you think you should leave the TYPE_NAME validation in this function?
What kind of problem are you worried about if this function does not validate TYPE_NAME?
(for preserve the current behavior?)

Don't worry, I will add TYPE_NAME verification to the v4 patch.
I will post it later today.

BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
