Return-Path: <linux-fsdevel+bounces-42454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A46EA427F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 17:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0171890246
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C0263C85;
	Mon, 24 Feb 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2tuMxjrO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FsIP7SXz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2tuMxjrO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FsIP7SXz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E19262D21
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414680; cv=none; b=IUCNckrnlIrYPxO/u5tvHYrKZn5Xjh+2CSjNIy1hNeJfkwSU9h/refSCY/VyRTlbAnQ8inHvWO8t29EBZvl3HH2wAb4GF8YyEJW07BtDvV9bAd6X3liDoPIWzSgzS7OYWtZnI+BUfx8J0+hYTIt+GSXczSioy7RHY4hrzTzYEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414680; c=relaxed/simple;
	bh=tW7XXhbi1IeRsmewSFWbttff7v0psptJLRxyFiyzHeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAhWLsUNn2LMZv3f26FtT/PLQAO865wrWV5dKoRfdBBBsranT5vFHIwovuQYlZLeNralN5spfEK7U0EQzRtyu9Ms9x55Wcxn8UOS5CBqmjnk+hmT3WnW9Yp9xn2KCF3lIa5PEDA9WnXSvnmaHJH2yKQdbLl/R/Mv+hn5rS2/0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2tuMxjrO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FsIP7SXz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2tuMxjrO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FsIP7SXz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DDE71F441;
	Mon, 24 Feb 2025 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740414676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOvrKXU2Fpby3+k39Eqb9cOy88Tj7rv27Trvm/lCB9g=;
	b=2tuMxjrOZDnDOe8/uzuzHBRlKSRoXecMJeC2Zp9MTjCjiV2Rrf2vziJYm8wDGRgABUQo7I
	QhlrgTUeyIlM23oZIgfsU81o9phWlYtesM6+P7xxiwcFPrZHu70Y5nxPoedW+Vjyvo9aNF
	qwiPChieGCwV03I0dewdea0TIMiHBoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740414676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOvrKXU2Fpby3+k39Eqb9cOy88Tj7rv27Trvm/lCB9g=;
	b=FsIP7SXzSLKcd6twEPycw1JTOWlPuAe81V9e5Mi05CUC1j9/XXYFgl2eYwRW2pN2yXdHRO
	En9wmjFatH36kIDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740414676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOvrKXU2Fpby3+k39Eqb9cOy88Tj7rv27Trvm/lCB9g=;
	b=2tuMxjrOZDnDOe8/uzuzHBRlKSRoXecMJeC2Zp9MTjCjiV2Rrf2vziJYm8wDGRgABUQo7I
	QhlrgTUeyIlM23oZIgfsU81o9phWlYtesM6+P7xxiwcFPrZHu70Y5nxPoedW+Vjyvo9aNF
	qwiPChieGCwV03I0dewdea0TIMiHBoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740414676;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOvrKXU2Fpby3+k39Eqb9cOy88Tj7rv27Trvm/lCB9g=;
	b=FsIP7SXzSLKcd6twEPycw1JTOWlPuAe81V9e5Mi05CUC1j9/XXYFgl2eYwRW2pN2yXdHRO
	En9wmjFatH36kIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5045713707;
	Mon, 24 Feb 2025 16:31:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xF+TE9SevGcIcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Feb 2025 16:31:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 12C1DA0851; Mon, 24 Feb 2025 17:31:16 +0100 (CET)
Date: Mon, 24 Feb 2025 17:31:16 +0100
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jan Kara <jack@suse.cz>, Kalesh Singh <kaleshsingh@google.com>, 
	lsf-pc@lists.linux-foundation.org, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Juan Yescas <jyescas@google.com>, android-mm <android-mm@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Optimizing Page Cache Readahead
 Behavior
