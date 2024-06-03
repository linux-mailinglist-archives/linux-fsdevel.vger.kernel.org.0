Return-Path: <linux-fsdevel+bounces-20836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD7C8D84C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 16:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CED31F22FA0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C463C12EBC2;
	Mon,  3 Jun 2024 14:18:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94712E1D4;
	Mon,  3 Jun 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424307; cv=none; b=S9DZZiSfOZf8A1WQDAZnN1iSTV3M7x5fwl09s0OnGjYNPvnTtjk0RwxZiVAiO16Q3c7hL60qyp7Wm9xgSeN5tsDjuJZl5KSL03Er8x4fyrCwCSDjnlCj1hTizNTR6+jHZpWIB8C/Wr0SGdxIdD/Y/jQnVyoAfEb2FWoibyUny9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424307; c=relaxed/simple;
	bh=YGUCY5XSDZtoZq0KF3cnbziMON1Tn+cspwU/+juyK2Q=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Wxz1+h5K/9x+YI9vE1+E05V5zorTqzjuLUL1WjD8aoxa8qOWuIPiFGL7AY+xeXYNafgpiao5joziC7yJqp09lfC4llDs2D02mh0nE8VRl/SY8f/j3IBg8SAy9lWz0pGU5PfqMhl5hJgY1KfCzGoR3P8iFlqkr2acjlxifhfhpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VtG6H49SMz4f3kkd;
	Mon,  3 Jun 2024 22:18:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id CA8C81A016E;
	Mon,  3 Jun 2024 22:18:21 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXPA+s0F1meXhPOw--.50390S3;
	Mon, 03 Jun 2024 22:18:21 +0800 (CST)
Subject: Re: [RFC PATCH v4 5/8] xfs: refactor the truncating order
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, chandanbabu@kernel.org, jack@suse.cz,
 willy@infradead.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-6-yi.zhang@huaweicloud.com>
 <Zlz2UCS4jqQO3Vm6@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <b4f354f7-7885-8f25-90dd-bec54daba405@huaweicloud.com>
Date: Mon, 3 Jun 2024 22:18:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zlz2UCS4jqQO3Vm6@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXPA+s0F1meXhPOw--.50390S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy8Kr1kWrykCFy3XFy8uFg_yoW5uFy3pF
	y7Ca4DGrZ7KFyUAr1vvFn5Jw1Sg3yrJFW8Ary3trn7CFs5Xw1xtF9rt340gayDGrs7G3WF
	vFs0qrZxZwn5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbPEf5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/6/3 6:46, Dave Chinner wrote:
> On Wed, May 29, 2024 at 05:52:03PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When truncating down an inode, we call xfs_truncate_page() to zero out
>> the tail partial block that beyond new EOF, which prevents exposing
>> stale data. But xfs_truncate_page() always assumes the blocksize is
>> i_blocksize(inode), it's not always true if we have a large allocation
>> unit for a file and we should aligned to this unitsize, e.g. realtime
>> inode should aligned to the rtextsize.
>>
>> Current xfs_setattr_size() can't support zeroing out a large alignment
>> size on trucate down since the process order is wrong. We first do zero
>> out through xfs_truncate_page(), and then update inode size through
>> truncate_setsize() immediately. If the zeroed range is larger than a
>> folio, the write back path would not write back zeroed pagecache beyond
>> the EOF folio, so it doesn't write zeroes to the entire tail extent and
>> could expose stale data after an appending write into the next aligned
>> extent.
>>
>> We need to adjust the order to zero out tail aligned blocks, write back
>> zeroed or cached data, update i_size and drop cache beyond aligned EOF
>> block, preparing for the fix of realtime inode and supporting the
>> upcoming forced alignment feature.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
> .....
>> @@ -853,30 +854,7 @@ xfs_setattr_size(
>>  	 * the transaction because the inode cannot be unlocked once it is a
>>  	 * part of the transaction.
>>  	 *
>> -	 * Start with zeroing any data beyond EOF that we may expose on file
>> -	 * extension, or zeroing out the rest of the block on a downward
>> -	 * truncate.
>> -	 */
>> -	if (newsize > oldsize) {
>> -		trace_xfs_zero_eof(ip, oldsize, newsize - oldsize);
>> -		error = xfs_zero_range(ip, oldsize, newsize - oldsize,
>> -				&did_zeroing);
>> -	} else if (newsize != oldsize) {
>> -		error = xfs_truncate_page(ip, newsize, &did_zeroing);
>> -	}
>> -
>> -	if (error)
>> -		return error;
>> -
>> -	/*
>> -	 * We've already locked out new page faults, so now we can safely remove
>> -	 * pages from the page cache knowing they won't get refaulted until we
>> -	 * drop the XFS_MMAP_EXCL lock after the extent manipulations are
>> -	 * complete. The truncate_setsize() call also cleans partial EOF page
>> -	 * PTEs on extending truncates and hence ensures sub-page block size
>> -	 * filesystems are correctly handled, too.
>> -	 *
>> -	 * We have to do all the page cache truncate work outside the
>> +	 * And we have to do all the page cache truncate work outside the
>>  	 * transaction context as the "lock" order is page lock->log space
>>  	 * reservation as defined by extent allocation in the writeback path.
>>  	 * Hence a truncate can fail with ENOMEM from xfs_trans_alloc(), but
> ......
> 
> Lots of new logic for zeroing here. That makes xfs_setattr_size()
> even longer than it already is. Can you lift this EOF zeroing logic
> into it's own helper function so that it is clear that it is a
> completely independent operation to the actual transaction that
> changes the inode size. That would also allow the operations to be
> broken up into:
> 
> 	if (newsize >= oldsize) {
> 		/* do the simple stuff */
> 		....
> 		return error;
> 	}
> 	/* do the complex size reduction stuff without additional indenting */
> 

Sure, I will try to factor them out.

Thanks,
Yi.


