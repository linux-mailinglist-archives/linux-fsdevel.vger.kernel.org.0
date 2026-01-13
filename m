Return-Path: <linux-fsdevel+bounces-73491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA25BD1AD93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B68B30119AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0D731812E;
	Tue, 13 Jan 2026 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bj/ZO7cT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tjpLKOLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D778F30F921
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329135; cv=none; b=lu5RpCD1bxGpCQyHnQRihQ906t8kxaj7017dN3sEzxHbgHG85Ts1ZaKRmyBKb2ved33LtNl5tcDRbzxvhFthzqEMCPFtXbI2xzbFzp4DiBz/6Y04xnh+UBTlfIkbnketLTKjclLtX90JFuEzPof2zrk41ruibrNmIr921Qh+048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329135; c=relaxed/simple;
	bh=C7cXIuEit8z5yOsmly68FLgYYo6jBsvZ4zuEgYVGIWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCUi/z7YJC2JWmw0yfFXdcJRv84Ot08Z5puF2mO92shSr3DM3xGHMfTcARlYwVozS4wtHfsQmGj14v/6TdMCF6sqi8MFtWg/KwslyD/6esCr1z0+WaAsbLqjiVnon1kVQOFNLgEMb1osb679q3ulK7zgLH72XAoq+nQjIxlmLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bj/ZO7cT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tjpLKOLd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768329133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mNT0HSHvGAV+3yCgFW/lQ1bdCtmHn1vgFID/F6ma4gA=;
	b=bj/ZO7cTA/niIInFUo25t8GlmuvBX4n7DhvDWVEunOP9hSqOqoIPrntZw1vH1MQ2LS/bvG
	++4Iqc1xf9GEWckHqQ68jAJtwO0IL7Dtb4tX7oAC96yMh+QxyoGu45LZ4NYmAMdgR8VFQ3
	V3uHZqvI955u6Qf410xfVF8ItnXGKS8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-CQzmIYYMOqmfCWyDNz11Rw-1; Tue, 13 Jan 2026 13:32:09 -0500
X-MC-Unique: CQzmIYYMOqmfCWyDNz11Rw-1
X-Mimecast-MFC-AGG-ID: CQzmIYYMOqmfCWyDNz11Rw_1768329128
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d28e7960fso79875635e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 10:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768329128; x=1768933928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mNT0HSHvGAV+3yCgFW/lQ1bdCtmHn1vgFID/F6ma4gA=;
        b=tjpLKOLd2elKjOThsVwdXAoj1eDCYPhPmTm6qUUvirhHikL0epIuS/zNUk5pNcz1sb
         a28jyc4gKwODZkOQiQGAiBkrPijC3aFoiJG4KXCHP3XnkHvlSLiGq3wfBsSkMbjZVzkT
         aSRcb3drpASQiFPBHITsSn7pUvaDUwWyd3rb9H2MnvyEsWgax4WegHY73+QDqPBfqNqs
         YNhLfIU3Z0VZP9EGk+0sd52bvGnL/lWLLeXfx3RmYrr4E3FNt3Ow4I5Mil8XKejXhsmE
         g4rGryWq7AIXg+wTvlQO9Kn9d1DXuXVvKYHFmhRuA10DvWNwHFR3ad+NJlkKU2LQnJ5n
         gbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768329128; x=1768933928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNT0HSHvGAV+3yCgFW/lQ1bdCtmHn1vgFID/F6ma4gA=;
        b=sp4yLPftqNi0SMBdnMytT4V24Vs+qL//jUg1Px1BzgY9a0U2guibiTBDqjmEEUzESI
         BIkY7d8A1ctTatSCUO1W1AJVa0EAzi0f1tNywVurI8dbWqLHdB9wg8K19S2myEuApYW6
         /3A9Jk7V3ZJa0eh7cFsiqGPgJIc4OS2qZ66iccsk5GywNAjAQNFp8YY50R5CZnivezcO
         nslfbKuGWm98JuMr8GT7qzA5QSjX29VUea/+JZ01Z6sooi2VUHaxl2oRKzr79nSwdVqv
         2/AIl+9tm04jsFwfjJNppClFrYJv/QPXsaASM/u4EHwzhoMU5+MXoEwh+nSOUj9z1Kal
         OMoA==
