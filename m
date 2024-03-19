Return-Path: <linux-fsdevel+bounces-14804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6D587F9B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 09:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FC5282FB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 08:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DE0548F6;
	Tue, 19 Mar 2024 08:26:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420F54645;
	Tue, 19 Mar 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836787; cv=none; b=JcARWmTka7YCWIwFmTuMQFjiKphUNWR9VTZ9SONRuxsHismdQX0b7oA9Z2IXoJ7p3Icem3nq0uh/PG8v4r5fmU64pLZ7l1aXVUfhJN+HrUIOz9lr0//i5HbVEGDp2iXg0vGdmkCT34AiHkCqV/l63zHyjRkz1gJg3j/deLTn04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836787; c=relaxed/simple;
	bh=73VHrk/0BPskzmZgqkIxNnLhsrJjuXoHiGnhXcDdTFk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XeAC7pprYQyIQORS/P/VfGFkzz6RxYD5ThXgW5eIVIHbZWiDpmGaS80PVCoIU06u1cvvnBXdl1nrcf8Fm6/7X+zLGavJA9BYSSQCaR9yW/NmyJLk+GW9upNlj1OIL22uAtWllKco2OAQUeZfhmLqANutfiycUQzRi/t3FToE6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TzPvC4fljz4f3kFW;
	Tue, 19 Mar 2024 16:26:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 953271A0175;
	Tue, 19 Mar 2024 16:26:21 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RErTPllNWKsHQ--.24489S3;
	Tue, 19 Mar 2024 16:26:21 +0800 (CST)
Subject: Re: [RFC v4 linux-next 19/19] fs & block: remove bdev->bd_inode
To: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, brauner@kernel.org, axboe@kernel.dk,
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
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c62dac0e-666f-9cc9-cffe-f3d985029d6a@huaweicloud.com>
Date: Tue, 19 Mar 2024 16:26:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240318232245.GA17831@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+RErTPllNWKsHQ--.24489S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKr17Cw4DKw4ktr1rCw48Zwb_yoWxZr18pr
	Z8Ja45trW8G34vgFWIva17Xr1Y9w17try8Za48W34akrZ7tr92kF18CryUuFyrt3ykJw4D
	XF4jgryUCryfCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2024/03/19 7:22, Christoph Hellwig Ð´µÀ:
> On Mon, Mar 18, 2024 at 03:19:03PM +0800, Yu Kuai wrote:
>> I come up with an ideal:
>>
>> While opening the block_device the first time, store the generated new
>> file in "bd_inode->i_private". And release it after the last opener
>> close the block_device.
>>
>> The advantages are:
>>   - multiple openers can share the same bdev_file;
>>   - raw block device ops can use the bdev_file as well, and there is no
>> need to distinguish iomap/buffer_head for raw block_device;
>>
>> Please let me know what do you think?
> 
> That does sound very reasonable to me.
> 
I just implement the ideal with following patch(not fully tested, just
boot and some blktests)

Please let me know what you think.
Thanks!
Kuai

diff --git a/block/bdev.c b/block/bdev.c
index d42a6bc73474..8bc8962c59a5 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -899,14 +899,6 @@ int bdev_open(struct block_device *bdev, blk_mode_t 
mode, void *holder,
         if (unblock_events)
                 disk_unblock_events(disk);

-       bdev_file->f_flags |= O_LARGEFILE;
-       bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
-       if (bdev_nowait(bdev))
-               bdev_file->f_mode |= FMODE_NOWAIT;
-       bdev_file->f_mapping = bdev_mapping(bdev);
-       bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
-       bdev_file->private_data = holder;
-
         return 0;
  put_module:
         module_put(disk->fops->owner);
@@ -948,12 +940,66 @@ static unsigned blk_to_file_flags(blk_mode_t mode)
         return flags;
  }

