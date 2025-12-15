Return-Path: <linux-fsdevel+bounces-71334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D603ACBDF04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A168301ADD9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 13:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ADC29BD87;
	Mon, 15 Dec 2025 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HkbO5ons";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W4iZSwLV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EGzgGE1v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/zTsccWZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB926B2D3
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803884; cv=none; b=oDGG9e4d98y4aHyssL/WERTkr/ByegLt8gujkZPUn9kAKAAKX2Jm+VVDDE9L82s6cKWPUnpqFXjvIncbv74Gsot6Yf8pwkK2618trEtt5nMIGl1ZpQ63eWQPFzTLSHmFzotQnbKyTMjD7JcSgsW7ZoSRTzzmgLDeBf7gEQ1VFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803884; c=relaxed/simple;
	bh=nhMX7FUupcm7a5FyQELnX4KZUKRLFAdhhl3hYqjy4Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVv6vv75/Yst8oR68S5FGSc3ClOhje1kN5MwOHr9xOdEUArTzkdIHJaSS8HFagiq0puyzBp1HVexUHaQJXmRPzYqC5arpKFxR4TRJZ/bRSJKTFNTENwunzZRW8IG1ShKgO40wufEBaLCPUfEoa11K8JA1eQBf9fZoOJsYva2p7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HkbO5ons; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W4iZSwLV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EGzgGE1v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/zTsccWZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 367FB3369F;
	Mon, 15 Dec 2025 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765803881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbmqYZ8jV/3jBHEf3Jr7Ltb+Mv+6trbgX6Q0Ddyw77g=;
	b=HkbO5ons71dq8TZZ7htB7bKmwS5nI0AWRn5vfMPGnL/tgIZ3xFwhhbaHMXl9nWc7l8/jNT
	CLsyWkEOd+/ka+JM/aHjAK/QMHqOsCUv3cqgP0SGm2XntBf70eY30IH35asSaXVrbWm6VA
	xqTbvMHlxIFPezNGA3rjpj2IbrffvUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765803881;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbmqYZ8jV/3jBHEf3Jr7Ltb+Mv+6trbgX6Q0Ddyw77g=;
	b=W4iZSwLVmAqE3AnslHy37RBamUYOvSukV/FQYDBw4F0OPn/tKavavottlftVS3nJfOffVh
	Av9D73dUX0ZSqOCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EGzgGE1v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/zTsccWZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765803880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbmqYZ8jV/3jBHEf3Jr7Ltb+Mv+6trbgX6Q0Ddyw77g=;
	b=EGzgGE1v1l17RaABdPyPYn5KjicmhD6jqap/LsnaBaM99bOhI9QQmiZfb9U9v2mjRlU64o
	R5q7k+dX1pH6E4z+BRqcGziOohhpZ0bL7fp5vKvexmfBY+N942wZf/Jcq8hL3vMsra7DWD
	88+G/8kS9g61yTT2TPY7cQn2EPIhBQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765803880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbmqYZ8jV/3jBHEf3Jr7Ltb+Mv+6trbgX6Q0Ddyw77g=;
	b=/zTsccWZWQpXVA21oY0CLyqBAqXDOpAJEvqP0ExOSMsj5U6PmrfsgZEsDV2SpOCCq1t0eh
	G+j7w+eazD8K3sBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D3793EA63;
	Mon, 15 Dec 2025 13:04:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qXEFC2gHQGnaUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Dec 2025 13:04:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E453FA0951; Mon, 15 Dec 2025 14:04:31 +0100 (CET)
Date: Mon, 15 Dec 2025 14:04:31 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, me@black-desk.cn, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] vfs: fix EBUSY on FSCONFIG_CMD_CREATE retry
Message-ID: <3jqjyw7p4sbnlle7y7qprlcf36siyqykkk6s7hjzfdhypyvwb4@mg6hu54lloff>
References: <20251213-mount-ebusy-v1-1-7b2907b7b0b2@black-desk.cn>
 <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd>
 <20251215-irdisch-aufkochen-d97a7a3ed4a3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-irdisch-aufkochen-d97a7a3ed4a3@brauner>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 367FB3369F
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 15-12-25 12:55:12, Christian Brauner wrote:
> On Mon, Dec 15, 2025 at 09:46:19AM +0100, Jan Kara wrote:
> > On Sat 13-12-25 02:03:56, Chen Linxuan via B4 Relay wrote:
> > > From: Chen Linxuan <me@black-desk.cn>
> > > 
> > > When using fsconfig(..., FSCONFIG_CMD_CREATE, ...), the filesystem
> > > context is retrieved from the file descriptor. Since the file structure
> > > persists across syscall restarts, the context state is preserved:
> > > 
> > > 	// fs/fsopen.c
> > > 	SYSCALL_DEFINE5(fsconfig, ...)
> > > 	{
> > > 		...
> > > 		fc = fd_file(f)->private_data;
> > > 		...
> > > 		ret = vfs_fsconfig_locked(fc, cmd, &param);
> > > 		...
> > > 	}
> > > 
> > > In vfs_cmd_create(), the context phase is transitioned to
> > > FS_CONTEXT_CREATING before calling vfs_get_tree():
> > > 
> > > 	// fs/fsopen.c
> > > 	static int vfs_cmd_create(struct fs_context *fc, bool exclusive)
> > > 	{
> > > 		...
> > > 		fc->phase = FS_CONTEXT_CREATING;
> > > 		...
> > > 		ret = vfs_get_tree(fc);
> > > 		...
> > > 	}
> > > 
> > > However, vfs_get_tree() may return -ERESTARTNOINTR if the filesystem
> > > implementation needs to restart the syscall. For example, cgroup v1 does
> > > this when it encounters a race condition where the root is dying:
> > > 
> > > 	// kernel/cgroup/cgroup-v1.c
> > > 	int cgroup1_get_tree(struct fs_context *fc)
> > > 	{
> > > 		...
> > > 		if (unlikely(ret > 0)) {
> > > 			msleep(10);
> > > 			return restart_syscall();
> > > 		}
> > > 		return ret;
> > > 	}
> > > 
> > > If the syscall is restarted, fsconfig() is called again and retrieves
> > > the *same* fs_context. However, vfs_cmd_create() rejects the call
> > > because the phase was left as FS_CONTEXT_CREATING during the first
> > > attempt:
> > 
> > Well, not quite. The phase is actually set to FS_CONTEXT_FAILED if
> > vfs_get_tree() returns any error. Still the effect is the same.
> 
> Uh, I'm not sure we should do this. If this only affects cgroup v1 then
> I say we should simply not care at all. It's a deprecated api and anyone
> using it uses something that is inherently broken and a big portion of
> userspace has already migrated. The current or upcoming systemd release
> has dropped all cgroup v1 support.
> 
> Generally, making fsconfig() restartable is not as trivial as it looks
> because once you called into the filesystem the config that was setup
> might have already been consumed. That's definitely the case for stuff
> in overlayfs and others. So no, that patch won't work and btw, I
> remembered that we already had that discussion a few years ago and I was
> right:
> 
> https://lore.kernel.org/20200923201958.b27ecda5a1e788fb5f472bcd@virtuozzo.com

I see. I was assuming that if the filesystem returns ERESTART* it will make
sure to not consume the context it wants to restart with. But I can see why
that might be too errorprone and not really worth the hassle in this case.
So fine by me if you don't want to go that route.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

