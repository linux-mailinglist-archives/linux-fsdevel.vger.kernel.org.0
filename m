Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A142837EF87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 01:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhELXNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 19:13:17 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:38663 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442670AbhELWMK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 18:12:10 -0400
Received: by mail-qk1-f176.google.com with SMTP id q10so19672682qkc.5;
        Wed, 12 May 2021 15:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SCqLxJf0+9Xv5oHYhvN5Usd5q1FWnTVefGLnMau8//4=;
        b=nUcMG9sioDiGyKuh7Nl79hyMS2K+0CeYnWAgKIwMgw74Yu0Y/FRBfYNHZeiQ02vyO5
         B9ITiF9hHrRLLgXY3GFXXr1BLqRQf3Qs9X9YmVs0NsfhXeKnou2+OWjw7hSUHyyDLtdV
         7ToSKdWfstb04Vcoanw5Rf/naFMmIvNno4xmx/bPIQLNhM8RNMAmX6ywCUOaJhGZotXT
         Ru1AVjbCP8CTBP3Mmmd1xzby+gcd7WCbdfWDsw+tz4d6amNywI1f7/0MxJDEhhYgi/Md
         0LX/4BE0k+GwP4Pn1UrhKDqKlYi9zPRzNa6lMhZP6zzPTgp7FEP/I52pl82SQdsx1gOa
         uPrw==
X-Gm-Message-State: AOAM530BA9lQDqVTpTC5LaiAV0kNQ3laQryVfPO8MNgQmJ6/ZZ9FccsY
        8eEBlvALKmZdtsjDSw1Y8v0=
X-Google-Smtp-Source: ABdhPJwiFho7EirWytFWbXSBRx6w3tCpQCdkAagD5zxtBueiOMsBwn4nn/jghk0vwnMtLPSYBycWKQ==
X-Received: by 2002:a37:5f41:: with SMTP id t62mr35409256qkb.458.1620857461602;
        Wed, 12 May 2021 15:11:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848? ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
        by smtp.gmail.com with ESMTPSA id r9sm1071163qtf.62.2021.05.12.15.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 15:11:01 -0700 (PDT)
Subject: Re: [PATCH 15/15] nvme-multipath: enable polled I/O
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-16-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2ae11b40-1d03-af08-aade-022fc1f0a743@grimberg.me>
Date:   Wed, 12 May 2021 15:10:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-16-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> Set the poll queue flag to enable polling, given that the multipath
> node just dispatches the bios to a lower queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/multipath.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 516fe977606d..e95b93655d06 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -446,6 +446,15 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   		goto out;
>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
>   	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
> +	/*
> +	 * This assumes all controllers that refer to a namespace either
> +	 * support poll queues or not.  That is not a strict guarantee,
> +	 * but if the assumption is wrong the effect is only suboptimal
> +	 * performance but not correctness problem.
> +	 */
> +	if (ctrl->tagset->nr_maps > HCTX_TYPE_POLL &&
> +	    ctrl->tagset->map[HCTX_TYPE_POLL].nr_queues)
> +		blk_queue_flag_set(QUEUE_FLAG_POLL, q);

If one controller does not support polling and the other does, won't
the block layer fail to map a queue for REQ_POLLED requests?

Maybe clear in the else case here?
