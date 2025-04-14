Return-Path: <linux-fsdevel+bounces-46364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C45F8A8801F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C613A9EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8342BD591;
	Mon, 14 Apr 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1LN99dSc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CQ0hOObU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1LN99dSc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CQ0hOObU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE427EC83
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744632767; cv=none; b=qVDb8YXAMyCi5ik3MzG1wLEYFyMiOXc5Hh11EQi0qYYQKHtA1ak70y7XAGypwBg0EyCS60V5QnyN/LiLydx2LQFA/WA9bTA+rT3iYeZWAIBQgW4Y1smoesU9doD9SUSOtHc1pirAtDFjWuHgDHmcG/2cd5QNjYQ06PWkYDDfCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744632767; c=relaxed/simple;
	bh=ENCN5x3UqZoK3dspT54xE0g8QUhPGicQX5vBEoOvbtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHVlnpG9PtB38mdrcG6w4TYs1l4WAHBnSM6hxSdqp4jDNJCxxkpiRVKKqHUSVUgE06aH4Sv44pWgaj7rcx+ToL1ajxFMke+O/t2QM+Jo54rioqNrv75p8eEOAOR88CdaEBBgOqo50N9wLXhgYtAv0hX2BQyQGfircf4wzqx128o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1LN99dSc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CQ0hOObU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1LN99dSc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CQ0hOObU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0BFE1F45F;
	Mon, 14 Apr 2025 12:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744632762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlkFtnpwAE5if8bFapspa1/JYvm/8UmbZU4eZJLXFyk=;
	b=1LN99dScidLHokALd1dYOCoP6pg5+3SHk8UsZlQ6jVIOj/6MHHc98uNzfsoXDolATz7LLU
	TmpC/ZAvOdBBb6T6oNVo9xepgvHHK5+A+aiJEA3WHpGHD0Vau9xzuSOspFECvUdgLuVJ+i
	djXk1+EB3qU2IaoktpT0PJqsWYEh/aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744632762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlkFtnpwAE5if8bFapspa1/JYvm/8UmbZU4eZJLXFyk=;
	b=CQ0hOObUL2hJ7Snkhjc2uGrVq8/AekYCwp83R8mzgoz4s8vy/rzomKMErDu/vl7wAwTl9O
	Q8sUErgWfN3IiIDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1LN99dSc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CQ0hOObU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744632762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlkFtnpwAE5if8bFapspa1/JYvm/8UmbZU4eZJLXFyk=;
	b=1LN99dScidLHokALd1dYOCoP6pg5+3SHk8UsZlQ6jVIOj/6MHHc98uNzfsoXDolATz7LLU
	TmpC/ZAvOdBBb6T6oNVo9xepgvHHK5+A+aiJEA3WHpGHD0Vau9xzuSOspFECvUdgLuVJ+i
	djXk1+EB3qU2IaoktpT0PJqsWYEh/aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744632762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlkFtnpwAE5if8bFapspa1/JYvm/8UmbZU4eZJLXFyk=;
	b=CQ0hOObUL2hJ7Snkhjc2uGrVq8/AekYCwp83R8mzgoz4s8vy/rzomKMErDu/vl7wAwTl9O
	Q8sUErgWfN3IiIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0F59136A7;
	Mon, 14 Apr 2025 12:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KsAYL7r7/GdlYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 14 Apr 2025 12:12:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4B4CAA094B; Mon, 14 Apr 2025 14:12:42 +0200 (CEST)
Date: Mon, 14 Apr 2025 14:12:42 +0200
From: Jan Kara <jack@suse.cz>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>, 
	brauner@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org, 
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk, hare@suse.de, 
	david@fromorbit.com, djwong@kernel.org, ritesh.list@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, 
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH v2 7/8] mm/migrate: enable noref migration for jbd2
Message-ID: <zbcvnyipzfzvcoaboldo6dbms3ppoi4mm65havqtknzi3iviwe@of5gwmgs6kpd>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-8-mcgrof@kernel.org>
 <rnhdk7ytdiiodckgc344novyknixn6jqeoy6bk4jjhtijjnc7z@qwofsm5ponwn>
 <20250410173028.2ucbsnlut2bpupm3@offworld>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410173028.2ucbsnlut2bpupm3@offworld>
X-Rspamd-Queue-Id: D0BFE1F45F
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,mit.edu,dilger.ca,vger.kernel.org,surriel.com,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 10-04-25 10:30:28, Davidlohr Bueso wrote:
> On Thu, 10 Apr 2025, Jan Kara wrote:
> 
> > > @@ -851,6 +851,8 @@ static int __buffer_migrate_folio(struct address_space *mapping,
> > > 		bool busy;
> > > 		bool invalidated = false;
> > > 
> > > +		VM_WARN_ON_ONCE(test_and_set_bit_lock(BH_Migrate,
> > > +						      &head->b_state));
> > 
> > Careful here. This breaks the logic with !CONFIG_DEBUG_VM.
> 
> Ok, I guess just a WARN_ON_ONCE() here then.

Or just:

	bool migrating = test_and_set_bit_lock(BH_Migrate, &head->b_state);

	VM_WARN_ON_ONCE(migrating);

Frankly, I find statements with side-effects in WARN_ON / BUG_ON statements
rather confusing practice...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

