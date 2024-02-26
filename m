Return-Path: <linux-fsdevel+bounces-12803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D7386758C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A285A28F88D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C191EC7;
	Mon, 26 Feb 2024 12:48:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E880020;
	Mon, 26 Feb 2024 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951705; cv=none; b=rKlnc7Cq7vXo0w0I8c0AORID3z7U2k22D9qy39sKNWJafxZrMthzQ27jEesI20nZOMAmtkXRkJaLje52NIveOsAczj+tu4J6Qg0V0rly4P1eTbFAsBcFJk6AVqv8XbyxNqz/EDe2crnuCiWgaGeZTQ3x8sNuent+qGoWNUd9ivA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951705; c=relaxed/simple;
	bh=A5fVjk1SgP+2ltBG8VhkDLaQNzbQ1PoBtwp3T6NOQ4I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWVsjv4DwjtcoWc6Gz2Y9JJhaZuOVpXMlg0/L9COhdFlIpU7CJfA0U3mKnH23pNEnS7kNMS7eqgK2kwicGf0mEHBxpRgfi7/kyNByjqW5KsxxXwmY6avULeYhQr2tton8O8ABUryXJQu6SV+taoz9mr53MM08f6FxKIuctXgumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk0fn3tSbz6K6Gc;
	Mon, 26 Feb 2024 20:44:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 188F0140D30;
	Mon, 26 Feb 2024 20:48:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 12:48:19 +0000
Date: Mon, 26 Feb 2024 12:48:18 +0000
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
Subject: Re: [RFC PATCH 08/20] famfs: Add famfs_internal.h
Message-ID: <20240226124818.0000251d@Huawei.com>
In-Reply-To: <13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:41:52 -0600
John Groves <John@Groves.net> wrote:

> Add the famfs_internal.h include file. This contains internal data
> structures such as the per-file metadata structure (famfs_file_meta)
> and extent formats.
> 
> Signed-off-by: John Groves <john@groves.net>
Hi John,

Build this up as you add the definitions in later patches.

Separate header patches just make people jump back and forth when trying
to review.  Obviously more work to build this stuff up cleanly but
it's worth doing to save review time.

Generally I'd plumb up Kconfig and Makefile a the beginning as it means
that the set is bisectable and we can check the logic of building each stage.
That is harder to do but tends to bring benefits in forcing clear step
wise approach on a patch set. Feel free to ignore this one though as it
can slow things down.

A few trivial comments inline.

> ---
>  fs/famfs/famfs_internal.h | 53 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 fs/famfs/famfs_internal.h
> 
> diff --git a/fs/famfs/famfs_internal.h b/fs/famfs/famfs_internal.h
> new file mode 100644
> index 000000000000..af3990d43305
> --- /dev/null
> +++ b/fs/famfs/famfs_internal.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * famfs - dax file system for shared fabric-attached memory
> + *
> + * Copyright 2023-2024 Micron Technology, Inc.
> + *
> + * This file system, originally based on ramfs the dax support from xfs,
> + * is intended to allow multiple host systems to mount a common file system
> + * view of dax files that map to shared memory.
> + */
> +#ifndef FAMFS_INTERNAL_H
> +#define FAMFS_INTERNAL_H
> +
> +#include <linux/atomic.h>

Why?

> +#include <linux/famfs_ioctl.h>
> +
> +#define FAMFS_MAGIC 0x87b282ff
> +
> +#define FAMFS_BLKDEV_MODE (FMODE_READ|FMODE_WRITE)

Spaces around | 

> +
> +extern const struct file_operations      famfs_file_operations;

I wouldn't force alignment. It rots too often as new stuff gets added
and doesn't really help readability much.

> +
> +/*
> + * Each famfs dax file has this hanging from its inode->i_private.
> + */
> +struct famfs_file_meta {
> +	int                   error;
> +	enum famfs_file_type  file_type;
> +	size_t                file_size;
> +	enum extent_type      tfs_extent_type;
> +	size_t                tfs_extent_ct;
> +	struct famfs_extent   tfs_extents[];  /* flexible array */

Comment kind of obvious ;) I'd drop it.  Though we have
magic markings for __counted_by which would be good to use from the start.



> +};
> +
> +struct famfs_mount_opts {
> +	umode_t mode;
> +};
> +
> +extern const struct iomap_ops             famfs_iomap_ops;
> +extern const struct vm_operations_struct  famfs_file_vm_ops;
> +
> +#define ROOTDEV_STRLEN 80

Why?  You aren't creating an array of this size here so I can't
immediately see what the define is for.

> +
> +struct famfs_fs_info {
> +	struct famfs_mount_opts  mount_opts;
> +	struct file             *dax_filp;
> +	struct dax_device       *dax_devp;
> +	struct bdev_handle      *bdev_handle;
> +	struct list_head         fsi_list;
> +	char                    *rootdev;
> +};
> +
> +#endif /* FAMFS_INTERNAL_H */


