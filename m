Return-Path: <linux-fsdevel+bounces-7218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F1822E22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14E21C23579
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C3199AA;
	Wed,  3 Jan 2024 13:21:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FB1947B;
	Wed,  3 Jan 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4r2B0dB3z4f3lfZ;
	Wed,  3 Jan 2024 21:20:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BC6371A0AB2;
	Wed,  3 Jan 2024 21:20:55 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgAHVw00X5VlKmyqFQ--.15497S3;
	Wed, 03 Jan 2024 21:20:53 +0800 (CST)
Subject: Re: [RFC PATCH v2 05/25] ext4: make ext4_map_blocks() distinguish
 delalloc only extent
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca, ritesh.list@gmail.com, hch@infradead.org,
 djwong@kernel.org, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <20240102123918.799062-1-yi.zhang@huaweicloud.com>
 <20240102123918.799062-6-yi.zhang@huaweicloud.com>
 <20240103113131.z4jhwim7bzynhrlx@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <62da3bfb-6d50-2eb9-1b9a-13f5287f562d@huaweicloud.com>
Date: Wed, 3 Jan 2024 21:20:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240103113131.z4jhwim7bzynhrlx@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAHVw00X5VlKmyqFQ--.15497S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWxGw47CFy5AF43trWkZwb_yoW5Zw48pa
	95AF1UKan8Ww1UuayIqF1UJr1UKa1Fkay7Cr4rtryFkasxGr1fKFn09FsxZFWDtrWxJF1U
	XFW5t3WUCanIkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/1/3 19:31, Jan Kara wrote:
> On Tue 02-01-24 20:38:58, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Add a new map flag EXT4_MAP_DELAYED to indicate the mapping range is a
>> delayed allocated only (not unwritten) one, and making
>> ext4_map_blocks() can distinguish it, no longer mixing it with holes.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> One small comment below.
> 
>> ---
>>  fs/ext4/ext4.h    | 4 +++-
>>  fs/ext4/extents.c | 5 +++--
>>  fs/ext4/inode.c   | 2 ++
>>  3 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index a5d784872303..55195909d32f 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -252,8 +252,10 @@ struct ext4_allocation_request {
>>  #define EXT4_MAP_MAPPED		BIT(BH_Mapped)
>>  #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
>>  #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
>> +#define EXT4_MAP_DELAYED	BIT(BH_Delay)
>>  #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
>> -				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY)
>> +				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY |\
>> +				 EXT4_MAP_DELAYED)
>>  
>>  struct ext4_map_blocks {
>>  	ext4_fsblk_t m_pblk;
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 0892d0568013..fc69f13cf510 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -4073,9 +4073,10 @@ static void ext4_ext_determine_hole(struct inode *inode,
>>  	} else if (in_range(map->m_lblk, es.es_lblk, es.es_len)) {
>>  		/*
>>  		 * Straddle the beginning of the queried range, it's no
>> -		 * longer a hole, adjust the length to the delayed extent's
>> -		 * after map->m_lblk.
>> +		 * longer a hole, mark it is a delalloc and adjust the
>> +		 * length to the delayed extent's after map->m_lblk.
>>  		 */
>> +		map->m_flags |= EXT4_MAP_DELAYED;
> 
> I wouldn't set delalloc bit here. If there's delalloc extent containing
> lblk now, it means the caller of ext4_map_blocks() is not holding i_rwsem
> (otherwise we would have found already in ext4_map_blocks()) and thus
> delalloc info is unreliable anyway. So I wouldn't bother. But it's worth a
> comment here like:
> 
> 		/*
> 		 * There's delalloc extent containing lblk. It must have
> 		 * been added after ext4_map_blocks() checked the extent
> 		 * status tree so we are not holding i_rwsem and delalloc
> 		 * info is only stabilized by i_data_sem we are going to
> 		 * release soon. Don't modify the extent status tree and
> 		 * report extent as a hole.
> 		 */
> 

Yeah, the delalloc info is still unreliable. Thanks for the advice, I
will revise it in my next iteration along with your advice in patch 03.

Thanks,
Yi.

> 
>>  		len = es.es_lblk + es.es_len - map->m_lblk;
>>  		goto out;
>>  	} else {
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 1b5e6409f958..c141bf6d8db2 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -515,6 +515,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>>  			map->m_len = retval;
>>  		} else if (ext4_es_is_delayed(&es) || ext4_es_is_hole(&es)) {
>>  			map->m_pblk = 0;
>> +			map->m_flags |= ext4_es_is_delayed(&es) ?
>> +					EXT4_MAP_DELAYED : 0;
>>  			retval = es.es_len - (map->m_lblk - es.es_lblk);
>>  			if (retval > map->m_len)
>>  				retval = map->m_len;
>> -- 
>> 2.39.2
>>


