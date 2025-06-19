Return-Path: <linux-fsdevel+bounces-52200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A3AAE0271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 12:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4199818854B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525952222C8;
	Thu, 19 Jun 2025 10:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSm7u+UA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IxiBQ0WM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSm7u+UA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IxiBQ0WM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E397C35963
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328022; cv=none; b=B7PyZdDtPtjcAUw4qtvkPZPZF10KN/RbvM764qvj41HokS3j9v1rj89O+i+zlmNlq84nJ7sEcp1MtyH7rYkL++KplFCQgX5RaLWVT0PZk/K/g1073aMI9US2GmzSMAkzovez8I91kFD1u/fIsiCffWSj24NiRqZI+9jvxYVCRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328022; c=relaxed/simple;
	bh=lARrWwBoH5RijGIo1sVjDiUQo7cWexM0QdYFzXi5EMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+tfA7LDUsUdsmremQZzXTzre4NmYhtmwQgtQKsbhspCQNxc5QlH4TNCQOvLCKEVGqWf9d3rQkkcjdj41uDfzGF8P7Ul8PJTA1KCIiHuoIHGqE+4cedtNGN9ru0Ykfa5pLDCdu4UXryiZviU4Dzo3bchUVVuQcpqop9/ol+0WvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSm7u+UA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IxiBQ0WM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSm7u+UA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IxiBQ0WM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FE692118B;
	Thu, 19 Jun 2025 10:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750328018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTI9Z6Q3pmfjpibUSNSxQNyenk2QP8gVYElzIW24P5E=;
	b=cSm7u+UAe5Xh+vN31/0FzJ8bbPuXC+h2Sr5duY0AjWKaHR592t4k2jHJ9aoDOsS1rxUp3A
	jD057Hh+Lye6qDEgL02BXWMDw8id51Ox7LoYXe5gKBF3/rKUHy7AH7SO+IgfervoX2BNQO
	8RpYpJccYQozguVf9kEnSmC1aQ1pt3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750328018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTI9Z6Q3pmfjpibUSNSxQNyenk2QP8gVYElzIW24P5E=;
	b=IxiBQ0WMbf1X7CSOX5+R9KJO4R+A0LK68NGp3FRVJ2eCygw5VcXnuuHbguL75S1t1tmynK
	YrHzVRMX+/gOWuCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750328018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTI9Z6Q3pmfjpibUSNSxQNyenk2QP8gVYElzIW24P5E=;
	b=cSm7u+UAe5Xh+vN31/0FzJ8bbPuXC+h2Sr5duY0AjWKaHR592t4k2jHJ9aoDOsS1rxUp3A
	jD057Hh+Lye6qDEgL02BXWMDw8id51Ox7LoYXe5gKBF3/rKUHy7AH7SO+IgfervoX2BNQO
	8RpYpJccYQozguVf9kEnSmC1aQ1pt3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750328018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jTI9Z6Q3pmfjpibUSNSxQNyenk2QP8gVYElzIW24P5E=;
	b=IxiBQ0WMbf1X7CSOX5+R9KJO4R+A0LK68NGp3FRVJ2eCygw5VcXnuuHbguL75S1t1tmynK
	YrHzVRMX+/gOWuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 116D7136CC;
	Thu, 19 Jun 2025 10:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kA7iA9LiU2gJVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Jun 2025 10:13:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B8E5AA29F1; Thu, 19 Jun 2025 12:13:33 +0200 (CEST)
Date: Thu, 19 Jun 2025 12:13:33 +0200
From: Jan Kara <jack@suse.cz>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Jan Kara <jack@suse.cz>, Pankaj Raghav <p.raghav@samsung.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, mcgrof@kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH] fs/buffer: use min folio order to calculate upper limit
 in __getblk_slow()
Message-ID: <qu2m6fw64ikk5dapckywr7tuyqjsyktvn4hnr7nl7py7p5dpbt@tzbvv6ivfvuu>
References: <20250618091710.119946-1-p.raghav@samsung.com>
 <rf5sve3v7vlkzae7ralok4vkkit24ashon3htmp56rmqshgcv5@a3bmz7mpkcwb>
 <lv3zoqm3uuzfqskcr734btb3hgqy67ddmd4ik2vidl3y3qv2hj@2zb34igia4o5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lv3zoqm3uuzfqskcr734btb3hgqy67ddmd4ik2vidl3y3qv2hj@2zb34igia4o5>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 

On Wed 18-06-25 21:50:56, Pankaj Raghav (Samsung) wrote:
> > > diff --git a/fs/buffer.c b/fs/buffer.c
> > > index 8cf4a1dc481e..98f90da69a0a 100644
> > > --- a/fs/buffer.c
> > > +++ b/fs/buffer.c
> > > @@ -1121,10 +1121,11 @@ __getblk_slow(struct block_device *bdev, sector_t block,
> > >  	     unsigned size, gfp_t gfp)
> > >  {
> > >  	bool blocking = gfpflags_allow_blocking(gfp);
> > > +	int blocklog = PAGE_SHIFT + mapping_min_folio_order(bdev->bd_mapping);
> > >  
> > >  	/* Size must be multiple of hard sectorsize */
> > > -	if (unlikely(size & (bdev_logical_block_size(bdev)-1) ||
> > > -			(size < 512 || size > PAGE_SIZE))) {
> > > +	if (unlikely(size & (bdev_logical_block_size(bdev) - 1) ||
> > > +		     (size < 512 || size > (1U << blocklog)))) {
> > 
> > So this doesn't quite make sense to me.  Shouldn't it be capped from above
> > by PAGE_SIZE << mapping_max_folio_order(bdev->bd_mapping)?
> 
> This __getblk_slow() function is used to read a block from a block
> device and fill the page cache along with creating buffer heads.
> 
> I think the reason we have this check is to make sure the size, which is
> block size is within the limits from 512 (SECTOR_SIZE) to upper limit on block size.
> 
> That upper limit on block size was PAGE_SIZE before the lbs support in 
> block devices, but now the upper limit of block size is mapping_min_folio_order.
> We set that in set_blocksize(). So a single block cannot be bigger than
> (PAGE_SIZE << mapping_min_folio_order).

Ah, right. Thanks for explanation. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

