Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7700660020
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 13:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjAFMTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 07:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjAFMTU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:19:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339C0736D7
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 04:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673007526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LzsbYm1v1GieXeKfZ+NGxeHC8we7FOSWZE8i0hStJ+g=;
        b=DTasb+/V1DOjgU6oxos58tRsnx2gfUEOB2OUh0qMWooDjvT9aWbCgkG08Vs4RYs9QNQpPD
        nCGLQ+tfMBb8A3QcnVxCxH5u/tllQhiW1hJPEmnQBEirU/NzWeKdR2QABpsX+C2tmoRSdq
        WNF60BMbjEsx/QI/I47rmz/tlEmGo2c=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-az9JnrqQO3C4ySBy5dMC-A-1; Fri, 06 Jan 2023 07:18:45 -0500
X-MC-Unique: az9JnrqQO3C4ySBy5dMC-A-1
Received: by mail-il1-f198.google.com with SMTP id l13-20020a056e0212ed00b00304c6338d79so1006189iln.21
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jan 2023 04:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzsbYm1v1GieXeKfZ+NGxeHC8we7FOSWZE8i0hStJ+g=;
        b=DfX01DhBgxJG0yggd7WU4oE3i2ghwzMaTd6wCucxqPUGtHrgTIk9bgOpTHZx2dg+5X
         QuitldiVu7yeiU1lvDQYfX363cvRvqABlSCIuIk8u1oBqOawJ38cPl0pU8nf3IIGyJiT
         sPmCmZgJL/msfnnhp4LJY/lGyStDYQ1RubMBO3+8r1Ca1h3HJMWBgja6zS9NXaeGY5b0
         tOV7hRTOwErSe6Kg64SB4ePaPZayJRwaR4/ZWYad8l0/oaI/9nmz8V4MtJGjG7P6LA0e
         t0g/+ZsXnSC0cAS8eKdn2wG20nXyZYQLNQUxW17tLADx6CyU6vY7SDb+7JjEafdH/357
         J1Hw==
X-Gm-Message-State: AFqh2kppDQMO7Z1u9RR13450RFIRXG5qZaCpA39BQPrxID73A1W0zwwW
        sbKaeuZwI3LskE7YRdEMuylYRkwiT90UWohtYk55a8UMSHYg2ZyRIosGJtKD0+rl3THIGET1TAD
        o/mjWyKE+ZRyz9cII+M14fpaWyg==
X-Received: by 2002:a92:c90b:0:b0:304:d0b7:e56c with SMTP id t11-20020a92c90b000000b00304d0b7e56cmr37671689ilp.14.1673007523903;
        Fri, 06 Jan 2023 04:18:43 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtwHyDjwQ26qAeHbl9wtyjADtcmAo/J+WTeqO/Hig4ZRkNBmW5eIWw+Wwze94ud79bHnAmG/g==
X-Received: by 2002:a92:c90b:0:b0:304:d0b7:e56c with SMTP id t11-20020a92c90b000000b00304d0b7e56cmr37671669ilp.14.1673007523452;
        Fri, 06 Jan 2023 04:18:43 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id c16-20020a92c8d0000000b0030c423515bfsm347633ilq.27.2023.01.06.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 04:18:42 -0800 (PST)
Date:   Fri, 6 Jan 2023 07:18:41 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gscrivan@redhat.com
Subject: Re: [PATCH 4/6] composefs: Add filesystem implementation
Message-ID: <Y7gRofheB9EaR4Mi@x1>
References: <cover.1669631086.git.alexl@redhat.com>
 <1f0bd3e3a0c68ee19dd96ee0d573bb113428f1b6.1669631086.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0bd3e3a0c68ee19dd96ee0d573bb113428f1b6.1669631086.git.alexl@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 12:17:12PM +0100, Alexander Larsson wrote:
> This is the basic inode and filesystem implementation.
> 
> Signed-off-by: Alexander Larsson <alexl@redhat.com>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>

Note: I'm looking at this from the VFS viewpoint since I haven't done
anything in this subsystem. Just looking for some generic suggestions.

