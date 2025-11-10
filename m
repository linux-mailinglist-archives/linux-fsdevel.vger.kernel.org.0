Return-Path: <linux-fsdevel+bounces-67677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D90C464BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C6AA4EBDD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B4B30C373;
	Mon, 10 Nov 2025 11:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdlF668r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+l21lIjW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdlF668r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+l21lIjW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C430C361
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 11:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774252; cv=none; b=aUohZgkRUsEOkV3F6QB0OVfhWKjtCYj+jGU1zXyZc3+VCWY9w9yXT4wc7zbtGY85jOtfcpmCd9u0ytk/0tG2oIb+ygo9K89pKeV0R3EmXLcEm0A7oOG7wz0wepVflsxTteVopwNi4AmUqoUPc4Z+zOekTa4ksVG1iXB9oOhrf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774252; c=relaxed/simple;
	bh=OoCAVZI0ODO0xjNB4eMphg5EnwxHAzR51SdjYdc6spg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWfKteMadjQ61V3vFCJfOBarCwxqUqeNRBiZLMMklrlk3Str7ajES1pwJGRm4vLK/ovME+GWCPSUQFHmwd8YfMzGCDY9JzX7zIAtVQAvO/pU7VEJPIUelwGKvO0/M/R+w1MlquLpNOQM6F8p8/06SoU+u+uFfjg2HEfigOaZQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdlF668r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+l21lIjW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdlF668r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+l21lIjW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A33661F445;
	Mon, 10 Nov 2025 11:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762774248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxS0+Y+8aWU+WXGUz5FS1LZd+SzhEBie98VixeoLL1Y=;
	b=vdlF668rSvDWzW8jhD0I8kBgY7UeqfjAOVYoyhd7WiPbxK/WabeeFs+rhFU3yYbCBOtQNr
	l1ZII0vj1+Q3taeYoCbNuR3mewdN7QsDc2ilsRtLGMGy850k0FlVnQ7Oc5dqqbocJxUS3b
	iLo45yFktiZehyvrhzG/ObElUcCYo/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762774248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxS0+Y+8aWU+WXGUz5FS1LZd+SzhEBie98VixeoLL1Y=;
	b=+l21lIjWmNCdC5n8dzP2Hv0PBstxOGGtXJou2EQKQXC+bVAzS8mqh+SIgV+HelSjxVu5QX
	6S/rOh2fKluUWlBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vdlF668r;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+l21lIjW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762774248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxS0+Y+8aWU+WXGUz5FS1LZd+SzhEBie98VixeoLL1Y=;
	b=vdlF668rSvDWzW8jhD0I8kBgY7UeqfjAOVYoyhd7WiPbxK/WabeeFs+rhFU3yYbCBOtQNr
	l1ZII0vj1+Q3taeYoCbNuR3mewdN7QsDc2ilsRtLGMGy850k0FlVnQ7Oc5dqqbocJxUS3b
	iLo45yFktiZehyvrhzG/ObElUcCYo/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762774248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pxS0+Y+8aWU+WXGUz5FS1LZd+SzhEBie98VixeoLL1Y=;
	b=+l21lIjWmNCdC5n8dzP2Hv0PBstxOGGtXJou2EQKQXC+bVAzS8mqh+SIgV+HelSjxVu5QX
	6S/rOh2fKluUWlBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9989E14385;
	Mon, 10 Nov 2025 11:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7vp0JejMEWnXXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 11:30:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 37F2AA28B1; Mon, 10 Nov 2025 12:30:40 +0100 (CET)
Date: Mon, 10 Nov 2025 12:30:40 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: avoid calls to legitimize_links() if possible
Message-ID: <iwsvdaw4u2o366ndbk2dzj2ehjbwpynpkcym435qvndoiwqg6a@mlbbmml23747>
References: <20251110100503.1434167-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110100503.1434167-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: A33661F445
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Mon 10-11-25 11:05:03, Mateusz Guzik wrote:
> The routine is always called towards the end of lookup.
> 
> According to bpftrace on my boxen and boxen of people I asked, the depth
> count is almost always 0, thus the call can be avoided in the common case.
> 
> one-liner:
> bpftrace -e 'kprobe:legitimize_links { @[((struct nameidata *)arg0)->depth] = count(); }'
> 
> sample results from few minutes of tracing:
> @[1]: 59
> @[0]: 147236
> 
> @[2]: 1
> @[1]: 12087
> @[0]: 5926235
> 
> And of course the venerable kernel build:
> @[1]: 3563
> @[0]: 6625425
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> v2:
> - drop 'noinline'
> - spell out the check at call sites
> 
> verified no change in asm
> 
>  fs/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 2a112b2c0951..0de0344a2ab2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -882,7 +882,7 @@ static bool try_to_unlazy(struct nameidata *nd)
>  
>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>  
> -	if (unlikely(!legitimize_links(nd)))
> +	if (unlikely(nd->depth && !legitimize_links(nd)))
>  		goto out1;
>  	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
>  		goto out;
> @@ -917,7 +917,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
>  	int res;
>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>  
> -	if (unlikely(!legitimize_links(nd)))
> +	if (unlikely(nd->depth && !legitimize_links(nd)))
>  		goto out2;
>  	res = __legitimize_mnt(nd->path.mnt, nd->m_seq);
>  	if (unlikely(res)) {
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

