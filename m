Return-Path: <linux-fsdevel+bounces-52378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AA7AE27CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 09:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EDA189FA7A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 07:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63221D95B3;
	Sat, 21 Jun 2025 07:46:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11303EED7;
	Sat, 21 Jun 2025 07:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750492008; cv=none; b=HM+UDif5qHkcKziUYipfVW1XQ2ZmnCVelGy34c0gCnqJwFAxO037BgOh44BeV8jFS9AS+pF5eMCQVqHkY2QnftTc79jhLXiZdRcHHcyfmps4m8rt5aoxrPs4bWUZOp8qrPmeA/El/wPB4kKi48BpK8NPBQW5vQrQzI6rt2W5eBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750492008; c=relaxed/simple;
	bh=DBxrikfhg8Wp0otCdHRK8j20NjDY96mwubx80hCnJfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkNJwr+EbIG+6Y0ZqI7IsT1NaKe+16olJQW6rQQXrEOe2NrdcgSEhMkjNxU8y5IueDQg4Y+c+MKPPynr1kvvm59uaWqAl9CjwowEUq532iQ8MzjMu335szskt2im4Hb38HMyVeHIPtSFbZLEpV65jVChPP4uBQdH+es3LvX/Mfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bPRHl4vchzYQtvb;
	Sat, 21 Jun 2025 15:46:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9AD9D1A176C;
	Sat, 21 Jun 2025 15:46:42 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXu19gY1ZobKe_QA--.33653S3;
	Sat, 21 Jun 2025 15:46:42 +0800 (CST)
Message-ID: <558c7f74-3d0a-4394-b9ab-3eafab136a23@huaweicloud.com>
Date: Sat, 21 Jun 2025 15:46:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] ext4/jbd2: reintroduce
 jbd2_journal_blocks_per_page()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-6-yi.zhang@huaweicloud.com>
 <ugup3tdvaxgzc6agaidbdh7sdcpzcqvwzsurqkesyhsyta7q7y@h3q6mrc2jcno>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ugup3tdvaxgzc6agaidbdh7sdcpzcqvwzsurqkesyhsyta7q7y@h3q6mrc2jcno>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXu19gY1ZobKe_QA--.33653S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WryrKrWkWFyfXF43WrW5trb_yoW7KF1UpF
	4DCFy8Cry8ZFy7uFn2gFsrZFyIg3y0kF4UWr9a9F1kta90q3s3tFnrtw1YyFy5Ar4DGa10
	vF4UC39rW3yjvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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

