Return-Path: <linux-fsdevel+bounces-71793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6B1CD2997
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 08:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08EC130194D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D59C29A9C9;
	Sat, 20 Dec 2025 07:16:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5C520102B;
	Sat, 20 Dec 2025 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766215009; cv=none; b=loz1Hi/VmNbmlC1xDbi5FPlxtBuHBHAfEHm8DlOAKHQoky3i3I51K1qlmt5Uog5Cvbx1o7GWz4CuX0jSZCxOlmhBJO1QG0WMjW6bPB8uf2j+9t9mQdKtcX2A4wUj8bfCtroPtDJIRkoVJN3exjmUGn4b3SM6ZHsB4h18LMh+CCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766215009; c=relaxed/simple;
	bh=THGr9dij6vUQ92tAxmYUHS0K+B7d2kX45hFqayHs0uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAC+z70gzBhn77x1nKUTW1s+e/Bi+LamNFnakTHQQ6/uob35yCsDWfsG7egonZXJIYhFSWN4UVRErbwGMpekkUTiq8kqb8axCQ5V+o9OeCkUjejanVqd+lKY/O92YQ7mXig94umumali7BpK6uUCnanGTa8Bdm/CtWkhcaf0M8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dYG0W5Z1lzYQtf3;
	Sat, 20 Dec 2025 15:16:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 50F0240562;
	Sat, 20 Dec 2025 15:16:43 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgBnFvdZTUZprgBUAw--.52524S3;
	Sat, 20 Dec 2025 15:16:43 +0800 (CST)
Message-ID: <5f6f9588-52a0-4ab8-a1ad-3d466488b985@huaweicloud.com>
Date: Sat, 20 Dec 2025 15:16:41 +0800
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
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <6kfhyiin2m3iook5c4s6dwq45yeqshv4vbez3dfvwaehltajuc@4ybsharot344>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnFvdZTUZprgBUAw--.52524S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1rGF4DuFWUZFWxtr47Arb_yoW5WFWUpr
	Z3KFykCF40qFyUua97Z3Wvqr1Fqw4DKr4xuF4rKr1Yqr9Igr18KF4vqFW5WF48KrZ7CF4I
	vFWUA34xZFnxArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/19/2025 11:25 PM, Jan Kara wrote:
> On Sat 13-12-25 10:20:04, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Since we have deferred the split of the unwritten extent until after I/O
>> completion, it is not necessary to initiate the journal handle when
>> submitting the I/O.
>>
>> This can improve the write performance of concurrent DIO for multiple
>> files. The fio tests below show a ~25% performance improvement when
>> wirting to unwritten files on my VM with a mem disk.
>>
>>   [unwritten]
>>   direct=1
>>   ioengine=psync
>>   numjobs=16
>>   rw=write     # write/randwrite
>>   bs=4K
>>   iodepth=1
>>   directory=/mnt
>>   size=5G
>>   runtime=30s
>>   overwrite=0
>>   norandommap=1
>>   fallocate=native
>>   ramp_time=5s
>>   group_reporting=1
>>
>>  [w/o]
>>   w:  IOPS=62.5k, BW=244MiB/s
>>   rw: IOPS=56.7k, BW=221MiB/s
>>
>>  [w]
>>   w:  IOPS=79.6k, BW=311MiB/s
>>   rw: IOPS=70.2k, BW=274MiB/s
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/file.c  | 4 +---
>>  fs/ext4/inode.c | 4 +++-
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index 7a8b30932189..9f571acc7782 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -418,9 +418,7 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>>   *
>>   * - shared locking will only be true mostly with overwrites, including
>> - *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
>> - *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
>> - *   also release exclusive i_rwsem lock.
>> + *   initialized blocks and unwritten blocks.
>>   *
>>   * - Otherwise we will switch to exclusive i_rwsem lock.
>>   */
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index ffde24ff7347..08a296122fe0 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3819,7 +3819,9 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>  			 * For atomic writes the entire requested length should
>>  			 * be mapped.
>>  			 */
>> -			if (map.m_flags & EXT4_MAP_MAPPED) {
>> +			if ((map.m_flags & EXT4_MAP_MAPPED) ||
>> +			    (!(flags & IOMAP_DAX) &&
> 
> Why is here an exception for DAX writes? DAX is fine writing to unwritten
> extents AFAIK. It only needs to pre-zero newly allocated blocks... Or am I
> missing some corner case?
> 
> 								Honza

Hi, Jan!

Thank you for reviewing this series.

Yes, that is precisely why this exception is necessary here. Without this
exception, a DAX write to an unwritten extent would return immediately
without invoking ext4_iomap_alloc() to perform pre-zeroing.

Thanks,
Yi.

> 
>> +			     (map.m_flags & EXT4_MAP_UNWRITTEN))) {
>>  				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
>>  				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
>>  					goto out;
>> -- 
>> 2.46.1
>>


