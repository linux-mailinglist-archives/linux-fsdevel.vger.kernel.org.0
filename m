Return-Path: <linux-fsdevel+bounces-16303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4489ADD6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 03:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE97C2824A5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 01:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C01103;
	Sun,  7 Apr 2024 01:18:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC62A34;
	Sun,  7 Apr 2024 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712452714; cv=none; b=DwXvxssszavq3jmtZIiQlXG1tqMT5dVF2mro45vQrAeoXaV6Z+kpAH5IPzLbxP1oHyfAj0rse+M7BuS3eYitcME9a76cZKt3U3iCy+sYSTZvj4MX1IbDV6zx4piDZzJcMQHoK7ZKjZXyCnxZDg101Es9HRcbxEa6uilPD8MQDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712452714; c=relaxed/simple;
	bh=yo0V0OqQ2hLnneGNmwTZyEIXc3U09jfJ3vOcHbJt8ps=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UQyA7WF+xULVfDBNJvvxkan9JWHdbtn0h2/m1hmCVpbVil9LeWlzvmnLjehDT8dcXYJ8eqScAffJPASl+kLVDFkIPLvzRTQyaMfOVtuS4zQFwqrS2VWPMRqAH4A10rstlovnmf5V6TEtO+oCIixbyj2DYqtXaI8knvoFXIYTjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBvVd6rbhz4f3jpk;
	Sun,  7 Apr 2024 09:18:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 49AB31A0A1F;
	Sun,  7 Apr 2024 09:18:22 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g5c9BFmYvUvJQ--.14156S3;
	Sun, 07 Apr 2024 09:18:22 +0800 (CST)
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
To: Al Viro <viro@zeniv.linux.org.uk>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV> <20240406202947.GD538574@ZenIV>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
Date: Sun, 7 Apr 2024 09:18:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240406202947.GD538574@ZenIV>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g5c9BFmYvUvJQ--.14156S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1DCw45Cw1UtF1UGr4xXrb_yoW8ArWrpF
	WYgFWYkaykCw48Gr4kZw4fJrySk39rJrWUGFnrXr18CrWj9r93WFZ7KF98uFZ5Krs7Xr1v
	vFWYyFykAF4rXw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/07 4:29, Al Viro Ð´µÀ:
> On Sat, Apr 06, 2024 at 08:42:06PM +0100, Al Viro wrote:
>> On Sat, Apr 06, 2024 at 05:09:26PM +0800, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> So that iomap and bffer_head can convert to use bdev_file in following
>>> patches.
>>
>> Let me see if I got it straight.  You introduce dummy struct file instances
>> (no methods, nothing).  The *ONLY* purpose they serve is to correspond to
>> opened instances of struct bdev.  No other use is possible.

Yes, this is the only purpose.
>>
>> You shove them into ->i_private of bdevfs inodes.  Lifetime rules are...
>> odd.
>>
>> In bdev_open() you arrange for such beast to be present.  You never
>> return it anywhere, they only get accessed via ->i_private, exposing
>> it at least to fs/buffer.c.  Reference to those suckers get stored
>> (without grabbing refcount) into buffer_head instances.
>>
>> And all of that is for... what, exactly?
> 
> Put another way, what's the endgame here?  Are you going to try and
> propagate those beasts down into bio_alloc()?  Because if you do not,
> you need to keep struct block_device * around anyway.

Yes, patch 23-26 already do the work to remove the field block_device
and convert to use bdev_file for iomap and buffer_head.

Or maybe you prefer the idea from last version to keep the block_device
field in iomap/buffer_head, and use it for raw block_device fops?

Thanks,
Kuai

> 
> We use ->b_bdev for several things:
> 	* passing to bio_alloc() (quite a few places)
> 	* %pg in debugging printks
> 	* (rare) passing to write_boundary_block().
> 	* (twice) passing to clean_bdev_aliases().
> 	* (once) passing to __find_get_block().
> 	* one irregular use as a key in lookup_bh_lru()
> 
> IDGI...
> .
> 


