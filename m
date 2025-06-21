Return-Path: <linux-fsdevel+bounces-52375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27867AE2766
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 06:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8CB3BC782
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 04:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0DA18B47C;
	Sat, 21 Jun 2025 04:42:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368B7FD;
	Sat, 21 Jun 2025 04:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750480940; cv=none; b=Xdz+ZU6/lhuCe41Iaev0u2jmasCehgdwAXhyzFwHLtNRhYDl/Iblm386T7ynDR54sHPt1P7QGKfYecBPlzpto6Ep5c/sKIftYiTFaNqT6Kf1WHU3N1D9Hb9TVl+qLIl5vbz3VzOSwsWiz/9MQIq4TiAp28bWMZx+wOBq17AEHx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750480940; c=relaxed/simple;
	bh=84OQdbnFaAalIBYEFR6CcGXAprWVFUTReWwTdcjFB7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+i+FwsgvrZREx7Ze/p9JJQsOB+ohFupjx4UVR1of5mj7cg2Dy5czEQhjOf1qcPH9cyQEnnGD6V4GA7xHKo4vRnM24LlbyUGtLgeb5XtCLXskGZYik2OOa5cYADjD7maR5VQsLE+6jalqwGudHw1RI9xzI+J6NzamKURrBuDDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bPMBt21ggzYQv5T;
	Sat, 21 Jun 2025 12:42:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3527F1A0A69;
	Sat, 21 Jun 2025 12:42:13 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXe18jOFZogESyQA--.18044S3;
	Sat, 21 Jun 2025 12:42:13 +0800 (CST)
Message-ID: <49596299-8cd5-4b43-ba32-cf2b404236a7@huaweicloud.com>
Date: Sat, 21 Jun 2025 12:42:11 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] ext4: fix stale data if it bail out of the extents
 mapping loop
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com,
 yukuai3@huawei.com, yangerkun@huawei.com
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-3-yi.zhang@huaweicloud.com>
 <m5drn6xauyaksmui7b3vpua24ttgmjnwsi3sgavpelxlcwivsw@6bpmobqvpw7f>
 <14966764-5bbc-48a9-9d56-841255cfe3c6@huaweicloud.com>
 <ygdwliycwt52ngkl2o4lia3hzyug3zzvc2hdacbdi3lvbzne7l@l7ub66fvqym6>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <ygdwliycwt52ngkl2o4lia3hzyug3zzvc2hdacbdi3lvbzne7l@l7ub66fvqym6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXe18jOFZogESyQA--.18044S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4UAry7ArW5CFWrGryUJrb_yoWxArWkpF
	WDCas0ka1DGayayr9avayqyrn3t3ykJr4UXFy7tasI9F98KF1fKr1Iqa4j9FW8Grs7CrWS
	qF45try7ua45A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2025/6/20 23:21, Jan Kara wrote:
