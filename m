Return-Path: <linux-fsdevel+bounces-20116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AAF8CE67B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE561C21BD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 13:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349212C522;
	Fri, 24 May 2024 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi9X/RH7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161112C46A;
	Fri, 24 May 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716559099; cv=none; b=TODwvzKQ5m+qxZi2ruGWOYCGPTC4ja5RjuuiDOlrsENM5UGIRRgTpBcsATd4eHJNEqCijkdZTxZLndcapvfqqeoTk5TtoKTZRklt1G7XVdGSdlyjQncRGFRHl0Ik1wkUqhj0bBRjwYAM2yq5D4tgvYGZb4BIdCg1BcJnJjc8n74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716559099; c=relaxed/simple;
	bh=mqPylF2rRM5owpQNuZHbnBucyf7nC9Xrf+5RTVBCbnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPQLY9kxNm515z9b89IT6m5UXbLOzWD+SyStsX3TMxPGjVznIL8dGpFD8uhUnzbMIbz96V3WgvTTAOcyYzttU7uxXun9aW+BCV0q3DhmmVfnhqNdInk8ekoWQALNN1ywLusEZSWpgwcVobZQbeHuVc1SQDpYSTB3RChKAB6JMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi9X/RH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6999CC2BBFC;
	Fri, 24 May 2024 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716559099;
	bh=mqPylF2rRM5owpQNuZHbnBucyf7nC9Xrf+5RTVBCbnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wi9X/RH7QM8gTaEFnb72tkCiXB3tnr64Om3+92ksSghga+iThD3AVElMaCAG+POCK
	 s7bgveHVSibeuvz8rOp0r6duXSdFiaL9Ws56oE4WsgR7DG3NUwf3ioAWLO01EoR+wF
	 ag1qPcD/II5B5seX2QP6YyC98rTkqX8gVeT8SxsYEUZJhDD8uvUORRbsoESucUZmNw
	 K6s1NAs+I0UtwvAdrdgBr/VwMO3gcoPrH42vTfUWQyfC0F3NlJMkO+2mXy7sFaOfd0
	 bN6kOOocUDGyljDkr+70mPKPVCPPeRUL1qB/kNeX/s4osqOQQ1n4b8w/I1JlxTCOPa
	 ozDBwSC6icq8Q==
Date: Fri, 24 May 2024 15:58:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Michael Jeanson <mjeanson@efficios.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: linux-kernel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Seth Forshee <sforshee@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] exfat: handle idmapped mounts
Message-ID: <20240524-verordnen-exhumieren-2ea2e8bc2d08@brauner>
References: <20240523011007.40649-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523011007.40649-1-mjeanson@efficios.com>

[Cc: Alex]

On Wed, May 22, 2024 at 09:10:07PM -0400, Michael Jeanson wrote:
> Pass the idmapped mount information to the different helper
> functions. Adapt the uid/gid checks in exfat_setattr to use the
> vfsuid/vfsgid helpers.
> 
> Based on the fat implementation in commit 4b7899368108
> ("fat: handle idmapped mounts") by Christian Brauner.
> 
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Sungjong Seo <sj1557.seo@samsung.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---

Looks good to me but maybe Alex sees some issues I dont,
Reviewed-by: Christian Brauner <brauner@kernel.org>

>  fs/exfat/file.c  | 22 +++++++++++++---------
>  fs/exfat/super.c |  2 +-
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 9adfc38ca7da..64c31867bc76 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -89,12 +89,14 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
>  	return -EIO;
>  }
>  
> -static bool exfat_allow_set_time(struct exfat_sb_info *sbi, struct inode *inode)
> +static bool exfat_allow_set_time(struct mnt_idmap *idmap,
> +				 struct exfat_sb_info *sbi, struct inode *inode)
>  {
>  	mode_t allow_utime = sbi->options.allow_utime;
>  
> -	if (!uid_eq(current_fsuid(), inode->i_uid)) {
> -		if (in_group_p(inode->i_gid))
> +	if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
> +			    current_fsuid())) {
> +		if (vfsgid_in_group_p(i_gid_into_vfsgid(idmap, inode)))
>  			allow_utime >>= 3;
>  		if (allow_utime & MAY_WRITE)
>  			return true;
> @@ -283,7 +285,7 @@ int exfat_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	struct inode *inode = d_backing_inode(path->dentry);
>  	struct exfat_inode_info *ei = EXFAT_I(inode);
>  
> -	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
> +	generic_fillattr(idmap, request_mask, inode, stat);
>  	exfat_truncate_atime(&stat->atime);
>  	stat->result_mask |= STATX_BTIME;
>  	stat->btime.tv_sec = ei->i_crtime.tv_sec;
> @@ -311,20 +313,22 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	/* Check for setting the inode time. */
>  	ia_valid = attr->ia_valid;
>  	if ((ia_valid & (ATTR_MTIME_SET | ATTR_ATIME_SET | ATTR_TIMES_SET)) &&
> -	    exfat_allow_set_time(sbi, inode)) {
> +	    exfat_allow_set_time(idmap, sbi, inode)) {
>  		attr->ia_valid &= ~(ATTR_MTIME_SET | ATTR_ATIME_SET |
>  				ATTR_TIMES_SET);
>  	}
>  
> -	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
> +	error = setattr_prepare(idmap, dentry, attr);
>  	attr->ia_valid = ia_valid;
>  	if (error)
>  		goto out;
>  
>  	if (((attr->ia_valid & ATTR_UID) &&
> -	     !uid_eq(attr->ia_uid, sbi->options.fs_uid)) ||
> +	      (!uid_eq(from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid),
> +	       sbi->options.fs_uid))) ||
>  	    ((attr->ia_valid & ATTR_GID) &&
> -	     !gid_eq(attr->ia_gid, sbi->options.fs_gid)) ||
> +	      (!gid_eq(from_vfsgid(idmap, i_user_ns(inode), attr->ia_vfsgid),
> +	       sbi->options.fs_gid))) ||
>  	    ((attr->ia_valid & ATTR_MODE) &&
>  	     (attr->ia_mode & ~(S_IFREG | S_IFLNK | S_IFDIR | 0777)))) {
>  		error = -EPERM;
> @@ -343,7 +347,7 @@ int exfat_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (attr->ia_valid & ATTR_SIZE)
>  		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
>  
> -	setattr_copy(&nop_mnt_idmap, inode, attr);
> +	setattr_copy(idmap, inode, attr);
>  	exfat_truncate_inode_atime(inode);
>  
>  	if (attr->ia_valid & ATTR_SIZE) {
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 3d5ea2cfad66..1f2b3b0c4923 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -788,7 +788,7 @@ static struct file_system_type exfat_fs_type = {
>  	.init_fs_context	= exfat_init_fs_context,
>  	.parameters		= exfat_parameters,
>  	.kill_sb		= exfat_kill_sb,
> -	.fs_flags		= FS_REQUIRES_DEV,
> +	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
>  };
>  
>  static void exfat_inode_init_once(void *foo)
> -- 
> 2.45.1
> 

