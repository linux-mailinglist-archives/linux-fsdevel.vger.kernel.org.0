Return-Path: <linux-fsdevel+bounces-9467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34CD8416C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 00:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCA01F2429F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 23:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9A15B2E4;
	Mon, 29 Jan 2024 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm5vgGd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431A15B10E;
	Mon, 29 Jan 2024 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706570735; cv=none; b=DdGFcFaSitVg0CFk1TaD9guK6jweLdmXjkDGBuyi6bQF7XRzc4bbghVD5wvFdzOfDcbeDeOU3IYOKuAS1Bo1DGSUf/k+qZrdEnGXk4xYzTQPuxyFT9wDQdzZsYgpTVc6xHQ0sX9THB+pySKNoNoAY7K+10f0j7dFBdRkgp2VVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706570735; c=relaxed/simple;
	bh=rlXD8wrR7LGaE3yPipo4oss7yBMRHRL+ZqlHjIj2kt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R51wLmC5sbzyflpHWnnkqyZWC3VVXbPufEobH8x+9Zm1VjLsD0dwTTKBrSnWFAFfzGwQSromofgG00iQJ9TSJh0RNN5uqgEXBZ7JDVplM3ZxVCF1ct2C08cUVQt0pNdM4zO3mqjhPz0xrYFmN+OV/AYYxhe7ByF8T9vFSj/+Mfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm5vgGd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4E9C433F1;
	Mon, 29 Jan 2024 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706570735;
	bh=rlXD8wrR7LGaE3yPipo4oss7yBMRHRL+ZqlHjIj2kt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bm5vgGd8iLgqVAS89ky5CprUejORrrO+L2Fm2jCGiGp9VUCRfnTu3zsHrnPsqtld/
	 GxZX0GpHfKiJtELlkp//qvfy+Iumzg2up1xNCtSSH96om1ftwi/oHPyzuNe8oZQdPS
	 FVh7JCk3yR8dHonw8oFafOdyX2eu5cEadJF1NwFhWQTA3YD9WIjfeTfBKqWjttbUp2
	 yZwdUq0oPF2A/f8W0vp7FkRZXx5Sc+i3DX+NXwp/mcouZV/6Az6J2ugDuWlE9EDosr
	 LuWkKwPhPn4vaMObQ6+6Y8YPEZepYVK7x5GzIQFzGSW6U4iJcePs0HWzVO/oxRMOUT
	 m5ciZiseX3ZIQ==
Message-ID: <6f0aed31-b9a9-4655-9c8c-839f978b40d9@kernel.org>
Date: Tue, 30 Jan 2024 08:25:31 +0900
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

s/save/safe

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

I think this is OK but I will need a little more time to fully convince myself.
So let me look again at the code to check all the calls contexts.

-- 
Damien Le Moal
Western Digital Research


