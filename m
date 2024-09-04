Return-Path: <linux-fsdevel+bounces-28499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D10096B474
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BCA1C23A36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926E17D8A6;
	Wed,  4 Sep 2024 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v8FOt5vi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IHbjO8WN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tyRS01gc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5fBmrRnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74C14F9FD
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438336; cv=none; b=aEXKn2d72iJoSB72eJACdEeZVcyXOmzwnveeb5MsHw02/TUZ8UbrARZPks8ecBJa3pBTrnPx1IOcYRX+AKb9DPoWLWqdhZ18duZNC4bINpMastRSPDKvJsqLwsOa9lCtAxdK4Bmde+0M3rdy5q4mGaQGcbbEs9IRICKkkJTL2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438336; c=relaxed/simple;
	bh=lA+A7fEhY9J/iIMoev1mTEY7yw/nO/loVXjVZx+VMv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a759fAaySD4f6F65fzqDHrUG9pp2bgi3317kNDYYR+rAda8J75CbybazGnJf4FdfLxRVtlR4c9a8Vm4VlgulfHYPXXrk5iBAWqemKv0hY7F5zL27aSioAxti//UmgomQaA/e6tVIj8/JgYzSwKDAjF3qsQNJJKFleDfXTu6NqIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v8FOt5vi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IHbjO8WN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tyRS01gc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5fBmrRnC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC4141F7A6;
	Wed,  4 Sep 2024 08:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725438333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=teOKWOXcNtFOFYdNGfh4+/h1x6i3L9aZkA25y3K7L70=;
	b=v8FOt5vilNR/sRSAbtzLCxD8eUgXlxjCrKJNe2r8YkpngwcgkPaWnz4uoqGfUbfFYHbJrp
	SacNy2ZCb8+ZKdMfDZCbC+JVWGVu5PM9ZMs5CIXYqOkeDvzGyG9bltGk7ytVWOSqtcTpJR
	2AeM/ZLj+cdqICj69kwm9J3Lva2folQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725438333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=teOKWOXcNtFOFYdNGfh4+/h1x6i3L9aZkA25y3K7L70=;
	b=IHbjO8WNxxzFLOCPZHlkab5/iZRUSblhVOxl3gp3zeGp8g1Jgexwi+q2URlW6eChYWV6uf
	7Yo2EJLYR3g7iBCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725438332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=teOKWOXcNtFOFYdNGfh4+/h1x6i3L9aZkA25y3K7L70=;
	b=tyRS01gcPHZawyzGNGGX4Ru6tMnV6EKMrJ/N9yMRC/ubXRLwtYwWP/BPLINIl1JzOA1TcY
	O7G4IUDgYlopcW++u4e1Yb06tBp4dhe2+tiAOtbhZiZX7ItlJRnlPPMlkUmV1/51EdBtKd
	58TkmPQoLEoj0vOEewoRW5sfqdtvcCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725438332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=teOKWOXcNtFOFYdNGfh4+/h1x6i3L9aZkA25y3K7L70=;
	b=5fBmrRnCVvc7Pl3a4EZB3SeLhSs+dgy7bpVwzbAtNT9i9+UtsdVUYN1p8z30+CEOW8Wuq/
	0ZujXyO/8r2JW0Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB10C139D2;
	Wed,  4 Sep 2024 08:25:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LL5ULXwZ2GbjAQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 04 Sep 2024 08:25:32 +0000
