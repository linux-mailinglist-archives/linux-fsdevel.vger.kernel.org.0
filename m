Return-Path: <linux-fsdevel+bounces-48353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6803AAADD20
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9FB506248
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0015D21772A;
	Wed,  7 May 2025 11:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EohNEwa2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KrazE4Qj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27D23kXM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9e80TSQm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35381B4F09
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616722; cv=none; b=KVD9uyreGaqs/FpTOrbr2YjxEL3rLwQue3MgK/q8I6uH1/gJ2rwSl3pbTg4J5mN8Nt+Demxz1hk4qBBpNYaEFk7WnwpIccLv1u2LmpTAX3H1sL1rXv21cqh6mt4SsCe9SpDeeyTPopCAyKPouRYEsTwRFOFoDFuk57jWqVw/M9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616722; c=relaxed/simple;
	bh=++IIt5AXAnXvfPvElINfcP5GZ/KLYdtQPJbOnyI3Qhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0OJ3OBOmLd7dBqDBk0mI0krsyX9CsdhgPUj6GQ8utzXWlnd9iJjEz+3BN9vPtDTJPUqGgBlbliXKQKcanVITSKTPp7y8xMneu7KR/kMNL+WaskJmdu34rPB1mDCki62EW1a5t6Wg6c4rvbTyGV9a8q2Q4ceZyGWYGJH/tQJjTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EohNEwa2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KrazE4Qj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27D23kXM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9e80TSQm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4AF91F394;
	Wed,  7 May 2025 11:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746616719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykR9RpzV7dXMsLmTY/LMhxYmcP2gKBaAJzGs2X1h3vU=;
	b=EohNEwa2UOJzK7B2CPzCxfXNPvEADHG1MDU25cPfHL6JPC/yx/w1BV8lahlgnTaHOpBgho
	Ryqx2Upe+meSO4+wBOey+upJfTMvDIHqKMmcdEejbdK7a6rF/JNMBJEWTeNqz05QZobcJ3
	LgV0kzadUmXqkrNGz1y4QYVY9s+YZLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746616719;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykR9RpzV7dXMsLmTY/LMhxYmcP2gKBaAJzGs2X1h3vU=;
	b=KrazE4QjQ6BXgqdV21ehkMI+yB45D7QB8uxx7ld4I9qGi4IRx8STHTor3ZEwPUOEhYs0v5
	UdOO0U+fvUSehzDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746616718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykR9RpzV7dXMsLmTY/LMhxYmcP2gKBaAJzGs2X1h3vU=;
	b=27D23kXMJv4CUQnS/Y8MKo0iFrebmw3PU3Jk1FgJmCy7lW8uHjA5T9V4EFl4eB40ODU1Z0
	NqAUrBiE1lZPw71UUprglynSyandszXnF2a17IXsZtA/Cz6f9mV46rKNw9fUikSLi2lpLp
	HN1zkI5S9AfCrplCSasm+Ik0gP6kJu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746616718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykR9RpzV7dXMsLmTY/LMhxYmcP2gKBaAJzGs2X1h3vU=;
	b=9e80TSQmTpNqDI1tx8DkoO3M8ymwY0CAQyP9E2ADTKaRUrWGpSx1chxSg9Z7DjhfpCf5DR
	BC5Sdbd39fH3DwAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2BAA13882;
	Wed,  7 May 2025 11:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4fVuM45BG2jMHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 May 2025 11:18:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9314DA09BE; Wed,  7 May 2025 13:18:34 +0200 (CEST)
Date: Wed, 7 May 2025 13:18:34 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH] fs: allow nesting with FREEZE_EXCL
Message-ID: <m2bvkh2v56akvvomku4w6n4lbw3zkc2awlutijndb7cc3tuirz@o64zcabrekch>
References: <ilwyxf34ixfkhbylev6d76tz5ufzg2sdxxhy6i3tr4ko5dbefr@57yuviqrftzr>
 <20250404-work-freeze-v1-1-31f9a26f7bc9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-work-freeze-v1-1-31f9a26f7bc9@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,kernel.org,hansenpartnership.com,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Fri 04-04-25 12:24:09, Christian Brauner wrote:
> If hibernation races with filesystem freezing (e.g. DM reconfiguration),
> then hibernation need not freeze a filesystem because it's already
> frozen but userspace may thaw the filesystem before hibernation actually
> happens.
> 
> If the race happens the other way around, DM reconfiguration may
> unexpectedly fail with EBUSY.
> 
> So allow FREEZE_EXCL to nest with other holders. An exclusive freezer
> cannot be undone by any of the other concurrent freezers.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

This has fallen through the cracks in my inbox but the patch now looks good
to me. Maybe we should fold it into "fs: add owner of freeze/thaw" to not
have strange intermediate state in the series?

								Honza

