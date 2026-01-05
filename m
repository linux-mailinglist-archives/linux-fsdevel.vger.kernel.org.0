Return-Path: <linux-fsdevel+bounces-72399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0470CCF4F4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 18:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9312230060D6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5B433B6CB;
	Mon,  5 Jan 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENMpImSk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ojo/SiD0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENMpImSk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ojo/SiD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58733A036
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633526; cv=none; b=YUgqHsnpPe+pp00CWNWGEH55XVC1meyndICXAKZt1yGaeVvAaqepcin9Mdcg1d/9ASEIKWHpebIn2dn6dhj97IPAoP16G9nshay7f7F8iPpBiwvOkM+Ci3L2Rd5kzmMDmxF7uIDCCVg0f/cA5bygyq83FYzgSXaA84oR3cOmIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633526; c=relaxed/simple;
	bh=KdMwFfCl8JDdc/v0EyqHsMwhDfjhao8+VKgtC4eE4Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxeX0jxC6owEOwk88z/+9XCH5dTsiDh5Eqvpe17YnzJAr8+zOG5GjWRuU/X+0zd/Piz1MgxVGboxymR8pr0JAhLZA8CTeFTvmlB9BWRKev9VoSdkAWmwJkv9Ok2fuqdS4X95Oofa8kDkcc8VmBFxKspqW7RgM2arr36cZvVLaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENMpImSk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ojo/SiD0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENMpImSk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ojo/SiD0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07C6133740;
	Mon,  5 Jan 2026 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767633519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6iEMvO4e5Rs59hzWljuvscaea2JjR1X7E2MLALaOLE=;
	b=ENMpImSkmTALglJz96JXKSywvWKHgDbyt+OTn3oPwftNZOWn6WPtumgkLC+MZRVavqkjsh
	/+ZToE9oMjQaIBlRDAqJNhTYTWjp+XpHTeTEsNJPJ5KvhpNmbUZVAmZAIevGXgNYPYk4pu
	L3vgB26PFlx/fAUmDAkHbI+tV1w3U1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767633519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6iEMvO4e5Rs59hzWljuvscaea2JjR1X7E2MLALaOLE=;
	b=ojo/SiD0jAS5DkXwhIDmvQsEP7dT1NYet46xe14QCGuLbPdP9DqNhVrqXsQM/Dxtnq6JVx
	l91KrqVFnLuXZJCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767633519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6iEMvO4e5Rs59hzWljuvscaea2JjR1X7E2MLALaOLE=;
	b=ENMpImSkmTALglJz96JXKSywvWKHgDbyt+OTn3oPwftNZOWn6WPtumgkLC+MZRVavqkjsh
	/+ZToE9oMjQaIBlRDAqJNhTYTWjp+XpHTeTEsNJPJ5KvhpNmbUZVAmZAIevGXgNYPYk4pu
	L3vgB26PFlx/fAUmDAkHbI+tV1w3U1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767633519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6iEMvO4e5Rs59hzWljuvscaea2JjR1X7E2MLALaOLE=;
	b=ojo/SiD0jAS5DkXwhIDmvQsEP7dT1NYet46xe14QCGuLbPdP9DqNhVrqXsQM/Dxtnq6JVx
	l91KrqVFnLuXZJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F00B813964;
	Mon,  5 Jan 2026 17:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YI5NOm7yW2mkKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Jan 2026 17:18:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AEC3FA0837; Mon,  5 Jan 2026 18:18:34 +0100 (CET)
Date: Mon, 5 Jan 2026 18:18:34 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: only assert on LOOKUP_RCU when built with
 CONFIG_DEBUG_VFS
Message-ID: <tiwlktsfpicrf3wg5yqvnxnrma3wgipqgkbfkrmj6w755fwpxy@bvxuofhdsemw>
References: <20251229125751.826050-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229125751.826050-1-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On Mon 29-12-25 13:57:51, Mateusz Guzik wrote:
> Calls to the 2 modified routines are explicitly gated with checks for
> the flag, so there is no use for this in production kernels.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index f7a8b5b000c2..9c5a372a86f6 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -879,7 +879,7 @@ static bool try_to_unlazy(struct nameidata *nd)
>  {
>  	struct dentry *parent = nd->path.dentry;
>  
> -	BUG_ON(!(nd->flags & LOOKUP_RCU));
> +	VFS_BUG_ON(!(nd->flags & LOOKUP_RCU));
>  
>  	if (unlikely(nd->flags & LOOKUP_CACHED)) {
>  		drop_links(nd);
> @@ -919,7 +919,8 @@ static bool try_to_unlazy(struct nameidata *nd)
>  static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
>  {
>  	int res;
> -	BUG_ON(!(nd->flags & LOOKUP_RCU));
> +
> +	VFS_BUG_ON(!(nd->flags & LOOKUP_RCU));
>  
>  	if (unlikely(nd->flags & LOOKUP_CACHED)) {
>  		drop_links(nd);
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