> ---
>  fs/composefs/cfs.c | 941 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 941 insertions(+)
>  create mode 100644 fs/composefs/cfs.c
> 
> diff --git a/fs/composefs/cfs.c b/fs/composefs/cfs.c
> new file mode 100644
> index 000000000000..4ed355ab079d
> --- /dev/null
> +++ b/fs/composefs/cfs.c
> @@ -0,0 +1,941 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * composefs
> + *
> + * Copyright (C) 2000 Linus Torvalds.
> + *               2000 Transmeta Corp.
> + * Copyright (C) 2021 Giuseppe Scrivano
> + * Copyright (C) 2022 Alexander Larsson
> + *
> + * This file is released under the GPL.
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/fsverity.h>
> +#include <linux/fs_parser.h>
> +#include <linux/module.h>
> +#include <linux/namei.h>
> +#include <linux/seq_file.h>
> +#include <linux/version.h>
> +#include <linux/xattr.h>
> +#include <linux/statfs.h>
> +
> +#include "cfs-internals.h"
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Giuseppe Scrivano <gscrivan@redhat.com>");

An entry for composefs should be added to the MAINTAINERS file as well.

> +
> +#define CFS_MAX_STACK 500
> +
> +struct cfs_info {
> +	struct cfs_context_s cfs_ctx;
> +
> +	char *base_path;
> +
> +	size_t n_bases;
> +	struct vfsmount **bases;
> +
> +	u32 verity_check; /* 0 == none, 1 == if specified in image, 2 == require in image */
> +	bool has_digest;
> +	u8 digest[SHA256_DIGEST_SIZE]; /* fs-verity digest */
> +};
> +
> +struct cfs_inode {
> +	/* must be first for clear in cfs_alloc_inode to work */
> +	struct inode vfs_inode;

[ snip ]

> +static struct inode *cfs_alloc_inode(struct super_block *sb)
> +{
> +	struct cfs_inode *cino =
> +		alloc_inode_sb(sb, cfs_inode_cachep, GFP_KERNEL);
> +
> +	if (!cino)
> +		return NULL;
> +
> +	memset((u8 *)cino + sizeof(struct inode), 0,
> +	       sizeof(struct cfs_inode) - sizeof(struct inode));

Why not use container_of() to look up the vfs_inode and then you can get
rid of the restriction of this being first. This may also break with
structure randomization turned on.

> +
> +	struct cfs_inode_data_s inode_data;
> +};
> +
> +static inline struct cfs_inode *CFS_I(struct inode *inode)

CFS_I in upper case doesn't match naming conventions in the rest of the
kernel.

> +{
> +	return container_of(inode, struct cfs_inode, vfs_inode);
> +}
> +
> +static struct file empty_file;
> +
> +static const struct file_operations cfs_file_operations;
> +static const struct vm_operations_struct generic_file_vm_ops;
> +
> +static const struct super_operations cfs_ops;
> +static const struct file_operations cfs_dir_operations;
> +static const struct inode_operations cfs_dir_inode_operations;
> +static const struct inode_operations cfs_file_inode_operations;
> +static const struct inode_operations cfs_link_inode_operations;
> +
> +static const struct xattr_handler *cfs_xattr_handlers[];
> +static const struct export_operations cfs_export_operations;
> +
> +static const struct address_space_operations cfs_aops = {
> +	.direct_IO = noop_direct_IO,
> +};
> +
> +static ssize_t cfs_listxattr(struct dentry *dentry, char *names, size_t size);
> +
> +/* copied from overlayfs.  */
> +static unsigned int cfs_split_basedirs(char *str)
> +{
> +	unsigned int ctr = 1;
> +	char *s, *d;
> +
> +	for (s = d = str;; s++, d++) {
> +		if (*s == '\\') {
> +			s++;
> +		} else if (*s == ':') {
> +			*d = '\0';
> +			ctr++;
> +			continue;
> +		}
> +		*d = *s;
> +		if (!*s)
> +			break;
> +	}
> +	return ctr;
> +}

To expand on the comment, this is ovl_split_lowerdirs in
fs/overlayfs/super.c. It'd be nice if there was a common place where
this could go.

> +
> +static struct inode *cfs_make_inode(struct cfs_context_s *ctx,
> +				    struct super_block *sb, ino_t ino_num,
> +				    struct cfs_inode_s *ino,
> +				    const struct inode *dir)
> +{
> +	struct cfs_xattr_header_s *xattrs = NULL;
> +	struct cfs_inode *cino;
> +	struct inode *inode = NULL;
> +	struct cfs_inode_data_s inode_data = { 0 };
> +	int ret, res;

Put in reverse Christmas tree order.

> +
> +	res = cfs_init_inode_data(ctx, ino, ino_num, &inode_data);
> +	if (res < 0) {
> +		ret = res;
> +		goto fail;

Just return ERR_PTR(res) here. xattrs is set to NULL at this point and
the fail path attempts to free it. Yes, there's a check in kfree for
this. The code in cfs_inode_data_put appears to handle this NULL case
fine as well.

> +	}
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
> +
> +	return cfs_make_inode(&fsi->cfs_ctx, sb, index, ino, NULL);
> +}
> +
> +static bool cfs_iterate_cb(void *private, const char *name, int name_len,
> +			   u64 ino, unsigned int dtype)
> +{
> +	struct dir_context *ctx = private;
> +
> +	if (!dir_emit(ctx, name, name_len, ino, dtype))
> +		return 0;
> +
> +	ctx->pos++;
> +	return 1;
> +}
> +
> +static int cfs_iterate(struct file *file, struct dir_context *ctx)
> +{
> +	struct inode *inode = file->f_inode;
> +	struct cfs_info *fsi = inode->i_sb->s_fs_info;
> +	struct cfs_inode *cino = CFS_I(inode);
> +
> +	if (!dir_emit_dots(file, ctx))
> +		return 0;
> +
> +	return cfs_dir_iterate(&fsi->cfs_ctx, inode->i_ino, &cino->inode_data,
> +			       ctx->pos - 2, cfs_iterate_cb, ctx);
> +}
> +
> +static struct dentry *cfs_lookup(struct inode *dir, struct dentry *dentry,
> +				 unsigned int flags)
> +{
> +	struct cfs_info *fsi = dir->i_sb->s_fs_info;
> +	struct cfs_inode *cino = CFS_I(dir);
> +	struct cfs_inode_s ino_buf;
> +	struct inode *inode;
> +	struct cfs_inode_s *ino_s;
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
> +
> +static const struct file_operations cfs_dir_operations = {
> +	.llseek = generic_file_llseek,
> +	.read = generic_read_dir,
> +	.iterate_shared = cfs_iterate,
> +};
> +
> +static const struct inode_operations cfs_dir_inode_operations = {
> +	.lookup = cfs_lookup,
> +	.listxattr = cfs_listxattr,
> +};
> +
> +static const struct inode_operations cfs_link_inode_operations = {
> +	.get_link = simple_get_link,
> +	.listxattr = cfs_listxattr,
> +};
> +
> +static void digest_to_string(const u8 *digest, char *buf)
> +{
> +	static const char hexchars[] = "0123456789abcdef";
> +	u32 i, j;
> +
> +	for (i = 0, j = 0; i < SHA256_DIGEST_SIZE; i++, j += 2) {
> +		u8 byte = digest[i];
> +
> +		buf[j] = hexchars[byte >> 4];
> +		buf[j + 1] = hexchars[byte & 0xF];
> +	}
> +	buf[j] = '\0';
> +}

Use %*phN printk() format with snprintf(). See the section 'Raw buffer
as a hex string' in Documentation/core-api/printk-formats.rst.

> +
> +static int digest_from_string(const char *digest_str, u8 *digest)
> +{
> +	size_t i, j;
> +
> +	for (i = 0, j = 0; i < SHA256_DIGEST_SIZE; i += 1, j += 2) {
> +		int big, little;
> +
> +		if (digest_str[j] == 0 || digest_str[j + 1] == 0)
> +			return -EINVAL; /* Too short string */
> +
> +		big = cfs_xdigit_value(digest_str[j]);
> +		little = cfs_xdigit_value(digest_str[j + 1]);
> +
> +		if (big == -1 || little == -1)
> +			return -EINVAL; /* Not hex digit */
> +
> +		digest[i] = (big << 4) | little;
> +	}
> +
> +	if (digest_str[j] != 0)
> +		return -EINVAL; /* Too long string */
> +
> +	return 0;
> +}

I mentioned this an another patch in this series but replace with
hex2bin() from lib/hexdump.c.

> +
> +/*
> + * Display the mount options in /proc/mounts.
> + */
> +static int cfs_show_options(struct seq_file *m, struct dentry *root)
> +{
> +	struct cfs_info *fsi = root->d_sb->s_fs_info;
> +
> +	if (fsi->base_path)
> +		seq_show_option(m, "basedir", fsi->base_path);
> +	if (fsi->has_digest) {
> +		char buf[SHA256_DIGEST_SIZE * 2 + 1];
> +
> +		digest_to_string(fsi->digest, buf);
> +		seq_show_option(m, "digest", buf);
> +	}
> +	if (fsi->verity_check != 0)
> +		seq_printf(m, ",verity_check=%u", fsi->verity_check);
> +
> +	return 0;
> +}
> +
> +static struct kmem_cache *cfs_inode_cachep;
> +

> +static void cfs_destroy_inode(struct inode *inode)
> +{
> +	struct cfs_inode *cino = CFS_I(inode);
> +
> +	cfs_inode_data_put(&cino->inode_data);
> +}
> +
> +static void cfs_free_inode(struct inode *inode)
> +{
> +	struct cfs_inode *cino = CFS_I(inode);
> +
> +	kmem_cache_free(cfs_inode_cachep, cino);
> +}
> +
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
> +
> +static int cfs_statfs(struct dentry *dentry, struct kstatfs *buf)
> +{
> +	struct cfs_info *fsi = dentry->d_sb->s_fs_info;
> +	int err = 0;
> +
> +	/* We return the free space, etc from the first base dir. */
> +	if (fsi->n_bases > 0) {
> +		struct path root = { .mnt = fsi->bases[0],
> +				     .dentry = fsi->bases[0]->mnt_root };
> +		err = vfs_statfs(&root, buf);
> +	}
> +
> +	if (!err) {
> +		buf->f_namelen = NAME_MAX;
> +		buf->f_type = dentry->d_sb->s_magic;
> +	}
> +
> +	return err;
> +}
> +
> +static const struct super_operations cfs_ops = {
> +	.statfs = cfs_statfs,
> +	.drop_inode = generic_delete_inode,
> +	.show_options = cfs_show_options,
> +	.put_super = cfs_put_super,
> +	.destroy_inode = cfs_destroy_inode,
> +	.alloc_inode = cfs_alloc_inode,
> +	.free_inode = cfs_free_inode,
> +};
> +
> +enum cfs_param {
> +	Opt_base_path,
> +	Opt_digest,
> +	Opt_verity_check,
> +};
> +
> +const struct fs_parameter_spec cfs_parameters[] = {
> +	fsparam_string("basedir", Opt_base_path),
> +	fsparam_string("digest", Opt_digest),
> +	fsparam_u32("verity_check", Opt_verity_check),
> +	{}
> +};
> +
> +static int cfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct fs_parse_result result;
> +	struct cfs_info *fsi = fc->s_fs_info;
> +	int opt, r;
> +
> +	opt = fs_parse(fc, cfs_parameters, param, &result);
> +	if (opt == -ENOPARAM)
> +		return vfs_parse_fs_param_source(fc, param);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_base_path:
> +		kfree(fsi->base_path);
> +		/* Take ownership.  */
> +		fsi->base_path = param->string;
> +		param->string = NULL;
> +		break;
> +	case Opt_digest:
> +		r = digest_from_string(param->string, fsi->digest);
> +		if (r < 0)
> +			return r;
> +		fsi->has_digest = true;
> +		fsi->verity_check = 2; /* Default to full verity check */
> +		break;
> +	case Opt_verity_check:
> +		if (result.uint_32 > 2)
> +			return invalfc(fc, "Invalid verity_check mode");
> +		fsi->verity_check = result.uint_32;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct vfsmount *resolve_basedir(const char *name)
> +{
> +	struct path path = {};
> +	struct vfsmount *mnt;
> +	int err = -EINVAL;
> +
> +	if (!*name) {
> +		pr_err("empty basedir\n");
> +		goto out;
> +	}
> +	err = kern_path(name, LOOKUP_FOLLOW, &path);
> +	if (err) {
> +		pr_err("failed to resolve '%s': %i\n", name, err);
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
> +
> +	/* Set up the inode allocator early */
> +	sb->s_op = &cfs_ops;
> +	sb->s_flags |= SB_RDONLY;
> +	sb->s_magic = CFS_MAGIC;
> +	sb->s_xattr = cfs_xattr_handlers;
> +	sb->s_export_op = &cfs_export_operations;
> +
> +	if (fsi->base_path) {
> +		char *lower, *splitlower = NULL;
> +		size_t i;
> +
> +		ret = -ENOMEM;
> +		splitlower = kstrdup(fsi->base_path, GFP_KERNEL);
> +		if (!splitlower)
> +			goto fail;
> +
> +		ret = -EINVAL;
> +		numbasedirs = cfs_split_basedirs(splitlower);
> +		if (numbasedirs > CFS_MAX_STACK) {
> +			pr_err("too many lower directories, limit is %d\n",
> +			       CFS_MAX_STACK);
> +			kfree(splitlower);
> +			goto fail;
> +		}
> +
> +		ret = -ENOMEM;
> +		bases = kcalloc(numbasedirs, sizeof(struct vfsmount *),
> +				GFP_KERNEL);
> +		if (!bases) {
> +			kfree(splitlower);
> +			goto fail;
> +		}
> +
> +		lower = splitlower;
> +		for (i = 0; i < numbasedirs; i++) {
> +			mnt = resolve_basedir(lower);
> +			if (IS_ERR(mnt)) {
> +				ret = PTR_ERR(mnt);
> +				kfree(splitlower);
> +				goto fail;
> +			}
> +			bases[i] = mnt;
> +
> +			lower = strchr(lower, '\0') + 1;
> +		}
> +		kfree(splitlower);
> +	}
> +
> +	/* Must be inited before calling cfs_get_inode.  */
> +	ret = cfs_init_ctx(fc->source, fsi->has_digest ? fsi->digest : NULL,
> +			   &fsi->cfs_ctx);
> +	if (ret < 0)
> +		goto fail;
> +
> +	inode = cfs_get_root_inode(sb);
> +	if (IS_ERR(inode)) {
> +		ret = PTR_ERR(inode);
> +		goto fail;
> +	}
> +	sb->s_root = d_make_root(inode);
> +
> +	ret = -ENOMEM;
> +	if (!sb->s_root)
> +		goto fail;
> +
> +	sb->s_maxbytes = MAX_LFS_FILESIZE;
> +	sb->s_blocksize = PAGE_SIZE;
> +	sb->s_blocksize_bits = PAGE_SHIFT;
> +
> +	sb->s_time_gran = 1;
> +
> +	fsi->bases = bases;
> +	fsi->n_bases = numbasedirs;
> +	return 0;
> +fail:
> +	if (bases) {
> +		size_t i;
> +
> +		for (i = 0; i < numbasedirs; i++) {

You can now do 'for (size_t i = 0; ...'

> +			if (bases[i])
> +				kern_unmount(bases[i]);
> +		}
> +		kfree(bases);
> +	}
> +	cfs_ctx_put(&fsi->cfs_ctx);
> +	return ret;
> +}
> +
> +static int cfs_get_tree(struct fs_context *fc)
> +{
> +	return get_tree_nodev(fc, cfs_fill_super);
> +}
> +
> +static const struct fs_context_operations cfs_context_ops = {
> +	.parse_param = cfs_parse_param,
> +	.get_tree = cfs_get_tree,
> +};
> +
> +static struct file *open_base_file(struct cfs_info *fsi, struct inode *inode,
> +				   struct file *file)
> +{
> +	struct cfs_inode *cino = CFS_I(inode);
> +	struct file *real_file;
> +	char *real_path = cino->inode_data.path_payload;
> +	size_t i;
> +
> +	for (i = 0; i < fsi->n_bases; i++) {
> +		real_file = file_open_root_mnt(fsi->bases[i], real_path,
> +					       file->f_flags, 0);
> +		if (!IS_ERR(real_file) || PTR_ERR(real_file) != -ENOENT)
> +			return real_file;
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
> +
> +static int cfs_open_file(struct inode *inode, struct file *file)
> +{
> +	struct cfs_inode *cino = CFS_I(inode);
> +	struct cfs_info *fsi = inode->i_sb->s_fs_info;
> +	struct file *real_file;
> +	struct file *faked_file;
> +	char *real_path = cino->inode_data.path_payload;
> +
> +	if (WARN_ON(!file))
> +		return -EIO;
> +
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
> +		return -EIO;
> +	}
> +
> +	real_file = open_base_file(fsi, inode, file);
> +
> +	if (IS_ERR(real_file))
> +		return PTR_ERR(real_file);
> +
> +	/* If metadata records a digest for the file, ensure it is there
> +	 * and correct before using the contents.
> +	 */
> +	if (cino->inode_data.has_digest && fsi->verity_check >= 1) {
> +		u8 verity_digest[FS_VERITY_MAX_DIGEST_SIZE];
> +		enum hash_algo verity_algo;
> +		int res;
> +
> +		res = fsverity_get_digest(d_inode(real_file->f_path.dentry),
> +					  verity_digest, &verity_algo);
> +		if (res < 0) {
> +			pr_warn("WARNING: composefs backing file '%pd' has no fs-verity digest\n",
> +				real_file->f_path.dentry);
> +			fput(real_file);
> +			return -EIO;
> +		}
> +		if (verity_algo != HASH_ALGO_SHA256 ||
> +		    memcmp(cino->inode_data.digest, verity_digest,
> +			   SHA256_DIGEST_SIZE) != 0) {
> +			pr_warn("WARNING: composefs backing file '%pd' has the wrong fs-verity digest\n",
> +				real_file->f_path.dentry);
> +			fput(real_file);
> +			return -EIO;
> +		}
> +	}
> +
> +	faked_file = open_with_fake_path(&file->f_path, file->f_flags,
> +					 real_file->f_inode, current_cred());
> +	fput(real_file);
> +
> +	if (IS_ERR(faked_file))
> +		return PTR_ERR(faked_file);
> +
> +	file->private_data = faked_file;
> +	return 0;
> +}
> +
> +static unsigned long cfs_mmu_get_unmapped_area(struct file *file,
> +					       unsigned long addr,
> +					       unsigned long len,
> +					       unsigned long pgoff,
> +					       unsigned long flags)
> +{
> +	struct file *realfile = file->private_data;
> +
> +	if (realfile == &empty_file)
> +		return 0;
> +
> +	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
> +}
> +
> +static int cfs_release_file(struct inode *inode, struct file *file)
> +{
> +	struct file *realfile = file->private_data;
> +
> +	if (WARN_ON(!realfile))
> +		return -EIO;
> +
> +	if (realfile == &empty_file)
> +		return 0;
> +
> +	fput(file->private_data);
> +
> +	return 0;
> +}
> +
> +static int cfs_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct file *realfile = file->private_data;
> +	int ret;
> +
> +	if (realfile == &empty_file)
> +		return 0;
> +
> +	if (!realfile->f_op->mmap)
> +		return -ENODEV;
> +
> +	if (WARN_ON(file != vma->vm_file))
> +		return -EIO;
> +
> +	vma_set_file(vma, realfile);
> +
> +	ret = call_mmap(vma->vm_file, vma);
> +
> +	return ret;
> +}
> +
> +static ssize_t cfs_read_iter(struct kiocb *iocb, struct iov_iter *iter)
> +{
> +	struct file *file = iocb->ki_filp;
> +	struct file *realfile = file->private_data;
> +	int ret;
> +
> +	if (realfile == &empty_file)
> +		return 0;
> +
> +	if (!realfile->f_op->read_iter)
> +		return -ENODEV;
> +
> +	iocb->ki_filp = realfile;
> +	ret = call_read_iter(realfile, iocb, iter);
> +	iocb->ki_filp = file;
> +
> +	return ret;
> +}
> +
> +static int cfs_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
> +{
> +	struct file *realfile = file->private_data;
> +
> +	if (realfile == &empty_file)
> +		return 0;
> +
> +	return vfs_fadvise(realfile, offset, len, advice);
> +}
> +
> +static int cfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +			 struct inode *parent)
> +{
> +	int len = 3;
> +	u64 nodeid;
> +	u32 generation;
> +
> +	if (*max_len < len) {
> +		*max_len = len;
> +		return FILEID_INVALID;
> +	}
> +
> +	nodeid = inode->i_ino;
> +	generation = inode->i_generation;
> +
> +	fh[0] = (u32)(nodeid >> 32);
> +	fh[1] = (u32)(nodeid & 0xffffffff);
> +	fh[2] = generation;
> +
> +	*max_len = len;
> +
> +	return 0x91;
> +}
> +
> +static struct dentry *cfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
> +				       int fh_len, int fh_type)
> +{
> +	struct cfs_info *fsi = sb->s_fs_info;
> +	struct inode *ino;
> +	u64 inode_index;
> +	u32 generation;
> +
> +	if (fh_type != 0x91 || fh_len < 3)

0x91 is referenced above as well. Should this be a #define?

Brian

