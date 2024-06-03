Return-Path: <linux-fsdevel+bounces-20804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAC98D8098
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 13:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90DABB23504
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 11:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733184A28;
	Mon,  3 Jun 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BWdUminq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D02RXRQ/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BWdUminq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D02RXRQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2F80039;
	Mon,  3 Jun 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413007; cv=none; b=fJQhAQgYIkk2F6VT/8u+VnI7zsHCfoXMJ+sHAhIMQv1GK8hzKPWjKTHPNi3oMg+Fwqg+ncrk7FB4MeeEqQKLxNw9Irf72UH1WrC4vJcu1GrT3BloX8neMWsMBk2/yIu+zETmm02mL2N7n12HjKptocSpFfh1vZ8YeJ2/b3DekT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413007; c=relaxed/simple;
	bh=QJmR2fZSpwd1bnIzbLsPjrZJAzboq407Jt6ky5wo0+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZfnSbtkbl2BOD3GVYKngIw9fCXicfvZllvzzs4dHg/DLCg6RBpay38fXEI4rAeMPV6GxrKcyd4wmsZn+sJMrFd+31OOO6AjfrfxgM+GPMPdrU6Tn6o0vhMAQJDFqufz/4gUFzWZiw4hl7YsuXPaGRy3zIt5tLQEKRXd1XIZOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BWdUminq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D02RXRQ/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BWdUminq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D02RXRQ/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FC0420031;
	Mon,  3 Jun 2024 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717413004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFTkACK56sbPNHG137Zoa10b1jiuGODyVen8+TQw2k4=;
	b=BWdUminqdsEgXpYg6OtrV6MBmBTUxenz8TQViZq2MQmreiN58+WQEiAq6NJquxFu8OwYPS
	fs5XMQCGFDlwwORRmScl16H24tXhBoomzUcJHTKlg0yFHP/LIopQtwIaoOJt0QcESLtWQR
	DvRC9ASRa6aJPoWE5agzYNMEnZ0mKJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717413004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFTkACK56sbPNHG137Zoa10b1jiuGODyVen8+TQw2k4=;
	b=D02RXRQ/Vy0t7FaWMS2HE90F1rx88vfRRTlsbXTu9z596vN90nBfBPC2xFmrDgsMprqmpt
	KsFarKRFuzvlxbCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717413004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFTkACK56sbPNHG137Zoa10b1jiuGODyVen8+TQw2k4=;
	b=BWdUminqdsEgXpYg6OtrV6MBmBTUxenz8TQViZq2MQmreiN58+WQEiAq6NJquxFu8OwYPS
	fs5XMQCGFDlwwORRmScl16H24tXhBoomzUcJHTKlg0yFHP/LIopQtwIaoOJt0QcESLtWQR
	DvRC9ASRa6aJPoWE5agzYNMEnZ0mKJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717413004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CFTkACK56sbPNHG137Zoa10b1jiuGODyVen8+TQw2k4=;
	b=D02RXRQ/Vy0t7FaWMS2HE90F1rx88vfRRTlsbXTu9z596vN90nBfBPC2xFmrDgsMprqmpt
	KsFarKRFuzvlxbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6093E13A93;
	Mon,  3 Jun 2024 11:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BtU7F4ykXWaiIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Jun 2024 11:10:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5C61EA087F; Mon,  3 Jun 2024 13:09:57 +0200 (CEST)
Date: Mon, 3 Jun 2024 13:09:57 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: replace WARN(down_read_trylock, ...) abuse with
 proper asserts
Message-ID: <20240603110957.we2e2af33qsesmmj@quack3>
References: <20240602123720.775702-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602123720.775702-1-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Sun 02-06-24 14:37:19, Mateusz Guzik wrote:
> Note the macro used here works regardless of LOCKDEP.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Nice cleanup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c      | 2 +-
>  fs/quota/dquot.c | 8 ++------
>  2 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 407095188f83..a0a944fd3a1c 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1548,7 +1548,7 @@ void shrink_dcache_for_umount(struct super_block *sb)
>  {
>  	struct dentry *dentry;
>  
> -	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
> +	rwsem_assert_held_write(&sb->s_umount);
>  
>  	dentry = sb->s_root;
>  	sb->s_root = NULL;
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 627eb2f72ef3..a2b256dac36e 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -2246,9 +2246,7 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
>  	int cnt;
>  	struct quota_info *dqopt = sb_dqopt(sb);
>  
> -	/* s_umount should be held in exclusive mode */
> -	if (WARN_ON_ONCE(down_read_trylock(&sb->s_umount)))
> -		up_read(&sb->s_umount);
> +	rwsem_assert_held_write(&sb->s_umount);
>  
>  	/* Cannot turn off usage accounting without turning off limits, or
>  	 * suspend quotas and simultaneously turn quotas off. */
> @@ -2510,9 +2508,7 @@ int dquot_resume(struct super_block *sb, int type)
>  	int ret = 0, cnt;
>  	unsigned int flags;
>  
> -	/* s_umount should be held in exclusive mode */
> -	if (WARN_ON_ONCE(down_read_trylock(&sb->s_umount)))
> -		up_read(&sb->s_umount);
> +	rwsem_assert_held_write(&sb->s_umount);
>  
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
>  		if (type != -1 && cnt != type)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

