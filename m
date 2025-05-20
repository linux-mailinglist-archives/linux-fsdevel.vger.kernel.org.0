Return-Path: <linux-fsdevel+bounces-49502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA6EABD88D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD677A6616
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F461D7989;
	Tue, 20 May 2025 12:53:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2267819F135;
	Tue, 20 May 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747745612; cv=none; b=OIcjmBHuIUYTN6gKjFdXE6MDQTH0Lgz9pu8cwI62T1dJ/1PAmKy5ItJnAD+n0RsaJ6j1WWxOFUo86muaRsuWhNCjEZWSl2Iwz3YEIwR+4m8mVqF7BuGBpGARQQGaraZlLwQsKvmqwz9Ub7u6idEny4FU8iFcmxzdPgTKT1f34Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747745612; c=relaxed/simple;
	bh=BSAzjNgFwqBT3dlEfWzgPj4d5DkvOqbJJ/Agsv1uQHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utZbM88AObcdv70tFxZSh7sVvWtyZyjz0mOEvr4mnDziWH1sr9l2kMCXQr6cVS+KWVW3Jt4MX5VhbMTkxCd1+2RPA3eJ3Rf4UoGdCFYIzzuVGxaey+YifPXaVqZ7PEMGUoJbagnfWrwHAYs9Ci3g9EvcVecGFP4XDCoNwEk0pgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b1vcT0nC5zKHMfW;
	Tue, 20 May 2025 20:53:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9D75E1A07BB;
	Tue, 20 May 2025 20:53:27 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGBGeyxorFXpMw--.65335S3;
	Tue, 20 May 2025 20:53:27 +0800 (CST)
Message-ID: <25d93183-35ac-4b58-9bd2-2c9179735601@huaweicloud.com>
Date: Tue, 20 May 2025 20:53:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] ext4: correct the journal credits calculations of
 allocating blocks
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-6-yi.zhang@huaweicloud.com>
 <nhxfuu53wyacsrq7xqgxvgzcggyscu2tbabginahcygvmc45hy@t4fvmyeky33e>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <nhxfuu53wyacsrq7xqgxvgzcggyscu2tbabginahcygvmc45hy@t4fvmyeky33e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHrGBGeyxorFXpMw--.65335S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy7Zw13CFy3WF45XFyrZwb_yoW5Zr15pF
	n7AF4rJF48Xw1UurWIqa1jvr48Wa18GF47uF43Jr45XF98Aa4fGrn0va4rCFy5tr4fAw1q
	vF4Fk347G3W3JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/20 4:24, Jan Kara wrote:
> On Mon 12-05-25 14:33:16, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The journal credits calculation in ext4_ext_index_trans_blocks() is
>> currently inadequate. It only multiplies the depth of the extents tree
>> and doesn't account for the blocks that may be required for adding the
>> leaf extents themselves.
>>
>> After enabling large folios, we can easily run out of handle credits,
>> triggering a warning in jbd2_journal_dirty_metadata() on filesystems
>> with a 1KB block size. This occurs because we may need more extents when
>> iterating through each large folio in
>> ext4_do_writepages()->mpage_map_and_submit_extent(). Therefore, we
>> should modify ext4_ext_index_trans_blocks() to include a count of the
>> leaf extents in the worst case as well.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> One comment below
> 
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index c616a16a9f36..e759941bd262 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -2405,9 +2405,10 @@ int ext4_ext_index_trans_blocks(struct inode *inode, int extents)
>>  	depth = ext_depth(inode);
>>  
>>  	if (extents <= 1)
>> -		index = depth * 2;
>> +		index = depth * 2 + extents;
>>  	else
>> -		index = depth * 3;
>> +		index = depth * 3 +
>> +			DIV_ROUND_UP(extents, ext4_ext_space_block(inode, 0));
>>  
>>  	return index;
>>  }
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index ffbf444b56d4..3e962a760d71 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -5792,18 +5792,16 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
>>  	int ret;
>>  
>>  	/*
>> -	 * How many index blocks need to touch to map @lblocks logical blocks
>> -	 * to @pextents physical extents?
>> +	 * How many index and lead blocks need to touch to map @lblocks
>> +	 * logical blocks to @pextents physical extents?
>>  	 */
>>  	idxblocks = ext4_index_trans_blocks(inode, lblocks, pextents);
>>  
>> -	ret = idxblocks;
>> -
>>  	/*
>>  	 * Now let's see how many group bitmaps and group descriptors need
>>  	 * to account
>>  	 */
>> -	groups = idxblocks + pextents;
>> +	groups = idxblocks;
> 
> I don't think you can drop 'pextents' from this computation... Yes, you now
> account possible number of modified extent tree leaf blocks in
> ext4_index_trans_blocks() but additionally, each extent separately may be
> allocated from a different group and thus need to update different bitmap
> and group descriptor block. That is separate from the computation you do in
> ext4_index_trans_blocks() AFAICT...
> 

Yes, that's right! Sorry for my mistake. I will fix this.

Thanks,
Yi.

> 
>>  	gdpblocks = groups;
>>  	if (groups > ngroups)
>>  		groups = ngroups;
>> @@ -5811,7 +5809,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
>>  		gdpblocks = EXT4_SB(inode->i_sb)->s_gdb_count;
>>  
>>  	/* bitmaps and block group descriptor blocks */
>> -	ret += groups + gdpblocks;
>> +	ret = idxblocks + groups + gdpblocks;
>>  
>>  	/* Blocks for super block, inode, quota and xattr blocks */
>>  	ret += EXT4_META_TRANS_BLOCKS(inode->i_sb);
>> -- 
>> 2.46.1
>>


