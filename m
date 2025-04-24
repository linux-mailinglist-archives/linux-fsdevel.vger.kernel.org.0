Return-Path: <linux-fsdevel+bounces-47244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8890A9AF8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0467B1731A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E618DB1C;
	Thu, 24 Apr 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+U2y4f8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809DB1714C6;
	Thu, 24 Apr 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502219; cv=none; b=WyAp/dXmA2D7syYZsf8iAXF0jY6lrxFGvHDirDrXb6ynJJihgHpkdNY44HkWUZeUBpKDGCzobUW0ASCxmG4dY3FubzdKOdNCJrMW+pY/eiVBHos8rIckD8WXUtiKicOCPGsxQsj3/xeQP9VbVv48KLcUrXJ921XWcqOGfNIuZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502219; c=relaxed/simple;
	bh=SJVPpi9BP39UGfSTUPj6HIVoTdrinIJLetEiCVKgFLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOv2o3koyS54sPD/zoda8AtTZGsfkJ6c75TSseNdx57BWREmqOqO2yZWHGml740SjPqAMxzG7grT+IfbHSau9AIuQE1E5hYNq6wl97onfEmuQqUGBSrF4SOBzTqV/ji8CfKnPUIg2LPri+LIyL7nuSoJ+zkKaQEcng9gr3JXCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+U2y4f8; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-400fa6b3012so1286790b6e.1;
        Thu, 24 Apr 2025 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745502216; x=1746107016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ccfLv/uuCGICTqyOHxS42TWN7u3S237rEDNLPwYXGUA=;
        b=e+U2y4f8PUGYGYi1LGdqDMCM/OVRIfvWdOXqT8MHgqfl3T6HrcAovo8xExDeuINsJe
         EjrbO3FAaWS2LYF2ssDxzIVCHVetIa0nMZnh0n/A/XJMJ/tzg9oyT8B8RyLuimx5L2+i
         N5KFurxhqzVaxl7h+WPfiB9T1vverox+i98tuDX5ZCPtOolsF9C/VBRn3qowG6xl8T6L
         hpCi8+ZqMVSuKg/goVeB9UAZ+z/VxyOntido/irjxdCAsvYSeOLPNKDoXpDFA9GrOoGy
         S/AYLJRIn/+egVBsrwuyLbSlHn9Mpk9+TyNdtVqKl9F+dKgbKHFys0VCZgh/EcFCRg0A
         d24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745502216; x=1746107016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccfLv/uuCGICTqyOHxS42TWN7u3S237rEDNLPwYXGUA=;
        b=ItGqAFLlC0a7ZSKVmSvzHPMoAJ6MgD02F4mJu3Q8M16ORAAglFl8PLIwf+puDeTBNu
         ZldMeiphX8ytGoyHLlgdXbF41kV+fNnh6l9hVE7iG5Zv3dQVGj+e1JpVLPHBU+ApgPU9
         iu9TNz+pP4KbC/h3QMDHi3+DotBwGtMrkLO4syDvnOG/CLCVVRtVeFnt9+vfn2ujhM5S
         GdYqOtU4jdMpO4qbHuJMF+HXew/GWxRPdmEaxnTWKVq81w0Vj0XvaEkODOhNLfAi3yS8
         C7ExVeMc0KEio33r0Jt2lYw4IYmqWiqBTxE8fOFhB3fuCXkj7JgTH4etf28mD5fkD+rR
         S1cg==
X-Forwarded-Encrypted: i=1; AJvYcCU3aPVgTgWwT4xWR1kihimJBNvM1P+EMH0Q/+Lp7pUq5Qm/Ivig2LuX4glL7oLtU0Xnqo133buRf6NGa+S0@vger.kernel.org, AJvYcCVjIBFA7C9UEtHT3/rfB/YAnCsU87MDyPJ311/K1cmr5jWy8sYy6EBVkPFhQUgIjcpaDIZMHffCh/qf@vger.kernel.org, AJvYcCVrEOo/8TX2LO4NXQSBIHu9uUbkJkcizzqsjdCZGoB3ZuBxQ0Zqugh4a/2qEQ8j+Kjv695+5kWzVaDNtGnZAw==@vger.kernel.org, AJvYcCW8H75+dA9EHdsTzSietq3rvPcX7QalbQPd1bs3a04AN57gq3fhBi7QMAYoXi3g5yMrmA1oQ5NfQRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxpSE6gB/n7FfsICrFsu03cPykMwydrryAqq3OiIe7ktUT8Evj
	hBVQG6AGxASFR8VuJgB7blJoa83sF3Gh/K0cQ7IHBW2Kbp9Oezgxxe9OGLXUaeE=
