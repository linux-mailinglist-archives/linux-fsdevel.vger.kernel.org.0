Return-Path: <linux-fsdevel+bounces-46860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAAFA95974
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6B9165D48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC77224243;
	Mon, 21 Apr 2025 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6EPPCAR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CE1DDE9;
	Mon, 21 Apr 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274689; cv=none; b=HKvGlD9sT16e6a+gfTkCT1ZGFIcTd7fQyl/sGrBZ4BAXOphyyUhChVzBMuia2Dn5VuF0mLOmKa4nn42zhvFGZ6MxzSoz3H0H+rd8V2PKZ2/22QtvYIGzj3y30EGEY/jCNGg+QNZ5rXMnvaW5d4A0DRsp7CmhVJwv6ibgDbO8Jww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274689; c=relaxed/simple;
	bh=uGFWn0NUS4a5+jnrhvCn5EEH3bytpObjuMaQuFtN32E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTpYcuNLPL6+wcyvqmNnufzehj3UOTvmyBgpmxwK0J4vFBRncu086Rkhv2JxoK0xYmDvVqncv4oDRNkTvU+Wm9eboGoATyBboiygZtu+szSZ5mErLaeQCF9c8K8kMOjVaiHLN91VECp4VYnlU8MafOSdUYGhEE/+HDw98nTFueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6EPPCAR; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3fea0363284so2814716b6e.1;
        Mon, 21 Apr 2025 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745274686; x=1745879486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXKF5DBzjOcQxYz/UT5w1r9XYBX2zcol6RnXk0eA+E4=;
        b=O6EPPCARjxuVG3LaTplQgem3Ax8XZq8Ed5ITKwSACdL+Woi5+WSgKe2tjEbb1tJ6p+
         gnthO2knzYcb7lJdnUo5OB5jN/dBqjeZwgjaXk1d7IWbW8+che8zj2upq0/UPh3VAVSJ
         RRwo8zoX3l+9CS2zZn3NBpDny/558E+NgV1xaqfT1IddgILjBUCQ7Fb+cRcL+IoVHhrp
         AO6CLZPp9dA4XXWjQHHUiFbJJIIyWXpMnBHvEfl7aHHUXy3VYvXuqwgNptfjhcM8u1ck
         hnUMlwcmkq6xMw52RrvIizg49DYkoeWIqzuBqh/t+TNa2tDhSxK4S9rHFxbYvMcecS2P
         Lv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745274686; x=1745879486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXKF5DBzjOcQxYz/UT5w1r9XYBX2zcol6RnXk0eA+E4=;
        b=HCk0GNt++0Bs8pFzVYbfOVH1zoonvzC+qOfsM457Vcc43m80yZyeHUNCd5qws3KY8q
         5oI5VrIuITIVmKvkPmH6AlvDrJeBbJWU9hsiOKoV2bHGiRiaFoK3BcNPiSFhrAW6SeFM
         s4CyHUXNQHxup9jhoMqRLFqW7FQUa9Wtvcz58Ht/bQNK0ogjBinzq23y9XvVaMWqnoB8
         PHs4ABH16MbWYPtm7Bot4Wy628NpyQF73R1XO3w8ktWT8n+B2h9QCsCgyX8Djp+pymOT
         U1V5TyPNbfLCg3OXuXjiFgM8zqRWJ0XFiO9xD+IsMwECEVmo0r97VE3v5Ko9yR/P41SM
         LFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVsfV+hMyi8a85gocctCnod10wYR8DKVhaJtJcab+sqq/FO4+q+30m34cqvNqLoWPlIVqXlHngWcRgMQzg@vger.kernel.org, AJvYcCUyIDpFHE4B8nETzI5Q+FtkjqoEWXiE3Vq1m8iFKnjtrz0s8fFvFUA06zLALKj0AbPsmySdOLUYiwGF@vger.kernel.org, AJvYcCVBmkhbiLYwF8Xm8Nr0+D5z/9QeksZ5pq7JqQ4tI04jfLJO3Gsxn0YBiE7n45vzXWGkeLQY4T3fj5o=@vger.kernel.org, AJvYcCX7lsEZM9d9/f+5bC9oMULPqTB4N/zo002B8A34UJQFsiNEjcYnOqBPF9xR2bsbRYnIow4/GQrQ1p8IBG6feA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLsHDqI3P53KraLWeYOcMZYOH/Tp+C25uHK2qjYrN83AhpYvq
	2eZGgtug2qnHZa8Pir7OYL36OVHipwDS28KL5nOEeQm8pW/ivKDd
