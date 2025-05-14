Return-Path: <linux-fsdevel+bounces-49005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A65AB752A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 21:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BB53A77E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 19:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4628C87B;
	Wed, 14 May 2025 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2If0vIn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37B1F4606;
	Wed, 14 May 2025 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249731; cv=none; b=gULdf89ckbwLkHg63FevMFvNU1MWFt1wD8UWu6B4FyU5r35ANhwgjfdonr0auOHvH3oMzUMtEw3X2TbaZQgx9tSKsWwtHJqFvYx0+tgr8RXR3YIYNZNlP9jpZg1T6RkzkRqJi9mf7xP6W4kC1EWGEHpsxz3vIxaPp/nf864y02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249731; c=relaxed/simple;
	bh=QFDkBjyNLjBp3n8ItqIsEgnBUYTkAuWEqUS+v0uesQs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=rg8OroZy4rurITEVw358LbyFy4m+IUHVK19tIb50zH2FwMYBC6cTVsuuZYEqXWhnht3mTFMn6npwD5LYhdCErl0xYJg5XdUcTyBhinxOjfMysZzufVmFCx07iXf3e1isxYAcKArJjYHYZ5lNbqyEwZBV7eI2XXNBcQ6aS2Y6Whk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2If0vIn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22c336fcdaaso1310815ad.3;
        Wed, 14 May 2025 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747249728; x=1747854528; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TNIWj7McG8NfuRyb4IVck2y+miQK7YKULLlHQtNV59A=;
        b=T2If0vInXoVIBUyYUWBNP3emRLDlQghYk9ZvVHJ7FR9w3t4XxEDRdKhGd+bWzT/13v
         GFfXtj4ilzaDpfNKf7vsrngwxp4Hte8JcZgV68GQrF0e+G9UfLO06QoHojs6Ek9fbnRB
         Mze1R/KImQZerOkSuVshAsPMdgWmQlcWsSBKjlKj5V3KIPJRZ+yye//NfSdbQf+iiSPQ
         fQx4eEeGNmKmKs1PTCeKOOmgDEEZvC94wx+iqLG4JRTxb4BYVGItl2VU38njgVshy4Gz
         XDBZtr5gLJyGCPhx3iP5f/kIUQGHbwEAzbus12VkTnv8INg4bndB2GrPaP6XXCdnnSoV
         eLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747249728; x=1747854528;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNIWj7McG8NfuRyb4IVck2y+miQK7YKULLlHQtNV59A=;
        b=sdI6AL7zUm8AswdasxtJN1rWMbvd3QuOXwhV1yMDjkkXOZhHdahiGQA4RWnFnqlh5a
         ZoKjniMAGFiqqTCkz5NHMOtVvLwho8yHnyD6X186tUfyZIntYJhxJvnhLAVCdKT7+lZB
         oNtxgrRDelJLDw0a6ljv8kI7GBnqqCHvwpKMBUTk4X7/x+bLNxF74uUFY82YtiE7Zohi
         x9ImCOYqLX5gZoX+hMd2XmnjiRLCKruF9W9Z0nVphhkex5RsWLi/rYKvPSYZcqMg2flj
         ijaXVRnyhTNgdE0/s7sI4wnsmnPriFMiRLnSV1sMG+2VmN8SO1zDDvpycJt0Bcq8w5Cn
         wunA==
X-Forwarded-Encrypted: i=1; AJvYcCWBkRcQlqESOfhe8Q5t/i6V4I9ZH9eqanMZIbk8TzZcus06/lijunk3q1r0tfND2XLZYUBWFLHNNmQ3a1nc@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZcmSzZ4YeMNLS7ie1oVqbWAnP1JElxoeWB8yTQyTiBOPi+KF
	1FXHQcEBOB6CU92pCvV6S/gLkyx7mWXQyObwHsnSGPKqy9anAuN8Kb7nGg==
X-Gm-Gg: ASbGncvYE4WWELB1dlMMd6NJZR2BCDvMVTH9usfY4iad3Xgur6A2xutA1QsTuNuJ0Wy
	HyUbrMimrD7mESGYlvoKo1Qc7OsxEDfDofh/7op9D36DmCT7TvrBbW5XwjTSxHp/QOXjfPzt/Yn
	u+opsDe54G/sNvLL/krq4Td6FWcaBS5YNM0PGtfNa+4Gv50AsDwhgzj99rahWYh2L0rkhvUaNyk
	PyaswpYwYlKyztdj3zO+Jygxdw9/XTxwiVd8AKvPhAsTQOVCCDuyqvnD2nPMH65UO5XFyAPq7uu
	woN+fYmOvb8qQDdnvY6/Cwok57c+WiOL97K8RIKh1w==
