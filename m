Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818F52C59A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 17:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391584AbgKZQ4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 11:56:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:32988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391576AbgKZQ4n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 11:56:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00CC4AD20;
        Thu, 26 Nov 2020 16:56:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 841961E10D0; Thu, 26 Nov 2020 17:56:41 +0100 (CET)
Date:   Thu, 26 Nov 2020 17:56:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 31/44] block: move the start_sect field to struct
 block_device
Message-ID: <20201126165641.GQ422@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-32-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-32-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:09, Christoph Hellwig wrote:
> Move the start_sect field to struct block_device in preparation
> of killing struct hd_struct.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good, just one nit below. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 8924e1ea8b2ad6..485777cea26bfa 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -192,7 +192,7 @@ static ssize_t part_start_show(struct device *dev,
>  {
>  	struct hd_struct *p = dev_to_part(dev);
>  
> -	return sprintf(buf, "%llu\n",(unsigned long long)p->start_sect);
> +	return sprintf(buf, "%llu\n",(unsigned long long)p->bdev->bd_start_sect);

The long long conversion is pointless here, right?

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
