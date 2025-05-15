Return-Path: <linux-fsdevel+bounces-49163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24CAAB8CE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 18:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A876DA0806C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBEC253F08;
	Thu, 15 May 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7Q2zfUY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BC1D79A6;
	Thu, 15 May 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747328091; cv=none; b=avVOnV94vnpeGsNAZhgnWJ56qoEcbRQ2vk60NtsEdRmJIZPimwtd8sBh+ZMTFYKcI2ASXNpZRCcXbcTEX+8grC39GJF60KRpj9UB1GwIkyhqH5V1qtt7ytWG0bu0jQrPL0xccS4A5DAn9vGiMl9zHLBGMrQ+2P+vKt4C1RN3SGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747328091; c=relaxed/simple;
	bh=32rA5pOdTkeW88mdRACmaRk+gHGwZqGl5lZoaXNu8Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9wRvLO6423MFgkmEFMDs8eBbkvFd0FGry94BaECuYrWYs/hB8kAPyv4+WUo4BRueQtEWE6Nn8tZbxADF2k0puz+BLgMENWtKZ9IjK05JFojV30HWKiAbqZpvpZ9k7yoR3Wx26LZMfhdcww2VPzd+DhAiM0AIFRZQSmDo0dYbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7Q2zfUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A8CC4CEE7;
	Thu, 15 May 2025 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747328091;
	bh=32rA5pOdTkeW88mdRACmaRk+gHGwZqGl5lZoaXNu8Eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7Q2zfUYRhPTIqYYon/H0tVDk7N4g+KbzJMtGpAS6ZQIVf48ZdCbe9h/Ztfkk3fSc
	 Zw72BY3wueEPvlD8cfySolJy7CvFSoYJ4Hl0K/y1pTwouzlsQ7Y8CaMyNvn+DNHXwd
	 pCN2OkwXiCSM+pA3WmvQloHWjfYfgZbGPY9sGEfGtL2S8UF8obRjcwj4++iJxZr+3Z
	 7bro+BErOPlQ5Oa14kLP04PGECFuQjZkJPEfvuuXtq8aWps1l1xI5mvH6Hv2pT/fFK
	 4/sPGscUBOzDCO8wLsw209vHFxPabCMqU8TsKCQSeqZba5pslX+kNvgssozmxyFs0n
	 p9yGv7GAwDEww==
Date: Thu, 15 May 2025 09:54:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] ext4: Add support for
 EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
Message-ID: <20250515165450.GP25655@frogsfrogsfrogs>
References: <cover.1747289779.git.ritesh.list@gmail.com>
 <1984dcac4cffe8ab580a5d08a555dcc1a9dbf638.1747289779.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1984dcac4cffe8ab580a5d08a555dcc1a9dbf638.1747289779.git.ritesh.list@gmail.com>

