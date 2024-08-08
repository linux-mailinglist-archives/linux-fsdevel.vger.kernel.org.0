Return-Path: <linux-fsdevel+bounces-25412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E55394BC20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 13:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EDF1F21CB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 11:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B018B469;
	Thu,  8 Aug 2024 11:21:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362ED10F9;
	Thu,  8 Aug 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116085; cv=none; b=MSamnzNMVmD9gJjRxqLbTG1Jg3GMb9qC1yBN3q2W/+FB8iUk+j2l67nlnz1vFc7Gu0yeg4GDU+yXhwQLvc7+G7VzbhC8YlMzuP54L3E4HcqS+qNsucPhH327E2QqE//RF2UH9vEGNNSvEFyemnIOC5cUei06BrkwMzVnRs1k4WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116085; c=relaxed/simple;
	bh=skkSAUV3Rn4fx++hjnrhmqCvMbVDJkY2rscuCc4fNuE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=R4vhcYGqU3um8GVDylwllBoMueKWBwknla5h0AkSQP/7pAaNRI+1hWp/gFSwz39AkmrQfF41WftZlDi0tkn93+oBFQ7AtNBNMSxNSFUc66CyRqrPJ0VYQNyDTIgST0aLHs2zA4ZEeHYjC6SXOtWPrhhpvC9jxPUoKQPPgA9/nSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wfl3T2jDzz4f3jkL;
	Thu,  8 Aug 2024 19:21:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 68F9E1A058E;
	Thu,  8 Aug 2024 19:21:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4UtqrRmSL9zBA--.1576S3;
	Thu, 08 Aug 2024 19:21:18 +0800 (CST)
Subject: Re: [PATCH v2 09/10] ext4: drop ext4_es_is_delonly()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240802115120.362902-1-yi.zhang@huaweicloud.com>
 <20240802115120.362902-10-yi.zhang@huaweicloud.com>
 <20240807174818.bt6b4qhub7ydy5r5@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <d71862a9-aeee-0db1-31de-2883cb32c28e@huaweicloud.com>
Date: Thu, 8 Aug 2024 19:21:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240807174818.bt6b4qhub7ydy5r5@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCXv4UtqrRmSL9zBA--.1576S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFy7Xw4fKF47KF1rJryfXrb_yoW7CF1rpr
	Z5JF1UGr45W34Uu3yIqF1qqr1Yga10qrWUGrWSkF1fXFyrJr1SkF10kFy8uFyFkrW8ZF12
	qFWUtw1UCa17Ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UQ6p9UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/8 1:48, Jan Kara wrote:
> On Fri 02-08-24 19:51:19, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Since we don't add delayed flag in unwritten extents, so there is no
>> difference between ext4_es_is_delayed() and ext4_es_is_delonly(),
>> just drop ext4_es_is_delonly().
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks good. But please also add assertion when inserting extent into status
> tree that only one of EXTENT_STATUS_WRITTEN, EXTENT_STATUS_UNWRITTEN,
> EXTENT_STATUS_DELAYED, and EXTENT_STATUS_HOLE is set.
> Also perhaps add comment to EXTENT_STATUS_DELAYED (and other) definition that
> these states are exclusive. Thanks!
> 

Sure, will do. Thanks for the suggestion,

Yi.

