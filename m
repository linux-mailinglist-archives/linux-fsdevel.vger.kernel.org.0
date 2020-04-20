Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B26D1AFF57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 02:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgDTAtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 20:49:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46731 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDTAtF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:49:05 -0400
Received: by mail-pl1-f193.google.com with SMTP id n24so3295284plp.13;
        Sun, 19 Apr 2020 17:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=plXatsbR9BcIEMtWXpoXiscsGWga1zHVo5Bn3+uYHbU=;
        b=gnlRi53O8lzOsxbFNtydRfVSCeG/kP/ymm2ptVHgYwFTHxXfZQ2Os8MX1k7Q6UEpjY
         zK1S8su/9On/+YRXNIkiposbRQBOIryuX1vUSOyvB5XTUBS4nUfPyS5+Y0pds3iV/01l
         dEY0MoSrXNJDNGUZHG7iv+GwZhrzpOpO0x/RIy9ZS0WRE9jls8q4go1Vq0dJCSgk13YN
         rPcjU9Q+99jyh8XzpjVGmhDLV/Wu7WBI5XmH8RuscAKi3sF6Ou0+QFJ8shz9ICye8yCP
         vl2Yt9tt/b3BP4ibJ5pYZDYF8vwzJ6F9mVttBivsULQ/cmbwF/IamzxocQn/QOf2BwwD
         tFYQ==
X-Gm-Message-State: AGi0Pualz11iZ+4T/V/dY+3cqcNhr81IWW9Vlqwucp+UtTkrJtH4QTbd
        PO6helC996Iu/cSPKAL8Xu4=
X-Google-Smtp-Source: APiQypJCa16L563ORXnhGw7azr4Wdql7RUSRkbPYh9iGbweBGGXZacJjLZFS2Lz6JJMlcN2ef8oZEA==
X-Received: by 2002:a17:902:aa08:: with SMTP id be8mr13349156plb.299.1587343744621;
        Sun, 19 Apr 2020 17:49:04 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.198.54])
        by smtp.gmail.com with ESMTPSA id j32sm12849355pgb.55.2020.04.19.17.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 17:49:03 -0700 (PDT)
Subject: Re: [PATCH v7 04/11] block: Introduce REQ_OP_ZONE_APPEND
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-5-johannes.thumshirn@wdc.com>
 <373bc820-95f2-5728-c102-c4ca9fa8eea5@acm.org>
 <BY5PR04MB6900E3323E8FB58C8AB42D24E7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <af522aee-365b-a65e-ce40-a8f66bbc7d63@acm.org>
Date:   Sun, 19 Apr 2020 17:49:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BY5PR04MB6900E3323E8FB58C8AB42D24E7D40@BY5PR04MB6900.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 5:30 PM, Damien Le Moal wrote:
> On 2020/04/19 1:46, Bart Van Assche wrote:
>> On 2020-04-17 05:15, Johannes Thumshirn wrote:
>>> From: Keith Busch <kbusch@kernel.org>
>>> +/*
>>> + * Check write append to a zoned block device.
>>> + */
>>> +static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>>> +						 struct bio *bio)
>>> +{
>>> +	sector_t pos = bio->bi_iter.bi_sector;
>>> +	int nr_sectors = bio_sectors(bio);
>>> +
>>> +	/* Only applicable to zoned block devices */
>>> +	if (!blk_queue_is_zoned(q))
>>> +		return BLK_STS_NOTSUPP;
>>> +
>>> +	/* The bio sector must point to the start of a sequential zone */
>>> +	if (pos & (blk_queue_zone_sectors(q) - 1) ||
>>> +	    !blk_queue_zone_is_seq(q, pos))
>>> +		return BLK_STS_IOERR;
>>> +
>>> +	/*
>>> +	 * Not allowed to cross zone boundaries. Otherwise, the BIO will be
>>> +	 * split and could result in non-contiguous sectors being written in
>>> +	 * different zones.
>>> +	 */
>>> +	if (blk_queue_zone_no(q, pos) != blk_queue_zone_no(q, pos + nr_sectors))
>>> +		return BLK_STS_IOERR;
>>
>> Can the above statement be simplified into the following?
>>
>> 	if (nr_sectors > q->limits.chunk_sectors)
>> 		return BLK_STS_IOERR;
> 
> That would be equivalent only if the zone is empty. If the zone is not empty, we
> need to check that the zone append request does not cross over to the next zone,
> which would result in the BIO being split by the block layer.

At the start of blk_check_zone_append() function there is a check that 
'pos' is aligned with a zone boundary. How can 'pos' at the same time 
represent a zone boundary and the exact offset at which the write will 
happen? I do not understand this.

>>> +	/* Make sure the BIO is small enough and will not get split */
>>> +	if (nr_sectors > q->limits.max_zone_append_sectors)
>>> +		return BLK_STS_IOERR;
>>
>> Do we really need a new request queue limit parameter? In which cases
>> will max_zone_append_sectors differ from the zone size?
> 
> Yes it can differ from the zone size. On real hardware, max_zone_append_sectors
> will most of the time be equal to max_hw_sectors_kb. But it could be smaller
> than that too. For the host, since a zone append is a write, it is also subject
> to the max_sector_kb limit and cannot exceed that value.

Would it be possible to use min(max_hw_sectors, zone_size) instead of 
introducing a new user-visible parameter?

Thanks,

Bart.
