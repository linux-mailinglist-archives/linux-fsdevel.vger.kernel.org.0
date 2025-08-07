Return-Path: <linux-fsdevel+bounces-57016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CF6B1DDB8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 21:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6170117BF4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A12356C0;
	Thu,  7 Aug 2025 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyIUtxP8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FFA223705;
	Thu,  7 Aug 2025 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754596622; cv=none; b=TqPZJ0w9r/CPQtIbbl+tjpH4GjOKFCdYXUPcdd/FBMyMOmYAgqfHV/la8E6GlAPgZTmWpkrmJbVMaHyQ4vddxmeNOw9CXTHpPqkUXLXTuC5poqVCyPj+gFCX5CAQD0fMt5WKnG7Q/mm5nHarm+GIbc86jIQxga3mHWYKyzbsBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754596622; c=relaxed/simple;
	bh=nDMGNwMtc0VDvGNgvp1lhcxe2RK30/Cr/bqKvCLRm4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa4vu7Ug7eE809lijottV3SacTsPgkQR6s+PcDTxpDzu8lPtuzcAP7OSmpHDIJ7N1+65ZGXqKgE2jC/axFZ5oWPLZ8USrzhwGzTkVDfKt3T1yQKcxg0YnuncpC05UBLQtegiiHZEzMUQhRBOPRTmTb6jphwO3gq1R69Tv6KqXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyIUtxP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57827C4CEEB;
	Thu,  7 Aug 2025 19:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754596621;
	bh=nDMGNwMtc0VDvGNgvp1lhcxe2RK30/Cr/bqKvCLRm4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NyIUtxP8PF4fKg+4Apcqo/Yi27bIkP6caR+mUukIKY0/MxtNOh/N5K6MX45YVsGqI
	 U3zgqIq5FrXhBq2HsGd1XkDY6a8bNSCSTpbiNHkgQ0twdqWb/PUpaw0JLJjUiUM4zm
	 aPNSkI1/pndVkiOq3IKOuT7ynLiNAB1jgJrpIWXMv13Y0Jo5JhC6gKp4xEH+a2gQh+
	 GtF6E2I92pin3tRO+bImY+Rim9m+Ba8B+V70FUGk65kSHawmpOzy9DoWInjVMYucsa
	 B/rq+ECAGqhQfWXp2x3mXT6grN9sUpa2U43CR/qZUm2EOSDMsYIKOgnnuX7CiouGMY
	 bS3CGWCDZ6AEQ==
Date: Thu, 7 Aug 2025 12:57:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ext4: Fix fsmap end of range reporting with bigalloc
Message-ID: <20250807195700.GS2672022@frogsfrogsfrogs>
References: <e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com>

On Tue, Aug 05, 2025 at 02:00:30PM +0530, Ojaswin Mujoo wrote:
> With bigalloc enabled, the logic to report last extent has a bug since
> we try to use cluster units instead of block units. This can cause an issue
> where extra incorrect entries might be returned back to the user. This was
> flagged by generic/365 with 64k bs and -O bigalloc.
> 
> ** Details of issue **
> 
> The issue was noticed on 5G 64k blocksize FS with -O bigalloc which has
> only 1 bg.
> 
> $ xfs_io -c "fsmap -d" /mnt/scratch
> 
>   0: 253:48 [0..127]: static fs metadata 128   /* sb */
>   1: 253:48 [128..255]: special 102:1 128   /* gdt */
>   3: 253:48 [256..383]: special 102:3 128   /* block bitmap */
>   4: 253:48 [384..2303]: unknown 1920       /* flex bg empty space */
>   5: 253:48 [2304..2431]: special 102:4 128   /* inode bitmap */
>   6: 253:48 [2432..4351]: unknown 1920      /* flex bg empty space */
>   7: 253:48 [4352..6911]: inodes 2560
>   8: 253:48 [6912..538623]: unknown 531712
>   9: 253:48 [538624..10485759]: free space 9947136
> 
> The issue can be seen with:
> 
> $ xfs_io -c "fsmap -d 0 3" /mnt/scratch
> 
>   0: 253:48 [0..127]: static fs metadata 128
>   1: 253:48 [384..2047]: unknown 1664
> 
> Only the first entry was expected to be returned but we get 2. This is
> because:
> 
> ext4_getfsmap_datadev()
>   first_cluster, last_cluster = 0
>   ...
>   info->gfi_last = true;
>   ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1, 0, info);
>     fsb = C2B(1) = 16
>     fslen = 0
>     ...
>     /* Merge in any relevant extents from the meta_list */
>     list_for_each_entry_safe(p, tmp, &info->gfi_meta_list, fmr_list) {
>       ...
>       // since fsb = 16, considers all metadata which starts before 16 blockno
>       iter 1: error = ext4_getfsmap_helper(sb, info, p);  // p = sb (0,1), nop
>         info->gfi_next_fsblk = 1
>       iter 2: error = ext4_getfsmap_helper(sb, info, p);  // p = gdt (1,2), nop
>         info->gfi_next_fsblk = 2
>       iter 3: error = ext4_getfsmap_helper(sb, info, p);  // p = blk bitmap (2,3), nop
>         info->gfi_next_fsblk = 3
>       iter 4: error = ext4_getfsmap_helper(sb, info, p);  // p = ino bitmap (18,19)
>         if (rec_blk > info->gfi_next_fsblk) { // (18 > 3)
>           // emits an extra entry ** BUG **
>         }
>     }
> 
> Fix this by directly calling ext4_getfsmap_datadev() with a dummy record
> that has fmr_physical set to (end_fsb + 1) instead of last_cluster + 1. By
> using the block instead of cluster we get the correct behavior.
> 
> Replacing ext4_getfsmap_datadev_helper() with ext4_getfsmap_helper() is
> okay since the gfi_lastfree and metadata checks in
> ext4_getfsmap_datadev_helper() are anyways redundant when we only want to
> emit the last allocated block of the range, as we have already taken care
> of emitting metadata and any last free blocks.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Fixes: 4a622e4d477b ("ext4: fix FS_IOC_GETFSMAP handling")
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks fine to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/fsmap.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index 383c6edea6dd..9d63c39f6077 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -526,6 +526,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
>  	ext4_group_t end_ag;
>  	ext4_grpblk_t first_cluster;
>  	ext4_grpblk_t last_cluster;
> +	struct ext4_fsmap irec;
>  	int error = 0;
>  
>  	bofs = le32_to_cpu(sbi->s_es->s_first_data_block);
> @@ -609,10 +610,18 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
>  			goto err;
>  	}
>  
> -	/* Report any gaps at the end of the bg */
> +	/*
> +	 * The dummy record below will cause ext4_getfsmap_helper() to report
> +	 * any allocated blocks at the end of the range.
> +	 */
> +	irec.fmr_device = 0;
> +	irec.fmr_physical = end_fsb + 1;
> +	irec.fmr_length = 0;
> +	irec.fmr_owner = EXT4_FMR_OWN_FREE;
> +	irec.fmr_flags = 0;
> +
>  	info->gfi_last = true;
> -	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
> -					     0, info);
> +	error = ext4_getfsmap_helper(sb, info, &irec);
>  	if (error)
>  		goto err;
>  
> -- 
> 2.49.0
> 
> 

