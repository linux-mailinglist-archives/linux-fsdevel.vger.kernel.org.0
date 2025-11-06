Return-Path: <linux-fsdevel+bounces-67287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0B9C3A950
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 12:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16DF1A42EC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92982F5A3F;
	Thu,  6 Nov 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T19Bon72";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nu3Zu33L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c95dtUBL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YMA+i/c+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3A2F3635
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428695; cv=none; b=jUV5vO9E8B/qlMXNew+9Yuf9ddyDSPm0G8xPn5U3BFONaS0843ZHj/eBkPXUChMD0fTkfgQPdhEd+2ClYygqQLEpY0QqeQQj9Ih2GkmPcln+EibE7C2hzUoji3g8mnWYO4xYSozZ4Uk7RxHe7ReQ1wbZSjCwHVatt61oorSmAiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428695; c=relaxed/simple;
	bh=yxNgBg8mFwppZWAGBg98ROLJ3LCBtZaPfgtBMiODBvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sj04sID/58IqoHnb8hkqEmZ3GTTOp4+xYmY/NpgfBytS9tSnldq9mULaWk0N3vwZz2VJImRKbouR67gEE9wnZwLljSR3OaMc8bH1MZJ8a8jZOAwoUWIa59MDj/PLwKAhux+Ff2KPdrtXuAbGKr3i40q48hlkfgx2kkAshhNb4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T19Bon72; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nu3Zu33L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c95dtUBL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YMA+i/c+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8904A21179;
	Thu,  6 Nov 2025 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762428691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rGCMXNn5dL3lRX/ozHN/9Eb+iB/lKfzKevPd+jVbI/Q=;
	b=T19Bon72ASkc8aIdSH+lxvP0PeGezhpeqa+dQ+VxmwtgiscQRB5TP0O83Kb6gkkSHPTPSb
	LyafLEvV9gakB38DclI2QetDQd62IkvnCrJAeFEmWoQFaXP+jOwxVG5sqEahPNFXYaiFps
	T/Hc3eAyRBcg6RHsF0jRHl8W+kz1Uhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762428691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rGCMXNn5dL3lRX/ozHN/9Eb+iB/lKfzKevPd+jVbI/Q=;
	b=Nu3Zu33LMtE90itQ6TCmD+OiKIP5ClZO02UPB2MFyVkKqy3x+1RLDUOkEo+VjtUpdTzhUx
	yjaKYUHHrbfY6dDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c95dtUBL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="YMA+i/c+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762428690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rGCMXNn5dL3lRX/ozHN/9Eb+iB/lKfzKevPd+jVbI/Q=;
	b=c95dtUBL5MxaNGu8M93yW94h8wI76yZKYkdazUNJ6NEonc29aNISAtccXpGktxspCcoIEn
	a0ba87QhuuSdA6xbqXTz/B8vH9VQa71EtoCN/bEJoFUEJMcwnYj8PCjtlThUIto9TWkrgO
	7hmEMbdzgfeoAXDqBRgbutRg6B1nutU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762428690;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rGCMXNn5dL3lRX/ozHN/9Eb+iB/lKfzKevPd+jVbI/Q=;
	b=YMA+i/c+Sf6pm7a1ytKMafhTEPEbwzt5P8pl/XBWo+jECCDWXykamUk0gncJnXUEL73Mqo
	XA/jZvH3juSePmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AF5B139A9;
	Thu,  6 Nov 2025 11:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S23WFRKHDGmQEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Nov 2025 11:31:30 +0000
Message-ID: <c68fe71a-d46b-4fe0-a2ce-57f443a43499@suse.cz>
Date: Thu, 6 Nov 2025 12:31:29 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: add atomic VMA flags, use VM_MAYBE_GUARD as
 such
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Andrei Vagin <avagin@gmail.com>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <94935cf140e3279c234b39e0d976c4718c547c73.1762422915.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <94935cf140e3279c234b39e0d976c4718c547c73.1762422915.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8904A21179
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,redhat.com,oracle.com,kernel.org,google.com,suse.com,goodmis.org,efficios.com,suse.de,vger.kernel.org,kvack.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 11/6/25 11:46, Lorenzo Stoakes wrote:
> This patch adds the ability to atomically set VMA flags with only the mmap
> read/VMA read lock held.
> 
> As this could be hugely problematic for VMA flags in general given that all
> other accesses are non-atomic and serialised by the mmap/VMA locks, we
> implement this with a strict allow-list - that is, only designated flags
> are allowed to do this.
> 
> We make VM_MAYBE_GUARD one of these flags, and then set it under the mmap
> read flag upon guard region installation.
> 
> The places where this flag is used currently and matter are:
> 
> * VMA merge - performed under mmap/VMA write lock, therefore excluding
>   racing writes.
> 
> * /proc/$pid/smaps - can race the write, however this isn't meaningful as
>   the flag write is performed at the point of the guard region being
>   established, and thus an smaps reader can't reasonably expect to avoid
>   races. Due to atomicity, a reader will observe either the flag being set
>   or not. Therefore consistency will be maintained.
> 
> In all other cases the flag being set is irrelevant and atomicity
> guarantees other flags will be read correctly.

Could we maybe also spell out that we rely on the read mmap/VMA lock to
exclude with writers that have write lock and then use non-atomic updates to
update completely different flags than VM_MAYBE_GUARD? Those non-atomic
updates could cause RMW races when only our side uses an atomic update, but
the trick is that the read lock excludes with the write lock.

> We additionally update madvise_guard_install() to ensure that
> anon_vma_prepare() is set for anonymous VMAs to maintain consistency with
> the assumption that any anonymous VMA with page tables will have an
> anon_vma set, and any with an anon_vma unset will not have page tables
> established.

Could we more obviously say that we did anon_vma_prepare() unconditionally
before this patch to trigger the page table copying in fork, but it's not
needed anymore because fork now checks also VM_MAYBE_GUARD that we're
setting here. Maybe it would be even more obvious to move that
vma_needs_copy() hunk from previous patch to this one, but doesn't matter
that much.

Also we could mention that this patch alone will prevent merging of VMAs in
some situations, but that's addressed next. I don't think it's such a bisect
hazard to need reordering or combining changes, just mention perhaps.

> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Otherwise LGTM.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


