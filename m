Return-Path: <linux-fsdevel+bounces-45324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C98A763BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 12:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408473A5095
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E861DF247;
	Mon, 31 Mar 2025 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IAnRZeIk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZFb6nJi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IAnRZeIk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2ZFb6nJi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFB7DA6C
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743415321; cv=none; b=GghhOBQ9I4Eq8YWn+5TSTEFD5FzK2U9+DsHIiFPo9Nu+2eoCpEdqNQZgoaYXeNiEPfgTDQpZxFMSXMTkVh+MY9+x33vt42L2WpDbLB7v2tmapakawMlJasIvE0WilEfOqL1tW5jBT7XsrU1DG0Xc2pbTfZKyxVwSyEwrpumUusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743415321; c=relaxed/simple;
	bh=wINThV8MCs1gmEXCriW8R1ijCf4qF5SCwaHPzlHYskY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi5rwR48ZAVL7KD61tqxRq+MRBlHzXhCP3XwYxkAUqoR0+i8czU8GUKmQW+a9h95H7rb5eT2VCqtSnLgSvGBf+dnHVFG/kq3nrulLQ4f5tHOUsBsVDtqTx5ofav26WMO+O7D0V55XJOwHxhxpyJh/XviB36d+tH6/HGq3VtdmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IAnRZeIk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZFb6nJi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IAnRZeIk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2ZFb6nJi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4727821182;
	Mon, 31 Mar 2025 10:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fkZHlP21fdVhSIfnEK/lkvtlj2PjrF6gtTTECJx/Hdo=;
	b=IAnRZeIke9ibeqb+1ZqyvI+ikGKKvC420OnzAvqFeHETrgdKuDkt6DWhVjbnV0yyT2qs1E
	7NdizimSDq5kw3zzDssMyC8AYBBLNMiIEwF3nLhczX/1d4OF19MVjSJCBaTLiNEkHQLl80
	3VZp6TEQuN9wQc22vxuqzuufisZR5Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fkZHlP21fdVhSIfnEK/lkvtlj2PjrF6gtTTECJx/Hdo=;
	b=2ZFb6nJitUxbwjr9hOuKNKnThwB09EVrZ8RgsPd27tkam2E+gMYr91cbEOkMoktniucQ5p
	4Z9Xte+TyIxE/CBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IAnRZeIk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2ZFb6nJi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743415318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fkZHlP21fdVhSIfnEK/lkvtlj2PjrF6gtTTECJx/Hdo=;
	b=IAnRZeIke9ibeqb+1ZqyvI+ikGKKvC420OnzAvqFeHETrgdKuDkt6DWhVjbnV0yyT2qs1E
	7NdizimSDq5kw3zzDssMyC8AYBBLNMiIEwF3nLhczX/1d4OF19MVjSJCBaTLiNEkHQLl80
	3VZp6TEQuN9wQc22vxuqzuufisZR5Qc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743415318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fkZHlP21fdVhSIfnEK/lkvtlj2PjrF6gtTTECJx/Hdo=;
	b=2ZFb6nJitUxbwjr9hOuKNKnThwB09EVrZ8RgsPd27tkam2E+gMYr91cbEOkMoktniucQ5p
	4Z9Xte+TyIxE/CBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39A8513A1F;
	Mon, 31 Mar 2025 10:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TJwQDhZo6mdeXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 10:01:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DEE3FA08D2; Mon, 31 Mar 2025 12:01:57 +0200 (CEST)
Date: Mon, 31 Mar 2025 12:01:57 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, rafael@kernel.org, 
	djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 4/6] super: use a common iterator (Part 1)
Message-ID: <slv42oamhqmazebk42ka66gwbdenxm33as5vmz5djmt5weejrh@exf5sck3j2lb>
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org>
 <20250329-work-freeze-v2-4-a47af37ecc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250329-work-freeze-v2-4-a47af37ecc3d@kernel.org>
