Return-Path: <linux-fsdevel+bounces-10880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEE84F0F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 08:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB512825DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 07:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68AF65BBC;
	Fri,  9 Feb 2024 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N48zljBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29423657D3;
	Fri,  9 Feb 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464668; cv=none; b=HeO+yisrUjTJh68QFGr7BYpKnv/RmQZyS2LA8k8eEcb0IVm+XDpMGWI4IWHVdCp9qM8YGXDVtdR1mq9qACbEjH26uqOFRkVNuasvWKu2GsjH795I4M+kefwe0eO3bpliWABh1ehzZ/p/pJiAmbQWatJWa6jZ0Zwv+3K/Ikd417g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464668; c=relaxed/simple;
	bh=8hPt35qwRNiqM7E/NAuVeN0iulCZTDSGB64rom1/iK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssatsohcA+onJDIgqAQ+AAV/5UxBbN4UO5l7No6IrJ02NFRqhOvrOHJmsFwiROgpQnm5Hcxc2Bz+b6c/SGNiI/3LOePHPUTJc9KFkaldAK1L5ub/7URQfy5kVkJCv1trMDUeWVgBTHy4IJM/bn8HNUzIbJ+pXtKocM+7WC/LFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N48zljBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F47CC433C7;
	Fri,  9 Feb 2024 07:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707464667;
	bh=8hPt35qwRNiqM7E/NAuVeN0iulCZTDSGB64rom1/iK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N48zljBWfUubIvX0MUYFWqfl6rPsb78Iuq4D7JxpYeP9qvXRrk9pFVtNPG958TxfD
	 +vGODzAaCy9jcR4gPg1qmPA15BPf6wFA1xdT5H25LeaBRe4aD063S5dFXGsk3rZZfp
	 nRlF1gZUVVVtRlWxmBz7Rjw7hKnnYP8oABe1jzw4EDkUfsz8BFIyGR+icMYChdCF4L
	 /JN4H7lRm7ANC4HrekEzSRn2UQVpOItwAbDsu0jIJeeUTlMaFjs3IxENEcKftob8XX
	 Lashwuzy8nHlTM24X8G9km4JhTVHVJk67i7e6QiRQFF/8fdfRZBDuhx5P8/B9mW0MV
	 idTp1kr45CINA==
Message-ID: <7c2c7925-b21c-4861-81a7-d49f39a85e29@kernel.org>
Date: Fri, 9 Feb 2024 16:44:22 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
Content-Language: en-US
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
 <20240128-zonefs_nofs-v3-1-ae3b7c8def61@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240128-zonefs_nofs-v3-1-ae3b7c8def61@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 16:52, Johannes Thumshirn wrote:
> Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
> zonefs_zone_mgmt().
> 
> As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
> from a place that can recurse back into the filesystem on memory reclaim,
> it is save to call blkdev_zone_mgmt() with GFP_KERNEL.
> 
> Link: https://lore.kernel.org/all/ZZcgXI46AinlcBDP@casper.infradead.org/
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/zonefs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 93971742613a..63fbac018c04 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
>  
>  	trace_zonefs_zone_mgmt(sb, z, op);
>  	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
> -			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
> +			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
>  	if (ret) {
>  		zonefs_err(sb,
>  			   "Zone management operation %s at %llu failed %d\n",
> 

Given that zonefs_inode_zone_mgmt() which calls zonefs_zone_mgmt() is only used
for sequential zone inodes, and that these inodes cannot be written with
buffered IOs, I think this is safe as we will never have dirty pages to
writeback for reclaim. So there should be no risk of re-entering the FS on
reclaim with GFP_KERNEL.

So:

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


