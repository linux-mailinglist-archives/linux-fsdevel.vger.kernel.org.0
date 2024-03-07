Return-Path: <linux-fsdevel+bounces-13944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C100D875A22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27141C21817
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3213E7E7;
	Thu,  7 Mar 2024 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZAbUCfK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B712D744;
	Thu,  7 Mar 2024 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709849890; cv=none; b=LQWun84H4U1ZclW2YSB1ba89R1a1N/BwBrxrKY7gHEL8ycUGZ2vOlj5Annwm0AczVQW44/nxB/pNvE7sfPPFarIP2KjDEYlkKY70I2wLKTp3yBGCmccbu6ms9a1PH0Le62+sSkymOn0a9jXWVz88EZb4t+k6kCCw2YCvb4Mm1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709849890; c=relaxed/simple;
	bh=GcuuhZu1ymPzyWsf/5caOZwYzqBN3Z/gNWxCxJK0fig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pyg2Wz2Rbl4s+QitSA1NjSqQyqfQJim7ei6qaov+HdOfM6ze/qQmv/xrq0VjOEzCMMaIsIXIQL3ERyb6BD52l3oUdRx7lrVuWXa7JGHEo+RFfShT03ob8KGh3fdv32JzdYTqrjl3jf3JmgD77Yu0oUWxL7OJuf7xZItScyiNZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZAbUCfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF79C43390;
	Thu,  7 Mar 2024 22:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709849889;
	bh=GcuuhZu1ymPzyWsf/5caOZwYzqBN3Z/gNWxCxJK0fig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZAbUCfKsCwAA0bcU7diULuPcDCElTBmGR6oEqwqdInykkokCLqQ6fLWpZ4yAEic5
	 Gji26D7oC9uRb2Vyybye16RM8iDiX7r1yIhVsakEI1uoua4WtAe4Om1FK+RpTrareS
	 MSdiiRB3oQH/5GvzKGY43jpYVGADzaf8vc6f3mogCriJpufWiMF+iZXFVyXJbYnFKF
	 wsJlhkY6JVeqePyu2Og+VHNOWNaOkmNwGxDIC0wPacQngFpGDOceKXqS1sWgStns6l
	 oKGutW7wRRmdQptXalrMh+uFMzr3DPfDSREiD3YpP5XxgotLlsgEfk2OLK4alz0IDb
	 5fqz/42EzM+tQ==
Date: Thu, 7 Mar 2024 14:18:09 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 22/24] xfs: make scrub aware of verity dinode flag
Message-ID: <20240307221809.GA1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-24-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-24-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:45PM +0100, Andrey Albershteyn wrote:
> fs-verity adds new inode flag which causes scrub to fail as it is
> not yet known.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/scrub/attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
> index 9a1f59f7b5a4..ae4227cb55ec 100644
> --- a/fs/xfs/scrub/attr.c
> +++ b/fs/xfs/scrub/attr.c
> @@ -494,7 +494,7 @@ xchk_xattr_rec(
>  	/* Retrieve the entry and check it. */
>  	hash = be32_to_cpu(ent->hashval);
>  	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
> -			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
> +			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);

Now that online repair can modify/discard/salvage broken xattr trees and
is pretty close to merging, how can I make it invalidate all the incore
merkle tree data after a repair?

--D

>  	if ((ent->flags & badflags) != 0)
>  		xchk_da_set_corrupt(ds, level);
>  	if (ent->flags & XFS_ATTR_LOCAL) {
> -- 
> 2.42.0
> 
> 

