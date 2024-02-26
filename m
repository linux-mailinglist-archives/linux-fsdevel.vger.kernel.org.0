Return-Path: <linux-fsdevel+bounces-12807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C896867653
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 14:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A321F2835F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59D1C6B0;
	Mon, 26 Feb 2024 13:20:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4396D7F7F7;
	Mon, 26 Feb 2024 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953627; cv=none; b=A0wH9ZQ1yPVIFtnsJ/ODOr8Y8MDH5WmeNnovoB+X5+NyLwcymXo+ZdGON3k/MLzWzmzB4q3CexFbNbTwFsyFQ0cXDDfpQuAAxRq8Z5i7x2mOPdB9OYqdL/jYDEBdQBn1UHS+SlBMNwD3t6SD1rdLPGLzfpvq3Qy/O2lFeaMJYk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953627; c=relaxed/simple;
	bh=yfBCNOdJ64HYR4E9FB66qv/dbzZd5+q8idAXgMnC+hk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzCl/TU3Jx7W4Xm4bO+IOvvWPshSi5O4/KBRMB8kzqGd5xyBUwzx/Cs7qrPJAH2XMt6lNGoUZ+XjmGyN4X7wv+lqCS/GMdmJQ/PTJXvEii9Mb9SskLb1vnRh3m2g6f4GNK13lL2/wXDoE/zQB0SNk+ap90Fg0tfxyPQ868an9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk1MR2tNfz6JBQS;
	Mon, 26 Feb 2024 21:15:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 26B1B140D30;
	Mon, 26 Feb 2024 21:20:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 13:20:20 +0000
Date: Mon, 26 Feb 2024 13:20:19 +0000
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
Subject: Re: [RFC PATCH 11/20] famfs: Add fs_context_operations
Message-ID: <20240226132019.00007b8c@Huawei.com>
In-Reply-To: <a645646f071e7baa30ef37ea46ea1330ac2eb63f.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
	<a645646f071e7baa30ef37ea46ea1330ac2eb63f.1708709155.git.john@groves.net>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 11:41:55 -0600
John Groves <John@Groves.net> wrote:

> This commit introduces the famfs fs_context_operations and
> famfs_get_inode() which is used by the context operations.
> 
> Signed-off-by: John Groves <john@groves.net>
Trivial comments inline.

> ---
>  fs/famfs/famfs_inode.c | 178 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 
> diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
> index 82c861998093..f98f82962d7b 100644
> --- a/fs/famfs/famfs_inode.c
> +++ b/fs/famfs/famfs_inode.c
> @@ -41,6 +41,50 @@ static const struct super_operations famfs_ops;
>  static const struct inode_operations famfs_file_inode_operations;
>  static const struct inode_operations famfs_dir_inode_operations;
>  
> +static struct inode *famfs_get_inode(
> +	struct super_block *sb,
> +	const struct inode *dir,
> +	umode_t             mode,
> +	dev_t               dev)
> +{
> +	struct inode *inode = new_inode(sb);
> +
> +	if (inode) {
reverse logic would be simpler and reduce indent.

	if (!inode)
		return NULL;


> +		struct timespec64       tv;
> +
> +		inode->i_ino = get_next_ino();
> +		inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
> +		inode->i_mapping->a_ops = &ram_aops;
> +		mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
> +		mapping_set_unevictable(inode->i_mapping);
> +		tv = inode_set_ctime_current(inode);
> +		inode_set_mtime_to_ts(inode, tv);
> +		inode_set_atime_to_ts(inode, tv);
> +
> +		switch (mode & S_IFMT) {
> +		default:
> +			init_special_inode(inode, mode, dev);
> +			break;
> +		case S_IFREG:
> +			inode->i_op = &famfs_file_inode_operations;
> +			inode->i_fop = &famfs_file_operations;
> +			break;
> +		case S_IFDIR:
> +			inode->i_op = &famfs_dir_inode_operations;
> +			inode->i_fop = &simple_dir_operations;
> +
> +			/* Directory inodes start off with i_nlink == 2 (for "." entry) */
> +			inc_nlink(inode);
> +			break;
> +		case S_IFLNK:
> +			inode->i_op = &page_symlink_inode_operations;
> +			inode_nohighmem(inode);
> +			break;
> +		}
> +	}
> +	return inode;
> +}
> +
>  /**********************************************************************************
>   * famfs super_operations
>   *
> @@ -150,6 +194,140 @@ famfs_open_device(
>  	return 0;
>  }
>  
> +/*****************************************************************************************
> + * fs_context_operations
> + */
> +static int
> +famfs_fill_super(
> +	struct super_block *sb,
> +	struct fs_context  *fc)
> +{
> +	struct famfs_fs_info *fsi = sb->s_fs_info;
> +	struct inode *inode;
> +	int rc = 0;
Always initialized so no need to do it here.

> +
> +	sb->s_maxbytes		= MAX_LFS_FILESIZE;
> +	sb->s_blocksize		= PAGE_SIZE;
> +	sb->s_blocksize_bits	= PAGE_SHIFT;
> +	sb->s_magic		= FAMFS_MAGIC;
> +	sb->s_op		= &famfs_ops;
> +	sb->s_time_gran		= 1;
> +
> +	rc = famfs_open_device(sb, fc);
> +	if (rc)
> +		goto out;
		return rc; //unless you need to do more in out in later patch..

> +
> +	inode = famfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
> +	sb->s_root = d_make_root(inode);
> +	if (!sb->s_root)
> +		rc = -ENOMEM;
		return -ENOMEM;

	return 0;

> +
> +out:
> +	return rc;
> +}
> +
> +enum famfs_param {
> +	Opt_mode,
> +	Opt_dax,
Why capital O?

> +};
> +

...

> +
> +static DEFINE_MUTEX(famfs_context_mutex);
> +static LIST_HEAD(famfs_context_list);
> +
> +static int famfs_get_tree(struct fs_context *fc)
> +{
> +	struct famfs_fs_info *fsi_entry;
> +	struct famfs_fs_info *fsi = fc->s_fs_info;
> +
> +	fsi->rootdev = kstrdup(fc->source, GFP_KERNEL);
> +	if (!fsi->rootdev)
> +		return -ENOMEM;
> +
> +	/* Fail if famfs is already mounted from the same device */
> +	mutex_lock(&famfs_context_mutex);

New toys might be good to use from start to avoid need for explicit
unlocks in error paths.

	scoped_guard(mutex, &famfs_context_mutex) {
		list_for_each_entry(fsi_entry, &famfs_context_list, fsi_list) {
			if (strcmp(fsi_entry->rootdev, cs_source) == 0) {
			//could invert with a continue to reduce indent
			// or factor this out as a little helper.
			// famfs_check_not_mounted()
				pr_err();
				return -EALREADY;
			}
		}	
		list_add(&fsi->fs_list, &famfs_context_list);
	}

	return get_tree_nodev(...

> +	list_for_each_entry(fsi_entry, &famfs_context_list, fsi_list) {
> +		if (strcmp(fsi_entry->rootdev, fc->source) == 0) {
> +			mutex_unlock(&famfs_context_mutex);
> +			pr_err("%s: already mounted from rootdev %s\n", __func__, fc->source);
> +			return -EALREADY;
> +		}
> +	}
> +
> +	list_add(&fsi->fsi_list, &famfs_context_list);
> +	mutex_unlock(&famfs_context_mutex);
> +
> +	return get_tree_nodev(fc, famfs_fill_super);
> +
> +}

>  
>  MODULE_LICENSE("GPL");


