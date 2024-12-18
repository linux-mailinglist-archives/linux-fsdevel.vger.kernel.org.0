Return-Path: <linux-fsdevel+bounces-37733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0749F672A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 14:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D77C1898679
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 13:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9AC199EA1;
	Wed, 18 Dec 2024 13:13:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D1A1ACEBB;
	Wed, 18 Dec 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527635; cv=none; b=hWWhV6Wccm0oUY0YKf1QRwLwfyYopWo7O/Bbu4OqlLc0VfPADP17VYibMshsSXDgqDH3xXH568vlVi9hA3d8QiPVV9jPMYluRF77W1Wr5Mpvklo4tm+R0lZw663PEyRonKAfiUVexH4wIZDnrlVAS3CXMr1ktr5wt2LRRHC5+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527635; c=relaxed/simple;
	bh=MQjJOOabUbrUlLMm6DlHGCrhqOd07CU7v1tiyTjXd3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBlScSNpuFpOaOT3lLKQLGckd0NH79aAwCkjYIcdRHlyrNMAzvVZNXZpnWqf480z1Ds1qHnUTLJfx7TMvkBDMJDkbdUgp1iMsqed8uFL5R8/sKQlW0sYeBY13vZWlw6CMIwDmWqx42bLXzF404ylmilQhXjDkbMdS+xQce1a05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YCvJ86ql7z4f3jQv;
	Wed, 18 Dec 2024 21:13:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7149D1A018D;
	Wed, 18 Dec 2024 21:13:48 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHMYWKymJnoErREw--.4231S3;
	Wed, 18 Dec 2024 21:13:48 +0800 (CST)
Message-ID: <221b151d-12c7-4e98-afc4-d248aa3637ba@huaweicloud.com>
Date: Wed, 18 Dec 2024 21:13:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] ext4: refactor ext4_punch_hole()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-5-yi.zhang@huaweicloud.com>
 <Z2KhPcxh9ESbD5l5@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z2KhPcxh9ESbD5l5@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHMYWKymJnoErREw--.4231S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1fWw4kuF17Gw17GryxAFb_yoW5GFWDpr
	Z3JFy3Gr40qry7Cw4Sgrs7XF1Fga1kKr4UGFy3Kr1Fgr90yw1vgF4qgryrWa4jgrZ7Jr1j
	qF1jqrW7u348CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	VOJUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/18 18:17, Ojaswin Mujoo wrote:
> On Mon, Dec 16, 2024 at 09:39:09AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The current implementation of ext4_punch_hole() contains complex
>> position calculations and stale error tags. To improve the code's
>> clarity and maintainability, it is essential to clean up the code and
>> improve its readability, this can be achieved by: a) simplifying and
>> renaming variables; b) eliminating unnecessary position calculations;
>> c) writing back all data in data=journal mode, and drop page cache from
>> the original offset to the end, rather than using aligned blocks,
>> d) renaming the stale error tags.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/ext4.h  |   2 +
>>  fs/ext4/inode.c | 119 +++++++++++++++++++++---------------------------
>>  2 files changed, 55 insertions(+), 66 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 8843929b46ce..8be06d5f5b43 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -367,6 +367,8 @@ struct ext4_io_submit {
>>  #define EXT4_MAX_BLOCKS(size, offset, blkbits) \
>>  	((EXT4_BLOCK_ALIGN(size + offset, blkbits) >> blkbits) - (offset >> \
>>  								  blkbits))
>> +#define EXT4_B_TO_LBLK(inode, offset) \
>> +	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
>>  
>>  /* Translate a block number to a cluster number */
>>  #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index a5ba2b71d508..7720d3700b27 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
[..]
>> @@ -4069,22 +4060,16 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>>  
>>  	ret = ext4_break_layouts(inode);
>>  	if (ret)
>> -		goto out_dio;
>> +		goto out_invalidate_lock;
>>  
>> -	first_block_offset = round_up(offset, sb->s_blocksize);
>> -	last_block_offset = round_down((offset + length), sb->s_blocksize) - 1;
>> +	ret = ext4_update_disksize_before_punch(inode, offset, length);
> 
> Hey Zhang,
> 
> The changes look good to me, just one question, why are we doing
> disksize update unconditionally now and not only when the range 
> spans a complete block or more.
> 

I want to simplify the code. We only need to update the disksize when
the end of the punching or zeroing range is >= the EOF and i_disksize
is less than i_size. ext4_update_disksize_before_punch() has already
performed this check and has ruled out most cases. Therefore, I
believe that calling it unconditionally will not incur significant
costs.

Thanks,
Yi.


