Return-Path: <linux-fsdevel+bounces-53563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DA4AF02B6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 20:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570713B8C53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016728134F;
	Tue,  1 Jul 2025 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOve7nFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC9225C6EC;
	Tue,  1 Jul 2025 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751393894; cv=none; b=RMOE6kSl7CaA5Wj+2RbAWG0F+0xt/KVZExDl8QSmQ9IuS1ciq04cLziom+niiHmNjBoRTkbu4SU4vydkt1ufG8unrpgb2Rep/EzSwwm76iILG28vHZ5t550CBPrz8ZLeC9AMyqdcI2j3BCWRDU7nWKEWQrzsx499Gzcv4iWDUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751393894; c=relaxed/simple;
	bh=n6cBRF3jCpIqUJWocAYITuRSChEERzk1rzU0fLLtfnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf4nuRCbWu6fDxa83H1KzWb0cMFRWTf+qEVA6cdc/b/ua+xaOytmfB5aOT+7iMmHPpOqYZ+fFlmUorHUMSsm8eVqBypMGNQP2WI5+qhAjP/UNWg6jcKstRbRBg4+2DovvLv87kd7iqJYBDbdM61SAWcxXweYQQRtOF+02gcfzLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOve7nFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A151CC4CEEB;
	Tue,  1 Jul 2025 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751393893;
	bh=n6cBRF3jCpIqUJWocAYITuRSChEERzk1rzU0fLLtfnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOve7nFBiW+4Xa9g/HmNdV7FR8Fqkjm4aOBK9JKSevLI3S2Pa+vMqcMWjnTfwpSgX
	 NipKMfsytU62eZskBU5KLGwUdkOY5wVe1iXvdThcrOLEfeax4N4ZQUyAC9AC24MCoC
	 e2sV+ra/WFphgqp/SPyxKZ5Gs8UPcf8MHKjFU6T75sAkKVgmCnPtx9amk7/kGBa+lL
	 fDQEg8GykwIeJd2acriD1SsKskmVfB5z3pkuaRBKRx09sBB7LF5BFj5Kn88T9RjgmB
	 BHyo1olc5rEeqw1Ssml3xQAwMJUa4pRIiuK7TeuPJHx1j4iHKjgGbHHwlg18gbepEf
	 Iou6QQUR+acWQ==
Date: Tue, 1 Jul 2025 11:18:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, selinux@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 2/6] lsm: introduce new hooks for setting/getting
 inode fsxattr
Message-ID: <20250701181813.GN10009@frogsfrogsfrogs>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-2-c4e3bc35227b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630-xattrat-syscall-v6-2-c4e3bc35227b@kernel.org>

On Mon, Jun 30, 2025 at 06:20:12PM +0200, Andrey Albershteyn wrote:
> Introduce new hooks for setting and getting filesystem extended
> attributes on inode (FS_IOC_FSGETXATTR).
> 
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

I wonder, were FS_IOC_FS[GS]ETXATTR already covered by the
security_file_ioctl hook?  If so, will an out of date security policy
on a 6.17 kernel now fail to check the new file_[gs]etattr syscalls?

Though AFAICT the future of managing these "extra" file attributes is
the system call so it's probably appropriate to have an explicit
callout to LSMs.

Acked-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/file_attr.c                | 19 ++++++++++++++++---
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      | 16 ++++++++++++++++
>  security/security.c           | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 2910b7047721..be62d97cc444 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
>  int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
>  {
>  	struct inode *inode = d_inode(dentry);
> +	int error;
>  
>  	if (!inode->i_op->fileattr_get)
>  		return -ENOIOCTLCMD;
>  
> +	error = security_inode_file_getattr(dentry, fa);
> +	if (error)
> +		return error;
> +
>  	return inode->i_op->fileattr_get(dentry, fa);
>  }
>  EXPORT_SYMBOL(vfs_fileattr_get);
> @@ -242,12 +247,20 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
>  		} else {
>  			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
>  		}
> +
>  		err = fileattr_set_prepare(inode, &old_ma, fa);
> -		if (!err)
> -			err = inode->i_op->fileattr_set(idmap, dentry, fa);
> +		if (err)
> +			goto out;
> +		err = security_inode_file_setattr(dentry, fa);
> +		if (err)
> +			goto out;
> +		err = inode->i_op->fileattr_set(idmap, dentry, fa);
> +		if (err)
> +			goto out;
>  	}
> +
> +out:
>  	inode_unlock(inode);
> -
>  	return err;
>  }
>  EXPORT_SYMBOL(vfs_fileattr_set);
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index bf3bbac4e02a..9600a4350e79 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -157,6 +157,8 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *name)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
>  	 const char *name)
> +LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct fileattr *fa)
> +LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct fileattr *fa)
>  LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
>  	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
>  LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
> diff --git a/include/linux/security.h b/include/linux/security.h
> index dba349629229..9ed0d0e0c81f 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -451,6 +451,10 @@ int security_inode_listxattr(struct dentry *dentry);
>  int security_inode_removexattr(struct mnt_idmap *idmap,
>  			       struct dentry *dentry, const char *name);
>  void security_inode_post_removexattr(struct dentry *dentry, const char *name);
> +int security_inode_file_setattr(struct dentry *dentry,
> +			      struct fileattr *fa);
> +int security_inode_file_getattr(struct dentry *dentry,
> +			      struct fileattr *fa);
>  int security_inode_need_killpriv(struct dentry *dentry);
>  int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
>  int security_inode_getsecurity(struct mnt_idmap *idmap,
> @@ -1052,6 +1056,18 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
>  						   const char *name)
>  { }
>  
> +static inline int security_inode_file_setattr(struct dentry *dentry,
> +					      struct fileattr *fa)
> +{
> +	return 0;
> +}
> +
> +static inline int security_inode_file_getattr(struct dentry *dentry,
> +					      struct fileattr *fa)
> +{
> +	return 0;
> +}
> +
>  static inline int security_inode_need_killpriv(struct dentry *dentry)
>  {
>  	return cap_inode_need_killpriv(dentry);
> diff --git a/security/security.c b/security/security.c
> index 596d41818577..711b4de40b8d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2622,6 +2622,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
>  	call_void_hook(inode_post_removexattr, dentry, name);
>  }
>  
> +/**
> + * security_inode_file_setattr() - check if setting fsxattr is allowed
> + * @dentry: file to set filesystem extended attributes on
> + * @fa: extended attributes to set on the inode
> + *
> + * Called when file_setattr() syscall or FS_IOC_FSSETXATTR ioctl() is called on
> + * inode
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
> +{
> +	return call_int_hook(inode_file_setattr, dentry, fa);
> +}
> +
> +/**
> + * security_inode_file_getattr() - check if retrieving fsxattr is allowed
> + * @dentry: file to retrieve filesystem extended attributes from
> + * @fa: extended attributes to get
> + *
> + * Called when file_getattr() syscall or FS_IOC_FSGETXATTR ioctl() is called on
> + * inode
> + *
> + * Return: Returns 0 if permission is granted.
> + */
> +int security_inode_file_getattr(struct dentry *dentry, struct fileattr *fa)
> +{
> +	return call_int_hook(inode_file_getattr, dentry, fa);
> +}
> +
>  /**
>   * security_inode_need_killpriv() - Check if security_inode_killpriv() required
>   * @dentry: associated dentry
> 
> -- 
> 2.47.2
> 
> 

