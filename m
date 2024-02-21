Return-Path: <linux-fsdevel+bounces-12221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD6A85D279
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FB7286153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786113BB37;
	Wed, 21 Feb 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKRvOW1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63593A8F0
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503837; cv=none; b=WfMV5TRWtrTWfnw6p+UTdb7A4uWD6f2L7/WfASTD6cxr31oOd0yYogvD9y8tT6HZKwoCqrIA3ePwey0YBC9N6k0k1Mvt3ZpvS5xhdxg8QN/Dd/ZbG5TQv6uksUqjoDUgiaTUVMeGibOiNMtJ7ybFlJ23rHYE7qnp8m8Owg7x/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503837; c=relaxed/simple;
	bh=gZccYbiVBQcsv93RH6yppuzFpxxBzA4DizM/5xhE+Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elTS4R17HKBj5gRKI/kKF6zGEIQmfhoHib2y5BCsxPdi5ubwvOcdiIEkGcFWYkcfhtyeeb63bc0jRfIWq0X0cWPASzf0Uok5qIIiqxEmWMpNwZyexUzXOBM/R7tx3BbztNl9anYZdAxHuyMP5p0MHjwVQ5mBpAFaOeWR/JndFxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKRvOW1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D589C433F1;
	Wed, 21 Feb 2024 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708503837;
	bh=gZccYbiVBQcsv93RH6yppuzFpxxBzA4DizM/5xhE+Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKRvOW1T/Oxf+8qZ3Nzv073UCTAkM/lgp//apEF9w6X1fp5wwoTpNiviwWtsV7fEI
	 k1reANF+e6m9D1Yg4o8R4m2QDTc9a9WynLly1c7GVzvwaBhwb8TIvlgnZ4aD5kqgUr
	 AdUu8qrB3XDiLlJ8yeQlyxwjzE8Z+kJo6btpTFnJJnpeBdplhy8oswEjevbDgYWN8r
	 T86m9N2K8Ntu1zVKt7/meM6lRDEHz4Bv8JcZZZ1x97n3UqDLIIKxs1ji3SAr2GXFhq
	 8O9DNKuLuM35/do5QeBUXXnT2q7G7Tnj8kCAr9LLJNYJFjgGyOAPMiKl7VjNoD8uPl
	 xkXz4NMBEPR5Q==
Date: Wed, 21 Feb 2024 09:23:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, Bill O'Donnell <billodo@redhat.com>
Subject: Re: [PATCH] Convert coda to use the new mount API
Message-ID: <20240221-kneifen-ferngeblieben-bd2d4f1f47db@brauner>
References: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>

