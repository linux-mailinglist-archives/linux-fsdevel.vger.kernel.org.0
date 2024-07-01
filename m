Return-Path: <linux-fsdevel+bounces-22833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF35691D60B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 04:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9431C1F218D9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 02:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9ECC13B;
	Mon,  1 Jul 2024 02:26:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67E8847C;
	Mon,  1 Jul 2024 02:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719800793; cv=none; b=ToGHeKOpoqt2rBbejRAHNsb+31IYnkXz6GD0u00OBSOL0GTPQS5xL8XKiG3jHST8Sn3RAV8ARnWjnskgRqeb9bPKZehSvLaHUA+gg2dPUVRTZtLVrY6G/sGB0qkWKIibV2k4mQ3lVYHNjUETLHgRrIX8lcWvyWSisgyWpalMjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719800793; c=relaxed/simple;
	bh=sSXuzX+WtTkW5UROQw7ByVRKZjhDpJk2+IFTmWsInT0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fPjzfRKrH1omWY8rq75UC6NCUt6jMbD5fsIvTcQilo11VVaKgAwxkQ5JYiubR5LrnOjlzUwme5LH/x0RYc8hV/eRPecAjbyCWLYD7gvhinTWVri+CPzfkAzwfwG6PWjK4Gra6OpUKzt2AY0VcG39yFkRv0VfrFuZJbq5tqWrjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WC8zh10Yqz4f3jHw;
	Mon,  1 Jul 2024 10:26:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 814ED1A016E;
	Mon,  1 Jul 2024 10:26:20 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAnkYbKE4JmQUVRAw--.39659S3;
	Mon, 01 Jul 2024 10:26:20 +0800 (CST)
Subject: Re: [PATCH -next v6 1/2] xfs: reserve blocks for truncating large
 realtime inode
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, chandanbabu@kernel.org,
 John Garry <john.g.garry@oracle.com>, jack@suse.cz, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
 <20240618142112.1315279-2-yi.zhang@huaweicloud.com>
 <ZoIDVHaS8xjha1mA@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <b27977d3-3764-886d-7067-483cea203fbe@huaweicloud.com>
Date: Mon, 1 Jul 2024 10:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZoIDVHaS8xjha1mA@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnkYbKE4JmQUVRAw--.39659S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZr13tr1Dury8ArWrZrb_yoW5ury3pF
	Z7Ca1UKFZ8Xry0kaySyF1ay3Wjkw1rKr42kryYgr1Iv34DXr1ftrn7tr4UKF1UJr4kWa1j
	gr15A3y3Zw15ZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/7/1 9:16, Dave Chinner wrote:
> On Tue, Jun 18, 2024 at 10:21:11PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When unaligned truncate down a big realtime file, xfs_truncate_page()
>> only zeros out the tail EOF block, __xfs_bunmapi() should split the tail
>> written extent and convert the later one that beyond EOF block to
>> unwritten, but it couldn't work as expected now since the reserved block
>> is zero in xfs_setattr_size(), this could expose stale data just after
>> commit '943bc0882ceb ("iomap: don't increase i_size if it's not a write
>> operation")'.
>>
>> If we truncate file that contains a large enough written extent:
>>
>>      |<    rxext    >|<    rtext    >|
>>   ...WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
>>         ^ (new EOF)      ^ old EOF
>>
>> Since we only zeros out the tail of the EOF block, and
>> xfs_itruncate_extents()->..->__xfs_bunmapi() unmap the whole ailgned
>> extents, it becomes this state:
>>
>>      |<    rxext    >|
>>   ...WWWzWWWWWWWWWWWWW
>>         ^ new EOF
>>
>> Then if we do an extending write like this, the blocks in the previous
>> tail extent becomes stale:
>>
>>      |<    rxext    >|
>>   ...WWWzSSSSSSSSSSSSS..........WWWWWWWWWWWWWWWWW
>>         ^ old EOF               ^ append start  ^ new EOF
>>
>> Fix this by reserving XFS_DIOSTRAT_SPACE_RES blocks for big realtime
>> inode.
> 
> This same problem is going to happen with force aligned allocations,
> right? i.e. it is a result of having a allocation block size larger
> than one filesystem block?
> 
Yeah, right.

+cc John

> If so, then....
> 
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/xfs/xfs_iops.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>> index ff222827e550..a00dcbc77e12 100644
>> --- a/fs/xfs/xfs_iops.c
>> +++ b/fs/xfs/xfs_iops.c
>> @@ -17,6 +17,8 @@
>>  #include "xfs_da_btree.h"
>>  #include "xfs_attr.h"
>>  #include "xfs_trans.h"
>> +#include "xfs_trans_space.h"
>> +#include "xfs_bmap_btree.h"
>>  #include "xfs_trace.h"
>>  #include "xfs_icache.h"
>>  #include "xfs_symlink.h"
>> @@ -811,6 +813,7 @@ xfs_setattr_size(
>>  	struct xfs_trans	*tp;
>>  	int			error;
>>  	uint			lock_flags = 0;
>> +	uint			resblks = 0;
>>  	bool			did_zeroing = false;
>>  
>>  	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
>> @@ -917,7 +920,17 @@ xfs_setattr_size(
>>  			return error;
>>  	}
>>  
>> -	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
>> +	/*
>> +	 * For realtime inode with more than one block rtextsize, we need the
>> +	 * block reservation for bmap btree block allocations/splits that can
>> +	 * happen since it could split the tail written extent and convert the
>> +	 * right beyond EOF one to unwritten.
>> +	 */
>> +	if (xfs_inode_has_bigrtalloc(ip))
>> +		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
> 
> .... should this be doing this generic check instead:
> 
> 	if (xfs_inode_alloc_unitsize(ip) > 1)

        if (xfs_inode_alloc_unitsize(ip) > i_blocksize(inode)) ?

> 		resblks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
> 

Yeah, it makes sense to me, but Christoph suggested to think about force
aligned allocations later, so I only dealt with the big RT inode case here.
I can revise it if John and Christoph don't object.

Thanks,
Yi.


