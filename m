Return-Path: <linux-fsdevel+bounces-53754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28FAF67B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 04:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2643AA9CA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 02:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712561C07F6;
	Thu,  3 Jul 2025 02:05:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990BA2F32;
	Thu,  3 Jul 2025 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508322; cv=none; b=CwZui8Yj3ygO/WE5vr8cvS/hDuJNx5Fcw6Tr4okQc2JHB4GCDJrF849V2XVTq0w/Vv4CIdgWQWxrV8dV7TatNU4FmDFvrWoqAYz21pg6UWT98FJ1jZdwJO3ad3VtrLBfJPMnh+BhQQRGlOmqAFHMyi6uUkYJlV6VT/QcY1hK6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508322; c=relaxed/simple;
	bh=wz2hO77el1aq9zOCPG42YTLU5SEI6sVB4Utc4vOYjmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLxHCstQ1VWq17PZL7zIkcySddMWKqXyj0ZjnEElF+xWgxxhQfKyIGZ3Sh21kTwOunzce50/aDpMvkmdheuBytI9Xz+ap/EQStHZTogNN+uW45kDjeHqVFsDazkBATXH5jdi1IjGEkRkA5mlDoGWNVL811hv0PxrQyBFAzfnSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bXg8D62y5zYQvMY;
	Thu,  3 Jul 2025 10:05:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B01BB1A0E8C;
	Thu,  3 Jul 2025 10:05:15 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP3 (Coremail) with SMTP id _Ch0CgAHaCVa5WVo2TfrAQ--.65001S3;
	Thu, 03 Jul 2025 10:05:15 +0800 (CST)
Message-ID: <fa74ce4b-6dd0-4f65-8daf-36faa94709ef@huaweicloud.com>
Date: Thu, 3 Jul 2025 10:05:14 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] ext4: fix stale data if it bail out of the
 extents mapping loop
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 ojaswin@linux.ibm.com, sashal@kernel.org, yi.zhang@huawei.com,
 libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250701130635.4079595-1-yi.zhang@huaweicloud.com>
 <20250701130635.4079595-4-yi.zhang@huaweicloud.com>
 <hybrquimicexphjrsgcqawpdwtkauemo7ckolnnoygvd5zbtg4@epiqru756uip>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <hybrquimicexphjrsgcqawpdwtkauemo7ckolnnoygvd5zbtg4@epiqru756uip>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAHaCVa5WVo2TfrAQ--.65001S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur1kXw17ArW7Wr15JF1kXwb_yoW5ur47pF
	WSkan8CF48Jayakr92qF4DZryIk393ZrW7Jay7Ga4ayFn0kr9akr1fK3WY9FW5Jry8Jay0
	vF4Utw17W3WDAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/7/2 22:07, Jan Kara wrote:
> On Tue 01-07-25 21:06:28, Zhang Yi wrote:
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
>> Fix this by submitting the current processing partially mapped folio.
>>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Just one naming suggestion below:
> 
>> +/*
>> + * This is used to submit mapped buffers in a single folio that is not fully
>> + * mapped for various reasons, such as insufficient space or journal credits.
>> + */
>> +static int mpage_submit_buffers(struct mpage_da_data *mpd)
> 
> mpage_submit_buffers() sounds somewhat generic. How about
> mpage_submit_partial_folio()?
> 
> 								Honza
>

Yeah, mpage_submit_partial_folio looks better to me.

Thanks,
Yi.


>> +{
>> +	struct inode *inode = mpd->inode;
>> +	struct folio *folio;
>> +	loff_t pos;
>> +	int ret;
>> +
>> +	folio = filemap_get_folio(inode->i_mapping,
>> +				  mpd->start_pos >> PAGE_SHIFT);
>> +	if (IS_ERR(folio))
>> +		return PTR_ERR(folio);
>> +	/*
>> +	 * The mapped position should be within the current processing folio
>> +	 * but must not be the folio start position.
>> +	 */
>> +	pos = mpd->map.m_lblk << inode->i_blkbits;
>> +	if (WARN_ON_ONCE((folio_pos(folio) == pos) ||
>> +			 !folio_contains(folio, pos >> PAGE_SHIFT)))
>> +		return -EINVAL;
>> +
>> +	ret = mpage_submit_folio(mpd, folio);
>> +	if (ret)
>> +		goto out;
>> +	/*
>> +	 * Update start_pos to prevent this folio from being released in
>> +	 * mpage_release_unused_pages(), it will be reset to the aligned folio
>> +	 * pos when this folio is written again in the next round. Additionally,
>> +	 * do not update wbc->nr_to_write here, as it will be updated once the
>> +	 * entire folio has finished processing.
>> +	 */
>> +	mpd->start_pos = pos;
>> +out:
>> +	folio_unlock(folio);
>> +	folio_put(folio);
>> +	return ret;
>> +}
>> +
>>  /*
>>   * mpage_map_and_submit_extent - map extent starting at mpd->lblk of length
>>   *				 mpd->len and submit pages underlying it for IO
>> @@ -2411,8 +2452,16 @@ static int mpage_map_and_submit_extent(handle_t *handle,
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
>> +					if (mpage_submit_buffers(mpd))
>> +						goto invalidate_dirty_pages;
>>  					goto update_disksize;
>> +				}
>>  				return err;
>>  			}
>>  			ext4_msg(sb, KERN_CRIT,
>> -- 
>> 2.46.1
>>


