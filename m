Return-Path: <linux-fsdevel+bounces-6840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EEF81D558
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 18:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4D3B20FF0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 17:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE77012E68;
	Sat, 23 Dec 2023 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n5ecZBTz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65C512E4C;
	Sat, 23 Dec 2023 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Cxs7b1r/Fe+mA08T4R0mNQ1fxv7+YhK2lTuot6SaQik=; b=n5ecZBTziYZYMztlj2287d4czK
	ml7cm9aw1T+0iVgkbnWKxaTTXKBcb46wrTtLR2cpZ6JzPt87e/ZOk+YN+BcmHpGceFYQwbG6TCmUn
	2/VVFTmvky5olmxAfDG+0qZ8z+LPPpf8u70Ai7d5Slq1K484QQZDKCm7dBvsESdFibfIkn0wHOZFA
	dZJMlBYBjYa9hkvZpbAVrPS56AMkvhhCeNeu4AfGdy+6akR7Z9BIJQ6lfh3OOUC9V+pNhgGo/mfiK
	S401NuO0YUaMlRsvZHgjfMbObBG2ZmuSJGS1ljZCYKmYCBguSKNIaneuWlwbS7egy1SGKjDV3fGW4
	digukkoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rH5qt-00BIro-7V; Sat, 23 Dec 2023 17:31:55 +0000
Date: Sat, 23 Dec 2023 17:31:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
	kent.overstreet@gmail.com, joern@lazybastard.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sth@linux.ibm.com, hoeppner@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
	nico@fluxnic.net, xiang@kernel.org, chao@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, jack@suse.com, konishi.ryusuke@gmail.com,
	akpm@linux-foundation.org, hare@suse.de, p.raghav@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
	linux-nilfs@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v3 for-6.8/block 09/17] btrfs: use bdev apis
Message-ID: <ZYcZi5YYvt5QHrG9@casper.infradead.org>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085712.1766333-10-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221085712.1766333-10-yukuai1@huaweicloud.com>

On Thu, Dec 21, 2023 at 04:57:04PM +0800, Yu Kuai wrote:
> @@ -3674,16 +3670,17 @@ struct btrfs_super_block *btrfs_read_dev_one_super(struct block_device *bdev,
>  		 * Drop the page of the primary superblock, so later read will
>  		 * always read from the device.
>  		 */
> -		invalidate_inode_pages2_range(mapping,
> -				bytenr >> PAGE_SHIFT,
> +		invalidate_bdev_range(bdev, bytenr >> PAGE_SHIFT,
>  				(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
>  	}
>  
> -	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
> -	if (IS_ERR(page))
> -		return ERR_CAST(page);
> +	nofs_flag = memalloc_nofs_save();
> +	folio = bdev_read_folio(bdev, bytenr);
> +	memalloc_nofs_restore(nofs_flag);

This is the wrong way to use memalloc_nofs_save/restore.  They should be
used at the point that the filesystem takes/releases whatever lock is
also used during reclaim.  I don't know btrfs well enough to suggest
what lock is missing these annotations.


