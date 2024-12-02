Return-Path: <linux-fsdevel+bounces-36274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C8B9E0A0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 18:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A39C5B3FC57
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0314E2D6;
	Mon,  2 Dec 2024 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="klX0RUIL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LT/9Xq3a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l/IfRkul";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1iJVhVZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C695A13B2A8;
	Mon,  2 Dec 2024 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733155496; cv=none; b=nB9vkxRkrK5sVMb/7dKRvwW6JWoVyTlN/thkLdomoYABQZ1FtcbmNhW6Q7mSBw4uMgjNVd5Pa+oQ6WWi9xoFwLhA6kVE8T0ezvE5FBXFKYs/TfrUn/FQdCGvUlGvABRn3n5eycw818RMS3NSfmh5wQT+EDLF9BHhL3LLCvB7As0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733155496; c=relaxed/simple;
	bh=AR9KEkE1xh7ZA2zijHUe0OkEthUtUah8mVlfXQUJjIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=db6riXdF1OUBtRicLK7rUW6XmlGNsG4Mj21Xt/9iCNufHsY0CSXeXn58EwGf9kTCMOjWfKQRCnxOgTRbg84nt57tb+wAvL42q85k87nkygJGCvs0vaQWIJLx99+JCqC9vA4CMn2/Ev+j5ExSlualgPRretL4prq1I0Zh+l5yWiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=klX0RUIL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LT/9Xq3a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l/IfRkul; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1iJVhVZ6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D58E621163;
	Mon,  2 Dec 2024 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yCg1W88d14OR9ELkh+3l+fvNAOmqICCUKeYMeu/VbY=;
	b=klX0RUILTO7fpJSOLcHY2f8qOaHnDLHjlwjr3nEMvN2IUWuC1zqsqpeM4EPn71FJ9g+506
	udIg5zvi3f0GIFcSdJe1phV3ifYgf9XMNPfcjI2P9EwBcBdL6wbxfLoroHoXcH5K/hkYIn
	PjiebdtR4zmTU7c+7na/eywZs8lVT8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yCg1W88d14OR9ELkh+3l+fvNAOmqICCUKeYMeu/VbY=;
	b=LT/9Xq3aMlEjm9PZ1HsLKuvc6fnxNNqtv6ulCzSAzxn/Fi52bsf2J1XagcdKMaUZBZvD4N
	yXNp+IzrCKpI/LDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733155492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yCg1W88d14OR9ELkh+3l+fvNAOmqICCUKeYMeu/VbY=;
	b=l/IfRkul1aRIbTx6QY4N83XABty1/MF8llm3eUa/gWiwvEkKSw/MkW71NE8U91DSGC65kX
	Er+K0Jw4Q5nw2Fc5pw+FoMzuKHOvIDSp/DDw6jD8aKCklN6HnDk9Go0E1O+RJ0R8K/8AYx
	d5JSJ9T3vSdXsipOiEsNhG3z7Tyw8ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733155492;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3yCg1W88d14OR9ELkh+3l+fvNAOmqICCUKeYMeu/VbY=;
	b=1iJVhVZ6FMkDtw5Xii7TUZtunEPOOZ5YcH8IZvSA1pppc50Lmnlbcs+bwJCD0dwtm6KiyF
	maSsaF6RocHugoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2ACF13A31;
	Mon,  2 Dec 2024 16:04:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T/yBL6TaTWfjPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Dec 2024 16:04:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5EFF6A07B4; Mon,  2 Dec 2024 17:04:52 +0100 (CET)
