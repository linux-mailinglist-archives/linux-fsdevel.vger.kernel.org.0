Return-Path: <linux-fsdevel+bounces-12956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356A869353
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 14:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809651F22BEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 13:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A930913B791;
	Tue, 27 Feb 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKlYDKM4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647813B2B4;
	Tue, 27 Feb 2024 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041433; cv=none; b=CodKn2dtHVavKbT8JDpEff1jqVoR93h2KPz2MJz7+t/pNTYtevl1h7Da16d0iHud5jI7hZ+7hJLCiRhoOcYv050lQaI6IqoNlB2/LY5stT5JJH/fEg2ntKvmaClIwU/9r+iVPy5wbKqqyKI03hpuhK65D5qUlJyTqmykj4PV6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041433; c=relaxed/simple;
	bh=n+sWKaLJY675WI200sbvcsNtX5pExAoPLJuSEeVd/mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7etgIwXRZL0HW6AERB5/pSywOEtjfOJjhPXemrN5e9XfBiOyl4Z7XJ4BpWLPaGaOmOSMGaJpOXWha2yLshlpwg53wAsPqwXY0jdM1XC1cRiGYJ1apaNVo+bbhBVCOShQCgZ8g1AZR4Wt3RfHd5F+Y+tzYCRxCk4jYV5+wyPEdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKlYDKM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51564C433F1;
	Tue, 27 Feb 2024 13:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709041432;
	bh=n+sWKaLJY675WI200sbvcsNtX5pExAoPLJuSEeVd/mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKlYDKM4QyX2+1hqzVO+A7DqDkyNi4syNZdmOc8x+feEUEnoC4Gcoy7KA9tjMv8Um
	 HqhFffK1OisZcZbKeUfM2t44ZGUTxC035WlriXYOK+g13iiKadadcauLFsAAol1Avo
	 imfpK0U8/UFbpnYFMwGnuvxmJMS4U6vEQcsETm3UI8SbDk9l76fBytmDsAVIy48qPA
	 uB/XzsDm3F+B8sLp/DhxDswItVslliu614fifi7M+Inlv/JtBzd+/Ns9yQdqdcGuay
	 Ue8XtGFoytVwlI69wHj4/+EXF+ZjDDfn/3NZLv+1Gbw9jmUyfopViBnZi3FwDeh0bq
	 3/qIh6zQaDJSA==
From: Christian Brauner <brauner@kernel.org>
To: John Groves <John@groves.net>
Cc: Christian Brauner <brauner@kernel.org>,
	John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com
Subject: Re: [RFC PATCH 11/20] famfs: Add fs_context_operations
Date: Tue, 27 Feb 2024 14:41:44 +0100
Message-ID: <20240227-mammut-tastatur-d791ca2f556b@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <a645646f071e7baa30ef37ea46ea1330ac2eb63f.1708709155.git.john@groves.net>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8704; i=brauner@kernel.org; h=from:subject:message-id; bh=n+sWKaLJY675WI200sbvcsNtX5pExAoPLJuSEeVd/mw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTefc4nJW+35q+SSdiLc5dyC1Vkks02uC76P0HMuthws xY/426njlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk0rGH4K+Fx+NWclvU5y6aW 1oi/4uH6Mdn24r0n6/4UMPdKf3774Cgjw7o5q/4UiFRdVpjxdNZPnxMbLl4Xijkc+PKoWt+l208 T2LkB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, Feb 23, 2024 at 11:41:55AM -0600, John Groves wrote:
> This commit introduces the famfs fs_context_operations and
> famfs_get_inode() which is used by the context operations.
> 
> Signed-off-by: John Groves <john@groves.net>
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
> +
> +	inode = famfs_get_inode(sb, NULL, S_IFDIR | fsi->mount_opts.mode, 0);
> +	sb->s_root = d_make_root(inode);
> +	if (!sb->s_root)
> +		rc = -ENOMEM;
> +
> +out:
> +	return rc;
> +}
> +
> +enum famfs_param {
> +	Opt_mode,
> +	Opt_dax,
> +};
> +
> +const struct fs_parameter_spec famfs_fs_parameters[] = {
> +	fsparam_u32oct("mode",	  Opt_mode),
> +	fsparam_string("dax",     Opt_dax),
> +	{}
> +};
> +
> +static int famfs_parse_param(
> +	struct fs_context   *fc,
> +	struct fs_parameter *param)
> +{
> +	struct famfs_fs_info *fsi = fc->s_fs_info;
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	opt = fs_parse(fc, famfs_fs_parameters, param, &result);
> +	if (opt == -ENOPARAM) {
> +		opt = vfs_parse_fs_param_source(fc, param);
> +		if (opt != -ENOPARAM)
> +			return opt;

I'm not sure I understand this. But in any case add, you should add
Opt_source to enum famfs_param and then add

        fsparam_string("source",        Opt_source),

to famfs_fs_parameters. Then you can add:

famfs_parse_source(fc, param);

You might want to consider validating your devices right away. So think
about:

fd_fs = fsopen("famfs", ...);
ret = fsconfig(fd_fs, FSCONFIG_SET_STRING, "source", "/definitely/not/valid/device", ...) // succeeds
ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "OPTION_1", ...) // succeeds
ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "OPTION_2", ...) // succeeds 
ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "OPTION_3", ...) // succeeds 
ret = fsconfig(fd_fs, FSCONFIG_SET_FLAG, "OPTION_N", ...) // succeeds 
ret = fsconfig(fd_fs, FSCONFIG_CMD_CREATE, ...) // superblock creation failed

