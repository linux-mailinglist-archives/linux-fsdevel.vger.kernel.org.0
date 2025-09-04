Return-Path: <linux-fsdevel+bounces-60256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC94B43650
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 10:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943191719EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3DB2D0614;
	Thu,  4 Sep 2025 08:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zLY0z0sK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ks14tQUF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zLY0z0sK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ks14tQUF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C8C2264B1
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976010; cv=none; b=EDrTJ/q4QQ+KFfyTPf6E14pUunFqwN6UAUtgIZ831vDvKX6GWyr9uQ5vA0En3NxBiV3jkQjSGY/VQ78snZRWJGJkKElCPjzaBZNDZVYlbvbDmhuSOs7FD4yDM+NCpTL+F1/sy38w9/H1TJ3/3WDb17GhKU42l8RxzYAwf+/i+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976010; c=relaxed/simple;
	bh=TbtDw3etI9/ZzofASv193l20wMhRJSnEG+pI6FclPx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFx/7vNSGeFJMeBfpy3RiZtZAGCR5NNcVDc17TYpnQKkRKu0Dl/HhlIo3WxvY7iLmLBkfO+71CtT09wXrBMYT+MpacmkOw/4yhkpQNx/Y1w1HW2u8Wxuytu4ejc9I5koAZ8sCF8zjgA07PV+tBRNTR7fU9CWa+MZIDTIeFfsUdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zLY0z0sK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ks14tQUF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zLY0z0sK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ks14tQUF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7619B33F61;
	Thu,  4 Sep 2025 08:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756976006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPAlW2jGM6z2VbyPzIAk1XwDtLLRv8RXQFnUCLBEOis=;
	b=zLY0z0sKVWzhzRyIbQlPUo4m/YP4rEXl2vWzHuOLU0U5wdSzWrLpPL14PpyZwl/3qBUvTb
	rKaEslebF5hPZjCAjVsD1OUXeyCWXPcDPw2CAfakN0tG1eRxPTorzw/JL7x3rHhN7/8Of7
	D+3/tMdTZX6vSBZ5b6Y0kE9t0JQGgTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756976006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPAlW2jGM6z2VbyPzIAk1XwDtLLRv8RXQFnUCLBEOis=;
	b=Ks14tQUF4QfXY3dKTad0ND0t1O3z2jPZSLpeLYMg+2yG3fErY4sRXypbYiiIo6S2x88NXf
	XLr/5Bal3QW4uPBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zLY0z0sK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ks14tQUF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756976006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPAlW2jGM6z2VbyPzIAk1XwDtLLRv8RXQFnUCLBEOis=;
	b=zLY0z0sKVWzhzRyIbQlPUo4m/YP4rEXl2vWzHuOLU0U5wdSzWrLpPL14PpyZwl/3qBUvTb
	rKaEslebF5hPZjCAjVsD1OUXeyCWXPcDPw2CAfakN0tG1eRxPTorzw/JL7x3rHhN7/8Of7
	D+3/tMdTZX6vSBZ5b6Y0kE9t0JQGgTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756976006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPAlW2jGM6z2VbyPzIAk1XwDtLLRv8RXQFnUCLBEOis=;
	b=Ks14tQUF4QfXY3dKTad0ND0t1O3z2jPZSLpeLYMg+2yG3fErY4sRXypbYiiIo6S2x88NXf
	XLr/5Bal3QW4uPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69A9113675;
	Thu,  4 Sep 2025 08:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QCDEGYZTuWhOEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Sep 2025 08:53:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E8B40A0A2D; Thu,  4 Sep 2025 10:53:25 +0200 (CEST)
Date: Thu, 4 Sep 2025 10:53:25 +0200
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org, 
	jack@suse.cz, hch@infradead.org, djwong@kernel.org, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 00/12] mm/iomap: add granular dirty and writeback
 accounting
Message-ID: <5qgjrq6l627byybxjs6vzouspeqj6hdrx2ohqbxqkkjy65mtz5@zp6pimrpeu4e>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829233942.3607248-1-joannelkoong@gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7619B33F61
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

