Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A7B3D49A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGXTFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 15:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhGXTFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:05:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520A5C061757
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 12:46:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j8-20020a17090aeb08b0290173bac8b9c9so13931976pjz.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 12:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SaRVMIPsR4RUT0xlMnKQjQMMszZ0iueZl2tGoIzLrJM=;
        b=FNnF3e0uYRIU4gSyLJfdlw7+kMTm7aNiVoiIg+bnba8zFWIMy4Ef+tApv3CbTY3wNR
         MwIU3QiAYVwVvQIFmhzx6sFDrftBF4y+DQJY5LnBmS4Vi8BnahJAOZflcSEIA5DhU6U5
         7g30HUKxH+mbzdacHLcZ4DPAIWVHE63QKozAl5UVvFyK2nSb1OJUItHZfyI/wYV/J4D9
         9M/JQ95+XQaOxD8z7ZB0WdayvPyhY5nqYCD04/+izy7b6eXRin8McVhmHLh5mEHA9OHQ
         pOfC+HDW3GfQLG6u4ZJrORNQy9St2KJmjK85mkhiNm1EafXSgNeSCrwcQnbxILNp0cmj
         jyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SaRVMIPsR4RUT0xlMnKQjQMMszZ0iueZl2tGoIzLrJM=;
        b=k5SnDpw8Bf+zVRv4NYY5venLUhmSWNgG28KjcNmgJiCniPLKcOajYsWaE0ln/f4X94
         o39xD+RvlHHaeR4f7jCsizSd5FMjwKqlfu+MjrnX0T0iEkQ5xAnFS3z5SbOiPJt3ps+8
         8en8UL9gdJ60SR8DVEP6ZSKCAo/vC9J8n8/lRmsYenQOXT3U1mXYyuvjcpGh8DGBAIFX
         OnFmKus8Bly9Wg5lPZ6K1IcR3bvI2IH9vXuKxT8krUD284A3HoV3yA10tJVL+XEnniCj
         1ynmT8tQ7pTRwdO6T5bYi9X3MiTYzGNnB9d0KG6Vtkh/u+pUk+Dj6gAtg2kve10x3j/z
         6Jxw==
X-Gm-Message-State: AOAM530W8+iM5Vqv6XpjrgcKX1lVElacEs9i6xwE74ePu1qzdCokMpCm
        UhAMxt4XtQ1gul/pnX5aqVoV8A==
X-Google-Smtp-Source: ABdhPJylawTGN3h+Z+h36hC8P3jWa6Xs90tk7UGNIstd8gOZaOSwuboq4WYd8TNMxYvPmRp5FY83pg==
X-Received: by 2002:aa7:8751:0:b029:32b:560a:b17f with SMTP id g17-20020aa787510000b029032b560ab17fmr10492603pfo.32.1627155965856;
        Sat, 24 Jul 2021 12:46:05 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id y7sm35336773pfi.204.2021.07.24.12.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 12:46:05 -0700 (PDT)
Subject: Re: [PATCH 0/2] Close a hole where IOCB_NOWAIT reads could sleep
To:     Matthew Wilcox <willy@infradead.org>
Cc:     io-uring@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org
References: <20210711150927.3898403-1-willy@infradead.org>
 <a3d0f8da-ffb4-25a3-07a1-79987ce788c5@kernel.dk>
 <YPxaXE0mf26aqy/O@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5b0e9558-0bb0-c2b0-2125-b8d33a1c3360@kernel.dk>
Date:   Sat, 24 Jul 2021 13:46:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YPxaXE0mf26aqy/O@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/24/21 12:22 PM, Matthew Wilcox wrote:
> On Sun, Jul 11, 2021 at 07:44:07PM -0600, Jens Axboe wrote:
>> On 7/11/21 9:09 AM, Matthew Wilcox (Oracle) wrote:
>>> I noticed a theoretical case where an IOCB_NOWAIT read could sleep:
>>>
>>> filemap_get_pages
>>>   filemap_get_read_batch
>>>   page_cache_sync_readahead
>>>     page_cache_sync_ra
>>>       ondemand_readahead
>>>         do_page_cache_ra
>>>         page_cache_ra_unbounded
>>>           gfp_t gfp_mask = readahead_gfp_mask(mapping);
>>>           memalloc_nofs_save()
>>>           __page_cache_alloc(gfp_mask);
>>>
>>> We're in a nofs context, so we're not going to start new IO, but we might
>>> wait for writeback to complete.  We generally don't want to sleep for IO,
>>> particularly not for IO that isn't related to us.
>>>
>>> Jens, can you run this through your test rig and see if it makes any
>>> practical difference?
>>
>> You bet, I'll see if I can trigger this condition and verify we're no
>> longer blocking on writeback. Thanks for hacking this up.
> 
> Did you have any success yet?

Sorry forgot to report back - I did run some testing last week, and
didn't manage to make it hit the blocking condition. Did various
read/write mix on the same file, made sure there was memory pressure,
etc. I'll give it another go, please let me know if you have an idea on
how to make this easier to hit... I know it's one of those things that
you hit all the time in certain workloads (hence why I would love to see
it get fixed), but I just didn't manage to provoke it when I tried.

-- 
Jens Axboe

