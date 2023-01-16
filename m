Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42E366D167
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 23:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjAPWHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 17:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjAPWHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:07:53 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DB02686E;
        Mon, 16 Jan 2023 14:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=owk2aGltcPJWFmuQJ2QiApPgJfhQHva4a3QDFzFbVRA=; b=WRl6OVI9BovAANPtRfOkouaajr
        0+pYEiStOFM+yyZ+8EkaAqIEAgsr9QDmiIGiR/02nKcc7Q/arJEOnepv/MCDqEu/qGjxPsLRUT6Rk
        Go8yhYpV0S69G8m7jESt7eeFkI2R9XAgSAt7t1EDfr+72Uz+nAxykCaZfH8ANucB/41qZWm+OTSj1
        RoidDVV2TkUYh1gFQT/P43WUmtE+w78c8erlRRW05FoV+3tdIcIZOZsaLjuCH38ROKPtqkPbHLL3L
        aypf1pH5if6EwDAlRFLEgSjqgA7tB0X92IHTwkjwJXAbwX5r6dl2zw3o8PPa2ZzNWSjrkz6jfHOKx
        KuENOaeQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pHXdu-002FFD-11;
        Mon, 16 Jan 2023 22:07:50 +0000
Date:   Mon, 16 Jan 2023 22:07:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Subject: Re: [PATCH v2 4/6] composefs: Add filesystem implementation
Message-ID: <Y8XKtqfmtulLcuWi@ZenIV>
References: <cover.1673623253.git.alexl@redhat.com>
 <ee96ab52b9d2ab58e7b793e34ce5dc956686ada9.1673623253.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee96ab52b9d2ab58e7b793e34ce5dc956686ada9.1673623253.git.alexl@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Several random observations:

> +static struct inode *cfs_make_inode(struct cfs_context_s *ctx,
> +				    struct super_block *sb, ino_t ino_num,
> +				    struct cfs_inode_s *ino, const struct inode *dir)
> +{
> +	struct cfs_inode_data_s inode_data = { 0 };
> +	struct cfs_xattr_header_s *xattrs = NULL;
> +	struct inode *inode = NULL;
> +	struct cfs_inode *cino;
> +	int ret, res;

I would suggest
	if (IS_ERR(ino))
		return ERR_CAST(ino);
here.  The callers get simpler that way, AFAICS.

> +	res = cfs_init_inode_data(ctx, ino, ino_num, &inode_data);
> +	if (res < 0)
> +		return ERR_PTR(res);
> +
> +	inode = new_inode(sb);
> +	if (inode) {
> +		inode_init_owner(&init_user_ns, inode, dir, ino->st_mode);
> +		inode->i_mapping->a_ops = &cfs_aops;
> +
> +		cino = CFS_I(inode);
> +		cino->inode_data = inode_data;
> +
> +		inode->i_ino = ino_num;
> +		set_nlink(inode, ino->st_nlink);
> +		inode->i_rdev = ino->st_rdev;
> +		inode->i_uid = make_kuid(current_user_ns(), ino->st_uid);
> +		inode->i_gid = make_kgid(current_user_ns(), ino->st_gid);
> +		inode->i_mode = ino->st_mode;
> +		inode->i_atime = ino->st_mtim;
> +		inode->i_mtime = ino->st_mtim;
> +		inode->i_ctime = ino->st_ctim;
> +
> +		switch (ino->st_mode & S_IFMT) {
> +		case S_IFREG:
> +			inode->i_op = &cfs_file_inode_operations;
> +			inode->i_fop = &cfs_file_operations;
> +			inode->i_size = ino->st_size;
> +			break;
> +		case S_IFLNK:
> +			inode->i_link = cino->inode_data.path_payload;
> +			inode->i_op = &cfs_link_inode_operations;
> +			inode->i_fop = &cfs_file_operations;
> +			break;
> +		case S_IFDIR:
> +			inode->i_op = &cfs_dir_inode_operations;
> +			inode->i_fop = &cfs_dir_operations;
> +			inode->i_size = 4096;
> +			break;
> +		case S_IFCHR:
> +		case S_IFBLK:
> +			if (current_user_ns() != &init_user_ns) {
> +				ret = -EPERM;
> +				goto fail;
> +			}
> +			fallthrough;
> +		default:
> +			inode->i_op = &cfs_file_inode_operations;
> +			init_special_inode(inode, ino->st_mode, ino->st_rdev);
> +			break;
> +		}
> +	}
> +	return inode;
> +
> +fail:
> +	if (inode)
> +		iput(inode);

Huh?  Just how do we get here with NULL inode?  While we are at it,
NULL on -ENOMEM is fine when it's the only error that can happen;
here, OTOH...

> +	kfree(xattrs);
> +	cfs_inode_data_put(&inode_data);
> +	return ERR_PTR(ret);
> +}
> +
> +static struct inode *cfs_get_root_inode(struct super_block *sb)
> +{
> +	struct cfs_info *fsi = sb->s_fs_info;
> +	struct cfs_inode_s ino_buf;
> +	struct cfs_inode_s *ino;
> +	u64 index;
> +
> +	ino = cfs_get_root_ino(&fsi->cfs_ctx, &ino_buf, &index);
> +	if (IS_ERR(ino))
> +		return ERR_CAST(ino);

See what I mean re callers?

> +	return cfs_make_inode(&fsi->cfs_ctx, sb, index, ino, NULL);
> +}

