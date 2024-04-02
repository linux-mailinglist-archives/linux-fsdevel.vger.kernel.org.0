Return-Path: <linux-fsdevel+bounces-15908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B6A8959E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 18:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D0A1C221B5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C40C159905;
	Tue,  2 Apr 2024 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzGxVYLR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9DC2AD1E;
	Tue,  2 Apr 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076178; cv=none; b=XthXvh4VRv99nOOQXKRVGNnv/3IAyZLFyWkdYuVP7TaxFZfjY7WCGierHbEKeRdr5Yrb5FscU/zgaY2TW4k5MXLKJPN4hx0LcklNAtyk/3B6PyaG0WLGp/V/HAYU/WfD0asO7qEsVnQPOmrfBmQsdp3ngUIvh9UfSTXOKv7rsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076178; c=relaxed/simple;
	bh=/d3zSsXkNJX6aXckhnlKmdQDD3L27N5hbTj+Z9KlRWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmI/f5608Vc/8rok6EXLmgnXJycrP8tTOds94ztlt/ey0Xj1BD9JlX6Rj8qt9AJp98ZR3t/9DNe+Cm3WPiJ5UJQh9AxwIwPOdtGGoMdPxKcMpnPNk46STGqGL2vJ+o9zW5LJagIIQLF+ycj0mTHXSlimHIAE4OqpsBw9biJtRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzGxVYLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A15BC43390;
	Tue,  2 Apr 2024 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712076178;
	bh=/d3zSsXkNJX6aXckhnlKmdQDD3L27N5hbTj+Z9KlRWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzGxVYLRyx4dPUPA1Up6iRluu45tip5WTJKJ2OpEIPK/AjsIjjjpUadCd+67ZRK31
	 oE9KGJutaW5T0dDKfpJbh1kOtucLRC2DihRGCH4JOYOwVaVuy94nH4pQNLakyNRS5R
	 El1QuTypwrwqJoAOThvNbdhoJU5a8A6iSyPNb05b5YArTThDaQQQPWuEnq5qeaP05S
	 TJ3fMq8M/4VIWX2hgM8OqYE9FnVFBHx9yYMspjZYzdYIVlz372kMuJ7lTsb2TCpU3O
	 p2gKGlqGUmfOfr7dNL+ta2dqB10Km1/KiwWaI67mMGEyO7m0+uBmjMPQPy061jOnt5
	 TVxD5NLw0KJqg==
Date: Tue, 2 Apr 2024 09:42:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 24/29] xfs: teach online repair to evaluate fsverity
 xattrs
Message-ID: <20240402164257.GC6390@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868956.1988170.10162640337320302727.stgit@frogsfrogsfrogs>
 <6fd77dqwbfmbaqwqori6jffpg2czfe23qmqrvzducti33a4vvi@7lut4a6qhsmt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fd77dqwbfmbaqwqori6jffpg2czfe23qmqrvzducti33a4vvi@7lut4a6qhsmt>

