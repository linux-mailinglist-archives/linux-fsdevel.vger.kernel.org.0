Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B755A42A7C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbhJLPAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 11:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237062AbhJLPAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:00:50 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E510C061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 07:58:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id r134so12837657iod.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Oct 2021 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqA23ObcMjBgZVvCWLFVqQeiCNLoGDBftx5XWNNYGp8=;
        b=1Ysqi5Tuua6c+DOLSCokMMRS0S3ouQULZDGn4I6OUS6O8h961XDJX5twQE8MEv3sYV
         yLKA+6+hnbhAFFd4liTVO0RAFAkhGdM/S74YHZB8IDjSJy7RI7fhnHIXklQCCs8tle6N
         4CC3iMtQeDwfxmML9nUnM23Mfe7YcrnJ1unghGz8N4xotNALRNSq4IKGWQxEJHDs6as0
         +/OD/rLxQ3TOY/Hj8Y5TUiXurkChyAiiljPthkqsePedmYW0D8a3EOhBhu/zsdhi2vQK
         c4L7JJLs0hXqLKYLbj3GRqS19j9cqxaDQp6KDApM/GdqunKznW5jYFku3mRxppSz02G0
         T3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqA23ObcMjBgZVvCWLFVqQeiCNLoGDBftx5XWNNYGp8=;
        b=Q+pc16/U6Z695EdWcy9FqVVuVTNmraUahoFsHpTeYET4nzm1nJtR1tzK4B2iU3A+A2
         /X0h3bz5OhL12oU+ugy7F0BQYWJwEjVDiPR6KiqbWm2Q6cQ4e3lBswvXzxRTWtWKaqOr
         OXgcXTHSbQPQF7jXxv6gz2gcudiHSlkvWL++W4MS4cuRElls0fwEnBp8vJfUFp00/sBv
         2ZA8BozGXoJnZjPvMznZkusw/90Kr9P7/8FRwMX0gjmOfvHIWYczzSJGTu+CG6aB/XQ1
         XAURPm/fqTme89KkuzJSBQbsvodRB+4tBRnIUM3qwW4IZg25Cc2cDnbIp20qRawUVSFv
         5uBA==
X-Gm-Message-State: AOAM531V+KQES2cW8xHOVRtNFfBxpiBz4qaPVe23T3qviAsKyMU95O1u
        Ntg5K5Cc8STZr+aG1jqxS4YwgA==
X-Google-Smtp-Source: ABdhPJyv1Javrn/St42VuUvMZqKad4SdoRQwzO4D5Q9r1lS2yVB+cCZF7l5V9bE9h582nw9V5kHLyg==
X-Received: by 2002:a6b:8e52:: with SMTP id q79mr21218840iod.64.1634050727820;
        Tue, 12 Oct 2021 07:58:47 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c9sm5649857ilo.18.2021.10.12.07.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 07:58:47 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model v4
To:     Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
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
 <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f53ea37-6825-de63-0f51-5ff54fa7618e@kernel.dk>
Date:   Tue, 12 Oct 2021 08:58:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <040104f6-720d-35ed-7e15-a704e6488fd4@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/21 8:57 AM, Sagi Grimberg wrote:
> 
>>> Hi all,
>>>
>>> This series clean up the block polling code a bit and changes the interface
>>> to poll for a specific bio instead of a request_queue and cookie pair.
>>>
>>> Polling for the bio itself leads to a few advantages:
>>>
>>>    - the cookie construction can made entirely private in blk-mq.c
>>>    - the caller does not need to remember the request_queue and cookie
>>>      separately and thus sidesteps their lifetime issues
>>>    - keeping the device and the cookie inside the bio allows to trivially
>>>      support polling BIOs remapping by stacking drivers
>>>    - a lot of code to propagate the cookie back up the submission path can
>>>      removed entirely
>>>
>>> The one major caveat is that this requires RCU freeing polled BIOs to make
>>> sure the bio that contains the polling information is still alive when
>>> io_uring tries to poll it through the iocb. For synchronous polling all the
>>> callers have a bio reference anyway, so this is not an issue.
>>
>> I ran this through the usual peak testing, and it doesn't seem to regress
>> anything for me. We're still at around ~7.4M polled IOPS on a single CPU
>> core:
>>
>> taskset -c 0,16 t/io_uring -d128 -b512 -s32 -c32 -p1 -F1 -B1 -D1 -n2 /dev/nvme1n1 /dev/nvme2n1
>> Added file /dev/nvme1n1 (submitter 0)
>> Added file /dev/nvme2n1 (submitter 1)
>> polled=1, fixedbufs=1, register_files=1, buffered=0, QD=128
>> Engine=io_uring, sq_ring=128, cq_ring=256
>> submitter=0, tid=1199
>> submitter=1, tid=1200
>> IOPS=7322112, BW=3575MiB/s, IOS/call=32/31, inflight=(110 71)
>> IOPS=7452736, BW=3639MiB/s, IOS/call=32/31, inflight=(52 80)
>> IOPS=7419904, BW=3623MiB/s, IOS/call=32/31, inflight=(78 104)
>> IOPS=7392576, BW=3609MiB/s, IOS/call=32/32, inflight=(75 102)
> 
> Jens, is that with nvme_core.multipath=Y ?

No, I don't have multipath enabled. I can run that too, if you'd like.

-- 
Jens Axboe

