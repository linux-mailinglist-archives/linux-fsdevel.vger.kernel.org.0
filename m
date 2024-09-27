Return-Path: <linux-fsdevel+bounces-30263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DA2988841
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 17:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8940C1F215A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 15:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E51C1732;
	Fri, 27 Sep 2024 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtwBfN/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEB3142621
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450842; cv=none; b=djYEM96ij99KPsegZNFJgxOcdNOLfRoCFv6b7vxy2Q/z8S59us/naa3qpVDlZe5jrcidLXaRgaCdA4SsvpZcweZ9TqI/swtTFq/tyYyzAEO/YTvdfNa/VPnAaOKdzUeXyp/50y/Ncnk3g6EWaTfdR89sRIJ59q0iGe6yrW0naLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450842; c=relaxed/simple;
	bh=O2TB960hWNhFSAZRNo1z0rBtIxOSLDwsOsf/v6qVzvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRcpUacF4w9XVmJrx5wiWl46hBRBqEt607gTkD+kBn4OGXQwfT8Ke4QLvDP+nyrSO/fcrqQcs575zQ0X8VYGZvnD/wRWlE7VYDoZEVckeeG20lSzO/KLv1S+B++RXp+W8ET7uhqE8PIOUYA0WOosCIdpZN1YVTPb4bTY1PZTxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtwBfN/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4A6C4CEC4;
	Fri, 27 Sep 2024 15:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727450842;
	bh=O2TB960hWNhFSAZRNo1z0rBtIxOSLDwsOsf/v6qVzvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtwBfN/cMReIz9WNppviqd4X+zaJqwVhDkV+SS9KAqTAp1jRXa7VfG/K1aHi40KD5
	 U5Y+wHX2dYqyjAZCnYrj/iEejDCECQ8uJoJRkT56PwsYO8gtJiheL3HSnlebrQboeF
	 LsrU0JpADlQ0hWmlj5r6eSZy0V4f6OARzK19RR2Xz2fmRQrkA2dd7Lmvf9V7CpxU6F
	 R1ZeittSQF4ngO7g1nr8rVONZvgOmm4F3s3pB2d0cn2Nu9HWhDNhcH2zw6wG+1cIof
	 yhF9GWurAB8DwkCBruqjG8lxFDIQrDueVQT86b/aORqtppLkJPOmsbx3JJHzXABKs7
	 KhrygnKhTLC4A==
Date: Fri, 27 Sep 2024 08:27:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	hch@lst.de
Subject: Re: [PATCH v2] vfs: return -EOVERFLOW in generic_remap_checks() when
 overflow check fails
Message-ID: <20240927152722.GR21877@frogsfrogsfrogs>
References: <20240927065325.2628648-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927065325.2628648-1-sunjunchao2870@gmail.com>

On Fri, Sep 27, 2024 at 02:53:25PM +0800, Julian Sun wrote:
> Keep the errno value consistent with the equivalent check in
> generic_copy_file_checks() that returns -EOVERFLOW, which feels like the
> more appropriate value to return compared to the overly generic -EINVAL.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Looks better this time :)
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/remap_range.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 6fdeb3c8cb70..1333f67530c0 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -47,7 +47,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  	/* Ensure offsets don't wrap. */
>  	if (check_add_overflow(pos_in, count, &tmp) ||
>  	    check_add_overflow(pos_out, count, &tmp))
> -		return -EINVAL;
> +		return -EOVERFLOW;
>  
>  	size_in = i_size_read(inode_in);
>  	size_out = i_size_read(inode_out);
> -- 
> 2.39.2
> 

