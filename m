Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D102E9BAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 18:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbhADREZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 12:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbhADREZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:04:25 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E45BC061793
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Jan 2021 09:03:45 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id q5so25909407ilc.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Jan 2021 09:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q7PboeI6oz8So+S0+W9siELlIesro+XsPSE7ag677dg=;
        b=l6AAaTX/UmVVPmJ/cw739bChCygCZUG0XsFrTuKQh/Y+RcY+HxzA+ucYZLYgkWTJuC
         8SR7yaaJDqGCVZeWPkwOcs9LBqiXjPY7dxSuC0gQaeiZdKGPl9WiM9s0K0Jcul4/GTfB
         qAKX2sSM6Sn0UygCMWT5SMJb+xDmLrIyojG9FlDswjPdmkmTRxSlsBsIT8AR3hvG/Thl
         z8vw0QfwVlizZ+Pylhz+4fgHxzWhG+QeDXwLjCEOIQcwOn8d+KyDt21r95UhtsjcH12b
         aDDNNmV/nEqrcHUbGYal6ardHSZ1+7i5886gROOiSrqHkO8u7Vgm40Luiyu4wHRExHJc
         iJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q7PboeI6oz8So+S0+W9siELlIesro+XsPSE7ag677dg=;
        b=P6NFIiIAR30PpvdgoSuba5YsxE1F8TRKxodR65XYQIZEDu+enn15u30/+v9NG6nXIG
         TkNOB4Klq74QbdjgBc/VLsh/q0b1RbPDj2bpQSimvRKdhVEHDhx0RmSlXVLa7Tlrqg75
         lD8iEKYRZ6KaUoTLXiIZ1864dsfM5eSiaCVhfX+qvJ9wY6SUP7H7UWQYqdTTduhKOo76
         1t8nVvv9d6cUBFP/6z41AT4SRvHJsjopo208nVirl64w6eCGtVoEPUi8u5AsvxeC4c0n
         ivyfXPfpysNUB8lQqKpILHJd50QshjSLYFaL4/8xxI5Nc70c3wGf8AwvHlIXDpSPA5D+
         2Fcg==
X-Gm-Message-State: AOAM531aEwAGkukBXy+GaH4qvY2GzP/INY9LMpVCT5J/M49RWFgjrU09
        CoyfGJNvzBLVX5LhMm1owVA65wP6d/tXTA==
X-Google-Smtp-Source: ABdhPJxfSLp+uHtRQkQlm/k6xPeaFzyp0c/V2CkgPgiiv30fexKDkSPf38NR09QOLN0j6egG9IIoZA==
X-Received: by 2002:a05:6e02:20c4:: with SMTP id 4mr38686189ilq.170.1609779824504;
        Mon, 04 Jan 2021 09:03:44 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f6sm42452258ioh.2.2021.01.04.09.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 09:03:43 -0800 (PST)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK /
 RESOLVE_NONBLOCK
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
References: <20201214191323.173773-1-axboe@kernel.dk>
 <20210104053112.GH3579531@ZenIV.linux.org.uk>
 <a51a2db9-716a-be20-5f71-5180394a992b@kernel.dk>
 <20210104165430.GI3579531@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <05a8597f-1a60-79e4-9e1c-d537f10a79a5@kernel.dk>
Date:   Mon, 4 Jan 2021 10:03:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104165430.GI3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/4/21 9:54 AM, Al Viro wrote:
> On Mon, Jan 04, 2021 at 07:43:17AM -0700, Jens Axboe wrote:
> 
>>> I've not put it into #for-next yet; yell if you see any problems with that
>>> branch, or it'll end up there ;-)
>>
>> Thanks Al - but you picked out of v3, not v4. Not that there are huge
>> changes between the two, from the posting of v4:
>>
>> - Rename LOOKUP_NONBLOCK -> LOOKUP_CACHED, and ditto for the RESOLVE_
>>   flag. This better explains what the feature does, making it more self
>>   explanatory in terms of both code readability and for the user visible
>>   part.
>>
>> - Remove dead LOOKUP_NONBLOCK check after we've dropped LOOKUP_RCU
>>   already, spotted by Al.
>>
>> - Add O_TMPFILE to the checks upfront, so we can drop the checking in
>>   do_tmpfile().
>>
>> and it sounds like you did the last two when merging yourself.
> 
> Yes - back when I'd posted that review.

Gotcha

>> I do like
>> LOOKUP_CACHED better than LOOKUP_NONBLOCK, mostly for the externally
>> self-documenting feature of it. What do you think?
> 
> Agreed, especially since _NONBLOCK would confuse users into assumption
> that operation is actually non-blocking...
> 
>> Here's the v4 posting, fwiw:
>>
>> https://lore.kernel.org/linux-fsdevel/20201217161911.743222-1-axboe@kernel.dk/
> 
> Sorry, picked from the local branch that sat around since Mid-December ;-/
> Fixed.  Another change: ..._child part in unlazy_child() is misleading -
> it might as well be used for .. traversal, where dentry is usually the
> _parent_ of nd->path.dentry.  The real constraint here is that dentry/seq pair
> had been valid next position at some point during the RCU walk.  Renamed to
> try_to_unlazy_next(), (hopefully) fixed the comment...
> 
> Updated variant force-pushed.

All good, looks good to me from a quick look. A diff between the two
bases just show seems sane. I'll pull it in and rebase on top of that,
and re-run the testing just to make sure that no ill effects snuck in
there with the changes.

-- 
Jens Axboe

