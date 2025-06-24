Return-Path: <linux-fsdevel+bounces-52729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB130AE60A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43313BEF44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24D127A92D;
	Tue, 24 Jun 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBdUgQsq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cXyjYEPt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBdUgQsq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cXyjYEPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFEE23C50A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756810; cv=none; b=XRwMETtEAsJxlUCEkz8lz8ntx5F4Rm+gDAhmesOgerCMpwZCxyNG+zYnzLzD/r3iFDfZ3GrHfT1H6v22yLasobONs2+WJM2rlSMa+nI+3jVTwdkhRGARG0OkNU1LjPFtaj62R/Wj6bMBC1RqRjHhJwzOgDW+oTy/EGProaNGMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756810; c=relaxed/simple;
	bh=rVDxbozIqTNFmHHNz1JJZ1hfA/ybvXnOS6w8xwJonic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsDfaf2OcEAib8LN99Wr+lazPgDRMKeF+1GhkbqIyiMfpV+AitO06e99LW5HKf+9t71+ATvyuZqOg+iBvOZILlAtIuVy7Wl6YhKM8UuChC8erMaIddpmnRw2MJO9VImYdSNv523paYuDG1T9RChcxrj18zae8o2E3tAabwnuKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iBdUgQsq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cXyjYEPt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iBdUgQsq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cXyjYEPt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43E2021186;
	Tue, 24 Jun 2025 09:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSzTqK3FatUj/jihYv+xxXyP9yqFPgFLMMfIeoA7huE=;
	b=iBdUgQsqGJ2Q+UkT1wNtnlxCxqNvmCETvFks2xNfMK44YPTB9fIOa5i9bd1WwT5iqTqPgW
	klHpu8U+BF2FGgALRo53Po7e2vLIevGldwxuYTwAYsDNss9Y65fwnWglJDiiZUOs8LOw/9
	mEPEquOfqiR2Md9YHscGmfYlPn+3sag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSzTqK3FatUj/jihYv+xxXyP9yqFPgFLMMfIeoA7huE=;
	b=cXyjYEPt8QzdPgo/B+Pg64I9MTiVHv8EbMNqItNRxiE9+H8k+oRlxhdJnvqp4tjs86S1EH
	lVnwvsa+P+zK90Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iBdUgQsq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cXyjYEPt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSzTqK3FatUj/jihYv+xxXyP9yqFPgFLMMfIeoA7huE=;
	b=iBdUgQsqGJ2Q+UkT1wNtnlxCxqNvmCETvFks2xNfMK44YPTB9fIOa5i9bd1WwT5iqTqPgW
	klHpu8U+BF2FGgALRo53Po7e2vLIevGldwxuYTwAYsDNss9Y65fwnWglJDiiZUOs8LOw/9
	mEPEquOfqiR2Md9YHscGmfYlPn+3sag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSzTqK3FatUj/jihYv+xxXyP9yqFPgFLMMfIeoA7huE=;
	b=cXyjYEPt8QzdPgo/B+Pg64I9MTiVHv8EbMNqItNRxiE9+H8k+oRlxhdJnvqp4tjs86S1EH
	lVnwvsa+P+zK90Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 375F013751;
	Tue, 24 Jun 2025 09:20:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y9WfDcdtWmjcGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:20:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E93BFA0A03; Tue, 24 Jun 2025 11:20:02 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:20:02 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 09/11] fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
Message-ID: <2j6ytfedk2bgyuegajumnxtyuqalb7wd52h7jnxtozpvf5fpmz@z4ysz7mhcajq>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-9-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-9-d02a04858fe3@kernel.org>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 43E2021186
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 24-06-25 10:29:12, Christian Brauner wrote:
> Allow a filesystem to indicate that it supports encoding autonomous file
> handles that can be decoded without having to pass a filesystem for the
> filesystem.

Forgot to mention the above phrase "to pass a filesystem for the
filesystem" doesn't make sense :) But my reviewed-by holds.

								Honza

> In other words, the file handle uniquely identifies the > filesystem.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/fhandle.c             | 7 ++++++-
>  include/linux/exportfs.h | 4 +++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fhandle.c b/fs/fhandle.c
> index 22edced83e4c..ab4891925b52 100644
> --- a/fs/fhandle.c
> +++ b/fs/fhandle.c
> @@ -23,12 +23,13 @@ static long do_sys_name_to_handle(const struct path *path,
>  	struct file_handle f_handle;
>  	int handle_dwords, handle_bytes;
>  	struct file_handle *handle = NULL;
> +	const struct export_operations *eops = path->dentry->d_sb->s_export_op;
>  
>  	/*
>  	 * We need to make sure whether the file system support decoding of
>  	 * the file handle if decodeable file handle was requested.
>  	 */
> -	if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_flags))
> +	if (!exportfs_can_encode_fh(eops, fh_flags))
>  		return -EOPNOTSUPP;
>  
>  	/*
> @@ -90,6 +91,10 @@ static long do_sys_name_to_handle(const struct path *path,
>  			if (d_is_dir(path->dentry))
>  				handle->handle_type |= FILEID_IS_DIR;
>  		}
> +
> +		/* Filesystems supports autonomous file handles. */
> +		if (eops->flags & EXPORT_OP_AUTONOMOUS_HANDLES)
> +			handle->handle_type |= FILEID_IS_AUTONOMOUS;
>  		retval = 0;
>  	}
>  	/* copy the mount id */
> diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> index 5bb757b51f5c..f7f9038b285e 100644
> --- a/include/linux/exportfs.h
> +++ b/include/linux/exportfs.h
> @@ -188,7 +188,8 @@ struct handle_to_path_ctx {
>  /* Flags supported in encoded handle_type that is exported to user */
>  #define FILEID_IS_CONNECTABLE	0x10000
>  #define FILEID_IS_DIR		0x20000
> -#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
> +#define FILEID_IS_AUTONOMOUS	0x40000
> +#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR | FILEID_IS_AUTONOMOUS)
>  
>  /**
>   * struct export_operations - for nfsd to communicate with file systems
> @@ -285,6 +286,7 @@ struct export_operations {
>  						*/
>  #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
>  #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
> +#define EXPORT_OP_AUTONOMOUS_HANDLES	(0x80) /* filesystem supports autonomous file handles */
>  	unsigned long	flags;
>  };
>  
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

