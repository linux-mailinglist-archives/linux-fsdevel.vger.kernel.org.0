Return-Path: <linux-fsdevel+bounces-22148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D0912DB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242461F24401
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DC517B4EB;
	Fri, 21 Jun 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej2w72va"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978DCB67D;
	Fri, 21 Jun 2024 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997203; cv=none; b=gM7nJIuR8aIYM9EFziwUYM1jzuqUiHF4Hq2HjiW07HvhKlBj3b8sAMG34NV59Hs0Lk3VYp+yhJ/rhVf5uKfRGzGYUGLld/X67gSWjVgFUAVU5sCCgrnVS4K7+UMSVfdE/bGuzyx6M2Pa7KetMdlcj3aUvuLErep3fqyE5Mr9JMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997203; c=relaxed/simple;
	bh=q1BUt/ISTdwBB2viZntrJkGEzi0Ktv7rF7mo0whPPPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwTRoMpqhD8yus/1wQeLmKfxv5g7rqOxYb0/C7BFN63u1PbFDfsfCrCVMMLAqy5+PEMV1qdThJk400cAljzpvuk0XqRjBI6RxBdvUlcdnPTB/q5+Zc8xX8DpDzB02o4pFzM9n5dMv/wBj+4UATMNGa6XvbrzDISM3IlM3j8psvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej2w72va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADA5C2BBFC;
	Fri, 21 Jun 2024 19:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718997203;
	bh=q1BUt/ISTdwBB2viZntrJkGEzi0Ktv7rF7mo0whPPPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ej2w72vatFq7AIbszA7BXkHnTnxWYzjwkkthc5OM2lYlcoJ1slbiBoK4PTF1MuWj+
	 PO0PgfVUG/UXFbtnaepFa9VkdExAX6OPzFt6OEBR/B2fi4a1DnJT4TlGzPkCqOKqQB
	 oiS1W5I5RGX3+5NJZ2i2Y3NYPQ3cIIa0btibvN5KNgjn4kDKKIVjN8XA27g6r+nT1C
	 8Gg0MdWuCBXxjDxUW4Hbn2zzQ95DCiOXLKc5Nwk/w+w/MzPLb1/H9DuWE4DBz+o8Sr
	 pYAML4/yhydkOYVN0pJguYwE/JA4SnyFQqa4194dhlVnXuhx/Q2TwddaPvxpY+5A7s
	 1oYr++qOIna/A==
Date: Fri, 21 Jun 2024 12:13:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 11/13] xfs: Only free full extents for forcealign
Message-ID: <20240621191322.GP3058325@frogsfrogsfrogs>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-12-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621100540.2976618-12-john.g.garry@oracle.com>

On Fri, Jun 21, 2024 at 10:05:38AM +0000, John Garry wrote:
> Like we already do for rtvol, only free full extents for forcealign in
> xfs_free_file_space().
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Seems fine to me.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_bmap_util.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index 56b80a7c0992..ee767a4fd63a 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -842,8 +842,11 @@ xfs_free_file_space(
>  	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
>  	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
>  
> -	/* We can only free complete realtime extents. */
> -	if (xfs_inode_has_bigrtalloc(ip)) {
> +	/* Free only complete extents. */
> +	if (xfs_inode_has_forcealign(ip)) {
> +		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
> +		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
> +	} else if (xfs_inode_has_bigrtalloc(ip)) {
>  		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
>  		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
>  	}
> -- 
> 2.31.1
> 
> 

