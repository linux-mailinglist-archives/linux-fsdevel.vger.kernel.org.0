Return-Path: <linux-fsdevel+bounces-54017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C23F9AFA19E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 21:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22981189F051
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 19:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005972192E4;
	Sat,  5 Jul 2025 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJLbPpCO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359E19CD1D;
	Sat,  5 Jul 2025 19:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751744665; cv=none; b=ceO4LkRph5dlgM5HuKwPr4X19HdchUBuZbq5mnDbe/PZtvlq9s2SMsio9VKKUPRFcW1C1DklU2IeKqsgTvJTI5Xpxq5l2RcH32VCSAoW5UDQyMcJocRiuISo4RTMqr8DsWtXGNHkEGHTGsTFpgTielAsI1Hc4noje1Lbjpj8t2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751744665; c=relaxed/simple;
	bh=hENqZ0jNAHsWpGWYiTL8BvUNuqNpvHdxrxJMXJi7EcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tK3AWzhZfyIZT5S0/R8k0yQt53Xi2bs2YN0A3z58fAC2c1FRcL2N9Nfpd4hbkpYEfnTmfOKQieCnjQXkMBdKGGeY+4Nt/RRXv25Iocn17vxp/z8WXa4i8FR5WVY8HM9x9hnupplueLid2BnEDELtXWbJq/ExVlMLcV857yRpmoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJLbPpCO; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2eacb421554so607550fac.1;
        Sat, 05 Jul 2025 12:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751744662; x=1752349462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAmszgfr1eGQerWWXtD/q4lKQRXYPW9xPhDpv2nzN60=;
        b=KJLbPpCOzWbcjErdh2N6vHeQyltAoXN0voj+gQ4Z2RVm0EcSnXG+UudKIUsOGQpvYh
         KkvrIINLGfc8AJ/ZRGSXKpDAcyBiQTaXeZ+Pl9PtijRiIel+paj9spvRm3R1ppvxx2RK
         +TH/OSB7vrGgJAHs144xdGW10v4b4vyss6MMh123m2iVgjjq5WjHwOZtz7ONasFXuOvH
         KTkpx4CpubaLtRodWDIc4W2ZltxTBzKqoDJVlxixE5nV++CQtJCMZ05dxD7ubgpuYlfE
         v4y1gH0lQNLCb+JvMjLGz9F76umLlc4ZoiOtQXy6hr+oM3D/cRn1qAc5g6qISIETzgwS
         WyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751744662; x=1752349462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAmszgfr1eGQerWWXtD/q4lKQRXYPW9xPhDpv2nzN60=;
        b=r78g7paAoDDIdoaXYDV1gYPdxgeVRFykNrcOvwAqlCiRI1xjqBs0CU1KW0vGcY/b0Z
         Ir6Qdnnuf2vjiZDRd5MyC3Es5IiEAZWQ+Pyt9ntW6JXWLD77SDqonBt+UfUq1M1GFIK3
         z7YCUYU/j56h/0Ptcfy1Szu7b8SBEYZCHv4PjXZh9UU3MnjX1L7aUEOvaHCLzygy8TDX
         +hAiSYjDZCqGQKNqiBDN6T8UFgS3zuoFNUU0qUYvS+axqEbBmr08xYlXwxEEzpZhS/Sc
         b3gCUqTIgbvlLYhzmLG2H+G9XyPe05RyPNsoXFkyhu506ScQevWSUBjJrik37OmOKVrU
         Fszg==
