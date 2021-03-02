Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCA532A516
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Mar 2021 16:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443355AbhCBLrK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Mar 2021 06:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835953AbhCBG3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:29:35 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF1C061756;
        Mon,  1 Mar 2021 22:28:54 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t26so13226932pgv.3;
        Mon, 01 Mar 2021 22:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VHO3Ym0bd2N18fPBpPrG0GZ2ZXvGcT6nRPeNnyeO6oo=;
        b=N3gDVAqd248w5d3/KwTS1gb4+StXOLBgm8tPS51uDHw8VdyLdJ05j8tBuw8MvtEock
         DLCUA6F0BqFfs1J2zqAIKNe3vCAONsj6rkRmt9l4q1a8v3KB1b2gyICWW8gKHkH0PIIF
         QEN0/ERFKjd4mS1eefkAaKoHAPYWIHh+NomT9MqsK0mL47WDGYWdgtPnzlT9SiZ2nKHM
         QALTTLFo8V6cUuIK9vzZH1kG8I1mhJ+/jS5ngJ0hUgp5AoYh+3+FLPAoJK3IrTNqqSbB
         pCaKUmRvrhdYwDHjORYQFheNmgGKXrJedVKLuVUEsvJl2R9e8tIuuYdahDnxkNoqbQO9
         s0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VHO3Ym0bd2N18fPBpPrG0GZ2ZXvGcT6nRPeNnyeO6oo=;
        b=l4EZ7Moc3Xj4jtf/Ni0bIXa04VZtO0DqjCSxE1ZCTb0nbcB+p+/D+ZrF4BGaexiuS0
         7liZBH33NG4aY/edx7e5uUvZdPLgzZBvi4sG7CMf6Vwixiwu0sJWp5xn8wKNQ7cU8ZzO
         ltHkXCeE8I75tYBfpDvCFrjagpUHhFv6q93A7YEYUN2irbZNaGOzT+v64JALNrQP9VLt
         N0kptPpAgnn07zxFVR2n9Uh6S8iqeD4u8E/hpRHrsp04TdRiHCwvQSVtbLvIkCL8URgI
         XZPqkioxRk3P12x6M/i/AOqzyw6h5/zA2f0IkAbtjaBMpMCzFQJKRFeKmkQ6DkMlzXbY
         Os9Q==
X-Gm-Message-State: AOAM5318Y2MZTINh/p7fkponv7jfQpzlQjp+KFNUppcY3nyf44wdXzjv
        XdyNv+T3gpGRTeFnXAJOQxdEnp6vSbJPyg==
X-Google-Smtp-Source: ABdhPJzlYVbXzjLODp3kDUUfkd0EnAd1fab1sDimqO5Z45HyKkQAHHfqeGqkvxVnZHmw1QTipXhq3g==
X-Received: by 2002:a65:50c8:: with SMTP id s8mr17010241pgp.68.1614666534031;
        Mon, 01 Mar 2021 22:28:54 -0800 (PST)
Received: from [192.168.0.12] ([125.186.151.199])
        by smtp.googlemail.com with ESMTPSA id s27sm17869278pgk.77.2021.03.01.22.28.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 22:28:53 -0800 (PST)
Subject: Re: [PATCH] exfat: fix erroneous discard when clear cluster bit
To:     Sungjong Seo <sj1557.seo@samsung.com>, namjae.jeon@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20210225093351epcas1p40377b00fb3532e734e4a7a1233ee72e1@epcas1p4.samsung.com>
 <20210225093333.144829-1-hyeongseok@gmail.com>
 <000001d70f0d$8e882ec0$ab988c40$@samsung.com>
From:   Hyeongseok Kim <hyeongseok@gmail.com>
Message-ID: <206deada-bb28-e19a-d79a-1075501bbfe3@gmail.com>
Date:   Tue, 2 Mar 2021 15:28:49 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <000001d70f0d$8e882ec0$ab988c40$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: ko-KR
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/2/21 11:41 AM, Sungjong Seo wrote:
>> Subject: [PATCH] exfat: fix erroneous discard when clear cluster bit
>>
>> If mounted with discard option, exFAT issues discard command when clear
>> cluster bit to remove file. But the input parameter of cluster-to-sector
>> calculation is abnormally adds reserved cluster size which is 2, leading
>> to discard unrelated sectors included in target+2 cluster.
>>
>> Fixes: 1e49a94cf707 ("exfat: add bitmap operations")
>> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>
>> ---
>>   fs/exfat/balloc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> Looks good.
>
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
>
> Thanks for your work!
> Could you remove the wrong comments above set/clear/find bitmap functions
> together?
>
Done, in V2.
Thanks for the review.

