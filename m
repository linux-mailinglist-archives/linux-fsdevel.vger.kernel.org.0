Return-Path: <linux-fsdevel+bounces-63-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 752507C54F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1D721C20F90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096EF1F5E3;
	Wed, 11 Oct 2023 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRAi+5Mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309C71F195
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 13:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDF0C433C8;
	Wed, 11 Oct 2023 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697029780;
	bh=KxOJWQx0gCXD+pvd94GVAroIZnfAUS0u3K1gpuBGf6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aRAi+5McYCClvfpkyuLVNSRKObTbg5YMEbrvQb/UgBgTLvPbVNBb6+AOfyZHAgEk2
	 YbG3EkDYiO+3E0fJpfAGKfP9Vgs+Q3kSfIO3PNipLfGn7iiH1TSCAE2QD16f2uYtgX
	 dwe2+ItGt/iKUP5+rxK5WOIJ+br55O6zAvW0z9id4qSDKfes+LylDqmUOY4UB5FK4w
	 hgAtuWaUwtv4nHJ8/HYhA0R5LuodFiVSDJkf7B+YEQF6NRDPm1m/0n01Pb93QEKCH6
	 plXcvPfw8jvC0o+IFYcXU9l445hjfrTcMFEfP7UpMt7m4MQQHmIicj/eHzUfAIyC41
	 aHb2RdWpamXkg==
Message-ID: <b4136500fe6c49ee689dba139ce25824684719f2.camel@kernel.org>
Subject: Re: [PATCH] xfs: reinstate the old i_version counter as
 STATX_CHANGE_COOKIE
From: Jeff Layton <jlayton@kernel.org>
To: Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
	 <djwong@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org
Date: Wed, 11 Oct 2023 09:09:38 -0400
In-Reply-To: <20230929-xfs-iversion-v1-1-38587d7b5a52@kernel.org>
References: <20230929-xfs-iversion-v1-1-38587d7b5a52@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.module_f38+17164+63eeee4a) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-09-29 at 14:43 -0400, Jeff Layton wrote:
> The handling of STATX_CHANGE_COOKIE was moved into generic_fillattr in
> commit 0d72b92883c6 (fs: pass the request_mask to generic_fillattr), but
> we didn't account for the fact that xfs doesn't call generic_fillattr at
> all.
>=20
> Make XFS report its i_version as the STATX_CHANGE_COOKIE.
>=20
> Fixes: 0d72b92883c6 (fs: pass the request_mask to generic_fillattr)
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I had hoped to fix this in a better way with the multigrain patches, but
> it's taking longer than expected (if it even pans out at this point).
>=20
> Until then, make sure we use XFS's i_version as the STATX_CHANGE_COOKIE,
> even if it's bumped due to atime updates. Too many invalidations is
> preferable to not enough.
> ---
>  fs/xfs/xfs_iops.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index 1c1e6171209d..2b3b05c28e9e 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -584,6 +584,11 @@ xfs_vn_getattr(
>  		}
>  	}
> =20
> +	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
> +		stat->change_cookie =3D inode_query_iversion(inode);
> +		stat->result_mask |=3D STATX_CHANGE_COOKIE;
> +	}
> +
>  	/*
>  	 * Note: If you add another clause to set an attribute flag, please
>  	 * update attributes_mask below.
>=20
> ---
> base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
> change-id: 20230929-xfs-iversion-819fa2c18591
>=20
> Best regards,

Ping?

This patch is needed in v6.6 to prevent a regression when serving XFS
via NFSD. I'd prefer this go in via the xfs tree, but let me know if
you need me to get this merged this via a different one.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>

