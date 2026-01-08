Return-Path: <linux-fsdevel+bounces-72835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC17D02FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 14:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F3CF3014D24
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 13:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94CB2E6CD2;
	Thu,  8 Jan 2026 13:14:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8BA4DD6F2;
	Thu,  8 Jan 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767878050; cv=none; b=Pxa40xFjAjydGS7Vbf6QE3aCFwVl3SeXACRYAA2Z5UI4D8dS+ZjmG3TZ+EIVHbAjg3pQdSLGuYheKzyWguQAtB4+r9Q/tOWyQpkjeKWPZSRlwnjL1qQdhJuPAB9Wck0L+UGK7O/JXLW6gBjdBxyNpKXMMVJGIeGTWpOGUfZrSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767878050; c=relaxed/simple;
	bh=ls/jocNT+3Zn6eYSRzzEne7Znx9y250T/xjjbq/sfHg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4W2LSGL+zEUzEfcjZ+NCRxfmZhV1JxxpKn7uhXMF7a+jTgG33EenSTEw1usHee43UfacsPK5lSog3R/imNBmQA79yha4dt5xHI641U4uW1ikkFbp8Pq4zn+gPvlDXMc/xGq7PbDPHezI4HcDrdRCZTX4tBCDZKGo9mF2pGDkUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn52W2rNWzHnGjq;
	Thu,  8 Jan 2026 21:13:55 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 897C840086;
	Thu,  8 Jan 2026 21:14:03 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 13:14:01 +0000
Date: Thu, 8 Jan 2026 13:14:00 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: John Groves <John@Groves.net>
CC: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams
	<dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, "Alison
 Schofield" <alison.schofield@intel.com>, John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, "David
 Hildenbrand" <david@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Stefan
 Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, Josef
 Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, Chen
 Linxuan <chenlinxuan@uniontech.com>, "James Morse" <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>, "Sean Christopherson" <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>, Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>, Aravind Ramesh <arramesh@micron.com>, Ajay
 Joshi <ajayjoshi@micron.com>, <venkataravis@micron.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V3 15/21] famfs_fuse: Create files with famfs fmaps
Message-ID: <20260108131400.000017f5@huawei.com>
In-Reply-To: <20260107153332.64727-16-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-16-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:24 -0600
John Groves <John@Groves.net> wrote:

> On completion of GET_FMAP message/response, setup the full famfs
> metadata such that it's possible to handle read/write/mmap directly to
> dax. Note that the devdax_iomap plumbing is not in yet...
> 
> * Add famfs_kfmap.h: in-memory structures for resolving famfs file maps
>   (fmaps) to dax.
> * famfs.c: allocate, initialize and free fmaps
> * inode.c: only allow famfs mode if the fuse server has CAP_SYS_RAWIO
> * Update MAINTAINERS for the new files.
> 
> Signed-off-by: John Groves <john@groves.net>

> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index 0f7e3f00e1e7..2aabd1d589fd 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c
> @@ -17,9 +17,355 @@
>  #include <linux/namei.h>
>  #include <linux/string.h>
>  
> +#include "famfs_kfmap.h"
>  #include "fuse_i.h"
>  
>  
> +/***************************************************************************/
Who doesn't like stars?  Why have them here?

> +
> +void
> +__famfs_meta_free(void *famfs_meta)

Maybe a local convention, but if not one line.
Same for other cases.

> +{
> +	struct famfs_file_meta *fmap = famfs_meta;
> +
> +	if (!fmap)
> +		return;
> +
> +	if (fmap) {

Well that's never going to fail given 2 lines above.


> +		switch (fmap->fm_extent_type) {
> +		case SIMPLE_DAX_EXTENT:
> +			kfree(fmap->se);
> +			break;
> +		case INTERLEAVED_EXTENT:
> +			if (fmap->ie)
> +				kfree(fmap->ie->ie_strips);
> +
> +			kfree(fmap->ie);
> +			break;
> +		default:
> +			pr_err("%s: invalid fmap type\n", __func__);
> +			break;
> +		}
> +	}
> +	kfree(fmap);
> +}

