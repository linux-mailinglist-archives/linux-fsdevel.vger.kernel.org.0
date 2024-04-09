Return-Path: <linux-fsdevel+bounces-16415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C02DE89D24E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 08:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87061C21F7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 06:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990F07D062;
	Tue,  9 Apr 2024 06:22:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995D7CF17;
	Tue,  9 Apr 2024 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643772; cv=none; b=oRMe87zzUtMxzyaQU0IcDFSkWgSJphSGNypQzaUM+ykV5k/ZJOl5Tggj6rhqO0UuMB5Kri1DW7NsZCRlDJ27IonoN60Bk5Z8bIeskOdyGBblBQTNis9xBb88fumBjz5O+WSkfcTfy8QqNXJdxbhZ99Ub9p4TkDfiXdXPCiXvGmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643772; c=relaxed/simple;
	bh=5rARhv3NmHpa1Fdlvzgz/4cyVDMr6pUtaAKtNUhQ6VI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tAa+AG+dWWVH8yJlrnq/b9pVNdCVPoNiB959C2jobFwr9m9doYoposq6w/SFfXHDTl/96uQ1GWb5VXZP96nE2s4/bx4UGg/AfmD9Vl44CF+tztJBr6ULc7nRWLXx9bhaUjepf6pyYwDg/NnAtQny1bE4JLjZV+jmkw8gLSz34Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VDG8n1WXRz4f3jR1;
	Tue,  9 Apr 2024 14:22:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0099B1A0568;
	Tue,  9 Apr 2024 14:22:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxCu3hRmAS0CJg--.44389S3;
	Tue, 09 Apr 2024 14:22:39 +0800 (CST)
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
To: Al Viro <viro@zeniv.linux.org.uk>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240406194206.GC538574@ZenIV> <20240406202947.GD538574@ZenIV>
 <3567de30-a7ce-b639-fa1f-805a8e043e18@huaweicloud.com>
 <20240407015149.GG538574@ZenIV>
 <21d1bfd6-76f7-7ffb-34a4-2a85644674fe@huaweicloud.com>
 <20240407030610.GI538574@ZenIV>
 <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
 <20240409042643.GP538574@ZenIV>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <49f99e7b-3983-8074-bb09-4b093c1269d1@huaweicloud.com>
Date: Tue, 9 Apr 2024 14:22:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240409042643.GP538574@ZenIV>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxCu3hRmAS0CJg--.44389S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4kWw4rCF4rGrWkKw1rWFg_yoW5GFWkpF
	ZxKFWqkr4DGry8KrZ2vw43ZF1ayw13A3y5Ca4rW3sIkrZ0gw1IgFWxGr45uF98ur4kWr12
	qrWagrZ0gry5A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

在 2024/04/09 12:26, Al Viro 写道:
> On Sun, Apr 07, 2024 at 11:21:56AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/04/07 11:06, Al Viro 写道:
>>> On Sun, Apr 07, 2024 at 10:34:56AM +0800, Yu Kuai wrote:
>>>
>>>> Other than raw block_device fops, other filesystems can use the opened
>>>> bdev_file directly for iomap and buffer_head, and they actually don't
>>>> need to reference block_device anymore. The point here is that whether
>>>
>>> What do you mean, "reference"?  The counting reference is to opened
>>> file; ->s_bdev is a cached pointer to associated struct block_device,
>>> and neither it nor pointers in buffer_head are valid past the moment
>>> when you close the file.  Storing (non-counting) pointers to struct
>>> file in struct buffer_head is not different in that respect - they
>>> are *still* only valid while the "master" reference is held.
>>>
>>> Again, what's the point of storing struct file * in struct buffer_head
>>> or struct iomap?  In any instances of those structures?
>>
>> Perhaps this is what you missed, like the title of this set, in order to
>> remove direct acceess of bdev->bd_inode from fs/buffer, we must store
>> bdev_file in buffer_head and iomap, and 'bdev->bd_inode' is replaced
>> with 'file_inode(bdev)' now.
> 
> BTW, what does that have to do with iomap?  All it passes ->bdev to is
> 	1) bio_alloc()
> 	2) bio_alloc_bioset()
> 	3) bio_init()
> 	4) bdev_logical_block_size()
> 	5) bdev_iter_is_aligned()
> 	6) bdev_fua()
> 	7) bdev_write_cache()
> 
> None of those goes anywhere near fs/buffer.c or uses ->bd_inode, AFAICS.
> 
> Again, what's the point?  It feels like you are trying to replace *all*
> uses of struct block_device with struct file, just because.
> 
> If that's what's going on, please don't.  Using struct file instead
> of that bdev_handle crap - sure, makes perfect sense.  But shoving it
> down into struct bio really, really does not.
> 
> I'd suggest to start with adding ->bd_mapping as the first step and
> converting the places where mapping is all we want to using that.
> Right at the beginning of your series.  Then let's see what gets
> left.

Thanks so much for your advice, in fact, I totally agree with this that
adding a 'bd_mapping' or expose the helper bdev_mapping().

However, I will let Christoph and Jan to make the decision, when they
get time to take a look at this.

Thanks!
Kuai

> 
> And leave ->bd_inode there for now; don't blindly replace it with
> ->bd_mapping->host everywhere.  It's much easier to grep for.
> The point of the exercise is to find what do we really need ->bd_inode
> for and what primitives are missing, not getting rid of a bad word...
> .
> 


