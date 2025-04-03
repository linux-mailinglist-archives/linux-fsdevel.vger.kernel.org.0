Return-Path: <linux-fsdevel+bounces-45645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE47EA7A3F5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F40189206F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9F924EAA9;
	Thu,  3 Apr 2025 13:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IQWQh8Q/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AzDqvaI4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k7LzV/L2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8gwDFCz8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9B24CEFD
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687796; cv=none; b=XGpVVNkkCCF9D41ZkG4oh1u8y6WrYNjptpVrTWRs6+ON3zqnHgLoGe1K4KgzbFax/TczE/86AAzXc7o3yoFGNcjuskQiOS0Dj6bXnn5KXoAuQTvjxBVeF6VhFF8VXBlWY6EWjtJbKMnYqNw++LrK9v9nhJXOpQt+wsiMKfTpyu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687796; c=relaxed/simple;
	bh=h+/40XnE4M1ObFUjyw0jMuZBvlkkFdEsQyY1PypAW9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIRXvva5u6nBRNojHDYizFVHWOW6qvqokw3HnjMVzfucAyWUOaR0rWUMqYjoDIbfaw9Bz0bAESrW38xb598QA8FbKLNg5MVl9am0yfThW+heve+C0yE0VcXpk4XwVF/TOdGOaDZLcuhroMe9uEIP3UM6NgdTwFyNs+vjRnbK8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IQWQh8Q/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AzDqvaI4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k7LzV/L2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8gwDFCz8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1FFF1F385;
	Thu,  3 Apr 2025 13:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743687793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0HKsQEfUkokQcI1XDwFnvMLnauwvRudsWJ5iSkoq5M=;
	b=IQWQh8Q/XlPMav3P0EvDPUlrJCBZGa5PHagsZMW2/FgQw7lymS6HGYEK9Zy0PpoHI1mK9c
	ceUFu+tCCyvoUHOzyXuvPO9+3RLoaKeNhoR8qM+i6FuBgUXKhj0AWhK59W1bIfeC4UlaxO
	wATUECIBuaEQ5evzZ6+BE2FvKlp9lgA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743687793;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0HKsQEfUkokQcI1XDwFnvMLnauwvRudsWJ5iSkoq5M=;
	b=AzDqvaI4zqHoTG49hrM/h4mJWnBY1Wb27JwZS6qjJjVIR3ww2JXjUuRWmlFfIcR//yMjYk
	BpjYSfsactfEdECg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743687792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0HKsQEfUkokQcI1XDwFnvMLnauwvRudsWJ5iSkoq5M=;
	b=k7LzV/L2Ov5PAXXw40YgZCJNrYfZ/ouuRuwAOFMGbTk0EwFnDZJFutlNiZJvW5M5ne1fX8
	pRr19VgRmmpdiOG8fHyjWa+IhRg9CqQysh9EGETkCds5H4AjkVDGTkflOFKFMuX+WIBcih
	Bh5yLeYw0fclm0/A5/rjx/gxrHTruAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743687792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0HKsQEfUkokQcI1XDwFnvMLnauwvRudsWJ5iSkoq5M=;
	b=8gwDFCz80y1MljbRrDcPwW0WwHcXymNBRIycLjMb3r+Uch1A0HvjuMhy6xbmNwG7N61gYm
	JI7jtzfL/pTRnIDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B157613A2C;
	Thu,  3 Apr 2025 13:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TzpGK3CQ7mdsRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Apr 2025 13:43:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 48D8BA07E6; Thu,  3 Apr 2025 15:43:12 +0200 (CEST)
Date: Thu, 3 Apr 2025 15:43:12 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	brauner@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	linux-ext4@vger.kernel.org, riel@surriel.com, hannes@cmpxchg.org, oliver.sang@intel.com, 
	david@redhat.com, axboe@kernel.dk, hare@suse.de, david@fromorbit.com, 
	djwong@kernel.org, ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com, 
	da.gomez@samsung.com
Subject: Re: [PATCH 2/3] fs/buffer: avoid races with folio migrations on
 __find_get_block_slow()