> +/**
> + * famfs_fuse_meta_alloc() - Allocate famfs file metadata
> + * @metap:       Pointer to an mcache_map_meta pointer
> + * @ext_count:  The number of extents needed

run kernel-doc over the file as that's not the parameters...

> + *
> + * Returns: 0=success
> + *          -errno=failure
> + */
> +static int
> +famfs_fuse_meta_alloc(
> +	void *fmap_buf,
> +	size_t fmap_buf_size,
> +	struct famfs_file_meta **metap)
> +{
> +	struct famfs_file_meta *meta = NULL;
> +	struct fuse_famfs_fmap_header *fmh;
> +	size_t extent_total = 0;
> +	size_t next_offset = 0;
> +	int errs = 0;
> +	int i, j;
> +	int rc;
> +
> +	fmh = (struct fuse_famfs_fmap_header *)fmap_buf;

void * so cast not needed and hence just assign it at the
declaration.

> +
> +	/* Move past fmh in fmap_buf */
> +	next_offset += sizeof(*fmh);
> +	if (next_offset > fmap_buf_size) {
> +		pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> +		       __func__, __LINE__, next_offset, fmap_buf_size);
> +		return -EINVAL;
> +	}
> +
> +	if (fmh->nextents < 1) {
> +		pr_err("%s: nextents %d < 1\n", __func__, fmh->nextents);
> +		return -EINVAL;
> +	}
> +
> +	if (fmh->nextents > FUSE_FAMFS_MAX_EXTENTS) {
> +		pr_err("%s: nextents %d > max (%d) 1\n",
> +		       __func__, fmh->nextents, FUSE_FAMFS_MAX_EXTENTS);
> +		return -E2BIG;
> +	}
> +
> +	meta = kzalloc(sizeof(*meta), GFP_KERNEL);

Maybe sprinkle some __free magic on this then you can return in
all the goto error_out places which to me makes this more readable.

> +	if (!meta)
> +		return -ENOMEM;
> +
> +	meta->error = false;
> +	meta->file_type = fmh->file_type;
> +	meta->file_size = fmh->file_size;
> +	meta->fm_extent_type = fmh->ext_type;
> +
> +	switch (fmh->ext_type) {
> +	case FUSE_FAMFS_EXT_SIMPLE: {
> +		struct fuse_famfs_simple_ext *se_in;
> +
> +		se_in = (struct fuse_famfs_simple_ext *)(fmap_buf + next_offset);

void * so no need for cast. Though you could keep the cast but apply it to
fmh + 1 to take advantage of that type.


> +
> +		/* Move past simple extents */
> +		next_offset += fmh->nextents * sizeof(*se_in);
> +		if (next_offset > fmap_buf_size) {
> +			pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> +			       __func__, __LINE__, next_offset, fmap_buf_size);
> +			rc = -EINVAL;
> +			goto errout;
> +		}
> +
> +		meta->fm_nextents = fmh->nextents;
> +
> +		meta->se = kcalloc(meta->fm_nextents, sizeof(*(meta->se)),
> +				   GFP_KERNEL);
> +		if (!meta->se) {
> +			rc = -ENOMEM;
> +			goto errout;
> +		}
> +
> +		if ((meta->fm_nextents > FUSE_FAMFS_MAX_EXTENTS) ||
> +		    (meta->fm_nextents < 1)) {
> +			rc = -EINVAL;
> +			goto errout;
> +		}
> +
> +		for (i = 0; i < fmh->nextents; i++) {
> +			meta->se[i].dev_index  = se_in[i].se_devindex;
> +			meta->se[i].ext_offset = se_in[i].se_offset;
> +			meta->se[i].ext_len    = se_in[i].se_len;
> +
> +			/* Record bitmap of referenced daxdev indices */
> +			meta->dev_bitmap |= (1 << meta->se[i].dev_index);
> +
> +			errs += famfs_check_ext_alignment(&meta->se[i]);
> +
> +			extent_total += meta->se[i].ext_len;
> +		}
> +		break;
> +	}
> +
> +	case FUSE_FAMFS_EXT_INTERLEAVE: {
> +		s64 size_remainder = meta->file_size;
> +		struct fuse_famfs_iext *ie_in;
> +		int niext = fmh->nextents;
> +
> +		meta->fm_niext = niext;
> +
> +		/* Allocate interleaved extent */
> +		meta->ie = kcalloc(niext, sizeof(*(meta->ie)), GFP_KERNEL);
> +		if (!meta->ie) {
> +			rc = -ENOMEM;
> +			goto errout;
> +		}
> +
> +		/*
> +		 * Each interleaved extent has a simple extent list of strips.
> +		 * Outer loop is over separate interleaved extents
> +		 */
> +		for (i = 0; i < niext; i++) {
> +			u64 nstrips;
> +			struct fuse_famfs_simple_ext *sie_in;
> +
> +			/* ie_in = one interleaved extent in fmap_buf */
> +			ie_in = (struct fuse_famfs_iext *)
> +				(fmap_buf + next_offset);

void * so no cast needed.

> +
> +			/* Move past one interleaved extent header in fmap_buf */
> +			next_offset += sizeof(*ie_in);
> +			if (next_offset > fmap_buf_size) {
> +				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> +				       __func__, __LINE__, next_offset,
> +				       fmap_buf_size);
> +				rc = -EINVAL;
> +				goto errout;
> +			}
> +
> +			nstrips = ie_in->ie_nstrips;
> +			meta->ie[i].fie_chunk_size = ie_in->ie_chunk_size;
> +			meta->ie[i].fie_nstrips    = ie_in->ie_nstrips;
> +			meta->ie[i].fie_nbytes     = ie_in->ie_nbytes;
> +
> +			if (!meta->ie[i].fie_nbytes) {
> +				pr_err("%s: zero-length interleave!\n",
> +				       __func__);
> +				rc = -EINVAL;
> +				goto errout;
> +			}
> +
> +			/* sie_in = the strip extents in fmap_buf */
> +			sie_in = (struct fuse_famfs_simple_ext *)
> +				(fmap_buf + next_offset);
no cast needed.

> +
> +			/* Move past strip extents in fmap_buf */
> +			next_offset += nstrips * sizeof(*sie_in);
> +			if (next_offset > fmap_buf_size) {
> +				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> +				       __func__, __LINE__, next_offset,
> +				       fmap_buf_size);
> +				rc = -EINVAL;
> +				goto errout;
> +			}
> +
> +			if ((nstrips > FUSE_FAMFS_MAX_STRIPS) || (nstrips < 1)) {
> +				pr_err("%s: invalid nstrips=%lld (max=%d)\n",
> +				       __func__, nstrips,
> +				       FUSE_FAMFS_MAX_STRIPS);
> +				errs++;
> +			}
> +
> +			/* Allocate strip extent array */
> +			meta->ie[i].ie_strips = kcalloc(ie_in->ie_nstrips,
> +					sizeof(meta->ie[i].ie_strips[0]),
> +							GFP_KERNEL);