+struct file *alloc_and_init_bdev_file(struct block_device *bdev,
+                                     blk_mode_t mode, void *holder)
+{
+       struct file *bdev_file = 
alloc_file_pseudo_noaccount(bdev_inode(bdev),
+                       blockdev_mnt, "", blk_to_file_flags(mode) | 
O_LARGEFILE,
+                       &def_blk_fops);
+
+       if (IS_ERR(bdev_file))
+               return bdev_file;
+
+       bdev_file->f_flags |= O_LARGEFILE;
+       bdev_file->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
+       if (bdev_nowait(bdev))
+               bdev_file->f_mode |= FMODE_NOWAIT;
+       bdev_file->f_mapping = bdev_mapping(bdev);
+       bdev_file->f_wb_err = filemap_sample_wb_err(bdev_file->f_mapping);
+       bdev_file->private_data = holder;
+
+       return bdev_file;
+}
+
+void get_bdev_file(struct block_device *bdev, struct file *bdev_file)
+{
+       struct inode *bd_inode = bdev_inode(bdev);
+       struct file *file;
+
+       mutex_lock(&bdev->bd_disk->open_mutex);
+       file = bd_inode->i_private;
+
+       if (!file) {
+               get_file(bdev_file);
+               bd_inode->i_private = bdev_file;
+       } else {
+               get_file(file);
+       }
+
+       mutex_unlock(&bdev->bd_disk->open_mutex);
+}
+
+void put_bdev_file(struct block_device *bdev)
+{
+       struct file *file = NULL;
+       struct inode *bd_inode = bdev_inode(bdev);
+
+       mutex_lock(&bdev->bd_disk->open_mutex);
+       file = bd_inode->i_private;
+
+       if (!atomic_read(&bdev->bd_openers))
+               bd_inode->i_private = NULL;
+
+       mutex_unlock(&bdev->bd_disk->open_mutex);
+
+       fput(file);
+}
+
  struct file *bdev_file_open_by_dev(dev_t dev, blk_mode_t mode, void 
*holder,
                                    const struct blk_holder_ops *hops)
  {
         struct file *bdev_file;
         struct block_device *bdev;
-       unsigned int flags;
         int ret;

         ret = bdev_permission(dev, mode, holder);
@@ -964,20 +1010,20 @@ struct file *bdev_file_open_by_dev(dev_t dev, 
blk_mode_t mode, void *holder,
         if (!bdev)
                 return ERR_PTR(-ENXIO);

-       flags = blk_to_file_flags(mode);
-       bdev_file = alloc_file_pseudo_noaccount(bdev_inode(bdev),
-                       blockdev_mnt, "", flags | O_LARGEFILE, 
&def_blk_fops);
+       bdev_file = alloc_and_init_bdev_file(bdev, mode, holder);
         if (IS_ERR(bdev_file)) {
                 blkdev_put_no_open(bdev);
                 return bdev_file;
         }
         ihold(bdev_inode(bdev));
+       get_bdev_file(bdev, bdev_file);

         ret = bdev_open(bdev, mode, holder, hops, bdev_file);
         if (ret) {
                 /* We failed to open the block device. Let ->release() 
know. */
                 bdev_file->private_data = ERR_PTR(ret);
                 fput(bdev_file);
+               put_bdev_file(bdev);
                 return ERR_PTR(ret);
         }
         return bdev_file;
@@ -1049,6 +1095,7 @@ void bdev_release(struct file *bdev_file)

         module_put(disk->fops->owner);
  put_no_open:
+       put_bdev_file(bdev);
         blkdev_put_no_open(bdev);
  }

diff --git a/block/blk.h b/block/blk.h
index 5ac293179bfb..ebe99dc9cff5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -518,6 +518,10 @@ static inline int req_ref_read(struct request *req)
         return atomic_read(&req->ref);
  }

+struct file *alloc_and_init_bdev_file(struct block_device *bdev,
+                                     blk_mode_t mode, void *holder);
+void get_bdev_file(struct block_device *bdev, struct file *bdev_file);
+void put_bdev_file(struct block_device *bdev);
  void bdev_release(struct file *bdev_file);
  int bdev_open(struct block_device *bdev, blk_mode_t mode, void *holder,
               const struct blk_holder_ops *hops, struct file *bdev_file);
diff --git a/block/fops.c b/block/fops.c
index 4037ae72a919..059f6c7d3c09 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -382,7 +382,7 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, 
struct iov_iter *iter)
  static int blkdev_iomap_begin(struct inode *inode, loff_t offset, 
loff_t length,
                 unsigned int flags, struct iomap *iomap, struct iomap 
*srcmap)
  {
-       struct block_device *bdev = I_BDEV(inode);
+       struct block_device *bdev = file_bdev(inode->i_private);
         loff_t isize = i_size_read(inode);

         iomap->bdev = bdev;
@@ -404,7 +404,7 @@ static const struct iomap_ops blkdev_iomap_ops = {
  static int blkdev_get_block(struct inode *inode, sector_t iblock,
                 struct buffer_head *bh, int create)
  {
-       bh->b_bdev = I_BDEV(inode);
+       bh->b_bdev = file_bdev(inode->i_private);
         bh->b_blocknr = iblock;
         set_buffer_mapped(bh);
         return 0;
@@ -598,6 +598,7 @@ blk_mode_t file_to_blk_mode(struct file *file)

  static int blkdev_open(struct inode *inode, struct file *filp)
  {
+       struct file *bdev_file;
         struct block_device *bdev;
         blk_mode_t mode;
         int ret;
@@ -614,9 +615,28 @@ static int blkdev_open(struct inode *inode, struct 
file *filp)
         if (!bdev)
                 return -ENXIO;

+       bdev_file = alloc_and_init_bdev_file(bdev,
+                       BLK_OPEN_READ | BLK_OPEN_WRITE, NULL);
+       if (IS_ERR(bdev_file)) {
+               blkdev_put_no_open(bdev);
+               return PTR_ERR(bdev_file);
+       }
+
+       bdev_file->private_data = ERR_PTR(-EINVAL);
+       get_bdev_file(bdev, bdev_file);
         ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
-       if (ret)
+       if (ret) {
+               put_bdev_file(bdev);
                 blkdev_put_no_open(bdev);
+       } else {
+               filp->f_flags |= O_LARGEFILE;
+               filp->f_mode |= FMODE_BUF_RASYNC | FMODE_CAN_ODIRECT;
+               if (bdev_nowait(bdev))
+                       filp->f_mode |= FMODE_NOWAIT;
+               filp->f_mapping = bdev_mapping(bdev);
+               filp->f_wb_err = 
filemap_sample_wb_err(bdev_file->f_mapping);
+       }
+
         return ret;
  }

> .
> 


