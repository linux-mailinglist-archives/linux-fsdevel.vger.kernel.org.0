Return-Path: <linux-fsdevel+bounces-37610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DDD9F44C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 08:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC4F161B4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E891D9592;
	Tue, 17 Dec 2024 07:05:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DB615533F;
	Tue, 17 Dec 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419150; cv=none; b=lMkYClPbFu1FHJlpOlSw2Bd7FfttK8SDZjedjZc0UWGZTKH2pg8HIsDz5QLTFk7FWhfyCTLjU2pJj+4GlrthmZ2jxdMz0+23+hgHbZAI1VMcmjPLoT8lEC/2H2x5VKDtyKTlYLK5Sh21z6LBhqvGPBtrY5NxMQFC4Nzk/vW83R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419150; c=relaxed/simple;
	bh=DSs6MKQtGfOSJuKLJlMPfak8E7lUmXpUpwQz3wouyfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asp4FEcDummDxpKg1V3uRQ0faKccTl7vO4F9N3JOv0pWEd8NTjfaqa4bZPJHtLxVNLAlMMjuKMzd3CpIlpdkTpHy0JdHS+NN61AWjDjzVp7Tz7QWUhLhhltgJMkNDYm3LagFw+myflOcQKNtBRUM+yVDxQZ9aAoMsbWZPGCDndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YC79t5S0Sz4f3lDN;
	Tue, 17 Dec 2024 15:05:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 413B81A07B6;
	Tue, 17 Dec 2024 15:05:43 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXP4PFImFnxpBaEw--.52699S3;
	Tue, 17 Dec 2024 15:05:43 +0800 (CST)
Message-ID: <9630a73c-2f68-4284-97ad-f1e34a2abbdf@huaweicloud.com>
Date: Tue, 17 Dec 2024 15:05:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] ext4: remove writable userspace mappings before
 truncating page cache
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20241216013915.3392419-1-yi.zhang@huaweicloud.com>
 <20241216013915.3392419-2-yi.zhang@huaweicloud.com>
 <20241216150028.xq4qlr7xqjce34ey@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241216150028.xq4qlr7xqjce34ey@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXP4PFImFnxpBaEw--.52699S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry7Gr4fJF1kXF4DJF4DXFb_yoW8Kw1rpr
	y7Ga43CrW8Ca13C3WIva4kA34ftwnrZFW7Jry5Kr1jvryrJF17tF1jqw18uw4jgr10yr48
	Zr4UAry7tw15ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/16 23:00, Jan Kara wrote:
> On Mon 16-12-24 09:39:06, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When zeroing a range of folios on the filesystem which block size is
>> less than the page size, the file's mapped blocks within one page will
>> be marked as unwritten, we should remove writable userspace mappings to
>> ensure that ext4_page_mkwrite() can be called during subsequent write
>> access to these partial folios. Otherwise, data written by subsequent
>> mmap writes may not be saved to disk.
>>
>>  $mkfs.ext4 -b 1024 /dev/vdb
>>  $mount /dev/vdb /mnt
>>  $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
>>                -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
>>                -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo
>>
>>  $od -Ax -t x1z /mnt/foo
>>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>>  *
>>  000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
>>  *
>>  001000
>>
>>  $umount /mnt && mount /dev/vdb /mnt
>>  $od -Ax -t x1z /mnt/foo
>>  000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
>>  *
>>  000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>  *
>>  001000
>>
>> Fix this by introducing ext4_truncate_page_cache_block_range() to remove
>> writable userspace mappings when truncating a partial folio range.
>> Additionally, move the journal data mode-specific handlers and
>> truncate_pagecache_range() into this function, allowing it to serve as a
>> common helper that correctly manages the page cache in preparation for
>> block range manipulations.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> I like the patch. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Just one thing occured to me when thinking about this: It seems like a
> nasty catch that truncate_inode_pages_range() does not writeprotect these
> partial pages because practically any filesystem supporting blocksize <
> pagesize and doing anything non-trivial in ->page_mkwrite handler will need
> this. So ultimately I think we might want to fix this in generic code but
> ext4 solution is fine for now.
> 

Yes, I agree with you. I've checked XFS, Btrfs, and Bcachefs. Currently,
XFS and Btrfs choose to perform writeback before truncating partial
folios, so they do not require this at the moment. However, it appears
that Bcachefs also does a similar approach in __bch2_truncate_folio().
So I think do this in generic code should be better too.

Thanks,
Yi.


