Return-Path: <linux-fsdevel+bounces-44546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617F4A6A417
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE653BD9C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 10:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD1E224B14;
	Thu, 20 Mar 2025 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vV7fER2g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8JMKr31";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vV7fER2g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="c8JMKr31"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F929224248
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467789; cv=none; b=h0Wj2mZ2p2Ij9RqZEAg66/m5PsEB0FA6rAT4QnpD4ZlZbtqcvNe6ubuEGvLqrLqTJhXdbs2t2ac5jLxi2Dg0LRNOCpzNu1HvOD9RUSg8lyzeR/45IPwLWgFLl1xsbMB7EGQDz3qtgbTeO4P0DnXH1+3jOqpT574wotGazkDbaE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467789; c=relaxed/simple;
	bh=RzAR1IJlCnHxIuB98N0gtcuvjQ9p7bI7dHHHaaG7zNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwlHMIaI1emrwRpzxMFZwrAs9BGnuiaOdhbmeKPSWNsk4GoaRqA+fP1oe5bLrCOlIZCaVbWSvbpI4JveH8llPhiWqr0IX+DKt0HHKd8g0xaZxl8jt3LtOxlMfvAa4sM0bO5k+laRzpVWVohoIrTBsm/q017aR2weQ7qxwB52K0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vV7fER2g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8JMKr31; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vV7fER2g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=c8JMKr31; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BAEB1F388;
	Thu, 20 Mar 2025 10:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742467785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2DmHC7F3sN4OwliEcqrh0UYzSuJDsxOkaBKgJEfhto=;
	b=vV7fER2gWVx4BggQhW2dwtkXaHKPg29f5Wy9T2BIZyGFbHNE03sTV3m+5G7iDks7RgOaps
	cF4bxMto3W7gh4jNptVDUzRjRfV9qgeCDMiIZBt3B345aLWZp/AeO8hcPXbNv0LIo38I5D
	YH127RVLCtWraA07ie2mW2hdinB0++s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742467785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2DmHC7F3sN4OwliEcqrh0UYzSuJDsxOkaBKgJEfhto=;
	b=c8JMKr31s2qoigrS1nniEwp5qlclpSI7APOtghJyfqG2LbWYvwix+s4HN/Z0+06E1TOKvc
	meg7jfz8DgCLtmDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vV7fER2g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=c8JMKr31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742467785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2DmHC7F3sN4OwliEcqrh0UYzSuJDsxOkaBKgJEfhto=;
	b=vV7fER2gWVx4BggQhW2dwtkXaHKPg29f5Wy9T2BIZyGFbHNE03sTV3m+5G7iDks7RgOaps
	cF4bxMto3W7gh4jNptVDUzRjRfV9qgeCDMiIZBt3B345aLWZp/AeO8hcPXbNv0LIo38I5D
	YH127RVLCtWraA07ie2mW2hdinB0++s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742467785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v2DmHC7F3sN4OwliEcqrh0UYzSuJDsxOkaBKgJEfhto=;
	b=c8JMKr31s2qoigrS1nniEwp5qlclpSI7APOtghJyfqG2LbWYvwix+s4HN/Z0+06E1TOKvc
	meg7jfz8DgCLtmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90C7F13A66;
	Thu, 20 Mar 2025 10:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8wNUI8ny22dXEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Mar 2025 10:49:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 45F41A07B2; Thu, 20 Mar 2025 11:49:45 +0100 (CET)
Date: Thu, 20 Mar 2025 11:49:45 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: tidy up do_sys_openat2() with likely/unlikely
Message-ID: <6w5kjzcpt7le4cz7iernbqawqgx6nfhipce4cvvu4qwssaeu2o@azv3x2c7bbkv>
References: <20250320092331.1921700-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320092331.1921700-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 9BAEB1F388
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
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 20-03-25 10:23:31, Mateusz Guzik wrote:
> Otherwise gcc 13 generates conditional forward jumps (aka branch
> mispredict by default) for build_open_flags() being succesfull.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> maybe i'll get around to do it a full pass instead of sending byte-sized
> patchen. someone(tm) should definitely do it.
> 
>  fs/open.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index bdbf03f799a1..a9063cca9911 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1413,18 +1413,19 @@ static int do_sys_openat2(int dfd, const char __user *filename,
>  			  struct open_how *how)
>  {
>  	struct open_flags op;
> -	int fd = build_open_flags(how, &op);
>  	struct filename *tmp;
> +	int err, fd;
>  
> -	if (fd)
> -		return fd;
> +	err = build_open_flags(how, &op);
> +	if (unlikely(err))
> +		return err;
>  
>  	tmp = getname(filename);
>  	if (IS_ERR(tmp))
>  		return PTR_ERR(tmp);
>  
>  	fd = get_unused_fd_flags(how->flags);
> -	if (fd >= 0) {
> +	if (likely(fd >= 0)) {
>  		struct file *f = do_filp_open(dfd, tmp, &op);
>  		if (IS_ERR(f)) {
>  			put_unused_fd(fd);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

