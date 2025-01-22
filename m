Return-Path: <linux-fsdevel+bounces-39818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57345A18A97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 04:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F36F3A262C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 03:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF182155C97;
	Wed, 22 Jan 2025 03:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laI9VX5D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546C961FF2;
	Wed, 22 Jan 2025 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737516305; cv=none; b=CXL+OyjLPAgFmqHFyoc8sE9i1sdVEtfBfxdP4p7+k5SsoYAn2QvLw9rwIdMZCywNfSFl1bwJ1oue3xJU11ifMoKs5nLFIzMiPHTtRuLrlYFZdYl92QnQfWG0U2um5ViGVuW8ymwC57iIeGsUGDujU5p2zNgAkcHMElbgY/oHFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737516305; c=relaxed/simple;
	bh=3Ta6CT92zMNQ4Nxc5RAR29X4+UfnvsqCJEC4+UdxP3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXo141Mtb+cimS4pRVwPmwNajWQhK+yrPJjZDhSw4lWv3lg24jCLb0UmXVb2aWetOociOVbF6Ac+31z/VOOrfoaAmWl63yBLLuP0p5rznle6Yi/dNAoibhOg4tDY3UWJVFciX2zebC6uQV4nQh2mUTBN4WkkqK5FULrkTdtW/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laI9VX5D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4E7C4CED6;
	Wed, 22 Jan 2025 03:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737516304;
	bh=3Ta6CT92zMNQ4Nxc5RAR29X4+UfnvsqCJEC4+UdxP3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=laI9VX5DpMZPJl0ecGT30VVHd2vHRStcPz+uvDNZdX3gbPZ12ay31XJwbwdhXqHnw
	 VwPFdpfIAewoOwgqXFR37O0zTmV06N3JILCaMzl+nn/++5XlBejBIcZ3Ox0J3sya59
	 36HPKkgBGjVlvKDqcFuh9gAowvJ4EdvmCDRCpKT8R2tGGMDXoSCywxdSQCpr3C2mdb
	 DJqHGFs9n1esuzZx9g9x6RbGJpF+C8Ep7O67d2/17MT+ia9RSX6wAg8awcUOjDkCTc
	 kMrAk7sC1sjs3B8H1Yn4t97lz1CgIpmJjtrbPpct7uv4Vnsrev7eKPWZGKFuC2LkYJ
	 XOKOjg6mUt1ZQ==
Date: Tue, 21 Jan 2025 19:25:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: chandanbabu@kernel.org, cem@kernel.org, brauner@kernel.org,
	dchinner@redhat.com, yi.zhang@huawei.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Propagate errors from xfs_reflink_cancel_cow_range
 in xfs_dax_write_iomap_end
Message-ID: <20250122032504.GT3557553@frogsfrogsfrogs>
References: <20250120160907.1751-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120160907.1751-1-vulab@iscas.ac.cn>

On Tue, Jan 21, 2025 at 12:09:06AM +0800, Wentao Liang wrote:
> In xfs_dax_write_iomap_end(), directly return the result of
> xfs_reflink_cancel_cow_range() when !written, ensuring proper
> error propagation and improving code robustness.
> 
> Fixes: ea6c49b784f0 ("xfs: support CoW in fsdax mode")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  fs/xfs/xfs_iomap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 50fa3ef89f6c..d61460309a78 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -976,10 +976,8 @@ xfs_dax_write_iomap_end(
>  	if (!xfs_is_cow_inode(ip))
>  		return 0;
>  
> -	if (!written) {
> -		xfs_reflink_cancel_cow_range(ip, pos, length, true);
> -		return 0;
> -	}
> +	if (!written)
> +		return xfs_reflink_cancel_cow_range(ip, pos, length, true);

Ouch.  Yeah, that's clearly wrong.  Please add my tags:

Cc: <stable@vger.kernel.org> # v6.0
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

>  
>  	return xfs_reflink_end_cow(ip, pos, written);
>  }
> -- 
> 2.42.0.windows.2
> 

