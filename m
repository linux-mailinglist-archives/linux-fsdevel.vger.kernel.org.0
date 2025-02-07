Return-Path: <linux-fsdevel+bounces-41165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27083A2BC10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 08:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D4E160609
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 07:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55450194091;
	Fri,  7 Feb 2025 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bIGl2px7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uENvLmCo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kScB3W4T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h0gnVkuw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7938385;
	Fri,  7 Feb 2025 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738912095; cv=none; b=puvI0Wza/edwehOeouAW3CkNpNV8BZ3n/jhbgREx7CM0NqSSqRDseRXag/BnJiASQVdRTYkqS/IUDUVF0gYC5dtPlPojueWcauvf0oTIiADhRVgeTN8FgfuGtvCa+YUn2iR9eHnWZrvDyNRURG4jxRIS5XBRVVophxevUUsVurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738912095; c=relaxed/simple;
	bh=NLjHGcdMr8MC2TB6JR+tiSmT/jC2MNv4W3oqDL6e+CA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MeKzPWi+aWgm3W3iCvwluGVPzkFtCizN4gZY9o0cMM/NGr7sSo35qfYqzK7TGL1TD7zBPwi32snTwwYF5TYpWcozuMfKvrWCI6f0qBSlsCgT8OWPG0uoM6+JYSy9fxiCP7LzNTbB1mGrfnn0soYU90MhWeC7Lf9CRcWNMqLCxOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bIGl2px7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uENvLmCo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kScB3W4T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h0gnVkuw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EDB0821168;
	Fri,  7 Feb 2025 07:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738912092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EPOR4GlrvbJfgXWHQ+FUyE0rBFnnykG5rw2E2AqCWc=;
	b=bIGl2px7YRM7LN//OacrJBv8dmWLT1W4CQvN65oXM0QTSN07FtRO6lBzQf4XiTCCRhQsy1
	DeYQBvNdcJQ1cr24MnS55bt1Q1yymL5flD3CipVkXWG6nuVYbCp+4wVb0FXpZxmYLv8BKC
	hwUbwyYjccRAmYU49p+ptEH3Em15F1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738912092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EPOR4GlrvbJfgXWHQ+FUyE0rBFnnykG5rw2E2AqCWc=;
	b=uENvLmCon/UxVGeZqTDxjGdOsPCzE/qjh9Zaw8aAMFXBextQRqdMuI86MeQrSjKnIBiXfp
	qcBVJkL40PntRaBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738912090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EPOR4GlrvbJfgXWHQ+FUyE0rBFnnykG5rw2E2AqCWc=;
	b=kScB3W4THxmDwPC41U91FiCkXtHqULTiznyvJiSUMvNvtE/7IOkd9Tm9XIww8EP/RbnVnE
	+bhd3V4sijtpdKwP0VvlPOqvQu/oWrcDiJThzpGNtMS5BCozuI8Fx6DBMSy5pAs1DXOrBK
	ZCZiE9fSgJPobOKsOuuz6XwfFMzfg6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738912090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EPOR4GlrvbJfgXWHQ+FUyE0rBFnnykG5rw2E2AqCWc=;
	b=h0gnVkuwHaqDvgB3pXA2NneGFSRlIJzYLixDUFHRb6CYcaaZVKR6xnZS4dhKmm1IDWbART
	sCukqvgnr6jPwSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4573C13694;
	Fri,  7 Feb 2025 07:08:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ISpiD1qxpWdEMwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 07 Feb 2025 07:08:10 +0000
Message-ID: <a023ce9a-12bf-475b-9c34-3218c80b6ff3@suse.de>
Date: Fri, 7 Feb 2025 08:08:09 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] fs/buffer: remove batching from async read
From: Hannes Reinecke <hare@suse.de>
To: Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
 dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org, kbusch@kernel.org
Cc: john.g.garry@oracle.com, hch@lst.de, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, gost.dev@samsung.com,
 p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-3-mcgrof@kernel.org>
 <40f8f338-3b88-497e-b622-49cfa6461d30@suse.de>
