Return-Path: <linux-fsdevel+bounces-8612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB6839724
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 19:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BDF1F21968
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544581AA1;
	Tue, 23 Jan 2024 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hIZ7IUNw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TUSNo0nt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hIZ7IUNw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TUSNo0nt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0428120E;
	Tue, 23 Jan 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032894; cv=none; b=O6n4tE3MSVfUgnbSuwY4IlNkMz1ppFrqkYb4p/UfQUq/P2R/8cryW02E2ASDKDBe7nQ7ImG+Sa0yqaB+UnPqmzKgGAeVJq4h8pUgggd2TWJfiP7grl94gryrsiA7C46N64Zrig0hRnXAgvRYFKOh45bn2OCsyDqHmnjcCxtrkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032894; c=relaxed/simple;
	bh=fFDSvwztfO1lwTUjz+bp3hKoAyvE1gQq9p4oft8qmIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/QRUggzQpsgG0rKKsvj4/AU1U22EW0p9YZLhdxqk3ue5dVUfOa29V84UC7IQOMuZfu2cZNz6pEPA0gI4FnqO5Y7uZsQIUpikx1eUQEQ+hXPVI1m5UFXvrwDXhvN04GYGpy5BpuIKfueqK3SsBft9etXOBJKoVDCfk0ZLYv7gdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hIZ7IUNw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TUSNo0nt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hIZ7IUNw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TUSNo0nt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50A9E1F79B;
	Tue, 23 Jan 2024 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AEwS31g/Z+ue7QdZLN1yxJmuCxks45DjvPXlHLQB6w=;
	b=hIZ7IUNwP20Nuva/Yn8J9KFTx/p7tZpLPoQs2alQxpQvgMhH8tlJVjDuWzRho+5wrYBECn
	rySlP/uEAiVLjCF3mR0Lat5dcIgm5+DyNWHPXoANdU8pg+r41Q9uDwoxAJ5ROJ9qwouh/B
	iEEZh15l8ycIABKL/0h6/YGjIyFRncs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AEwS31g/Z+ue7QdZLN1yxJmuCxks45DjvPXlHLQB6w=;
	b=TUSNo0ntzRpfP059ayiXbvPkmWhit5qddJo7GSUgYi0GWdlm94t7TWodzXJs4MjLyUwbsU
	3mZpwH1rdCzncAAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032889; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AEwS31g/Z+ue7QdZLN1yxJmuCxks45DjvPXlHLQB6w=;
	b=hIZ7IUNwP20Nuva/Yn8J9KFTx/p7tZpLPoQs2alQxpQvgMhH8tlJVjDuWzRho+5wrYBECn
	rySlP/uEAiVLjCF3mR0Lat5dcIgm5+DyNWHPXoANdU8pg+r41Q9uDwoxAJ5ROJ9qwouh/B
	iEEZh15l8ycIABKL/0h6/YGjIyFRncs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032889;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AEwS31g/Z+ue7QdZLN1yxJmuCxks45DjvPXlHLQB6w=;
	b=TUSNo0ntzRpfP059ayiXbvPkmWhit5qddJo7GSUgYi0GWdlm94t7TWodzXJs4MjLyUwbsU
	3mZpwH1rdCzncAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DAF9136A4;
	Tue, 23 Jan 2024 18:01:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U10LD/n+r2VEKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 18:01:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D29AA0803; Tue, 23 Jan 2024 19:01:28 +0100 (CET)
Date: Tue, 23 Jan 2024 19:01:28 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/82] fs: Refactor intentional wrap-around calculation
Message-ID: <20240123180128.d2hgvlbjq66rkfdc@quack3>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-19-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-19-keescook@chromium.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,suse.cz:email,suse.com:email,chromium.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon 22-01-24 16:26:54, Kees Cook wrote:
> In an effort to separate intentional arithmetic wrap-around from
> unexpected wrap-around, we need to refactor places that depend on this
> kind of math. One of the most common code patterns of this is:
> 
> 	VAR + value < VAR
> 
> Notably, this is considered "undefined behavior" for signed and pointer
> types, which the kernel works around by using the -fno-strict-overflow
> option in the build[1] (which used to just be -fwrapv). Regardless, we
> want to get the kernel source to the position where we can meaningfully
> instrument arithmetic wrap-around conditions and catch them when they
> are unexpected, regardless of whether they are signed[2], unsigned[3],
> or pointer[4] types.
> 
> Refactor open-coded unsigned wrap-around addition test to use
> check_add_overflow(), retaining the result for later usage (which removes
> the redundant open-coded addition). This paves the way to enabling the
> wrap-around sanitizers in the future.
> 
> Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> Link: https://github.com/KSPP/linux/issues/26 [2]
> Link: https://github.com/KSPP/linux/issues/27 [3]
> Link: https://github.com/KSPP/linux/issues/344 [4]
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/read_write.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index d4c036e82b6c..e24b94a8937d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1417,6 +1417,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  	struct inode *inode_out = file_inode(file_out);
>  	uint64_t count = *req_count;
>  	loff_t size_in;
> +	loff_t sum_in, sum_out;
>  	int ret;
>  
>  	ret = generic_file_rw_checks(file_in, file_out);
> @@ -1451,7 +1452,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  		return -ETXTBSY;
>  
>  	/* Ensure offsets don't wrap. */
> -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> +	if (check_add_overflow(pos_in, count, &sum_in) ||
> +	    check_add_overflow(pos_out, count, &sum_out))
>  		return -EOVERFLOW;
>  
>  	/* Shorten the copy to EOF */
> @@ -1467,8 +1469,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>  
>  	/* Don't allow overlapped copying within the same file. */
>  	if (inode_in == inode_out &&
> -	    pos_out + count > pos_in &&
> -	    pos_out < pos_in + count)
> +	    sum_out > pos_in &&
> +	    pos_out < sum_in)
>  		return -EINVAL;
>  
>  	*req_count = count;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

