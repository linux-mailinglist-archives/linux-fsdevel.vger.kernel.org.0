Return-Path: <linux-fsdevel+bounces-43824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FA0A5E1DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 17:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156B31758B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4CA1D9A54;
	Wed, 12 Mar 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FAdb7KLM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2WKHA+VJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qKJx/YOW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aKLKVzI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75C142E7C
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797311; cv=none; b=uJwNnI9pXDjXZjBwtd7hyDjNY35KrRHllCq/YZcape+Y84MCW4TQAIm8HNvwmFJ7JBCfZCqRAPAjcQFWagMKdpwuvNyJ0lCcTKv1s3LCvWyQMpnPaOnTEY8ZXk9fbT4nM0rIqb1RKBNiKjBoTQ32bLKUNHmNGfzRTe3R1A9N3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797311; c=relaxed/simple;
	bh=xoEemfhLe/hT8wz2RM1g2YsmjYmjkPpdM+Xn0gOBvwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrNk+v7oOI5gqPjp3iVeKQy48y3Lx68ZWklANgOrqg+fFV2IHq7KI0bwHYTYepjntyXI5L8EFvR7mCl4XIZMROFiGX1mCoHvxb9cK4ZJkcH0Z4g0bCuog4kH7+JIlah7OMeRgTMfHicBAB0t+j8C8sOKy2r8qcvgeEfnc2a+w54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FAdb7KLM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2WKHA+VJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qKJx/YOW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aKLKVzI4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E297F21185;
	Wed, 12 Mar 2025 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741797308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wyKPY6BsbgyKWF/AfyhaWT4I1iwcwHT3tGILMMBhG1Q=;
	b=FAdb7KLMPq+ctNIBOHF2Cxu6MvSs9nTT8OLyGWBrt8bCx1FkG0ansp4KucHyawL3n90skV
	nXmvl5eSyTsVh/74H+KYos5tHANhWsMeGviJZlxUaoJVvlf6+OEGDoyTd0snYWICMJIf4f
	w3MMTc8MacGWZ1e1Wr9BlweuyRd/Dnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741797308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wyKPY6BsbgyKWF/AfyhaWT4I1iwcwHT3tGILMMBhG1Q=;
	b=2WKHA+VJxdjU8QdTz88wk4eHowItUqgc/m7cC6UOhislmq+P/2v/onj1WASBL1ZxfEdTuB
	Jbh1ketNTcttobAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="qKJx/YOW";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aKLKVzI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741797307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wyKPY6BsbgyKWF/AfyhaWT4I1iwcwHT3tGILMMBhG1Q=;
	b=qKJx/YOWB6s6UEY8y1U6UexFPJ56MLXm59UCOMnIlRueIpq18/nzY66WWNWxszLgQf23Tv
	dlrQoqIABgvOm1AdLTb+cpbZzWYMA84ABiv5E+0mVGX/QRU63P6yXyRqFbbrsaY1wbWNlF
	LKkJq10dNB7FKfsCnCMzW/A2SKki/Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741797307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wyKPY6BsbgyKWF/AfyhaWT4I1iwcwHT3tGILMMBhG1Q=;
	b=aKLKVzI4gzRdhKjVIVY96GDY+bD8Ul78vdS2BMTBnNsp/j4IJv9DbWxsyG81fuHEpIXldT
	Vi4nJ1PXA3l/TdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D61351377F;
	Wed, 12 Mar 2025 16:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id szU6NLu30WfPIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Mar 2025 16:35:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4F815A0908; Wed, 12 Mar 2025 17:35:03 +0100 (CET)
Date: Wed, 12 Mar 2025 17:35:03 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use debug-only asserts around fd allocation and
 install
Message-ID: <nlsxinmlymfa6jkafzu4d2xdbrrwjpkvdnz5hxnfn7qahltqws@nagqp77yuk6f>
References: <20250312161941.1261615-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312161941.1261615-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: E297F21185
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
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 12-03-25 17:19:41, Mateusz Guzik wrote:
> This also restores the check which got removed in 52732bb9abc9ee5b
> ("fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()")
> for performance reasons -- they no longer apply with a debug-only
> variant.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> I have about 0 opinion whether this should be BUG or WARN, the code was
> already inconsistent on this front. If you want the latter, I'll have 0
> complaints if you just sed it and commit as yours.
> 
> This reminded me to sort out that litmus test for smp_rmb, hopefully
> soon(tm) as it is now nagging me.
> 
>  fs/file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 6c159ede55f1..09460ec74ef8 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -582,6 +582,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  
>  	__set_open_fd(fd, fdt, flags & O_CLOEXEC);
>  	error = fd;
> +	VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) != NULL);
>  
>  out:
>  	spin_unlock(&files->file_lock);
> @@ -647,7 +648,7 @@ void fd_install(unsigned int fd, struct file *file)
>  		rcu_read_unlock_sched();
>  		spin_lock(&files->file_lock);
>  		fdt = files_fdtable(files);
> -		WARN_ON(fdt->fd[fd] != NULL);
> +		VFS_BUG_ON(fdt->fd[fd] != NULL);
>  		rcu_assign_pointer(fdt->fd[fd], file);
>  		spin_unlock(&files->file_lock);
>  		return;
> @@ -655,7 +656,7 @@ void fd_install(unsigned int fd, struct file *file)
>  	/* coupled with smp_wmb() in expand_fdtable() */
>  	smp_rmb();
>  	fdt = rcu_dereference_sched(files->fdt);
> -	BUG_ON(fdt->fd[fd] != NULL);
> +	VFS_BUG_ON(fdt->fd[fd] != NULL);
>  	rcu_assign_pointer(fdt->fd[fd], file);
>  	rcu_read_unlock_sched();
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