X-Forwarded-Encrypted: i=1; AJvYcCV7XNcnmBRdfoNTME7ItQ3r4Plh3OU8vvunVPoy0cxt0uvk0c+8BiPSM436/D4gJFo/r1NdjqGeE190ajzR@vger.kernel.org, AJvYcCW7fuOBW2/ub9TXsBblvqH/RILEGbfYdMu79/WANGEmvXOFAGgAqCAxdWsaxN6Udo6SKapRGnarpiz4@vger.kernel.org, AJvYcCWmyRYYici0RoNSAsj7pfu2tJWRJ1D6S6SyHoCTagj0q68BycbJi074XB5jF3j7eI/wMfh7eeoB5As=@vger.kernel.org, AJvYcCXmNlRO75BLxW/o7ma34SsfqH3bJmRgVBEngHAbBiHpzQI5Q0hJXCM8aS7Gr9X6yFg5W7MkpuZdwZoqcW8CEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNy9fDHHPOr5tzHKCa9mpEXbk3UT3Fp/qJXztmCmX/cEBcXc5N
	pRO1bohiHG+ZNf+s9n6Lg30sSI/1n8r8+7X4L6NqmW2yUvZ++T1Ht6Vn
X-Gm-Gg: ASbGncu3/NoTcVaVftdFajMzgN1KSAFS+qduQBSQSfX/OdfaeG6HFa0cI0KFKXIl7+w
	u8OD5+IHxxPpJv7rVa+zvlgwvyf0bd1zMTFNqCGiTetAh25erp5ykmEMrZyC33iSzrbSAIKoTm2
	kk87IZQS0PyijC+4IDWKKT0EDMtHrfGUzRp5pvpd15Ru9LWy2WmctDUT6dYUJgy6n6w0lmz3V+i
	PkOrDGDNidcXvoisUGkxtrjcEmX3HMaNtzSzwQ2ECt3xJUJbGEaWmUXhuwehhCSBiIlzu58tIvO
	GeZR+eIQynyr3ZR5GUHfs89dNwU2HB/ewyWIH3VQNECguYTykh2DYKGabY1UBhB6nmhq0wMo48n
	y
X-Google-Smtp-Source: AGHT+IFgmcWEyMWz88jiQ5IzLLdLp2L+SYjGFH4A3hJwxGWh/D56s45loZlnwMU4qhCaBzxUAyHzJg==
X-Received: by 2002:a05:6870:e249:b0:2d5:1725:f529 with SMTP id 586e51a60fabf-2f79200c1e2mr5599075fac.27.1751744661923;
        Sat, 05 Jul 2025 12:44:21 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:5c68:c378:f4d3:49a4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6138e5c9389sm710046eaf.40.2025.07.05.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 12:44:21 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sat, 5 Jul 2025 14:44:19 -0500
From: John Groves <John@groves.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC V2 15/18] famfs_fuse: Plumb dax iomap and fuse
 read/write/mmap
Message-ID: <gkasmy2ntypw725tlnxbrclrax43h44jcc5lyak3ezjtawjezl@66ychtusd3pr>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-16-john@groves.net>
 <CAOQ4uxgqXVX8uynEZduNEor0XhgVvch+WK2esiiSJ1G=iy_bcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgqXVX8uynEZduNEor0XhgVvch+WK2esiiSJ1G=iy_bcg@mail.gmail.com>

