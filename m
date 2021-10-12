Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5A42A7BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhJLO7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 10:59:48 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:39776 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbhJLO7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 10:59:47 -0400
Received: by mail-wr1-f42.google.com with SMTP id r18so67903685wrg.6;
        Tue, 12 Oct 2021 07:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VtXwb5BYNS5KGkt6MvcktBG7LF1gDr4C50twzOZ5210=;
        b=dKrfiLoFLSGrv+exOJ6XTc8x2FJ4nzNfs87PivVDdio8by8PwF2VA2x2wo/aCPm8P8
         PZb9sRBYEufUaUQo4ZWQjhsH7pxXvmaqZM43QZij5KBN9iuZzIoNf2qhZRii4aIuLuDE
         dIpaaPTNXsFHlEgVrN0Mac0LbUwNelAN5L2rBaOrx1yhGZgErce6UwioY065JsHoQvy0
         8a1Ro6TgLh5SnRwss3JvwxVopSq1eiA5niM/bdxig2CtPxVSqgTOZmPlMnQKFpVOiC/f
         6ZtSc2fXHFqTLkCIRYhyr8MR5FEQhwPka0GSpWAtDg4O3Q55LfRzm8QwdQFj9bYihGrk
         uk5A==
X-Gm-Message-State: AOAM532cRh4mAk8CFELdzkSjZcSESy6HnxoGm5k4E6dmrKO9EQpJLnTH
        CO3GQLTx+emohBjF4RHB1kY=
X-Google-Smtp-Source: ABdhPJxz+cYCges9NE0K4zRRi+5Im04qxitQs7NFCycHffQ+nJC3FVxsi+esTCwTWq5519XTQc7Pqw==
X-Received: by 2002:a05:600c:35d0:: with SMTP id r16mr3654310wmq.97.1634050665189;
        Tue, 12 Oct 2021 07:57:45 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w2sm5646211wrt.31.2021.10.12.07.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 07:57:44 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model v4
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
Date:   Tue, 12 Oct 2021 17:57:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <07f31547-5570-4150-7a4b-1d773fb9fa87@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>> Hi all,
>>
>> This series clean up the block polling code a bit and changes the interface
>> to poll for a specific bio instead of a request_queue and cookie pair.
>>
>> Polling for the bio itself leads to a few advantages:
>>
>>    - the cookie construction can made entirely private in blk-mq.c
>>    - the caller does not need to remember the request_queue and cookie
>>      separately and thus sidesteps their lifetime issues
>>    - keeping the device and the cookie inside the bio allows to trivially
>>      support polling BIOs remapping by stacking drivers
>>    - a lot of code to propagate the cookie back up the submission path can
>>      removed entirely
>>
>> The one major caveat is that this requires RCU freeing polled BIOs to make
>> sure the bio that contains the polling information is still alive when
>> io_uring tries to poll it through the iocb. For synchronous polling all the
>> callers have a bio reference anyway, so this is not an issue.
> 
> I ran this through the usual peak testing, and it doesn't seem to regress
> anything for me. We're still at around ~7.4M polled IOPS on a single CPU
> core:
> 
> taskset -c 0,16 t/io_uring -d128 -b512 -s32 -c32 -p1 -F1 -B1 -D1 -n2 /dev/nvme1n1 /dev/nvme2n1
> Added file /dev/nvme1n1 (submitter 0)
> Added file /dev/nvme2n1 (submitter 1)
> polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=256
> submitter=0, tid=1199
> submitter=1, tid=1200
> IOPS=7322112, BW=3575MiB/s, IOS/call=32/31, inflight=(110 71)
> IOPS=7452736, BW=3639MiB/s, IOS/call=32/31, inflight=(52 80)
> IOPS=7419904, BW=3623MiB/s, IOS/call=32/31, inflight=(78 104)
> IOPS=7392576, BW=3609MiB/s, IOS/call=32/32, inflight=(75 102)

Jens, is that with nvme_core.multipath=Y ?
