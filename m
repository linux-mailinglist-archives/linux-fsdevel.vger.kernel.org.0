Return-Path: <linux-fsdevel+bounces-11935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A649C8593FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 03:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CA328306F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 02:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83215CB;
	Sun, 18 Feb 2024 02:11:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F54EA4;
	Sun, 18 Feb 2024 02:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708222306; cv=none; b=d5toFk52QuFMnxMibZ3NnfLoYcLJgpX7ZuyWre/Rxn5JwPuasfgJJy/vz/5+s0X85EZ3rs7Vy2J3dKKi9nAeiZQoKr+2uo7f5dey/GRImebWNyV4eltLHQVKyvqIhXc37TNzRm4CRj8ufDbLTZcNDugRhQGpsQ9FyvSKECARNLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708222306; c=relaxed/simple;
	bh=jvy6VlvkMJg85//QhK6/hGyp7KCFJSO3KQbJdFbXdPg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MSX9rvi7a+o6KFqTP8kdv/PII4l8Odmp0GliRJdKqFEzZxsqjk+sTXSZTUVL4Rd+Np27hJST3OfOlgDO/bpL03+nv4lAtyhIVwTFlLccQaqgGR6Ueiww9WA1nGf0wSxLc3Y2sz4sDkzAyqkJC98F6yM7QGnIbQ80LrJzzWsrt/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tcq0n6qV8z4f3k6L;
	Sun, 18 Feb 2024 10:11:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 09CDF1A0172;
	Sun, 18 Feb 2024 10:11:41 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgAnNZ1cZ9FlYBQdEQ--.23895S2;
	Sun, 18 Feb 2024 10:11:40 +0800 (CST)
Subject: Re: [PATCH 2/7] fs/writeback: bail out if there is no more inodes for
 IO and queued once
To: Tim Chen <tim.c.chen@linux.intel.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-3-shikemeng@huaweicloud.com>
 <acc5ebbcd6a378b090d7ce56c47ed66fd1e0ccdc.camel@linux.intel.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <b79993fb-6413-4de7-a38f-c75a281d1762@huaweicloud.com>
Date: Sun, 18 Feb 2024 10:11:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <acc5ebbcd6a378b090d7ce56c47ed66fd1e0ccdc.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnNZ1cZ9FlYBQdEQ--.23895S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFyrKFy8WFy7KrWDtr43Jrb_yoW8ZFWkpF
	WrtFy5KFWqy3y7Crn7Ca42qr1aqw4DtF45Jryfu3WUtr93ZFy09Fy0gr1FyF1xA3y3uFWI
	vr4rX348Jry8t3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/9/2024 3:21 AM, Tim Chen wrote:
> On Fri, 2024-02-09 at 01:20 +0800, Kemeng Shi wrote:
>> For case there is no more inodes for IO in io list from last wb_writeback,
>> We may bail out early even there is inode in dirty list should be written
>> back. Only bail out when we queued once to avoid missing dirtied inode.
>>
>> This is from code reading...
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/fs-writeback.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index a9a918972719..edb0cff51673 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -2086,6 +2086,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>>  	struct inode *inode;
>>  	long progress;
>>  	struct blk_plug plug;
>> +	bool queued = false;
>>  
>>  	if (work->for_kupdate)
>>  		filter_expired_io(wb);
>> @@ -2131,8 +2132,10 @@ static long wb_writeback(struct bdi_writeback *wb,
>>  			dirtied_before = jiffies;
>>  
>>  		trace_writeback_start(wb, work);
>> -		if (list_empty(&wb->b_io))
>> +		if (list_empty(&wb->b_io)) {
>>  			queue_io(wb, work, dirtied_before);
>> +			queued = true;
>> +		}
>>  		if (work->sb)
>>  			progress = writeback_sb_inodes(work->sb, wb, work);
>>  		else
>> @@ -2155,7 +2158,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>>  		/*
>>  		 * No more inodes for IO, bail
>>  		 */
>> -		if (list_empty(&wb->b_more_io)) {
>> +		if (list_empty(&wb->b_more_io) && queued) {
> 
> Wonder if we can simply do
> 		if (list_empty(&wb->b_more_io) && list_empty(&wb->b_io)) {
> 
> if the intention is to not bail if there are still inodes to be be flushed.
I suppose not as there may be inodes in wb->b_dirty should be flushed.
For case that there is a inode in wb->b_io which is not flushed in last
wb_writeback and there are a lot of inodes in wb->dirty, the next background
flush is supposed to make dirty pages under threshold however only the inode
in wb->b_io is flushed.
> 
> Tim
> 
>>  			spin_unlock(&wb->list_lock);
>>  			break;
>>  		}
> 


