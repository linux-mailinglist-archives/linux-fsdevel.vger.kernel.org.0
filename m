Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748282C6695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 14:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbgK0NTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 08:19:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:51378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgK0NTD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:19:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6B3BABD7;
        Fri, 27 Nov 2020 13:19:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7BE0A1E1318; Fri, 27 Nov 2020 14:19:01 +0100 (CET)
Date:   Fri, 27 Nov 2020 14:19:01 +0100
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
Subject: Re: [PATCH 43/44] block: merge struct block_device and struct
 hd_struct
Message-ID: <20201127131901.GE27162@quack2.suse.cz>
References: <20201126130422.92945-1-hch@lst.de>
 <20201126130422.92945-44-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126130422.92945-44-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 26-11-20 14:04:21, Christoph Hellwig wrote:
> Instead of having two structures that represent each block device with
> different life time rules, merge them into a single one.  This also
> greatly simplifies the reference counting rules, as we can use the inode
> reference count as the main reference count for the new struct
> block_device, with the device model reference front ending it for device
> model interaction.  The percpu refcount in struct hd_struct is entirely
> gone given that struct block_device must be opened and thus valid for
> the duration of the I/O.

The percpu refcount is long gone after the series refactoring...

> @@ -939,13 +910,13 @@ void blk_request_module(dev_t devt)
>   */
>  struct block_device *bdget_disk(struct gendisk *disk, int partno)
>  {
> -	struct hd_struct *part;
>  	struct block_device *bdev = NULL;
>  
> -	part = disk_get_part(disk, partno);
> -	if (part)
> -		bdev = bdget_part(part);
> -	disk_put_part(part);
> +	rcu_read_lock();
> +	bdev = __disk_get_part(disk, partno);
> +	if (bdev)
> +		bdgrab(bdev);

Again I think you need to accommodate for bdgrab() returning NULL here when
we race with partition destruction...

> +	rcu_read_unlock();
>  
>  	return bdev;
>  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
