Return-Path: <linux-fsdevel+bounces-4433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8B7FF66E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B4228168A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8070D54FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t5ZL3j1Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D6XOS6NE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826BA10D5;
	Thu, 30 Nov 2023 08:01:58 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0CA8F21B2C;
	Thu, 30 Nov 2023 16:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701360117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8kmfcckQ0W7ImJ1VNJWlVy+wCrbCrSOpYpo3nSwGEM=;
	b=t5ZL3j1Q5NekY+6YklB5OqjPoGUMODATtLZxSrzcZf5KVjsgvkPkOn0bFczJxT4RE17984
	MB8XAo56XWZq5bk9YHSJWK9cvctjaMt7TwC2Vijc0An7XbT7zsYZSI4EY1+N9lZPORfAAV
	m8SGYlAij5HZno7kVGAnPjE1X6Y8oOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701360117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8kmfcckQ0W7ImJ1VNJWlVy+wCrbCrSOpYpo3nSwGEM=;
	b=D6XOS6NESUFWxZ4CubFPvhN7PgRyKYVagEq0utHSoRYmgZG63dibEi/gh9qUaorMPZfPw9
	s/RzNaG1E9i0YlBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EF5FF13A5C;
	Thu, 30 Nov 2023 16:01:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id o1hoOvSxaGXoCwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 16:01:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4DDBFA07E0; Thu, 30 Nov 2023 17:01:56 +0100 (CET)
Date: Thu, 30 Nov 2023 17:01:56 +0100
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use
 iomap
Message-ID: <20231130160156.xlorirxomdgpko5o@quack3>
References: <20231130140859.hdgvf24ystz2ghdv@quack3>
 <878r6fi6jy.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r6fi6jy.fsf@doe.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email,suse.cz:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Thu 30-11-23 21:20:41, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Thu 30-11-23 16:29:59, Ritesh Harjani wrote:
> >> Jan Kara <jack@suse.cz> writes:
> >> 
> >> > On Thu 30-11-23 13:15:58, Ritesh Harjani wrote:
> >> >> Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> >> >> 
> >> >> > Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:
> >> >> >
> >> >> >> Christoph Hellwig <hch@infradead.org> writes:
> >> >> >>
> >> >> >>> On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
> >> >> >>>> writeback bit set. XFS plays the revalidation sequence counter games
> >> >> >>>> because of this so we'd have to do something similar for ext2. Not that I'd
> >> >> >>>> care as much about ext2 writeback performance but it should not be that
> >> >> >>>> hard and we'll definitely need some similar solution for ext4 anyway. Can
> >> >> >>>> you give that a try (as a followup "performance improvement" patch).
> >> >> 
> >> >> ok. So I am re-thinknig over this on why will a filesystem like ext2
> >> >> would require sequence counter check. We don't have collapse range
> >> >> or COW sort of operations, it is only the truncate which can race,
> >> >> but that should be taken care by folio_lock. And even if the partial
> >> >> truncate happens on a folio, since the logical to physical block mapping
> >> >> never changes, it should not matter if the writeback wrote data to a
> >> >> cached entry, right?
> >> >
> >> > Yes, so this is what I think I've already mentioned. As long as we map just
> >> > the block at the current offset (or a block under currently locked folio),
> >> > we are fine and we don't need any kind of sequence counter. But as soon as
> >> > we start caching any kind of mapping in iomap_writepage_ctx we need a way
> >> > to protect from races with truncate. So something like the sequence counter.
> >> >
> >> 
> >> Why do we need to protect from the race with truncate, is my question here.
> >> So, IMO, truncate will truncate the folio cache first before releasing the FS
> >> blocks. Truncation of the folio cache and the writeback path are
> >> protected using folio_lock()
> >> Truncate will clear the dirty flag of the folio before
> >> releasing the folio_lock() right, so writeback will not even proceed for
> >> folios which are not marked dirty (even if we have a cached wpc entry for
> >> which folio is released from folio cache).
> >> 
> >> Now coming to the stale cached wpc entry for which truncate is doing a
> >> partial truncation. Say, truncate ended up calling
> >> truncate_inode_partial_folio(). Now for such folio (it remains dirty
> >> after partial truncation) (for which there is a stale cached wpc entry),
> >> when writeback writes to the underlying stale block, there is no harm
> >> with that right?
> >> 
> >> Also this will "only" happen for folio which was partially truncated.
> >> So why do we need to have sequence counter for protecting against this
> >> race is my question. 
> >
> > That's a very good question and it took me a while to formulate my "this
> > sounds problematic" feeling into a particular example :) We can still have
> > a race like:
> >
> > write_cache_pages()
> >   cache extent covering 0..1MB range
> >   write page at offset 0k
> > 					truncate(file, 4k)
> > 					  drops all relevant pages
> > 					  frees fs blocks
> > 					pwrite(file, 4k, 4k)
> > 					  creates dirty page in the page cache
> >   writes page at offset 4k to a stale block
> 
> :) Nice! 
> Truncate followed by an append write could cause this race with writeback
> happening in parallel. And this might cause data corruption.
> 
> Thanks again for clearly explaining the race :) 
> 
> So I think just having a seq. counter (no other locks required), should
> be ok to prevent this race. Since mostly what we are interested in is
> whether the stale cached block mapping got changed for the folio which
> writeback is going to continue writing to.
> 
> i.e. the race only happens when 2 of these operation happen while we
> have a cached block mapping for a folio - 
> - a new physical block got allocated for the same logical offset to
> which the previous folio belongs to 
> - the folio got re-instatiated in the page cache as dirty with the new
> physical block mapping at the same logical offset of the file.
> 
> Now when the writeback continues, it will iterate over the same
> dirty folio in question, lock it, check for ->map_blocks which will
> notice a changed seq counter and do ->get_blocks again and then
> we do submit_bio() to the right physical block.
> 
> So, it should be ok, if we simply update the seq counter everytime a
> block is allocated or freed for a given inode... because when we
> check the seq counter, we know the folio is locked and the other
> operation of re-instating a new physical block mapping for a given folio
> can also only happen while under a folio lock. 

Yes.

> OR, one other approach to this can be... 
> 
> IIUC, for a new block mapping for the same folio, the folio can be made to
> get invalidated once in between right? So should this be handled in folio
> cache somehow to know if for a given folio the underlying mapping might
> have changed for which iomap should again query  ->map_blocks() ? 
> ... can that also help against unnecessary re-validations against cached
> block mappings?

This would be difficult because the page cache handling code does not know
someone has cached block mapping somewhere...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