X-Gm-Gg: ASbGncuxPIedJMy5zA052VfxEYsMTs/p1EiJvDqb9vkGDR2l1SMUVCvkrbZc4hW6UCz
	ye5tF8vNKSej+x6Zpm/C+9d3bJ/gh8qE/+CpierAIgQozje0YjFOK8Ry3yE3izKDfDwbhBDA1Cn
	sHSt71Rv74woPdrakZyVMM0de9q6eY883mmx3BDiz6ij5e4Jxbeh1CQS/HRw6/MCrWkYovCgEuZ
	HR3FOH6OYtTfkWBUE8V90s7rw/0yhA0oXiDeLZSrO84JZZ13y9YylXDMRwq/9X9xmZwW5x4ZRwr
	qXA7vD6Re2HWlvhxq1liSLMPNz9HcMBldOpWKwj95Mv37+kjXQpzsJYUBvGc
X-Google-Smtp-Source: AGHT+IGTZrw02O707vTuxc6FPfd5PdhyoeK6pVEFZkZwN+bLDouAKZdOL11yjEeHU8ZNMQnHrtzufw==
X-Received: by 2002:a05:6808:2f13:b0:3f4:11b3:206b with SMTP id 5614622812f47-401ec5354f9mr1472229b6e.17.1745502216274;
        Thu, 24 Apr 2025 06:43:36 -0700 (PDT)
Received: from Borg-550.local ([2603:8080:1500:3d89:3937:298c:3ce2:13d8])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401ec970ec5sm244933b6e.34.2025.04.24.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:43:35 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 24 Apr 2025 08:43:33 -0500
From: John Groves <John@groves.net>
To: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-14-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421013346.32530-14-john@groves.net>

