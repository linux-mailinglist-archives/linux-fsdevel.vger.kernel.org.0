Return-Path: <linux-fsdevel+bounces-15309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B68588BFF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355DF301767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2DF134C6;
	Tue, 26 Mar 2024 10:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kUiYxGNW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XfxE6I62";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kUiYxGNW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XfxE6I62"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7D3C30;
	Tue, 26 Mar 2024 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450510; cv=none; b=eVraFKPDCgm80RmvJjbyYsMnvd0+qI1vYXykZ8YNbJpLMz9TsMagmtlNtjcuMokyhal0nPhmRtfhlP0qPLoRbkYJplsW2HsbsoAesVhC4TR1t1ugKNzVRQzXiezmuAF5ZtWvZThUlXYOSJr7bFv/dbV/7p3Exjhsrl/a1SjCKr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450510; c=relaxed/simple;
	bh=TDxEP8Utle4UQaW+Louu8u8U4eflu17bhRfPBZSW3pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EH0En2y/5WRhF1emIDJXDl5QTWsb96QO8JVfTKikRHUyNVHPppRwtuqXElACPIGXdSseaHrQp42VcEJeiCQ8/ySzjGOG/KyAQwwgrR33YUE9XMSr2NwisxhLpSavIbXF1H9IeUOnjR6AN3BikeKhPX1WZyhddUybiCuYy17mQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kUiYxGNW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XfxE6I62; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kUiYxGNW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XfxE6I62; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 779CE5D4A1;
	Tue, 26 Mar 2024 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711450507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTAHC+dMlqgS5jsreRqLtBqwCP2zNUfrzfIGXEK/tJY=;
	b=kUiYxGNW8v1k6TKo4T89QY29viOegU1qT3isgfEoFTaC493EP2ZsBan/tb77soJ16nWnAx
	MXMUqkyoMP5sQPYazm7w2wNVncvYH/FoYatI4S1QgK1ELdH8UKEimAuqWuj39azqw/x58d
	xzQh25s1/vqr6cWtKtilsY9JQ4Bn0U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711450507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTAHC+dMlqgS5jsreRqLtBqwCP2zNUfrzfIGXEK/tJY=;
	b=XfxE6I627pa79m+G1W4LYwVMCyb0DfGUrcnsaVE4lG3C93QValJUsOpvYKy0THWSTwFSyS
	zk3p+W8lspJ2LEAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711450507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTAHC+dMlqgS5jsreRqLtBqwCP2zNUfrzfIGXEK/tJY=;
	b=kUiYxGNW8v1k6TKo4T89QY29viOegU1qT3isgfEoFTaC493EP2ZsBan/tb77soJ16nWnAx
	MXMUqkyoMP5sQPYazm7w2wNVncvYH/FoYatI4S1QgK1ELdH8UKEimAuqWuj39azqw/x58d
	xzQh25s1/vqr6cWtKtilsY9JQ4Bn0U0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711450507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTAHC+dMlqgS5jsreRqLtBqwCP2zNUfrzfIGXEK/tJY=;
	b=XfxE6I627pa79m+G1W4LYwVMCyb0DfGUrcnsaVE4lG3C93QValJUsOpvYKy0THWSTwFSyS
	zk3p+W8lspJ2LEAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FBFE13306;
	Tue, 26 Mar 2024 10:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LzwFE4upAmZ0CAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 26 Mar 2024 10:55:07 +0000
Message-ID: <2b1a2ded-d26f-4c9e-bd48-2384b5a7c2c9@suse.de>
Date: Tue, 26 Mar 2024 11:55:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] readahead: rework loop in
 page_cache_ra_unbounded()
Content-Language: en-US
To: Pankaj Raghav <kernel@pankajraghav.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 gost.dev@samsung.com, chandan.babu@oracle.com, mcgrof@kernel.org,
 djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 david@fromorbit.com, akpm@linux-foundation.org,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-5-kernel@pankajraghav.com>
 <ZgHFPZ9tNLLjKZpz@casper.infradead.org>
 <7217df4e-470b-46ab-a4fc-1d4681256885@suse.de>
 <5e5523b1-0766-43b2-abb1-f18ea63906d6@pankajraghav.com>
 <3aa8bdf1-24f6-4e1f-a5c4-8dc2d11ca292@suse.de>
 <1a4a6ad3-6b88-47ea-a6c4-144a1485f614@pankajraghav.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <1a4a6ad3-6b88-47ea-a6c4-144a1485f614@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.995];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On 3/26/24 11:06, Pankaj Raghav wrote:
> On 26/03/2024 11:00, Hannes Reinecke wrote:
>> On 3/26/24 10:44, Pankaj Raghav wrote:
>>> Hi Hannes,
>>>
>>> On 26/03/2024 10:39, Hannes Reinecke wrote:
>>>> On 3/25/24 19:41, Matthew Wilcox wrote:
>>>>> On Wed, Mar 13, 2024 at 06:02:46PM +0100, Pankaj Raghav (Samsung) wrote:
>>>>>> @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>>>>>                  * not worth getting one just for that.
>>>>>>                  */
>>>>>>                 read_pages(ractl);
>>>>>> -            ractl->_index++;
>>>>>> -            i = ractl->_index + ractl->_nr_pages - index - 1;
>>>>>> +            ractl->_index += folio_nr_pages(folio);
>>>>>> +            i = ractl->_index + ractl->_nr_pages - index;
>>>>>>                 continue;
>>>>>>             }
>>>>>>     @@ -252,13 +252,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>>>>>                 folio_put(folio);
>>>>>>                 read_pages(ractl);
>>>>>>                 ractl->_index++;
>>>>>> -            i = ractl->_index + ractl->_nr_pages - index - 1;
>>>>>> +            i = ractl->_index + ractl->_nr_pages - index;
>>>>>>                 continue;
>>>>>>             }
>>>>>
>>>>> You changed index++ in the first hunk, but not the second hunk.  Is that
>>>>> intentional?
>>>>
>>>> Hmm. Looks you are right; it should be modified, too.
>>>> Will be fixing it up.
>>>>
>>> You initially had also in the second hunk:
>>> ractl->index += folio_nr_pages(folio);
>>>
>>> and I changed it to what it is now.
>>>
>>> The reason is in my reply to willy:
>>> https://lore.kernel.org/linux-xfs/s4jn4t4betknd3y4ltfccqxyfktzdljiz7klgbqsrccmv3rwrd@orlwjz77oyxo/
>>>
>>> Let me know if you agree with it.
>>>
>> Bah. That really is overly complicated. When we attempt a conversion that conversion should be
>> stand-alone, not rely on some other patch modifications later on.
>> We definitely need to work on that to make it easier to review, even
>> without having to read the mail thread.
>>
> 
> I don't know understand what you mean by overly complicated. This conversion is standalone and it is
> wrong to use folio_nr_pages after we `put` the folio. This patch just reworks the loop and in the
> next patch I add min order support to readahead.
> 
> This patch doesn't depend on the next patch.
> 

Let me rephrase: what does 'ractl->_index' signify?
 From my understanding it should be the index of the
first folio/page in ractl, right?

If so I find it hard to understand how we _could_ increase it by one; 
_index should _always_ in units of the minimal pagemap size.
And if we don't have it here (as you suggested in the mailthread)
I'd rather move this patch _after_ the minimal pagesize is introduced
to ensure that _index is always incremented by the right amount.

Cheers,

Hannes


