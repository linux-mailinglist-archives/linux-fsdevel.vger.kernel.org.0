Return-Path: <linux-fsdevel+bounces-69788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FFBC84F8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E20A3B1D1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F59B2D8363;
	Tue, 25 Nov 2025 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HDKwf0YQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/Tpx/UR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HDKwf0YQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1/Tpx/UR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6B301493
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073956; cv=none; b=uBujljb0eQ1iCJ+SijL9vDyvTTAfPzftO+5rkLtZLvBYN0A9FZt1MGEqSG0wpM1gFSOXmdv9/Cd5UU3oA4HdAXbUoxfG49tWuTcjwiospXd9QKwxLXV3cV6jTldjD7Oog+1JIbPr6akYX2he1ekXPEY11F1DCpL8TMSN/tcuvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073956; c=relaxed/simple;
	bh=gzVXJvrKdM2NsSJbt8Xku5p6XNA1i/Xv9YJmSbcHuC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxGz1l4d039tihdfwCg2l4xN/Oye7bS7wlF4esIn2v3FpDSpMTbQ9Zn/cDqsXHL/5CsE9pkVMYQ5vWQNDKMTpdqyH/Hw8uUGdZe242EQ2zmFM82ce2XxMTu3o5d+f76KLw1Dc7WJZu6LHIYNDI6EmE28dz41VEq2RA4/Qn8A9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HDKwf0YQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/Tpx/UR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HDKwf0YQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1/Tpx/UR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 877275BE53;
	Tue, 25 Nov 2025 12:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764073949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUBD/5l2DDSTM3HJ6/sjGno9gIGuilRy7vBsdEVvZzI=;
	b=HDKwf0YQYd7YONcbAhp9bRWQv7AdLP3AI2PGJmrZwZST1OBQpFB7HGt7LJMOzRifrlQjMG
	XLLZtqm5KW2zNbtwNh8S58wgRLZ1zKlpC0NuEVKq8d8gQ6tKv9rN4CEw6dace77BHtEotH
	GW8a8ESokAckX5A6KFxCEF7/o/xa7YU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764073949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUBD/5l2DDSTM3HJ6/sjGno9gIGuilRy7vBsdEVvZzI=;
	b=1/Tpx/URtlm7G08KOFX/Xj2uIQmC3AAfF9EkqEpMt1gJpvgZ3u5PlpGWdeU464VubxJ38y
	YmpCv9rMlb0FoIBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764073949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUBD/5l2DDSTM3HJ6/sjGno9gIGuilRy7vBsdEVvZzI=;
	b=HDKwf0YQYd7YONcbAhp9bRWQv7AdLP3AI2PGJmrZwZST1OBQpFB7HGt7LJMOzRifrlQjMG
	XLLZtqm5KW2zNbtwNh8S58wgRLZ1zKlpC0NuEVKq8d8gQ6tKv9rN4CEw6dace77BHtEotH
	GW8a8ESokAckX5A6KFxCEF7/o/xa7YU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764073949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dUBD/5l2DDSTM3HJ6/sjGno9gIGuilRy7vBsdEVvZzI=;
	b=1/Tpx/URtlm7G08KOFX/Xj2uIQmC3AAfF9EkqEpMt1gJpvgZ3u5PlpGWdeU464VubxJ38y
	YmpCv9rMlb0FoIBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B5943EA63;
	Tue, 25 Nov 2025 12:32:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id doAXHt2hJWkhcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 12:32:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36D26A0C7D; Tue, 25 Nov 2025 13:32:25 +0100 (CET)
Date: Tue, 25 Nov 2025 13:32:25 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 05/47] namespace: convert open_tree() to FD_PREPARE()
Message-ID: <ilf3stvvomikmxi6x7caeihap2mkpgm2m4s4hu6aqawlgdva3r@xipldmip2fhr>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-5-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-5-b6efa1706cfd@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,gmail.com,kernel.dk];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sun 23-11-25 17:33:23, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namespace.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..3cf3fa27117d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3103,19 +3103,7 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
>  
>  SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)
>  {
> -	int fd;
> -	struct file *file __free(fput) = NULL;
> -
> -	file = vfs_open_tree(dfd, filename, flags);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> -
> -	fd = get_unused_fd_flags(flags & O_CLOEXEC);
> -	if (fd < 0)
> -		return fd;
> -
> -	fd_install(fd, no_free_ptr(file));
> -	return fd;
> +	return FD_ADD(flags, vfs_open_tree(dfd, filename, flags));
>  }
>  
>  /*
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

