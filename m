Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFEB2D7687
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 14:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393539AbgLKN1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 08:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404817AbgLKN04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:26:56 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273ACC0613D3;
        Fri, 11 Dec 2020 05:26:16 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 91so9017037wrj.7;
        Fri, 11 Dec 2020 05:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dGlGdBIQJplax9fn42DAuyVmL5pWywkGsDXvfG3KLYM=;
        b=sSkayAXnYvDL5BOVAOEzW/XfU4qXiPTKDnr+G7N3/dZ2AFLfvVy+uILW6jyRhhWmCo
         Avkd0d5dVz/hddDzx7+ldtpASaPypcfjN4XmtJ/diyxwqeer9G7Tu0thtu+E/d6eTGmM
         rQusjeQb2bD0n82Rgx5AbPEB70KCaW4X9mDQbsAGBVx6loN+ihdSfEYEj8SPU9AGyhma
         qyh5ocXAXysZcqszWaItrNdftdXGaeHggkR4bIQXhZz/nL9pv0paUcX3OpDpEmjChhRv
         ltGafOxrd5v1Mh0+T0LQNjRt9+ZiAjqTj7tKDHKbSM59YdBSLNNRxocOYN657DrzStJ7
         nXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dGlGdBIQJplax9fn42DAuyVmL5pWywkGsDXvfG3KLYM=;
        b=gtylxbmN6t8wuTjrqA9ZrAWzlOfvwwmrce2M55BaZqPh2HSxUn03XtckD4BEgfuQbh
         ndEJJW9Q8ETSh5MIY9fEROjVCqKMyrVGKonKpbzjMk7oGMzgdzGumFy89FNEAn/diOYr
         szK8EbOOkpnRayUbnSFrZvBRrcxzHvz4FgY/HTvfiZjGpXpURExy/WABmYctnx3pi45Q
         iMVFn/rxQpRORgpsIo0jF+7S4ylAnSNccdlq+aWSGbnfrfWxHfu5LMIkV7nZH1Np4vN9
         A4x0lt7rA8i14yz6L4xyNkWSGPdCZkCZaw92HoKbI+UlMGzR9f2YVsv1pP0G66GEExqI
         uqJw==
X-Gm-Message-State: AOAM530Gndvt6YhY5dhjWAW9Qn7m+oPlsNaShIqlN6pZzqSuYrXWr1v4
        orGpxo+96/7CpQ6GxvZDZqpXDqXeellGyg==
X-Google-Smtp-Source: ABdhPJztwkZTm9evWRa65zMqUMdmEdDOQypbUm3+crOY9P51lppv7JeQWS06uhK2lX1GMu9kARa5PA==
X-Received: by 2002:adf:ebc5:: with SMTP id v5mr13791067wrn.392.1607693174676;
        Fri, 11 Dec 2020 05:26:14 -0800 (PST)
Received: from [192.168.8.123] ([85.255.234.121])
        by smtp.gmail.com with ESMTPSA id d191sm14971217wmd.24.2020.12.11.05.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 05:26:14 -0800 (PST)
Subject: Re: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20201201120652.487077-1-ming.lei@redhat.com>
 <20201201125251.GA11935@casper.infradead.org>
 <20201201125936.GA25111@infradead.org>
 <fdbfe981-0251-9641-6ed8-db034c0f0148@gmail.com>
 <20201201133226.GA26472@infradead.org> <20201203223607.GB53708@cmpxchg.org>
 <20201204124849.GA8768@infradead.org> <20201210131826.GC264602@cmpxchg.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <d582bf1c-ee82-eb54-7978-836e8aa3ff5f@gmail.com>
Date:   Fri, 11 Dec 2020 13:22:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20201210131826.GC264602@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/2020 13:18, Johannes Weiner wrote:
> Sorry, I'm only now getting back to this.
> 
> On Fri, Dec 04, 2020 at 12:48:49PM +0000, Christoph Hellwig wrote:
>> On Thu, Dec 03, 2020 at 05:36:07PM -0500, Johannes Weiner wrote:
>>> Correct, it's only interesting for pages under LRU management - page
>>> cache and swap pages. It should not matter for direct IO.
>>>
>>> The VM uses the page flag to tell the difference between cold faults
>>> (empty cache startup e.g.), and thrashing pages which are being read
>>> back not long after they have been reclaimed. This influences reclaim
>>> behavior, but can also indicate a general lack of memory.
>>
>> I really wonder if we should move setting the flag out of bio_add_page
>> and into the writeback code, as it will do the wrong things for
>> non-writeback I/O, that is direct I/O or its in-kernel equivalents.
> 
> Good point. When somebody does direct IO reads into a user page that
> happens to have the flag set, we misattribute submission delays.
> 
> There is some background discussion from when I first submitted the
> patch, which did the annotations on the writeback/page cache side:
> 
> https://lore.kernel.org/lkml/20190722201337.19180-1-hannes@cmpxchg.org/
> 
> Fragility is a concern, as this is part of the writeback code that is
> spread out over several fs-specific implementations, and it's somewhat
> easy to get the annotation wrong.
> 
> Some possible options I can think of:
> 
> 1 open-coding the submit_bio() annotations in writeback code, like the original patch
>   pros: no bio layer involvement at all - no BIO_WORKINGSET flag
>   cons: lots of copy-paste code & comments
> 
> 2 open-coding if (PageWorkingset()) bio_set_flag(BIO_WORKINGSET) in writeback code
>   pros: slightly less complex callsite code, eliminates read check in submit_bio()
>   cons: still somewhat copy-pasty (but the surrounding code is as well)
> 
> 3 adding a bio_add_page_memstall() as per Dave in the original patch thread
>   pros: minimal churn and self-documenting (may need a better name)
>   cons: easy to incorrectly use raw bio_add_page() in writeback code
> 
> 4 writeback & direct-io versions for bio_add_page()
>   pros: hard to misuse
>   cons: awkward interface/layering
> 
> 5 flag bio itself as writeback or direct-io (BIO_BUFFERED?)
>   pros: single version of bio_add_page()
>   cons: easy to miss setting the flag, similar to 3
> 
> Personally, I'm torn between 2 and 5. What do you think?

I was thinking that easier would be inverted 3, i.e. letting add_page
with the annotation be and use a special version of it for direct IO.
IIRC we only to change bio_iov_iter_get_pages() + its helpers for that.

-- 
Pavel Begunkov
