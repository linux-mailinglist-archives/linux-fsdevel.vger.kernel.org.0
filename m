Return-Path: <linux-fsdevel+bounces-12815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA14386770B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E2B728FFEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C566012C524;
	Mon, 26 Feb 2024 13:44:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7BA129A67;
	Mon, 26 Feb 2024 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955056; cv=none; b=gk0NsQ7tLwxS+hXoGlBEq+AQj/jAgNdfppogSVVodHs4pmnXZ52Y9mO8Q5MvKwBmXxnIxY0fLYJfmbFBNQSiKMIHHk1O0ThCpwTtoXZI7c4BoKdGJ0LYkGp7K+R9F6DDDMKWAX1TRkibl1FYHzJB7zn4CfXClqF/zGQ4lolYYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955056; c=relaxed/simple;
	bh=RDk51qgwd48WtwvhFPF7ApCTm5BiB3MYXD5qCIwjl9E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rlx444OjfMlQCoRN6Y4+nWmvQaHxv7uX5Ry69n5LPL/BF70cyGOLTwZyXfpchFgbJS/uotAaMRxA5RfzDLlbfV3n6TzYHlCPWySRsp5qJwWhzYsV/cQdeg8GiFD9KiDKwhlkp7E+vpYwEbO6sfUzCE09g0OYPBTLMcnu0rbr3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk1vC3Xstz6K6TM;
	Mon, 26 Feb 2024 21:39:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 30557141369;
	Mon, 26 Feb 2024 21:44:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 13:44:09 +0000
Date: Mon, 26 Feb 2024 13:44:08 +0000
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
Subject: Re: [RFC PATCH 15/20] famfs: Add ioctl to file_operations
Message-ID: <20240226134408.00005576@Huawei.com>
In-Reply-To: <a5d0969403ca02af6593b6789a21b230b2436800.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<a5d0969403ca02af6593b6789a21b230b2436800.1708709155.git.john@groves.net>
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

On Fri, 23 Feb 2024 11:41:59 -0600
John Groves <John@Groves.net> wrote:

> This commit introduces the per-file ioctl function famfs_file_ioctl()
> into struct file_operations, and introduces the famfs_file_init_dax()
> function (which is called by famfs_file_ioct())
> 
> famfs_file_init_dax() associates a dax extent list with a file, making
> it into a proper famfs file. It is called from the FAMFSIOC_MAP_CREATE
> ioctl. Starting with an empty file (which is basically a ramfs file),
> this turns the file into a DAX file backed by the specified extent list.
> 
> The other ioctls are:
> 
> FAMFSIOC_NOP - A convenient way for user space to verify it's a famfs file
> FAMFSIOC_MAP_GET - Get the header of the metadata for a file
> FAMFSIOC_MAP_GETEXT - Get the extents for a file
> 
> The latter two, together, are comparable to xfs_bmap. Our user space tools
> use them primarly in testing.
> 
> Signed-off-by: John Groves <john@groves.net>
A few more comments inline. Nothing fundamental just nice to have
simplifications of the code.

