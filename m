Return-Path: <linux-fsdevel+bounces-14-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272FC7C4703
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F144281E97
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 01:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2220EC;
	Wed, 11 Oct 2023 01:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA9OQtk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5228819;
	Wed, 11 Oct 2023 01:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1031BC433C8;
	Wed, 11 Oct 2023 01:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696986402;
	bh=eujIaVOehxQ1dXg6O0sAaTVgdZDN63IOo6uS8dtM4q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kA9OQtk8UpuuO/qThJxCdgUTtALHX+nLeNmxA+Loj3+uBJ945Z5aLmf3PjXcK69M0
	 mOFNEAtgk+VbmgQiGLDa6NzT2f+TjNnh4HIRnSBWWgtnnfztrTikuitx9+AtPihYFT
	 2zWe9v4tjn60ImXaNPCGWRHHmWOyafIYRd1pVqZydJ+fEeZZg9knU/X0P+1xKorEg8
	 7zZOXA9WCPQxMOLDoiBQI5JpiyAoJJ2RKpOkqz9LokHVueviw+F+TOwc1qoiPlqShU
	 ocSgxXUqH/oucJ4iLY1MCYifQVM7ydjfU1+ITw92J3HIP3KVTwB6xAyTXnXD9Srgkr
	 8fQ88kun/19hw==
Date: Tue, 10 Oct 2023 18:06:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, ebiggers@kernel.org, david@fromorbit.com,
	dchinner@redhat.com
Subject: Re: [PATCH v3 26/28] xfs: make scrub aware of verity dinode flag
Message-ID: <20231011010641.GI21298@frogsfrogsfrogs>
References: <20231006184922.252188-1-aalbersh@redhat.com>
 <20231006184922.252188-27-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006184922.252188-27-aalbersh@redhat.com>

On Fri, Oct 06, 2023 at 08:49:20PM +0200, Andrey Albershteyn wrote:
> fs-verity adds new inode flag which causes scrub to fail as it is
> not yet known.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/scrub/attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
> index f35144704395..b4f0ba45a092 100644
> --- a/fs/xfs/scrub/attr.c
> +++ b/fs/xfs/scrub/attr.c
> @@ -494,7 +494,7 @@ xchk_xattr_rec(
>  	/* Retrieve the entry and check it. */
>  	hash = be32_to_cpu(ent->hashval);
>  	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
> -			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
> +			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);
>  	if ((ent->flags & badflags) != 0)
>  		xchk_da_set_corrupt(ds, level);
>  	if (ent->flags & XFS_ATTR_LOCAL) {
> -- 
> 2.40.1
> 

