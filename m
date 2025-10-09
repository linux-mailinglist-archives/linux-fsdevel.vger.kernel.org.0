Return-Path: <linux-fsdevel+bounces-63629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192EBC7B0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 09:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1C1C135164F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 07:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89D22D0C88;
	Thu,  9 Oct 2025 07:23:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937C298CA4;
	Thu,  9 Oct 2025 07:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994623; cv=none; b=Y7Me7tpxGnv0OzuZtHywTM+eCTUnBI77Y+XSTUkHJdoTlHMHLWu3mhKwtfhqaHPpw5GBmX3IavtmoSxvkPo8bWBCs3GQGXfkfyUJhVeFwNformlEe01x93zzTLg5d/+UKHYGIWWTZ35vciJgaf+j1PXFfCv6ro6yJ5F7VSGFpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994623; c=relaxed/simple;
	bh=LINDnW4s9/f8fq1vV5tLl5zmw9/+Ay+oZDsgSpWg0Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYbqs4J2Gid9GfspgmMsjQpCBq4s4mx+r8agVCSb1QM8Ev63Fy/u+6mCU3iGCR5UE6Siesr0PQLNtvwanROXdQpCnozOw/9MOqVNtvrKXBbjFXyhiHOoUKNZKWZdBIu8A/kU41znsdBoPOUZAgLlk3zrUIabGNFQkVrM3G8c10E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cj1Yk0QrPzYQv2T;
	Thu,  9 Oct 2025 15:23:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 547521A0F1A;
	Thu,  9 Oct 2025 15:23:38 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgDX6GD5YudoO_s4CQ--.16977S3;
	Thu, 09 Oct 2025 15:23:38 +0800 (CST)
Message-ID: <eec9bf55-3e16-446e-8f80-2556a7ec4172@huaweicloud.com>
Date: Thu, 9 Oct 2025 15:23:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] ext4: add large folios support for moving
 extents
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-13-yi.zhang@huaweicloud.com>
 <axefpw7kkvnto72cde4cmn7ns6elbh6xrmfqh523dgjfveej5w@nmh5nsos4xoz>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <axefpw7kkvnto72cde4cmn7ns6elbh6xrmfqh523dgjfveej5w@nmh5nsos4xoz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDX6GD5YudoO_s4CQ--.16977S3
X-Coremail-Antispam: 1UD129KBjvJXoWrtw4DZF18Zr4fGr18CFWrGrg_yoW8Jr48pF
	WIgan7ArWkG347u3yUKF9FvryUGFWDWr18GrW3W3ya9FyUXr9agrsrCa1jvry5XryrAFy0
	vF4S9rnrGwn0y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/8/2025 8:53 PM, Jan Kara wrote:
> On Thu 25-09-25 17:26:08, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Pass the moving extent length into mext_folio_double_lock() so that it
>> can acquire a higher-order folio if the length exceeds PAGE_SIZE. This
>> can speed up extent moving when the extent is larger than one page.
>> Additionally, remove the unnecessary comments from
>> mext_folio_double_lock().
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> One nit below, otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> @@ -214,7 +206,8 @@ static int mext_move_begin(struct mext_data *mext, struct folio *folio[2],
>>  	orig_pos = ((loff_t)mext->orig_map.m_lblk) << blkbits;
>>  	donor_pos = ((loff_t)mext->donor_lblk) << blkbits;
>>  	ret = mext_folio_double_lock(orig_inode, donor_inode,
>> -			orig_pos >> PAGE_SHIFT, donor_pos >> PAGE_SHIFT, folio);
>> +			orig_pos >> PAGE_SHIFT, donor_pos >> PAGE_SHIFT,
>> +			mext->orig_map.m_len << blkbits, folio);
> 			^^^ This is just cosmetical but we should cast to
>   size_t before the shift...
> 
> 								Honza

Ha, right! I missed this, thank you for pointing it out, will fix in
next iteration.

Best Regards,
Yi.


