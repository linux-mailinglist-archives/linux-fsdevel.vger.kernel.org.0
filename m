Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD03431F10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 16:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhJRONs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 10:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233563AbhJRONO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 10:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634566263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=064MO1ygmXJa1fVKyFJVck+W1a3Wk0X30J/mSsTbiT0=;
        b=HdFYFXx6QT3qSSdwpYhDdxqzUEH6lCE/1BS8E/8nrd5Z65XtAP5Atp00zXLp/fOoXXKwQx
        JRYMPDIH98dpCefgmmQM+F2zyHaBr2RxoGl/BKMzHgUhsN+olW7KeSVg1pGp/3X86J9AG4
        R/wGrmJXucx1AY4HIMAFAuYvJwW/t1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-i4GZyiKdNlmZWVRweQTNSw-1; Mon, 18 Oct 2021 10:10:59 -0400
X-MC-Unique: i4GZyiKdNlmZWVRweQTNSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE68A18125C0;
        Mon, 18 Oct 2021 14:10:58 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A47D55DF21;
        Mon, 18 Oct 2021 14:10:27 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 35E9522045E; Mon, 18 Oct 2021 10:10:27 -0400 (EDT)
Date:   Mon, 18 Oct 2021 10:10:27 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hub,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v6 2/7] fuse: make DAX mount option a tri-state
Message-ID: <YW2AU/E0pLHO5Yl8@redhat.com>
References: <20211011030052.98923-1-jefflexu@linux.alibaba.com>
 <20211011030052.98923-3-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011030052.98923-3-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 11:00:47AM +0800, Jeffle Xu wrote:
> We add 'always', 'never', and 'inode' (default). '-o dax' continues to
> operate the same which is equivalent to 'always'. To be consistemt with
> ext4/xfs's tri-state mount option, when neither '-o dax' nor '-o dax='
> option is specified, the default behaviour is equal to 'inode'.

Hi Jeffle,

I am not sure when  -o "dax=inode"  is used as a default? If user
specifies, "-o dax" then it is equal to "-o dax=always", otherwise
user will explicitly specify "-o dax=always/never/inode". So when
is dax=inode is used as default?

