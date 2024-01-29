Return-Path: <linux-fsdevel+bounces-9404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FF8840ADC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 17:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC81C22F05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B08155A49;
	Mon, 29 Jan 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XEmM3qYl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pHOAXzVZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v0bghz1e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o2TK9+Jj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD764155A28;
	Mon, 29 Jan 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544586; cv=none; b=ZQWSodWlVuwPIjs1DnpOoDuKdALpB09Y7bgGwhqpCEt5ErGb+eWL4u85ooZhIuImqDJMPIBXDrJ1vD9kfxIQp/vJP4Kj2aoRmo7jYlzV9K35ivJ7uzUzMuRy1qfq28iocVsoiRY07h0sxsz0PWEKRGsg95DpqBbFKFykdXSX1Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544586; c=relaxed/simple;
	bh=hNsaj1rxxwQWYa7Z7f8gZ5X4GBVhrlEGD+oqwl6NJL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDDnbf61n0w46pMCWsNAhngSgrKuqoxhJtEEZXsS1hfL1dQlNrNZgOehLZsGP5NBc1Xytr0TnGYFV+XhsSnh8FmtoFTfx8LxAfFPpLaAtlwadR4ubQQLHXWEDVr3oyrWzVcNxaYTLg7Lj3nlx/HoGm96YyuoGkcKfWULgTHYgJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XEmM3qYl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pHOAXzVZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v0bghz1e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o2TK9+Jj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD34C1F7F6;
	Mon, 29 Jan 2024 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706544582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0q2MLUrv1k7d9D5+/BdCoPmlbiZZ17Ok8bpHpkSmRSY=;
	b=XEmM3qYlI0CUrEqb7kPUhszOWOQHrlokbHhrZc7EGwa2SHsGXXDHs28Y1liMhb8eVSRDeO
	zatQeIr5WQa7C018hiHg56nH3gGKBWdULRUkIytPR2X8MllN8+cuqIC1jlmM9H7jAE4AEK
	FizcKVhqgW1iD6E/ABYBy/eaXsx6HxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706544582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0q2MLUrv1k7d9D5+/BdCoPmlbiZZ17Ok8bpHpkSmRSY=;
	b=pHOAXzVZkyeIJmcfgNypcReo3Jf9iwdmiAJjbf9PZXcOsFH1rsl1yy9JI5Ch2qME7PBVfo
	x7CM5qd5SElWPxDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706544580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0q2MLUrv1k7d9D5+/BdCoPmlbiZZ17Ok8bpHpkSmRSY=;
	b=v0bghz1eqSg+/3eBpgiT5psyrda9f5aC+lV5JzdkYb2pQcpf8whF4MwtOFF1+nwpPoZfYI
	KbB9mB8y4ZcLBV2pgYTRKbwoZe9O2ilikNY2Mtihm1Zz592TvhQ+xEEVq0S1ExdH7wUPkL
	uuMBhbM3mblZ9tOrhFRxTnLP+JkzkKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706544580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0q2MLUrv1k7d9D5+/BdCoPmlbiZZ17Ok8bpHpkSmRSY=;
	b=o2TK9+JjZ+NMF9RV1bTujh4tyCF2Ql59qLB7eN/Mzp3OOKiLYgY59GiPARiAgNiFdm1hIV
	MtBKvHGUbHtJZeBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id ACF4D132FA;
	Mon, 29 Jan 2024 16:09:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id v5ItKsTNt2V/JAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 29 Jan 2024 16:09:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1B926A0807; Mon, 29 Jan 2024 17:09:39 +0100 (CET)
Date: Mon, 29 Jan 2024 17:09:39 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Roman Smirnov <r.smirnov@omp.ru>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, lvc-project@linuxtesting.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 5.10/5.15 v2 0/1 RFC] mm/truncate: fix WARNING in
 ext4_set_page_dirty()
Message-ID: <20240129160939.jgrhzrh5l2paezvp@quack3>
References: <20240125130947.600632-1-r.smirnov@omp.ru>
 <ZbJrAvCIufx1K2PU@casper.infradead.org>
 <20240129091124.vbyohvklcfkrpbyp@quack3>
 <Zbe5NBKrugBpRpM-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbe5NBKrugBpRpM-@casper.infradead.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v0bghz1e;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o2TK9+Jj
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,syzkaller.appspot.com:url,bootlin.com:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: BD34C1F7F6
X-Spam-Flag: NO

