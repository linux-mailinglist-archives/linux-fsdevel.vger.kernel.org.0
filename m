Return-Path: <linux-fsdevel+bounces-13951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19CF875AE7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 00:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C29221C21504
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CBA3FB2F;
	Thu,  7 Mar 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syty/ot6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDA3DBBF;
	Thu,  7 Mar 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853039; cv=none; b=ievcZctmr41C6rabPUI1iw9e6GBv9JZ9C2A18r/njEChqsIr3lSXFanUIPMdq+YrXzrtGtZvmSjfNWRLjkRvjjeNpqWW1l/iT89rkEp7vWdbBEn00wRkFIUZ4aQTy3QgJxO3LLkOHN4n1jdy8enof6l5EtPp1nQS8f0OMwtwog0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853039; c=relaxed/simple;
	bh=xAJumLBPWRfgavdNnMklE0MfVdAsdr3RSaS6X4fMo9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtqlTttd+GNoAl5j4OmzoRrsX6DpkETROdGHaY6Rnp4FG3KRhAoARnMSEFkxOHT5088a17inhTYF/YsmSjQMuRPIC95D8JT8M3YO/3SyTV9cNWjRJnse1YbwmGSmfu7qJUaZllBUxc3chp4xelzpVa5BW/qU3okfkZF2dehy7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syty/ot6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF28C433F1;
	Thu,  7 Mar 2024 23:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709853038;
	bh=xAJumLBPWRfgavdNnMklE0MfVdAsdr3RSaS6X4fMo9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Syty/ot6UtOedZCv0zw9qycGuMt1Va0LxtnRuRqXUd48CE1C+fVL7w+CpfGkOfb0r
	 ioA/Bdyb6x/owkFytgSWGt85DqKbdAf9lYQRDz7u9fb1erUaUZz7mZbz55TLZQAT/S
	 zgcQRe5AxpliT7Ojn648ffDj58UgCyfC07jocSyn/yL5gBOSjRVigrsMtt4Mx1camS
	 EKBLHg27DV+1X11lgDCqcoAES3M0/v0jp+SgWvQIBQWSxVrTQHJ7Ny2vqIUUkFR1Jg
	 f1/OCjI8cgdVW+PZhV+AqDFHRB+pgsT8feheY9qpIv9JaYWqnoDYBSB2t9wOihfSnW
	 QLcobS9/Y7XDA==
Date: Thu, 7 Mar 2024 15:10:38 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com,
	ebiggers@kernel.org
Subject: Re: [PATCH v5 21/24] xfs: add fs-verity support
Message-ID: <20240307231038.GC1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-23-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304191046.157464-23-aalbersh@redhat.com>

