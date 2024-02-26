Return-Path: <linux-fsdevel+bounces-12790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3298673C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC821C23C9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F131EB33;
	Mon, 26 Feb 2024 11:47:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E012032B;
	Mon, 26 Feb 2024 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948055; cv=none; b=Z+5R74txmK8GtE91UYlWVlt5mJxPhKRBtr3vrRZYozhz0eBDrYmReCI7xun/0NG0hpWLj6Fl0+5vkus2zb8czhsetC/+stNKM5BCOPj1YlsPe+UALzEaLDCJhXrHa5VQ0oXKVii4hp0+ex7w4dpKiGbnwelkLxX5HlYy9sGCHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948055; c=relaxed/simple;
	bh=PW/t0CgsbXwGVwWv1YrcHNbF7vwavTug2HrgvR6ADgU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XMyIumcyfHa94ZQwpoWfDVSQXc6x7PWIZwAcSt2dTbeuT4KCDijtc/iJPtp0EO3NPUzlb84phdwR1aAtRZZELSoQcJfxsfU6mxFEXStJVJnh2FuItSuplIxgHui6NeBjTNoNaD826JU2N0SRleKsxYscxOVrVv5kW2vuU+zA3Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TjzPS38mKz4f3jJ6;
	Mon, 26 Feb 2024 19:47:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9A5591A016E;
	Mon, 26 Feb 2024 19:47:29 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgAnSg1QetxlAD88FQ--.14538S2;
	Mon, 26 Feb 2024 19:47:29 +0800 (CST)
Subject: Re: [PATCH 1/7] fs/writeback: avoid to writeback non-expired inode in
 kupdate writeback
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-2-shikemeng@huaweicloud.com>
 <20240223134212.g6m7oluhkjlpur2r@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <b3bbdb2a-18db-3721-26ce-9958d15e8385@huaweicloud.com>
Date: Mon, 26 Feb 2024 19:47:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240223134212.g6m7oluhkjlpur2r@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnSg1QetxlAD88FQ--.14538S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr18Xr1xXryfXw1DurykZrb_yoWrZryxpF
	WUJF13JF4qv34xGrnaka42gr1aqw4kJr47JryxWay2qw1qvr18KFyUWFyFkFy8ArsxGrWS
	vF4kA34xGr40yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 2/23/2024 9:42 PM, Jan Kara wrote:
> On Fri 09-02-24 01:20:18, Kemeng Shi wrote:
>> In kupdate writeback, only expired inode (have been dirty for longer than
>> dirty_expire_interval) is supposed to be written back. However, kupdate
>> writeback will writeback non-expired inode left in b_io or b_more_io from
>> last wb_writeback. As a result, writeback will keep being triggered
>> unexpected when we keep dirtying pages even dirty memory is under
>> threshold and inode is not expired. To be more specific:
>> Assume dirty background threshold is > 1G and dirty_expire_centisecs is
>>> 60s. When we running fio -size=1G -invalidate=0 -ioengine=libaio
>> --time_based -runtime=60... (keep dirtying), the writeback will keep
>> being triggered as following:
>> wb_workfn
>>   wb_do_writeback
>>     wb_check_background_flush
>>       /*
>>        * Wb dirty background threshold starts at 0 if device was idle and
>>        * grows up when bandwidth of wb is updated. So a background
>>        * writeback is triggered.
>>        */
>>       wb_over_bg_thresh
>>       /*
>>        * Dirtied inode will be written back and added to b_more_io list
>>        * after slice used up (because we keep dirtying the inode).
>>        */
>>       wb_writeback
>>
>> Writeback is triggered per dirty_writeback_centisecs as following:
>> wb_workfn
>>   wb_do_writeback
>>     wb_check_old_data_flush
>>       /*
>>        * Write back inode left in b_io and b_more_io from last wb_writeback
>>        * even the inode is non-expired and it will be added to b_more_io
>>        * again as slice will be used up (because we keep dirtying the
>>        * inode)
>>        */
>>       wb_writeback
>>
>> Fix this by moving non-expired inode in io list from last wb_writeback to
>> dirty list in kudpate writeback.
>>
>> Test as following:
>> /* make it more easier to observe the issue */
>> echo 300000 > /proc/sys/vm/dirty_expire_centisecs
>> echo 100 > /proc/sys/vm/dirty_writeback_centisecs
>> /* create a idle device */
>> mkfs.ext4 -F /dev/vdb
>> mount /dev/vdb /bdi1/
>> /* run buffer write with fio */
>> fio -name test -filename=/bdi1/file -size=800M -ioengine=libaio -bs=4K \
>> -iodepth=1 -rw=write -direct=0 --time_based -runtime=60 -invalidate=0
>>
>> Result before fix (run three tests):
>> 1360MB/s
>> 1329MB/s
>> 1455MB/s
>>
>> Result after fix (run three tests);
>> 790MB/s
>> 1820MB/s
>> 1804MB/s
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> OK, I don't find this a particularly troubling problem but I agree it might
> be nice to fix. But filtering the lists in wb_writeback() like this seems
> kind of wrong - the queueing is managed in queue_io() and I'd prefer to
> keep it that way. What if we just modified requeue_inode() to not
> requeue_io() inodes in case we are doing kupdate style writeback and inode
> isn't expired?
Sure, this could solve the reported problem and is acceptable to me. Thanks
for the advise. I will try it in next version.
> 
> Sure we will still possibly writeback unexpired inodes once before calling
> redirty_tail_locked() on them but that shouldn't really be noticeable?
> 
> 								Honza
>> ---
>>  fs/fs-writeback.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
>> index 5ab1aaf805f7..a9a918972719 100644
>> --- a/fs/fs-writeback.c
>> +++ b/fs/fs-writeback.c
>> @@ -2046,6 +2046,23 @@ static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
>>  	return nr_pages - work.nr_pages;
>>  }
>>  
>> +static void filter_expired_io(struct bdi_writeback *wb)
>> +{
>> +	struct inode *inode, *tmp;
>> +	unsigned long expired_jiffies = jiffies -
>> +		msecs_to_jiffies(dirty_expire_interval * 10);
>> +
>> +	spin_lock(&wb->list_lock);
>> +	list_for_each_entry_safe(inode, tmp, &wb->b_io, i_io_list)
>> +		if (inode_dirtied_after(inode, expired_jiffies))
>> +			redirty_tail(inode, wb);
>> +
>> +	list_for_each_entry_safe(inode, tmp, &wb->b_more_io, i_io_list)
>> +		if (inode_dirtied_after(inode, expired_jiffies))
>> +			redirty_tail(inode, wb);
>> +	spin_unlock(&wb->list_lock);
>> +}
>> +
>>  /*
>>   * Explicit flushing or periodic writeback of "old" data.
>>   *
>> @@ -2070,6 +2087,9 @@ static long wb_writeback(struct bdi_writeback *wb,
>>  	long progress;
>>  	struct blk_plug plug;
>>  
>> +	if (work->for_kupdate)
>> +		filter_expired_io(wb);
>> +
>>  	blk_start_plug(&plug);
>>  	for (;;) {
>>  		/*
>> -- 
>> 2.30.0
>>


