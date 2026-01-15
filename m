Return-Path: <linux-fsdevel+bounces-73945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E37D0D2608C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EB8E3048ED8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 16:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFCC3A7F43;
	Thu, 15 Jan 2026 16:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MUeBFayB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4anpiBji";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MUeBFayB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4anpiBji"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DC3B9619
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496355; cv=none; b=H69u6Q1CTvTD6+HeldliOo6INes+lIR3s9tS6yEZmbb3v6OLjITdNjWd2K1DMjMhAAgBgXo+3LyczgbQU9Dudcp5KUWE/dYanTkZi0W/4pqxxbYpc1KWMhGCnyo0tIYhPcuA6lPdyllysDjWcMWpcbAYohTR7Bu4ClBdcpq4JXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496355; c=relaxed/simple;
	bh=lCTb5YBAkfnIlu44zPuUmqyY+HgEdbth99Zf/IxjgN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1zeIeN464COPBTiHZ9apgqRF/iaDXLDFhN6yAHcVnbik34Cqc8Hph1t9cW8R76oFNs6cwTo3mPpN3ceVyp5+zNMnY+LgfCR1TUTAMLZTxatAbrFKQC8MbP+lInxPiIhwKH1TUBp0Q0f0o4Ku39YSQUbjBKo7ewpmXLCRZ4zNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MUeBFayB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4anpiBji; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MUeBFayB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4anpiBji; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9B813375C;
	Thu, 15 Jan 2026 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768496352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8ApPkUvBrjyWW5bWMQ3GGcWGPQHRsApbqSkpz1eomsc=;
	b=MUeBFayBqN8xz45b03FhYnm4ZT1GyrZg8qfMd/TrKZPYoZe2h567tuZuUrLE18mxwJtk86
	dGxQea3ZW5KuqwUjeeoOLJ45y870k44JXBDSYVq9VE5XF/dRKtpnAbuwRTgUHgMd+BNQf+
	CKM1TbAJVKb2qI6YirpTuemdnbSoN1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768496352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8ApPkUvBrjyWW5bWMQ3GGcWGPQHRsApbqSkpz1eomsc=;
	b=4anpiBjigLN/195m2i2zulO20fg4kU2BHE1+lmo0daC0kKO0OEGY9A0RNSSh0jsfq6Yhy2
	et7xh8m4kg7iMBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768496352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8ApPkUvBrjyWW5bWMQ3GGcWGPQHRsApbqSkpz1eomsc=;
	b=MUeBFayBqN8xz45b03FhYnm4ZT1GyrZg8qfMd/TrKZPYoZe2h567tuZuUrLE18mxwJtk86
	dGxQea3ZW5KuqwUjeeoOLJ45y870k44JXBDSYVq9VE5XF/dRKtpnAbuwRTgUHgMd+BNQf+
	CKM1TbAJVKb2qI6YirpTuemdnbSoN1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768496352;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8ApPkUvBrjyWW5bWMQ3GGcWGPQHRsApbqSkpz1eomsc=;
	b=4anpiBjigLN/195m2i2zulO20fg4kU2BHE1+lmo0daC0kKO0OEGY9A0RNSSh0jsfq6Yhy2
	et7xh8m4kg7iMBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B21273EA63;
	Thu, 15 Jan 2026 16:59:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kRsoK+AcaWl4dgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 15 Jan 2026 16:59:12 +0000
Message-ID: <19e0c58f-114c-4bbd-9bc0-25382d7d5cbb@suse.cz>
Date: Thu, 15 Jan 2026 17:59:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/15] static kmem_cache instances for core caches
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, "Christoph Lameter (Ampere)" <cl@gentwo.org>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
 <20260110040217.1927971-2-viro@zeniv.linux.org.uk> <aWdGEI6iQBl3Xibi@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aWdGEI6iQBl3Xibi@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,zeniv.linux.org.uk,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 1/14/26 08:30, Harry Yoo wrote:
