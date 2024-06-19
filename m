Return-Path: <linux-fsdevel+bounces-21909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C340890E16C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 03:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD861F23390
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 01:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F317A20B34;
	Wed, 19 Jun 2024 01:53:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638B18E20;
	Wed, 19 Jun 2024 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718761981; cv=none; b=O5lPUbpoYMD1EGiFu3Ies5oBjgL21KFo4vBCoMGlT93Kel2OXAREkVR7CqBrovCmDRrEU8Ba9MO8UTXB+lZe20NSJBCzk5s0kgmDiMDyu288WC0ZgsUhpTGzWBx6/RChYYqRtgZB4ftdqg/QFwdsHs3tdP0FcD/YAV0C+mIjdHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718761981; c=relaxed/simple;
	bh=QmPk0UzntBJOKP+gtREakJzVLTpxJSG6l9MVP35N/+8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=E197t/HJKtmzFjaRybC30sfrNHGnuPhpJXOprYoNFCsPlYfHg8TOlHpIdKwVEiZFNRteCrn6g4fld8EIqgVfL7pO1s4Dj51xkLfsDRpWySKH5Z1BqwxLm8V/3T5Adf7OPlYanqcdXVzG1HYJzHIlApdd3euV7c2ZxUR5B9NW2pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4W3mpb3yNVz4f3jd0;
	Wed, 19 Jun 2024 09:52:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E89531A0572;
	Wed, 19 Jun 2024 09:52:49 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCnDw3uOXJmtDtWAQ--.53627S3;
	Wed, 19 Jun 2024 09:52:47 +0800 (CST)
Subject: Re: [PATCH -next v6 0/2] iomap/xfs: fix stale data exposure when
 truncating realtime inodes
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, chandanbabu@kernel.org, jack@suse.cz,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240618142112.1315279-1-yi.zhang@huaweicloud.com>
 <20240619002444.GH103034@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <2aec8c89-b09b-c173-de4e-6a6c1547d600@huaweicloud.com>
Date: Wed, 19 Jun 2024 09:52:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240619002444.GH103034@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnDw3uOXJmtDtWAQ--.53627S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAw4DKr47uF4xJr1UKFyfZwb_yoWrGF17pF
	Z3KayYkF4Ut34fArZ7ZF1UXr1Yyan7Cr4UGFy5Kr4fuF15Zr1Iqr1vgF4F9FWqk3s7urs0
	vr4Fva4fCrn0yFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2024/6/19 8:24, Darrick J. Wong wrote:
> On Tue, Jun 18, 2024 at 10:21:10PM +0800, Zhang Yi wrote:
>> Changes since v5:
>>  - Drop all the code about zeroing out the whole allocation unitsize
>>    on truncate down in xfs_setattr_size() as Christoph suggested, let's
>>    just fix this issue for RT file by converting tail blocks to
>>    unwritten now, and we could think about forced aligned extent and
>>    atomic write later until it needs, so only pick patch 6 and 8 in
>>    previous version, do some minor git log changes.
> 
> This mostly makes sense, let's see how it fares with overnight fstests.
> For now, this is a provisional
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 

Thanks for the review. BTW, what kind of fstests configs do you usually run?
I always run kvm-xfstests -g auto[1] before I submitting ext4 patches, I'd
also like to run full tests and hope to find regressions before submitting
xfs patches.

[1] https://github.com/tytso/xfstests-bld

Thanks,
Yi.

> 
> 
>> Changes since v4:
>>  - Drop the first patch in v4 "iomap: zeroing needs to be pagecache
>>    aware" since this series is not strongly depends on it, that patch
>>    still needs furtuer analyse and also should add to handle the case of
>>    a pending COW extent that extends over a data fork hole. This is a
>>    big job, so let's fix the exposure stale data issue and brings back
>>    the changes in iomap_write_end() first, don't block the ext4 buffered
>>    iomap conversion.
>>  - In patch 1, drop the 'ifndef rem_u64'.
>>  - In patch 4, factor out a helper xfs_setattr_truncate_data() to handle
>>    the zero out, update i_size, write back and drop pagecache on
>>    truncate.
>>  - In patch 5, switch to use xfs_inode_alloc_unitsize() in
>>    xfs_itruncate_extents_flags().
>>  - In patch 6, changes to reserve blocks for rtextsize > 1 realtime
>>    inodes on truncate down.
>>  - In patch 7, drop the unwritten convert threshold, always convert tail
>>    blocks to unwritten on truncate down realtime inodes.
>>  - Add patch 8 to bring back 'commit 943bc0882ceb ("iomap: don't
>>    increase i_size if it's not a write operation")'.
>>
>> Changes since v3:
>>  - Factor out a new helper to get the remainder in math64.h as Darrick
>>    suggested.
>>  - Adjust the truncating order to prevent too much redundant blocking
>>    writes as Dave suggested.
>>  - Improve to convert the tail extent to unwritten when truncating down
>>    an inode with large rtextsize as Darrick and Dave suggested.
>>
>> Since 'commit 943bc0882ceb ("iomap: don't increase i_size if it's not a
>> write operation")' merged, Chandan reported a stale data exposure issue
>> when running fstests generic/561 on xfs with realtime device [1]. This
>> issue has been fix in 6.10 by revert this commit through commit
>> '0841ea4a3b41 ("iomap: keep on increasing i_size in iomap_write_end()")',
>> but the real problem is xfs_setattr_size() doesn't zero out enough range
>> when truncate down a realtime inode. So this series fix this problem by
>> just converting the tail blocks to unwritten when truncate down realtime
>> inodes, then we could bring commit 943bc0882ceb back.
>>
>> I've tested this series on fstests (1) with reflink=0, (2) with
>> reflink=1, (3) with 28K RT device, no new failures detected, and it
>> passed generic/561 on RT device over 300+ rounds, please let me know if
>> we need any other test.
>>
>> [1] https://lore.kernel.org/linux-xfs/87ttj8ircu.fsf@debian-BULLSEYE-live-builder-AMD64/
>>
>> Thanks,
>> Yi.
>>
>> Zhang Yi (2):
>>   xfs: reserve blocks for truncating large realtime inode
>>   iomap: don't increase i_size in iomap_write_end()
>>
>>  fs/iomap/buffered-io.c | 53 +++++++++++++++++++++++-------------------
>>  fs/xfs/xfs_iops.c      | 15 +++++++++++-
>>  2 files changed, 43 insertions(+), 25 deletions(-)
>>
>> -- 
>> 2.39.2
>>
>>


