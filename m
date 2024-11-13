Return-Path: <linux-fsdevel+bounces-34675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F7C9C78FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 17:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D341B2A28F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7247E16088F;
	Wed, 13 Nov 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xfD8D5xz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cwNOIYIW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xfD8D5xz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cwNOIYIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225301C32;
	Wed, 13 Nov 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514677; cv=none; b=Zc5nCDi1qC81Kdm6KbFMXnF4D3urEiLsaW4VQqgWrKREIcjsbjczWB5EE7MAO8OIY9VHW4i1NmIBWy059v4dJUYfh4IDzL+aPs1FoXPTAxMRjX1A5x6wm+Tq8ovFs46EyLCoKeQ6lfjOZPAjVkh+DfRLlXtLe3b1jdzdNJQDUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514677; c=relaxed/simple;
	bh=q0VQ9X+/obSpsOK/bRPN3dRqDNFVoYyuzZk0bMVicU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+nzUtzDJvEd/PlNRdyg9H3NPUmiJ58c6rf6kk8U7f9smzkxmI98DlQkzX/EBozERoOtE/YH+15Nl9Wph2SDTxnOzmoK+xSb+8hqmiVLF1ukgizHfl+avVTlKqEtJOO1VmJ4RM8XWohI0KvgCi91GfeNbwUkOlIqqTPkwBGVM5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xfD8D5xz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cwNOIYIW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xfD8D5xz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cwNOIYIW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B5991F391;
	Wed, 13 Nov 2024 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731514674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM4G77+YLlc9ORY9AG3U/Xgzm50WG8iO1k0TaTFiVxE=;
	b=xfD8D5xzlbk0LEzwpk6Hrb5G2q0u7V9lRSr6WVkdW0qCg8haPtrpuE8afGMtaQ4uNw8LQl
	fv8seFOTQ5h2fw+3M59bfoox+XN+lLt+rG0V40+JSbgT3YMBENqLHFQ/OTwzJcoMCAYEma
	7BOa1INxuDCbAp/q/CGh7X8+3yQh4sA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731514674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM4G77+YLlc9ORY9AG3U/Xgzm50WG8iO1k0TaTFiVxE=;
	b=cwNOIYIWH1ujuV6THi76n+vYoHmYm439yjgw5FniEBz3Xv9DO1POer6CMM2uRTCRWQPdU+
	WD4O0Vhv9gOicdDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xfD8D5xz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cwNOIYIW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731514674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM4G77+YLlc9ORY9AG3U/Xgzm50WG8iO1k0TaTFiVxE=;
	b=xfD8D5xzlbk0LEzwpk6Hrb5G2q0u7V9lRSr6WVkdW0qCg8haPtrpuE8afGMtaQ4uNw8LQl
	fv8seFOTQ5h2fw+3M59bfoox+XN+lLt+rG0V40+JSbgT3YMBENqLHFQ/OTwzJcoMCAYEma
	7BOa1INxuDCbAp/q/CGh7X8+3yQh4sA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731514674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UM4G77+YLlc9ORY9AG3U/Xgzm50WG8iO1k0TaTFiVxE=;
	b=cwNOIYIWH1ujuV6THi76n+vYoHmYm439yjgw5FniEBz3Xv9DO1POer6CMM2uRTCRWQPdU+
	WD4O0Vhv9gOicdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DCDD13A6E;
	Wed, 13 Nov 2024 16:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2bjrCjLRNGfHMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 16:17:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0016A08D0; Wed, 13 Nov 2024 17:17:53 +0100 (CET)
Date: Wed, 13 Nov 2024 17:17:53 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jlayton@kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: make evict() use smp_mb__after_spinlock instead of
 smp_mb
Message-ID: <20241113161753.2rtsxuwzgvenwvu4@quack3>
References: <20241113155103.4194099-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113155103.4194099-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 3B5991F391
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 13-11-24 16:51:03, Mateusz Guzik wrote:
> It literally directly follows a spin_lock() call.
> 
> This whacks an explicit barrier on x86-64.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> This plausibly can go away altogether, but I could not be arsed to
> convince myself that's correct. Individuals willing to put in time are
> welcome :)

AFAICS there's nothing else really guaranteeing the last store to
inode->i_state cannot be reordered up to after the wake up so I think the
barrier should be there.

								Honza
> 
>  fs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index e5a60084a7a9..b3db1234737f 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -817,7 +817,7 @@ static void evict(struct inode *inode)
>  	 * ___wait_var_event() either sees the bit cleared or
>  	 * waitqueue_active() check in wake_up_var() sees the waiter.
>  	 */
> -	smp_mb();
> +	smp_mb__after_spinlock();
>  	inode_wake_up_bit(inode, __I_NEW);
>  	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
>  	spin_unlock(&inode->i_lock);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

