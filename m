Return-Path: <linux-fsdevel+bounces-69789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E712AC84FA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 13:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274C33B21F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A7F2DCC1B;
	Tue, 25 Nov 2025 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kWVwH4kp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XsqkU/vu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kWVwH4kp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XsqkU/vu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C45630E823
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764074037; cv=none; b=UQFJseIH2yE6mbYY4T52gaMDAc50UEahFJWY+zxkLljDqTqc3hed2NNFxQgxkblOi32GBNbg5Sv4Idv4f+ZOaLt2lYjCzM7HpEHE/nYzvbg/8yLkXI3zAGNhNhS/ezDtWKD4VjVpFhuHuln1IQR5ieDnNhQeGWFkg5s6Bh8n4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764074037; c=relaxed/simple;
	bh=VRfobmipVVETrzPDZLRx1D3gCkUcP9toSSvIfyhEbNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSZJbqNQmlmcpLp+e5D7lYR+/OxFbnPclotwQp10SUifiz+AppNMJAbRS6ng36GZy/+Y4njT9DViM8psuz8YrL7Toxq3s3AH/0V6QogBwxeN12CZZFU+SotgBjU5RlAeqNWZRB94vXhMqE6AWhQ+VyGegandycwEI8BGVj7VwVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kWVwH4kp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XsqkU/vu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kWVwH4kp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XsqkU/vu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1688E5BE80;
	Tue, 25 Nov 2025 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764074028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f82EiAtzd53vMLneXHR56JtzHGgDBW+RmdSJosNymZY=;
	b=kWVwH4kpJbZxXWZecgnG/LdFYqUxTVfegZ4PmPeyxM0lGOyQZkOycNjeBWyOR/kOSOt8uj
	+9mYCb2J0ZxDn/I3aKBdsgIwiVVou7TK89u79iLnJ1oxEDUcvfU+3+fXGPzU6j63iLuwBZ
	HQJ0nx8IdEk8bpgyWdOZJlvUlP2gMGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764074028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f82EiAtzd53vMLneXHR56JtzHGgDBW+RmdSJosNymZY=;
	b=XsqkU/vucvswH5CZ8CDB5bQL6Tk0j6Ecft1wXaPPfx8zex92NufJxjk7darAwyNaw/KG24
	ejBSCdkBn1aDyVCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764074028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f82EiAtzd53vMLneXHR56JtzHGgDBW+RmdSJosNymZY=;
	b=kWVwH4kpJbZxXWZecgnG/LdFYqUxTVfegZ4PmPeyxM0lGOyQZkOycNjeBWyOR/kOSOt8uj
	+9mYCb2J0ZxDn/I3aKBdsgIwiVVou7TK89u79iLnJ1oxEDUcvfU+3+fXGPzU6j63iLuwBZ
	HQJ0nx8IdEk8bpgyWdOZJlvUlP2gMGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764074028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f82EiAtzd53vMLneXHR56JtzHGgDBW+RmdSJosNymZY=;
	b=XsqkU/vucvswH5CZ8CDB5bQL6Tk0j6Ecft1wXaPPfx8zex92NufJxjk7darAwyNaw/KG24
	ejBSCdkBn1aDyVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A2A83EA63;
	Tue, 25 Nov 2025 12:33:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R2B5AiyiJWkNdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Nov 2025 12:33:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8F6F9A0C7D; Tue, 25 Nov 2025 13:33:43 +0100 (CET)
Date: Tue, 25 Nov 2025 13:33:43 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 06/47] namespace: convert open_tree_attr() to
 FD_PREPARE()
Message-ID: <p2y5amso467dpdljats3fzpepj33ogcbg3ksnyqgt2cfi3ompx@l2etmhnxyln2>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
 <20251123-work-fd-prepare-v4-6-b6efa1706cfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251123-work-fd-prepare-v4-6-b6efa1706cfd@kernel.org>
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
	URIBL_BLOCKED(0.00)[suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,kernel.org,gmail.com,kernel.dk];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sun 23-11-25 17:33:24, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 3cf3fa27117d..0c4024558c13 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5023,19 +5023,17 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
>  		unsigned, flags, struct mount_attr __user *, uattr,
>  		size_t, usize)
>  {
> -	struct file __free(fput) *file = NULL;
> -	int fd;
> -
>  	if (!uattr && usize)
>  		return -EINVAL;
>  
> -	file = vfs_open_tree(dfd, filename, flags);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> +	FD_PREPARE(fdf, flags, vfs_open_tree(dfd, filename, flags));
> +	if (fdf.err)
> +		return fdf.err;
>  
>  	if (uattr) {
> -		int ret;
>  		struct mount_kattr kattr = {};
> +		struct file *file = fd_prepare_file(fdf);
> +		int ret;
>  
>  		if (flags & OPEN_TREE_CLONE)
>  			kattr.kflags = MOUNT_KATTR_IDMAP_REPLACE;
> @@ -5051,12 +5049,7 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
>  			return ret;
>  	}
>  
> -	fd = get_unused_fd_flags(flags & O_CLOEXEC);
> -	if (fd < 0)
> -		return fd;
> -
> -	fd_install(fd, no_free_ptr(file));
> -	return fd;
> +	return fd_publish(fdf);
>  }
>  
>  int show_path(struct seq_file *m, struct dentry *root)
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

