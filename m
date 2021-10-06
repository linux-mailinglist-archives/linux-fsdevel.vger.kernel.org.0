Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4294A424163
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhJFPeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 11:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230014AbhJFPen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633534370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvEph9NgYeijJljCcohhAoNZxQThplIO11/fqs6syHU=;
        b=Hy38fZpPTHJ6gF8LqAD5LqVjMoFf4cHFNPAByONAnZH0HZu+LQVWYUvNVyR2YtReizkFbp
        0NEm4eAVIAy8+0ejFI92iApBUwmQCbcK3yLHP671HDA16hkGaCO827piKElxzWQIJYm3m9
        unYRxcT75w/ybEfbCflm9+tkVdkmDS0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-n2VTeHtLNO64Rkf33efNXQ-1; Wed, 06 Oct 2021 11:32:49 -0400
X-MC-Unique: n2VTeHtLNO64Rkf33efNXQ-1
Received: by mail-wr1-f70.google.com with SMTP id x14-20020a5d60ce000000b00160b27b5fd1so2367589wrt.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Oct 2021 08:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cvEph9NgYeijJljCcohhAoNZxQThplIO11/fqs6syHU=;
        b=2aXt6+87PRfqT7o8HF9pWGmnznYDbtAQQa1XfXCZWFcd5EfaaG2WUcz2mRgjZQvX7I
         sYmRfbpR+IseCEgAbTH5Bn+opJlsX4ZfxspCHmu9A3c8SEek/YuIvm/cFP5OrHeNHFe/
         BdcTiywrDF2fz2/ObKt8oQSpRswCnLaFKtec+lVayUGYuDjtu5ZK6pu0aQHWDcDbN549
         9rQ/NCt7YlabHbtJ3zWZZuRP5o0V7SyMtOly1t6tUkxfb4MdCx91SAQvRGEizvLzl4m1
         sfu3L6dbozsBeKMorSy+zhQmgMrRiqZ08qO62HDA+NU7PzP/Kff3sJctgFcVpxsU/eIe
         STBg==
X-Gm-Message-State: AOAM533YBaSjfDyMtcqdQqslAcp3Hb2Ri+RzN0+KwqkvznGRPAMkHuV3
        ThfqvmSOBZFlx28sMfcuHb+LgWp+SncVL17ip+3hyq1d12xSWWwysxHCKJB4mc+3vU/qSSjuRkH
        pAKcNhbTd46wgTVP7ryULPIFwjr0xtd+HjGOgOdh3L2RNBOqemNm1XYuPMmPPoMNajd+hZ5/tJA
        ==
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr10512175wmm.137.1633534368166;
        Wed, 06 Oct 2021 08:32:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQnWEw8OnSFw6c/U83DcmKnf11Gs3w7WwRutSUaaTj+DpRwg4WZxidh4QqDP/vn7/V76Xlcw==
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr10512139wmm.137.1633534367951;
        Wed, 06 Oct 2021 08:32:47 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6529.dip0.t-ipconnect.de. [91.12.101.41])
        by smtp.gmail.com with ESMTPSA id i3sm5558725wrn.34.2021.10.06.08.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 08:32:47 -0700 (PDT)
Subject: Re: [RFC] pgflags_t
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-fsdevel@vger.kernel.org
References: <YV25hsgfJ2qAYiRJ@casper.infradead.org>
 <YV2/NZjsmSK6/vlB@zeniv-ca.linux.org.uk>
 <106400c5-d3f2-e858-186a-82f9b517917b@redhat.com>
 <YV3ArQxQ7CFzhBhR@zeniv-ca.linux.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <21ce511e-7cde-8bdb-b6c6-e1278681ebf6@redhat.com>
Date:   Wed, 6 Oct 2021 17:32:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV3ArQxQ7CFzhBhR@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06.10.21 17:28, Al Viro wrote:
> On Wed, Oct 06, 2021 at 05:23:49PM +0200, David Hildenbrand wrote:
>> On 06.10.21 17:22, Al Viro wrote:
>>> On Wed, Oct 06, 2021 at 03:58:14PM +0100, Matthew Wilcox wrote:
>>>> David expressed some unease about the lack of typesafety in patches
>>>> 1 & 2 of the page->slab conversion [1], and I'll admit to not being
>>>> particularly a fan of passing around an unsigned long.  That crystallised
>>>> in a discussion with Kent [2] about how to lock a page when you don't know
>>>> its type (solution: every memory descriptor type starts with a
>>>> pgflags_t)
>>>
>>> Why bother making it a struct?  What's wrong with __bitwise and letting
>>> sparse catch conversions?
>>>
>>
>> As I raised in my reply, we store all kinds of different things in
>> page->flags ... not sure if that could be worked around somehow.
> 
> What of that?  Inline helpers with force-casts for accessing those and
> that's it...

It feels to me like using __bitwise for access checks and then still 
modifying the __bitwise fields randomly via a backdoor. But sure, if it 
works, I'll be happy if we can use that.

-- 
Thanks,

David / dhildenb

