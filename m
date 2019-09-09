Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19108AE16E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2019 01:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389222AbfIIXP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 19:15:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40701 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730900AbfIIXP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 19:15:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id y39so15201887ota.7;
        Mon, 09 Sep 2019 16:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=76+B0F+y6GF7x1pmO705M0ab149/3jefLlEAKzhXfdY=;
        b=ny6T50Z+UdF6y8uSXXKKUc9fU1AC13p4lMW3Oy0elxaJ/rTHUfx1IkPZMvCf3vg/9G
         /itfv5b9Z+e3KGNXqt4LG7SPUDI2PGGQwVhPSZGyaNEYGRXL3Ie3E5UkQbvirmunXOhR
         qJ6LG2NxKaWvhA6ScbFbbbN7eRDoiq6nGBoIPdNpQu82c/ir5eT82opkojuAR2n7PX3T
         mkLVSLjuL2w2AyXsfEjqUKY1awwvKlWBpY21t3kVGTebIoI1WLydiW9ATMs5WLWleZip
         hbWBtwvVdl8SRhGaFdqvZ5AOnRNfd2iOHFJ7PRQ2upZs1/W4G+fnjBl9jWxpKZ5ZixQo
         Vbpg==
X-Gm-Message-State: APjAAAUjEfbgF4PNmae4/DaNcSNRoZZQOkT8QUzdKzYIdoUcBVxc3dCJ
        HKmO0C6YT5LUfO7Sk0q4Hoo=
X-Google-Smtp-Source: APXvYqw8MteVMDy0Cl8ZOyqZEdlruprk+5eF7K1KC+eC19R7iANjgOvPKaYiMx6uYRtoPSCqFx1Cbw==
X-Received: by 2002:a9d:4815:: with SMTP id c21mr18066036otf.26.1568070928432;
        Mon, 09 Sep 2019 16:15:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l30sm6462344otl.74.2019.09.09.16.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 16:15:27 -0700 (PDT)
Subject: Re: [PATCH v8 13/13] nvmet-passthru: support block accounting
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-14-logang@deltatee.com>
 <92d61426-65a2-827c-936b-55f12f3d6afb@grimberg.me>
 <ca4ebcd9-fa5d-5ddf-c2a7-70318410dd97@deltatee.com>
 <7954e8a4-6026-2210-7192-94a4e483facf@grimberg.me>
 <b23c72b2-c9db-cb8e-5519-63eb195b7fd4@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ca811aea-c4ae-10ee-15a5-2332d5a9e29a@grimberg.me>
Date:   Mon, 9 Sep 2019 16:15:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b23c72b2-c9db-cb8e-5519-63eb195b7fd4@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>>>> Support block disk accounting by setting the RQF_IO_STAT flag
>>>>> and gendisk in the request.
>>>>>
>>>>> After this change, IO counts will be reflected correctly in
>>>>> /proc/diskstats for drives being used by passthru.
>>>>>
>>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>>> ---
>>>>>     drivers/nvme/target/io-cmd-passthru.c | 5 ++++-
>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
>>>>> index 7557927a3451..63f12750a80d 100644
>>>>> --- a/drivers/nvme/target/io-cmd-passthru.c
>>>>> +++ b/drivers/nvme/target/io-cmd-passthru.c
>>>>> @@ -410,6 +410,9 @@ static struct request *nvmet_passthru_blk_make_request(struct nvmet_req *req,
>>>>>     	if (unlikely(IS_ERR(rq)))
>>>>>     		return rq;
>>>>>     
>>>>> +	if (blk_queue_io_stat(q) && cmd->common.opcode != nvme_cmd_flush)
>>>>> +		rq->rq_flags |= RQF_IO_STAT;
>>>
>>> Thanks for the review!
>>>
>>>> Does flush has data bytes in the request? Why the special casing?
>>>
>>> Well it was special cased in the vanilla blk account flow... But I think
>>> it's required to be special cased so the IO and in_flight counts don't
>>> count flushes (as they do not for regular block device traffic).
>>
>> I think that the accounting exclude I/O that is yielded from the flush
>> sequence. Don't think its relevant here...
> 
> What? Per blk_account_io_done(), RQF_FLUSH_SEQ will not be set by us for
> passthru commands and I don't think it's appropriate to do so. Thus, if
> we set RQF_IO_STAT for passthru flush commands, they will be counted
> which we do not want.

Have you considered to have nvmet_passthru_blk_make_request set RQF_FUA
for nvme_cmd_flush? this way blk_insert_flush will be called and
RQF_FLUSH_SEQ will be set and you don't need to worry about this
special casing...
