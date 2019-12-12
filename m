Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A325611C1EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLLBLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:11:17 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39475 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfLLBLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:11:17 -0500
Received: by mail-pj1-f67.google.com with SMTP id v93so290395pjb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sGp68FxG1milZwgqvhCx5ABmHyTyp4gdvpmuwSTWMgg=;
        b=ThQkGLv0kWCvxCkrZE9KsADVrmz66ji1pqT0HfsZ/RBCDVO/obqW9Ao6VM6WfFYO+e
         QhRWx9ExsON63+CkJs1t0Z3+zSgeIS+W1ByhgR7qHL2pGjTiZz72GKJz9IaGI9ynmF16
         2SDnB3EdkuQL9iRDkUTMVE3SkoMAJLSeQvzFW3SYusmZJTyeoy5ifZGT5fobtGQzxNdr
         TGK2FlWfxd0hl/RGoNC28QrLarZFWBQOAL+Ngu3InkGf6NZprgaKTN8RBs458W2KLcPs
         p44GZuDYtVgcJelf2Hc+qZ1gAul0amLCWvYmst9bKcLjuYCEcvbHYLn+n3udxG4zA1oU
         l/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sGp68FxG1milZwgqvhCx5ABmHyTyp4gdvpmuwSTWMgg=;
        b=X0KEfI9IXpPFmtJS72dxcCCyiIYjHYs94IAlVjLG3v7r4aGOToySZWRGwx8W3BtN3Q
         kmjYqcpWdply1LIA4HnYHBAefSIHoMOGhfoP41aNiQWIsWREcXc6WhOF/MOPTgi/z2Fy
         cUGbDHp2u36iuqBJKpck3pz/eJDzzlu9BaYPkGrpsQ6ctI8JlXAduxwy5EHi0a2wiqNq
         kzmn5ld8PtcvIHp5Aw9zruUpqO0gXaNXo3b1WJUcxFGFajCY6ebTdDjTe50xdkTG+imA
         P9lUm9o01sRx7yo/xHYfzJJ8GBcHKnD9xcXyqmMkZHABvAEuuz30bf79UtkaTyfj8SBf
         f0KQ==
X-Gm-Message-State: APjAAAW0+afRQUJqQZ6bSkrq5dpfRTfvc1SiDsBvLL0uBNhUvVnI7lif
        7rXa/cuPkZS2PGhhpwm5/TXLxw==
X-Google-Smtp-Source: APXvYqyccbP8taY3xEoa/hOPmelOCM+2rRePZa3inYolV7y9/awTpbymwJZCjz2wKvfeJTt/iVVOiw==
X-Received: by 2002:a17:90a:9bc6:: with SMTP id b6mr6962092pjw.77.1576113076415;
        Wed, 11 Dec 2019 17:11:16 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id c10sm4650779pfo.135.2019.12.11.17.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:11:15 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1c93194a-ed91-c3aa-deb5-a3394805defb@kernel.dk>
Date:   Wed, 11 Dec 2019 18:11:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg=hHUFg3i0vDmKEg8HFbEKquAsoC8CJoZpP-8_A1jZDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/19 6:08 PM, Linus Torvalds wrote:
> On Wed, Dec 11, 2019 at 3:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Here's what I did to reproduce:
> 
> Gaah. I have a fairly fast ssd (but it's "consumer fast" - Samsung 970
> Pro - I'm assuming yours is a different class), but I encrypt my disk,
> so I only get about 15k iops and I see kcyrptd in my profiles, not
> kswapd.
> 
> I didn't even try to worry about RWF_UNCACHED or RWF_NOACCESS, since I
> wanted to see the problem. But I think that with my setup, I can't
> really see it just due to my IO being slow ;(
> 
> I do see xas_create and kswapd0, but it's 0.42%. I'm assuming it's the
> very first signs of this problem, but it's certainly not all that
> noticeable.

15K is likely too slow to really show an issue, I'm afraid. The 970
is no slouch, but your crypt setup will likely hamper it a lot. You
don't have a non-encrypted partition on it? I always set aside a
decently sized empty partition on my laptop to be able to run these
kinds of things without having to resort to a test box.

Latency is where it's down the most, you'll likely do better with
more threads to get the IOPS up.

-- 
Jens Axboe

