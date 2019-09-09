Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D16ADF6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 21:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfIIT0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 15:26:40 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32799 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729060AbfIIT0k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 15:26:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id g25so12846551otl.0;
        Mon, 09 Sep 2019 12:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gLM1CCeC9p531hDNHLzC8mfBfqp2fYYPYblncN2/1Rc=;
        b=KKkXO0ezzEspIPk0w3BCC3YY19ntWXFIAilGUb6+Ma9tjL6+5+M2reVTsTXlIcndPN
         GYxToW8uMLeylQ+bycJnoH8/UJvntB/OsFBTjJ+ax56cWOvDCbtYknq5BB9oA4lT1ybb
         v5LJWnYm8k9JI0o1cX+vwwj1Kf6NLV4ewEYzHHkMJrojtMrRL27NBwjcvrrEmqm3ZRmj
         sMeSgMrdbWusLM6pV76/+qjcntS9J/HqLj1UCyi9i1s9vL/w4zG36RLfxDcSK5DVeieE
         GX7s8Tk+NXPBvTBbZNVW+9rPcuF9pT/ehmrmHDarjpwlMBbTC06Nk0DSzfNi72xEZIu4
         oYNQ==
X-Gm-Message-State: APjAAAW4N/0KSWBXwjHMT0KvrIrQqmOoEoge4Iq+Nqm/bAJg7mNd2hlA
        w9EJv95+pYrkAJZcwq8FAjI=
X-Google-Smtp-Source: APXvYqxvv9Dl8xhPxigif8op9MALNHTzy1+8Tpt1rHFifjQ8+bhuULtTy/MLAuruuc/2+om5BkVnKA==
X-Received: by 2002:a9d:77c1:: with SMTP id w1mr5081503otl.9.1568057198903;
        Mon, 09 Sep 2019 12:26:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id k10sm2043237oij.16.2019.09.09.12.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 12:26:37 -0700 (PDT)
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
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7954e8a4-6026-2210-7192-94a4e483facf@grimberg.me>
Date:   Mon, 9 Sep 2019 12:26:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ca4ebcd9-fa5d-5ddf-c2a7-70318410dd97@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>> Support block disk accounting by setting the RQF_IO_STAT flag
>>> and gendisk in the request.
>>>
>>> After this change, IO counts will be reflected correctly in
>>> /proc/diskstats for drives being used by passthru.
>>>
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>> ---
>>>    drivers/nvme/target/io-cmd-passthru.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
>>> index 7557927a3451..63f12750a80d 100644
>>> --- a/drivers/nvme/target/io-cmd-passthru.c
>>> +++ b/drivers/nvme/target/io-cmd-passthru.c
>>> @@ -410,6 +410,9 @@ static struct request *nvmet_passthru_blk_make_request(struct nvmet_req *req,
>>>    	if (unlikely(IS_ERR(rq)))
>>>    		return rq;
>>>    
>>> +	if (blk_queue_io_stat(q) && cmd->common.opcode != nvme_cmd_flush)
>>> +		rq->rq_flags |= RQF_IO_STAT;
> 
> Thanks for the review!
> 
>> Does flush has data bytes in the request? Why the special casing?
> 
> Well it was special cased in the vanilla blk account flow... But I think
> it's required to be special cased so the IO and in_flight counts don't
> count flushes (as they do not for regular block device traffic).

I think that the accounting exclude I/O that is yielded from the flush
sequence. Don't think its relevant here...
