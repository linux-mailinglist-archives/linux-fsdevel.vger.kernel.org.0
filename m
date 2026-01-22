Return-Path: <linux-fsdevel+bounces-75153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP/HM92UcmksmQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:21:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82B6DAFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 22:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 071F630185B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A303B4C98;
	Thu, 22 Jan 2026 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH0CIJFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3589B3A731F;
	Thu, 22 Jan 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116883; cv=none; b=CUiXCOz/v2IecDDaHfAJH4Yo6oDwqUQYbs/YHxRkRvcVpvnhf6Sq+WRGA8gS69t8uwagYNMYL7U4AolHZcSpBZh6XK1J2hBP/FujwVvf4uQIb4q9n6HMULaU/LSlIqrAy3evyzIPgGnWtglJHGOLdHUth8olDyiTaM416UWTysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116883; c=relaxed/simple;
	bh=HuuV2V7oQdXHpZv2p1xtrH9rIpKzASmyg1enkricVyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5FgbtpapsjTpBSKsum4rc2L/SrQmuS+uyqWVdrZ4bXdcTTyvHbBaGhSOXOIrdfOVoVd8rFFVdbhwI45tQ/0TnXLIYO4bKVNccA3qgJi91/scTRuxyhEe71rLRRG5xNnDO5emW9rZWdJiNGZoDloGyKU6iqDBSF/ddqhYtC/GNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH0CIJFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BCFC116C6;
	Thu, 22 Jan 2026 21:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769116882;
	bh=HuuV2V7oQdXHpZv2p1xtrH9rIpKzASmyg1enkricVyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vH0CIJFDafluSg7UmFnP+wjTXB3u+C5rT5g6Fzh5Bi3H+8e35YmszXezwTTlhPksL
	 8WxIH7HbfjYE2Y/mAGaDpnlM+ypNi1FUDuIOso3Tirt6B66U+S/ZS6qetMBTOtw4UL
	 9avQGMG35wKclM34S2LK+YX86Wqw07SE1YJp95eXHsOuq75HZatUlF+9lElX5oEPzM
	 ll9Q/xIg+wx2+3Fk7N5zO03sT/D0ws0naqyXinxDVz6+IxEoM2QT+9BMd30BSdyCpD
	 Us+c3wHkr/4tHMAzzKnwV0Kt9d6uoc19ORrVXfsl0nltbSvLUvvDjTRIfzmbDMkiyR
	 PrHGcC77U9wQA==
Date: Thu, 22 Jan 2026 13:21:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 01/11] fs,fsverity: reject size changes on fsverity files
 in setattr_prepare
Message-ID: <20260122212121.GA5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122082214.452153-2-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75153-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D82B6DAFB
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:21:57AM +0100, Christoph Hellwig wrote:
> Add the check to reject truncates of fsverity files directly to
> setattr_prepare instead of requiring the file system to handle it.
> Besides removing boilerplate code, this also fixes the complete lack of
> such check in btrfs.
> 
> Fixes: 146054090b08 ("btrfs: initial fsverity support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Seems reasonable to me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/attr.c                | 12 +++++++++++-
>  fs/ext4/inode.c          |  4 ----
>  fs/f2fs/file.c           |  4 ----
>  fs/verity/open.c         |  8 --------
>  include/linux/fsverity.h | 25 -------------------------
>  5 files changed, 11 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index b9ec6b47bab2..e7d7c6d19fe9 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -169,7 +169,17 @@ int setattr_prepare(struct mnt_idmap *idmap, struct dentry *dentry,
>  	 * ATTR_FORCE.
>  	 */
>  	if (ia_valid & ATTR_SIZE) {
> -		int error = inode_newsize_ok(inode, attr->ia_size);
> +		int error;
> +
> +		/*
> +		 * Verity files are immutable, so deny truncates.  This isn't
> +		 * covered by the open-time check because sys_truncate() takes a
> +		 * path, not an open file.
> +		 */
> +		if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
> +			return -EPERM;
> +
> +		error = inode_newsize_ok(inode, attr->ia_size);
>  		if (error)
>  			return error;
>  	}
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 0c466ccbed69..8c2ef98fa530 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5835,10 +5835,6 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (error)
>  		return error;
>  
> -	error = fsverity_prepare_setattr(dentry, attr);
> -	if (error)
> -		return error;
> -
>  	if (is_quota_modification(idmap, inode, attr)) {
>  		error = dquot_initialize(inode);
>  		if (error)
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index d7047ca6b98d..da029fed4e5a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1074,10 +1074,6 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	if (err)
>  		return err;
>  
> -	err = fsverity_prepare_setattr(dentry, attr);
> -	if (err)
> -		return err;
> -
>  	if (unlikely(IS_IMMUTABLE(inode)))
>  		return -EPERM;
>  
> diff --git a/fs/verity/open.c b/fs/verity/open.c
> index 77b1c977af02..2aa5eae5a540 100644
> --- a/fs/verity/open.c
> +++ b/fs/verity/open.c
> @@ -384,14 +384,6 @@ int __fsverity_file_open(struct inode *inode, struct file *filp)
>  }
>  EXPORT_SYMBOL_GPL(__fsverity_file_open);
>  
> -int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr)
> -{
> -	if (attr->ia_valid & ATTR_SIZE)
> -		return -EPERM;
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(__fsverity_prepare_setattr);
> -
>  void __fsverity_cleanup_inode(struct inode *inode)
>  {
>  	struct fsverity_info **vi_addr = fsverity_info_addr(inode);
> diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> index 5bc7280425a7..86fb1708676b 100644
> --- a/include/linux/fsverity.h
> +++ b/include/linux/fsverity.h
> @@ -179,7 +179,6 @@ int fsverity_get_digest(struct inode *inode,
>  /* open.c */
>  
>  int __fsverity_file_open(struct inode *inode, struct file *filp);
> -int __fsverity_prepare_setattr(struct dentry *dentry, struct iattr *attr);
>  void __fsverity_cleanup_inode(struct inode *inode);
>  
>  /**
> @@ -251,12 +250,6 @@ static inline int __fsverity_file_open(struct inode *inode, struct file *filp)
>  	return -EOPNOTSUPP;
>  }
>  
> -static inline int __fsverity_prepare_setattr(struct dentry *dentry,
> -					     struct iattr *attr)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
>  static inline void fsverity_cleanup_inode(struct inode *inode)
>  {
>  }
> @@ -338,22 +331,4 @@ static inline int fsverity_file_open(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> -/**
> - * fsverity_prepare_setattr() - prepare to change a verity inode's attributes
> - * @dentry: dentry through which the inode is being changed
> - * @attr: attributes to change
> - *
> - * Verity files are immutable, so deny truncates.  This isn't covered by the
> - * open-time check because sys_truncate() takes a path, not a file descriptor.
> - *
> - * Return: 0 on success, -errno on failure
> - */
> -static inline int fsverity_prepare_setattr(struct dentry *dentry,
> -					   struct iattr *attr)
> -{
> -	if (IS_VERITY(d_inode(dentry)))
> -		return __fsverity_prepare_setattr(dentry, attr);
> -	return 0;
> -}
> -
>  #endif	/* _LINUX_FSVERITY_H */
> -- 
> 2.47.3
> 
> 

