Return-Path: <linux-fsdevel+bounces-73781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78336D20408
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6715A300AFF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D8C3A4ADB;
	Wed, 14 Jan 2026 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiAikgwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215F33A0B39;
	Wed, 14 Jan 2026 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408823; cv=none; b=nbW2Mfg+BA2Alfah8RFQVNfj39KUYPw6gS9ipBNw/bVF6ZTDzPHGQCXlIIsZR6kOrR16Jnf+YXUgcFhqnE1rAwmdvPYaCKz3DE17V1VHr4KCScY5ly0hZoC4O5wWVo5HwE81/ADaYeFjmPuJuCrKmm9ME9SG/0c9Yvd33ZnI8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408823; c=relaxed/simple;
	bh=g7aSUTkSWauEg+kHQP+jGmiu2e/5RuAifgYpiz6ah+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqcK2Mt1ptgry9me8bslQHZ8HxOYbncCVhdX/lzQNrzVRnV1haODTPA98o0b8FIgxFb93KawECDXVsNBpIYwEyBXvehLrXTHENLT48uDJLlXY7987MnGIQp7BN/Gi+ST0TH5tEDlUpmttySMjk3Vl/orAqskfuAdTTl4xbiTKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiAikgwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A5BC4CEF7;
	Wed, 14 Jan 2026 16:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768408822;
	bh=g7aSUTkSWauEg+kHQP+jGmiu2e/5RuAifgYpiz6ah+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SiAikgwXNU6OXomd8zt5FAjo7WHx7tPLeeZrfL29ojvPAKeaABSSg9pZcJtes3XMY
	 S1nRq7o8zKosia4SlyfjUcg/KqICJYOaBm3c2nwLLE1KgB4w2SjaQ+jQJjuUdpl7qW
	 UXXlZONE3RP363rcxpC+k7ikvlvz9UVlf8vN4u2g2ZPTzYsj6sEuUJ2g+zdX4ckE09
	 7L9Gso8Ro03Ig7qw9guw/yCRyiOYfQy4OeQ33fFrD3jRsWplx2+9sSnCcHrvWxG9Hl
	 PjRVJ+5/m19wmgfLKSVfMq/rPodmslMYcWHSeObnzbflhUNCKawviuortMm6/b5sJp
	 Xz4HV3lCPjJzw==
Date: Wed, 14 Jan 2026 08:40:22 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 16/22] xfs: add fs-verity support
Message-ID: <20260114164022.GN15583@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <p4vwqbgks2zr5i4f4d2t2i3gs2l4tnsmi2eijay5jba5y4kx6e@g3k4uk4ia4es>
 <20260112230548.GR15551@frogsfrogsfrogs>
 <vtkbi6fc2hhacxj5rmxqfxiawg5iqabsoxmxosm3oawqtqrbv5@vniylcxwzkcv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vtkbi6fc2hhacxj5rmxqfxiawg5iqabsoxmxosm3oawqtqrbv5@vniylcxwzkcv>

On Tue, Jan 13, 2026 at 07:32:06PM +0100, Andrey Albershteyn wrote:
> On 2026-01-12 15:05:48, Darrick J. Wong wrote:
> > On Mon, Jan 12, 2026 at 03:51:43PM +0100, Andrey Albershteyn wrote:
> > > Add integration with fs-verity. XFS stores fs-verity descriptor and
> > > Merkle tree in the inode data fork at offset file offset (1 << 53).
> > > 
> > > The Merkle tree reading/writing is done through iomap interface. The
> > > data itself are read to the inode's page cache. When XFS reads from this
> > > region iomap doesn't call into fsverity to verify it against Merkle
> > > tree. For data, verification is done on BIO completion in a workqueue.
> > > 
> > > When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> > > flag is set meaning that the Merkle tree is being build. The
> > > initialization ends with storing of verity descriptor and setting
> > > inode on-disk flag (XFS_DIFLAG2_VERITY).

<snip some of this stuff>

