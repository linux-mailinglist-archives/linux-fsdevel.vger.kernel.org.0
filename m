Return-Path: <linux-fsdevel+bounces-69982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DF6C8CFA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 08:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB5324E1469
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 07:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D852F60B2;
	Thu, 27 Nov 2025 07:01:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4E4239594;
	Thu, 27 Nov 2025 07:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764226896; cv=none; b=ZccGpt6G+ptgAZ4cfO2x0EaAcGKDEsMTDYko8uuLwcVIXrnGo8/Ma/EIAhfzVd4+h4Dj7G5aMv1zjZiVttZCRZD6iI1ohzyr2wYiWLT9AO1PfGZrFTITCq+GEBqo9l0/6MGPQq6CdX5N9b0jKa6ihLXeOeC5mqGfCXbkiMHY3J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764226896; c=relaxed/simple;
	bh=qIPy6G5I822y4hiAYBmIWifrftFGsURLxM/EAnnNC/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i5wRyEy3r5AfN3QNaq9y3U5NtVBY3lz6qGZJ1YoUzOQsfh8u0ojR9pa7SZdeUWRm4ez33kgjrMwL4AJXQLat4Tgs7doh41x26kv42h7yJOCTf611rrKz5Dts7Hg896yxVfeoFZ+JI6miIyyo0myofSDMH6qjr7/RhYcnZOGtBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dH6l86nmlzYQv0k;
	Thu, 27 Nov 2025 15:00:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 27E021A1542;
	Thu, 27 Nov 2025 15:01:30 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgBHpXtI9ydp8YOwCA--.20270S3;
	Thu, 27 Nov 2025 15:01:30 +0800 (CST)
Message-ID: <bec5bcd5-59ea-4e69-bf4c-7031bcf9008b@huaweicloud.com>
Date: Thu, 27 Nov 2025 15:01:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] ext4: don't cache extent during splitting extent
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, yi.zhang@huawei.com, yizhang089@gmail.com,
 libaokun1@huawei.com, yangerkun@huawei.com
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-7-yi.zhang@huaweicloud.com>
 <aSbsxpMSVGyywIIX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <aSbsxpMSVGyywIIX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHpXtI9ydp8YOwCA--.20270S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw45Gw4fXF15Xr17Cr4Uurg_yoWrAF4Dpr
	ZrCF4UJr4vkw1vk3yxAF4Dtr1F93s3JrW7AryfGw1SkFy5JFySgFW7ta45ZFyFgrW8Z3Wa
	vr48K3W5Ca4DAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/26/2025 8:04 PM, Ojaswin Mujoo wrote:
> On Fri, Nov 21, 2025 at 02:08:04PM +0800, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Caching extents during the splitting process is risky, as it may result
>> in stale extents remaining in the status tree. Moreover, in most cases,
>> the corresponding extent block entries are likely already cached before
>> the split happens, making caching here not particularly useful.
>>
>> Assume we have an unwritten extent, and then DIO writes the first half.
>>
>>   [UUUUUUUUUUUUUUUU] on-disk extent        U: unwritten extent
>>   [UUUUUUUUUUUUUUUU] extent status tree
>>   |<-   ->| ----> dio write this range
>>
>> First, when ext4_split_extent_at() splits this extent, it truncates the
>> existing extent and then inserts a new one. During this process, this
>> extent status entry may be shrunk, and calls to ext4_find_extent() and
>> ext4_cache_extents() may occur, which could potentially insert the
>> truncated range as a hole into the extent status tree. After the split
>> is completed, this hole is not replaced with the correct status.
>>
>>   [UUUUUUU|UUUUUUUU] on-disk extent        U: unwritten extent
>>   [UUUUUUU|HHHHHHHH] extent status tree    H: hole
>>
>> Then, the outer calling functions will not correct this remaining hole
>> extent either. Finally, if we perform a delayed buffer write on this
>> latter part, it will re-insert the delayed extent and cause an error in
>> space accounting.
> 
> Okay, makes sense. So one basic question, I see that in
> ext4_ext_insert_extent() doesnt really care about updating es unless as a
> side effect of ext4_find_extent().  For example, if we end up at goto
> has_space; we don't add the new extent and niether do we update that the
> exsisting extent has shrunk. 
> 
> Similarly, the splitting code also doesn't seem to care about the es
> cache other than zeroout in the error handling.
> 
> Is there a reason for this? Do we expect the upper layers to maintain
> the es cache?

Yeah, if we don't consider the zeroout case caused by a failed split,
under typical circumstances, the ext4_es_insert_extent() in
ext4_map_create_blocks() is called to insert or update the cached
extent entries.

However, ext4_map_create_blocks() only insert or update
the range that the caller want to map, it can't know the actual
initialized range if this extent has been zeroed out, so we have to
update the extent cache in ext4_split_extent_at() for this special case.
Please see commit adb2355104b2 ("ext4: update extent status tree after
an extent is zeroed out") for details.

Unfortunately, the legacy scenario described in this patch remains
unhandled.

Cheers,
Yi.

>>
>> In adition, if the unwritten extent cache is not shrunk during the
>> splitting, ext4_cache_extents() also conflicts with existing extents
>> when caching extents. In the future, we will add checks when caching
>> extents, which will trigger a warning. Therefore, Do not cache extents
>> that are being split.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/extents.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 19338f488550..2b5aec3f8882 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3199,6 +3199,9 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
>>  	BUG_ON((split_flag & EXT4_EXT_DATA_VALID1) &&
>>  	       (split_flag & EXT4_EXT_DATA_VALID2));
>>  
>> +	/* Do not cache extents that are in the process of being modified. */
>> +	flags |= EXT4_EX_NOCACHE;
>> +
>>  	ext_debug(inode, "logical block %llu\n", (unsigned long long)split);
>>  
>>  	ext4_ext_show_leaf(inode, path);
>> @@ -3364,6 +3367,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
>>  	ee_len = ext4_ext_get_actual_len(ex);
>>  	unwritten = ext4_ext_is_unwritten(ex);
>>  
>> +	/* Do not cache extents that are in the process of being modified. */
>> +	flags |= EXT4_EX_NOCACHE;
>> +
>>  	if (map->m_lblk + map->m_len < ee_block + ee_len) {
>>  		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
>>  		flags1 = flags | EXT4_GET_BLOCKS_PRE_IO;
>> -- 
>> 2.46.1
>>


