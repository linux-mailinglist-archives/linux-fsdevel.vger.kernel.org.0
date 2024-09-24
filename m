Return-Path: <linux-fsdevel+bounces-29946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13005983F88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970391F21A33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5510C1494D4;
	Tue, 24 Sep 2024 07:43:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A51148FF9;
	Tue, 24 Sep 2024 07:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163810; cv=none; b=bNekstcDpnPThdSg4+SBeS+MuuvdKFPBL0HlMI4zyg2N86/QDK9xB2+JQim4GCsIXITgyYIqGr7ExQKJoGyZaeW0IB0hl8hi8TLvBEu0O6x3m0eGyBJzh/4vvZGsLaTGmN7qaa7/VZOK5tPQVAdVuz+3GjKY4AoZKWWZDodcjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163810; c=relaxed/simple;
	bh=w6OIkxu0c0aRorGX0RNKZ2Zty8s6bl/Zv9aFMNGUfbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcT1k/0ELvTjfyTMBO2+JC6qgjaQvKPzLdj/esM1muepvBfFzj0vy9CQ4iPVF+S9esAOJJYCMCdWwWGz6x3Np5m3WhxayxUKrQ4Ou310EndeiAsoe6EnaOIbCzLtzHi7AvGTQCgwsTUkK35m+JYRYIcYHlqAPVLWlW/UHhJwb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XCX0C3kt5z4f3l22;
	Tue, 24 Sep 2024 15:43:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 645121A07B6;
	Tue, 24 Sep 2024 15:43:24 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXysaabfJmX5bQCA--.4309S3;
	Tue, 24 Sep 2024 15:43:24 +0800 (CST)
Message-ID: <5de46c69-74f4-4955-a825-8c8970c0aa09@huaweicloud.com>
Date: Tue, 24 Sep 2024 15:43:22 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] ext4: drop ext4_update_disksize_before_punch()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-4-yi.zhang@huaweicloud.com>
 <20240920161351.ax3oidpt6w6bf3o4@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20240920161351.ax3oidpt6w6bf3o4@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXysaabfJmX5bQCA--.4309S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1DtFWxtw4DJryxCr45KFg_yoWrAw48pr
	93JFy8Kr4Fqa4DurWIgFnxZr10y3W2krW8WryfGF1Iq3sFvwn7KF10qr1ruFWUtrWkAr40
	qF4UtFsrWr15urJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/21 0:13, Jan Kara wrote:
> On Wed 04-09-24 14:29:18, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Since we always write back dirty data before zeroing range and punching
>> hole, the delalloc extended file's disksize of should be updated
>> properly when writing back pages, hence we don't need to update file's
>> disksize before discarding page cache in ext4_zero_range() and
>> ext4_punch_hole(), just drop ext4_update_disksize_before_punch().
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> So when we don't write out before hole punching & company this needs to stay
> in some shape or form. 
> 

Thanks for taking time to review this series!

I don't fully understand this comment, please let me confirm. Do you
suggested that we still don't write out all the data before punching /
zeroing / collapseing(i.e. drop patch 01), so we need to keep
ext4_update_disksize_before_punch()(i.e. also drop this patch), is
that right?

Thanks,
Yi.

> 
>> ---
>>  fs/ext4/ext4.h    |  3 ---
>>  fs/ext4/extents.c |  4 ----
>>  fs/ext4/inode.c   | 37 +------------------------------------
>>  3 files changed, 1 insertion(+), 43 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 08acd152261e..e8d7965f62c4 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -3414,9 +3414,6 @@ static inline int ext4_update_inode_size(struct inode *inode, loff_t newsize)
>>  	return changed;
>>  }
>>  
>> -int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>> -				      loff_t len);
>> -
>>  struct ext4_group_info {
>>  	unsigned long   bb_state;
>>  #ifdef AGGRESSIVE_CHECK
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 19a9b14935b7..d9fccf2970e9 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -4637,10 +4637,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>>  		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
>>  			  EXT4_EX_NOCACHE);
>>  
>> -		ret = ext4_update_disksize_before_punch(inode, offset, len);
>> -		if (ret)
>> -			goto out_invalidate_lock;
>> -
>>  		/* Now release the pages and zero block aligned part of pages */
>>  		truncate_pagecache_range(inode, start, end - 1);
>>  
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 8af25442d44d..9343ce9f2b01 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3872,37 +3872,6 @@ int ext4_can_truncate(struct inode *inode)
>>  	return 0;
>>  }
>>  
>> -/*
>> - * We have to make sure i_disksize gets properly updated before we truncate
>> - * page cache due to hole punching or zero range. Otherwise i_disksize update
>> - * can get lost as it may have been postponed to submission of writeback but
>> - * that will never happen after we truncate page cache.
>> - */
>> -int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>> -				      loff_t len)
>> -{
>> -	handle_t *handle;
>> -	int ret;
>> -
>> -	loff_t size = i_size_read(inode);
>> -
>> -	WARN_ON(!inode_is_locked(inode));
>> -	if (offset > size || offset + len < size)
>> -		return 0;
>> -
>> -	if (EXT4_I(inode)->i_disksize >= size)
>> -		return 0;
>> -
>> -	handle = ext4_journal_start(inode, EXT4_HT_MISC, 1);
>> -	if (IS_ERR(handle))
>> -		return PTR_ERR(handle);
>> -	ext4_update_i_disksize(inode, size);
>> -	ret = ext4_mark_inode_dirty(handle, inode);
>> -	ext4_journal_stop(handle);
>> -
>> -	return ret;
>> -}
>> -
>>  static void ext4_wait_dax_page(struct inode *inode)
>>  {
>>  	filemap_invalidate_unlock(inode->i_mapping);
>> @@ -4022,13 +3991,9 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
>>  
>>  	/* Now release the pages and zero block aligned part of pages*/
>> -	if (last_block_offset > first_block_offset) {
>> -		ret = ext4_update_disksize_before_punch(inode, offset, length);
>> -		if (ret)
>> -			goto out_dio;
>> +	if (last_block_offset > first_block_offset)
>>  		truncate_pagecache_range(inode, first_block_offset,
>>  					 last_block_offset);
>> -	}
>>  
>>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>>  		credits = ext4_writepage_trans_blocks(inode);
>> -- 
>> 2.39.2
>>


