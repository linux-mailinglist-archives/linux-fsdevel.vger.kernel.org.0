Return-Path: <linux-fsdevel+bounces-44211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC3A659D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4440189B947
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB52F1B0F0B;
	Mon, 17 Mar 2025 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bFBZk2aD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iq9Ui5SA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bFBZk2aD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iq9Ui5SA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913D1A5B8E
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230989; cv=none; b=m7Pva5aHaGHZAetgHWR6cTvNS9uaQIij8DG3/pq3IIXfRJixUJHIn62b/MdfjF9megMQnZTGnmmEttBNrAwOIS+nt17EsarwDb1A+grmwB6BwecsBMbBq4NCZSmgGTCIvovTPCyFS+6wNM3IXI2GOopOtlAbLtaJz15jkxb24TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230989; c=relaxed/simple;
	bh=Y1lEL/P4AAiBvQvEgf/V9bLVgFS07sJXZXwE6QLB2xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjQOBIh1o9ZXY0yY39Ji93NAPKibmF/nhR3zU06xzV6Zp9s47WJZ8iOddhYdf1kKg63+anV9KSz6qXMLAaXxtIDgnowvpEtznJcHCWTSVgqFYFGoz1WDu4wSCO7KckxFm5OL0k6ncoYUiobNTqJTLobEb9TKVxhwXuhP1bBQmJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bFBZk2aD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iq9Ui5SA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bFBZk2aD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iq9Ui5SA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21B8F21E86;
	Mon, 17 Mar 2025 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742230985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7RtdBLjUX5HzImX3cp7Yd+vB9keMyW7jPADEVYMiqJE=;
	b=bFBZk2aD0h1n5a+TV5nRhJbYYc/h8Wy0v0Dca60oPC5fHbfb+a89UCUB0kT/WgF2nnORGI
	DaQ3Se37zw56DBrpXYsUhGP8zwr5FG0wY1nVpkUfXExwp/C83LJnOp6xgE0CJ3kId7z3ue
	9Yt8c/E25oTz/ZLaxDr4oapqn4EzzQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742230985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7RtdBLjUX5HzImX3cp7Yd+vB9keMyW7jPADEVYMiqJE=;
	b=iq9Ui5SAn/BTMC27bpNHFa7AharG7H14agTMJLjN1OpYMhxmR4D/60sXnY9OxOODXWhmws
	M5wL9TAIy+ioo6Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742230985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7RtdBLjUX5HzImX3cp7Yd+vB9keMyW7jPADEVYMiqJE=;
	b=bFBZk2aD0h1n5a+TV5nRhJbYYc/h8Wy0v0Dca60oPC5fHbfb+a89UCUB0kT/WgF2nnORGI
	DaQ3Se37zw56DBrpXYsUhGP8zwr5FG0wY1nVpkUfXExwp/C83LJnOp6xgE0CJ3kId7z3ue
	9Yt8c/E25oTz/ZLaxDr4oapqn4EzzQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742230985;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7RtdBLjUX5HzImX3cp7Yd+vB9keMyW7jPADEVYMiqJE=;
	b=iq9Ui5SAn/BTMC27bpNHFa7AharG7H14agTMJLjN1OpYMhxmR4D/60sXnY9OxOODXWhmws
	M5wL9TAIy+ioo6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 052EB139D2;
	Mon, 17 Mar 2025 17:03:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 83DvAMlV2GfvIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Mar 2025 17:03:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 94636A09A8; Mon, 17 Mar 2025 18:03:04 +0100 (CET)
Date: Mon, 17 Mar 2025 18:03:04 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use wq_has_sleeper() in end_dir_add()
Message-ID: <apadfckxgxx46eten4sftyiay5nnbuopnph5oagnch6lyrtd3r@cgpwxge6bzs3>
References: <20250316232421.1642758-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316232421.1642758-1-mjguzik@gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 17-03-25 00:24:21, Mateusz Guzik wrote:
> The routine is used a lot, while the wakeup almost never has anyone to
> deal with.
> 
> wake_up_all() takes an irq-protected spinlock, wq_has_sleeper() "only"
> contains a full fence -- not free by any means, but still cheaper.
> 
> Sample result tracing waiters using a custom probe during -j 20 kernel
> build (0 - no waiters, 1 - waiters):
> 
> @[
>     wakeprobe+5
>     __wake_up_common+63
>     __wake_up+54
>     __d_add+234
>     d_splice_alias+146
>     ext4_lookup+439
>     path_openat+1746
>     do_filp_open+195
>     do_sys_openat2+153
>     __x64_sys_openat+86
>     do_syscall_64+82
>     entry_SYSCALL_64_after_hwframe+118
> ]:
> [0, 1)             13999 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [1, ...)               1 |                                                    |
> 
> So that 14000 calls in total from this backtrace, where only one time
> had a waiter.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index df8833fe9986..bd5aa136153a 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2497,7 +2497,8 @@ static inline void end_dir_add(struct inode *dir, unsigned int n,
>  {
>  	smp_store_release(&dir->i_dir_seq, n + 2);
>  	preempt_enable_nested();
> -	wake_up_all(d_wait);
> +	if (wq_has_sleeper(d_wait))
> +		wake_up_all(d_wait);
>  }
>  
>  static void d_wait_lookup(struct dentry *dentry)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