Message-ID: <ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz>
References: <CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91qsenYfYsX8Te=Bg@mail.gmail.com>
 <hep2a5d6k2kwth5klatzhl3ejbc6g2opqu6tyxyiohbpdyhvwp@lkg2wbb4zhy3>
 <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3bd275ed-7951-4a55-9331-560981770d30@lucifer.local>
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
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 24-02-25 14:21:37, Lorenzo Stoakes wrote:
> On Mon, Feb 24, 2025 at 03:14:04PM +0100, Jan Kara wrote:
> > Hello!
> >
> > On Fri 21-02-25 13:13:15, Kalesh Singh via Lsf-pc wrote:
> > > Problem Statement
> > > ===============
> > >
> > > Readahead can result in unnecessary page cache pollution for mapped
> > > regions that are never accessed. Current mechanisms to disable
> > > readahead lack granularity and rather operate at the file or VMA
> > > level. This proposal seeks to initiate discussion at LSFMM to explore
> > > potential solutions for optimizing page cache/readahead behavior.
> > >
> > >
> > > Background
> > > =========
> > >
> > > The read-ahead heuristics on file-backed memory mappings can
> > > inadvertently populate the page cache with pages corresponding to
> > > regions that user-space processes are known never to access e.g ELF
> > > LOAD segment padding regions. While these pages are ultimately
> > > reclaimable, their presence precipitates unnecessary I/O operations,
> > > particularly when a substantial quantity of such regions exists.
> > >
> > > Although the underlying file can be made sparse in these regions to
> > > mitigate I/O, readahead will still allocate discrete zero pages when
> > > populating the page cache within these ranges. These pages, while
> > > subject to reclaim, introduce additional churn to the LRU. This
> > > reclaim overhead is further exacerbated in filesystems that support
> > > "fault-around" semantics, that can populate the surrounding pages’
> > > PTEs if found present in the page cache.
> > >
> > > While the memory impact may be negligible for large files containing a
> > > limited number of sparse regions, it becomes appreciable for many
> > > small mappings characterized by numerous holes. This scenario can
> > > arise from efforts to minimize vm_area_struct slab memory footprint.
> >
> > OK, I agree the behavior you describe exists. But do you have some
> > real-world numbers showing its extent? I'm not looking for some artificial
> > numbers - sure bad cases can be constructed - but how big practical problem
> > is this? If you can show that average Android phone has 10% of these
> > useless pages in memory than that's one thing and we should be looking for
> > some general solution. If it is more like 0.1%, then why bother?
> >
> > > Limitations of Existing Mechanisms
> > > ===========================
> > >
> > > fadvise(..., POSIX_FADV_RANDOM, ...): disables read-ahead for the
> > > entire file, rather than specific sub-regions. The offset and length
> > > parameters primarily serve the POSIX_FADV_WILLNEED [1] and
> > > POSIX_FADV_DONTNEED [2] cases.
> > >
> > > madvise(..., MADV_RANDOM, ...): Similarly, this applies on the entire
> > > VMA, rather than specific sub-regions. [3]
> > > Guard Regions: While guard regions for file-backed VMAs circumvent
> > > fault-around concerns, the fundamental issue of unnecessary page cache
> > > population persists. [4]
> >
> > Somewhere else in the thread you complain about readahead extending past
> > the VMA. That's relatively easy to avoid at least for readahead triggered
> > from filemap_fault() (i.e., do_async_mmap_readahead() and
> > do_sync_mmap_readahead()). I agree we could do that and that seems as a
> > relatively uncontroversial change. Note that if someone accesses the file
> > through standard read(2) or write(2) syscall or through different memory
> > mapping, the limits won't apply but such combinations of access are not
> > that common anyway.
> 
> Hm I'm not sure sure, map elf files with different mprotect(), or mprotect()
> different portions of a file and suddenly you lose all the readahead for the
> rest even though you're reading sequentially?

Well, you wouldn't loose all readahead for the rest. Just readahead won't
preread data underlying the next VMA so yes, you get a cache miss and have
to wait for a page to get loaded into cache when transitioning to the next
VMA but once you get there, you'll have readahead running at full speed
again.

So yes, sequential read of a memory mapping of a file fragmented into many
VMAs will be somewhat slower. My impression is such use is rare (sequential
readers tend to use read(2) rather than mmap) but I could be wrong.

> What about shared libraries with r/o parts and exec parts?
> 
> I think we'd really need to do some pretty careful checking to ensure this
> wouldn't break some real world use cases esp. if we really do mostly
> readahead data from page cache.

So I'm not sure if you are not conflating two things here because the above
sentence doesn't make sense to me :). Readahead is the mechanism that
brings data from underlying filesystem into the page cache. Fault-around is
the mechanism that maps into page tables pages present in the page cache
although they were not possibly requested by the page fault. By "do mostly
readahead data from page cache" are you speaking about fault-around? That
currently does not cross VMA boundaries anyway as far as I'm reading
do_fault_around()...

> > Regarding controlling readahead for various portions of the file - I'm
> > skeptical. In my opinion it would require too much bookeeping on the kernel
> > side for such a niche usecache (but maybe your numbers will show it isn't
> > such a niche as I think :)). I can imagine you could just completely
> > turn off kernel readahead for the file and do your special readahead from
> > userspace - I think you could use either userfaultfd for triggering it or
> > new fanotify FAN_PREACCESS events.
> 
> I'm opposed to anything that'll proliferate VMAs (and from what Kalesh
> says, he is too!) I don't really see how we could avoid having to do that
> for this kind of case, but I may be missing something...

I don't see why we would need to be increasing number of VMAs here at all.
With FAN_PREACCESS you get notification with file & offset when it's
accessed, you can issue readahead(2) calls based on that however you like.
Similarly you can ask for userfaults for the whole mapped range and handle
those. Now thinking more about this, this approach has the downside that
you cannot implement async readahead with it (once PTE is mapped to some
page it won't trigger notifications either with FAN_PREACCESS or with
UFFD). But with UFFD you could at least trigger readahead on minor faults.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

