Return-Path: <linux-fsdevel+bounces-43887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2969A5F05E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 11:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453403BBB2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 10:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075D264F9A;
	Thu, 13 Mar 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3rcZCy5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDE21EE028;
	Thu, 13 Mar 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860830; cv=none; b=H6p/yoTAvho/WnATDggJQ3Msxf0hB5HIcIkYPzUxkGj8gVmuvTj6GtrqrEpmSUtkUqS+Ig9gzHJI3fAt2rqtDxdIxXjgKM2Nq2eXPHe4J3/zP8TrRwmOReS8TeZKGL7HDfMz+H1u4v04DvDm9ti/A9TeQq+jbs90++SRQMmcFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860830; c=relaxed/simple;
	bh=A+clKUiTVxNNWcs3kVwAtPbVCg55Ck1FzU4JTlveFn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaES3lhg7Pr60/0u+pHO4NaeMbYk3HSzZuJWww60ANvdOKniimnx0HEHZigzgdIowcFKOUTM02AGgPkVYkTX5tO7Rh7NhIYAc3xmj5//SN1CUSk0YYh3T7nKrbd2BryRRuyRTMCrsGzC83cv0mzyD6ewagYeWceb9ouDEMf9b1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3rcZCy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CAAC4CEDD;
	Thu, 13 Mar 2025 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741860830;
	bh=A+clKUiTVxNNWcs3kVwAtPbVCg55Ck1FzU4JTlveFn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3rcZCy5N59e0R0p3kmXrI4StRKYfepVSAaQEyVMFKsYuOJmmS15990JRbrNyqJj+
	 GlWs9Dv2sSaTgjpy/4sJbcztYJQiO6H+zB9XMGYm2xeUwPRofUyU5aNdDTWkv3CNUV
	 b+XqZeV5FRnSsStFr6CKhV0zfekycDRcF6KJrvq5KUwMjHYCvGdrKmlL9RKAOkLIXy
	 JEq5NRQEd0UewIIgnKhCc1SZA2DlCxZYmlEbDRKI+LQl/13gj0132lCiYYpn1p2In/
	 R1uLpRVtnL7X3c47yRK6z3y0ArWM/bmbk1Zw+1tDUz70yulv07Grnk3ZOPuUwje4u5
	 frkKzZDcIXIIQ==
Date: Thu, 13 Mar 2025 11:13:45 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
Subject: Re: [PATCH] udf: Fix inode_getblk() return value
Message-ID: <zh6ygcz237c23e7w47glfckqioyaeu62shroy6p5mlaxnp25rd@xyrcogmtwmth>
References: <kTCh8T9LAi-c_EZZeR5n35O79mJYo1igl-bR8kBN0MQn6vWW8i_XSuO3dDDVuHo7ggqWLk4lZOAIAzf4T57-Zg==@protonmail.internalid>
 <20250312163846.22851-2-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312163846.22851-2-jack@suse.cz>

On Wed, Mar 12, 2025 at 05:38:47PM +0100, Jan Kara wrote:
> Smatch noticed that inode_getblk() can return 1 on successful mapping of
> a block instead of expected 0 after commit b405c1e58b73 ("udf: refactor
> udf_next_aext() to handle error"). This could confuse some of the
> callers and lead to strange failures (although the one reported by
> Smatch in udf_mkdir() is impossible to trigger in practice). Fix the
> return value of inode_getblk().
> 
> Link: https://lore.kernel.org/all/cb514af7-bbe0-435b-934f-dd1d7a16d2cd@stanley.mountain
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Fixes: b405c1e58b73 ("udf: refactor udf_next_aext() to handle error")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/udf/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> I plan to merge this patch through my tree.
> 
> diff --git a/fs/udf/inode.c b/fs/udf/inode.c
> index 70c907fe8af9..4386dd845e40 100644
> --- a/fs/udf/inode.c
> +++ b/fs/udf/inode.c
> @@ -810,6 +810,7 @@ static int inode_getblk(struct inode *inode, struct udf_map_rq *map)
>  		}
>  		map->oflags = UDF_BLK_MAPPED;
>  		map->pblk = udf_get_lb_pblock(inode->i_sb, &eloc, offset);
> +		ret = 0;
>  		goto out_free;
>  	}
> 

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> --
> 2.43.0
> 
> 

