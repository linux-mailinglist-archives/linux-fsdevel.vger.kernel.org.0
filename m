Return-Path: <linux-fsdevel+bounces-27478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDE4961AC9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964BF282344
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6F1D4612;
	Tue, 27 Aug 2024 23:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BV4ggfIE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D51D3186;
	Tue, 27 Aug 2024 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802432; cv=none; b=ZDbXf3E8VB9q+nTCWTonfysyc6Nlhg1LOb/4YQGfK2L22RsyBP8I6Lwz6eA+oSZhLhdihtKZWa+QvVl6CHliuwFCqws3999hSHTMPt3QwaleztZ1Ib2H8j3yuBIv5oWQFjAr2+DZU6EBRQAEeAKvqMXTyy44IY5J9swgYizMDxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802432; c=relaxed/simple;
	bh=OeQ4KeXcMAU00xKc+jqm3FoXFoFUgrIIah38ySqQmPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdJ14nLbQ4srM8qt7AFNuzmM9D6W7VqBS6Ufd8YALJPoPjLmkZzz9wHVHXiuH4hVcH4Dv7Ww6Dw8fHziZPNXfIrBrbKowAOU8PJ/xFaunJ/ISy1YApsIacsyklZrWdeza3r5XZvP7H6KnKH1ntGu1b2reSHyQ2tTar2s9piHDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BV4ggfIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA48C4E68E;
	Tue, 27 Aug 2024 23:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724802431;
	bh=OeQ4KeXcMAU00xKc+jqm3FoXFoFUgrIIah38ySqQmPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BV4ggfIEk8f3ii3C+EQKH3gErcwzDamvvI2k343gHQO2nWBBn4kVsu9YQJPtgaMSG
	 VH7XGTXdMqUM8u4S0ESu3+AZnkIfDVyCJBQz2G9v0z1lhwe4JGjWkeLL0G4HempjjD
	 VpL9m6aYG7lxMK2e/LX1Xg+fE3SDV6Iw4b4PaUPkRNjFq02m9hvogj++3gFgQs4Cmb
	 q6jfq4jUZSYIeyyTSAjUqx43tJtD9s34SwEE6vCbJZ1hxpsNBPn8nsRJ75Ua2u3fhy
	 GozXiuD8EwkuezDxoKlTY7yaKsvNYvd86bgb622gag9lfZs3ZCu5SCqdX8XANG/SjO
	 qr/RIGmExVf9w==
Date: Tue, 27 Aug 2024 16:47:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] xfs: Fix format specifier for max_folio_size in
 xfs_fs_fill_super()
Message-ID: <20240827234710.GF1977952@frogsfrogsfrogs>
References: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>

On Tue, Aug 27, 2024 at 04:15:05PM -0700, Nathan Chancellor wrote:
> When building for a 32-bit architecture, where 'size_t' is 'unsigned
> int', there is a warning due to use of '%ld', the specifier for a 'long
> int':
> 
>   In file included from fs/xfs/xfs_linux.h:82,
>                    from fs/xfs/xfs.h:26,
>                    from fs/xfs/xfs_super.c:7:
>   fs/xfs/xfs_super.c: In function 'xfs_fs_fill_super':
>   fs/xfs/xfs_super.c:1654:1: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    1655 |                                 mp->m_sb.sb_blocksize, max_folio_size);
>         |                                                        ~~~~~~~~~~~~~~
>         |                                                        |
>         |                                                        size_t {aka unsigned int}
>   ...
>   fs/xfs/xfs_super.c:1654:58: note: format string is defined here
>    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
>         |                                                        ~~^
>         |                                                          |
>         |                                                          long int
>         |                                                        %d
> 
> Use the proper 'size_t' specifier, '%zu', to resolve the warning.
> 
> Fixes: 0ab3ca31b012 ("xfs: enable block size larger than page size support")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Yep.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 242271298a33..e8cc7900911e 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1651,7 +1651,7 @@ xfs_fs_fill_super(
>  
>  		if (mp->m_sb.sb_blocksize > max_folio_size) {
>  			xfs_warn(mp,
> -"block size (%u bytes) not supported; Only block size (%ld) or less is supported",
> +"block size (%u bytes) not supported; Only block size (%zu) or less is supported",
>  				mp->m_sb.sb_blocksize, max_folio_size);
>  			error = -ENOSYS;
>  			goto out_free_sb;
> 
> ---
> base-commit: f143d1a48d6ecce12f5bced0d18a10a0294726b5
> change-id: 20240827-xfs-fix-wformat-bs-gt-ps-967f3aa1c142
> 
> Best regards,
> -- 
> Nathan Chancellor <nathan@kernel.org>
> 
> 

