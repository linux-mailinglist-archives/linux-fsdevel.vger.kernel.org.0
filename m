Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8765B3CEBAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 22:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353024AbhGSRXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 13:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356313AbhGSRWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626717759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x8yd+DRZO8vTRPuL5X35e3D3WtSixgW0f5O77HlkSTw=;
        b=A/R6aKmqV09HJvHKftjSlTlIILBfFl7a6cypWQN8vk0S4ca0Q5mzk9Xb2WQmW9tYbkbmt+
        w8F/l/c/ClJpNYSR4Rtan8h2b1S8z+uRztE/nz9urA0LDkP3OoZH3PWmNwYBsbg6VvZIOd
        ED5KfGrDOx0UahwMREAm8/FjdfpWTmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-cf8_p-lDPE2TGk-vKS33-w-1; Mon, 19 Jul 2021 14:02:36 -0400
X-MC-Unique: cf8_p-lDPE2TGk-vKS33-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBBE0192D785;
        Mon, 19 Jul 2021 18:02:34 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-17.rdu2.redhat.com [10.10.118.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE3066E0B7;
        Mon, 19 Jul 2021 18:02:30 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7F9B7223E4F; Mon, 19 Jul 2021 14:02:30 -0400 (EDT)
Date:   Mon, 19 Jul 2021 14:02:30 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2 2/4] fuse: Make DAX mount option a tri-state
Message-ID: <YPW+NgbMDnGQ2UPI@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-3-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716104753.74377-3-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 06:47:51PM +0800, Jeffle Xu wrote:
> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
> operate the same which is equivalent to 'always'.
> 
> By the time this patch is applied, 'inode' mode is actually equal to
> 'always' mode, before the per-file DAX flag is introduced in the
> following patch.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c       | 13 ++++++++++++-
>  fs/fuse/fuse_i.h    | 11 +++++++++--
>  fs/fuse/inode.c     |  2 +-
>  fs/fuse/virtio_fs.c | 16 ++++++++++++++--
>  4 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index c6f4e82e65f3..a478e824c2d0 100644
> --- a/fs/fuse/dax.c
> +++ b/fs/fuse/dax.c
> @@ -70,6 +70,9 @@ struct fuse_inode_dax {
>  };
>  
>  struct fuse_conn_dax {
> +	/** dax mode: FUSE_DAX_MOUNT_* (always, never or per-file) **/
> +	unsigned int mode;

Why "/**" ?

How about make it something like "enum fuse_dax_mode mode" instead?

enum fuse_dax_mode dax_mode;

> +
>  	/* DAX device */
>  	struct dax_device *dev;
>  
> @@ -1288,7 +1291,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
>  	return ret;
>  }
>  
> -int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
> +int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
> +			struct dax_device *dax_dev)
>  {
>  	struct fuse_conn_dax *fcd;
>  	int err;
> @@ -1301,6 +1305,7 @@ int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev)
>  		return -ENOMEM;
>  
>  	spin_lock_init(&fcd->lock);
> +	fcd->mode = mode;
>  	fcd->dev = dax_dev;
>  	err = fuse_dax_mem_range_init(fcd);
>  	if (err) {
> @@ -1339,10 +1344,16 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>  static bool fuse_should_enable_dax(struct inode *inode)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	unsigned int mode;
>  
>  	if (!fc->dax)
>  		return false;
>  
> +	mode = fc->dax->mode;
> +
> +	if (mode == FUSE_DAX_MOUNT_NEVER)
> +		return false;
> +
>  	return true;
>  }
>  
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 07829ce78695..f29018323845 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -487,6 +487,12 @@ struct fuse_dev {
>  	struct list_head entry;
>  };
>  
> +enum {
And this becomes.

enum fuse_dax_mode {
};

> +	FUSE_DAX_MOUNT_INODE,
> +	FUSE_DAX_MOUNT_ALWAYS,
> +	FUSE_DAX_MOUNT_NEVER,
> +};

How about getting rid of "MOUNT" and just do.

	FUSE_DAX_INODE,
	FUSE_DAX_ALWAYS,
	FUSE_DAX_NEVER,

> +
>  struct fuse_fs_context {
>  	int fd;
>  	unsigned int rootmode;
> @@ -503,7 +509,7 @@ struct fuse_fs_context {
>  	bool no_control:1;
>  	bool no_force_umount:1;
>  	bool legacy_opts_show:1;
> -	bool dax:1;
> +	unsigned int dax;

enum fuse_dax_mode dax_mode;

>  	unsigned int max_read;
>  	unsigned int blksize;
>  	const char *subtype;
> @@ -1242,7 +1248,8 @@ ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
>  ssize_t fuse_dax_write_iter(struct kiocb *iocb, struct iov_iter *from);
>  int fuse_dax_mmap(struct file *file, struct vm_area_struct *vma);
>  int fuse_dax_break_layouts(struct inode *inode, u64 dmap_start, u64 dmap_end);
> -int fuse_dax_conn_alloc(struct fuse_conn *fc, struct dax_device *dax_dev);
> +int fuse_dax_conn_alloc(struct fuse_conn *fc, unsigned int mode,
						   ^^
						enum fuse_dax_mode dax_mode
> +			struct dax_device *dax_dev);
>  void fuse_dax_conn_free(struct fuse_conn *fc);
>  bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi);
>  void fuse_dax_inode_init(struct inode *inode);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index b9beb39a4a18..f6b46395edb2 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1434,7 +1434,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	sb->s_subtype = ctx->subtype;
>  	ctx->subtype = NULL;
>  	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
> -		err = fuse_dax_conn_alloc(fc, ctx->dax_dev);
> +		err = fuse_dax_conn_alloc(fc, ctx->dax, ctx->dax_dev);
>  		if (err)
>  			goto err;
>  	}
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 8f52cdaa8445..561f711d1945 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -88,12 +88,21 @@ struct virtio_fs_req_work {
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  				 struct fuse_req *req, bool in_flight);
>  
> +static const struct constant_table dax_param_enums[] = {
> +	{"inode",	FUSE_DAX_MOUNT_INODE },
> +	{"always",	FUSE_DAX_MOUNT_ALWAYS },
> +	{"never",	FUSE_DAX_MOUNT_NEVER },
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
> @@ -110,7 +119,10 @@ static int virtio_fs_parse_param(struct fs_context *fc,
>  
>  	switch (opt) {
>  	case OPT_DAX:
> -		ctx->dax = 1;
> +		ctx->dax = FUSE_DAX_MOUNT_ALWAYS;
> +		break;
> +	case OPT_DAX_ENUM:
> +		ctx->dax = result.uint_32;

Do we want to check here if result.uint_32 has one of the allowed values.
FUSE_DAX_MOUNT_INODE, FUSE_DAX_MOUNT_ALWAYS or FUSE_DAX_MOUNT_NEVER. Or
VFS has already taken care of that?

Vivek



>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1326,7 +1338,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
>  
>  	/* virtiofs allocates and installs its own fuse devices */
>  	ctx->fudptr = NULL;
> -	if (ctx->dax) {
> +	if (ctx->dax != FUSE_DAX_MOUNT_NEVER) {
>  		if (!fs->dax_dev) {
>  			err = -EINVAL;
>  			pr_err("virtio-fs: dax can't be enabled as filesystem"
> -- 
> 2.27.0
> 

