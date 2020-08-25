Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE3C25166B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 12:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgHYKPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 06:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgHYKPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:15:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9DBC061574;
        Tue, 25 Aug 2020 03:15:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so6972693pfn.0;
        Tue, 25 Aug 2020 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bBeFjkrLRepO5x2t9jrG71rLIeewMCntWxdGnW+ePv4=;
        b=VlfJWsaiucdUF5ERlNyTFu63QUTP06Pp6V2gndpFm+VDE0oiPrnPHH9iAS3AvQZczT
         RRc7T5l1BJQIF5wtztEKjU9aOliQZdvhM3eQ/T0EPeaOznC1pviKYZgkkYhYu/9armCt
         Q/2NPh2J+tX0e9uW5nRy8KdxDdJQTAuEvHDSZCppLJuue4dSOat7cLWxyQXIpm6EqhSw
         jtY0PurvNqqBgyU+HlclnZv/xxu7wiJyT0Bx0qMs2OK0An+34zp0P+ZqcTod5fIDTX8t
         JCJmTkzeSAoKBzP8ehbrjn9g0FJYCfErP2tK4kRtH4HyLepe0qiMqKBZ40jX1WKX1ZIM
         AVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bBeFjkrLRepO5x2t9jrG71rLIeewMCntWxdGnW+ePv4=;
        b=tu8vcXADWWHeva04eUZxvwHGe/dxyZO2uQlP6feoqKKKpjD3uPiF50leEXf0PX/MKl
         ZRMbK4JQeOW3Z21EtJ1HJfU3i3Nj9WfELvCe7GFulEoIiK2MJY89Uk15NpG4p0ocxkiz
         kw+U3Kx5nzVVxv38bitJ5KHIFRtMbOq5mh0LKlajXuhEmeHn9y2cOHgCXjedDowk4WNm
         NJdzy/MusttQ5uHbSvst/Hk/tGUaJpXKXF6royVaS2uKBuzZtlZ+rTdK8LKya5HF3rJE
         2p6r/Lhz811ZrQJ1bYfXmzanyWP1J7BwW5SI+QNwSebaPwisq51uyhoaFbtZ0LRmmp1v
         kHPg==
X-Gm-Message-State: AOAM531vKpcCyiLJANFWNIRGXdVhZkRCoJjIjKMeHaKjCJ4KgZXTX8wk
        6NkgE9+I2uY4BOaB1cSaoHapINHKEfI=
X-Google-Smtp-Source: ABdhPJzaGkj6W5K8gbg8hr32bUIemOs+O0DozWPB5rVbhCxPqk8NcGrdL8aeWY8b4rEyec1WehR9fA==
X-Received: by 2002:a65:4847:: with SMTP id i7mr6246219pgs.385.1598350546147;
        Tue, 25 Aug 2020 03:15:46 -0700 (PDT)
Received: from [192.168.1.200] (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id g23sm14082776pfo.95.2020.08.25.03.15.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 03:15:45 -0700 (PDT)
Subject: Re: [PATCH 2/2] exfat: unify name extraction
To:     Sungjong Seo <sj1557.seo@samsung.com>
Cc:     kohada.tetsuhiro@dc.mitsubishielectric.co.jp,
        mori.takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        'Namjae Jeon' <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200806055653.9329-1-kohada.t2@gmail.com>
 <CGME20200806055726epcas1p2f36810983abf14d3aa27f8a102bbbc4d@epcas1p2.samsung.com>
 <20200806055653.9329-2-kohada.t2@gmail.com>
 <000201d66da8$07a2c750$16e855f0$@samsung.com>
 <bbd9355c-cd48-b961-0a91-771a702c03df@gmail.com>
 <860b01d677a7$a62bf230$f283d690$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <dea90cbc-9f72-6476-b2a9-10014c34042b@gmail.com>
Date:   Tue, 25 Aug 2020 19:15:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <860b01d677a7$a62bf230$f283d690$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>> +			exfat_free_dentry_set(es, false);
>>>> +
>>>> +			if (!exfat_uniname_ncmp(sb,
>>>> +						p_uniname->name,
>>>> +						uni_name.name,
>>>> +						name_len)) {
>>>> +				/* set the last used position as hint */
>>>> +				hint_stat->clu = clu.dir;
>>>> +				hint_stat->eidx = dentry;
>>>
>>> eidx and clu of hint_stat should have one for the next entry we'll
>>> start looking for.
>>> Did you intentionally change the concept?
>>
>> Yes, this is intentional.
>> Essentially, the "Hint" concept is to reduce the next seek cost with
>> minimal cost.
>> There is a difference in the position of the hint, but the concept is the
>> same.
>> As you can see, the patched code strategy doesn't move from current
>> position.
>> Basically, the original code strategy is advancing only one dentry.(It's
>> the "minimum cost") However, when it reaches the cluster boundary, it gets
>> the next cluster and error handling.
> 
> I didn't get exactly what "original code" is.
> Do you mean whole code lines for exfat_find_dir_entry()?
> Or just only for handling the hint in it?

My intention is the latter.


> The strategy of original code for hint is advancing not one dentry but one dentry_set.

That's the strategy as a whole code.
But all it does to get a hint after "found" is to advance one entry.
In the original code, the 'dentry' variable points to the end of the EntrySet when "found",
so it can point to the next EntrySet by simply advancing one entry.
(However, it may need to scan the cluster chain)


> If a hint position is not moved to next like the patched code,
> caller have to start at old dentry_set that could be already loaded on dentry cache.
> 
> Let's think the case of searching through all files sequentially.
> The patched code should check twice per a file.

This is the case when all requests find the specified file, right?

Sure, the request will evaluate the same EntrySet as before found.
However, the cost to spend is different from the last time.
The current request looks for a different name than the last request.
In most cases, length and hash are different from the last EntrySet.
Therefore, the last EntrySet just skips dir-entries by num_ext.
There is no string comparison with ignores cases. <- This cost is high
The cost of skipping dir-entries is much less than the string comparison.

> No better than the original policy.

In this patch, when "found", the 'dentry' variable still points to the beginning of the EntrySet.
In this case, I thought "stay here" was a very efficient hint at a minimal cost.
As a whole, I think that the cost has been reduced...
> 
>> Getting the next cluster The error handling already exists at the end of
>> the while loop, so the code is duplicated.
>> These costs should be paid next time and are no longer the "minimum cost".
> 
> I agree with your words, "These costs should be paid next time".
> If so, how about moving the cluster handling for a hint dentry to
> the beginning of the function while keeping the original policy?

My first idea was
	hint_stat->eidx = dentry + 1 + num_ext;

However, in the current hint, offset ((hint_stat->eidx) and cluster number (hint_stat->clu) in the directory are paired.
It was difficult to change only one of values.
So I'm trying to make a 'new hint' where the offset and cluster number aren't linked.


> BTW, this patch is not related to the hint code.
> I think it would be better to keep the original code in this patch and improve it with a separate patch.

I think so, too.
I'll try another patch.


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
> 
