Return-Path: <linux-fsdevel+bounces-21758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1979097FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 13:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93EDC1F21A43
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F173F9C5;
	Sat, 15 Jun 2024 11:44:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BDC374F1;
	Sat, 15 Jun 2024 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718451876; cv=none; b=nTkRSe8IX9lwaSu7gdtfqxYsMrC5UWli73P57r6Ln0Km3bZyG0kzpJ5Z1DFKUTr1eU+pj8+Fz9ZQRQ16SEeP8+DqJvqd2V0dheZCw+g/atY6PseB8Tfg/ukdlIJBYMssdP+Jh8WxduvN2NT7XZ3fUScfKFpfV7gt1TcFHvWRZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718451876; c=relaxed/simple;
	bh=68lts4Ju0T7CR+5pmBNYENZcBYUucTr+vBM8YPISqOI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YBebKmPcmPLnrzYRNQZQUgiOYjTgjoLB7pMSi71qenblQ6A9shyu6zU3mwwgEPGETp76cFHelOGILsIfRzHKRnEHTGQcrfbdJwsp6cJXH7NEQb80JkYhTPBa3ElwQO6m4KtkWJyt3A6j6Ht5YbR+5SAWEKjmao9Yv2nMrHeUi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W1Z713vqfz4f3jdr;
	Sat, 15 Jun 2024 19:44:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B7FFB1A0568;
	Sat, 15 Jun 2024 19:44:23 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP1 (Coremail) with SMTP id cCh0CgBnGw2Vfm1m91gAAA--.148S3;
	Sat, 15 Jun 2024 19:44:23 +0800 (CST)
Subject: Re: [PATCH -next v5 7/8] xfs: speed up truncating down a big realtime
 inode
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 John Garry <john.g.garry@oracle.com>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
 <20240613090033.2246907-8-yi.zhang@huaweicloud.com>
 <ZmveZolfY0Q0--1k@infradead.org>
 <399680eb-cd60-4c27-ef2b-2704e470d228@huaweicloud.com>
 <ZmwJuiMHQ8qgkJDS@infradead.org>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <ecd7a5cf-4939-947a-edd4-0739dc73870b@huaweicloud.com>
Date: Sat, 15 Jun 2024 19:44:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZmwJuiMHQ8qgkJDS@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnGw2Vfm1m91gAAA--.148S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr15KF1xJr1kJFWxGF4kJFb_yoW8Zr47pr
	W5ua4DAr9Yq345C3srA3Z7Xa4Fkw1Fka18XF15Zr4UAF9xWFy3CFnaqa15Xa1ku3y8uFW0
	vF4qqF9xGr17AFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/6/14 17:13, Christoph Hellwig wrote:
> On Fri, Jun 14, 2024 at 03:18:07PM +0800, Zhang Yi wrote:
>> Thanks for your suggestion.
>>
>> Yeah, we could fix the realtime inode problem by just drop this part, but
>> for the upcoming forcealign feature and atomic feature by John, IIUC, we
>> couldn't split and convert the tail extent like RT inode does, we should
>> zero out the entire tail force aligned extent, if not, atomic write could
>> be broken by submitting unaligned bios.
> 
> Let's worry about that if/when those actually land.

OK, if we don't consider the upcoming forcealign feature and atomic feature,
I think only path 6 is needed to fix the issue.

> I also see no
> rason why those couldn't just use partially convert to unwritten path
> offhand (but without having looked into the details).
> 

The reason why atomic feature can't split and convert the tail extent on truncate
down now is the dio write iter loop will split an atomic dio which covers the
whole allocation unit(extsize) since there are two extents in on allocation unit.

Please see this code:
__iomap_dio_rw()
{
	...
	while ((ret = iomap_iter(&iomi, ops)) > 0) {
		iomi.processed = iomap_dio_iter(&iomi, dio);
	...
}

The first loop find and submit the frist extent and the second loop submit the
second extent, this breaks the atomic property.

For example, we have a file with only one extszie length，if we truncate down
and split the extent, the file becomes below,

  |   forced extsize (one atomic IO unit)  |
  wwwwwwwwwwwwww+uuuuuuuuuuuuuuuuuuuuuuuuuuu
                ^new size A                ^old size B

Then if we submit a DIO from 0 to B, xfs should submit it in one bio, but it
will submit to two bios, since there are two extents. So, unless we find
another way to guarantee submit one bio even we have two extents in one atomic
write unit (I guess it may complicated), we have to zero out the whole unit
when truncate down(I'd prefer this solution), we need consider this in the near
future.

Thanks,
Yi.


