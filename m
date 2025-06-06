Return-Path: <linux-fsdevel+bounces-50816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C9ACFD23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 08:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443EF1891FB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 06:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0BC283FE2;
	Fri,  6 Jun 2025 06:54:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8703C42AA9;
	Fri,  6 Jun 2025 06:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749192870; cv=none; b=HsbFBmBo7v2cYbKDhPu4p22mLuxPF2z0Klu9T7gJL24ECnAYTwOQaqand0Vl42a+FhyepQ4uA/HWJ5QjDKhJpOI5HAnclQ71ZbgKaTEiFzAcbt/Sni8dYVnBa7PofTWCXM/1tQazmOrL26NLLnVOMoO702d6+qx7M85bhUq8y/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749192870; c=relaxed/simple;
	bh=KptEL6E2q8w2gmJAwCZzKmuRb0crbU7DAMpbCXvvYhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzCABK+f6nlHD0Kvyc3rn355/eTzjIgXIuLzZHb7Vv2/pAlbaJq2gEOe0vVuHP7Zp3bOUT7Tg1d8uqRuZA9A+XhjezfkxrKW/mqHPTFe58DKilm1S6/Xyow/qBRGd4vPMy+fpoP3mmqxtpJvf2NQQScgwFiR2pIcG+jODJc9EpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bDBrK0RWVzKHND2;
	Fri,  6 Jun 2025 14:54:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 69B281A158A;
	Fri,  6 Jun 2025 14:54:23 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1+dkEJoiwKnOg--.6018S3;
	Fri, 06 Jun 2025 14:54:23 +0800 (CST)
Message-ID: <3aafd643-3655-420e-93fa-25d0d0ff4f32@huaweicloud.com>
Date: Fri, 6 Jun 2025 14:54:21 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] ext4: restart handle if credits are insufficient
 during writepages
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250530062858.458039-1-yi.zhang@huaweicloud.com>
 <20250530062858.458039-2-yi.zhang@huaweicloud.com>
 <byiax3ykefdvmu47xrgrndguxabwvakescnkanbhwwqoec7yky@dvzzkic5uzf3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <byiax3ykefdvmu47xrgrndguxabwvakescnkanbhwwqoec7yky@dvzzkic5uzf3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXu1+dkEJoiwKnOg--.6018S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Cw4fAr17tw47GrykKr47twb_yoWkGryxpr
	WUCFn0kFsrXa4a9rW7Za1DXF1xG3y8JrWUJay3KFZ0qas8uFn7KF18ta4Y9FWUArs3ua4x
	ZF40kryDW3WUAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/6/5 22:04, Jan Kara wrote:
> On Fri 30-05-25 14:28:54, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> After large folios are supported on ext4, writing back a sufficiently
>> large and discontinuous folio may consume a significant number of
>> journal credits, placing considerable strain on the journal. For
>> example, in a 20GB filesystem with 1K block size and 1MB journal size,
>> writing back a 2MB folio could require thousands of credits in the
>> worst-case scenario (when each block is discontinuous and distributed
>> across different block groups), potentially exceeding the journal size.
>>
>> Fix this by making the write-back process first reserves credits for one
>> page and attempts to extend the transaction if the credits are
>> insufficient. In particular, if the credits for a transaction reach
>> their upper limit, stop the handle and initiate a new transaction.
>>
>> Note that since we do not support partial folio writeouts, some blocks
>> within this folio may have been allocated. These allocated extents are
>> submitted through the current transaction, but the folio itself is not
>> submitted. To prevent stale data and potential deadlocks in ordered
>> mode, only the dioread_nolock mode supports this solution, as it always
>> allocate unwritten extents.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Couple of simplification suggestions below and one bigger issue we need to
> deal with.
> 
Thanks a lot for your comments and suggestions.


