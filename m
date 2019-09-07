Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5286AC37C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2019 02:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406281AbfIGAAX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 20:00:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43151 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405572AbfIGAAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:00:22 -0400
Received: by mail-oi1-f194.google.com with SMTP id t84so6448340oih.10;
        Fri, 06 Sep 2019 17:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CTESiiiEsvvGtzHjMvt+Vs+YyinAgG2nRdj8V0GoeRI=;
        b=Pq81b9Tzy56Piznk485w3DSx9Fz/UgdOXrizeHAIFpTL8PJ0NJv5WiM8mM/HzVPNSc
         ZZeUPpM8TK+5Zdn0436NfXkG6nbwB2PKnnEq3TkExuWzap53mmZiY+PnksG6XBEAtQHl
         E4VsnTLamUyT+R5jTBEudkUhJdsjXQio5vMnxoKyXOxoyil6mK/y1NjA2N6/2m+A+ruf
         BO2bWtg5BLmymucCJAc5RV/eVNY1HDeBtD4hFtWlZlfnxYR1HyquvJ5qD0cL8XLGu9J6
         USkNtgVNehtnZjnpdiHpIrFSI3cuz9A8ub2u6SZ8I6QD8QRdbXchaVJyKtQxvm1cwr4i
         fo4w==
X-Gm-Message-State: APjAAAWIm1Id4mN4gCUHz9oc9MPjBWFsFs/bglgL0yuVMDD1OfG94Em1
        dHhJcob7dNih+JmpOWBGYCA=
X-Google-Smtp-Source: APXvYqxVnW04a3pr7A6Hae0d1zkxWcP9AgzgoZUhAC/S/OwAbr5Y/KKWFoseJliFrz3GXCxEwxRWkA==
X-Received: by 2002:aca:6707:: with SMTP id z7mr2532791oix.12.1567814421581;
        Fri, 06 Sep 2019 17:00:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id i20sm2195084oie.13.2019.09.06.17.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 17:00:20 -0700 (PDT)
Subject: Re: [PATCH v8 13/13] nvmet-passthru: support block accounting
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20190828215429.4572-1-logang@deltatee.com>
 <20190828215429.4572-14-logang@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <92d61426-65a2-827c-936b-55f12f3d6afb@grimberg.me>
Date:   Fri, 6 Sep 2019 17:00:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828215429.4572-14-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Support block disk accounting by setting the RQF_IO_STAT flag
> and gendisk in the request.
> 
> After this change, IO counts will be reflected correctly in
> /proc/diskstats for drives being used by passthru.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/io-cmd-passthru.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
> index 7557927a3451..63f12750a80d 100644
> --- a/drivers/nvme/target/io-cmd-passthru.c
> +++ b/drivers/nvme/target/io-cmd-passthru.c
> @@ -410,6 +410,9 @@ static struct request *nvmet_passthru_blk_make_request(struct nvmet_req *req,
>   	if (unlikely(IS_ERR(rq)))
>   		return rq;
>   
> +	if (blk_queue_io_stat(q) && cmd->common.opcode != nvme_cmd_flush)
> +		rq->rq_flags |= RQF_IO_STAT;

Does flush has data bytes in the request? Why the special casing?
