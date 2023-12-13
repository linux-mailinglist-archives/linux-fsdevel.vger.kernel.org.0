Return-Path: <linux-fsdevel+bounces-5780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A189381079E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 02:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A5A1F219CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 01:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7D31109;
	Wed, 13 Dec 2023 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYhfZ+Vs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40B5CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 17:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702430757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7+Fi662eTBH61l7dziQI31ojIowi0xTylG+eKXF8CnY=;
	b=UYhfZ+VspMN6MzMZeixGy+OAJ9OlNKfVsbfSSWNZY/rDPF2NbEIQFhCtHvsGTkTH7zAvfK
	qFH7UUL6izIT8Z6mpWXoqjRBpCLxVO5pnRywPKe7JpjvLni49Y1yT4ROxJDvHACpSZMBZD
	6C6hjTk4kqLg/EYvF+jS48uY65wOhgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-C7-uyY69MkKS7aFFTyZZzQ-1; Tue, 12 Dec 2023 20:25:52 -0500
X-MC-Unique: C7-uyY69MkKS7aFFTyZZzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1ED9833B41;
	Wed, 13 Dec 2023 01:25:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.39])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B04C3C25;
	Wed, 13 Dec 2023 01:25:42 +0000 (UTC)
Date: Wed, 13 Dec 2023 09:25:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	jaswin@linux.ibm.com, bvanassche@acm.org,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v2 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <ZXkIEnQld577uHqu@fedora>
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212110844.19698-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212110844.19698-2-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, Dec 12, 2023 at 11:08:29AM +0000, John Garry wrote:
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
> 
> Add the following limits:
> - atomic_write_boundary_bytes
> - atomic_write_max_bytes
> - atomic_write_unit_max_bytes
> - atomic_write_unit_min_bytes
> 
> All atomic writes limits are initialised to 0 to indicate no atomic write
> support. Stacked devices are just not supported either for now.
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> #jpg: Heavy rewrite
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 47 ++++++++++++++++++++++
>  block/blk-settings.c                 | 60 ++++++++++++++++++++++++++++
>  block/blk-sysfs.c                    | 33 +++++++++++++++
>  include/linux/blkdev.h               | 37 +++++++++++++++++
>  4 files changed, 177 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index 1fe9a553c37b..ba81a081522f 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -21,6 +21,53 @@ Description:
>  		device is offset from the internal allocation unit's
>  		natural alignment.
>  
> +What:		/sys/block/<disk>/atomic_write_max_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the maximum atomic write
> +		size reported by the device. This parameter is relevant
> +		for merging of writes, where a merged atomic write
> +		operation must not exceed this number of bytes.
> +		The atomic_write_max_bytes may exceed the value in
> +		atomic_write_unit_max_bytes if atomic_write_max_bytes
> +		is not a power-of-two or atomic_write_unit_max_bytes is
> +		limited by some queue limits, such as max_segments.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_min_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the smallest block which can
> +		be written atomically with an atomic write operation. All
> +		atomic write operations must begin at a
> +		atomic_write_unit_min boundary and must be multiples of
> +		atomic_write_unit_min. This value must be a power-of-two.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_unit_max_bytes
> +Date:		January 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter defines the largest block which can be
> +		written atomically with an atomic write operation. This
> +		value must be a multiple of atomic_write_unit_min and must
> +		be a power-of-two.
> +
> +
> +What:		/sys/block/<disk>/atomic_write_boundary_bytes
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
> +
>  
>  What:		/sys/block/<disk>/diskseq
>  Date:		February 2021
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 0046b447268f..d151be394c98 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,10 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
>  	lim->dma_alignment = 511;
> +	lim->atomic_write_unit_min_sectors = 0;
> +	lim->atomic_write_unit_max_sectors = 0;
> +	lim->atomic_write_max_sectors = 0;
> +	lim->atomic_write_boundary_sectors = 0;

Can we move the four into single structure and setup them in single
API? Then cross-validation can be done in this API.

>  }
>  
>  /**
> @@ -183,6 +187,62 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
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
> +				      unsigned int bytes)
> +{
> +	q->limits.atomic_write_max_sectors = bytes >> SECTOR_SHIFT;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);

What if driver doesn't call it but driver supports atomic write?

I guess the default max sectors should be atomic_write_unit_max_sectors
if the feature is enabled.

> +
> +/**
> + * blk_queue_atomic_write_boundary_bytes - Device's logical block address space
> + * which an atomic write should not cross.
> + * @q:  the request queue for the device
> + * @bytes: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_boundary_bytes(struct request_queue *q,
> +					   unsigned int bytes)
> +{
> +	q->limits.atomic_write_boundary_sectors = bytes >> SECTOR_SHIFT;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_boundary_bytes);

Default atomic_write_boundary_sectors should be
atomic_write_unit_max_sectors in case of atomic write?

> +
> +/**
> + * blk_queue_atomic_write_unit_min_sectors - smallest unit that can be written
> + * atomically to the device.
> + * @q:  the request queue for the device
> + * @sectors: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_unit_min_sectors(struct request_queue *q,
> +					     unsigned int sectors)
> +{
> +	struct queue_limits *limits = &q->limits;
> +
> +	limits->atomic_write_unit_min_sectors = sectors;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_min_sectors);

atomic_write_unit_min_sectors should be >= (physical block size >> 9)
given the minimized atomic write unit is physical sector for all disk.

> +
> +/*
> + * blk_queue_atomic_write_unit_max_sectors - largest unit that can be written
> + * atomically to the device.
> + * @q: the request queue for the device
> + * @sectors: must be a power-of-two.
> + */
> +void blk_queue_atomic_write_unit_max_sectors(struct request_queue *q,
> +					     unsigned int sectors)
> +{
> +	struct queue_limits *limits = &q->limits;
> +
> +	limits->atomic_write_unit_max_sectors = sectors;
> +}
> +EXPORT_SYMBOL(blk_queue_atomic_write_unit_max_sectors);

atomic_write_unit_max_sectors should be >= atomic_write_unit_min_sectors.


Thanks, 
Ming


