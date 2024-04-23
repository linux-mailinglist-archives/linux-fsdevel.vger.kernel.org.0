Return-Path: <linux-fsdevel+bounces-17500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1518AE3EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3441C222DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420483CAA;
	Tue, 23 Apr 2024 11:30:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624D7E118;
	Tue, 23 Apr 2024 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871813; cv=none; b=mqDyD241hIvgwHiSHH9oUSDPvWUwEEa78d8wrOfZLaZYupj9toH66MvyED3aWgq7VsIyBfVvbXz2AjYis/P5mCHkn39NB0l5hJUxhRrBfEXIiXsm35O3lcssHRJAWomtePstlvMuuoBf/jpt4p4cQ668KMBeDQqCq8h4KBjyOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871813; c=relaxed/simple;
	bh=IjrLm+jHCQEXdyCv6CiIzEcP94pKJ2KOwDyAUcgLU+g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B24Kpeq4rnprIF5GwItdnojIEv0cRZAA4/HNvqick2TVK28i+7+hTh+V33QYH3ZOQ7Lb5JS4mZKNOOKO/TOKHKupdsIPrvWCTJfWoxdOF8f39ZI4xUkgwiy3SYubNUK0VRry50BtuhRKsfryZ3ksLgvuj+psdqObFvRH3k5Wj9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VP0K15qDFz4f3pHY;
	Tue, 23 Apr 2024 19:29:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F0F241A10D4;
	Tue, 23 Apr 2024 19:30:06 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBG4mydm6qX7Kg--.45038S3;
	Tue, 23 Apr 2024 19:30:02 +0800 (CST)
Subject: Re: [PATCH v4 6/9] iomap: don't increase i_size if it's not a write
 operation
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, djwong@kernel.org, hch@infradead.org,
 brauner@kernel.org, david@fromorbit.com, tytso@mit.edu, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240320110548.2200662-1-yi.zhang@huaweicloud.com>
 <20240320110548.2200662-7-yi.zhang@huaweicloud.com>
 <87edb13ms8.fsf@debian-BULLSEYE-live-builder-AMD64>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <c9c51d1b-70aa-103f-d580-07ac3ec545e2@huaweicloud.com>
Date: Tue, 23 Apr 2024 19:30:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87edb13ms8.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBnOBG4mydm6qX7Kg--.45038S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWxGr17tF43KF4UXr4UCFg_yoW8AF1fpF
	WfWa4Fqr4UKw1xKFW7XryUX3W8X3W5Xr9xuryUGrWYyFnxAF1fArs2grWUurWUtFZ7Cw1F
	qw4kCFWkGry5urDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/4/19 14:07, Chandan Babu R wrote:
> On Wed, Mar 20, 2024 at 07:05:45 PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Increase i_size in iomap_zero_range() and iomap_unshare_iter() is not
>> needed, the caller should handle it. Especially, when truncate partial
>> block, we should not increase i_size beyond the new EOF here. It doesn't
>> affect xfs and gfs2 now because they set the new file size after zero
>> out, it doesn't matter that a transient increase in i_size, but it will
>> affect ext4 because it set file size before truncate. So move the i_size
>> updating logic to iomap_write_iter().
>>
> 
> This patch causes generic/522 to consistently fail when using the following
> fstest configuration,
> 
> TEST_DEV=/dev/loop16
> TEST_LOGDEV=/dev/loop13
> SCRATCH_DEV_POOL="/dev/loop5 /dev/loop6 /dev/loop7 /dev/loop8 /dev/loop9 /dev/loop10 /dev/loop11 /dev/loop12"
> MKFS_OPTIONS='-f -m reflink=1,rmapbt=1, -i sparse=1, -lsize=1g'
> MOUNT_OPTIONS='-o usrquota,grpquota,prjquota'
> TEST_FS_MOUNT_OPTS="$TEST_FS_MOUNT_OPTS -o usrquota,grpquota,prjquota"
> TEST_FS_MOUNT_OPTS="-o logdev=/dev/loop13"
> SCRATCH_LOGDEV=/dev/loop15
> USE_EXTERNAL=yes
> LOGWRITES_DEV=/dev/loop15
> 

Hello!

The root cause of the problem is caused by patch 4/9, this patch is fine,
I've revised the patch 4/9 and send it out separately in reply to v4. I've
tested that on my machine for over 100 rounds on generic/522 and it hasn't
failed again. Please take a look at the v5 patch for details and test it
on your machine.

https://lore.kernel.org/linux-xfs/20240423111735.1298851-1-yi.zhang@huaweicloud.com/T/#m2da33e643b642071aa20077321e2c431f5a64e38

Thanks,
Yi.