On Tue, Apr 02, 2024 at 05:42:04PM +0200, Andrey Albershteyn wrote:
> On 2024-03-29 17:42:19, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Teach online repair to check for unused fsverity metadata and purge it
> > on reconstruction.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/xfs/scrub/attr.c        |  139 ++++++++++++++++++++++++++++++++++++++++++++
> >  fs/xfs/scrub/attr.h        |    6 ++
> >  fs/xfs/scrub/attr_repair.c |   50 ++++++++++++++++
> >  fs/xfs/scrub/trace.c       |    1 
> >  fs/xfs/scrub/trace.h       |   31 ++++++++++
> >  5 files changed, 226 insertions(+), 1 deletion(-)
> > 
> > 
> > diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
> > index 2e8a2b2e82fbd..be121625c14f0 100644
> > --- a/fs/xfs/scrub/attr.c
> > +++ b/fs/xfs/scrub/attr.c
> > @@ -18,6 +18,7 @@
> >  #include "xfs_attr_leaf.h"
> >  #include "xfs_attr_sf.h"
> >  #include "xfs_parent.h"
> > +#include "xfs_verity.h"
> >  #include "scrub/scrub.h"
> >  #include "scrub/common.h"
> >  #include "scrub/dabtree.h"
> > @@ -25,6 +26,8 @@
> >  #include "scrub/listxattr.h"
> >  #include "scrub/repair.h"
> >  
> > +#include <linux/fsverity.h>
> > +
> >  /* Free the buffers linked from the xattr buffer. */
> >  static void
> >  xchk_xattr_buf_cleanup(
> > @@ -126,6 +129,53 @@ xchk_setup_xattr_buf(
> >  	return 0;
> >  }
> >  
> > +#ifdef CONFIG_FS_VERITY
> > +/*
> > + * Obtain merkle tree geometry information for a verity file so that we can
> > + * perform sanity checks of the fsverity xattrs.
> > + */
> > +STATIC int
> > +xchk_xattr_setup_verity(
> > +	struct xfs_scrub	*sc)
> > +{
> > +	struct xchk_xattr_buf	*ab;
> > +	int			error;
> > +
> > +	/*
> > +	 * Drop the ILOCK and the transaction because loading the fsverity
> > +	 * metadata will call into the xattr code.  S_VERITY is enabled with
> > +	 * IOLOCK_EXCL held, so it should not change here.
> > +	 */
> > +	xchk_iunlock(sc, XFS_ILOCK_EXCL);
> > +	xchk_trans_cancel(sc);
> > +
> > +	error = xchk_setup_xattr_buf(sc, 0);
> > +	if (error)
> > +		return error;
> > +
> > +	ab = sc->buf;
> > +	error = fsverity_merkle_tree_geometry(VFS_I(sc->ip),
> > +			&ab->merkle_blocksize, &ab->merkle_tree_size);
> > +	if (error == -ENODATA || error == -EFSCORRUPTED) {
> > +		/* fsverity metadata corrupt, cannot complete checks */
> > +		xchk_set_incomplete(sc);
> > +		ab->merkle_blocksize = 0;
> > +		error = 0;
> > +	}
> > +	if (error)
> > +		return error;
> > +
> > +	error = xchk_trans_alloc(sc, 0);
> > +	if (error)
> > +		return error;
> > +
> > +	xchk_ilock(sc, XFS_ILOCK_EXCL);
> > +	return 0;
> > +}
> > +#else
> > +# define xchk_xattr_setup_verity(...)	(0)
> > +#endif /* CONFIG_FS_VERITY */
> > +
> >  /* Set us up to scrub an inode's extended attributes. */
> >  int
> >  xchk_setup_xattr(
> > @@ -150,9 +200,89 @@ xchk_setup_xattr(
> >  			return error;
> >  	}
> >  
> > -	return xchk_setup_inode_contents(sc, 0);
> > +	error = xchk_setup_inode_contents(sc, 0);
> > +	if (error)
> > +		return error;
> > +
> > +	if (IS_VERITY(VFS_I(sc->ip))) {
> > +		error = xchk_xattr_setup_verity(sc);
> > +		if (error)
> > +			return error;
> > +	}
> > +
> > +	return error;
> >  }
> >  
> > +#ifdef CONFIG_FS_VERITY
> > +/* Check the merkle tree xattrs. */
> > +STATIC void
> > +xchk_xattr_verity(
> > +	struct xfs_scrub		*sc,
> > +	xfs_dablk_t			blkno,
> > +	const unsigned char		*name,
> > +	unsigned int			namelen,
> > +	unsigned int			valuelen)
> > +{
> > +	struct xchk_xattr_buf		*ab = sc->buf;
> > +
> > +	/* Non-verity filesystems should never have verity xattrs. */
> > +	if (!xfs_has_verity(sc->mp)) {
> > +		xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Any verity metadata on a non-verity file are leftovers from a
> > +	 * previous attempt to enable verity.
> > +	 */
> > +	if (!IS_VERITY(VFS_I(sc->ip))) {
> > +		xchk_ino_set_preen(sc, sc->ip->i_ino);
> > +		return;
> > +	}
> > +
> > +	/* Zero blocksize occurs if we couldn't load the merkle tree data. */
> > +	if (ab->merkle_blocksize == 0)
> > +		return;
> > +
> > +	switch (namelen) {
> > +	case sizeof(struct xfs_merkle_key):
> > +		/* Oversized blocks are not allowed */
> > +		if (valuelen > ab->merkle_blocksize) {
> > +			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> > +			return;
> > +		}
> > +		break;
> > +	case XFS_VERITY_DESCRIPTOR_NAME_LEN:
> > +		/* Has to match the descriptor xattr name */
> > +		if (memcmp(name, XFS_VERITY_DESCRIPTOR_NAME, namelen))
> > +			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> > +		return;
> > +	default:
> > +		xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Merkle tree blocks beyond the end of the tree are leftovers from
> > +	 * a previous failed attempt to enable verity.
> > +	 */
> > +	if (xfs_merkle_key_from_disk(name, namelen) >= ab->merkle_tree_size)
> > +		xchk_ino_set_preen(sc, sc->ip->i_ino);
> 
> The other case which probably can be detected is if we start
> removing the tree and it gets interrupted (starting blocks missing).
> This can be checked by iterating over the xattrs names up to
> ->merkle_tree_size. But I'm not sure if online repair can store
> state over xattrs validation.

It can; you'd just have to amend the xchk_xattr_buf to store whatever
extra data you want.  That said, if IS_VERITY() isn't true, then we'll
flag the xattr structure for any XFS_ATTR_VERITY attrs:

	/*
	 * Any verity metadata on a non-verity file are leftovers from a
	 * previous attempt to enable verity.
	 */
	if (!IS_VERITY(VFS_I(sc->ip))) {
		xchk_ino_set_preen(sc, sc->ip->i_ino);
		return;
	}

And attr_repair.c will not salvage the attrs when it reconstructs the
attr structure.

> Also, only pair of valid descriptor and valid tree is something of
> use, but I'm not sure if all of this is in scope of online repair.

Not here -- the xfsprogs verity patchset amends xfs_scrub phase 6 to
look for verity files so that it can open them and read the contents to
see if any IO errors occur.  That will catch missing/inconsistent bits
in the fsverity metadata.

> Otherwise, looks good to me:
> Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

Thanks!

--D

> -- 
> - Andrey
> 
> 

