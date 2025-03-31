Return-Path: <linux-fsdevel+bounces-45321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D35A763A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67EDF3A9072
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 09:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4429B1DEFF5;
	Mon, 31 Mar 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJy1Gy+c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ss9aSS41";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JJy1Gy+c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ss9aSS41"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EA41DEFE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415074; cv=none; b=N72U9o3a7OnWc5Dlw3YaCxGKbvIb/uxz3X96LdEdsMuPLN+1nEKh5xfkG9PSs8YJwR7boeBRz2+Jd2TQDnlmoR/oSnlIJF7sKgHlX/if3ocgvYR1HcCWnSU9SSXKXR78Piv4uEHRLu4OpCBaxtuTLWnYoHw5Erz5UUD+eZ+fYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415074; c=relaxed/simple;
	bh=OcTHLvkTGaKUrpLGvtcFwEvIOA69PmtdXZKjZ2GHb3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+4fRBRKm1R+iOjJ9e+Z0MWRwYtD830Kp9NDLUHUWGrVpJh5MuIRLuDST//QfBympz/FYwPCWI1v34RTUDaIpeDczi+U3K5xees3tVaU3WYU2+2utL+bsldXNzMgNz0q54ramiaqPLL23IU4kKus+8dI1wl1+hTCVrQzL46MB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJy1Gy+c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ss9aSS41; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JJy1Gy+c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ss9aSS41; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BF421F397;
	Mon, 31 Mar 2025 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/uVGROm7NbGf07qjMoGWaLre3v600WXXwwyGI557Dc=;
	b=JJy1Gy+cltgTq3xDo62iRQYRKyDbychpPN2dBnegLZCFjrxOtulRrQV1qHtyOsdal93wzE
	TSGO5G2xBrIeZqNAsOqP5/JOwsBRY0K7N9LRC4rLlEpUX5lUTz0nvKF5RpdpEzTLnbTtHM
	Wzn6+0/xUBmpwFjt+yPuM77+hbY4sw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/uVGROm7NbGf07qjMoGWaLre3v600WXXwwyGI557Dc=;
	b=ss9aSS41uvpTReO6eiA/hpSddGvtPYEa1heZi+DyQ0qBd1Eq8lAjHeyQ5Mqu4ZUvZr6apW
	xeIvGNzrLY6vmjCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JJy1Gy+c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ss9aSS41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/uVGROm7NbGf07qjMoGWaLre3v600WXXwwyGI557Dc=;
	b=JJy1Gy+cltgTq3xDo62iRQYRKyDbychpPN2dBnegLZCFjrxOtulRrQV1qHtyOsdal93wzE
	TSGO5G2xBrIeZqNAsOqP5/JOwsBRY0K7N9LRC4rLlEpUX5lUTz0nvKF5RpdpEzTLnbTtHM
	Wzn6+0/xUBmpwFjt+yPuM77+hbY4sw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/uVGROm7NbGf07qjMoGWaLre3v600WXXwwyGI557Dc=;
	b=ss9aSS41uvpTReO6eiA/hpSddGvtPYEa1heZi+DyQ0qBd1Eq8lAjHeyQ5Mqu4ZUvZr6apW
	xeIvGNzrLY6vmjCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28E2B13A56;
	Mon, 31 Mar 2025 09:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IvfyCR9n6mcEWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 09:57:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4C74A08D2; Mon, 31 Mar 2025 11:57:50 +0200 (CEST)
Date: Mon, 31 Mar 2025 11:57:50 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 1/6] super: remove pointless s_root checks
Message-ID: <qgq3uzlrllywodaazal2e6hde45pxz6jixp77uhi6lfkkpp6wt@uhf5zirhm3ex>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-1-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329-work-freeze-v2-1-a47af37ecc3d@kernel.org>
X-Rspamd-Queue-Id: 3BF421F397
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,hansenpartnership.com,kernel.org,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 29-03-25 09:42:14, Christian Brauner wrote:
> The locking guarantees that the superblock is alive and sb->s_root is
> still set. Remove the pointless check.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. In fact most sb->s_root checks in fs/super.c look pointless
these days since AFAICT if you have SB_BORN && !SB_DYING superblock (as
super_lock_*() ascertains), then sb->s_root != NULL. Anyway feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 97a17f9d9023..dc14f4bf73a6 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -930,8 +930,7 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  
>  		locked = super_lock_shared(sb);
>  		if (locked) {
> -			if (sb->s_root)
> -				f(sb, arg);
> +			f(sb, arg);
>  			super_unlock_shared(sb);
>  		}
>  
> @@ -967,11 +966,8 @@ void iterate_supers_type(struct file_system_type *type,
>  		spin_unlock(&sb_lock);
>  
>  		locked = super_lock_shared(sb);
> -		if (locked) {
> -			if (sb->s_root)
> -				f(sb, arg);
> -			super_unlock_shared(sb);
> -		}
> +		if (locked)
> +			f(sb, arg);
>  
>  		spin_lock(&sb_lock);
>  		if (p)
> @@ -991,18 +987,15 @@ struct super_block *user_get_super(dev_t dev, bool excl)
>  
>  	spin_lock(&sb_lock);
>  	list_for_each_entry(sb, &super_blocks, s_list) {
> -		if (sb->s_dev ==  dev) {
> +		if (sb->s_dev == dev) {
>  			bool locked;
>  
>  			sb->s_count++;
>  			spin_unlock(&sb_lock);
>  			/* still alive? */
>  			locked = super_lock(sb, excl);
> -			if (locked) {
> -				if (sb->s_root)
> -					return sb;
> -				super_unlock(sb, excl);
> -			}
> +			if (locked)
> +				return sb; /* caller will drop */
>  			/* nope, got unmounted */
>  			spin_lock(&sb_lock);
>  			__put_super(sb);
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

