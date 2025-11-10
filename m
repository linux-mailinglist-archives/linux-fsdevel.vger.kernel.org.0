Return-Path: <linux-fsdevel+bounces-67674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1ACC46252
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 12:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6DA3AD552
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AC53074A0;
	Mon, 10 Nov 2025 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WJTdAEO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aMA1X8IV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WJTdAEO3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aMA1X8IV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83C2EBB88
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 11:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772969; cv=none; b=Df43yVUyCsEcHk4w4CL8UBEMKEjZ7Erz5siz/vryjDdsrcGT0CKvdGnXMVoC+dv2F9PzyO8u6RGbgEgAMdazchkeWsuUKnMY8xnLk0+k1o2eAd8SBqvMEPsfirc09ePvoVqhZRX9dBg7C2XT9K+1auXFkagiKXprpktZ/p/hiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772969; c=relaxed/simple;
	bh=+KBmRNafak3ap++2xlrc7kNHO3YO/fkS8Attg973XVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijqIm3SEuPhy3aabHobye7zv4NfwIO74qPxonIZR128+enc3v4wMMwjDIYC0BFttvyhKc2gw4k08yMqLyLX6VUkBzLT9dFXAVHXkwwsYDdSM6ZI+oIRL6bsVJWv76z7CzMkgzeJyo1TAUExoRW8U7/P3o5przgOmH/FTFsT9jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WJTdAEO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aMA1X8IV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WJTdAEO3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aMA1X8IV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 471FD1F445;
	Mon, 10 Nov 2025 11:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762772966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vt+M+VE2AxdsqecB1TrhGicB97Adif/19QV7IHqEko8=;
	b=WJTdAEO3bx3/vooEh/U5MUUU9lZW4tQDPFjRgAxXD7Af/IiDWZlUnB2oHuNWtK5l08rOzm
	w2tkw6bqSumVvk8RIC6COPDChLilRql2JoduRFahCasvynqcFs0dXI63K8QYdGmPklfd0u
	9yhTcSYh16wueMAmTHsCGVlWYFlJxRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762772966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vt+M+VE2AxdsqecB1TrhGicB97Adif/19QV7IHqEko8=;
	b=aMA1X8IV3LNrHhnTLxcUAG8nmTM+TVN31/2lQZrfabwCN47VMgWIDXVIZGG+VmCIAdTRz6
	PAxSxxMqHvrhQmBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762772966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vt+M+VE2AxdsqecB1TrhGicB97Adif/19QV7IHqEko8=;
	b=WJTdAEO3bx3/vooEh/U5MUUU9lZW4tQDPFjRgAxXD7Af/IiDWZlUnB2oHuNWtK5l08rOzm
	w2tkw6bqSumVvk8RIC6COPDChLilRql2JoduRFahCasvynqcFs0dXI63K8QYdGmPklfd0u
	9yhTcSYh16wueMAmTHsCGVlWYFlJxRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762772966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vt+M+VE2AxdsqecB1TrhGicB97Adif/19QV7IHqEko8=;
	b=aMA1X8IV3LNrHhnTLxcUAG8nmTM+TVN31/2lQZrfabwCN47VMgWIDXVIZGG+VmCIAdTRz6
	PAxSxxMqHvrhQmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BB0A1436F;
	Mon, 10 Nov 2025 11:09:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BnuODubHEWlESgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 11:09:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D592FA28B1; Mon, 10 Nov 2025 12:09:25 +0100 (CET)
Date: Mon, 10 Nov 2025 12:09:25 +0100
From: Jan Kara <jack@suse.cz>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] futex: Store time as ktime_t in restart block
Message-ID: <qzqldbanacnrdwtqbgplxmgucfzijelq5mhciyykldok6pocwr@mdkezu5pinxa>
References: <20251110-restart-block-expiration-v1-0-5d39cc93df4f@linutronix.de>
 <20251110-restart-block-expiration-v1-2-5d39cc93df4f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110-restart-block-expiration-v1-2-5d39cc93df4f@linutronix.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 10-11-25 10:38:52, Thomas Weiﬂschuh wrote:
> The futex core uses ktime_t to represent times,
> use that also for the restart block.
> 
> This also allows the simplification of the accessors.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/restart_block.h | 2 +-
>  kernel/futex/waitwake.c       | 9 ++++-----
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
> index 0798a4ae67c6c75749c38c4673ab8ea012261319..3c2bd13f609120a8a914f6e738ffea97bf72c32d 100644
> --- a/include/linux/restart_block.h
> +++ b/include/linux/restart_block.h
> @@ -33,7 +33,7 @@ struct restart_block {
>  			u32 val;
>  			u32 flags;
>  			u32 bitset;
> -			u64 time;
> +			ktime_t time;
>  			u32 __user *uaddr2;
>  		} futex;
>  		/* For nanosleep */
> diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
> index e2bbe5509ec27a18785227358d4ff8d8f913ddc1..1c2dd03f11ec4e5d34d1a9f67ef01e05604b3bac 100644
> --- a/kernel/futex/waitwake.c
> +++ b/kernel/futex/waitwake.c
> @@ -738,12 +738,11 @@ int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time
>  static long futex_wait_restart(struct restart_block *restart)
>  {
>  	u32 __user *uaddr = restart->futex.uaddr;
> -	ktime_t t, *tp = NULL;
> +	ktime_t *tp = NULL;
> +
> +	if (restart->futex.flags & FLAGS_HAS_TIMEOUT)
> +		tp = &restart->futex.time;
>  
> -	if (restart->futex.flags & FLAGS_HAS_TIMEOUT) {
> -		t = restart->futex.time;
> -		tp = &t;
> -	}
>  	restart->fn = do_no_restart_syscall;
>  
>  	return (long)futex_wait(uaddr, restart->futex.flags,
> 
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

