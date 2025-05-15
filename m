Return-Path: <linux-fsdevel+bounces-49125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC65AB84EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090D71BC1CE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14629298C15;
	Thu, 15 May 2025 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aiw731cV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ykBfxu2I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aiw731cV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ykBfxu2I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003AA2989AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308502; cv=none; b=DsfDeCFuvpNfCGJqpdovcarDQc8XVXdnsNewV4sJPRrs3uKJa8JLr4gBEJchrN7RJ4ClJbsrkthCwpsm05Vg5ABD3C3w3Bekvnpyd6krTpoaGAO9BXcKnWvT5aco+Y3+94tJhintH/3juoa3BngIKtE79hXO830ueMx5RnXZ9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308502; c=relaxed/simple;
	bh=gQvPujqngghj0Dq05iVIVhZF6wDE0w5nwGYupzIkA64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVow70QsYIfup42xLVO7QOzV8Qf9ItAd5bbxzI4aFPTnEkWYCRWDq5XlGYiDgQxCSzQ3bMzcHTJANywnr7iL4bSHceTnYsMFV/iyw29A5njOoaDU6Erjm1XOgLQvVGzj3W7yF17c/gOzhWWAJfBcJvoSsQ0a1qZ0+pX7FcAJEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Aiw731cV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ykBfxu2I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Aiw731cV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ykBfxu2I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 29B53211A5;
	Thu, 15 May 2025 11:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747308499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Up2hJiI9AuEDVzLuKqKUlIrqcsteVNokAO6UxOmyZYs=;
	b=Aiw731cV/YzwTnFIRYjcUSTGMSidJSBw4OZ+7RjjLakkw2lWyNvZrPLXtQOGn40+jHWHB3
	69/0qfTLFvc9p1w9MML6ONFGEj5t+qXHW0ZbT3B+2frgIMPzcDuj0Ns0aG8p0ZYXZr87RK
	3i7jUTsKwPGxzqt3nMySTQ0fU18DEWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747308499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Up2hJiI9AuEDVzLuKqKUlIrqcsteVNokAO6UxOmyZYs=;
	b=ykBfxu2IEiy4ptpcz0ZdIdVIm6qk8b/ON/gWYzNSfF+5QdBE9HGKCh+fa+c4Vj0R80kHgF
	BSBv7AC5OEf/wpDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747308499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Up2hJiI9AuEDVzLuKqKUlIrqcsteVNokAO6UxOmyZYs=;
	b=Aiw731cV/YzwTnFIRYjcUSTGMSidJSBw4OZ+7RjjLakkw2lWyNvZrPLXtQOGn40+jHWHB3
	69/0qfTLFvc9p1w9MML6ONFGEj5t+qXHW0ZbT3B+2frgIMPzcDuj0Ns0aG8p0ZYXZr87RK
	3i7jUTsKwPGxzqt3nMySTQ0fU18DEWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747308499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Up2hJiI9AuEDVzLuKqKUlIrqcsteVNokAO6UxOmyZYs=;
	b=ykBfxu2IEiy4ptpcz0ZdIdVIm6qk8b/ON/gWYzNSfF+5QdBE9HGKCh+fa+c4Vj0R80kHgF
	BSBv7AC5OEf/wpDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA34B139D0;
	Thu, 15 May 2025 11:28:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W2AqOdLPJWjPcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 May 2025 11:28:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B8829A08CF; Thu, 15 May 2025 13:28:13 +0200 (CEST)
Date: Thu, 15 May 2025 13:28:13 +0200
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] fs/open: make chmod_common() and chown_common()
 killable
Message-ID: <2jll2ujfh2r2x54imkto3suaoe7h76ypokeaybrqdvwo2sromb@a7ep7dnpmfi3>
References: <20250513150327.1373061-1-max.kellermann@ionos.com>
 <20250513150327.1373061-2-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513150327.1373061-2-max.kellermann@ionos.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -3.80

On Tue 13-05-25 17:03:25, Max Kellermann wrote:
> Allows killing processes that are waiting for the inode lock.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2: split into separate patches
> 
> This part was reviewed by Christian Brauner here:
>  https://lore.kernel.org/linux-fsdevel/20250512-unrat-kapital-2122d3777c5d@brauner/
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/open.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index a9063cca9911..d2f2df52c458 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -635,7 +635,9 @@ int chmod_common(const struct path *path, umode_t mode)
>  	if (error)
>  		return error;
>  retry_deleg:
> -	inode_lock(inode);
> +	error = inode_lock_killable(inode);
> +	if (error)
> +		goto out_mnt_unlock;
>  	error = security_path_chmod(path, mode);
>  	if (error)
>  		goto out_unlock;
> @@ -650,6 +652,7 @@ int chmod_common(const struct path *path, umode_t mode)
>  		if (!error)
>  			goto retry_deleg;
>  	}
> +out_mnt_unlock:
>  	mnt_drop_write(path->mnt);
>  	return error;
>  }
> @@ -769,7 +772,9 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
>  		return -EINVAL;
>  	if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
>  		return -EINVAL;
> -	inode_lock(inode);
> +	error = inode_lock_killable(inode);
> +	if (error)
> +		return error;
>  	if (!S_ISDIR(inode->i_mode))
>  		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
>  				     setattr_should_drop_sgid(idmap, inode);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