>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index be9a4cba35fd..5ef34c0c5633 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -1680,6 +1680,7 @@ struct mpage_da_data {
>>  	unsigned int do_map:1;
>>  	unsigned int scanned_until_end:1;
>>  	unsigned int journalled_more_data:1;
>> +	unsigned int continue_map:1;
>>  };
>>  
>>  static void mpage_release_unused_pages(struct mpage_da_data *mpd,
>> @@ -2367,6 +2368,8 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>>   *
>>   * @handle - handle for journal operations
>>   * @mpd - extent to map
>> + * @needed_blocks - journal credits needed for one writepages iteration
>> + * @check_blocks - journal credits needed for map one extent
>>   * @give_up_on_write - we set this to true iff there is a fatal error and there
>>   *                     is no hope of writing the data. The caller should discard
>>   *                     dirty pages to avoid infinite loops.
>> @@ -2383,6 +2386,7 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>>   */
>>  static int mpage_map_and_submit_extent(handle_t *handle,
>>  				       struct mpage_da_data *mpd,
>> +				       int needed_blocks, int check_blocks,
>>  				       bool *give_up_on_write)
>>  {
>>  	struct inode *inode = mpd->inode;
>> @@ -2393,6 +2397,8 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>>  	ext4_io_end_t *io_end = mpd->io_submit.io_end;
>>  	struct ext4_io_end_vec *io_end_vec;
>>  
>> +	mpd->continue_map = 0;
>> +
>>  	io_end_vec = ext4_alloc_io_end_vec(io_end);
>>  	if (IS_ERR(io_end_vec))
>>  		return PTR_ERR(io_end_vec);
>> @@ -2439,6 +2445,34 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>>  		err = mpage_map_and_submit_buffers(mpd);
>>  		if (err < 0)
>>  			goto update_disksize;
>> +		if (!map->m_len)
>> +			goto update_disksize;
>> +
>> +		/*
>> +		 * For mapping a folio that is sufficiently large and
>> +		 * discontinuous, the current handle credits may be
>> +		 * insufficient, try to extend the handle.
>> +		 */
>> +		err = __ext4_journal_ensure_credits(handle, check_blocks,
>> +				needed_blocks, 0);
>> +		if (err < 0)
>> +			goto update_disksize;
> 
> IMO it would be more logical to have __ext4_journal_ensure_credits() in
> mpage_map_one_extent() where the handle is actually used. Also there it
> would be pretty logical to do:
> 
> 		/* Make sure transaction has enough credits for this extent */
> 		needed_credits = ext4_chunk_trans_blocks(inode, 1);
> 		err = ext4_journal_ensure_credits(handle, needed_credits, 0);
> 
> No need to extend the transaction by more than we need for this current
> extent and also no need to propagate needed credits here.
> 
> If __ext4_journal_ensure_credits() cannot extend the transaction, we can
> just return -EAGAIN (or something like that) and make sure the retry logic
> on ENOSPC or similar transient errors in mpage_map_and_submit_extent()
> applies properly.

Yeah, that would be simpler.

> 
>> +		/*
>> +		 * The credits for the current handle and transaction have
>> +		 * reached their upper limit, stop the handle and initiate a
>> +		 * new transaction. Note that some blocks in this folio may
>> +		 * have been allocated, and these allocated extents are
>> +		 * submitted through the current transaction, but the folio
>> +		 * itself is not submitted. To prevent stale data and
>> +		 * potential deadlock in ordered mode, only the
>> +		 * dioread_nolock mode supports this.
>> +		 */
>> +		if (err > 0) {
>> +			WARN_ON_ONCE(!ext4_should_dioread_nolock(inode));
>> +			mpd->continue_map = 1;
>> +			err = 0;
>> +			goto update_disksize;
>> +		}
>>  	} while (map->m_len);
>>  
>>  update_disksize:
>> @@ -2467,6 +2501,9 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>>  		if (!err)
>>  			err = err2;
>>  	}
>> +	if (!err && mpd->continue_map)
>> +		ext4_get_io_end(io_end);
>> +
> 
> IMHO it would be more logical to not call ext4_put_io_end[_deferred]() in
> ext4_do_writepages() if we see we need to continue doing mapping for the
> current io_end.
> 
> That way it would be also more obvious that you've just reintroduced
> deadlock fixed by 646caa9c8e196 ("ext4: fix deadlock during page
> writeback"). This is actually a fundamental thing because for
> ext4_journal_stop() to complete, we may need IO on the folio to finish
> which means we need io_end to be processed. Even if we avoided the awkward
> case with sync handle described in 646caa9c8e196, to be able to start a new
> handle we may need to complete a previous transaction commit to be able to
> make space in the journal.

Yeah, you are right, I missed the full folios that were attached to the
same io_end in the previous rounds. If we continue to use this solution,
I think we should split the io_end and submit the previous one which
includes those full folios before the previous transaction is
committed.

> 
> Thinking some more about this holding ioend for a folio with partially
> submitted IO is also deadlock prone because mpage_prepare_extent_to_map()
> can call folio_wait_writeback() which will effectively wait for the last
> reference to ioend to be dropped so that underlying extents can be
> converted and folio_writeback bit cleared.

I don't understand this one. The mpage_prepare_extent_to_map() should
call folio_wait_writeback() for the current processing partial folio,
not the previous full folios that were attached to the io_end. This is
because mpd->first_page should be moved forward in mpage_folio_done()
once we complete the previous full folio. Besides, in my current
solution, the current partial folio will not be submitted, the
folio_writeback flag will not be set, so how does this deadlock happen?

> 
> So what I think we need to do is that if we submit part of the folio and
> cannot submit it all, we just redirty the folio and bail out of the mapping
> loop (similarly as in ENOSPC case).

After looking at the ENOSPC case again, I found that the handling of
ENOSPC before we enabling large folio is also wrong, it may case stale
data on 1K block size. Suppose we are processing four bhs on a dirty
page. We map the first bh, and the corresponding io_vec is added to the
io_end, with the unwritten flag set. However, when we attempt to map
the second bh, we bail out of the loop due to ENOSPC. At this point,
ext4_do_writepages()->ext4_put_io_end() will convert the extent of the
first bh to written. However, since the folio has not been committed
(mpage_submit_folio() submit a full folio), it will trigger stale data
issue. Is that right? I suppose we also have to write partial folio out
in this case.

> Then once IO completes
> mpage_prepare_extent_to_map() is able to start working on the folio again.
> Since we cleared dirty bits in the buffers we should not be repeating the
> work we already did...
> 

Hmm, it looks like this solution should work. We should introduce a
partial folio version of mpage_submit_folio(), call it and redirty
the folio once we need to bail out of the loop since insufficient
space or journal credits. But ext4_bio_write_folio() will handle the
the logic of fscrypt case, I'm not familiar with fscrypt, so I'm not
sure it could handle the partial page properly. I'll give it a try.

Thanks,
Yi.

> 
>>  	return err;
>>  }
>>  
>> @@ -2703,7 +2740,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>>  	handle_t *handle = NULL;
>>  	struct inode *inode = mpd->inode;
>>  	struct address_space *mapping = inode->i_mapping;
>> -	int needed_blocks, rsv_blocks = 0, ret = 0;
>> +	int needed_blocks, check_blocks, rsv_blocks = 0, ret = 0;
>>  	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
>>  	struct blk_plug plug;
>>  	bool give_up_on_write = false;
>> @@ -2825,10 +2862,13 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>>  
>>  	while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
>>  		/* For each extent of pages we use new io_end */
>> -		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
>>  		if (!mpd->io_submit.io_end) {
>> -			ret = -ENOMEM;
>> -			break;
>> +			mpd->io_submit.io_end =
>> +					ext4_init_io_end(inode, GFP_KERNEL);
>> +			if (!mpd->io_submit.io_end) {
>> +				ret = -ENOMEM;
>> +				break;
>> +			}
>>  		}
>>  
>>  		WARN_ON_ONCE(!mpd->can_map);
>> @@ -2841,10 +2881,13 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>>  		 */
>>  		BUG_ON(ext4_should_journal_data(inode));
>>  		needed_blocks = ext4_da_writepages_trans_blocks(inode);
>> +		check_blocks = ext4_chunk_trans_blocks(inode,
>> +				MAX_WRITEPAGES_EXTENT_LEN);
>>  
>>  		/* start a new transaction */
>>  		handle = ext4_journal_start_with_reserve(inode,
>> -				EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
>> +				EXT4_HT_WRITE_PAGE, needed_blocks,
>> +				mpd->continue_map ? 0 : rsv_blocks);
>>  		if (IS_ERR(handle)) {
>>  			ret = PTR_ERR(handle);
>>  			ext4_msg(inode->i_sb, KERN_CRIT, "%s: jbd2_start: "
>> @@ -2861,6 +2904,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>>  		ret = mpage_prepare_extent_to_map(mpd);
>>  		if (!ret && mpd->map.m_len)
>>  			ret = mpage_map_and_submit_extent(handle, mpd,
>> +					needed_blocks, check_blocks,
>>  					&give_up_on_write);
>>  		/*
>>  		 * Caution: If the handle is synchronous,
>> @@ -2894,7 +2938,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
>>  			ext4_journal_stop(handle);
>>  		} else
>>  			ext4_put_io_end(mpd->io_submit.io_end);
>> -		mpd->io_submit.io_end = NULL;
>> +		if (ret || !mpd->continue_map)
>> +			mpd->io_submit.io_end = NULL;
>>  
>>  		if (ret == -ENOSPC && sbi->s_journal) {
>>  			/*
>> -- 
>> 2.46.1
>>


