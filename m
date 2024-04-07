Return-Path: <linux-fsdevel+bounces-16310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8421E89AE17
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 04:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F831F21CCB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Apr 2024 02:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69D81876;
	Sun,  7 Apr 2024 02:37:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FA368;
	Sun,  7 Apr 2024 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712457436; cv=none; b=QjJ/0Djom9b64gFM73YZMTuvqz0KfiWpCjbOmXAyWqsYAlZ0o4yztOfyqP/WgzpW40GHhtLIvmRnpTEe5vpyjUCKeA+BV9rGYTfwgspmQOL5rBQeVjurHAh1jhUJY9xUNm1c50QFb1GrPOXBDdkwL54m7Ci2c1weYEmQusFQNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712457436; c=relaxed/simple;
	bh=JTX3bajuxlEJLfm3k+IU8/2q1JwcvZhj9x9aaodSxxA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=atH+6j1xmuWhqeYQ00+fj6AEFneHA3zCynZI+JzIpG35EiTW9ibA726kM/39TIPwHAf7keO0undh5RgDIGM0VAxiJ2gYzOtEF7j/NiE//+LyaDIT1iEyvv3cMyGKefgzHE19k3RY5TbYM0IvZdg8GQP3F/vEcR6aAxZeBJuSSSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VBxFY3sZjz4f3jkD;
	Sun,  7 Apr 2024 10:37:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D725F1A0172;
	Sun,  7 Apr 2024 10:37:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RHVBhJmk6M1JQ--.44469S3;
	Sun, 07 Apr 2024 10:37:09 +0800 (CST)
Subject: Re: [PATCH vfs.all 04/26] block: prevent direct access of bd_inode
To: Al Viro <viro@zeniv.linux.org.uk>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-5-yukuai1@huaweicloud.com>
 <20240407022250.GH538574@ZenIV>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <45c32706-b599-d968-4bff-4ad8f0768275@huaweicloud.com>
Date: Sun, 7 Apr 2024 10:37:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240407022250.GH538574@ZenIV>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RHVBhJmk6M1JQ--.44469S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr17WFWxZFWxAr13uF4rXwb_yoW8GFyUpr
	4UGFW5Cr45XryFgF40vw42vFnIgF17KrW8Z34fJ3WFy3yDtw1vgFy8Cry7AFW7XrykKF4I
	qF4YyrW8ury7CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWU
	JwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUF9a9DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/04/07 10:22, Al Viro Ð´µÀ:
> On Sat, Apr 06, 2024 at 05:09:08PM +0800, Yu Kuai wrote:
>> @@ -669,7 +669,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>   {
>>   	struct file *file = iocb->ki_filp;
>>   	struct block_device *bdev = I_BDEV(file->f_mapping->host);
>> -	struct inode *bd_inode = bdev->bd_inode;
>> +	struct inode *bd_inode = bdev_inode(bdev);
> 
> What you want here is this:
> 
> 	struct inode *bd_inode = file->f_mapping->host;
> 	struct block_device *bdev = I_BDEV(bd_inode);

Yes, this way is better, logically.
> 
> 
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -97,7 +97,7 @@ static int blk_ioctl_discard(struct block_device *bdev, blk_mode_t mode,
>>   {
>>   	uint64_t range[2];
>>   	uint64_t start, len;
>> -	struct inode *inode = bdev->bd_inode;
>> +	struct inode *inode = bdev_inode(bdev);
>>   	int err;
> 
> The uses of 'inode' in this function are
>          filemap_invalidate_lock(inode->i_mapping);
> and
>          filemap_invalidate_unlock(inode->i_mapping);
> 
> IOW, you want bdev_mapping(bdev), not bdev_inode(bdev).
> 
>> @@ -166,7 +166,7 @@ static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
>>   {
>>   	uint64_t range[2];
>>   	uint64_t start, end, len;
>> -	struct inode *inode = bdev->bd_inode;
>> +	struct inode *inode = bdev_inode(bdev);
> 
> Same story.

Yes.

Thanks for the suggestions!
Kuai

> .
> 


