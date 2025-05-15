Return-Path: <linux-fsdevel+bounces-49176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A26AB8F69
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 20:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084064A1885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 18:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9074725A2B2;
	Thu, 15 May 2025 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcwM+4nV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3922690E0;
	Thu, 15 May 2025 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335263; cv=none; b=Ti6BxrpZui2f+HO1Pi9iDlFskSWkd6iumBfNM6uIwECPJFvSjeTyRLWKzMcuIw0/qVcxzaI8Sk/ixcYE32/SEA6pboRiynvVLYqMGvTkb3T7h7QeMfLHrLas7pklQIH4vhA8/xnzPR8qrnYtJ7ulg1VNIn4ANb/Aj/rl7bdg3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335263; c=relaxed/simple;
	bh=2o/V9aZOOhZmsU3TUotz55YzXH9hTOdhkKk8Ra/OtNQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=KVUvL9gzg8yUFdK2zBVG77VBBxjt03GtfBfnRYyJRTrWaVfyQVEHOuksKW8IfrcuM0T/T1t0hnQw+Ndcnfz2zmyhnDlBKbot5nSC4mjfbj6mOHekrRHQVFxcwX1sUC6Zr3/LWYvAVKyQxJ+Z1blsV/HPtkf9JLKifvy/gpWqI2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcwM+4nV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e6344326dso14831445ad.1;
        Thu, 15 May 2025 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747335259; x=1747940059; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IvSaVUL8LKZwl0FLHUTOOVgpyodHFhZPrvgJmDLPgks=;
        b=lcwM+4nVvXTuQyY0RPANYDeA/PPzysHHm+SFpL8kuzzFZk68EGuxmZYN2AkhfR+hvt
         4865Bk3okEJMgQkKkWxX6d1u5QHSxHWcIiyUX0x1Y0igrHaEYj44DRt+8Mdg7HjEowDq
         s0Ve1j1cj/pcT9LpqUMMP7lQmRMdaAsPDb5u0LXSZnEvPdJgpxSHTdtaMzceK8Z3Q26R
         gOXX3w86YNDGWW3l8Z4LnOF+yYbi6lsSos+QTUtowFknAvVmsOsHWkVqtzSHH1I0GEsE
         ayiVUQF6arKzd0ubZWePDizqTTuanLyj6cH7lMBgn/EW1pahgu/wQEXkxRmZLIydJxBH
         Ppww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335259; x=1747940059;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvSaVUL8LKZwl0FLHUTOOVgpyodHFhZPrvgJmDLPgks=;
        b=dEh6SM1dt61YiKLD8pqXM7SFSc+FTwuf+6QKQU15VbqFYr8n6HRS4dmVHKIioIjhVA
         54ZfHZsTnFbdOPYuuQdAvzaumvNi4GJF50RqB5qj27KnQvZcWP7Ku7KKJNslZs0YY3xQ
         q28xZ0YEW4KPKFUBMLKMUNtSJ7cy6PzdY5J5Yj175u9cqqghTQhfOT8Tf2M0NPQCgs1C
         4GzQBVgW30PsSpW2JfUp4NgSne/8BVRbvj3kjZcoPPg96j6u+eHkRRXoPuFiJQas3FcH
         Dy7gho8xuGsFdPSkFz3nawG6IxY8NINt7EF8KLGDsuAatqd4U+dNnkeTTUxyU4fzR1yp
         b3zg==
X-Forwarded-Encrypted: i=1; AJvYcCXPmnZOo/WaS1BVJ0JXP7vjjy7QGzjrMlvuCo6N3hzx8NhjUhd3lcgRLxkD/o/Sfvky/dXgzUQ1ELo37tCQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXkp7+9ENCU6SQyfjLFMhlHTNklceelOUOEtqSafWdTxvLsPf
	1tNjG5p08wXyjz8Pg8ih6kIN6lI3NsnojXrCy3DGSwCvR0dSU98fsQXUDQbF3A==