Align all lines after 1st one to same point.

...

> +
> +/**
> + * famfs_file_init_dax() - init famfs dax file metadata
> + *
> + * @fm:        fuse_mount
> + * @inode:     the inode
> + * @fmap_buf:  fmap response message
> + * @fmap_size: Size of the fmap message
> + *
> + * Initialize famfs metadata for a file, based on the contents of the GET_FMAP
> + * response
> + *
> + * Return: 0=success
> + *          -errno=failure
> + */
> +int
> +famfs_file_init_dax(
> +	struct fuse_mount *fm,
> +	struct inode *inode,
> +	void *fmap_buf,
> +	size_t fmap_size)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct famfs_file_meta *meta = NULL;
> +	int rc = 0;

Always set before use.

> +
> +	if (fi->famfs_meta) {
> +		pr_notice("%s: i_no=%ld fmap_size=%ld ALREADY INITIALIZED\n",
> +			  __func__,
> +			  inode->i_ino, fmap_size);
> +		return 0;
> +	}
> +
> +	rc = famfs_fuse_meta_alloc(fmap_buf, fmap_size, &meta);
> +	if (rc)
> +		goto errout;
> +
> +	/* Publish the famfs metadata on fi->famfs_meta */
> +	inode_lock(inode);
> +	if (fi->famfs_meta) {
> +		rc = -EEXIST; /* file already has famfs metadata */
> +	} else {
> +		if (famfs_meta_set(fi, meta) != NULL) {
> +			pr_debug("%s: file already had metadata\n", __func__);
> +			__famfs_meta_free(meta);
> +			/* rc is 0 - the file is valid */
> +			goto unlock_out;
> +		}
> +		i_size_write(inode, meta->file_size);
> +		inode->i_flags |= S_DAX;
> +	}
> + unlock_out:
> +	inode_unlock(inode);
> +
> +errout:
> +	if (rc)
> +		__famfs_meta_free(meta);

For readability I'd split he good and bad exit paths even it unlock
needs to happen in two places.


> +
> +	return rc;
> +}
> +

> diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> new file mode 100644
> index 000000000000..058645cb10a1
> --- /dev/null
> +++ b/fs/fuse/famfs_kfmap.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * famfs - dax file system for shared fabric-attached memory
> + *
> + * Copyright 2023-2025 Micron Technology, Inc.
> + */
> +#ifndef FAMFS_KFMAP_H
> +#define FAMFS_KFMAP_H
> +
> +/*
> + * The structures below are the in-memory metadata format for famfs files.
> + * Metadata retrieved via the GET_FMAP response is converted to this format
> + * for use in  resolving file mapping faults.

bonus space after in

> + *
> + * The GET_FMAP response contains the same information, but in a more
> + * message-and-versioning-friendly format. Those structs can be found in the
> + * famfs section of include/uapi/linux/fuse.h (aka fuse_kernel.h in libfuse)
> + */

> +/*
> + * Each famfs dax file has this hanging from its fuse_inode->famfs_meta
> + */
> +struct famfs_file_meta {
> +	bool                   error;
> +	enum famfs_file_type   file_type;
> +	size_t                 file_size;
> +	enum famfs_extent_type fm_extent_type;
> +	u64 dev_bitmap; /* bitmap of referenced daxdevs by index */
> +	union { /* This will make code a bit more readable */

Not sure what the comment is for. I'd drop it.


> +		struct {
> +			size_t         fm_nextents;
> +			struct famfs_meta_simple_ext  *se;
> +		};
> +		struct {
> +			size_t         fm_niext;
> +			struct famfs_meta_interleaved_ext *ie;
> +		};
> +	};
> +};
> +
> +#endif /* FAMFS_KFMAP_H */

