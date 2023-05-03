Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3736F6097
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 23:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjECVjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjECVjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 17:39:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3CDF4EC9
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 May 2023 14:39:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6434e263962so789318b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 May 2023 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683149970; x=1685741970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzAhAYHfPiOiW4LGzVRyyrVTgIaQhjrhkrdgvGxpiyM=;
        b=IhF1wixOaSL/x8TlU2RExxY7cJSSZaroN+UxW8vl7cR9l23m0lsThaG0Tea8DON128
         ps3dQt0jnqtLV6sgxnYS8EQrdj9H3j6pXLtmsQdF6LLgDIJngN1ezjwLb0Uhu61JCLc9
         jT0kF8peKcL8FlrOUKxCfAeGoidm+h4TUG5+pKrM2Yew5GctCXxqz4pZeUhjptSUY8Qy
         jMO8TJPDDU/sSzrlAvNFZsxacLg9E7hVWO24oQMJpIAtxV0FPPYHh35IL8wTpnYlq/V/
         QqO9XBTJsEjnoj2NBDmgiXzKqjBT6M5CpdQIQBOHk4tVRQt8N4OAapTxtPzTShctlGgv
         GMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683149970; x=1685741970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzAhAYHfPiOiW4LGzVRyyrVTgIaQhjrhkrdgvGxpiyM=;
        b=dncRl5kyJLSFnQNwe2t1Iy+usHBAGD6ArxESTs+wo0cc6ShgG6auOB2S0wWrqEalIZ
         1+jKrtj8ywINoQA25iVm3H+DB+sGrDG3fRu+o6+uTTDPFL5TD9uJCOs9KJuCYe9NdNQT
         939dv6xyn8jqwPNYM5JMrIgULMRcalyeSdBzzBp+h2COYOFd8+VzT7yMcQt/k5SzTm2s
         boz1BiYMWxade/HV4RXCC27csI0u64j2uNQcfLo8iXq7H8Zog+bc9Q+kaCyEI/HmqYsS
         twFhCx+8JtlLlk+Dm0oNyOY0pwyDVe3gOZ1luSw1LFv/YnYm/+VCSnpJaYKuK0bE37BA
         VZxQ==
X-Gm-Message-State: AC+VfDweyNGQLEqxlwECFZL2f+EjV9vlIPH3VnsRzbrOdQlXxAuCU+1w
        aHm7UYQrMZlN3DFBUgW7DzeT9Q==
X-Google-Smtp-Source: ACHHUZ7c8+1LMq/ab4C/efQsoxMs8u6vlVF2UalA9iWyU2ItPHceCK3E3VPgAKJ7NiuiSI8HPHPgHw==
X-Received: by 2002:a05:6a00:10c7:b0:641:2927:985b with SMTP id d7-20020a056a0010c700b006412927985bmr64703pfu.4.1683149970354;
        Wed, 03 May 2023 14:39:30 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm19474124pfk.79.2023.05.03.14.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 14:39:29 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1puKC5-00B0Kz-U6; Thu, 04 May 2023 07:39:25 +1000
Date:   Thu, 4 May 2023 07:39:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <20230503213925.GD3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503183821.1473305-2-john.g.garry@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 03, 2023 at 06:38:06PM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add the following limits:
> - atomic_write_boundary
> - atomic_write_max_bytes
> - atomic_write_unit_max
> - atomic_write_unit_min
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 42 +++++++++++++++++++++
>  block/blk-settings.c                 | 56 ++++++++++++++++++++++++++++
>  block/blk-sysfs.c                    | 33 ++++++++++++++++
>  include/linux/blkdev.h               | 23 ++++++++++++
>  4 files changed, 154 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 282de3680367..f3ed9890e03b 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -21,6 +21,48 @@ Description:
>  		device is offset from the internal allocation unit's
>  		natural alignment.
>  
> +What:		/sys/block/<disk>/atomic_write_max_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the maximum atomic write
> +		size reported by the device. An atomic write operation
> +		must not exceed this number of bytes.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_min
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the smallest block which can
> +		be written atomically with an atomic write operation. All
> +		atomic write operations must begin at a
> +		atomic_write_unit_min boundary and must be multiples of
> +		atomic_write_unit_min. This value must be a power-of-two.

