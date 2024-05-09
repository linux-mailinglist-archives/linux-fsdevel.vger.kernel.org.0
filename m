Return-Path: <linux-fsdevel+bounces-19199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1498C124F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634752833B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 15:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83E716F836;
	Thu,  9 May 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mLK2/COY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="es8J8FjG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mLK2/COY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="es8J8FjG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5916F286;
	Thu,  9 May 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715270041; cv=none; b=VCVhfX3RuQDhFOYCSUjsKAy4k3/5RYsQ9mwt/yZfE53d/hCcp3pdQaCl4HQDxkWVLfmY1eyNcA0oqu3GzNug07+VPMv2xOI6XRGbQHJy69BwqEGCi3kjd05GhvMSaSPUr/jH3blXt9RsY3Avagj3zBvcjjhaLCPeS8bOYz2YzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715270041; c=relaxed/simple;
	bh=kgl7POulRwkv6guf3DOlw60s3g+R1sh3voqGVyv5uHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8L+oW57gbxAyr00oibiNtFfZCczYHSgaPui1lwGbnbdfQoW+pdwU0lAF2I6KF5qp+AIyhCwIDML+ItCyz8vLVCuvDntveU2ZUtwc+fqNA+M0Mq3o3UUx9g2Q16mhKhzXbquHZgCaqKiPwtXDyX4DWbAzxm53WipOi0spAcBQAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mLK2/COY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=es8J8FjG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mLK2/COY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=es8J8FjG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76F14388B9;
	Thu,  9 May 2024 15:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715270036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENRXJy8TOwBwRPUrho6blMoXPCSHd5Sswn+nQd1Hoc=;
	b=mLK2/COYDcvh0WfuZFsir5Gt2C9Fpi/+cSUp9GmF6mCcYSzybDkVE4iMEjMsjkmdwTItZD
	bP1XaXyqJEgIkPI9s20bE+lG/5eNSNn6N3K9jcGjC2qwXmpaemgQW58Z2d1fpsG8pA/kcE
	3BCKuHVGeumNL7EahtNjU2Mfc+gBPTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715270036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENRXJy8TOwBwRPUrho6blMoXPCSHd5Sswn+nQd1Hoc=;
	b=es8J8FjGXagPQbHbDg8VyS2kstKbPNTdaOSvVVxZW1e6aM3bWRE/tQeZA+bH84h973v5Hr
	PeKt7dh36+wFUJCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715270036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENRXJy8TOwBwRPUrho6blMoXPCSHd5Sswn+nQd1Hoc=;
	b=mLK2/COYDcvh0WfuZFsir5Gt2C9Fpi/+cSUp9GmF6mCcYSzybDkVE4iMEjMsjkmdwTItZD
	bP1XaXyqJEgIkPI9s20bE+lG/5eNSNn6N3K9jcGjC2qwXmpaemgQW58Z2d1fpsG8pA/kcE
	3BCKuHVGeumNL7EahtNjU2Mfc+gBPTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715270036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ENRXJy8TOwBwRPUrho6blMoXPCSHd5Sswn+nQd1Hoc=;
	b=es8J8FjGXagPQbHbDg8VyS2kstKbPNTdaOSvVVxZW1e6aM3bWRE/tQeZA+bH84h973v5Hr
	PeKt7dh36+wFUJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 696D913941;
	Thu,  9 May 2024 15:53:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0iG3GZTxPGZ9GwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 May 2024 15:53:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0ECB2A0861; Thu,  9 May 2024 17:53:56 +0200 (CEST)
Date: Thu, 9 May 2024 17:53:56 +0200
From: Jan Kara <jack@suse.cz>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: remove accidental overflow during wraparound check
Message-ID: <20240509155356.w274h4blmcykxej6@quack3>
References: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 07-05-24 23:17:57, Justin Stitt wrote:
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

Well, we compile the kernel with -fno-strict-overflow for a reason so I
wouldn't consider this a bug. But check_add_overflow() is easier to digest
since we don't have to worry about type details so I'm for this change.

> @@ -319,8 +320,12 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
>  		return -ENODEV;
>  
> -	/* Check for wrap through zero too */
> -	if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))
> +	/* Check for wraparound */
> +	if (check_add_overflow(offset, len, &sum))
> +		return -EFBIG;
> +
> +	/* Now, check bounds */
> +	if (sum > inode->i_sb->s_maxbytes || sum < 0)
>  		return -EFBIG;

But why do you check for sum < 0? We know from previous checks offset >= 0
&& len > 0 so unless we overflow, sum is guaranteed to be > 0.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

