Return-Path: <linux-fsdevel+bounces-62777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24345BA078A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3456B4E3F78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC78305940;
	Thu, 25 Sep 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uRNcFJA0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1YrAcFz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uRNcFJA0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v1YrAcFz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23116304BCE
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758815581; cv=none; b=C91+BbrCuZNeqs7xhGUwCXuQKhDGX2Ip6aHYuSmiR8Rn2vEmcI5FWJsvz8nKw/uX1+p/Pl/JE+88G+lXRlPyOIYwXCEqSqnCfR4vYbjktSSqtaqh+Z47VyjwaHanEsOkT7zHAF3vkdSmffs36/LzBHfc2KorKr+Rqr53Ibj2tvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758815581; c=relaxed/simple;
	bh=qSPPe2xjhNN4gLuJiQJN1K+D4x0yOkPla9SJfJ3AGGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFtm2k0t9nnwY6qDUSyEUh+2K9fHMMxkQ55GElxz9PJqdnbJGt51o6ll6oTjXaXiQSQHCni4WC0VlzMNDNx3tzQw6uHeRzYD6c+y6y0Ycl/gBsxN0mio2DjberTAjcworES7IHilm496fwKf3Cb+n+XsunP/BC7FuABlsaMTk74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uRNcFJA0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v1YrAcFz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uRNcFJA0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v1YrAcFz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 023893EAF3;
	Thu, 25 Sep 2025 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758815576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDopZZ0RgseBNFHbhRFaoUMb/T2KLph+cR80nM05oOw=;
	b=uRNcFJA0E1P4zX1bBuWvkrBlwKl6R3+5YEDg7RV2vnIaKZhXTyQmD+uDoZkIFfpR/ezAuh
	vDWv2RzX/EJ0O/d3k+WSxaZ+ldBs5n2DRdZ8a2OTjkkAjFpoiBeDgrnfkjpsNYjHlZu6su
	1qZgJ69vacnZwS3Pmhuo/QACiN1ZiOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758815576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDopZZ0RgseBNFHbhRFaoUMb/T2KLph+cR80nM05oOw=;
	b=v1YrAcFz9KiXost75HrGA8+EQiArgz8lklUTmim69amE6ALvMmmoaHZVDDhxRj2i0pQ2fC
	H6g4AedCvRNOzBBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758815576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDopZZ0RgseBNFHbhRFaoUMb/T2KLph+cR80nM05oOw=;
	b=uRNcFJA0E1P4zX1bBuWvkrBlwKl6R3+5YEDg7RV2vnIaKZhXTyQmD+uDoZkIFfpR/ezAuh
	vDWv2RzX/EJ0O/d3k+WSxaZ+ldBs5n2DRdZ8a2OTjkkAjFpoiBeDgrnfkjpsNYjHlZu6su
	1qZgJ69vacnZwS3Pmhuo/QACiN1ZiOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758815576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WDopZZ0RgseBNFHbhRFaoUMb/T2KLph+cR80nM05oOw=;
	b=v1YrAcFz9KiXost75HrGA8+EQiArgz8lklUTmim69amE6ALvMmmoaHZVDDhxRj2i0pQ2fC
	H6g4AedCvRNOzBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DADD213869;
	Thu, 25 Sep 2025 15:52:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2k5wNVdl1WgAXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Sep 2025 15:52:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 912DDA0AA0; Thu, 25 Sep 2025 17:52:55 +0200 (CEST)
Date: Thu, 25 Sep 2025 17:52:55 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Jonathan Corbet <corbet@lwn.net>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Paulo Alcantara <pc@manguebit.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Carlos Maiolino <cem@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Rick Macklem <rick.macklem@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
	netfs@lists.linux.dev, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/38] vfs: add try_break_deleg calls for parents to
 vfs_{link,rename,unlink}
Message-ID: <cx5cpyg2q2ro3hpn55z673bk44tm5syftxso2hawe4ioe7jv2s@itiemyvjhgtc>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
 <20250924-dir-deleg-v3-3-9f3af8bc5c40@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924-dir-deleg-v3-3-9f3af8bc5c40@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RL63fqwwx8ot6gmekemcs76f9d)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,samba.org,microsoft.com,talpey.com,brown.name,redhat.com,lwn.net,szeredi.hu,manguebit.org,linuxfoundation.org,tyhicks.com,chromium.org,goodmis.org,efficios.com,vger.kernel.org,lists.samba.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Wed 24-09-25 14:05:49, Jeff Layton wrote:
> In order to add directory delegation support, we need to break
> delegations on the parent whenever there is going to be a change in the
> directory.
> 
> vfs_link, vfs_unlink, and vfs_rename all have existing delegation break
> handling for the children in the rename. Add the necessary calls for
> breaking delegations in the parent(s) as well.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index cd43ff89fbaa38206db2aec4f097ca119819f92e..cd517eb232317d326e6d2fc5a60cb4c7569a137d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4580,6 +4580,9 @@ int vfs_unlink(struct mnt_idmap *idmap, struct inode *dir,
>  	else {
>  		error = security_inode_unlink(dir, dentry);
>  		if (!error) {
> +			error = try_break_deleg(dir, delegated_inode);
> +			if (error)
> +				goto out;
>  			error = try_break_deleg(target, delegated_inode);
>  			if (error)
>  				goto out;
> @@ -4849,7 +4852,9 @@ int vfs_link(struct dentry *old_dentry, struct mnt_idmap *idmap,
>  	else if (max_links && inode->i_nlink >= max_links)
>  		error = -EMLINK;
>  	else {
> -		error = try_break_deleg(inode, delegated_inode);
> +		error = try_break_deleg(dir, delegated_inode);
> +		if (!error)
> +			error = try_break_deleg(inode, delegated_inode);
>  		if (!error)
>  			error = dir->i_op->link(old_dentry, dir, new_dentry);
>  	}
> @@ -5116,6 +5121,14 @@ int vfs_rename(struct renamedata *rd)
>  		    old_dir->i_nlink >= max_links)
>  			goto out;
>  	}
> +	error = try_break_deleg(old_dir, delegated_inode);
> +	if (error)
> +		goto out;
> +	if (new_dir != old_dir) {
> +		error = try_break_deleg(new_dir, delegated_inode);
> +		if (error)
> +			goto out;
> +	}
>  	if (!is_dir) {
>  		error = try_break_deleg(source, delegated_inode);
>  		if (error)
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

