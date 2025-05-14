Return-Path: <linux-fsdevel+bounces-48983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAFAAB713E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F7D4C8198
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 16:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979227C872;
	Wed, 14 May 2025 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mshydQ1M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779D41A5B90;
	Wed, 14 May 2025 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239890; cv=none; b=RYMwolvE7jwbre/fq0N2SB94Sb47ZsiKWnEPdOhC/oeYbIZF/remYpyU6hMzDtIbhzbH/hHi+M0rhd3cY3bCLpNKytXt0sI6dN2GRz0ykH/hxEi5UWIOrCIagBWePgVRck1JOh9PRLqrQCREidOOFNvHlfZiNFLdwVeVcya3i88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239890; c=relaxed/simple;
	bh=lhMvRJarwv3IwAENLrKX4I1lisbEeuyZxa3wPpwDUvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUXAIxLrF87I1egP0M2LKsiA6B0tUhmZB4mbCO7btGy42w8VlMOs0J0H26zea5eKPrWB8+7xyRK9bw/zWtfcnVNis1lFZu0TwHXH6gKfiJtPccdFdTP3RBRwyuonvOUbOq3efCiZFsXQ4dW9VQpWEfYDR77/Hn5AOW2j6tZOAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mshydQ1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC15C4CEE3;
	Wed, 14 May 2025 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747239890;
	bh=lhMvRJarwv3IwAENLrKX4I1lisbEeuyZxa3wPpwDUvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mshydQ1M5KXOx9nz9DbyroKAWzzpTxKj+6XDL7/EpjPbhWNDO1v2UEByUJA7AiHgf
	 0ZDvDFY3rUBFzs1eJbKOAdkOZtczHkn6Uirb1eaFR6WQ/ohjUC7lheK7jY35WWpITY
	 RpCwAEEl70dmdkhancTBLBGEdr7CUKPQHE5zLyCE9gSodWXTvmKd6/IsH1y/3h8RQ5
	 o+2pjDrQ1F+9OF43VoZlepKkEsAt/pbTHrFG98GLjILp4UPv4Mu2SPQfYdqW00h/78
	 OKFR3nbT9o6pReSaYzKkR1I1sdXCbxcWHJJuLAcKn8uONf6rWbAgAWBrk0pggG544S
	 mY6wCFnQFsflA==
Date: Wed, 14 May 2025 09:24:49 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] ext4: Make ext4_meta_trans_blocks() non-static
 for later use
Message-ID: <20250514162449.GL25655@frogsfrogsfrogs>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <53dd687535024df91147d1c30124330d1a5c985c.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53dd687535024df91147d1c30124330d1a5c985c.1746734745.git.ritesh.list@gmail.com>

On Fri, May 09, 2025 at 02:20:33AM +0530, Ritesh Harjani (IBM) wrote:
> Let's make ext4_meta_trans_blocks() non-static for use in later
> functions during ->end_io conversion for atomic writes.
> We will need this function to estimate journal credits for a special
> case. Instead of adding another wrapper around it, let's make this
> non-static.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/ext4.h  | 2 ++
>  fs/ext4/inode.c | 6 +-----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index c0240f6f6491..e2b36a3c1b0f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3039,6 +3039,8 @@ extern void ext4_set_aops(struct inode *inode);
>  extern int ext4_writepage_trans_blocks(struct inode *);
>  extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
>  extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
> +extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
> +				  int pextents);
>  extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
>  			     loff_t lstart, loff_t lend);
>  extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b10e5cd5bb5c..2f99b087a5d8 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -142,9 +142,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
>  						   new_size);
>  }
>  
> -static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
> -				  int pextents);
> -
>  /*
>   * Test whether an inode is a fast symlink.
>   * A fast symlink has its symlink data stored in ext4_inode_info->i_data.
> @@ -5777,8 +5774,7 @@ static int ext4_index_trans_blocks(struct inode *inode, int lblocks,
>   *
>   * Also account for superblock, inode, quota and xattr blocks
>   */
> -static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
> -				  int pextents)
> +int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
>  {
>  	ext4_group_t groups, ngroups = ext4_get_groups_count(inode->i_sb);
>  	int gdpblocks;
> -- 
> 2.49.0
> 
> 

