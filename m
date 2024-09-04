Return-Path: <linux-fsdevel+bounces-28580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE81496C2D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE781F22A83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDD11DC1AD;
	Wed,  4 Sep 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnSICjtZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O+OIYhel";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lnSICjtZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O+OIYhel"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F1D3CF65
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464960; cv=none; b=NwIIHN2+986ybRfPaWsaUejeLe4qyesjdXJKdUyMF/KF3aC6tgP0o0YAfcHqCb8mVniZWemClor4QiFc9UumVCiByJEIJz4I4rauE3A11RfbtljvC1rcpkEeraCAb+I08HDzODaKbbdmHEFX0Ebww+bYJShqcKkAg7YQwvgw+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464960; c=relaxed/simple;
	bh=T+VWZXDaA/l+lNNprl+rJ6Sx7emOcRwAX6Rf8Q1dPSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VycxWjOAsC/wg5kmIZR2Kt6ADXVXL2GfnGndK9T4blxmvET10GH7nBkz2B32F+9FmM+k3cHI4VXunKFwNi3u5An4Gkf1LEtgcJDDpsEZAanS9p4/QyHMRgCwvUw9IhuQ81/W/88uErblOW7KXKPMmI+6H+1spw+vNjpe7CD/hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnSICjtZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O+OIYhel; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lnSICjtZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O+OIYhel; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48A3C2197E;
	Wed,  4 Sep 2024 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725464956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=THaKVs3lY/mEHYaOCw8chjrh6S3bUNgZVp8Cxk4qBQM=;
	b=lnSICjtZrjN404/Fo/QxQi3CE+0IeZ2i7rYbN/0ux/A/cCNpk2kuM0C6lbbhHhUuYM4tM7
	XrxrlH4e746Lv/au4SK2LwQZXv0emH9ZLysTU5CpVdM9/VfM/X/u1cX9tK0NDUkap2mYqv
	PtkrmJtN/CgV3PccYUa1MS6CmOKfZR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725464956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=THaKVs3lY/mEHYaOCw8chjrh6S3bUNgZVp8Cxk4qBQM=;
	b=O+OIYhel4aE7oXLPBrbvywSrJCQve5f9ucIzsiGkWiAJVE/JffcO5jSzJ8rzY3mTde3PfF
	MqEpPfIgnDvRAgBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lnSICjtZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O+OIYhel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725464956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=THaKVs3lY/mEHYaOCw8chjrh6S3bUNgZVp8Cxk4qBQM=;
	b=lnSICjtZrjN404/Fo/QxQi3CE+0IeZ2i7rYbN/0ux/A/cCNpk2kuM0C6lbbhHhUuYM4tM7
	XrxrlH4e746Lv/au4SK2LwQZXv0emH9ZLysTU5CpVdM9/VfM/X/u1cX9tK0NDUkap2mYqv
	PtkrmJtN/CgV3PccYUa1MS6CmOKfZR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725464956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=THaKVs3lY/mEHYaOCw8chjrh6S3bUNgZVp8Cxk4qBQM=;
	b=O+OIYhel4aE7oXLPBrbvywSrJCQve5f9ucIzsiGkWiAJVE/JffcO5jSzJ8rzY3mTde3PfF
	MqEpPfIgnDvRAgBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34A14139E2;
	Wed,  4 Sep 2024 15:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eld+DHyB2GYREQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 04 Sep 2024 15:49:16 +0000
Message-ID: <9303896a-e3c8-4dc3-926b-c7e8fc75cf6b@suse.cz>
Date: Wed, 4 Sep 2024 17:49:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] slab: add struct kmem_cache_args
Content-Language: en-US
To: Mike Rapoport <rppt@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-2-76f97e9a4560@kernel.org>
 <Zth5wHtDkX78gl1l@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Zth5wHtDkX78gl1l@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 48A3C2197E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 9/4/24 17:16, Mike Rapoport wrote:
> On Tue, Sep 03, 2024 at 04:20:43PM +0200, Christian Brauner wrote:
>> @@ -275,7 +285,7 @@ do_kmem_cache_create_usercopy(const char *name,
>>  
>>  	mutex_lock(&slab_mutex);
>>  
>> -	err = kmem_cache_sanity_check(name, size);
>> +	err = kmem_cache_sanity_check(name, object_size);
>>  	if (err) {
>>  		goto out_unlock;
>>  	}
>> @@ -296,12 +306,14 @@ do_kmem_cache_create_usercopy(const char *name,
>>  
>>  	/* Fail closed on bad usersize of useroffset values. */
>>  	if (!IS_ENABLED(CONFIG_HARDENED_USERCOPY) ||
>> -	    WARN_ON(!usersize && useroffset) ||
>> -	    WARN_ON(size < usersize || size - usersize < useroffset))
>> -		usersize = useroffset = 0;
>> -
>> -	if (!usersize)
>> -		s = __kmem_cache_alias(name, size, align, flags, ctor);
>> +	    WARN_ON(!args->usersize && args->useroffset) ||
>> +	    WARN_ON(object_size < args->usersize ||
>> +		    object_size - args->usersize < args->useroffset))
>> +		args->usersize = args->useroffset = 0;
>> +
>> +	if (!args->usersize)
>> +		s = __kmem_cache_alias(name, object_size, args->align, flags,
>> +				       args->ctor);
> 
> Sorry I missed it in the previous review, but nothing guaranties that
> nobody will call kmem_cache_create_args with args != NULL.
> 
> I think there should be a check for args != NULL and a substitution of args
> with defaults if it actually was NULL.

Hm there might be a bigger problem with this? If we wanted to do a
(non-flag-day) conversion to the new kmem_cache_create() for some callers
that need none of the extra args, passing NULL wouldn't work for the
_Generic((__args) looking for "struct kmem_cache_args *" as NULL is not of
that type, right?

I tried and it really errors out.