> On Fri 20-06-25 12:57:18, Zhang Yi wrote:
>> On 2025/6/20 0:21, Jan Kara wrote:
>>> On Wed 11-06-25 19:16:21, Zhang Yi wrote:
>>>> From: Zhang Yi <yi.zhang@huawei.com>
>>>>
>>>> During the process of writing back folios, if
>>>> mpage_map_and_submit_extent() exits the extent mapping loop due to an
>>>> ENOSPC or ENOMEM error, it may result in stale data or filesystem
>>>> inconsistency in environments where the block size is smaller than the
>>>> folio size.
>>>>
>>>> When mapping a discontinuous folio in mpage_map_and_submit_extent(),
>>>> some buffers may have already be mapped. If we exit the mapping loop
>>>> prematurely, the folio data within the mapped range will not be written
>>>> back, and the file's disk size will not be updated. Once the transaction
>>>> that includes this range of extents is committed, this can lead to stale
>>>> data or filesystem inconsistency.
>>>>
>>>> Fix this by submitting the current processing partial mapped folio and
>>>> update the disk size to the end of the mapped range.
>>>>
>>>> Suggested-by: Jan Kara <jack@suse.cz>
>>>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>>>> ---
>>>>  fs/ext4/inode.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 48 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>> index 3a086fee7989..d0db6e3bf158 100644
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -2362,6 +2362,42 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +/*
>>>> + * This is used to submit mapped buffers in a single folio that is not fully
>>>> + * mapped for various reasons, such as insufficient space or journal credits.
>>>> + */
>>>> +static int mpage_submit_buffers(struct mpage_da_data *mpd, loff_t pos)
>>>> +{
>>>> +	struct inode *inode = mpd->inode;
>>>> +	struct folio *folio;
>>>> +	int ret;
>>>> +
>>>> +	folio = filemap_get_folio(inode->i_mapping, mpd->first_page);
>>>> +	if (IS_ERR(folio))
>>>> +		return PTR_ERR(folio);
>>>> +
>>>> +	ret = mpage_submit_folio(mpd, folio);
>>>> +	if (ret)
>>>> +		goto out;
>>>> +	/*
>>>> +	 * Update first_page to prevent this folio from being released in
>>>> +	 * mpage_release_unused_pages(), it should not equal to the folio
>>>> +	 * index.
>>>> +	 *
>>>> +	 * The first_page will be reset to the aligned folio index when this
>>>> +	 * folio is written again in the next round. Additionally, do not
>>>> +	 * update wbc->nr_to_write here, as it will be updated once the
>>>> +	 * entire folio has finished processing.
>>>> +	 */
>>>> +	mpd->first_page = round_up(pos, PAGE_SIZE) >> PAGE_SHIFT;
>>>
>>> Well, but there can be many folios between mpd->first_page and pos. And
>>> this way you avoid cleaning them up (unlocking them and dropping elevated
>>> refcount) before we restart next loop. How is this going to work?
>>>
>>
>> Hmm, I don't think there can be many folios between mpd->first_page and
>> pos. All of the fully mapped folios should be unlocked by
>> mpage_folio_done(), and there is no elevated since it always call
>> folio_batch_release() once we finish processing the folios.
> 
> Indeed. I forgot that mpage_map_one_extent() with shorten mpd->map->m_len
> to the number of currently mapped blocks.
> 
>> mpage_release_unused_pages() is used to clean up unsubmitted folios.
>>
>> For example, suppose we have a 4kB block size filesystem and we found 4
>> order-2 folios need to be mapped in the mpage_prepare_extent_to_map().
>>
>>        first_page             next_page
>>        |                      |
>>       [HHHH][HHHH][HHHH][HHHH]              H: hole  L: locked
>>        LLLL  LLLL  LLLL  LLLL
>>
>> In the first round in the mpage_map_and_submit_extent(), we mapped the
>> first two folios along with the first two pages of the third folio, the
>> mpage_map_and_submit_buffers() should then submit and unlock the first
>> two folios, while also updating mpd->first_page to the beginning of the
>> third folio.
>>
>>                   first_page  next_page
>>                   |          |
>>       [WWWW][WWWW][WWHH][HHHH]              H: hole    L: locked
>>        UUUU  UUUU  LLLL  LLLL               W: mapped  U: unlocked
>>
>> In the second round in the mpage_map_and_submit_extent(), we failed to
>> map the blocks and call mpage_submit_buffers() to submit and unlock
>> this partially mapped folio. Additionally, we increased mpd->first_page.
>>
>>                      first_page next_page
>>                      |        /
>>       [WWWW][WWWW][WWHH][HHHH]              H: hole    L: locked
>>        UUUU  UUUU  UUUU  LLLL               W: mapped  U: unlocked
> 
> Good. But what if we have a filesystem with 1k blocksize and order 0
> folios? I mean situation like:
> 
>         first_page             next_page
>         |                      |
>        [HHHH][HHHH][HHHH][HHHH]              H: hole  L: locked
>         L     L     L     L
> 
> Now we map first two folios.
> 
>                    first_page  next_page
>                    |           |
>        [MMMM][MMMM][HHHH][HHHH]              H: hole  L: locked
>                     L     L
> 
> Now mpage_map_one_extent() maps half of the folio and fails to extend the
> transaction further:
> 
>                    first_page  next_page
>                    |           |
>        [MMMM][MMMM][MMHH][HHHH]              H: hole  L: locked
>                     L     L
> 
> and mpage_submit_folio() now shifts mpd->first page like:
> 
>                           first_page
>                           |    next_page
>                           |    |
>        [MMMM][MMMM][MMHH][HHHH]              H: hole  L: locked
>                     L     L
> 
> and it never gets reset back?
> 
> I suspect you thought that the failure to extend transaction in the middle
> of order 0 folio should not happen because you reserve credits for full
> page worth of writeback? But those credits could be exhaused by the time we
> get to mapping third folio because mpage_map_one_extent() only ensures
> there are credits for mapping one extent.

Ooops, you are right. Sorry, it was my mistake.

> 
> And I think reserving credits for just one extent is fine even from the
> beginning (as I wrote in my comment to patch 4). We just need to handle
> this partial case 

Yeah.

> which should be possible by just leaving
> mpd->first_page untouched and leave unlocking to
> mpage_release_unused_pages(). 

I was going to use this solution, but it breaks the semantics of the
mpage_release_unused_pages() and trigger BUG_ON(folio_test_writeback(folio))
in this function. I don't want to drop this BUG_ON since I think it's
somewhat useful.

> But I can be missing some effects, the writeback code is really complex...

Indeed, I was confused by this code for a long time. Thank you a lot for
patiently correcting my mistakes in my patch.

> BTW long-term the code may be easier to follow if we replace
> mpd->first_page and mpd->next_page with logical block based or byte based
> indexing. Now when we have large order folios, page is not that important
> concept for writeback anymore.
> 

I suppose we should do this conversion now.

Thanks,
Yi.







