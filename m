Return-Path: <linux-fsdevel+bounces-19680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E128C86B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7393FB21180
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E2A4F608;
	Fri, 17 May 2024 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w1cp1FNV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9sLrQzGJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w1cp1FNV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9sLrQzGJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714F43D546;
	Fri, 17 May 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950577; cv=none; b=h/w62xuUwFD327ZcPhdkOpM+yro6rWfpNDeiKjI4E9X8tIAzuFaOjPPKodwxEbzwrqVEW57RDK8u5FebMegp833r2O3CMElopQY4J9gUL8vG3n/ij8JeHX1JwaN+DHGqE311vo4Bm6V4HZGqjnN6haR9dCCQ2dOrYsiNUn8SnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950577; c=relaxed/simple;
	bh=e9oH/dFJNymwnP2+/bICLJ3w2u+V9W0KpOSWMqRvKaM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g39wIvP5uR6g0EdZ9+Vq/yLmkONwHgkFTZtM3Ryo6F/vEOWotlroTYZpwFoDeknE2ur2GahlHL6aprPqlMFcaveB78hTH3ZPgt57VXVJI0gMQh4YRDwskOvsOHcYFuOFTcguRRGb+TJTUA3CGX3hMTUYGmnp1V3Oaxsswzo1KDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w1cp1FNV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9sLrQzGJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w1cp1FNV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9sLrQzGJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63C285D39D;
	Fri, 17 May 2024 12:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715950573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cby//ih+NMEN3e6wlO01IS8t6sJXDU+AyZekjPzlkn8=;
	b=w1cp1FNVIuKA1qfXgHtz6MXzAE1rPbnAHQccBwH4oB7Q+CrjyPZsMG7Wp8Ya4tDl7CQuER
	xX4JvXXjBTp5W00aHF9ztIsp2raHdoqrAy8wEXdXt5mFE7vJISMFXvzITzFC0PmQE69otW
	gG4KtRXzF+bI5qBh04YXuxdSED1F4kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715950573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cby//ih+NMEN3e6wlO01IS8t6sJXDU+AyZekjPzlkn8=;
	b=9sLrQzGJXcLCz+kbnFtXjYOZNr26jZNpYG6JbjKJvbAvv3XSzRr/sAU1rApxjsN3VnakKG
	bxdHBUX9hPyG2yAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715950573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cby//ih+NMEN3e6wlO01IS8t6sJXDU+AyZekjPzlkn8=;
	b=w1cp1FNVIuKA1qfXgHtz6MXzAE1rPbnAHQccBwH4oB7Q+CrjyPZsMG7Wp8Ya4tDl7CQuER
	xX4JvXXjBTp5W00aHF9ztIsp2raHdoqrAy8wEXdXt5mFE7vJISMFXvzITzFC0PmQE69otW
	gG4KtRXzF+bI5qBh04YXuxdSED1F4kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715950573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cby//ih+NMEN3e6wlO01IS8t6sJXDU+AyZekjPzlkn8=;
	b=9sLrQzGJXcLCz+kbnFtXjYOZNr26jZNpYG6JbjKJvbAvv3XSzRr/sAU1rApxjsN3VnakKG
	bxdHBUX9hPyG2yAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6E8013991;
	Fri, 17 May 2024 12:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nkfnJuxTR2ZhQQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 17 May 2024 12:56:12 +0000
Message-ID: <c7ace4b0-4f88-4a2d-8f0c-fcc1e2e618ba@suse.de>
Date: Fri, 17 May 2024 14:56:12 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
 Keith Busch <kbusch@kernel.org>, mcgrof@kernel.org,
 akpm@linux-foundation.org, brauner@kernel.org, chandan.babu@oracle.com,
 gost.dev@samsung.com, john.g.garry@oracle.com, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, p.raghav@samsung.com, ritesh.list@gmail.com,
 ziy@nvidia.com
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZkQG7bdFStBLFv3g@casper.infradead.org> <ZkQfId5IdKFRigy2@kbusch-mbp>
 <ZkQ0Pj26H81HxQ_4@casper.infradead.org>
 <20240515155943.2uaa23nvddmgtkul@quentin>
 <ZkT46AsZ3WghOArL@casper.infradead.org>
 <20240516150206.d64eezbj3waieef5@quentin>
 <ef22fc06-0227-419c-8f25-38aff7f5e3eb@suse.de>
In-Reply-To: <ef22fc06-0227-419c-8f25-38aff7f5e3eb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fromorbit.com,kernel.org,lst.de,linux-foundation.org,oracle.com,samsung.com,vger.kernel.org,kvack.org,gmail.com,nvidia.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]

On 5/17/24 14:36, Hannes Reinecke wrote:
> On 5/16/24 17:02, Pankaj Raghav (Samsung) wrote:
>> On Wed, May 15, 2024 at 07:03:20PM +0100, Matthew Wilcox wrote:
>>> On Wed, May 15, 2024 at 03:59:43PM +0000, Pankaj Raghav (Samsung) wrote:
>>>>   static int __init iomap_init(void)
>>>>   {
>>>> +       void            *addr = kzalloc(16 * PAGE_SIZE, GFP_KERNEL);
>>>
>>> Don't use XFS coding style outside XFS.
>>>
>>> kzalloc() does not guarantee page alignment much less alignment to
>>> a folio.  It happens to work today, but that is an implementation
>>> artefact.
>>>
>>>> +
>>>> +       if (!addr)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       zero_fsb_folio = virt_to_folio(addr);
>>>
>>> We also don't guarantee that calling kzalloc() gives you a virtual
>>> address that can be converted to a folio.  You need to allocate a folio
>>> to be sure that you get a folio.
>>>
>>> Of course, you don't actually need a folio.  You don't need any of the
>>> folio metadata and can just use raw pages.
>>>
>>>> +       /*
>>>> +        * The zero folio used is 64k.
>>>> +        */
>>>> +       WARN_ON_ONCE(len > (16 * PAGE_SIZE));
>>>
>>> PAGE_SIZE is not necessarily 4KiB.
>>>
>>>> +       bio = iomap_dio_alloc_bio(iter, dio, BIO_MAX_VECS,
>>>> +                                 REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>>>
>>> The point was that we now only need one biovec, not MAX.
>>>
>>
>> Thanks for the comments. I think it all makes sense:
>>
>> diff --git a/fs/internal.h b/fs/internal.h
>> index 7ca738904e34..e152b77a77e4 100644
>> --- a/fs/internal.h
>> +++ b/fs/internal.h
>> @@ -35,6 +35,14 @@ static inline void bdev_cache_init(void)
>>   int __block_write_begin_int(struct folio *folio, loff_t pos, 
>> unsigned len,
>>                  get_block_t *get_block, const struct iomap *iomap);
>> +/*
>> + * iomap/buffered-io.c
>> + */
>> +
>> +#define ZERO_FSB_SIZE (65536)
>> +#define ZERO_FSB_ORDER (get_order(ZERO_FSB_SIZE))
>> +extern struct page *zero_fs_block;
>> +
>>   /*
>>    * char_dev.c
>>    */
> But why?
> We already have a perfectly fine hugepage zero page in huge_memory.c. 
> Shouldn't we rather export that one and use it?
> (Actually I have some patches for doing so...)
> We might allocate folios

Bah. Hit 'enter' too soon.

We might allocate a zero folio as a fallback if the huge zero page is 
not available, but first we should try to use that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


