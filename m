Return-Path: <linux-fsdevel+bounces-39817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40666A18A92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 04:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71193A3437
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 03:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0115575D;
	Wed, 22 Jan 2025 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+syXFs6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2133481B1;
	Wed, 22 Jan 2025 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737516078; cv=none; b=t4xlxSYqFeCE8oC2ouH0FOLLckR2q5/L4zBRxntujPkH55lTT27lm1H5ZqR2FhE4tpyrnuxnIFp6raLP/ordYB0DOvIgK5JFqJ77APE8Nd/XxkR2nOFfyzyDzWKmuCEKGR5Z4dsDOvq6CICfAjU/ET/xx4AG8VB6q8pAUUObG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737516078; c=relaxed/simple;
	bh=g3kGjyEah7u+jJiqBdmrMK486PvH1xv43roG5vWbXs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVG1KsBqzWJRlwq+/m2+mtbJqeF42JGOkJ5PWWavec5+/82A65tBWifpPSSonio1Q/xVAHOYyW9FVSu1DdMWnV0j1oFGZFum1F80LWmyMEaP43Flp/tW8YGMKtBoKBCKozRF8dfglE4gbsARalpoA7kHK9ePy1x2v9CtbkSX1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+syXFs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0DCC4CEDF;
	Wed, 22 Jan 2025 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737516078;
	bh=g3kGjyEah7u+jJiqBdmrMK486PvH1xv43roG5vWbXs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+syXFs6VvOCoMdlcPylFKjNUJl17coEGeZkgdYBwpmgIp+PyhLvLdX8g9gdTD7sg
	 T33aUZZofJvOq1gGcGeCrILb8pRlg6siarEoTVp5NT2BTQdI1Es/jq6X9bj35j3rI8
	 jNJ6OAHmBG2oNpFfyb1ZyD+TpV1ZG/EmYFRX80s2nVhIY6n7r5guB5BG39rD2YsxDx
	 BrBx1ELVwic2ruYQ6lJQcmpJRNTQhqczraOxQr/Ad5EIXNxm+bQEPHDFibGXTWE9UP
	 1gIenhebJAml9AOHQ4YTfhUaP63CMFgW39eegEhKMKdkOjYSIobyT1KNxkrCHx8Ueo
	 NUCvBbEWxqTVQ==
Date: Tue, 21 Jan 2025 19:21:17 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Chandan Babu R <chandanbabu@kernel.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	Dave Chinner <dchinner@redhat.com>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs: Add error handling for xfs_reflink_cancel_cow_range
Message-ID: <20250122032117.GS3557553@frogsfrogsfrogs>
References: <20250120154624.1658-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120154624.1658-1-vulab@iscas.ac.cn>

On Mon, Jan 20, 2025 at 11:46:24PM +0800, Wentao Liang wrote:
> In xfs_inactive(), xfs_reflink_cancel_cow_range() is called
> without error handling, risking unnoticed failures and
> inconsistent behavior compared to other parts of the code.
> 
> Fix this issue by adding an error handling for the
> xfs_reflink_cancel_cow_range(), improving code robustness.
> 
> Fixes: 6231848c3aa5 ("xfs: check for cow blocks before trying to clear them")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  fs/xfs/xfs_inode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index c8ad2606f928..1ff514b6c035 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -1404,8 +1404,11 @@ xfs_inactive(
>  		goto out;
>  
>  	/* Try to clean out the cow blocks if there are any. */
> -	if (xfs_inode_has_cow_data(ip))
> -		xfs_reflink_cancel_cow_range(ip, 0, NULLFILEOFF, true);
> +	if (xfs_inode_has_cow_data(ip)) {
> +		error = xfs_reflink_cancel_cow_range(ip, 0, NULLFILEOFF, true);
> +		if (error)
> +			goto out;

If memory serves, we ignored the error return here on the grounds that
the worst that can happen is that we leak some cow staging reservations,
so we should continue freeing the file in the ondisk metadata.

That said, I /think/ the error case corresponds to the log being shut
down or going down due to a corruption error during the cow blocks
cancellation.  So I guess this can go ahead with:

Cc: <stable@vger.kernel.org> # v4.17
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +	}
>  
>  	if (VFS_I(ip)->i_nlink != 0) {
>  		/*
> -- 
> 2.42.0.windows.2
> 

