Return-Path: <linux-fsdevel+bounces-18647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96008BAEA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EF82842B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 14:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10566154BF4;
	Fri,  3 May 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyim2pkC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7F154441;
	Fri,  3 May 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745710; cv=none; b=iKY2i38aFBhUTwlepu6Qnd/AZRx+GZCee+6IEd/rzG1wsrJO6nHUXBVJ9AEy0AIOUZWlExJDfmuoyTG5Xn+FU7Isrq+NeKdrM7x9BF0cYqlQ/Qd2vnKvomgPWhL0KaZdIBnle0K5tRb6ZHWTFIyTFQy2TTcsOgxp9wDaLWPjJXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745710; c=relaxed/simple;
	bh=Id6ElNj0sEpoRegcL0Is1k1R9hLfr2Yeu3kdZOF2mrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0Ur03qZJq2R1yfBkWdiiCuaZrWbRakoryIa5QB49qtNILTHk5fxaFfeWGqB/DKKh5n4j8tllsz5s6oD/mhXdsRa1uFz6t7EEE4d5WJ8rIHukguXZxyDYlicjehfaH3NEro0JzhstAUlkEq7lVFn6yuGR02Ea6WQehxCbDQxGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyim2pkC; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c70b652154so5532367b6e.2;
        Fri, 03 May 2024 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714745707; x=1715350507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrX77LDgQ9AjxKMcOfntaYcMmlEdkaEGEXeOOAW7N6A=;
        b=Wyim2pkC5W92KZCElZv5GvktMjmL60/9tjU3l4VWPpwYieI8Ge4Wru33YX3WD+wdBz
         rVGTUmReXOs/2VfjpxTNriyFSy7Fpyml4+b6zJzqyz3o1pGyrF+8QHAybHQwMmQ9zMUg
         2tTfee15KIimauPYGvvvoR4+lrQjiZ6e+giTJPQiDToBfkqQbj3zrY3XoU6V+9XUYFyi
         Qq1FcT91uPc5ncPoglwZTrojS/r9H8f1x+GQQrRzODkeUncZscCNKqTAazlo1tzv8UA6
         qteoT2sQ4aHnmwMKgwIINBaNuuhEwa9pc2pRt+v2Oh/d/3Yl5mWxDYVc9mPDvMKTQkxj
         Mf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714745707; x=1715350507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrX77LDgQ9AjxKMcOfntaYcMmlEdkaEGEXeOOAW7N6A=;
        b=dqRYJpEJMPZFw6UWbX2ve2AT0qsvjlOdmB6Vl65NVTWkMpEmfxlYU14DSILWYoUGiq
         laWvChdKIazQ0L6LFoPDzlTP5paXDhw3zGRhU6age4OZ52hnCo70XL+T3S5Pyc5aANoe
         f1yNEly0/qEPmWDXehGJv+GcD4k3FRQrYVd036651bBND11UpgNLnb409vRq0/S08Jo9
         iR1D+h4m1PsDiJBqmkaUQaKasme8J+bn/BCTttRm+0f8ja8ogb9mWakJgQXq7n9SJClJ
         K+E8nh7L/K1P0vtr/FjRvfFs84yC5VpmuD4goywPhEm/9/Up1JYLsWljsHFQJqA60FN6
         09sw==
X-Forwarded-Encrypted: i=1; AJvYcCVyQCo5aGuE+dzDOBvAv7X8Vfe38uX+1MADqncrQ/WEQ0oyqRhnRkwXnOY6kfwFbKsuYYlsj7HI6x3no1DfaP+L1lUTt6+CQ2iZxx0XeySuF9JeXG/JFKnucMWKoGNd66Ggo6eo3brQCA==
X-Gm-Message-State: AOJu0YxuhtzO/8A7VfNF9Aib4coADneOGMjARK5DCArHJ9FPoU28B9tX
	a5mOIEQP6zedMrzCiV6o2gP4fZ4+YBXsS/FHJ0KMTfAWhZkOgK7H
X-Google-Smtp-Source: AGHT+IF1f6K9lV+bRbMym2R+gd9eOO7t2eNJ7d80IbJ7WhVcFdePW18b30bt+8JSpXjB+4HIDr7M2g==
X-Received: by 2002:a05:6808:4346:b0:3c7:41ba:102f with SMTP id dx6-20020a056808434600b003c741ba102fmr2927770oib.34.1714745706479;
        Fri, 03 May 2024 07:15:06 -0700 (PDT)
Received: from Borg-10.local (syn-070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id en2-20020a056808394200b003c85ab75886sm529220oib.5.2024.05.03.07.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 07:15:05 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 3 May 2024 09:15:03 -0500
From: John Groves <John@groves.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	John Groves <jgroves@micron.com>, john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com, 
	Randy Dunlap <rdunlap@infradead.org>, Jerome Glisse <jglisse@google.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Ravi Shankar <venkataravis@micron.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Chandan Babu R <chandanbabu@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Steve French <stfrench@microsoft.com>, 
	Nathan Lynch <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Julien Panis <jpanis@baylibre.com>, 
	Stanislav Fomichev <sdf@google.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH v2 08/12] famfs: module operations & fs_context