On Thu, May 15, 2025 at 08:15:36PM +0530, Ritesh Harjani (IBM) wrote:
> There can be a case where there are contiguous extents on the adjacent
> leaf nodes of on-disk extent trees. So when someone tries to write to
> this contiguous range, ext4_map_blocks() call will split by returning
> 1 extent at a time if this is not already cached in extent_status tree
> cache (where if these extents when cached can get merged since they are
> contiguous).
> 
> This is fine for a normal write however in case of atomic writes, it
> can't afford to break the write into two. Now this is also something
> that will only happen in the slow write case where we call
> ext4_map_blocks() for each of these extents spread across different leaf
> nodes. However, there is no guarantee that these extent status cache
> cannot be reclaimed before the last call to ext4_map_blocks() in
> ext4_map_blocks_atomic_write_slow().
> 
> Hence this patch adds support of EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS.
> This flag checks if the requested range can be fully found in extent
> status cache and return. If not, it looks up in on-disk extent
> tree via ext4_map_query_blocks(). If the found extent is the last entry
> in the leaf node, then it goes and queries the next lblk to see if there
> is an adjacent contiguous extent in the adjacent leaf node of the
> on-disk extent tree.
> 
> Even though there can be a case where there are multiple adjacent extent
> entries spread across multiple leaf nodes. But we only read an adjacent
> leaf block i.e. in total of 2 extent entries spread across 2 leaf nodes.
> The reason for this is that we are mostly only going to support atomic
> writes with upto 64KB or maybe max upto 1MB of atomic write support.
> 
> Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good to me,
Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/ext4.h    | 18 ++++++++-
>  fs/ext4/extents.c | 12 ++++++
>  fs/ext4/inode.c   | 97 +++++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 115 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index e2b36a3c1b0f..ef6cac6b4b4c 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -256,9 +256,19 @@ struct ext4_allocation_request {
>  #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
>  #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
>  #define EXT4_MAP_DELAYED	BIT(BH_Delay)
> +/*
> + * This is for use in ext4_map_query_blocks() for a special case where we can
> + * have a physically and logically contiguous blocks split across two leaf
> + * nodes instead of a single extent. This is required in case of atomic writes
> + * to know whether the returned extent is last in leaf. If yes, then lookup for
> + * next in leaf block in ext4_map_query_blocks_next_in_leaf().
> + * - This is never going to be added to any buffer head state.
> + * - We use the next available bit after BH_BITMAP_UPTODATE.
> + */
> +#define EXT4_MAP_QUERY_LAST_IN_LEAF	BIT(BH_BITMAP_UPTODATE + 1)
>  #define EXT4_MAP_FLAGS		(EXT4_MAP_NEW | EXT4_MAP_MAPPED |\
>  				 EXT4_MAP_UNWRITTEN | EXT4_MAP_BOUNDARY |\
> -				 EXT4_MAP_DELAYED)
> +				 EXT4_MAP_DELAYED | EXT4_MAP_QUERY_LAST_IN_LEAF)
> 
>  struct ext4_map_blocks {
>  	ext4_fsblk_t m_pblk;
> @@ -725,6 +735,12 @@ enum {
>  #define EXT4_GET_BLOCKS_IO_SUBMIT		0x0400
>  	/* Caller is in the atomic contex, find extent if it has been cached */
>  #define EXT4_GET_BLOCKS_CACHED_NOWAIT		0x0800
> +/*
> + * Atomic write caller needs this to query in the slow path of mixed mapping
> + * case, when a contiguous extent can be split across two adjacent leaf nodes.
> + * Look EXT4_MAP_QUERY_LAST_IN_LEAF.
> + */
> +#define EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF	0x1000
> 
>  /*
>   * The bit position of these flags must not overlap with any of the
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c616a16a9f36..fa850f188d46 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4433,6 +4433,18 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	allocated = map->m_len;
>  	ext4_ext_show_leaf(inode, path);
>  out:
> +	/*
> +	 * We never use EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF with CREATE flag.
> +	 * So we know that the depth used here is correct, since there was no
> +	 * block allocation done if EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF is set.
> +	 * If tomorrow we start using this QUERY flag with CREATE, then we will
> +	 * need to re-calculate the depth as it might have changed due to block
> +	 * allocation.
> +	 */
> +	if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
> +		if (!err && ex && (ex == EXT_LAST_EXTENT(path[depth].p_hdr)))
> +			map->m_flags |= EXT4_MAP_QUERY_LAST_IN_LEAF;
> +
>  	ext4_free_ext_path(path);
> 
>  	trace_ext4_ext_map_blocks_exit(inode, flags, map,
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2f99b087a5d8..8b86b1a29bdc 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -459,14 +459,71 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
>  }
>  #endif /* ES_AGGRESSIVE_TEST */
> 
> +static int ext4_map_query_blocks_next_in_leaf(handle_t *handle,
> +			struct inode *inode, struct ext4_map_blocks *map,
> +			unsigned int orig_mlen)
> +{
> +	struct ext4_map_blocks map2;
> +	unsigned int status, status2;
> +	int retval;
> +
> +	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> +		EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> +
> +	WARN_ON_ONCE(!(map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF));
> +	WARN_ON_ONCE(orig_mlen <= map->m_len);
> +
> +	/* Prepare map2 for lookup in next leaf block */
> +	map2.m_lblk = map->m_lblk + map->m_len;
> +	map2.m_len = orig_mlen - map->m_len;
> +	map2.m_flags = 0;
> +	retval = ext4_ext_map_blocks(handle, inode, &map2, 0);
> +
> +	if (retval <= 0) {
> +		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> +				      map->m_pblk, status, false);
> +		return map->m_len;
> +	}
> +
> +	if (unlikely(retval != map2.m_len)) {
> +		ext4_warning(inode->i_sb,
> +			     "ES len assertion failed for inode "
> +			     "%lu: retval %d != map->m_len %d",
> +			     inode->i_ino, retval, map2.m_len);
> +		WARN_ON(1);
> +	}
> +
> +	status2 = map2.m_flags & EXT4_MAP_UNWRITTEN ?
> +		EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> +
> +	/*
> +	 * If map2 is contiguous with map, then let's insert it as a single
> +	 * extent in es cache and return the combined length of both the maps.
> +	 */
> +	if (map->m_pblk + map->m_len == map2.m_pblk &&
> +			status == status2) {
> +		ext4_es_insert_extent(inode, map->m_lblk,
> +				      map->m_len + map2.m_len, map->m_pblk,
> +				      status, false);
> +		map->m_len += map2.m_len;
> +	} else {
> +		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> +				      map->m_pblk, status, false);
> +	}
> +
> +	return map->m_len;
> +}
> +
>  static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
> -				 struct ext4_map_blocks *map)
> +				 struct ext4_map_blocks *map, int flags)
>  {
>  	unsigned int status;
>  	int retval;
> +	unsigned int orig_mlen = map->m_len;
> +	unsigned int query_flags = flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF;
> 
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> -		retval = ext4_ext_map_blocks(handle, inode, map, 0);
> +		retval = ext4_ext_map_blocks(handle, inode, map, query_flags);
>  	else
>  		retval = ext4_ind_map_blocks(handle, inode, map, 0);
> 
> @@ -481,11 +538,23 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  		WARN_ON(1);
>  	}
> 
> -	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> -			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> -	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> -			      map->m_pblk, status, false);
> -	return retval;
> +	/*
> +	 * No need to query next in leaf:
> +	 * - if returned extent is not last in leaf or
> +	 * - if the last in leaf is the full requested range
> +	 */
> +	if (!(map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) ||
> +			((map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) &&
> +			 (map->m_len == orig_mlen))) {
> +		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
> +				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
> +		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> +				      map->m_pblk, status, false);
> +		return retval;
> +	}
> +
> +	return ext4_map_query_blocks_next_in_leaf(handle, inode, map,
> +						  orig_mlen);
>  }
> 
>  static int ext4_map_create_blocks(handle_t *handle, struct inode *inode,
> @@ -599,6 +668,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  	struct extent_status es;
>  	int retval;
>  	int ret = 0;
> +	unsigned int orig_mlen = map->m_len;
>  #ifdef ES_AGGRESSIVE_TEST
>  	struct ext4_map_blocks orig_map;
> 
> @@ -650,7 +720,12 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  		ext4_map_blocks_es_recheck(handle, inode, map,
>  					   &orig_map, flags);
>  #endif
> -		goto found;
> +		if (!(flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF) ||
> +				orig_mlen == map->m_len)
> +			goto found;
> +
> +		if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
> +			map->m_len = orig_mlen;
>  	}
>  	/*
>  	 * In the query cache no-wait mode, nothing we can do more if we
> @@ -664,7 +739,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  	 * file system block.
>  	 */
>  	down_read(&EXT4_I(inode)->i_data_sem);
> -	retval = ext4_map_query_blocks(handle, inode, map);
> +	retval = ext4_map_query_blocks(handle, inode, map, flags);
>  	up_read((&EXT4_I(inode)->i_data_sem));
> 
>  found:
> @@ -1802,7 +1877,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>  	if (ext4_has_inline_data(inode))
>  		retval = 0;
>  	else
> -		retval = ext4_map_query_blocks(NULL, inode, map);
> +		retval = ext4_map_query_blocks(NULL, inode, map, 0);
>  	up_read(&EXT4_I(inode)->i_data_sem);
>  	if (retval)
>  		return retval < 0 ? retval : 0;
> @@ -1825,7 +1900,7 @@ static int ext4_da_map_blocks(struct inode *inode, struct ext4_map_blocks *map)
>  			goto found;
>  		}
>  	} else if (!ext4_has_inline_data(inode)) {
> -		retval = ext4_map_query_blocks(NULL, inode, map);
> +		retval = ext4_map_query_blocks(NULL, inode, map, 0);
>  		if (retval) {
>  			up_write(&EXT4_I(inode)->i_data_sem);
>  			return retval < 0 ? retval : 0;
> --
> 2.49.0
> 
> 

