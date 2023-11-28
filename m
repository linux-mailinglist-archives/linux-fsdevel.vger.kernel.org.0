Return-Path: <linux-fsdevel+bounces-4055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 991357FBF3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 17:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E51B216C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59A55CD14;
	Tue, 28 Nov 2023 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="14yXKjeK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w54tU1SL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B4BD5D;
	Tue, 28 Nov 2023 08:33:51 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBD7D21940;
	Tue, 28 Nov 2023 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701189229;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hq0WlH0mXIm7CC6RbZLQt0x0AsWjrpBw0tLGnSU8jww=;
	b=14yXKjeKd27P9ViqKHBnlqxaIG1hHD8CGVhQnvW1Is6RjIWztyUOuIGrVct/pZHIh/wFMz
	Kh0xOvzIjRoNnz1Pu7LpZmA8JvW99EHXDIFeYsGPCqsRFF0eX3PjZcmN9KbpLc5fQWfGuk
	ouV0TjubBqb8U6AgOpwYvSzaoiE0114=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701189229;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hq0WlH0mXIm7CC6RbZLQt0x0AsWjrpBw0tLGnSU8jww=;
	b=w54tU1SLUpSmKUOAgGkHDb2MRcSE7OKrt8Lq7u2piglcj2jj8fwLT6B+jje+Nntc8b4kIU
	tzahGaKSpo5vH4Bg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 89ECB133B5;
	Tue, 28 Nov 2023 16:33:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id e4ixIG0WZmX/WQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 28 Nov 2023 16:33:49 +0000
Date: Tue, 28 Nov 2023 17:26:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Should we still go __GFP_NOFAIL? (Was Re: [PATCH] btrfs:
 refactor alloc_extent_buffer() to allocate-then-attach method)
Message-ID: <20231128162636.GK18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
 <20231122143815.GD11264@twin.jikos.cz>
 <71d723c9-8f36-4fd1-bea7-7d962da465e2@gmx.com>
 <793cd840-49cb-4458-9137-30f899100870@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793cd840-49cb-4458-9137-30f899100870@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 FREEMAIL_TO(0.00)[gmx.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -4.00

On Mon, Nov 27, 2023 at 03:40:41PM +1030, Qu Wenruo wrote:
> On 2023/11/23 06:33, Qu Wenruo wrote:
> [...]
> >> I wonder if we still can keep the __GFP_NOFAIL for the fallback
> >> allocation, it's there right now and seems to work on sysmtems under
> >> stress and does not cause random failures due to ENOMEM.
> >>
> > Oh, I forgot the __NOFAIL gfp flags, that's not hard to fix, just
> > re-introduce the gfp flags to btrfs_alloc_page_array().
> 
> BTW, I think it's a good time to start a new discussion on whether we
> should go __GFP_NOFAIL.
> (Although I have updated the patch to keep the GFP_NOFAIL behavior)
> 
> I totally understand that we need some memory for tree block during
> transaction commitment and other critical sections.
> 
> And it's not that uncommon to see __GFP_NOFAIL usage in other mainstream
> filesystems.

The use of NOFAIL is either carefuly evaluated or it's there for
historical reasons. The comment for the flag says that,
https://elixir.bootlin.com/linux/latest/source/include/linux/gfp_types.h#L198
and I know MM people see the flag as problematic and that it should not
be used if possible.

> But my concern is, we also have a lot of memory allocation which can
> lead to a lot of problems either, like btrfs_csum_one_bio() or even
> join_transaction().

While I agree that there are many places that can fail due to memory
allocations, the extent buffer requires whole 4 pages, other structures
could be taken from the generic slabs or our named caches. The latter
has lower chance to fail.

> I doubt if btrfs (or any other filesystems) would be to blamed if we're
> really running out of memory.

Well, people blame btrfs for everything.

> Should the memory hungry user space programs to be firstly killed far
> before we failed to allocate memory?

That's up to the allocator and I think it does a good job of providing
the memory to kernel rather than to user space programs.

We do the critical allocations as GFP_NOFS which so far provides the "do
not fail" guarantees. It's a long going discussion,
https://lwn.net/Articles/653573/ (2015). We can let many allocations
fail with a fallback, but still a lot of them would lead to transaction
abort. And as Josef said, there are some that can't fail because they're
too deep or there's no clear exit path.

> Furthermore, at least for btrfs, I don't think we would hit a situation
> where memory allocation failure for metadata would lead to any data
> corruption.
> The worst case is we hit transaction abort, and the fs flips RO.

Yeah, corruption can't happen as long as we have all the error handling
in place and the transaction abort as the ultimate fallback.

> Thus I'm wondering if we really need __NOFAIL for btrfs?

It's hard to say if or when the NOFAIL semantics actually apply. Let's
say there are applications doing metadata operations, the system is
under load, memory is freed slowly by writing data etc. Application that
waits inside the eb allocation will continue eventually. Without the
NOFAIL it would exit early.

As a middle ground, we may want something like "try hard" that would not
fail too soon but it could eventually. That's __GFP_RETRY_MAYFAIL .

Right now there are several changes around the extent buffers, I'd like
do the conversion first and then replace/drop the NOFAIL flag so we
don't mix too many changes in one release. The extent buffers are
critical so one step a time, with lots of testing.

