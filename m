Return-Path: <linux-fsdevel+bounces-31465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9A7997276
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 18:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880892810B6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B731A3AAD;
	Wed,  9 Oct 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i4kvVtlI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qw1Thf14";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i4kvVtlI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qw1Thf14"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C638F1991B6;
	Wed,  9 Oct 2024 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492994; cv=none; b=fCcZB/t5E2etJxUA3JpPa5qghJd2aWAZ5/JOLwytvxXT7eQhK8hM7Kc5xX/YTfTluE5x+A5lPcG9KUspNvAxnxz3VJvbRYXReBR3/YS9L/J882yBOkOjhhxhe0IMm2LcX4zCrLrN6jDK7x7HEtFW5t/rr9MntUFpy6d2/8ZB7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492994; c=relaxed/simple;
	bh=Y1f6IJnRYF29Eq3PI5vgzdeUr9Mbsns9nINXOjdPA24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=alYpbQRt7rZ4eYYOZ+VwEgGCdMFHVJRKoksUn1NNVOljCCYf8sfCXbM7nv0Z+ovC7DDwmQZEuAQWIgraorkk47eY3VSgyZdcOdcJXdRLKt6OvedPCnZarbPrkdxTVUvqPy/6bnYlbSrG/T0Wxtbglq0W3NUOQyKoAz/QxOYOKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i4kvVtlI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qw1Thf14; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i4kvVtlI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qw1Thf14; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCC0921DF8;
	Wed,  9 Oct 2024 16:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728492990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGD59A1e01pYnN95FgLMB7cBzpem21vRVd0iHeQxI9A=;
	b=i4kvVtlIYgqKd6zbBLyq8zZDIliQmrsklGtM9mmzi/8lWEU+FZX0LsyiNKJH1sQejxf2mE
	tV9RYjkHwpco4Jrx3NC/P5KZwTRp0MuI8nM18h3n54jgwrGtRT1vwM9NSpquK6Cxgv+Yfa
	hsZSFU+h/FGNfv9Cf9WeWrmPnhYMQqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728492990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGD59A1e01pYnN95FgLMB7cBzpem21vRVd0iHeQxI9A=;
	b=qw1Thf14tCfqXymtv7D9JwyaIZIMQHyIpIKWUW+mu7XtmMrdcBm49k4CAcMWuPOjFnZqAr
	zkfEcaycF/NiuMCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i4kvVtlI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qw1Thf14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728492990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGD59A1e01pYnN95FgLMB7cBzpem21vRVd0iHeQxI9A=;
	b=i4kvVtlIYgqKd6zbBLyq8zZDIliQmrsklGtM9mmzi/8lWEU+FZX0LsyiNKJH1sQejxf2mE
	tV9RYjkHwpco4Jrx3NC/P5KZwTRp0MuI8nM18h3n54jgwrGtRT1vwM9NSpquK6Cxgv+Yfa
	hsZSFU+h/FGNfv9Cf9WeWrmPnhYMQqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728492990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MGD59A1e01pYnN95FgLMB7cBzpem21vRVd0iHeQxI9A=;
	b=qw1Thf14tCfqXymtv7D9JwyaIZIMQHyIpIKWUW+mu7XtmMrdcBm49k4CAcMWuPOjFnZqAr
	zkfEcaycF/NiuMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3A91136BA;
	Wed,  9 Oct 2024 16:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /GPYK761BmeHcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 16:56:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51F82A0896; Wed,  9 Oct 2024 18:56:26 +0200 (CEST)
Date: Wed, 9 Oct 2024 18:56:26 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: grab current_time() in setattr_copy_mgtime() when
 ATTR_CTIME is unset
Message-ID: <20241009165626.wwuy4gcwkjy2sc6n@quack3>
References: <20241009-mgtime-v1-1-383b9e0481b5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009-mgtime-v1-1-383b9e0481b5@kernel.org>
X-Rspamd-Queue-Id: BCC0921DF8
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 09-10-24 12:26:32, Jeff Layton wrote:
> With support of delegated timestamps, nfsd can issue a setattr that sets
> the atime, but not the ctime. Ensure that when the ctime isn't set that
> "now" is set to the current coarse-grained time.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Closes: https://lore.kernel.org/linux-fsdevel/20241009153022.5uyp6aku2kcfeexp@quack3/
> Fixes: d8d11298e8a1 ("fs: handle delegated timestamps in setattr_copy_mgtime")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> A fix for bug that Jan reported. Christian, it may be best to fold this
> into d8d11298e8a1.

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

although I agree with Jeff it's best to fold this into the original patch.

								Honza

> ---
>  fs/attr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/attr.c b/fs/attr.c
> index c614b954bda5244cc20ee82a98a8e68845f23bd7..9caf63d20d03e86c535e9c8c91d49c2a34d34b7a 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -298,6 +298,7 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
>  	} else {
>  		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
>  		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
> +		now = current_time(inode);
>  	}
>  
>  	if (ia_valid & ATTR_ATIME_SET)
> 
> ---
> base-commit: 109aff7a3b294d9dc0f49d33fc6746e8d27e46f6
> change-id: 20241009-mgtime-f672852d67cc
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

