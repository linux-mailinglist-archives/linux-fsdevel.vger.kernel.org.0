Return-Path: <linux-fsdevel+bounces-71822-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E397ACD5CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 12:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8AF030595B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375423164A8;
	Mon, 22 Dec 2025 11:18:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE43148D9;
	Mon, 22 Dec 2025 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766402330; cv=none; b=m4UZ/DJ4fLgqCmFi9sN16LyYrnqryxC5WMg/r37VmmLZaY2bEsEKLU/Cx1dABZlmvpPOf2mfpl9J3TyozU49gRvL6APX7zYnFQDkIGUAqxParlmLphT2WYifKxCN/pggrHoJm60vDf7E+0T3wiOM2faASKO1IvngaqgdV6aHRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766402330; c=relaxed/simple;
	bh=L5CSwTNRoAzejG8cIanyZQEioZ3Ta7TMfGL/jJVgFa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+HlaFjlZ6hS9IAjZ5wvKqSIoSqWG4USKDULA9mF7x+J14wI9LZ4o6IfCsNyBzdCgzpvAdXRfdWb6uusWrytDQIWepOTEvzGBDTZT9bp9OAuVc36gpn/CNvUstdYOm07riTuIXGqQuBMchqjnBVnFaisAtkPj+OYJOi3mH21ltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dZbGk3HkXzYQv8Y;
	Mon, 22 Dec 2025 19:18:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A07274056C;
	Mon, 22 Dec 2025 19:18:41 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgCX+PgOKUlpLfBUBA--.49541S3;
	Mon, 22 Dec 2025 19:18:41 +0800 (CST)
Message-ID: <4f6ac1c0-8bd7-4547-8eb2-bf764cff0880@huaweicloud.com>
Date: Mon, 22 Dec 2025 19:18:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 3/7] ext4: avoid starting handle when dio writing an
 unwritten extent
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, ritesh.list@gmail.com, yi.zhang@huawei.com,
 yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com,
 yukuai@fnnas.com
References: <20251213022008.1766912-1-yi.zhang@huaweicloud.com>
 <20251213022008.1766912-4-yi.zhang@huaweicloud.com>
 <6kfhyiin2m3iook5c4s6dwq45yeqshv4vbez3dfvwaehltajuc@4ybsharot344>
 <5f6f9588-52a0-4ab8-a1ad-3d466488b985@huaweicloud.com>
 <7btwyxrkixgmv45jeh3bf4uf4fqmauypb2ss67uqsiicklz6gq@rmll5ujssmwx>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <7btwyxrkixgmv45jeh3bf4uf4fqmauypb2ss67uqsiicklz6gq@rmll5ujssmwx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCX+PgOKUlpLfBUBA--.49541S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWfKFW3uw45Jw48GrW3Jrb_yoW5tFWxpr
	Z3KFy8CF4vqryUu3s2v3W8Xr1Sq397Kr4xZF4Fgr1jqr909r1xKw1jqFW5WF18KrWxCF10
	vFWUAryxZF15ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/22/2025 6:15 PM, Jan Kara wrote:
> On Sat 20-12-25 15:16:41, Zhang Yi wrote:
>> On 12/19/2025 11:25 PM, Jan Kara wrote:
>>> On Sat 13-12-25 10:20:04, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> Since we have deferred the split of the unwritten extent until after I/O
>>>> completion, it is not necessary to initiate the journal handle when
>>>> submitting the I/O.
>>>>
>>>> This can improve the write performance of concurrent DIO for multiple
>>>> files. The fio tests below show a ~25% performance improvement when
>>>> wirting to unwritten files on my VM with a mem disk.
>>>>
>>>>   [unwritten]
>>>>   direct=1
>>>>   ioengine=psync
>>>>   numjobs=16
>>>>   rw=write     # write/randwrite
>>>>   bs=4K
>>>>   iodepth=1
>>>>   directory=/mnt
>>>>   size=5G
>>>>   runtime=30s
>>>>   overwrite=0
>>>>   norandommap=1
>>>>   fallocate=native
>>>>   ramp_time=5s
>>>>   group_reporting=1
>>>>
>>>>  [w/o]
>>>>   w:  IOPS=62.5k, BW=244MiB/s
>>>>   rw: IOPS=56.7k, BW=221MiB/s
>>>>
>>>>  [w]
>>>>   w:  IOPS=79.6k, BW=311MiB/s
>>>>   rw: IOPS=70.2k, BW=274MiB/s
>>>>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>> ---
>>>>  fs/ext4/file.c  | 4 +---
>>>>  fs/ext4/inode.c | 4 +++-
>>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>>>> index 7a8b30932189..9f571acc7782 100644
>>>> --- a/fs/ext4/file.c
>>>> +++ b/fs/ext4/file.c
>>>> @@ -418,9 +418,7 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>>>>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>>>>   *
>>>>   * - shared locking will only be true mostly with overwrites, including
>>>> - *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
>>>> - *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
>>>> - *   also release exclusive i_rwsem lock.
>>>> + *   initialized blocks and unwritten blocks.
>>>>   *
>>>>   * - Otherwise we will switch to exclusive i_rwsem lock.
>>>>   */
>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>> index ffde24ff7347..08a296122fe0 100644
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -3819,7 +3819,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>>>  			 * For atomic writes the entire requested length should
>>>>  			 * be mapped.
>>>>  			 */
>>>> -			if (map.m_flags & EXT4_MAP_MAPPED) {
>>>> +			if ((map.m_flags & EXT4_MAP_MAPPED) ||
>>>> +			    (!(flags & IOMAP_DAX) &&
>>>
>>> Why is here an exception for DAX writes? DAX is fine writing to unwritten
>>> extents AFAIK. It only needs to pre-zero newly allocated blocks... Or am I
>>> missing some corner case?
>>>
>>> 								Honza
>>
>> Hi, Jan!
>>
>> Thank you for reviewing this series.
>>
>> Yes, that is precisely why this exception is necessary here. Without this
>> exception, a DAX write to an unwritten extent would return immediately
>> without invoking ext4_iomap_alloc() to perform pre-zeroing.
> 
> Ah, you're right. I already forgot how writing to unwritten extents works
> with DAX and it seems we convert the extents to initialized (and zero them
> out) before copying the data. Can you please expand the comment above by
> "For DAX we convert extents to initialized ones before copying the data,
> otherwise we do it after IO so there's no need to call into
> ext4_iomap_alloc()." Otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza

Sure! I will add this comment in v2.

Thanks,
Yi.


