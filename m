Return-Path: <linux-fsdevel+bounces-30862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D53C98EECA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4156C1C21CFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A5216F265;
	Thu,  3 Oct 2024 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DX6Q+IcO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2/HesUIE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2RTKKfR9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OnCmJlo8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E031E161310;
	Thu,  3 Oct 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957433; cv=none; b=XDLOI4CmZzqn+eAvItLztEVEgS+qzMyc9F/Vwuj/7suDO8Hduq76R+ArEMzMc6bz0na/raESStJXmZUzMYjiZUvxh/98K9gtqtd7ld6AfRRTafg8IBhRMfpyHPHQ4mK+M4J7OHv8xAfLPqqH8hpmc8CwQN11zAqk5KgqBBW68Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957433; c=relaxed/simple;
	bh=KsTdweygGJKuMb0XZxfKSU4TCF0O8Pcac/cGNx/kNjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvOPkcm8W2cYthzgWqkou30iu1JufW6zZeIG86bLg9JnewyAm5kve+4k0AYubZxO0dT9pZKYfJpMohPPtdDCDnfh3zQiNPwg4YHJCVvoADpFWhXz+YY/+sfyc3khEdpAr+6WavOzhJa1YjP5m7EIq9DyYXOpt4vD86alEESxb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DX6Q+IcO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2/HesUIE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2RTKKfR9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OnCmJlo8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE1D921C03;
	Thu,  3 Oct 2024 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727957429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yG3NFZF51ik4yscefD7bkZR402j9YJxhaCsaR0zppt0=;
	b=DX6Q+IcOKvn0idhPKrKqNBfY59zlsQI/8qqsUrs4LQrv/glwrwJGWwk1l6cv8OXMTcZOAK
	KKhn5fygOM3RxqgXEIdjWFumDGDvNFPdQ7fmYYcJ/1cyZRA8oJgo5rMqyrglBlU91OuyHA
	QQf9vmG22B6Ax6bElFk+FVMOe+UX7Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727957429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yG3NFZF51ik4yscefD7bkZR402j9YJxhaCsaR0zppt0=;
	b=2/HesUIEssTze+NqyrHmAYMmi8MGHX1vMe1NOqatVdqXzkSsuWV0zP3kHJc9mtkFO8fqsA
	m5iM2vQnNkMaXfCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2RTKKfR9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OnCmJlo8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727957428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yG3NFZF51ik4yscefD7bkZR402j9YJxhaCsaR0zppt0=;
	b=2RTKKfR9AB/92GFNRoE0nJ86pUWxvTougnYOGH7IVgarOqkCINZOCjyB1SUaurqq9NFOOn
	MIuP4I4sdY7WoYee5gKe4kujQAAFQThXxMQkTx27rEPmS90WcPKyk3QCsVbxs31LINxdL1
	HBj55Bsd0F2pLSR9/X0IC9K0fxT6acE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727957428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yG3NFZF51ik4yscefD7bkZR402j9YJxhaCsaR0zppt0=;
	b=OnCmJlo8h9QOp897FRSqi0wLna1CSY6Btyz90g5l5u701jwVFEegyet3F4Q6xzZiI7qAdb
	UFwzW7zhcEs7C5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D323613882;
	Thu,  3 Oct 2024 12:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aWqFM7SJ/mYMIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 12:10:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90EB7A086F; Thu,  3 Oct 2024 14:10:20 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:10:20 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/6] fs: Move clearing of mappedtodisk to buffer.c
Message-ID: <20241003121020.36i4ufbbuf4fbua7@quack3>
References: <20241002040111.1023018-1-willy@infradead.org>
 <20241002040111.1023018-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002040111.1023018-2-willy@infradead.org>
X-Rspamd-Queue-Id: DE1D921C03
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
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 02-10-24 05:01:03, Matthew Wilcox (Oracle) wrote:
> The mappedtodisk flag is only meaningful for buffer head based
> filesystems.  It should not be cleared for other filesystems.  This allows
> us to reuse the mappedtodisk flag to have other meanings in filesystems
> that do not use buffer heads.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

The patch looks good. But I'm bit confused about the changelog. There's no
generic code checking for mappedtodisk. Only nilfs2 actually uses it for
anything, all other filesystems just never look at it as far as my grepping
shows. So speaking about "filesystems that do not use buffer heads" looks
somewhat broad to me. Anyway feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c   | 1 +
>  mm/truncate.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 1fc9a50def0b..35f9af799e0a 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1649,6 +1649,7 @@ void block_invalidate_folio(struct folio *folio, size_t offset, size_t length)
>  	if (length == folio_size(folio))
>  		filemap_release_folio(folio, 0);
>  out:
> +	folio_clear_mappedtodisk(folio);
>  	return;
>  }
>  EXPORT_SYMBOL(block_invalidate_folio);
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 0668cd340a46..870af79fb446 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -166,7 +166,6 @@ static void truncate_cleanup_folio(struct folio *folio)
>  	 * Hence dirty accounting check is placed after invalidation.
>  	 */
>  	folio_cancel_dirty(folio);
> -	folio_clear_mappedtodisk(folio);
>  }
>  
>  int truncate_inode_folio(struct address_space *mapping, struct folio *folio)
> -- 
> 2.43.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

