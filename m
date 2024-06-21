Return-Path: <linux-fsdevel+bounces-22149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C099F912DBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 21:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14A61C238F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A6917B4FA;
	Fri, 21 Jun 2024 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzHjc/Ce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F089B67D;
	Fri, 21 Jun 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718997238; cv=none; b=m2r7Jhd1hV0cTUvtObKmnAgWNB+2dVKYzN3HbrljwbAjPG2dNMbekQrM7AeqDJfDrg3bjwdy6EriH+mKqTTKUeoCzxDQXs3al5Y0kpuzUIEaO3DQ2J729mX3sS7a4NZZuUHgb0CjI6gTb1yjf82HWfsDYVdZVphSZHVph7shRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718997238; c=relaxed/simple;
	bh=0zyZ73ct1NhekP0iINSaiaQYX6M2DCA8CHBz7pfWunc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGgvFW1zUz3VyI7pSExn8O8DiBK6I2UOHMjgzI5GReJfVya1Y/URCkRkSx51p/KKf/+MxLBd4RYvqU4b30qxkXyL7UqVzqlSynDVnzHVchQ3/pxChspe1w1mf5r6y5qVjTMYM/itFz4ou8bOZO+uIczQml3GRt4PvIzhX2gIgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzHjc/Ce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0966FC2BBFC;
	Fri, 21 Jun 2024 19:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718997238;
	bh=0zyZ73ct1NhekP0iINSaiaQYX6M2DCA8CHBz7pfWunc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QzHjc/CeDDROv6rVmUnD/fFH4PmnK5EDDoinhW2wdVYVaXMPUVUmHITgU4v3Q+zJN
	 Mhd75q0TOZYNmWT4RtOQpBcSazgGldhGvZ30zyifNU0+2dwcgnd/LPVh5bA02waGcs
	 J2S37PqnQF84UHJ3ML45pyjLzyNY/JUbETKiQuB6mgrbTqp/952QC/r1HDbMXg6ri8
	 u66QwiEZuIL9QITG4sGe4ccoChD2cV0VVdkIb3KcraZIFLG449DZbA0iX4WeVzyd/m
	 Sg2uVTDl+Z1ZSCrHiaiBgi1uNQuUg0yFtU3xtHQu5k5LVOLPa1UWxujGdT8SXJAkgz
	 9UVsN1E4VwvIQ==
Date: Fri, 21 Jun 2024 12:13:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 12/13] xfs: Don't revert allocated offset for forcealign
Message-ID: <20240621191357.GQ3058325@frogsfrogsfrogs>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-13-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621100540.2976618-13-john.g.garry@oracle.com>

On Fri, Jun 21, 2024 at 10:05:39AM +0000, John Garry wrote:
> In xfs_bmap_process_allocated_extent(), for when we found that we could not
> provide the requested length completely, the mapping is moved so that we
> can provide as much as possible for the original request.
> 
> For forcealign, this would mean ignoring alignment guaranteed, so don't do
> this.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Makes sense,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_bmap.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index ebeb2969b289..42f3582c1574 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3492,11 +3492,15 @@ xfs_bmap_process_allocated_extent(
>  	 * original request as possible.  Free space is apparently
>  	 * very fragmented so we're unlikely to be able to satisfy the
>  	 * hints anyway.
> +	 * However, for an inode with forcealign, continue with the
> +	 * found offset as we need to honour the alignment hint.
>  	 */
> -	if (ap->length <= orig_length)
> -		ap->offset = orig_offset;
> -	else if (ap->offset + ap->length < orig_offset + orig_length)
> -		ap->offset = orig_offset + orig_length - ap->length;
> +	if (!xfs_inode_has_forcealign(ap->ip)) {
> +		if (ap->length <= orig_length)
> +			ap->offset = orig_offset;
> +		else if (ap->offset + ap->length < orig_offset + orig_length)
> +			ap->offset = orig_offset + orig_length - ap->length;
> +	}
>  	xfs_bmap_alloc_account(ap);
>  }
>  
> -- 
> 2.31.1
> 
> 

