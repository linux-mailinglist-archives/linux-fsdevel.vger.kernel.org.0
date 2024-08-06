Return-Path: <linux-fsdevel+bounces-25174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E99E5949892
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 21:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A591B282A8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626A14B965;
	Tue,  6 Aug 2024 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1tqTmDS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289607EEFD;
	Tue,  6 Aug 2024 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973402; cv=none; b=E4tseNBcBIgFWqqpAkjVvMtrPoxBiek47abyGQkroLGJCr5y56bpf0NiIw9F2SZFsq27dJ79r2Q1yJ2a23y0CFgr/iLhWIjYIWnImPY5WvkVkse8g+XrzOLcw6C/uSvRohD8bFiyEG0SC9pJ7Hfw0ESnwPozDqtf8Rys/0DuX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973402; c=relaxed/simple;
	bh=TLWaPUe957jN+lNsjIkqk2CPkFpWrDGUb/QpOBcEPyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqgxcLu7nBak/FpGoOv8sT17LPCUB8fPsdyYwimepGSWS2Dzuo4PzHe/9wYsQ+uPdl5pSn3qOmNBrM/hU/m8nq5AefmRWBFItYvo2yfm6NPccclAtq5PCf9lxO5qN2p3lfVbX/a06/bkSSweMi77W+Ma2nhTGytITcMM0OuT1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1tqTmDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09F3C32786;
	Tue,  6 Aug 2024 19:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722973401;
	bh=TLWaPUe957jN+lNsjIkqk2CPkFpWrDGUb/QpOBcEPyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1tqTmDSx5jm2CRMlHUtYdMggpkfgB75emkb/YcJwGg5IZqk+/xsKfIVq2E2Ht4XD
	 hV40PFHaJ1+TFH+DbAM9OQ4PPVZ7guvOzBNDjtKEKDVYal3EEcs9HQ5B6FIMtc5fyF
	 NjX4aJnI8JWrMXVHtXICNYLiHhD4grBeBqTDxB0BUzhsgh4sjt5tsr26j7EcGL+KeJ
	 8Z4iHFAGDbR0JzEuhZnwv9WvKIVnygtjsPyj1dBMoWtYN/MBoDoWMFgLKugukFDKHe
	 +fyVUp4zeOy778HEAH5GvalyGkxI9nOoxP7o4ILluLkTvTShDhMRD8GpVmsobTVx6c
	 yM44lM2A4jqaQ==
Date: Tue, 6 Aug 2024 12:43:21 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH v3 14/14] xfs: Enable file data forcealign feature
Message-ID: <20240806194321.GO623936@frogsfrogsfrogs>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
 <20240801163057.3981192-15-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163057.3981192-15-john.g.garry@oracle.com>

On Thu, Aug 01, 2024 at 04:30:57PM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Enable this feature.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

You really ought to add your own Reviewed-by tag here...

--D

> ---
>  fs/xfs/libxfs/xfs_format.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
> index 95f5259c4255..04c6cbc943c2 100644
> --- a/fs/xfs/libxfs/xfs_format.h
> +++ b/fs/xfs/libxfs/xfs_format.h
> @@ -357,7 +357,8 @@ xfs_sb_has_compat_feature(
>  		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
>  		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
>  		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
> -		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
> +		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
> +		 XFS_SB_FEAT_RO_COMPAT_FORCEALIGN)
>  #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
>  static inline bool
>  xfs_sb_has_ro_compat_feature(
> -- 
> 2.31.1
> 
> 