X-Forwarded-Encrypted: i=1; AJvYcCW+QB+3Hwt5EtWYV5cOkWoKkdP6m3SYCG8T5CLaSEfNP30d+Zc1d+BoS89R4G8tw2RfSf2KozNeCiQB++W/@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcgDKT0xL9CakIZFWK08HgFAm0ioo8POxW9axGGgszdxYwbqL
	aTSSHtKR9GSWDJ6dJkIljFNdUch1Y2+ifTQZ11A9A2sk3YuT89iT2smpRdMyV6x5Bic9gwa9aB5
	iWK4XxhLhA3x7oEIaf7nAnBqVvgUv/gWItOaqKNTeki5BIki5N2pmvlPa4RRJYaABXQ==
X-Gm-Gg: AY/fxX5TYuMx61xFK038T7SVJuXT8xBlL4zM8zTwYuBcDS7LVKvVsXuXbF3pJVfgwwi
	RAKcmigXSn1vZV8LLQT3Dg/Pv2l0Z2a8/VFp0COJO64PmEHwtrKmh7fu+j7y1M6XLbEbcaeWiZv
	rwip2snAWGjPPdGjEuhYHmFJ5xbA0H1Ys65SNGGDJuI/VafxgsEePD8PvOVEiPS+qigoO1zNE2F
	nVg5DW+FISdnXlISn+0B1L+Wr6VElEaHosxxqbFEaQmxnMSjRqgQIqvUM3LQr7KHQ3lAw5sYnOu
	4Xm8MLSm+Z/GVMTnGZV8qXArcqLmfL8jcMT5ry/TqijLJ5fp71TEMQs/Yx9Z3xF0NTHW0AgD3CE
	=
X-Received: by 2002:a05:600c:34cd:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47ee33117d3mr2044545e9.15.1768329128069;
        Tue, 13 Jan 2026 10:32:08 -0800 (PST)
X-Received: by 2002:a05:600c:34cd:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47ee33117d3mr2044125e9.15.1768329127431;
        Tue, 13 Jan 2026 10:32:07 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f69dsm415307315e9.1.2026.01.13.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 10:32:07 -0800 (PST)
Date: Tue, 13 Jan 2026 19:32:06 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 16/22] xfs: add fs-verity support
Message-ID: <vtkbi6fc2hhacxj5rmxqfxiawg5iqabsoxmxosm3oawqtqrbv5@vniylcxwzkcv>
References: <cover.1768229271.patch-series@thinky>
 <p4vwqbgks2zr5i4f4d2t2i3gs2l4tnsmi2eijay5jba5y4kx6e@g3k4uk4ia4es>
 <20260112230548.GR15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112230548.GR15551@frogsfrogsfrogs>

On 2026-01-12 15:05:48, Darrick J. Wong wrote:
> On Mon, Jan 12, 2026 at 03:51:43PM +0100, Andrey Albershteyn wrote:
> > Add integration with fs-verity. XFS stores fs-verity descriptor and
> > Merkle tree in the inode data fork at offset file offset (1 << 53).
> > 
> > The Merkle tree reading/writing is done through iomap interface. The
> > data itself are read to the inode's page cache. When XFS reads from this
> > region iomap doesn't call into fsverity to verify it against Merkle
> > tree. For data, verification is done on BIO completion in a workqueue.
> > 
> > When fs-verity is enabled on an inode, the XFS_IVERITY_CONSTRUCTION
> > flag is set meaning that the Merkle tree is being build. The
> > initialization ends with storing of verity descriptor and setting
> > inode on-disk flag (XFS_DIFLAG2_VERITY).
> 
> Might want to mention that XFS_DIFLAG2_VERITY sets S_VERITY, and that
> XFS_IVERITY_CONSTRUCTION gets dropped after construction ends.

added

> 
> > The descriptor is stored in a new block after the last Merkle tree
> > block. The size of the descriptor is stored at the end of the last
> > descriptor block (descriptor can be multiple blocks).
> 
> Huh, I would have thought the descriptor would go at 1<<53 and the
> merkle tree goes immediately afterwards but eh, whatever. :)

