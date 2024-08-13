Return-Path: <linux-fsdevel+bounces-25750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6180794FBB3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 04:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D98B282E34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 02:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3901400A;
	Tue, 13 Aug 2024 02:14:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580ED531;
	Tue, 13 Aug 2024 02:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723515289; cv=none; b=UTqFHQ7D8yK4GM14CoU1x84RMUq2zvZDMh4DQ1/tSqqAEfs4m68SX3vC6ScpycFXblPsinlzaKDaj2ON8FvSBSNTlCCcP28DWrtzEC+C2DEytSWBkarfsW/Cm1nZAXe19wEhKDy4pdy+UZu4mv01mR6hDFjil5qkMDsl3DnT3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723515289; c=relaxed/simple;
	bh=vvhvWKIh2t4mtzuVwGeHfsr+W2bjpTI1kncVkcWG15g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OwfhQ4boemyuW//CA1MQ1JYC2/zo2zSu9N+khH7Ya8WQJKdmJRSVv7qEVyHt9373XwWbYR/5BLrYXgAxfP86GuyMmeLDUUKaHWLIb0b9eiRuKv1JQ5zR699/qv1zJ4irkH9F5nb4cSRDzcbF6kAANm/91UZmyClPX4OuiLrdMf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjZhM6kHwz4f3kvY;
	Tue, 13 Aug 2024 10:14:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 91AA81A058E;
	Tue, 13 Aug 2024 10:14:42 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4WQwbpmVecoBg--.63080S3;
	Tue, 13 Aug 2024 10:14:42 +0800 (CST)
Subject: Re: [PATCH v2 1/6] iomap: correct the range of a partial dirty clear
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, hch@infradead.org, brauner@kernel.org,
 david@fromorbit.com, jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-2-yi.zhang@huaweicloud.com>
 <20240812163339.GD6043@frogsfrogsfrogs>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <d56e3183-a27e-fbbb-4203-28e8e10127cb@huaweicloud.com>
Date: Tue, 13 Aug 2024 10:14:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240812163339.GD6043@frogsfrogsfrogs>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAHL4WQwbpmVecoBg--.63080S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ury8Jr13Kw1UWrW5Xw1UWrg_yoW8ur1rpr
	s3KF4UKrWDXry29r1xXFyrXFn5tanrWF48JrW7WryrWan0qr1fKr109ay3uF92gr4xAF10
	vF1agrWxCrWqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/8/13 0:33, Darrick J. Wong wrote:
> On Mon, Aug 12, 2024 at 08:11:54PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The block range calculation in ifs_clear_range_dirty() is incorrect when
>> partial clear a range in a folio. We can't clear the dirty bit of the
>> first block or the last block if the start or end offset is blocksize
>> unaligned, this has not yet caused any issue since we always clear a
>> whole folio in iomap_writepage_map()->iomap_clear_range_dirty(). Fix
>> this by round up the first block and round down the last block and
>> correct the calculation of nr_blks.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/iomap/buffered-io.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
>> index f420c53d86ac..4da453394aaf 100644
>> --- a/fs/iomap/buffered-io.c
>> +++ b/fs/iomap/buffered-io.c
>> @@ -138,11 +138,14 @@ static void ifs_clear_range_dirty(struct folio *folio,
>>  {
>>  	struct inode *inode = folio->mapping->host;
>>  	unsigned int blks_per_folio = i_blocks_per_folio(inode, folio);
>> -	unsigned int first_blk = (off >> inode->i_blkbits);
>> -	unsigned int last_blk = (off + len - 1) >> inode->i_blkbits;
>> -	unsigned int nr_blks = last_blk - first_blk + 1;
>> +	unsigned int first_blk = DIV_ROUND_UP(off, i_blocksize(inode));
> 
> Is there a round up macro that doesn't involve integer division?
> 

Sorry, I don't find a common macro now, if we want to avoid integer division,
how about open code here?

	first_blk = round_up(off, i_blocksize(inode)) >> inode->i_blkbits;

Thanks,
Yi.

> 
>> +	unsigned int last_blk = (off + len) >> inode->i_blkbits;
>> +	unsigned int nr_blks = last_blk - first_blk;
>>  	unsigned long flags;
>>  
>> +	if (!nr_blks)
>> +		return;
>> +
>>  	spin_lock_irqsave(&ifs->state_lock, flags);
>>  	bitmap_clear(ifs->state, first_blk + blks_per_folio, nr_blks);
>>  	spin_unlock_irqrestore(&ifs->state_lock, flags);
>> -- 
>> 2.39.2
>>
>>


