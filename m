Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2D11C225
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfLLB3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:29:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38987 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfLLB3v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:29:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so260958pga.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DhyX9yKmk3Bjq16+cH6CFIH0oBue170bHYeXiMOQ8dA=;
        b=tBcfwgxJPBhRRcAGhCQgQbyfTfpQsyiGY9DGe/XHH2/qbpQARxKq7yWjGdvqo1IllS
         dEWH4g1714qg29h4GEZigEfbqrKvxMzRE9LNVpEFK2NyrdjbNtkxs6UWbtUszECnOQ0D
         VEoKTKtnfhk/vEZGeDpWMdwNOGh8La+bbktv7kvota82pgoXLzk3sL28vntZlDhqgkLX
         +EyfDp8OYP1xKcWrZTib+Ng+VSUqbKeEhhTBmOwpw+Ojk7X5nKqyrRMXwloZOmKkzPiZ
         +9yGgbU006bu6ndm0cPeWABAqJMpqOiOI+vxaISk+h/Wium9aaoWX5gz51q7TBIt5Pl3
         er3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DhyX9yKmk3Bjq16+cH6CFIH0oBue170bHYeXiMOQ8dA=;
        b=J4IMAnGBfAiTrtQ96Nqb/TQ3eqEzHt536PMngLsY7yg4WLi5gsyHy8bFe1y+5zABnG
         +/N6IlIIHSo5jHkjCMePsz2cPR1CZhI8o+WvqZYtNMTOMh8Epo7/41ym448S5O40Abif
         2HiLy2HNR11ewwQp00KBF0mzSVMev/9sDoRSYpQ8i0F2N1pUUeKAj/Xk/rcLJJdHi1nP
         /81CMn919Q9qUFSzF+FjmPqgOt+LV1Zf6OFlV83cEeECgDHjv1+0Bd67wMV+E7zCo0mV
         GjjcfKmveK3yL45xb3g2YNlcg5XD3uyQq8bxhMUS92PLZJRYMGXLj5ngjyVAzhGG9SS2
         TaEg==
X-Gm-Message-State: APjAAAXSnUDqWEpQSsIN9JWfxNhi+aj9KONfePCI16CBFnYcs5Edxaof
        BsxKGuT9QykFfOaVjPP08HszYQ==
X-Google-Smtp-Source: APXvYqwIZT80qb6KK6M7DWfi9Y0s3aK7ho5OWU9hmanRrqTeBJgLbXHTk13enGqUZ5WC+TJcO9HU0Q==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr7322984pgh.197.1576114191223;
        Wed, 11 Dec 2019 17:29:51 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id z14sm2580858pfg.57.2019.12.11.17.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:29:50 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
 <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk>
 <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
Date:   Wed, 11 Dec 2019 18:29:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj0pXsngjWKw5p3oTvwkNnT2DyoZWqPB+-wBY+BGTQ96w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/19 6:22 PM, Linus Torvalds wrote:
> On Wed, Dec 11, 2019 at 5:11 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> 15K is likely too slow to really show an issue, I'm afraid. The 970
>> is no slouch, but your crypt setup will likely hamper it a lot. You
>> don't have a non-encrypted partition on it?
> 
> No. I normally don't need all that much disk, so I've never upgraded
> my ssd from the 512G size.
> 
> Which means that it's actually half full or so, and I never felt like
> "I should keep an unencrypted partition for IO testing", since I don't
> generally _do_ any IO testing.
> 
> I can get my load up with "numjobs=8" and get my iops up to the 100k
> range, though.
> 
> But kswapd doesn't much seem to care, the CPU percentage actually does
> _down_ to 0.39% when I try that. Probably simply because now my CPU's
> are busy, so they are running at 4.7Ghz instead of the 800Mhz "mostly
> idle" state ...
> 
> I guess I should be happy. It does mean that the situation you see
> isn't exactly the normal case. I understand why you want to do the
> non-cached case, but the case I think it the worrisome one is the
> regular buffered one, so that's what I'm testing (not even trying the
> noaccess patches).
> 
> So from your report I went "uhhuh, that sounds like a bug". And it
> appears that it largely isn't - you're seeing it because of pushing
> the IO subsystem by another order of magnitude (and then I agree that
> "under those kinds of IO loads, caching just won't help")

I'd very much argue that it IS a bug, maybe just doesn't show on your
system. My test box is a pretty standard 2 socket system, 24 cores / 48
threads, 2 nodes. The last numbers I sent were 100K IOPS, so nothing
crazy, and granted that's only 10% kswapd cpu time, but that still seems
very high for those kinds of rates. I'm surprised you see essentially no
kswapd time for the same data rate.

We'll keep poking here, I know Johannes is spending some time looking
into the reclaim side.

-- 
Jens Axboe

