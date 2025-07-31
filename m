Return-Path: <linux-fsdevel+bounces-56428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F702B173C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 17:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8280C170D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 15:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349261D7E37;
	Thu, 31 Jul 2025 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYF7Lfwk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C1190477;
	Thu, 31 Jul 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974447; cv=none; b=XsTQthig92qDTTZJ5rHTNXz8GvFi2PbC/WFWqRhVyrkAeq1Dz8RzUevD8QcO6CKGCGRYaiHH56xOLKe5dDwDz+KR0wJG5w3sxVnFzCdugM4Vdk8Yd5W0eEPFiqMjVC6jinvesW+ihXqPkfBiBMzfX43SRwtIS65PSRoFQnltlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974447; c=relaxed/simple;
	bh=Z6kd+k8rQ/38q+0nlIbKpo1Ambgr0IRMkjo3jSSIMLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3/UNo6hDh0hzsSz3MwaGQScRgMgz2xICt7T+3MeZWe9d8zEKz3UcwvaLVw7xu8mwBBEdJMZbWasYy84NKGSLKP93RWEHFaWBCykOAy7NNjpCXIZEZ/Z6cm4YXvjvvkeX5mFvFu+4OzhYrJmm1vZmIj5bGDfXrpAAPvKN8ePxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYF7Lfwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19450C4CEEF;
	Thu, 31 Jul 2025 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753974447;
	bh=Z6kd+k8rQ/38q+0nlIbKpo1Ambgr0IRMkjo3jSSIMLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYF7Lfwk0S1bOtfQk0oPXrwR4qQsXG66xDr40hQXtYyie0ksHZr1pXiUdl/eX9CRH
	 s2PG8T1RiWId+HYIS4dvnHAVNNhiHZzx81sHL/VqrPBpmd0JLEBp45nHo2IHEdVzqe
	 KPM7ltlZMWtzJ1RHMeZdPZvJhfmosnYeEptxNzI3Q/9San8kLeNOScOjiOZCfN5nNB
	 ELLVGq5aKyGvzQiQz9pNean9pL3LU+/ocwX9zith3+VXU0bmP4I/+EQMjsRbHzWUxH
	 nhzkDu8zsCVEO8CfvDYJ+FHE13j6w3dicVxr1gVtLhNY//+gjSI5dr9g8q1PYeGmhY
	 OlQQ7G8bqjvDg==
Date: Thu, 31 Jul 2025 08:07:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, david@fromorbit.com, ebiggers@kernel.org,
	hch@lst.de, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH RFC 22/29] xfs: add fs-verity support
Message-ID: <20250731150726.GB2672029@frogsfrogsfrogs>
References: <20250728-fsverity-v1-0-9e5443af0e34@kernel.org>
 <20250728-fsverity-v1-22-9e5443af0e34@kernel.org>
 <20250729230536.GM2672049@frogsfrogsfrogs>
 <ubxmvkvjjq7ev32rgrb2nhzn5pdskgz2rl3jgkfh6typbnz6ys@wqmq2bjwunrk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ubxmvkvjjq7ev32rgrb2nhzn5pdskgz2rl3jgkfh6typbnz6ys@wqmq2bjwunrk>

