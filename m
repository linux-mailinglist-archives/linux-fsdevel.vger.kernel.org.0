Return-Path: <linux-fsdevel+bounces-14756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D71787EF01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC471C222FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC835674C;
	Mon, 18 Mar 2024 17:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfhD0Bv/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960E57874
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783252; cv=none; b=QhKtWBVnKp5BLL7wUMrtu/M0nrp1zlXNmL2wxpGiir18O8UHUcxqvspR2stdEpqXaa/Q/FbVCLyPkW1RxXK1506EpyxIlsp+sviT5r7J3MdI8U6Q/9BZZ00riI6kAzZYhVgwNNxNOMHjs1WO7G4Trbg79U9Pz5DrRBYlFMpj5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783252; c=relaxed/simple;
	bh=UTbEDQuBPq0vcs45OgpExSveoxGH1wHzjv+GJN8St7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqGvRT0SlnLqAeUg3nPYqH4eRJtYMG3oU/SjFFo9b29ycpac/VfKpnvhr+ZkLv3lFgQCjUXD8XB4jA/ZRhFnIM9+7KsT8LTMuxiDF4HHPvCLOKvLS0LqA5Uvnnli4KXBQcDR/ZanlJY65SPYhWJsYkJEf0wgkw/of6uEZDmPJfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfhD0Bv/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710783249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1b336hcpmrVHHwLQeQ8dAMc9BcLym1+XVHhIRwOaNJE=;
	b=PfhD0Bv/1bKsVZvLJCzGNN4xaw6KZgZpxz99R4EXVMiL7c2CuCp/sfTVmQ7DoA7bcVmHvu
	OjL8DGLukKPBDvM6u/2osuZ8PoYBOgYvxPhsSLeF6U2JD6d7L07oHa7e9DOxj4cBcNp0mS
	quKs6gbMmdF0bq4lEnF5x20AIhDKt00=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-5fgtIZT3OD-5S639yIXbbg-1; Mon, 18 Mar 2024 13:34:07 -0400
X-MC-Unique: 5fgtIZT3OD-5S639yIXbbg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-514b4572d2bso813571e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 10:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783246; x=1711388046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b336hcpmrVHHwLQeQ8dAMc9BcLym1+XVHhIRwOaNJE=;
        b=qldT+Bk0lJpLcdSmDG/PwZE5WDXpNhRrD8ICTRU4Cbjgb76F+2CKpLntvJLhsF/O3p
         /LSoKAA3QU0oamqX95hWEi24zcp/G+yk6AKtoyomx3MDCN5vGqKtDjMusVogDBiXCnL6
         BoWlhbhYv/A/iuX9Nax5M+rC8a9yB28neZDqRzJgZDFlj6xE3TUD/pELhJWjz8EXt9FS
         pdoe9sVX49afrav0fDEGPUzT0/yWUDJ/IFjgVZYFlFVhQbmgu8wNKNU/Az8dEqwZrIK+
         b94HhW6bIDFqqYR47xgGGBQWCzsczvyCM+W/jupLaUnu7RSn4648vWy+GtadQu2YJ77s
         SHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWEea+HK3uKIpmUbT9Mg39V2BSBnG7tAECiNYc7wYGtcfF+g4NnVT5oUbHprPmzEYQjWxBLTt0w4ehVlypOhbQNr6B3VRQ8kRtIxgoWA==
X-Gm-Message-State: AOJu0Yy4//rXxI+SzDVOq+8pBT9P3Ft9ehNEuSNim2aqbf5Yo/auCPXa
	SZ6QOX49asnqOZLhOkS0jaMm3jOPxBv7BsaJGh2MwiwVboOiZw742qHaiGwsusCbbm1xLmdj4k3
	NSWqnk/4qcDq9Jd/iEyJMAk577C1ZxRlwpM4SCVr6F+6NoS0S8rA/x+N6vXXL4A==
X-Received: by 2002:a19:9146:0:b0:513:d3c2:f094 with SMTP id y6-20020a199146000000b00513d3c2f094mr8043634lfj.29.1710783245866;
        Mon, 18 Mar 2024 10:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzpiw4+mEtjtGD7WM2sm40ah3Ge0myoXaoUNKqmzufoploM8oU95BG7gPUFQDrqvtjqK7wRg==
X-Received: by 2002:a19:9146:0:b0:513:d3c2:f094 with SMTP id y6-20020a199146000000b00513d3c2f094mr8043627lfj.29.1710783245311;
        Mon, 18 Mar 2024 10:34:05 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id bh25-20020a05600c3d1900b0041461b04cd2sm456682wmb.3.2024.03.18.10.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:34:05 -0700 (PDT)
Date: Mon, 18 Mar 2024 18:34:04 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 35/40] xfs: teach online repair to evaluate fsverity
 xattrs
