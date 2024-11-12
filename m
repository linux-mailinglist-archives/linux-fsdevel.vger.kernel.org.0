Return-Path: <linux-fsdevel+bounces-34439-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894629C5734
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173A81F21550
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362F1CD1F0;
	Tue, 12 Nov 2024 12:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Pd3ABGH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JdEx4DhL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AMxeTR4F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="96WniaZO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2361AFB35;
	Tue, 12 Nov 2024 12:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412977; cv=none; b=Px3N5ewOmlr9R+S2VVEFECX4qCxndb0NyeZW6ow+jEezHI1gJQPuGfRvgd0YCKHdOPNFC2qu+b7l3aupQ/GU7wY2lnyMytwk+vYInlUiYFU/g7okYUB2psaSAcWZP5msLMXY59FFnWMnWBYb8+rHmYHI5yrnFFetFA9O2hsKK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412977; c=relaxed/simple;
	bh=Y/JW144yIBVf+KBNkSwHhfAPV7r+kikoSSCqNcfhfcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6eYZlXOjiQdJhnlbrjs4wWe9GgSxyrmvIPjtmJbEossSCa5p5Us/QFxG1NYhiHPU4BHWszRYUyYTb6dTcQQdN6OlsPNYDE1EFVhUXLiXfSIVMglq+sBf+ym+8EwaoyYaVSUAO3MvKUXNSOD3d3Uuhhs+lknz1aD1fBOtlCHyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Pd3ABGH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JdEx4DhL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AMxeTR4F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=96WniaZO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF8FB2128B;
	Tue, 12 Nov 2024 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731412974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeFtWbLIO4INsUn3shyTdNpyYjkXRHvqq8ej5oL8n+Q=;
	b=3Pd3ABGHZF67gQB1ZdiTehkHtkGZp8HEBVTfLV8MnkjTeTAZgQTODqwZybsqqyG1TLF5Ty
	iDVnuNShRxHIpND6WtfG15kFqF/FAfxCEa0eniOQB+NckQB8sKxxKlsXxPkGnM8UBlOJMv
	vQBSqE2QlU/oAKPuJd9vAI0gooQgkqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731412974;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeFtWbLIO4INsUn3shyTdNpyYjkXRHvqq8ej5oL8n+Q=;
	b=JdEx4DhLgoRIBX/QSaB3HCBteBS5NMAYzOgPQSgOB/IwMtcxyIyM1bQMiUceFHvEBgw40q
	DmpQdJ9QcZph8HAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AMxeTR4F;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=96WniaZO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731412972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeFtWbLIO4INsUn3shyTdNpyYjkXRHvqq8ej5oL8n+Q=;
	b=AMxeTR4FHlltp5A/KQ2c3UHxxhzfrE9ubSOKGlCRXf8D9mHj3IGLzsTXsqrKy5K8bM3BMT
	6gG9LkWZF4BIOOav9ts5t9M8FbPsdHoVZguVGiJdXcpgJwVJFiQrK5EhFRJ5k4XYbX2ODy
	McY8jkcwKNNlZxSYH2dzGIrVB0kTTSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731412972;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeFtWbLIO4INsUn3shyTdNpyYjkXRHvqq8ej5oL8n+Q=;
	b=96WniaZOgUDDX1mB/gz5cww6a0Fpo3X1rGfVnqUeKjRpA+pGair9VHpx2c7XjTjBG1aWbN
	kyayI0qwBtp1w+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE6A813721;
	Tue, 12 Nov 2024 12:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4nEINuxDM2dOUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 12 Nov 2024 12:02:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79829A08D0; Tue, 12 Nov 2024 13:02:52 +0100 (CET)
Date: Tue, 12 Nov 2024 13:02:52 +0100
From: Jan Kara <jack@suse.cz>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: jmoyer@redhat.com, bcrl@kvack.org, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, willy@infradead.org, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs:aio: Remove TODO comment suggesting hash or array
 usage in  io_cancel()
Message-ID: <20241112120252.a75tg4xqszn7nou3@quack3>
References: <20241112113906.15825-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112113906.15825-1-pvmohammedanees2003@gmail.com>
X-Rspamd-Queue-Id: EF8FB2128B
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 12-11-24 17:08:34, Mohammed Anees wrote:
> The comment suggests a hash or array approach to
> store the active requests. Currently it iterates
> through all the active requests and when found
> deletes the requested request, in the linked list.
> However io_cancel() isn’t a frequently used operation,
> and optimizing it wouldn’t bring a substantial benefit
> to real users and the increased complexity of maintaining
> a hashtable for this would be significant and will slow
> down other operation. Therefore remove this TODO 
> to avoid people spending time improving this.
> 
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index e8920178b50f..72e3970f4225 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -2191,7 +2191,6 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
>  		return -EINVAL;
>  
>  	spin_lock_irq(&ctx->ctx_lock);
> -	/* TODO: use a hash or array, this sucks. */
>  	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
>  		if (kiocb->ki_res.obj == obj) {
>  			ret = kiocb->ki_cancel(&kiocb->rw);
> -- 
> 2.47.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