X-Gm-Gg: ASbGncsSSi/BwDSQFjGSZrc8m7pddDIkhcr2qbaVVXXpbuRxJrAh7HnQjRMRgxc2e9T
	qVGoXapieoWnLNp7sNVpPq0QBY9WaUsFermh8wDsu7+hqTSXnyjkZavItBABV6io9rmllm3iSE3
	yzeSP5nQacsn9E1uM52y6Vhq7WsNShFnWHmMbPISliG06TzttUIL1TQv09JkGRQWqvCJHgPspui
	KtjEcMGTro8hB8v/NbS2h3v+ecP0ccxiMQCiudCn3Nq65e48YInIBXA0NgqBMKN/mNjgt86qaow
	sEwoTxlVe3ExACm8DFPQUSovRQMxWQjwwRWHbZUTlS7O
X-Google-Smtp-Source: AGHT+IF4doNGehKDRLeWfEBQVtF+u54w0GesXIdh+gWtpeDMOEqECoN9rVmAIHJsmG/Y8f+0hdABQA==
X-Received: by 2002:a17:903:41d0:b0:220:e362:9b1a with SMTP id d9443c01a7336-231d452dd76mr7109575ad.25.1747335258728;
        Thu, 15 May 2025 11:54:18 -0700 (PDT)
Received: from dw-tp ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97dadsm1097355ad.141.2025.05.15.11.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:54:17 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] ext4: Add multi-fsblock atomic write support with bigalloc
In-Reply-To: <20250515165348.GO25655@frogsfrogsfrogs>
Date: Thu, 15 May 2025 23:45:51 +0530
Message-ID: <87plg9wxig.fsf@gmail.com>
References: <cover.1747289779.git.ritesh.list@gmail.com> <3795865b7e5788d66f362cec573b196f54439e9a.1747289779.git.ritesh.list@gmail.com> <20250515165348.GO25655@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Darrick J. Wong" <djwong@kernel.org> writes:

> On Thu, May 15, 2025 at 08:15:37PM +0530, Ritesh Harjani (IBM) wrote:
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
>> ---
>>  fs/ext4/ext4.h    |   2 +
>>  fs/ext4/extents.c |  87 ++++++++++++++++++++
>>  fs/ext4/file.c    |   7 +-
>>  fs/ext4/inode.c   | 200 +++++++++++++++++++++++++++++++++++++++++++++-
>>  4 files changed, 291 insertions(+), 5 deletions(-)
>> 
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index ef6cac6b4b4c..8eb1f332ee7d 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -3728,6 +3728,8 @@ extern long ext4_fallocate(struct file *file, int mode, loff_t offset,
>>  			  loff_t len);
>>  extern int ext4_convert_unwritten_extents(handle_t *handle, struct inode *inode,
>>  					  loff_t offset, ssize_t len);
>> +extern int ext4_convert_unwritten_extents_atomic(handle_t *handle,
>> +			struct inode *inode, loff_t offset, ssize_t len);
>>  extern int ext4_convert_unwritten_io_end_vec(handle_t *handle,
>>  					     ext4_io_end_t *io_end);
>>  extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index fa850f188d46..2967c74dabaf 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -4792,6 +4792,93 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>>  	return ret;
>>  }
>>  
>> +/*
>> + * This function converts a range of blocks to written extents. The caller of
>> + * this function will pass the start offset and the size. all unwritten extents
>> + * within this range will be converted to written extents.
>> + *
>> + * This function is called from the direct IO end io call back function for
>> + * atomic writes, to convert the unwritten extents after IO is completed.
>> + *
>> + * Note that the requirement for atomic writes is that all conversion should
>> + * happen atomically in a single fs journal transaction. We mainly only allocate
>> + * unwritten extents either on a hole on a pre-exiting unwritten extent range in
>> + * ext4_map_blocks_atomic_write(). The only case where we can have multiple
>> + * unwritten extents in a range [offset, offset+len) is when there is a split
>> + * unwritten extent between two leaf nodes which was cached in extent status
>> + * cache during ext4_iomap_alloc() time. That will allow
>> + * ext4_map_blocks_atomic_write() to return the unwritten extent range w/o going
>> + * into the slow path. That means we might need a loop for conversion of this
>> + * unwritten extent split across leaf block within a single journal transaction.
>> + * Split extents across leaf nodes is a rare case, but let's still handle that
>> + * to meet the requirements of multi-fsblock atomic writes.
>> + *
>> + * Returns 0 on success.
>> + */
>> +int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
>> +					  loff_t offset, ssize_t len)
>> +{
>> +	unsigned int max_blocks;
>> +	int ret = 0, ret2 = 0, ret3 = 0;
>> +	struct ext4_map_blocks map;
>> +	unsigned int blkbits = inode->i_blkbits;
>> +	unsigned int credits = 0;
>> +	int flags = EXT4_GET_BLOCKS_IO_CONVERT_EXT;
>> +
>> +	map.m_lblk = offset >> blkbits;
>> +	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
>> +
>> +	if (!handle) {
>> +		/*
>> +		 * TODO: An optimization can be added later by having an extent
>> +		 * status flag e.g. EXTENT_STATUS_SPLIT_LEAF. If we query that
>> +		 * it can tell if the extent in the cache is a split extent.
>> +		 * But for now let's assume pextents as 2 always.
>> +		 */
>> +		credits = ext4_meta_trans_blocks(inode, max_blocks, 2);
>> +	}
>> +
>> +	if (credits) {
>> +		handle = ext4_journal_start(inode, EXT4_HT_MAP_BLOCKS, credits);
>> +		if (IS_ERR(handle)) {
>> +			ret = PTR_ERR(handle);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	while (ret >= 0 && ret < max_blocks) {
>> +		map.m_lblk += ret;
>> +		map.m_len = (max_blocks -= ret);
>> +		ret = ext4_map_blocks(handle, inode, &map, flags);
>> +		if (ret != max_blocks)
>> +			ext4_msg(inode->i_sb, KERN_INFO,
>> +				     "inode #%lu: block %u: len %u: "
>> +				     "split block mapping found for atomic write, "
>> +				     "ret = %d",
>> +				     inode->i_ino, map.m_lblk,
>> +				     map.m_len, ret);
>> +		if (ret <= 0)
>> +			break;
>> +	}
>> +
>> +	ret2 = ext4_mark_inode_dirty(handle, inode);
>> +
>> +	if (credits) {
>> +		ret3 = ext4_journal_stop(handle);
>> +		if (unlikely(ret3))
>> +			ret2 = ret3;
>> +	}
>> +
>> +	if (ret <= 0 || ret2)
>> +		ext4_warning(inode->i_sb,
>> +			     "inode #%lu: block %u: len %u: "
>> +			     "returned %d or %d",
>> +			     inode->i_ino, map.m_lblk,
>> +			     map.m_len, ret, ret2);
>> +
>> +	return ret > 0 ? ret2 : ret;
>> +}
>> +
>>  /*
>>   * This function convert a range of blocks to written extents
>>   * The caller of this function will pass the start offset and the size.
>> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
>> index beb078ee4811..959328072c15 100644
>> --- a/fs/ext4/file.c
>> +++ b/fs/ext4/file.c
>> @@ -377,7 +377,12 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>>  	loff_t pos = iocb->ki_pos;
>>  	struct inode *inode = file_inode(iocb->ki_filp);
>>  
>> -	if (!error && size && flags & IOMAP_DIO_UNWRITTEN)
>> +
>> +	if (!error && size && (flags & IOMAP_DIO_UNWRITTEN) &&
>> +			(iocb->ki_flags & IOCB_ATOMIC))
>> +		error = ext4_convert_unwritten_extents_atomic(NULL, inode, pos,
>> +							      size);
>> +	else if (!error && size && flags & IOMAP_DIO_UNWRITTEN)
>>  		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
>>  	if (error)
>>  		return error;
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 8b86b1a29bdc..13bc9f07ae7f 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3412,12 +3412,149 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
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
>> +			ret = -EFSCORRUPTED;
>> +			goto out_err;
>> +		}
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
>
> When does this produce a short mapping?  In theory the cluster's already
> allocated, right?  So this is (AFAICT) a handler for a "should never
> happen" corner case, right?
>

Yes, you are right. This will ideally never happen.

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
>> +				struct ext4_map_blocks *map, int m_flags,
>> +				bool *force_commit)
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
>> +	/*
>> +	 * slow path means we have mixed mapping, that means we will need
>> +	 * to force txn commit.
>> +	 */
>> +	*force_commit = true;
>> +	return ext4_map_blocks_atomic_write_slow(handle, inode, map);
>> +out:
>> +	return ret;
>> +}
>> +
>>  static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>  			    unsigned int flags)
>>  {
>>  	handle_t *handle;
>>  	u8 blkbits = inode->i_blkbits;
>>  	int ret, dio_credits, m_flags = 0, retries = 0;
>> +	bool force_commit = false;
>>  
>>  	/*
>>  	 * Trim the mapping request to the maximum value that we can map at
>> @@ -3425,7 +3562,30 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
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
>> @@ -3456,7 +3616,11 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>  	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>>  		m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
>>  
>> -	ret = ext4_map_blocks(handle, inode, map, m_flags);
>> +	if (flags & IOMAP_ATOMIC)
>> +		ret = ext4_map_blocks_atomic_write(handle, inode, map, m_flags,
>> +						   &force_commit);
>> +	else
>> +		ret = ext4_map_blocks(handle, inode, map, m_flags);
>>  
>>  	/*
>>  	 * We cannot fill holes in indirect tree based inodes as that could
>> @@ -3470,6 +3634,14 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>>  	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
>>  		goto retry;
>>  
>> +	if (ret > 0 && force_commit) {
>> +		int ret2;
>> +
>> +		ret2 = ext4_force_commit(inode->i_sb);
>> +		if (ret2)
>> +			ret = ret2;
>
> Nit: This could return ret2 directly instead of assigning it to ret and
> letting it fall out.

Ok. Will return ret2 directly here.

>
> But my bigger complaint is that you ought to leave a comment here along
> the lines of:
>

yes, I should have added a comment.

> 		/*
> 		 * Someone forced us to commit the journal ahead of an
> 		 * IO operation so that the ondisk mapping state is
> 		 * consistent with the contents of the file data blocks.
> 		 * The commit failed, so we abort the whole IO.
> 		 */
>
> so it's obvious why we got a mapping but are erroring out anyway.

	/*
	 * Force commit the current transaction if the allocation spans a mixed
	 * mapping range. This ensures any pending metadata updates (like
	 * unwritten to written extents conversion) in this range are in
	 * consistent state with the file data blocks, before performing the
	 * actual write I/O. If the commit fails, the whole I/O must be aborted
	 * to prevent any possible torn writes.
	 */

I am thinking will add above ^^^ and something similar to a section
where we talk about how mixed mappings are handled in Documentation.

>
> If the answers to my questions are all 'yes' and the extra comment gets
> added, then
>
> Acked-by: "Darrick J. Wong" <djwong@kernel.org>
>
> --D
>

Thanks for the review! Since above answers are all yes, and I will add
the comment I just mentioned abovem so I will take your Acked by too and
soon send a v5.

Please let me know otherwise.


Thanks a lot for reviewing!

-ritesh

>> +	}
>> +
>>  	return ret;
>>  }
>>  
>> @@ -3480,6 +3652,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>  	int ret;
>>  	struct ext4_map_blocks map;
>>  	u8 blkbits = inode->i_blkbits;
>> +	unsigned int orig_mlen;
>>  
>>  	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>>  		return -EINVAL;
>> @@ -3493,6 +3666,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>>  	map.m_lblk = offset >> blkbits;
>>  	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>> +	orig_mlen = map.m_len;
>>  
>>  	if (flags & IOMAP_WRITE) {
>>  		/*
>> @@ -3503,8 +3677,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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
>> @@ -3525,6 +3707,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
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