So what failed exactly? Yes, you can log into the fscontext and dmesg
that it's @source that's the issue but it's annoying for userspace to
setup a whole mount context only to figure out that some option was
wrong at the end of it.

So validating

famfs_parse_source(...)
{
	if (fc->source)
		return invalfc(fc, "Uhm, we already have a source....
	
       lookup_bdev(fc->source, &dev)
       // validate it's a device you're actually happy to use

       fc->source = param->string;
       param->string = NULL;
}

Your ->get_tree implementation that actually creates/finds the
superblock will validate fc->source again and yes, there's a race here
in so far as the path that fc->source points to could change in between
validating this in famfs_parse_source() and ->get_tree() superblock
creation. This is fixable even right now but then you couldn't reuse
common infrastrucute so I would just accept that race for now and we
should provide a nicer mechanism on the vfs layer.

> +
> +		return 0;
> +	}
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_mode:
> +		fsi->mount_opts.mode = result.uint_32 & S_IALLUGO;
> +		break;
> +	case Opt_dax:
> +		if (strcmp(param->string, "always"))
> +			pr_notice("%s: invalid dax mode %s\n",
> +				  __func__, param->string);
> +		break;
> +	}
> +
> +	return 0;
> +}
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
> +	list_for_each_entry(fsi_entry, &famfs_context_list, fsi_list) {
> +		if (strcmp(fsi_entry->rootdev, fc->source) == 0) {
> +			mutex_unlock(&famfs_context_mutex);
> +			pr_err("%s: already mounted from rootdev %s\n", __func__, fc->source);
> +			return -EALREADY;

What errno is EALREADY? Isn't that socket stuff. In any case, it seems
you want EBUSY?

But bigger picture I'm lost. And why do you keep that list based on
strings? What if I do:

mount -t famfs /dev/pmem1234 /mnt # succeeds

mount -t famfs /dev/pmem1234 /opt # ah, fsck me, this fails.. But wait a minute....

mount --bind /dev/pmem1234 /evil-masterplan

mount -t famfs /evil-masterplan /opt # succeeds. YAY

I believe that would trivially defeat your check.

> +		}
> +	}
> +
> +	list_add(&fsi->fsi_list, &famfs_context_list);
> +	mutex_unlock(&famfs_context_mutex);
> +
> +	return get_tree_nodev(fc, famfs_fill_super);

So why isn't this using get_tree_bdev()? Note that a while ago I
added FSCONFIG_CMD_CREAT_EXCL which prevents silent superblock reuse. To
implement that I added fs_context->exclusive. If you unconditionally set
fc->exclusive = 1 in your famfs_init_fs_context() and use
get_tree_bdev() it will give you EBUSY if fc->source is already in use -
including other famfs instances.

I also fail to yet understand how that function which actually opens the block
device and gets the dax device figures into this. It's a bit hard to follow
what's going on since you add all those unused functions and types so there's
never a wider context to see that stuff in.

> +
> +}
> +
> +static void famfs_free_fc(struct fs_context *fc)
> +{
> +	struct famfs_fs_info *fsi = fc->s_fs_info;
> +
> +	if (fsi && fsi->rootdev)
> +		kfree(fsi->rootdev);
> +
> +	kfree(fsi);
> +}
> +
> +static const struct fs_context_operations famfs_context_ops = {
> +	.free		= famfs_free_fc,
> +	.parse_param	= famfs_parse_param,
> +	.get_tree	= famfs_get_tree,
> +};
> +
> +static int famfs_init_fs_context(struct fs_context *fc)
> +{
> +	struct famfs_fs_info *fsi;
> +
> +	fsi = kzalloc(sizeof(*fsi), GFP_KERNEL);
> +	if (!fsi)
> +		return -ENOMEM;
> +
> +	fsi->mount_opts.mode = FAMFS_DEFAULT_MODE;
> +	fc->s_fs_info        = fsi;
> +	fc->ops              = &famfs_context_ops;
> +	return 0;
> +}
>  
>  
>  MODULE_LICENSE("GPL");
> -- 
> 2.43.0
> 

