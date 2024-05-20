Return-Path: <linux-fsdevel+bounces-19796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4928C9CCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AAD1F2108C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2CB53E1A;
	Mon, 20 May 2024 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fsUmlYuo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6EKitTSP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KZ5b86gE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3XhpOVOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A71B960;
	Mon, 20 May 2024 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206335; cv=none; b=FSmjl9oyaUMdsvKP65KVkzbUY91ykhVGW+qwPgpwJYkaK5TbwCHRXMjQcveJAGwCSzJHkJHHz0uGX+7vAy3+tC8lsBRY2McUHeCTq6ABH/q6X+jAHscion41oac9J1w4L9jQpTzAoGzLAW2FbFlIgnoqSdfeAWTEa6wiiIWXVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206335; c=relaxed/simple;
	bh=bHNHl9JcLOSKGTPq7jvpEWQfUxyRDiDCngPc1F2Y4h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/ImfIGUNGzeLZYPnAfBR+ylt6yKfuruZlOEyDId+omTY+WPA97aIuWcHwRQ7lY/AFFRufVEm/OfB2V2TzgK8tGGgVo79Uv0fwiC9IbC0J0a/R3wcTCLVt/GLEaQYCKCJFm5UemohG7pAV9bAfD7rNzpdp5C8iHWlvmbDXxs0oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fsUmlYuo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6EKitTSP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KZ5b86gE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3XhpOVOA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E847E20CBB;
	Mon, 20 May 2024 11:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716206332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0h6zaNbKQHduY01o7fAQC33d55GnLQirB81SYs06U=;
	b=fsUmlYuoYYddvJ7cs0YoGabDIp5ofkSffhBkM/sYifMORlwhS2rMb24AuMZSx81AAiYG1c
	b2ZqyHRBDNBKBrkFr08SfYHMpqRC5VgYBIyqjQKWVfvrjAgj7uHTfjk9NmmNWbXSs2EGKd
	exU9ARjDeCA63yXc3X5OwDZk+LfPG0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716206332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0h6zaNbKQHduY01o7fAQC33d55GnLQirB81SYs06U=;
	b=6EKitTSPmN7XLWrVvRRWnBAo6dHpgTGe7Bj1R1Z8VainveiJBvxV/BWjGX8BFHecApfzeF
	lgE1+l78EUQzIVCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KZ5b86gE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3XhpOVOA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716206331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0h6zaNbKQHduY01o7fAQC33d55GnLQirB81SYs06U=;
	b=KZ5b86gEJ4Ml/imRWLmSSHHasp1i7AXhSLcXjO5y/Y18zv6ZGmPcoX0pZpiKBq/lx7xuXo
	tXsG2IDB3QanEKNwrVG2QJ7xQj7n25DDRGQ85tR0LshrO7IZfbKZllw9SNmEiPnhGcg6xc
	p7qFzY+vNm32pV/P0iJGcWjS/sQSrEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716206331;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0h6zaNbKQHduY01o7fAQC33d55GnLQirB81SYs06U=;
	b=3XhpOVOAADnPbdL/pAVyLGDYnXa6G6dD60Zjq5x8BRZQgxyjn+cEJU1M+Oc82dKbSjZMfa
	UIoAgRchQEQeVHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4AD313A6B;
	Mon, 20 May 2024 11:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mvPaM/s6S2ZaWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 11:58:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5A29CA08D8; Mon, 20 May 2024 13:58:51 +0200 (CEST)
Date: Mon, 20 May 2024 13:58:51 +0200
From: Jan Kara <jack@suse.cz>
To: Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <20240520115851.gcwj3nwicvr2c4j3@quack3>
References: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E847E20CBB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 17-05-24 00:29:06, Justin Stitt wrote:
> When running syzkaller with the newly reintroduced signed integer
> overflow sanitizer we encounter this report:
> 
> UBSAN: signed-integer-overflow in ../fs/read_write.c:91:10
> 9223372036854775807 + 4096 cannot be represented in type 'loff_t' (aka 'long long')
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x93/0xd0
>  handle_overflow+0x171/0x1b0
>  generic_file_llseek_size+0x35b/0x380
> 
> ... amongst others:
> UBSAN: signed-integer-overflow in ../fs/read_write.c:1657:12
> 142606336 - -9223372036854775807 cannot be represented in type 'loff_t' (aka 'long long')
> ...
> UBSAN: signed-integer-overflow in ../fs/read_write.c:1666:11
> 9223372036854775807 - -9223231299366420479 cannot be represented in type 'loff_t' (aka 'long long')
> 
> Fix the accidental overflow in these position and offset calculations
> by checking for negative position values, using check_add_overflow()
> helpers and clamping values to expected ranges.
> 
> Link: https://github.com/llvm/llvm-project/pull/82432 [1]
> Closes: https://github.com/KSPP/linux/issues/358
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Except for the unfortunate wording in the changelog, the code actually
looks easier to grasp to me and if it helps the compiler as well, I'm in
favor of this change (but I definitely don't want to overrule Al if he
hates it ;)).

Regarding the code:

> @@ -1467,8 +1470,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  
>  	/* Don't allow overlapped copying within the same file. */
>  	if (inode_in == inode_out &&
> -	    pos_out + count > pos_in &&
> -	    pos_out < pos_in + count)
> +	    out_sum > pos_in &&
> +	    pos_out < in_sum)
>  		return -EINVAL;

This is actually subtly wrong becaue 'count' could have been updated
(shrinked) between the check_add_overflow() and this place. So please keep
the old checks here.

> @@ -1649,6 +1652,9 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
>  	loff_t max_size = inode->i_sb->s_maxbytes;
>  	loff_t limit = rlimit(RLIMIT_FSIZE);
>  
> +	if (pos < 0)
> +		return -EINVAL;
> +
>  	if (limit != RLIM_INFINITY) {
>  		if (pos >= limit) {
>  			send_sig(SIGXFSZ, current, 0);

Here I'm a bit confused. How is this related to the signed overflow
handling?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

