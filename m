Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED295119057
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfLJTKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 14:10:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42578 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727631AbfLJTKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:10:10 -0500
Received: by mail-pg1-f195.google.com with SMTP id s64so2621589pgb.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 11:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pD/GXbyxXmq207jRh2gvgJBcKwt2WDkBmn5D5BwOUR0=;
        b=0zd/CC/xy+5XfIRrov6Igs9uQ9b4fzxaPqyQ9Ci3zZlkxWWtr7ylmeYjBW7qLmuaCs
         zJIy4VJAtPuJ4IfipjILY+LnrbI1k1TCcceOP4OJBpZZg2F9Bx+q1ewRdXY2+74u4tcV
         uMHscExh1f4d+XQIly9BKEziKGSwZYZ7fYpYOxZzmarLfMXRh8noeIsiWX0seNFkg8Ge
         D1Ng+QxN60+KKeLEZMtDLPdWxyVPQ+A8+H5jwdNMVHDcUXMWswuV8EYhoFBf6syYVjLX
         ljGaKzmeRPMfTPeFELgwcMcx5k/zHAR5pmFitDgX4mzL6Jvf4F37PKzYLqRSqyTurTd5
         xEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pD/GXbyxXmq207jRh2gvgJBcKwt2WDkBmn5D5BwOUR0=;
        b=q70OY0g7REhblAgOCxLDukitL8p9/Dhst3cr8i8UHbefMR582Iil0LmpkqMpHai8t8
         /2D2cLq5BwGKnrrResEBl7DkrqWaeNsi2NgSJuBq45DVfIAqrgL0H8Q7ey9P8VILcGss
         Fuic/RlMGw1ienDh+O9GvonA0bS+CVrQHULKkmJqoteMCBRf2QeHJYoC8O74iCZajc93
         gJ5/LfaklZHjaINqq8P839Cg4ZzWxZcB+osh+SwIYNBCGzYQCqj2lquExEFSuCpqjWvK
         UB8t4RW+DE5kwC9PoMQu/8ZYsCHcs7b/LApXUMe8CrE5jrHVgPvG9W+qiLETdKZYJw3Z
         Iwfg==
X-Gm-Message-State: APjAAAUtgSxl7YmfRbA3xdeSLlZveqVLGbg6L2TWOcG3PqJkSD6CI8re
        Dp6wSLDmuhAI+9pqYkXBMHih4Q==
X-Google-Smtp-Source: APXvYqz2P0ZtN1JnDbU04k2spXWrQ5JVBscoicGfU8So+JuGIevcDGrXfvrA/ZQBmOoUFhbclAX//w==
X-Received: by 2002:a63:4287:: with SMTP id p129mr26000373pga.122.1576005009853;
        Tue, 10 Dec 2019 11:10:09 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1365? ([2620:10d:c090:180::b7af])
        by smtp.gmail.com with ESMTPSA id q7sm4357714pfb.44.2019.12.10.11.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 11:10:09 -0800 (PST)
Subject: Re: [PATCH 3/5] mm: make buffered writes work with RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20191210162454.8608-1-axboe@kernel.dk>
 <20191210162454.8608-4-axboe@kernel.dk>
 <20191210165532.GJ32169@bombadil.infradead.org>
 <721d8d7e-9e24-bded-a3c0-fa5bf433e129@kernel.dk>
 <20191210185813.GK32169@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4000e82e-399c-c0f9-4d8d-072560082605@kernel.dk>
Date:   Tue, 10 Dec 2019 12:10:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210185813.GK32169@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/19 11:58 AM, Matthew Wilcox wrote:
> On Tue, Dec 10, 2019 at 10:02:18AM -0700, Jens Axboe wrote:
>> On 12/10/19 9:55 AM, Matthew Wilcox wrote:
>>> On Tue, Dec 10, 2019 at 09:24:52AM -0700, Jens Axboe wrote:
>>>> +/*
>>>> + * Start writeback on the pages in pgs[], and then try and remove those pages
>>>> + * from the page cached. Used with RWF_UNCACHED.
>>>> + */
>>>> +void write_drop_cached_pages(struct page **pgs, struct address_space *mapping,
>>>> +			     unsigned *nr)
>>>
>>> It would seem more natural to use a pagevec instead of pgs/nr.
>>
>> I did look into that, but they are intertwined with LRU etc. I
>> deliberately avoided the LRU on the read side, as it adds noticeable
>> overhead and gains us nothing since the pages will be dropped agian.
> 
> I agree the LRU uses them, but they're used in all kinds of places where
> we need to batch pages, eg truncate, munlock.

I think I just had to convince myself that the release business works
the way it should for my use case, and I think it does. I'll test it.
release_pages() isn't exactly the prettiest thing out there.

-- 
Jens Axboe