X-Gm-Gg: ASbGnctqhIZwtRwEO2mCTc5SyMYVOVjJKpubmet6KCB2iDayQ1FsEIvCftdvLXjKRk4
	5xjAtW0TXXjvFNCnEThAox3bZ7F8tnkPFDDfo7+6jV/W9w8iTi2T+JmST2v7FVdDpEQU1w9j+ku
	pTnG9hCTts+wtD02fTnAt4d5M2+szCin98UD9DoPNCD3xk4v4SX6qcZ61CAVCUoMPCrUOsSs5AK
	3Ms8ppbNtymszftOam/24tGIz0cUysch6fl2iDcMZCTvvJ2w+uecAqao3SUvLqeuruQqrpZgqJr
	TQxWiNva3hc7HAR2e6NP2Rxd7I523QIC+BpV9MHPV3F7UGaNHBOIW0ttDkI+
X-Google-Smtp-Source: AGHT+IFt5wHsCjSlpFEFUHVsJUEoyStNlvmXw+Gm+ahrEHq6vasyVcDWIICCWhEq6uDb8143Fpvq+w==
X-Received: by 2002:a05:6808:6a93:b0:3f9:176a:3958 with SMTP id 5614622812f47-401bcd13721mr8780591b6e.11.1745274686223;
        Mon, 21 Apr 2025 15:31:26 -0700 (PDT)
Received: from Borg-550.local ([2603:8080:1500:3d89:c191:629b:fde5:2f06])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401bf081e2asm1742687b6e.36.2025.04.21.15.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:31:25 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 21 Apr 2025 17:31:22 -0500
From: John Groves <John@groves.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Luis Henriques <luis@igalia.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <44so2lrfvu6v6m2zdrldyosgkgaszsone4on3duql4yphfoorn@shdy4ibm4zle>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-14-john@groves.net>
 <20250421215719.GK25659@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421215719.GK25659@frogsfrogsfrogs>

