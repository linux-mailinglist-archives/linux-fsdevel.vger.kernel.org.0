Return-Path: <linux-fsdevel+bounces-67092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A31FC3535B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 11:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592841891391
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4E30DD3A;
	Wed,  5 Nov 2025 10:48:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F13309DD8;
	Wed,  5 Nov 2025 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339730; cv=none; b=PhM/I5BZzBHWIXyf/yCfkzExpcRnri4IL9Do/mEx51j+g9yOMIXhnweDkT1z/KKi8oeJdgPOdB+nGw1+V2edIEFpY1zwu2WR2rrCKLA8BybH0wdSKDjmPAcRdV7/UvsTfZF/i5IPHZ6cdA/YVUeAxTO055N2HzsuI1Z0lxRayk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339730; c=relaxed/simple;
	bh=krgdsMbqPAnZEgv6GcAPh6GqU4FTX2vq6UliNancPPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEvV+mPfp8c1yQrLLCB0Ta89b9fqyvvqENZ3Y7lSDW81Kv48YEHctQHpJDPxtZULcZDdgHd8RQa/doAVgAOTEvAzrJSN3MvsiQme5hdqI2UBZG9hfs2R/M3ekkOoebWSFbMai0CSkBbewAWS0EyU3j9gOZHNhycxZXOeYbzy14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d1hrC6TxGzYQvhs;
	Wed,  5 Nov 2025 18:48:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 740A21A058E;
	Wed,  5 Nov 2025 18:48:44 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBnCEGJKwtpT+YjCw--.1462S3;
	Wed, 05 Nov 2025 18:48:43 +0800 (CST)
Message-ID: <8041da1f-2ea6-4c66-8042-81076f5fc9d3@huaweicloud.com>
Date: Wed, 5 Nov 2025 18:48:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/25] ext4: make online defragmentation support large
 block size
To: Jan Kara <jack@suse.cz>, libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 linux-kernel@vger.kernel.org, kernel@pankajraghav.com, mcgrof@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251025032221.2905818-1-libaokun@huaweicloud.com>
 <20251025032221.2905818-22-libaokun@huaweicloud.com>
 <vkbarfyd6ozrrljhvwhmy2cq23mby6mxl2kxlsxp2wqgmvxvgi@6sgmqhhdnmru>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <vkbarfyd6ozrrljhvwhmy2cq23mby6mxl2kxlsxp2wqgmvxvgi@6sgmqhhdnmru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBnCEGJKwtpT+YjCw--.1462S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4fWF4kKF4fWrW8KF15Arb_yoW5XryDpF
	WxAr15Kws8W3W0grsrXFsrZr1rK3W7CF4UXrW8W34fXFyjy3sIgFn7A3W5uFyj9rWxCry0
	vF42yrnrWay5J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/5/2025 5:50 PM, Jan Kara wrote:
> On Sat 25-10-25 11:22:17, libaokun@huaweicloud.com wrote:
>> From: Zhihao Cheng <chengzhihao1@huawei.com>
>>
>> There are several places assuming that block size <= PAGE_SIZE, modify
>> them to support large block size (bs > ps).
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> 
> ...
> 
>> @@ -565,7 +564,7 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>>  	struct inode *orig_inode = file_inode(o_filp);
>>  	struct inode *donor_inode = file_inode(d_filp);
>>  	struct ext4_ext_path *path = NULL;
>> -	int blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
>> +	int blocks_per_page = 1;
>>  	ext4_lblk_t o_end, o_start = orig_blk;
>>  	ext4_lblk_t d_start = donor_blk;
>>  	int ret;
>> @@ -608,6 +607,9 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>>  		return -EOPNOTSUPP;
>>  	}
>>  
>> +	if (i_blocksize(orig_inode) < PAGE_SIZE)
>> +		blocks_per_page = PAGE_SIZE >> orig_inode->i_blkbits;
>> +
> 
> I think these are strange and the only reason for this is that
> ext4_move_extents() tries to make life easier to move_extent_per_page() and
> that doesn't really work with larger folios anymore. I think
> ext4_move_extents() just shouldn't care about pages / folios at all and
> pass 'cur_len' as the length to the end of extent / moved range and
> move_extent_per_page() will trim the length based on the folios it has got.
> 
> Also then we can rename some of the variables and functions from 'page' to
> 'folio'.
> 
> 								Honza

Hi, Jan!

Thank you for the suggestion. However, after merging my online defragmentation
optimization series[1], we don't need this patch at all. Baokun will rebase it
onto my series in the next iteration.

[1] https://lore.kernel.org/linux-ext4/20251013015128.499308-1-yi.zhang@huaweicloud.com/

Thanks,
Yi.

> 
>>  	/* Protect orig and donor inodes against a truncate */
>>  	lock_two_nondirectories(orig_inode, donor_inode);
>>  
>> @@ -665,10 +667,8 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>>  		if (o_end - o_start < cur_len)
>>  			cur_len = o_end - o_start;
>>  
>> -		orig_page_index = o_start >> (PAGE_SHIFT -
>> -					       orig_inode->i_blkbits);
>> -		donor_page_index = d_start >> (PAGE_SHIFT -
>> -					       donor_inode->i_blkbits);
>> +		orig_page_index = EXT4_LBLK_TO_P(orig_inode, o_start);
>> +		donor_page_index = EXT4_LBLK_TO_P(donor_inode, d_start);
>>  		offset_in_page = o_start % blocks_per_page;
>>  		if (cur_len > blocks_per_page - offset_in_page)
>>  			cur_len = blocks_per_page - offset_in_page;
>> -- 
>> 2.46.1
>>


