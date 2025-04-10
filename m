Return-Path: <linux-fsdevel+bounces-46206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F1A84522
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 15:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF5A1890D1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D128C5C4;
	Thu, 10 Apr 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qcxx7Lkr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHJaBBi5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qcxx7Lkr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHJaBBi5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59F28C5C3
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744292445; cv=none; b=diWeQhLD+GwRqAnHOeVRZFxMaArovabpmMbLDVJ38GjbJSa7LnpLM8rvtgR3jVLfFWrkN2jE6FBptbnxsExWMGRxxHpdqcBKSnlHK1ou2xpMSVwfZVpS+wV520HKai1JxRJ7FcWzw7rBlDHZ+WTLxouUb7CMvo6KimbQGTEjyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744292445; c=relaxed/simple;
	bh=/z1Dxc/gPFoQk0tHAmLU9NdqOZTDLpJgMceTXVZvpZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAEFg014IW5OhDyWzkDiHMCSw8FQpHR3y+3ETfiQiKOVF73TIs2LpQq7uKmKkcdqBUHUZpKsJdeoKchdHK9bubSh4zzlHZQCe8XmGbU2faxXg4YhghtnI34rVgeYT4rVp5bI9q9sdD7dHw62xWVsW6hX7G9QnnR5iv3IQ1KzVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qcxx7Lkr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHJaBBi5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qcxx7Lkr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHJaBBi5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76E6B1F38C;
	Thu, 10 Apr 2025 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744292441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEW/4t0fah9hh4ytyQQ4jogiOr/8+G0+ynUBVfQmIL0=;
	b=qcxx7LkrBge3ML8u/3xGayWdW+uSIJpUrCghWo+4xJ/SYGD5HSRa1CYU9AtlcXv0iE40lD
	QFugZjjpa3mhIKWobHz7xpbARuSaEiG8D5xogNgMWX/+rpDyLenwX6YoLidp4tYBLBDFkq
	w+lKj0PcFrFHHsCpMs1+sXyKx9q4/PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744292441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEW/4t0fah9hh4ytyQQ4jogiOr/8+G0+ynUBVfQmIL0=;
	b=pHJaBBi5BKo95YTHZLOK8XrhXGX6mRe1JPV+Aj7hI3VboiFPJuJiQZYUiiT8uso8L8q0Ln
	QvQ0spqVY8MiJ6DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qcxx7Lkr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pHJaBBi5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744292441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEW/4t0fah9hh4ytyQQ4jogiOr/8+G0+ynUBVfQmIL0=;
	b=qcxx7LkrBge3ML8u/3xGayWdW+uSIJpUrCghWo+4xJ/SYGD5HSRa1CYU9AtlcXv0iE40lD
	QFugZjjpa3mhIKWobHz7xpbARuSaEiG8D5xogNgMWX/+rpDyLenwX6YoLidp4tYBLBDFkq
	w+lKj0PcFrFHHsCpMs1+sXyKx9q4/PI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744292441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lEW/4t0fah9hh4ytyQQ4jogiOr/8+G0+ynUBVfQmIL0=;
	b=pHJaBBi5BKo95YTHZLOK8XrhXGX6mRe1JPV+Aj7hI3VboiFPJuJiQZYUiiT8uso8L8q0Ln
	QvQ0spqVY8MiJ6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69B5A132D8;
	Thu, 10 Apr 2025 13:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 18ndGVnK92d0bAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Apr 2025 13:40:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17607A0910; Thu, 10 Apr 2025 15:40:41 +0200 (CEST)
Date: Thu, 10 Apr 2025 15:40:41 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: brauner@kernel.org, jack@suse.cz, tytso@mit.edu, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, riel@surriel.com, dave@stgolabs.net, 
	willy@infradead.org, hannes@cmpxchg.org, oliver.sang@intel.com, david@redhat.com, 
	axboe@kernel.dk, hare@suse.de, david@fromorbit.com, djwong@kernel.org, 
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH v2 7/8] mm/migrate: enable noref migration for jbd2
Message-ID: <rnhdk7ytdiiodckgc344novyknixn6jqeoy6bk4jjhtijjnc7z@qwofsm5ponwn>
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-8-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410014945.2140781-8-mcgrof@kernel.org>
X-Rspamd-Queue-Id: 76E6B1F38C
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,mit.edu,dilger.ca,vger.kernel.org,surriel.com,stgolabs.net,infradead.org,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 09-04-25 18:49:44, Luis Chamberlain wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Add semantics to enable future optimizations for buffer head noref jbd2
> migration. This adds a new BH_Migrate flag which ensures we can bail
> on the lookup path. This should enable jbd2 to get semantics of when
> a buffer head is under folio migration, and should yield to it and to
> eventually remove the buffer_meta() check skipping current jbd2 folio
> migration.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Co-developed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

..

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 32fa72ba10b4..8fed2655f2e8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -851,6 +851,8 @@ static int __buffer_migrate_folio(struct address_space *mapping,
>  		bool busy;
>  		bool invalidated = false;
>  
> +		VM_WARN_ON_ONCE(test_and_set_bit_lock(BH_Migrate,
> +						      &head->b_state));

Careful here. This breaks the logic with !CONFIG_DEBUG_VM.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

