Return-Path: <linux-fsdevel+bounces-18810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBAA8BC769
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 08:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D15A1F2162E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3014CB58;
	Mon,  6 May 2024 06:15:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B71F47F4A;
	Mon,  6 May 2024 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714976144; cv=none; b=bo4uQHx4cODBxhJkZgfsx7vYJvHDEU91ZxdRlU9vVDixKzO2u2lgQfxZDOh0uhZGh6132Nl/0wAkdqUPbQZQs2TtIQMVsp6fTpc6lElUo0kxuUBrAnFqYoQi4JUFsOfWOe/PlxfAjr7Nq+A1ADKXvcPMxXMHviFfZ+Wjmm740bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714976144; c=relaxed/simple;
	bh=ZXTHp++7FC5VMkPyWIlUyWDb94/UInMsEC+wZAfwtls=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o5RhLXbJ2mCTawMzaSaAb3L2BoWmnMGlVleoabose/YEwSYFR2beTuSidde10AAMBxarIctwnwN8lLm52VXFiy0YRnQXu2Cac7jciQrJMfk2CvZmfqzTfybdaFQXI3vOzsTkFUh6Emyqz/VfVl2FF607ccPZm+xb1qBz9E3cOkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXrk75kNrz4f3p0g;
	Mon,  6 May 2024 14:15:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 888D21A0B15;
	Mon,  6 May 2024 14:15:37 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgCnyw6HdThmFPC1MA--.46801S3;
	Mon, 06 May 2024 14:15:37 +0800 (CST)
Subject: Re: [PATCH v4 03/34] ext4: trim delalloc extent
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, hch@infradead.org, djwong@kernel.org, david@fromorbit.com,
 willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com,
 chengzhihao1@huawei.com, yukuai3@huawei.com, wangkefeng.wang@huawei.com
References: <87h6fh4n9c.fsf@gmail.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <567d7082-5c0c-0f7c-11b4-8f3d1bcd23dc@huaweicloud.com>
Date: Mon, 6 May 2024 14:15:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87h6fh4n9c.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnyw6HdThmFPC1MA--.46801S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur1rJry5Aw4xKr43Xw15twb_yoW5Wr18pr
	ZFk3W5trs3Kw429a1xAF18XF1rCw4rJF4Utws5Jry5Za98WFySka4qqF4jgFWDurs3tF4Y
	qF42q3y5XayvyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UZ18PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/1 22:31, Ritesh Harjani (IBM) wrote:
> Zhang Yi <yi.zhang@huaweicloud.com> writes:
> 
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> The cached delalloc or hole extent should be trimed to the map->map_len
>> if we map delalloc blocks in ext4_da_map_blocks().
> 
> Why do you say the cached delalloc extent should also be trimemd to
> m_len? Because we are only inserting delalloc blocks of
> min(hole_len, m_len), right?
> 
> If we find delalloc blocks, we don't need to insert anything in ES
> cache. So we just return 0 in such case in this function.
> 

I'm sorry for the clerical error, it should not be trimmed to m_len, it
should be trimmed to es->es_len. If we find a delalloc entry that shorter
than the map->m_len, it means the front part of this write range has
already been delayed, we can't insert the delalloc extent that contains
the latter part in this round, we need to trim the map->m_len and return 0,
the caller will increase the position and call ext4_da_map_blocks() again.
For example, please assume we write data [A, C) to a file that contains a
delayed extent [A, B) in the cache.

                      A     B  C
before da write:   ...dddddd|hhh....

Then we will get delayed extent [A, B), we should trim map->m_len to B-A
and return 0, if not, the caller will incorrectly assume that the write
is complete and won't insert [B, C) later.

> 
>> But it doesn't
>> trigger any issue now because the map->m_len is always set to one and we
>> always insert one delayed block once a time. Fix this by trim the extent
>> once we get one from the cached extent tree, prearing for mapping a
>> extent with multiple delalloc blocks.
>>
> 
> Yes, it wasn't clear until I looked at the discussion in the other
> thread. It would be helpful if you could use that example in the commit
> msg here for clarity.
> 
> 
> """
> Yeah, now we only trim map len if we found an unwritten extent or written
> extent in the cache, this isn't okay if we found a hole and
> ext4_insert_delayed_block() and ext4_da_map_blocks() support inserting
> map->len blocks. If we found a hole which es->es_len is shorter than the
> length we want to write, we could delay more blocks than we expected.
> 
> Please assume we write data [A, C) to a file that contains a hole extent
> [A, B) and a written extent [B, D) in cache.
> 
>                       A     B  C  D
> before da write:   ...hhhhhh|wwwwww....
> 
> Then we will get extent [A, B), we should trim map->m_len to B-A before
> inserting new delalloc blocks, if not, the range [B, C) is duplicated.
> 
> """
> 
> Minor nit: ext4_da_map_blocks() function comments have become stale now. 
> It's not clear of it's return value, the lock it uses etc. etc. If we are
> at it, we might as well fix the function description.
> 

Thanks for the reminder, I will update it in patch 9 since it does
some cleanup and also changes the return value.

Thanks,
Yi.


