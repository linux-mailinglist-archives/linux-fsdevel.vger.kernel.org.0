Return-Path: <linux-fsdevel+bounces-48978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F86AB70FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515FD8C050C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322341C68A6;
	Wed, 14 May 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1n7T+N0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0941C7F;
	Wed, 14 May 2025 16:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239364; cv=none; b=UwOW3y92J18YhC0wXBLrEVo6T+BFG9kgqLKoZihbbK266ycREPxN73gdbCJlke6OL7JY+dy/Xb2h3hxGGdI5HygQTKcTEpFwd9o3n4VHXKv05IyoxSW4mfNsPilxh0oXbzMkj+H6p4GK3eaK71rzL2XxgqG/yOZY1W39om9igWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239364; c=relaxed/simple;
	bh=oqRkXdDYgoE8CplhU1w8F37+ysAKOe5az/ifaAjSHQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/NooQcQQ+DGPZiWjgR8xVQZI9VoKLZBncHGsOkbjC/pBRmAI1PtTdkUE9SgLK/DpZo9IbnjsgC5NdBpWjc7Ob8ooWiIZBMnnUo1D6cSJHyAoKNCTr/w2fieFQ0zrQRfylsHtvufpJ4bZyBU6B0EYuc98K7fcjoKLodrrmJ0Ccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1n7T+N0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8025C4CEE3;
	Wed, 14 May 2025 16:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239363;
	bh=oqRkXdDYgoE8CplhU1w8F37+ysAKOe5az/ifaAjSHQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1n7T+N07AGTPeWpcWOlGos6NrLCN0AC3iqXxCPgqTUwQ2Uz6wKuUh8b9gZG7uUZE
	 kPMDHFpUUv1A114YWu7bG7E+Bee+sRfaUFSdtNDQ4JphzLrqIcea6rHuaI2/JxEh3Y
	 6GbmiI3m2qJ5gIyoAKwdWc72vRweZhpjdICp/l0SSAgp7/VCc94wUO6exCJPz5DqzT
	 +FAf0dmyZlpGZlVlu7OBpTXWpzvUS+rzdgHkfaWLoklXYUc+nLaAX53fOx+BJp+gqx
	 jdzFb/rZxZoAM9c5rbccX5loNH14YrcUzngWn7v3cLnfP1M16QXPcQEl/alL6WUt5g
	 ehrJ1oVP0J08A==
Date: Wed, 14 May 2025 09:16:03 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] ext4: Add support for
 EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
Message-ID: <20250514161603.GG25655@frogsfrogsfrogs>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <29f33ff8f54526d332c4cc590ac254543587aaa4.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f33ff8f54526d332c4cc590ac254543587aaa4.1746734745.git.ritesh.list@gmail.com>

On Fri, May 09, 2025 at 02:20:34AM +0530, Ritesh Harjani (IBM) wrote:
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

Can you have two physically and logically contiguous mappings within a
single leaf node?  Or is the key idea here that the extent status tree
will merge adjacent mappings from the same leaf block, just not between
leaf blocks?

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
> ---
>  fs/ext4/ext4.h    | 18 ++++++++-
>  fs/ext4/extents.c | 12 ++++++
>  fs/ext4/inode.c   | 97 +++++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 115 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index e2b36a3c1b0f..b4bbe2837423 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -256,9 +256,19 @@ struct ext4_allocation_request {
>  #define EXT4_MAP_UNWRITTEN	BIT(BH_Unwritten)
>  #define EXT4_MAP_BOUNDARY	BIT(BH_Boundary)
>  #define EXT4_MAP_DELAYED	BIT(BH_Delay)
> +/*
> + * This is for use in ext4_map_query_blocks() for a special case where we can
> + * have a physically and logically contiguous blocks explit across two leaf

s/explit/split/ ?

--D

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

