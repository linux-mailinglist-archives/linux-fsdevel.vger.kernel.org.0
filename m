Return-Path: <linux-fsdevel+bounces-20032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B478CCA8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 04:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20558282459
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 02:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B502C4685;
	Thu, 23 May 2024 02:00:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CECD6FB9;
	Thu, 23 May 2024 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716429611; cv=none; b=O002i80YUmthVFMHIxCnArDud8l6unHvgL6afQwx1sZPmqDEnSuMhlj6gSj5naJyFtsEqBTj1u8S/p8Kbma36a94wf6pQVmRAR4LMxYtLQaSBeVfaxQwPYZjq9/3dFINccCQnD4TDR0lFTnc3L8clz4ZqYHsK+6BPfibbsP68cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716429611; c=relaxed/simple;
	bh=nhCPewS1z5PaPTyemrch/Z3VzSgGoYpoFUicHPWxQVY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H0t5zkbJI8FVlKV6zWEzxI0l6qrGSW+aJ13OuVQ5p0DObiTHfNud9oLgzkq7mj/0mZ2MdzMg2SPqSIPLMXBroaxs+1SxQedrM1mNns1lrfNItyaej+bQ9jQhIavMmED6Mu1DjhDd4uqXTawSgf6O7zDz22OTofKcm/zDfgU+nKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VlBFV2NwWz4f3jQd;
	Thu, 23 May 2024 09:59:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 255B11A0CD9;
	Thu, 23 May 2024 10:00:04 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgCnyw4io05myMQANw--.37203S3;
	Thu, 23 May 2024 10:00:03 +0800 (CST)
Subject: Re: [PATCH v3 3/3] xfs: correct the zeroing truncate range
To: Dave Chinner <david@fromorbit.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, djwong@kernel.org,
 hch@infradead.org, brauner@kernel.org, chandanbabu@kernel.org, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240517111355.233085-1-yi.zhang@huaweicloud.com>
 <20240517111355.233085-4-yi.zhang@huaweicloud.com>
 <ZkwJJuFCV+WQLl40@dread.disaster.area>
 <122ab6ed-147b-517c-148d-7cb35f7f888b@huaweicloud.com>
 <Zk6XqIcO+7+VPn35@dread.disaster.area>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <92cec08a-7fe7-1cc7-7a39-7f3d5fbc087b@huaweicloud.com>
Date: Thu, 23 May 2024 10:00:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zk6XqIcO+7+VPn35@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnyw4io05myMQANw--.37203S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr13urW3Cw1xAr45Wr1Utrb_yoW5Cry8pF
	WUGa4UKr4kA3yDC34IyFn2qw1Fyw1rJrW8uryrtw12kas8X342yFyjgFWFkFyUuFZ3Gr12
	vF4jy3y3Zwn5A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/5/23 9:11, Dave Chinner wrote:
> On Wed, May 22, 2024 at 09:57:13AM +0800, Zhang Yi wrote:
>> On 2024/5/21 10:38, Dave Chinner wrote:
>>> We can do all this with a single writeback operation if we are a
>>> little bit smarter about the order of operations we perform and we
>>> are a little bit smarter in iomap about zeroing dirty pages in the
>>> page cache:
>>>
>>> 	1. change iomap_zero_range() to do the right thing with
>>> 	dirty unwritten and cow extents (the patch I've been working
>>> 	on).
>>>
>>> 	2. pass the range to be zeroed into iomap_truncate_page()
>>> 	(the fundamental change being made here).
>>>
>>> 	3. zero the required range *through the page cache*
>>> 	(iomap_zero_range() already does this).
>>>
>>> 	4. write back the XFS inode from ip->i_disk_size to the end
>>> 	of the range zeroed by iomap_truncate_page()
>>> 	(xfs_setattr_size() already does this).
>>>
>>> 	5. i_size_write(newsize);
>>>
>>> 	6. invalidate_inode_pages2_range(newsize, -1) to trash all
>>> 	the page cache beyond the new EOF without doing any zeroing
>>> 	as we've already done all the zeroing needed to the page
>>> 	cache through iomap_truncate_page().
>>>
>>>
>>> The patch I'm working on for step 1 is below. It still needs to be
>>> extended to handle the cow case, but I'm unclear on how to exercise
>>> that case so I haven't written the code to do it. The rest of it is
>>> just rearranging the code that we already use just to get the order
>>> of operations right. The only notable change in behaviour is using
>>> invalidate_inode_pages2_range() instead of truncate_pagecache(),
>>> because we don't want the EOF page to be dirtied again once we've
>>> already written zeroes to disk....
>>>
>>
>> Indeed, this sounds like the best solution. Since Darrick recommended
>> that we could fix the stale data exposure on realtime inode issue by
>> convert the tail extent to unwritten, I suppose we could do this after
>> fixing the problem.
> 
> We also need to fix the truncate issue for the upcoming forced
> alignment feature (for atomic writes), and in that case we are
> required to write zeroes to the entire tail extent. i.e. forced
> alignment does not allow partial unwritten extent conversion of
> the EOF extent.
> 

Yes, right. I noticed that feature also needs to fix.

> Hence I think we want to fix the problem by zeroing the entire EOF
> extent first, then optimise the large rtextsize case to use
> unwritten extents if that tail zeroing proves to be a performance
> issue.
> 
> I say "if" because the large rtextsize case will still need to write
> zeroes for the fsb that spans EOF. Adding conversion of the rest of
> the extent to unwritten may well be more expensive (in terms of both
> CPU and IO requirements for the transactional metadata updates) than
> just submitting a slightly larger IO containing real zeroes and
> leaving it as a written extent....
> 

Yeah, if the rtextsize if not large (in most cases), I'm pretty sure
that writing zeros would better. If the rtextsize is large enough, I
think it deserves a performance test.

Thanks,
Yi.


