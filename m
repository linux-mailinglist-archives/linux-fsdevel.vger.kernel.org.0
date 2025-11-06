Return-Path: <linux-fsdevel+bounces-67313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6430C3B77E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9CF550064C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CD1D9663;
	Thu,  6 Nov 2025 13:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="btnNVb/M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AeC7lmf8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="btnNVb/M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AeC7lmf8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3048E220687
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436808; cv=none; b=N4IDWX+Z5ef64xxrcdumyPhU7xsyNtgFkyfO30aPt1SOxx+tOtPnHS3Y/L6v5DV43gfGpDTYh+QRUauc3GnSt/VLFPcEJ49PRTlx3PptfUT4BXFdjUvj6aZqX+Wv5vlE4zMX1VVPjplffb7RUc4VIjuiLfUNlO5AxVvWxJA2kfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436808; c=relaxed/simple;
	bh=DSY2Nsx3JJErEtfG5CUi3GqduJf1nXZtnyvAqUnvkw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=db83r7HgSIs6XXFSjhbqeYTd/APA3ySvQxbeOo4Z4BpAyZwcqIvKKWL9iY2OJP32lY/WO/jrcQAb2b/HC6kLVpGcq4aYRwkTKW55AYfkz+nYYWxgz8e9+WRcyLZeFmBpxEYuqyFuI4vrmIctndlrX2Ik1zARTIo4Jc9GcXbWCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=btnNVb/M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AeC7lmf8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=btnNVb/M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AeC7lmf8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 218C521133;
	Thu,  6 Nov 2025 13:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762436799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=srEru9BczoLVjnMr65S1BOS77cjygGQYHttJr4DpgI0=;
	b=btnNVb/MvcugtbLI/y8eY2rdz3/5ii3+rhUQya3G10/nWA+eV6E4LsGmO8kEphHo0A+uRN
	Q7fQUMQlyGifqop/NhGWXXUFZfyhha/ntXjM0XtORRGTOlYLTEbLaihpu7DhFhJ5D+MLL4
	e7NB0P/PMytHVLFvoxRcHewgv83iIfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762436799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=srEru9BczoLVjnMr65S1BOS77cjygGQYHttJr4DpgI0=;
	b=AeC7lmf8lSe1/oJTrHtSxTwFSJzpf7ddLRjRFeGMNwlaNj2FlDqujnnR3SGgC52QLBjDNq
	bspam6diG7yY1cDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762436799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=srEru9BczoLVjnMr65S1BOS77cjygGQYHttJr4DpgI0=;
	b=btnNVb/MvcugtbLI/y8eY2rdz3/5ii3+rhUQya3G10/nWA+eV6E4LsGmO8kEphHo0A+uRN
	Q7fQUMQlyGifqop/NhGWXXUFZfyhha/ntXjM0XtORRGTOlYLTEbLaihpu7DhFhJ5D+MLL4
	e7NB0P/PMytHVLFvoxRcHewgv83iIfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762436799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=srEru9BczoLVjnMr65S1BOS77cjygGQYHttJr4DpgI0=;
	b=AeC7lmf8lSe1/oJTrHtSxTwFSJzpf7ddLRjRFeGMNwlaNj2FlDqujnnR3SGgC52QLBjDNq
	bspam6diG7yY1cDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0DD9139A9;
	Thu,  6 Nov 2025 13:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9yAzNb6mDGlgGwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Nov 2025 13:46:38 +0000
Message-ID: <3d423848-2b55-4797-bdab-a9b42a373a45@suse.cz>
Date: Thu, 6 Nov 2025 14:46:38 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: implement sticky, copy on fork VMA flags
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
 <9c9e9fb6b767556594b2cef023db01d45d8f8463.1762422915.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <9c9e9fb6b767556594b2cef023db01d45d8f8463.1762422915.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,redhat.com,oracle.com,kernel.org,google.com,suse.com,goodmis.org,efficios.com,suse.de,vger.kernel.org,kvack.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/6/25 11:46, Lorenzo Stoakes wrote:
