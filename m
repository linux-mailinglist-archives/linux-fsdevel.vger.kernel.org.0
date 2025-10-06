Return-Path: <linux-fsdevel+bounces-63487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAD1BBDFE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 14:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502FE3A8240
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD29827D771;
	Mon,  6 Oct 2025 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wGLUQn4d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sNGeUe4X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wGLUQn4d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sNGeUe4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146627B351
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752915; cv=none; b=NhsgV4HHXvpAPHaRu0/CXtLp9+Xux2+Bb4eLDcilgL/mb0RtT80UwM5Migbs7kBmd3a7uoQO8/hCwcRsUQnhs1dJlfth3Z5dsj0PPCOFx3eBkWm0nlCkzKos+UgOoPfgaQKgA00jOokkVelF8vENiYwo/rz6EelQZFdS56WRiQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752915; c=relaxed/simple;
	bh=VuUz0roRHqMBrcSmQOKqhZEPcZpCrjppkJw1W0kd098=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqf9Kwi37x4sl34CSOn5YrpAx3jhFGIReNl4WIyDqx9DFT+/pjSLJ6lrGLeJ0ALVxbBWEhrVneNV/VTAnbZW8NEVlu0Tpcziu3ZMesDOMm3yzpCj8lmP+K0O9v6GRrzMGOhjWOSHvAwssaGZKUqBO+vqEPITdQ2aLS25A3+Heo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wGLUQn4d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sNGeUe4X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wGLUQn4d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sNGeUe4X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F161336EF;
	Mon,  6 Oct 2025 12:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759752910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvj7BWorJn/oDNT5FPNXzXRZiv+JubjdJcHoGaWcRjY=;
	b=wGLUQn4dHucXat43jKz+SsShkSF9jl22ZA+2urB9mAgHz07G3sZgyLtTur/BUK7YZpjpX+
	VQbKWlCgmmloMIEirWNLzRqjFURop8Ds67NNb6DsQj6sn03LQGsLMsudmdOg7Hno0jgbUG
	2pCUqb53KtbLa46Md+J6VGlD/bFE8b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759752910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvj7BWorJn/oDNT5FPNXzXRZiv+JubjdJcHoGaWcRjY=;
	b=sNGeUe4XiFMOg9uUeyxUE8EjUu6YqnKvNZ0m8872y0P6j2L8GTTG9VXd88qgPSqtK+vxun
	lcieWFJh+urr4QAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wGLUQn4d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sNGeUe4X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759752910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvj7BWorJn/oDNT5FPNXzXRZiv+JubjdJcHoGaWcRjY=;
	b=wGLUQn4dHucXat43jKz+SsShkSF9jl22ZA+2urB9mAgHz07G3sZgyLtTur/BUK7YZpjpX+
	VQbKWlCgmmloMIEirWNLzRqjFURop8Ds67NNb6DsQj6sn03LQGsLMsudmdOg7Hno0jgbUG
	2pCUqb53KtbLa46Md+J6VGlD/bFE8b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759752910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gvj7BWorJn/oDNT5FPNXzXRZiv+JubjdJcHoGaWcRjY=;
	b=sNGeUe4XiFMOg9uUeyxUE8EjUu6YqnKvNZ0m8872y0P6j2L8GTTG9VXd88qgPSqtK+vxun
	lcieWFJh+urr4QAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2278513700;
	Mon,  6 Oct 2025 12:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6VVmCM6y42jlcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Oct 2025 12:15:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA1ADA0ABD; Mon,  6 Oct 2025 14:15:09 +0200 (CEST)
Date: Mon, 6 Oct 2025 14:15:09 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
Message-ID: <3ectwcds3gwiicciapcktvrmxhau3t7ans5ipzm5xkhpptc2fc@td2jicn5kd5s>
References: <20251005231526.708061-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251005231526.708061-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 2F161336EF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Mon 06-10-25 01:15:26, Mateusz Guzik wrote:
> Suppose there are 2 CPUs racing inode hash lookup func (say ilookup5())
> and unlock_new_inode().
> 
> In principle the latter can clear the I_NEW flag before prior stores
> into the inode were made visible.
> 
> The former can in turn observe I_NEW is cleared and proceed to use the
> inode, while possibly reading from not-yet-published areas.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> I don't think this is a serious bug in the sense I doubt anyone ever ran
> into it, but this is an issue on paper.
> 
> I'm doing some changes in the area and I figured I'll get this bit out
> of the way.

Yeah, good spotting.

> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1981,6 +1981,10 @@ void d_instantiate_new(struct dentry *entry, struct inode *inode)
>  	spin_lock(&inode->i_lock);
>  	__d_instantiate(entry, inode);
>  	WARN_ON(!(inode->i_state & I_NEW));
> +	/*
> +	 * Pairs with smp_rmb in wait_on_inode().
> +	 */
> +	smp_wmb();
>  	inode->i_state &= ~I_NEW & ~I_CREATING;

Hum, why not smp_store_release() here (and below) and...

>  	/*
>  	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> diff --git a/fs/inode.c b/fs/inode.c
> index ec9339024ac3..842ee973c8b6 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1181,6 +1181,10 @@ void unlock_new_inode(struct inode *inode)
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode->i_state & I_NEW));
> +	/*
> +	 * Pairs with smp_rmb in wait_on_inode().
> +	 */
> +	smp_wmb();
>  	inode->i_state &= ~I_NEW & ~I_CREATING;
>  	/*
>  	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> @@ -1198,6 +1202,10 @@ void discard_new_inode(struct inode *inode)
>  	lockdep_annotate_inode_mutex_key(inode);
>  	spin_lock(&inode->i_lock);
>  	WARN_ON(!(inode->i_state & I_NEW));
> +	/*
> +	 * Pairs with smp_rmb in wait_on_inode().
> +	 */
> +	smp_wmb();
>  	inode->i_state &= ~I_NEW;
>  	/*
>  	 * Pairs with the barrier in prepare_to_wait_event() to make sure
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 22dd4adc5667..e1e1231a6830 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *inode)
>  {
>  	wait_var_event(inode_state_wait_address(inode, __I_NEW),
>  		       !(READ_ONCE(inode->i_state) & I_NEW));
> +	/*
> +	 * Pairs with routines clearing I_NEW.
> +	 */
> +	smp_rmb();

... smp_load_acquire() instead if READ_ONCE? That would seem like a more
"modern" way to fix this?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

