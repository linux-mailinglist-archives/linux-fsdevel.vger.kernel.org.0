Return-Path: <linux-fsdevel+bounces-25920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC72951D74
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 16:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 833C81C2579B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71161B3F0E;
	Wed, 14 Aug 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3LcKHrq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D91B373B;
	Wed, 14 Aug 2024 14:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646376; cv=none; b=F99rjQ7EVRO2eScs5pIOZQA+D+MOmKNYQQ5tffQDVNJ7CrIRg9vECDoWr8p7meJsJ9ZP2mli1sQxn4WW6V05QQYE14G61L8b7NCUvXieQbyHTT/6+6/fMPZmTwgqs/YIJfDn2fmeEkMgeSOv+obcMaS5nGoxdIVxZrv2ShGk3ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646376; c=relaxed/simple;
	bh=Lz3WZju4AIx0XhLGlChFQhykhUMFjefQLlxi1VNM7LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkVHVm8/A6sJXkrs3hNSaVvP84ovzCkVpf7ZBCGDo7ZZYgdBIbc3cVF++Cv+etnTS++t1zZlSk7SGVM5J2UA+U3fatQqzH0kVz++G6Tyq/RTMurUu3qgYbv4cWxOqUhL8tcrBx8zxrqNSRZvVKfZUQfcOLAFvOdKSplsE1+v3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3LcKHrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A812C116B1;
	Wed, 14 Aug 2024 14:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723646375;
	bh=Lz3WZju4AIx0XhLGlChFQhykhUMFjefQLlxi1VNM7LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3LcKHrqsXQ/S/eSdVxcNBL9VCpUxk0hLYjOrsaOIY5o6KtN5e/7M6xrghhCMeNz1
	 +Eann4WzY8xQES0SDLqNU8mgTvM30yikIw1tISdJNwugjrCT6K8VVV2GTA1jxxLxXT
	 tT4rWXaOA20aMslvdcs5O5mDJ5xyrY5qnScyAnX7/s5jcBasuH1aQA6qnru2Ugvgxc
	 OmGWR4z8za9O0BPGE+j/VRuMRMB+hixckCBjNn/Xbid3jBjK0/+38J1I8qVvM5s152
	 bEsjRQOSr8YGjKKvqev6KSG/b7YSsMfoGm0hsy1mP/XVaCFjdR71zY8Cw38Vd33E+A
	 H0GmXn0WNmocg==
Date: Wed, 14 Aug 2024 16:39:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ian Kent <raven@themaw.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	autofs mailing list <autofs@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] autofs: add per dentry expire timeout
Message-ID: <20240814-darauf-schund-23ec844f4a09@brauner>
References: <20240814090231.963520-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240814090231.963520-1-raven@themaw.net>