Message-ID: <2jrcw4mtwcophanqmi2y74ffgf247m6ap44u3gedpylsjl3bz6@yueuwkmcwm66>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
 <lj6o73q6nev776uvy7potqrn5gmgtm4o2cev7dloedwasxcsmn@uanvqp3sm35p>
 <20250401214951.kikcrmu5k3q6qmcr@offworld>
 <Z-yZxMVJgqOOpjHn@casper.infradead.org>
 <Z-3spxNHYe_CbLgP@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-3spxNHYe_CbLgP@bombadil.infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,kernel.org,mit.edu,dilger.ca,vger.kernel.org,surriel.com,cmpxchg.org,intel.com,redhat.com,kernel.dk,suse.de,fromorbit.com,gmail.com,kvack.org,samsung.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.30
X-Spam-Flag: NO

On Wed 02-04-25 19:04:23, Luis Chamberlain wrote:
> On Wed, Apr 02, 2025 at 02:58:28AM +0100, Matthew Wilcox wrote:
> > On Tue, Apr 01, 2025 at 02:49:51PM -0700, Davidlohr Bueso wrote:
> > > So the below could be tucked in for norefs only (because this is about the addr
> > > space i_private_lock), but this also shortens the hold time; if that matters
> > > at all, of course, vs changing the migration semantics.
> > 
> > I like this approach a lot better.  One wrinkle is that it doesn't seem
> > that we need to set the BH_Migrate bit on every buffer; we could define
> > that it's only set on the head BH, right?
> 
> Yes, we are also only doing this for block devices, and for migration
> purposes. Even though a bit from one buffer may be desirable it makes
> no sense to allow for that in case migration is taking place.  So indeed
> we have no need to add the flag for all buffers.
> 
> I think the remaining question is what users of __find_get_block_slow()
> can really block, and well I've started trying to determine that with
> coccinelle [0], its gonna take some more time.
> 
> Perhaps its easier to ask, why would a block device mapping want to
> allow __find_get_block_slow() to not block?

So I've audited all callers of __find_get_block_slow() (there aren't that
many) and most of them are actually fine with sleeping these days.

Analysis:
__find_get_block_slow() is only used from __find_get_block().

__find_get_block() is used from:
  write_boundary_block() - locks the buffer so can sleep
  bdev_getblk() - allocates buffers with 'gfp' mask. We use GFP_NOWAIT mask
     from some places (generally doing readahead). For callers where
     !gfpflags_allow_blocking() we should bail rather than block on
     migration. Callers are currently fine with this, we should probably
     document that bdev_getblk() with restrictive gfp mask may fail even if
     bh is present - or perhaps make this even more explicit in the API by
     providing bdev_try_getblk() and make bdev_getblk() assert gfp mask
     allows sleeping.
  __getblk_slow() - only called from bdev_getblk(). Probably should fold
     there.
  ocfs2_force_read_journal() - allows sleeping as it does IO
  jbd2_journal_revoke() - can sleep (has might_sleep() in the beginning)
  jbd2_journal_cancel_revoke() - only used from do_get_write_access() and
    do_get_create_access() which do sleep. So can sleep.
  jbd2_clear_buffer_revoked_flags() - only called from journal commit code
    which sleeps. So can sleep.

The last user is sb_find_get_block() which is used from:
  hpfs_prefetch_sectors() - prefers bail rather than blocking
  fat_dir_readahead() - prefers bail rather than blocking
  exfat_dir_readahead() - prefers bail rather than blocking
  ext4_free_blocks() - can sleep
  ext4_getblk() - depending on EXT4_GET_BLOCKS_CACHED_NOWAIT flag either can
    sleep or must bail (and is fine with it) rather than sleeping
  fs/ext4/ialloc.c:recently_deleted() - this one is the most problematic
    place. It must bail rather than sleeping (called under a spinlock) but
    it depends on the fact that if bh is not returned, then the data has been
    written out and evicted from memory. Luckily, the usage of
    recently_deleted() is mostly an optimization to reduce damage in case
    of crash so rare false failure should be OK. Ted, what is your opinion?

And this is actually all. So it seems that if we give possibility to
callers to tell whether they want to bail or wait for migration, things
should work out fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

