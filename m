Return-Path: <linux-fsdevel+bounces-8614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B3D839731
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 19:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EBA1F2513D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F55381207;
	Tue, 23 Jan 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0n/i9ENU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BCe2B2BX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0n/i9ENU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BCe2B2BX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D4823A5;
	Tue, 23 Jan 2024 18:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033013; cv=none; b=ECE/4HgR6yY2EP9agebjBh3ew2DqgAGfbX9lZvLFquQ79OhwUCxk0MCBwtP0OtTHISU0khL1kWHQ5rQlBdHJ1z+y/kW4oroH+g6LOm6hL/Inp8w7kiOTQ9he7cBUhDmpZQ6xA0U1rwQA5pwTRQ8HHvA26ZreYg1LRKAyaHe5sIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033013; c=relaxed/simple;
	bh=FM39C5+dDJIqtcQ0V6pUv3Btv4UXQxsNjRrxNWs2RB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbIvcySQ6oweJJR/ec25SmETxERs6MCLyGrzqhyJd+9akVAWrRd8VoG3/IhkQAEthae/IpMTuXmPCS5pR3i5Ybk0H9GORq9LfqbzPKqvggFiG+CClAJ4//3ujkpMxnqNBJfK8ODmNPRCi94rUdNAk1iOlFV94s7KS5Hwi8b68Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0n/i9ENU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BCe2B2BX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0n/i9ENU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BCe2B2BX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F7061F79B;
	Tue, 23 Jan 2024 18:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706033010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/QT8OmiiMqa92U7O1bt84T4KaCJPt04c3cPvTWRcJwE=;
	b=0n/i9ENUDsQh9LBixNC7gGqZ651FxSuCvFKxcGzk/HoaY0lPCLkXNANCvKI20s3HNHKb2A
	9HiLTNEduWciHfSXvte0DrXgWl4r9mQj1VzXtaz/kOkc2RtxBLMaShbOABbdygoYSdvUZ1
	1nlwml6oX50bZJYmS8zbunxCGBdtj9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706033010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/QT8OmiiMqa92U7O1bt84T4KaCJPt04c3cPvTWRcJwE=;
	b=BCe2B2BXIUumxD8VmU7hjWDe0x75claIvmiDVzXbqZtyqJCJtM01gXESQpifAu5vMFDLjk
	A51p7ZHe4FHWqFDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706033010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/QT8OmiiMqa92U7O1bt84T4KaCJPt04c3cPvTWRcJwE=;
	b=0n/i9ENUDsQh9LBixNC7gGqZ651FxSuCvFKxcGzk/HoaY0lPCLkXNANCvKI20s3HNHKb2A
	9HiLTNEduWciHfSXvte0DrXgWl4r9mQj1VzXtaz/kOkc2RtxBLMaShbOABbdygoYSdvUZ1
	1nlwml6oX50bZJYmS8zbunxCGBdtj9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706033010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/QT8OmiiMqa92U7O1bt84T4KaCJPt04c3cPvTWRcJwE=;
	b=BCe2B2BXIUumxD8VmU7hjWDe0x75claIvmiDVzXbqZtyqJCJtM01gXESQpifAu5vMFDLjk
	A51p7ZHe4FHWqFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70607136A4;
	Tue, 23 Jan 2024 18:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O3xtG3L/r2XGKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 18:03:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17E13A0803; Tue, 23 Jan 2024 19:03:30 +0100 (CET)
Date: Tue, 23 Jan 2024 19:03:30 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 37/82] aio: Refactor intentional wrap-around test
Message-ID: <20240123180330.2br6kzg2m3lbyrva@quack3>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-37-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123002814.1396804-37-keescook@chromium.org>
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
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.org.uk:email,chromium.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Mon 22-01-24 16:27:12, Kees Cook wrote:
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
> Cc: Benjamin LaHaise <bcrl@kvack.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-aio@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index bb2ff48991f3..edd19be3f4b1 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -796,7 +796,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
>  	/* limit the number of system wide aios */
>  	spin_lock(&aio_nr_lock);
>  	if (aio_nr + ctx->max_reqs > aio_max_nr ||
> -	    aio_nr + ctx->max_reqs < aio_nr) {
> +	    add_would_overflow(aio_nr, ctx->max_reqs)) {
>  		spin_unlock(&aio_nr_lock);
>  		err = -EAGAIN;
>  		goto err_ctx;
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

