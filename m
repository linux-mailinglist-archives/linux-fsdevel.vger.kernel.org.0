Return-Path: <linux-fsdevel+bounces-24440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B74993F4A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D791C21F97
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76018146A7A;
	Mon, 29 Jul 2024 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2g3LkMPn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQ4M86Hl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2g3LkMPn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qQ4M86Hl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4691465BF;
	Mon, 29 Jul 2024 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722254066; cv=none; b=WHYLlyJNlZ8TZSRNN3NFrUCIS8VTWtZEnSVxKp02LmrtqhK1XBMrRp4UMr27nTlLt604DliaNFd2tCWDHZ0C7FzqKtUuWdJ0Cm9ijRM0/In0ZoNcbJi3KgxNf47Fl2BzX9098Oqm6FzPDSCwBvJu3GaOenO+trIiWlYWfdvXA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722254066; c=relaxed/simple;
	bh=UrngsJxAjbcM3AqLgJFjWlmGMAo8MzvPgh7YUPnf/gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LU5fHdrZGe+XvWAoNx+42iNFUk+eUhrequ5MQM3YJeYY8nlM441a8bJCz/WaSkb5OOTpjAX7MTxGHP25x8gkvLknEugFjD2DAGscU2aT7mIRiVo9uaTCiY4eMHpa/bvrDJSsCHV7pfpYla0agXwBPXP/esM+qRqmFdAnvLtWTB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2g3LkMPn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQ4M86Hl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2g3LkMPn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qQ4M86Hl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F3941F790;
	Mon, 29 Jul 2024 11:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722254063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uX7eQ/l/4mqf+N2I4GzExoJxI/EcAEkLiNq+ZdMk+XE=;
	b=2g3LkMPnPq6lrL+t2tOVYsxhaLYtJlMi12ywxUDpQuAAAIB8Z8Fnrj0/Nq/BMRHLVvonrs
	XH+UAUS/NfqjI2ZV2z7Te5gBjhmq9nhyr6X3ERydbarvf+U1f+t67p8P9q0NCuoesghf4g
	sr5j8I3YmMaR3oKAEi92aoxR2ISpiMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722254063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uX7eQ/l/4mqf+N2I4GzExoJxI/EcAEkLiNq+ZdMk+XE=;
	b=qQ4M86HlpJAvtYTKqfJxGRnzR3u7nQ533lmgZHpuMwPE0FQOfU8JfUDaAKtvEBJaEfNp+g
	vTD5EqhAUppeoSDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2g3LkMPn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qQ4M86Hl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722254063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uX7eQ/l/4mqf+N2I4GzExoJxI/EcAEkLiNq+ZdMk+XE=;
	b=2g3LkMPnPq6lrL+t2tOVYsxhaLYtJlMi12ywxUDpQuAAAIB8Z8Fnrj0/Nq/BMRHLVvonrs
	XH+UAUS/NfqjI2ZV2z7Te5gBjhmq9nhyr6X3ERydbarvf+U1f+t67p8P9q0NCuoesghf4g
	sr5j8I3YmMaR3oKAEi92aoxR2ISpiMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722254063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uX7eQ/l/4mqf+N2I4GzExoJxI/EcAEkLiNq+ZdMk+XE=;
	b=qQ4M86HlpJAvtYTKqfJxGRnzR3u7nQ533lmgZHpuMwPE0FQOfU8JfUDaAKtvEBJaEfNp+g
	vTD5EqhAUppeoSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41618138A7;
	Mon, 29 Jul 2024 11:54:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RdDrD++Cp2bOOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Jul 2024 11:54:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CFDB4A099C; Mon, 29 Jul 2024 13:54:18 +0200 (CEST)
Date: Mon, 29 Jul 2024 13:54:18 +0200
From: Jan Kara <jack@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk, nathan@kernel.org,
	linux-fsdevel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH AUTOSEL 6.10 02/16] fs: remove accidental overflow during
 wraparound check
Message-ID: <20240729115418.xzfmanyqtipkuttx@quack3>
References: <20240728004739.1698541-1-sashal@kernel.org>
 <20240728004739.1698541-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728004739.1698541-2-sashal@kernel.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5F3941F790
X-Spam-Score: -3.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,chromium.org:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]

On Sat 27-07-24 20:47:19, Sasha Levin wrote:
> From: Justin Stitt <justinstitt@google.com>
> 
> [ Upstream commit 23cc6ef6fd453b13502caae23130844e7d6ed0fe ]

Sasha, this commit is only about silencing false-positive UBSAN warning.
Not sure if it is really a stable material...

								Honza

> 
> Running syzkaller with the newly enabled signed integer overflow
> sanitizer produces this report:
> 
> [  195.401651] ------------[ cut here ]------------
> [  195.404808] UBSAN: signed-integer-overflow in ../fs/open.c:321:15
> [  195.408739] 9223372036854775807 + 562984447377399 cannot be represented in type 'loff_t' (aka 'long long')
> [  195.414683] CPU: 1 PID: 703 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00039-g14de58dbe653-dirty #11
> [  195.420138] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  195.425804] Call Trace:
> [  195.427360]  <TASK>
> [  195.428791]  dump_stack_lvl+0x93/0xd0
> [  195.431150]  handle_overflow+0x171/0x1b0
> [  195.433640]  vfs_fallocate+0x459/0x4f0
> ...
> [  195.490053] ------------[ cut here ]------------
> [  195.493146] UBSAN: signed-integer-overflow in ../fs/open.c:321:61
> [  195.497030] 9223372036854775807 + 562984447377399 cannot be represented in type 'loff_t' (aka 'long long)
> [  195.502940] CPU: 1 PID: 703 Comm: syz-executor.0 Not tainted 6.8.0-rc2-00039-g14de58dbe653-dirty #11
> [  195.508395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  195.514075] Call Trace:
> [  195.515636]  <TASK>
> [  195.517000]  dump_stack_lvl+0x93/0xd0
> [  195.519255]  handle_overflow+0x171/0x1b0
> [  195.521677]  vfs_fallocate+0x4cb/0x4f0
> [  195.524033]  __x64_sys_fallocate+0xb2/0xf0
> 
> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang. It was re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").
> 
> Let's use the check_add_overflow helper to first verify the addition
> stays within the bounds of its type (long long); then we can use that
> sum for the following check.
> 
> Link: https://github.com/llvm/llvm-project/pull/82432 [1]
> Closes: https://github.com/KSPP/linux/issues/356
> Cc: linux-hardening@vger.kernel.org
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Link: https://lore.kernel.org/r/20240513-b4-sio-vfs_fallocate-v2-1-db415872fb16@google.com
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/open.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index 278b3edcda444..1dd123ba34ee9 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -247,6 +247,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  {
>  	struct inode *inode = file_inode(file);
>  	long ret;
> +	loff_t sum;
>  
>  	if (offset < 0 || len <= 0)
>  		return -EINVAL;
> @@ -319,8 +320,11 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
>  		return -ENODEV;
>  
> -	/* Check for wrap through zero too */
> -	if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))
> +	/* Check for wraparound */
> +	if (check_add_overflow(offset, len, &sum))
> +		return -EFBIG;
> +
> +	if (sum > inode->i_sb->s_maxbytes)
>  		return -EFBIG;
>  
>  	if (!file->f_op->fallocate)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

