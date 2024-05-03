Return-Path: <linux-fsdevel+bounces-18584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B818BA9EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDC5282D67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8004F14F9CE;
	Fri,  3 May 2024 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KWs22mke";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zgTS9KJj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KWs22mke";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zgTS9KJj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625BF14F13D;
	Fri,  3 May 2024 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728694; cv=none; b=cQs1iebt6GfhNg74UwlqK2Jsu81o8uCun+Q14grMVxSTCfADk+NKKlHQy0c4ttGu1cgsd0Dt9fl2Lf27nlAOlhI3bS4B+2gmqVRUFFYuSYtLd78o8E4B7ZG08VmAGOKJKwjLGbCRwnHmMiKVqO3UrL8EzDf+na86fmtQGQ9AuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728694; c=relaxed/simple;
	bh=E8PY2B1wxIN5xa8VCdlxWFkp+3+YoCtDnoiZN05+rcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVhT0DKm8FeEfRyFvqyjTnftERL3XWMvOavu4B+ctUZ/epmF23YawjD51B0d7NDPJWE1Ht7l5K+7RWQyYrCh1BgFHSZyGpEIQmIdpLe/O1215YWzE5GkWNM9BXAQog9EIfylcB/GK+0KTD5hPOWbgAQwAafJSooGQh+bD9CPMsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KWs22mke; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zgTS9KJj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KWs22mke; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zgTS9KJj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75E24336D0;
	Fri,  3 May 2024 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714728690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1ZkI43ouhbZimT/6Sz/nQ9W4boKtYozaB6hBMysMKE=;
	b=KWs22mke9uaE7QySPC4EkPDeE+dueH0WTYyUZMx4GAiNIzNsHy9KKRBDwslrT8TLMm1HxD
	zeapumC745oRo9QQyEMD+j8x/YV+Vq5r+eYH3O2DxD/7/jvtNyXQCUbCpPaPsCtANRGJTm
	FEQylR04QxJBiFPdfaZ/+OGtlsMap4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714728690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1ZkI43ouhbZimT/6Sz/nQ9W4boKtYozaB6hBMysMKE=;
	b=zgTS9KJjYD1/sY6qc8iUMd4jwopzfuHTIKYMrcU5kR63QesMiyBb9gtJdB6F5c2KQYvaiG
	nxIviKrSk5y0eNAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714728690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1ZkI43ouhbZimT/6Sz/nQ9W4boKtYozaB6hBMysMKE=;
	b=KWs22mke9uaE7QySPC4EkPDeE+dueH0WTYyUZMx4GAiNIzNsHy9KKRBDwslrT8TLMm1HxD
	zeapumC745oRo9QQyEMD+j8x/YV+Vq5r+eYH3O2DxD/7/jvtNyXQCUbCpPaPsCtANRGJTm
	FEQylR04QxJBiFPdfaZ/+OGtlsMap4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714728690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T1ZkI43ouhbZimT/6Sz/nQ9W4boKtYozaB6hBMysMKE=;
	b=zgTS9KJjYD1/sY6qc8iUMd4jwopzfuHTIKYMrcU5kR63QesMiyBb9gtJdB6F5c2KQYvaiG
	nxIviKrSk5y0eNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C6E9139CB;
	Fri,  3 May 2024 09:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aB53GvKuNGaqMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 May 2024 09:31:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 365ECA0A12; Fri,  3 May 2024 11:31:30 +0200 (CEST)
Date: Fri, 3 May 2024 11:31:30 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, tj@kernel.org,
	jack@suse.cz, hcochran@kernelspring.com, axboe@kernel.dk,
	mszeredi@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mm: remove stale comment __folio_mark_dirty
Message-ID: <20240503093130.kxbolkashbezb2sx@quack3>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
 <20240425131724.36778-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425131724.36778-5-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.68 / 50.00];
	BAYES_HAM(-2.88)[99.50%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,huaweicloud.com:email,suse.com:email,suse.cz:email]
X-Spam-Score: -3.68
X-Spam-Flag: NO

On Thu 25-04-24 21:17:24, Kemeng Shi wrote:
> The __folio_mark_dirty will not mark inode dirty any longer. Remove the
> stale comment of it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 22e1acec899e..692c0da04cbd 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2721,8 +2721,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
>  }
>  
>  /*
> - * Mark the folio dirty, and set it dirty in the page cache, and mark
> - * the inode dirty.
> + * Mark the folio dirty, and set it dirty in the page cache.
>   *
>   * If warn is true, then emit a warning if the folio is not uptodate and has
>   * not been truncated.
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

