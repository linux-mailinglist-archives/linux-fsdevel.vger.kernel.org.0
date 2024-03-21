Return-Path: <linux-fsdevel+bounces-14965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A98858E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D5DB2240F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 12:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837537603D;
	Thu, 21 Mar 2024 12:15:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815C58232;
	Thu, 21 Mar 2024 12:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023315; cv=none; b=iALvGp2zKy15zNFGInmabJG/mXYRC9G+h+yQd+l+L0pIcUZlyb/fSdf7OgKA4VZUYFXN2Bnx/qxyEo1y+rytUBEyaPjWe4h3JAUjTwF05fzBJ9rfPMhF8K8rFVazakrShaj0IDO0BNjK/ErLcCB91jyuMrKbp5npxcamWaYfuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023315; c=relaxed/simple;
	bh=DAh40+uz6rrjbgwmew9a6AMozhKZLl/upM31no81vHI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=db9vcm0Z5gqqFzp4XqFiuHQhpd97uzOstZJs4c1COZvDbhcXQfqIbZvOZYf50P7QQ5bJF//DadoDO6p+nOa8PsODDFFxcvxGv2LSxfYWU2ZvmqAnDq+7ZK35l4hmBkBi+PBWagb57HFRIvrlwpopyqU0hBQtupL3OTfGBBq9JWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V0ktJ4zhkz4f3kq2;
	Thu, 21 Mar 2024 20:15:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8F21E1A0172;
	Thu, 21 Mar 2024 20:15:08 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBHZQ7KJPxlrKiKHg--.63152S3;
	Thu, 21 Mar 2024 20:15:08 +0800 (CST)
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
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
 <20240321112737.33xuxfttrahtvbej@quack3>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <240b78df-257e-a97c-31ff-a8b1b1882e80@huaweicloud.com>
Date: Thu, 21 Mar 2024 20:15:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240321112737.33xuxfttrahtvbej@quack3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHZQ7KJPxlrKiKHg--.63152S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4xWFW5ur15Gw1xXFW7twb_yoWrJrWUpF
	Z8JFWYyF48GryqgFs2qwsrXr1Fk3WUtrW8Z348Wa4rCrWqyrna9Fy8GF1Yka4Yvr4kGr4q
	vr1jgry3urySk3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
	3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jan!

在 2024/03/21 19:27, Jan Kara 写道:
> Hello!
> 
> On Tue 19-03-24 16:26:19, Yu Kuai wrote:
>> 在 2024/03/19 7:22, Christoph Hellwig 写道:
>>> On Mon, Mar 18, 2024 at 03:19:03PM +0800, Yu Kuai wrote:
>>>> I come up with an ideal:
>>>>
>>>> While opening the block_device the first time, store the generated new
>>>> file in "bd_inode->i_private". And release it after the last opener
>>>> close the block_device.
>>>>
>>>> The advantages are:
>>>>    - multiple openers can share the same bdev_file;
>>>>    - raw block device ops can use the bdev_file as well, and there is no
>>>> need to distinguish iomap/buffer_head for raw block_device;
>>>>
>>>> Please let me know what do you think?
>>>
>>> That does sound very reasonable to me.
>>>
>> I just implement the ideal with following patch(not fully tested, just
>> boot and some blktests)
> 
> So I was looking into this and I'm not sure I 100% understand the problem.
> I understand that the inode you get e.g. in blkdev_get_block(),
> blkdev_iomap_begin() etc. may be an arbitrary filesystem block device
> inode. But why can't you use I_BDEV(inode->i_mapping->host) to get to the
> block device instead of your file_bdev(inode->i_private)? I don't see any
> advantage in stashing away that special bdev_file into inode->i_private but
> perhaps I'm missing something...
> 

Because we're goning to remove the 'block_device' from iomap and
buffer_head, and replace it with a 'bdev_file'.

patch 19 from this set is using a union of block_device and bdev_file,
this can work as well.

Thanks,
Kuai

> 								Honza
> 
>> diff --git a/block/fops.c b/block/fops.c
>> index 4037ae72a919..059f6c7d3c09 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -382,7 +382,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb,
>> struct iov_iter *iter)
>>   static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t
>> length,
>>                  unsigned int flags, struct iomap *iomap, struct iomap
>> *srcmap)
>>   {
>> -       struct block_device *bdev = I_BDEV(inode);
>> +       struct block_device *bdev = file_bdev(inode->i_private);
>>          loff_t isize = i_size_read(inode);
>>
>>          iomap->bdev = bdev;
>> @@ -404,7 +404,7 @@ static const struct iomap_ops blkdev_iomap_ops = {
>>   static int blkdev_get_block(struct inode *inode, sector_t iblock,
>>                  struct buffer_head *bh, int create)
>>   {
>> -       bh->b_bdev = I_BDEV(inode);
>> +       bh->b_bdev = file_bdev(inode->i_private);
>>          bh->b_blocknr = iblock;
>>          set_buffer_mapped(bh);
>>          return 0;
>> @@ -598,6 +598,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
>>
>>   static int blkdev_open(struct inode *inode, struct file *filp)
>>   {
>> +       struct file *bdev_file;
>>          struct block_device *bdev;
>>          blk_mode_t mode;
>>          int ret;
>> @@ -614,9 +615,28 @@ static int blkdev_open(struct inode *inode, struct file
>> *filp)
>>          if (!bdev)
>>                  return -ENXIO;
>>
>> +       bdev_file = alloc_and_init_bdev_file(bdev,
>> +                       BLK_OPEN_READ | BLK_OPEN_WRITE, NULL);
>> +       if (IS_ERR(bdev_file)) {
>> +               blkdev_put_no_open(bdev);
>> +               return PTR_ERR(bdev_file);
>> +       }
>> +
>> +       bdev_file->private_data = ERR_PTR(-EINVAL);
>> +       get_bdev_file(bdev, bdev_file);
>>          ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
>> -       if (ret)
>> +       if (ret) {
>> +               put_bdev_file(bdev);
>>                  blkdev_put_no_open(bdev);
>> +       } else {
>> +               filp->f_flags |= O_LARGEFILE;
>> +               filp->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
>> +               if (bdev_nowait(bdev))
>> +                       filp->f_mode |= FMODE_NOWAIT;
>> +               filp->f_mapping = bdev_mapping(bdev);
>> +               filp->f_wb_err =
>> filemap_sample_wb_err(bdev_file->f_mapping);
>> +       }
>> +
>>          return ret;
>>   }
>>
>>> .
>>>
>>


