Return-Path: <linux-fsdevel+bounces-28589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9239E96C40C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC2B1C21CA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D60F1DFE0F;
	Wed,  4 Sep 2024 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T7Uo201K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z1OT4ESL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWYyPPU0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Naivw1uF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6934778C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466970; cv=none; b=FgiRT/njdVI+bpWW4nbVl1lvW4njwxdNBD5fo26Twj457oJBAPnXKzkbc78BL9sWuFxQ7KOkkL3fmudIiTdJttba3O39upzpG9o2Lm3dFxQRHoH+VCs4Get8ugEs7HFr2i5BNe5QyuMraKU/Z+j5/2ma84zk/MAvTVB6R6UAToE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466970; c=relaxed/simple;
	bh=QOBDmuV1lVE964O08AHdQSPKAxqUH7s11He+ESEVU48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnj1fadcYp+4yPYk+Z7GhXiy6rPyK/FAAAzdXFiOsMhq1+45i6btWFE9eeFzBI45XFkZFaqMJ9SEl3OO2IcoZLjB/Y19NfLd8WSNImqXTn8GXzMB145sbYkUG1iUPKv4w4PHUiLf87detSYHcjayK7Yh5JikyIoicNqJuLGyAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T7Uo201K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z1OT4ESL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWYyPPU0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Naivw1uF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 846E521A1B;
	Wed,  4 Sep 2024 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725466966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OsGn+GMU9LztgvJJ2xT+wcVfB0lZopSDBR8Roh7ZK+A=;
	b=T7Uo201KaV/e7YvZysDIrNAX6nBAR8WIIkgjbtcqEwNeMwAc8QlHf2wH8xrujpjLSctB3F
	iw+ZIxdpQpU4KXbxmxzreCEFbRe++MK8i6vw34GPzB8FdX3YvyvWGPN+nlH8FM916Wsj/9
	9EJljpZ1TsXHJU8AVkSfR/7pIOKJEzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725466966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OsGn+GMU9LztgvJJ2xT+wcVfB0lZopSDBR8Roh7ZK+A=;
	b=z1OT4ESLxDBx5R+OcGcKjUpOBQ7cbPAcYu5lQzlcw+KEOsnlZwHAWepP+D5XDM0aOdNzkH
	/8m0H5oJ1wk1X7AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AWYyPPU0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Naivw1uF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725466965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OsGn+GMU9LztgvJJ2xT+wcVfB0lZopSDBR8Roh7ZK+A=;
	b=AWYyPPU0AvDtaVrDitWIye8UkuOhr2TnRXhHtdXmT5AAC6FKjwFOuEgArGH0tpwDqWwHN3
	AQmaNjhDQXRSYfLAfLlEjhcrT1lgk0uU6jp5QEX3M/pYKodibrAHaui+xkm68xIZvIK32n
	HNFmMj5A3vs7w1C4MiqhGydaKLerjNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725466965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OsGn+GMU9LztgvJJ2xT+wcVfB0lZopSDBR8Roh7ZK+A=;
	b=Naivw1uFIKL1+EtJUYmZa2zYdShKwFL3rv7uTjgcI46TVu5KSKdD5Gas3NI/MsoV6MYxa6
	aAl55jQmCNnOuuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7213C139D2;
	Wed,  4 Sep 2024 16:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OC59G1WJ2GZKGwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 04 Sep 2024 16:22:45 +0000
Message-ID: <3ade6827-701d-4b50-b9bd-96c60ba38658@suse.cz>
Date: Wed, 4 Sep 2024 18:22:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jann Horn <jannh@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
 <Zth5wHtDkX78gl1l@kernel.org> <9303896a-e3c8-4dc3-926b-c7e8fc75cf6b@suse.cz>
 <ZtiH7UNQ7Rnftr0o@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZtiH7UNQ7Rnftr0o@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 846E521A1B
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 9/4/24 18:16, Mike Rapoport wrote:
> On Wed, Sep 04, 2024 at 05:49:15PM +0200, Vlastimil Babka wrote:
>> On 9/4/24 17:16, Mike Rapoport wrote:
>> > On Tue, Sep 03, 2024 at 04:20:43PM +0200, Christian Brauner wrote:
>> >> @@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
>> >>  
>> >>  	mutex_lock(&slab_mutex);
>> >>  
>> >> -	err = kmem_cache_sanity_check(name, size);
>> >> +	err = kmem_cache_sanity_check(name, object_size);
>> >>  	if (err) {
>> >>  		goto out_unlock;
>> >>  	}
>> >> @@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
>> >>  
>> >>  	/* Fail closed on bad usersize of useroffset values. */
>> >>  	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
>> >> -	    WARN_ON(!usersize && useroffset) ||
>> >> -	    WARN_ON(size < usersize || size - usersize < useroffset))
>> >> -		usersize = useroffset = 0;
>> >> -
>> >> -	if (!usersize)
>> >> -		s = __kmem_cache_alias(name, size, align, flags, ctor);
>> >> +	    WARN_ON(!args->usersize && args->useroffset) ||
>> >> +	    WARN_ON(object_size < args->usersize ||
>> >> +		    object_size - args->usersize < args->useroffset))
>> >> +		args->usersize = args->useroffset = 0;
>> >> +
>> >> +	if (!args->usersize)
>> >> +		s = __kmem_cache_alias(name, object_size, args->align, flags,
>> >> +				       args->ctor);
>> > 
>> > Sorry I missed it in the previous review, but nothing guaranties that
>> > nobody will call kmem_cache_create_args with args != NULL.
>> > 
>> > I think there should be a check for args != NULL and a substitution of args
>> > with defaults if it actually was NULL.
>> 
>> Hm there might be a bigger problem with this? If we wanted to do a
>> (non-flag-day) conversion to the new kmem_cache_create() for some callers
>> that need none of the extra args, passing NULL wouldn't work for the
>> _Generic((__args) looking for "struct kmem_cache_args *" as NULL is not of
>> that type, right?
>> 
>> I tried and it really errors out.
> 
> How about
> 
> #define kmem_cache_create(__name, __object_size, __args, ...)           \
> 	_Generic((__args),                                              \
> 		struct kmem_cache_args *: __kmem_cache_create_args,	\
> 		void *: __kmem_cache_create_args,			\
> 		default: __kmem_cache_create)(__name, __object_size, __args, __VA_ARGS__)

Seems to work. I'd agree with the "if NULL, use a static default" direction
then. It just seems like a more user-friendly API to me.


