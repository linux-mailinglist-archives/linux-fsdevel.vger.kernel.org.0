Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C384A64D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 20:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbiBATSt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 14:18:49 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:44606 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242361AbiBATSt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:18:49 -0500
Received: by mail-pg1-f173.google.com with SMTP id h23so16223472pgk.11;
        Tue, 01 Feb 2022 11:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NRC1O6LjHoTRFcyJrr+TbaOvQh6OliquRDaYmBL6vQo=;
        b=1P//Eph80WwsbujlE3jVFShWweV+3UkgMOULsYevKn0KhVw8VtjXybVr4xhOVHnghP
         KjG/v2XqnilDGuQQaPad01V8vXn9qT8AN3XtsHCrkvGIA1h/fhwTd6lowqPOLlFIOE3E
         9knxRRXT6LiRvhPb9BSVWBYbKl4Mv6ceg6Bs+NAzd3/6KMrNLiE2y3pQXqlAXCHvIi6S
         Bi6DeDYI9hjYBlYZXPM1zPr8efrsm84GeIt4HAJ9ZL5lR/hq3YYVNAWm8j9fOkDhqfr2
         fQJi6B/6A9qR16AuPxMTtXY2xRJ9SoPCQqUd3CnaHTfwe4ytJIl40w89M3wkQd6kHW86
         mkjw==
X-Gm-Message-State: AOAM532lLZMcR1WVZgnR2+NrwV4B2CXvONh2gj+XYBqkaIJCQNQIjCEM
        E9lXAZZuX3C1m25NhVojYqw=
X-Google-Smtp-Source: ABdhPJzdZuuT3zl/4KWMi39wXS4EFCvsDMKJDeuJ1g6HI0TEGyb2bJY3A35suFFqhBI5SCopxvLvag==
X-Received: by 2002:a63:9307:: with SMTP id b7mr22131054pge.616.1643743123461;
        Tue, 01 Feb 2022 11:18:43 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id nv13sm4083647pjb.17.2022.02.01.11.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 11:18:42 -0800 (PST)
Message-ID: <efd2e976-4d2d-178e-890d-9bde1a89c47f@acm.org>
Date:   Tue, 1 Feb 2022 11:18:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 1/3] block: add copy offload support
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <alpine.LRH.2.02.2202011331570.22481@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/1/22 10:32, Mikulas Patocka wrote:
>   /**
> + * blk_queue_max_copy_sectors - set maximum copy offload sectors for the queue
> + * @q:  the request queue for the device
> + * @size:  the maximum copy offload sectors
> + */
> +void blk_queue_max_copy_sectors(struct request_queue *q, unsigned int size)
> +{
> +	q->limits.max_copy_sectors = size;
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors);

Please either change the unit of 'size' into bytes or change its type 
into sector_t.

> +extern int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
> +		      struct block_device *bdev2, sector_t sector2,
> +		      sector_t nr_sects, sector_t *copied, gfp_t gfp_mask);
> +

Only supporting copying between contiguous LBA ranges seems restrictive 
to me. I expect garbage collection by filesystems for UFS devices to 
perform better if multiple LBA ranges are submitted as a single SCSI 
XCOPY command.

A general comment about the approach: encoding the LBA range information 
in a bio payload is not compatible with bio splitting. How can the dm 
driver implement copy offloading without the ability to split copy 
offload bio's?

> +int blkdev_issue_copy(struct block_device *bdev1, sector_t sector1,
> +		      struct block_device *bdev2, sector_t sector2,
> +		      sector_t nr_sects, sector_t *copied, gfp_t gfp_mask)
> +{
> +	struct page *token;
> +	sector_t m;
> +	int r = 0;
> +	struct completion comp;

Consider using DECLARE_COMPLETION_ONSTACK() instead of a separate 
declaration and init_completion() call.

Thanks,

Bart.
