Return-Path: <linux-fsdevel+bounces-64661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 670ADBF0319
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52C6189C871
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203452EACE9;
	Mon, 20 Oct 2025 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mFkp3atQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9VZHlyVs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tEH4hGHS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="heeIs2Rt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2EDDC5
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952885; cv=none; b=p+VzyrBJBGsjz/Jgmb+VBuj/OoZaG45LN2/OL5uNsiP5jIZ6Ub5ssdG+2aRqBX5BPc5Myv6VoRnUY06r7tNBVliuCqQPhqo+LXaGjWJo2svh4LbK1pQrj58PyrM5RFjUdmqAxYkBFUpA4CXMJ0VhGloKRg2eIdPsHezqwrCzG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952885; c=relaxed/simple;
	bh=Dw4XUOnaPL3PsnTOu8GYa5vaBXZyyttri4LJsZQSMoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkEUNTeEN0q5vXDi9ueHoai7+6jOblmfR3jQFHjLqiX/U8ZCz5KpuCuC09Amzc0YZCiOfnhWGO7UWsnXCQUy4za5/pOv+bzhoxi1s5YliqD88WHho6EELC0mfhoYYPD1k2nmZzaqImIX4iJV55/sNRjcKZHl5ZSMy7ZiXaQulh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mFkp3atQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9VZHlyVs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tEH4hGHS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=heeIs2Rt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CF9C921168;
	Mon, 20 Oct 2025 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760952878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=586HgrKwXL/CuLgCJVGk9xjDAYqg9yJZZ9H3nn0c7dk=;
	b=mFkp3atQlAVT+0yl8lRdhIhnlwdVbNqAGmtxzkM7/Q/yXyS3nRuRIJws6JzfAJmCRdLRC/
	XG3C53MecpZKoBdKe3gQPIYkxKsnsGUGLs2ceE1dsB2eqfALQpCuuuclT+VjyfXqg3VOl7
	dGhFchb7hZktk2AvdI+aQZoAeIdzd6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760952878;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=586HgrKwXL/CuLgCJVGk9xjDAYqg9yJZZ9H3nn0c7dk=;
	b=9VZHlyVsYS7V2qb1ILpSLp8b9tlQHQqeQGiKZ5PNj7EwAMMoh0QTAj3WbTtqLKchi0oIb9
	OCBllEs9wmHZr2AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tEH4hGHS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=heeIs2Rt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760952873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=586HgrKwXL/CuLgCJVGk9xjDAYqg9yJZZ9H3nn0c7dk=;
	b=tEH4hGHS9stepa4KIDU7TrDNXS1BCyLwGWk/TIAdHTnWKDzEKYAJnXujfW2rfmyRdSAijW
	xWSb9rITL8ayNiCHE4pBbWhz/jicx04JiWIXpDb9K61HUu5TiT80fVc5mpISwfUg513zLo
	T0Lx5wn1z2TQY1C5hjWlzqixKk3ZdSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760952873;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=586HgrKwXL/CuLgCJVGk9xjDAYqg9yJZZ9H3nn0c7dk=;
	b=heeIs2Rtcc/YWvixmcShz8E2YYYU0DBy6NikUfqTg+P//k+mtkSPJvUZfCNsIk3pzbPk5c
	LHNpprNHDL8XBRAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C13E813AAD;
	Mon, 20 Oct 2025 09:34:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id puInLykC9mi2CwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:34:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79670A0856; Mon, 20 Oct 2025 11:34:33 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:34:33 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Carlos Maiolino <cem@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/3] writeback: cleanup writeback_chunk_size
Message-ID: <ledzremc2x4ehhs6kfovuwexxyic6cwlqbb55dbtm4hnvovynr@tbm5cp6qt73u>
References: <20251015062728.60104-1-hch@lst.de>
 <20251015062728.60104-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015062728.60104-2-hch@lst.de>
X-Rspamd-Queue-Id: CF9C921168
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 15-10-25 15:27:14, Christoph Hellwig wrote:
> Return the pages directly when calculated instead of first assigning
> them back to a variable, and directly return for the data integrity /
> tagged case instead of going through an else clause.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

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

