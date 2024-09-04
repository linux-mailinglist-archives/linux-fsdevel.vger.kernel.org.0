Return-Path: <linux-fsdevel+bounces-28544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8531B96BB2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 13:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87E01C2205E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 11:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F4F1D5CC6;
	Wed,  4 Sep 2024 11:44:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC01D2231;
	Wed,  4 Sep 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450240; cv=none; b=sfDEQJDmXXIVgTlHW4ODErIunOhv/7EkAOuQIa7clc0tzhbuZd45qkAJvDMwSQQVoLDT3X3WUxsREqBaM9/ZNGG8tyN2en9q9Dz6fQarSJW15TYwICXP3zgiBMMQdZAC3IN6TaaYEGsuiZE9rnjSMvMst8Jx+zxnY5pFMQURlRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450240; c=relaxed/simple;
	bh=K6OnJGxaAcsZ9MDkNmmQ1YWuZNbfYpWFDlarjgU69BA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lu4uwf9plPOifu11K9+YFFIufFAOp+qivxdm3TKEPl2noMLPK/M34Cx40TSZRS7/NYVQjGAJFZxU5w39tcJlYOFjkPBi59gUW9lISEoV346TIQwGL9hxMAh63ZBn04L0J1tOLntZMho39rKEIFPkrnbd9Uz/JMkVbvh/ATehHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzLGq2CRBz4f3jXJ;
	Wed,  4 Sep 2024 19:43:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4E3C01A07B6;
	Wed,  4 Sep 2024 19:43:46 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCHusbwR9hm8396AQ--.60910S3;
	Wed, 04 Sep 2024 19:43:46 +0800 (CST)
Subject: Re: [PATCH v3 05/12] ext4: passing block allocation information to
 ext4_es_insert_extent()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
 <20240813123452.2824659-6-yi.zhang@huaweicloud.com>
 <20240904102103.3lss7s5yxavcnjwm@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <0d8ffff7-6b51-16fe-bf11-a6f126a81c58@huaweicloud.com>
Date: Wed, 4 Sep 2024 19:43:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240904102103.3lss7s5yxavcnjwm@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHusbwR9hm8396AQ--.60910S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5tF1kXw4fCFy8KF1rJFb_yoW8GF4rpF
	Z3ua48GF4UXw429FW0ya13Jr4fKa18J3y7ArWSgw1rXay5Casa9F97KFWjq3WvqrWI9Fn0
	vFW5Kw15Wa1YyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/4 18:21, Jan Kara wrote:
> On Tue 13-08-24 20:34:45, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Just pass the block allocation flag to ext4_es_insert_extent() when we
>> replacing a current extent after an actually block allocation or extent
>> status conversion, this flag will be used by later changes.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks good. Just one suggestion below. With that feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> @@ -848,7 +848,7 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
>>   */
>>  void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>  			   ext4_lblk_t len, ext4_fsblk_t pblk,
>> -			   unsigned int status)
>> +			   unsigned int status, int flags)
> 
> Since you pass flags to ext4_es_insert_extent() only from one place, let's
> not pretend these are always full mapping flags and just make this new
> argument:
> 
> bool delalloc_reserve_used
> 
> and from ext4_map_blocks_create() you can pass flags &
> EXT4_GET_BLOCKS_DELALLOC_RESERVE.
> 

Sure, it's a better idea than passing full mapping flags, thanks for your
suggestion, but since I've noticed that Ted had already picked this series
into his dev branch, I can send another patch to do this. Thanks a lot for
reviewing this series again!

Yi.


