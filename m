Return-Path: <linux-fsdevel+bounces-15299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C43888BE9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A91C38E8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3F2548F1;
	Tue, 26 Mar 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UOznrKGV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nifv0FZX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UOznrKGV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nifv0FZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99992487B5;
	Tue, 26 Mar 2024 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447231; cv=none; b=MGzi1z18QPNoQw9McJcxCLA+1msLvlg8ozJ9LEtL1Ie+8pZfBOKVK2UKJVHVChBSqKe6ikyPPcVkNCymo5mwI1i3n0EooVQwngyPR554eIdOVjvuEj9my+HVfU/p+aJhmLNrdw9TgMMnYzulnqfsJY2FgqQxUGYfZOIkjhRAMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447231; c=relaxed/simple;
	bh=XJNsynjzhDj0K6HmxLv28+YnYkW2HnZhhLlHe4y7U3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IaiAKgn+PsDl56UNnHEnrkwZ6QndH2rjHHz3gvvX9X2hWhQSJ6GGmDg9qqmP9/uBpLuf0Y7bRKuUp4SI0oqRFsbiqE6BlZrD5umW2mzn/VslllUiWgvgn2FYaJiI0pkMlxBGkQlSCvNeRaPu32VCtaG7zttnSROLcXUrWJ9Ha8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UOznrKGV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nifv0FZX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UOznrKGV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nifv0FZX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 578B55D41B;
	Tue, 26 Mar 2024 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711447227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KICT4ootVVkt82VIPFNRhNaswFEFMB6uWwwdlc+odyo=;
	b=UOznrKGVKIfFw2Fuszv5rYbTxsSo6NUggGIl4qc4DEs4/FyktjuYR8w/28z9wRcXhmp5DM
	yuDOfmvFfgFCmZqQuLpc940hGiok4U5tIA1OnKTWVm8hgbCxN1xChmxDD0tz78xhpYhuoV
	Y4rO/xz2+NyOS6VhgXYbMjfCH5lhB/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711447227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KICT4ootVVkt82VIPFNRhNaswFEFMB6uWwwdlc+odyo=;
	b=Nifv0FZX88quizLkdpQphaS7PfqMVM9ArrCcCEpGk+35zdfozitUjml3zkzOyQKwHZ0nLb
	McctA9slEgNiv+Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711447227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KICT4ootVVkt82VIPFNRhNaswFEFMB6uWwwdlc+odyo=;
	b=UOznrKGVKIfFw2Fuszv5rYbTxsSo6NUggGIl4qc4DEs4/FyktjuYR8w/28z9wRcXhmp5DM
	yuDOfmvFfgFCmZqQuLpc940hGiok4U5tIA1OnKTWVm8hgbCxN1xChmxDD0tz78xhpYhuoV
	Y4rO/xz2+NyOS6VhgXYbMjfCH5lhB/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711447227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KICT4ootVVkt82VIPFNRhNaswFEFMB6uWwwdlc+odyo=;
	b=Nifv0FZX88quizLkdpQphaS7PfqMVM9ArrCcCEpGk+35zdfozitUjml3zkzOyQKwHZ0nLb
	McctA9slEgNiv+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1759B138A1;
	Tue, 26 Mar 2024 10:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uMT8BLucAmZfeQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 26 Mar 2024 10:00:27 +0000
Message-ID: <3aa8bdf1-24f6-4e1f-a5c4-8dc2d11ca292@suse.de>
Date: Tue, 26 Mar 2024 11:00:26 +0100
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
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5e5523b1-0766-43b2-abb1-f18ea63906d6@pankajraghav.com>
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
	 NEURAL_HAM_SHORT(-0.20)[-0.994];
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

On 3/26/24 10:44, Pankaj Raghav wrote:
> Hi Hannes,
> 
> On 26/03/2024 10:39, Hannes Reinecke wrote:
>> On 3/25/24 19:41, Matthew Wilcox wrote:
>>> On Wed, Mar 13, 2024 at 06:02:46PM +0100, Pankaj Raghav (Samsung) wrote:
>>>> @@ -239,8 +239,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>>>                 * not worth getting one just for that.
>>>>                 */
>>>>                read_pages(ractl);
>>>> -            ractl->_index++;
>>>> -            i = ractl->_index + ractl->_nr_pages - index - 1;
>>>> +            ractl->_index += folio_nr_pages(folio);
>>>> +            i = ractl->_index + ractl->_nr_pages - index;
>>>>                continue;
>>>>            }
>>>>    @@ -252,13 +252,14 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
>>>>                folio_put(folio);
>>>>                read_pages(ractl);
>>>>                ractl->_index++;
>>>> -            i = ractl->_index + ractl->_nr_pages - index - 1;
>>>> +            i = ractl->_index + ractl->_nr_pages - index;
>>>>                continue;
>>>>            }
>>>
>>> You changed index++ in the first hunk, but not the second hunk.  Is that
>>> intentional?
>>
>> Hmm. Looks you are right; it should be modified, too.
>> Will be fixing it up.
>>
> You initially had also in the second hunk:
> ractl->index += folio_nr_pages(folio);
> 
> and I changed it to what it is now.
> 
> The reason is in my reply to willy:
> https://lore.kernel.org/linux-xfs/s4jn4t4betknd3y4ltfccqxyfktzdljiz7klgbqsrccmv3rwrd@orlwjz77oyxo/
> 
> Let me know if you agree with it.
> 
Bah. That really is overly complicated. When we attempt a conversion 
that conversion should be stand-alone, not rely on some other patch 
modifications later on.
We definitely need to work on that to make it easier to review, even
without having to read the mail thread.

Cheers,

Hannes


