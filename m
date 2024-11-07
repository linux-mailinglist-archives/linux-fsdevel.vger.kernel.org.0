Return-Path: <linux-fsdevel+bounces-33883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 788DB9C01BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0511C21D54
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE26E1E7677;
	Thu,  7 Nov 2024 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dEyWEJFP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2xj1YwUi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dEyWEJFP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2xj1YwUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5921DFE09;
	Thu,  7 Nov 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973679; cv=none; b=sG4wz07kx/TkKmHEwABL/F/n0NtitGUKvx76yUmeBuYWeiBQrfGeLcpCbOAsJ+A5zPoNFEHPaGmzRetCMedv4W1QxhIxUcvSAujjX64NZtg9jcbRQv9I9t7qXAI2gU5khd6eSHFxjWJ7TrNh9mPMlVLMSbxRc+IniscF80CSfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973679; c=relaxed/simple;
	bh=xzy1a+XIjSNMU/9hC5QgXrBmdrtIFDc4aIusSqqZDyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afpsO4iCyCaS2PrdEr2RuLJpxqHuttj5LanvScfXQImj5tzLtyqvdMLYzswGWEQNws3qOWEVdKA6ve1oq52dEEFXFhCKTk68WO7goVY1XB75NUo40MMKtamBjxPboltCzeQkvTP82grytIxP6mlapUgpLB5qQJgS73NrFwUgCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dEyWEJFP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2xj1YwUi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dEyWEJFP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2xj1YwUi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A7AB91F8B8;
	Thu,  7 Nov 2024 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730973669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GaeMriiFanSTTR3LXqn8YDithSvI9c9ELHnMZEcbcV4=;
	b=dEyWEJFP9+7pFZto0mTwaAdpdbUBoE+E1Jnb17O6Oi86fWbGp9buUsewrMmL7rRrw3moYr
	7jZVcuruN+WKKEap2Qyzs/K/w4zP/wOhIzGi/Uj7MGsu3rXbc5PvAc3OzqnOlCCWrtEDWa
	0WJ825xm66rkDiQFnhSLi1ynKIJEEKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730973669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GaeMriiFanSTTR3LXqn8YDithSvI9c9ELHnMZEcbcV4=;
	b=2xj1YwUi1NjJGe5xQRuOT/bgQX4rnzwsFc2ixDbkBGV6Ockj2AopBZIxrofb7O4+KoEdm5
	e2c0LgeZSkEUZIBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dEyWEJFP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2xj1YwUi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730973669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GaeMriiFanSTTR3LXqn8YDithSvI9c9ELHnMZEcbcV4=;
	b=dEyWEJFP9+7pFZto0mTwaAdpdbUBoE+E1Jnb17O6Oi86fWbGp9buUsewrMmL7rRrw3moYr
	7jZVcuruN+WKKEap2Qyzs/K/w4zP/wOhIzGi/Uj7MGsu3rXbc5PvAc3OzqnOlCCWrtEDWa
	0WJ825xm66rkDiQFnhSLi1ynKIJEEKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730973669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GaeMriiFanSTTR3LXqn8YDithSvI9c9ELHnMZEcbcV4=;
	b=2xj1YwUi1NjJGe5xQRuOT/bgQX4rnzwsFc2ixDbkBGV6Ockj2AopBZIxrofb7O4+KoEdm5
	e2c0LgeZSkEUZIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 996BF139B3;
	Thu,  7 Nov 2024 10:01:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2mJtJeWPLGd5fwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 10:01:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 53202A0AF4; Thu,  7 Nov 2024 11:01:05 +0100 (CET)
Date: Thu, 7 Nov 2024 11:01:05 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>, Asahi Lina <lina@asahilina.net>,
	Dave Chinner <david@fromorbit.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sergio Lopez Pascual <slp@redhat.com>,
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
Message-ID: <20241107100105.tktkxs5qhkjwkckg@quack3>
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
 <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
 <20241106121255.yfvlzcomf7yvrvm7@quack3>
 <672bcab0911a2_10bc62943f@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <672bcab0911a2_10bc62943f@dwillia2-xfh.jf.intel.com.notmuch>
X-Rspamd-Queue-Id: A7AB91F8B8
X-Spam-Score: -4.01
X-Rspamd-Action: no action
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
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 06-11-24 11:59:44, Dan Williams wrote:
> Jan Kara wrote:
> [..]
> > > This WARN still feels like the wrong thing, though. Right now it is the
> > > only thing in DAX code complaining on a page size/block size mismatch
> > > (at least for virtiofs). If this is so important, I feel like there
> > > should be a higher level check elsewhere, like something happening at
> > > mount time or on file open. It should actually cause the operations to
> > > fail cleanly.
> > 
> > That's a fair point. Currently filesystems supporting DAX check for this in
> > their mount code because there isn't really a DAX code that would get
> > called during mount and would have enough information to perform the check.
> > I'm not sure adding a new call just for this check makes a lot of sense.
> > But if you have some good place in mind, please tell me.
> 
> Is not the reason that dax_writeback_mapping_range() the only thing
> checking ->i_blkbits because 'struct writeback_control' does writeback
> in terms of page-index ranges?

To be fair, I don't remember why we've put the assertion specifically into
dax_writeback_mapping_range(). But as Dave explained there's much more to
this blocksize == pagesize limitation in DAX than just doing writeback in
terms of page-index ranges. The whole DAX entry tracking in xarray would
have to be modified to properly support other entry sizes than just PTE &
PMD sizes because otherwise the entry locking just doesn't provide the
guarantees that are expected from filesystems (e.g. you could have parallel
modifications happening to a single fs block in pagesize < blocksize case).

> All other dax entry points are filesystem controlled that know the
> block-to-pfn-to-mapping relationship.
> 
> Recall that dax_writeback_mapping_range() is historically for pmem
> persistence guarantees to make sure that applications write through CPU
> cache to media.

Correct.

> Presumably there are no cache coherency concerns with fuse and dax
> writes from the guest side are not a risk of being stranded in CPU
> cache. Host side filesystem writeback will take care of them when / if
> the guest triggers a storage device cache flush, not a guest page cache
> writeback.

I'm not so sure. When you call fsync(2) in the guest on virtiofs file, it
should provide persistency guarantees on the file contents even in case of
*host* power failure. So if the guest is directly mapping host's page cache
pages through virtiofs, filemap_fdatawrite() call in the guest must result
in fsync(2) on the host to persist those pages. And as far as I vaguely
remember that happens by KVM catching the arch_wb_cache_pmem() calls and
issuing fsync(2) on the host. But I could be totally wrong here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