Yeah, I did it initially as it's easier to find both, descriptor and
tree. But it will cause problems if descriptor will ever grow in size
(current max is 16k).

> 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/xfs/Makefile        |   1 +
> >  fs/xfs/xfs_bmap_util.c |   7 +
> >  fs/xfs/xfs_fsverity.c  | 376 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/xfs/xfs_fsverity.h  |  12 +
> >  fs/xfs/xfs_message.c   |   4 +
> >  fs/xfs/xfs_message.h   |   1 +
> >  fs/xfs/xfs_super.c     |  14 +
> >  7 files changed, 415 insertions(+), 0 deletions(-)
> > 
> > diff --git a/fs/xfs/Makefile b/fs/xfs/Makefile
> > index 5bf501cf82..ad66439db7 100644
> > --- a/fs/xfs/Makefile
> > +++ b/fs/xfs/Makefile
> > @@ -147,6 +147,7 @@
> >  xfs-$(CONFIG_SYSCTL)		+= xfs_sysctl.o
> >  xfs-$(CONFIG_COMPAT)		+= xfs_ioctl32.o
> >  xfs-$(CONFIG_EXPORTFS_BLOCK_OPS)	+= xfs_pnfs.o
> > +xfs-$(CONFIG_FS_VERITY)		+= xfs_fsverity.o
> >  
> >  # notify failure
> >  ifeq ($(CONFIG_MEMORY_FAILURE),y)
> > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > index 2208a720ec..79a255a3ac 100644
> > --- a/fs/xfs/xfs_bmap_util.c
> > +++ b/fs/xfs/xfs_bmap_util.c
> > @@ -31,6 +31,7 @@
> >  #include "xfs_rtbitmap.h"
> >  #include "xfs_rtgroup.h"
> >  #include "xfs_zone_alloc.h"
> > +#include <linux/fsverity.h>
> >  
> >  /* Kernel only BMAP related definitions and functions */
> >  
> > @@ -554,6 +555,12 @@
> >  		return false;
> >  
> >  	/*
> > +	 * Nothing to clean on fsverity inodes as they are read-only
> > +	 */
> > +	if (IS_VERITY(VFS_I(ip)))
> > +		return false;
> > +
> > +	/*
> >  	 * Check if there is an post-EOF extent to free.  If there are any
> >  	 * delalloc blocks attached to the inode (data fork delalloc
> >  	 * reservations or CoW extents of any kind), we need to free them so
> > diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
> > new file mode 100644
> > index 0000000000..691dc60778
> > --- /dev/null
> > +++ b/fs/xfs/xfs_fsverity.c
> > @@ -0,0 +1,376 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2025 Red Hat, Inc.
> > + */
> > +#include "xfs.h"
> > +#include "xfs_shared.h"
> > +#include "xfs_format.h"
> > +#include "xfs_trans_resv.h"
> > +#include "xfs_mount.h"
> > +#include "xfs_da_format.h"
> > +#include "xfs_da_btree.h"
> > +#include "xfs_inode.h"
> > +#include "xfs_log_format.h"
> > +#include "xfs_bmap_util.h"
> > +#include "xfs_log_format.h"
> > +#include "xfs_trans.h"
> > +#include "xfs_trace.h"
> > +#include "xfs_quota.h"
> > +#include "xfs_fsverity.h"
> > +#include "xfs_iomap.h"
> > +#include <linux/fsverity.h>
> > +#include <linux/pagemap.h>
> > +
> > +static int
> > +xfs_fsverity_read(
> > +	struct inode	*inode,
> > +	void		*buf,
> > +	size_t		count,
> > +	loff_t		pos)
> > +{
> > +	struct folio	*folio;
> > +	size_t		n;
> > +
> > +	while (count) {
> > +		folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT,
> > +					 NULL);
> > +		if (IS_ERR(folio))
> > +			return PTR_ERR(folio);
> > +
> > +		n = memcpy_from_file_folio(buf, folio, pos, count);
> > +		folio_put(folio);
> > +
> > +		buf += n;
> > +		pos += n;
> > +		count -= n;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int
> > +xfs_fsverity_write(
> > +	struct xfs_inode	*ip,
> > +	loff_t			pos,
> > +	size_t			length,
> > +	const void		*buf)
> > +{
> > +	int			ret;
> > +	struct iov_iter		iter;
> > +	struct kvec		kvec = {
> > +		.iov_base	= (void *)buf,
> > +		.iov_len	= length,
> > +	};
> > +	struct kiocb		iocb = {
> > +		/* 
> > +		 * We don't have file here, but iomap_file_buffered_write uses
> > +		 * it only to obtain inode, so, pass inode as private arg
> > +		 * directly
> > +		 */
> 
> Oh, it occurs to me that fsverity doesn't take the struct file and pass
> it through to the per-fs implementation.  And that's why you had to
> resort to the trick of passing the struct inode in as "private" earlier.
> 
> I think that needs to get fixed, unfortunately it's a treewide change.
> What if you wrote a iomap_write_iter wrapper that skips all the iocb
> junk and just takes the inode/pos/len directly?

I will add a wrapper for now

> 
> > +		.ki_filp = NULL,
> > +		.ki_ioprio = get_current_ioprio(),
> > +		.ki_pos = pos,
> > +	};
> > +
> > +	iov_iter_kvec(&iter, WRITE, &kvec, 1, length);
> > +	ret = iomap_file_buffered_write(&iocb, &iter,
> > +			&xfs_buffered_write_iomap_ops, &xfs_iomap_write_ops,
> > +			VFS_I(ip));
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Retrieve the verity descriptor.
> > + */
> > +static int
> > +xfs_fsverity_get_descriptor(
> > +	struct inode		*inode,
> > +	void			*buf,
> > +	size_t			buf_size)
> > +{
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	__be32			d_desc_size;
> > +	u32			desc_size;
> > +	u64			desc_size_pos;
> > +	int			error;
> > +	u64			desc_pos;
> > +	struct xfs_bmbt_irec	rec;
> > +	int			is_empty;
> > +	uint32_t		blocksize = i_blocksize(VFS_I(ip));
> > +	xfs_fileoff_t		last_block;
> > +
> > +	ASSERT(inode->i_flags & S_VERITY);
> > +	error = xfs_bmap_last_extent(NULL, ip, XFS_DATA_FORK, &rec, &is_empty);
> > +	if (error)
> > +		return error;
> > +
> > +	if (is_empty)
> > +		return -ENODATA;
> > +
> > +	last_block = (rec.br_startoff + rec.br_blockcount);
> > +	desc_size_pos = (last_block << ip->i_mount->m_sb.sb_blocklog) -
> > +			sizeof(__be32);
> > +	error = xfs_fsverity_read(inode, (char *)&d_desc_size,
> > +				  sizeof(d_desc_size), desc_size_pos);
> > +	if (error)
> > +		return error;
> > +
> > +	desc_size = be32_to_cpu(d_desc_size);
> > +	if (desc_size > FS_VERITY_MAX_DESCRIPTOR_SIZE || desc_size > desc_size_pos)
> > +		return -ERANGE;
> > +
> > +	if (!buf_size)
> > +		return desc_size;
> > +
> > +	if (desc_size > buf_size)
> > +		return -ERANGE;
> > +
> > +	desc_pos = round_down(desc_size_pos - desc_size, blocksize);
> > +	error = xfs_fsverity_read(inode, buf, desc_size, desc_pos);
> > +	if (error)
> > +		return error;
> > +
> > +	return desc_size;
> > +}
> 
> You might want to wrap the integrity checks through XFS_IS_CORRUPT so
> that we get some logging on corrupt fsverity data.  Also, if descriptor
> corruption doesn't prevent iget from completing, then we ought to define
> a new health state for the xfs_inode so that it can report those kinds
> of failures via bulkstat.

sure, thanks! I will add XFS_IS_CORRUPT

> 
> > +
> > +static int
> > +xfs_fsverity_write_descriptor(
> > +	struct xfs_inode	*ip,
> > +	const void		*desc,
> > +	u32			desc_size,
> > +	u64			merkle_tree_size)
> > +{
> > +	int			error;
> > +	unsigned int		blksize = ip->i_mount->m_attr_geo->blksize;
> > +	u64			desc_pos = round_up(
> > +			XFS_FSVERITY_REGION_START | merkle_tree_size, blksize);
> > +	u64			desc_end = desc_pos + desc_size;
> > +	__be32			desc_size_disk = cpu_to_be32(desc_size);
> > +	u64			desc_size_pos =
> > +			round_up(desc_end + sizeof(desc_size_disk), blksize) -
> > +			sizeof(desc_size_disk);
> > +
> > +	error = xfs_fsverity_write(ip, desc_size_pos,
> > +				   sizeof(__be32),
> > +				   (const void *)&desc_size_disk);
> > +	if (error)
> > +		return error;
> > +
> > +	error = xfs_fsverity_write(ip, desc_pos, desc_size, desc);
> > +
> > +	return error;
> > +}
> > +
> > +/*
> > + * Try to remove all the fsverity metadata after a failed enablement.
> > + */
> > +static int
> > +xfs_fsverity_delete_metadata(
> > +	struct xfs_inode	*ip)
> > +{
> > +	struct xfs_trans	*tp;
> > +	struct xfs_mount	*mp = ip->i_mount;
> > +	int			error;
> > +
> > +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > +	if (error)
> > +		return error;
> > +
> > +	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> 
> The MMAPLOCK should be taken before the transaction allocation like
> everything else in xfs.

hmm, but is it needed for transaction? I meant to only wrap
xfs_truncate_page() with mmaplock

> 
> > +	error = xfs_truncate_page(ip, XFS_ISIZE(ip), NULL, NULL);
> > +	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > +
> > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > +	xfs_trans_ijoin(tp, ip, 0);
> > +
> > +	/*
> > +	 * We removing post EOF data, no need to update i_size
> > +	 */
> > +	error = xfs_itruncate_extents(&tp, ip, XFS_DATA_FORK, XFS_ISIZE(ip));
> > +	if (error)
> > +		goto err_cancel;
> > +
> > +	error = xfs_trans_commit(tp);
> > +	if (error)
> > +		goto err_cancel;
> > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > +
> > +	return error;
> > +
> > +err_cancel:
> > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > +	xfs_trans_cancel(tp);
> > +	return error;
> > +}
> > +
> > +
> > +/*
> > + * Prepare to enable fsverity by clearing old metadata.
> > + */
> > +static int
> > +xfs_fsverity_begin_enable(
> > +	struct file		*filp)
> > +{
> > +	struct inode		*inode = file_inode(filp);
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	int			error;
> > +
> > +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
> > +
> > +	if (IS_DAX(inode))
> > +		return -EINVAL;
> > +
> > +	if (inode->i_size > XFS_FSVERITY_REGION_START)
> > +		return -EFBIG;
> > +
> > +	if (xfs_iflags_test_and_set(ip, XFS_VERITY_CONSTRUCTION))
> > +		return -EBUSY;
> > +
> > +	error = xfs_qm_dqattach(ip);
> > +	if (error)
> > +		return error;
> > +
> > +	/*
> > +	 * Flush pagecache before building Merkle tree. Inode is locked and no
> > +	 * further writes will happen to the file except fsverity metadata
> 
> Don't we need to take the MMAPLOCK to prevent concurrent write faults?

will add it

> 
> > +	 */
> > +	error = filemap_write_and_wait(inode->i_mapping);
> > +	if (error)
> > +		return error;
> > +
> > +	return xfs_fsverity_delete_metadata(ip);
> > +}
> > +
> > +/*
> > + * Complete (or fail) the process of enabling fsverity.
> > + */
> > +static int
> > +xfs_fsverity_end_enable(
> > +	struct file		*filp,
> > +	const void		*desc,
> > +	size_t			desc_size,
> > +	u64			merkle_tree_size)
> > +{
> > +	struct inode		*inode = file_inode(filp);
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	struct xfs_mount	*mp = ip->i_mount;
> > +	struct xfs_trans	*tp;
> > +	int			error = 0;
> > +
> > +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
> > +
> > +	/* fs-verity failed, just cleanup */
> > +	if (desc == NULL)
> > +		goto out;
> > +
> > +	error = xfs_fsverity_write_descriptor(ip, desc, desc_size,
> > +					      merkle_tree_size);
> > +	if (error)
> > +		goto out;
> > +
> > +	/*
> > +	 * Wait for Merkle tree get written to disk before setting on-disk inode
> > +	 * flag and clearing XFS_VERITY_CONSTRUCTION
> > +	 */
> > +	error = filemap_write_and_wait(inode->i_mapping);
> > +	if (error)
> > +		goto out;
> > +
> > +	/*
> > +	 * Set fsverity inode flag
> > +	 */
> > +	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_ichange,
> > +			0, 0, false, &tp);
> > +	if (error)
> > +		goto out;
> > +
> > +	/*
> > +	 * Ensure that we've persisted the verity information before we enable
> > +	 * it on the inode and tell the caller we have sealed the inode.
> > +	 */
> > +	ip->i_diflags2 |= XFS_DIFLAG2_VERITY;
> > +
> > +	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
> > +	xfs_trans_set_sync(tp);
> > +
> > +	error = xfs_trans_commit(tp);
> > +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
> > +
> > +	if (!error)
> > +		inode->i_flags |= S_VERITY;
> > +
> > +out:
> > +	if (error) {
> > +		int	error2;
> > +
> > +		error2 = xfs_fsverity_delete_metadata(ip);
> > +		if (error2)
> > +			xfs_alert(ip->i_mount,
> > +"ino 0x%llx failed to clean up new fsverity metadata, err %d",
> > +					ip->i_ino, error2);
> > +	}
> > +
> > +	xfs_iflags_clear(ip, XFS_VERITY_CONSTRUCTION);
> > +	return error;
> > +}
> > +
> > +/*
> > + * Retrieve a merkle tree block.
> > + */
> > +static struct page *
> > +xfs_fsverity_read_merkle(
> > +	struct inode		*inode,
> > +	pgoff_t			index,
> > +	unsigned long		num_ra_pages)
> > +{
> > +	struct folio            *folio;
> > +	pgoff_t			offset =
> > +			index | (XFS_FSVERITY_REGION_START >> PAGE_SHIFT);
> > +
> > +	folio = __filemap_get_folio(inode->i_mapping, offset, FGP_ACCESSED, 0);
> > +	if (IS_ERR(folio) || !folio_test_uptodate(folio)) {
> > +		DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, offset);
> > +
> > +		if (!IS_ERR(folio))
> > +			folio_put(folio);
> > +		else if (num_ra_pages > 1)
> > +			page_cache_ra_unbounded(&ractl, num_ra_pages, 0);
> > +		folio = read_mapping_folio(inode->i_mapping, offset, NULL);
> > +		if (IS_ERR(folio))
> > +			return ERR_CAST(folio);
> > +	}
> > +	return folio_file_page(folio, offset);
> 
> Shouldn't this be some _BEYOND_EOF variant of generic_file_read_iter?

_BEYOND_EOF is set by xfs_iomap_read_begin() while mapping the
blocks, and also this uses _unbounded version of readhead to skip
EOF checks.

> 
> > +}
> > +
> > +/*
> > + * Write a merkle tree block.
> > + */
> > +static int
> > +xfs_fsverity_write_merkle(
> > +	struct inode		*inode,
> > +	const void		*buf,
> > +	u64			pos,
> > +	unsigned int		size)
> > +{
> > +	struct xfs_inode	*ip = XFS_I(inode);
> > +	loff_t			position = pos | XFS_FSVERITY_REGION_START;
> > +
> > +	if (position + size > inode->i_sb->s_maxbytes)
> > +		return -EFBIG;
> > +
> > +	return xfs_fsverity_write(ip, position, size, buf);
> > +}
> > +
> > +const ptrdiff_t info_offs = (int)offsetof(struct xfs_inode, i_verity_info) -
> > +			    (int)offsetof(struct xfs_inode, i_vnode);
> 
> I ... wow.
> 
> Not blaming you for writing this, just surprised that the common code
> makes you do that.
> 
> > +const struct fsverity_operations xfs_fsverity_ops = {
> > +	.inode_info_offs		= info_offs,
> > +	.begin_enable_verity		= xfs_fsverity_begin_enable,
> > +	.end_enable_verity		= xfs_fsverity_end_enable,
> > +	.get_verity_descriptor		= xfs_fsverity_get_descriptor,
> > +	.read_merkle_tree_page		= xfs_fsverity_read_merkle,
> > +	.write_merkle_tree_block	= xfs_fsverity_write_merkle,
> > +};
> > diff --git a/fs/xfs/xfs_fsverity.h b/fs/xfs/xfs_fsverity.h
> > new file mode 100644
> > index 0000000000..8b0d7ef456
> > --- /dev/null
> > +++ b/fs/xfs/xfs_fsverity.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2022 Red Hat, Inc.
> > + */
> > +#ifndef __XFS_FSVERITY_H__
> > +#define __XFS_FSVERITY_H__
> > +
> > +#ifdef CONFIG_FS_VERITY
> > +extern const struct fsverity_operations xfs_fsverity_ops;
> > +#endif	/* CONFIG_FS_VERITY */
> > +
> > +#endif	/* __XFS_FSVERITY_H__ */
> > diff --git a/fs/xfs/xfs_message.c b/fs/xfs/xfs_message.c
> > index 19aba2c3d5..17f0f0ca7b 100644
> > --- a/fs/xfs/xfs_message.c
> > +++ b/fs/xfs/xfs_message.c
> > @@ -161,6 +161,10 @@
> >  			.opstate	= XFS_OPSTATE_WARNED_ZONED,
> >  			.name		= "zoned RT device",
> >  		},
> > +		[XFS_EXPERIMENTAL_FSVERITY] = {
> > +			.opstate	= XFS_OPSTATE_WARNED_ZONED,
> > +			.name		= "fsverity",
> > +		},
> >  	};
> >  	ASSERT(feat >= 0 && feat < XFS_EXPERIMENTAL_MAX);
> >  	BUILD_BUG_ON(ARRAY_SIZE(features) != XFS_EXPERIMENTAL_MAX);
> > diff --git a/fs/xfs/xfs_message.h b/fs/xfs/xfs_message.h
> > index d68e72379f..1647d32ea4 100644
> > --- a/fs/xfs/xfs_message.h
> > +++ b/fs/xfs/xfs_message.h
> > @@ -96,6 +96,7 @@
> >  	XFS_EXPERIMENTAL_LBS,
> >  	XFS_EXPERIMENTAL_METADIR,
> >  	XFS_EXPERIMENTAL_ZONED,
> > +	XFS_EXPERIMENTAL_FSVERITY,
> >  
> >  	XFS_EXPERIMENTAL_MAX,
> >  };
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 10c6fc8d20..42a16b15a6 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -30,6 +30,7 @@
> >  #include "xfs_filestream.h"
> >  #include "xfs_quota.h"
> >  #include "xfs_sysfs.h"
> > +#include "xfs_fsverity.h"
> >  #include "xfs_ondisk.h"
> >  #include "xfs_rmap_item.h"
> >  #include "xfs_refcount_item.h"
> > @@ -54,6 +55,7 @@
> >  #include <linux/fs_context.h>
> >  #include <linux/fs_parser.h>
> >  #include <linux/fsverity.h>
> > +#include <linux/iomap.h>
> >  
> >  static const struct super_operations xfs_super_operations;
> >  
> > @@ -1706,6 +1708,9 @@
> >  	sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP | QTYPE_MASK_PRJ;
> >  #endif
> >  	sb->s_op = &xfs_super_operations;
> > +#ifdef CONFIG_FS_VERITY
> > +	sb->s_vop = &xfs_fsverity_ops;
> > +#endif
> >  
> >  	/*
> >  	 * Delay mount work if the debug hook is set. This is debug
> > @@ -1959,10 +1964,19 @@
> >  		xfs_set_resuming_quotaon(mp);
> >  	mp->m_qflags &= ~XFS_QFLAGS_MNTOPTS;
> >  
> > +	if (xfs_has_verity(mp))
> > +		xfs_warn_experimental(mp, XFS_EXPERIMENTAL_FSVERITY);
> > +
> >  	error = xfs_mountfs(mp);
> >  	if (error)
> >  		goto out_filestream_unmount;
> >  
> > +#ifdef CONFIG_FS_VERITY
> > +	error = iomap_fsverity_init_bioset();
> 
> if (xfs_has_verity()) ?

sure, will change it

-- 
- Andrey


