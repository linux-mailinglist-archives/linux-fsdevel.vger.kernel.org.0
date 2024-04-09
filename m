Return-Path: <linux-fsdevel+bounces-16436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2989D892
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89941C213F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3712A14A;
	Tue,  9 Apr 2024 11:53:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96212A144;
	Tue,  9 Apr 2024 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663614; cv=none; b=roiZI8JDFiawiunyr0U7EbemVtSAX0ccbGYZsyJrq7MCX1h6Tld/P4TJTPFi1gxhw+NNuDPexJLJ9VFz3hC6i3JnBeijCP57lB/E8q93062huoMHic0s5DZzNPvujfU7RBGSjDMopAGUH7aaGgCbAONUZx/MV/vXBD9YEWJqjHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663614; c=relaxed/simple;
	bh=/Vf/ZrPrZ22LUB/jznddmjfNXq2LQt/RWdYSXZn/7wI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ShqJCRjlJoC0aBAqTt+0Ph9x1Em1VOLeAye2N8jyPuMGV3WJHUPPpRwrcvWdGqxjCs7C+5wCbLjXerVFv2kLH3mUaYeju+npKJHzPgaH/Ts7NLIxp/jBTmZk2TY22cgbDg92P+JfnU0XezKnjj69ILgpDiO27nD64TlxxaHbPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VDPVR5BcDz4f3lfQ;
	Tue,  9 Apr 2024 19:53:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 538861A0568;
	Tue,  9 Apr 2024 19:53:28 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBE2LBVmvDcXJg--.2082S3;
	Tue, 09 Apr 2024 19:53:28 +0800 (CST)
Subject: Re: [PATCH vfs.all 22/26] block: stash a bdev_file to read/write raw
 blcok_device
To: Christian Brauner <brauner@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-23-yukuai1@huaweicloud.com>
 <20240409-pavillon-lohnnebenkosten-8ba65c1fd8e0@brauner>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <f61097a3-5a39-8e9b-d0c7-77e8ac80f56a@huaweicloud.com>
Date: Tue, 9 Apr 2024 19:53:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240409-pavillon-lohnnebenkosten-8ba65c1fd8e0@brauner>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBE2LBVmvDcXJg--.2082S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1DZw1xtF4UCFW3Kr4rKrg_yoWruF1UpF
	98KFZ8GrWUWry0gF4vvw15Zryaqa4093y8Ca4xJ34SkrWDKr92gF1vkr1UAFWYyFWxJFs7
	XF42krWruryjkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0D
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/04/09 18:23, Christian Brauner 写道:
>> +static int __stash_bdev_file(struct block_device *bdev)
> 
> I've said that on the previous version. I think that this is really
> error prone and seems overall like an unpleasant solution. I would
> really like to avoid going down that route.

Yes, I see your point, and it's indeed reasonable.

> 
> I think a chunk of this series is good though specicially simple
> conversions of individual filesystems where file_inode() or f_mapping
> makes sense. There's a few exceptions where we might be better of
> replacing the current apis with something else (I think Al touched on
> that somewhere further down the thread.).
> 
> I'd suggest the straightforward bd_inode removals into a separate series
> that I can take.
> 
> Thanks for working on all of this. It's certainly a contentious area.

How about following simple patch to expose bdev_mapping() for
fs/buffer.c for now?

Thanks,
Kuai

diff --git a/block/blk.h b/block/blk.h
index a34bb590cce6..f8bcb43a12c6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -428,7 +428,6 @@ static inline int blkdev_zone_mgmt_ioctl(struct 
block_device *bdev,
  #endif /* CONFIG_BLK_DEV_ZONED */

  struct inode *bdev_inode(struct block_device *bdev);
-struct address_space *bdev_mapping(struct block_device *bdev);
  struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
  void bdev_add(struct block_device *bdev, dev_t dev);

diff --git a/fs/buffer.c b/fs/buffer.c
index 4f73d23c2c46..e2bd19e3fe48 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -189,8 +189,8 @@ EXPORT_SYMBOL(end_buffer_write_sync);
  static struct buffer_head *
  __find_get_block_slow(struct block_device *bdev, sector_t block)
  {
-       struct inode *bd_inode = bdev->bd_inode;
-       struct address_space *bd_mapping = bd_inode->i_mapping;
+       struct address_space *bd_mapping = bdev_mapping(bdev);
+       struct inode *bd_inode = bd_mapping->host;
         struct buffer_head *ret = NULL;
         pgoff_t index;
         struct buffer_head *bh;
@@ -1034,12 +1034,12 @@ static sector_t folio_init_buffers(struct folio 
*folio,
  static bool grow_dev_folio(struct block_device *bdev, sector_t block,
                 pgoff_t index, unsigned size, gfp_t gfp)
  {
-       struct inode *inode = bdev->bd_inode;
+       struct address_space *bd_mapping = bdev_mapping(bdev);
         struct folio *folio;
         struct buffer_head *bh;
         sector_t end_block = 0;

-       folio = __filemap_get_folio(inode->i_mapping, index,
+       folio = __filemap_get_folio(bd_mapping, index,
                         FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
         if (IS_ERR(folio))
                 return false;
@@ -1073,10 +1073,10 @@ static bool grow_dev_folio(struct block_device 
*bdev, sector_t block,
          * lock to be atomic wrt __find_get_block(), which does not
          * run under the folio lock.
          */
-       spin_lock(&inode->i_mapping->i_private_lock);
+       spin_lock(&bd_mapping->i_private_lock);
         link_dev_buffers(folio, bh);
         end_block = folio_init_buffers(folio, bdev, size);
-       spin_unlock(&inode->i_mapping->i_private_lock);
+       spin_unlock(&bd_mapping->i_private_lock);
  unlock:
         folio_unlock(folio);
         folio_put(folio);
@@ -1463,7 +1463,7 @@ __bread_gfp(struct block_device *bdev, sector_t block,
  {
         struct buffer_head *bh;

-       gfp |= mapping_gfp_constraint(bdev->bd_inode->i_mapping, ~__GFP_FS);
+       gfp |= mapping_gfp_constraint(bdev_mapping(bdev), ~__GFP_FS);

         /*
          * Prefer looping in the allocator rather than here, at least that
@@ -1696,8 +1696,8 @@ EXPORT_SYMBOL(create_empty_buffers);
   */
  void clean_bdev_aliases(struct block_device *bdev, sector_t block, 
sector_t len)
  {
-       struct inode *bd_inode = bdev->bd_inode;
-       struct address_space *bd_mapping = bd_inode->i_mapping;
+       struct address_space *bd_mapping = bdev_mapping(bdev);
+       struct inode *bd_inode = bd_mapping->host;
         struct folio_batch fbatch;
         pgoff_t index = ((loff_t)block << bd_inode->i_blkbits) / PAGE_SIZE;
         pgoff_t end;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc840e0fb6e5..bbae55535d53 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1527,6 +1527,7 @@ void blkdev_put_no_open(struct block_device *bdev);

  struct block_device *I_BDEV(struct inode *inode);
  struct block_device *file_bdev(struct file *bdev_file);
+struct address_space *bdev_mapping(struct block_device *bdev);
  bool disk_live(struct gendisk *disk);
  unsigned int block_size(struct block_device *bdev);

> .
> 


