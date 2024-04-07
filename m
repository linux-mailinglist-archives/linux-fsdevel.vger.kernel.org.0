Return-Path: <linux-fsdevel+bounces-16314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9E489AE46
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 05:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5EC2827F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3237C5223;
	Sun,  7 Apr 2024 03:22:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D971849;
	Sun,  7 Apr 2024 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712460127; cv=none; b=aOf9FUNUG7H2Kp/PCzNk4O7ryAE1mDMxWJNrPCABN2uKVjXpPdahgSP+dGZMaTG3+L0UojcHB9lL/M2Uct/xY4SUbQVAgHPH+RpH9G7GTnEjIJ73RfiMvt27p2h8ycfIE7nsUpdUnoLIXAGyHhL2pZYjCzlWe5nGLe8ZOJrfHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712460127; c=relaxed/simple;
	bh=gBXysK6vcQmGEr7lzAailCqaQeryrg2p6T97a2m3cpw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nBWUSIWQgaDhe9oa7PMsBebYvsWlTq+X0m7v1QJzd0gxwJJw9Nq0t1EpRXX61w3of0igtnih99F3VIwVIulKqfgdan8i4bJnHrREbnvJAJTNE/iMz1azjpnEK7pujdx3FyHfou8Y+bRTo3TrnJd4pq9i5cXvhT4Qu/95GcJZaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VByFJ34Cnz4f3kq9;
	Sun,  7 Apr 2024 11:21:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BC6621A058D;
	Sun,  7 Apr 2024 11:22:00 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBFUERJmH9s4JQ--.22949S3;
	Sun, 07 Apr 2024 11:21:58 +0800 (CST)
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8f414bc5-44c6-fe71-4d04-6aef3de8c5e3@huaweicloud.com>
Date: Sun, 7 Apr 2024 11:21:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240407030610.GI538574@ZenIV>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBFUERJmH9s4JQ--.22949S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4rtrWDtFyrKr15KFyUZFb_yoW5JrW5pr
	ZxKFyDKrn8Gry8Kws29w43ZrWYyw18Ar15Cw1xJ3sY9rWYgr92qFW0gF45uFn0vrZ7Gry2
	qr4agrW8KrZ8C3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

ÔÚ 2024/04/07 11:06, Al Viro Ð´µÀ:
> On Sun, Apr 07, 2024 at 10:34:56AM +0800, Yu Kuai wrote:
> 
>> Other than raw block_device fops, other filesystems can use the opened
>> bdev_file directly for iomap and buffer_head, and they actually don't
>> need to reference block_device anymore. The point here is that whether
> 
> What do you mean, "reference"?  The counting reference is to opened
> file; ->s_bdev is a cached pointer to associated struct block_device,
> and neither it nor pointers in buffer_head are valid past the moment
> when you close the file.  Storing (non-counting) pointers to struct
> file in struct buffer_head is not different in that respect - they
> are *still* only valid while the "master" reference is held.
> 
> Again, what's the point of storing struct file * in struct buffer_head
> or struct iomap?  In any instances of those structures?

Perhaps this is what you missed, like the title of this set, in order to
remove direct acceess of bdev->bd_inode from fs/buffer, we must store
bdev_file in buffer_head and iomap, and 'bdev->bd_inode' is replaced
with 'file_inode(bdev)' now.

Some history of previous discussions:

[1] https://lore.kernel.org/all/ZWRDeQ4K8BiYnV+X@infradead.org/
[2] 
https://lore.kernel.org/all/28237ec3-c3c1-1f0c-5250-04a88845d4a6@huaweicloud.com/
[3] 
https://lore.kernel.org/all/20240129-vfs-bdev-file-bd_inode-v1-0-42eb9eea96cf@kernel.org/

Thanks,
Kuai

> 
> There is a good reason to have it in places that keep a reference to
> opened block device - the kind that _keeps_ the device opened.  Namely,
> there's state that need to be carried from the place where we'd opened
> the sucker to the place where we close it, and that state is better
> carried by opened file.
> 
> But neither iomap nor buffer_head contain anything of that sort -
> the lifetime management of the opened device is not in their
> competence.  As the matter of fact, the logics around closing
> those opened devices (bdev_release()) makes sure that no
> instances of buffer_head (or iomap) will outlive them.
> And they don't care about any extra state - everything
> they use is in block_device and coallocated inode.
> 
> I could've easily missed something in one of the threads around
> the earlier iterations of the patchset; if that's the case,
> could somebody restate the rationale for that part and/or
> post relevant lore.kernel.org links?  Christian?  hch?
> What am I missing here?
> .
> 