X-Rspamd-Queue-Id: 4727821182
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
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,hansenpartnership.com,kernel.org,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 29-03-25 09:42:17, Christian Brauner wrote:
> Use a common iterator for all callbacks.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Very nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c         | 67 +++++++++++-------------------------------------------
>  include/linux/fs.h |  6 ++++-
>  2 files changed, 18 insertions(+), 55 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index c67ea3cdda41..0dd208804a74 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -887,37 +887,7 @@ void drop_super_exclusive(struct super_block *sb)
>  }
>  EXPORT_SYMBOL(drop_super_exclusive);
>  
> -static void __iterate_supers(void (*f)(struct super_block *))
> -{
> -	struct super_block *sb, *p = NULL;
> -
> -	spin_lock(&sb_lock);
> -	list_for_each_entry(sb, &super_blocks, s_list) {
> -		if (super_flags(sb, SB_DYING))
> -			continue;
> -		sb->s_count++;
> -		spin_unlock(&sb_lock);
> -
> -		f(sb);
> -
> -		spin_lock(&sb_lock);
> -		if (p)
> -			__put_super(p);
> -		p = sb;
> -	}
> -	if (p)
> -		__put_super(p);
> -	spin_unlock(&sb_lock);
> -}
> -/**
> - *	iterate_supers - call function for all active superblocks
> - *	@f: function to call
> - *	@arg: argument to pass to it
> - *
> - *	Scans the superblock list and calls given function, passing it
> - *	locked superblock and given argument.
> - */
> -void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
> +void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl)
>  {
>  	struct super_block *sb, *p = NULL;
>  
> @@ -927,14 +897,13 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  
>  		if (super_flags(sb, SB_DYING))
>  			continue;
> -
>  		sb->s_count++;
>  		spin_unlock(&sb_lock);
>  
> -		locked = super_lock_shared(sb);
> +		locked = super_lock(sb, excl);
>  		if (locked) {
>  			f(sb, arg);
> -			super_unlock_shared(sb);
> +			super_unlock(sb, excl);
>  		}
>  
>  		spin_lock(&sb_lock);
> @@ -1111,11 +1080,9 @@ int reconfigure_super(struct fs_context *fc)
>  	return retval;
>  }
>  
> -static void do_emergency_remount_callback(struct super_block *sb)
> +static void do_emergency_remount_callback(struct super_block *sb, void *unused)
>  {
> -	bool locked = super_lock_excl(sb);
> -
> -	if (locked && sb->s_root && sb->s_bdev && !sb_rdonly(sb)) {
> +	if (sb->s_bdev && !sb_rdonly(sb)) {
>  		struct fs_context *fc;
>  
>  		fc = fs_context_for_reconfigure(sb->s_root,
> @@ -1126,13 +1093,11 @@ static void do_emergency_remount_callback(struct super_block *sb)
>  			put_fs_context(fc);
>  		}
>  	}
> -	if (locked)
> -		super_unlock_excl(sb);
>  }
>  
>  static void do_emergency_remount(struct work_struct *work)
>  {
> -	__iterate_supers(do_emergency_remount_callback);
> +	__iterate_supers(do_emergency_remount_callback, NULL, true);
>  	kfree(work);
>  	printk("Emergency Remount complete\n");
>  }
> @@ -1148,24 +1113,18 @@ void emergency_remount(void)
>  	}
>  }
>  
> -static void do_thaw_all_callback(struct super_block *sb)
> +static void do_thaw_all_callback(struct super_block *sb, void *unused)
>  {
> -	bool locked = super_lock_excl(sb);
> -
> -	if (locked && sb->s_root) {
> -		if (IS_ENABLED(CONFIG_BLOCK))
> -			while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
> -				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
> -		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
> -		return;
> -	}
> -	if (locked)
> -		super_unlock_excl(sb);
> +	if (IS_ENABLED(CONFIG_BLOCK))
> +		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
> +			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
> +	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
> +	return;
>  }
>  
>  static void do_thaw_all(struct work_struct *work)
>  {
> -	__iterate_supers(do_thaw_all_callback);
> +	__iterate_supers(do_thaw_all_callback, NULL, true);
>  	kfree(work);
>  	printk(KERN_WARNING "Emergency Thaw complete\n");
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 016b0fe1536e..0351500b71d2 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3515,7 +3515,11 @@ extern void put_filesystem(struct file_system_type *fs);
>  extern struct file_system_type *get_fs_type(const char *name);
>  extern void drop_super(struct super_block *sb);
>  extern void drop_super_exclusive(struct super_block *sb);
> -extern void iterate_supers(void (*)(struct super_block *, void *), void *);
> +void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl);
> +static inline void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
> +{
> +	__iterate_supers(f, arg, false);
> +}
>  extern void iterate_supers_type(struct file_system_type *,
>  			        void (*)(struct super_block *, void *), void *);
>  
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