> On Sat, Jan 10, 2026 at 04:02:03AM +0000, Al Viro wrote:
>>         kmem_cache_create() and friends create new instances of
>> struct kmem_cache and return pointers to those.  Quite a few things in
>> core kernel are allocated from such caches; each allocation involves
>> dereferencing an assign-once pointer and for sufficiently hot ones that
>> dereferencing does show in profiles.
>> 
>>         There had been patches floating around switching some of those
>> to runtime_const infrastructure.  Unfortunately, it's arch-specific
>> and most of the architectures lack it.
>> 
>>         There's an alternative approach applicable at least to the caches
>> that are never destroyed, which covers a lot of them.  No matter what,
>> runtime_const for pointers is not going to be faster than plain &,
>> so if we had struct kmem_cache instances with static storage duration, we
>> would be at least no worse off than we are with runtime_const variants.
>> 
>>         There are obstacles to doing that, but they turn out to be easy
>> to deal with.
>> 
>> 1) as it is, struct kmem_cache is opaque for anything outside of a few
>> files in mm/*; that avoids serious headache with header dependencies,
>> etc., and it's not something we want to lose.  Solution: struct
>> kmem_cache_opaque, with the size and alignment identical to struct
>> kmem_cache.  Calculation of size and alignment can be done via the same
>> mechanism we use for asm-offsets.h and rq-offsets.h, with build-time
>> check for mismatches.  With that done, we get an opaque type defined in
>> linux/slab-static.h that can be used for declaring those caches.
>> In linux/slab.h we add a forward declaration of kmem_cache_opaque +
>> helper (to_kmem_cache()) converting a pointer to kmem_cache_opaque
>> into pointer to kmem_cache.
>> 
>> 2) real constructor of kmem_cache needs to be taught to deal with
>> preallocated instances.  That turns out to be easy - we already pass an
>> obscene amount of optional arguments via struct kmem_cache_args, so we
>> can stash the pointer to preallocated instance in there.  Changes in
>> mm/slab_common.c are very minor - we should treat preallocated caches
>> as unmergable, use the instance passed to us instead of allocating a
>> new one and we should not free them.  That's it.
> 
> SLAB_NO_MERGE prevents both side of merging - when 1) creating the cache,
> and when 2) another cache tries to create an alias from it.
> 
> Avoiding 1) makes sense, but is there a reason to prevent 2)?
> 
> If it's fine for other caches to merge into a cache with static
> duration, then it's sufficient to update find_mergeable() to not attempt
> creating an alias during cache creation if args->preallocated is
> specified (instead of using SLAB_NO_MERGE).

The merging prevention is my biggest concern with the approach. We could
potentially solve it by moving the sharing to a different layer than today's
sharing of kmem_cache objects with refcount, and instead have separate
instances that point to the same underlying storage (mainly the per-node and
per-cpu slabs/sheaves). It's possible it would also simplify the suboptimal
sysfs handling of today as the aliases could know their cache name and own
their symlinks.

However slabs and sheaves do have a parent kmem_cache pointer. It's how e.g.
kfree() works by virt_to_slab(obj) -> kmem_cache and then being like
kmem_cache_free().

So we could have kmem_cache->primary_cache field where the primary would
just point to self and aliasing caches to the primary, and newly created
slabs and sheaves would read that ->primary_cache to assign their kmem_cache
pointer. This is not a fasthpath operation so it shouldn't matter, and with
that there wouldn't be any mix of differing cache pointers so the aliases
could be destroyed easily. And then the primary cache wouldn't be able go
away as long as there are aliases, as it is today.

Only a dynamic cache or a non-module static cache thus could become a
primary, for module unload reasons.

For this to work fully mergeable in all scenarios of the order of creating
static vs dynamic aliases, there would however have to be a weird quirk for
static module caches - when such a cache is created, and there's no
compatible primary to become alias of, a dynamic, otherwise unused primary
would need to be created just to become the owner of the slabs and sheaves.
Because if a mergeable dynamic cache appears later, it would not be able to
become a primary for the static module cache to become alias of, because the
static module cache would already have existing slabs and sheaves pointing
to it.

And there might be other issues with this scheme I don't immediately see.
But maybe it's feasible.

