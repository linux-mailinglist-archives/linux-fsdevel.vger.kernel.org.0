Return-Path: <linux-fsdevel+bounces-52728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42970AE60A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B7A4C212A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE227AC32;
	Tue, 24 Jun 2025 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0479VYdQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IgaIfUWL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0479VYdQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IgaIfUWL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C908023C50A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756697; cv=none; b=dwAnsc0BFNI3MRkEDvDdL6p16eDpEjRtTq/K6ww6oPD+nMwMy07MT2sDDFrtbNy9TF6TWRBvXRkecGMmpblNr7Rh0+R90iW0Qcm9UQGz8ayet5PerSaMTz7f5q7DKxFk8Q1kj3lbmaeRI/wHHzQgAeR7bpV/mroaA1o/16ffh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756697; c=relaxed/simple;
	bh=ZqCR0DszAk+ZhPwZmwWrWDvapVJRjxHYi9oAw1Kyz4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtegDBc07r4AkpZ7dqh/sJroKnLmwckxwCF9gn48JKAsEGVJwfZLm5kCfYlVMFSVOzMbZJjWqlDDZ06v+r/OkMRK17bgU8E5KNJLr/r3hsD7to86SZzOrXQdSLmDeel9Nd3LZt53wDkeAuSGnA+Pie65FrKA6l5IPfO0n0tpKZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0479VYdQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IgaIfUWL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0479VYdQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IgaIfUWL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A65C1F391;
	Tue, 24 Jun 2025 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEmi19U0X0uZmADXA3x4g6K1tidgzMF0wRTbVK/LX+0=;
	b=0479VYdQeFbxbkzmuy9t1GtBdBgsnPhRxVyK7HhhtbuKMHLPp2y11llD4gma6W2CDAjAGb
	MoQk09z9cq6qwUO85olymeSqRsTaTMRr5rrce4jtqsU9MTnDeG1O+Nd3iWk+at2yPXJf/n
	teAMnG8/U8dxV+/tlNNIW1c9xjwbTio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEmi19U0X0uZmADXA3x4g6K1tidgzMF0wRTbVK/LX+0=;
	b=IgaIfUWLpY8zZpg8/03B5sTYjTtqUyGJbyFNAZ4uhDJouOP1+Yszu2hJ9Xk1O25yE9KXeE
	mb1OoMJI6Eljy1Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750756693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEmi19U0X0uZmADXA3x4g6K1tidgzMF0wRTbVK/LX+0=;
	b=0479VYdQeFbxbkzmuy9t1GtBdBgsnPhRxVyK7HhhtbuKMHLPp2y11llD4gma6W2CDAjAGb
	MoQk09z9cq6qwUO85olymeSqRsTaTMRr5rrce4jtqsU9MTnDeG1O+Nd3iWk+at2yPXJf/n
	teAMnG8/U8dxV+/tlNNIW1c9xjwbTio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750756693;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MEmi19U0X0uZmADXA3x4g6K1tidgzMF0wRTbVK/LX+0=;
	b=IgaIfUWLpY8zZpg8/03B5sTYjTtqUyGJbyFNAZ4uhDJouOP1+Yszu2hJ9Xk1O25yE9KXeE
	mb1OoMJI6Eljy1Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 001D513751;
	Tue, 24 Jun 2025 09:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XC8GAFVtWmhJGgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:18:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2FC4A0A03; Tue, 24 Jun 2025 11:18:12 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:18:12 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 09/11] fhandle: add EXPORT_OP_AUTONOMOUS_HANDLES marker
Message-ID: <ozauj3mds7zvjfmziwqqosyooipo3me4o73555jq5455p7daw2@f6mdcwh4tun4>
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
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 

On Tue 24-06-25 10:29:12, Christian Brauner wrote:
> Allow a filesystem to indicate that it supports encoding autonomous file
> handles that can be decoded without having to pass a filesystem for the
> filesystem. In other words, the file handle uniquely identifies the
> filesystem.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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

