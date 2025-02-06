Return-Path: <linux-fsdevel+bounces-41127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0AA2B43E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 22:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057EE3A3642
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BFE223300;
	Thu,  6 Feb 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC7V19eL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8862722257E;
	Thu,  6 Feb 2025 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877898; cv=none; b=Hg+BB/aDVDgvUHqa4kvht0tHZrxj9M2sPINBsqUvvrEMhBh9Vgt2YOBHJKybSrHaUiw3b9Y1XHRJxvJfKvk4jXWvgMtyc7dW+odnz6LmsnFkrbyQyoS9ucyGJ8C6IweuolzekTxkKMo7/dS8HM9pSyMmngumGlL0xWwu8qm6Bf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877898; c=relaxed/simple;
	bh=CryonJbCuF96YFIBThKO+6Qtw8wzRCDlB/WwGhs/j2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMfhfhtLs26IqP5aQO139tQ8lO65Mj4w4Jmkh6CINrWr0/4uVdbles8x8XdruErYjlHlCRU+Av+g4o1tY5tBm6OEa2j3AkT4GcMitxI54rbUFfa4BQeSrYjIFI0Er7ThzlnS4/sRpBiHjZAybHB5rw2bUM5dXCiXxGzwOpH3aoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC7V19eL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E995CC4CEDD;
	Thu,  6 Feb 2025 21:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738877897;
	bh=CryonJbCuF96YFIBThKO+6Qtw8wzRCDlB/WwGhs/j2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cC7V19eLyM4Cyotrv/DepwRQkC91MWNJbBnya/DsiwB7Xt/rvhhp0a6uuJ4cf0n1I
	 boGhtzgm+6ba46+1c7dTrk83tKv9W/dK4cfDAiGHCSiHtYd0LZofcrOxYs3JbU3NRz
	 K2NZjBvhKVf+F+Zjc5b04w7ZLfl5ZDnxByI7uJusOkGnLsHXeWqCWwK465uwStAD0I
	 s1NgbUKlr55RV06rWvIYMLWmKOhGuhfJQzjV8czTQ8R8KzYSpGOIv9QHpKjwTJd8+V
	 /Z4geYpK7JruLVSm3xtLIIO7nvYj/MHmOALFsWenA4pqupjd9IPrRKYn/uIvq6DFom
	 l7ZPq2fUxB4Qg==
Date: Thu, 6 Feb 2025 13:38:16 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, martin.petersen@oracle.com
Subject: Re: [PATCH RFC 02/10] xfs: Refactor xfs_reflink_end_cow_extent()
Message-ID: <20250206213816.GU21808@frogsfrogsfrogs>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-3-john.g.garry@oracle.com>
 <20250205195050.GX21808@frogsfrogsfrogs>
 <d049cabb-9535-4a1d-ab01-61512c041af8@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d049cabb-9535-4a1d-ab01-61512c041af8@oracle.com>

On Thu, Feb 06, 2025 at 10:35:28AM +0000, John Garry wrote:
> On 05/02/2025 19:50, Darrick J. Wong wrote:
> > > diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> > > index 59f7fc16eb80..580469668334 100644
> > > --- a/fs/xfs/xfs_reflink.c
> > > +++ b/fs/xfs/xfs_reflink.c
> > > @@ -786,35 +786,20 @@ xfs_reflink_update_quota(
> > >    * requirements as low as possible.
> > >    */
> > >   STATIC int
> > > -xfs_reflink_end_cow_extent(
> > > +xfs_reflink_end_cow_extent_locked(
> > >   	struct xfs_inode	*ip,
> > >   	xfs_fileoff_t		*offset_fsb,
> > > -	xfs_fileoff_t		end_fsb)
> > > +	xfs_fileoff_t		end_fsb,
> > > +	struct xfs_trans	*tp,
> > > +	bool			*commit)
> > Transactions usually come before the inode in the parameter list.
> 
> ok
> 
> > 
> > You don't need to pass out a @commit flag -- if the function returns
> > nonzero then the caller has to cancel the transaction; otherwise it will
> > return zero and the caller should commit it.>  There's no penalty for
> > committing a non-dirty transaction.
> 
> If there is no penalty, then fine. But I don't feel totally comfortable with
> this and would prefer to keep the same behavior.

Right now this is the only place in XFS that behaves this way, which
means you're adding a new code idiom that isn't present anywhere else in
the code base.

--D

> Thanks,
> John
> 
> 
> 
> 

