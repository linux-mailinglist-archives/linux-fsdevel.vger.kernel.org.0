Return-Path: <linux-fsdevel+bounces-22144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82041912D4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5D21F2315A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8F17B407;
	Fri, 21 Jun 2024 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQhyQpE1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA48820;
	Fri, 21 Jun 2024 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995106; cv=none; b=h8qdWa8bTijqMiOJF3bfqLCt1HZxiZfh45CqUqWioTuak4hRroqirAiDke7mr1f/92a8ZMh9N3G+UwKRmAWkm+0U8CGsidX8cyBhmbWBGUsOGj0cRADy8TuqJP1xl6ebmnXK+XNddBZkGcbqXBr2vpGgw0KKBRZy+czlpZ7EndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995106; c=relaxed/simple;
	bh=Ok8swI1SCA/tBODdfv/m74RxTes/0LQxUWZeMddygOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3+JoVTNwPKemt5d5si0Or3nEJ7FoQ25fl44YkrSbjkyaxPAABOnP5WRSEVtBIgIbgTE3MLfo3mnj3UpFw5/1bpuSf3t7BanlYyEY1VDA4jyQfn6fVWeT68XBNO0zVn8qVMjwEB8W5Q3FsCHsI/ZO6Yv+vRyI9A0MdxligBRXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQhyQpE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8012C2BBFC;
	Fri, 21 Jun 2024 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718995104;
	bh=Ok8swI1SCA/tBODdfv/m74RxTes/0LQxUWZeMddygOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iQhyQpE1AIEy0Dp1mfxsrm1/69xt6rgau9+W/UWCVWJjyG4xllLUH8IoiNT1qTfye
	 X9DYgCJzTrC/OFtJrgc164n1Xd1bMIuZ49zT8l8MoHGGZZGw9DYdSJCPw33iFhRvAL
	 KTqFnEH0gfhRF5vXWiqR+ydmn4A0hdxsRS3l4gAxThZt0FwNcoBck3IPjU90FeqaqC
	 PXTYOpdjkiq30HI5BLo6n4BwU5jlL8ypjVYHVUWz0LTN39V4NAtgg1vzPQ+nUf91Oc
	 cjM8yqVoyU1SUXEmuv3g8VV8HvWU3f3uFRZHvrnBsBSlfXlLbD3z5ITL71fN0cALG0
	 QeSSWEtqB/6Hw==
Date: Fri, 21 Jun 2024 11:38:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH 09/13] xfs: Update xfs_inode_alloc_unitsize_fsb() for
 forcealign
Message-ID: <20240621183824.GL3058325@frogsfrogsfrogs>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
 <20240621100540.2976618-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621100540.2976618-10-john.g.garry@oracle.com>

On Fri, Jun 21, 2024 at 10:05:36AM +0000, John Garry wrote:
> For forcealign enabled, the allocation unit size is in ip->i_extsize, and
> this must never be zero.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 994fb7e184d9..cd07b15478ac 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -4299,6 +4299,8 @@ xfs_inode_alloc_unitsize(
>  {
>  	unsigned int		blocks = 1;
>  
> +	if (xfs_inode_has_forcealign(ip))
> +		return ip->i_extsize;

i_extsize is in units of fsblocks, whereas this function returns bytes.
I think you need XFS_FSB_TO_B here?

--D

>  	if (XFS_IS_REALTIME_INODE(ip))
>  		blocks = ip->i_mount->m_sb.sb_rextsize;
>  
> -- 
> 2.31.1
> 
> 

