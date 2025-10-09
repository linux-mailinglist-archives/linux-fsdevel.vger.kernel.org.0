Return-Path: <linux-fsdevel+bounces-63627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8EFBC7958
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 08:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A583C636B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 06:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA142D061A;
	Thu,  9 Oct 2025 06:52:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6320B22;
	Thu,  9 Oct 2025 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992765; cv=none; b=hfjcVFNVXhMSc/MhOi0oDgJimK35Qj2X2cpH8qOqimnurwSPFdYAQQthtx99LxAZH2+0TnEFXG5RfIGTkwJzvGe896Bts71Rj3CS0yk9vmFQdAFqcwU0n0oMs10WaaonuqDGC1DlU4kSalR1f05j0mBTRIEyvkjpSVtt1KyeHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992765; c=relaxed/simple;
	bh=UVEbtt6q2MF+xJdEdmcooUFqNwXEarbr+BPKjODbBJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/PUnJHoHqrPHPXEkEE/IvkOSH9VmGQLVeEbu8VDs+Zf6kbNKCf4VLAJFbMU1PY1Z3DmumPgWABGPKdJPkEi2JTyfypwNv2kApdUbik70UpQjcUBwhX0ytPSJfbdV7vpicVSmxlQvmPssNVEN58VmS46VVO6td/HaS7TOCjrzKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cj0sy12sYzYQtwc;
	Thu,  9 Oct 2025 14:52:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 62AFD1A0DC6;
	Thu,  9 Oct 2025 14:52:38 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgAXKWG0W+do14A2CQ--.14766S3;
	Thu, 09 Oct 2025 14:52:38 +0800 (CST)
Message-ID: <1daf2836-f497-4de7-ac8c-32d4d5e68f83@huaweicloud.com>
Date: Thu, 9 Oct 2025 14:52:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] ext4: introduce seq counter for the extent
 status entry
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-4-yi.zhang@huaweicloud.com>
 <ympvfypw3222g2k4xzd5pba4zhkz5jihw4td67iixvrqhuu43y@wse63ntv4s6u>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ympvfypw3222g2k4xzd5pba4zhkz5jihw4td67iixvrqhuu43y@wse63ntv4s6u>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXKWG0W+do14A2CQ--.14766S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4rWF43WFyftrWfur18Grg_yoW5AF4fpF
	ZIkws5Jrn5Xw1IkF97J3W8XryrWw4rJr47JF43Kw12yan8GFy09F17KayjvFyxWrs7tw1Y
	vF4Fvr9ru3W7AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/8/2025 7:44 PM, Jan Kara wrote:
> On Thu 25-09-25 17:25:59, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> In the iomap_write_iter(), the iomap buffered write frame does not hold
>> any locks between querying the inode extent mapping info and performing
>> page cache writes. As a result, the extent mapping can be changed due to
>> concurrent I/O in flight. Similarly, in the iomap_writepage_map(), the
>> write-back process faces a similar problem: concurrent changes can
>> invalidate the extent mapping before the I/O is submitted.
>>
>> Therefore, both of these processes must recheck the mapping info after
>> acquiring the folio lock. To address this, similar to XFS, we propose
>> introducing an extent sequence number to serve as a validity cookie for
>> the extent. After commit 24b7a2331fcd ("ext4: clairfy the rules for
>> modifying extents"), we can ensure the extent information should always
>> be processed through the extent status tree, and the extent status tree
>> is always uptodate under i_rwsem or invalidate_lock or folio lock, so
>> it's safe to introduce this sequence number. The sequence number will be
>> increased whenever the extent status tree changes, preparing for the
>> buffered write iomap conversion.
>>
>> Besides, this mechanism is also applicable for the moving extents case.
>> In move_extent_per_page(), it also needs to reacquire data_sem and check
>> the mapping info again under the folio lock.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> One idea for future optimization as I'm reading the series:

Hi, Jan!

Thank you very much for reviewing this series!

> 
>> @@ -955,6 +961,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>  		}
>>  		pending = err3;
>>  	}
>> +	ext4_es_inc_seq(inode);
>>  error:
>>  	write_unlock(&EXT4_I(inode)->i_es_lock);
>>  	/*
> 
> ext4_es_insert_extent() doesn't always need to increment the sequence
> counter. It is used in two situations:
> 
> 1) When we found the extent in the on-disk extent tree and want to cache it
> in memory. No increment needed is in this case.
> 
> 2) When we allocated new blocks or changed their status. Increment needed
> in this case.
> 
> Case 1) can be actually pretty frequent on large files and we would be
> unnecessarily invalidating mapping information for operations happening in
> other parts of the file although no allocation information changes are
> actually happening.
> 

Indeed, the sequence count increment in Case 1 can be omitted because it
does not change any real extent. This increment can cause unnecessary
invalidation, potentially incurring additional overhead in some concurrency
scenarios.

Distinguishing between these two scenarios does not seem complicated. Since
the iomap conversion has not yet been completed, currently only the
defragmentation use this mechanism, I can add a TODO comment here now and
then initiate a new series to optimize it.

Thanks,
Yi.


