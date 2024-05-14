Return-Path: <linux-fsdevel+bounces-19404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA998C4B38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 04:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7249B22C5B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 02:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F821170F;
	Tue, 14 May 2024 02:38:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1E4111A8;
	Tue, 14 May 2024 02:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715654280; cv=none; b=SbwreAUB1bP8gStcFwczf1dUlFtBAJe43a64/ETB4vaPGIYUiAuWhui1zxPAWduPKbNe3q0JqDnBbCNiZjP0HQSS+ZWRTtwJJvecTR5XRBPW0LNBmgwBO2loASsv7oBuB+RoSsBVPlDQ6Ac14XcYkxXf5r+l2fV3g2tbMiptyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715654280; c=relaxed/simple;
	bh=LpHndWUANENyXbWEUWy6ULQGvYKRFduNo9e0num+LF4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=vBk2msm4FBUeEmpw+R8b65VPi600S/e1cMUZFKqejC5o/2jpHT5/Lw/jZjvrA2HLyi744HnLd3MFR6OeQlc4CmerIR/0H0AcQUiX/7ZFBhsswXNh4BC/blcrY7JEUlIio7APDTVfbmmi4rXBj9kmeRAnB5y+qbVmlKLQodzGGZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdgWH3shKz4f3jLJ;
	Tue, 14 May 2024 10:37:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0DE451A017F;
	Tue, 14 May 2024 10:37:53 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBHaw5_zkJmKsijMw--.49294S3;
	Tue, 14 May 2024 10:37:52 +0800 (CST)
Subject: Re: [PATCH v3 08/10] ext4: factor out check for whether a cluster is
 allocated
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
 <20240508061220.967970-9-yi.zhang@huaweicloud.com>
 <20240512154037.x6icodkj2zmzeqtg@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <0d2c6419-0dad-1bd5-92fe-2239ef6809e0@huaweicloud.com>
Date: Tue, 14 May 2024 10:37:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240512154037.x6icodkj2zmzeqtg@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHaw5_zkJmKsijMw--.49294S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1UJFWftFWUZF17GF47twb_yoW5Gr13pF
	W8GF1UtF13GryxWF4Iqrn8XFya9w4jqrZrJ3y293W8Zrs3AFyfKF1qkF15ua4xCr48Can5
	ZFWUAry7uF1DKa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/12 23:40, Jan Kara wrote:
> On Wed 08-05-24 14:12:18, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Factor out a common helper ext4_da_check_clu_allocated(), check whether
>> the cluster containing a delalloc block to be added has been delayed or
>> allocated, no logic changes.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> I have one suggestion for improvement here.
> 
>> +/*
>> + * Check whether the cluster containing lblk has been delayed or allocated,
>> + * if not, it means we should reserve a cluster when add delalloc, return 1,
>> + * otherwise return 0 or error code.
>> + */
>> +static int ext4_da_check_clu_allocated(struct inode *inode, ext4_lblk_t lblk,
>> +				       bool *allocated)
> 
> The name of the function does not quite match what it is returning and that
> is confusing. Essentially we have three states here:
> 
> a) cluster allocated
> b) cluster has delalloc reservation
> c) cluster doesn't have either
> 
> So maybe we could call the function ext4_clu_alloc_state() and return 0 /
> 1 / 2 based on the state?
> 
> 								Honza

Sure, thanks for the suggestion, it looks better.

Thanks,
Yi.

> 
>> +{
>> +	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>> +	int ret;
>> +
>> +	*allocated = false;
>> +	if (ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk))
>> +		return 0;
>> +
>> +	if (ext4_es_scan_clu(inode, &ext4_es_is_mapped, lblk))
>> +		goto allocated;
>> +
>> +	ret = ext4_clu_mapped(inode, EXT4_B2C(sbi, lblk));
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ret == 0)
>> +		return 1;
>> +allocated:
>> +	*allocated = true;
>> +	return 0;
>> +}
>> +
>>  /*
>>   * ext4_insert_delayed_block - adds a delayed block to the extents status
>>   *                             tree, incrementing the reserved cluster/block
>> @@ -1682,23 +1710,13 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
>>  		if (ret != 0)   /* ENOSPC */
>>  			return ret;
>>  	} else {   /* bigalloc */
>> -		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
>> -			if (!ext4_es_scan_clu(inode,
>> -					      &ext4_es_is_mapped, lblk)) {
>> -				ret = ext4_clu_mapped(inode,
>> -						      EXT4_B2C(sbi, lblk));
>> -				if (ret < 0)
>> -					return ret;
>> -				if (ret == 0) {
>> -					ret = ext4_da_reserve_space(inode, 1);
>> -					if (ret != 0)   /* ENOSPC */
>> -						return ret;
>> -				} else {
>> -					allocated = true;
>> -				}
>> -			} else {
>> -				allocated = true;
>> -			}
>> +		ret = ext4_da_check_clu_allocated(inode, lblk, &allocated);
>> +		if (ret < 0)
>> +			return ret;
>> +		if (ret > 0) {
>> +			ret = ext4_da_reserve_space(inode, 1);
>> +			if (ret != 0)   /* ENOSPC */
>> +				return ret;
>>  		}
>>  	}
>>  
>> -- 
>> 2.39.2
>>