On Mon, Mar 04, 2024 at 08:10:44PM +0100, Andrey Albershteyn wrote:
> Add integration with fs-verity. The XFS store fs-verity metadata in
> the extended file attributes. The metadata consist of verity
> descriptor and Merkle tree blocks.
> 
> The descriptor is stored under "vdesc" extended attribute. The
> Merkle tree blocks are stored under binary indexes which are offsets
> into the Merkle tree.
> 
> When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> flag is set meaning that the Merkle tree is being build. The
> initialization ends with storing of verity descriptor and setting
> inode on-disk flag (XFS_DIFLAG2_VERITY).
> 
> The verification on read is done in read path of iomap.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/Makefile                 |   1 +
>  fs/xfs/libxfs/xfs_attr.c        |  13 ++
>  fs/xfs/libxfs/xfs_attr_leaf.c   |  17 +-
>  fs/xfs/libxfs/xfs_attr_remote.c |   8 +-
>  fs/xfs/libxfs/xfs_da_format.h   |  27 +++
>  fs/xfs/libxfs/xfs_ondisk.h      |   4 +
>  fs/xfs/xfs_inode.h              |   3 +-
>  fs/xfs/xfs_super.c              |  10 +
>  fs/xfs/xfs_verity.c             | 355 ++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_verity.h             |  33 +++
>  10 files changed, 464 insertions(+), 7 deletions(-)
>  create mode 100644 fs/xfs/xfs_verity.c
>  create mode 100644 fs/xfs/xfs_verity.h
> 
> diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> index f8845e65cac7..8396a633b541 100644
> --- a/fs/xfs/Makefile
> +++ b/fs/xfs/Makefile
> @@ -130,6 +130,7 @@ xfs-$(CONFIG_XFS_POSIX_ACL)	+= xfs_acl.o
>  xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
>  xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
>  xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
> +xfs-$(CONFIG_FS_VERITY)		+= xfs_verity.o
>  
>  # notify failure
>  ifeq ($(CONFIG_MEMORY_FAILURE),y)
> diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
> index ca515e8bd2ed..cde5352db9aa 100644
> --- a/fs/xfs/libxfs/xfs_attr.c
> +++ b/fs/xfs/libxfs/xfs_attr.c
> @@ -27,6 +27,7 @@
>  #include "xfs_attr_item.h"
>  #include "xfs_xattr.h"
>  #include "xfs_parent.h"
> +#include "xfs_verity.h"
>  
>  struct kmem_cache		*xfs_attr_intent_cache;
>  
> @@ -1527,6 +1528,18 @@ xfs_attr_namecheck(
>  	if (flags & XFS_ATTR_PARENT)
>  		return xfs_parent_namecheck(mp, name, length, flags);
>  
> +	if (flags & XFS_ATTR_VERITY) {
> +		/* Merkle tree pages are stored under u64 indexes */
> +		if (length == sizeof(struct xfs_fsverity_merkle_key))
> +			return true;
> +
> +		/* Verity descriptor blocks are held in a named attribute. */
> +		if (length == XFS_VERITY_DESCRIPTOR_NAME_LEN)
> +			return true;
> +
> +		return false;
> +	}
> +
>  	/*
>  	 * MAXNAMELEN includes the trailing null, but (name/length) leave it
>  	 * out, so use >= for the length check.
> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
> index b51f439e4aed..f1f6aefc0420 100644
> --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> @@ -30,6 +30,7 @@
>  #include "xfs_ag.h"
>  #include "xfs_errortag.h"
>  #include "xfs_health.h"
> +#include "xfs_verity.h"
>  
>  
>  /*
> @@ -519,7 +520,12 @@ xfs_attr_copy_value(
>  		return -ERANGE;
>  	}
>  
> -	if (!args->value) {
> +	/*
> +	 * We don't want to allocate memory for fs-verity Merkle tree blocks
> +	 * (fs-verity descriptor is fine though). They will be stored in
> +	 * underlying xfs_buf
> +	 */
> +	if (!args->value && !xfs_verity_merkle_block(args)) {
>  		args->value = kvmalloc(valuelen, GFP_KERNEL | __GFP_NOLOCKDEP);
>  		if (!args->value)
>  			return -ENOMEM;
> @@ -538,7 +544,14 @@ xfs_attr_copy_value(
>  	 */
>  	if (!value)
>  		return -EINVAL;
> -	memcpy(args->value, value, valuelen);
> +	/*
> +	 * We won't copy Merkle tree block to the args->value as we want it be
> +	 * in the xfs_buf. And we didn't allocate any memory in args->value.
> +	 */
> +	if (xfs_verity_merkle_block(args))
> +		args->value = value;
> +	else
> +		memcpy(args->value, value, valuelen);
>  	return 0;
>  }
>  
> diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
> index f1b7842da809..a631ddff8068 100644
> --- a/fs/xfs/libxfs/xfs_attr_remote.c
> +++ b/fs/xfs/libxfs/xfs_attr_remote.c
> @@ -23,6 +23,7 @@
>  #include "xfs_trace.h"
>  #include "xfs_error.h"
>  #include "xfs_health.h"
> +#include "xfs_verity.h"
>  
>  #define ATTR_RMTVALUE_MAPSIZE	1	/* # of map entries at once */
>  
> @@ -404,11 +405,10 @@ xfs_attr_rmtval_get(
>  	ASSERT(args->rmtvaluelen == args->valuelen);
>  
>  	/*
> -	 * We also check for _OP_BUFFER as we want to trigger on
> -	 * verity blocks only, not on verity_descriptor
> +	 * For fs-verity we want additional space in the xfs_buf. This space is
> +	 * used to copy xattr value without leaf headers (crc header).
>  	 */
> -	if (args->attr_filter & XFS_ATTR_VERITY &&
> -			args->op_flags & XFS_DA_OP_BUFFER)
> +	if (xfs_verity_merkle_block(args))
>  		flags = XBF_DOUBLE_ALLOC;
>  
>  	valuelen = args->rmtvaluelen;
> diff --git a/fs/xfs/libxfs/xfs_da_format.h b/fs/xfs/libxfs/xfs_da_format.h
> index 28d4ac6fa156..c30c3c253191 100644
> --- a/fs/xfs/libxfs/xfs_da_format.h
> +++ b/fs/xfs/libxfs/xfs_da_format.h
> @@ -914,4 +914,31 @@ struct xfs_parent_name_rec {
>   */
>  #define XFS_PARENT_DIRENT_NAME_MAX_SIZE		(MAXNAMELEN - 1)
>  
> +/*
> + * fs-verity attribute name format
> + *
> + * Merkle tree blocks are stored under extended attributes of the inode. The
> + * name of the attributes are offsets into merkle tree.
> + */
> +struct xfs_fsverity_merkle_key {
> +	__be64 merkleoff;

Nit: tab here ^ for consistency.

> +};
> +
> +static inline void
> +xfs_fsverity_merkle_key_to_disk(struct xfs_fsverity_merkle_key *key, loff_t pos)
> +{
> +	key->merkleoff = cpu_to_be64(pos);
> +}
> +
> +static inline loff_t
> +xfs_fsverity_name_to_block_offset(unsigned char *name)
> +{
> +	struct xfs_fsverity_merkle_key key = {
> +		.merkleoff = *(__be64 *)name
> +	};
> +	loff_t offset = be64_to_cpu(key.merkleoff);
> +
> +	return offset;
> +}

These helpers should go in xfs_verity.c or wherever they're actually
used.  They don't need to be in this header file.

>  #endif /* __XFS_DA_FORMAT_H__ */
> diff --git a/fs/xfs/libxfs/xfs_ondisk.h b/fs/xfs/libxfs/xfs_ondisk.h
> index 81885a6a028e..39209943c474 100644
> --- a/fs/xfs/libxfs/xfs_ondisk.h
> +++ b/fs/xfs/libxfs/xfs_ondisk.h
> @@ -194,6 +194,10 @@ xfs_check_ondisk_structs(void)
>  	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MIN << XFS_DQ_BIGTIME_SHIFT, 4);
>  	XFS_CHECK_VALUE(XFS_DQ_BIGTIME_EXPIRY_MAX << XFS_DQ_BIGTIME_SHIFT,
>  			16299260424LL);
> +
> +	/* fs-verity descriptor xattr name */
> +	XFS_CHECK_VALUE(strlen(XFS_VERITY_DESCRIPTOR_NAME),
> +			XFS_VERITY_DESCRIPTOR_NAME_LEN);

strlen works within a macro?

I would've thought this would be:

	XFS_CHECK_VALUE(sizeof(XFS_VERITY_DESCRIPTOR_NAME) ==
			XFS_VERITY_DESCRIPTOR_NAME_LEN + 1);

>  }
>  
>  #endif /* __XFS_ONDISK_H */
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index ab46ffb3ac19..d6664e9afa22 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -348,7 +348,8 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
>   * inactivation completes, both flags will be cleared and the inode is a
>   * plain old IRECLAIMABLE inode.
>   */
> -#define XFS_INACTIVATING	(1 << 13)
> +#define XFS_INACTIVATING		(1 << 13)
> +#define XFS_IVERITY_CONSTRUCTION	(1 << 14) /* merkle tree construction */

This (still) collides with...

>  /* Quotacheck is running but inode has not been added to quota counts. */
>  #define XFS_IQUOTAUNCHECKED	(1 << 14)

...this value here.  These are bitmasks; you MUST create a
non-conflicting value here.

You'll also have to update the xfs_iflags_* functions to take an
unsigned long.

> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 9f9c35cff9bf..996e6ea91fe1 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -30,6 +30,7 @@
>  #include "xfs_filestream.h"
>  #include "xfs_quota.h"
>  #include "xfs_sysfs.h"
> +#include "xfs_verity.h"
>  #include "xfs_ondisk.h"
>  #include "xfs_rmap_item.h"
>  #include "xfs_refcount_item.h"
> @@ -1520,6 +1521,11 @@ xfs_fs_fill_super(
>  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
>  #endif
>  	sb->s_op = &xfs_super_operations;
> +#ifdef CONFIG_FS_VERITY
> +	error = fsverity_set_ops(sb, &xfs_verity_ops);
> +	if (error)
> +		return error;
> +#endif

Isn't fsverity_set_ops a nop if !CONFIG_FS_VERITY?

>  	/*
>  	 * Delay mount work if the debug hook is set. This is debug
> @@ -1729,6 +1735,10 @@ xfs_fs_fill_super(
>  		goto out_filestream_unmount;
>  	}
>  
> +	if (xfs_has_verity(mp))
> +		xfs_alert(mp,
> +	"EXPERIMENTAL fs-verity feature in use. Use at your own risk!");
> +
>  	error = xfs_mountfs(mp);
>  	if (error)
>  		goto out_filestream_unmount;
> diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
> new file mode 100644
> index 000000000000..ea31b5bf6214
> --- /dev/null
> +++ b/fs/xfs/xfs_verity.c
> @@ -0,0 +1,355 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Nit: The SPDX header for C files needs to use C++ comment style, not C.

(This is a really stupid rule decided on by the spdx bureaucrats.)

> +/*
> + * Copyright (C) 2023 Red Hat, Inc.
> + */
> +#include "xfs.h"
> +#include "xfs_shared.h"
> +#include "xfs_format.h"
> +#include "xfs_da_format.h"
> +#include "xfs_da_btree.h"
> +#include "xfs_trans_resv.h"
> +#include "xfs_mount.h"
> +#include "xfs_inode.h"
> +#include "xfs_log_format.h"
> +#include "xfs_attr.h"
> +#include "xfs_verity.h"
> +#include "xfs_bmap_util.h"
> +#include "xfs_log_format.h"
> +#include "xfs_trans.h"
> +#include "xfs_attr_leaf.h"
> +
> +/*
> + * Make fs-verity invalidate verified status of Merkle tree block
> + */
> +static void
> +xfs_verity_put_listent(
> +	struct xfs_attr_list_context	*context,
> +	int				flags,
> +	unsigned char			*name,
> +	int				namelen,
> +	int				valuelen)
> +{
> +	struct fsverity_blockbuf	block = {
> +		.offset = xfs_fsverity_name_to_block_offset(name),
> +		.size = valuelen,
> +	};
> +	/*
> +	 * Verity descriptor is smaller than 1024; verity block min size is
> +	 * 1024. Exclude verity descriptor
> +	 */
> +	if (valuelen < 1024)
> +		return;

As Eric implied elsewhere, shouldn't you be checking here if @name is
/not/ XFS_VERITY_DESCRIPTOR_NAME?

> +
> +	fsverity_invalidate_block(VFS_I(context->dp), &block);
> +}
> +
> +/*
> + * Iterate over extended attributes in the bp to invalidate Merkle tree blocks
> + */
> +static int
> +xfs_invalidate_blocks(
> +	struct xfs_inode	*ip,
> +	struct xfs_buf		*bp)
> +{
> +	struct xfs_attr_list_context context;
> +
> +	context.dp = ip;
> +	context.resynch = 0;
> +	context.buffer = NULL;
> +	context.bufsize = 0;
> +	context.firstu = 0;
> +	context.attr_filter = XFS_ATTR_VERITY;
> +	context.put_listent = xfs_verity_put_listent;
> +
> +	return xfs_attr3_leaf_list_int(bp, &context);
> +}

Why is it necessary to invalidate every block in the merkle tree?

OH.  This is what happens any time that xfs_read_merkle_tree_block
doesn't find a DOUBLE_ALLOC buffer.  That's unfortunate, because the
merkle tree could be large enough that a double-alloc'd xattr buffer
gets purged, a subsequent xattr read from the same block nets us a
!double buffer, and then fsverity wants to read the block again.

Does my xblobc rework eliminate the need for all of this?

> +
> +static int
> +xfs_get_verity_descriptor(
> +	struct inode		*inode,
> +	void			*buf,
> +	size_t			buf_size)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	int			error = 0;
> +	struct xfs_da_args	args = {
> +		.dp		= ip,
> +		.attr_filter	= XFS_ATTR_VERITY,
> +		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
> +		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
> +		.value		= buf,
> +		.valuelen	= buf_size,
> +	};
> +
> +	/*
> +	 * The fact that (returned attribute size) == (provided buf_size) is
> +	 * checked by xfs_attr_copy_value() (returns -ERANGE)

Can verity handle ERANGE?  Or is that more of an EFSCORRUPTED?

> +	 */
> +	error = xfs_attr_get(&args);
> +	if (error)
> +		return error;
> +
> +	return args.valuelen;
> +}
> +
> +static int
> +xfs_begin_enable_verity(
> +	struct file	    *filp)
> +{
> +	struct inode	    *inode = file_inode(filp);
> +	struct xfs_inode    *ip = XFS_I(inode);
> +	int		    error = 0;
> +
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);

Do we need to lock out pagecache invalidations too?

(Can't remember if I already asked that question.)

> +
> +	if (IS_DAX(inode))
> +		return -EINVAL;
> +
> +	if (xfs_iflags_test_and_set(ip, XFS_IVERITY_CONSTRUCTION))
> +		return -EBUSY;
> +
> +	return error;
> +}
> +
> +static int
> +xfs_drop_merkle_tree(
> +	struct xfs_inode		*ip,
> +	u64				merkle_tree_size,
> +	unsigned int			tree_blocksize)
> +{
> +	struct xfs_fsverity_merkle_key	name;
> +	int				error = 0;
> +	u64				offset = 0;
> +	struct xfs_da_args		args = {
> +		.dp			= ip,
> +		.whichfork		= XFS_ATTR_FORK,
> +		.attr_filter		= XFS_ATTR_VERITY,
> +		.op_flags		= XFS_DA_OP_REMOVE,
> +		.namelen		= sizeof(struct xfs_fsverity_merkle_key),
> +		/* NULL value make xfs_attr_set remove the attr */
> +		.value			= NULL,
> +	};
> +
> +	if (!merkle_tree_size)
> +		return 0;
> +
> +	args.name = (const uint8_t *)&name.merkleoff;

Can you assign this in the @args initializer?

And shouldn't that be taking the address of the entire struct:

		.name			= (const uint8_t *)&name,

not just some field within the struct?

> +	for (offset = 0; offset < merkle_tree_size; offset += tree_blocksize) {
> +		xfs_fsverity_merkle_key_to_disk(&name, offset);
> +		error = xfs_attr_set(&args);
> +		if (error)
> +			return error;
> +	}
> +
> +	args.name = (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME;
> +	args.namelen = XFS_VERITY_DESCRIPTOR_NAME_LEN;
> +	error = xfs_attr_set(&args);
> +
> +	return error;
> +}
> +
> +static int
> +xfs_end_enable_verity(
> +	struct file		*filp,
> +	const void		*desc,
> +	size_t			desc_size,
> +	u64			merkle_tree_size,
> +	unsigned int		tree_blocksize)
> +{
> +	struct inode		*inode = file_inode(filp);
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_mount	*mp = ip->i_mount;
> +	struct xfs_trans	*tp;
> +	struct xfs_da_args	args = {
> +		.dp		= ip,
> +		.whichfork	= XFS_ATTR_FORK,
> +		.attr_filter	= XFS_ATTR_VERITY,
> +		.attr_flags	= XATTR_CREATE,

Hmm.  How do you recover from the weird situation where DIFLAG2_VERITY
is not set on the file but there /is/ a "vdesc" in the xattrs and you go
to re-enable verity?

Or: Why is it important to fail the ->end_enable operation when we have
all the information we need to reset the verity descriptor?

> +		.name		= (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME,
> +		.namelen	= XFS_VERITY_DESCRIPTOR_NAME_LEN,
> +		.value		= (void *)desc,
> +		.valuelen	= desc_size,
> +	};
> +	int			error = 0;
> +
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
> +
> +	/* fs-verity failed, just cleanup */
> +	if (desc == NULL)
> +		goto out;
> +
> +	error = xfs_attr_set(&args);
> +	if (error)
> +		goto out;

Case in point: if the system persists this transaction to the log and
crashes at this point, a subsequent re-run of 'fsverity enable' will
fail.

Should the attr_set of the verity descriptor and the setting of
DIFLAG2_VERITY be in the same transaction?

> +	/* Set fsverity inode flag */
> +	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange,
> +			0, 0, false, &tp);
> +	if (error)
> +		goto out;
> +
> +	/*
> +	 * Ensure that we've persisted the verity information before we enable
> +	 * it on the inode and tell the caller we have sealed the inode.
> +	 */
> +	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
> +
> +	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> +	xfs_trans_set_sync(tp);

Why is it necessary to commit this transaction synchronously?  Is this
required by the FS_IOC_ENABLE_VERITY API?

> +
> +	error = xfs_trans_commit(tp);
> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> +
> +	if (!error)
> +		inode->i_flags |= S_VERITY;
> +
> +out:
> +	if (error)
> +		WARN_ON_ONCE(xfs_drop_merkle_tree(ip, merkle_tree_size,
> +						  tree_blocksize));
> +
> +	xfs_iflags_clear(ip, XFS_IVERITY_CONSTRUCTION);
> +	return error;
> +}
> +
> +static int
> +xfs_read_merkle_tree_block(
> +	struct inode			*inode,
> +	u64				pos,
> +	struct fsverity_blockbuf	*block,
> +	unsigned int			log_blocksize,
> +	u64				ra_bytes)
> +{
> +	struct xfs_inode		*ip = XFS_I(inode);
> +	struct xfs_fsverity_merkle_key	name;
> +	int				error = 0;
> +	struct xfs_da_args		args = {
> +		.dp			= ip,
> +		.attr_filter		= XFS_ATTR_VERITY,
> +		.op_flags		= XFS_DA_OP_BUFFER,
> +		.namelen		= sizeof(struct xfs_fsverity_merkle_key),
> +		.valuelen		= (1 << log_blocksize),
> +	};
> +	xfs_fsverity_merkle_key_to_disk(&name, pos);
> +	args.name = (const uint8_t *)&name.merkleoff;

		.name			= (const uint8_t *)&name,

same as above.

> +
> +	error = xfs_attr_get(&args);
> +	if (error)
> +		goto out;
> +
> +	if (!args.valuelen)
> +		return -ENODATA;
> +
> +	block->kaddr = args.value;
> +	block->offset = pos;
> +	block->size = args.valuelen;
> +	block->context = args.bp;
> +
> +	/*
> +	 * Memory barriers are used to force operation ordering of clearing
> +	 * bitmap in fsverity_invalidate_block() and setting XBF_VERITY_SEEN
> +	 * flag.
> +	 *
> +	 * Multiple threads may execute this code concurrently on the same block.
> +	 * This is safe because we use memory barriers to ensure that if a
> +	 * thread sees XBF_VERITY_SEEN, then fsverity bitmap is already up to
> +	 * date.
> +	 *
> +	 * Invalidating block in a bitmap again at worst causes a hash block to
> +	 * be verified redundantly. That event should be very rare, so it's not
> +	 * worth using a lock to avoid.
> +	 */
> +	if (!(args.bp->b_flags & XBF_VERITY_SEEN)) {
> +		/*
> +		 * A read memory barrier is needed here to give ACQUIRE
> +		 * semantics to the above check.
> +		 */
> +		smp_rmb();
> +		/*
> +		 * fs-verity is not aware if buffer was evicted from the memory.
> +		 * Make fs-verity invalidate verfied status of all blocks in the
> +		 * buffer.
> +		 *
> +		 * Single extended attribute can contain multiple Merkle tree
> +		 * blocks:
> +		 * - leaf with inline data -> invalidate all blocks in the leaf
> +		 * - remote value -> invalidate single block
> +		 *
> +		 * For example, leaf on 64k system with 4k/1k filesystem will
> +		 * contain multiple Merkle tree blocks.
> +		 *
> +		 * Only remote value buffers would have XBF_DOUBLE_ALLOC flag
> +		 */
> +		if (args.bp->b_flags & XBF_DOUBLE_ALLOC)
> +			fsverity_invalidate_block(inode, block);
> +		else {
> +			error = xfs_invalidate_blocks(ip, args.bp);
> +			if (error)
> +				goto out;
> +		}
> +	}
> +
> +	/*
> +	 * A write memory barrier is needed here to give RELEASE
> +	 * semantics to the below flag.
> +	 */
> +	smp_wmb();
> +	args.bp->b_flags |= XBF_VERITY_SEEN;

Eww.  See my version of this in:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity-cleanups-6.9_2024-03-07

> +	return error;
> +
> +out:
> +	kvfree(args.value);
> +	if (args.bp)
> +		xfs_buf_rele(args.bp);
> +	return error;
> +}
> +
> +static int
> +xfs_write_merkle_tree_block(
> +	struct inode		*inode,
> +	const void		*buf,
> +	u64			pos,
> +	unsigned int		size)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_fsverity_merkle_key	name;
> +	struct xfs_da_args	args = {
> +		.dp		= ip,
> +		.whichfork	= XFS_ATTR_FORK,
> +		.attr_filter	= XFS_ATTR_VERITY,
> +		.attr_flags	= XATTR_CREATE,
> +		.namelen	= sizeof(struct xfs_fsverity_merkle_key),
> +		.value		= (void *)buf,
> +		.valuelen	= size,
> +	};
> +
> +	xfs_fsverity_merkle_key_to_disk(&name, pos);
> +	args.name = (const uint8_t *)&name.merkleoff;

		.name			= (const uint8_t *)&name,

same as above.

> +
> +	return xfs_attr_set(&args);
> +}
> +
> +static void
> +xfs_drop_block(
> +	struct fsverity_blockbuf	*block)
> +{
> +	struct xfs_buf			*bp;
> +
> +	ASSERT(block != NULL);
> +	bp = (struct xfs_buf *)block->context;
> +	ASSERT(bp->b_flags & XBF_VERITY_SEEN);
> +
> +	xfs_buf_rele(bp);
> +
> +	kunmap_local(block->kaddr);
> +}
> +
> +const struct fsverity_operations xfs_verity_ops = {
> +	.begin_enable_verity		= &xfs_begin_enable_verity,
> +	.end_enable_verity		= &xfs_end_enable_verity,
> +	.get_verity_descriptor		= &xfs_get_verity_descriptor,
> +	.read_merkle_tree_block		= &xfs_read_merkle_tree_block,
> +	.write_merkle_tree_block	= &xfs_write_merkle_tree_block,

Not sure why all these function names don't start with "xfs_verity_"?

--D

> +	.drop_block			= &xfs_drop_block,
> +};
> diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
> new file mode 100644
> index 000000000000..deea15cd3cc5
> --- /dev/null
> +++ b/fs/xfs/xfs_verity.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Red Hat, Inc.
> + */
> +#ifndef __XFS_VERITY_H__
> +#define __XFS_VERITY_H__
> +
> +#include "xfs.h"
> +#include "xfs_da_format.h"
> +#include "xfs_da_btree.h"
> +#include <linux/fsverity.h>
> +
> +#define XFS_VERITY_DESCRIPTOR_NAME "vdesc"
> +#define XFS_VERITY_DESCRIPTOR_NAME_LEN 5
> +
> +static inline bool
> +xfs_verity_merkle_block(
> +		struct xfs_da_args *args)
> +{
> +	if (!(args->attr_filter & XFS_ATTR_VERITY))
> +		return false;
> +
> +	if (!(args->op_flags & XFS_DA_OP_BUFFER))
> +		return false;
> +
> +	return true;
> +}
> +
> +#ifdef CONFIG_FS_VERITY
> +extern const struct fsverity_operations xfs_verity_ops;
> +#endif	/* CONFIG_FS_VERITY */
> +
> +#endif	/* __XFS_VERITY_H__ */
> -- 
> 2.42.0
> 
> 