> 
> By the time this patch is applied, 'inode' mode is actually equal to
> 'always' mode, before the per-file DAX flag is introduced in the
> following patch.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/dax.c       | 19 ++++++++++++++++---
>  fs/fuse/fuse_i.h    | 14 ++++++++++++--
>  fs/fuse/inode.c     | 10 +++++++---
>  fs/fuse/virtio_fs.c | 16 ++++++++++++++--
>  4 files changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> index 1eb6538bf1b2..4c6c64efc950 100644
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
> @@ -1335,11 +1338,21 @@ static const struct address_space_operations fuse_dax_file_aops  = {
>  static bool fuse_should_enable_dax(struct inode *inode)
>  {
>  	struct fuse_conn *fc = get_fuse_conn(inode);
> +	unsigned int dax_mode = fc->dax_mode;
> +
> +	if (dax_mode == FUSE_DAX_NEVER)
> +		return false;
>  
> -	if (fc->dax)
> +	/*
> +	 * If 'dax=always/inode', fc->dax couldn't be NULL even when fuse
> +	 * daemon doesn't support DAX, since the mount routine will fail
> +	 * early in this case.
> +	 */
> +	if (dax_mode == FUSE_DAX_ALWAYS)
>  		return true;
>  
> -	return false;
> +	/* dax_mode == FUSE_DAX_INODE */
> +	return true;

So as of this patch except FUSE_DAX_NEVER return true and this will
change in later patches for FUSE_DAX_INODE? If that's the case, keep
it simple in this patch and change it later in the patch series.

fuse_should_enable_dax()
{
	if (dax_mode == FUSE_DAX_NEVER)
		return false;
	return true;
}

>  }
>  
>  void fuse_dax_inode_init(struct inode *inode)
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 319596df5dc6..5abf9749923f 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -480,6 +480,12 @@ struct fuse_dev {
>  	struct list_head entry;
>  };
>  
> +enum fuse_dax_mode {
> +	FUSE_DAX_INODE,
> +	FUSE_DAX_ALWAYS,
> +	FUSE_DAX_NEVER,
> +};
> +
>  struct fuse_fs_context {
>  	int fd;
>  	struct file *file;
> @@ -497,7 +503,7 @@ struct fuse_fs_context {
>  	bool no_control:1;
>  	bool no_force_umount:1;
>  	bool legacy_opts_show:1;
> -	bool dax:1;
> +	enum fuse_dax_mode dax_mode;
>  	unsigned int max_read;
>  	unsigned int blksize;
>  	const char *subtype;
> @@ -802,6 +808,9 @@ struct fuse_conn {
>  	struct list_head devices;
>  
>  #ifdef CONFIG_FUSE_DAX
> +	/* dax mode: FUSE_DAX_* (always, never or per-file) */
> +	enum fuse_dax_mode dax_mode;
> +
>  	/* Dax specific conn data, non-NULL if DAX is enabled */
>  	struct fuse_conn_dax *dax;
>  #endif
> @@ -1255,7 +1264,8 @@ ssize_t fuse_dax_read_iter(struct kiocb *iocb, struct iov_iter *to);
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
> index 36cd03114b6d..b4b41683e97e 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -742,8 +742,12 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
>  			seq_printf(m, ",blksize=%lu", sb->s_blocksize);
>  	}
>  #ifdef CONFIG_FUSE_DAX
> -	if (fc->dax)
> -		seq_puts(m, ",dax");
> +	if (fc->dax_mode == FUSE_DAX_ALWAYS)
> +		seq_puts(m, ",dax=always");

So if somebody mounts with "-o dax" then kernel previous to this change
will show "dax" and kernel after this change will show "dax=always"?

How about not change the behavior. Keep a mode say FUSE_DAX_LEGACY which
will be set when user specifies "-o dax". Internally FUSE_DAX_LEGACY
and FUSE_DAX_ALWAYS will be same.

	if (fc->dax_mode == FUSE_DAX_LEGACY)
		seq_puts(m, ",dax");


Thanks
Vivek

> +	else if (fc->dax_mode == FUSE_DAX_NEVER)
> +		seq_puts(m, ",dax=never");
> +	else if (fc->dax_mode == FUSE_DAX_INODE)
> +		seq_puts(m, ",dax=inode");
>  #endif
>  
>  	return 0;
> @@ -1493,7 +1497,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
>  	sb->s_subtype = ctx->subtype;
>  	ctx->subtype = NULL;
>  	if (IS_ENABLED(CONFIG_FUSE_DAX)) {
> -		err = fuse_dax_conn_alloc(fc, ctx->dax_dev);
> +		err = fuse_dax_conn_alloc(fc, ctx->dax_mode, ctx->dax_dev);
>  		if (err)
>  			goto err;
>  	}
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 0ad89c6629d7..58cfbaeb4a7d 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -88,12 +88,21 @@ struct virtio_fs_req_work {
>  static int virtio_fs_enqueue_req(struct virtio_fs_vq *fsvq,
>  				 struct fuse_req *req, bool in_flight);
>  
> +static const struct constant_table dax_param_enums[] = {
> +	{"inode",	FUSE_DAX_INODE },
> +	{"always",	FUSE_DAX_ALWAYS },
> +	{"never",	FUSE_DAX_NEVER },
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
> @@ -1326,7 +1338,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
>  
>  	/* virtiofs allocates and installs its own fuse devices */
>  	ctx->fudptr = NULL;
> -	if (ctx->dax) {
> +	if (ctx->dax_mode != FUSE_DAX_NEVER) {
>  		if (!fs->dax_dev) {
>  			err = -EINVAL;
>  			pr_err("virtio-fs: dax can't be enabled as filesystem"
> -- 
> 2.27.0
> 

