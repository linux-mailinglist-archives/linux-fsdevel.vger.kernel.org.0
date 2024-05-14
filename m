Return-Path: <linux-fsdevel+bounces-19453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D678C5800
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB871F20FC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A19517BB27;
	Tue, 14 May 2024 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mzL707PF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kjYmueXO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mzL707PF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kjYmueXO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FCD144D01;
	Tue, 14 May 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715697204; cv=none; b=nm23dxwy5kTCXZk98jfahdyHHITrG/qcLbBdjAyVNOp+bIljdxnidjML2D0CWHeuKN8AVcwWy9t3kx5+F0HvHbssrU22lOz5pOneI63JBEUizMRcHwwdy/9v7F2Xeb24uHrCXwQlkuCH2GGOAgnNNl1+rydz7eMwXhRDr+sbmh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715697204; c=relaxed/simple;
	bh=3vP2d1BhUB6PM8bFMgiIuGPsXqeQHZ/ZrrORTNgR7nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/n/pfiojaH9cRn5g2CRyy1eABClPr+yU4C3kT6D90oJsEBXZc503BA6nxe4TGFiqAdBrEeUoSFmQEHHy5NtGIrMmMLRcs5jRImWHsHxOHsCaCHxViPHg8bdAk0YdBqyiU3b6oJ/THnOh0xFteSzmoES17jcOC0KZ/Ibc0/JWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mzL707PF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kjYmueXO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mzL707PF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kjYmueXO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50BB260CF4;
	Tue, 14 May 2024 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715697201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaWpSIyJedoUka8sdWkGBzyYmR9xVJ8HBD8/Du0duh0=;
	b=mzL707PFlrYZYnKLFGKxpAKro8LpD3geI6XczFCtUyPOgBKl/iQJovqsjRH6r+4xRFN41t
	6bg5dwiJqHCSbqNPhsu+DiiEtjHTas38WMhbcV6H7EinFNI5BusvnizDAklIrlFtF+5HPh
	qeq7nTXkCmFY9sU5GXPYiBaEgQbNTsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715697201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaWpSIyJedoUka8sdWkGBzyYmR9xVJ8HBD8/Du0duh0=;
	b=kjYmueXOJbxv7qD9Fkl8UmX2GsjEwxZ3YOwm6VuKYmsn3wCaEO9hP0Gv2DQGFjNqQMNTe3
	X/4nb7NhXWo+d0Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mzL707PF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kjYmueXO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715697201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaWpSIyJedoUka8sdWkGBzyYmR9xVJ8HBD8/Du0duh0=;
	b=mzL707PFlrYZYnKLFGKxpAKro8LpD3geI6XczFCtUyPOgBKl/iQJovqsjRH6r+4xRFN41t
	6bg5dwiJqHCSbqNPhsu+DiiEtjHTas38WMhbcV6H7EinFNI5BusvnizDAklIrlFtF+5HPh
	qeq7nTXkCmFY9sU5GXPYiBaEgQbNTsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715697201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XaWpSIyJedoUka8sdWkGBzyYmR9xVJ8HBD8/Du0duh0=;
	b=kjYmueXOJbxv7qD9Fkl8UmX2GsjEwxZ3YOwm6VuKYmsn3wCaEO9hP0Gv2DQGFjNqQMNTe3
	X/4nb7NhXWo+d0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB99A1372E;
	Tue, 14 May 2024 14:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LSt0OTB2Q2Y8PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 May 2024 14:33:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0DB0EA08B5; Tue, 14 May 2024 16:33:15 +0200 (CEST)
Date: Tue, 14 May 2024 16:33:15 +0200
From: Jan Kara <jack@suse.cz>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] fs: remove accidental overflow during wraparound check
Message-ID: <20240514143315.wxs3hnetssth2xt5@quack3>
References: <20240513-b4-sio-vfs_fallocate-v2-1-db415872fb16@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513-b4-sio-vfs_fallocate-v2-1-db415872fb16@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 50BB260CF4
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Mon 13-05-24 17:50:30, Justin Stitt wrote:
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

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - drop the sum < 0 check (thanks Jan)
> - carry along Kees' RB tag
> - Link to v1: https://lore.kernel.org/r/20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com
> ---
> Here's the syzkaller reproducer:
> r0 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file1\x00', 0x42, 0x0)
> fallocate(r0, 0x10, 0x7fffffffffffffff, 0x2000807fffff7)
> 
> ... which was used against Kees' tree here (v6.8rc2):
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer
> 
> ... with this config:
> https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
> ---
>  fs/open.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/open.c b/fs/open.c
> index ee8460c83c77..23849d487479 100644
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
> 
> ---
> base-commit: 0106679839f7c69632b3b9833c3268c316c0a9fc
> change-id: 20240507-b4-sio-vfs_fallocate-7b5223ba3a81
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