> It's useful to be able to force a VMA to be copied on fork outside of the
> parameters specified by vma_needs_copy(), which otherwise only copies page
> tables if:
> 
> * The destination VMA has VM_UFFD_WP set
> * The mapping is a PFN or mixed map
> * The mapping is anonymous and forked in (i.e. vma->anon_vma is non-NULL)
> 
> Setting this flag implies that the page tables mapping the VMA are such
> that simply re-faulting the VMA will not re-establish them in identical
> form.
> 
> We introduce VM_COPY_ON_FORK to clearly identify which flags require this
> behaviour, which currently is only VM_MAYBE_GUARD.
> 
> Any VMA flags which require this behaviour are inherently 'sticky', that
> is, should we merge two VMAs together, this implies that the newly merged
> VMA maps a range that requires page table copying on fork.
> 
> In order to implement this we must both introduce the concept of a 'sticky'
> VMA flag and adjust the VMA merge logic accordingly, and also have VMA
> merge still successfully succeed should one VMA have the flag set and
> another not.
> 
> Note that we update the VMA expand logic to handle new VMA merging, as this
> function is the one ultimately called by all instances of merging of new
> VMAs.
> 
> This patch implements this, establishing VM_STICKY to contain all such
> flags and VM_IGNORE_MERGE for those flags which should be ignored when
> comparing adjacent VMA's flags for the purposes of merging.
> 
> As part of this change we place VM_SOFTDIRTY in VM_IGNORE_MERGE as it
> already had this behaviour, alongside VM_STICKY as sticky flags by
> implication must not disallow merge.
> 
> As a result of this change, VMAs with guard ranges will now not have their
> merge behaviour impacted by doing so and can be freely merged with other
> VMAs without VM_MAYBE_GUARD set.
> 
> We also update the VMA userland tests to account for the changes.
> 
> Note that VM_MAYBE_GUARD being set atomically remains correct as
> vma_needs_copy() is invoked with the mmap and VMA write locks held,
> excluding any race with madvise_guard_install().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm.h               | 32 ++++++++++++++++++++++++++++++++
>  mm/memory.c                      |  3 +--
>  mm/vma.c                         | 22 ++++++++++++----------
>  tools/testing/vma/vma_internal.h | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2ea65c646212..4d80eaf4ef3b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -527,6 +527,38 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
>  #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
>  
> +/* Flags which should result in page tables being copied on fork. */
> +#define VM_COPY_ON_FORK VM_MAYBE_GUARD
> +
> +/*
> + * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
> + * possesses it but the other does not, the merged VMA should nonetheless have
> + * applied to it:
> + *
> + * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that contains
> + *                   metadata which should be unconditionally propagated upon
> + *                   fork. When merging two VMAs, we encapsulate this range in
> + *                   the merged VMA, so the flag should be 'sticky' as a result.
> + */
> +#define VM_STICKY VM_COPY_ON_FORK

TBH I don't see why there should be always an implication that copying on
fork implies stickiness in merging. Yeah, VM_MAYBE_GUARD is both, but in
general, is there any underlying property that makes this a rule?

