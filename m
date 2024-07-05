Return-Path: <linux-fsdevel+bounces-23176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B47927F46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 02:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104EA2830AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 00:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16751FBB;
	Fri,  5 Jul 2024 00:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+I+DgSs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917A18D;
	Fri,  5 Jul 2024 00:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720138389; cv=none; b=omzS4A4Jrw0ZQo6Fr341brmxfz3PtzMjBqHVFcfbNVj02/Wti0cj8Lh2lV9syoODRB+yLeNywEcov91KAYub+ymYCG/9rG30cUEMswEFU7EHquMxgCWjo3xzpdLSRAE40MC3m0XP3e3oJlRAyOnxByEFmfdXDCNAUThWoMqnxr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720138389; c=relaxed/simple;
	bh=/x2so69rPNKLWYz+x3ROF/ISz3M+ZqXy/UOlggfPEVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbMYvZf7cVRCB7QM5tKUK+2VK+YdUZQEjwWkuOd7O7BLnh5nBh92+xbOJOCsKIK5TJ/y1pVG8QxNzHsiQXyRBoqQ6ZBzEvLta9+gkseVnGRsd8uwQ/vSJiNPxLEisihuJOual7xA7m53ggMtUPYGOu4ifcLp9DRPF95zQFbqx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+I+DgSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B2CC4AF0B;
	Fri,  5 Jul 2024 00:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720138388;
	bh=/x2so69rPNKLWYz+x3ROF/ISz3M+ZqXy/UOlggfPEVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H+I+DgSsOlrDFwT2M8NvZatKKRu8/CGGJDf4hQO9Lb97WBwpNI9qoErPiaTIa9W7s
	 z7F0Gu0VAyv6KjMxlKEBMVwrCMAwMCjW4eDg8PngZP4BwYX4Q5dA8yuCS2470GhBuI
	 IGJ5AiIRPbEP5t8KEWim0H8B/srWsPQFocJhhevMsPwb7SSqtLGZ8GpMA5GJIFtGna
	 LLanA9CgXWvYr+nSAfPUPL/WllUBFdhCPcBdRUvaBdPK9VO0bxDS4SjMDvdrUsUJEQ
	 bWB6+rRC7LxC7MDn+jbKMQVRBRPZHZzJ6h/O/VyOxIR/f4KGH6hDJYML8pnWNRqMMn
	 fKP5QKIS2DL3Q==
Message-ID: <54a30f2a-99f5-486a-9d9d-d8e2b1007c6c@kernel.org>
Date: Fri, 5 Jul 2024 09:13:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Non-power-of-2 zone size
To: Mikulas Patocka <mpatocka@redhat.com>, Li Dong <lidong@vivo.com>,
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 "open list:DEVICE-MAPPER (LVM)" <dm-devel@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
References: <20240704151549.1365-1-lidong@vivo.com>
 <cd05398-cffa-f4ca-2ac3-74433be2316c@redhat.com>
 <c4ee654e-3120-e1a9-80b6-cb7073aa5c1a@redhat.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <c4ee654e-3120-e1a9-80b6-cb7073aa5c1a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/24 04:00, Mikulas Patocka wrote:
> 
> 
>> On Thu, 4 Jul 2024, Li Dong wrote:
>>
>>> For zone block devices, device_area_is_invalid may return an incorrect 
>>> value.
>>>
>>> Failure log:
>>> [   19.337657]: device-mapper: table: 254:56: len=836960256 not aligned to
>>> h/w zone size 3244032 of sde
>>> [   19.337665]: device-mapper: core: Cannot calculate initial queue limits
>>> [   19.337667]: device-mapper: ioctl: unable to set up device queue for 
>>> new table.
>>>
>>> Actually, the device's zone length is aligned to the zonesize.
>>>
>>> Fixes: 5dea271b6d87 ("dm table: pass correct dev area size to device_area_is_valid")
>>> Signed-off-by: Li Dong <lidong@vivo.com>
>>> ---
>>>  drivers/md/dm-table.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
>>> index 33b7a1844ed4..0bddae0bee3c 100644
>>> --- a/drivers/md/dm-table.c
>>> +++ b/drivers/md/dm-table.c
>>> @@ -257,7 +257,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  	if (bdev_is_zoned(bdev)) {
>>>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>>>  
>>> -		if (start & (zone_sectors - 1)) {
>>> +		if (start % zone_sectors) {
>>>  			DMERR("%s: start=%llu not aligned to h/w zone size %u of %pg",
>>>  			      dm_device_name(ti->table->md),
>>>  			      (unsigned long long)start,
>>> @@ -274,7 +274,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  		 * devices do not end up with a smaller zone in the middle of
>>>  		 * the sector range.
>>>  		 */
>>> -		if (len & (zone_sectors - 1)) {
>>> +		if (len % zone_sectors) {
>>>  			DMERR("%s: len=%llu not aligned to h/w zone size %u of %pg",
>>>  			      dm_device_name(ti->table->md),
>>>  			      (unsigned long long)len,
>>> -- 
>>> 2.31.1.windows.1
> 
> I grepped the kernel for bdev_zone_sectors and there are more assumptions 
> that bdev_zone_sectors is a power of 2.
> 
> drivers/md/dm-zone.c:           sector_t mask = bdev_zone_sectors(disk->part0) - 1
> drivers/nvme/target/zns.c:      if (get_capacity(bd_disk) & (bdev_zone_sectors(ns->bdev) - 1))
> drivers/nvme/target/zns.c:      if (sect & (bdev_zone_sectors(req->ns->bdev) - 1)) {
> fs/zonefs/super.c:      sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
> fs/btrfs/zoned.c:       return (sector_t)zone_number << ilog2(bdev_zone_sectors(bdev));
> fs/btrfs/zoned.c:	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
> include/linux/blkdev.h: return sector & (bdev_zone_sectors(bdev) - 1);
> fs/f2fs/super.c:	if (nr_sectors & (zone_sectors - 1))
> 
> So, if we want to support non-power-of-2 zone size, we need some 
> systematic fix. Now it appears that Linux doesn't even attempt to support 
> disks non-power-of-2 zone size.

Correct. We currently do not support zoned devices with a zone size that is not
a power of 2 number of LBAs. Such drives are rejected by the block layer. So I
am surprised that Li could even reach a DM error. It means that his kernel was
already patched to accept zoned drives with a zone size that is not a power of 2.

> I added Damien Le Moal so that he can help with testing disks with 
> non-power-of-2 zone size (if WD is actually making them).

No, I do not have such drive. The vast majority of zoned device users today are
SMR HDD users, and in that space, no one wants a non power of 2 zone size drive.
As far as I know, the main push is from zoned-UFS users for Android, as Pankaj
mentioned.

As you rightly guessed, and as Pankaj confirmed, supporting non power of 2 zone
size drives requires a lot more changes than just the fix Li sent for DM. Pankaj
initial patch set that did not make it upstream (but is in Android) would need
to be reworked given the extensive changes that happened since then (zone write
locking replaced with zone write plugging, queue limits changes, etc).

-- 
Damien Le Moal
Western Digital Research


