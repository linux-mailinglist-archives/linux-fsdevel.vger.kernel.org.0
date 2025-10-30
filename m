Return-Path: <linux-fsdevel+bounces-66497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C5CC21334
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14CB74EA82D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC76C264F9C;
	Thu, 30 Oct 2025 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0j9hU/Ts";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/4I74rDr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0j9hU/Ts";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/4I74rDr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6F1F4CB7
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 16:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841922; cv=none; b=sdO9gP6nphyUu01ANx+SJWKXA4aow5wjyBUDuLa2Lph4vMojXcMJU8Zc1uzAp0yUvvJYPe7agWSpW2Apdca9aTYoR+C1n5ttDN2l7gtIs1mHYQBFuUkPDPay3kaTVlrQiOFdGWwiZfEKZOMWmD20RsjlrWFTGb5sztQEOsBl74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841922; c=relaxed/simple;
	bh=aPQoLf4+s8Au/I2d1625qGN7HPl1hNarTZGKPyM8KkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upfLhvR9DyTKzMs+zWHBVYOkvE4jo22AhwOEdbii44EPkS9wwDRgnOha/gFXADQhbs6JLhGlcEaZavt1+Ot89FCSQ/si5Xct8kLOmZZirdU1XmS8VLxQqdvJsTFZmKlAHiq/3wBluSbRGXtwQ7+oGHmACVEVuLLuf3a2M4ilVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0j9hU/Ts; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/4I74rDr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0j9hU/Ts; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/4I74rDr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC6B233734;
	Thu, 30 Oct 2025 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761841918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYxUqOLOyZrF6zpcmB2FMK7ECIXy7RwQ0ssrddYQtt4=;
	b=0j9hU/Ts09qlAQwjbg9XzmffczV8JmPTLC5Tal5kBHOkxavC2/Hk/UWPigSPkRxQql3Sts
	m/JuTTW+3nn/0tnzY4tVQfKVzW9d9u29lgLYrbbDh8mLJ0++SMk8ER8Rjt1Faf8L2KJk8R
	A8pTuIrdTPliL9z3rj068Q60O4mKbbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761841918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYxUqOLOyZrF6zpcmB2FMK7ECIXy7RwQ0ssrddYQtt4=;
	b=/4I74rDr2B/Kz3VDx5w+SlXMZ4BGPlIeQHP5WGXrGv/pd5Hck0KSYuZjRFzC7tIlVvc5/u
	UIhBzgKIrxODdDCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761841918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYxUqOLOyZrF6zpcmB2FMK7ECIXy7RwQ0ssrddYQtt4=;
	b=0j9hU/Ts09qlAQwjbg9XzmffczV8JmPTLC5Tal5kBHOkxavC2/Hk/UWPigSPkRxQql3Sts
	m/JuTTW+3nn/0tnzY4tVQfKVzW9d9u29lgLYrbbDh8mLJ0++SMk8ER8Rjt1Faf8L2KJk8R
	A8pTuIrdTPliL9z3rj068Q60O4mKbbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761841918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LYxUqOLOyZrF6zpcmB2FMK7ECIXy7RwQ0ssrddYQtt4=;
	b=/4I74rDr2B/Kz3VDx5w+SlXMZ4BGPlIeQHP5WGXrGv/pd5Hck0KSYuZjRFzC7tIlVvc5/u
	UIhBzgKIrxODdDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3F6613393;
	Thu, 30 Oct 2025 16:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EtDIJP2SA2mgHAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 30 Oct 2025 16:31:57 +0000
Date: Thu, 30 Oct 2025 16:31:56 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Message-ID: <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,redhat.com,oracle.com,suse.cz,kernel.org,google.com,suse.com,goodmis.org,efficios.com,vger.kernel.org,kvack.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu, Oct 30, 2025 at 04:23:58PM +0000, Lorenzo Stoakes wrote:
> On Thu, Oct 30, 2025 at 04:16:20PM +0000, Pedro Falcato wrote:
> > On Wed, Oct 29, 2025 at 04:50:31PM +0000, Lorenzo Stoakes wrote:
> > > Currently, if a user needs to determine if guard regions are present in a
> > > range, they have to scan all VMAs (or have knowledge of which ones might
> > > have guard regions).
> > >
> > > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> > > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> > > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> > > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> > > operation at a virtual address level.
> > >
> > > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> > > that guard regions exist in ranges.
> > >
> > > This patch remedies the situation by establishing a new VMA flag,
> > > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> > > uncertain because we cannot reasonably determine whether a
> > > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> > > additionally VMAs may change across merge/split).
> > >
> > > We utilise 0x800 for this flag which makes it available to 32-bit
> > > architectures also, a flag that was previously used by VM_DENYWRITE, which
> > > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> > > bee reused yet.
> > >
> > > The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
> > > lock (and also VMA write lock) whereas previously it did not, but this
> > > seems a reasonable overhead.
> >
> > Do you though? Could it be possible to simply atomically set the flag with
> > the read lock held? This would make it so we can't split the VMA (and tightly
> 
> VMA flags are not accessed atomically so no I don't think we can do that in any
> workable way.
>

FWIW I think you could work it as an atomic flag and treat those races as benign
(this one, at least).

> I also don't think it's at all necessary, see below.
> 
> > define what "may have a guard page"), but it sounds much better than introducing
> > lock contention. I don't think it is reasonable to add a write lock to a feature
> > that may be used by such things as thread stack allocation, malloc, etc.
> 
> What lock contention? It's per-VMA so the contention is limited to the VMA in
> question, and only over the span of time you are setting the gaurd region.

Don't we always need to take the mmap write lock when grabbing a VMA write
lock as well?

> When allocating thread stacks you'll be mapping things into memory which... take
> the write lock. malloc() if it goes to the kernel will also take the write lock.
>

But yes, good point, you're already serializing anyway. I don't think this is
a big deal.

> So I think you're overly worried about an operation that a. isn't going to be
> something that happens all that often, b. when it does, it's at a time when
> you'd be taking write locks anyway and c. won't contend important stuff like
> page faults for any VMA other than the one having the the guard region
> installed.

Yep, thanks.

-- 
Pedro

