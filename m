Return-Path: <linux-fsdevel+bounces-71117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD0FCB605C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 14:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA642300D42A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 13:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1762313E13;
	Thu, 11 Dec 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NOei2yqZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ndLA8Tw3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G+XQEgZz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNqmroqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42E31353D
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459651; cv=none; b=uyWuIphEcb8fWsjPP4Qa9cmNZuD3R6IPpiesmj2acmytL2Xc876/d4HTDMtVJMFIqz6tbUylGG8Oh2i3YMcSzNxJZEkpyB/8ut1aLcqq9xoFlxwvYM7r+kBPtTsx7iLZqT7Kj4ecXTKJ0p4J7hALJeEWtGs2oSpvMai9ioyzY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459651; c=relaxed/simple;
	bh=2pTYAFEt+B0DcYmbSaZVLmxawafvdoyuw5DpYz5NqAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm29uTndtoQEVFRKPo9oAD+xVnCOMm+dYUwOHBdFOFOIKNBeWdGaQqQbhTA0ZkgIgWvueXjyPXKmlU9hTFvFOQ2fd1QjVnQNt3/gweRx61yIMQJwVGunsRNrskuttsYpwO4VPqMpjTeYLVMBl51NQrvIQ9R9c9H/VCIvKE+Lkgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NOei2yqZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ndLA8Tw3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G+XQEgZz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNqmroqx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 456D05BDFE;
	Thu, 11 Dec 2025 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765459647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+keSGeEWOoy0PdiqJY0zO8+gkfFPclclf4TPYgaqr8=;
	b=NOei2yqZbWN9WCW4gF3WCZWcjMeMhDraBJvxST3uTiq0hwQCqc8OPmOn164aAs2tVZw8O4
	N3Z5cTtMSRp+aVWkxGqq7smol/77MNwXz1BKbXa49FtNJ9cVu4oeIT45GadT0E2aitarn5
	UNgAf+k2hylqgtN5zkoMrjrx14h1IVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765459647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+keSGeEWOoy0PdiqJY0zO8+gkfFPclclf4TPYgaqr8=;
	b=ndLA8Tw3eClko+Kgvyguflo6ozefiAPsPdRFdtkkDaeAY8miABSkCcMw6qpP+mQVnOcnfN
	3Q3uW4ZYHOxxKWCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G+XQEgZz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rNqmroqx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765459646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+keSGeEWOoy0PdiqJY0zO8+gkfFPclclf4TPYgaqr8=;
	b=G+XQEgZzYlMfFDskpX/2QCsCK6x7ci5rn/j/f/G/uYHT4QYwzZXMQhbAKAAts08tJkxRqP
	ISiRPxlk6YPVAfsEQQu54/JI7Kp6nH8jwazN/T9BbcMgk6Xkb12PY0NwmxdDBNFm+UIlYA
	vmuE9hfz83s3T05eLEHe3em4ueaJRmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765459646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K+keSGeEWOoy0PdiqJY0zO8+gkfFPclclf4TPYgaqr8=;
	b=rNqmroqxu4goavZ2FBzxkWijZ06MM+XyffF8S62CNKgMD76kRH1z/c+oWXmN4LBebrrXdL
	PazmAC6Dq8TbdBCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FEE23EA63;
	Thu, 11 Dec 2025 13:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HVytC77GOmmbWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Dec 2025 13:27:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C44D6A0837; Thu, 11 Dec 2025 14:27:21 +0100 (CET)
Date: Thu, 11 Dec 2025 14:27:21 +0100
From: Jan Kara <jack@suse.cz>
To: Deepakkumar Karn <dkarn@redhat.com>
Cc: jack@suse.cz, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/buffer: add alert in try_to_free_buffers() for
 folios without buffers
Message-ID: <z5ohx53pjtwc3jtcebp777i4t4jxczoie2hkcsg75enzojsurz@4pwb4pxb244n>
References: <pt6xr3w5ne22gqvgxzbdhwfm45wiiwqmycajofgnnzlrzowmeh@iek3vsmkvs5j>
 <20251211131211.308021-1-dkarn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211131211.308021-1-dkarn@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 456D05BDFE
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Thu 11-12-25 18:42:11, Deepakkumar Karn wrote:
> try_to_free_buffers() can be called on folios with no buffers attached
> when filemap_release_folio() is invoked on a folio belonging to a mapping
> with AS_RELEASE_ALWAYS set but no release_folio operation defined.
> 
> In such cases, folio_needs_release() returns true because of the
> AS_RELEASE_ALWAYS flag, but the folio has no private buffer data. This
> causes try_to_free_buffers() to call drop_buffers() on a folio with no
> buffers, leading to a null pointer dereference.
> 
> Adding a check in try_to_free_buffers() to return early if the folio has no
> buffers attached, with WARN_ON_ONCE() to alert about the misconfiguration.
> This provides defensive hardening.
> 
> Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>

Looks good to me now. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 838c0c571022..28e4d53f1717 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2948,6 +2948,10 @@ bool try_to_free_buffers(struct folio *folio)
>  	if (folio_test_writeback(folio))
>  		return false;
>  
> +	/* Misconfigured folio check */
> +	if (WARN_ON_ONCE(!folio_buffers(folio)))
> +		return true;
> +
>  	if (mapping == NULL) {		/* can this still happen? */
>  		ret = drop_buffers(folio, &buffers_to_free);
>  		goto out;
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

