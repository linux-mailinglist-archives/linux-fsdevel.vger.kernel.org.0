Return-Path: <linux-fsdevel+bounces-16755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 357FD8A2323
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 03:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3E4B211B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0914DDC9;
	Fri, 12 Apr 2024 01:14:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A5D517;
	Fri, 12 Apr 2024 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712884492; cv=none; b=gNLQQK6HhHouFpF1mN7rZnwh/rKkBc509h34mItfa0mDraZ8WbMpOoW9hXBcXdVN2upxCOQ8HirYFrw/NZxEHV9SBxoy9m5dTTqmH+4fj3xk2fGVLIV4gmYR2XSRs1VNZbZgvmkVQ4OnTf9qTFbIF4Et98EWWx8mRPKDq3WMU7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712884492; c=relaxed/simple;
	bh=7QELeBrQbBDtK85nuDk06HjEg/RAH0JG6uBAJiIYmM0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lm6IAybE42wNnTzWDySz6wN1CFfJtoN6i1HeNRKPGEogNJrk5ifF7MjoFls3MjOMRjEIK0flWH9vVc/Ebd0kSmOo4u+7ni7Ko8dqgKt5RCnBkYTXrlzyef6VExB3EmJWqqol+Zc9RTbZRntzNxMux5+ok/ECtr0omAWe53HKYh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VFzB12wwvz4f3jXJ;
	Fri, 12 Apr 2024 09:14:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 503B61A0175;
	Fri, 12 Apr 2024 09:14:40 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBH7ihhmm2H+Jg--.44885S3;
	Fri, 12 Apr 2024 09:14:37 +0800 (CST)
Subject: Re: [PATCH vfs.all 08/26] erofs: prevent direct access of bd_inode
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <285b9c65-380b-7920-0769-013e5fadb2a6@huaweicloud.com>
Date: Fri, 12 Apr 2024 09:14:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBH7ihhmm2H+Jg--.44885S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4fXr4xur48Jry3GFWrAFb_yoWrZF4rpF
	y8Cr18Cr98Ar18Ar1SgF10qFyUtrn7J3W7Awn0q3WrZ3WUGrnaqr9YvrZ0gFs8Wr4kJr4j
	qF1av34Uua45Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
	3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/04/12 0:13, Gao Xiang 写道:
> Hi Al,
> 
> On 2024/4/7 12:05, Al Viro wrote:
>> On Sat, Apr 06, 2024 at 05:09:12PM +0800, Yu Kuai wrote:
>>> From: Yu Kuai <yukuai3@huawei.com>
>>>
>>> Now that all filesystems stash the bdev file, it's ok to get inode
>>> for the file.
>>
>> Looking at the only user of erofs_buf->inode (erofs_bread())...  We
>> use the inode for two things there - block size calculation (to get
>> from block number to position in bytes) and access to page cache.
>> We read in full pages anyway.  And frankly, looking at the callers,
>> we really would be better off if we passed position in bytes instead
>> of block number.  IOW, it smells like erofs_bread() having wrong type.
>>
>> Look at the callers.  With 3 exceptions it's
>> fs/erofs/super.c:135:   ptr = erofs_bread(buf, erofs_blknr(sb, 
>> *offset), EROFS_KMAP);
>> fs/erofs/super.c:151:           ptr = erofs_bread(buf, erofs_blknr(sb, 
>> *offset), EROFS_KMAP);
>> fs/erofs/xattr.c:84:    it.kaddr = erofs_bread(&it.buf, 
>> erofs_blknr(sb, it.pos), EROFS_KMAP);
>> fs/erofs/xattr.c:105:           it.kaddr = erofs_bread(&it.buf, 
>> erofs_blknr(sb, it.pos),
>> fs/erofs/xattr.c:188:           it->kaddr = erofs_bread(&it->buf, 
>> erofs_blknr(sb, it->pos),
>> fs/erofs/xattr.c:294:           it->kaddr = erofs_bread(&it->buf, 
>> erofs_blknr(sb, it->pos),
>> fs/erofs/xattr.c:339:           it->kaddr = erofs_bread(&it->buf, 
>> erofs_blknr(it->sb, it->pos),
>> fs/erofs/xattr.c:378:           it->kaddr = erofs_bread(&it->buf, 
>> erofs_blknr(sb, it->pos),
>> fs/erofs/zdata.c:943:           src = erofs_bread(&buf, 
>> erofs_blknr(sb, pos), EROFS_KMAP);
>>
>> and all of them actually want the return value + erofs_offset(...).  IOW,
>> we take a linear position (in bytes).  Divide it by block size (from sb).
>> Pass the factor to erofs_bread(), where we multiply that by block size
>> (from inode), see which page will that be in, get that page and return a
>> pointer *into* that page.  Then we again divide the same position
>> by block size (from sb) and add the remainder to the pointer returned
>> by erofs_bread().
>>
>> IOW, it would be much easier to pass the position directly and to hell
>> with block size logics.  Three exceptions to that pattern:
>>
>> fs/erofs/data.c:80:     return erofs_bread(buf, blkaddr, type);
>> fs/erofs/dir.c:66:              de = erofs_bread(&buf, i, EROFS_KMAP);
>> fs/erofs/namei.c:103:           de = erofs_bread(&buf, mid, EROFS_KMAP);
>>
>> Those could bloody well multiply the argument by block size;
>> the first one (erofs_read_metabuf()) is also interesting - its
>> callers themselves follow the similar pattern.  So it might be
>> worth passing it a position in bytes as well...
>>
>> In any case, all 3 have superblock reference, so they can convert
>> from blocks to bytes conveniently.  Which means that erofs_bread()
>> doesn't need to mess with block size considerations at all.
>>
>> IOW, it might make sense to replace erofs_buf->inode with
>> pointer to address space.  And use file_mapping() instead of
>> file_inode() in that patch...
> 
> Just saw this again by chance, which is unexpected.
> 
> Yeah, I think that is a good idea.  The story is that erofs_bread()
> was derived from a page-based interface:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/data.c?h=v5.10#n35 
> 
> 
> so it was once a page index number.  I think a byte offset will be
> a better interface to clean up these, thanks for your time and work
> on this!
> 
> BTW, sightly off the topic:
> 
> I'm little confused why I'm not be looped for this version this time
> even:
> 
>   1) I explicitly asked to Cc the mailing list so that I could find
>      the latest discussion and respond in time:
>       
> https://lore.kernel.org/r/5e04a86d-8bbd-41da-95f6-cf1562ed04f9@linux.alibaba.com 
> 
> 
>   2) I sent my r-v-b tag on RFC v4 (and the tag was added on this
>      version) but I didn't receive this new version.

This is my fault to blame, I gave up to cc all address from 
get_maintainer.pl for this set, because I somehow can't send this set
with too much CC. However, I should still CC you.

Thanks,
Kuai

> 
> Thanks,
> Gao Xiang
> .
> 


