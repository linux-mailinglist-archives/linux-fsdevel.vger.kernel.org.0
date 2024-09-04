Return-Path: <linux-fsdevel+bounces-28539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2927196B940
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 651FCB2553B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EB91CFECB;
	Wed,  4 Sep 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OC5U0q24";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s5jQCAhk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Csnp/LoY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cOrIWI0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415961D04B7
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447033; cv=none; b=PuX1bZdC4s3wD7x8DlE5b8uPsyKsKz2M+IrMkkQ2NZkzARbxsNfbDqu+Bc0DztZ8P48LXJMd1Gi5Ez7ovxhN34EGMupWF73trWOXwaOuQQxEzZ/LzlXN2RliH+kI+sQI3TU58iAp9JlyTO6V2ZAADl0MbLXnh+cDWM1DQEkhj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447033; c=relaxed/simple;
	bh=BKE+ierhkz+/Px+ZvDBACRJcczQHaqrvcaExxKWvGtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TM53yn8KwsRhUoh6894FUj34I8T6X5hLpjGR6jr2DLa3Yxgg100/EESx2scGyf33sFYvQxMgGk8Bet0dOEqPISdIVAPlXcoXCClgIPL8I3WLIbvaz4c2XrT705NjDQix7cG6WyGMYa6jSkcvPa5KYRPJfrM7MUdkHmb/U75LOSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OC5U0q24; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s5jQCAhk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Csnp/LoY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cOrIWI0b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E71C219F3;
	Wed,  4 Sep 2024 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725447029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=toDg4FGAE3+xoGHYWixBm2HnGerhdjQnP1cxFZ8dy6w=;
	b=OC5U0q244j97LNLndlEFWfCCxpXCW8VheGVS0/JdwVyGCzXXT3GvjMOf3kFN/RoFnsLqQz
	G6UAxLBHFoJi4dtY2Ya8zWMlkx/uDCOXgCVlFREiD34FuGfsLdkIR76Fvo6uoKmQIDrHpY
	YWn31UxHlgV4AbT1RLVCkMfj1ew6saQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725447029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=toDg4FGAE3+xoGHYWixBm2HnGerhdjQnP1cxFZ8dy6w=;
	b=s5jQCAhkjsRmdsaDc8DPLsFMSLJO07mi6FSjxyVM92n24Bndl5rhWgtuG4xp/FO2mBgvAJ
	HBPjIwP7gt6TW+Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725447028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=toDg4FGAE3+xoGHYWixBm2HnGerhdjQnP1cxFZ8dy6w=;
	b=Csnp/LoYFwcXpkBwwgSrnw4X/S0b+sHD3i6yUBs8/6bcz3VNeGZ08OyBHk5HaXGzjgYJ8Y
	ZCH+7cqga7l5miKSREYg1Fpxtb/WB6uwwMDXNYnJKYojVieXoxUWUArgJRSOTAd+bXwSJr
	vLgO30OmOzZziWESuaLxQqJxUBuPP84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725447028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=toDg4FGAE3+xoGHYWixBm2HnGerhdjQnP1cxFZ8dy6w=;
	b=cOrIWI0bL23bqAfqUCE1qNkRyo9ljjqgdlPICt7Mo9bU9OjgqC00dxxcD3OlfUix+yH29I
	ALi31bcCFmcVKTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A768139E2;
	Wed,  4 Sep 2024 10:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lQibGXQ72GYYMAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 04 Sep 2024 10:50:28 +0000
Message-ID: <23eb55c3-0a8c-404b-b787-9f21c2739c4e@suse.cz>
Date: Wed, 4 Sep 2024 12:50:28 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/15] slab: create kmem_cache_create() compatibility
 layer
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-12-76f97e9a4560@kernel.org>
 <ZtfssAqDeyd_-4MJ@kernel.org> <20240904-storch-worin-32db25e60f32@brauner>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240904-storch-worin-32db25e60f32@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 9/4/24 11:45, Christian Brauner wrote:
> On Wed, Sep 04, 2024 at 08:14:24AM GMT, Mike Rapoport wrote:
>> On Tue, Sep 03, 2024 at 04:20:53PM +0200, Christian Brauner wrote:
>> > Use _Generic() to create a compatibility layer that type switches on the
>> > third argument to either call __kmem_cache_create() or
>> > __kmem_cache_create_args(). This can be kept in place until all callers
>> > have been ported to struct kmem_cache_args.
>> > 
>> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>> 
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> 
>> > ---
>> >  include/linux/slab.h | 13 ++++++++++---
>> >  mm/slab_common.c     | 10 +++++-----
>> >  2 files changed, 15 insertions(+), 8 deletions(-)
>> > 
>> > diff --git a/include/linux/slab.h b/include/linux/slab.h
>> > index aced16a08700..4292d67094c3 100644
>> > --- a/include/linux/slab.h
>> > +++ b/include/linux/slab.h
>> > @@ -261,9 +261,10 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
>> >  					    unsigned int object_size,
>> >  					    struct kmem_cache_args *args,
>> >  					    slab_flags_t flags);
>> > -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size,
>> > -			unsigned int align, slab_flags_t flags,
>> > -			void (*ctor)(void *));
>> > +
>> > +struct kmem_cache *__kmem_cache_create(const char *name, unsigned int size,
>> > +				       unsigned int align, slab_flags_t flags,
>> > +				       void (*ctor)(void *));
>> 
>> As I said earlier, this can become _kmem_cache_create and
>> __kmem_cache_create_args can be __kmem_cache_create from the beginning.

I didn't notice an answer to this suggestion? Even if it's just that you
don't think it's worth the rewrite, or it's not possible because X Y Z.
Thanks.

>> And as a followup cleanup both kmem_cache_create_usercopy() and
>> kmem_cache_create() can be made static inlines.
> 
> Seems an ok suggestion to me. See the two patches I sent out now.