On Tue, Feb 20, 2024 at 03:13:50PM -0600, Eric Sandeen wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Convert the coda filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
> 
> See Documentation/filesystems/mount_api.rst for more information.
> 
> Note this is slightly tricky as coda currently only has a binary mount data
> interface.  This is handled through the parse_monolithic hook.
> 
> Also add a more conventional interface with a parameter named "fd" that
> takes an fd that refers to a coda psdev, thereby specifying the index to
> use.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Co-developed-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> [sandeen: forward port to current upstream mount API interfaces]
> Tested-by: Jan Harkes <jaharkes@cs.cmu.edu>
> cc: coda@cs.cmu.edu
> 
> ---
> 
> NB: This updated patch is based on 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=4aec2ba3ca543e39944604774b8cab9c4d592651
> 
> hence the From: David above.
> 
>  fs/coda/inode.c | 140 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 98 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/coda/inode.c b/fs/coda/inode.c
> index 0c7c2528791e..479c45b7b621 100644
> --- a/fs/coda/inode.c
> +++ b/fs/coda/inode.c
> @@ -24,6 +24,8 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/uaccess.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/vmalloc.h>
>  
>  #include <linux/coda.h>
> @@ -87,10 +89,10 @@ void coda_destroy_inodecache(void)
>  	kmem_cache_destroy(coda_inode_cachep);
>  }
>  
> -static int coda_remount(struct super_block *sb, int *flags, char *data)
> +static int coda_reconfigure(struct fs_context *fc)
>  {
> -	sync_filesystem(sb);
> -	*flags |= SB_NOATIME;
> +	sync_filesystem(fc->root->d_sb);
> +	fc->sb_flags |= SB_NOATIME;
>  	return 0;
>  }
>  
> @@ -102,78 +104,105 @@ static const struct super_operations coda_super_operations =
>  	.evict_inode	= coda_evict_inode,
>  	.put_super	= coda_put_super,
>  	.statfs		= coda_statfs,
> -	.remount_fs	= coda_remount,
>  };
>  
> -static int get_device_index(struct coda_mount_data *data)
> +struct coda_fs_context {
> +	int	idx;
> +};
> +
> +enum {
> +	Opt_fd,
> +};
> +
> +static const struct fs_parameter_spec coda_param_specs[] = {
> +	fsparam_fd	("fd",	Opt_fd),
> +	{}
> +};
> +
> +static int coda_parse_fd(struct fs_context *fc, int fd)
>  {
> +	struct coda_fs_context *ctx = fc->fs_private;
>  	struct fd f;
>  	struct inode *inode;
>  	int idx;
>  
> -	if (data == NULL) {
> -		pr_warn("%s: Bad mount data\n", __func__);
> -		return -1;
> -	}
> -
> -	if (data->version != CODA_MOUNT_VERSION) {
> -		pr_warn("%s: Bad mount version\n", __func__);
> -		return -1;
> -	}
> -
> -	f = fdget(data->fd);
> +	f = fdget(fd);
>  	if (!f.file)
> -		goto Ebadf;
> +		return -EBADF;
>  	inode = file_inode(f.file);
>  	if (!S_ISCHR(inode->i_mode) || imajor(inode) != CODA_PSDEV_MAJOR) {
>  		fdput(f);
> -		goto Ebadf;
> +		return invalf(fc, "code: Not coda psdev");
>  	}
>  
>  	idx = iminor(inode);
>  	fdput(f);
>  
> -	if (idx < 0 || idx >= MAX_CODADEVS) {
> -		pr_warn("%s: Bad minor number\n", __func__);
> -		return -1;
> +	if (idx < 0 || idx >= MAX_CODADEVS)
> +		return invalf(fc, "coda: Bad minor number");
> +	ctx->idx = idx;
> +	return 0;
> +}
> +
> +static int coda_parse_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct fs_parse_result result;
> +	int opt;
> +
> +	opt = fs_parse(fc, coda_param_specs, param, &result);
> +	if (opt < 0)
> +		return opt;
> +
> +	switch (opt) {
> +	case Opt_fd:
> +		return coda_parse_fd(fc, result.uint_32);
>  	}
>  
> -	return idx;
> -Ebadf:
> -	pr_warn("%s: Bad file\n", __func__);
> -	return -1;
> +	return 0;
>  }
>  
> -static int coda_fill_super(struct super_block *sb, void *data, int silent)
> +/*
> + * Parse coda's binary mount data form.  We ignore any errors and go with index
> + * 0 if we get one for backward compatibility.
> + */
> +static int coda_parse_monolithic(struct fs_context *fc, void *_data)
>  {
> +	struct coda_mount_data *data = _data;
> +
> +	if (!data)
> +		return invalf(fc, "coda: Bad mount data");
> +
> +	if (data->version != CODA_MOUNT_VERSION)
> +		return invalf(fc, "coda: Bad mount version");
> +
> +	coda_parse_fd(fc, data->fd);
> +	return 0;
> +}
> +
> +static int coda_fill_super(struct super_block *sb, struct fs_context *fc)
> +{
> +	struct coda_fs_context *ctx = fc->fs_private;
>  	struct inode *root = NULL;
>  	struct venus_comm *vc;
>  	struct CodaFid fid;
>  	int error;
> -	int idx;
>  
>  	if (task_active_pid_ns(current) != &init_pid_ns)
>  		return -EINVAL;
>  
> -	idx = get_device_index((struct coda_mount_data *) data);
> +	infof(fc, "coda: device index: %i\n", ctx->idx);
>  
> -	/* Ignore errors in data, for backward compatibility */
> -	if(idx == -1)
> -		idx = 0;
> -	
> -	pr_info("%s: device index: %i\n", __func__,  idx);
> -
> -	vc = &coda_comms[idx];
> +	vc = &coda_comms[ctx->idx];
>  	mutex_lock(&vc->vc_mutex);
>  
>  	if (!vc->vc_inuse) {
> -		pr_warn("%s: No pseudo device\n", __func__);
> +		errorf(fc, "coda: No pseudo device");
>  		error = -EINVAL;
>  		goto unlock_out;
>  	}
>  
>  	if (vc->vc_sb) {
> -		pr_warn("%s: Device already mounted\n", __func__);
> +		errorf(fc, "coda: Device already mounted");
>  		error = -EBUSY;
>  		goto unlock_out;
>  	}
> @@ -313,18 +342,45 @@ static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
>  	return 0; 
>  }
>  
> -/* init_coda: used by filesystems.c to register coda */
> +static int coda_get_tree(struct fs_context *fc)
> +{
> +	if (task_active_pid_ns(current) != &init_pid_ns)
> +		return -EINVAL;

Fwiw, this check is redundant since you're performing the same check in
coda_fill_super() again.

