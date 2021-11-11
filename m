Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2170F44DBCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 19:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhKKSz6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 13:55:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36943 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234001AbhKKSz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 13:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636656787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LJn9fSQ4OlhcSTpXp3NVtQ5lincQoFe3W+soaHvheRM=;
        b=aNlnF0leyj773Xf00vEmNl82y9n3CsSe2o5sKzGHqgTwNhc3/93PCK0op2FXxZuaFX2sPW
        Bdq/lL5qsUvJsLcIWZITLc0kECvh0FggSHGqTtuamHjajwL9p9HyTOOhdMqSBIAv65qZvk
        0KpjZ6tYaXNECOVJd86oXfBitUtVIa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-Td19LbVgPzqG3TUtGFsXug-1; Thu, 11 Nov 2021 13:53:04 -0500
X-MC-Unique: Td19LbVgPzqG3TUtGFsXug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECCEF824F87;
        Thu, 11 Nov 2021 18:53:02 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB63760854;
        Thu, 11 Nov 2021 18:52:57 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3D5AE220EED; Thu, 11 Nov 2021 13:52:57 -0500 (EST)
Date:   Thu, 11 Nov 2021 13:52:57 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v7 2/7] fuse: make DAX mount option a tri-state
Message-ID: <YY1miSYq9glK7R2K@redhat.com>
References: <20211102052604.59462-1-jefflexu@linux.alibaba.com>
 <20211102052604.59462-3-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102052604.59462-3-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 01:25:59PM +0800, Jeffle Xu wrote:
> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
> operate the same which is equivalent to 'always'.
> 
> The following behavior is consistent with that on ext4/xfs:
> - The default behavior (when neither '-o dax' nor
>   '-o dax=always|never|inode' option is specified) is equal to 'inode'
>   mode, while 'dax=inode' won't be printed among the mount option list.
> - The 'inode' mode is only advisory. It will silently fallback to
>   'never' mode if fuse server doesn't support that.
> 
> Also noted that by the time of this commit, 'inode' mode is actually
> equal to 'always' mode, before the per inode DAX flag is introduced in
> the following patch.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c       |  9 ++++++++-
>  fs/fuse/fuse_i.h    | 20 ++++++++++++++++++--
>  fs/fuse/inode.c     | 10 +++++++---
>  fs/fuse/virtio_fs.c | 18 +++++++++++++++---
>  4 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 8c187b04874e..91c8d146dbc4 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -1284,11 +1284,14 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
>  	return ret;
>  }
>  
> -int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
> +int fuse_dax_conn_alloc(struct fuse_conn *fc, enum fuse_dax_mode dax_mode,
> +			struct dax_device *dax_dev)
>  {
>  	struct fuse_conn_dax *fcd;
>  	int err;
>  
> +	fc->dax_mode = dax_mode;
> +
>  	if (!dax_dev)
>  		return 0;
>  
> @@ -1335,6 +1338,10 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>  static bool fuse_should_enable_dax(struct inode *inode)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	enum fuse_dax_mode dax_mode = fc->dax_mode;
> +
> +	if (dax_mode == FUSE_DAX_NEVER)
> +		return false;
>  
>  	if (!fc->dax)
>  		return false;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f55f9f94b1a4..4f9c2358f343 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -480,6 +480,18 @@ struct fuse_dev {
>  	struct list_head entry;
>  };
>  
> +enum fuse_dax_mode {
> +	FUSE_DAX_NONE,	 /* default */
> +	FUSE_DAX_ALWAYS, /* "-o dax=always" */
> +	FUSE_DAX_NEVER,  /* "-o dax=never" */
> +	FUSE_DAX_INODE,  /* "-o dax=inode" */
> +};
Hi,

Not sure why do we need FUSE_DAX_NONE. Now default is FUSE_DAX_INODE
and "-o dax" will map to FUSE_DAX_ALWAYS. So after this patch series,
nobody should be using FUSE_DAX_NONE state at all? So we should be
able to get rid of entirely?

> +
> +static inline bool fuse_is_inode_dax_mode(enum fuse_dax_mode mode)
> +{
> +	return mode == FUSE_DAX_INODE || mode == FUSE_DAX_NONE;
> +}

This is confusing. Why FUSE_DAX_NONE is equivalent to inode dax mode.
Is it because you want FUSE_DAX_INODE as default. If that's the case,
lets get rid of FUSE_DAX_NONE and just set FUSE_DAX_INODE as default?

> +
>  struct fuse_fs_context {
>  	int fd;
>  	struct file *file;
> @@ -497,7 +509,7 @@ struct fuse_fs_context {
>  	bool no_control:1;
>  	bool no_force_umount:1;
>  	bool legacy_opts_show:1;
> -	bool dax:1;
> +	enum fuse_dax_mode dax_mode;
>  	unsigned int max_read;
>  	unsigned int blksize;
>  	const char *subtype;
> @@ -802,6 +814,9 @@ struct fuse_conn {
>  	struct list_head devices;
>  
>  #ifdef CONFIG_FUSE_DAX
> +	/* Dax mode */
> +	enum fuse_dax_mode dax_mode;
> +
>  	/* Dax specific conn data, non-NULL if DAX is enabled */
>  	struct fuse_conn_dax *dax;
>  #endif
> @@ -1258,7 +1273,8 @@ ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
>  ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
>  int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
>  int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start, u64 dmap_end);
> -int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev);
> +int fuse_dax_conn_alloc(struct fuse_conn *fc, enum fuse_dax_mode mode,
> +			struct dax_device *dax_dev);
>  void fuse_dax_conn_free(struct fuse_conn *fc);
>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>  void fuse_dax_inode_init(struct inode *inode);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 12d49a1914e8..15ce56f9cf11 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -734,8 +734,12 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
>  			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
>  	}
>  #ifdef CONFIG_FUSE_DAX
> -	if (fc->dax)
> -		seq_puts(m, ",dax");
> +	if (fc->dax_mode == FUSE_DAX_ALWAYS)
> +		seq_puts(m, ",dax=always");
> +	else if (fc->dax_mode == FUSE_DAX_NEVER)
> +		seq_puts(m, ",dax=never");
> +	else if (fc->dax_mode == FUSE_DAX_INODE)
> +		seq_puts(m, ",dax=inode");

I guess this answers the question about FUSE_DAX_NONE. You want to
keep track if user passed in "dax=inode" or you defaulted to dax=inode.
And if you defaulted to "dax=inode" you don't want to show it in fuse
options.

Hmm..., if that's the intent, I would rather keep the names like this.

FUSE_DAX_INODE_USER and FUSE_DAX_INODE_DEFAULT. This clearly tells
me the difference between two states.

>  #endif
>  
>  	return 0;
> @@ -1481,7 +1485,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	sb->s_subtype = ctx->subtype;
>  	ctx->subtype = NULL;
>  	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
> -		err = fuse_dax_conn_alloc(fc, ctx->dax_dev);
> +		err = fuse_dax_conn_alloc(fc, ctx->dax_mode, ctx->dax_dev);
>  		if (err)
>  			goto err;
>  	}
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 94fc874f5de7..e8c404946c63 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -88,12 +88,21 @@ struct virtio_fs_req_work {
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  				 struct fuse_req *req, bool in_flight);
>  
> +static const struct constant_table dax_param_enums[] = {
> +	{"always",	FUSE_DAX_ALWAYS },
> +	{"never",	FUSE_DAX_NEVER },
> +	{"inode",	FUSE_DAX_INODE },
> +	{}
> +};
> +
>  enum {
>  	OPT_DAX,
> +	OPT_DAX_ENUM,
>  };
>  
>  static const struct fs_parameter_spec virtio_fs_parameters[] = {
>  	fsparam_flag("dax", OPT_DAX),
> +	fsparam_enum("dax", OPT_DAX_ENUM, dax_param_enums),
>  	{}
>  };
>  
> @@ -110,7 +119,10 @@ static int virtio_fs_parse_param(struct fs_context *fsc,
>  
>  	switch (opt) {
>  	case OPT_DAX:
> -		ctx->dax = 1;
> +		ctx->dax_mode = FUSE_DAX_ALWAYS;
> +		break;
> +	case OPT_DAX_ENUM:
> +		ctx->dax_mode = result.uint_32;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1326,8 +1338,8 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
>  
>  	/* virtiofs allocates and installs its own fuse devices */
>  	ctx->fudptr = NULL;
> -	if (ctx->dax) {
> -		if (!fs->dax_dev) {
> +	if (ctx->dax_mode != FUSE_DAX_NEVER) {
	   ^^
Why do we need this check. IOW, why following check alone is not
sufficient.

> +		if (ctx->dax_mode == FUSE_DAX_ALWAYS && !fs->dax_dev) {
		 ^^^

If user specified dax mode FUSE_DAX_ALWAYS, we need to make sure fs device
supports dax.  And second if condition seems sufficient. 

Vivek

>  			err = -EINVAL;
>  			pr_err("virtio-fs: dax can't be enabled as filesystem"
>  			       " device does not support it.\n");
> -- 
> 2.27.0
> 