On Thu, Jul 31, 2025 at 04:50:02PM +0200, Andrey Albershteyn wrote:
> On 2025-07-29 16:05:36, Darrick J. Wong wrote:
> > On Mon, Jul 28, 2025 at 10:30:26PM +0200, Andrey Albershteyn wrote:
> > > Add integration with fs-verity. XFS stores fs-verity descriptor in
> > > the extended file attributes and the Merkle tree is store in data fork
> > > beyond EOF.
> > > 
> > > The descriptor is stored under "vdesc" extended attribute.
> > > 
> > > The Merkle tree reading/writing is done through iomap interface. The
> > > data itself are at offset 1 << 53 in the inode's page cache. When XFS
> > > reads from this region iomap doesn't call into fsverity to verify it
> > > against Merkle tree. For data, verification is done on BIO completion.
> > > 
> > > When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> > > flag is set meaning that the Merkle tree is being build. The
> > > initialization ends with storing of verity descriptor and setting
> > > inode on-disk flag (XFS_DIFLAG2_VERITY).
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > /me wonders if this is really SoB me since it's rather different from
> > the last time I even touched this patch.  It also means I can't RVB it.
> > ;)
> 
> Yeah, it probably make sense to drop it, because I dropped most of
> the blob cache related code
> 
> > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  fs/xfs/Makefile               |   1 +
> > >  fs/xfs/libxfs/xfs_da_format.h |   4 +
> > >  fs/xfs/xfs_bmap_util.c        |   7 +
> > >  fs/xfs/xfs_fsverity.c         | 311 ++++++++++++++++++++++++++++++++++++++++++
> > >  fs/xfs/xfs_fsverity.h         |  28 ++++
> > >  fs/xfs/xfs_inode.h            |   6 +
> > >  fs/xfs/xfs_super.c            |  20 +++
> > >  7 files changed, 377 insertions(+)
> > > 
> > > diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> > > index 5bf501cf8271..ad66439db7bf 100644
> > > --- a/fs/xfs/Makefile
> > > +++ b/fs/xfs/Makefile
> > > @@ -147,6 +147,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
> > >  xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
> > >  xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
> > >  xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
> > > +xfs-$(CONFIG_FS_VERITY)		+= xfs_fsverity.o
> > >  
> > >  # notify failure
> > >  ifeq ($(CONFIG_MEMORY_FAILURE),y)
> > > diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
> > > index e5274be2fe9c..b17fdbbb48aa 100644
> > > --- a/fs/xfs/libxfs/xfs_da_format.h
> > > +++ b/fs/xfs/libxfs/xfs_da_format.h
> > > @@ -909,4 +909,8 @@ struct xfs_parent_rec {
> > >  	__be32	p_gen;
> > >  } __packed;
> > >  
> > > +/* fs-verity ondisk xattr name used for the fsverity descriptor */
> > > +#define XFS_VERITY_DESCRIPTOR_NAME	"vdesc"
> > > +#define XFS_VERITY_DESCRIPTOR_NAME_LEN	(sizeof(XFS_VERITY_DESCRIPTOR_NAME) - 1)
> > > +
> > >  #endif /* __XFS_DA_FORMAT_H__ */
> > > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > > index 06ca11731e43..af1933129647 100644
> > > --- a/fs/xfs/xfs_bmap_util.c
> > > +++ b/fs/xfs/xfs_bmap_util.c
> > > @@ -31,6 +31,7 @@
> > >  #include "xfs_rtbitmap.h"
> > >  #include "xfs_rtgroup.h"
> > >  #include "xfs_zone_alloc.h"
> > > +#include <linux/fsverity.h>
> > >  
> > >  /* Kernel only BMAP related definitions and functions */
> > >  
> > > @@ -553,6 +554,12 @@ xfs_can_free_eofblocks(
> > >  	if (last_fsb <= end_fsb)
> > >  		return false;
> > >  
> > > +	/*
> > > +	 * Nothing to clean on fsverity inodes as they are read-only
> > > +	 */
> > > +	if (IS_VERITY(VFS_I(ip)))
> > > +		return false;
> > > +
> > >  	/*
> > >  	 * Check if there is an post-EOF extent to free.  If there are any
> > >  	 * delalloc blocks attached to the inode (data fork delalloc
> > > diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> > > new file mode 100644
> > > index 000000000000..ec7dea4289d5
> > > --- /dev/null
> > > +++ b/fs/xfs/xfs_fsverity.c
> > > @@ -0,0 +1,311 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2023 Red Hat, Inc.
> > > + */
> > > +#include "xfs.h"
> > > +#include "xfs_shared.h"
> > > +#include "xfs_format.h"
> > > +#include "xfs_da_format.h"
> > > +#include "xfs_da_btree.h"
> > > +#include "xfs_trans_resv.h"
> > > +#include "xfs_mount.h"
> > > +#include "xfs_inode.h"
> > > +#include "xfs_log_format.h"
> > > +#include "xfs_attr.h"
> > > +#include "xfs_bmap_util.h"
> > > +#include "xfs_log_format.h"
> > > +#include "xfs_trans.h"
> > > +#include "xfs_attr_leaf.h"
> > > +#include "xfs_trace.h"
> > > +#include "xfs_quota.h"
> > > +#include "xfs_ag.h"
> > > +#include "xfs_fsverity.h"
> > > +#include "xfs_iomap.h"
> > > +#include <linux/fsverity.h>
> > > +#include <linux/pagemap.h>
> > > +
> > > +/*
> > > + * Initialize an args structure to load or store the fsverity descriptor.
> > > + * Caller must ensure @args is zeroed except for value and valuelen.
> > > + */
> > > +static inline void
> > > +xfs_fsverity_init_vdesc_args(
> > > +	struct xfs_inode	*ip,
> > > +	struct xfs_da_args	*args)
> > > +{
> > > +	args->geo = ip->i_mount->m_attr_geo;
> > > +	args->whichfork = XFS_ATTR_FORK;
> > > +	args->attr_filter = XFS_ATTR_VERITY;
> > > +	args->op_flags = XFS_DA_OP_OKNOENT;
> > > +	args->dp = ip;
> > > +	args->owner = ip->i_ino;
> > > +	args->name = XFS_VERITY_DESCRIPTOR_NAME;
> > > +	args->namelen = XFS_VERITY_DESCRIPTOR_NAME_LEN;
> > > +	xfs_attr_sethash(args);
> > > +}
> > > +
> > > +/* Delete the verity descriptor. */
> > > +static int
> > > +xfs_fsverity_delete_descriptor(
> > > +	struct xfs_inode	*ip)
> > > +{
> > > +	struct xfs_da_args	args = { };
> > > +
> > > +	xfs_fsverity_init_vdesc_args(ip, &args);
> > > +	return xfs_attr_set(&args, XFS_ATTRUPDATE_REMOVE, false);
> > > +}
> > > +
> > > +/* Retrieve the verity descriptor. */
> > > +static int
> > > +xfs_fsverity_get_descriptor(
> > > +	struct inode		*inode,
> > > +	void			*buf,
> > > +	size_t			buf_size)
> > > +{
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > +	struct xfs_da_args	args = {
> > > +		.value		= buf,
> > > +		.valuelen	= buf_size,
> > > +	};
> > > +	int			error = 0;
> > > +
> > > +	/*
> > > +	 * The fact that (returned attribute size) == (provided buf_size) is
> > > +	 * checked by xfs_attr_copy_value() (returns -ERANGE).  No descriptor
> > > +	 * is treated as a short read so that common fsverity code will
> > > +	 * complain.
> > > +	 */
> > > +	xfs_fsverity_init_vdesc_args(ip, &args);
> > > +	error = xfs_attr_get(&args);
> > > +	if (error == -ENOATTR)
> > > +		return 0;
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	return args.valuelen;
> > > +}
> > > +
> > > +/* Try to remove all the fsverity metadata after a failed enablement. */
> > > +static int
> > > +xfs_fsverity_delete_metadata(
> > > +	struct xfs_inode	*ip)
> > > +{
> > > +	struct xfs_trans	*tp;
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +	int			error;
> > > +
> > > +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > > +	if (error) {
> > > +		ASSERT(xfs_is_shutdown(mp));
> > > +		return error;
> > > +	}
> > > +
> > > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > > +	xfs_trans_ijoin(tp, ip, 0);
> > > +
> > > +	/*
> > > +	 * As only merkle tree is getting removed, no need to change inode size
> > > +	 */
> > > +	error = xfs_itruncate_extents(&tp, ip, XFS_DATA_FORK, XFS_ISIZE(ip));
> > > +	if (error)
> > > +		goto err_cancel;
> > > +
> > > +	error = xfs_trans_commit(tp);
> > > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	error = xfs_fsverity_delete_descriptor(ip);
> > > +	return error != -ENOATTR ? error : 0;
> > 
> > Do you need to re-truncate the file to EOF to clear out the post-eof
> > blocks?
> 
> yes, any prealloc extents, or failed merkle tree construction
> extents
> 
> > 
> > > +
> > > +err_cancel:
> > > +	xfs_trans_cancel(tp);
> > > +	return error;
> > > +}
> > > +
> > > +
> > > +/* Prepare to enable fsverity by clearing old metadata. */
> > > +static int
> > > +xfs_fsverity_begin_enable(
> > > +	struct file		*filp)
> > > +{
> > > +	struct inode		*inode = file_inode(filp);
> > > +	struct xfs_inode	*ip = XFS_I(inode);
> > > +	int			error;
> > > +
> > > +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);

Hrm, do you need to take MMAPLOCK_EXCL here to lock out write faults?
The answer might be false if page_mkwrite looks for VERITY_CONSTRUCTION
and errors out.

> > > +	if (IS_DAX(inode))
> > > +		return -EINVAL;
> > > +
> > > +	if (inode->i_size > XFS_FSVERITY_MTREE_OFFSET)
> > > +		return -EFBIG;
> > > +
> > > +	if (xfs_iflags_test_and_set(ip, XFS_VERITY_CONSTRUCTION))
> > > +		return -EBUSY;
> > 
> > Hm.  Do we actually flush the pagecache to disk in the _begin_enable
> > path?  /me looked briefly but didn't see anything.
> 
> hmm, you're right, this is missing, my memory had an impression that
> fsverity code does it but it doesn't
> 
> I'm not sure that this is actually needed here as we will do
> filemap_write_and_wait() in _end_enable() while inode is being
> locked and only writting happening is merkle tree construction.

I guess this depends on what Eric thinks is the sequence for enabling
verity.  I'd have thought that you'd want to stabilize the file on disk
before constructing the merkle tree, but the ext4 implementation doesn't
do that afaict.

> > > +
> > > +	error = xfs_qm_dqattach(ip);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	return xfs_fsverity_delete_metadata(ip);
> > > +}
> > > +
> > > +/* Complete (or fail) the process of enabling fsverity. */
> > > +static int
> > > +xfs_fsverity_end_enable(
> > > +	struct file		*filp,
> > > +	const void		*desc,
> > > +	size_t			desc_size,
> > > +	u64			merkle_tree_size)
> > > +{
> > > +	struct xfs_da_args	args = {
> > > +		.value		= (void *)desc,
> > > +		.valuelen	= desc_size,
> > > +	};
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
> > > +	xfs_fsverity_init_vdesc_args(ip, &args);
> > > +	error = xfs_attr_set(&args, XFS_ATTRUPDATE_UPSERT, false);
> > > +	if (error)
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * Wait for Merkel tree get written to disk before setting on-disk inode
> > > +	 * flag and clering XFS_VERITY_CONSTRUCTION
> > 
> > s/Merkel/Merkle/
> > 
> > s/clering/clearing/ , sorry if that's my typo
> 
> thanks!
> 
> > 
> > > +	 */
> > > +	error = filemap_write_and_wait(inode->i_mapping);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	/* Set fsverity inode flag */
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
> > > +static void
> > > +xfs_fsverity_adjust_read(
> > > +		struct ioregion	*region)
> > > +{
> > > +	u8			log_blocksize;
> > > +	unsigned int		block_size;
> > > +	u64			tree_size;
> > > +	u64			position = region->pos & XFS_FSVERITY_MTREE_MASK;
> > > +
> > > +	fsverity_merkle_tree_geometry(region->inode, &log_blocksize,
> > > +				      &block_size, &tree_size);
> > > +
> > > +	if (position + region->length < tree_size)
> > > +		return;
> > > +
> > > +	region->length = tree_size - position;
> > > +}
> > > +
> > > +/* Retrieve a merkle tree block. */
> > > +static struct page *
> > > +xfs_fsverity_read_merkle(
> > > +	struct inode		*inode,
> > > +	pgoff_t			index,
> > > +	unsigned long		num_ra_pages)
> > > +{
> > > +	u64 position		= (index << PAGE_SHIFT) | XFS_FSVERITY_MTREE_OFFSET;
> > 
> > Is this shift safe on 32-bit where pgoff_t is unsigned long?
> > I don't think it is....?
> 
> u64 position		= ((loff_t)index << PAGE_SHIFT) | XFS_FSVERITY_MTREE_OFFSET;
> like this?

Yeah.  I really wonder if the pagecache needs to grow a typed helper:

static inline loff_t pgoff_to_loff(pgoff_t i)
{
	return ((loff_t)i) << PAGE_SHIFT;
}

loff_t position = pgoff_to_loff(index) + XFS_FSVERITY_MTREE_OFFSET;

> > 
> > > +	struct ioregion region	= {
> > > +		.inode		= inode,
> > > +		.pos		= position,
> > > +		.length		= PAGE_SIZE,
> > > +		.ops		= &xfs_read_iomap_ops,
> > > +	};
> > > +	int			error;
> > > +	struct folio		*folio;
> > > +
> > > +	/*
> > > +	 * As region->length is PAGE_SIZE we have to adjust the length for the
> > > +	 * end of the tree. The case when tree blocks size are smaller then
> > > +	 * PAGE_SIZE.
> > 
> > Hrm.  I wonder if we want to try to create large folios for merkle
> > trees?
> 
> I think we can as we just need to then pick the right page fsverity
> requested

Oh, right, and you can get individual pages from a large folio.

> > 
> > Since the comment references PAGE_SIZE, what happens if this is an 8k
> > fsblock XFS filesystem where folios will always be at least 8k?
> 
> I think this should be fine, the default is PAGE_SIZE because
> fsverity is interested in pages, so, start from this and adjust if
> we don't have data to fill it.

<nod>

--D

> > 
> > > +	 */
> > > +	xfs_fsverity_adjust_read(&region);
> > > +
> > > +	folio = iomap_read_region(&region);
> > > +	if (IS_ERR(folio))
> > > +		return ERR_PTR(-EIO);
> > > +
> > > +	/* Wait for buffered read to finish */
> > > +	error = folio_wait_locked_killable(folio);
> > > +	if (error)
> > > +		return ERR_PTR(error);
> > > +	if (IS_ERR(folio) || !folio_test_uptodate(folio))
> > > +		return ERR_PTR(-EFSCORRUPTED);
> > > +
> > > +	return folio_file_page(folio, 0);
> > > +}
> > > +
> > > +/* Write a merkle tree block. */
> > > +static int
> > > +xfs_fsverity_write_merkle(
> > > +	struct inode				*inode,
> > > +	const void				*buf,
> > > +	u64					pos,
> > > +	unsigned int				size)
> > > +{
> > > +	struct ioregion region			= {
> > > +		.inode				= inode,
> > > +		.pos				= pos | XFS_FSVERITY_MTREE_OFFSET,
> > > +		.buf				= buf,
> > > +		.length				= size,
> > > +		.ops				= &xfs_buffered_write_iomap_ops,
> > > +	};
> > > +
> > > +	if (region.pos + region.length > inode->i_sb->s_maxbytes)
> > > +		return -EFBIG;
> > > +
> > > +	return iomap_write_region(&region);
> > > +}
> > > +
> > > +const struct fsverity_operations xfs_fsverity_ops = {
> > > +	.begin_enable_verity		= xfs_fsverity_begin_enable,
> > > +	.end_enable_verity		= xfs_fsverity_end_enable,
> > > +	.get_verity_descriptor		= xfs_fsverity_get_descriptor,
> > > +	.read_merkle_tree_page		= xfs_fsverity_read_merkle,
> > > +	.write_merkle_tree_block	= xfs_fsverity_write_merkle,
> > > +};
> > > diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
> > > new file mode 100644
> > > index 000000000000..e063b7288dc0
> > > --- /dev/null
> > > +++ b/fs/xfs/xfs_fsverity.h
> > > @@ -0,0 +1,28 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright (C) 2022 Red Hat, Inc.
> > > + */
> > > +#ifndef __XFS_FSVERITY_H__
> > > +#define __XFS_FSVERITY_H__
> > > +
> > > +/* Merkle tree location in page cache. We take memory region from the inode's
> > > + * address space for Merkle tree.
> > > + *
> > > + * At maximum of 8 levels with 128 hashes per block (32 bytes SHA-256) maximum
> > 
> > Aren't sha512 hashes allowed too?  In which case it would be 64 bytes
> > per hash?
> > 
> > I suppose that doesn't really matter since... an 8EB file on a 1k
> > fsblock filesystem with 1k merkle tree blocks will do this:
> > 
> > # xfs_db /dev/sda -c "btheight -b 1024 -n $(( (2**63 - 1) / 1024 ))
> > 64:64:0:merkle -w min"
> > 64:64:0:merkle: worst case per 1024-byte block: 8 records (leaf) / 8
> > keyptrs (node)
> > level 0: 9007199254740991 records, 1125899906842624 blocks
> > level 1: 1125899906842624 records, 140737488355328 blocks
> > level 2: 140737488355328 records, 17592186044416 blocks
> > level 3: 17592186044416 records, 2199023255552 blocks
> > level 4: 2199023255552 records, 274877906944 blocks
> > level 5: 274877906944 records, 34359738368 blocks
> > level 6: 34359738368 records, 4294967296 blocks
> > level 7: 4294967296 records, 536870912 blocks
> > level 8: 536870912 records, 67108864 blocks
> > level 9: 67108864 records, 8388608 blocks
> > level 10: 8388608 records, 1048576 blocks
> > level 11: 1048576 records, 131072 blocks
> > level 12: 131072 records, 16384 blocks
> > level 13: 16384 records, 2048 blocks
> > level 14: 2048 records, 256 blocks
> > level 15: 256 records, 32 blocks
> > level 16: 32 records, 4 blocks
> > level 17: 4 records, 1 block
> > 18 levels, 1286742750677285 blocks total
> > 
> > log2(1286742750677285) is 50, so your choice of 53 is fine.  Though this
> > will far exceed the max merkle tree height anyway.
> 
> yup, the 53 seems to be fine even for 1k.
> 
> > 
> > > + * tree size is ((128^8 − 1)/(128 − 1)) = 567*10^12 blocks. This should fit in 53
> > > + * bits address space.
> > > + *
> > > + * At this Merkle tree size we can cover 295EB large file. This is much larger
> > > + * than the currently supported file size.
> > > + *
> > > + * As we allocate some pagecache space for fsverity tree we need to limit
> > > + * maximum fsverity file size.
> > > + */
> > > +#define XFS_FSVERITY_MTREE_OFFSET (1ULL << 53)
> > > +#define XFS_FSVERITY_MTREE_MASK (XFS_FSVERITY_MTREE_OFFSET - 1)
> > 
> > This is part of the ondisk format, so it belongs in xfs_fs.h.
> 
> oh, will move it
> 
> > 
> > --D
> > 
> > > +#ifdef CONFIG_FS_VERITY
> > > +extern const struct fsverity_operations xfs_fsverity_ops;
> > > +#endif	/* CONFIG_FS_VERITY */
> > > +
> > > +#endif	/* __XFS_FSVERITY_H__ */
> > > diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> > > index d7e2b902ef5c..033e1a71e64b 100644
> > > --- a/fs/xfs/xfs_inode.h
> > > +++ b/fs/xfs/xfs_inode.h
> > > @@ -404,6 +404,12 @@ static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
> > >   */
> > >  #define XFS_IREMAPPING		(1U << 15)
> > >  
> > > +/*
> > > + * fs-verity's Merkle tree is under construction. The file is read-only, the
> > > + * only writes happening is the ones with Merkle tree blocks.
> > > + */
> > > +#define XFS_VERITY_CONSTRUCTION	(1U << 16)
> > > +
> > >  /* All inode state flags related to inode reclaim. */
> > >  #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
> > >  				 XFS_IRECLAIM | \
> > > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > > index 7b1ace75955c..10fb23ac672a 100644
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
> > > @@ -1711,6 +1713,9 @@ xfs_fs_fill_super(
> > >  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> > >  #endif
> > >  	sb->s_op = &xfs_super_operations;
> > > +#ifdef CONFIG_FS_VERITY
> > > +	sb->s_vop = &xfs_fsverity_ops;
> > > +#endif
> > >  
> > >  	/*
> > >  	 * Delay mount work if the debug hook is set. This is debug
> > > @@ -1964,10 +1969,25 @@ xfs_fs_fill_super(
> > >  		xfs_set_resuming_quotaon(mp);
> > >  	mp->m_qflags &= ~XFS_QFLAGS_MNTOPTS;
> > >  
> > > +	if (xfs_has_verity(mp))
> > > +		xfs_warn(mp,
> > > +	"EXPERIMENTAL fsverity feature in use. Use at your own risk!");
> > > +
> > >  	error = xfs_mountfs(mp);
> > >  	if (error)
> > >  		goto out_filestream_unmount;
> > >  
> > > +#ifdef CONFIG_FS_VERITY
> > > +	/*
> > > +	 * Don't use a high priority workqueue like the other fsverity
> > > +	 * implementations because that will lead to conflicts with the xfs log
> > > +	 * workqueue.
> > > +	 */
> > > +	error = iomap_init_fsverity(mp->m_super, 0, 0);
> > > +	if (error)
> > > +		goto out_unmount;
> > > +#endif
> > > +
> > >  	root = igrab(VFS_I(mp->m_rootip));
> > >  	if (!root) {
> > >  		error = -ENOENT;
> > > 
> > > -- 
> > > 2.50.0
> > > 
> > > 
> > 
> 
> -- 
> - Andrey
> 
> 