> > > +/*
> > > + * Try to remove all the fsverity metadata after a failed enablement.
> > > + */
> > > +static int
> > > +xfs_fsverity_delete_metadata(
> > > +	struct xfs_inode	*ip)
> > > +{
> > > +	struct xfs_trans	*tp;
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +	int			error;
> > > +
> > > +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> > 
> > The MMAPLOCK should be taken before the transaction allocation like
> > everything else in xfs.
> 
> hmm, but is it needed for transaction? I meant to only wrap
> xfs_truncate_page() with mmaplock

The MMAPLOCK isn't needed to run the transaction, but the normal
resource acquisition order is:

i_rwsem (IOLOCK) -> mmap_invalidatelock (MMAPLOCK) -> log grant space
(aka xfs_trans_reserve) -> ILOCK.

By taking the MMAPLOCK after log space has been granted, you're now
risking an ABBA deadlock because another thread could hold the same
MMAPLOCK and is waiting for a log grant while the current thread took
the last of the log grant space and is now waiting for the MMAPLOCK.

Why are we calling xfs_truncate_page on the EOF page?

Should we hold the MMAPLOCK during the entire merkle tree construction
process so that page_mkwrite is blocked?

Also, should page_mkwrite return an error if either S_VERITY or
XFS_VERITY_CONSTRUCTION are set on the inode?

--D

> > > +	error = xfs_truncate_page(ip, XFS_ISIZE(ip), NULL, NULL);
> > > +	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > > +
> > > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > > +	xfs_trans_ijoin(tp, ip, 0);
> > > +
> > > +	/*
> > > +	 * We removing post EOF data, no need to update i_size
> > > +	 */
> > > +	error = xfs_itruncate_extents(&tp, ip, XFS_DATA_FORK, XFS_ISIZE(ip));
> > > +	if (error)
> > > +		goto err_cancel;
> > > +
> > > +	error = xfs_trans_commit(tp);
> > > +	if (error)
> > > +		goto err_cancel;
> > > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > > +
> > > +	return error;
> > > +
> > > +err_cancel:
> > > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > > +	xfs_trans_cancel(tp);
> > > +	return error;
> > > +}
> > > +
> > > +
> > > +/*
> > > + * Prepare to enable fsverity by clearing old metadata.
> > > + */
> > > +static int
> > > +xfs_fsverity_begin_enable(
> > > +	struct file		*filp)
> > > +{
> > > +	struct inode		*inode = file_inode(filp);
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > +	int			error;
> > > +
> > > +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
> > > +
> > > +	if (IS_DAX(inode))
> > > +		return -EINVAL;
> > > +
> > > +	if (inode->i_size > XFS_FSVERITY_REGION_START)
> > > +		return -EFBIG;
> > > +
> > > +	if (xfs_iflags_test_and_set(ip, XFS_VERITY_CONSTRUCTION))
> > > +		return -EBUSY;
> > > +
> > > +	error = xfs_qm_dqattach(ip);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	/*
> > > +	 * Flush pagecache before building Merkle tree. Inode is locked and no
> > > +	 * further writes will happen to the file except fsverity metadata
> > 
> > Don't we need to take the MMAPLOCK to prevent concurrent write faults?
> 
> will add it
> 
> > 
> > > +	 */
> > > +	error = filemap_write_and_wait(inode->i_mapping);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	return xfs_fsverity_delete_metadata(ip);
> > > +}
> > > +
> > > +/*
> > > + * Complete (or fail) the process of enabling fsverity.
> > > + */
> > > +static int
> > > +xfs_fsverity_end_enable(
> > > +	struct file		*filp,
> > > +	const void		*desc,
> > > +	size_t			desc_size,
> > > +	u64			merkle_tree_size)
> > > +{
> > > +	struct inode		*inode = file_inode(filp);
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +	struct xfs_trans	*tp;
> > > +	int			error = 0;
> > > +
> > > +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
> > > +
> > > +	/* fs-verity failed, just cleanup */
> > > +	if (desc == NULL)
> > > +		goto out;
> > > +
> > > +	error = xfs_fsverity_write_descriptor(ip, desc, desc_size,
> > > +					      merkle_tree_size);
> > > +	if (error)
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * Wait for Merkle tree get written to disk before setting on-disk inode
> > > +	 * flag and clearing XFS_VERITY_CONSTRUCTION
> > > +	 */
> > > +	error = filemap_write_and_wait(inode->i_mapping);
> > > +	if (error)
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * Set fsverity inode flag
> > > +	 */
> > > +	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange,
> > > +			0, 0, false, &tp);
> > > +	if (error)
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * Ensure that we've persisted the verity information before we enable
> > > +	 * it on the inode and tell the caller we have sealed the inode.
> > > +	 */
> > > +	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
> > > +
> > > +	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> > > +	xfs_trans_set_sync(tp);
> > > +
> > > +	error = xfs_trans_commit(tp);
> > > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > > +
> > > +	if (!error)
> > > +		inode->i_flags |= S_VERITY;
> > > +
> > > +out:
> > > +	if (error) {
> > > +		int	error2;
> > > +
> > > +		error2 = xfs_fsverity_delete_metadata(ip);
> > > +		if (error2)
> > > +			xfs_alert(ip->i_mount,
> > > +"ino 0x%llx failed to clean up new fsverity metadata, err %d",
> > > +					ip->i_ino, error2);
> > > +	}
> > > +
> > > +	xfs_iflags_clear(ip, XFS_VERITY_CONSTRUCTION);
> > > +	return error;
> > > +}
> > > +
> > > +/*
> > > + * Retrieve a merkle tree block.
> > > + */
> > > +static struct page *
> > > +xfs_fsverity_read_merkle(
> > > +	struct inode		*inode,
> > > +	pgoff_t			index,
> > > +	unsigned long		num_ra_pages)
> > > +{
> > > +	struct folio            *folio;
> > > +	pgoff_t			offset =
> > > +			index | (XFS_FSVERITY_REGION_START >> PAGE_SHIFT);
> > > +
> > > +	folio = __filemap_get_folio(inode->i_mapping, offset, FGP_ACCESSED, 0);
> > > +	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> > > +		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, offset);
> > > +
> > > +		if (!IS_ERR(folio))
> > > +			folio_put(folio);
> > > +		else if (num_ra_pages > 1)
> > > +			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> > > +		folio = read_mapping_folio(inode->i_mapping, offset, NULL);
> > > +		if (IS_ERR(folio))
> > > +			return ERR_CAST(folio);
> > > +	}
> > > +	return folio_file_page(folio, offset);
> > 
> > Shouldn't this be some _BEYOND_EOF variant of generic_file_read_iter?
> 
> _BEYOND_EOF is set by xfs_iomap_read_begin() while mapping the
> blocks, and also this uses _unbounded version of readhead to skip
> EOF checks.
> 
> > 
> > > +}
> > > +
> > > +/*
> > > + * Write a merkle tree block.
> > > + */
> > > +static int
> > > +xfs_fsverity_write_merkle(
> > > +	struct inode		*inode,
> > > +	const void		*buf,
> > > +	u64			pos,
> > > +	unsigned int		size)
> > > +{
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > +	loff_t			position = pos | XFS_FSVERITY_REGION_START;
> > > +
> > > +	if (position + size > inode->i_sb->s_maxbytes)
> > > +		return -EFBIG;
> > > +
> > > +	return xfs_fsverity_write(ip, position, size, buf);
> > > +}
> > > +
> > > +const ptrdiff_t info_offs = (int)offsetof(struct xfs_inode, i_verity_info) -
> > > +			    (int)offsetof(struct xfs_inode, i_vnode);
> > 
> > I ... wow.
> > 
> > Not blaming you for writing this, just surprised that the common code
> > makes you do that.
> > 
> > > +const struct fsverity_operations xfs_fsverity_ops = {
> > > +	.inode_info_offs		= info_offs,
> > > +	.begin_enable_verity		= xfs_fsverity_begin_enable,
> > > +	.end_enable_verity		= xfs_fsverity_end_enable,
> > > +	.get_verity_descriptor		= xfs_fsverity_get_descriptor,
> > > +	.read_merkle_tree_page		= xfs_fsverity_read_merkle,
> > > +	.write_merkle_tree_block	= xfs_fsverity_write_merkle,
> > > +};
> > > diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
> > > new file mode 100644
> > > index 0000000000..8b0d7ef456
> > > --- /dev/null
> > > +++ b/fs/xfs/xfs_fsverity.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2022 Red Hat, Inc.
> > > + */
> > > +#ifndef __XFS_FSVERITY_H__
> > > +#define __XFS_FSVERITY_H__
> > > +
> > > +#ifdef CONFIG_FS_VERITY
> > > +extern const struct fsverity_operations xfs_fsverity_ops;
> > > +#endif	/* CONFIG_FS_VERITY */
> > > +
> > > +#endif	/* __XFS_FSVERITY_H__ */
> > > diff --git a/fs/xfs/xfs_message.c b/fs/xfs/xfs_message.c
> > > index 19aba2c3d5..17f0f0ca7b 100644
> > > --- a/fs/xfs/xfs_message.c
> > > +++ b/fs/xfs/xfs_message.c
> > > @@ -161,6 +161,10 @@
> > >  			.opstate	= XFS_OPSTATE_WARNED_ZONED,
> > >  			.name		= "zoned RT device",
> > >  		},
> > > +		[XFS_EXPERIMENTAL_FSVERITY] = {
> > > +			.opstate	= XFS_OPSTATE_WARNED_ZONED,
> > > +			.name		= "fsverity",
> > > +		},
> > >  	};
> > >  	ASSERT(feat >= 0 && feat < XFS_EXPERIMENTAL_MAX);
> > >  	BUILD_BUG_ON(ARRAY_SIZE(features) != XFS_EXPERIMENTAL_MAX);
> > > diff --git a/fs/xfs/xfs_message.h b/fs/xfs/xfs_message.h
> > > index d68e72379f..1647d32ea4 100644
> > > --- a/fs/xfs/xfs_message.h
> > > +++ b/fs/xfs/xfs_message.h
> > > @@ -96,6 +96,7 @@
> > >  	XFS_EXPERIMENTAL_LBS,
> > >  	XFS_EXPERIMENTAL_METADIR,
> > >  	XFS_EXPERIMENTAL_ZONED,
> > > +	XFS_EXPERIMENTAL_FSVERITY,
> > >  
> > >  	XFS_EXPERIMENTAL_MAX,
> > >  };
> > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > index 10c6fc8d20..42a16b15a6 100644
> > > --- a/fs/xfs/xfs_super.c
> > > +++ b/fs/xfs/xfs_super.c
> > > @@ -30,6 +30,7 @@
> > >  #include "xfs_filestream.h"
> > >  #include "xfs_quota.h"
> > >  #include "xfs_sysfs.h"
> > > +#include "xfs_fsverity.h"
> > >  #include "xfs_ondisk.h"
> > >  #include "xfs_rmap_item.h"
> > >  #include "xfs_refcount_item.h"
> > > @@ -54,6 +55,7 @@
> > >  #include <linux/fs_context.h>
> > >  #include <linux/fs_parser.h>
> > >  #include <linux/fsverity.h>
> > > +#include <linux/iomap.h>
> > >  
> > >  static const struct super_operations xfs_super_operations;
> > >  
> > > @@ -1706,6 +1708,9 @@
> > >  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> > >  #endif
> > >  	sb->s_op = &xfs_super_operations;
> > > +#ifdef CONFIG_FS_VERITY
> > > +	sb->s_vop = &xfs_fsverity_ops;
> > > +#endif
> > >  
> > >  	/*
> > >  	 * Delay mount work if the debug hook is set. This is debug
> > > @@ -1959,10 +1964,19 @@
> > >  		xfs_set_resuming_quotaon(mp);
> > >  	mp->m_qflags &= ~XFS_QFLAGS_MNTOPTS;
> > >  
> > > +	if (xfs_has_verity(mp))
> > > +		xfs_warn_experimental(mp, XFS_EXPERIMENTAL_FSVERITY);
> > > +
> > >  	error = xfs_mountfs(mp);
> > >  	if (error)
> > >  		goto out_filestream_unmount;
> > >  
> > > +#ifdef CONFIG_FS_VERITY
> > > +	error = iomap_fsverity_init_bioset();
> > 
> > if (xfs_has_verity()) ?
> 
> sure, will change it
> 
> -- 
> - Andrey
> 

