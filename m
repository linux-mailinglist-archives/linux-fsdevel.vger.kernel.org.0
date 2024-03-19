Return-Path: <linux-fsdevel+bounces-14841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B45B38806B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D731F22D09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC52E3FE2A;
	Tue, 19 Mar 2024 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu7jDJWe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED44C626;
	Tue, 19 Mar 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883668; cv=none; b=fjUVQLS05Zg387ug6X581ZXTiCI68U1xtfdPFYtmO/PRGrn4AgUQHSdjNxb3cHxnWJxx5b0356kOxxM4OXHnEAt0x9kCpQkx0gpVcvg1v0tGxTUPdG6zybI/CnQjcyl2fIBZLRE2iyY4IYzbEIZNgub2V0FIOLnxqaRj9rJng5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883668; c=relaxed/simple;
	bh=RP/J70y68fnM4pHqRlu6CZfv3mzhT++eZbG/WWasYPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbXaO0ZhsiBw3Gx2AAttjBgk787SHbg+vuS8jEOoi53DPFy9hphpl3tZmXzMgzRH0LWKbq3SNMJD3AEcNwM9Fr7AF4NxZSd/ceGtOGAEaZDmG5iSNeDWkCQn7q+zGR1Kst/Sfn524rzZRMuO94jqg3qO9uHd8SfqZXGSwDZh4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu7jDJWe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4C6C433C7;
	Tue, 19 Mar 2024 21:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710883667;
	bh=RP/J70y68fnM4pHqRlu6CZfv3mzhT++eZbG/WWasYPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yu7jDJWeWEixfG2aJWu+RXnIeE5EDFF3nlfdL1o3n+fe6AbG+BehP5f1Qc15mxYGs
	 PBMeqOkAINzfEwguujJjf8Q6SWVw7DKrTXT8Trvw2fdJAvOp8856H4eacfWX/XzRhT
	 fZYF60lo5wBic85woKEP0URs3tCwtEQtJtSuj0d5O7oRwD+qvmk0IxpgPmw5XuOEyi
	 54KyxoJwgGlw1s8p6UDLK96Efj0zIAh7B1gy5ShNf57jnJLUC4h5UMNYmnEMvzqC1H
	 61H7yqXZEHUQtaEwBMHh4BPz9qpwZ7iE6f7o2MdvQjOvQ2I0dCtAG1J3WziBTTonGf
	 V+0Ha5peFz6Og==
Date: Tue, 19 Mar 2024 14:27:46 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 35/40] xfs: teach online repair to evaluate fsverity
 xattrs
Message-ID: <20240319212746.GP1927156@frogsfrogsfrogs>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246470.2684506.16777519924436608697.stgit@frogsfrogsfrogs>
 <cukuakjpyim572vkhcl24xxnkrgrmkkalkrnoglte735jmpm7m@epenfnca5a4s>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cukuakjpyim572vkhcl24xxnkrgrmkkalkrnoglte735jmpm7m@epenfnca5a4s>

On Mon, Mar 18, 2024 at 06:34:04PM +0100, Andrey Albershteyn wrote:
> On 2024-03-17 09:32:31, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Teach online repair to check for unused fsverity metadata and purge it
> > on reconstruction.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/xfs/scrub/attr.c   |  102 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/xfs/scrub/attr.h   |    4 ++
> >  fs/xfs/scrub/common.c |   27 +++++++++++++
> >  3 files changed, 133 insertions(+)
> > 
> > 
> > diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
> > index ae4227cb55ec..c69dee281984 100644
> > --- a/fs/xfs/scrub/attr.c
> > +++ b/fs/xfs/scrub/attr.c
> > @@ -21,6 +21,8 @@
> >  #include "scrub/dabtree.h"
> >  #include "scrub/attr.h"
> >  
> > +#include <linux/fsverity.h>
> > +
> >  /* Free the buffers linked from the xattr buffer. */
> >  static void
> >  xchk_xattr_buf_cleanup(
> > @@ -135,6 +137,91 @@ xchk_setup_xattr(
> >  	return xchk_setup_inode_contents(sc, 0);
> >  }
> >  
> > +#ifdef CONFIG_FS_VERITY
> > +/* Extract merkle tree geometry from incore information. */
> > +static int
> > +xchk_xattr_extract_verity(
> > +	struct xfs_scrub		*sc)
> > +{
> > +	struct xchk_xattr_buf		*ab = sc->buf;
> > +
> > +	/* setup should have allocated the buffer */
> > +	if (!ab) {
> > +		ASSERT(0);
> > +		return -EFSCORRUPTED;
> > +	}
> > +
> > +	return fsverity_merkle_tree_geometry(VFS_I(sc->ip),
> > +			&ab->merkle_blocksize, &ab->merkle_tree_size);
> > +}
> > +
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
> > +	switch (namelen) {
> > +	case sizeof(struct xfs_verity_merkle_key):
> > +		/* Oversized blocks are not allowed */
> > +		if (valuelen > ab->merkle_blocksize) {
> > +			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> > +			return;
> > +		}
> > +		break;
> > +	case XFS_VERITY_DESCRIPTOR_NAME_LEN:
> > +		/* Has to match the descriptor xattr name */
> > +		if (memcmp(name, XFS_VERITY_DESCRIPTOR_NAME, namelen)) {
> > +			xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> > +		}
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
> > +	if (xfs_verity_merkle_key_from_disk(name) >= ab->merkle_tree_size)
> > +		xchk_ino_set_preen(sc, sc->ip->i_ino);
> > +}
> > +#else
> > +# define xchk_xattr_extract_verity(sc)	(0)
> > +
> > +static void
> > +xchk_xattr_verity(
> > +	struct xfs_scrub	*sc,
> > +	xfs_dablk_t		blkno,
> > +	const unsigned char	*name,
> > +	unsigned int		namelen)
> > +{
> > +	/* Should never see verity xattrs when verity is not enabled. */
> > +	xchk_fblock_set_corrupt(sc, XFS_ATTR_FORK, blkno);
> > +}
> > +#endif /* CONFIG_FS_VERITY */
> > +
> >  /* Extended Attributes */
> >  
> >  struct xchk_xattr {
> > @@ -194,6 +281,15 @@ xchk_xattr_listent(
> >  		goto fail_xref;
> >  	}
> >  
> > +	/* Check verity xattr geometry */
> > +	if (flags & XFS_ATTR_VERITY) {
> > +		xchk_xattr_verity(sx->sc, args.blkno, name, namelen, valuelen);
> > +		if (sx->sc->sm->sm_flags & XFS_SCRUB_OFLAG_CORRUPT) {
> > +			context->seen_enough = 1;
> > +			return;
> > +		}
> > +	}
> > +
> >  	/* Does this name make sense? */
> >  	if (!xfs_attr_namecheck(sx->sc->mp, name, namelen, flags)) {
> >  		xchk_fblock_set_corrupt(sx->sc, XFS_ATTR_FORK, args.blkno);
> 
> Would it be better to check verity after xfs_attr_namecheck()?
> Invalid name seems to be a more basic corruption.

Yeah, that could be changed easily. Done.

--D

> -- 
> - Andrey
> 
> 