> ---
>  fs/super.c         | 71 ++++++++++++++++++++++++++++++++++++++++++------------
>  include/linux/fs.h |  2 +-
>  2 files changed, 56 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index b4bdbc509dba..e2fee655fbed 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1979,26 +1979,34 @@ static inline int freeze_dec(struct super_block *sb, enum freeze_holder who)
>  	return sb->s_writers.freeze_kcount + sb->s_writers.freeze_ucount;
>  }
>  
> -static inline bool may_freeze(struct super_block *sb, enum freeze_holder who)
> +static inline bool may_freeze(struct super_block *sb, enum freeze_holder who,
> +			      const void *freeze_owner)
>  {
> +	lockdep_assert_held(&sb->s_umount);
> +
>  	WARN_ON_ONCE((who & ~FREEZE_FLAGS));
>  	WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
>  
>  	if (who & FREEZE_EXCL) {
>  		if (WARN_ON_ONCE(!(who & FREEZE_HOLDER_KERNEL)))
>  			return false;
> -
> -		if (who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL))
> +		if (WARN_ON_ONCE(who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL)))
>  			return false;
> -
> -		return (sb->s_writers.freeze_kcount +
> -			sb->s_writers.freeze_ucount) == 0;
> +		if (WARN_ON_ONCE(!freeze_owner))
> +			return false;
> +		/* This freeze already has a specific owner. */
> +		if (sb->s_writers.freeze_owner)
> +			return false;
> +		/*
> +		 * This is already frozen multiple times so we're just
> +		 * going to take a reference count and mark it as
> +		 * belonging to use.
> +		 */
> +		if (sb->s_writers.freeze_kcount + sb->s_writers.freeze_ucount)
> +			sb->s_writers.freeze_owner = freeze_owner;
> +		return true;
>  	}
>  
> -	/* This filesystem is already exclusively frozen. */
> -	if (sb->s_writers.freeze_owner)
> -		return false;
> -
>  	if (who & FREEZE_HOLDER_KERNEL)
>  		return (who & FREEZE_MAY_NEST) ||
>  		       sb->s_writers.freeze_kcount == 0;
> @@ -2011,20 +2019,51 @@ static inline bool may_freeze(struct super_block *sb, enum freeze_holder who)
>  static inline bool may_unfreeze(struct super_block *sb, enum freeze_holder who,
>  				const void *freeze_owner)
>  {
> +	lockdep_assert_held(&sb->s_umount);
> +
>  	WARN_ON_ONCE((who & ~FREEZE_FLAGS));
>  	WARN_ON_ONCE(hweight32(who & FREEZE_HOLDERS) > 1);
>  
>  	if (who & FREEZE_EXCL) {
> -		if (WARN_ON_ONCE(sb->s_writers.freeze_owner == NULL))
> -			return false;
>  		if (WARN_ON_ONCE(!(who & FREEZE_HOLDER_KERNEL)))
>  			return false;
> -		if (who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL))
> +		if (WARN_ON_ONCE(who & ~(FREEZE_EXCL | FREEZE_HOLDER_KERNEL)))
> +			return false;
> +		if (WARN_ON_ONCE(!freeze_owner))
> +			return false;
> +		if (WARN_ON_ONCE(sb->s_writers.freeze_kcount == 0))
>  			return false;
> -		return sb->s_writers.freeze_owner == freeze_owner;
> +		/* This isn't exclusively frozen. */
> +		if (!sb->s_writers.freeze_owner)
> +			return false;
> +		/* This isn't exclusively frozen by us. */
> +		if (sb->s_writers.freeze_owner != freeze_owner)
> +			return false;
> +		/*
> +		 * This is still frozen multiple times so we're just
> +		 * going to drop our reference count and undo our
> +		 * exclusive freeze.
> +		 */
> +		if ((sb->s_writers.freeze_kcount + sb->s_writers.freeze_ucount) > 1)
> +			sb->s_writers.freeze_owner = NULL;
> +		return true;
> +	}
> +
> +	if (who & FREEZE_HOLDER_KERNEL) {
> +		/*
> +		 * Someone's trying to steal the reference belonging to
> +		 * @sb->s_writers.freeze_owner.
> +		 */
> +		if (sb->s_writers.freeze_kcount == 1 &&
> +		    sb->s_writers.freeze_owner)
> +			return false;
> +		return sb->s_writers.freeze_kcount > 0;
>  	}
>  
> -	return sb->s_writers.freeze_owner == NULL;
> +	if (who & FREEZE_HOLDER_USERSPACE)
> +		return sb->s_writers.freeze_ucount > 0;
> +
> +	return false;
>  }
>  
>  /**
> @@ -2095,7 +2134,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
>  
>  retry:
>  	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
> -		if (may_freeze(sb, who))
> +		if (may_freeze(sb, who, freeze_owner))
>  			ret = !!WARN_ON_ONCE(freeze_inc(sb, who) == 1);
>  		else
>  			ret = -EBUSY;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 1edcba3cd68e..7a3f821d2723 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2270,7 +2270,7 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
>   * @FREEZE_HOLDER_KERNEL: kernel wants to freeze or thaw filesystem
>   * @FREEZE_HOLDER_USERSPACE: userspace wants to freeze or thaw filesystem
>   * @FREEZE_MAY_NEST: whether nesting freeze and thaw requests is allowed
> - * @FREEZE_EXCL: whether actual freezing must be done by the caller
> + * @FREEZE_EXCL: a freeze that can only be undone by the owner
>   *
>   * Indicate who the owner of the freeze or thaw request is and whether
>   * the freeze needs to be exclusive or can nest.
> 
> ---
> base-commit: a83fe97e0d53f7d2b0fc62fd9a322a963cb30306
> change-id: 20250404-work-freeze-5eacb515f044
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

