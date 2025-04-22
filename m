Return-Path: <linux-fsdevel+bounces-46918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB60A9674D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC10A3ADFE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9B27BF87;
	Tue, 22 Apr 2025 11:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EEUSmd9Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IBdSlQ01";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EEUSmd9Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IBdSlQ01"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178F27BF74
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321159; cv=none; b=NPlU+/Sa3s764jm7a1cQKwj9Sm5bwc63C/+/AwqiI0Qi0csVFFrIWbULvNAd6FlEqBJcSB632wWzaMkoi2f7F6yoUyK5qamvw2R5Uyh99QxGrTVTpf62hszcrhHORBO71ZT8CyicOe69u0Xc2PG9NV4T4sorQwh5MTf6NUpFJ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321159; c=relaxed/simple;
	bh=xMwBI9JrSwhqTpbGiRz6Y57HnmM05ftBgV6XDhxHO3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adY0G/u6dzA0vkWGTKGmie9/WNcz581kJsQXba0fBKhnWSl80g9wrzFz9ate1yB+GiI6fQvbdQgXHVkZPRxobGE0OSVORogAPIEotF4dJ+6qMZ6lc7zsgrbwgjTmdLY4resfof/qIHLza9ug45YgFFMk6RSsohMlZJT0L9N0TaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EEUSmd9Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IBdSlQ01; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EEUSmd9Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IBdSlQ01; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C78A321187;
	Tue, 22 Apr 2025 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745321155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iO6vzueM4CxUgcbkft4Y4vPzSVxQmwKdoliK2EKUjiQ=;
	b=EEUSmd9ZXncONRT13T3UzRXYGC+hvbX92t9/Fgj7M9Eev+PbyfHP6gkcRi6F3lgDHDsiYc
	ODuzVnK5e3aEBzJvu/lfzlqb04F/JjEfg9QOkuv5BtJeUH2jjg19381+zCYhjHkoXQR4Nn
	CKrFj6Imtf0pZtFO1lUZ7V8mdYy1Kzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745321155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iO6vzueM4CxUgcbkft4Y4vPzSVxQmwKdoliK2EKUjiQ=;
	b=IBdSlQ01m3XklXTdLALO8NRVSSvfWU13y2aoIbwF4rCkgrojv/0oDSCw/7wpjAoYbwSB7/
	9n2gvnKpezPsdeCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745321155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iO6vzueM4CxUgcbkft4Y4vPzSVxQmwKdoliK2EKUjiQ=;
	b=EEUSmd9ZXncONRT13T3UzRXYGC+hvbX92t9/Fgj7M9Eev+PbyfHP6gkcRi6F3lgDHDsiYc
	ODuzVnK5e3aEBzJvu/lfzlqb04F/JjEfg9QOkuv5BtJeUH2jjg19381+zCYhjHkoXQR4Nn
	CKrFj6Imtf0pZtFO1lUZ7V8mdYy1Kzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745321155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iO6vzueM4CxUgcbkft4Y4vPzSVxQmwKdoliK2EKUjiQ=;
	b=IBdSlQ01m3XklXTdLALO8NRVSSvfWU13y2aoIbwF4rCkgrojv/0oDSCw/7wpjAoYbwSB7/
	9n2gvnKpezPsdeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7EE2139D5;
	Tue, 22 Apr 2025 11:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bcDjLMN8B2hsCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Apr 2025 11:25:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 66ABEA0A56; Tue, 22 Apr 2025 13:25:55 +0200 (CEST)
Date: Tue, 22 Apr 2025 13:25:55 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Linus Torvalds <torvalds@linux-foundation.org>, jack@suse.cz, tytso@mit.edu, adilger.kernel@dilger.ca, 
	brauner@kernel.org, willy@infradead.org, hare@suse.de, djwong@kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next 0/7] fs/buffer: split pagecache lookups into atomic
 or blocking
Message-ID: <defginw6pm72k5obplzmgzjo2bw4yonaahpbnockb2akqv4qbr@f7egm23q5ozi>
References: <20250415231635.83960-1-dave@stgolabs.net>
 <aAAEvcrmREWa1SKF@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAAEvcrmREWa1SKF@bombadil.infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 16-04-25 12:27:57, Luis Chamberlain wrote:
> On Tue, Apr 15, 2025 at 04:16:28PM -0700, Davidlohr Bueso wrote:
> > Hello,
> > 
> > This is a respin of the series[0] to address the sleep in atomic scenarios for
> > noref migration with large folios, introduced in:
> > 
> >       3c20917120ce61 ("block/bdev: enable large folio support for large logical block sizes")
> > 
> > The main difference is that it removes the first patch and moves the fix (reducing
> > the i_private_lock critical region in the migration path) to the final patch, which
> > also introduces the new BH_Migrate flag. It also simplifies the locking scheme in
> > patch 1 to avoid folio trylocking in the atomic lookup cases. So essentially blocking
> > users will take the folio lock and hence wait for migration, and otherwise nonblocking
> > callers will bail the lookup if a noref migration is on-going. Blocking callers
> > will also benefit from potential performance gains by reducing contention on the
> > spinlock for bdev mappings.
> > 
> > It is noteworthy that this series is probably too big for Linus' tree, so there are
> > two options:
> > 
> >  1. Revert 3c20917120ce61, add this series + 3c20917120ce61 for next. Or,
> 
> Reverting due to a fix series is odd, I'd advocate this series as a set
> of fixes to Linus' tree because clearly folio migration was not complete
> for buffer_migrate_folio_norefs() and this is part of the loose bits to help
> it for large folios. This issue was just hard to reproduce. The enabler
> of large folios on the block device cache is actually commit
> 47dd67532303 ("block/bdev: lift block size restrictions to 64k") which
> goes later after 3c20917120ce61.

I fully agree reverting anything upstream when there's fix series available
is just pointless.
 
> Jan Kara, since you've already added your Reviewed-by for all patches
> do you have any preference how this trickles to Linus?

I think pushing it normally through VFS tree is fine.

> >  2. Cherry pick patch 7 as a fix for Linus' tree, and leave the rest for next.
> >     But that could break lookup callers that have been deemed unfit to bail.
> > 
> > Patch 1: carves a path for callers that can block to take the folio lock.
> > Patch 2: adds sleeping flavors to pagecache lookups, no users.
> > Patches 3-6: converts to the new call, where possible.
> > Patch 7: does the actual sleep in atomic fix.
> > 
> > Thanks!
> 
> kdevops has tested this patch series and compared it to the baseline [0]
> and has found no regressions on ext4.
> 
> Tested-by: kdevops@lists.linux.dev

Cool, thanks for testing.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

