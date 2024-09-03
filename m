Return-Path: <linux-fsdevel+bounces-28379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E83C969F58
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9411F24592
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AE48C07;
	Tue,  3 Sep 2024 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="suqIObhU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wTXJXT44";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="suqIObhU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wTXJXT44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556671CFA9
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371140; cv=none; b=GzGcrAeU72eOAv02Eu0fXEumxPIbc30v+hxmyBEdCsb7Oce0COhitg3u/mEJQac6XIMGeQqWqUbOhQ7K1mfQ5egR1rCPhUEOOO6s2ebOIjKPVYhF4oNGYwZRzVPs5RA0wZqtiZZ39kv5WvImbuzUk9rFFg7BAmF1Na6enPhG2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371140; c=relaxed/simple;
	bh=Wn6Q1OefFtq7/iNfNGVP63MofATwssLE6mwioutwja4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xq1j2t67jiNjpisubKQGDVnHUI5qvVWsB5BJIQutKRR6+FqrtzGyVVmbBJWFYk9hORamB8iTL0dKKP3L+qGr91usOA5uOAH/PhUpA4ioYXiiw39rY9Kj+JKuoeHvXoUqjYMgCloqFCTpeYLSWl8GvzySU67dxo0EWRVTYcKXO8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=suqIObhU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wTXJXT44; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=suqIObhU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wTXJXT44; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70A9E1F383;
	Tue,  3 Sep 2024 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725371136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrV1MdkSNLuu+bXQB1nu+7DzQ/2yyxWXF3KCO6Azf3Y=;
	b=suqIObhUNSoSUlDdTZxE8q8G8GhLS0LskXmYr/bCFguBQ7u0AeMLEvtptV1mi9qpoIKnq/
	8w/ox3UODF5xqrHVv7QYcYFK9HvMD9rM0Ij9Zwhx+Jbtjl240ppwxIB5jKcgtWtMicJ1YC
	OHvp52LIO3Q+hgX/+/q9RPWBwyGC3ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725371136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrV1MdkSNLuu+bXQB1nu+7DzQ/2yyxWXF3KCO6Azf3Y=;
	b=wTXJXT447w9JpXQo9zygn/7DHQQdfytTabBUd2lvQK6ZUZs1FJHHY1RtXQCnVbA5w0kDGR
	i9+zV71dLBDpTRDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=suqIObhU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wTXJXT44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725371136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrV1MdkSNLuu+bXQB1nu+7DzQ/2yyxWXF3KCO6Azf3Y=;
	b=suqIObhUNSoSUlDdTZxE8q8G8GhLS0LskXmYr/bCFguBQ7u0AeMLEvtptV1mi9qpoIKnq/
	8w/ox3UODF5xqrHVv7QYcYFK9HvMD9rM0Ij9Zwhx+Jbtjl240ppwxIB5jKcgtWtMicJ1YC
	OHvp52LIO3Q+hgX/+/q9RPWBwyGC3ZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725371136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HrV1MdkSNLuu+bXQB1nu+7DzQ/2yyxWXF3KCO6Azf3Y=;
	b=wTXJXT447w9JpXQo9zygn/7DHQQdfytTabBUd2lvQK6ZUZs1FJHHY1RtXQCnVbA5w0kDGR
	i9+zV71dLBDpTRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6497013A52;
	Tue,  3 Sep 2024 13:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D++MGAAT12YcTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Sep 2024 13:45:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14EB4A096C; Tue,  3 Sep 2024 15:45:36 +0200 (CEST)
Date: Tue, 3 Sep 2024 15:45:36 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 19/20] pipe: use f_pipe
Message-ID: <20240903134536.hvryipc6yjpbl6us@quack3>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-19-6d3e4816aa7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-vfs-file-f_version-v1-19-6d3e4816aa7b@kernel.org>
X-Rspamd-Queue-Id: 70A9E1F383
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 30-08-24 15:05:00, Christian Brauner wrote:
> Pipes use f_version to defer poll notifications until a write has been
> observed. Since multiple file's refer to the same struct pipe_inode_info
> in their ->private_data moving it into their isn't feasible since we
> would need to introduce an additional pointer indirection.
> 
> However, since pipes don't require f_pos_lock we placed a new f_pipe
> member into a union with f_pos_lock that pipes can use. This is similar
> to what we already do for struct inode where we have additional fields
> per file type. This will allow us to fully remove f_version in the next
> step.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/pipe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 7dff2aa50a6d..b8f1943c57b9 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -686,7 +686,7 @@ pipe_poll(struct file *filp, poll_table *wait)
>  	if (filp->f_mode & FMODE_READ) {
>  		if (!pipe_empty(head, tail))
>  			mask |= EPOLLIN | EPOLLRDNORM;
> -		if (!pipe->writers && filp->f_version != pipe->w_counter)
> +		if (!pipe->writers && filp->f_pipe != pipe->w_counter)
>  			mask |= EPOLLHUP;
>  	}
>  
> @@ -1108,7 +1108,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
>  	bool is_pipe = inode->i_sb->s_magic == PIPEFS_MAGIC;
>  	int ret;
>  
> -	filp->f_version = 0;
> +	filp->f_pipe = 0;
>  
>  	spin_lock(&inode->i_lock);
>  	if (inode->i_pipe) {
> @@ -1155,7 +1155,7 @@ static int fifo_open(struct inode *inode, struct file *filp)
>  			if ((filp->f_flags & O_NONBLOCK)) {
>  				/* suppress EPOLLHUP until we have
>  				 * seen a writer */
> -				filp->f_version = pipe->w_counter;
> +				filp->f_pipe = pipe->w_counter;
>  			} else {
>  				if (wait_for_partner(pipe, &pipe->w_counter))
>  					goto err_rd;
> 
> -- 
> 2.45.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

