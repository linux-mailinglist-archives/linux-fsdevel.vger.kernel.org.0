Return-Path: <linux-fsdevel+bounces-27437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A6E961866
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA101C22F57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19C158218;
	Tue, 27 Aug 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vYi3HUMv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b0Cz1XsW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vYi3HUMv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b0Cz1XsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C182877
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724789737; cv=none; b=Nmk7Akom80Q4CrHXeE0GJA2+SC0CmbY9hqrgYLZLOvAckawisQFoIFAfpJ9SethoBzygN1hQ8AM7H45rRSD4hcfh8CZiozm9c5uiWqbYXJrp6C3X1YHx61z4THSAWY/a9VjSC0UR3Phjo1hOgKrdNaQ/0XNuRuhVpcREYxAVRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724789737; c=relaxed/simple;
	bh=CWObhrSRvzhh7tFoOSGiXUAWVKBca5FyYSszZ5TgF68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NCPb1sUnDJ6bSIn8R5gUyeRhTR+LtevqJ6VTiDTXnXmVioF9ogGHgdDjBj1S63Ui3AfojD2sVyZ2jhI14M/zqMbBlGTseatRp3yZVMWnbg8ezoj80sStNW7vycf6ngZLgLiDjxJfPk+E0TZeccYE/5DinbTMWzaN+pCm7PZrCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vYi3HUMv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b0Cz1XsW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vYi3HUMv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b0Cz1XsW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB8A91FB8B;
	Tue, 27 Aug 2024 20:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724789732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knGWaxH0R4m4TuW4TvM6nfIpA71Qplb2bUBb1bkN+fM=;
	b=vYi3HUMvibdq7PAKrKGB19OXblhVQ3UO+nax9hTPh+f9zWiL5ZqG7FRVnjDfyOtCuAHDFD
	wdYAiILks64A1y8UaVGuqkOfyYP8kvjl8kQGZfmxQ6Imz8YQ0vh69KDyiRWf9Nk7bJU9uo
	Dkfn1b04o6VjA8j8lNuQktR6dP00Ouc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724789732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knGWaxH0R4m4TuW4TvM6nfIpA71Qplb2bUBb1bkN+fM=;
	b=b0Cz1XsWgroKjYdyQLGZ5bR0mOCkMcnPdP0pO3UbN++fNSPyqB/VMmbciAJs1lKO4k2Zyh
	8qSDy8fqLn/kJIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vYi3HUMv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b0Cz1XsW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724789732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knGWaxH0R4m4TuW4TvM6nfIpA71Qplb2bUBb1bkN+fM=;
	b=vYi3HUMvibdq7PAKrKGB19OXblhVQ3UO+nax9hTPh+f9zWiL5ZqG7FRVnjDfyOtCuAHDFD
	wdYAiILks64A1y8UaVGuqkOfyYP8kvjl8kQGZfmxQ6Imz8YQ0vh69KDyiRWf9Nk7bJU9uo
	Dkfn1b04o6VjA8j8lNuQktR6dP00Ouc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724789732;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=knGWaxH0R4m4TuW4TvM6nfIpA71Qplb2bUBb1bkN+fM=;
	b=b0Cz1XsWgroKjYdyQLGZ5bR0mOCkMcnPdP0pO3UbN++fNSPyqB/VMmbciAJs1lKO4k2Zyh
	8qSDy8fqLn/kJIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B490413A20;
	Tue, 27 Aug 2024 20:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vFq9K+Qzzma+fAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Aug 2024 20:15:32 +0000
Message-ID: <96dd4a75-e83f-4807-b43e-bd5552f6aa6d@suse.cz>
Date: Tue, 27 Aug 2024 22:15:32 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] fs,mm: add kmem_cache_create_rcu()
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
References: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
 <20240827-lehrjahr-bezichtigen-ecb2da63d900@brauner>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240827-lehrjahr-bezichtigen-ecb2da63d900@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CB8A91FB8B
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 8/27/24 18:05, Christian Brauner wrote:
> On Tue, Aug 27, 2024 at 05:59:41PM GMT, Christian Brauner wrote:
>> When a kmem cache is created with SLAB_TYPESAFE_BY_RCU the free pointer
>> must be located outside of the object because we don't know what part of
>> the memory can safely be overwritten as it may be needed to prevent
>> object recycling.
>> 
>> That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
>> new cacheline. This is the case for .e.g, struct file. After having it
>> shrunk down by 40 bytes and having it fit in three cachelines we still
>> have SLAB_TYPESAFE_BY_RCU adding a fourth cacheline because it needs to
>> accomodate the free pointer and is hardware cacheline aligned.
>> 
>> I tried to find ways to rectify this as struct file is pretty much
>> everywhere and having it use less memory is a good thing. So here's a
>> proposal.
>> 
>> I was hoping to get something to this effect into v6.12.
>> 
>> If we really want to switch to a struct to pass kmem_cache parameters I
>> can do the preparatory patch to convert all kmem_cache_create() and
>> kmem_cache_create_usercopy() callers to use a struct for initialization
>> of course. I can do this as a preparatory work or as follow-up work to
>> this series. Thoughts?
> 
> So one thing I can do is to add:
> 
> struct kmem_cache_args {
> 	.freeptr_offset,
> 	.useroffset,
> 	.flags,
> 	.name,
> };

Hm basically everyone uses name, size and some flags, so how about we leave
those as direct parameters and args is for the rest, and in most cases would
be NULL.

> accompanied by:
> 
> int kmem_create_cache(struct kmem_cache_args *args);

I think we can't reuse the name with different parameters as long the old
one exists?

> and then switch both the filp cache and Jens' io_kiocb cache over to use
> these two helpers. Then we can convert other callers one by one.
> 
> @Vlastimil, @Jens, @Linus what do you think?

In the other thread you said it's best to leave such refactoring to
maintainers and I agree and don't ask you to do the cleanup in order to get
what you need (and we don't need to rush it either).

