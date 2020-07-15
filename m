Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECEC22097E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgGOKGe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgGOKGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:06:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583AC061755;
        Wed, 15 Jul 2020 03:06:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so2853105pgh.3;
        Wed, 15 Jul 2020 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nslPGXdZu/5gZ5LlNT5PDYtuT1891xRHJ5/j3FOie1I=;
        b=lGi5aMLs/XECgYs1wjj1xEt4khF6eXDc9MZM4ewiJLheR5G3ao1sYAmrUhdh7KXPcL
         N6dQzwyW9m6us8VZmLnPPJpjkrv9ufJmvRv+Q+UCvXFuBMNUpK6iB+guhv62D02FCqK/
         kuT/aUv1WV+QLRY2CCUeMYSCqH2WMIjPQ2rtjxKl0Sh9tlIShNgdE8nabYy521Cu+MhU
         E6RItElbkHkx98ZUqFwCPlEWRf1R5yzTu0KqqPgeghlii8qfT3M6qN1v6eNWFqhIjzo7
         MZ9JoFRHHLm8NMzXcF/f5jPeK83cOF95eZys0+WOuqGqVFcSxYa5GpWuRVTpp+qV0s94
         UKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nslPGXdZu/5gZ5LlNT5PDYtuT1891xRHJ5/j3FOie1I=;
        b=XK/nXCzQa/4CIh6ic447VH7zCaB5sYGrqGKGPqO/UQ1mhWRuELHJHfPShvl4CF/r9W
         KxUjZB+VcD5DXyQQRjX8X/P2th0l0NotxKmfXer/C8K8oRxEi/Zl0d/fczCrJzY/sYhn
         v9SzCyOn2cxxKX8jEOHVCTzxlayAFP1TEAsZEQvNWNNJPdAw9psc4TtTcmiDZVRGFm/w
         pCDgTtYXGcUGA/nfCtntPOMa9KOn4FfLh2Av58ZdiPC0RlxeftF/m3cAIWFTWpleD1HL
         wj51es+Kj9RtrooNt3hE0EpNP5PTUsTYMxi0wwEYQ2s7l6bf06odOBnCH3H7RQg29ABl
         eNPg==
X-Gm-Message-State: AOAM5324UJaJQM8t86i+du1R/fc+8TrKVZIV7bqNISxoScJBGKYFwnjl
        A9Xm5IN0xy3RCjSR8PFQrXLB4vYEkWo=
X-Google-Smtp-Source: ABdhPJx4DFc/ox8E65aNHtbWuNDIZGW4YupywrWlghgOOC0Ec9nmXuyti1B4p7PC6lB/hhLKUpWmrw==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr7337634pgr.418.1594807593570;
        Wed, 15 Jul 2020 03:06:33 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:355c:1e73:d0e6:d45f? ([2404:7a87:83e0:f800:355c:1e73:d0e6:d45f])
        by smtp.gmail.com with ESMTPSA id 22sm1690145pfx.94.2020.07.15.03.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 03:06:33 -0700 (PDT)
Subject: Re: [PATCH] exfat: retain 'VolumeFlags' properly
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
Cc:     Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        Motai.Hirotaka@aj.MitsubishiElectric.co.jp,
        'Sungjong Seo' <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20200708095813epcas1p2277cdf7de6a8bb20c27bcd030eec431f@epcas1p2.samsung.com>
 <20200708095746.4179-1-kohada.t2@gmail.com>
 <005101d658d1$7202e5d0$5608b170$@samsung.com>
 <TY2PR01MB2875C88DD10CC13D0C70DE1690610@TY2PR01MB2875.jpnprd01.prod.outlook.com>
 <015801d65a4a$ebedd380$c3c97a80$@samsung.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <ad0beeab-48ba-ee6d-f4cf-de19ec35a405@gmail.com>
Date:   Wed, 15 Jul 2020 19:06:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <015801d65a4a$ebedd380$c3c97a80$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>> Also, rename ERR_MEDIUM to MED_FAILURE.
>>> I think that MEDIA_FAILURE looks better.
>>
>> I think so too.
>> If so, should I change VOL_DIRTY to VOLUME_DIRTY?
> Yes, maybe.

OK.
I'll rename both in v2.


>>>> -	p_boot->vol_flags = cpu_to_le16(new_flag);
>>>> +	p_boot->vol_flags = cpu_to_le16(new_flags);
>>> How about set or clear only dirty bit to on-disk volume flags instead
>>> of using
>>> sbi->vol_flags_noclear ?
>>>         if (set)
>>>                 p_boot->vol_flags |= cpu_to_le16(VOL_DIRTY);
>>>         else
>>>                 p_boot->vol_flags &= cpu_to_le16(~VOL_DIRTY);

Please let me know about this code.
Does this code assume that 'sbi->vol_flags'(last vol_flag value) is not used?

If you use sbi->vol_flags, I think the original idea is fine.

         sbi-> vol_flags = new_flag;
	p_boot->vol_flags = cpu_to_le16(new_flag);


>> In this way, the initial  VOL_DIRTY cannot be retained.
>> The purpose of this patch is to avoid losing the initial VOL_DIRTY and MED_FAILURE.
>> Furthermore, I'm also thinking of setting MED_FAILURE.
> I know what you do. I mean this function does not need to be called if volume dirty
> Is already set on on-disk volume flags as I said earlier.

Hmm?
Does it mean the caller check that volume was dirty at mount, and caller determine
whether to call exfat_set_vol_flags() or not?
If so, MEDIA_FAILUR needs to be set independently of the volume-dirty state.


>> However, the formula for 'new_flags' may be a bit complicated.
>> Is it better to change to the following?
>>
>> 	if (new_flags == VOL_CLEAN)
>> 		new_flags = sbi->vol_flags & ~VOL_DIRTY
>> 	else
>> 		new_flags |= sbi->vol_flags;
>>
>> 	new_flags |= sbi->vol_flags_noclear;
>>
>>
>> one more point,
>> Is there a better name than 'vol_flags_noclear'?
>> (I can't come up with a good name anymore)
> It looks complicated. It would be better to simply set/clear VOLUME DIRTY bit.

I think exfat_set_vol_flags() gets a little complicated,
because it needs the followings (with bit operation)
  a) Set/Clear VOLUME_DIRTY.
  b) Set MEDIA_FAILUR.
  c) Do not change other flags.
  d) Retain VOLUME_DIRTY/MEDIA_FAILUR as it is when mounted.

'vol_flags_noclear' is used for d).

Bit-by-bit operation makes the code redundant.
I think it's not a bad way to handle multiple bits.

What do you think?


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
