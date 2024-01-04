Return-Path: <linux-fsdevel+bounces-7365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8587E8241CC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 13:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107301F25274
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4A522313;
	Thu,  4 Jan 2024 12:32:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9531EB57;
	Thu,  4 Jan 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4T5QwC58Htz4f3jYP;
	Thu,  4 Jan 2024 20:32:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 00E171A085D;
	Thu,  4 Jan 2024 20:32:46 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCnqxFrpZZlWpgFFg--.9161S3;
	Thu, 04 Jan 2024 20:32:46 +0800 (CST)
Subject: Re: [PATCH RFC v3 for-6.8/block 11/17] erofs: use bdev api
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, roger.pau@citrix.com, colyli@suse.de,
 kent.overstreet@gmail.com, joern@lazybastard.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, sth@linux.ibm.com, hoeppner@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, clm@fb.com,
 josef@toxicpanda.com, dsterba@suse.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, nico@fluxnic.net, xiang@kernel.org, chao@kernel.org,
 tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
 konishi.ryusuke@gmail.com, willy@infradead.org, akpm@linux-foundation.org,
 hare@suse.de, p.raghav@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-nilfs@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com>
 <20231221085826.1768395-1-yukuai1@huaweicloud.com>
 <20240104120207.ig7tfc3mgckwkp2n@quack3>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7f868579-f993-aaa1-b7d7-eccbe0b0173c@huaweicloud.com>
Date: Thu, 4 Jan 2024 20:32:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240104120207.ig7tfc3mgckwkp2n@quack3>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCnqxFrpZZlWpgFFg--.9161S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy8ury3GFW8AF18AFy3twb_yoW5CFW7pF
	y5CF1rGrWrXr9I9w1Igr1jvF4rta97tr48C3yxJw1FvayjqrySgFy0ywnxGF4jkr4vkr4I
	qF12vryxuw4UKrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Wrv_Gr1UMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6rWU
	JVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUoL0eDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi, Jan!

ÔÚ 2024/01/04 20:02, Jan Kara Ð´µÀ:
> On Thu 21-12-23 16:58:26, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Avoid to access bd_inode directly, prepare to remove bd_inode from
>> block_device.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> I'm not erofs maintainer but IMO this is quite ugly and grows erofs_buf
> unnecessarily. I'd rather store 'sb' pointer in erofs_buf and then do the
> right thing in erofs_bread() which is the only place that seems to care
> about the erofs_is_fscache_mode() distinction... Also blkszbits is then
> trivially sb->s_blocksize_bits so it would all seem much more
> straightforward.

Thanks for your suggestion, I'll follow this unless Gao Xiang has other
suggestions.

Kuai
> 
> 								Honza
> 
>> ---
>>   fs/erofs/data.c     | 18 ++++++++++++------
>>   fs/erofs/internal.h |  2 ++
>>   2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
>> index c98aeda8abb2..bbe2fe199bf3 100644
>> --- a/fs/erofs/data.c
>> +++ b/fs/erofs/data.c
>> @@ -32,8 +32,8 @@ void erofs_put_metabuf(struct erofs_buf *buf)
>>   void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>>   		  enum erofs_kmap_type type)
>>   {
>> -	struct inode *inode = buf->inode;
>> -	erofs_off_t offset = (erofs_off_t)blkaddr << inode->i_blkbits;
>> +	u8 blkszbits = buf->inode ? buf->inode->i_blkbits : buf->blkszbits;
>> +	erofs_off_t offset = (erofs_off_t)blkaddr << blkszbits;
>>   	pgoff_t index = offset >> PAGE_SHIFT;
>>   	struct page *page = buf->page;
>>   	struct folio *folio;
>> @@ -43,7 +43,9 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>>   		erofs_put_metabuf(buf);
>>   
>>   		nofs_flag = memalloc_nofs_save();
>> -		folio = read_cache_folio(inode->i_mapping, index, NULL, NULL);
>> +		folio = buf->inode ?
>> +			read_mapping_folio(buf->inode->i_mapping, index, NULL) :
>> +			bdev_read_folio(buf->bdev, offset);
>>   		memalloc_nofs_restore(nofs_flag);
>>   		if (IS_ERR(folio))
>>   			return folio;
>> @@ -67,10 +69,14 @@ void *erofs_bread(struct erofs_buf *buf, erofs_blk_t blkaddr,
>>   
>>   void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
>>   {
>> -	if (erofs_is_fscache_mode(sb))
>> +	if (erofs_is_fscache_mode(sb)) {
>>   		buf->inode = EROFS_SB(sb)->s_fscache->inode;
>> -	else
>> -		buf->inode = sb->s_bdev->bd_inode;
>> +		buf->bdev = NULL;
>> +	} else {
>> +		buf->inode = NULL;
>> +		buf->bdev = sb->s_bdev;
>> +		buf->blkszbits = EROFS_SB(sb)->blkszbits;
>> +	}
>>   }
>>   
>>   void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
>> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
>> index b0409badb017..c9206351b485 100644
>> --- a/fs/erofs/internal.h
>> +++ b/fs/erofs/internal.h
>> @@ -224,8 +224,10 @@ enum erofs_kmap_type {
>>   
>>   struct erofs_buf {
>>   	struct inode *inode;
>> +	struct block_device *bdev;
>>   	struct page *page;
>>   	void *base;
>> +	u8 blkszbits;
>>   	enum erofs_kmap_type kmap_type;
>>   };
>>   #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
>> -- 
>> 2.39.2
>>