> ---
>  fs/famfs/famfs_file.c | 226 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 226 insertions(+)
> 
> diff --git a/fs/famfs/famfs_file.c b/fs/famfs/famfs_file.c
> index 5228e9de1e3b..fd42d5966982 100644
> --- a/fs/famfs/famfs_file.c
> +++ b/fs/famfs/famfs_file.c
> @@ -19,6 +19,231 @@
>  #include <uapi/linux/famfs_ioctl.h>
>  #include "famfs_internal.h"
>  
> +/**
> + * famfs_map_meta_alloc() - Allocate famfs file metadata
> + * @mapp:       Pointer to an mcache_map_meta pointer
> + * @ext_count:  The number of extents needed
> + */
> +static int
> +famfs_meta_alloc(
> +	struct famfs_file_meta  **metap,
> +	size_t                    ext_count)
> +{
> +	struct famfs_file_meta *meta;
> +	size_t                  metasz;
> +
> +	*metap = NULL;

Not responsibility of caller?

> +
> +	metasz = sizeof(*meta) + sizeof(*(meta->tfs_extents)) * ext_count;

Looks like struct_size() would be appropriate.


> +
> +	meta = kzalloc(metasz, GFP_KERNEL);
> +	if (!meta)
> +		return -ENOMEM;
> +
> +	meta->tfs_extent_ct = ext_count;
> +	*metap = meta;
> +
> +	return 0;
> +}
> +
> +static void
> +famfs_meta_free(
> +	struct famfs_file_meta *map)
> +{
> +	kfree(map);
Given this is just kfree you can use __free magic to simplify things below.

> +}
> +
> +/**
> + * famfs_file_init_dax() - FAMFSIOC_MAP_CREATE ioctl handler
> + * @file:
> + * @arg:        ptr to struct mcioc_map in user space
> + *
> + * Setup the dax mapping for a file. Files are created empty, and then function is called
> + * (by famfs_file_ioctl()) to setup the mapping and set the file size.
> + */
> +static int
> +famfs_file_init_dax(
> +	struct file    *file,
> +	void __user    *arg)
> +{
> +	struct famfs_extent    *tfs_extents = NULL;
> +	struct famfs_file_meta *meta = NULL;
> +	struct inode           *inode;
> +	struct famfs_ioc_map    imap;
> +	struct famfs_fs_info   *fsi;
> +	struct super_block     *sb;
> +	int    alignment_errs = 0;
> +	size_t extent_total = 0;
> +	size_t ext_count;
> +	int    rc = 0;
> +	int    i;
> +
> +	rc = copy_from_user(&imap, arg, sizeof(imap));
> +	if (rc)
> +		return -EFAULT;
> +
> +	ext_count = imap.ext_list_count;
> +	if (ext_count < 1) {
> +		rc = -ENOSPC;
> +		goto errout;
		meta data not yet allocated.
		return -ENOSPC;

> +	}
> +
> +	if (ext_count > FAMFS_MAX_EXTENTS) {
> +		rc = -E2BIG;
> +		goto errout;	
		return 

> +	}
> +
> +	inode = file_inode(file);
> +	if (!inode) {
> +		rc = -EBADF;
> +		goto errout;
		return;

> +	}
> +	sb  = inode->i_sb;
> +	fsi = inode->i_sb->s_fs_info;
> +
> +	tfs_extents = &imap.ext_list[0];
> +
> +	rc = famfs_meta_alloc(&meta, ext_count);
> +	if (rc)
> +		goto errout;
	return ...

	only after this point should there be any
	meta data to free on exit?

> +
> +	meta->file_type = imap.file_type;
> +	meta->file_size = imap.file_size;
> +
> +	/* Fill in the internal file metadata structure */
> +	for (i = 0; i < imap.ext_list_count; i++) {
> +		size_t len;
> +		off_t  offset;
> +
> +		offset = imap.ext_list[i].offset;
> +		len    = imap.ext_list[i].len;
> +
> +		extent_total += len;
> +
> +		if (WARN_ON(offset == 0 && meta->file_type != FAMFS_SUPERBLOCK)) {
> +			rc = -EINVAL;
> +			goto errout;
> +		}
> +
> +		meta->tfs_extents[i].offset = offset;
> +		meta->tfs_extents[i].len    = len;
> +
> +		/* All extent addresses/offsets must be 2MiB aligned,
> +		 * and all but the last length must be a 2MiB multiple.
> +		 */
> +		if (!IS_ALIGNED(offset, PMD_SIZE)) {
> +			pr_err("%s: error ext %d hpa %lx not aligned\n",
> +			       __func__, i, offset);
> +			alignment_errs++;
> +		}
> +		if (i < (imap.ext_list_count - 1) && !IS_ALIGNED(len, PMD_SIZE)) {
> +			pr_err("%s: error ext %d length %ld not aligned\n",
> +			       __func__, i, len);
> +			alignment_errs++;
> +		}
> +	}
> +
> +	/*
> +	 * File size can be <= ext list size, since extent sizes are constrained
> +	 * to PMD multiples
> +	 */
> +	if (imap.file_size > extent_total) {
> +		pr_err("%s: file size %lld larger than ext list size %lld\n",
> +		       __func__, (u64)imap.file_size, (u64)extent_total);
> +		rc = -EINVAL;
> +		goto errout;
> +	}
> +
> +	if (alignment_errs > 0) {
> +		pr_err("%s: there were %d alignment errors in the extent list\n",
> +		       __func__, alignment_errs);
> +		rc = -EINVAL;
> +		goto errout;
> +	}
> +
> +	/* Publish the famfs metadata on inode->i_private */
> +	inode_lock(inode);

Easy to add a guard definition - maybe useful enough to bother as can then do
this which makes the error handling align with other cases.

	scoped_guard(inode_sem, inode) {
		if (inode->i_private) {
			rc = -EEXIST;
			goto errout;
		}
		inode->...

	}
> +	if (inode->i_private) {
> +		rc = -EEXIST; /* file already has famfs metadata */
> +	} else {
> +		inode->i_private = meta;

You could use __free on the meta data and 
		inode->i_private = no_ptr_free(meta);
here. Then all your earlier error paths become direct returns.

> +		i_size_write(inode, imap.file_size);
> +		inode->i_flags |= S_DAX;
> +	}
> +	inode_unlock(inode);
> +
> + errout:
> +	if (rc)
> +		famfs_meta_free(meta);
A separate error path is going to be easier to follow as no if (rc)

> +
> +	return rc;
> +}
> +
> +/**
> + * famfs_file_ioctl() -  top-level famfs file ioctl handler
> + * @file:
> + * @cmd:
> + * @arg:
> + */
> +static
> +long
> +famfs_file_ioctl(
> +	struct file    *file,
> +	unsigned int    cmd,
> +	unsigned long   arg)
> +{
> +	long rc;
> +
> +	switch (cmd) {
> +	case FAMFSIOC_NOP:
> +		rc = 0;
		return 0;
> +		break;
> +
> +	case FAMFSIOC_MAP_CREATE:
> +		rc = famfs_file_init_dax(file, (void *)arg);
		return famfs_file_init_dax()

> +		break;
> +
> +	case FAMFSIOC_MAP_GET: {
> +		struct inode *inode = file_inode(file);
> +		struct famfs_file_meta *meta = inode->i_private;
> +		struct famfs_ioc_map umeta;
> +
> +		memset(&umeta, 0, sizeof(umeta));
> +
> +		if (meta) {
> +			/* TODO: do more to harmonize these structures */
> +			umeta.extent_type    = meta->tfs_extent_type;
> +			umeta.file_size      = i_size_read(inode);
> +			umeta.ext_list_count = meta->tfs_extent_ct;
> +
> +			rc = copy_to_user((void __user *)arg, &umeta, sizeof(umeta));
> +			if (rc)
> +				pr_err("%s: copy_to_user returned %ld\n", __func__, rc);
> +
> +		} else {
> +			rc = -EINVAL;
> +		}
Flip logic.

		if (!meta)
			return -EINVAL;

		umeta ...
		return 0;

> +	}
> +		break;
> +	case FAMFSIOC_MAP_GETEXT: {
> +		struct inode *inode = file_inode(file);
> +		struct famfs_file_meta *meta = inode->i_private;
> +
> +		if (meta)
> +			rc = copy_to_user((void __user *)arg, meta->tfs_extents,
> +					  meta->tfs_extent_ct * sizeof(struct famfs_extent));
> +		else
> +			rc = -EINVAL;
		if (!meta)
			return -EINVAL;

		return copy_to_user

> +	}
> +		break;
> +	default:
> +		rc = -ENOTTY;
return -ENOTTY;

> +		break;
> +	}
> +
> +	return rc;
Early returns will simplify the flow for anyone reading this.

> +}


