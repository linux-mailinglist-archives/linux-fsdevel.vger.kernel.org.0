Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF121ACE9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 19:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389206AbgDPRXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 13:23:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:56628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388338AbgDPRXA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:23:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79472B13D;
        Thu, 16 Apr 2020 17:22:58 +0000 (UTC)
Date:   Thu, 16 Apr 2020 19:22:57 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 02/11] block: provide fallbacks for
 blk_queue_zone_is_seq and blk_queue_zone_no
Message-ID: <20200416172257.4zvks6u2f6c6couu@carbon>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
 <20200415090513.5133-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415090513.5133-3-johannes.thumshirn@wdc.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:05:04PM +0900, Johannes Thumshirn wrote:
> blk_queue_zone_is_seq() and blk_queue_zone_no() have not been called with
> CONFIG_BLK_DEV_ZONED disabled until now.
> 
> The introduction of REQ_OP_ZONE_APPEND will change this, so we need to
> provide noop fallbacks for the !CONFIG_BLK_DEV_ZONED case.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blkdev.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 32868fbedc9e..e47888a7d80b 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -729,6 +729,16 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  {
>  	return 0;
>  }
> +static inline bool blk_queue_zone_is_seq(struct request_queue *q,
> +					 sector_t sector)
> +{
> +	return false;
> +}
> +static inline unsigned int blk_queue_zone_no(struct request_queue *q,
> +					     sector_t sector)
> +{
> +	return 0;
> +}

nit: blk_queue_zone_no is defined before blk_queue_zone_is_seq in the
CONFIG_BLK_DEV_ZONED section.

Besides that,

Reviewed-by: Daniel Wagner <dwagner@suse.de>
