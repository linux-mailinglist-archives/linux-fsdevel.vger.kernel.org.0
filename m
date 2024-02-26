Return-Path: <linux-fsdevel+bounces-12804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEE686759D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A603A1F25C42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24337FBD8;
	Mon, 26 Feb 2024 12:51:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33507F7D0;
	Mon, 26 Feb 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951903; cv=none; b=cvH6b3rsHOT4J0uz7vaEBWwDH89lRhije050IMlwEWVcfdB+ZmYzaLXqy8162o0m9+NSHiLniu3LhUAi1s/ji/QafPFjc2t0CvJgK9aXvqwadnvD4wnMtKt71ayodfPcHdqHcXOZDUDyAx1l5ik8Hp4488ieHMb2znJlov84tCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951903; c=relaxed/simple;
	bh=WXZHOU0/VVsz2WZBsy4+DbitB3SDhWUUx6Cp0aYy9iI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnBUE0jFubCTuduXcddWtQQiBa1bSQdbseaNvehtsjKsUWJFEi+ZbZc8eougetnGpPe0h2pj5vOCQEVpKoGv9BKmNc3wYliUU1yBTWyZW5i5DoK2xUK60n+3MY2Ke6nKidHPIpdRbaflEtHpgAeycoGECS/oar9TNcNBw8Ws5JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk0kb5lhdz689Hq;
	Mon, 26 Feb 2024 20:47:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5A6C71400DB;
	Mon, 26 Feb 2024 20:51:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 12:51:37 +0000
Date: Mon, 26 Feb 2024 12:51:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: John Groves <John@Groves.net>
CC: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, "Dan
 Williams" <dan.j.williams@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	<linux-cxl@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <john@jagalactic.com>, Dave Chinner
	<david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>,
	<dave.hansen@linux.intel.com>, <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 09/20] famfs: Add super_operations
Message-ID: <20240226125136.00002e64@Huawei.com>
In-Reply-To: <537f836056c141ae093c42b9623d20de919083b1.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<537f836056c141ae093c42b9623d20de919083b1.1708709155.git.john@groves.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:41:53 -0600
John Groves <John@Groves.net> wrote:

> Introduce the famfs superblock operations
> 
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/famfs/famfs_inode.c | 72 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 fs/famfs/famfs_inode.c
> 
> diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> new file mode 100644
> index 000000000000..3329aff000d1
> --- /dev/null
> +++ b/fs/famfs/famfs_inode.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * famfs - dax file system for shared fabric-attached memory
> + *
> + * Copyright 2023-2024 Micron Technology, inc
> + *
> + * This file system, originally based on ramfs the dax support from xfs,
> + * is intended to allow multiple host systems to mount a common file system
> + * view of dax files that map to shared memory.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/pagemap.h>
> +#include <linux/highmem.h>
> +#include <linux/time.h>
> +#include <linux/init.h>
> +#include <linux/string.h>
> +#include <linux/backing-dev.h>
> +#include <linux/sched.h>
> +#include <linux/parser.h>
> +#include <linux/magic.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
> +#include <linux/seq_file.h>
> +#include <linux/dax.h>
> +#include <linux/hugetlb.h>
> +#include <linux/uio.h>
> +#include <linux/iomap.h>
> +#include <linux/path.h>
> +#include <linux/namei.h>
> +#include <linux/pfn_t.h>
> +#include <linux/blkdev.h>

That's a lot of header for such a small patch.. I'm going to guess
they aren't all used - bring them in as you need them - I hope
you never need some of these!


> +
> +#include "famfs_internal.h"
> +
> +#define FAMFS_DEFAULT_MODE	0755
> +
> +static const struct super_operations famfs_ops;
> +static const struct inode_operations famfs_file_inode_operations;
> +static const struct inode_operations famfs_dir_inode_operations;

Why are these all up here?

> +
> +/**********************************************************************************
> + * famfs super_operations
> + *
> + * TODO: implement a famfs_statfs() that shows size, free and available space, etc.
> + */
> +
> +/**
> + * famfs_show_options() - Display the mount options in /proc/mounts.
Run kernel doc script + fix all warnings.

> + */
> +static int famfs_show_options(
> +	struct seq_file *m,
> +	struct dentry   *root)
Not that familiar with fs code, but this unusual kernel style. I'd go with 
something more common

static int famfs_show_options(struct seq_file *m, struct dentry *root)

> +{
> +	struct famfs_fs_info *fsi = root->d_sb->s_fs_info;
> +
> +	if (fsi->mount_opts.mode != FAMFS_DEFAULT_MODE)
> +		seq_printf(m, ",mode=%o", fsi->mount_opts.mode);
> +
> +	return 0;
> +}
> +
> +static const struct super_operations famfs_ops = {
> +	.statfs		= simple_statfs,
> +	.drop_inode	= generic_delete_inode,
> +	.show_options	= famfs_show_options,
> +};
> +
> +
One blank line probably fine.


Add the rest of the stuff a module normally has, author etc in this
patch.

> +MODULE_LICENSE("GPL");


