Return-Path: <linux-fsdevel+bounces-70668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B06CCA3F09
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 15:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4073301BCDA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 14:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C12B3321D8;
	Thu,  4 Dec 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cNJdUYNk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CxWhE6Z0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="viIvpZAR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s8GKyRTi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5786D398F90
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764857242; cv=none; b=UwanrJGGfdFFs5Ipqvs9KFelwPEGz/Rzs1eelbtji8OnVgR8MiugeRwbti3C2HuVG3XSMeQ6LoGmccApY3gVpSqrHdw8OAVvokeVlSNpRheQIUY0oU30kRK2LcZDJ+epAPeolgEldoEKoH66L5Tg1rXr5BIYK+62U6kjhKTE8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764857242; c=relaxed/simple;
	bh=5sEXu9BiauggCrHwGfIwB7iP9vf9Wg7I2+bA68GCoWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuM6Q8UhmujdaX5r674UoRMZEBN+iirOokMMLSw8dXQ0LLiUw0IbQfCIuWBozDvDgVKiroM3OB2GiLvzc3LH/F2X0hHWTW+k4yNn8KQWp+YxwqpKAGB+LQCiEL46E1rrpnazWfR+HQd+6M0+S0Gotl3N31sGFm8gmZRQkEkZrfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cNJdUYNk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CxWhE6Z0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=viIvpZAR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s8GKyRTi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C6543372C;
	Thu,  4 Dec 2025 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764857238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KunlljhTGfo4uOVtnLiOglrl8rA6gprvRNmzNCw7y8o=;
	b=cNJdUYNkzbqbwSh9IObBtp0jonMNqAUBFk80PqNpIL40gSrHBXKb8ObXoMrDseg9TD+wtU
	U8rF2v3ZZ4a3JmMLPMYZymD9iGD0XdZ2hxLH3ZwbNOEihbSdhWIJDMRp89pgn/wK4YUdsF
	LNIdUhYpGCpamaguiyfPXx0LGaFjCpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764857238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KunlljhTGfo4uOVtnLiOglrl8rA6gprvRNmzNCw7y8o=;
	b=CxWhE6Z0h4Jfmd1bzkhDEODVki58DoBLAoEG3pFV9WrA45ckcUdDplEv5dKJqNUmukkfgJ
	PkHSjGBZUIjPKaCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=viIvpZAR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=s8GKyRTi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764857237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KunlljhTGfo4uOVtnLiOglrl8rA6gprvRNmzNCw7y8o=;
	b=viIvpZAR0zCcNbVaMtB/CT5rC27YTxwpUbnfcKWn2sxHaP20Ig/MO/E8ewL5KAS0YC1JfG
	C4JRvAQ/AZwVvs3sklu050dD0/Yn9Hr88z6o+iIemHM/C0IjdcfvTB7OX6OvBXZnrUnWRq
	cILuE5c3GJb4nTWxSWGo7ixOMhBanyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764857237;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KunlljhTGfo4uOVtnLiOglrl8rA6gprvRNmzNCw7y8o=;
	b=s8GKyRTiru1NRNuR5m3Ni5Xwy8YDFpfh8GWfeRcdAX5qrK67FJ/QhXvdcIl4IbpclblSzs
	wg0bFyusLZG8B6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E3623EA63;
	Thu,  4 Dec 2025 14:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GMn3CpWVMWliUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Dec 2025 14:07:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C51AAA09A3; Thu,  4 Dec 2025 15:07:16 +0100 (CET)
Date: Thu, 4 Dec 2025 15:07:16 +0100
From: Jan Kara <jack@suse.cz>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+40f42779048f7476e2e0@syzkaller.appspotmail.com, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] mqueue: correct the type of ro to int
Message-ID: <i77q2nmmx6jfbqnbgbxlvnz3aauj3pfq6xroo25xslonc4ordy@4cxsxhcrwc3u>
References: <69315929.a70a0220.2ea503.00d8.GAE@google.com>
 <tencent_369728EA76ED36CD98793A6D942C956C4C0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_369728EA76ED36CD98793A6D942C956C4C0A@qq.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 3C6543372C
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[qq.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[40f42779048f7476e2e0];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Thu 04-12-25 21:16:22, Edward Adam Davis wrote:
> The ro variable, being of type bool, caused the -EROFS return value from
> mnt_want_write() to be implicitly converted to 1. This prevented the file
> from being correctly acquired, thus triggering the issue reported by
> syzbot [1].
> 
> Changing the type of ro to int allows the system to correctly identify
> the reason for the file open failure.
> 
> [1]
> KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
> Call Trace:
>  do_mq_open+0x5a0/0x770 ipc/mqueue.c:932
>  __do_sys_mq_open ipc/mqueue.c:945 [inline]
>  __se_sys_mq_open ipc/mqueue.c:938 [inline]
>  __x64_sys_mq_open+0x16a/0x1c0 ipc/mqueue.c:938
> 
> Fixes: f2573685bd0c ("ipc: convert do_mq_open() to FD_ADD()")
> Reported-by: syzbot+40f42779048f7476e2e0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=40f42779048f7476e2e0
> Tested-by: syzbot+40f42779048f7476e2e0@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

Ah, indeed. mqueue_file_open() was returning ERR_PTR(1) which was confusing
FD_ADD error handling. Thanks for debugging this! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  ipc/mqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 56e811f9e5fa..90664d26ec07 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -893,7 +893,7 @@ static int prepare_open(struct dentry *dentry, int oflag, int ro,
>  }
>  
>  static struct file *mqueue_file_open(struct filename *name,
> -				     struct vfsmount *mnt, int oflag, bool ro,
> +				     struct vfsmount *mnt, int oflag, int ro,
>  				     umode_t mode, struct mq_attr *attr)
>  {
>  	struct dentry *dentry;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

