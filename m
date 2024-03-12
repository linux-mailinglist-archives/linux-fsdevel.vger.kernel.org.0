Return-Path: <linux-fsdevel+bounces-14184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E93878F90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 09:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E4B1C216E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DF69D0B;
	Tue, 12 Mar 2024 08:18:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5D8D30B;
	Tue, 12 Mar 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710231528; cv=none; b=FcF241yVgTlNjZaBFNEbnRhtpbTyI1IB1qaEb80clHK2kXVUKCyUZhn6qVMqsD8mRFSTNII85GPFVAHBQC57H6LgNZZciDfosrR2S3bnYO7XdP+AK3AEccCPMlYJvvRIdCOExygrLV2WUorusm/VWbLMBoLafY9ivz4tV5/j6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710231528; c=relaxed/simple;
	bh=hPd+xJ5jOSC8o1CG2r+WXG2uyyLrv5AmWrxsGZg+GLg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=EUXlMogEXL2ovJiojKypNOGRL5R5+89FqNZSc3qX8JCo2Nh0FO/1Jow95Jt7dwbUafTIhku9q+2XHWXgLP2D6+lgcgHLNdQKaFfzkpyrIarovWRLgSH4u8IcnBj8aqnVunv8tbtgXHqc4MfZ09UEKCs+npmMJwVoGdV8xXTIguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tv63W6RRPz4f3jqP;
	Tue, 12 Mar 2024 16:18:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8ADC71A0199;
	Tue, 12 Mar 2024 16:18:35 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBHZD_BlXa7TGg--.10688S3;
	Tue, 12 Mar 2024 16:18:35 +0800 (CST)
Subject: Re: [PATCH 1/4] xfs: match lock mode in
 xfs_buffered_write_iomap_begin()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240311122255.2637311-1-yi.zhang@huaweicloud.com>
 <20240311122255.2637311-2-yi.zhang@huaweicloud.com>
 <20240311153415.GS1927156@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <04c14e02-9968-3fda-39a6-c3b44c78a2ba@huaweicloud.com>
Date: Tue, 12 Mar 2024 16:18:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240311153415.GS1927156@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXKBHZD_BlXa7TGg--.10688S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJFyUAr4xCr47JryDuFy8Zrb_yoW5XF15pr
	n7KayqkrZ2vF1Yvr40qryYvF10g3W7Jw1UAr15Wan3uw1Dtr4fKr4093Wru3W8Ars2k34v
	gF4UGr1ku34ayFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/3/11 23:34, Darrick J. Wong wrote:
> On Mon, Mar 11, 2024 at 08:22:52PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Commit 1aa91d9c9933 ("xfs: Add async buffered write support") replace
>> xfs_ilock(XFS_ILOCK_EXCL) with xfs_ilock_for_iomap() when locking the
>> writing inode, and a new variable lockmode is used to indicate the lock
>> mode. Although the lockmode should always be XFS_ILOCK_EXCL, it's still
>> better to use this variable instead of useing XFS_ILOCK_EXCL directly
>> when unlocking the inode.
>>
>> Fixes: 1aa91d9c9933 ("xfs: Add async buffered write support")
> 
> AFAICT, xfs_ilock_for_iomap can change lockmode from SHARED->EXCL, but
> never changed away from EXCL, right?  

Yes.

> And xfs_buffered_write_iomap_begin
> sets it to EXCL (and never changes it), right?

Yes.

> 
> This seems like more of a code cleanup/logic bomb removal than an actual
> defect that someone could actually hit, correct?
> 

Yes, it's not a real problem.

> If the answers are {yes, yes, yes} then:
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> 
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/xfs/xfs_iomap.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 18c8f168b153..ccf83e72d8ca 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -1149,13 +1149,13 @@ xfs_buffered_write_iomap_begin(
>>  	 * them out if the write happens to fail.
>>  	 */
>>  	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_NEW);
>> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +	xfs_iunlock(ip, lockmode);
>>  	trace_xfs_iomap_alloc(ip, offset, count, allocfork, &imap);
>>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, IOMAP_F_NEW, seq);
>>  
>>  found_imap:
>>  	seq = xfs_iomap_inode_sequence(ip, 0);
>> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +	xfs_iunlock(ip, lockmode);
>>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
>>  
>>  found_cow:
>> @@ -1165,17 +1165,17 @@ xfs_buffered_write_iomap_begin(
>>  		if (error)
>>  			goto out_unlock;
>>  		seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
>> -		xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +		xfs_iunlock(ip, lockmode);
>>  		return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags,
>>  					 IOMAP_F_SHARED, seq);
>>  	}
>>  
>>  	xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
>> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +	xfs_iunlock(ip, lockmode);
>>  	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, 0, seq);
>>  
>>  out_unlock:
>> -	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +	xfs_iunlock(ip, lockmode);
>>  	return error;
>>  }
>>  
>> -- 
>> 2.39.2
>>
>>