> +/*
> + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
> + * of these flags and the other not does not preclude a merge.
> + *
> + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
> + *                dirty bit -- the caller should mark merged VMA as dirty. If
> + *                dirty bit won't be excluded from comparison, we increase
> + *                pressure on the memory system forcing the kernel to generate
> + *                new VMAs when old one could be extended instead.

So I wonder if VM_SOFTDIRTY should be actually also sticky and not just
VM_IGNORE_MERGE. The way I understand the flag suggests it should.
Right now AFAICS its rather undefined if the result of vma merge has the
flag - depending on which of the two VMA's stays and which is removed by the
merge. "the caller should mark merged VMA as dirty" in the comment you're
moving here seems not really happening or I'm missing it. __mmap_complete()
and do_brk_flags() do it, so any new areas are marked, but on pure merge of
two vma's due to e.g. mprotect() this is really nondetermintic? AFAICT the
sticky flag behavior would work perfectly for VM_SOFTDIRTY.

> + *
> + *    VM_STICKY - If one VMA has flags which most be 'sticky', that is ones
> + *                which should propagate to all VMAs, but the other does not,
> + *                the merge should still proceed with the merge logic applying
> + *                sticky flags to the final VMA.
> + */
> +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> +
>  /*
>   * mapping from the currently active vm_flags protection bits (the
>   * low four bits) to a page protection mask..
> diff --git a/mm/memory.c b/mm/memory.c
> index 334732ab6733..7582a88f5332 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1480,8 +1480,7 @@ vma_needs_copy(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
>  	if (src_vma->anon_vma)
>  		return true;
>  
> -	/* Guard regions have momdified page tables that require copying. */
> -	if (src_vma->vm_flags & VM_MAYBE_GUARD)
> +	if (src_vma->vm_flags & VM_COPY_ON_FORK)
>  		return true;
>  
>  	/*
> diff --git a/mm/vma.c b/mm/vma.c
> index 0c5e391fe2e2..6cb082bc5e29 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -89,15 +89,7 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
>  
>  	if (!mpol_equal(vmg->policy, vma_policy(vma)))
>  		return false;
> -	/*
> -	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> -	 * match the flags but dirty bit -- the caller should mark
> -	 * merged VMA as dirty. If dirty bit won't be excluded from
> -	 * comparison, we increase pressure on the memory system forcing
> -	 * the kernel to generate new VMAs when old one could be
> -	 * extended instead.
> -	 */
> -	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_SOFTDIRTY)
> +	if ((vma->vm_flags ^ vmg->vm_flags) & ~VM_IGNORE_MERGE)
>  		return false;
>  	if (vma->vm_file != vmg->file)
>  		return false;
> @@ -808,6 +800,7 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
>  static __must_check struct vm_area_struct *vma_merge_existing_range(
>  		struct vma_merge_struct *vmg)
>  {
> +	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
>  	struct vm_area_struct *middle = vmg->middle;
>  	struct vm_area_struct *prev = vmg->prev;
>  	struct vm_area_struct *next;
> @@ -900,11 +893,13 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
>  	if (merge_right) {
>  		vma_start_write(next);
>  		vmg->target = next;
> +		sticky_flags |= (next->vm_flags & VM_STICKY);
>  	}
>  
>  	if (merge_left) {
>  		vma_start_write(prev);
>  		vmg->target = prev;
> +		sticky_flags |= (prev->vm_flags & VM_STICKY);
>  	}
>  
>  	if (merge_both) {
> @@ -974,6 +969,7 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
>  	if (err || commit_merge(vmg))
>  		goto abort;
>  
> +	vm_flags_set(vmg->target, sticky_flags);
>  	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
>  	vmg->state = VMA_MERGE_SUCCESS;
>  	return vmg->target;
> @@ -1124,6 +1120,10 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	bool remove_next = false;
>  	struct vm_area_struct *target = vmg->target;
>  	struct vm_area_struct *next = vmg->next;
> +	vm_flags_t sticky_flags;
> +
> +	sticky_flags = vmg->vm_flags & VM_STICKY;
> +	sticky_flags |= target->vm_flags & VM_STICKY;
>  
>  	VM_WARN_ON_VMG(!target, vmg);
>  
> @@ -1133,6 +1133,7 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	if (next && (target != next) && (vmg->end == next->vm_end)) {
>  		int ret;
>  
> +		sticky_flags |= next->vm_flags & VM_STICKY;
>  		remove_next = true;
>  		/* This should already have been checked by this point. */
>  		VM_WARN_ON_VMG(!can_merge_remove_vma(next), vmg);
> @@ -1159,6 +1160,7 @@ int vma_expand(struct vma_merge_struct *vmg)
>  	if (commit_merge(vmg))
>  		goto nomem;
>  
> +	vm_flags_set(target, sticky_flags);
>  	return 0;
>  
>  nomem:
> @@ -1902,7 +1904,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
>  	return a->vm_end == b->vm_start &&
>  		mpol_equal(vma_policy(a), vma_policy(b)) &&
>  		a->vm_file == b->vm_file &&
> -		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_SOFTDIRTY)) &&
> +		!((a->vm_flags ^ b->vm_flags) & ~(VM_ACCESS_FLAGS | VM_IGNORE_MERGE)) &&
>  		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
>  }
>  
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index ddf58a5e1add..984307a64ee9 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -119,6 +119,38 @@ extern unsigned long dac_mmap_min_addr;
>  #define VM_SEALED	VM_NONE
>  #endif
>  
> +/* Flags which should result in page tables being copied on fork. */
> +#define VM_COPY_ON_FORK VM_MAYBE_GUARD
> +
> +/*
> + * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
> + * possesses it but the other does not, the merged VMA should nonetheless have
> + * applied to it:
> + *
> + * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that contains
> + *                   metadata which should be unconditionally propagated upon
> + *                   fork. When merging two VMAs, we encapsulate this range in
> + *                   the merged VMA, so the flag should be 'sticky' as a result.
> + */
> +#define VM_STICKY VM_COPY_ON_FORK
> +
> +/*
> + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
> + * of these flags and the other not does not preclude a merge.
> + *
> + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
> + *                dirty bit -- the caller should mark merged VMA as dirty. If
> + *                dirty bit won't be excluded from comparison, we increase
> + *                pressure on the memory system forcing the kernel to generate
> + *                new VMAs when old one could be extended instead.
> + *
> + *    VM_STICKY - If one VMA has flags which must be 'sticky', that is ones
> + *                which should propagate to all VMAs, but the other does not,
> + *                the merge should still proceed with the merge logic applying
> + *                sticky flags to the final VMA.
> + */
> +#define VM_IGNORE_MERGE (VM_SOFTDIRTY | VM_STICKY)
> +
>  #define FIRST_USER_ADDRESS	0UL
>  #define USER_PGTABLES_CEILING	0UL
>  


