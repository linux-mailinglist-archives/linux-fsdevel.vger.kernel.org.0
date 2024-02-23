Return-Path: <linux-fsdevel+bounces-12553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06570860D0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2887E1C22708
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193118E2A;
	Fri, 23 Feb 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH4wnTxU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD2917BAC;
	Fri, 23 Feb 2024 08:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677613; cv=none; b=l5MaptuzZzqCiaMSFToFiNww4uCGAf6RBfwCo2s2ExGQlnEf/fLHXnTwT3KGlGTrrrua5T/SrIk/Lmlh8j2Nd7UvtYRzZ7HDp54v76RlBtTukcROT2VDEzC675G1tr2mleSep5DVZUw4rTvkQAMf5Kj0WiR50FNaE/v1gj2TulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677613; c=relaxed/simple;
	bh=26qXSoNOanIh2BHkDdomIEeZtTX2NNa2xiQmWVHrpkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi5zd1SBg62Tkrjb/4b70/CeHSoKph//y92GkUuq4uWAHOVs1uRMrKXxHa+LCfAM0Peqh8Egu6uenYA6rqYfP6w3w0uk1tff8yoZG75xwmehjo7qKRoq2v28ewPv+EJyXZ9y4gABclg513bGxyDEsvY5rLOayHoR7id13tT3TxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dH4wnTxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5615C433F1;
	Fri, 23 Feb 2024 08:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708677612;
	bh=26qXSoNOanIh2BHkDdomIEeZtTX2NNa2xiQmWVHrpkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dH4wnTxUOdotCDGX6WhVjFnKVR4/dyixQK98JtcAs3iGz/gBNSR0+IeId875l2Rn3
	 ICgxQuJTMNSQKv58sZMHrUW4fDp6pCrKU/XuyKBSO/+R+RiMCHiQFJiLAFIROVGmT8
	 QIDP+w/8sUSNEPvRXSMdLi2ujRKYfM58TIHdkjl/o4CooXBjcaIbXF6BeS/p0PfZdt
	 BLtjtHejDfFvo/ONO/tgn25EBu/adDJGj5aWp3bpGNbflbruMO2X4MH7utC0m7csF3
	 Z+QM8mL5XHQKq+LM8Gbbep/yWB5O5+MOf+7zkMsoUfng2QwoTgzy0U/A9AJ207nwwL
	 wir5LjkBeRfnQ==
Date: Fri, 23 Feb 2024 09:40:05 +0100
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
Subject: Re: [PATCH v2 19/25] fs: add vfs_remove_fscaps()
Message-ID: <20240223-kehle-willen-cd42ece30692@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-19-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-19-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:50PM -0600, Seth Forshee (DigitalOcean) wrote:
> Provide a type-safe interface for removing filesystem capabilities and a
> generic implementation suitable for most filesystems. Also add an
> internal interface, vfs_remove_fscaps_nosec(), which is called with the
> inode lock held and skips security checks for later use from the
> capability code.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  fs/xattr.c         | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  2 files changed, 83 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 96de43928a51..8b0f7384cbc9 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -324,6 +324,87 @@ int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
>  }
>  EXPORT_SYMBOL(vfs_set_fscaps);
>  
> +static int generic_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
> +{
> +	return __vfs_removexattr(idmap, dentry, XATTR_NAME_CAPS);
> +}
> +
> +/**
> + * vfs_remove_fscaps_nosec - remove filesystem capabilities without
> + *                           security checks
> + * @idmap: idmap of the mount the inode was found from
> + * @dentry: the dentry from which to remove filesystem capabilities
> + *
> + * This function removes any filesystem capabilities from the specified
> + * dentry. Does not perform any security checks, and callers must hold the
> + * inode lock.
> + *
> + * Return: 0 on success, a negative errno on error.
> + */
> +int vfs_remove_fscaps_nosec(struct mnt_idmap *idmap, struct dentry *dentry)
> +{
> +	struct inode *inode = dentry->d_inode;
> +	int error;
> +
> +	if (inode->i_op->set_fscaps)
> +		error =  inode->i_op->set_fscaps(idmap, dentry, NULL,
> +						 XATTR_REPLACE);
> +	else
> +		error = generic_remove_fscaps(idmap, dentry);
> +
> +	return error;
> +}
> +
> +/**
> + * vfs_remove_fscaps - remove filesystem capabilities
> + * @idmap: idmap of the mount the inode was found from
> + * @dentry: the dentry from which to remove filesystem capabilities
> + *
> + * This function removes any filesystem capabilities from the specified
> + * dentry.
> + *
> + * Return: 0 on success, a negative errno on error.
> + */
> +int vfs_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
> +{
> +	struct inode *inode = dentry->d_inode;
> +	struct inode *delegated_inode = NULL;
> +	int error;
> +
> +retry_deleg:
> +	inode_lock(inode);
> +
> +	error = xattr_permission(idmap, inode, XATTR_NAME_CAPS, MAY_WRITE);
> +	if (error)
> +		goto out_inode_unlock;

Should also use may_write_xattr() instead of xattr_permission() if
possible.

> +
> +	error = security_inode_remove_fscaps(idmap, dentry);
> +	if (error)
> +		goto out_inode_unlock;
> +
> +	error = try_break_deleg(inode, &delegated_inode);
> +	if (error)
> +		goto out_inode_unlock;
> +
> +	error = vfs_remove_fscaps_nosec(idmap, dentry);
> +	if (!error) {
> +		fsnotify_xattr(dentry);
> +		evm_inode_post_remove_fscaps(dentry);
> +	}
> +
> +out_inode_unlock:
> +	inode_unlock(inode);
> +
> +	if (delegated_inode) {
> +		error = break_deleg_wait(&delegated_inode);
> +		if (!error)
> +			goto retry_deleg;
> +	}
> +
> +	return error;
> +}
> +EXPORT_SYMBOL(vfs_remove_fscaps);
> +
>  int
>  __vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	       struct inode *inode, const char *name, const void *value,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4f5d7ed44644..c07427d2fc71 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2122,6 +2122,8 @@ extern int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
>  			  struct vfs_caps *caps);
>  extern int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
>  			  const struct vfs_caps *caps, int setxattr_flags);
> +extern int vfs_remove_fscaps_nosec(struct mnt_idmap *idmap, struct dentry *dentry);
> +extern int vfs_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry);

Please drop the extern.

