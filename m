Return-Path: <linux-fsdevel+bounces-44952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51936A6F57F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 12:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB133B272F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Mar 2025 11:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E22561CF;
	Tue, 25 Mar 2025 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g7NyOrec"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D52561B7;
	Tue, 25 Mar 2025 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902990; cv=none; b=RxKTf+xu6tmE8v6uSgsgdM7FvrxjO8kPw9+SIHerNE/897rTZZq8TaJeiJgcU7Z3Ym6vVYOIgakW+RslnH06FPqiX2feseLlxYrycK1URMAT2iCQ+C8fK3QOijYuMwyrte/anNEqUQWsVjsEgwhKrgdB/gjCzx0YHN+8nyIaYAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902990; c=relaxed/simple;
	bh=pIFsg9mtUVpAGYomfA9FC5AA4DlyQinycG1fq7OLaDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaCTUMv8HmDE19OplCGcn36iRnYU6sJX/d73zgwH047z7DvIDwSMYWywdK7Q452y+Oxf2XG/72TKQ/qENqVvM1wV5cMdUiQ0WIrJugmOlsbAzyO48Nc7ZoRtQkxdV9hjwE81Uf+4OX73tOUSEwhc1mRIe/BwsCkJ2V6reCqZ1Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g7NyOrec; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PAWqWQ029752;
	Tue, 25 Mar 2025 11:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=8X1ifLhVT6ZbfRgEXAq3UI9m7wogRS
	61MbM2vh4q11g=; b=g7NyOrec5jCUEijX4KU6hwljwCfcNWV2pLN4n4xl/DLya6
	xbvEtoGWw9a9tqcWE9Ijm2sGRvsB0etBsb/WDpC+2AW4deBDKhH51mn9qCAhRvg3
	f617PrhWnVclN4KyRHiWC/dQE0tFjHFU3oxX/UH+hA15WxQD57wclsZi/PXk+kzp
	7C7Fesg9cEbRV3Prxcn2Bwl+RZU4cQKQNLhzT91bHXojWnOfMaO16j+ZH/60Os+2
	oXSqhNJ+WXFoOtVzIv0/5nY26jN4MISeyUaiPsCdxn7f0br1zv1PFVskdDbP8HQc
	B22ATVn3O1h6LGMEer9sHNjvIW6YIDCuab6VfNOw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k7e3e0yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 11:42:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PBdEs4015903;
	Tue, 25 Mar 2025 11:42:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k7e3e0yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 11:42:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P80UPg025443;
	Tue, 25 Mar 2025 11:42:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x03av9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 11:42:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PBgqp960490034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 11:42:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E78872004B;
	Tue, 25 Mar 2025 11:42:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E151920040;
	Tue, 25 Mar 2025 11:42:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.213.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 11:42:48 +0000 (GMT)
Date: Tue, 25 Mar 2025 17:12:41 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, djwong@kernel.org,
        linux-xfs@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [RFCv1 1/1] ext4: Add multi-fsblock atomic write support with
 bigalloc
Message-ID: <Z-KWsWHOGJnq8pUp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1742699765.git.ritesh.list@gmail.com>
 <20250323070218.TXPv0lyp0kW0RBhSJpoCl37NxYw24VwGfwoNb3Lyohg@z>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323070218.TXPv0lyp0kW0RBhSJpoCl37NxYw24VwGfwoNb3Lyohg@z>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i6CPJleKQp9wummvQldFLO8JKVXroW2O
X-Proofpoint-GUID: dDk6nyxD2ao79Zmj6fgOYsCT09PwiKQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_04,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250080

On Sun, Mar 23, 2025 at 12:32:18PM +0530, Ritesh Harjani (IBM) wrote:
> EXT4 supports bigalloc feature which allows the FS to work in size of
> clusters (group of blocks) rather than individual blocks. This patch
> adds atomic write support for bigalloc so that systems with bs = ps can
> also create FS using -
>     mkfs.ext4 -F -O bigalloc -b 4096 -C 16384 <dev>
> 
> With bigalloc ext4 can support multi-fsblock atomic writes. We will have to
> adjust ext4's atomic write unit max value to cluster size. This can then support
> atomic write of size anywhere between [blocksize, clustersize].
> 
> We first query the underlying region of the requested range by calling
> ext4_map_blocks() call. Here are the various cases which we then handle
> for block allocation depending upon the underlying mapping type:
> 1. If the underlying region for the entire requested range is a mapped extent,
>    then we don't call ext4_map_blocks() to allocate anything. We don't need to
>    even start the jbd2 txn in this case.
> 2. For an append write case, we create a mapped extent.
> 3. If the underlying region is entirely a hole, then we create an unwritten
>    extent for the requested range.
> 4. If the underlying region is a large unwritten extent, then we split the
>    extent into 2 unwritten extent of required size.
> 5. If the underlying region has any type of mixed mapping, then we call
>    ext4_map_blocks() in a loop to zero out the unwritten and the hole regions
>    within the requested range. This then provide a single mapped extent type
>    mapping for the requested range.
> 
> Note: We invoke ext4_map_blocks() in a loop with the EXT4_GET_BLOCKS_ZERO
> flag only when the underlying extent mapping of the requested range is
> not entirely a hole, an unwritten extent, or a fully mapped extent. That
> is, if the underlying region contains a mix of hole(s), unwritten
> extent(s), and mapped extent(s), we use this loop to ensure that all the
> short mappings are zeroed out. This guarantees that the entire requested
> range becomes a single, uniformly mapped extent. It is ok to do so
> because we know this is being done on a bigalloc enabled filesystem
> where the block bitmap represents the entire cluster unit.

