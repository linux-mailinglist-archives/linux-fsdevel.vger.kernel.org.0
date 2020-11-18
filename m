Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D62B8708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 22:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgKRVzK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 16:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRVzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:55:09 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB9C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 13:55:08 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id y18so3382388ilp.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 13:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r5xNiD6e9XlvHz5giFP6FQRbcfmbNgwAuTXBPufM+xg=;
        b=XwwWPCedgn3ORDfUGCAssTXoHksFYen7NSJpo5CXyDdiTN/9c5h//Kr1utnYrDqzv0
         3a8o1RbJYki+C45YC0aSE/OFzkh52bfP09N1bzeeHvsITTRY2EowJW6NJhO753q6Q6rr
         GfwKwBxLBZFhmL7xPke9JdH2sv24CkuLd9JDojz9FRJoicz975dIsdU18PsaeOicM5H5
         RBWoFULjiAHsx2wMwN8D8QuEzkSBxQOk62sEngb8CDSGtioU7CJa/p0Cssotl6qvbb14
         rsawf1x7keGoVocyvmlN5/CqZBK/fUAHNaeeWwbk2rT0gmgMoqh+AwwxWOpQ3YpffprJ
         kSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r5xNiD6e9XlvHz5giFP6FQRbcfmbNgwAuTXBPufM+xg=;
        b=QogeIMrk6/Y5IzOPRv2pQKX65fEzpGmbj/+Pju0LKrwaqrogE2/AXTaT35bKlLPxsx
         FG/viwtkOsg2k4GWtrlyaXjgFg14IdWWAgx4OnubwmMrDt37ywyGSttuFcwTnD5SV23p
         ZXoe9KwLDiiUm2dZQOzLy8llzx0DlvjnSFb80oUWnYIS5ba3GRoJupF4kT6+b+v3M9Gj
         WJjGXindmm83Q6m1YzbBdOoeWx+VZljzECoqJtDW7wV5keXwp7BB7q3PElr7iRuLoAoU
         OEHuVbeBUBFbzMrF04f1tNPUz7sBAuS70v/Qvj5O+tS/BKAbvI4Fh6yY9jCYoYFOIrLK
         5/7A==
X-Gm-Message-State: AOAM533AIhb5N628WTZmy84S7G+AXzqUTOZCXelcF/vl+kcksuCErKt3
        lbPh+tV6Ev4Ub5pgmn/cjbYxXqhjOQNbKg==
X-Google-Smtp-Source: ABdhPJyxZETLLnm+KzDiFn3gFtSnrgvK6O7SMgJ1BG9XarcMSCHgoKNCtSnfrAT0goSOfNGVoy4dEA==
X-Received: by 2002:a92:d11:: with SMTP id 17mr18882451iln.84.1605736507392;
        Wed, 18 Nov 2020 13:55:07 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 10sm15511670ill.75.2020.11.18.13.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 13:55:06 -0800 (PST)
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
 <20201118071941.GN7391@dread.disaster.area>
 <9ef0f890-f115-41f3-15fc-28f21810379f@kernel.dk>
 <20201118203723.GP7391@dread.disaster.area>
 <95d51836-9dc0-24c3-9aad-678d68613907@kernel.dk>
 <20201118211506.GQ7391@dread.disaster.area>
 <83997a78-7662-42ba-1e0d-9b543d3e3194@kernel.dk>
 <20201118213341.GR7391@dread.disaster.area>
 <83c8c94e-0d70-bd9a-d5b2-0621c1d977ac@kernel.dk>
 <20201118214805.GS7391@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b218ddea-798c-b6a1-9039-e4279e6ce490@kernel.dk>
Date:   Wed, 18 Nov 2020 14:55:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118214805.GS7391@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 2:48 PM, Dave Chinner wrote:
> On Wed, Nov 18, 2020 at 02:36:47PM -0700, Jens Axboe wrote:
>> On 11/18/20 2:33 PM, Dave Chinner wrote:
>>> On Wed, Nov 18, 2020 at 02:19:30PM -0700, Jens Axboe wrote:
>>>>>>> Can you provide an actual event trace of the IOs in question that
>>>>>>> are failing in your tests (e.g. from something like `trace-cmd
>>>>>>> record -e xfs_file\* -e xfs_i\* -e xfs_\*write -e iomap\*` over the
>>>>>>> sequential that reproduces the issue) so that there's no ambiguity
>>>>>>> over how this problem is occurring in your systems?
>>>>>>
>>>>>> Let me know if you still want this!
>>>>>
>>>>> No, it makes sense now :)
>>>>
>>>> What's the next step here? Are you working on an XFS fix for this?
>>>
>>> I'm just building the patch now for testing.
>>
>> Nice, you're fast...
> 
> Only when I understand exactly what is happening :/

That certainly helps...

> Patch below.

Thanks, ran it through the test case 20 times (would always fail before
in one run), and no issues observed.

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

