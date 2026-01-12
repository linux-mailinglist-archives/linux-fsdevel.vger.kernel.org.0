Return-Path: <linux-fsdevel+bounces-73322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF590D158ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 23:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D384B3033D68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 22:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202072857EE;
	Mon, 12 Jan 2026 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCSMOiC/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124628506F;
	Mon, 12 Jan 2026 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768256536; cv=none; b=fbWqrXI4XTrJxLur/7Bd7Ov6EhhYanqAP/uvtDRWEthid0i5M+CwUBNYUZDPgGcx879o1pPnBtFoGc8Sib5CXuXKwrmiMEuTwciLwKHL8jEgUgh4sIRkccuYHvSgsj+jIgXLABE/N6qgjH8ik11tgfNM187nLUCK0DVjG99bOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768256536; c=relaxed/simple;
	bh=7xhcvRFTJhNAao8XObbtXFp9xV1U7lxavzma/incP4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC2Oh/tMwab4whsuP1YPQw1BVG6XbsjWt8YAjoaD4pJ6mhfePu014aFYLpb0gfaWGjiouS/UlRZOEo75u49estgT8Ra3NSj9pnPB0S0busoUgDmS1HRriW1W25kP2doDRIOT1v3w8FNJVkq58OYVmG/uLJA+V0Z3iyUf2dXXNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCSMOiC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126F9C116D0;
	Mon, 12 Jan 2026 22:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768256536;
	bh=7xhcvRFTJhNAao8XObbtXFp9xV1U7lxavzma/incP4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iCSMOiC/sSqMtm9S7IGOiQ6qbfrtM0hYZ4Bbz2F+iP3hhZya1yRwFAT0o1PI1g5PP
	 pbaGoj6SXSLeNX92s0OrKqINfQoPZmtauW/bJ54i03n7QDMfGP8UtVpeCkAPfnaTJ5
	 dtQ0Ieuv9PK0mCAKN4nHhHs+OnOmh+wBbBHCAgxr+0aHNQJ+vwi6ALRg0eDmX2PZy5
	 G2hgc+3pzW5jmVB7VG/catZ+oioPHXEIJ5gtBgaEKnGPXwimgVGd3fYImG2ko4605U
	 vU2qmt6TqNYehtuFDiIK5QcRdcRhh9vtTLcTO4EUfaJo5g+q3oiskacpZvFgizYpWr
	 Imf9liPebDL0Q==
Date: Mon, 12 Jan 2026 14:22:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 4/22] iomap: allow iomap_file_buffered_write() take
 iocb without file
Message-ID: <20260112222215.GJ15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <kibhid6bipmrndfn774tlbm6wcitya5qydhjws3n6tnjvbd4a3@bui63p535b3q>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kibhid6bipmrndfn774tlbm6wcitya5qydhjws3n6tnjvbd4a3@bui63p535b3q>

On Mon, Jan 12, 2026 at 03:50:18PM +0100, Andrey Albershteyn wrote:
> This will be necessary for XFS to use iomap_file_buffered_write() in
> context without file pointer.
> 
> As the only user of this is XFS fsverity let's set necessary
> IOMAP_F_BEYOND_EOF flag if no file provided instead of adding new flags
> to iocb->ki_flags.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  fs/iomap/buffered-io.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index cc1cbf2a4c..79d1c97f02 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1173,7 +1173,6 @@
>  		const struct iomap_write_ops *write_ops, void *private)
>  {
>  	struct iomap_iter iter = {
> -		.inode		= iocb->ki_filp->f_mapping->host,
>  		.pos		= iocb->ki_pos,
>  		.len		= iov_iter_count(i),
>  		.flags		= IOMAP_WRITE,
> @@ -1181,6 +1180,13 @@
>  	};
>  	ssize_t ret;
>  
> +	if (iocb->ki_filp) {
> +		iter.inode = iocb->ki_filp->f_mapping->host;
> +	} else {
> +		iter.inode = (struct inode *)private;

@private is for the filesystem implementation to access, not the generic
iomap code.  If this is intended for fsverity, then shouldn't merkle
tree construction be the only time that fsverity writes to the file?
And shouldn't fsverity therefore have access to the struct file?

> +		iter.flags |= IOMAP_F_BEYOND_EOF;

IOMAP_F_ flags are mapping state flags for struct iomap::flags, not the
iomap_iter.

--D

> +	}
> +
>  	if (iocb->ki_flags & IOCB_NOWAIT)
>  		iter.flags |= IOMAP_NOWAIT;
>  	if (iocb->ki_flags & IOCB_DONTCACHE)
> 
> -- 
> - Andrey
> 
> 

