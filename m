Return-Path: <linux-fsdevel+bounces-8632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A12839D38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 00:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD8C1F22B69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 23:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240E54F9B;
	Tue, 23 Jan 2024 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msTHDUvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687706FC2;
	Tue, 23 Jan 2024 23:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052671; cv=none; b=Qwl7Snjbfn/sdQnJc/CCSqvwJiih2lESXj6OCNQYtHkVfiP12rk6tATlIIGheyBjicBgV8IVi9X1CmBBRTLQ+1cE7TdazmpFK/QTzRzjvBjRexGKufLQbE+sAPrfLCRjaWF0T7ZdCQi8Xn7kVwHdzqFFmsNSfZR/TL3QyvbEzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052671; c=relaxed/simple;
	bh=5IKCI89izY9q7OnAbvvB4vyI9VWaIqEYhVeW69cwKBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HDLR+mXjSyJKzJmKZHPKQhr/c9kpKLhYSMc1Rwr0izufnJ1zQre8aj/4NgIVSuaRcIbrFYhxV0M6jt3nMMs1O1rpLjp6yPMRKiamDnMet9u2USF86a6dEg6AdUro7karHXi02Z2iahD8wizuAEbKD7CB/rhQs5+0LQlB68ko4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msTHDUvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68F9C433C7;
	Tue, 23 Jan 2024 23:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706052670;
	bh=5IKCI89izY9q7OnAbvvB4vyI9VWaIqEYhVeW69cwKBo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=msTHDUvykvzFCBJnKtqkfMnJkhCV4e1CWKyluOEIj1Qy17EJpTXSHTeb5+mROq8wc
	 RQhoZ8shAfLx5k88DQXJX8bx/UFxML65CH+qDuFsfun+R0Tkz3P7qY1d2LtdEdF7cK
	 +VfPtaqJG4NgOMJiwMlU+9wqG4FVcDhKNvh5WzwN6DWM+BH7uFAjWOWs+jxAaysQb6
	 mtP+GPGpeeLUVX/oW0VjbXqKyXEWl0r+yZ9Fiq7ozko2SMkoqocAjhpq6zfnKDyqqY
	 oFeXFGIDddZpbotoXXZxw/1sKXOG8gM5jeAjiedV5py8EDl4olJY48Vy/4O2c1b0OR
	 FpL2Ka9boi3Rw==
Message-ID: <a08be89b-6825-4559-a909-632f9571d387@kernel.org>
Date: Wed, 24 Jan 2024 08:31:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@lists.linux.dev, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
 <20240123-zonefs_nofs-v1-1-cc0b0308ef25@wdc.com>
 <31e0f796-1c5-b7f8-2f4b-d937770e8d5@redhat.com>
 <ZbBKC3U3/1yPvWDR@dread.disaster.area>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZbBKC3U3/1yPvWDR@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 08:21, Dave Chinner wrote:
> On Tue, Jan 23, 2024 at 09:39:02PM +0100, Mikulas Patocka wrote:
>>
>>
>> On Tue, 23 Jan 2024, Johannes Thumshirn wrote:
>>
>>> Pass GFP_KERNEL instead of GFP_NOFS to the blkdev_zone_mgmt() call in
>>> zonefs_zone_mgmt().
>>>
>>> As as zonefs_zone_mgmt() and zonefs_inode_zone_mgmt() are never called
>>> from a place that can recurse back into the filesystem on memory reclaim,
>>> it is save to call blkdev_zone_mgmt() with GFP_KERNEL.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>  fs/zonefs/super.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
>>> index 93971742613a..63fbac018c04 100644
>>> --- a/fs/zonefs/super.c
>>> +++ b/fs/zonefs/super.c
>>> @@ -113,7 +113,7 @@ static int zonefs_zone_mgmt(struct super_block *sb,
>>>  
>>>  	trace_zonefs_zone_mgmt(sb, z, op);
>>>  	ret = blkdev_zone_mgmt(sb->s_bdev, op, z->z_sector,
>>> -			       z->z_size >> SECTOR_SHIFT, GFP_NOFS);
>>> +			       z->z_size >> SECTOR_SHIFT, GFP_KERNEL);
>>>  	if (ret) {
>>>  		zonefs_err(sb,
>>>  			   "Zone management operation %s at %llu failed %d\n",
>>>
>>> -- 
>>> 2.43.0
>>
>> zonefs_inode_zone_mgmt calls 
>> lockdep_assert_held(&ZONEFS_I(inode)->i_truncate_mutex); - so, this 
>> function is called with the mutex held - could it happen that the 
>> GFP_KERNEL allocation recurses into the filesystem and attempts to take 
>> i_truncate_mutex as well?
>>
>> i.e. GFP_KERNEL -> iomap_do_writepage -> zonefs_write_map_blocks -> 
>> zonefs_write_iomap_begin -> mutex_lock(&zi->i_truncate_mutex)
> 
> zonefs doesn't have a ->writepage method, so writeback can't be
> called from memory reclaim like this.

And also, buffered writes are allowed only for conventional zone files, for
which we never do zone management. For sequential zone files which may have
there zone managed with blkdev_zone_mgmt(), only direct writes are allowed.

> 
> -Dave.

-- 
Damien Le Moal
Western Digital Research


