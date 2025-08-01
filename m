Return-Path: <linux-fsdevel+bounces-56507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD58B18066
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 12:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D727B434E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658223817D;
	Fri,  1 Aug 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3bQCwe+8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tNnXAiRK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3bQCwe+8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tNnXAiRK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27105218ADE
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045293; cv=none; b=VNjg0zfJqT2TUY0QtNHrx7gCz2zplCyUivCEaxsKLCeblSedGkrIoyFrqR/DThh/G4j2Y5yAqUzKcAMgC/SjeYMypPWy7eQrYL/0jgWT7qPJWF/7ZdEeUrc8NqIU6RHYw4/y9lqJ7l7H74yeKanCkMFOkFwsYlcbKdlPKf9ll5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045293; c=relaxed/simple;
	bh=qawU/hgul6DO0p7PkqaVzmv3qF3Q0v23J+MMsJIYuAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4C0bM3QDiVk3dR9mNjCI+V8/WBHmNKL21x9vPhjLFHAZyodAKPf7mgFbQsJ7N/NCylq9UT1ISp40Lm+EMp/VSot2Ql6HLKumUjIElgaYYgylWdaCWVgtEZjn1gyR9YsYhJZNq8P/dchgL0oQEpfUJXPUGU3cJMC9cSr9HzpuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3bQCwe+8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tNnXAiRK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3bQCwe+8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tNnXAiRK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CFCA1F802;
	Fri,  1 Aug 2025 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754045290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlpcRid/jLviLnOCIII1zFUp+X5/v5OApsbSvqgkX0g=;
	b=3bQCwe+8m+b1pJXki7i0SE19LRJuLZX/aYgO8A3ZiSqrxzSq+JlrRllc40Ijgjp0TEoRmy
	oEmC7LLWO65q+KAukErRJmt4xvjB2DU7z1kH1ytR78Z+c0qtd40vBaJ5wmgvdX4pZNQolO
	uULuN2WRCFTgAM3bwR4y0sDtMF26K4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754045290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlpcRid/jLviLnOCIII1zFUp+X5/v5OApsbSvqgkX0g=;
	b=tNnXAiRKs4dWG6re5uc2xbcv5wm+9c7z4s8kRNOflfN1gsjkjp0s4yqknTPOzjZfL2uObF
	VqmUlolodqbMRNDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754045290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlpcRid/jLviLnOCIII1zFUp+X5/v5OApsbSvqgkX0g=;
	b=3bQCwe+8m+b1pJXki7i0SE19LRJuLZX/aYgO8A3ZiSqrxzSq+JlrRllc40Ijgjp0TEoRmy
	oEmC7LLWO65q+KAukErRJmt4xvjB2DU7z1kH1ytR78Z+c0qtd40vBaJ5wmgvdX4pZNQolO
	uULuN2WRCFTgAM3bwR4y0sDtMF26K4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754045290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlpcRid/jLviLnOCIII1zFUp+X5/v5OApsbSvqgkX0g=;
	b=tNnXAiRKs4dWG6re5uc2xbcv5wm+9c7z4s8kRNOflfN1gsjkjp0s4yqknTPOzjZfL2uObF
	VqmUlolodqbMRNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E7D413876;
	Fri,  1 Aug 2025 10:48:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w3vxDmqbjGhSUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 01 Aug 2025 10:48:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ABB00A09FB; Fri,  1 Aug 2025 12:48:09 +0200 (CEST)
Date: Fri, 1 Aug 2025 12:48:09 +0200
From: Jan Kara <jack@suse.cz>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Sargun Dhillon <sargun@sargun.me>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] fs: correctly check for errors from replace_fd() in
 receive_fd_replace()
Message-ID: <fq2s55tc5hhvh4dfjdzek4neozffmn36rwdlsrsxxjqzts2f4c@j67nruhocdiz>
References: <20250801-fix-receive_fd_replace-v1-1-d46d600c74d6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801-fix-receive_fd_replace-v1-1-d46d600c74d6@linutronix.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Fri 01-08-25 09:38:38, Thomas Weiﬂschuh wrote:
> replace_fd() returns either a negative error number or the number of the
> new file descriptor. The current code misinterprets any positive file
> descriptor number as an error.
> 
> Only check for negative error numbers, so that __receive_sock() is called
> correctly for valid file descriptors.
> 
> Fixes: 173817151b15 ("fs: Expand __receive_fd() to accept existing fd")
> Fixes: 42eb0d54c08a ("fs: split receive_fd_replace from __receive_fd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>

Indeed. I'm wondering how come nobody noticed... Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Untested, it stuck out while reading the code.
> ---
>  fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 6d2275c3be9c6967d16c75d1b6521f9b58980926..56c3a045121d8f43a54cf05e6ce1962f896339ac 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1387,7 +1387,7 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
>  	if (error)
>  		return error;
>  	error = replace_fd(new_fd, file, o_flags);
> -	if (error)
> +	if (error < 0)
>  		return error;
>  	__receive_sock(file);
>  	return new_fd;
> 
> ---
> base-commit: 89748acdf226fd1a8775ff6fa2703f8412b286c8
> change-id: 20250801-fix-receive_fd_replace-7fdd5ce6532d
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