Message-ID: <8d8da7d3-5a8f-4c79-84d2-90535324cdcd@suse.cz>
Date: Wed, 4 Sep 2024 10:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] slab: add struct kmem_cache_args
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jann Horn <jannh@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 9/3/24 16:20, Christian Brauner wrote:
> Hey,
> 
> As discussed last week the various kmem_cache_*() functions should be
> replaced by a unified function that is based around a struct, with only
> the basic parameters passed separately.
> 
> Vlastimil already said that he would like to keep core parameters out
> of the struct: name, object size, and flags. I personally don't care
> much and would not object to moving everything into the struct but
> that's a matter of taste and I yield that decision power to the
> maintainer.
> 
> In the first version I pointed out that the choice of name is somewhat
> forced as kmem_cache_create() is taken and the only way to reuse it
> would be to replace all users in one go. Or to do a global
> sed/kmem_cache_create()/kmem_cache_create2()/g. And then introduce
> kmem_cache_setup(). That doesn't strike me as a viable option.
> 
> If we really cared about the *_create() suffix then an alternative might
> be to do a sed/kmem_cache_setup()/kmem_cache_create()/g after every user
> in the kernel is ported. I honestly don't think that's worth it but I
> wanted to at least mention it to highlight the fact that this might lead
> to a naming compromise.
> 
> However, I came up with an alternative using _Generic() to create a
> compatibility layer that will call the correct variant of
> kmem_cache_create() depending on whether struct kmem_cache_args is
> passed or not. That compatibility layer can stay in place until we
> updated all calls to be based on struct kmem_cache_args.
> 
> From a cursory grep (and not excluding Documentation mentions) we will
> have to replace 44 kmem_cache_create_usercopy() calls and about 463
> kmem_cache_create() calls which makes for a bit above 500 calls to port
> to kmem_cache_setup(). That'll probably be good work for people getting
> into kernel development.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Besides the nits I replied to individual patches, LGTM and thanks for doing
the work. You could add to all:

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Too bad it's quite late for 6.12, right? It would have to be vfs tree anyway
for that due to the kmem_cache_create_rcu() prerequisities. Otherwise I can
handle it in the slab tree after the merge window, for 6.13.

Also for any more postings please Cc the SLAB ALLOCATOR section, only a
small subset of that is completely MIA :)

Thanks,
Vlastimil

> ---
> Changes in v2:
> - Remove kmem_cache_setup() and add a compatibility layer built around
>   _Generic() so that we can keep the kmem_cache_create() name and type
>   switch on the third argument to either call __kmem_cache_create() or
>   __kmem_cache_create_args().
> - Link to v1: https://lore.kernel.org/r/20240902-work-kmem_cache_args-v1-0-27d05bc05128@kernel.org
> 
> ---
> Christian Brauner (15):
>       sl*b: s/__kmem_cache_create/do_kmem_cache_create/g
>       slab: add struct kmem_cache_args
>       slab: port kmem_cache_create() to struct kmem_cache_args
>       slab: port kmem_cache_create_rcu() to struct kmem_cache_args
>       slab: port kmem_cache_create_usercopy() to struct kmem_cache_args
>       slab: pass struct kmem_cache_args to create_cache()
>       slub: pull kmem_cache_open() into do_kmem_cache_create()
>       slab: pass struct kmem_cache_args to do_kmem_cache_create()
>       sl*b: remove rcu_freeptr_offset from struct kmem_cache
>       slab: port KMEM_CACHE() to struct kmem_cache_args
>       slab: port KMEM_CACHE_USERCOPY() to struct kmem_cache_args
>       slab: create kmem_cache_create() compatibility layer
>       file: port to struct kmem_cache_args
>       slab: remove kmem_cache_create_rcu()
>       io_uring: port to struct kmem_cache_args
> 
>  fs/file_table.c      |  11 +++-
>  include/linux/slab.h |  60 ++++++++++++++-----
>  io_uring/io_uring.c  |  14 +++--
>  mm/slab.h            |   6 +-
>  mm/slab_common.c     | 150 +++++++++++++++++++----------------------------
>  mm/slub.c            | 162 +++++++++++++++++++++++++--------------------------
>  6 files changed, 203 insertions(+), 200 deletions(-)
> ---
> base-commit: 6e016babce7c845ed015da25c7a097fa3482d95a
> change-id: 20240902-work-kmem_cache_args-e9760972c7d4
> 


