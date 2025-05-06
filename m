Return-Path: <linux-fsdevel+bounces-48167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DD4AABAC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5003B4251
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 07:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AA82690D1;
	Tue,  6 May 2025 04:39:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4727F74C;
	Tue,  6 May 2025 04:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746505748; cv=none; b=AwLJS2Hd8UBhUy3T+V+NS97i8auojBayulh0vo1vgg+vNYYibZJy8z4qEx35nEHEhqyQDC+Vopm/yXammrH/TXA+pt6G1iSmzwTVJvbxTed2XmH+l9fp84i43DAGkGg0ZdPbNOWbYnHDQc+ZKhiKazsO2tAveTLyd6ecgWZWGQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746505748; c=relaxed/simple;
	bh=kN1W1BtRodyCfIAZkZrsBIkamnfL0sCMOrgtYLKdpe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RymSS4i39XXg+sEWI1V9Uok3CrX0Q8G/Aca9NhBQGtGrrYG1CkLCD8IjLIvwD7ffc0i21rxjE+PoMca1fDf2dL9iXPmica1uPCoDbkO6lA0ulUfw2yyeO9mtcuLGvYAjtbtjL29pmCLOxmRnBIRL/Wd8/UP2Z5/tw7CZn8+neWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zs54P5cN5z4f3jq5;
	Tue,  6 May 2025 12:28:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F09591A0C6A;
	Tue,  6 May 2025 12:28:56 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2AGkBlo8EZMLg--.37436S3;
	Tue, 06 May 2025 12:28:56 +0800 (CST)
Message-ID: <c7d8d0c3-7efa-4ee6-b518-f8b09ec87b73@huaweicloud.com>
Date: Tue, 6 May 2025 12:28:54 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
To: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 john.g.garry@oracle.com, bmarzins@redhat.com, chaitanyak@nvidia.com,
 shinichiro.kawasaki@wdc.com, brauner@kernel.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
 <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
 <20250505132208.GA22182@lst.de> <20250505142945.GJ1035866@frogsfrogsfrogs>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20250505142945.GJ1035866@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHK2AGkBlo8EZMLg--.37436S3
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDJr4DZry8Xry8Zw1DWrg_yoW8Aw1fpF
	ykGFy8CF4Fyry7Ca92g3W7Xw1Y9wn3Jr1UXrySkw1jkFZ0qw1Ikry8Kw1j9F13Z3yfCw4x
	Xa47Gry29ayYk37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/5/5 22:29, Darrick J. Wong wrote:
> On Mon, May 05, 2025 at 03:22:08PM +0200, Christoph Hellwig wrote:
>> On Mon, Apr 21, 2025 at 10:15:05AM +0800, Zhang Yi wrote:
>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>
>>> Add a new attribute flag to statx to determine whether a bdev or a file
>>> supports the unmap write zeroes command.
>>>
>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>> ---
>>>  block/bdev.c              | 4 ++++
>>>  fs/ext4/inode.c           | 9 ++++++---
>>>  include/uapi/linux/stat.h | 1 +
>>>  3 files changed, 11 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/bdev.c b/block/bdev.c
>>> index 4844d1e27b6f..29b0e5feb138 100644
>>> --- a/block/bdev.c
>>> +++ b/block/bdev.c
>>> @@ -1304,6 +1304,10 @@ void bdev_statx(struct path *path, struct kstat *stat,
>>>  			queue_atomic_write_unit_max_bytes(bd_queue));
>>>  	}
>>>  
>>> +	if (bdev_write_zeroes_unmap(bdev))
>>> +		stat->attributes |= STATX_ATTR_WRITE_ZEROES_UNMAP;
>>> +	stat->attributes_mask |= STATX_ATTR_WRITE_ZEROES_UNMAP;
>>
>> Hmm, shouldn't this always be set by stat?  But I might just be
>> really confused what attributes_mask is, and might in fact have
>> misapplied it in past patches of my own..
> 
> attributes_mask contains attribute flags known to the filesystem,
> whereas attributes contains flags actually set on the file.
> "known_attributes" would have been a better name, but that's water under
> the bridge. :P
> 
>> Also shouldn't the patches to report the flag go into the bdev/ext4
>> patches that actually implement the feature for the respective files
>> to keep bisectability?
> 
> /I/ think so...
> 

OK, since this statx reporting flag is not strongly tied to
FALLOC_FL_WRITE_ZEROES in vfs_fallocate(), I'll split this patch into
three separate patches.

Thanks,
Yi.


