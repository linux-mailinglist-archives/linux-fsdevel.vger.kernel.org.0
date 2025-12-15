Return-Path: <linux-fsdevel+bounces-71298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C456BCBD0FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 09:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36998302ABA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39882330333;
	Mon, 15 Dec 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QDg8RJ4d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBBuYG1o";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yr9u8eFR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Gn/PI5j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D872459FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788384; cv=none; b=qi1/vnTtMHXDGP78FcpNiMUj23tOA86Xfoa8pDgBhKV2V3WOK/oZ+2dQhXOLsjel6KlTzjm7vy0cIUf3KdEOQjj6B73JN89bv5dvRRYSk4jXwEqqg5svzBcm3U2iZZbWsZXAORQSt9pkBluNbbd4DkBR4GRGn9FHP15gYHwU4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788384; c=relaxed/simple;
	bh=dm184A/+6Dqyot/rqGSgpiulsmHLgefYTOAHynng6lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgej4oLF2RksgNtMRF4BGKAUbP/Cyd9GYENDLzRYlFLmDfO/mzHqUV2VIPhZZLKUGI9qAOkB91Dlpr40wuJanSplRhJ93K4aVdCURYZaIBxqbQXxdTxVfKTMH3TgExVXWPW3m3A20NimO8p2x9fcqOlxOv7NUOeeTaNuguWklVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QDg8RJ4d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBBuYG1o; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yr9u8eFR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Gn/PI5j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE3CB336AF;
	Mon, 15 Dec 2025 08:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765788380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/QXeAUf3kFRwiz7tA4aJhXkTwwMFk8KaQft9K/jHkc=;
	b=QDg8RJ4dhZKTk2BvV8pawHmsc2HPHhdHIza+hxeV6k66FwKyOQhPzFFI8uzYqp9JuMcmg3
	mNiDfa9nzj0wnZwHcuLFmstVxhO1ercARSKCGX+68mJmJjZwEDqYuY6qgRi5ael8OEdJKu
	42lHYOXf1Nj2e8bAsIZWI4Odofz397s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765788380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/QXeAUf3kFRwiz7tA4aJhXkTwwMFk8KaQft9K/jHkc=;
	b=wBBuYG1ojxpfgYakpYygIZ491/K5rNHmIMrgLEERJX9B028B57rffkXYgjdvQri4ZZsSFn
	fC2z7B92wFsUzLDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Yr9u8eFR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="3Gn/PI5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765788379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/QXeAUf3kFRwiz7tA4aJhXkTwwMFk8KaQft9K/jHkc=;
	b=Yr9u8eFRRe8SZQ4e8yzvzKeb7VdWWGN71edEgELPFM3xmTeON7HMROrV05IFv9yNhSzVLO
	t3oA6Johcxi1Qg5/LlTeiM3LZ9WtkVREsp9fVQttX0XJbg0dHP5X55OoLl5aBBukhCrPLL
	YU5zDmTBnkp12OfOpPGDOrZKpyZ9XY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765788379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/QXeAUf3kFRwiz7tA4aJhXkTwwMFk8KaQft9K/jHkc=;
	b=3Gn/PI5jA8uJCER4zlKZyb0UsTzAmT225pfv1MpokGbrsnhHTLGrZtG0cML4PQp4aEkCeV
	9k8y50OxmHZ+IHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3FF33EA63;
	Mon, 15 Dec 2025 08:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kGG5M9vKP2nbZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Dec 2025 08:46:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8089CA09B4; Mon, 15 Dec 2025 09:46:19 +0100 (CET)
Date: Mon, 15 Dec 2025 09:46:19 +0100
From: Jan Kara <jack@suse.cz>
To: me@black-desk.cn
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfs: fix EBUSY on FSCONFIG_CMD_CREATE retry
Message-ID: <k7kcsc6wljl32mik2qqwij23hjsqtxqbuq6a5gbu7r6z33vq5c@7jeeepio6jkd>
References: <20251213-mount-ebusy-v1-1-7b2907b7b0b2@black-desk.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251213-mount-ebusy-v1-1-7b2907b7b0b2@black-desk.cn>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[black-desk.cn:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: DE3CB336AF
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Sat 13-12-25 02:03:56, Chen Linxuan via B4 Relay wrote:
> From: Chen Linxuan <me@black-desk.cn>
> 
> When using fsconfig(..., FSCONFIG_CMD_CREATE, ...), the filesystem
> context is retrieved from the file descriptor. Since the file structure
> persists across syscall restarts, the context state is preserved:
> 
> 	// fs/fsopen.c
> 	SYSCALL_DEFINE5(fsconfig, ...)
> 	{
> 		...
> 		fc = fd_file(f)->private_data;
> 		...
> 		ret = vfs_fsconfig_locked(fc, cmd, &param);
> 		...
> 	}
> 
> In vfs_cmd_create(), the context phase is transitioned to
> FS_CONTEXT_CREATING before calling vfs_get_tree():
> 
> 	// fs/fsopen.c
> 	static int vfs_cmd_create(struct fs_context *fc, bool exclusive)
> 	{
> 		...
> 		fc->phase = FS_CONTEXT_CREATING;
> 		...
> 		ret = vfs_get_tree(fc);
> 		...
> 	}
> 
> However, vfs_get_tree() may return -ERESTARTNOINTR if the filesystem
> implementation needs to restart the syscall. For example, cgroup v1 does
> this when it encounters a race condition where the root is dying:
> 
> 	// kernel/cgroup/cgroup-v1.c
> 	int cgroup1_get_tree(struct fs_context *fc)
> 	{
> 		...
> 		if (unlikely(ret > 0)) {
> 			msleep(10);
> 			return restart_syscall();
> 		}
> 		return ret;
> 	}
> 
> If the syscall is restarted, fsconfig() is called again and retrieves
> the *same* fs_context. However, vfs_cmd_create() rejects the call
> because the phase was left as FS_CONTEXT_CREATING during the first
> attempt:

Well, not quite. The phase is actually set to FS_CONTEXT_FAILED if
vfs_get_tree() returns any error. Still the effect is the same.

> 	if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
> 		return -EBUSY;
> 
> Fix this by resetting fc->phase back to FS_CONTEXT_CREATE_PARAMS if
> vfs_get_tree() returns -ERESTARTNOINTR.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chen Linxuan <me@black-desk.cn>
> ---
>  fs/fsopen.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/fsopen.c b/fs/fsopen.c
> index f645c99204eb..8a7cb031af50 100644
> --- a/fs/fsopen.c
> +++ b/fs/fsopen.c
> @@ -229,6 +229,10 @@ static int vfs_cmd_create(struct fs_context *fc, bool exclusive)
>  	fc->exclusive = exclusive;
>  
>  	ret = vfs_get_tree(fc);
> +	if (ret == -ERESTARTNOINTR) {
> +		fc->phase = FS_CONTEXT_CREATE_PARAMS;
> +		return ret;
> +	}
>  	if (ret) {
>  		fc->phase = FS_CONTEXT_FAILED;
>  		return ret;

Thanks for the patch. It looks good to me. I'd slightly prefer style like:

	if (ret) {
		if (ret == -ERESTARTNOINTR)
			fc->phase = FS_CONTEXT_CREATE_PARAMS;
		else
			fc->phase = FS_CONTEXT_FAILED;
		return ret;
	}

but I can live with what you propose as well. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

