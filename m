Return-Path: <linux-fsdevel+bounces-45419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69194A7775E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 11:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFDF3AB70D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185A81EDA12;
	Tue,  1 Apr 2025 09:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WMz+80oi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Duab3wO6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WMz+80oi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Duab3wO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E409A1EDA01
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Apr 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498986; cv=none; b=NEordJwdQyO5NV1UTidnxJVZgTJ2AGrFLI8U4YbSHF/P2Z1R12Tofpf8LK+m1M/bLlxZddKwvOSBxwL591JUTNZ/gXO5IQ3gVu6ajVtE16fp1phqRFwC6XZcfTSZOpZa0bNRWLQnf4auIHdpityqBpdaTetTaOXKfzbjobOXR5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498986; c=relaxed/simple;
	bh=+nik7Tvg/51eI/Ya5TbSY9360OoLrYMzidLK4vZ8VJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbcrcJ0XDspUtQPsDO43HDCqpvlYFzGIen+3YEs+0UOMEBOOAInzUL5TcWoKdCGqJkM4LCF3Cox6sUuIAzf9LCXGyxNANfYPoNvwOWvp3tskCDCqjNhK07VuN4wS6bilQSunFT4gLPc0IEdYCCWtq+iDgJzkQ/3XV4LATz3NTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WMz+80oi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Duab3wO6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WMz+80oi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Duab3wO6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B2CF21163;
	Tue,  1 Apr 2025 09:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743498983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzwqT88FUUmuP4AeS3GXYNARxly+cJCGN2uYTtENPOI=;
	b=WMz+80oiWTnt+wgSYRY3BWpRfzNbsDh+xtMUG6fYoyjnefOGmeNfdAcqABiGELQ7sWq6aO
	In6LzW2Bhd0qgCmdZcElCQ5Vzge+cwsK54/wDpktAPM8PXvlqVdoSuQXGdJCnY+OzHA0w5
	DF4tLtG1Xg4XutHZSKCl8FcTvoKFp/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743498983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzwqT88FUUmuP4AeS3GXYNARxly+cJCGN2uYTtENPOI=;
	b=Duab3wO6fcVOjauoKDE5fxUOXyv1I9nCe1GyAjkpaacwgQEpQqojg6Juf/XIXFB21dY6q9
	g729rfSXpE/uewAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743498983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzwqT88FUUmuP4AeS3GXYNARxly+cJCGN2uYTtENPOI=;
	b=WMz+80oiWTnt+wgSYRY3BWpRfzNbsDh+xtMUG6fYoyjnefOGmeNfdAcqABiGELQ7sWq6aO
	In6LzW2Bhd0qgCmdZcElCQ5Vzge+cwsK54/wDpktAPM8PXvlqVdoSuQXGdJCnY+OzHA0w5
	DF4tLtG1Xg4XutHZSKCl8FcTvoKFp/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743498983;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzwqT88FUUmuP4AeS3GXYNARxly+cJCGN2uYTtENPOI=;
	b=Duab3wO6fcVOjauoKDE5fxUOXyv1I9nCe1GyAjkpaacwgQEpQqojg6Juf/XIXFB21dY6q9
	g729rfSXpE/uewAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0919913691;
	Tue,  1 Apr 2025 09:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7pHmAeeu62fwegAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Apr 2025 09:16:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5A7EA07E6; Tue,  1 Apr 2025 11:16:18 +0200 (CEST)
Date: Tue, 1 Apr 2025 11:16:18 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH 1/6] ext4: replace kthread freezing with auto fs freezing
Message-ID: <z3zqumhqgzq3agjps4ufdcqqrgip7t7xtr6v5kymchkdjfnwhp@i76pwshkydig>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
 <20250401-work-freeze-v1-1-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401-work-freeze-v1-1-d000611d4ab0@kernel.org>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,kernel.org,hansenpartnership.com,infradead.org,fromorbit.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 01-04-25 02:32:46, Christian Brauner wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> The kernel power management now supports allowing the VFS