Message-ID: <cukuakjpyim572vkhcl24xxnkrgrmkkalkrnoglte735jmpm7m@epenfnca5a4s>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246470.2684506.16777519924436608697.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171069246470.2684506.16777519924436608697.stgit@frogsfrogsfrogs>

On 2024-03-17 09:32:31, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Teach online repair to check for unused fsverity metadata and purge it
> on reconstruction.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/xfs/scrub/attr.c   |  102 +++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/scrub/attr.h   |    4 ++
>  fs/xfs/scrub/common.c |   27 +++++++++++++
>  3 files changed, 133 insertions(+)
> 
> 
> diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
> index ae4227cb55ec..c69dee281984 100644
> --- a/fs/xfs/scrub/attr.c
> +++ b/fs/xfs/scrub/attr.c
> @@ -21,6 +21,8 @@
>  #include "scrub/dabtree.h"
>  #include "scrub/attr.h"
>  
> +#include <linux/fsverity.h>
> +
>  /* Free the buffers linked from the xattr buffer. */
>  static void
>  xchk_xattr_buf_cleanup(
> @@ -135,6 +137,91 @@ xchk_setup_xattr(
>  	return xchk_setup_inode_contents(sc, 0);
>  }
>  
> +#ifdef CONFIG_FS_VERITY
> +/* Extract merkle tree geometry from incore information. */
> +static int
> +xchk_xattr_extract_verity(
> +	struct xfs_scrub		*sc)
> +{
> +	struct xchk_xattr_buf		*ab = sc->buf;
> +
> +	/* setup should have allocated the buffer */
> +	if (!ab) {
> +		ASSERT(0);
> +		return -EFSCORRUPTED;
> +	}
> +
> +	return fsverity_merkle_tree_geometry(VFS_I(sc->ip),
> +			&ab->merkle_blocksize, &ab->merkle_tree_size);
> +}
> +
> +/* Check the merkle tree xattrs. */
> +STATIC void
> +xchk_xattr_verity(
> +	struct xfs_scrub		*sc,
> +	xfs_dablk_t			blkno,
> +	const unsigned char		*name,
> +	unsigned int			namelen,
> +	unsigned int			valuelen)
> +{
> +	struct xchk_xattr_buf		*ab = sc->buf;
> +
> +	/* Non-verity filesystems should never have verity xattrs. */
> +	if (!xfs_has_verity(sc->mp)) {
> +		xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> +		return;
> +	}
> +
> +	/*
> +	 * Any verity metadata on a non-verity file are leftovers from a
> +	 * previous attempt to enable verity.
> +	 */
> +	if (!IS_VERITY(VFS_I(sc->ip))) {
> +		xchk_ino_set_preen(sc, sc->ip->i_ino);
> +		return;
> +	}
> +
> +	switch (namelen) {
> +	case sizeof(struct xfs_verity_merkle_key):
> +		/* Oversized blocks are not allowed */
> +		if (valuelen > ab->merkle_blocksize) {
> +			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> +			return;
> +		}
> +		break;
> +	case XFS_VERITY_DESCRIPTOR_NAME_LEN:
> +		/* Has to match the descriptor xattr name */
> +		if (memcmp(name, XFS_VERITY_DESCRIPTOR_NAME, namelen)) {
> +			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> +		}
> +		return;
> +	default:
> +		xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> +		return;
> +	}
> +
> +	/*
> +	 * Merkle tree blocks beyond the end of the tree are leftovers from
> +	 * a previous failed attempt to enable verity.
> +	 */
> +	if (xfs_verity_merkle_key_from_disk(name) >= ab->merkle_tree_size)
> +		xchk_ino_set_preen(sc, sc->ip->i_ino);
> +}
> +#else
> +# define xchk_xattr_extract_verity(sc)	(0)
> +
> +static void
> +xchk_xattr_verity(
> +	struct xfs_scrub	*sc,
> +	xfs_dablk_t		blkno,
> +	const unsigned char	*name,
> +	unsigned int		namelen)
> +{
> +	/* Should never see verity xattrs when verity is not enabled. */
> +	xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> +}
> +#endif /* CONFIG_FS_VERITY */
> +
>  /* Extended Attributes */
>  
>  struct xchk_xattr {
> @@ -194,6 +281,15 @@ xchk_xattr_listent(
>  		goto fail_xref;
>  	}
>  
> +	/* Check verity xattr geometry */
> +	if (flags & XFS_ATTR_VERITY) {
> +		xchk_xattr_verity(sx->sc, args.blkno, name, namelen, valuelen);
> +		if (sx->sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT) {
> +			context->seen_enough = 1;
> +			return;
> +		}
> +	}
> +
>  	/* Does this name make sense? */
>  	if (!xfs_attr_namecheck(sx->sc->mp, name, namelen, flags)) {
>  		xchk_fblock_set_corrupt(sx->sc, XFS_ATTR_FORK, args.blkno);

Would it be better to check verity after xfs_attr_namecheck()?
Invalid name seems to be a more basic corruption.

-- 
- Andrey


