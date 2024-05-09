Return-Path: <linux-fsdevel+bounces-19164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93CA8C0E48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1981C2127F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 10:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7F12F5B3;
	Thu,  9 May 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DoSqUxQ9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QGHb9EuI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kKhgX2dG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UkBjvTDO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D5322E;
	Thu,  9 May 2024 10:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715251256; cv=none; b=DIfehCrpYpVzpV6GuiY0uhFMSU1r8EwXmkbj81SvHrLBbP3qY2NXemyJxzLo/PaI+D5uzH22AIrKinRFes02aepNcVfJ/CYdprhp4ARm9AMTpVGKvgIGvWvFIUL57APMWGyaQg06cnxd2ws2Wd6BzNgXfSYHSkHH0ex9hXB1Sis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715251256; c=relaxed/simple;
	bh=G1ypJ1HrkCCEaeAsq2Hx6jfkoV7haBNx9b3Fr/D5xm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQvayCqvPyEKWBGj7cNveVIMjLwm2QROJzTHAvX2lctgWVmWOHW9iPGghKLHmYKXwq34hFTLdhqmT28VPE3fbhCeLU9vn+EhRaY3XwiGgmGBMPVjcgVSMSV/odLxptLNX8rxmiTwQqfxjs1KyM76O2XeNfwW54ql6Qag/iS21z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DoSqUxQ9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QGHb9EuI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kKhgX2dG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UkBjvTDO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAFE15FD1D;
	Thu,  9 May 2024 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715251253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22XtW7WxCKcNM6SFn+k2/G0UhW7ZtL6Ugs4+UbmPn8s=;
	b=DoSqUxQ9y3VQoA/BqC/HKL02NPabxOQd5bzxBULgX1dHX/bZb1idcXYIumQ3p8fguT6ejJ
	4FYbyhV0T1bqyxMK7yD5GjeJ0uwcyfY5fjaUmmHAjpT30ymIa1emUTgG/UcKxX9guJWXeG
	Zqk9AkIna0IFtFdyN5l74dLSxDSjwj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715251253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22XtW7WxCKcNM6SFn+k2/G0UhW7ZtL6Ugs4+UbmPn8s=;
	b=QGHb9EuIGYOGgFfWhrgSmsInouSeYWd//I1s7rpmxm7WT2n0lpRPGxYLhg+cmljmf1LZvo
	ML274K5y9RogWJDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715251252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22XtW7WxCKcNM6SFn+k2/G0UhW7ZtL6Ugs4+UbmPn8s=;
	b=kKhgX2dGE8bt8bBPRlqwHxh6OwWdcr1L7y4sKVajOILLtjslM88TrHUimMZeUvDczMY0FZ
	RqARGoFeNUZ7YE1n3WeZMwc4ymUf8TzReXIqKT+5rwi9doajwKD2yAmstMPmCmNYOs6baX
	QsUvWAlL+QwRBTCrH1WwWOBTZr+99l4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715251252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22XtW7WxCKcNM6SFn+k2/G0UhW7ZtL6Ugs4+UbmPn8s=;
	b=UkBjvTDOn6pw7W7sVTD1zmJXv5PzIyLH69L/9xC7qh2CCDqGiyBR6xJQd5VmO77tbnU4z5
	MYfGAj6Boa2CHACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF72B13A24;
	Thu,  9 May 2024 10:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c0uHNjSoPGbIQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 May 2024 10:40:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 811DFA0861; Thu,  9 May 2024 12:40:52 +0200 (CEST)
Date: Thu, 9 May 2024 12:40:52 +0200
From: Jan Kara <jack@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHv2 2/2] iomap: Optimize iomap_read_folio
Message-ID: <20240509104052.mixeiy7ihxlzzbba@quack3>
References: <cover.1715067055.git.ritesh.list@gmail.com>
 <92ae9f3333c9a7e66214568d08f45664261c899c.1715067055.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ae9f3333c9a7e66214568d08f45664261c899c.1715067055.git.ritesh.list@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Tue 07-05-24 14:25:43, Ritesh Harjani (IBM) wrote:
> iomap_readpage_iter() handles "uptodate blocks" and "not uptodate blocks"
> within a folio separately. This makes iomap_read_folio() to call into
> ->iomap_begin() to request for extent mapping even though it might already
> have an extent which is not fully processed.
> This happens when we either have a large folio or with bs < ps. In these
> cases we can have sub blocks which can be uptodate (say for e.g. due to
> previous writes). With iomap_read_folio_iter(), this is handled more
> efficiently by not calling ->iomap_begin() call until all the sub blocks
> with the current folio are processed.
> 
> iomap_read_folio_iter() handles multiple sub blocks within a given
> folio but it's implementation logic is similar to how
> iomap_readahead_iter() handles multiple folios within a single mapped
> extent. Both of them iterate over a given range of folio/mapped extent
> and call iomap_readpage_iter() for reading.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap/buffered-io.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9f79c82d1f73..a9bd74ee7870 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -444,6 +444,24 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	return pos - orig_pos + plen;
>  }
> 
> +static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
> +		struct iomap_readpage_ctx *ctx)
> +{
> +	struct folio *folio = ctx->cur_folio;
> +	size_t offset = offset_in_folio(folio, iter->pos);
> +	loff_t length = min_t(loff_t, folio_size(folio) - offset,
> +			      iomap_length(iter));
> +	loff_t done, ret;
> +
> +	for (done = 0; done < length; done += ret) {
> +		ret = iomap_readpage_iter(iter, ctx, done);
> +		if (ret <= 0)
> +			return ret;
> +	}
> +
> +	return done;
> +}
> +
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  {
>  	struct iomap_iter iter = {
> @@ -459,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	trace_iomap_readpage(iter.inode, 1);
> 
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
> +		iter.processed = iomap_read_folio_iter(&iter, &ctx);
> 
>  	if (ret < 0)
>  		folio_set_error(folio);
> --
> 2.44.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

