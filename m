Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10844207669
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 17:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404122AbgFXPBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404106AbgFXPBf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:01:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D86C0613ED
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so1262099pjc.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I2Wt5QedxvLGXCfHxOenkohT0DiZJGHo6D4kFEJ4uE8=;
        b=IROJTaKwsSOIpl0WW4Gu8mPbIi0eaibrEp+f3DVWW4zt3amjINeZfRPvIwLOalIy8e
         7/XPatvV30fEzPY0uKnRbynudIVhi6EssJ1mMT8B0TpQ+xVtlNJaRmhqmbE5EsBsogHQ
         GLEFs2DhZ7YwDKffHihrNoQ1dDx5eYIzFeiuTHCZj3zodndYdrl1fLKXzPBNaUzA7o91
         53gctfr2I7K6XZakW8edfoI4f2Jrfi5hIjR+g+50Do4ywZoOQSBko7nkRRaC/tKXERdn
         ep6h0uze29S8PrWVjY8q8UiafF0Ba0EyrQW9/ORpTST41Pj5CDvvpAGBdLbMdY/8gWpg
         584A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I2Wt5QedxvLGXCfHxOenkohT0DiZJGHo6D4kFEJ4uE8=;
        b=jgstybySIWJduspP9WGkZW4Z86xvTuKXYqph559SEc92khG7ElAcU2AqkrG2HXyjDS
         iJ6yshA9LEbG7r1hqkibw0Kn8xwSvTupgGcmvdRCQqqQsNL+93aIl72lKafcp518pt4Q
         b+aDCGEkv7gvCrA6m0IDuqXV6994owJ28DkX+7YQRFL7aU5SYZWm+7Hjsuv7sLS8e8St
         5fnYsTSFJ96vlL9X303cU9LoZRvBv7fUeeTZ84bMfx5/ynfd0BGueNp0hwzESJBiSXB+
         D/8EFvQWZNKUY/CEGqp5rgfW6vkT0PCa8cTDJVdryuFjOrUEaLiqQ6u1c+5fdepAs+7U
         YDdw==
X-Gm-Message-State: AOAM531H3Ddnaw3F0IWMAG9lNsoK0DVrgP0GvNZ7oW1WDpPCB964Ah9J
        wzdlgCX8gigV8rnWDLdUl51sJA==
X-Google-Smtp-Source: ABdhPJwdFv++0X60Vw2UpSgX2H9PZx08FyjXGhCZ+1Q4IXV3Ir3kUVavKO4Ae3tjd6c7WpUnLLyOGw==
X-Received: by 2002:a17:90a:d485:: with SMTP id s5mr27344721pju.61.1593010894581;
        Wed, 24 Jun 2020 08:01:34 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p30sm21012287pfq.59.2020.06.24.08.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:01:33 -0700 (PDT)
Subject: Re: [PATCH 05/15] mm: allow read-ahead with IOCB_NOWAIT set
To:     Dave Chinner <david@fromorbit.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>
References: <20200618144355.17324-1-axboe@kernel.dk>
 <20200618144355.17324-6-axboe@kernel.dk>
 <20200624043814.GC5369@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8248e187-1b4a-83c8-0ba8-afc253ed69da@kernel.dk>
Date:   Wed, 24 Jun 2020 09:01:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624043814.GC5369@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/23/20 10:38 PM, Dave Chinner wrote:
> On Thu, Jun 18, 2020 at 08:43:45AM -0600, Jens Axboe wrote:
>> The read-ahead shouldn't block, so allow it to be done even if
>> IOCB_NOWAIT is set in the kiocb.
>>
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> BTW, Jens, in case nobody had mentioned it, the Reply-To field for
> the patches in this patchset is screwed up:
> 
> | Reply-To: Add@vger.kernel.org, support@vger.kernel.org, for@vger.kernel.org,
> |         async@vger.kernel.org, buffered@vger.kernel.org,
> | 	        reads@vger.kernel.org

Yeah, I pasted the subject line into the wrong spot for git send-email,
hence the reply-to is boogered, and the subject line was empty for the
cover letter...

-- 
Jens Axboe

