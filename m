Return-Path: <linux-fsdevel+bounces-14852-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1688093F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 02:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D91284096
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 01:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F979EA;
	Wed, 20 Mar 2024 01:51:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A091B6FC3;
	Wed, 20 Mar 2024 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710899501; cv=none; b=BTm91Gy6zbImI1aA/pRPuxC7fG21ddEneuBZjMqPqAht9e8e4AUo67B9jPv3VC3Pvp2xhSqXL0hMssRbIyTe+BJ6O3Zlr0OK0lb9F3/n1wLkNN0jt7m6dLY9va+R0KhZXBxfuvV0UP2NzPy3VmUGQu8NcFiSmdiD9rS9o1AQfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710899501; c=relaxed/simple;
	bh=saxoGu9UZdW8TBh8QByEj0Of2/jE//AXv/FgCbPO3sI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IXXoahQAmVjfVbpAAJqJKHzsE5i4Ay39nhAQfZKcDOJ7rhyq2J4tONfNSaDMvbwUWMwwmjNdFLok5DpW3rJbi9FNt/YEfR6eN2AlPSFCCx6AMZO+sgZ9Wz56hHyZ7jfkCV+UjIOF9sta0/8qWMdSZgCigMod/cCm2gAFLz2EgXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tzs583xHVz4f3jZT;
	Wed, 20 Mar 2024 09:51:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 672681A0199;
	Wed, 20 Mar 2024 09:51:28 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBEeQfplZGn3HQ--.57221S3;
	Wed, 20 Mar 2024 09:51:28 +0800 (CST)
Subject: Re: [PATCH v3 3/9] xfs: make xfs_bmapi_convert_delalloc() to allocate
 the target offset
To: "Darrick J. Wong" <djwong@kernel.org>, hch@infradead.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, david@fromorbit.com,
 tytso@mit.edu, jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240319011102.2929635-1-yi.zhang@huaweicloud.com>
 <20240319011102.2929635-4-yi.zhang@huaweicloud.com>
 <20240319204552.GG1927156@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <054ac072-4ccf-b83c-cc9c-cbb5d6f5dbdb@huaweicloud.com>
Date: Wed, 20 Mar 2024 09:51:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240319204552.GG1927156@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXaBEeQfplZGn3HQ--.57221S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CryftrW5trWUZFy8KrWkXrb_yoW8uFW8pF
	Z3KaySkF4vqw1fuFnayF1Yqa4fKa1xGr4jyF4furn3Z345Zr1fWF12kr1Fq34UCrySq3Wj
	qa1UJ3W7Ww4Yva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/3/20 4:45, Darrick J. Wong wrote:
> On Tue, Mar 19, 2024 at 09:10:56AM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Since xfs_bmapi_convert_delalloc() only attempts to allocate the entire
>> delalloc extent and require multiple invocations to allocate the target
>> offset. So xfs_convert_blocks() add a loop to do this job and we call it
>> in the write back path, but xfs_convert_blocks() isn't a common helper.
>> Let's do it in xfs_bmapi_convert_delalloc() and drop
>> xfs_convert_blocks(), preparing for the post EOF delalloc blocks
>> converting in the buffered write begin path.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/xfs/libxfs/xfs_bmap.c | 34 +++++++++++++++++++++++--
>>  fs/xfs/xfs_aops.c        | 54 +++++++++++-----------------------------
>>  2 files changed, 46 insertions(+), 42 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index 07dc35de8ce5..042e8d3ab0ba 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -4516,8 +4516,8 @@ xfs_bmapi_write(
>>   * invocations to allocate the target offset if a large enough physical extent
>>   * is not available.
>>   */
>> -int
>> -xfs_bmapi_convert_delalloc(
>> +static int
> 
> static inline?
> 

I'd suggest to leave that to the compiler too.

>> +__xfs_bmapi_convert_delalloc(
> 
> Double underscore prefixes read to me like "do this without grabbing
> a lock or a resource", not just one step in a loop.
> 
> Would you mind changing it to xfs_bmapi_convert_one_delalloc() ?
> Then the callsite looks like:
> 
> xfs_bmapi_convert_delalloc(...)
> {
> 	...
> 	do {
> 		error = xfs_bmapi_convert_one_delalloc(ip, whichfork, offset,
> 					iomap, seq);
> 		if (error)
> 			return error;
> 	} while (iomap->offset + iomap->length <= offset);
> }
> 

Thanks for your suggestions, all subsequent improvements in this series are
also looks fine by me, I will revise them in my next iteration. Christoph,
I will keep your review tag, please let me know if you have different
opinion.

Thanks,
Yi.


