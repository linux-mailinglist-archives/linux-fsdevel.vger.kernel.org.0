Return-Path: <linux-fsdevel+bounces-14278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E387A626
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 11:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CE51C218B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868C43D96E;
	Wed, 13 Mar 2024 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ICnhLx89";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UNsWCCPs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ICnhLx89";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UNsWCCPs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2A2E822;
	Wed, 13 Mar 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327305; cv=none; b=EWtPV6qvwakH6Z2TgspecNGXGHEY7t6z+NI+r5cqOs7FK9lRRIFX7JURRaS/q1pdSHeH7zVYWYzez6/SP2nW2Vh4pDx09VMoZHkTa0KxQgVVLvvZdwATPxNgdnwF4KJX+tW8Vne22bKuIbWX4/26+jLa/2+E2VMyOdWxsOO8Byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327305; c=relaxed/simple;
	bh=5extK9f367YL3H5gOJNXWVi1SGFLkqUtL6iLmjGxHfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLCv47UU7B7rzI0SeONo6O5VsuVE6vEf/JzjCtZ+diEDnuq/9rdXUFJLZUz/U9pPKyft9WnTsotEPV+cjX2Dr9feP/czZ9wDA8g0TolyA5et1QmOLkzQK1Dj6LsB/xSN6HsJY7HgW12aIuehKV3f4odpyiXtgithz47DSQRK8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ICnhLx89; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UNsWCCPs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ICnhLx89; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UNsWCCPs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F59321BF3;
	Wed, 13 Mar 2024 10:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710327301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNHl9j5rJS3FB75T3Br2PFgZD7an6d8GVNmFy/0Uptw=;
	b=ICnhLx89ytvNA+K1nls/VjM4iWaYDo7ArKG+6jS0xNfvwa3idlY0yaq3IVQR506uX4h0Tg
	sesB0BQqhGbeh8+5eAqoio9ELHwfCdZb3j3A73uu9KmCEm9sbAfS5VfpofGsJb+6iv6mq9
	ttOXm+rk1dtXSjVR4YcREd7uc1+inU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710327301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNHl9j5rJS3FB75T3Br2PFgZD7an6d8GVNmFy/0Uptw=;
	b=UNsWCCPsLIlnzTKkR4v5wVRse+HEASQrOEh7ONVrfXZlh5i7Vt1yQNcE/zBsWRG+Tur2Fv
	SUAbKJ2rTMBM3RAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710327301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNHl9j5rJS3FB75T3Br2PFgZD7an6d8GVNmFy/0Uptw=;
	b=ICnhLx89ytvNA+K1nls/VjM4iWaYDo7ArKG+6jS0xNfvwa3idlY0yaq3IVQR506uX4h0Tg
	sesB0BQqhGbeh8+5eAqoio9ELHwfCdZb3j3A73uu9KmCEm9sbAfS5VfpofGsJb+6iv6mq9
	ttOXm+rk1dtXSjVR4YcREd7uc1+inU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710327301;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QNHl9j5rJS3FB75T3Br2PFgZD7an6d8GVNmFy/0Uptw=;
	b=UNsWCCPsLIlnzTKkR4v5wVRse+HEASQrOEh7ONVrfXZlh5i7Vt1yQNcE/zBsWRG+Tur2Fv
	SUAbKJ2rTMBM3RAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 699DD13977;
	Wed, 13 Mar 2024 10:55:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /RehGQWG8WWoFAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 13 Mar 2024 10:55:01 +0000
Message-ID: <bd05d62d-9f46-46b5-b444-6c4814526459@suse.cz>
Date: Wed, 13 Mar 2024 11:55:04 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] mm, slab: move memcg charging to post-alloc hook
Content-Language: en-US
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Kees Cook <kees@kernel.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <muchun.song@linux.dev>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240301-slab-memcg-v1-0-359328a46596@suse.cz>
 <20240301-slab-memcg-v1-1-359328a46596@suse.cz> <ZfCkfpogPQVMZnIG@P9FQF9L96D>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ZfCkfpogPQVMZnIG@P9FQF9L96D>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ICnhLx89;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UNsWCCPs
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLduzbn1medsdpg3i8igc4rk67)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,linux.com,google.com,lge.com,gmail.com,cmpxchg.org,linux.dev,zeniv.linux.org.uk,suse.cz,kvack.org,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -6.50
X-Rspamd-Queue-Id: 7F59321BF3
X-Spam-Flag: NO

On 3/12/24 19:52, Roman Gushchin wrote:
> On Fri, Mar 01, 2024 at 06:07:08PM +0100, Vlastimil Babka wrote:
>> The MEMCG_KMEM integration with slab currently relies on two hooks
>> during allocation. memcg_slab_pre_alloc_hook() determines the objcg and
>> charges it, and memcg_slab_post_alloc_hook() assigns the objcg pointer
>> to the allocated object(s).
>>
>> As Linus pointed out, this is unnecessarily complex. Failing to charge
>> due to memcg limits should be rare, so we can optimistically allocate
>> the object(s) and do the charging together with assigning the objcg
>> pointer in a single post_alloc hook. In the rare case the charging
>> fails, we can free the object(s) back.
>>
>> This simplifies the code (no need to pass around the objcg pointer) and
>> potentially allows to separate charging from allocation in cases where
>> it's common that the allocation would be immediately freed, and the
>> memcg handling overhead could be saved.
>>
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Link: https://lore.kernel.org/all/CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com/
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Nice cleanup, Vlastimil!
> Couple of small nits below, but otherwise, please, add my
> 
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

>>  	/*
>>  	 * The obtained objcg pointer is safe to use within the current scope,
>>  	 * defined by current task or set_active_memcg() pair.
>>  	 * obj_cgroup_get() is used to get a permanent reference.
>>  	 */
>> -	struct obj_cgroup *objcg = current_obj_cgroup();
>> +	objcg = current_obj_cgroup();
>>  	if (!objcg)
>>  		return true;
>>  
>> +	/*
>> +	 * slab_alloc_node() avoids the NULL check, so we might be called with a
>> +	 * single NULL object. kmem_cache_alloc_bulk() aborts if it can't fill
>> +	 * the whole requested size.
>> +	 * return success as there's nothing to free back
>> +	 */
>> +	if (unlikely(*p == NULL))
>> +		return true;
> 
> Probably better to move this check up? current_obj_cgroup() != NULL check is more
> expensive.

It probably doesn't matter in practice anyway, but my thinking was that
*p == NULL is so rare (the object allocation failed) it shouldn't matter
that we did current_obj_cgroup() uselessly in case it happens.
OTOH current_obj_cgroup() returning NULL is not that rare (?) so it
could be useful to not check *p in those cases?

>> +
>> +	flags &= gfp_allowed_mask;
>> +
>>  	if (lru) {
>>  		int ret;
>>  		struct mem_cgroup *memcg;
>> @@ -1926,71 +1939,51 @@ static bool __memcg_slab_pre_alloc_hook(struct kmem_cache *s,
>>  			return false;
>>  	}
>>  
>> -	if (obj_cgroup_charge(objcg, flags, objects * obj_full_size(s)))
>> +	if (obj_cgroup_charge(objcg, flags, size * obj_full_size(s)))
>>  		return false;
>>  
>> -	*objcgp = objcg;
>> +	for (i = 0; i < size; i++) {
>> +		slab = virt_to_slab(p[i]);
> 
> Not specific to this change, but I wonder if it makes sense to introduce virt_to_slab()
> variant without any extra checks for this and similar cases, where we know for sure
> that p resides on a slab page. What do you think?