Message-ID: <xpban4zhri7hhxy4fv6j6kmqjlm3fid7n6lrzsr7fsfthxqxwq@xhsqipkvnd7w>
References: <cover.1714409084.git.john@groves.net>
 <86694a1a663ab0b6e8e35c7b187f5ad179103482.1714409084.git.john@groves.net>
 <20240430-badeverbot-paletten-05442cfbbdf0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-badeverbot-paletten-05442cfbbdf0@brauner>

On 24/04/30 01:01PM, Christian Brauner wrote:
> On Mon, Apr 29, 2024 at 12:04:24PM -0500, John Groves wrote:
> > Start building up from the famfs module operations. This commit
> > includes the following:
> > 
> > * Register as a file system
> > * Parse mount parameters
> > * Allocate or find (and initialize) a superblock via famfs_get_tree()
> > * Lookup the host dax device, and bail if it's in use (or not dax)
> > * Register as the holder of the dax device if it's available
> > * Add Kconfig and Makefile misc to build famfs
> > * Add FAMFS_SUPER_MAGIC to include/uapi/linux/magic.h
> > * Add export of fs/namei.c:may_open_dev(), which famfs needs to call
> > * Update MAINTAINERS file for the fs/famfs/ path
> > 
> > The following exports had to happen to enable famfs:
> > 
> > * This uses the new fs/super.c:kill_char_super() - the other kill*super
> >   helpers were not quite right.
> > * This uses the dev_dax_iomap export of dax_dev_get()
> > 
> > This commit builds but is otherwise too incomplete to run
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  MAINTAINERS                |   1 +
> >  fs/Kconfig                 |   2 +
> >  fs/Makefile                |   1 +
> >  fs/famfs/Kconfig           |  10 ++
> >  fs/famfs/Makefile          |   5 +
> >  fs/famfs/famfs_inode.c     | 345 +++++++++++++++++++++++++++++++++++++
> >  fs/famfs/famfs_internal.h  |  36 ++++
> >  fs/namei.c                 |   1 +
> >  include/uapi/linux/magic.h |   1 +
> >  9 files changed, 402 insertions(+)
> >  create mode 100644 fs/famfs/Kconfig
> >  create mode 100644 fs/famfs/Makefile
> >  create mode 100644 fs/famfs/famfs_inode.c
> >  create mode 100644 fs/famfs/famfs_internal.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 3f2d847dcf01..365d678e2f40 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8188,6 +8188,7 @@ L:	linux-cxl@vger.kernel.org
> >  L:	linux-fsdevel@vger.kernel.org
> >  S:	Supported
> >  F:	Documentation/filesystems/famfs.rst
> > +F:	fs/famfs
> >  
> >  FANOTIFY
> >  M:	Jan Kara <jack@suse.cz>
> > diff --git a/fs/Kconfig b/fs/Kconfig
> > index a46b0cbc4d8f..53b4629e92a0 100644
> > --- a/fs/Kconfig
> > +++ b/fs/Kconfig
> > @@ -140,6 +140,8 @@ source "fs/autofs/Kconfig"
> >  source "fs/fuse/Kconfig"
> >  source "fs/overlayfs/Kconfig"
> >  
> > +source "fs/famfs/Kconfig"
> > +
> >  menu "Caches"
> >  
> >  source "fs/netfs/Kconfig"
> > diff --git a/fs/Makefile b/fs/Makefile
> > index 6ecc9b0a53f2..3393f399a9e9 100644
> > --- a/fs/Makefile
> > +++ b/fs/Makefile
> > @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
> >  obj-$(CONFIG_EROFS_FS)		+= erofs/
> >  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
> >  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> > +obj-$(CONFIG_FAMFS)             += famfs/
> > diff --git a/fs/famfs/Kconfig b/fs/famfs/Kconfig
> > new file mode 100644
> > index 000000000000..edb8980820f7
> > --- /dev/null
> > +++ b/fs/famfs/Kconfig
> > @@ -0,0 +1,10 @@
> > +
> > +
> > +config FAMFS
> > +       tristate "famfs: shared memory file system"
> > +       depends on DEV_DAX && FS_DAX && DEV_DAX_IOMAP
> > +       help
> > +	  Support for the famfs file system. Famfs is a dax file system that
> > +	  can support scale-out shared access to fabric-attached memory
> > +	  (e.g. CXL shared memory). Famfs is not a general purpose file system;
> > +	  it is an enabler for data sets in shared memory.
> > diff --git a/fs/famfs/Makefile b/fs/famfs/Makefile
> > new file mode 100644
> > index 000000000000..62230bcd6793
> > --- /dev/null
> > +++ b/fs/famfs/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +obj-$(CONFIG_FAMFS) += famfs.o
> > +
> > +famfs-y := famfs_inode.o
> > diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> > new file mode 100644
> > index 000000000000..61306240fc0b
> > --- /dev/null
> > +++ b/fs/famfs/famfs_inode.c
> > @@ -0,0 +1,345 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * famfs - dax file system for shared fabric-attached memory
> > + *
> > + * Copyright 2023-2024 Micron Technology, inc
> > + *
> > + * This file system, originally based on ramfs the dax support from xfs,
> > + * is intended to allow multiple host systems to mount a common file system
> > + * view of dax files that map to shared memory.
> > + */
> > +
> > +#include <linux/fs.h>
> > +#include <linux/time.h>
> > +#include <linux/init.h>
> > +#include <linux/string.h>
> > +#include <linux/parser.h>
> > +#include <linux/magic.h>
> > +#include <linux/slab.h>
> > +#include <linux/fs_context.h>
> > +#include <linux/fs_parser.h>
> > +#include <linux/dax.h>
> > +#include <linux/hugetlb.h>
> > +#include <linux/iomap.h>
> > +#include <linux/path.h>
> > +#include <linux/namei.h>
> > +
> > +#include "famfs_internal.h"
> > +
> > +#define FAMFS_DEFAULT_MODE	0755
> > +
> > +static struct inode *famfs_get_inode(struct super_block *sb,
> > +				     const struct inode *dir,
> > +				     umode_t mode, dev_t dev)
> > +{
> > +	struct inode *inode = new_inode(sb);
> > +	struct timespec64 tv;
> > +
> > +	if (!inode)
> > +		return NULL;
> > +
> > +	inode->i_ino = get_next_ino();
> > +	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
> > +	inode->i_mapping->a_ops = &ram_aops;
> > +	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> > +	mapping_set_unevictable(inode->i_mapping);
> > +	tv = inode_set_ctime_current(inode);
> > +	inode_set_mtime_to_ts(inode, tv);
> > +	inode_set_atime_to_ts(inode, tv);
> > +
> > +	switch (mode & S_IFMT) {
> > +	default:
> > +		init_special_inode(inode, mode, dev);
> > +		break;
> > +	case S_IFREG:
> > +		inode->i_op = NULL /* famfs_file_inode_operations */;
> > +		inode->i_fop = NULL /* &famfs_file_operations */;
> > +		break;
> > +	case S_IFDIR:
> > +		inode->i_op = NULL /* famfs_dir_inode_operations */;
> > +		inode->i_fop = &simple_dir_operations;
> > +
> > +		/* Directory inodes start off with i_nlink == 2 (for ".") */
> > +		inc_nlink(inode);
> > +		break;
> > +	case S_IFLNK:
> > +		inode->i_op = &page_symlink_inode_operations;
> > +		inode_nohighmem(inode);
> > +		break;
> > +	}
> > +	return inode;
> > +}
> > +
> > +/*
> > + * famfs dax_operations  (for char dax)
> > + */
> > +static int
> > +famfs_dax_notify_failure(struct dax_device *dax_dev, u64 offset,
> > +			u64 len, int mf_flags)
> > +{
> > +	struct super_block *sb = dax_holder(dax_dev);
> > +	struct famfs_fs_info *fsi = sb->s_fs_info;
> > +
> > +	pr_err("%s: rootdev=%s offset=%lld len=%llu flags=%x\n", __func__,
> > +	       fsi->rootdev, offset, len, mf_flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct dax_holder_operations famfs_dax_holder_ops = {
> > +	.notify_failure		= famfs_dax_notify_failure,
> > +};
> > +
> > +/*****************************************************************************
> > + * fs_context_operations
> > + */
> > +
> > +static int
> > +famfs_fill_super(struct super_block *sb, struct fs_context *fc)
> > +{
> > +	int rc = 0;
> > +
> > +	sb->s_maxbytes		= MAX_LFS_FILESIZE;
> > +	sb->s_blocksize		= PAGE_SIZE;
> > +	sb->s_blocksize_bits	= PAGE_SHIFT;
> > +	sb->s_magic		= FAMFS_SUPER_MAGIC;
> > +	sb->s_op		= NULL /* famfs_super_ops */;
> > +	sb->s_time_gran		= 1;
> > +
> > +	return rc;
> > +}
> > +
> > +static int
> > +lookup_daxdev(const char *pathname, dev_t *devno)
> > +{
> > +	struct inode *inode;
> > +	struct path path;
> > +	int err;
> > +
> > +	if (!pathname || !*pathname)
> > +		return -EINVAL;
> > +
> > +	err = kern_path(pathname, LOOKUP_FOLLOW, &path);
> > +	if (err)
> > +		return err;
> > +
> > +	inode = d_backing_inode(path.dentry);
> > +	if (!S_ISCHR(inode->i_mode)) {
> > +		err = -EINVAL;
> > +		goto out_path_put;
> > +	}
> > +
> > +	if (!may_open_dev(&path)) { /* had to export this */
> > +		err = -EACCES;
> > +		goto out_path_put;
> > +	}
> > +
> > +	 /* if it's dax, i_rdev is struct dax_device */
> > +	*devno = inode->i_rdev;
> > +
> > +out_path_put:
> > +	path_put(&path);
> > +	return err;
> > +}
> > +
> > +static int
> > +famfs_get_tree(struct fs_context *fc)
> > +{
> > +	struct famfs_fs_info *fsi = fc->s_fs_info;
> > +	struct dax_device *dax_devp;
> > +	struct super_block *sb;
> > +	struct inode *inode;
> > +	dev_t daxdevno;
> > +	int err;
> > +
> > +	/* TODO: clean up chatty messages */
> > +
> > +	err = lookup_daxdev(fc->source, &daxdevno);
> > +	if (err)
> > +		return err;
> > +
> > +	fsi->daxdevno = daxdevno;
> > +
> > +	/* This will set sb->s_dev=daxdevno */
> > +	sb = sget_dev(fc, daxdevno);
> 
> This will open the dax device as a block device. However, nothing in
> your ->kill_sb method or kill_char_super() closes it again. So you're
> leaking block device references and leaving unitialized memory around as
> you've claimed that device but never ended your claim.
> 
> > +	if (IS_ERR(sb)) {
> > +		pr_err("%s: sget_dev error\n", __func__);
> > +		return PTR_ERR(sb);
> > +	}
> > +
> > +	if (sb->s_root) {
> > +		pr_info("%s: found a matching suerblock for %s\n",
> > +			__func__, fc->source);
> > +
> > +		/* We don't expect to find a match by dev_t; if we do, it must
> > +		 * already be mounted, so we bail
> > +		 */
> > +		err = -EBUSY;
> > +		goto deactivate_out;
> > +	} else {
> > +		pr_info("%s: initializing new superblock for %s\n",
> > +			__func__, fc->source);
> > +		err = famfs_fill_super(sb, fc);
> > +		if (err)
> > +			goto deactivate_out;
> > +	}
> > +
> > +	/* This will fail if it's not a dax device */
> > +	dax_devp = dax_dev_get(daxdevno);
> > +	if (!dax_devp) {
> > +		pr_warn("%s: device %s not found or not dax\n",
> > +		       __func__, fc->source);
> > +		err = -ENODEV;
> > +		goto deactivate_out;
> > +	}
> > +
> > +	err = fs_dax_get(dax_devp, sb, &famfs_dax_holder_ops);
> > +	if (err) {
> > +		pr_err("%s: fs_dax_get(%lld) failed\n", __func__, (u64)daxdevno);
> > +		err = -EBUSY;
> > +		goto deactivate_out;
> > +	}
> > +	fsi->dax_devp = dax_devp;
> > +
> > +	inode = famfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
> > +	sb->s_root = d_make_root(inode);
> > +	if (!sb->s_root) {
> > +		pr_err("%s: d_make_root() failed\n", __func__);
> > +		err = -ENOMEM;
> > +		fs_put_dax(fsi->dax_devp, sb);
> > +		goto deactivate_out;
> > +	}
> > +
> > +	sb->s_flags |= SB_ACTIVE;
> > +
> > +	WARN_ON(fc->root);
> > +	fc->root = dget(sb->s_root);
> > +	return err;
> > +
> > +deactivate_out:
> > +	pr_debug("%s: deactivating sb=%llx\n", __func__, (u64)sb);
> > +	deactivate_locked_super(sb);
> > +	return err;
> > +}
> > +
> > +/*****************************************************************************/
> > +
> > +enum famfs_param {
> > +	Opt_mode,
> > +	Opt_dax,
> > +};
> > +
> > +const struct fs_parameter_spec famfs_fs_parameters[] = {
> > +	fsparam_u32oct("mode",	  Opt_mode),
> > +	fsparam_string("dax",     Opt_dax),
> > +	{}
> > +};
> > +
> > +static int famfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> > +{
> > +	struct famfs_fs_info *fsi = fc->s_fs_info;
> > +	struct fs_parse_result result;
> > +	int opt;
> > +
> > +	opt = fs_parse(fc, famfs_fs_parameters, param, &result);
> > +	if (opt == -ENOPARAM) {
> > +		opt = vfs_parse_fs_param_source(fc, param);
> > +		if (opt != -ENOPARAM)
> > +			return opt;
> 
> This shouldn't be needed. The VFS will handle all that for you.
> 
> > +
> > +		return 0;
> > +	}
> > +	if (opt < 0)
> > +		return opt;
> > +
> > +	switch (opt) {
> > +	case Opt_mode:
> > +		fsi->mount_opts.mode = result.uint_32 & S_IALLUGO;
> > +		break;
> > +	case Opt_dax:
> > +		if (strcmp(param->string, "always"))
> > +			pr_notice("%s: invalid dax mode %s\n",
> > +				  __func__, param->string);
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void famfs_free_fc(struct fs_context *fc)
> > +{
> > +	struct famfs_fs_info *fsi = fc->s_fs_info;
> > +
> > +	if (fsi && fsi->rootdev)
> > +		kfree(fsi->rootdev);
> 
> Dead code since rootdev is unused an unset?
> 
> > +
> > +	kfree(fsi);
> > +}
> > +
> > +static const struct fs_context_operations famfs_context_ops = {
> > +	.free		= famfs_free_fc,
> > +	.parse_param	= famfs_parse_param,
> > +	.get_tree	= famfs_get_tree,
> > +};
> > +
> > +static int famfs_init_fs_context(struct fs_context *fc)
> > +{
> > +	struct famfs_fs_info *fsi;
> > +
> > +	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
> > +	if (!fsi)
> > +		return -ENOMEM;
> > +
> > +	fsi->mount_opts.mode = FAMFS_DEFAULT_MODE;
> > +	fc->s_fs_info        = fsi;
> > +	fc->ops              = &famfs_context_ops;
> > +	return 0;
> > +}
> > +
> > +static void famfs_kill_sb(struct super_block *sb)
> > +{
> > +	struct famfs_fs_info *fsi = sb->s_fs_info;
> > +
> > +	if (fsi->dax_devp)
> > +		fs_put_dax(fsi->dax_devp, sb);
> > +	if (fsi && fsi->rootdev)
> > +		kfree(fsi->rootdev);
> > +	kfree(fsi);
> > +	sb->s_fs_info = NULL;
> > +
> > +	kill_char_super(sb); /* new */
> > +}
> 
> Can likely just be
> 
> static void famfs_kill_sb(struct super_block *sb)
> {
> 	struct famfs_fs_info *fsi = sb->s_fs_info;
> 
> 	generic_shutdown_super(sb);
> 
>         if (sb->s_bdev_file)
> 		bdev_fput(sb->s_bdev_file);
> 
> 	if (fsi->dax_devp)
> 		fs_put_dax(fsi->dax_devp, sb);
> 
> 	kfree(fsi);
> }
> 
> and then you don't need any custom helpers at all.

I replaced famfs_kill_sb() with this function.  On [the first] umount, I
get one of these dentry bugs for each file in the file system:


    May 03 07:27:03 f39-dev1 kernel: ------------[ cut here ]------------
    May 03 07:27:03 f39-dev1 kernel: BUG: Dentry 0000000033362594{i=217d,n=smoke_loop4.log}  still in use (1) [unmount of famfs famfs]
    May 03 07:27:03 f39-dev1 kernel: WARNING: CPU: 0 PID: 1138 at fs/dcache.c:1524 umount_check+0x56/0x70
    May 03 07:27:03 f39-dev1 kernel: Modules linked in: famfs rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs qrtr rfkill intel_rapl_msr sunrpc snd_hda_codec_generic intel_rapl_common snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm_intel snd_hda_codec kmem snd_hda_core iTCO_wdt intel_pmc_bxt snd_hwdep device_dax iTCO_vendor_support kvm snd_seq snd_seq_device rapl dax_hmem cxl_acpi snd_pcm cxl_core i2c_i801 snd_timer einj pcspkr i2c_smbus snd lpc_ich soundcore virtio_balloon joydev vfat fat fuse loop zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 virtio_blk virtio_console virtio_gpu virtio_net net_failover virtio_dma_buf failover serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath qemu_fw_cfg
    May 03 07:27:03 f39-dev1 kernel: CPU: 0 PID: 1138 Comm: umount Tainted: G        W          6.9.0-rc5+ #266
    May 03 07:27:03 f39-dev1 kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230301gitf80f052277c8-26.fc38 03/01/2023
    May 03 07:27:03 f39-dev1 kernel: RIP: 0010:umount_check+0x56/0x70
    May 03 07:27:03 f39-dev1 kernel: Code: 03 00 00 48 8b 40 28 48 89 e5 4c 8b 08 48 8b 46 30 48 85 c0 74 04 48 8b 50 40 51 48 c7 c7 b0 a6 ae 82 48 89 f1 e8 ba 56 c4 ff <0f> 0b 58 31 c0 c9 c3 cc cc cc cc 41 83 f8 01 75 ba eb a8 0f 1f 80
    May 03 07:27:03 f39-dev1 kernel: RSP: 0018:ffffc90000717bd0 EFLAGS: 00010282
    May 03 07:27:03 f39-dev1 kernel: RAX: 0000000000000000 RBX: 0000000000000f34 RCX: 0000000000000000
    May 03 07:27:03 f39-dev1 kernel: RDX: 0000000000000004 RSI: ffffffff82b1c111 RDI: 00000000ffffffff
    May 03 07:27:03 f39-dev1 kernel: RBP: ffffc90000717bd8 R08: 0000000000000000 R09: 0000000000000003
    May 03 07:27:03 f39-dev1 kernel: R10: ffffc90000717a20 R11: ffffffff82f3c3a8 R12: ffff8881007be840
    May 03 07:27:03 f39-dev1 kernel: R13: ffffffff814d8ae0 R14: ffff8881007be8a0 R15: ffff88810d82ab40
    May 03 07:27:03 f39-dev1 kernel: FS:  00007f3163f71800(0000) GS:ffff88886fc00000(0000) knlGS:0000000000000000
    May 03 07:27:03 f39-dev1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    May 03 07:27:03 f39-dev1 kernel: CR2: 00007fff84673f78 CR3: 000000010c338002 CR4: 0000000000170ef0
    May 03 07:27:03 f39-dev1 kernel: Call Trace:
    May 03 07:27:03 f39-dev1 kernel:  <TASK>
    May 03 07:27:03 f39-dev1 kernel:  ? show_regs+0x64/0x70
    May 03 07:27:03 f39-dev1 kernel:  ? __warn+0x88/0x130
    May 03 07:27:03 f39-dev1 kernel:  ? umount_check+0x56/0x70
    May 03 07:27:03 f39-dev1 kernel:  ? report_bug+0x192/0x1c0
    May 03 07:27:03 f39-dev1 kernel:  ? handle_bug+0x44/0x90
    May 03 07:27:03 f39-dev1 kernel:  ? exc_invalid_op+0x18/0x70
    May 03 07:27:03 f39-dev1 kernel:  ? asm_exc_invalid_op+0x1b/0x20
    May 03 07:27:03 f39-dev1 kernel:  ? __pfx_umount_check+0x10/0x10
    May 03 07:27:03 f39-dev1 kernel:  ? umount_check+0x56/0x70
    May 03 07:27:03 f39-dev1 kernel:  d_walk+0xc3/0x280
    May 03 07:27:03 f39-dev1 kernel:  shrink_dcache_for_umount+0x4e/0x130
    May 03 07:27:03 f39-dev1 kernel:  generic_shutdown_super+0x1f/0x120
    May 03 07:27:03 f39-dev1 kernel:  famfs_kill_sb+0x1b/0x70 [famfs]
    May 03 07:27:03 f39-dev1 kernel:  deactivate_locked_super+0x35/0xb0
    May 03 07:27:03 f39-dev1 kernel:  deactivate_super+0x40/0x50
    May 03 07:27:03 f39-dev1 kernel:  cleanup_mnt+0xc3/0x160
    May 03 07:27:03 f39-dev1 kernel:  __cleanup_mnt+0x12/0x20
    May 03 07:27:03 f39-dev1 kernel:  task_work_run+0x60/0x90
    May 03 07:27:03 f39-dev1 kernel:  syscall_exit_to_user_mode+0x21a/0x220
    May 03 07:27:03 f39-dev1 kernel:  do_syscall_64+0x8d/0x180
    May 03 07:27:03 f39-dev1 kernel:  ? mntput+0x24/0x40
    May 03 07:27:03 f39-dev1 kernel:  ? path_put+0x1e/0x30
    May 03 07:27:03 f39-dev1 kernel:  ? do_faccessat+0x1b8/0x2e0
    May 03 07:27:03 f39-dev1 kernel:  ? syscall_exit_to_user_mode+0x7c/0x220
    May 03 07:27:03 f39-dev1 kernel:  ? do_syscall_64+0x8d/0x180
    May 03 07:27:03 f39-dev1 kernel:  ? putname+0x55/0x70
    May 03 07:27:03 f39-dev1 kernel:  ? syscall_exit_to_user_mode+0x7c/0x220
    May 03 07:27:03 f39-dev1 kernel:  ? do_syscall_64+0x8d/0x180
    May 03 07:27:03 f39-dev1 kernel:  ? do_user_addr_fault+0x315/0x6e0
    May 03 07:27:03 f39-dev1 kernel:  ? irqentry_exit_to_user_mode+0x71/0x220
    May 03 07:27:03 f39-dev1 kernel:  ? irqentry_exit+0x3b/0x50
    May 03 07:27:03 f39-dev1 kernel:  ? exc_page_fault+0x90/0x190
    May 03 07:27:03 f39-dev1 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
    May 03 07:27:03 f39-dev1 kernel: RIP: 0033:0x7f316419041b
    May 03 07:27:03 f39-dev1 kernel: Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 e1 19 0c 00 f7 d8
    May 03 07:27:03 f39-dev1 kernel: RSP: 002b:00007fff84675728 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
    May 03 07:27:03 f39-dev1 kernel: RAX: 0000000000000000 RBX: 00005648cab2eb90 RCX: 00007f316419041b
    May 03 07:27:03 f39-dev1 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005648cab33ba0
    May 03 07:27:03 f39-dev1 kernel: RBP: 00007fff84675800 R08: 0000000000000020 R09: 0000000000000001
    May 03 07:27:03 f39-dev1 kernel: R10: 0000000000000004 R11: 0000000000000246 R12: 00005648cab2ec90
    May 03 07:27:03 f39-dev1 kernel: R13: 0000000000000000 R14: 00005648cab33ba0 R15: 00005648cab2efa0
    May 03 07:27:03 f39-dev1 kernel:  </TASK>
    May 03 07:27:03 f39-dev1 kernel: ---[ end trace 0000000000000000 ]---

After one of the above for every file:

    May 03 07:27:03 f39-dev1 kernel: VFS: Busy inodes after unmount of famfs (famfs)

    May 03 07:27:03 f39-dev1 kernel: ------------[ cut here ]------------
    May 03 07:27:03 f39-dev1 kernel: kernel BUG at fs/super.c:649!
    May 03 07:27:03 f39-dev1 kernel: invalid opcode: 0000 [#1] PREEMPT SMP PTI
    May 03 07:27:03 f39-dev1 kernel: CPU: 3 PID: 1138 Comm: umount Tainted: G        W          6.9.0-rc5+ #266
    May 03 07:27:03 f39-dev1 kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230301gitf80f052277c8-26.fc38 03/01/2023
    May 03 07:27:03 f39-dev1 kernel: RIP: 0010:generic_shutdown_super+0x112/0x120
    May 03 07:27:03 f39-dev1 kernel: Code: cc cc e8 e1 4f f0 ff 48 8b bb 00 01 00 00 eb d9 48 8b 43 28 48 8d b3 c0 03 00 00 48 c7 c7 c0 98 ae 82 48 8b 10 e8 5e 2d d0 ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
    May 03 07:27:03 f39-dev1 kernel: RSP: 0018:ffffc90000717c70 EFLAGS: 00010246
    May 03 07:27:03 f39-dev1 kernel: RAX: 000000000000002f RBX: ffff8881215d5000 RCX: 0000000000000000
    May 03 07:27:03 f39-dev1 kernel: RDX: 0000000000000000 RSI: ffffffff82b1c111 RDI: 00000000ffffffff
    May 03 07:27:03 f39-dev1 kernel: RBP: ffffc90000717c80 R08: 0000000000000000 R09: 0000000000000003
    May 03 07:27:03 f39-dev1 kernel: R10: ffffc90000717ad8 R11: ffffffff82f3c3a8 R12: ffffffffa0cf4380
    May 03 07:27:03 f39-dev1 kernel: R13: ffff888124ed359c R14: 0000000000000000 R15: 0000000000000000
    May 03 07:27:03 f39-dev1 kernel: FS:  00007f3163f71800(0000) GS:ffff88886fd80000(0000) knlGS:0000000000000000
    May 03 07:27:03 f39-dev1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    May 03 07:27:03 f39-dev1 kernel: CR2: 000055fd5fc6a370 CR3: 000000010c338003 CR4: 0000000000170ef0
    May 03 07:27:03 f39-dev1 kernel: Call Trace:
    May 03 07:27:03 f39-dev1 kernel:  <TASK>
    May 03 07:27:03 f39-dev1 kernel:  ? show_regs+0x64/0x70
    May 03 07:27:03 f39-dev1 kernel:  ? die+0x37/0x90
    May 03 07:27:03 f39-dev1 kernel:  ? do_trap+0xca/0xe0
    May 03 07:27:03 f39-dev1 kernel:  ? do_error_trap+0x73/0xa0
    May 03 07:27:03 f39-dev1 kernel:  ? generic_shutdown_super+0x112/0x120
    May 03 07:27:03 f39-dev1 kernel:  ? exc_invalid_op+0x52/0x70
    May 03 07:27:03 f39-dev1 kernel:  ? generic_shutdown_super+0x112/0x120
    May 03 07:27:03 f39-dev1 kernel:  ? asm_exc_invalid_op+0x1b/0x20
    May 03 07:27:03 f39-dev1 kernel:  ? generic_shutdown_super+0x112/0x120
    May 03 07:27:03 f39-dev1 kernel:  famfs_kill_sb+0x1b/0x70 [famfs]
    May 03 07:27:03 f39-dev1 kernel:  deactivate_locked_super+0x35/0xb0
    May 03 07:27:03 f39-dev1 kernel:  deactivate_super+0x40/0x50
    May 03 07:27:03 f39-dev1 kernel:  cleanup_mnt+0xc3/0x160
    May 03 07:27:03 f39-dev1 kernel:  __cleanup_mnt+0x12/0x20
    May 03 07:27:03 f39-dev1 kernel:  task_work_run+0x60/0x90
    May 03 07:27:03 f39-dev1 kernel:  syscall_exit_to_user_mode+0x21a/0x220
    May 03 07:27:03 f39-dev1 kernel:  do_syscall_64+0x8d/0x180
    May 03 07:27:03 f39-dev1 kernel:  ? mntput+0x24/0x40
    May 03 07:27:03 f39-dev1 kernel:  ? path_put+0x1e/0x30
    May 03 07:27:03 f39-dev1 kernel:  ? do_faccessat+0x1b8/0x2e0
    May 03 07:27:03 f39-dev1 kernel:  ? syscall_exit_to_user_mode+0x7c/0x220
    May 03 07:27:03 f39-dev1 kernel:  ? do_syscall_64+0x8d/0x180
    May 03 07:27:03 f39-dev1 kernel:  ? putname+0x55/0x70
    May 03 07:27:03 f39-dev1 kernel:  ? syscall_exit_to_user_mode+0x7c/0x220
    May 03 07:27:03 f39-dev1 kernel:  ? do_syscall_64+0x8d/0x180
    May 03 07:27:03 f39-dev1 kernel:  ? do_user_addr_fault+0x315/0x6e0
    May 03 07:27:03 f39-dev1 kernel:  ? irqentry_exit_to_user_mode+0x71/0x220
    May 03 07:27:03 f39-dev1 kernel:  ? irqentry_exit+0x3b/0x50
    May 03 07:27:03 f39-dev1 kernel:  ? exc_page_fault+0x90/0x190
    May 03 07:27:03 f39-dev1 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
    May 03 07:27:03 f39-dev1 kernel: RIP: 0033:0x7f316419041b
    May 03 07:27:03 f39-dev1 kernel: Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 e1 19 0c 00 f7 d8
    May 03 07:27:03 f39-dev1 kernel: RSP: 002b:00007fff84675728 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
    May 03 07:27:03 f39-dev1 kernel: RAX: 0000000000000000 RBX: 00005648cab2eb90 RCX: 00007f316419041b
    May 03 07:27:03 f39-dev1 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005648cab33ba0
    May 03 07:27:03 f39-dev1 kernel: RBP: 00007fff84675800 R08: 0000000000000020 R09: 0000000000000001
    May 03 07:27:03 f39-dev1 kernel: R10: 0000000000000004 R11: 0000000000000246 R12: 00005648cab2ec90
    May 03 07:27:03 f39-dev1 kernel: R13: 0000000000000000 R14: 00005648cab33ba0 R15: 00005648cab2efa0
    May 03 07:27:03 f39-dev1 kernel:  </TASK>
    May 03 07:27:03 f39-dev1 kernel: Modules linked in: famfs rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs qrtr rfkill intel_rapl_msr sunrpc snd_hda_codec_generic intel_rapl_common snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi kvm_intel snd_hda_codec kmem snd_hda_core iTCO_wdt intel_pmc_bxt snd_hwdep device_dax iTCO_vendor_support kvm snd_seq snd_seq_device rapl dax_hmem cxl_acpi snd_pcm cxl_core i2c_i801 snd_timer einj pcspkr i2c_smbus snd lpc_ich soundcore virtio_balloon joydev vfat fat fuse loop zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 virtio_blk virtio_console virtio_gpu virtio_net net_failover virtio_dma_buf failover serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath qemu_fw_cfg
    May 03 07:27:03 f39-dev1 kernel: ---[ end trace 0000000000000000 ]---

    May 03 07:27:03 f39-dev1 kernel: RIP: 0010:generic_shutdown_super+0x112/0x120
    May 03 07:27:03 f39-dev1 kernel: Code: cc cc e8 e1 4f f0 ff 48 8b bb 00 01 00 00 eb d9 48 8b 43 28 48 8d b3 c0 03 00 00 48 c7 c7 c0 98 ae 82 48 8b 10 e8 5e 2d d0 ff <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
    May 03 07:27:03 f39-dev1 kernel: RSP: 0018:ffffc90000717c70 EFLAGS: 00010246
    May 03 07:27:03 f39-dev1 kernel: RAX: 000000000000002f RBX: ffff8881215d5000 RCX: 0000000000000000
    May 03 07:27:03 f39-dev1 kernel: RDX: 0000000000000000 RSI: ffffffff82b1c111 RDI: 00000000ffffffff
    May 03 07:27:03 f39-dev1 kernel: RBP: ffffc90000717c80 R08: 0000000000000000 R09: 0000000000000003
    May 03 07:27:03 f39-dev1 kernel: R10: ffffc90000717ad8 R11: ffffffff82f3c3a8 R12: ffffffffa0cf4380
    May 03 07:27:03 f39-dev1 kernel: R13: ffff888124ed359c R14: 0000000000000000 R15: 0000000000000000
    May 03 07:27:03 f39-dev1 kernel: FS:  00007f3163f71800(0000) GS:ffff88886fd80000(0000) knlGS:0000000000000000
    May 03 07:27:03 f39-dev1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    May 03 07:27:03 f39-dev1 kernel: CR2: 000055fd5fc6a370 CR3: 000000010c338003 CR4: 0000000000170ef0

These BUG dumps are familiar; famfs_kill_sb()/kill_char_sb() in this
patch set are clean in this regard. (I'm not saying they're "right", but
clean). But to be clear, blowing away the dentries is appropriate in the
famfs case.

An important thing, I think, is that instantiation of famfs file
(which happens when user space plays the log) looks a lot like creating
ramfs files - except that after an empty ramfs-like file is created,
an ioctl is called to "tell the file where its backing memory is".
And famfs does not persist metadata changes, which is a feature and
not a bug...

I think the d_genocide() call is what cleans up the dentry cache with
famfs_kill_sb() from the patch (which calls the new kill_char_super()).

Thanks for any suggestions,
John


