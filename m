Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF6711C26C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 02:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfLLBls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 20:41:48 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40542 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLLBls (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:41:48 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so229199pfh.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 17:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QxnRj1KTspHy7p7jjV7BEiC8kTXAQbaB4Nasa0uBmKs=;
        b=hrnF4TXgpHDXedLBaY8w522NQV3GgLZp7239lwIiy9APNQKtr7vpyOoUxgMf4c4pPn
         zgSquxRTfw5cwSdsjtl6c6fDxnYOqeV4fmJ2Gldio+OHoocZY7Z/6hI0wy5a4O1jgRgO
         iF1mSK0vpjSK1cI9IOA9ZpTOkJuyLyobGk/k1zVU/7TDgIyO9KQeAfMdBp+LcnoXK0X+
         J/9TA64kcKSg8Jsvji+Y/wugIAHOqXrh4bk5/Rbcu5uexhTu3drPECCqLYk1+JtsYpgl
         NbPkRosZagw/jIkQr2JhkyH//XXiiGFB1d6UleMnNPhFgQ8z2rynbwm2S6DXqiySojOu
         QI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QxnRj1KTspHy7p7jjV7BEiC8kTXAQbaB4Nasa0uBmKs=;
        b=nAXzMY3ARlOSQj6M7+kmWC4PGjXGg5e0dlAvA5qHFvwZeF+VAKreRLtkiNioTpUYBO
         gkJAPePPw8Z4VX/FPWLq4psBSqEfPH7GQE4jYQfhj2mzHrII8htkBeo1pulX99HbttW/
         okK7/w0tVISzBxDftfsjeIFJ1tCcW2XqgDhr5O2qbDO5SZi98D6WvH+Pb+wNxIwhqVh5
         +zlhhzsZ0Y2C4eUMVQIWsm9EW07NDAYavck0xbjUiZ+O0Z4RseAKIkklSqT974ERSIv8
         vIAYsYOs8szqY5TYKqkX4+0wJTZeBN08DFPUmRVxLhYpQz8dhyPBSAmABj2F87Fugomz
         L4Rg==
X-Gm-Message-State: APjAAAXUbqDAEUbz/slWrr1MsDJK3uUr1zotSjR+5vmL1hJuSMr3qu66
        agi3sy4yUB8a5AjBnuHdGobmDAd98J5aMA==
X-Google-Smtp-Source: APXvYqwUun2qLSYWDkJmEhhOuR/RBu3Dvqm+DjkY/o2GxGB0RxGae2HfaWEfH2qhUPN7GXt7FDDbyA==
X-Received: by 2002:a65:4203:: with SMTP id c3mr7635957pgq.368.1576114907080;
        Wed, 11 Dec 2019 17:41:47 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id v4sm3619850pjb.24.2019.12.11.17.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 17:41:46 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
From:   Jens Axboe <axboe@kernel.dk>
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
 <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
Message-ID: <6e2ca035-0e06-1def-5ea9-90a7466b2d49@kernel.dk>
Date:   Wed, 11 Dec 2019 18:41:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d8a8ea42-7f76-926c-ae9a-d49b11578153@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/19 6:29 PM, Jens Axboe wrote:
> On 12/11/19 6:22 PM, Linus Torvalds wrote:
>> On Wed, Dec 11, 2019 at 5:11 PM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> 15K is likely too slow to really show an issue, I'm afraid. The 970
>>> is no slouch, but your crypt setup will likely hamper it a lot. You
>>> don't have a non-encrypted partition on it?
>>
>> No. I normally don't need all that much disk, so I've never upgraded
>> my ssd from the 512G size.
>>
>> Which means that it's actually half full or so, and I never felt like
>> "I should keep an unencrypted partition for IO testing", since I don't
>> generally _do_ any IO testing.
>>
>> I can get my load up with "numjobs=8" and get my iops up to the 100k
>> range, though.
>>
>> But kswapd doesn't much seem to care, the CPU percentage actually does
>> _down_ to 0.39% when I try that. Probably simply because now my CPU's
>> are busy, so they are running at 4.7Ghz instead of the 800Mhz "mostly
>> idle" state ...
>>
>> I guess I should be happy. It does mean that the situation you see
>> isn't exactly the normal case. I understand why you want to do the
>> non-cached case, but the case I think it the worrisome one is the
>> regular buffered one, so that's what I'm testing (not even trying the
>> noaccess patches).
>>
>> So from your report I went "uhhuh, that sounds like a bug". And it
>> appears that it largely isn't - you're seeing it because of pushing
>> the IO subsystem by another order of magnitude (and then I agree that
>> "under those kinds of IO loads, caching just won't help")
> 
> I'd very much argue that it IS a bug, maybe just doesn't show on your
> system. My test box is a pretty standard 2 socket system, 24 cores / 48
> threads, 2 nodes. The last numbers I sent were 100K IOPS, so nothing
> crazy, and granted that's only 10% kswapd cpu time, but that still seems
> very high for those kinds of rates. I'm surprised you see essentially no
> kswapd time for the same data rate.
> 
> We'll keep poking here, I know Johannes is spending some time looking
> into the reclaim side.

Out of curiosity, just tried it on my laptop, which also has some
samsung drive. Using 8 jobs, I get around 100K IOPS too, and this
is my top listing:

23308 axboe     20   0  623156   1304      8 D  10.3  0.0   0:03.81 fio
23309 axboe     20   0  623160   1304      8 D  10.3  0.0   0:03.81 fio
23311 axboe     20   0  623168   1304      8 D  10.3  0.0   0:03.82 fio
23313 axboe     20   0  623176   1304      8 D  10.3  0.0   0:03.82 fio
23314 axboe     20   0  623180   1304      8 D  10.3  0.0   0:03.81 fio
  162 root      20   0       0      0      0 S   9.9  0.0   0:12.97 kswapd0
23307 axboe     20   0  623152   1304      8 D   9.9  0.0   0:03.84 fio
23310 axboe     20   0  623164   1304      8 D   9.9  0.0   0:03.81 fio
23312 axboe     20   0  623172   1304      8 D   9.9  0.0   0:03.80 fio

kswapd is between 9-11% the whole time, and the profile looks very
similar to what I saw on my test box:

    35.79%  kswapd0  [kernel.vmlinux]  [k] xas_create
     9.97%  kswapd0  [kernel.vmlinux]  [k] free_pcppages_bulk
     9.94%  kswapd0  [kernel.vmlinux]  [k] isolate_lru_pages
     7.78%  kswapd0  [kernel.vmlinux]  [k] shrink_page_list
     3.78%  kswapd0  [kernel.vmlinux]  [k] xas_clear_mark
     3.08%  kswapd0  [kernel.vmlinux]  [k] workingset_eviction
     2.48%  kswapd0  [kernel.vmlinux]  [k] __isolate_lru_page
     2.06%  kswapd0  [kernel.vmlinux]  [k] page_mapping
     1.95%  kswapd0  [kernel.vmlinux]  [k] __remove_mapping

So now I'm even more puzzled why your (desktop?) doesn't show it, it
must be more potent than my x1 laptop. But for me, the laptop and 2
socket test box show EXACTLY the same behavior, laptop is just too slow
to make it really pathological.

-- 
Jens Axboe

