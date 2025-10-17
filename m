Return-Path: <linux-fsdevel+bounces-64654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E254BF00E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 10:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01793E45FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35362ED87C;
	Mon, 20 Oct 2025 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TlxL9JlF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gXXHg0Kl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vzvzZxbD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VIksI5YE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1F22ECE9F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950612; cv=none; b=o0rrEB9uqOtNKdopAhHUv3enNrFC7dyjOkubRvKmww4r8q3h+bi7Qgc9s4RxFjnXF11SIq6zOIihq+ybhP08M4imj08AukctG2/3hgU09OtPR+lAKTdpXcMfHWQb3tVZqUyUaRsBRYGoF30XVBNDmnTclkqewHzxq9ufUpqa2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950612; c=relaxed/simple;
	bh=9Thl4a/O1BCyX7iZmCSKfY0KKrGMBe5Tsvyi5pBcUpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjXON7BepvQdMD6akveyb/QPgYvr1+I76QiDh/A7YKDHsg4FzbO7vtEEkq4qmmpxjVkWaJ4W0q0Tp+ImqFjxHKi4GItTHrY8Lif43y+AzAD8extssqeZ/Wg6tyMwu2SUaPyGs02F0GQuPEKIzi02uzOSxhJ08hDwVy8gKGBYA4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TlxL9JlF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gXXHg0Kl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vzvzZxbD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VIksI5YE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D17D211B8;
	Mon, 20 Oct 2025 08:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fQY0APsh278CNyuTjNL9Yy0qeDKE7+Zcmc3dmDr7Y+M=;
	b=TlxL9JlFKAwndySpNh1I4Xnpg+anKZtDS2y7PLBVYdVZB7gGE42Eft7flIcOwlzJekyb/H
	8xSmF1RB3x9rGFTUoA/XbcKXE+2tJb3vhLo5sjnVbnD4s9zN3ZbR179yMu9iNcfSEXNUYT
	nmrBvC7TgqeK3yd/Fnoi2eMkjwfbmIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fQY0APsh278CNyuTjNL9Yy0qeDKE7+Zcmc3dmDr7Y+M=;
	b=gXXHg0KlWO4+TWtwoeLcQuoEG3EdCqDE8es+TnpxNAm6kb5Dyc5GZDdHWM8MsMpm6/Iaxw
	xpo6pO7tMr9c0FDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760950599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fQY0APsh278CNyuTjNL9Yy0qeDKE7+Zcmc3dmDr7Y+M=;
	b=vzvzZxbD2eARALY0nC9MdjGZl7efuKpM85/ydlJTdvKl9hrU6/UuhQ6gXc2IXvUXRNITjB
	uZluy1E4oNR15ymaxudBDLqfL6yO1zouznWc02xlGpbN9vPCoqK+HBeCsoZTCtsc4zTKVr
	efmdxJ11prXT1MNcDmBeES6yxqJYtss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760950599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fQY0APsh278CNyuTjNL9Yy0qeDKE7+Zcmc3dmDr7Y+M=;
	b=VIksI5YEww7h0zhiJyytFnfGeUaB4o1TdSNVirrjWiwXZf3WwvJPHnoF17PXG29f53f3nR
	3Nd2dZzJa75SJPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F15513B08;
	Mon, 20 Oct 2025 08:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 94SMB0H59WhgZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 08:56:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4D80A28E1; Fri, 17 Oct 2025 14:31:06 +0200 (CEST)
Date: Fri, 17 Oct 2025 14:31:06 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Carlos Maiolino <cem@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	dlemoal@kernel.org, hans.holmberg@wdc.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 1/3] writeback: cleanup writeback_chunk_size
Message-ID: <wjk2656emsjxsyjm2l7qnsaeg5oospkhwxp2gt3hhj4jsr5ul5@5aps7ijypzol>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DATE_IN_PAST(1.00)[68];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On Fri 17-10-25 05:45:47, Christoph Hellwig wrote:
> Return the pages directly when calculated instead of first assigning
> them back to a variable, and directly return for the data integrity /
> tagged case instead of going through an else clause.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

I think I've already given my tag to this patch but anyway, feel free to
add:

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

