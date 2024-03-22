Return-Path: <linux-fsdevel+bounces-15061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F06C886756
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 08:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295CB285D02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 07:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5B11713;
	Fri, 22 Mar 2024 07:09:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1DB10A25;
	Fri, 22 Mar 2024 07:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711091386; cv=none; b=MwxquYda7LmqcpTEqGKH7n02FqJ6dgYSwQvgWuseVTDRzU3+F+QMis2WzYQv32wt8q6Do4JDAHvqHIiyb6CaJPq0zmghpYvbszc8547oCCsjRr4xb1VQX+/zfCl8V9kBxhnLn/aitFvI453F29t0KHlGWqriL0tRuVjKsWQBPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711091386; c=relaxed/simple;
	bh=EXf4W3NnwLH9Ann9P4fCEu48sBUVafwEXvWrQKtHX+Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DbgD2Rod2nIs9k92DKU2FiijVElBtA1JDFOpBMCNCRQuH79KJ6Bpxez89dtEb1IuZpPqWjlfDMmlvWG/qrd6Fyc+68oJwG4RJZ0xVUxR5SgVyz2kpg52STtPe8KXw7j2vg4DOdIi+jIPYou44M4XF/v4UJih3INSpMitrriNsgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V1D3B31Qpz4f3khx;
	Fri, 22 Mar 2024 15:09:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 77A4C1A019F;
	Fri, 22 Mar 2024 15:09:32 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g6qLv1lOezbHg--.36054S3;
	Fri, 22 Mar 2024 15:09:32 +0800 (CST)
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
To: Al Viro <viro@zeniv.linux.org.uk>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, jack@suse.cz, brauner@kernel.org,
 axboe@kernel.dk, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-20-yukuai1@huaweicloud.com>
 <20240317213847.GD10665@lst.de>
 <022204e6-c387-b4b2-5982-970fd1ed5b5b@huaweicloud.com>
 <20240318013208.GA23711@lst.de>
 <5c231b60-a2bf-383e-e641-371e7e57da67@huaweicloud.com>
 <ea4774db-188e-6744-6a5b-0096f6206112@huaweicloud.com>
 <20240318232245.GA17831@lst.de>
 <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
 <20240322063346.GB3404528@ZenIV>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6f784f43-068b-12c0-e3ff-56dbc09420e8@huaweicloud.com>
Date: Fri, 22 Mar 2024 15:09:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240322063346.GB3404528@ZenIV>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g6qLv1lOezbHg--.36054S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykuF4UXry7Xw1fAF1kZrb_yoW8tF15pF
	Z5JFZ5Kr4kGryqyrsFvF17Xw1Yyw1xtF1UZwn8ZryrA39IvrySgFWFgr15ur10kws5Ar1v
	vr1jg3y5Jw45CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

ÔÚ 2024/03/22 14:33, Al Viro Ð´µÀ:
> On Tue, Mar 19, 2024 at 04:26:19PM +0800, Yu Kuai wrote:
> 
>> +void put_bdev_file(struct block_device *bdev)
>> +{
>> +       struct file *file = NULL;
>> +       struct inode *bd_inode = bdev_inode(bdev);
>> +
>> +       mutex_lock(&bdev->bd_disk->open_mutex);
>> +       file = bd_inode->i_private;
>> +
>> +       if (!atomic_read(&bdev->bd_openers))
>> +               bd_inode->i_private = NULL;
>> +
>> +       mutex_unlock(&bdev->bd_disk->open_mutex);
>> +
>> +       fput(file);
>> +}
> 
> Locking is completely wrong here.  The only thing that protects
> ->bd_openers is ->open_mutex.  atomic_read() is obviously a red
> herring.

I'm lost here, in get_bdev_file() and put_bdev_file(), I grabbed
'open_mutex' to protect reading 'bd_openers', reading and setting
'bd_inode->i_private'.
> 
> Suppose another thread has already opened the same sucker
> with bdev_file_open_by_dev().
> 
> Now you are doing the same thing, just as the other guy is
> getting to bdev_release() call.
> 
> The thing is, between your get_bdev_file() and increment of ->bd_openers
> (in bdev_open()) there's a window when bdev_release() of the old file
> could've gotten all the way through the decrement of ->bd_openers
> (to 0, since our increment has not happened yet) and through the
> call of put_bdev_file(), which ends up clearing ->i_private.
> 
> End result:
> 
> * old ->i_private leaked (already grabbed by your get_bdev_file())
> * ->bd_openers at 1 (after your bdev_open() gets through)
> * ->i_private left NULL.
> 
Yes, I got you now. The problem is this patch is that:

1) opener 1, set bdev_file, bd_openers is 1
2) opener 2, before bdev_open(), get bdev_file,
3) close 1, bd_openers is 0, clear bdev_file
4) opener 2, after bdev_open(), bdev_file is cleared unexpected.

> Christoph, could we please get rid of that atomic_t nonsense?
> It only confuses people into brainos like that.  It really
> needs ->open_mutex for any kind of atomicity.

While we're here, which way should we move forward?
1. keep the behavior to use bdev for iomap/buffer_head for raw block
ops;
2. record new 'bdev_file' in 'bd_inode->i_private', and use a new way
to handle the concurrent scenario.
3. other possible solution?

Thanks,
Kuai

> 
> .
> 