On 25/04/21 02:57PM, Darrick J. Wong wrote:
> On Sun, Apr 20, 2025 at 08:33:40PM -0500, John Groves wrote:
> > On completion of GET_FMAP message/response, setup the full famfs
> > metadata such that it's possible to handle read/write/mmap directly to
> > dax. Note that the devdax_iomap plumbing is not in yet...
> > 
> > Update MAINTAINERS for the new files.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  MAINTAINERS               |   9 +
> >  fs/fuse/Makefile          |   2 +-
> >  fs/fuse/dir.c             |   3 +
> >  fs/fuse/famfs.c           | 344 ++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/famfs_kfmap.h     |  63 +++++++
> >  fs/fuse/fuse_i.h          |  16 +-
> >  fs/fuse/inode.c           |   2 +-
> >  include/uapi/linux/fuse.h |  42 +++++
> >  8 files changed, 477 insertions(+), 4 deletions(-)
> >  create mode 100644 fs/fuse/famfs.c
> >  create mode 100644 fs/fuse/famfs_kfmap.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 00e94bec401e..2a5a7e0e8b28 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8808,6 +8808,15 @@ F:	Documentation/networking/failover.rst
> >  F:	include/net/failover.h
> >  F:	net/core/failover.c
> >  
> > +FAMFS
> > +M:	John Groves <jgroves@micron.com>
> > +M:	John Groves <John@Groves.net>
> > +L:	linux-cxl@vger.kernel.org
> > +L:	linux-fsdevel@vger.kernel.org
> > +S:	Supported
> > +F:	fs/fuse/famfs.c
> > +F:	fs/fuse/famfs_kfmap.h
> > +
> >  FANOTIFY
> >  M:	Jan Kara <jack@suse.cz>
> >  R:	Amir Goldstein <amir73il@gmail.com>
> > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > index 3f0f312a31c1..65a12975d734 100644
> > --- a/fs/fuse/Makefile
> > +++ b/fs/fuse/Makefile
> > @@ -16,5 +16,5 @@ fuse-$(CONFIG_FUSE_DAX) += dax.o
> >  fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
> >  fuse-$(CONFIG_SYSCTL) += sysctl.o
> >  fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
> > -
> > +fuse-$(CONFIG_FUSE_FAMFS_DAX) += famfs.o
> >  virtiofs-y := virtio_fs.o
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index ae135c55b9f6..b28a1e912d6b 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -405,6 +405,9 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode *inode, u64 nodeid)
> >  	fmap_size = args.out_args[0].size;
> >  	pr_notice("%s: nodei=%lld fmap_size=%ld\n", __func__, nodeid, fmap_size);
> >  
> > +	/* Convert fmap into in-memory format and hang from inode */
> > +	famfs_file_init_dax(fm, inode, fmap_buf, fmap_size);
> > +
> >  	return 0;
> >  }
> >  #endif
> > diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> > new file mode 100644
> > index 000000000000..e62c047d0950
> > --- /dev/null
> > +++ b/fs/fuse/famfs.c
> > @@ -0,0 +1,344 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * famfs - dax file system for shared fabric-attached memory
> > + *
> > + * Copyright 2023-2025 Micron Technology, Inc.
> > + *
> > + * This file system, originally based on ramfs the dax support from xfs,
> > + * is intended to allow multiple host systems to mount a common file system
> > + * view of dax files that map to shared memory.
> > + */
> > +
> > +#include <linux/fs.h>
> > +#include <linux/mm.h>
> > +#include <linux/dax.h>
> > +#include <linux/iomap.h>
> > +#include <linux/path.h>
> > +#include <linux/namei.h>
> > +#include <linux/string.h>
> > +
> > +#include "famfs_kfmap.h"
> > +#include "fuse_i.h"
> > +
> > +
> > +void
> > +__famfs_meta_free(void *famfs_meta)
> > +{
> > +	struct famfs_file_meta *fmap = famfs_meta;
> > +
> > +	if (!fmap)
> > +		return;
> > +
> > +	if (fmap) {
> > +		switch (fmap->fm_extent_type) {
> > +		case SIMPLE_DAX_EXTENT:
> > +			kfree(fmap->se);
> > +			break;
> > +		case INTERLEAVED_EXTENT:
> 
> Are interleaved extents not DAX extents?  Why does one constant refer to
> DAX but the other does not?

All extents are DAX. Naming evolved over 2+ years, and could be cleaned up.

> 
> > +			if (fmap->ie)
> > +				kfree(fmap->ie->ie_strips);
> > +
> > +			kfree(fmap->ie);
> > +			break;
> > +		default:
> > +			pr_err("%s: invalid fmap type\n", __func__);
> > +			break;
> > +		}
> > +	}
> > +	kfree(fmap);
> > +}
> > +
> > +static int
> > +famfs_check_ext_alignment(struct famfs_meta_simple_ext *se)
> > +{
> > +	int errs = 0;
> > +
> > +	if (se->dev_index != 0)
> > +		errs++;
> > +
> > +	/* TODO: pass in alignment so we can support the other page sizes */
> > +	if (!IS_ALIGNED(se->ext_offset, PMD_SIZE))
> > +		errs++;
> > +
> > +	if (!IS_ALIGNED(se->ext_len, PMD_SIZE))
> > +		errs++;
> > +
> > +	return errs;
> > +}
> > +
> > +/**
> > + * famfs_meta_alloc() - Allocate famfs file metadata
> > + * @metap:       Pointer to an mcache_map_meta pointer
> > + * @ext_count:  The number of extents needed
> > + */
> > +static int
> > +famfs_meta_alloc_v3(
> 
> Err, what's with "v3"?  This is a new fs, right?


Um, been working on this for 2+ years so there's a not-very-public legacy.
But I agree naming should be cleaned up.

> 
> > +	void *fmap_buf,
> > +	size_t fmap_buf_size,
> > +	struct famfs_file_meta **metap)
> > +{
> > +	struct famfs_file_meta *meta = NULL;
> > +	struct fuse_famfs_fmap_header *fmh;
> > +	size_t extent_total = 0;
> > +	size_t next_offset = 0;
> > +	int errs = 0;
> > +	int i, j;
> > +	int rc;
> > +
> > +	fmh = (struct fuse_famfs_fmap_header *)fmap_buf;
> > +
> > +	/* Move past fmh in fmap_buf */
> > +	next_offset += sizeof(*fmh);
> > +	if (next_offset > fmap_buf_size) {
> > +		pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> > +		       __func__, __LINE__, next_offset, fmap_buf_size);
> > +		rc = -EINVAL;
> > +		goto errout;
> > +	}
> > +
> > +	if (fmh->nextents < 1) {
> > +		pr_err("%s: nextents %d < 1\n", __func__, fmh->nextents);
> > +		rc = -EINVAL;
> > +		goto errout;
> > +	}
> > +
> > +	if (fmh->nextents > FUSE_FAMFS_MAX_EXTENTS) {
> > +		pr_err("%s: nextents %d > max (%d) 1\n",
> > +		       __func__, fmh->nextents, FUSE_FAMFS_MAX_EXTENTS);
> > +		rc = -E2BIG;
> > +		goto errout;
> > +	}
> > +
> > +	meta = kzalloc(sizeof(*meta), GFP_KERNEL);
> > +	if (!meta)
> > +		return -ENOMEM;
> > +	meta->error = false;
> > +
> > +	meta->file_type = fmh->file_type;
> > +	meta->file_size = fmh->file_size;
> > +	meta->fm_extent_type = fmh->ext_type;
> > +
> > +	switch (fmh->ext_type) {
> > +	case FUSE_FAMFS_EXT_SIMPLE: {
> > +		struct fuse_famfs_simple_ext *se_in;
> > +
> > +		se_in = (struct fuse_famfs_simple_ext *)(fmap_buf + next_offset);
> > +
> > +		/* Move past simple extents */
> > +		next_offset += fmh->nextents * sizeof(*se_in);
> > +		if (next_offset > fmap_buf_size) {
> > +			pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
> > +			       __func__, __LINE__, next_offset, fmap_buf_size);
> > +			rc = -EINVAL;
> > +			goto errout;
> > +		}
> > +
> > +		meta->fm_nextents = fmh->nextents;
> > +
> > +		meta->se = kcalloc(meta->fm_nextents, sizeof(*(meta->se)),
> > +				   GFP_KERNEL);
> > +		if (!meta->se) {
> > +			rc = -ENOMEM;
> > +			goto errout;
> > +		}
> > +
> > +		if ((meta->fm_nextents > FUSE_FAMFS_MAX_EXTENTS) ||
> 
> FUSE_FAMFS_MAX_EXTENTS is 2?  I gather that simple files in famfs refer
> to contiguous regions, but why two mappings?

There is no forward-looking, or even current-term reason why it should be 
limited to 2; But famfs files are strictly pre-allocated, so it takes some 
special code to test the multi-extent code paths. We do that internally, 
hence 2 (rather than 1).

Where we do exercise much bigger lists of the same extents in in interleaved
setups - where the limit is higher.

But dialing it up or even removing the limit provided the GET_FMAP message
validates should be fine.

> 
> > +		    (meta->fm_nextents < 1)) {
> > +			rc = -EINVAL;
> > +			goto errout;
> > +		}
> > +
> > +		for (i = 0; i < fmh->nextents; i++) {
> > +			meta->se[i].dev_index  = se_in[i].se_devindex;
> > +			meta->se[i].ext_offset = se_in[i].se_offset;
> > +			meta->se[i].ext_len    = se_in[i].se_len;
> > +
> > +			/* Record bitmap of referenced daxdev indices */
> > +			meta->dev_bitmap |= (1 << meta->se[i].dev_index);
> > +
> > +			errs += famfs_check_ext_alignment(&meta->se[i]);
> 
> Shouldn't you bail out at the first bad mapping?

Probably yes; need to dredge old memory about this...

> 
> > +			extent_total += meta->se[i].ext_len;
> > +		}
> 
> I took a look at what's already in uapi/linux/fuse.h and saw that
> there are two operations -- FUSE_{SETUP,REMOVE}MAPPING.  Those two fuse
> upcalls seem to manage an interval tree in struct fuse_inode_dax, which
> is used to feed fuse_iomap_begin.  Can you reuse this existing uapi
> instead of defining a new one that's already pretty similar?

OK, so the pre-existing DAX stuff in fuse is for virtiofs, which is doing
a very narrow thing (which I don't understand completely, but Stefan is
on this thread - though if I were him I might not be paying attention :)
My net assessment: the pre-existing fuse dax stuff was not a viable platform
for a file system with many files.

I initially implemented famfs as a standalone file system (patches easy
to find, and there are branches in my github kernel repos - including one
called famfs_dual that has BOTH). The existing DAX stuff in fuse is quite
different from the fs-dax interface that xfs uses - and has no notify_failure
etc.

> 
> I'm wondering why create all this new code when fuse/dax.c already seems
> to have the ability to cache mappings and pass them to dax_iomap_rw
> without restrictions on the number of mappings and all that?
> 
> Maybe you're trying to avoid runtime upcalls, but then I would think
> that you could teach the fuse/dax.c mapping code to pin the mappings
> if there aren't that many of them in the first place, rather than
> reinventing mappings?
> 
> It occurred to me (perhaps naively) that maybe you created FUSE_GETFMAP
> because of this interleaving thing because it's probably faster to
> upload a template for that than it would be to upload a large number of
> mappings.  But I don't really grok why the interleaving exists, though I
> guess it's for memory controllers interleaving memory devices or
> something for better throughput?

In famfsv1 (the standalone version), user space "pushed" mappings into
the kernel, but fuse doesn't do it that way. It wants to do readdir, lookup,
etc. So GET_FMAP was the answer I came up with - and so far it works fine.

> 
> I also see that famfs_meta_to_dax_offset does a linear walk of the
> mapping array, which does not seem like it will be inefficient when
> there are many mappings.

Right, that's no big deal. And if there's only one extent (or if the extents
are fixed-size), it's order 1.

> 
> > +		break;
> > +	}
> > +
> > +	case FUSE_FAMFS_EXT_INTERLEAVE: {
> > +		s64 size_remainder = meta->file_size;
> > +		struct fuse_famfs_iext *ie_in;
> > +		int niext = fmh->nextents;
> > +
> > +		meta->fm_niext = niext;
> > +
> > +		/* Allocate interleaved extent */
> > +		meta->ie = kcalloc(niext, sizeof(*(meta->ie)), GFP_KERNEL);
> > +		if (!meta->ie) {
> > +			rc = -ENOMEM;
> > +			goto errout;
> > +		}
> > +
> > +		/*
> > +		 * Each interleaved extent has a simple extent list of strips.
> > +		 * Outer loop is over separate interleaved extents
> 
> Hmm, so there's no checking on fmh->nextents here, so I guess we can
> have as many sets of interleaved extents as we want?  Each with up to 16
> simple mappings?
> 
> --D

OK, so I'm remembering a bit more about the legacy around extent limits. 
There are some MVP simplifications in the famfs metadata log format 
(which is orthogonal to the message and in-memory metadata formats here). 
An fmap in the log (a third format, but there is at least one more :-/) 
is a fully dimensioned compound structure that you can call sizeof on. 
So that is the second reason (in addition to preallocation) why we didn't 
need many extents.

Also, when we resolve file offsets to dax offsets, limit and validity
checking was already done when the GET_FMAP message was ingested.

I think for fuse famfs, that can be relaxed and ignored - especially if 
you're gonna test it :D.

Thanks for the review eyeballs, and let me know if you wanna talk through
some of this stuff.

Regards,
John




