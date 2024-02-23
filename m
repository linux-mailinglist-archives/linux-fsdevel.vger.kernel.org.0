Return-Path: <linux-fsdevel+bounces-12549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E51860CDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B9D287016
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5644EB45;
	Fri, 23 Feb 2024 08:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu0xdDe4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B54199B0;
	Fri, 23 Feb 2024 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676890; cv=none; b=R1j1IOL826qHlEYtoAhv3d+CsGJlQjFlRIDmixmioBjIqmsHlltjEzRRNNq4nfDE4d5Pl/E8tsWc3xjPJy5y3JVU9nHUCudRb7nelXsqqLJ41m/WQnrOjrQ+DTY3yZCC2uK2blSa6WFtvdgnxxvHDn//LokzZmgGIQEN69QjEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676890; c=relaxed/simple;
	bh=q6V2H4gtFXsWFNKk56zPdodpY1DcPJdBBy776jbpCfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb7JDjoSZHK6b0Ur0nYhufq7A2C9LST3zN5BkIfc+EJrf0GrPi9r/rwqpUgcpxAJccjC7a+8nbU667IBo+BfjeHfOGH+ZBc1OIEKi0fc7Oaiw+WLuSMSGxL9fLKKr6Oh9kmoN+/gB3f6DBX2ZK6d7Neqye8dtOWWWhH+fvmRslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu0xdDe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD0C433F1;
	Fri, 23 Feb 2024 08:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708676889;
	bh=q6V2H4gtFXsWFNKk56zPdodpY1DcPJdBBy776jbpCfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hu0xdDe4xcBEAVwr6eKhMBXxJbpLZgi9Bpm6xVwg0Uo1fwUlu5WUAnkGqOitKmGq1
	 tZ6lUtbEZwJ6++CltYmiYny6cfi1Z7WHDaOrsW6nqzRjTohYV2l/pleu2FK3tlJQ9u
	 RiDhf2akStqYEi99gM2+W8bb5quxSvd9vsxhvl9InnFpC1I35omMGlD8EzAmHEUPSm
	 6wEycOQLd20xkQ0qaCTprFSKep8ZGEDDtu20dmBvLQGZBn+JoBoI4SElAhDemNURx9
	 iNG/GkSFY+VEjOtVtWQsvP3W3x3T+tIdQ1G1NyCYnbSkf6e8NZup1qc32EHSMuLSrU
	 /0T6ZkyLaWK3Q==
Date: Fri, 23 Feb 2024 09:28:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 17/25] fs: add vfs_get_fscaps()
Message-ID: <20240223-unzutreffend-streng-40cc6bcbc222@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-17-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-17-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:48PM -0600, Seth Forshee (DigitalOcean) wrote:
> Provide a type-safe interface for retrieving filesystem capabilities and
> a generic implementation suitable for most filesystems. Also add an
> internal interface, vfs_get_fscaps_nosec(), which skips security checks
> for later use from the capability code.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  fs/xattr.c         | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  4 ++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 06290e4ebc03..10d1b1f78fc2 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -181,6 +181,70 @@ xattr_supports_user_prefix(struct inode *inode)
>  }
>  EXPORT_SYMBOL(xattr_supports_user_prefix);
>  
> +static int generic_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +			      struct vfs_caps *caps)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct vfs_ns_cap_data nscaps;
> +	int ret;
> +
> +	ret = __vfs_getxattr(dentry, inode, XATTR_NAME_CAPS, &nscaps, sizeof(nscaps));
> +
> +	if (ret >= 0)
> +		ret = vfs_caps_from_xattr(idmap, i_user_ns(inode), caps, &nscaps, ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * vfs_get_fscaps_nosec - get filesystem capabilities without security checks
> + * @idmap: idmap of the mount the inode was found from
> + * @dentry: the dentry from which to get filesystem capabilities
> + * @caps: storage in which to return the filesystem capabilities
> + *
> + * This function gets the filesystem capabilities for the dentry and returns
> + * them in @caps. It does not perform security checks.
> + *
> + * Return: 0 on success, a negative errno on error.
> + */
> +int vfs_get_fscaps_nosec(struct mnt_idmap *idmap, struct dentry *dentry,
> +			 struct vfs_caps *caps)
> +{
> +	struct inode *inode = d_inode(dentry);
> +
> +	if (inode->i_op->get_fscaps)
> +		return inode->i_op->get_fscaps(idmap, dentry, caps);
> +	return generic_get_fscaps(idmap, dentry, caps);
> +}
> +
> +/**
> + * vfs_get_fscaps - get filesystem capabilities
> + * @idmap: idmap of the mount the inode was found from
> + * @dentry: the dentry from which to get filesystem capabilities
> + * @caps: storage in which to return the filesystem capabilities
> + *
> + * This function gets the filesystem capabilities for the dentry and returns
> + * them in @caps.
> + *
> + * Return: 0 on success, a negative errno on error.
> + */
> +int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +		   struct vfs_caps *caps)
> +{
> +	int error;
> +
> +	/*
> +	 * The VFS has no restrictions on reading security.* xattrs, so
> +	 * xattr_permission() isn't needed. Only LSMs get a say.
> +	 */
> +	error = security_inode_get_fscaps(idmap, dentry);
> +	if (error)
> +		return error;
> +
> +	return vfs_get_fscaps_nosec(idmap, dentry, caps);
> +}
> +EXPORT_SYMBOL(vfs_get_fscaps);
> +
>  int
>  __vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	       struct inode *inode, const char *name, const void *value,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 89163e0f7aad..d7cd2467e1ea 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2116,6 +2116,10 @@ extern int vfs_dedupe_file_range(struct file *file,
>  extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>  					struct file *dst_file, loff_t dst_pos,
>  					loff_t len, unsigned int remap_flags);
> +extern int vfs_get_fscaps_nosec(struct mnt_idmap *idmap, struct dentry *dentry,
> +				struct vfs_caps *caps);
> +extern int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +			  struct vfs_caps *caps);

Please drop the externs. Other than my usual complaing about this
falling back to the legacy vfs_*xattr() interfaces,
Reviewed-by: Christian Brauner <brauner@kernel.org>

