Return-Path: <linux-fsdevel+bounces-17915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693D8B3B86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 17:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2521F21BD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBF2156F39;
	Fri, 26 Apr 2024 15:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5rX3RXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797514A4EB;
	Fri, 26 Apr 2024 15:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145419; cv=none; b=PYjh19MNFAt3Hpz7ldjjPffKja/qJSF81LGTVuglj0YOInxvVwLLArI6FtWDuwwcfk/9fe/1hDXV+9tZ7Jr8PzfRpl2ix+F4s0jlaQXcUfdWF8s9zckJBTfsm6ZdI7tSbNjm5hetfckRZl5hzleERCrOXVPZGkeRsV3C8FccFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145419; c=relaxed/simple;
	bh=WbG5PebwLa5slSDDeOjdZM1n/ZjV3i3QmndMDm5xsEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeNyLD6SHiWyutaweD27drYVyoGRpvFBfZf2+QtnhE4UT0OmFFOczB0ZPlYcQFpEBBFqVTXDVC505MT4SYdKDpYKN7X252yfk/IsxvbpazQnsmB0qSeWNnTctcgWE/Gy/vr2w30GRwpCltqROnfoIYbdOEvhb9DPnXlXTuKtCx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5rX3RXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9DFC2BD10;
	Fri, 26 Apr 2024 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714145418;
	bh=WbG5PebwLa5slSDDeOjdZM1n/ZjV3i3QmndMDm5xsEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5rX3RXG54yW9CkikWmrTXIccH3B2BYpVqGlFqz+KDm0j/N3Iph6MoL5rjS9oqLSK
	 db5pR911JvEVmkzXRgEvqE0Fg1cM5YML4/g9R8pU0fKDTYApasIdz+MkmtIxMc1Ndg
	 1JHVkSJ7L/XGcXR5J32kI9C1P00Lvj6D/0DmL53gEjflIjNokdZsBcNCFg5AcMeF6i
	 BifFDaOa27PL1p2Qd2xfF+3RSb//Zzx1dpgm9CAOOoUPVACXJJs3sHx70b6Yuy6eo0
	 2p7Gmk90zwT0m9ztuzQPidQyymJci6HqzLyL/BIIBSgj3Yw1HSLIUxPVyeG+bnRJzP
	 tekyHAdxJB+/A==
Date: Fri, 26 Apr 2024 08:30:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 3/7] ext2: Enable large folio support
Message-ID: <20240426153018.GK360919@frogsfrogsfrogs>
References: <cover.1714046808.git.ritesh.list@gmail.com>
 <581b2ed21a709093522f3747c06e8171c82f2d8c.1714046808.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <581b2ed21a709093522f3747c06e8171c82f2d8c.1714046808.git.ritesh.list@gmail.com>

On Thu, Apr 25, 2024 at 06:58:47PM +0530, Ritesh Harjani (IBM) wrote:
> Now that ext2 regular file buffered-io path is converted to use iomap,
> we can also enable large folio support for ext2.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

This filesystem is looking more and more modern!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/ext2/inode.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index f90d280025d9..2b62786130b5 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -1424,10 +1424,12 @@ void ext2_set_file_ops(struct inode *inode)
>  {
>  	inode->i_op = &ext2_file_inode_operations;
>  	inode->i_fop = &ext2_file_operations;
> -	if (IS_DAX(inode))
> +	if (IS_DAX(inode)) {
>  		inode->i_mapping->a_ops = &ext2_dax_aops;
> -	else
> +	} else {
>  		inode->i_mapping->a_ops = &ext2_file_aops;
> +		mapping_set_large_folios(inode->i_mapping);
> +	}
>  }
>  
>  struct inode *ext2_iget (struct super_block *sb, unsigned long ino)
> -- 
> 2.44.0
> 
> 