> 
>> ---
>>  fs/ext4/extents_status.c | 18 +++++++++---------
>>  fs/ext4/extents_status.h |  5 -----
>>  fs/ext4/inode.c          |  4 ++--
>>  3 files changed, 11 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index e482ac818317..5fb0a02405ba 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -563,8 +563,8 @@ static int ext4_es_can_be_merged(struct extent_status *es1,
>>  	if (ext4_es_is_hole(es1))
>>  		return 1;
>>  
>> -	/* we need to check delayed extent is without unwritten status */
>> -	if (ext4_es_is_delayed(es1) && !ext4_es_is_unwritten(es1))
>> +	/* we need to check delayed extent */
>> +	if (ext4_es_is_delayed(es1))
>>  		return 1;
>>  
>>  	return 0;
>> @@ -1139,7 +1139,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>>  	ext4_lblk_t i, end, nclu;
>>  
>> -	if (!ext4_es_is_delonly(es))
>> +	if (!ext4_es_is_delayed(es))
>>  		return;
>>  
>>  	WARN_ON(len <= 0);
>> @@ -1291,7 +1291,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>>  		es = rc->left_es;
>>  		while (es && ext4_es_end(es) >=
>>  		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
>> -			if (ext4_es_is_delonly(es)) {
>> +			if (ext4_es_is_delayed(es)) {
>>  				rc->ndelonly_cluster--;
>>  				left_delonly = true;
>>  				break;
>> @@ -1311,7 +1311,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
>>  			}
>>  			while (es && es->es_lblk <=
>>  			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
>> -				if (ext4_es_is_delonly(es)) {
>> +				if (ext4_es_is_delayed(es)) {
>>  					rc->ndelonly_cluster--;
>>  					right_delonly = true;
>>  					break;
>> @@ -2239,7 +2239,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>>  	if (EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) {
>>  		first = EXT4_LBLK_CMASK(sbi, lblk);
>>  		if (first != lblk)
>> -			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
>> +			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
>>  						first, lblk - 1);
>>  		if (f_del) {
>>  			ret = __insert_pending(inode, first, prealloc);
>> @@ -2251,7 +2251,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>>  			       sbi->s_cluster_ratio - 1;
>>  			if (last != end)
>>  				l_del = __es_scan_range(inode,
>> -							&ext4_es_is_delonly,
>> +							&ext4_es_is_delayed,
>>  							end + 1, last);
>>  			if (l_del) {
>>  				ret = __insert_pending(inode, last, prealloc);
>> @@ -2264,7 +2264,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>>  	} else {
>>  		first = EXT4_LBLK_CMASK(sbi, lblk);
>>  		if (first != lblk)
>> -			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
>> +			f_del = __es_scan_range(inode, &ext4_es_is_delayed,
>>  						first, lblk - 1);
>>  		if (f_del) {
>>  			ret = __insert_pending(inode, first, prealloc);
>> @@ -2276,7 +2276,7 @@ static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
>>  
>>  		last = EXT4_LBLK_CMASK(sbi, end) + sbi->s_cluster_ratio - 1;
>>  		if (last != end)
>> -			l_del = __es_scan_range(inode, &ext4_es_is_delonly,
>> +			l_del = __es_scan_range(inode, &ext4_es_is_delayed,
>>  						end + 1, last);
>>  		if (l_del) {
>>  			ret = __insert_pending(inode, last, prealloc);
>> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
>> index 5b49cb3b9aff..e484c60e55e3 100644
>> --- a/fs/ext4/extents_status.h
>> +++ b/fs/ext4/extents_status.h
>> @@ -184,11 +184,6 @@ static inline int ext4_es_is_mapped(struct extent_status *es)
>>  	return (ext4_es_is_written(es) || ext4_es_is_unwritten(es));
>>  }
>>  
>> -static inline int ext4_es_is_delonly(struct extent_status *es)
>> -{
>> -	return (ext4_es_is_delayed(es) && !ext4_es_is_unwritten(es));
>> -}
>> -
>>  static inline void ext4_es_set_referenced(struct extent_status *es)
>>  {
>>  	es->es_pblk |= ((ext4_fsblk_t)EXTENT_STATUS_REFERENCED) << ES_SHIFT;
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 8bd65a45a26a..2b301c165468 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1645,7 +1645,7 @@ static int ext4_clu_alloc_state(struct inode *inode, ext4_lblk_t lblk)
>>  	int ret;
>>  
>>  	/* Has delalloc reservation? */
>> -	if (ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
>> +	if (ext4_es_scan_clu(inode, &ext4_es_is_delayed, lblk))
>>  		return 1;
>>  
>>  	/* Already been allocated? */
>> @@ -1766,7 +1766,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>>  		 * Delayed extent could be allocated by fallocate.
>>  		 * So we need to check it.
>>  		 */
>> -		if (ext4_es_is_delonly(&es)) {
>> +		if (ext4_es_is_delayed(&es)) {
>>  			map->m_flags |= EXT4_MAP_DELAYED;
>>  			return 0;
>>  		}
>> -- 
>> 2.39.2
>>


