Return-Path: <linux-fsdevel+bounces-33917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C038F9C0A22
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 16:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7258A1F2340C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B0212EFB;
	Thu,  7 Nov 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27IKjOHy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="50NzdFIG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="27IKjOHy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="50NzdFIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A94929CF4;
	Thu,  7 Nov 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993543; cv=none; b=R1D7mzIR0SH/stHIBDB1Q1h1Z9WMxMpTxuoPMjCspvIqkUPqNFFhBXHmORv357cDLStGYwS8rg2n9MvexeVNwA3dLmU8thnRhqzvFtcBKyMW85k8AQruR1zihAOHQqM/q6q/EI9CslIJ2MppdHPUlqSeh0Uola81NbqRoHAmb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993543; c=relaxed/simple;
	bh=MNIDAM9F2mP1cQXpXuguySZM881HcFtfjihzPCdfe/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYivuzBf7PT+GBHif8NF52CjPOKJEuUc80mmgORfhDj/OGHNgXKbrQQ6ALxyRYjoKPmWyvtz/X19oxUrTDaR/6Ts+fUBFrxkjVrdhdA534FXrQh5T4xJSexRkftyXXpITGXGuHBER9N52cnwheLUi3wdVNWnna1w5AgAZ6WZohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27IKjOHy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=50NzdFIG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=27IKjOHy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=50NzdFIG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D9F51FB4A;
	Thu,  7 Nov 2024 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730993538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+0m2CEqNZ49h/raDsmRZOTYIT7S6RDGtUP6QOTVYgA=;
	b=27IKjOHyAJgZJwgGAzjBfAwdmP/TXLs51G7RHvfRCGgOcAsJzknmIjdewGKwaa1mOX/9I3
	NN/1XvwdPvWVuBGsUa9UcnL/BNS9QwMFyUYyQsWKtP1gI5FN3Ey9Ku1XvsmweowaoQ34T7
	Pg/4ao3Q1O1eg+kZ0OfJibR4EsRKuEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730993538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+0m2CEqNZ49h/raDsmRZOTYIT7S6RDGtUP6QOTVYgA=;
	b=50NzdFIG4HJXESRzKFBO0uQg92WktmZxY/JARePzBqJjGO0tyxcfvpMN20l1VQQIoZYF3l
	ENVWu76lKgSS04Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=27IKjOHy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=50NzdFIG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730993538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+0m2CEqNZ49h/raDsmRZOTYIT7S6RDGtUP6QOTVYgA=;
	b=27IKjOHyAJgZJwgGAzjBfAwdmP/TXLs51G7RHvfRCGgOcAsJzknmIjdewGKwaa1mOX/9I3
	NN/1XvwdPvWVuBGsUa9UcnL/BNS9QwMFyUYyQsWKtP1gI5FN3Ey9Ku1XvsmweowaoQ34T7
	Pg/4ao3Q1O1eg+kZ0OfJibR4EsRKuEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730993538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6+0m2CEqNZ49h/raDsmRZOTYIT7S6RDGtUP6QOTVYgA=;
	b=50NzdFIG4HJXESRzKFBO0uQg92WktmZxY/JARePzBqJjGO0tyxcfvpMN20l1VQQIoZYF3l
	ENVWu76lKgSS04Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51CEF139B3;
	Thu,  7 Nov 2024 15:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 31rtE4LdLGfYdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 15:32:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC946A08FE; Thu,  7 Nov 2024 16:32:17 +0100 (CET)
Date: Thu, 7 Nov 2024 16:32:17 +0100
From: Jan Kara <jack@suse.cz>
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: willy@infradead.org, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write
 blocking with strictlimit
Message-ID: <20241107153217.j6kwfgihzhj33dia@quack3>
References: <20241023100032.62952-1-jimzhao.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023100032.62952-1-jimzhao.ai@gmail.com>
X-Rspamd-Queue-Id: 5D9F51FB4A
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 23-10-24 18:00:32, Jim Zhao wrote:
> With the strictlimit flag, wb_thresh acts as a hard limit in
> balance_dirty_pages() and wb_position_ratio(). When device write
> operations are inactive, wb_thresh can drop to 0, causing writes to
> be blocked. The issue occasionally occurs in fuse fs, particularly
> with network backends, the write thread is blocked frequently during
> a period. To address it, this patch raises the minimum wb_thresh to a
> controllable level, similar to the non-strictlimit case.
> 
> Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>

...

> +	/*
> +	 * With strictlimit flag, the wb_thresh is treated as
> +	 * a hard limit in balance_dirty_pages() and wb_position_ratio().
> +	 * It's possible that wb_thresh is close to zero, not because
> +	 * the device is slow, but because it has been inactive.
> +	 * To prevent occasional writes from being blocked, we raise wb_thresh.
> +	 */
> +	if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> +		unsigned long limit = hard_dirty_limit(dom, dtc->thresh);
> +		u64 wb_scale_thresh = 0;
> +
> +		if (limit > dtc->dirty)
> +			wb_scale_thresh = (limit - dtc->dirty) / 100;
> +		wb_thresh = max(wb_thresh, min(wb_scale_thresh, wb_max_thresh / 4));
> +	}

What you propose makes sense in principle although I'd say this is mostly a
userspace setup issue - with strictlimit enabled, you're kind of expected
to set min_ratio exactly if you want to avoid these startup issues. But I
tend to agree that we can provide a bit of a slack for a bdi without
min_ratio configured to ramp up.

But I'd rather pick the logic like:

	/*
	 * If bdi does not have min_ratio configured and it was inactive,
	 * bump its min_ratio to 0.1% to provide it some room to ramp up.
	 */
	if (!wb_min_ratio && !numerator)
		wb_min_ratio = min(BDI_RATIO_SCALE / 10, wb_max_ratio / 2);

That would seem like a bit more systematic way than the formula you propose
above...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

