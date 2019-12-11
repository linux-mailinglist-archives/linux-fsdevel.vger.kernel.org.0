Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E073711BDA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 21:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLKUFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 15:05:03 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34310 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfLKUFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:05:03 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so20667pjs.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2019 12:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tsOWIFudRN3reWK5MlLc7h9kutRZZYV6QEDcmlofBfg=;
        b=icYVu+ipVyioTkIzX05lyZ/nDofSI9BiOFxVI5kxybYBYBXw7LjODIWhaKTkcea/nk
         Qk51hgCt/OC6xTOeiKXKK4U9IQ/v0DtnEQnmDYbZz+2e405zkiY6t2RuPdfMCtRZjVJ4
         nQN5W6GuAL8hOr1VyNiCoXkA4kzZ/61mMKXzHyzaLlnRtBA/mqR7NBGgZ59znrF9T7up
         PiQhaUBRqpyGGhCoPJY8HhGBR/cWCpUpKPOfyCGF6DqfefG+wfAbvEP4gR5I8o3lyEm1
         S4V9+2H+vQQ+wyNnqQQZInrv/XHJrEC6N930U5VAF7m846uC0vjDl/+JEuaDExPnMzuf
         +7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tsOWIFudRN3reWK5MlLc7h9kutRZZYV6QEDcmlofBfg=;
        b=HWvz3msGHm9EmhuE1EJxWU5s9J9o/3ruQ6ZQOtjr6sRPcktrIVgUmKcImIHY8KgmtS
         PcETTm/ALg95i8DCjdzukz2pCSRzIhBq6sIxf1Y6UL9chJwASiL7Mt0GFPlQBLzw5WFc
         kD0Bn0PpM/wlOKnhNo6fhySFmV3DbSi3YHz5BXjSw3RbBv857E+qM/ccxnsVfdkK+T+e
         HaD6vhtBgqaIfDf2/afoa2x5mLxNC7JAyUAvfO0egkKFFYGRZbp6p3rg7N4TvA7S9+Uo
         /q5ovkFIqax4uroesnLFNgyWFSzJ8KWUeg+mf99naVMoXpiPk6UForRrkphtKBCkrGV7
         RWaw==
X-Gm-Message-State: APjAAAXE8Y7QA+ZFO+9zryopY+donR4dChsX+rSbZCrk4b6JUGA37BWP
        Tm/ojBWr1KEvma+Noxyq1aEYrw==
X-Google-Smtp-Source: APXvYqxXBwB0bh9VK6p2nHwY5RWgvHbUK/AdjrWcmYmgtNlHRRs0vYZ+qQZa4Rq9Y8kOzoY88Z9TRg==
X-Received: by 2002:a17:90a:cc10:: with SMTP id b16mr5238863pju.55.1576094702218;
        Wed, 11 Dec 2019 12:05:02 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1014? ([2620:10d:c090:180::50da])
        by smtp.gmail.com with ESMTPSA id i127sm3971751pfc.55.2019.12.11.12.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 12:05:01 -0800 (PST)
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
Message-ID: <d3ac2d74-f943-9b4c-570c-c7f6e86a475a@kernel.dk>
Date:   Wed, 11 Dec 2019 13:04:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/11/19 12:34 PM, Jens Axboe wrote:
> On 12/11/19 10:56 AM, Jens Axboe wrote:
>>> But I think most of the regular IO call chains come through
>>> "mark_page_accessed()". So _that_ is the part you want to avoid (and
>>> maybe the workingset code). And that should be fairly straightforward,
>>> I think.
>>
>> Sure, I can give that a go and see how that behaves.
> 
> Before doing that, I ran a streamed read test instead of just random
> reads, and the behavior is roughly the same. kswapd consumes a bit less
> CPU, but it's still very active once the page cache has been filled. For
> specifics on the setup, I deliberately boot the box with 32G of RAM, and
> the dataset is 320G. My initial tests were with 1 320G file, but
> Johannes complained about that so I went to 32 10G files instead. That's
> what I'm currently using.
> 
> For the random test case, top of profile for kswapd is:
> 
> +   33.49%  kswapd0  [kernel.vmlinux]  [k] xas_create
> +    7.93%  kswapd0  [kernel.vmlinux]  [k] __isolate_lru_page
> +    7.18%  kswapd0  [kernel.vmlinux]  [k] unlock_page
> +    5.90%  kswapd0  [kernel.vmlinux]  [k] free_pcppages_bulk
> +    5.64%  kswapd0  [kernel.vmlinux]  [k] _raw_spin_lock_irqsave
> +    5.57%  kswapd0  [kernel.vmlinux]  [k] shrink_page_list
> +    3.48%  kswapd0  [kernel.vmlinux]  [k] __remove_mapping
> +    3.35%  kswapd0  [kernel.vmlinux]  [k] isolate_lru_pages
> +    3.14%  kswapd0  [kernel.vmlinux]  [k] __delete_from_page_cache

Here's the profile for the !mark_page_accessed() run, looks very much
the same:

+   32.84%  kswapd0  [kernel.vmlinux]  [k] xas_create
+    8.05%  kswapd0  [kernel.vmlinux]  [k] unlock_page
+    7.68%  kswapd0  [kernel.vmlinux]  [k] __isolate_lru_page
+    6.08%  kswapd0  [kernel.vmlinux]  [k] free_pcppages_bulk
+    5.96%  kswapd0  [kernel.vmlinux]  [k] _raw_spin_lock_irqsave
+    5.56%  kswapd0  [kernel.vmlinux]  [k] shrink_page_list
+    4.02%  kswapd0  [kernel.vmlinux]  [k] __remove_mapping
+    3.70%  kswapd0  [kernel.vmlinux]  [k] __delete_from_page_cache
+    3.55%  kswapd0  [kernel.vmlinux]  [k] isolate_lru_pages

-- 
Jens Axboe