Hello!

On Fri 29-08-25 16:39:30, Joanne Koong wrote:
> This patchset adds granular dirty and writeback stats accounting for large
> folios.
> 
> The dirty page balancing logic uses these stats to determine things like
> whether the ratelimit has been exceeded, the frequency with which pages need
> to be written back, if dirtying should be throttled, etc. Currently for large
> folios, if any byte in the folio is dirtied or written back, all the bytes in
> the folio are accounted as such.
> 
> In particular, there are four places where dirty and writeback stats get
> incremented and decremented as pages get dirtied and written back:
> a) folio dirtying (filemap_dirty_folio() -> ... -> folio_account_dirtied())
>    - increments NR_FILE_DIRTY, NR_ZONE_WRITE_PENDING, WB_RECLAIMABLE,
>      current->nr_dirtied
> 
> b) writing back a mapping (writeback_iter() -> ... ->
> folio_clear_dirty_for_io())
>    - decrements NR_FILE_DIRTY, NR_ZONE_WRITE_PENDING, WB_RECLAIMABLE
> 
> c) starting writeback on a folio (folio_start_writeback())
>    - increments WB_WRITEBACK, NR_WRITEBACK, NR_ZONE_WRITE_PENDING
> 
> d) ending writeback on a folio (folio_end_writeback())
>    - decrements WB_WRITEBACK, NR_WRITEBACK, NR_ZONE_WRITE_PENDING

I was looking through the patch set. One general concern I have is that it
all looks somewhat fragile. If you say start writeback on a folio with a
granular function and happen to end writeback with a non-granular one,
everything will run fine, just a permanent error in the counters will be
introduced.  Similarly with a dirtying / starting writeback mismatch. The
practicality of this issue is demostrated by the fact that you didn't
convert e.g. folio_redirty_for_writepage() so anybody using it together
with fine-grained accounting will just silently mess up the counters.
Another issue of a similar kind is that __folio_migrate_mapping() does not
support fine-grained accounting (and doesn't even have a way to figure out
proper amount to account) so again any page migration may introduce
permanent errors into counters. One way to deal with this fragility would
be to have a flag in the mapping that will determine whether the dirty
accounting is done by MM or the filesystem (iomap code in your case)
instead of determining it at the call site.

Another concern I have is the limitation to blocksize >= PAGE_SIZE you
mention below. That is kind of annoying for filesystems because generally
they also have to deal with cases of blocksize < PAGE_SIZE and having two
ways of accounting in one codebase is a big maintenance burden. But this
was discussed elsewhere in this series and I think you have settled on
supporting blocksize < PAGE_SIZE as well?

Finally, there is one general issue for which I'd like to hear opinions of
MM guys: Dirty throttling is a mechanism to avoid a situation where the
dirty page cache consumes too big amount of memory which makes page reclaim
hard and the machine thrashes as a result or goes OOM. Now if you dirty a
2MB folio, it really makes all those 2MB hard to reclaim (neither direct
reclaim nor kswapd will be able to reclaim such folio) even though only 1KB
in that folio needs actual writeback. In this sense it is actually correct
to account whole big folio as dirty in the counters - if you accounted only
1KB or even 4KB (page), a user could with some effort make all page cache
memory dirty and hard to reclaim without crossing the dirty limits. On the
other hand if only 1KB in a folio trully needs writeback, the writeback
will be generally significantly faster than with 2MB needing writeback. So
in this sense it is correct to account amount to data that trully needs
writeback.

I don't know what the right answer to this "conflict of interests" is. We
could keep accounting full folios in the global / memcg counters (to
protect memory reclaim) and do per page (or even finer) accounting in the
bdi_writeback which is there to avoid excessive accumulation of dirty data
(and thus long writeback times) against one device. This should still help
your case with FUSE and strictlimit (which is generally constrained by
bdi_writeback counters). One just needs to have a closer look how hard
would it be to adapt writeback throttling logic to the different
granularity of global counters and writeback counters...

								Honza

