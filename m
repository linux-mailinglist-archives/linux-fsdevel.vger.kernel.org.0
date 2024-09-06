Return-Path: <linux-fsdevel+bounces-28843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD31F96F367
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 13:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847AA1F23570
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 11:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683611CBE9B;
	Fri,  6 Sep 2024 11:44:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12321CB154;
	Fri,  6 Sep 2024 11:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623076; cv=none; b=Cl53bsFUddDsDAq3tHdUuVUKJNG1oi7S3/y8UIDswmbRC/PQKJzrWwwnlOPhpU9l+f7vh+vljQF6dTSzR193DgGDG0k8/fun14USwElIKhVe8+I8Npkx7o1WItz3YSoXX+Jm45LSPxV0TPIk7YyTjCuD/ZrXYxowMDZ5sYmARZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623076; c=relaxed/simple;
	bh=pgHZ6pNns/zCb7OwBUYttF56SM01OMsasHc2ufiQzQ4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aTktoDtRfzhDHx/YnTimBhC5eC9za4BSwuwAjjjM2zy9cDB9hyFZiEAOJGh4SRKAlCA0tU+D6mvcXK4pWd6PeN9RNAi/kOsZYvIgcnkZNwPrjRHyNHdbP5EO8xh5i3vKe4T1P+gYHlGIPVk7UemdO2+FEuyxbCmKMK68BQFERt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X0ZBn4qnhz4f3kKD;
	Fri,  6 Sep 2024 19:44:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 14DF71A058E;
	Fri,  6 Sep 2024 19:44:28 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAnXMga69pm74M6Ag--.57615S3;
	Fri, 06 Sep 2024 19:44:27 +0800 (CST)
Subject: Re: [PATCH -next] ext4: don't pass full mapping flags to
 ext4_es_insert_extent()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
 yukuai3@huawei.com
References: <20240906061401.2980330-1-yi.zhang@huaweicloud.com>
 <20240906103445.pwdlkivrlqh3redb@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <742ccba0-6a27-7694-2381-37a70c137ac5@huaweicloud.com>
Date: Fri, 6 Sep 2024 19:44:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240906103445.pwdlkivrlqh3redb@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAnXMga69pm74M6Ag--.57615S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw15uw4DZw1DtF4xZw4UXFb_yoW8Jw4fpa
	9rC3W8JF1rKa4xCFWxta17trW7Ka1UJ3y2vFykuw15ZFZ5Zr93Kr45G3WjgFyIkrWFyr1a
	vFW8uwnxC3Wjg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/9/6 18:34, Jan Kara wrote:
> On Fri 06-09-24 14:14:01, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When converting a delalloc extent in ext4_es_insert_extent(), since we
>> only want to pass the info of whether the quota has already been claimed
>> if the allocation is a direct allocation from ext4_map_create_blocks(),
>> there is no need to pass full mapping flags, so changes to just pass
>> whether the EXT4_GET_BLOCKS_DELALLOC_RESERVE bit is set.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
>> @@ -863,8 +863,8 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
>>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>>  		return;
>>  
>> -	es_debug("add [%u/%u) %llu %x %x to extent status tree of inode %lu\n",
>> -		 lblk, len, pblk, status, flags, inode->i_ino);
>> +	es_debug("add [%u/%u) %llu %x %d to extent status tree of inode %lu\n",
>> +		 lblk, len, pblk, status, delalloc_reserve_used, inode->i_ino);
> 
> Ah, I didn't know 'bool' gets automatically promoted to 'int' when passed
> as variadic argument but it seems to be the case from what I've found. One
> always learns :)
> 

Yeah, I'm always learn too. ;)

Thanks,
Yi.