On 2025/6/20 0:44, Jan Kara wrote:
> On Wed 11-06-25 19:16:24, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> This partially reverts commit d6bf294773a4 ("ext4/jbd2: convert
>> jbd2_journal_blocks_per_page() to support large folio"). This
>> jbd2_journal_blocks_per_folio() will lead to a significant
>> overestimation of journal credits. Since we still reserve credits for
>> one page and attempt to extend and restart handles during large folio
>> writebacks, so we should convert this helper back to
>> ext4_journal_blocks_per_page().
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Here I'm not decided. Does it make any particular sense to reserve credits
> for one *page* worth of blocks when pages don't have any particular meaning
> in our writeback code anymore? We could reserve credits just for one
> physical extent and that should be enough.

Indeed, reserving credits for a single page is no longer suitable in the
currently folio based context. It do seems more appropriate to allocate
credits for a single extent.

> For blocksize == pagesize (most
> common configs) this would be actually equivalent. If blocksize < pagesize,
> this could force us to do some more writeback retries and thus get somewhat
> higher writeback CPU overhead but do we really care for these configs?  It
> is well possible I've overlooked something and someone will spot a
> performance regression in practical setup with this in which case we'd have
> to come up with something more clever but I think it's worth it to start
> simple and complicate later.

This can indeed be a problem if the file system is already fragmented
enough. However, thanks to the credits extension logic in
__ext4_journal_ensure_credits(), I suppose that on most file system images,
it will not trigger excessive retry operations. Besides, although there
might be some lock cost in jbd2_journal_extend(), I suppose it won't be a
big deal.

Perhaps we could reserve more credits through a complex formula at the
outset, which would lower the cost of expanding the credits. But I don't
think this will help much in reducing the number of retries, it may only
be helpful in extreme cases (the running transaction stats to commit, we
cannot extend it).

So, I think we can implement it by reserving for an extent for the time
being. Do you agree?

Thanks,
Yi.

> 
> 
>> ---
>>  fs/ext4/ext4_jbd2.h  | 7 +++++++
>>  fs/ext4/inode.c      | 6 +++---
>>  fs/jbd2/journal.c    | 6 ++++++
>>  include/linux/jbd2.h | 1 +
>>  4 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
>> index 63d17c5201b5..c0ee756cb34c 100644
>> --- a/fs/ext4/ext4_jbd2.h
>> +++ b/fs/ext4/ext4_jbd2.h
>> @@ -326,6 +326,13 @@ static inline int ext4_journal_blocks_per_folio(struct inode *inode)
>>  	return 0;
>>  }
>>  
>> +static inline int ext4_journal_blocks_per_page(struct inode *inode)
>> +{
>> +	if (EXT4_JOURNAL(inode) != NULL)
>> +		return jbd2_journal_blocks_per_page(inode);
>> +	return 0;
>> +}
>> +
>>  static inline int ext4_journal_force_commit(journal_t *journal)
>>  {
>>  	if (journal)
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 67e37dd546eb..9835145b1b27 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -2556,7 +2556,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>>   */
>>  static int ext4_da_writepages_trans_blocks(struct inode *inode)
>>  {
>> -	int bpp = ext4_journal_blocks_per_folio(inode);
>> +	int bpp = ext4_journal_blocks_per_page(inode);
>>  
>>  	return ext4_meta_trans_blocks(inode,
>>  				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
>> @@ -2634,7 +2634,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>>  	ext4_lblk_t lblk;
>>  	struct buffer_head *head;
>>  	handle_t *handle = NULL;
>> -	int bpp = ext4_journal_blocks_per_folio(mpd->inode);
>> +	int bpp = ext4_journal_blocks_per_page(mpd->inode);
>>  
>>  	if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
>>  		tag = PAGECACHE_TAG_TOWRITE;
>> @@ -6255,7 +6255,7 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
>>   */
>>  int ext4_writepage_trans_blocks(struct inode *inode)
>>  {
>> -	int bpp = ext4_journal_blocks_per_folio(inode);
>> +	int bpp = ext4_journal_blocks_per_page(inode);
>>  	int ret;
>>  
>>  	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index d480b94117cd..7fccb425907f 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -84,6 +84,7 @@ EXPORT_SYMBOL(jbd2_journal_start_commit);
>>  EXPORT_SYMBOL(jbd2_journal_force_commit_nested);
>>  EXPORT_SYMBOL(jbd2_journal_wipe);
>>  EXPORT_SYMBOL(jbd2_journal_blocks_per_folio);
>> +EXPORT_SYMBOL(jbd2_journal_blocks_per_page);
>>  EXPORT_SYMBOL(jbd2_journal_invalidate_folio);
>>  EXPORT_SYMBOL(jbd2_journal_try_to_free_buffers);
>>  EXPORT_SYMBOL(jbd2_journal_force_commit);
>> @@ -2661,6 +2662,11 @@ int jbd2_journal_blocks_per_folio(struct inode *inode)
>>  		     inode->i_sb->s_blocksize_bits);
>>  }
>>  
>> +int jbd2_journal_blocks_per_page(struct inode *inode)
>> +{
>> +	return 1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
>> +}
>> +
>>  /*
>>   * helper functions to deal with 32 or 64bit block numbers.
>>   */
>> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
>> index 43b9297fe8a7..f35369c104ba 100644
>> --- a/include/linux/jbd2.h
>> +++ b/include/linux/jbd2.h
>> @@ -1724,6 +1724,7 @@ static inline int tid_geq(tid_t x, tid_t y)
>>  }
>>  
>>  extern int jbd2_journal_blocks_per_folio(struct inode *inode);
>> +extern int jbd2_journal_blocks_per_page(struct inode *inode);
>>  extern size_t journal_tag_bytes(journal_t *journal);
>>  
>>  static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
>> -- 
>> 2.46.1
>>


