Return-Path: <linux-fsdevel+bounces-12552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CAE860D04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3D7B24602
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8318E2A;
	Fri, 23 Feb 2024 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoAHNn/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82E17BC1;
	Fri, 23 Feb 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677548; cv=none; b=ZvN/Rq/nuIO/33XH17ZIufa35uapAmHS8GE/XbzvP6Ndfd66epApsEa1heoHYO3sIAXDuhnF7KfSygvlYk7LARvWg2mKDUbWaCPp1faa+XX4ZG4+MOITY42Icw/9bYP0DPa230I0Jsub1vqz73I/i+9LvahCAGgySRib8ZK+hiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677548; c=relaxed/simple;
	bh=/UDfrDS9KwonodlrRcDZK+463Wesj7cXnS8k0zwgjbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1i6XkI/uUgwOj0Q7YkYCcFQuAAJKkbDZLqilpCi/GItrDJzJ0I+AmlZMYwlDODKu8ArNLJEoIfM9gbUkoIz/42CTJo34rYH9xxXsQ59PrxXXXpToTne4TE2PxWaA3zdEnOUW0UWMF36qF5SX6Z3y4/+7tgUBxD88upF2ZKdH6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoAHNn/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385A7C433C7;
	Fri, 23 Feb 2024 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708677547;
	bh=/UDfrDS9KwonodlrRcDZK+463Wesj7cXnS8k0zwgjbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoAHNn/+PBXxa6O8LLgQzQyGQOtdDop3hBZysdXKh2tXhh+Ri5zvjoNa1G8bNpJFU
	 3j1wNb1TAAwqVWq19uJZ8qkq9XjDDeqko0Uz65KP1yiSZVcuV0o5+J7z6wgWpdhrbc
	 OSQfFbpAzTB5NuXvp6pI4e043pnHBj3PiMuxHgaWr2HfMGc57u1Jl4pz9ygUvq1ieE
	 fpyg6PFMJKMGqKnUgyYhH8qfCogF39tbpoTNzlxmxDsV4di+HboHhslxkSw7h0as+g
	 F9dO36WvChMmfBHwz5du+PWnvWudQ8slQkYpxYG3NvcrjAh/+8nqy0mvN8i11qyv3P
	 D7rE73sy0aQrg==
Date: Fri, 23 Feb 2024 09:38:59 +0100
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
Subject: Re: [PATCH v2 18/25] fs: add vfs_set_fscaps()
Message-ID: <20240223-kehlkopf-zitat-494f00034071@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-18-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-18-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:49PM -0600, Seth Forshee (DigitalOcean) wrote:
> Provide a type-safe interface for setting filesystem capabilities and a
> generic implementation suitable for most filesystems.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  fs/xattr.c         | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  2 ++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 10d1b1f78fc2..96de43928a51 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -245,6 +245,85 @@ int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
>  }
>  EXPORT_SYMBOL(vfs_get_fscaps);
>  
> +static int generic_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +			      const struct vfs_caps *caps, int setxattr_flags)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct vfs_ns_cap_data nscaps;
> +	int size;

ssize_t, I believe.

> +
> +	size = vfs_caps_to_xattr(idmap, i_user_ns(inode), caps,
> +				 &nscaps, sizeof(nscaps));
> +	if (size < 0)
> +		return size;
> +
> +	return __vfs_setxattr_noperm(idmap, dentry, XATTR_NAME_CAPS,
> +				     &nscaps, size, setxattr_flags);
> +}
> +
> +/**
> + * vfs_set_fscaps - set filesystem capabilities
> + * @idmap: idmap of the mount the inode was found from
> + * @dentry: the dentry on which to set filesystem capabilities
> + * @caps: the filesystem capabilities to be written
> + * @setxattr_flags: setxattr flags to use when writing the capabilities xattr
> + *
> + * This function writes the supplied filesystem capabilities to the dentry.
> + *
> + * Return: 0 on success, a negative errno on error.
> + */
> +int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +		   const struct vfs_caps *caps, int setxattr_flags)
> +{
> +	struct inode *inode = d_inode(dentry);
> +	struct inode *delegated_inode = NULL;
> +	int error;
> +
> +retry_deleg:
> +	inode_lock(inode);
> +
> +	error = xattr_permission(idmap, inode, XATTR_NAME_CAPS, MAY_WRITE);
> +	if (error)
> +		goto out_inode_unlock;

I think this should be

        /*
         * We only care about restrictions the inode struct itself places upon
         * us otherwise fscaps aren't subject to any VFS restrictions.
         */
        error = may_write_xattr(idmap, inode);
        if (error)
                goto out_inode_unlock;

which is a 1:1 copy of what POSIX ACLs do?

> +	error = security_inode_set_fscaps(idmap, dentry, caps, setxattr_flags);
> +	if (error)
> +		goto out_inode_unlock;
> +
> +	error = try_break_deleg(inode, &delegated_inode);
> +	if (error)
> +		goto out_inode_unlock;
> +
> +	if (inode->i_opflags & IOP_XATTR) {

Fwiw, I think that if we move fscaps off of xattr handlers completely
this can go away and we can simply rely on ->{g,s}et_fscaps() being
implemented. But again, that can be in a follow-up series.

> +		if (inode->i_op->set_fscaps)
> +			error = inode->i_op->set_fscaps(idmap, dentry, caps,
> +							setxattr_flags);
> +		else
> +			error = generic_set_fscaps(idmap, dentry, caps,
> +						   setxattr_flags);
> +		if (!error) {
> +			fsnotify_xattr(dentry);
> +			security_inode_post_set_fscaps(idmap, dentry, caps,
> +						       setxattr_flags);
> +		}
> +	} else if (unlikely(is_bad_inode(inode))) {
> +		error = -EIO;
> +	} else {
> +		error = -EOPNOTSUPP;
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
> +EXPORT_SYMBOL(vfs_set_fscaps);
> +
>  int
>  __vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	       struct inode *inode, const char *name, const void *value,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7cd2467e1ea..4f5d7ed44644 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2120,6 +2120,8 @@ extern int vfs_get_fscaps_nosec(struct mnt_idmap *idmap, struct dentry *dentry,
>  				struct vfs_caps *caps);
>  extern int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
>  			  struct vfs_caps *caps);
> +extern int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +			  const struct vfs_caps *caps, int setxattr_flags);

Please drop the extern.