> +static struct dentry *cfs_lookup(struct inode *dir, struct dentry *dentry,
> +				 unsigned int flags)
> +{
> +	struct cfs_info *fsi = dir->i_sb->s_fs_info;
> +	struct cfs_inode *cino = CFS_I(dir);
> +	struct cfs_inode_s ino_buf;
> +	struct cfs_inode_s *ino_s;
> +	struct inode *inode;
> +	u64 index;
> +	int ret;
> +
> +	if (dentry->d_name.len > NAME_MAX)
> +		return ERR_PTR(-ENAMETOOLONG);
> +
> +	ret = cfs_dir_lookup(&fsi->cfs_ctx, dir->i_ino, &cino->inode_data,
> +			     dentry->d_name.name, dentry->d_name.len, &index);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +	if (ret == 0)
> +		goto return_negative;
> +
> +	ino_s = cfs_get_ino_index(&fsi->cfs_ctx, index, &ino_buf);
> +	if (IS_ERR(ino_s))
> +		return ERR_CAST(ino_s);
> +
> +	inode = cfs_make_inode(&fsi->cfs_ctx, dir->i_sb, index, ino_s, dir);
> +	if (IS_ERR(inode))
> +		return ERR_CAST(inode);
> +
> +	return d_splice_alias(inode, dentry);
> +
> +return_negative:
> +	d_add(dentry, NULL);
> +	return NULL;
> +}

Ugh...  One problem here is that out of memory in new_inode() translates into
successful negative lookup.  Another...

	struct inode *inode = NULL;

	if (dentry->d_name.len > NAME_MAX)
		return ERR_PTR(-ENAMETOOLONG);

	ret = cfs_dir_lookup(&fsi->cfs_ctx, dir->i_ino, &cino->inode_data,
			     dentry->d_name.name, dentry->d_name.len, &index);
	if (ret) {
		if (ret < 0)
			return ERR_PTR(ret);
		ino_s = cfs_get_ino_index(&fsi->cfs_ctx, index, &ino_buf);
		inode = cfs_make_inode(&fsi->cfs_ctx, dir->i_sb, index, ino_s, dir);
	}
	return d_splice_alias(inode, dentry);

is all you really need.  d_splice_alias() will do the right thing if given
ERR_PTR()...

