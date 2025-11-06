Return-Path: <linux-fsdevel+bounces-67323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE4C3BCBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DFE18925D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486102367B0;
	Thu,  6 Nov 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wU7eIE/a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g92+yCEe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wU7eIE/a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g92+yCEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E431A80D
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439620; cv=none; b=cabTxaN2vdPTIU425YaAORLFQ9hd3m8gfoYTHKtqC/v7dGqNC58jPbJ6IL/Su798WrvOy89/H4eytEeBkfKSEQuZbVJTokdkd0GZIue1FP6uFcl0HaTRIwMwUK/A0pG/w8buZRYEP1xOKBbaYvzVrkPPlI3n9WDGaXjaAL156TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439620; c=relaxed/simple;
	bh=fQilJNipyxT/q8/9Js36Vv+5fgeLdeP3OrbGvCTyEBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Is1XtF6TlbyOAZWbHbM4cSLNrxAzZahWHIraDswufvZdNESxI6Mb+HNEu9WOdf94hWgqKS2FCoVukPsmWDhkRwK0wG9UCnsj8meZjJbCQaLcXc0k1M3R9kQpeDlEKSA+SnNtmvw3IDxMfSlQau1S/CT8X5HgxddsbPG4vcYCnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wU7eIE/a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g92+yCEe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wU7eIE/a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g92+yCEe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95473211FA;
	Thu,  6 Nov 2025 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762439616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pCIJX8/iWnVUuvfe1rGXnP2363EkjNZoIa3wD0HTysg=;
	b=wU7eIE/awNdBW9X0M+guihUvpSfwGtZp7sB+FdVnnc6rp86D7PwrERWDsdMq2nV0SfheuJ
	vS9mKCpsNreHzq7FzmTwbH14vUAGfSDnBvcPCAX7tDFa0UUGNH1/VLnRzCEJm0PS+fzlpK
	6OrczvGIPmpeAZtqXCDUTI8lMGChIyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762439616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pCIJX8/iWnVUuvfe1rGXnP2363EkjNZoIa3wD0HTysg=;
	b=g92+yCEeQzeK7H/xtQ8RxX0mcYggPveuauVX45NrFsRXUHQWem3OBmr8NhE0PaChlFqnfi
	DcxekCE+Z6GhaBDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="wU7eIE/a";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g92+yCEe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762439616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pCIJX8/iWnVUuvfe1rGXnP2363EkjNZoIa3wD0HTysg=;
	b=wU7eIE/awNdBW9X0M+guihUvpSfwGtZp7sB+FdVnnc6rp86D7PwrERWDsdMq2nV0SfheuJ
	vS9mKCpsNreHzq7FzmTwbH14vUAGfSDnBvcPCAX7tDFa0UUGNH1/VLnRzCEJm0PS+fzlpK
	6OrczvGIPmpeAZtqXCDUTI8lMGChIyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762439616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pCIJX8/iWnVUuvfe1rGXnP2363EkjNZoIa3wD0HTysg=;
	b=g92+yCEeQzeK7H/xtQ8RxX0mcYggPveuauVX45NrFsRXUHQWem3OBmr8NhE0PaChlFqnfi
	DcxekCE+Z6GhaBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65FC913A31;
	Thu,  6 Nov 2025 14:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EcLNF8CxDGlwSgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Nov 2025 14:33:36 +0000
Message-ID: <3ba49b47-91a5-4a73-9dbd-b27f3956ae16@suse.cz>
Date: Thu, 6 Nov 2025 15:33:36 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: implement sticky, copy on fork VMA flags
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
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
 <3d423848-2b55-4797-bdab-a9b42a373a45@suse.cz>
 <402256c9-8cfe-4943-9b3f-40f21c17292e@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <402256c9-8cfe-4943-9b3f-40f21c17292e@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 95473211FA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,lwn.net,redhat.com,oracle.com,kernel.org,google.com,suse.com,goodmis.org,efficios.com,suse.de,vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 11/6/25 15:18, Lorenzo Stoakes wrote:
> On Thu, Nov 06, 2025 at 02:46:38PM +0100, Vlastimil Babka wrote:
>> On 11/6/25 11:46, Lorenzo Stoakes wrote:
>> > diff --git a/include/linux/mm.h b/include/linux/mm.h
>> > index 2ea65c646212..4d80eaf4ef3b 100644
>> > --- a/include/linux/mm.h
>> > +++ b/include/linux/mm.h
>> > @@ -527,6 +527,38 @@ extern unsigned int kobjsize(const void *objp);
>> >  #endif
>> >  #define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)
>> >
>> > +/* Flags which should result in page tables being copied on fork. */
>> > +#define VM_COPY_ON_FORK VM_MAYBE_GUARD
>> > +
>> > +/*
>> > + * Flags which should be 'sticky' on merge - that is, flags which, when one VMA
>> > + * possesses it but the other does not, the merged VMA should nonetheless have
>> > + * applied to it:
>> > + *
>> > + * VM_COPY_ON_FORK - These flags indicates that a VMA maps a range that contains
>> > + *                   metadata which should be unconditionally propagated upon
>> > + *                   fork. When merging two VMAs, we encapsulate this range in
>> > + *                   the merged VMA, so the flag should be 'sticky' as a result.
>> > + */
>> > +#define VM_STICKY VM_COPY_ON_FORK
>>
>> TBH I don't see why there should be always an implication that copying on
>> fork implies stickiness in merging. Yeah, VM_MAYBE_GUARD is both, but in
>> general, is there any underlying property that makes this a rule?
> 
> Why do you copy on fork? It's because the page tables contain data that won't be
> reconstructed on fault.
> 
> If that is the case, that applies to any VMA which is merged, and also - since
> you can't be sure precisely which page tables contain the data we need to
> propagate - on split too.
> 
> This is why copy on fork implies sticky IMO.

Hmm I guess that makes some sense.
> I can update the commit message to make this clear if this makes sense?

It would help, thanks. Let's see if future will surprise us with some flag
where this won't be true :)

>>
>> > +/*
>> > + * VMA flags we ignore for the purposes of merge, i.e. one VMA possessing one
>> > + * of these flags and the other not does not preclude a merge.
>> > + *
>> > + * VM_SOFTDIRTY - Should not prevent from VMA merging, if we match the flags but
>> > + *                dirty bit -- the caller should mark merged VMA as dirty. If
>> > + *                dirty bit won't be excluded from comparison, we increase
>> > + *                pressure on the memory system forcing the kernel to generate
>> > + *                new VMAs when old one could be extended instead.
> 
> Note that I'm literally just moving the comment from is_mergeable_vma():
> 
> -	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> -	 * match the flags but dirty bit -- the caller should mark
> -	 * merged VMA as dirty. If dirty bit won't be excluded from
> -	 * comparison, we increase pressure on the memory system forcing
> -	 * the kernel to generate new VMAs when old one could be
> -	 * extended instead.
> 
> (OK I see you realised that below :P)
> 
>>
>> So I wonder if VM_SOFTDIRTY should be actually also sticky and not just
>> VM_IGNORE_MERGE. The way I understand the flag suggests it should.
>> Right now AFAICS its rather undefined if the result of vma merge has the
>> flag - depending on which of the two VMA's stays and which is removed by the
>> merge. "the caller should mark merged VMA as dirty" in the comment you're
>> moving here seems not really happening or I'm missing it. __mmap_complete()
> 
> No it's not happening, but I can't be blamed for existing incorrect comments :)
> 
>> and do_brk_flags() do it, so any new areas are marked, but on pure merge of
>> two vma's due to e.g. mprotect() this is really nondetermintic? AFAICT the
>> sticky flag behavior would work perfectly for VM_SOFTDIRTY.
> 
> Maybe we inavertantly changed this somehow or maybe it was just wrong, but we're
> not doing this on merge in general afaict.

Yeah wouldn't surprised me if we subtly changed it during some refactoring
and it's not causing such obvious issues to be noticed easily.

> I think you're right that we should make this sticky, but I'd rather deal with
> that in a follow-up series/patch as this is out of scope here.
> 
> Equally so I'd rather fix the comment in a follow up too for the same reason.

Sure it's just something I noticed and seems like a good fit for the new
concept.