On Mon 29-01-24 14:41:56, Matthew Wilcox wrote:
> On Mon, Jan 29, 2024 at 10:11:24AM +0100, Jan Kara wrote:
> > On Thu 25-01-24 14:06:58, Matthew Wilcox wrote:
> > > On Thu, Jan 25, 2024 at 01:09:46PM +0000, Roman Smirnov wrote:
> > > > Syzkaller reports warning in ext4_set_page_dirty() in 5.10 and 5.15
> > > > stable releases. It happens because invalidate_inode_page() frees pages
> > > > that are needed for the system. To fix this we need to add additional
> > > > checks to the function. page_mapped() checks if a page exists in the 
> > > > page tables, but this is not enough. The page can be used in other places:
> > > > https://elixir.bootlin.com/linux/v6.8-rc1/source/include/linux/page_ref.h#L71
> > > > 
> > > > Kernel outputs an error line related to direct I/O:
> > > > https://syzkaller.appspot.com/text?tag=CrashLog&x=14ab52dac80000
> > > 
> > > OK, this is making a lot more sense.
> > > 
> > > The invalidate_inode_page() path (after the page_mapped check) calls
> > > try_to_release_page() which strips the buffers from the page.
> > > __remove_mapping() tries to freeze the page and presuambly fails.
> > 
> > Yep, likely.
> > 
> > > ext4 is checking there are still buffer heads attached to the page.
> > > I'm not sure why it's doing that; it's legitimate to strip the
> > > bufferheads from a page and then reattach them later (if they're
> > > attached to a dirty page, they are created dirty).
> > 
> > Well, we really need to track dirtiness on per fs-block basis in ext4
> > (which makes a difference when blocksize < page size). For example for
> > delayed block allocation we reserve exactly as many blocks as we need
> > (which need not be all the blocks in the page e.g. when writing just one
> > block in the middle of a large hole). So when all buffers would be marked
> > as dirty we would overrun our reservation. Hence at the moment of dirtying
> > we really need buffers to be attached to the page and stay there until the
> > page is written back.
> 
> Thanks for the clear explanation!
> 
> Isn't the correct place to ensure that this is true in
> ext4_release_folio()?  I think all paths to remove buffer_heads from a
> folio go through ext4_release_folio() and so it can be prohibited here
> if the folio is part of a delalloc extent?

OK, I tried to keep it simple but now I have to go into more intricate
details of GUP and the IO path so please bear with me. Normally, how things
happen on write or page_mkwrite time is:

lock_page(page)
check we have buffers, create if not
do stuff with page
mark appropriate buffers (and thus the page) dirty
unlock_page(page)

Now the page and buffers are dirty so nothing can be freed as reclaim
doesn't touch such pages (and neither does try_to_free_buffers()). So we
are safe until page writeback time.

But GUP users such as direct IO are different. They do the page_mkwrite()
dance at GUP time so we are fine at that moment. But on direct IO
completion they recheck page dirty bits and call set_page_dirty() *again*
if they find the page has been cleaned in the mean time. And this is where
the problem really happens. If writeback of the pages serving as direct IO
buffer happen while the IO is running, buffers get cleaned, and can be
reclaimed, and we then hit the warning in ext4_set_page_dirty().

So what we really need is "don't reclaim page buffers if the page is pinned
by GUP". This is what MM checks in recent kernels (since d824ec2a15467 "mm:
do not reclaim private data from pinned page") and the patch discussed here
is effectively an equivalent of it for stable. So AFAICT it really closes
all the problematic paths. Sure we could implement that check in
ext4_release_folio() but I don't think there's a great reason for that.

And yes, technically I assume we could reconstruct the buffer state from
other data structures if we find the buffers are missing. But in
ext4_set_page_dirty() that is not easily possible as it may be called in
softirq context. And elsewhere it is prone to hiding other bugs we may
introduce. So just not stripping the buffer heads when the page is pinned
is by far the easiest solution for ext4, in particular for stable...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

