Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6373199979
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgCaPXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 11:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730105AbgCaPXZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:23:25 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A6C20786;
        Tue, 31 Mar 2020 15:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585668204;
        bh=Zl6S9IRFwUsBOn6IiDpE/WA5x2SlSjCDcLLIPst4E5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yRpb6MgLbkwu90Xh/DHq+YFbBWCp996yX16m1OkT51EwxooYbV5eEIjRLKL41RGyL
         v/JGXyTq4vA6rgU9qwyycGHDhwgKTN+7WEOOHeRN+NE6BP+aNDhAD6m3CPozq1Rxbr
         u8GFYn6e6INIrX6wvX48ocJcVELHlAHmIDPqmojc=
Date:   Wed, 1 Apr 2020 00:23:17 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] block: Introduce REQ_OP_ZONE_APPEND
Message-ID: <20200331152317.GB30875@redsun51.ssa.fujisawa.hgst.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165012.34443-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 28, 2020 at 01:50:04AM +0900, Johannes Thumshirn wrote:
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -455,6 +455,15 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
>  				       blk_revalidate_zone_cb, &args);
>  	memalloc_noio_restore(noio_flag);
>  
> +	if (ret == 0 &&
> +	    (queue_max_zone_append_sectors(q) > queue_max_hw_sectors(q) ||
> +	     queue_max_zone_append_sectors(q) > q->limits.chunk_sectors)) {
> +		pr_warn("%s: invalid max_zone_append_bytes value: %u\n",
> +			disk->disk_name, queue_max_zone_append_sectors(q) << 9);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +

The generic block layer doesn't set chunk_sectors until after this,
so unless the driver happened to set it earlier, this check would fail.
We don't want to rely on the driver doing this, so I'll fix it up for
the next version.
