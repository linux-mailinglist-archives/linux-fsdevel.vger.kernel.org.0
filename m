Return-Path: <linux-fsdevel+bounces-20830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F4C8D8467
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 15:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924552830A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDD912E1ED;
	Mon,  3 Jun 2024 13:51:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307E12DDAE;
	Mon,  3 Jun 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717422685; cv=none; b=cge99zofr2tDmXQIQ+ZsgunahQqtDAkY7kOm1PelvSsXBxAbKy5k/umzLL8vf8b2Sr0StVqZwXi5+Ue7KrwqC1sIRfoNIX5ExHXoKOBcxt8W2EZe4Zbafty+0plPE1RFJ6UjVT/coY2BvjhBQdIp9CIEXtEpyNy3GLxJVy9AjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717422685; c=relaxed/simple;
	bh=HKKTu5vhAUsqBzR4kRXK9CCm8TDx2Kz71laD8niO1YI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BOQaDV888Hh8b7Bn3vGy0jMiOIqCm5QgmmpsTl1FBWR9hoYPojD2trgPmXxv3mexX1CKvXV+l2qkB36z/QX26HBOFNyF7AQpvY7Vcm3SMO0ccmLY58ufGErI4XP8PxjW62npgn8bqHfQ2Xw7uNsrGv4wc+V+24DMg9/f4NN95ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VtFW11hWcz4f3jXr;
	Mon,  3 Jun 2024 21:51:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C95761A0170;
	Mon,  3 Jun 2024 21:51:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAXOQxUyl1mA7BNOw--.32316S3;
	Mon, 03 Jun 2024 21:51:18 +0800 (CST)
Subject: Re: [RFC PATCH v4 5/8] xfs: refactor the truncating order
To: "Darrick J. Wong" <djwong@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, david@fromorbit.com,
 chandanbabu@kernel.org, jack@suse.cz, willy@infradead.org,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-6-yi.zhang@huaweicloud.com>
 <ZlnRODP_b8bhXOEE@infradead.org> <20240531152732.GM52987@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <de2c345e-6892-f3c1-09a9-cdf5991cca7e@huaweicloud.com>
Date: Mon, 3 Jun 2024 21:51:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240531152732.GM52987@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXOQxUyl1mA7BNOw--.32316S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urykXw18WFy7KFWkKrW5GFg_yoW8Aw4xpr
	W3CasYvr1kKr1UAr18X3W0qwna9a98tayxJr95WFn7KF98uryfXF1xtryjgF4UArn3Ww4S
	qa1DW34fCwn5AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/31 23:27, Darrick J. Wong wrote:
> On Fri, May 31, 2024 at 06:31:36AM -0700, Christoph Hellwig wrote:
>>> +	write_back = newsize > ip->i_disk_size && oldsize != ip->i_disk_size;
>>
>> Maybe need_writeback would be a better name for the variable?  Also no
>> need to initialize it to false at declaration time if it is
>> unconditionally set here.
> 
> This variable captures whether or not we need to write dirty file tail
> data because we're extending the ondisk EOF, right?
> 
> I don't really like long names like any good 1980s C programmer, but
> maybe we should name this something like "extending_ondisk_eof"?
> 
> 	if (newsize > ip->i_disk_size && oldsize != ip->i_disk_size)
> 		extending_ondisk_eof = true;
> 
> 	...
> 
> 	if (did_zeroing || extending_ondisk_eof)
> 		filemap_write_and_wait_range(...);
> 
> Hm?

Sure, this name looks better.

> 
>>> +		/*
>>> +		 * Updating i_size after writing back to make sure the zeroed
>>> +		 * blocks could been written out, and drop all the page cache
>>> +		 * range that beyond blocksize aligned new EOF block.
>>> +		 *
>>> +		 * We've already locked out new page faults, so now we can
>>> +		 * safely remove pages from the page cache knowing they won't
>>> +		 * get refaulted until we drop the XFS_MMAP_EXCL lock after the
> 
> And can we correct the comment here too?
> 
> "...until we drop XFS_MMAPLOCK_EXCL after the extent manipulations..."
> 

Sure,

> --D
> 
>>> +		 * extent manipulations are complete.
>>> +		 */
>>> +		i_size_write(inode, newsize);
>>> +		truncate_pagecache(inode, roundup_64(newsize, blocksize));
>>
>> Any reason this open codes truncate_setsize()?
>>

It's not equal to open codes truncate_setsize(), please look the truncate
start pos is aligned to rtextsize for realtime inode, we only drop page
cache that beyond the new aligned EOF block.

Thanks,
Yi.


