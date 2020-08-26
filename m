Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA272525A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 04:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHZC41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 22:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgHZC40 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 22:56:26 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B76FC061574;
        Tue, 25 Aug 2020 19:56:26 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n3so442356pjq.1;
        Tue, 25 Aug 2020 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hbFEodepPvZbmGlOCAW6pdL+PginykbrTuYJhMivWLU=;
        b=JRtgxN04gxU/IDzMXlbNw78semo21YBgHHcNoAJbnR8jpjdjspaNQ1Mftdhsz9QGPH
         jlSF1BkqJEhpSeIj0gismWgIY1pyC4ypjxqBmwTFct/ARCWxtawBzaXiXjMWGSDKTESn
         cm/hayB1tXowLPiC1gKmKFBJo1YOJLlnQMyLKmDHMvdV38Y1F7qfmQZiHFtCDkMfWA/R
         LBMwbalKomRo2k8WmJ5V4tFsIATzLx4qh+LxdhaPLM2eZYGDJa08RG134oy7zYAjtzSA
         obq5uhESHqOOIEF8Ddyg4Muc+sOAgPW4LQRgDEQ2LcsBc7ZOV4v74iwJi2DAzWCofocD
         PR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hbFEodepPvZbmGlOCAW6pdL+PginykbrTuYJhMivWLU=;
        b=Lh4ZMXM8cam+6GBjh/MGfbavfA+0pGzDIDmHVgkkL2FYWSygtvl4mbgsDoKZkXzq35
         RpknLIzgFOtIURHUMbuTJ5NoZebIhGXmYv+7ImkCIZop1VBzbhRIXusWtfxTiN01plUu
         EizJsjDUKHA02WKth19MbuE8PRDOxDPOOGD6g6+5FsV62oi24OrlEkvLyh8yHAEusp/C
         bMlPUK2M1dp++YF2/shRJPYTf/OG74hhtEd7Y2NCCVbeMd6fMWoc9WhR7CUBB065qpTN
         gnoF16L8ITsu79yfrqKPEscG40RVh2U8f3yfYDj7jL70YJ7Vq9Hnx02Yht3RLIFlnpuX
         mVKA==
X-Gm-Message-State: AOAM530UX62vJ2YUqdIdft9peeQVeL3bjMldj7LaI2ocOBXT5x+v2pmX
        BnghHGrDosMlx4VTqAJNV5VmKFDXGKE=
X-Google-Smtp-Source: ABdhPJxZm0kD5dvuB19oPRwFNo47AjWTDEpT6SxPsjOG3h5zKWKc4algdeVl7DB4SDtIoJIXo3fWyA==
X-Received: by 2002:a17:90a:19c8:: with SMTP id 8mr3746355pjj.152.1598410585817;
        Tue, 25 Aug 2020 19:56:25 -0700 (PDT)
Received: from [192.168.1.200] (FL1-111-169-205-196.hyg.mesh.ad.jp. [111.169.205.196])
        by smtp.gmail.com with ESMTPSA id fz19sm397834pjb.40.2020.08.25.19.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 19:56:25 -0700 (PDT)
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
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <d1df9cca-3020-9e1e-0f3d-9db6752a22b6@gmail.com>
Date:   Wed, 26 Aug 2020 11:56:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <000101d67b44$ac458c80$04d0a580$@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/08/26 10:03, Namjae Jeon wrote:
>> Second: Range validation and type validation should not be separated.
>> When I started making this patch, I intended to add only range validation.
>> However, after the caller gets the ep, the type validation follows.
>> Get ep, null check of ep (= range verification), type verification is a series of procedures.
>> There would be no reason to keep them independent anymore.
>> Range and type validation is enforced when the caller uses ep.
> You can add a validate flags as argument of exfat_get_dentry_set(), e.g. none, basic and strict.
> none : only range validation.
> basic : range + type validation.
> strict : range + type + checksum and name length, etc.

Currently, various types of verification will not be needed.
Let's add it when we need it.
>   
>>> -	/* validiate cached dentries */
>>> -	for (i = 1; i < num_entries; i++) {
>>> -		ep = exfat_get_dentry_cached(es, i);
>>> -		if (!exfat_validate_entry(exfat_get_entry_type(ep), &mode))
>>> +	ep = exfat_get_dentry_cached(es, ENTRY_STREAM);
>>> +	if (!ep || ep->type != EXFAT_STREAM)
>>> +		goto free_es;
>>> +	es->de[ENTRY_STREAM] = ep;
>>
>> The value contained in stream-ext dir-entry should not be used before validating the EntrySet checksum.
>> So I would insert EntrySet checksum validation here.
>> In that case, the checksum verification loop would be followed by the TYPE_NAME verification loop, can
>> you acceptable?
> Yes. That would be great.

OK.
I'll add TYPE_NAME verification after checksum verification, in next patch.
However, I think it is enough to validate TYPE_NAME when extracting name.
Could you please tell me why you think you need TYPE_NAME validation here?


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
> 
