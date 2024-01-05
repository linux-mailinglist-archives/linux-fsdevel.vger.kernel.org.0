Return-Path: <linux-fsdevel+bounces-7459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4462982527B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 11:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E215D286779
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 10:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F021528E38;
	Fri,  5 Jan 2024 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MKKjungj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4FVik9ep";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MKKjungj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4FVik9ep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AC02C85B;
	Fri,  5 Jan 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A8354220B7;
	Fri,  5 Jan 2024 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704452256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vXxhtyeckuqJFNr/JRv524z1JHaWgmFYD2pXQ0IUDA=;
	b=MKKjungjIvGWCqbk0Vf4SBIt53LzaJID/tvg9uLrkg6ZvBfMm0/3NvfIX4H3zTrxSvMjK8
	Mme8raMtSEGYLgrC8FnZJrGRsc72iI4GiAdmYWpBtkOaRZBPXvxaNjohitwW0mRpsIqetd
	PNI533+jSBdMQ+x69VEGvnZDvktdkIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704452256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vXxhtyeckuqJFNr/JRv524z1JHaWgmFYD2pXQ0IUDA=;
	b=4FVik9epYGd6eXdIFPsDiIvAoOAZNYgVhdckcBQ6otxliwcT7727hvm+6Cy7c2U3FUIAQs
	bmkQznNaureYqQDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704452256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vXxhtyeckuqJFNr/JRv524z1JHaWgmFYD2pXQ0IUDA=;
	b=MKKjungjIvGWCqbk0Vf4SBIt53LzaJID/tvg9uLrkg6ZvBfMm0/3NvfIX4H3zTrxSvMjK8
	Mme8raMtSEGYLgrC8FnZJrGRsc72iI4GiAdmYWpBtkOaRZBPXvxaNjohitwW0mRpsIqetd
	PNI533+jSBdMQ+x69VEGvnZDvktdkIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704452256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vXxhtyeckuqJFNr/JRv524z1JHaWgmFYD2pXQ0IUDA=;
	b=4FVik9epYGd6eXdIFPsDiIvAoOAZNYgVhdckcBQ6otxliwcT7727hvm+6Cy7c2U3FUIAQs
	bmkQznNaureYqQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A4A4136F5;
	Fri,  5 Jan 2024 10:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xfs2JaDgl2XhZwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 05 Jan 2024 10:57:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 49C52A07EF; Fri,  5 Jan 2024 11:57:36 +0100 (CET)
Date: Fri, 5 Jan 2024 11:57:36 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <20240105105736.24jep6q6cd7vsnmz@quack3>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZcgXI46AinlcBDP@casper.infradead.org>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hello,

On Thu 04-01-24 21:17:16, Matthew Wilcox wrote:
> This is primarily a _FILESYSTEM_ track topic.  All the work has already
> been done on the MM side; the FS people need to do their part.  It could
> be a joint session, but I'm not sure there's much for the MM people
> to say.
> 
> There are situations where we need to allocate memory, but cannot call
> into the filesystem to free memory.  Generally this is because we're
> holding a lock or we've started a transaction, and attempting to write
> out dirty folios to reclaim memory would result in a deadlock.
> 
> The old way to solve this problem is to specify GFP_NOFS when allocating
> memory.  This conveys little information about what is being protected
> against, and so it is hard to know when it might be safe to remove.
> It's also a reflex -- many filesystem authors use GFP_NOFS by default
> even when they could use GFP_KERNEL because there's no risk of deadlock.
> 
> The new way is to use the scoped APIs -- memalloc_nofs_save() and
> memalloc_nofs_restore().  These should be called when we start a
> transaction or take a lock that would cause a GFP_KERNEL allocation to
> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> can see the nofs situation is in effect and will not call back into
> the filesystem.
> 
> This results in better code within your filesystem as you don't need to
> pass around gfp flags as much, and can lead to better performance from
> the memory allocators as GFP_NOFS will not be used unnecessarily.
> 
> The memalloc_nofs APIs were introduced in May 2017, but we still have
> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
> really sad).  This session is for filesystem developers to talk about
> what they need to do to fix up their own filesystem, or share stories
> about how they made their filesystem better by adopting the new APIs.

I agree this is a worthy goal and the scoped API helped us a lot in the
ext4/jbd2 land. Still we have some legacy to deal with:

~> git grep "NOFS" fs/jbd2/ | wc -l
15
~> git grep "NOFS" fs/ext4/ | wc -l
71

When you are asking about what would help filesystems with the conversion I
actually have one wish. The most common case is that you need to annotate
some lock that can be grabbed in the reclaim path and thus you must avoid
GFP_FS allocations from under it. For example to deal with reclaim
deadlocks in the writeback paths we had to introduce wrappers like:

static inline int ext4_writepages_down_read(struct super_block *sb)
{
        percpu_down_read(&EXT4_SB(sb)->s_writepages_rwsem);
        return memalloc_nofs_save();
}

static inline void ext4_writepages_up_read(struct super_block *sb, int ctx)
{
        memalloc_nofs_restore(ctx);
        percpu_up_read(&EXT4_SB(sb)->s_writepages_rwsem);
}

When you have to do it for 5 locks in your filesystem it gets a bit ugly
and it would be nice to have some generic way to deal with this. We already
have the spin_lock_irqsave() precedent we might follow (and I don't
necessarily mean the calling convention which is a bit weird for today's
standards)?

Even more lovely would be if we could actually avoid passing around the
returned reclaim state because sometimes the locks get acquired / released
in different functions and passing the state around requires quite some
changes and gets ugly. That would mean we'd have to have
fs-reclaim-forbidden counter instead of just a flag in task_struct. OTOH
then we could just mark the lock (mutex / rwsem / whatever) as
fs-reclaim-unsafe during init and the rest would just magically happen.
That would be super-easy to use.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

