Return-Path: <linux-fsdevel+bounces-23255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2379291A6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508A82832A0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jul 2024 07:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05063E49D;
	Sat,  6 Jul 2024 07:59:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC9A95B;
	Sat,  6 Jul 2024 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720252744; cv=none; b=XTqS+Saex2AFawCHLJwdRbqssd1u0p1PbVYZA3kQk/jzMZkPgVhzar9CaQLcOOBWBrGbd6fRCLlLhqXuIviCdU3ysi4K2hGOnMh5V219U+Z8qvEJGfqJRRBSz3XkAYKxcvlWyqdFJJinLnYeqRoUD2t8VLoDHJTZU6C6VWX+lEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720252744; c=relaxed/simple;
	bh=sbeJTeAe2HQzOECSDfVOq6iaJU+QefO/UatGjQUDIkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPyINVABuqpAJVE7AomvteKQqg5wO7d50RlGl0dzCkNissMPuD6TXotXwrgrBzLFmMkZawBr09c4UUII6UR5D16e3yN/FT445nsf7k4GDK/1cJvz109Q8BGNDIxpPqw9mXWUC34nWeyYkzwR5RUes4XiVFysDOrQp9MN8DGOkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9465668AA6; Sat,  6 Jul 2024 09:58:58 +0200 (CEST)
Date: Sat, 6 Jul 2024 09:58:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
	hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	catherine.hoang@oracle.com, martin.petersen@oracle.com
Subject: Re: [PATCH v2 10/13] xfs: Unmap blocks according to forcealign
Message-ID: <20240706075858.GC15212@lst.de>
References: <20240705162450.3481169-1-john.g.garry@oracle.com> <20240705162450.3481169-11-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705162450.3481169-11-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +static xfs_extlen_t
> +xfs_bunmapi_align(
> +	struct xfs_inode	*ip,
> +	xfs_fsblock_t		bno)
> +{
> +	struct xfs_mount	*mp = ip->i_mount;
> +	xfs_agblock_t		agbno;
> +
> +	if (xfs_inode_has_forcealign(ip)) {
> +		if (is_power_of_2(ip->i_extsize))
> +			return bno & (ip->i_extsize - 1);
> +
> +		agbno = XFS_FSB_TO_AGBNO(mp, bno);
> +		return agbno % ip->i_extsize;
> +	}
> +	ASSERT(XFS_IS_REALTIME_INODE(ip));
> +	return xfs_rtb_to_rtxoff(ip->i_mount, bno);

This helper isn't really bunmapi sepcific, is it?

> @@ -5425,6 +5444,7 @@ __xfs_bunmapi(
>  	struct xfs_bmbt_irec	got;		/* current extent record */
>  	struct xfs_ifork	*ifp;		/* inode fork pointer */
>  	int			isrt;		/* freeing in rt area */
> +	int			isforcealign;	/* freeing for inode with forcealign */

This is really a bool.  And while it matches the code around it the
code feels a bit too verbose..
> 
> +		if ((!isrt && !isforcealign) || (flags & XFS_BMAPI_REMAP))
>  			goto delete;
>  
> -		mod = xfs_rtb_to_rtxoff(mp,
> -				del.br_startblock + del.br_blockcount);
> +		mod = xfs_bunmapi_align(ip, del.br_startblock + del.br_blockcount);

Overly long line.

We've been long wanting to split the whole align / convert unwritten /
etc code into a helper outside the main bumapi flow.  And when adding
new logic to it this might indeed be a good time.

> +			if (isforcealign) {
> +				off = ip->i_extsize - mod;
> +			} else {
> +				ASSERT(isrt);
> +				off = mp->m_sb.sb_rextsize - mod;
> +			}

And we'll really need proper helpers so that we don't have to
open code the i_extsize vs sb_rextsize logic all over.