On 25/04/20 08:33PM, John Groves wrote:
> On completion of GET_FMAP message/response, setup the full famfs
> metadata such that it's possible to handle read/write/mmap directly to
> dax. Note that the devdax_iomap plumbing is not in yet...
> 
> Update MAINTAINERS for the new files.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  MAINTAINERS               |   9 +
>  fs/fuse/Makefile          |   2 +-
>  fs/fuse/dir.c             |   3 +
>  fs/fuse/famfs.c           | 344 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/famfs_kfmap.h     |  63 +++++++
>  fs/fuse/fuse_i.h          |  16 +-
>  fs/fuse/inode.c           |   2 +-
>  include/uapi/linux/fuse.h |  42 +++++
>  8 files changed, 477 insertions(+), 4 deletions(-)
>  create mode 100644 fs/fuse/famfs.c
>  create mode 100644 fs/fuse/famfs_kfmap.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00e94bec401e..2a5a7e0e8b28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8808,6 +8808,15 @@ F:	Documentation/networking/failover.rst
>  F:	include/net/failover.h
>  F:	net/core/failover.c
>  
> +FAMFS
> +M:	John Groves <jgroves@micron.com>
> +M:	John Groves <John@Groves.net>
> +L:	linux-cxl@vger.kernel.org
> +L:	linux-fsdevel@vger.kernel.org
> +S:	Supported
> +F:	fs/fuse/famfs.c
> +F:	fs/fuse/famfs_kfmap.h
> +
>  FANOTIFY
>  M:	Jan Kara <jack@suse.cz>
>  R:	Amir Goldstein <amir73il@gmail.com>
> diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> index 3f0f312a31c1..65a12975d734 100644
> --- a/fs/fuse/Makefile
> +++ b/fs/fuse/Makefile
> @@ -16,5 +16,5 @@ fuse-$(CONFIG_FUSE_DAX) += dax.o
>  fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
>  fuse-$(CONFIG_SYSCTL) += sysctl.o
>  fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
> -
> +fuse-$(CONFIG_FUSE_FAMFS_DAX) += famfs.o
>  virtiofs-y := virtio_fs.o
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ae135c55b9f6..b28a1e912d6b 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -405,6 +405,9 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
>  	fmap_size = args.out_args[0].size;
>  	pr_notice("%s: nodei=%lld fmap_size=%ld\n", __func__, nodeid, fmap_size);
>  
> +	/* Convert fmap into in-memory format and hang from inode */
> +	famfs_file_init_dax(fm, inode, fmap_buf, fmap_size);
> +
>  	return 0;
>  }
>  #endif
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> new file mode 100644
> index 000000000000..e62c047d0950
> --- /dev/null
> +++ b/fs/fuse/famfs.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * famfs - dax file system for shared fabric-attached memory
> + *
> + * Copyright 2023-2025 Micron Technology, Inc.
> + *
> + * This file system, originally based on ramfs the dax support from xfs,
> + * is intended to allow multiple host systems to mount a common file system
> + * view of dax files that map to shared memory.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/mm.h>
> +#include <linux/dax.h>
> +#include <linux/iomap.h>
> +#include <linux/path.h>
> +#include <linux/namei.h>
> +#include <linux/string.h>
> +
> +#include "famfs_kfmap.h"
> +#include "fuse_i.h"
> +
> +
> +void
> +__famfs_meta_free(void *famfs_meta)
> +{
> +	struct famfs_file_meta *fmap = famfs_meta;
> +
> +	if (!fmap)
> +		return;
> +
> +	if (fmap) {
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
> +
> +static int
> +famfs_check_ext_alignment(struct famfs_meta_simple_ext *se)
> +{
> +	int errs = 0;
> +
> +	if (se->dev_index != 0)
> +		errs++;
> +
> +	/* TODO: pass in alignment so we can support the other page sizes */
> +	if (!IS_ALIGNED(se->ext_offset, PMD_SIZE))
> +		errs++;
> +
> +	if (!IS_ALIGNED(se->ext_len, PMD_SIZE))
> +		errs++;
> +
> +	return errs;
> +}
> +
> +/**
> + * famfs_meta_alloc() - Allocate famfs file metadata
> + * @metap:       Pointer to an mcache_map_meta pointer
> + * @ext_count:  The number of extents needed
> + */
> +static int
> +famfs_meta_alloc_v3(
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
> +
> +	/* Move past fmh in fmap_buf */
> +	next_offset += sizeof(*fmh);
> +	if (next_offset > fmap_buf_size) {
> +		pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> +		       __func__, __LINE__, next_offset, fmap_buf_size);
> +		rc = -EINVAL;
> +		goto errout;
> +	}
> +
> +	if (fmh->nextents < 1) {
> +		pr_err("%s: nextents %d < 1\n", __func__, fmh->nextents);
> +		rc = -EINVAL;
> +		goto errout;
> +	}
> +
> +	if (fmh->nextents > FUSE_FAMFS_MAX_EXTENTS) {
> +		pr_err("%s: nextents %d > max (%d) 1\n",
> +		       __func__, fmh->nextents, FUSE_FAMFS_MAX_EXTENTS);
> +		rc = -E2BIG;
> +		goto errout;
> +	}
> +
> +	meta = kzalloc(sizeof(*meta), GFP_KERNEL);
> +	if (!meta)
> +		return -ENOMEM;
> +	meta->error = false;
> +
> +	meta->file_type = fmh->file_type;
> +	meta->file_size = fmh->file_size;
> +	meta->fm_extent_type = fmh->ext_type;
> +
> +	switch (fmh->ext_type) {
> +	case FUSE_FAMFS_EXT_SIMPLE: {
> +		struct fuse_famfs_simple_ext *se_in;
> +
> +		se_in = (struct fuse_famfs_simple_ext *)(fmap_buf + next_offset);
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
> +
> +			/* Move past one interleaved extent header in fmap_buf */
> +			next_offset += sizeof(*ie_in);
> +			if (next_offset > fmap_buf_size) {
> +				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> +				       __func__, __LINE__, next_offset, fmap_buf_size);
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
> +
> +			/* Move past strip extents in fmap_buf */
> +			next_offset += nstrips * sizeof(*sie_in);
> +			if (next_offset > fmap_buf_size) {
> +				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> +				       __func__, __LINE__, next_offset, fmap_buf_size);
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
> +			if (!meta->ie[i].ie_strips) {
> +				rc = -ENOMEM;
> +				goto errout;
> +			}
> +
> +			/* Inner loop is over strips */
> +			for (j = 0; j < nstrips; j++) {
> +				struct famfs_meta_simple_ext *strips_out;
> +				u64 devindex = sie_in[j].se_devindex;
> +				u64 offset   = sie_in[j].se_offset;
> +				u64 len      = sie_in[j].se_len;
> +
> +				strips_out = meta->ie[i].ie_strips;
> +				strips_out[j].dev_index  = devindex;
> +				strips_out[j].ext_offset = offset;
> +				strips_out[j].ext_len    = len;
> +
> +				/* Record bitmap of referenced daxdev indices */
> +				meta->dev_bitmap |= (1 << devindex);
> +
> +				extent_total += len;
> +				errs += famfs_check_ext_alignment(&strips_out[j]);
> +				size_remainder -= len;
> +			}
> +		}
> +
> +		if (size_remainder > 0) {
> +			/* Sum of interleaved extent sizes is less than file size! */
> +			pr_err("%s: size_remainder %lld (0x%llx)\n",
> +			       __func__, size_remainder, size_remainder);
> +			rc = -EINVAL;
> +			goto errout;
> +		}
> +		break;
> +	}
> +
> +	default:
> +		pr_err("%s: invalid ext_type %d\n", __func__, fmh->ext_type);
> +		rc = -EINVAL;
> +		goto errout;
> +	}
> +
> +	if (errs > 0) {
> +		pr_err("%s: %d alignment errors found\n", __func__, errs);
> +		rc = -EINVAL;
> +		goto errout;
> +	}
> +
> +	/* More sanity checks */
> +	if (extent_total < meta->file_size) {
> +		pr_err("%s: file size %ld larger than map size %ld\n",
> +		       __func__, meta->file_size, extent_total);
> +		rc = -EINVAL;
> +		goto errout;
> +	}
> +
> +	*metap = meta;
> +
> +	return 0;
> +errout:
> +	__famfs_meta_free(meta);
> +	return rc;
> +}
> +
> +int
> +famfs_file_init_dax(
> +	struct fuse_mount *fm,
> +	struct inode *inode,
> +	void *fmap_buf,
> +	size_t fmap_size)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct famfs_file_meta *meta = NULL;
> +	int rc;
> +
> +	if (fi->famfs_meta) {
> +		pr_notice("%s: i_no=%ld fmap_size=%ld ALREADY INITIALIZED\n",
> +			  __func__,
> +			  inode->i_ino, fmap_size);
> +		return -EEXIST;
> +	}
> +
> +	rc = famfs_meta_alloc_v3(fmap_buf, fmap_size, &meta);
> +	if (rc)
> +		goto errout;
> +
> +	/* Publish the famfs metadata on fi->famfs_meta */
> +	inode_lock(inode);
> +	if (fi->famfs_meta) {
> +		rc = -EEXIST; /* file already has famfs metadata */
> +	} else {
> +		if (famfs_meta_set(fi, meta) != NULL) {
> +			pr_err("%s: file already had metadata\n", __func__);
> +			rc = -EALREADY;
> +			goto errout;
> +		}
> +		i_size_write(inode, meta->file_size);
> +		inode->i_flags |= S_DAX;
> +	}
> +	inode_unlock(inode);
> +
> + errout:
> +	if (rc)
> +		__famfs_meta_free(meta);
> +
> +	return rc;
> +}
> +
> diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> new file mode 100644
> index 000000000000..ce785d76719c
> --- /dev/null
> +++ b/fs/fuse/famfs_kfmap.h
> @@ -0,0 +1,63 @@
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
> + * These structures are the in-memory metadata format for famfs files. Metadata
> + * retrieved via the GET_FMAP response is converted to this format for use in
> + * resolving file mapping faults.
> + */
> +
> +enum famfs_file_type {
> +	FAMFS_REG,
> +	FAMFS_SUPERBLOCK,
> +	FAMFS_LOG,
> +};
> +
> +/* We anticipate the possiblity of supporting additional types of extents */
> +enum famfs_extent_type {
> +	SIMPLE_DAX_EXTENT,
> +	INTERLEAVED_EXTENT,
> +	INVALID_EXTENT_TYPE,
> +};
> +
> +struct famfs_meta_simple_ext {
> +	u64 dev_index;
> +	u64 ext_offset;
> +	u64 ext_len;
> +};
> +
> +struct famfs_meta_interleaved_ext {
> +	u64 fie_nstrips;
> +	u64 fie_chunk_size;
> +	u64 fie_nbytes;
> +	struct famfs_meta_simple_ext *ie_strips;
> +};
> +
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
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 437177c2f092..d8e0ac784224 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1557,11 +1557,18 @@ extern void fuse_sysctl_unregister(void);
>  #endif /* CONFIG_SYSCTL */
>  
>  /* famfs.c */
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +int famfs_file_init_dax(struct fuse_mount *fm,
> +			     struct inode *inode, void *fmap_buf,
> +			     size_t fmap_size);
> +void __famfs_meta_free(void *map);
> +#endif
> +
>  static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
>  						       void *meta)
>  {
>  #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> -	return xchg(&fi->famfs_meta, meta);
> +	return cmpxchg(&fi->famfs_meta, NULL, meta);
>  #else
>  	return NULL;
>  #endif
> @@ -1569,7 +1576,12 @@ static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
>  
>  static inline void famfs_meta_free(struct fuse_inode *fi)
>  {
> -	/* Stub wil be connected in a subsequent commit */
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	if (fi->famfs_meta != NULL) {
> +		__famfs_meta_free(fi->famfs_meta);
> +		famfs_meta_set(fi, NULL);
> +	}
> +#endif
>  }
>  
>  static inline int fuse_file_famfs(struct fuse_inode *fi)
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 848c8818e6f7..e86bf330117f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -118,7 +118,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
>  		fuse_inode_backing_set(fi, NULL);
>  
>  	if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> -		famfs_meta_set(fi, NULL);
> +		fi->famfs_meta = NULL; /* XXX new inodes currently not zeroed; why not? */
>  
>  	return &fi->inode;
>  
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d85fb692cf3b..0f6ff1ffb23d 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -1286,4 +1286,46 @@ struct fuse_uring_cmd_req {
>  	uint8_t padding[6];
>  };
>  
> +/* Famfs fmap message components */
> +
> +#define FAMFS_FMAP_VERSION 1
> +
> +#define FUSE_FAMFS_MAX_EXTENTS 2
> +#define FUSE_FAMFS_MAX_STRIPS 16

FYI, after thinking through the conversation with Darrick,  I'm planning 
to drop FUSE_FAMFS_MAX_(EXTENTS|STRIPS) in the next version.  In the 
response to GET_FMAP, it's the structures below serialized into a message 
buffer. If it fits, it's good - and if not it's invalid. When the
in-memory metadata (defined in famfs_kfmap.h) gets assembled, if there is
a reason to apply limits it can be done - but I don't currently see a reason
do to that (so if I'm currently enforcing limits there, I'll probably drop
that.


> +
> +enum fuse_famfs_file_type {
> +	FUSE_FAMFS_FILE_REG,
> +	FUSE_FAMFS_FILE_SUPERBLOCK,
> +	FUSE_FAMFS_FILE_LOG,
> +};
> +
> +enum famfs_ext_type {
> +	FUSE_FAMFS_EXT_SIMPLE = 0,
> +	FUSE_FAMFS_EXT_INTERLEAVE = 1,
> +};
> +
> +struct fuse_famfs_simple_ext {
> +	uint32_t se_devindex;
> +	uint32_t reserved;
> +	uint64_t se_offset;
> +	uint64_t se_len;
> +};
> +
> +struct fuse_famfs_iext { /* Interleaved extent */
> +	uint32_t ie_nstrips;
> +	uint32_t ie_chunk_size;
> +	uint64_t ie_nbytes; /* Total bytes for this interleaved_ext; sum of strips may be more */
> +	uint64_t reserved;
> +};
> +
> +struct fuse_famfs_fmap_header {
> +	uint8_t file_type; /* enum famfs_file_type */
> +	uint8_t reserved;
> +	uint16_t fmap_version;
> +	uint32_t ext_type; /* enum famfs_log_ext_type */
> +	uint32_t nextents;
> +	uint32_t reserved0;
> +	uint64_t file_size;
> +	uint64_t reserved1;
> +};
>  #endif /* _LINUX_FUSE_H */
> -- 
> 2.49.0
> 

