Return-Path: <linux-fsdevel+bounces-64663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD93BF0355
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6EF93E27B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AF2BE032;
	Mon, 20 Oct 2025 09:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GgWDHmOi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yYYNxzeN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xC7Vte8B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3phBpZ57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84242E8B8A
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952967; cv=none; b=rPMWSpC+3NUtZaVAaM2afIZbccdHwKaV9NpkI2J/vhSYqrV5FnE0xQPPf54mr7us9AKqPM43/L/B9IT4+fNuha7sQS+rzgn23SLhKkYI/gS8HF2xQ3RZwZizKiH3OEOWIlVXIB12ycfk5pSJGzyP2gfh0Wv4YdOMbClJxDExuBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952967; c=relaxed/simple;
	bh=pb7koSi1mdWN7GrEo23T3F/LgZ/z651FyLLayGCI31c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5w5TWkExJTEl3mnbLkJoRhcnGs0q8CPB+AEs70R4jjm1vp0o4OWSM1Ph5wB6pLJbSUX39O95ajruX5cr/d++3potYKSXKqAoN735hBH0r1Nf8mcc9vtAMf0hzsYLt4csZuNCPzqQRvxBT+LIxNs/g8NnhfwyL9pEuQ+2FfuQFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GgWDHmOi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yYYNxzeN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xC7Vte8B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3phBpZ57; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6A101F387;
	Mon, 20 Oct 2025 09:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760952960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZGrk75lzeUcUPY7bXGOuLVFadRTcXNXHKGPKlcJJIk=;
	b=GgWDHmOiUNzNWIHKdVaazAdmxYnL/+OrBB0yIZxLTTBB/tZT4vigET2TkWSdwJLXjsXBw6
	p1bCRjTG8SuSV0mxhUDwNgCqR0jSRNyy0s73aoU8ukWk+SGWxH8pV3Q9CEi8XG0DRlpaBd
	W3fPCX9PexXBAdpWxUsiJFspQP0bVuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760952960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZGrk75lzeUcUPY7bXGOuLVFadRTcXNXHKGPKlcJJIk=;
	b=yYYNxzeNK+imXBRIhQzhMJbwBsLzZlTDL3dGHsG9mZ8cLlSpRrgpr+HOUnYzahsTrd/wDH
	iiPhYlGGmlclZTCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xC7Vte8B;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3phBpZ57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760952955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZGrk75lzeUcUPY7bXGOuLVFadRTcXNXHKGPKlcJJIk=;
	b=xC7Vte8BQNOemmEq2ZOO8I4JfrXVqsXBnlEYJmqD8gKlTmqcAm4Qq8uJmFKhAOSJJdUWsT
	o2uiiUo7scqHXncEvhIdDYN9sxjxJCkUPE+UEHSHuSUWlpvLdM/flg+wkHPdwxQ4SxBby0
	JvrsEabewyArTBDBzY71AN1xXfmrbIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760952955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ZGrk75lzeUcUPY7bXGOuLVFadRTcXNXHKGPKlcJJIk=;
	b=3phBpZ57woN99UzJW/kapoO8Am51aDTiUtiu/hDu8dB2Qn1R4UY0X6o5cbjCIqt+OFNa5f
	wXZocNlQujblr7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCB5313AAC;
	Mon, 20 Oct 2025 09:35:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Apf3MXsC9mgeDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:35:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C6A6A0856; Mon, 20 Oct 2025 11:35:51 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:35:51 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Carlos Maiolino <cem@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/3] writeback: cleanup writeback_chunk_size
Message-ID: <mf4onihgfgioim3c33d4jvcfixi6qvibqvp7ndp5wefocgwdke@vzjltwrvm47y>
References: <20251017034611.651385-1-hch@lst.de>
 <20251017034611.651385-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017034611.651385-2-hch@lst.de>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D6A101F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Fri 17-10-25 05:45:47, Christoph Hellwig wrote:
> Return the pages directly when calculated instead of first assigning
> them back to a variable, and directly return for the data integrity /
> tagged case instead of going through an else clause.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Looks good, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> ---
>  fs/fs-writeback.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2b35e80037fe..11fd08a0efb8 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1893,16 +1893,12 @@ static long writeback_chunk_size(struct bdi_writeback *wb,
>  	 *                   (maybe slowly) sync all tagged pages
>  	 */
>  	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
> -		pages = LONG_MAX;
> -	else {
> -		pages = min(wb->avg_write_bandwidth / 2,
> -			    global_wb_domain.dirty_limit / DIRTY_SCOPE);
> -		pages = min(pages, work->nr_pages);
> -		pages = round_down(pages + MIN_WRITEBACK_PAGES,
> -				   MIN_WRITEBACK_PAGES);
> -	}
> +		return LONG_MAX;
>  
> -	return pages;
> +	pages = min(wb->avg_write_bandwidth / 2,
> +		    global_wb_domain.dirty_limit / DIRTY_SCOPE);
> +	pages = min(pages, work->nr_pages);
> +	return round_down(pages + MIN_WRITEBACK_PAGES, MIN_WRITEBACK_PAGES);
>  }
>  
>  /*
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

