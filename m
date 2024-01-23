Return-Path: <linux-fsdevel+bounces-8613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B383972B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 19:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BAD2896D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E4A81211;
	Tue, 23 Jan 2024 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcUJfRKa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B5vWeU8y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcUJfRKa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B5vWeU8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752FF81AA2;
	Tue, 23 Jan 2024 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032984; cv=none; b=RqQMrzg02owh1siYdiJ22cRQXJ/gmsU5x6M6CWGr2AAImOnK71SCVaS5YMzUWyZyKFrU48WPXb8axtgrSUX+GF9W2ypEUYxDwK7cJ3Pt4o19Ujt0huIDGQL7XlQx6RHK7hTnx17DWwoKGhXbVAwdUFobviDWnvC8bIplcv8O2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032984; c=relaxed/simple;
	bh=Kls/oFcAw6BTebsNXmW38DpmnKz89g4d7yo2gqb7VpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kaEFaF0XDFIq197AkVB53qku0Y7RtMCTlAwvyS5i9VRBKiKt8dVI6HJt7a0WBBfudF7ltBX6z6HPMDJLkWCv7POFk63upc8N1NcD41Wei5ulPtziSAweFDP03y5Ye27mdGhy8cZwql3Ag8JuSF+F9enKJlrHJ6sM/DkYI4NCzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcUJfRKa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B5vWeU8y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcUJfRKa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B5vWeU8y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7B2F1F79B;
	Tue, 23 Jan 2024 18:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVEHulAgauPl/Vgac2NWW0rpe7yrK6/nS0F3Zcf7p9Y=;
	b=mcUJfRKagSyNddQ+w389b7gCjjIO1hvq1z267sF+LX88IUIY39TFD6eU8jfJkYT/85D7rK
	NRkFN7Pz1vRZ1Xr2tnDvs6d4HCeo320o/oYyy00D4XeJErTT+jtt1Xx+hR7llNmqgO3RkQ
	+KvFdPNZDio6YGkU3SsahnPKo/9jSO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVEHulAgauPl/Vgac2NWW0rpe7yrK6/nS0F3Zcf7p9Y=;
	b=B5vWeU8yXvx9o2XriiKyA9U9MXa3cAjT6yKTnnwzdCUW6II63xmSgl38EfPZ8cInudVp34
	hltjb3TDHB3A6cCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706032979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVEHulAgauPl/Vgac2NWW0rpe7yrK6/nS0F3Zcf7p9Y=;
	b=mcUJfRKagSyNddQ+w389b7gCjjIO1hvq1z267sF+LX88IUIY39TFD6eU8jfJkYT/85D7rK
	NRkFN7Pz1vRZ1Xr2tnDvs6d4HCeo320o/oYyy00D4XeJErTT+jtt1Xx+hR7llNmqgO3RkQ
	+KvFdPNZDio6YGkU3SsahnPKo/9jSO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706032979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EVEHulAgauPl/Vgac2NWW0rpe7yrK6/nS0F3Zcf7p9Y=;
	b=B5vWeU8yXvx9o2XriiKyA9U9MXa3cAjT6yKTnnwzdCUW6II63xmSgl38EfPZ8cInudVp34
	hltjb3TDHB3A6cCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 991A0136A4;
	Tue, 23 Jan 2024 18:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0TtcJVP/r2WjKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 18:02:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E031A0803; Tue, 23 Jan 2024 19:02:55 +0100 (CET)
Date: Tue, 23 Jan 2024 19:02:55 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 53/82] fs: Refactor intentional wrap-around test
Message-ID: <20240123180255.l75abb7mo4tlupuv@quack3>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-53-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-53-keescook@chromium.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,chromium.org:email,linux.org.uk:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Mon 22-01-24 16:27:28, Kees Cook wrote:
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
> Refactor open-coded wrap-around addition test to use add_would_overflow().
> This paves the way to enabling the wrap-around sanitizers in the future.
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

Looks good atlhough I'd prefer wrapping the line to not overflow 80 chars.
Anyway feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/remap_range.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index f8c1120b8311..15e91bf2c5e3 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -45,7 +45,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
>  		return -EINVAL;
>  
>  	/* Ensure offsets don't wrap. */
> -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> +	if (add_would_overflow(pos_in, count) || add_would_overflow(pos_out, count))
>  		return -EINVAL;
>  
>  	size_in = i_size_read(inode_in);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