> Patches 1 to 9 adds support for the 4 cases above to take in the number of
> pages to be accounted, instead of accounting for the entire folio.
> 
> Patch 12 adds the iomap changes that uses these new APIs. This relies on the
> iomap folio state bitmap to track which pages are dirty (so that we avoid
> any double-counting). As such we can only do granular accounting if the
> block size >= PAGE_SIZE.
> 
> This patchset was run through xfstests using fuse passthrough hp (with an
> out-of-tree kernel patch enabling fuse large folios).
> 
> This is on top of commit 4f702205 ("Merge branch 'vfs-6.18.rust' into
> vfs.all") in Christian's vfs tree, and on top of the patchset that removes
> BDI_CAP_WRITEBACK_ACCT [1].
> 
> Local benchmarks were run on xfs by doing the following:
> 
> seting up xfs (per the xfstests readme):
> # xfs_io -f -c "falloc 0 10g" test.img
> # xfs_io -f -c "falloc 0 10g" scratch.img
> # mkfs.xfs test.img
> # losetup /dev/loop0 ./test.img
> # losetup /dev/loop1 ./scratch.img
> # mkdir -p /mnt/test && mount /dev/loop0 /mnt/test
> 
> # sudo sysctl -w vm.dirty_bytes=$((3276 * 1024 * 1024)) # roughly 20% of 16GB
> # sudo sysctl -w vm.dirty_background_bytes=$((1638*1024*1024)) # roughly 10% of 16GB
> 
> running this test program (ai-generated) [2] which essentially writes out 2 GB
> of data 256 MB at a time and then spins up 15 threads to do 50-byte 50k
> writes.
> 
> On my VM, I saw the writes take around 3 seconds (with some variability of
> taking 0.3 seconds to 5 seconds sometimes) in the base version vs taking
> a pretty consistent 0.14 seconds with this patchset. It'd be much appreciated
> if someone could also run it on their local system to verify they see similar
> numbers.
> 
> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250707234606.2300149-1-joannelkoong@gmail.com/
> [2] https://pastebin.com/CbcwTXjq
> 
> Changelog
> v1: https://lore.kernel.org/linux-fsdevel/20250801002131.255068-1-joannelkoong@gmail.com/
> v1 -> v2:
> * Add documentation specifying caller expectations for the
>   filemap_dirty_folio_pages() -> __folio_mark_dirty() callpath (Jan)
> * Add requested iomap bitmap iteration refactoring (Christoph)
> * Fix long lines (Christoph)
> 
> Joanne Koong (12):
>   mm: pass number of pages to __folio_start_writeback()
>   mm: pass number of pages to __folio_end_writeback()
>   mm: add folio_end_writeback_pages() helper
>   mm: pass number of pages dirtied to __folio_mark_dirty()
>   mm: add filemap_dirty_folio_pages() helper
>   mm: add __folio_clear_dirty_for_io() helper
>   mm: add no_stats_accounting bitfield to wbc
>   mm: refactor clearing dirty stats into helper function
>   mm: add clear_dirty_for_io_stats() helper
>   iomap: refactor dirty bitmap iteration
>   iomap: refactor uptodate bitmap iteration
>   iomap: add granular dirty and writeback accounting
> 
>  fs/btrfs/subpage.c         |   2 +-
>  fs/buffer.c                |   6 +-
>  fs/ext4/page-io.c          |   2 +-
>  fs/iomap/buffered-io.c     | 281 ++++++++++++++++++++++++++++++-------
>  include/linux/page-flags.h |   4 +-
>  include/linux/pagemap.h    |   4 +-
>  include/linux/writeback.h  |  10 ++
>  mm/filemap.c               |  12 +-
>  mm/internal.h              |   2 +-
>  mm/page-writeback.c        | 115 +++++++++++----
>  10 files changed, 346 insertions(+), 92 deletions(-)
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

