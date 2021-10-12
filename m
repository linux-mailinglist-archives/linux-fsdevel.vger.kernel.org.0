Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3141442A7F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhJLPL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 11:11:28 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:42943 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhJLPLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:11:25 -0400
Received: by mail-wr1-f53.google.com with SMTP id v17so67854449wrv.9;
        Tue, 12 Oct 2021 08:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J1LZaElNrkRTt0L3TOQg6vlE4jRHoB3hzqVL1wIyGtw=;
        b=mKgt6g/gNF+O52SAApJuDICNAXPdQPiC7akJ2lapADCV6JfnbZ7eRuvIvHIYNaa5Xa
         eZECqFXEyNu7onbdtqor8iMbjNMvTtcT7mJ2gQDWNkXaG07cTG2YXoNKuIFIEzOxjhSK
         y8NRX4OQ6jPEZ3UWzxey4185m6TQxPHkzWxsGT8ddJQKUb7x3mEuRwNX5OG98jsotKqj
         ghThyWB5V2xe7yZJqCjcGU0bz+SI2VKbOOvD8YSwMC6Nq4CkssIRoyxADIeZDRl+uv40
         3p0FXYI1vFHhb728QXSjWBKVPnNGFxYMf88JpU2jM/S+8XNb3ZE+MC7OfD+7yP90/3DK
         piAw==
X-Gm-Message-State: AOAM532Vv2cbZkNHT1NA035IdX5Q5XR0VhXKd4v0Xd/KcMk+SkVJ9JWS
        LsQ3C3UYugxU/wK/D5dtncXo/vR3k7s=
X-Google-Smtp-Source: ABdhPJzUa0NDblM2T2QL1+RHFgBKRczuoTxZUdRpZb6VVmvwDGzRabZJtooobPPXFM3WMF7ximyaQw==
X-Received: by 2002:adf:a550:: with SMTP id j16mr33357712wrb.180.1634051362822;
        Tue, 12 Oct 2021 08:09:22 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a63sm899421wmd.34.2021.10.12.08.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 08:09:22 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model v4
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
 <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
 <1f53ea37-6825-de63-0f51-5ff54fa7618e@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <054cd2ed-1996-d6dd-5842-2bf5a03fbdea@grimberg.me>
Date:   Tue, 12 Oct 2021 18:09:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1f53ea37-6825-de63-0f51-5ff54fa7618e@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/12/21 5:58 PM, Jens Axboe wrote:
> On 10/12/21 8:57 AM, Sagi Grimberg wrote:
>>
>>>> Hi all,
>>>>
>>>> This series clean up the block polling code a bit and changes the interface
>>>> to poll for a specific bio instead of a request_queue and cookie pair.
>>>>
>>>> Polling for the bio itself leads to a few advantages:
>>>>
>>>>     - the cookie construction can made entirely private in blk-mq.c
>>>>     - the caller does not need to remember the request_queue and cookie
>>>>       separately and thus sidesteps their lifetime issues
>>>>     - keeping the device and the cookie inside the bio allows to trivially
>>>>       support polling BIOs remapping by stacking drivers
>>>>     - a lot of code to propagate the cookie back up the submission path can
>>>>       removed entirely
>>>>
>>>> The one major caveat is that this requires RCU freeing polled BIOs to make
>>>> sure the bio that contains the polling information is still alive when
>>>> io_uring tries to poll it through the iocb. For synchronous polling all the
>>>> callers have a bio reference anyway, so this is not an issue.
>>>
>>> I ran this through the usual peak testing, and it doesn't seem to regress
>>> anything for me. We're still at around ~7.4M polled IOPS on a single CPU
>>> core:
>>>
>>> taskset -c 0,16 t/io_uring -d128 -b512 -s32 -c32 -p1 -F1 -B1 -D1 -n2 /dev/nvme1n1 /dev/nvme2n1
>>> Added file /dev/nvme1n1 (submitter 0)
>>> Added file /dev/nvme2n1 (submitter 1)
>>> polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
>>> Engine=io_uring, sq_ring=128, cq_ring=256
>>> submitter=0, tid=1199
>>> submitter=1, tid=1200
>>> IOPS=7322112, BW=3575MiB/s, IOS/call=32/31, inflight=(110 71)
>>> IOPS=7452736, BW=3639MiB/s, IOS/call=32/31, inflight=(52 80)
>>> IOPS=7419904, BW=3623MiB/s, IOS/call=32/31, inflight=(78 104)
>>> IOPS=7392576, BW=3609MiB/s, IOS/call=32/32, inflight=(75 102)
>>
>> Jens, is that with nvme_core.multipath=Y ?
> 
> No, I don't have multipath enabled. I can run that too, if you'd like.

That would be useful to learn. thanks.