Hi Ritesh, thanks for the patch. The approach looks good to me, just
adding a few comments below.
> 
> Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/inode.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++--
>  fs/ext4/super.c |  8 +++--
>  2 files changed, 93 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d04d8a7f12e7..0096a597ad04 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3332,6 +3332,67 @@ static void ext4_set_iomap(struct inode *inode, struct iomap *iomap,
>     iomap->addr = IOMAP_NULL_ADDR;
>   }
>  }
> +/*
> + * ext4_map_blocks_atomic: Helper routine to ensure the entire requested mapping
> + * [map.m_lblk, map.m_len] is one single contiguous extent with no mixed
> + * mappings. This function is only called when the bigalloc is enabled, so we
> + * know that the allocated physical extent start is always aligned properly.
> + *
> + * We call EXT4_GET_BLOCKS_ZERO only when the underlying physical extent for the
> + * requested range does not have a single mapping type (Hole, Mapped, or
> + * Unwritten) throughout. In that case we will loop over the requested range to
> + * allocate and zero out the unwritten / holes in between, to get a single
> + * mapped extent from [m_lblk, m_len]. This case is mostly non-performance
> + * critical path, so it should be ok to loop using ext4_map_blocks() with
> + * appropriate flags to allocate & zero the underlying short holes/unwritten
> + * extents within the requested range.
> + */
> +static int ext4_map_blocks_atomic(handle_t *handle, struct inode *inode,
> +         struct ext4_map_blocks *map)
> +{
> + ext4_lblk_t m_lblk = map->m_lblk;
> + unsigned int m_len = map->m_len;
> + unsigned int mapped_len = 0, flags = 0;
> + u8 blkbits = inode->i_blkbits;
> + int ret;
> +
> + WARN_ON(!ext4_has_feature_bigalloc(inode->i_sb));
> +
> + ret = ext4_map_blocks(handle, inode, map, 0);
> + if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
> +   flags = EXT4_GET_BLOCKS_CREATE;
> + else if ((ret == 0 && map->m_len >= m_len) ||
> +   (ret >= m_len && map->m_flags & EXT4_MAP_UNWRITTEN))
> +   flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> + else
> +   flags = EXT4_GET_BLOCKS_CREATE_ZERO;
> +
> + do {
> +   ret = ext4_map_blocks(handle, inode, map, flags);

With the multiple calls to map block for converting the extents, I don't
think the transaction reservation wouldn't be enough anymore since in
the worst case we could be converting atleast (max atomicwrite size / blocksize) 
extents. We need to account for that as well.

> +   if (ret < 0)
> +     return ret;
> +   mapped_len += map->m_len;
> +   map->m_lblk += map->m_len;
> +   map->m_len = m_len - mapped_len;
> + } while (mapped_len < m_len);

> +
> + map->m_lblk = m_lblk;
> + map->m_len = m_len;
> +
> + /*
> +  * We might have done some work in above loop. Let's ensure we query the
> +  * start of the physical extent, based on the origin m_lblk and m_len
> +  * and also ensure we were able to allocate the required range for doing
> +  * atomic write.
> +  */
> + ret = ext4_map_blocks(handle, inode, map, 0);

 Here, We are calling ext4_map_blocks() 3 times uneccessarily even if a
 single complete mapping is found. I think a better approach would be to
 just go for the map_blocks and then decide if we want to split. Also,
 factor out a function to do the zero out. So, somthing like:

  if (((loff_t)map->m_lblk << blkbits) >= i_size_read(inode))
    flags = EXT4_GET_BLOCKS_CREATE;
  else
    flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;

        ret = ext4_map_blocks(handle, inode, map, flags);

        if (map->m_len < m_len) {
          map->m_len = m_len;

                /* do the zero out */
          ext4_zero_mixed_mappings(handle, inode, map);
                ext4_map_blocks(handle, inode, map, 0);

                WARN_ON(!(map->m_flags & EXT4_MAP_MAPPED) || map->m_len < m_len);
        }

 I think this covers the 5 cases you mentioned in the commit message, if
 I'm not missing anything.  Also, this way we avoid the duplication for
 non zero-out cases and the zero-out function can then be resused incase
 we want to do the same for forcealign atomic writes in the future.

Regards,
ojaswin

> + if (ret != m_len) {
> +   ext4_warning_inode(inode, "allocation failed for atomic write request pos:%u, len:%u\n",
> +       m_lblk, m_len);
> +   return -EINVAL;
> + }
> + return mapped_len;
> +}
> 
>  static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>           unsigned int flags)
> @@ -3377,7 +3438,10 @@ static int ext4_iomap_alloc(struct inode *inode, struct ext4_map_blocks *map,
>   else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>     m_flags = EXT4_GET_BLOCKS_IO_CREATE_EXT;
> 
> - ret = ext4_map_blocks(handle, inode, map, m_flags);
> + if (flags & IOMAP_ATOMIC && ext4_has_feature_bigalloc(inode->i_sb))
> +   ret = ext4_map_blocks_atomic(handle, inode, map);
> + else
> +   ret = ext4_map_blocks(handle, inode, map, m_flags);
> 
>   /*
>    * We cannot fill holes in indirect tree based inodes as that could
> @@ -3401,6 +3465,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   int ret;
>   struct ext4_map_blocks map;
>   u8 blkbits = inode->i_blkbits;
> + unsigned int m_len_orig;
> 
>   if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
>     return -EINVAL;
> @@ -3414,6 +3479,7 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   map.m_lblk = offset >> blkbits;
>   map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>         EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> + m_len_orig = map.m_len;
> 
>   if (flags & IOMAP_WRITE) {
>     /*
> @@ -3424,8 +3490,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>      */
>     if (offset + length <= i_size_read(inode)) {
>       ret = ext4_map_blocks(NULL, inode, &map, 0);
> -     if (ret > 0 && (map.m_flags & EXT4_MAP_MAPPED))
> -       goto out;
> +     /*
> +      * For atomic writes the entire requested length should
> +      * be mapped.
> +      */
> +     if (map.m_flags & EXT4_MAP_MAPPED) {
> +       if ((!(flags & IOMAP_ATOMIC) && ret > 0) ||
> +          (flags & IOMAP_ATOMIC && ret >= m_len_orig))
> +         goto out;
> +     }
> +     map.m_len = m_len_orig;
>     }
>     ret = ext4_iomap_alloc(inode, &map, flags);
>   } else {
> @@ -3442,6 +3516,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>    */
>   map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk, map.m_len);
> 
> + /*
> +  * Before returning to iomap, let's ensure the allocated mapping
> +  * covers the entire requested length for atomic writes.
> +  */
> + if (flags & IOMAP_ATOMIC) {
> +   if (map.m_len < (length >> blkbits)) {
> +     WARN_ON(1);
> +     return -EINVAL;
> +   }
> + }
>   ext4_set_iomap(inode, iomap, &map, offset, length, flags);
> 
>   return 0;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a50e5c31b937..cbb24d535d59 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4442,12 +4442,13 @@ static int ext4_handle_clustersize(struct super_block *sb)
>  /*
>   * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
>   * @sb: super block
> - * TODO: Later add support for bigalloc
>   */
>  static void ext4_atomic_write_init(struct super_block *sb)
>  {
>   struct ext4_sb_info *sbi = EXT4_SB(sb);
>   struct block_device *bdev = sb->s_bdev;
> + unsigned int blkbits = sb->s_blocksize_bits;
> + unsigned int clustersize = sb->s_blocksize;
> 
>   if (!bdev_can_atomic_write(bdev))
>     return;
> @@ -4455,9 +4456,12 @@ static void ext4_atomic_write_init(struct super_block *sb)
>   if (!ext4_has_feature_extents(sb))
>     return;
> 
> + if (ext4_has_feature_bigalloc(sb))
> +   clustersize = 1U << (sbi->s_cluster_bits + blkbits);
> +
>   sbi->s_awu_min = max(sb->s_blocksize,
>             bdev_atomic_write_unit_min_bytes(bdev));
> - sbi->s_awu_max = min(sb->s_blocksize,
> + sbi->s_awu_max = min(clustersize,
>             bdev_atomic_write_unit_max_bytes(bdev));
>   if (sbi->s_awu_min && sbi->s_awu_max &&
>       sbi->s_awu_min <= sbi->s_awu_max) {
> --
> 2.48.1
> 