Content-Language: en-US
In-Reply-To: <40f8f338-3b88-497e-b622-49cfa6461d30@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,lst.de,gmail.com,vger.kernel.org,kvack.org,samsung.com,pankajraghav.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/5/25 17:21, Hannes Reinecke wrote:
> On 2/5/25 00:12, Luis Chamberlain wrote:
>> From: Matthew Wilcox <willy@infradead.org>
>>
>> The current implementation of a folio async read in 
>> block_read_full_folio()
>> first batches all buffer-heads which need IOs issued for by putting 
>> them on an
>> array of max size MAX_BUF_PER_PAGE. After collection it locks the batched
>> buffer-heads and finally submits the pending reads. On systems with CPUs
>> where the system page size is quite larger like Hexagon with 256 KiB this
>> batching can lead stack growth warnings so we want to avoid that.
>>
>> Note the use of folio_end_read() through block_read_full_folio(), its
>> used either when the folio is determined to be fully uptodate and no
>> pending read is needed, an IO error happened on get_block(), or an out of
>> bound read raced against batching collection to make our required reads
>> uptodate.
>>
>> We can simplify this logic considerably and remove the stack growth
>> issues of MAX_BUF_PER_PAGE by just replacing the batched logic with
>> one which only issues IO for the previous buffer-head keeping in mind
>> we'll always have one buffer-head (the current one) on the folio with
>> an async flag, this will prevent any calls to folio_end_read().
>>
>> So we accomplish two things with this:
>>
>>   o Avoid large stacks arrays with MAX_BUF_PER_PAGE
>>   o Make the need for folio_end_read() explicit and easier to read
>>
>> Suggested-by: Matthew Wilcox <willy@infradead.org>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>   fs/buffer.c | 51 +++++++++++++++++++++------------------------------
>>   1 file changed, 21 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/buffer.c b/fs/buffer.c
>> index b99560e8a142..167fa3e33566 100644
>> --- a/fs/buffer.c
>> +++ b/fs/buffer.c
>> @@ -2361,9 +2361,8 @@ int block_read_full_folio(struct folio *folio, 
>> get_block_t *get_block)
>>   {
>>       struct inode *inode = folio->mapping->host;
>>       sector_t iblock, lblock;
>> -    struct buffer_head *bh, *head, *arr[MAX_BUF_PER_PAGE];
>> +    struct buffer_head *bh, *head, *prev = NULL;
>>       size_t blocksize;
>> -    int nr, i;
>>       int fully_mapped = 1;
>>       bool page_error = false;
>>       loff_t limit = i_size_read(inode);
>> @@ -2380,7 +2379,6 @@ int block_read_full_folio(struct folio *folio, 
>> get_block_t *get_block)
>>       iblock = div_u64(folio_pos(folio), blocksize);
>>       lblock = div_u64(limit + blocksize - 1, blocksize);
>>       bh = head;
>> -    nr = 0;
>>       do {
>>           if (buffer_uptodate(bh))
>> @@ -2410,40 +2408,33 @@ int block_read_full_folio(struct folio *folio, 
>> get_block_t *get_block)
>>               if (buffer_uptodate(bh))
>>                   continue;
>>           }
>> -        arr[nr++] = bh;
>> +
>> +        lock_buffer(bh);
>> +        if (buffer_uptodate(bh)) {
>> +            unlock_buffer(bh);
>> +            continue;
>> +        }
>> +
>> +        mark_buffer_async_read(bh);
>> +        if (prev)
>> +            submit_bh(REQ_OP_READ, prev);
>> +        prev = bh;
>>       } while (iblock++, (bh = bh->b_this_page) != head);
>>       if (fully_mapped)
>>           folio_set_mappedtodisk(folio);
>> -    if (!nr) {
>> -        /*
>> -         * All buffers are uptodate or get_block() returned an
>> -         * error when trying to map them - we can finish the read.
>> -         */
>> -        folio_end_read(folio, !page_error);
>> -        return 0;
>> -    }
>> -
>> -    /* Stage two: lock the buffers */
>> -    for (i = 0; i < nr; i++) {
>> -        bh = arr[i];
>> -        lock_buffer(bh);
>> -        mark_buffer_async_read(bh);
>> -    }
>> -
>>       /*
>> -     * Stage 3: start the IO.  Check for uptodateness
>> -     * inside the buffer lock in case another process reading
>> -     * the underlying blockdev brought it uptodate (the sct fix).
>> +     * All buffers are uptodate or get_block() returned an error
>> +     * when trying to map them - we must finish the read because
>> +     * end_buffer_async_read() will never be called on any buffer
>> +     * in this folio.
>>        */
>> -    for (i = 0; i < nr; i++) {
>> -        bh = arr[i];
>> -        if (buffer_uptodate(bh))
>> -            end_buffer_async_read(bh, 1);
>> -        else
>> -            submit_bh(REQ_OP_READ, bh);
>> -    }
>> +    if (prev)
>> +        submit_bh(REQ_OP_READ, prev);
>> +    else
>> +        folio_end_read(folio, !page_error);
>> +
>>       return 0;
>>   }
>>   EXPORT_SYMBOL(block_read_full_folio);
> 
> Similar here; as we now removed batching (which technically could result
> in I/O being completed while executing the various stages) there really
> is nothing preventing us to use plugging here, no?
> 
In the light of the discussion to the previous patch we should move that
to a later point. So:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

