Return-Path: <linux-fsdevel+bounces-31888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E799CB95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 15:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794441C21FE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 13:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5661A76C6;
	Mon, 14 Oct 2024 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AkZA5JrL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6bIqgcA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HuC4ts3d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dd+aoLJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E619CCFA;
	Mon, 14 Oct 2024 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912648; cv=none; b=RZ6h+WdyoVJG7YvlabcLaxvc5cnOXaLkDGlMXrteiYAEntlyOTWW6qORKkTKcUH+IUcXuXxHFpSHix8hodjI7NqCOAF9nUFJN2mHQ76Z+7qNzJHvD8CIjQnSWQCZbstJg9TCLh47rP4aDDTTF+dO71Xbiz/20Gd/No0Tzq4D9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912648; c=relaxed/simple;
	bh=r5A234qwQWPwcqsYi1jgGoXNx091qhoDlVXzZGi7Dhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1OltQmddfAspgzq1lZQ3Q7qjsKZ0YSyAVVPq2EBtWkZ/M7Q1jsURANw3HrNBDNUOH9ixLU59vL7BsJ7sO/n5ynKU2iHnT5LWuU5DE86p2sjXeDtiCn6z57lm6CNSiyx2HXso7hp9KhNd2gjl/W0TkPDqGdRfXJ9Y2elDVwdg/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AkZA5JrL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v6bIqgcA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HuC4ts3d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dd+aoLJP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 718AD1FE53;
	Mon, 14 Oct 2024 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728912644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=235JuUpvspvGYow+ON4E4Do0RYXuLHAk110/di76hcM=;
	b=AkZA5JrLM+TUDUxoF6BfJ1zsSSFQzX51TcPsWrXXH+ZZUNwcqLxkSKAkAfhTpRTj+ZQXpt
	b5Y6Z7TqdLGwYnwQ9KTleVT8hOnPuUzQXzq8fGSIOKYlJvoa0iVvSEJslF9c/9gaGA+GSM
	DXuFB+6+0ZDWUagzudILk1GZyzyvbwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728912644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=235JuUpvspvGYow+ON4E4Do0RYXuLHAk110/di76hcM=;
	b=v6bIqgcADWr6s0yC6RdYIywFMusbeMvXAmymzghzHS36Ey/xCdRj2YWMnQUZvwRfeUDiqQ
	4Svli02NR4VIEqAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728912643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=235JuUpvspvGYow+ON4E4Do0RYXuLHAk110/di76hcM=;
	b=HuC4ts3drYC6MZq9yDleJR72QppBjLzLqIbLVnHVKP//+uHrlncXhc4t/EWC2iJGnwqB3C
	hBcsAfO6kGMSSR0p/JLW4pZXNdvePeaCuduPim0KEgPpZCFZOIEuTaN+Sr4EQb8CqVD0rk
	PT41K+umufUkvRtyXAziJ5qsBT08Brw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728912643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=235JuUpvspvGYow+ON4E4Do0RYXuLHAk110/di76hcM=;
	b=Dd+aoLJPrN4V2yCU4lUyTX5au+zBGFOY5FKo5qG1OM9MTFJRoCFZuOX0MF1mp2BzENSvvs
	JJm7lFLZIEjfWlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66EFC13A51;
	Mon, 14 Oct 2024 13:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y80ZGQMdDWeaVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Oct 2024 13:30:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 10A3BA0896; Mon, 14 Oct 2024 15:30:43 +0200 (CEST)
Date: Mon, 14 Oct 2024 15:30:43 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/3] fs: prepare for "explicit connectable" file
 handles
Message-ID: <20241014133043.sucfbpsx4gnjvacb@quack3>
References: <20241011090023.655623-1-amir73il@gmail.com>
 <20241011090023.655623-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011090023.655623-2-amir73il@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 11-10-24 11:00:21, Amir Goldstein wrote:
> We would like to use the high 16bit of the handle_type field to encode
> file handle traits, such as "connectable".
> 
> In preparation for this change, make sure that filesystems do not return
> a handle_type value with upper bits set and that the open_by_handle_at(2)
> syscall rejects these handle types.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/exportfs/expfs.c      | 17 +++++++++++++++--
>  fs/fhandle.c             |  7 +++++++
>  include/linux/exportfs.h | 11 +++++++++++
>  3 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
> index 4f2dd4ab4486..0c899cfba578 100644
> --- a/fs/exportfs/expfs.c
> +++ b/fs/exportfs/expfs.c
> @@ -382,14 +382,24 @@ int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
>  			     int *max_len, struct inode *parent, int flags)
>  {
>  	const struct export_operations *nop = inode->i_sb->s_export_op;
> +	enum fid_type type;
>  
>  	if (!exportfs_can_encode_fh(nop, flags))
>  		return -EOPNOTSUPP;
>  
>  	if (!nop && (flags & EXPORT_FH_FID))
> -		return exportfs_encode_ino64_fid(inode, fid, max_len);
> +		type = exportfs_encode_ino64_fid(inode, fid, max_len);
> +	else
> +		type = nop->encode_fh(inode, fid->raw, max_len, parent);
> +
> +	if (type > 0 && FILEID_USER_FLAGS(type)) {
> +		pr_warn_once("%s: unexpected fh type value 0x%x from fstype %s.\n",
> +			     __func__, type, inode->i_sb->s_type->name);
> +		return -EINVAL;
> +	}
> +
> +	return type;
>  
> -	return nop->encode_fh(inode, fid->raw, max_len, parent);
>  }
>  EXPORT_SYMBOL_GPL(exportfs_encode_inode_fh);
>  
> @@ -436,6 +446,9 @@ exportfs_decode_fh_raw(struct vfsmount *mnt, struct fid *fid, int fh_len,
>  	char nbuf[NAME_MAX+1];
>  	int err;
>  
> +	if (fileid_type < 0 || FILEID_USER_FLAGS(fileid_type))
> +		return ERR_PTR(-EINVAL);
> +
>  	/*
>  	 * Try to get any dentry for the given file handle from the filesystem.
>  	 */
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 82df28d45cd7..218511f38cbb 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -307,6 +307,11 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  		retval = -EINVAL;
>  		goto out_path;
>  	}
> +	if (f_handle.handle_type < 0 ||
> +	    FILEID_USER_FLAGS(f_handle.handle_type) & ~FILEID_VALID_USER_FLAGS) {
> +		retval = -EINVAL;
> +		goto out_path;
> +	}
>  	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
>  			 GFP_KERNEL);
>  	if (!handle) {
> @@ -322,6 +327,8 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  		goto out_handle;
>  	}
>  
> +	/* Filesystem code should not be exposed to user flags */
> +	handle->handle_type &= ~FILEID_USER_FLAGS_MASK;
>  	retval = do_handle_to_path(handle, path, &ctx);
>  
>  out_handle:
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 893a1d21dc1c..5e14d4500a75 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -160,6 +160,17 @@ struct fid {
>  #define EXPORT_FH_FID		0x2 /* File handle may be non-decodeable */
>  #define EXPORT_FH_DIR_ONLY	0x4 /* Only decode file handle for a directory */
>  
> +/*
> + * Filesystems use only lower 8 bits of file_handle type for fid_type.
> + * name_to_handle_at() uses upper 16 bits of type as user flags to be
> + * interpreted by open_by_handle_at().
> + */
> +#define FILEID_USER_FLAGS_MASK	0xffff0000
> +#define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
> +
> +/* Flags supported in encoded handle_type that is exported to user */
> +#define FILEID_VALID_USER_FLAGS	(0)
> +
>  /**
>   * struct export_operations - for nfsd to communicate with file systems
>   * @encode_fh:      encode a file handle fragment from a dentry
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