> +{
> +	struct cfs_inode *cino = alloc_inode_sb(sb, cfs_inode_cachep, GFP_KERNEL);
> +
> +	if (!cino)
> +		return NULL;
> +
> +	memset((u8 *)cino + sizeof(struct inode), 0,
> +	       sizeof(struct cfs_inode) - sizeof(struct inode));

Huh?  What's wrong with memset(&cino->inode_data, 0, sizeof(cino->inode_data))?

> +static void cfs_destroy_inode(struct inode *inode)
> +{
> +	struct cfs_inode *cino = CFS_I(inode);
> +
> +	cfs_inode_data_put(&cino->inode_data);
> +}

Umm...  Any reason that can't be done from your ->free_inode()?  Looks like
nothing in there needs to be synchronous...  For that matter, what's wrong
with simply kfree(cino->inode_data.path_payload) from cfs_free_inode(),
just before it frees cino itself?

> +static void cfs_put_super(struct super_block *sb)
> +{
> +	struct cfs_info *fsi = sb->s_fs_info;
> +
> +	cfs_ctx_put(&fsi->cfs_ctx);
> +	if (fsi->bases) {
> +		kern_unmount_array(fsi->bases, fsi->n_bases);
> +		kfree(fsi->bases);
> +	}
> +	kfree(fsi->base_path);
> +
> +	kfree(fsi);
> +}

> +static struct vfsmount *resolve_basedir(const char *name)
> +{
> +	struct path path = {};
> +	struct vfsmount *mnt;
> +	int err = -EINVAL;
> +
> +	if (!*name) {
> +		pr_err("empty basedir\n");

		return ERR_PTR(-EINVAL);

> +		goto out;
> +	}
> +	err = kern_path(name, LOOKUP_FOLLOW, &path);

Are sure you don't want LOOKUP_DIRECTORY added here?

> +	if (err) {
> +		pr_err("failed to resolve '%s': %i\n", name, err);

		return ERR_PTR(err);

> +		goto out;
> +	}
> +
> +	mnt = clone_private_mount(&path);
> +	err = PTR_ERR(mnt);
> +	if (IS_ERR(mnt)) {
> +		pr_err("failed to clone basedir\n");
> +		goto out_put;
> +	}
> +
> +	path_put(&path);

	mnt = clone_private_mount(&path);
	path_put(&path);
	/* Don't inherit atime flags */
	if (!IS_ERR(mnt))
		mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME);
	return mnt;

I'm not saying that gotos are to be religiously avoided, but here they
make it harder to follow...

> +
> +	/* Don't inherit atime flags */
> +	mnt->mnt_flags &= ~(MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME);
> +
> +	return mnt;
> +
> +out_put:
> +	path_put(&path);
> +out:
> +	return ERR_PTR(err);
> +}

> +
> +static int cfs_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	struct cfs_info *fsi = sb->s_fs_info;
> +	struct vfsmount **bases = NULL;
> +	size_t numbasedirs = 0;
> +	struct inode *inode;
> +	struct vfsmount *mnt;
> +	int ret;
> +
> +	if (sb->s_root)
> +		return -EINVAL;

Wha...?  How could it ever get called with non-NULL ->s_root?


> +static struct file *open_base_file(struct cfs_info *fsi, struct inode *inode,
> +				   struct file *file)
> +{
> +	struct cfs_inode *cino = CFS_I(inode);
> +	struct file *real_file;
> +	char *real_path = cino->inode_data.path_payload;
> +
> +	for (size_t i = 0; i < fsi->n_bases; i++) {
> +		real_file = file_open_root_mnt(fsi->bases[i], real_path,
> +					       file->f_flags, 0);
> +		if (!IS_ERR(real_file) || PTR_ERR(real_file) != -ENOENT)
> +			return real_file;

That's a strange way to spell if (real_file != ERR_PTR(-ENOENT))...

> +static int cfs_open_file(struct inode *inode, struct file *file)
> +{
> +	struct cfs_info *fsi = inode->i_sb->s_fs_info;
> +	struct cfs_inode *cino = CFS_I(inode);
> +	char *real_path = cino->inode_data.path_payload;
> +	struct file *faked_file;
> +	struct file *real_file;
> +
> +	if (WARN_ON(!file))
> +		return -EIO;

Huh?

> +	if (file->f_flags & (O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_TRUNC))
> +		return -EROFS;
> +
> +	if (!real_path) {
> +		file->private_data = &empty_file;
> +		return 0;
> +	}
> +
> +	if (fsi->verity_check >= 2 && !cino->inode_data.has_digest) {
> +		pr_warn("WARNING: composefs image file '%pd' specified no fs-verity digest\n",
> +			file->f_path.dentry);

%pD with file, please, both here and later.
