Return-Path: <linux-fsdevel+bounces-19381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0C18C4310
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 16:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B461C21648
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 14:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8886E153BEC;
	Mon, 13 May 2024 14:17:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BE5153BDD;
	Mon, 13 May 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609867; cv=none; b=TGsuh8fqTvQAIKenNj+5iZbxJkU+1p3JYcnknBHDKTvm+/uHLo84hdTVxffGo7pJ85ncOBcUc6NnICQyOeZ+0o5hDG3t9GuT4xQueE4HvVkBTZn7/jcjS/alLKnAetOoHPNUwvfk/A4yMCBuo2RbxH2+PJawoa/0Hdo8YmYrMXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609867; c=relaxed/simple;
	bh=ZMKJiPvWUMLG/15B8aJK121V4OU+vsa13K9Fm2xgN64=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qzxyWuFoD63YMl9f5AwweYAlYgrT3sF+mqYKVXHdF9HKME1c7KUQ5B7NR1DSdplrcwBxP1TGfRx+lBqiR37QocwnJNVfmi98t2nI2kYiG4zd03m148oelC+pHcx/msyp88SuWWvRlxTVEmdNldiyGliVp15CwbV8aaMfL5qDd0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VdM57146Qz4f3jMH;
	Mon, 13 May 2024 22:17:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AF21F1A0568;
	Mon, 13 May 2024 22:17:39 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgCnyw4BIUJmd_txMw--.55460S3;
	Mon, 13 May 2024 22:17:39 +0800 (CST)
Subject: Re: [PATCH v3 03/10] ext4: warn if delalloc counters are not zero on
 inactive
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240508061220.967970-1-yi.zhang@huaweicloud.com>
 <20240508061220.967970-4-yi.zhang@huaweicloud.com>
 <20240512151038.wdg4g3evfvimr7ul@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <7d8e3e67-a246-2bfd-39ad-663d7d9d8eed@huaweicloud.com>
Date: Mon, 13 May 2024 22:17:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240512151038.wdg4g3evfvimr7ul@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnyw4BIUJmd_txMw--.55460S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1kXw4xWFWrJFW7Zr1DZFb_yoW8ur13pF
	WkC3W8GF9Ygry8Ga1IqF47Xr1Fqa1xKF4rGrW8Wr1UZF9xGa4ftr17tFyYkF1j9rZxCw4F
	qa4rWF17urWDJ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/12 23:10, Jan Kara wrote:
> On Wed 08-05-24 14:12:13, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The per-inode i_reserved_data_blocks count the reserved delalloc blocks
>> in a regular file, it should be zero when destroying the file. The
>> per-fs s_dirtyclusters_counter count all reserved delalloc blocks in a
>> filesystem, it also should be zero when umounting the filesystem. Now we
>> have only an error message if the i_reserved_data_blocks is not zero,
>> which is unable to be simply captured, so add WARN_ON_ONCE to make it
>> more visable.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Well, maybe the warnings could be guarded by !(EXT4_SB(sb)->s_mount_state &
> EXT4_ERROR_FS)? Because the warning isn't very interesting when the
> filesystem was corrupted and if somebody runs with errors=continue we would
> still possibly hit this warning although we don't really care...
> 

Make sense, I missed the errors=continue mode.

Thanks,
Yi.

> 
>> ---
>>  fs/ext4/super.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 044135796f2b..440dd54eea25 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1343,6 +1343,9 @@ static void ext4_put_super(struct super_block *sb)
>>  
>>  	ext4_group_desc_free(sbi);
>>  	ext4_flex_groups_free(sbi);
>> +
>> +	WARN_ON_ONCE(!ext4_forced_shutdown(sb) &&
>> +		     percpu_counter_sum(&sbi->s_dirtyclusters_counter));
>>  	ext4_percpu_param_destroy(sbi);
>>  #ifdef CONFIG_QUOTA
>>  	for (int i = 0; i < EXT4_MAXQUOTAS; i++)
>> @@ -1473,7 +1476,8 @@ static void ext4_destroy_inode(struct inode *inode)
>>  		dump_stack();
>>  	}
>>  
>> -	if (EXT4_I(inode)->i_reserved_data_blocks)
>> +	if (!ext4_forced_shutdown(inode->i_sb) &&
>> +	    WARN_ON_ONCE(EXT4_I(inode)->i_reserved_data_blocks))
>>  		ext4_msg(inode->i_sb, KERN_ERR,
>>  			 "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
>>  			 inode->i_ino, EXT4_I(inode),
>> -- 
>> 2.39.2
>>