Date: Mon, 2 Dec 2024 17:04:52 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Erin Shepherd <erin.shepherd@e43.eu>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 5/6] exportfs: add permission method
Message-ID: <20241202160452.2pg3qe4jymugp3su@quack3>
References: <20241129-work-pidfs-file_handle-v1-0-87d803a42495@kernel.org>
 <20241129-work-pidfs-file_handle-v1-5-87d803a42495@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241129-work-pidfs-file_handle-v1-5-87d803a42495@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[e43.eu,gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Fri 29-11-24 14:38:04, Christian Brauner wrote:
> This allows filesystems such as pidfs to provide their custom permission
> checks.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fhandle.c             | 21 +++++++--------------
>  include/linux/exportfs.h | 17 ++++++++++++++++-
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 031ad5592a0beabcc299436f037ad5fe626332e6..23491094032ec037066a271873ea8ff794616bee 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -187,17 +187,6 @@ static int get_path_from_fd(int fd, struct path *root)
>  	return 0;
>  }
>  
> -enum handle_to_path_flags {
> -	HANDLE_CHECK_PERMS   = (1 << 0),
> -	HANDLE_CHECK_SUBTREE = (1 << 1),
> -};
> -
> -struct handle_to_path_ctx {
> -	struct path root;
> -	enum handle_to_path_flags flags;
> -	unsigned int fh_flags;
> -};
> -
>  static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
>  {
>  	struct handle_to_path_ctx *ctx = context;
> @@ -335,15 +324,19 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
>  	struct file_handle f_handle;
>  	struct file_handle *handle = NULL;
>  	struct handle_to_path_ctx ctx = {};
> +	const struct export_operations *eops;
>  
>  	retval = get_path_from_fd(mountdirfd, &ctx.root);
>  	if (retval)
>  		goto out_err;
>  
> -	if (!may_decode_fh(&ctx, o_flags)) {
> -		retval = -EPERM;
> +	eops = ctx.root.mnt->mnt_sb->s_export_op;
> +	if (eops && eops->permission)
> +		retval = eops->permission(&ctx, o_flags);
> +	else
> +		retval = may_decode_fh(&ctx, o_flags);
> +	if (retval)
>  		goto out_path;
> -	}
>  
>  	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle))) {
>  		retval = -EFAULT;
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index c69b79b64466d5bc32ffe9b2796a388130fe72d8..a087606ace194ccc9d1250f990ce55627aaf8dc5 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -3,6 +3,7 @@
>  #define LINUX_EXPORTFS_H 1
>  
>  #include <linux/types.h>
> +#include <linux/path.h>
>  
>  struct dentry;
>  struct iattr;
> @@ -10,7 +11,6 @@ struct inode;
>  struct iomap;
>  struct super_block;
>  struct vfsmount;
> -struct path;
>  
>  /* limit the handle size to NFSv4 handle size now */
>  #define MAX_HANDLE_SZ 128
> @@ -157,6 +157,17 @@ struct fid {
>  	};
>  };
>  
> +enum handle_to_path_flags {
> +	HANDLE_CHECK_PERMS   = (1 << 0),
> +	HANDLE_CHECK_SUBTREE = (1 << 1),
> +};
> +
> +struct handle_to_path_ctx {
> +	struct path root;
> +	enum handle_to_path_flags flags;
> +	unsigned int fh_flags;
> +};
> +
>  #define EXPORT_FH_CONNECTABLE	0x1 /* Encode file handle with parent */
>  #define EXPORT_FH_FID		0x2 /* File handle may be non-decodeable */
>  #define EXPORT_FH_DIR_ONLY	0x4 /* Only decode file handle for a directory */
> @@ -226,6 +237,9 @@ struct fid {
>   *    is also a directory.  In the event that it cannot be found, or storage
>   *    space cannot be allocated, a %ERR_PTR should be returned.
>   *
> + * permission:
> + *    Allow filesystems to specify a custom permission function.
> + *
>   * open:
>   *    Allow filesystems to specify a custom open function.
>   *
> @@ -255,6 +269,7 @@ struct export_operations {
>  			  bool write, u32 *device_generation);
>  	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
>  			     int nr_iomaps, struct iattr *iattr);
> +	int (*permission)(struct handle_to_path_ctx *ctx, unsigned int oflags);
>  	struct file * (*open)(struct path *path, unsigned int oflags);
>  #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
>  #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

