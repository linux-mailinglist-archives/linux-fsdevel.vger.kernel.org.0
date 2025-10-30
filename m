Return-Path: <linux-fsdevel+bounces-66517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27576C21C73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 19:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03E9188C879
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ACF36E34A;
	Thu, 30 Oct 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="04iKfcY+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="igiB3ZOL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mlpd7JOu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GmhOIcfd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6B836C247
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849092; cv=none; b=jGgvdZ3xoFHKfG54T7KzuHwq1nDHdwnicmABau1Z8W4V0YTkaDUKHKRaJAXHniBRxXrgN9nPNX8bPF+UM5w7sqBMpvoS7Y8k0tE8/9mWEgJHujaMk9y5Ah2QoqGPG4BXKk7XJOXGzrsr7FZaNnkrxgpIV+EkPuUxSBESXbdeELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849092; c=relaxed/simple;
	bh=OR2dZqNzzVO5BwsCPBM0hsxin2ZrWiJwfxBcRC8Ff6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAR/qlGEnTfDP+SVj09YSg7Gq8+4ukMQn6DbIGCm0ms2bu67eqfB0/9jDGmSZl6PhyAD116syw98RsSoUFy/xS6umPuQ2PhBzUe7IdZFpruXg/5dl8nuC/TnBzhQubiyX56fJyhZ7ls/dqDVxmqdWWcHLSosqjpTAVsURdsc1g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=04iKfcY+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=igiB3ZOL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mlpd7JOu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GmhOIcfd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B17C1F7E9;
	Thu, 30 Oct 2025 18:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761849088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6wu4JmqRSVUxmPY+orKabgdgbl+cS4T0hGW38ZUO13k=;
	b=04iKfcY+8o345QvLdxK+8oF7FhJiB0XDldbfDAiAl0jZ4VaoiZvrNtEHan+PaeD/xhTF1j
	GpmNSFoStNkWN1jlQvUAqY2TwQNLr/xz1tZCUjkOlMmvK23o3wXZIDA3F4UtLHN5/FN4s2
	NauW7M4wxlJoBhzTeku2jasERYu1zUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761849088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6wu4JmqRSVUxmPY+orKabgdgbl+cS4T0hGW38ZUO13k=;
	b=igiB3ZOLI2thR8FkcmqQPe6l/YOut6/JPYEn+tQf6klzCNm5kalB2NQN61wUoQO3xzI9VU
	BqiapvgDytjtuVBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mlpd7JOu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GmhOIcfd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761849087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6wu4JmqRSVUxmPY+orKabgdgbl+cS4T0hGW38ZUO13k=;
	b=mlpd7JOuWnxP0St5rlvOV0Zge6C5xx8yJb3s2cjWIzGAIF4S2yMRa4tluRM1q3i6GtodMP
	Wj5dolx60AfeL8fKPlQSxrxCh/ivkhIGbCxWw5oeOVSjBd0QGVM8M3onUHT1fwK3KHzMdT
	LxnlzVOtjBQ66tgtH4VAXSweC3BL7Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761849087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6wu4JmqRSVUxmPY+orKabgdgbl+cS4T0hGW38ZUO13k=;
	b=GmhOIcfdkM15lOi69HROnP/YEjeeZx8cWYET42jL9w0FjbY4oMmy0dkO2hedguRWguaKDx
	JCckn0bfHOKGsMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13B0813393;
	Thu, 30 Oct 2025 18:31:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PO8xBP+uA2k5EAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 30 Oct 2025 18:31:27 +0000
Message-ID: <72ee2324-d599-44b6-92ce-ed0afafed78f@suse.cz>
Date: Thu, 30 Oct 2025 19:31:26 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
 Barry Song <21cnbao@gmail.com>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
 <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
 <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3B17C1F7E9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,redhat.com,oracle.com,kernel.org,google.com,suse.com,goodmis.org,efficios.com,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/30/25 17:43, Lorenzo Stoakes wrote:
> On Thu, Oct 30, 2025 at 04:31:56PM +0000, Pedro Falcato wrote:
>> On Thu, Oct 30, 2025 at 04:23:58PM +0000, Lorenzo Stoakes wrote:
>> > On Thu, Oct 30, 2025 at 04:16:20PM +0000, Pedro Falcato wrote:
>> > > On Wed, Oct 29, 2025 at 04:50:31PM +0000, Lorenzo Stoakes wrote:
>> > > > Currently, if a user needs to determine if guard regions are present in a
>> > > > range, they have to scan all VMAs (or have knowledge of which ones might
>> > > > have guard regions).
>> > > >
>> > > > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
>> > > > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
>> > > > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
>> > > > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
>> > > > operation at a virtual address level.
>> > > >
>> > > > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
>> > > > that guard regions exist in ranges.
>> > > >
>> > > > This patch remedies the situation by establishing a new VMA flag,
>> > > > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
>> > > > uncertain because we cannot reasonably determine whether a
>> > > > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
>> > > > additionally VMAs may change across merge/split).
>> > > >
>> > > > We utilise 0x800 for this flag which makes it available to 32-bit
>> > > > architectures also, a flag that was previously used by VM_DENYWRITE, which
>> > > > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
>> > > > bee reused yet.
>> > > >
>> > > > The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
>> > > > lock (and also VMA write lock) whereas previously it did not, but this
>> > > > seems a reasonable overhead.
>> > >
>> > > Do you though? Could it be possible to simply atomically set the flag with
>> > > the read lock held? This would make it so we can't split the VMA (and tightly
>> >
>> > VMA flags are not accessed atomically so no I don't think we can do that in any
>> > workable way.
>> >
>>
>> FWIW I think you could work it as an atomic flag and treat those races as benign
>> (this one, at least).
> 
> It's not benign as we need to ensure that page tables are correctly propagated
> on fork.

Could we use MADVISE_VMA_READ_LOCK mode (would be actually an improvement
over the current MADVISE_MMAP_READ_LOCK), together with the atomic flag
setting? I think the places that could race with us to cause RMW use vma
write lock so that would be excluded. Fork AFAICS unfortunately doesn't (for
the oldmm) and it probably would't make sense to start doing it. Maybe we
could think of something to deal with this special case...

>>
>> > I also don't think it's at all necessary, see below.
>> >
>> > > define what "may have a guard page"), but it sounds much better than introducing
>> > > lock contention. I don't think it is reasonable to add a write lock to a feature
>> > > that may be used by such things as thread stack allocation, malloc, etc.
>> >
>> > What lock contention? It's per-VMA so the contention is limited to the VMA in
>> > question, and only over the span of time you are setting the gaurd region.
>>
>> Don't we always need to take the mmap write lock when grabbing a VMA write
>> lock as well?
> 
> Yup. But at the same time you're doing the kind of operations that'd use this
> you'd already be taking the lock anyway.
> 
> You don't hold it for long and you won't be doing this any more often than you'd
> be doing other write operations, which you're also not going to be holding up
> faults on other VMAs either (they can access other VMAs despite mmap write lock
> being held), so I don't think there's ay issue here.
> 
>>
>> > When allocating thread stacks you'll be mapping things into memory which... take
>> > the write lock. malloc() if it goes to the kernel will also take the write lock.
>> >
>>
>> But yes, good point, you're already serializing anyway. I don't think this is
>> a big deal.
> 
> Indeed

Besides thread stacks, I'm thinking of the userspace allocators usecase
(jemalloc etc) where guard regions were supposed to allow a cheap
use-after-free protection by replacing their existing
MADV_DONTNEED/MADV_FREE use with MADV_GUARD_INSTALL.
Now MADV_DONTNEED/MADV_FREE use MADVISE_VMA_READ_LOCK, and guard regions
moves from (worse but still reasonable) MADVISE_MMAP_READ_LOCK to the heavy
MADVISE_MMAP_WRITE_LOCK. I'm afraid this might be too heavy price for that
usecase :(

>>
>> > So I think you're overly worried about an operation that a. isn't going to be
>> > something that happens all that often, b. when it does, it's at a time when
>> > you'd be taking write locks anyway and c. won't contend important stuff like
>> > page faults for any VMA other than the one having the the guard region
>> > installed.
>>
>> Yep, thanks.
> 
> No problemo, you can get yourself into sticky situations with lock contention
> but I think this is not one! :)
> 
>>
>> --
>> Pedro
> 
> Cheers, Lorenzo


