Return-Path: <linux-fsdevel+bounces-63825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF02BCEDBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 03:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AF21A62052
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6D87D098;
	Sat, 11 Oct 2025 01:20:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027034BA57;
	Sat, 11 Oct 2025 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760145642; cv=none; b=btfo6rJdq6GG2Nvz9cktqtTE27+TZjo0PrE3weyo/lhqesnVjW92dvvP58evbGOuqbf79q+wOQF+BnBomux0h/b8+wWRfY9F9d1cJ3GX+EMp1Ye1uaO9lY/jI4sEkbLGjvxAeZfiv/fhXeChWBIAX2VgM8MBwXC6CA+TRkA+Xdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760145642; c=relaxed/simple;
	bh=3fhpvZ3VfMyWFc+BjLgInTMsIfV04gcVoPmD/6ASl3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8S8OoOLF0DccJ8Xv2GURjV/Uu/I7mm2OcS6xbLH3eng6FM05q2pRbVZHv5jFr9gBpV3E3gOOoStQYiTM8TTVI7EFsIcslPsBxMeCBwqJuaGwQox0rocmM7vHFm8y7ci3xFxEFUyW1ZRSq6kv4Z77+VLnJAEnH4WGRaMyg4wZho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ck5Ps3kbnzYQtrB;
	Sat, 11 Oct 2025 09:20:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B69261A0843;
	Sat, 11 Oct 2025 09:20:36 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgA3+mHisOlo+on_CQ--.8318S3;
	Sat, 11 Oct 2025 09:20:36 +0800 (CST)
Message-ID: <021b2564-4f1d-4dd7-b98c-569668c8359a@huaweicloud.com>
Date: Sat, 11 Oct 2025 09:20:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/12] ext4: introduce mext_move_extent()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
 yangerkun@huawei.com
References: <20251010103326.3353700-1-yi.zhang@huaweicloud.com>
 <20251010103326.3353700-10-yi.zhang@huaweicloud.com>
 <pkhkxgsoa3e3svcwudqo5jckurdqnhkdd6ckbkvgp424lxfcvn@h4nazw5rrd77>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <pkhkxgsoa3e3svcwudqo5jckurdqnhkdd6ckbkvgp424lxfcvn@h4nazw5rrd77>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3+mHisOlo+on_CQ--.8318S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GFy7tryrJFy8tr13JFykuFg_yoW7ArW5pF
	WxCF1DKrWkJa4I9r1Ivw4kXFyxK3y7Gr47Cr4fWFy7CFWqvFyrKFWUKa15uFy8CrW8G3Wj
	vF40yr9rW3s8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 10/10/2025 9:38 PM, Jan Kara wrote:
> On Fri 10-10-25 18:33:23, Zhang Yi wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> When moving extents, the current move_extent_per_page() process can only
>> move extents of length PAGE_SIZE at a time, which is highly inefficient,
>> especially when the fragmentation of the file is not particularly
>> severe, this will result in a large number of unnecessary extent split
>> and merge operations. Moreover, since the ext4 file system now supports
>> large folios, using PAGE_SIZE as the processing unit is no longer
>> practical.
>>
>> Therefore, introduce a new move extents method, mext_move_extent(). It
>> moves one extent of the origin inode at a time, but not exceeding the
>> size of a folio. The parameters for the move are passed through the new
>> mext_data data structure, which includes the origin inode, donor inode,
>> the mapping extent of the origin inode to be moved, and the starting
>> offset of the donor inode.
>>
>> The move process is similar to move_extent_per_page() and can be
>> categorized into three types: MEXT_SKIP_EXTENT, MEXT_MOVE_EXTENT, and
>> MEXT_COPY_DATA. MEXT_SKIP_EXTENT indicates that the corresponding area
>> of the donor file is a hole, meaning no actual space is allocated, so
>> the move is skipped. MEXT_MOVE_EXTENT indicates that the corresponding
>> areas of both the origin and donor files are unwritten, so no data needs
>> to be copied; only the extents are swapped. MEXT_COPY_DATA indicates
>> that the corresponding areas of both the origin and donor files contain
>> data, so data must be copied. The data copying is performed in three
>> steps: first, the data from the original location is read into the page
>> cache; then, the extents are swapped, and the page cache is rebuilt to
>> reflect the index of the physical blocks; finally, the dirty page cache
>> is marked and written back to ensure that the data is written to disk
>> before the metadata is persisted.
>>
>> One important point to note is that the folio lock and i_data_sem are
>> held only during the moving process. Therefore, before moving an extent,
>> it is necessary to check whether the sequence cookie of the area to be
>> moved has changed while holding the folio lock. If a change is detected,
>> it indicates that concurrent write-back operations may have occurred
>> during this period, and the type of the extent to be moved can no longer
>> be considered reliable. For example, it may have changed from unwritten
>> to written. In such cases, return -ESTALE, and the calling function
>> should reacquire the move extent of the original file and retry the
>> movement.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> ...
> 
>> +static __used int mext_move_extent(struct mext_data *mext, u64 *m_len)
>> +{
>> +	struct inode *orig_inode = mext->orig_inode;
>> +	struct inode *donor_inode = mext->donor_inode;
>> +	struct ext4_map_blocks *orig_map = &mext->orig_map;
>> +	unsigned int blkbits = orig_inode->i_blkbits;
>> +	struct folio *folio[2] = {NULL, NULL};
>> +	loff_t from, length;
>> +	enum mext_move_type move_type = 0;
>> +	handle_t *handle;
>> +	u64 r_len = 0;
>> +	unsigned int credits;
>> +	int ret, ret2;
>> +
>> +	*m_len = 0;
>> +	credits = ext4_chunk_trans_extent(orig_inode, 0) * 2;
>> +	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, credits);
>> +	if (IS_ERR(handle))
>> +		return PTR_ERR(handle);
>> +
>> +	ret = mext_move_begin(mext, folio, &move_type);
>> +	if (ret)
>> +		goto stop_handle;
>> +
>> +	if (move_type == MEXT_SKIP_EXTENT)
>> +		goto unlock;
>> +
>> +	/*
>> +	 * Copy the data. First, read the original inode data into the page
>> +	 * cache. Then, release the existing mapping relationships and swap
>> +	 * the extent. Finally, re-establish the new mapping relationships
>> +	 * and dirty the page cache.
>> +	 */
>> +	if (move_type == MEXT_COPY_DATA) {
>> +		from = offset_in_folio(folio[0],
>> +				((loff_t)orig_map->m_lblk) << blkbits);
>> +		length = ((loff_t)orig_map->m_len) << blkbits;
>> +
>> +		ret = mext_folio_mkuptodate(folio[0], from, from + length);
>> +		if (ret)
>> +			goto unlock;
>> +	}
>> +
>> +	if (!filemap_release_folio(folio[0], 0) ||
>> +	    !filemap_release_folio(folio[1], 0)) {
>> +		ret = -EBUSY;
>> +		goto unlock;
>> +	}
>> +
>> +	/* Move extent */
>> +	ext4_double_down_write_data_sem(orig_inode, donor_inode);
>> +	*m_len = ext4_swap_extents(handle, orig_inode, donor_inode,
>> +				   orig_map->m_lblk, mext->donor_lblk,
>> +				   orig_map->m_len, 1, &ret);
>> +	ext4_double_up_write_data_sem(orig_inode, donor_inode);
>> +
>> +	/* A short-length swap cannot occur after a successful swap extent. */
>> +	if (WARN_ON_ONCE(!ret && (*m_len != orig_map->m_len)))
>> +		ret = -EIO;
>> +
>> +	if (!(*m_len) || (move_type == MEXT_MOVE_EXTENT))
>> +		goto unlock;
>> +
>> +	/* Copy data */
>> +	length = (*m_len) << blkbits;
>> +	ret = mext_folio_mkwrite(orig_inode, folio[0], from, from + length);
>> +	if (ret)
>> +		goto repair_branches;
> 
> I think you need to be careful here and below to not overwrite 'ret' if it
> is != 0. So something like:
> 
> 	ret2 = mext_folio_mkwrite(..)
> 	if (ret2) {
> 		if (!ret)
> 			ret = ret2;
> 		goto repair_branches;
> 	}
> 
> and something similar below. Otherwise the patch looks good to me.
> 
> 								Honza

OK, although overwrite 'ret' seems fine, it's better to keep it.

Thanks,
Yi.



