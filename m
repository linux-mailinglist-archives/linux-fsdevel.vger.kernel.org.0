Return-Path: <linux-fsdevel+bounces-52289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20121AE12B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 06:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAD24A052D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 04:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1F1FFC7E;
	Fri, 20 Jun 2025 04:57:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30311AD3E0;
	Fri, 20 Jun 2025 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750395447; cv=none; b=AIQJx+VwCpUKXoQTCA/X7EgSgmPcVkz3ufu+exx7JkQOwoQG+XJcSQpilx/QJSzZ2YUxtOOyzbB7OgGKuu87fr8WetI69XHB2cokfsaO5V1P9ztOW237JXkP3NJXB2ZQV+YbTBwGGku5jNyar2xSLV6xZ5R+wvkroDoComgz5zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750395447; c=relaxed/simple;
	bh=uRgcwl290Kvbz+ly3bPzS+eyzIM6ccDi/Yg/oDEdo2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZOlof+DHOdbgApCxBWyvGl8C6LWPLvDi6A5V1WPhD1w1KScbEPKPWtIdQoV2DcWlBmUmua2g4tIhQJkqxhRSwyZ7mZOyqmcKCyOuCUsVlAVOdY51ySt7ZTPGwhZlAxaqE/2udgl/wGryp/d0/yvh0W7CNdeh1nVQYQop3nvj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bNlZp4LJlzKHMk8;
	Fri, 20 Jun 2025 12:57:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F11E11A111D;
	Fri, 20 Jun 2025 12:57:20 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDHK2Av6lRoLGpLQA--.8922S3;
	Fri, 20 Jun 2025 12:57:20 +0800 (CST)
Message-ID: <14966764-5bbc-48a9-9d56-841255cfe3c6@huaweicloud.com>
Date: Fri, 20 Jun 2025 12:57:18 +0800
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
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <m5drn6xauyaksmui7b3vpua24ttgmjnwsi3sgavpelxlcwivsw@6bpmobqvpw7f>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHK2Av6lRoLGpLQA--.8922S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4UAr4DKF17JFW7tF18Zrb_yoWxKw4UpF
	WDC3Z0kw1DJaySvr9xZayDAr1Sv395Jr4UJa47ta9IvF98ur1fKr18ta4Uur45Grs7AFW0
	qF45KF4UuF1UJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2025/6/20 0:21, Jan Kara wrote:
> On Wed 11-06-25 19:16:21, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> During the process of writing back folios, if
>> mpage_map_and_submit_extent() exits the extent mapping loop due to an
>> ENOSPC or ENOMEM error, it may result in stale data or filesystem
>> inconsistency in environments where the block size is smaller than the
>> folio size.
>>
>> When mapping a discontinuous folio in mpage_map_and_submit_extent(),
>> some buffers may have already be mapped. If we exit the mapping loop
>> prematurely, the folio data within the mapped range will not be written
>> back, and the file's disk size will not be updated. Once the transaction
>> that includes this range of extents is committed, this can lead to stale
>> data or filesystem inconsistency.
>>
>> Fix this by submitting the current processing partial mapped folio and
>> update the disk size to the end of the mapped range.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 3a086fee7989..d0db6e3bf158 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -2362,6 +2362,42 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * This is used to submit mapped buffers in a single folio that is not fully
>> + * mapped for various reasons, such as insufficient space or journal credits.
>> + */
>> +static int mpage_submit_buffers(struct mpage_da_data *mpd, loff_t pos)
>> +{
>> +	struct inode *inode = mpd->inode;
>> +	struct folio *folio;
>> +	int ret;
>> +
>> +	folio = filemap_get_folio(inode->i_mapping, mpd->first_page);
>> +	if (IS_ERR(folio))
>> +		return PTR_ERR(folio);
>> +
>> +	ret = mpage_submit_folio(mpd, folio);
>> +	if (ret)
>> +		goto out;
>> +	/*
>> +	 * Update first_page to prevent this folio from being released in
>> +	 * mpage_release_unused_pages(), it should not equal to the folio
>> +	 * index.
>> +	 *
>> +	 * The first_page will be reset to the aligned folio index when this
>> +	 * folio is written again in the next round. Additionally, do not
>> +	 * update wbc->nr_to_write here, as it will be updated once the
>> +	 * entire folio has finished processing.
>> +	 */
>> +	mpd->first_page = round_up(pos, PAGE_SIZE) >> PAGE_SHIFT;
> 
> Well, but there can be many folios between mpd->first_page and pos. And
> this way you avoid cleaning them up (unlocking them and dropping elevated
> refcount) before we restart next loop. How is this going to work?
> 

Hmm, I don't think there can be many folios between mpd->first_page and
pos. All of the fully mapped folios should be unlocked by
mpage_folio_done(), and there is no elevated since it always call
folio_batch_release() once we finish processing the folios.
mpage_release_unused_pages() is used to clean up unsubmitted folios.

For example, suppose we have a 4kB block size filesystem and we found 4
order-2 folios need to be mapped in the mpage_prepare_extent_to_map().

       first_page             next_page
       |                      |
      [HHHH][HHHH][HHHH][HHHH]              H: hole  L: locked
       LLLL  LLLL  LLLL  LLLL

In the first round in the mpage_map_and_submit_extent(), we mapped the
first two folios along with the first two pages of the third folio, the
mpage_map_and_submit_buffers() should then submit and unlock the first
two folios, while also updating mpd->first_page to the beginning of the
third folio.

                  first_page  next_page
                  |          |
      [WWWW][WWWW][WWHH][HHHH]              H: hole    L: locked
       UUUU  UUUU  LLLL  LLLL               W: mapped  U: unlocked

In the second round in the mpage_map_and_submit_extent(), we failed to
map the blocks and call mpage_submit_buffers() to submit and unlock
this partially mapped folio. Additionally, we increased mpd->first_page.

                     first_page next_page
                     |        /
      [WWWW][WWWW][WWHH][HHHH]              H: hole    L: locked
       UUUU  UUUU  UUUU  LLLL               W: mapped  U: unlocked

Then, we break out to ext4_do_writepages(), which calls
mpage_release_unused_pages() to unlock the last folio.

                     first_page next_page
                     |        /
      [WWWW][WWWW][WWHH][HHHH]              H: hole    L: locked
       UUUU  UUUU  UUUU  UUUU               W: mapped  U: unlocked

In the next round in the ext4_do_writepages(), mpage_prepare_extent_to_map()
restarts processing the third folio and resets the mpd->first_page to
the beginning of it.

                   first_page  next_page
                   |          /
      [WWWW][WWWW][WWHH][HHHH]              H: hole    L: locked
       UUUU  UUUU  LLLL  LLLL               W: mapped  U: unlocked


> Also I don't see in this patch where mpd->first_page would get set back to
> retry writing this folio. What am I missing?
> 

We already have this setting, please refer to the following section in
mpage_prepare_extent_to_map().

static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
{
	pgoff_t index = mpd->first_page;
	...
	mpd->map.m_len = 0;
	mpd->next_page = index;
	...
	while (index <= end) {
...
			if (mpd->map.m_len == 0)
				mpd->first_page = folio->index;
...
}

>> +	WARN_ON_ONCE((folio->index == mpd->first_page) ||
>> +		     !folio_contains(folio, pos >> PAGE_SHIFT));
>> +out:
>> +	folio_unlock(folio);
>> +	folio_put(folio);
>> +	return ret;
>> +}
>> +
>>  /*
>>   * mpage_map_and_submit_extent - map extent starting at mpd->lblk of length
>>   *				 mpd->len and submit pages underlying it for IO
>> @@ -2412,8 +2448,16 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>>  			 */
>>  			if ((err == -ENOMEM) ||
>>  			    (err == -ENOSPC && ext4_count_free_clusters(sb))) {
>> -				if (progress)
>> +				/*
>> +				 * We may have already allocated extents for
>> +				 * some bhs inside the folio, issue the
>> +				 * corresponding data to prevent stale data.
>> +				 */
>> +				if (progress) {
>> +					if (mpage_submit_buffers(mpd, disksize))
>> +						goto invalidate_dirty_pages;
>>  					goto update_disksize;
>> +				}
>>  				return err;
>>  			}
>>  			ext4_msg(sb, KERN_CRIT,
>> @@ -2432,6 +2476,8 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>>  			*give_up_on_write = true;
>>  			return err;
>>  		}
>> +		disksize = ((loff_t)(map->m_lblk + map->m_len)) <<
>> +				inode->i_blkbits;
> 
> I don't think setting disksize like this is correct in case
> mpage_map_and_submit_buffers() below fails (when extent covers many folios
> and we don't succeed in writing them all). In that case we may need to keep
> disksize somewhere in the middle of the extent.
> 
> Overall I don't think we need to modify disksize handling here. It is fine
> to leave (part of) the extent dangling beyond disksize until we retry the
> writeback in these rare cases.

OK, this is indeed a rare case. Let's keep it as it is.

Thanks,
Yi.

> 
>>  		progress = 1;
>>  		/*
>>  		 * Update buffer state, submit mapped pages, and get us new
>> @@ -2442,12 +2488,12 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>>  			goto update_disksize;
>>  	} while (map->m_len);
>>  
>> +	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
>>  update_disksize:
>>  	/*
>>  	 * Update on-disk size after IO is submitted.  Races with
>>  	 * truncate are avoided by checking i_size under i_data_sem.
>>  	 */
>> -	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
>>  	if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
>>  		int err2;
>>  		loff_t i_size;
> 
> 								Honza


