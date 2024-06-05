Return-Path: <linux-fsdevel+bounces-21061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF5B8FD20E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EEA1C22C93
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538D414D447;
	Wed,  5 Jun 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c6JsmXeK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RmEX97yG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c6JsmXeK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RmEX97yG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E329376F1;
	Wed,  5 Jun 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717602566; cv=none; b=MzP0FGSfwVsmFQxEsx7uo6RfG2/C0Qj9IgKZMalWhOHruycpRXicpCYMfSMotgQHdBlCaq7yteZxWr36ZdGd6h9hlHlfsw4zMdWpuuOo6dwy7PN30YqmgFeTTxpcgY3/NRZbS8Qodbf+Sxhpv2KF1NgmROuDK8v7vcNlXPBe7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717602566; c=relaxed/simple;
	bh=BlWSLoJNk8jTOYLpAuH8GjEdeRr/JzNuJFF/tQG7gcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfbris7imorrMlenWL3DNz+4X3+8Tm8NRyHsIQcq9UDK/dEvxvxfEMzbQau1urMkoq3P5fCdh2Gi2bwsd3KndUHtjWbkDz5LafdkVM3A7XSHJvU9HOJ+pd6ymOzOdfzDbTsKvcdreoNSvNPnrGo1KOn9L/7bUQNCqEkMazHr0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c6JsmXeK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RmEX97yG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c6JsmXeK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RmEX97yG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7079821282;
	Wed,  5 Jun 2024 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717602563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8m32dSEsbROBVmERiARqCYCgF+DliZC0copAvcWR/Q=;
	b=c6JsmXeKUvHSZ2CI+LORGPbeCf1ea20T9LpGyWqqlHuPsqlv6xq0lusFScOh5GZstcVHLR
	B6+DHy15WIX1maoe7pxyg/URgixZQC+uWjaNvzJDVht2DZXuRHlDd8QPv0sdITcCU06Pui
	KfbFgyIXEXsQCpwmy4umaVDIlEAzcOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717602563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8m32dSEsbROBVmERiARqCYCgF+DliZC0copAvcWR/Q=;
	b=RmEX97yGEu8IX8S4SH/aZ6R5UwkeIFzgxHcqir+05bIiVDC4Sz0s9qTLUlYyIDHfV8eG5F
	WG9S7FXlF/cZurCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c6JsmXeK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RmEX97yG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717602563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8m32dSEsbROBVmERiARqCYCgF+DliZC0copAvcWR/Q=;
	b=c6JsmXeKUvHSZ2CI+LORGPbeCf1ea20T9LpGyWqqlHuPsqlv6xq0lusFScOh5GZstcVHLR
	B6+DHy15WIX1maoe7pxyg/URgixZQC+uWjaNvzJDVht2DZXuRHlDd8QPv0sdITcCU06Pui
	KfbFgyIXEXsQCpwmy4umaVDIlEAzcOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717602563;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r8m32dSEsbROBVmERiARqCYCgF+DliZC0copAvcWR/Q=;
	b=RmEX97yGEu8IX8S4SH/aZ6R5UwkeIFzgxHcqir+05bIiVDC4Sz0s9qTLUlYyIDHfV8eG5F
	WG9S7FXlF/cZurCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A84113A24;
	Wed,  5 Jun 2024 15:49:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x60WFgOJYGZpTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 05 Jun 2024 15:49:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E4EFA086C; Wed,  5 Jun 2024 17:49:23 +0200 (CEST)
Date: Wed, 5 Jun 2024 17:49:23 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] vfs: shave a branch in getname_flags
Message-ID: <20240605154923.sec53hhjnzgowvws@quack3>
References: <20240604155257.109500-1-mjguzik@gmail.com>
 <20240604155257.109500-4-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604155257.109500-4-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.94
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7079821282
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.94 / 50.00];
	BAYES_HAM(-2.93)[99.69%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Tue 04-06-24 17:52:57, Mateusz Guzik wrote:
> Check for an error while copying and no path in one branch.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good to me modulo the need for rechecking Christian already pointed
out. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


								Honza

> ---
>  fs/namei.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 950ad6bdd9fe..f25dcb9077dd 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -148,9 +148,20 @@ getname_flags(const char __user *filename, int flags)
>  	result->name = kname;
>  
>  	len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);
> -	if (unlikely(len < 0)) {
> -		__putname(result);
> -		return ERR_PTR(len);
> +	/*
> +	 * Handle both empty path and copy failure in one go.
> +	 */
> +	if (unlikely(len <= 0)) {
> +		if (unlikely(len < 0)) {
> +			__putname(result);
> +			return ERR_PTR(len);
> +		}
> +
> +		/* The empty path is special. */
> +		if (!(flags & LOOKUP_EMPTY)) {
> +			__putname(result);
> +			return ERR_PTR(-ENOENT);
> +		}
>  	}
>  
>  	/*
> @@ -188,14 +199,6 @@ getname_flags(const char __user *filename, int flags)
>  	}
>  
>  	atomic_set(&result->refcnt, 1);
> -	/* The empty path is special. */
> -	if (unlikely(!len)) {
> -		if (!(flags & LOOKUP_EMPTY)) {
> -			putname(result);
> -			return ERR_PTR(-ENOENT);
> -		}
> -	}
> -
>  	result->uptr = filename;
>  	result->aname = NULL;
>  	audit_getname(result);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