On 25/07/04 11:13AM, Amir Goldstein wrote:
> On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> >
> > This commit fills in read/write/mmap handling for famfs files. The
> > dev_dax_iomap interface is used - just like xfs in fs-dax mode.
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/famfs.c  | 436 +++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/file.c   |  14 ++
> >  fs/fuse/fuse_i.h |   3 +
> >  3 files changed, 453 insertions(+)
> >
> > diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> > index f5e01032b825..1973eb10b60b 100644
> > --- a/fs/fuse/famfs.c
> > +++ b/fs/fuse/famfs.c
> > @@ -585,3 +585,439 @@ famfs_file_init_dax(
> >         return rc;
> >  }
> >
> > +/*********************************************************************
> > + * iomap_operations
> > + *
> > + * This stuff uses the iomap (dax-related) helpers to resolve file offsets to
> > + * offsets within a dax device.
> > + */
> > +
> > +static ssize_t famfs_file_bad(struct inode *inode);
> > +
> > +static int
> > +famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
> > +                        loff_t file_offset, off_t len, unsigned int flags)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct famfs_file_meta *meta = fi->famfs_meta;
> > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > +       loff_t local_offset = file_offset;
> > +       int i;
> > +
> > +       /* This function is only for extent_type INTERLEAVED_EXTENT */
> > +       if (meta->fm_extent_type != INTERLEAVED_EXTENT) {
> > +               pr_err("%s: bad extent type\n", __func__);
> > +               goto err_out;
> > +       }
> > +
> > +       if (famfs_file_bad(inode))
> > +               goto err_out;
> > +
> > +       iomap->offset = file_offset;
> > +
> > +       for (i = 0; i < meta->fm_niext; i++) {
> > +               struct famfs_meta_interleaved_ext *fei = &meta->ie[i];
> > +               u64 chunk_size = fei->fie_chunk_size;
> > +               u64 nstrips = fei->fie_nstrips;
> > +               u64 ext_size = fei->fie_nbytes;
> > +
> > +               ext_size = min_t(u64, ext_size, meta->file_size);
> > +
> > +               if (ext_size == 0) {
> > +                       pr_err("%s: ext_size=%lld file_size=%ld\n",
> > +                              __func__, fei->fie_nbytes, meta->file_size);
> > +                       goto err_out;
> > +               }
> > +
> > +               /* Is the data is in this striped extent? */
> > +               if (local_offset < ext_size) {
> > +                       u64 chunk_num       = local_offset / chunk_size;
> > +                       u64 chunk_offset    = local_offset % chunk_size;
> > +                       u64 stripe_num      = chunk_num / nstrips;
> > +                       u64 strip_num       = chunk_num % nstrips;
> > +                       u64 chunk_remainder = chunk_size - chunk_offset;
> > +                       u64 strip_offset    = chunk_offset + (stripe_num * chunk_size);
> > +                       u64 strip_dax_ofs = fei->ie_strips[strip_num].ext_offset;
> > +                       u64 strip_devidx = fei->ie_strips[strip_num].dev_index;
> > +
> > +                       if (!fc->dax_devlist->devlist[strip_devidx].valid) {
> > +                               pr_err("%s: daxdev=%lld invalid\n", __func__,
> > +                                       strip_devidx);
> > +                               goto err_out;
> > +                       }
> > +                       iomap->addr    = strip_dax_ofs + strip_offset;
> > +                       iomap->offset  = file_offset;
> > +                       iomap->length  = min_t(loff_t, len, chunk_remainder);
> > +
> > +                       iomap->dax_dev = fc->dax_devlist->devlist[strip_devidx].devp;
> > +
> > +                       iomap->type    = IOMAP_MAPPED;
> > +                       iomap->flags   = flags;
> > +
> > +                       return 0;
> > +               }
> > +               local_offset -= ext_size; /* offset is beyond this striped extent */
> > +       }
> > +
> > + err_out:
> > +       pr_err("%s: err_out\n", __func__);
> > +
> > +       /* We fell out the end of the extent list.
> > +        * Set iomap to zero length in this case, and return 0
> > +        * This just means that the r/w is past EOF
> > +        */
> > +       iomap->addr    = 0; /* there is no valid dax device offset */
> > +       iomap->offset  = file_offset; /* file offset */
> > +       iomap->length  = 0; /* this had better result in no access to dax mem */
> > +       iomap->dax_dev = NULL;
> > +       iomap->type    = IOMAP_MAPPED;
> > +       iomap->flags   = flags;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * famfs_fileofs_to_daxofs() - Resolve (file, offset, len) to (daxdev, offset, len)
> > + *
> > + * This function is called by famfs_fuse_iomap_begin() to resolve an offset in a
> > + * file to an offset in a dax device. This is upcalled from dax from calls to
> > + * both  * dax_iomap_fault() and dax_iomap_rw(). Dax finishes the job resolving
> > + * a fault to a specific physical page (the fault case) or doing a memcpy
> > + * variant (the rw case)
> > + *
> > + * Pages can be PTE (4k), PMD (2MiB) or (theoretically) PuD (1GiB)
> > + * (these sizes are for X86; may vary on other cpu architectures
> > + *
> > + * @inode:  The file where the fault occurred
> > + * @iomap:       To be filled in to indicate where to find the right memory,
> > + *               relative  to a dax device.
> > + * @file_offset: Within the file where the fault occurred (will be page boundary)
> > + * @len:         The length of the faulted mapping (will be a page multiple)
> > + *               (will be trimmed in *iomap if it's disjoint in the extent list)
> > + * @flags:
> > + *
> > + * Return values: 0. (info is returned in a modified @iomap struct)
> > + */
> > +static int
> > +famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
> > +                        loff_t file_offset, off_t len, unsigned int flags)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct famfs_file_meta *meta = fi->famfs_meta;
> > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > +       loff_t local_offset = file_offset;
> > +       int i;
> > +
> > +       if (!fc->dax_devlist) {
> > +               pr_err("%s: null dax_devlist\n", __func__);
> > +               goto err_out;
> > +       }
> > +
> > +       if (famfs_file_bad(inode))
> > +               goto err_out;
> > +
> > +       if (meta->fm_extent_type == INTERLEAVED_EXTENT)
> > +               return famfs_interleave_fileofs_to_daxofs(inode, iomap,
> > +                                                         file_offset,
> > +                                                         len, flags);
> > +
> > +       iomap->offset = file_offset;
> > +
> > +       for (i = 0; i < meta->fm_nextents; i++) {
> > +               /* TODO: check devindex too */
> > +               loff_t dax_ext_offset = meta->se[i].ext_offset;
> > +               loff_t dax_ext_len    = meta->se[i].ext_len;
> > +               u64 daxdev_idx = meta->se[i].dev_index;
> > +
> > +               if ((dax_ext_offset == 0) &&
> > +                   (meta->file_type != FAMFS_SUPERBLOCK))
> > +                       pr_warn("%s: zero offset on non-superblock file!!\n",
> > +                               __func__);
> > +
> > +               /* local_offset is the offset minus the size of extents skipped
> > +                * so far; If local_offset < dax_ext_len, the data of interest
> > +                * starts in this extent
> > +                */
> > +               if (local_offset < dax_ext_len) {
> > +                       loff_t ext_len_remainder = dax_ext_len - local_offset;
> > +                       struct famfs_daxdev *dd;
> > +
> > +                       dd = &fc->dax_devlist->devlist[daxdev_idx];
> > +
> > +                       if (!dd->valid || dd->error) {
> > +                               pr_err("%s: daxdev=%lld %s\n", __func__,
> > +                                      daxdev_idx,
> > +                                      dd->valid ? "error" : "invalid");
> > +                               goto err_out;
> > +                       }
> > +
> > +                       /*
> > +                        * OK, we found the file metadata extent where this
> > +                        * data begins
> > +                        * @local_offset      - The offset within the current
> > +                        *                      extent
> > +                        * @ext_len_remainder - Remaining length of ext after
> > +                        *                      skipping local_offset
> > +                        * Outputs:
> > +                        * iomap->addr:   the offset within the dax device where
> > +                        *                the  data starts
> > +                        * iomap->offset: the file offset
> > +                        * iomap->length: the valid length resolved here
> > +                        */
> > +                       iomap->addr    = dax_ext_offset + local_offset;
> > +                       iomap->offset  = file_offset;
> > +                       iomap->length  = min_t(loff_t, len, ext_len_remainder);
> > +
> > +                       iomap->dax_dev = fc->dax_devlist->devlist[daxdev_idx].devp;
> > +
> > +                       iomap->type    = IOMAP_MAPPED;
> > +                       iomap->flags   = flags;
> > +                       return 0;
> > +               }
> > +               local_offset -= dax_ext_len; /* Get ready for the next extent */
> > +       }
> > +
> > + err_out:
> > +       pr_err("%s: err_out\n", __func__);
> > +
> > +       /* We fell out the end of the extent list.
> > +        * Set iomap to zero length in this case, and return 0
> > +        * This just means that the r/w is past EOF
> > +        */
> > +       iomap->addr    = 0; /* there is no valid dax device offset */
> > +       iomap->offset  = file_offset; /* file offset */
> > +       iomap->length  = 0; /* this had better result in no access to dax mem */
> > +       iomap->dax_dev = NULL;
> > +       iomap->type    = IOMAP_MAPPED;
> > +       iomap->flags   = flags;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * famfs_fuse_iomap_begin() - Handler for iomap_begin upcall from dax
> > + *
> > + * This function is pretty simple because files are
> > + * * never partially allocated
> > + * * never have holes (never sparse)
> > + * * never "allocate on write"
> > + *
> > + * @inode:  inode for the file being accessed
> > + * @offset: offset within the file
> > + * @length: Length being accessed at offset
> > + * @flags:
> > + * @iomap:  iomap struct to be filled in, resolving (offset, length) to
> > + *          (daxdev, offset, len)
> > + * @srcmap:
> > + */
> > +static int
> > +famfs_fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > +                 unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct famfs_file_meta *meta = fi->famfs_meta;
> > +       size_t size;
> > +
> > +       size = i_size_read(inode);
> > +
> > +       WARN_ON(size != meta->file_size);
> > +
> > +       return famfs_fileofs_to_daxofs(inode, iomap, offset, length, flags);
> > +}
> > +
> > +/* Note: We never need a special set of write_iomap_ops because famfs never
> > + * performs allocation on write.
> > + */
> > +const struct iomap_ops famfs_iomap_ops = {
> > +       .iomap_begin            = famfs_fuse_iomap_begin,
> > +};
> > +
> > +/*********************************************************************
> > + * vm_operations
> > + */
> > +static vm_fault_t
> > +__famfs_fuse_filemap_fault(struct vm_fault *vmf, unsigned int pe_size,
> > +                     bool write_fault)
> > +{
> > +       struct inode *inode = file_inode(vmf->vma->vm_file);
> > +       vm_fault_t ret;
> > +       pfn_t pfn;
> > +
> > +       if (!IS_DAX(file_inode(vmf->vma->vm_file))) {
> > +               pr_err("%s: file not marked IS_DAX!!\n", __func__);
> > +               return VM_FAULT_SIGBUS;
> > +       }
> > +
> > +       if (write_fault) {
> > +               sb_start_pagefault(inode->i_sb);
> > +               file_update_time(vmf->vma->vm_file);
> > +       }
> > +
> > +       ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &famfs_iomap_ops);
> > +       if (ret & VM_FAULT_NEEDDSYNC)
> > +               ret = dax_finish_sync_fault(vmf, pe_size, pfn);
> > +
> > +       if (write_fault)
> > +               sb_end_pagefault(inode->i_sb);
> > +
> > +       return ret;
> > +}
> > +
> > +static inline bool
> > +famfs_is_write_fault(struct vm_fault *vmf)
> > +{
> > +       return (vmf->flags & FAULT_FLAG_WRITE) &&
> > +              (vmf->vma->vm_flags & VM_SHARED);
> > +}
> > +
> > +static vm_fault_t
> > +famfs_filemap_fault(struct vm_fault *vmf)
> > +{
> > +       return __famfs_fuse_filemap_fault(vmf, 0, famfs_is_write_fault(vmf));
> > +}
> > +
> > +static vm_fault_t
> > +famfs_filemap_huge_fault(struct vm_fault *vmf, unsigned int pe_size)
> > +{
> > +       return __famfs_fuse_filemap_fault(vmf, pe_size, famfs_is_write_fault(vmf));
> > +}
> > +
> > +static vm_fault_t
> > +famfs_filemap_page_mkwrite(struct vm_fault *vmf)
> > +{
> > +       return __famfs_fuse_filemap_fault(vmf, 0, true);
> > +}
> > +
> > +static vm_fault_t
> > +famfs_filemap_pfn_mkwrite(struct vm_fault *vmf)
> > +{
> > +       return __famfs_fuse_filemap_fault(vmf, 0, true);
> > +}
> > +
> > +static vm_fault_t
> > +famfs_filemap_map_pages(struct vm_fault        *vmf, pgoff_t start_pgoff,
> > +                       pgoff_t end_pgoff)
> > +{
> > +       return filemap_map_pages(vmf, start_pgoff, end_pgoff);
> > +}
> > +
> > +const struct vm_operations_struct famfs_file_vm_ops = {
> > +       .fault          = famfs_filemap_fault,
> > +       .huge_fault     = famfs_filemap_huge_fault,
> > +       .map_pages      = famfs_filemap_map_pages,
> > +       .page_mkwrite   = famfs_filemap_page_mkwrite,
> > +       .pfn_mkwrite    = famfs_filemap_pfn_mkwrite,
> > +};
> > +
> > +/*********************************************************************
> > + * file_operations
> > + */
> > +
> > +/**
> > + * famfs_file_bad() - Check for files that aren't in a valid state
> > + *
> > + * @inode - inode
> > + *
> > + * Returns: 0=success
> > + *          -errno=failure
> > + */
> > +static ssize_t
> > +famfs_file_bad(struct inode *inode)
> > +{
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> > +       struct famfs_file_meta *meta = fi->famfs_meta;
> > +       size_t i_size = i_size_read(inode);
> > +
> > +       if (!meta) {
> > +               pr_err("%s: un-initialized famfs file\n", __func__);
> > +               return -EIO;
> > +       }
> > +       if (meta->error) {
> > +               pr_debug("%s: previously detected metadata errors\n", __func__);
> > +               return -EIO;
> > +       }
> > +       if (i_size != meta->file_size) {
> > +               pr_warn("%s: i_size overwritten from %ld to %ld\n",
> > +                      __func__, meta->file_size, i_size);
> > +               meta->error = true;
> > +               return -ENXIO;
> > +       }
> > +       if (!IS_DAX(inode)) {
> > +               pr_debug("%s: inode %llx IS_DAX is false\n", __func__, (u64)inode);
> > +               return -ENXIO;
> > +       }
> > +       return 0;
> > +}
> > +
> > +static ssize_t
> > +famfs_fuse_rw_prep(struct kiocb *iocb, struct iov_iter *ubuf)
> > +{
> > +       struct inode *inode = iocb->ki_filp->f_mapping->host;
> > +       size_t i_size = i_size_read(inode);
> > +       size_t count = iov_iter_count(ubuf);
> > +       size_t max_count;
> > +       ssize_t rc;
> > +
> > +       rc = famfs_file_bad(inode);
> > +       if (rc)
> > +               return rc;
> > +
> > +       max_count = max_t(size_t, 0, i_size - iocb->ki_pos);
> > +
> > +       if (count > max_count)
> > +               iov_iter_truncate(ubuf, max_count);
> > +
> > +       if (!iov_iter_count(ubuf))
> > +               return 0;
> > +
> > +       return rc;
> > +}
> > +
> > +ssize_t
> > +famfs_fuse_read_iter(struct kiocb *iocb, struct iov_iter       *to)
> > +{
> > +       ssize_t rc;
> > +
> > +       rc = famfs_fuse_rw_prep(iocb, to);
> > +       if (rc)
> > +               return rc;
> > +
> > +       if (!iov_iter_count(to))
> > +               return 0;
> > +
> > +       rc = dax_iomap_rw(iocb, to, &famfs_iomap_ops);
> > +
> > +       file_accessed(iocb->ki_filp);
> > +       return rc;
> > +}
> > +
> > +ssize_t
> > +famfs_fuse_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > +{
> > +       ssize_t rc;
> > +
> > +       rc = famfs_fuse_rw_prep(iocb, from);
> > +       if (rc)
> > +               return rc;
> > +
> > +       if (!iov_iter_count(from))
> > +               return 0;
> > +
> > +       return dax_iomap_rw(iocb, from, &famfs_iomap_ops);
> > +}
> > +
> > +int
> > +famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +       struct inode *inode = file_inode(file);
> > +       ssize_t rc;
> > +
> > +       rc = famfs_file_bad(inode);
> > +       if (rc)
> > +               return (int)rc;
> > +
> > +       file_accessed(file);
> > +       vma->vm_ops = &famfs_file_vm_ops;
> > +       vm_flags_set(vma, VM_HUGEPAGE);
> > +       return 0;
> > +}
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 5d205eadb48f..24a14b176510 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1874,6 +1874,8 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> >
> >         if (FUSE_IS_VIRTIO_DAX(fi))
> >                 return fuse_dax_read_iter(iocb, to);
> > +       if (fuse_file_famfs(fi))
> > +               return famfs_fuse_read_iter(iocb, to);
> >
> >         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> >         if (ff->open_flags & FOPEN_DIRECT_IO)
> > @@ -1896,6 +1898,8 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >
> >         if (FUSE_IS_VIRTIO_DAX(fi))
> >                 return fuse_dax_write_iter(iocb, from);
> > +       if (fuse_file_famfs(fi))
> > +               return famfs_fuse_write_iter(iocb, from);
> >
> >         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> >         if (ff->open_flags & FOPEN_DIRECT_IO)
> > @@ -1911,10 +1915,14 @@ static ssize_t fuse_splice_read(struct file *in, loff_t *ppos,
> >                                 unsigned int flags)
> >  {
> >         struct fuse_file *ff = in->private_data;
> > +       struct inode *inode = file_inode(in);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> >
> >         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> >         if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
> >                 return fuse_passthrough_splice_read(in, ppos, pipe, len, flags);
> > +       else if (fuse_file_famfs(fi))
> > +               return -EIO; /* direct I/O doesn't make sense in dax_iomap */
> >         else
> >                 return filemap_splice_read(in, ppos, pipe, len, flags);
> >  }
> > @@ -1923,10 +1931,14 @@ static ssize_t fuse_splice_write(struct pipe_inode_info *pipe, struct file *out,
> >                                  loff_t *ppos, size_t len, unsigned int flags)
> >  {
> >         struct fuse_file *ff = out->private_data;
> > +       struct inode *inode = file_inode(out);
> > +       struct fuse_inode *fi = get_fuse_inode(inode);
> >
> >         /* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> >         if (fuse_file_passthrough(ff) && !(ff->open_flags & FOPEN_DIRECT_IO))
> >                 return fuse_passthrough_splice_write(pipe, out, ppos, len, flags);
> > +       else if (fuse_file_famfs(fi))
> > +               return -EIO; /* direct I/O doesn't make sense in dax_iomap */
> >         else
> >                 return iter_file_splice_write(pipe, out, ppos, len, flags);
> >  }
> 
> This looks odd.
> 
> Usually, the methods first check for FUSE_IS_VIRTIO_DAX() and
> fuse_file_famfs() to get this condition out of the way so I never needed
> to think about whether or not the code verifies that fuse_file_passthrough()
> and fuse_file_famfs() cannot co-exist.
> 
> Is there a reason why you did not follow the same pattern here?

I think I just got a little sloppy. I'll do the famfs test first. Unless we
can rule out this path for famfs. But unlike virtiofs, famfs doesn't have 
separate file_operations, so I suppose it must be checked.

> 
> Also, your comment makes no sense.
> splice is not the case of direct I/O - quite the contrary.

Sorry, brain fart on the comment. Splice doesn't make sense for famfs because
famfs doesn't use the page cache. Will fix the comment too.

> 
> Thanks,
> Amir.

Thank you Amir!
John


