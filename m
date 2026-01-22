Return-Path: <linux-fsdevel+bounces-74998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAazMHLscWl6ZAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:22:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5764763
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0843060506D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1FE355042;
	Thu, 22 Jan 2026 09:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mNxR9NTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOMJteb0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mNxR9NTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vOMJteb0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125562877ED
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 09:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073124; cv=none; b=QH+pO5PLSZypxDX4WO+LPI45j1xoXY6EXeJpZnBJr4DDKbt/aGvdT9w2YJbyQ+SdGJfkHgZDcHdonkECzsprf6OJgU4oFyxSfR4YL7u/9pRUAelFOj1yI4POt2WW+FmjXlQ4r7ETLX0Pv+2xYQpsHFA2Yuc8YggMIrn0YwrNczk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073124; c=relaxed/simple;
	bh=EO7+RRuqqA+m4/ivcE5Mu4B+/PgpBnLgvIHDtNz+/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0qMrcDGuQR3CRX/jsPbKMdfjbbs8c7mXhjA4rpc3bwe/jRAXciuGgWeATJoA7hyh44TcVtSkyu65oXxr5DPi8b8Fp4s7pYEOk5H20t4YWYSFloKvaRLA3DvwgXiAUzczhQ3XbjMqCmPzNzhVku+yhBqfMsqagXvg+v+MDbbUP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mNxR9NTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOMJteb0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mNxR9NTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vOMJteb0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3ECE4336AE;
	Thu, 22 Jan 2026 09:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769073121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXIUvLZQSYyui9YEvQR72Ui+TDRCWzjQqAG1YFLyf8o=;
	b=mNxR9NTf4MNm4dbAgIYUxYrzGGFH07I6d7bJNS2ndYMO2mG3AAYP2WfBpgj0jNE0qZxUV8
	ORK4xJnPFNBW7ZQ/Ykp8QFhXnOB8B4LIrJ7w/lICoOLas5V7m9d3SyCEtHBmys0vZMqC3X
	/QViu+bOEuVk14QwPwYZi0/eAHpPE9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769073121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXIUvLZQSYyui9YEvQR72Ui+TDRCWzjQqAG1YFLyf8o=;
	b=vOMJteb0HVbBiAPvqH72sm3kumUeHhvPK43vzi5uy4BSaKzjVlkwALpmjtMhFTduHHDD8j
	1addyf5fC1z5z/BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mNxR9NTf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vOMJteb0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769073121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXIUvLZQSYyui9YEvQR72Ui+TDRCWzjQqAG1YFLyf8o=;
	b=mNxR9NTf4MNm4dbAgIYUxYrzGGFH07I6d7bJNS2ndYMO2mG3AAYP2WfBpgj0jNE0qZxUV8
	ORK4xJnPFNBW7ZQ/Ykp8QFhXnOB8B4LIrJ7w/lICoOLas5V7m9d3SyCEtHBmys0vZMqC3X
	/QViu+bOEuVk14QwPwYZi0/eAHpPE9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769073121;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qXIUvLZQSYyui9YEvQR72Ui+TDRCWzjQqAG1YFLyf8o=;
	b=vOMJteb0HVbBiAPvqH72sm3kumUeHhvPK43vzi5uy4BSaKzjVlkwALpmjtMhFTduHHDD8j
	1addyf5fC1z5z/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D005136B7;
	Thu, 22 Jan 2026 09:12:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qpkUB+HpcWlkHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Jan 2026 09:12:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BF523A082E; Thu, 22 Jan 2026 10:12:00 +0100 (CET)
Date: Thu, 22 Jan 2026 10:12:00 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Sterba <dsterba@suse.com>, 
	Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 01/11] fs,fsverity: reject size changes on fsverity files
 in setattr_prepare
Message-ID: <psd53y2tpgmbsgry7zc6ocfujwziicvgyobbrnlzfproeqfmci@ephcwktsfanm>
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
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,suse.com:email,suse.cz:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-74998-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 67D5764763
X-Rspamd-Action: no action

On Thu 22-01-26 09:21:57, Christoph Hellwig wrote:
> Add the check to reject truncates of fsverity files directly to
> setattr_prepare instead of requiring the file system to handle it.
> Besides removing boilerplate code, this also fixes the complete lack of
> such check in btrfs.
> 
> Fixes: 146054090b08 ("btrfs: initial fsverity support")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

