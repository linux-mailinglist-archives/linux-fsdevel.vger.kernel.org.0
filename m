Return-Path: <linux-fsdevel+bounces-72834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9778CD0319A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 14:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFB9830C5518
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 13:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D145B389DFE;
	Thu,  8 Jan 2026 12:50:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6BA387577;
	Thu,  8 Jan 2026 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876604; cv=none; b=JlVWGNb3K7QlN7ovOjWmQwT7YA6mR7Hmy4K8EY9lpVtGoJ/0J54ipB+nxlrf1xD84HqKei2tchpfVVyU0clTfKbYmXMeYbcJniXGv0LH/t/887sqKvKzsqamJvVVx+1dAz7VeNThHhyFf9TEq+BLUWsvMPR6UUnZgBhn6GwnO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876604; c=relaxed/simple;
	bh=oRZ2lPl+gZkTUwx0MnubUkgPpy5MkPPj96/wtI4UW/Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwypx3FNddimLD7g+CS3Hh3F0/p6kI50YUHMW0kSlfSaw00M/rY3YpekBVuNC2rD6MTeICRHHcwmzD5yZIM5kiysUYbTXG/CGdXC5MbMoqpq6pfLxY0/0bOD/472NCJyJsMbRiELGieGcsGXBneEISPc85NimJEj5kFY83NVuQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dn4Vp3QDBzJ469G;
	Thu,  8 Jan 2026 20:49:54 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FF994056A;
	Thu,  8 Jan 2026 20:49:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 12:49:57 +0000
Date: Thu, 8 Jan 2026 12:49:56 +0000
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
Subject: Re: [PATCH V3 14/21] famfs_fuse: Plumb the GET_FMAP
 message/response
Message-ID: <20260108124956.00000e0e@huawei.com>
In-Reply-To: <20260107153332.64727-15-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
	<20260107153332.64727-1-john@groves.net>
	<20260107153332.64727-15-john@groves.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed,  7 Jan 2026 09:33:23 -0600
John Groves <John@Groves.net> wrote:

> Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
> retrieve and cache up the file-to-dax map in the kernel. If this
> succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> 
> Signed-off-by: John Groves <john@groves.net>
A few things inline.

J

> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> new file mode 100644
> index 000000000000..0f7e3f00e1e7
> --- /dev/null
> +++ b/fs/fuse/famfs.c
> @@ -0,0 +1,74 @@
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
> +#include "fuse_i.h"
> +
> +
> +#define FMAP_BUFSIZE PAGE_SIZE
> +
> +int
> +fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	size_t fmap_bufsize = FMAP_BUFSIZE;
> +	u64 nodeid = get_node_id(inode);
> +	ssize_t fmap_size;
> +	void *fmap_buf;
> +	int rc;
> +
> +	FUSE_ARGS(args);
> +
> +	/* Don't retrieve if we already have the famfs metadata */
> +	if (fi->famfs_meta)
> +		return 0;
> +
> +	fmap_buf = kcalloc(1, FMAP_BUFSIZE, GFP_KERNEL);

If there is only ever 1, does kcalloc() make sense over kzalloc()?

> +	if (!fmap_buf)
> +		return -EIO;
> +
> +	args.opcode = FUSE_GET_FMAP;
> +	args.nodeid = nodeid;
> +
> +	/* Variable-sized output buffer
> +	 * this causes fuse_simple_request() to return the size of the
> +	 * output payload
> +	 */
> +	args.out_argvar = true;
> +	args.out_numargs = 1;
> +	args.out_args[0].size = fmap_bufsize;
> +	args.out_args[0].value = fmap_buf;
> +
> +	/* Send GET_FMAP command */
> +	rc = fuse_simple_request(fm, &args);
> +	if (rc < 0) {
> +		pr_err("%s: err=%d from fuse_simple_request()\n",
> +		       __func__, rc);

Leaks the fmap_buf?  Maybe use a __free() so no need to keep track of htat.


> +		return rc;
> +	}
> +	fmap_size = rc;
> +
> +	/* We retrieved the "fmap" (the file's map to memory), but
> +	 * we haven't used it yet. A call to famfs_file_init_dax() will be added
> +	 * here in a subsequent patch, when we add the ability to attach
> +	 * fmaps to files.
> +	 */
> +
> +	kfree(fmap_buf);
> +	return 0;
> +}

> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 84d0ee2a501d..691c7850cf4e 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -223,6 +223,14 @@ struct fuse_inode {

>  
> +static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
> +						       void *meta)
> +{
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	return xchg(&fi->famfs_meta, meta);
> +#else
> +	return NULL;
> +#endif
> +}
> +
> +static inline void famfs_meta_free(struct fuse_inode *fi)
> +{
> +	/* Stub wil be connected in a subsequent commit */
> +}
> +
> +static inline int fuse_file_famfs(struct fuse_inode *fi)
> +{
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +	return (READ_ONCE(fi->famfs_meta) != NULL);
> +#else
> +	return 0;
> +#endif
> +}
> +
> +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> +int fuse_get_fmap(struct fuse_mount *fm, struct inode *inode);
> +#else
> +static inline int
> +fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)
> +{
> +	return 0;
> +}
> +#endif
I'd do a single block under one if IS_ENABLED() and then use an else
for the stubs.   Should end up more readable.

Jonathan