> to handle filesystem freezing freezes and thawing. Take advantage
> of that and remove the kthread freezing. This is needed so that we
> properly really stop IO in flight without races after userspace
> has been frozen. Without this we rely on kthread freezing and
> its semantics are loose and error prone.
> 
> The filesystem therefore is in charge of properly dealing with
> quiescing of the filesystem through its callbacks if it thinks
> it knows better than how the VFS handles it.
> 
> The following Coccinelle rule was used as to remove the now superfluous
> freezer calls:
> 
> make coccicheck MODE=patch SPFLAGS="--in-place --no-show-diff" COCCI=./fs-freeze-cleanup.cocci M=fs/ext4
> 
> virtual patch
> 
> @ remove_set_freezable @
> expression time;
> statement S, S2;
> expression task, current;
> @@
> 
> (
> -       set_freezable();
> |
> -       if (try_to_freeze())
> -               continue;
> |
> -       try_to_freeze();
> |
> -       freezable_schedule();
> +       schedule();
> |
> -       freezable_schedule_timeout(time);
> +       schedule_timeout(time);
> |
> -       if (freezing(task)) { S }
> |
> -       if (freezing(task)) { S }
> -       else
> 	    { S2 }
> |
> -       freezing(current)
> )
> 
> @ remove_wq_freezable @
> expression WQ_E, WQ_ARG1, WQ_ARG2, WQ_ARG3, WQ_ARG4;
> identifier fs_wq_fn;
> @@
> 
> (
>     WQ_E = alloc_workqueue(WQ_ARG1,
> -                              WQ_ARG2 | WQ_FREEZABLE,
> +                              WQ_ARG2,
> 			   ...);
> |
>     WQ_E = alloc_workqueue(WQ_ARG1,
> -                              WQ_ARG2 | WQ_FREEZABLE | WQ_ARG3,
> +                              WQ_ARG2 | WQ_ARG3,
> 			   ...);
> |
>     WQ_E = alloc_workqueue(WQ_ARG1,
> -                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE,
> +                              WQ_ARG2 | WQ_ARG3,
> 			   ...);
> |
>     WQ_E = alloc_workqueue(WQ_ARG1,
> -                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE | WQ_ARG4,
> +                              WQ_ARG2 | WQ_ARG3 | WQ_ARG4,
> 			   ...);
> |
> 	    WQ_E =
> -               WQ_ARG1 | WQ_FREEZABLE
> +               WQ_ARG1
> |
> 	    WQ_E =
> -               WQ_ARG1 | WQ_FREEZABLE | WQ_ARG3
> +               WQ_ARG1 | WQ_ARG3
> |
>     fs_wq_fn(
> -               WQ_FREEZABLE | WQ_ARG2 | WQ_ARG3
> +               WQ_ARG2 | WQ_ARG3
>     )
> |
>     fs_wq_fn(
> -               WQ_FREEZABLE | WQ_ARG2
> +               WQ_ARG2
>     )
> |
>     fs_wq_fn(
> -               WQ_FREEZABLE
> +               0
>     )
> )
> 
> @ add_auto_flag @
> expression E1;
> identifier fs_type;
> @@
> 
> struct file_system_type fs_type = {
> 	.fs_flags = E1
> +                   | FS_AUTOFREEZE
> 	,
> };
> 
> Generated-by: Coccinelle SmPL
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Link: https://lore.kernel.org/r/20250326112220.1988619-5-mcgrof@kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/ext4/mballoc.c | 2 +-
>  fs/ext4/super.c   | 3 ---
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 0d523e9fb3d5..ae235ec5ff3a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6782,7 +6782,7 @@ static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
>  
>  static bool ext4_trim_interrupted(void)
>  {
> -	return fatal_signal_pending(current) || freezing(current);
> +	return fatal_signal_pending(current);
>  }

This change should not happen. ext4_trim_interrupted() makes sure FITRIM
ioctl doesn't cause hibernation failures and has nothing to do with kthread
freezing...

Otherwise the patch looks good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

