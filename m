Return-Path: <linux-fsdevel+bounces-16759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765D58A2352
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 03:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160791F2316B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 01:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9625C82;
	Fri, 12 Apr 2024 01:38:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BDF2F2D;
	Fri, 12 Apr 2024 01:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885905; cv=none; b=t+zkLTfZIuhdIJIsb4KXnZRkze08W/sQ+A/2lQTbzNcJ8BZqBLgRBjAfKmdU1XYjwZfSB1CF/ZSZNh8QqzhOJpQz+pzO2S3kGXXXsORHxNUs1HcEBzDRfd2hzF79Oz6AZq3vAcsKi7M+bv40yiJHI/+OVvRir8NPV+9D8VIbgYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885905; c=relaxed/simple;
	bh=5IEtu+qNRVlRpBTHOIA9G3EqlubXv7MitXSrPARbmAU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Wg0ebuOx6vm9FbsuCii344BPz8f3dnxM6zYim0NTg13g2KlPEc6NkPmYQkOsxwcJEWj3oWkt6rWYI1Q0B6wxM2OUxOF89RneFDBVFaPUoW5sZBgcsFIeK1JSu3/8wGHQC1ZrnDGJlBhY/FoycT6YTEizZnTKzz68IaXt2H8EqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VFzjJ5cNkz4f3jJK;
	Fri, 12 Apr 2024 09:38:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id ACB111A0175;
	Fri, 12 Apr 2024 09:38:19 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g6IkBhmPNn_Jg--.44042S3;
	Fri, 12 Apr 2024 09:38:18 +0800 (CST)
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de,
 axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
 <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
 <20240410105911.hfxz4qh3n5ekrpqg@quack3> <20240410223443.GG2118490@ZenIV>
 <20240411-logik-besorgen-b7d590d6c1e9@brauner>
 <20240411140409.GH2118490@ZenIV> <20240411144930.GI2118490@ZenIV>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <d89916c0-6220-449e-ff5f-f299fd4a1483@huaweicloud.com>
Date: Fri, 12 Apr 2024 09:38:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240411144930.GI2118490@ZenIV>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g6IkBhmPNn_Jg--.44042S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw47Cry5ur43Jr1rtr48tFb_yoW5Aw48pF
	W3tasxCr40yry3u3WfuFn7Ka4Fyw4kGay3C34akw1rAr90vFy3tF4kKrWrCFWUXrWxKr4a
	qr17JayDWryUArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
	Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/11 22:49, Al Viro Ð´µÀ:
> On Thu, Apr 11, 2024 at 03:04:09PM +0100, Al Viro wrote:
>>> lot slimmer and we don't need to care about messing with a lot of that
>>> code. I didn't care about making it static inline because that might've
>>> meant we need to move other stuff into the header as well. Imho, it's
>>> not that important but if it's a big deal to any of you just do the
>>> changes on top of it, please.
>>>
>>> Pushed to
>>> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.super
>>>
>>> If I hear no objections that'll show up in -next tomorrow. Al, would be
>>> nice if you could do your changes on top of this, please.
>>
>> Objection: start with adding bdev->bd_mapping, next convert the really
>> obvious instances to it and most of this series becomes not needed at
>> all.
>>
>> Really.  There is no need whatsoever to push struct file down all those
>> paths.
>>

There really is a long history here. The beginning of the attempt to try
removing the filed 'bd_inode' is that I want to make a room from the
first cacheline(64 bytes) for a new 'unsigned long flags' field because
we keep adding new 'bool xxx' field [1]. And adding a new 'bd_mapping'
field will make that impossible.

I do like the idea of passing 'bd_mapping' here, however, will it be
considered to expose bdev_mapping() for slow path, or to pass in bd_file
and get it by 'f_mapping' for fast path? So that a new field in the
first cacheline will still be possible, other than that there will be
more code change, I don't see any difference for performance.

Thanks,
Kuai

[1] 
https://lore.kernel.org/all/20231122103103.1104589-3-yukuai1@huaweicloud.com/
>> And yes, erofs and buffer.c stuff belongs on top of that, no arguments here.
> 
> FWIW, here's what you get if this is done in such order:
> 
> block/bdev.c                           | 31 ++++++++++++++++++++++---------
> block/blk-zoned.c                      |  4 ++--
> block/fops.c                           |  4 ++--
> block/genhd.c                          |  2 +-
> block/ioctl.c                          | 14 ++++++--------
> block/partitions/core.c                |  2 +-
> drivers/md/bcache/super.c              |  2 +-
> drivers/md/dm-vdo/dm-vdo-target.c      |  4 ++--
> drivers/md/dm-vdo/indexer/io-factory.c |  2 +-
> drivers/mtd/devices/block2mtd.c        |  6 ++++--
> drivers/scsi/scsicam.c                 |  2 +-
> fs/bcachefs/util.h                     |  5 -----
> fs/btrfs/disk-io.c                     |  6 +++---
> fs/btrfs/volumes.c                     |  2 +-
> fs/btrfs/zoned.c                       |  2 +-
> fs/buffer.c                            | 10 +++++-----
> fs/cramfs/inode.c                      |  2 +-
> fs/ext4/dir.c                          |  2 +-
> fs/ext4/ext4_jbd2.c                    |  2 +-
> fs/ext4/super.c                        | 24 +++---------------------
> fs/gfs2/glock.c                        |  2 +-
> fs/gfs2/ops_fstype.c                   |  2 +-
> fs/jbd2/journal.c                      |  2 +-
> include/linux/blk_types.h              |  1 +
> include/linux/blkdev.h                 | 12 ++----------
> include/linux/buffer_head.h            |  4 ++--
> include/linux/jbd2.h                   |  4 ++--
> 27 files changed, 69 insertions(+), 86 deletions(-)
> 
> The bulk of the changes is straight replacements of foo->bd_inode->i_mapping
> with foo->bd_mapping.  That's completely mechanical and that takes out most
> of the bd_inode uses.  Anyway, patches in followups
> 
> .
> 


