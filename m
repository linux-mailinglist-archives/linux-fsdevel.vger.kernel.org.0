Return-Path: <linux-fsdevel+bounces-14143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A674087856A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 17:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0D31C21A8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBDB4D9F0;
	Mon, 11 Mar 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tK7oi/Mw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rlDwVZ60";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KsuQBzSG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jzhtDdT0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251D34AEF3;
	Mon, 11 Mar 2024 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174252; cv=none; b=IdZrPsrTCNbd1JGO+wO86vjg9Mczmyi21FeOEYq4uKjLzSJrWoGaOSVGRRGyqWl72B/QiwtUa3vPhM9SSOPm9gaknYvfyU5FQOq4jlH/S1XI0ynOYA78gSqlbWB1TqAPyVPu5wLDvlJjrUFBWpZ183Tvn2+hckAvYwcDa73hrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174252; c=relaxed/simple;
	bh=56yF8ItREGrogJnMekkXuqeHvYyuZSYZRhgsK/vBcDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiOixwMEgXn/cOcX+nwlRb5/ewme5qTQPjXcgVvTP+7ciAS2zgtw9MkzUF1K9aMwCppdwpYFsdeBAuywWAd1Ab5BGWjUQa9CU9Jnr1HDAVdcrvkiGdqSSPWWewb/N2asqwVqynHl/fGkAF0QZ+V3uFTwETTOKBAJW1Zf8vrD3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tK7oi/Mw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rlDwVZ60; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KsuQBzSG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jzhtDdT0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6676A5C922;
	Mon, 11 Mar 2024 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710174248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gviz5aamPw6bk1Yn/7A3J9/ubb5Bc95XhumqFeNN1XY=;
	b=tK7oi/MwDjs5+QGIyJm895NxQuZCxk1I3xYUasuE7NieqDMvUF35GyFsnezsxvGrl+qvrc
	Ch31f59wUdyKJ0w4F9lzbpYlCGu8bH0lg5n06h2/I40lEevzULkTgaT5zoLdNXYg7/S7UN
	I3ZMTvcQeN9mEeewsmOz2e+vy4SHN0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710174248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gviz5aamPw6bk1Yn/7A3J9/ubb5Bc95XhumqFeNN1XY=;
	b=rlDwVZ60gnNkXjgzoRpSqjKQwHVZf0C/DnFnoLKhzaW2kyJPXLVGnUOGUWwqXcDeuhJwQ3
	qUFIhNWD5i5KjpAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710174246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gviz5aamPw6bk1Yn/7A3J9/ubb5Bc95XhumqFeNN1XY=;
	b=KsuQBzSGY3fEOHsRlsOsznJCdxQICyIoKDdm8Vn+f3w8nW9qrRwT+90/WKF4gKu2+jsrPr
	AY8JL5VPPhzyFwXyG3cHIzPRbQjjODfIG4WSZn5Y1VKdhHxcvClHIfcEzzWTWIq6tn6cIH
	3rygFR4sJsvRTOEoQ7QV4KBtN7Jl3MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710174246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gviz5aamPw6bk1Yn/7A3J9/ubb5Bc95XhumqFeNN1XY=;
	b=jzhtDdT0N+uL90UQCPBu9X87oMs/u+fIl3ARPtRp7x4/3oZcymnuXyZVy7sbdQ2XtitIBV
	GgZdtqq/mSUSenCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BC711395F;
	Mon, 11 Mar 2024 16:24:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kLtdFiYw72VwFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 Mar 2024 16:24:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 158D6A0807; Mon, 11 Mar 2024 17:24:06 +0100 (CET)
Date: Mon, 11 Mar 2024 17:24:06 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: Simplify remove_arg_zero() error path
Message-ID: <20240311162406.7vc64qbta24psk3j@quack3>
References: <20240309214826.work.449-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309214826.work.449-kees@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KsuQBzSG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jzhtDdT0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.78 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.77)[84.37%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,linux.org.uk:email,chromium.org:email,kvack.org:email,suse.com:email,xmission.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.78
X-Rspamd-Queue-Id: 6676A5C922
X-Spam-Flag: NO

On Sat 09-03-24 13:48:30, Kees Cook wrote:
> We don't need the "out" label any more, so remove "ret" and return
> directly on error.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/exec.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 715e1a8aa4f0..e7d9d6ad980b 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1720,7 +1720,6 @@ static int prepare_binprm(struct linux_binprm *bprm)
>   */
>  int remove_arg_zero(struct linux_binprm *bprm)
>  {
> -	int ret = 0;
>  	unsigned long offset;
>  	char *kaddr;
>  	struct page *page;
> @@ -1731,10 +1730,8 @@ int remove_arg_zero(struct linux_binprm *bprm)
>  	do {
>  		offset = bprm->p & ~PAGE_MASK;
>  		page = get_arg_page(bprm, bprm->p, 0);
> -		if (!page) {
> -			ret = -EFAULT;
> -			goto out;
> -		}
> +		if (!page)
> +			return -EFAULT;
>  		kaddr = kmap_local_page(page);
>  
>  		for (; offset < PAGE_SIZE && kaddr[offset];
> @@ -1748,8 +1745,7 @@ int remove_arg_zero(struct linux_binprm *bprm)
>  	bprm->p++;
>  	bprm->argc--;
>  
> -out:
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL(remove_arg_zero);
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