What units is this defined to use? Bytes?

> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_max
> +Date:		January 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter defines the largest block which can be
> +		written atomically with an atomic write operation. This
> +		value must be a multiple of atomic_write_unit_min and must
> +		be a power-of-two.

Same question. Also, how is this different to
atomic_write_max_bytes?

> +
> +
> +What:		/sys/block/<disk>/atomic_write_boundary
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] A device may need to internally split I/Os which
> +		straddle a given logical block address boundary. In that
> +		case a single atomic write operation will be processed as
> +		one of more sub-operations which each complete atomically.
> +		This parameter specifies the size in bytes of the atomic
> +		boundary if one is reported by the device. This value must
> +		be a power-of-two.

How are users/filesystems supposed to use this?

> +
>  
>  What:		/sys/block/<disk>/diskseq
>  Date:		February 2021
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..e21731715a12 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,9 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
>  	lim->dma_alignment = 511;
> +	lim->atomic_write_unit_min = lim->atomic_write_unit_max = 1;

A value of "1" isn't obviously a power of 2, nor does it tell me
what units these values use.

> +	lim->atomic_write_max_bytes = 512;
> +	lim->atomic_write_boundary = 0;

The behaviour when the value is zero is not defined by the syfs
description above.

>  }
>  
>  /**
> @@ -183,6 +186,59 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  
> +/**
> + * blk_queue_atomic_write_max_bytes - set max bytes supported by
> + * the device for atomic write operations.
> + * @q:  the request queue for the device
> + * @size: maximum bytes supported
> + */
> +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> +				      unsigned int size)
> +{
> +	q->limits.atomic_write_max_bytes = size;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
> +
> +/**
> + * blk_queue_atomic_write_boundary - Device's logical block address space
> + * which an atomic write should not cross.

I have no idea what "logical block address space which an atomic
write should not cross" means, especially as the unit is in bytes
and not in sectors (which are the units LBAs are expressed in).

> + * @q:  the request queue for the device
> + * @size: size in bytes. Must be a power-of-two.
> + */
> +void blk_queue_atomic_write_boundary(struct request_queue *q,
> +				     unsigned int size)
> +{
> +	q->limits.atomic_write_boundary = size;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_boundary);
> +
> +/**
> + * blk_queue_atomic_write_unit_min - smallest unit that can be written
> + *				     atomically to the device.
> + * @q:  the request queue for the device
> + * @sectors: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_unit_min(struct request_queue *q,
> +				     unsigned int sectors)
> +{
> +	q->limits.atomic_write_unit_min = sectors;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_min);

Oh, these are sectors?

What size sector? Are we talking about fixed size 512 byte basic
block units, or are we talking about physical device sector sizes
(e.g. 4kB, maybe larger in future?)

These really should be in bytes, as they are directly exposed to
userspace applications via statx and applications will have no idea
what the sector size actually is without having to query the block
device directly...

> +
> +/*
> + * blk_queue_atomic_write_unit_max - largest unit that can be written
> + * atomically to the device.
> + * @q: the reqeust queue for the device
> + * @sectors: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_unit_max(struct request_queue *q,
> +				     unsigned int sectors)
> +{
> +	struct queue_limits *limits = &q->limits;
> +	limits->atomic_write_unit_max = sectors;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_max);
> +
>  /**
>   * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
>   * @q:  the request queue for the device
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index f1fce1c7fa44..1025beff2281 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -132,6 +132,30 @@ static ssize_t queue_max_discard_segments_show(struct request_queue *q,
>  	return queue_var_show(queue_max_discard_segments(q), page);
>  }
>  
> +static ssize_t queue_atomic_write_max_bytes_show(struct request_queue *q,
> +						char *page)
> +{
> +	return queue_var_show(q->limits.atomic_write_max_bytes, page);
> +}
> +
> +static ssize_t queue_atomic_write_boundary_show(struct request_queue *q,
> +						char *page)
> +{
> +	return queue_var_show(q->limits.atomic_write_boundary, page);
> +}
> +
> +static ssize_t queue_atomic_write_unit_min_show(struct request_queue *q,
> +						char *page)
> +{
> +	return queue_var_show(queue_atomic_write_unit_min(q), page);
> +}
> +
> +static ssize_t queue_atomic_write_unit_max_show(struct request_queue *q,
> +						char *page)
> +{
> +	return queue_var_show(queue_atomic_write_unit_max(q), page);
> +}
> +
>  static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
>  {
>  	return queue_var_show(q->limits.max_integrity_segments, page);
> @@ -604,6 +628,11 @@ QUEUE_RO_ENTRY(queue_discard_max_hw, "discard_max_hw_bytes");
>  QUEUE_RW_ENTRY(queue_discard_max, "discard_max_bytes");
>  QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
>  
> +QUEUE_RO_ENTRY(queue_atomic_write_max_bytes, "atomic_write_max_bytes");
> +QUEUE_RO_ENTRY(queue_atomic_write_boundary, "atomic_write_boundary");
> +QUEUE_RO_ENTRY(queue_atomic_write_unit_max, "atomic_write_unit_max");
> +QUEUE_RO_ENTRY(queue_atomic_write_unit_min, "atomic_write_unit_min");
> +
>  QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");
>  QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");
>  QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");
> @@ -661,6 +690,10 @@ static struct attribute *queue_attrs[] = {
>  	&queue_discard_max_entry.attr,
>  	&queue_discard_max_hw_entry.attr,
>  	&queue_discard_zeroes_data_entry.attr,
> +	&queue_atomic_write_max_bytes_entry.attr,
> +	&queue_atomic_write_boundary_entry.attr,
> +	&queue_atomic_write_unit_min_entry.attr,
> +	&queue_atomic_write_unit_max_entry.attr,
>  	&queue_write_same_max_entry.attr,
>  	&queue_write_zeroes_max_entry.attr,
>  	&queue_zone_append_max_entry.attr,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 941304f17492..6b6f2992338c 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -304,6 +304,11 @@ struct queue_limits {
>  	unsigned int		discard_alignment;
>  	unsigned int		zone_write_granularity;
>  
> +	unsigned int		atomic_write_boundary;
> +	unsigned int		atomic_write_max_bytes;
> +	unsigned int		atomic_write_unit_min;
> +	unsigned int		atomic_write_unit_max;
> +
>  	unsigned short		max_segments;
>  	unsigned short		max_integrity_segments;
>  	unsigned short		max_discard_segments;
> @@ -929,6 +934,14 @@ void blk_queue_zone_write_granularity(struct request_queue *q,
>  				      unsigned int size);
>  extern void blk_queue_alignment_offset(struct request_queue *q,
>  				       unsigned int alignment);
> +extern void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> +					     unsigned int size);
> +extern void blk_queue_atomic_write_unit_max(struct request_queue *q,
> +					    unsigned int sectors);
> +extern void blk_queue_atomic_write_unit_min(struct request_queue *q,
> +					    unsigned int sectors);
> +extern void blk_queue_atomic_write_boundary(struct request_queue *q,
> +					    unsigned int size);
>  void disk_update_readahead(struct gendisk *disk);
>  extern void blk_limits_io_min(struct queue_limits *limits, unsigned int min);
>  extern void blk_queue_io_min(struct request_queue *q, unsigned int min);
> @@ -1331,6 +1344,16 @@ static inline int queue_dma_alignment(const struct request_queue *q)
>  	return q ? q->limits.dma_alignment : 511;
>  }
>  
> +static inline unsigned int queue_atomic_write_unit_max(const struct request_queue *q)
> +{
> +	return q->limits.atomic_write_unit_max << SECTOR_SHIFT;
> +}
> +
> +static inline unsigned int queue_atomic_write_unit_min(const struct request_queue *q)
> +{
> +	return q->limits.atomic_write_unit_min << SECTOR_SHIFT;
> +}

Ah, what? This undocumented interface reports "unit limits" in
bytes, but it's not using the physical device sector size to convert
between sector units and bytes. This really needs some more
documentation and work to make it present all units consistently and
not result in confusion when devices have 4kB sector sizes and not
512 byte sectors...

Also, I think all the byte ranges should support full 64 bit values,
otherwise there will be silent overflows in converting 32 bit sector
counts to byte ranges. And, eventually, something will want to do
larger than 4GB atomic IOs

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