X-Google-Smtp-Source: AGHT+IFQsBGqmkhxNHerxyRFEhJemXdYyxnwDHft1DKndivnnn6iEtddKxKJZ3Ht0H3wutexq6NioQ==
X-Received: by 2002:a17:902:f68f:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-231981835bbmr57103695ad.52.1747249728137;
        Wed, 14 May 2025 12:08:48 -0700 (PDT)
Received: from dw-tp ([171.76.87.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828b3a0sm103538395ad.179.2025.05.14.12.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 12:08:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] ext4: Add multi-fsblock atomic write support with bigalloc
In-Reply-To: <20250514161913.GH25655@frogsfrogsfrogs>
Date: Thu, 15 May 2025 00:34:43 +0530
Message-ID: <87ldqzypx0.fsf@gmail.com>
References: <cover.1746734745.git.ritesh.list@gmail.com> <dc97b425ba7f88f18ef175b014d25d9d6e074278.1746734746.git.ritesh.list@gmail.com> <20250514161913.GH25655@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Fri, May 09, 2025 at 02:20:35AM +0530, Ritesh Harjani (IBM) wrote:
>> EXT4 supports bigalloc feature which allows the FS to work in size of
>> clusters (group of blocks) rather than individual blocks. This patch
>> adds atomic write support for bigalloc so that systems with bs = ps can
>> also create FS using -
>>     mkfs.ext4 -F -O bigalloc -b 4096 -C 16384 <dev>
>> 
>> With bigalloc ext4 can support multi-fsblock atomic writes. We will have to
>> adjust ext4's atomic write unit max value to cluster size. This can then support
>> atomic write of size anywhere between [blocksize, clustersize]. This
>> patch adds the required changes to enable multi-fsblock atomic write
>> support using bigalloc in the next patch.
>> 
>> In this patch for block allocation:
>> we first query the underlying region of the requested range by calling
>> ext4_map_blocks() call. Here are the various cases which we then handle
>> depending upon the underlying mapping type:
>> 1. If the underlying region for the entire requested range is a mapped extent,
>>    then we don't call ext4_map_blocks() to allocate anything. We don't need to
>>    even start the jbd2 txn in this case.
>> 2. For an append write case, we create a mapped extent.
>> 3. If the underlying region is entirely a hole, then we create an unwritten
>>    extent for the requested range.
>> 4. If the underlying region is a large unwritten extent, then we split the
>>    extent into 2 unwritten extent of required size.
>> 5. If the underlying region has any type of mixed mapping, then we call
>>    ext4_map_blocks() in a loop to zero out the unwritten and the hole regions
>>    within the requested range. This then provide a single mapped extent type
>>    mapping for the requested range.
>> 
>> Note: We invoke ext4_map_blocks() in a loop with the EXT4_GET_BLOCKS_ZERO
>> flag only when the underlying extent mapping of the requested range is
>> not entirely a hole, an unwritten extent, or a fully mapped extent. That
>> is, if the underlying region contains a mix of hole(s), unwritten
>> extent(s), and mapped extent(s), we use this loop to ensure that all the
>> short mappings are zeroed out. This guarantees that the entire requested
>> range becomes a single, uniformly mapped extent. It is ok to do so
>> because we know this is being done on a bigalloc enabled filesystem
>> where the block bitmap represents the entire cluster unit.
>> 
>> Note having a single contiguous underlying region of type mapped,
>> unwrittn or hole is not a problem. But the reason to avoid writing on
>> top of mixed mapping region is because, atomic writes requires all or
>> nothing should get written for the userspace pwritev2 request. So if at
>> any point in time during the write if a crash or a sudden poweroff
>> occurs, the region undergoing atomic write should read either complete
>> old data or complete new data. But it should never have a mix of both
>> old and new data.
>> So, we first convert any mixed mapping region to a single contiguous
>> mapped extent before any data gets written to it. This is because
>> normally FS will only convert unwritten extents to written at the end of
>> the write in ->end_io() call. And if we allow the writes over a mixed
>> mapping and if a sudden power off happens in between, we will end up
>> reading mix of new data (over mapped extents) and old data (over
>> unwritten extents), because unwritten to written conversion never went
>> through.
>> So to avoid this and to avoid writes getting torned due to mixed
>> mapping, we first allocate a single contiguous block mapping and then
>> do the write.
>> 
>> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> Looks fine (I don't like the pre-zeroing but options are limited on
> ext4) except for one thing...
>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 8b86b1a29bdc..2642e1ef128f 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3412,6 +3412,136 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>>  	}
>>  }
>>  
>> +static int ext4_map_blocks_atomic_write_slow(handle_t *handle,
>> +			struct inode *inode, struct ext4_map_blocks *map)
>> +{
>> +	ext4_lblk_t m_lblk = map->m_lblk;
>> +	unsigned int m_len = map->m_len;
>> +	unsigned int mapped_len = 0, m_flags = 0;
>> +	ext4_fsblk_t next_pblk;
>> +	bool check_next_pblk = false;
>> +	int ret = 0;
>> +
>> +	WARN_ON_ONCE(!ext4_has_feature_bigalloc(inode->i_sb));
>> +
>> +	/*
>> +	 * This is a slow path in case of mixed mapping. We use
>> +	 * EXT4_GET_BLOCKS_CREATE_ZERO flag here to make sure we get a single
>> +	 * contiguous mapped mapping. This will ensure any unwritten or hole
>> +	 * regions within the requested range is zeroed out and we return
>> +	 * a single contiguous mapped extent.
>> +	 */
>> +	m_flags = EXT4_GET_BLOCKS_CREATE_ZERO;
>> +
>> +	do {
>> +		ret = ext4_map_blocks(handle, inode, map, m_flags);
>> +		if (ret < 0 && ret != -ENOSPC)
>> +			goto out_err;
>> +		/*
>> +		 * This should never happen, but let's return an error code to
>> +		 * avoid an infinite loop in here.
>> +		 */
>> +		if (ret == 0) {
>> +			ret = -EFSCORRUPTED;
>> +			ext4_warning_inode(inode,
>> +				"ext4_map_blocks() couldn't allocate blocks m_flags: 0x%x, ret:%d",
>> +				m_flags, ret);
>> +			goto out_err;
>> +		}
>> +		/*
>> +		 * With bigalloc we should never get ENOSPC nor discontiguous
>> +		 * physical extents.
>> +		 */
>> +		if ((check_next_pblk && next_pblk != map->m_pblk) ||
>> +				ret == -ENOSPC) {
>> +			ext4_warning_inode(inode,
>> +				"Non-contiguous allocation detected: expected %llu, got %llu, "
>> +				"or ext4_map_blocks() returned out of space ret: %d",
>> +				next_pblk, map->m_pblk, ret);
>> +			ret = -ENOSPC;
>> +			goto out_err;
>
> If you get physically discontiguous mappings within a cluster, the
> extent tree is corrupt.
>

yes, I guess I was just being hesitant to do that. But you are right,
we should return -EFSCORRUPTED here then. 

I will change the error code along with the other forcecommit change in v4. 

> --D
>

Thanks for the review!

-ritesh


>> +		next_pblk = map->m_pblk + map->m_len;
>> +		check_next_pblk = true;
>> +
>> +		mapped_len += map->m_len;
>> +		map->m_lblk += map->m_len;
>> +		map->m_len = m_len - mapped_len;
>> +	} while (mapped_len < m_len);
>> +
>> +	/*
>> +	 * We might have done some work in above loop, so we need to query the
>> +	 * start of the physical extent, based on the origin m_lblk and m_len.
>> +	 * Let's also ensure we were able to allocate the required range for
>> +	 * mixed mapping case.
>> +	 */
>> +	map->m_lblk = m_lblk;
>> +	map->m_len = m_len;
>> +	map->m_flags = 0;
>> +
>> +	ret = ext4_map_blocks(handle, inode, map,
>> +			      EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF);
>> +	if (ret != m_len) {
>> +		ext4_warning_inode(inode,
>> +			"allocation failed for atomic write request m_lblk:%u, m_len:%u, ret:%d\n",
>> +			m_lblk, m_len, ret);
>> +		ret = -EINVAL;
>> +	}
>> +	return ret;
>> +
>> +out_err:
>> +	/* reset map before returning an error */
>> +	map->m_lblk = m_lblk;
>> +	map->m_len = m_len;
>> +	map->m_flags = 0;
>> +	return ret;
>> +}
>> +
>> +/*
>> + * ext4_map_blocks_atomic: Helper routine to ensure the entire requested
>> + * range in @map [lblk, lblk + len) is one single contiguous extent with no
>> + * mixed mappings.
>> + *
>> + * We first use m_flags passed to us by our caller (ext4_iomap_alloc()).
>> + * We only call EXT4_GET_BLOCKS_ZERO in the slow path, when the underlying
>> + * physical extent for the requested range does not have a single contiguous
>> + * mapping type i.e. (Hole, Mapped, or Unwritten) throughout.
>> + * In that case we will loop over the requested range to allocate and zero out
>> + * the unwritten / holes in between, to get a single mapped extent from
>> + * [m_lblk, m_lblk +  m_len). Note that this is only possible because we know
>> + * this can be called only with bigalloc enabled filesystem where the underlying
>> + * cluster is already allocated. This avoids allocating discontiguous extents
>> + * in the slow path due to multiple calls to ext4_map_blocks().
>> + * The slow path is mostly non-performance critical path, so it should be ok to
>> + * loop using ext4_map_blocks() with appropriate flags to allocate & zero the
>> + * underlying short holes/unwritten extents within the requested range.
>> + */
>> +static int ext4_map_blocks_atomic_write(handle_t *handle, struct inode *inode,
>> +				struct ext4_map_blocks *map, int m_flags)
>> +{
>> +	ext4_lblk_t m_lblk = map->m_lblk;
>> +	unsigned int m_len = map->m_len;
>> +	int ret = 0;
>> +
>> +	WARN_ON_ONCE(m_len > 1 && !ext4_has_feature_bigalloc(inode->i_sb));
>> +
>> +	ret = ext4_map_blocks(handle, inode, map, m_flags);
>> +	if (ret < 0 || ret == m_len)
>> +		goto out;
>> +	/*
>> +	 * This is a mixed mapping case where we were not able to allocate
>> +	 * a single contiguous extent. In that case let's reset requested
>> +	 * mapping and call the slow path.
>> +	 */
>> +	map->m_lblk = m_lblk;
>> +	map->m_len = m_len;
>> +	map->m_flags = 0;
>> +
>> +	return ext4_map_blocks_atomic_write_slow(handle, inode, map);
>> +out:
>> +	return ret;
>> +}
>> +
>>  static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>  			    unsigned int flags)
>>  {
>> @@ -3425,7 +3555,30 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>  	 */
>>  	if (map->m_len > DIO_MAX_BLOCKS)
>>  		map->m_len = DIO_MAX_BLOCKS;
>> -	dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
>> +
>> +	/*
>> +	 * journal credits estimation for atomic writes. We call
>> +	 * ext4_map_blocks(), to find if there could be a mixed mapping. If yes,
>> +	 * then let's assume the no. of pextents required can be m_len i.e.
>> +	 * every alternate block can be unwritten and hole.
>> +	 */
>> +	if (flags & IOMAP_ATOMIC) {
>> +		unsigned int orig_mlen = map->m_len;
>> +
>> +		ret = ext4_map_blocks(NULL, inode, map, 0);
>> +		if (ret < 0)
>> +			return ret;
>> +		if (map->m_len < orig_mlen) {
>> +			map->m_len = orig_mlen;
>> +			dio_credits = ext4_meta_trans_blocks(inode, orig_mlen,
>> +							     map->m_len);
>> +		} else {
>> +			dio_credits = ext4_chunk_trans_blocks(inode,
>> +							      map->m_len);
>> +		}
>> +	} else {
>> +		dio_credits = ext4_chunk_trans_blocks(inode, map->m_len);
>> +	}
>>  
>>  retry:
>>  	/*
>> @@ -3456,7 +3609,10 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>  	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>>  		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
>>  
>> -	ret = ext4_map_blocks(handle, inode, map, m_flags);
>> +	if (flags & IOMAP_ATOMIC)
>> +		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags);
>> +	else
>> +		ret = ext4_map_blocks(handle, inode, map, m_flags);
>>  
>>  	/*
>>  	 * We cannot fill holes in indirect tree based inodes as that could
>> @@ -3480,6 +3636,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>  	int ret;
>>  	struct ext4_map_blocks map;
>>  	u8 blkbits = inode->i_blkbits;
>> +	unsigned int orig_mlen;
>>  
>>  	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>>  		return -EINVAL;
>> @@ -3493,6 +3650,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>  	map.m_lblk = offset >> blkbits;
>>  	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>> +	orig_mlen = map.m_len;
>>  
>>  	if (flags & IOMAP_WRITE) {
>>  		/*
>> @@ -3503,8 +3661,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>  		 */
>>  		if (offset + length <= i_size_read(inode)) {
>>  			ret = ext4_map_blocks(NULL, inode, &map, 0);
>> -			if (ret > 0 && (map.m_flags & EXT4_MAP_MAPPED))
>> -				goto out;
>> +			/*
>> +			 * For atomic writes the entire requested length should
>> +			 * be mapped.
>> +			 */
>> +			if (map.m_flags & EXT4_MAP_MAPPED) {
>> +				if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
>> +				   (flags & IOMAP_ATOMIC && ret >= orig_mlen))
>> +					goto out;
>> +			}
>> +			map.m_len = orig_mlen;
>>  		}
>>  		ret = ext4_iomap_alloc(inode, &map, flags);
>>  	} else {
>> @@ -3525,6 +3691,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>  	 */
>>  	map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
>>  
>> +	/*
>> +	 * Before returning to iomap, let's ensure the allocated mapping
>> +	 * covers the entire requested length for atomic writes.
>> +	 */
>> +	if (flags & IOMAP_ATOMIC) {
>> +		if (map.m_len < (length >> blkbits)) {
>> +			WARN_ON(1);
>> +			return -EINVAL;
>> +		}
>> +	}
>>  	ext4_set_iomap(inode, iomap, &map, offset, length, flags);
>>  
>>  	return 0;
>> -- 
>> 2.49.0
>> 
>> 