On Wed, Aug 14, 2024 at 05:02:31PM GMT, Ian Kent wrote:
> Add ability to set per-dentry mount expire timeout to autofs.
> 
> There are two fairly well known automounter map formats, the autofs
> format and the amd format (more or less System V and Berkley).
> 
> Some time ago Linux autofs added an amd map format parser that
> implemented a fair amount of the amd functionality. This was done
> within the autofs infrastructure and some functionality wasn't
> implemented because it either didn't make sense or required extra
> kernel changes. The idea was to restrict changes to be within the
> existing autofs functionality as much as possible and leave changes
> with a wider scope to be considered later.
> 
> One of these changes is implementing the amd options:
> 1) "unmount", expire this mount according to a timeout (same as the
>    current autofs default).
> 2) "nounmount", don't expire this mount (same as setting the autofs
>    timeout to 0 except only for this specific mount) .
> 3) "utimeout=<seconds>", expire this mount using the specified
>    timeout (again same as setting the autofs timeout but only for
>    this mount).
> 
> To implement these options per-dentry expire timeouts need to be
> implemented for autofs indirect mounts. This is because all map keys
> (mounts) for autofs indirect mounts use an expire timeout stored in
> the autofs mount super block info. structure and all indirect mounts
> use the same expire timeout.
> 
> Now I have a request to add the "nounmount" option so I need to add
> the per-dentry expire handling to the kernel implementation to do this.
> 
> The implementation uses the trailing path component to identify the
> mount (and is also used as the autofs map key) which is passed in the
> autofs_dev_ioctl structure path field. The expire timeout is passed
> in autofs_dev_ioctl timeout field (well, of the timeout union).
> 
> If the passed in timeout is equal to -1 the per-dentry timeout and
> flag are cleared providing for the "unmount" option. If the timeout
> is greater than or equal to 0 the timeout is set to the value and the
> flag is also set. If the dentry timeout is 0 the dentry will not expire
> by timeout which enables the implementation of the "nounmount" option
> for the specific mount. When the dentry timeout is greater than zero it
> allows for the implementation of the "utimeout=<seconds>" option.
> 
> Signed-off-by: Ian Kent <raven@themaw.net>
> ---
>  fs/autofs/autofs_i.h         |  4 ++
>  fs/autofs/dev-ioctl.c        | 97 ++++++++++++++++++++++++++++++++++--
>  fs/autofs/expire.c           |  7 ++-
>  fs/autofs/inode.c            |  2 +
>  include/uapi/linux/auto_fs.h |  2 +-
>  5 files changed, 104 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index 8c1d587b3eef..77c7991d89aa 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -62,6 +62,7 @@ struct autofs_info {
>  	struct list_head expiring;
>  
>  	struct autofs_sb_info *sbi;
> +	unsigned long exp_timeout;
>  	unsigned long last_used;
>  	int count;
>  
> @@ -81,6 +82,9 @@ struct autofs_info {
>  					*/
>  #define AUTOFS_INF_PENDING	(1<<2) /* dentry pending mount */
>  
> +#define AUTOFS_INF_EXPIRE_SET	(1<<3) /* per-dentry expire timeout set for
> +					  this mount point.
> +					*/
>  struct autofs_wait_queue {
>  	wait_queue_head_t queue;
>  	struct autofs_wait_queue *next;
> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> index 5bf781ea6d67..f011e026358e 100644
> --- a/fs/autofs/dev-ioctl.c
> +++ b/fs/autofs/dev-ioctl.c
> @@ -128,7 +128,13 @@ static int validate_dev_ioctl(int cmd, struct autofs_dev_ioctl *param)
>  			goto out;
>  		}
>  
> +		/* Setting the per-dentry expire timeout requires a trailing
> +		 * path component, ie. no '/', so invert the logic of the
> +		 * check_name() return for AUTOFS_DEV_IOCTL_TIMEOUT_CMD.
> +		 */
>  		err = check_name(param->path);
> +		if (cmd == AUTOFS_DEV_IOCTL_TIMEOUT_CMD)
> +			err = err ? 0 : -EINVAL;
>  		if (err) {
>  			pr_warn("invalid path supplied for cmd(0x%08x)\n",
>  				cmd);
> @@ -396,16 +402,97 @@ static int autofs_dev_ioctl_catatonic(struct file *fp,
>  	return 0;
>  }
>  
> -/* Set the autofs mount timeout */
> +/*
> + * Set the autofs mount expire timeout.
> + *
> + * There are two places an expire timeout can be set, in the autofs
> + * super block info. (this is all that's needed for direct and offset
> + * mounts because there's a distinct mount corresponding to each of
> + * these) and per-dentry within within the dentry info. If a per-dentry
> + * timeout is set it will override the expire timeout set in the parent
> + * autofs super block info.
> + *
> + * If setting the autofs super block expire timeout the autofs_dev_ioctl
> + * size field will be equal to the autofs_dev_ioctl structure size. If
> + * setting the per-dentry expire timeout the mount point name is passed
> + * in the autofs_dev_ioctl path field and the size field updated to
> + * reflect this.
> + *
> + * Setting the autofs mount expire timeout sets the timeout in the super
> + * block info. struct. Setting the per-dentry timeout does a little more.
> + * If the timeout is equal to -1 the per-dentry timeout (and flag) is
> + * cleared which reverts to using the super block timeout, otherwise if
> + * timeout is 0 the timeout is set to this value and the flag is left
> + * set which disables expiration for the mount point, lastly the flag
> + * and the timeout are set enabling the dentry to use this timeout.
> + */
>  static int autofs_dev_ioctl_timeout(struct file *fp,
>  				    struct autofs_sb_info *sbi,
>  				    struct autofs_dev_ioctl *param)
>  {
> -	unsigned long timeout;
> +	unsigned long timeout = param->timeout.timeout;
> +
> +	/* If setting the expire timeout for an individual indirect
> +	 * mount point dentry the mount trailing component path is
> +	 * placed in param->path and param->size adjusted to account
> +	 * for it otherwise param->size it is set to the structure
> +	 * size.
> +	 */
> +	if (param->size == AUTOFS_DEV_IOCTL_SIZE) {
> +		param->timeout.timeout = sbi->exp_timeout / HZ;
> +		sbi->exp_timeout = timeout * HZ;
> +	} else {
> +		struct dentry *base = fp->f_path.dentry;
> +		struct inode *inode = base->d_inode;
> +		int path_len = param->size - AUTOFS_DEV_IOCTL_SIZE - 1;
> +		struct dentry *dentry;
> +		struct autofs_info *ino;
> +
> +		if (!autofs_type_indirect(sbi->type))
> +			return -EINVAL;
> +
> +		/* An expire timeout greater than the superblock timeout
> +		 * could be a problem at shutdown but the super block
> +		 * timeout itself can change so all we can really do is
> +		 * warn the user.
> +		 */
> +		if (timeout >= sbi->exp_timeout)
> +			pr_warn("per-mount expire timeout is greater than "
> +				"the parent autofs mount timeout which could "
> +				"prevent shutdown\n");

Wouldn't it be possible to just record the lowest known per-dentry
timeout in idk sbi->exp_lower_bound and reject sbi->exp_timeout changes
that go below that?

