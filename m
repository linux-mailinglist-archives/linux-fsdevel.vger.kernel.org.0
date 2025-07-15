Return-Path: <linux-fsdevel+bounces-54939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A97B057B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EE417C0DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C52D8361;
	Tue, 15 Jul 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aIxLOiY4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h6hM3NaL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aIxLOiY4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h6hM3NaL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15084275873
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575015; cv=none; b=cjRvH/ce89fwrxVXi/Mok4uKIxI6ztfKlto/E9Rr1fF5GMIWLJprtgU4WjJ1NpA8pvgNZ72miF4tTC7U1TRindo9qIQKMabuNIeVZpjETsG7cc47Cb1gZ6aqSBDhy/hJIXMzTQogzpP9Ci7NACC7mujNLJlpvH6viscyZGmsruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575015; c=relaxed/simple;
	bh=vuQceaozUCI5vYXD3y8BDdsiOM3F86D8uiIatwsZtjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvLzFth/UI6mxXp5ej/id1aRIBRPGpf7pLBp9ijxxxKYvhQNyeco9t3Lb59O8OPn4xeRdfBs/he65uLPS8L2ZJKyTgZEKJmxP07AQgH75Dnd7/kR2kqvtgfam2Ajb9W/TDiB+wnUC9Ll6FZX6CsqnzbIPUlf7CeX4HeziCPj7JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aIxLOiY4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h6hM3NaL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aIxLOiY4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h6hM3NaL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 398D42120E;
	Tue, 15 Jul 2025 10:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752575012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yJYPNA6u4aeyyYLiremB9nnSoMj89EXKE+21RNguYlo=;
	b=aIxLOiY4j6Wdm0/KfmHoL2dwK3J502fAv5rGjKdUtBFdv+WxazAPiQTyx4Y+dRTk5CTmQJ
	6zT/E5Zoj3lZWk76SX69gsA44IgwlF2uYl++FN57lenGUJjVekns7/2xC9Pgi1PtWV/y+8
	DdrlxtklB8Muv2qrpyw8AlU5bVQh2NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752575012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yJYPNA6u4aeyyYLiremB9nnSoMj89EXKE+21RNguYlo=;
	b=h6hM3NaLV1rOtLLJ0N+tLunZ7TvQPOtzR54ITC4Wk/L5Yrj7mzqD5+76IQI6JRRDS2ifx+
	cXmA4VSWtHnVtlDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752575012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yJYPNA6u4aeyyYLiremB9nnSoMj89EXKE+21RNguYlo=;
	b=aIxLOiY4j6Wdm0/KfmHoL2dwK3J502fAv5rGjKdUtBFdv+WxazAPiQTyx4Y+dRTk5CTmQJ
	6zT/E5Zoj3lZWk76SX69gsA44IgwlF2uYl++FN57lenGUJjVekns7/2xC9Pgi1PtWV/y+8
	DdrlxtklB8Muv2qrpyw8AlU5bVQh2NE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752575012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yJYPNA6u4aeyyYLiremB9nnSoMj89EXKE+21RNguYlo=;
	b=h6hM3NaLV1rOtLLJ0N+tLunZ7TvQPOtzR54ITC4Wk/L5Yrj7mzqD5+76IQI6JRRDS2ifx+
	cXmA4VSWtHnVtlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 086E513306;
	Tue, 15 Jul 2025 10:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t1FmASQsdmhVeQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 15 Jul 2025 10:23:32 +0000
Message-ID: <8026c455-6237-47e3-98af-e3acb90dba25@suse.cz>
Date: Tue, 15 Jul 2025 12:23:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma
 lock
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
 peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org,
 paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com,
 brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com,
 linux@weissschuh.net, willy@infradead.org, osalvador@suse.de,
 andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
 tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz>
 <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
 <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
 <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
 <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <0b8617c1-a150-426f-8fa6-9ab3b5bcfa1e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux-foundation.org,redhat.com,cmpxchg.org,kernel.org,gmail.com,toxicpanda.com,huawei.com,weissschuh.net,infradead.org,suse.de,arm.com,csgroup.eu,vger.kernel.org,kvack.org];
	R_RATELIMIT(0.00)[to_ip_from(RLqwhhqik4qyk5i1fk54co8f1o)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/15/25 11:52, David Hildenbrand wrote:
> On 15.07.25 11:40, Lorenzo Stoakes wrote:
>> On Tue, Jul 15, 2025 at 10:16:41AM +0200, Vlastimil Babka wrote:
>>>> Andrew, could you please remove this patchset from mm-unstable for now
>>>> until I fix the issue and re-post the new version?
>>>
>>> Andrew can you do that please? We keep getting new syzbot reports.
>> 
>> I also pinged up top :P just to be extra specially clear...
>> 
>>>
>>>> The error I got after these fixes is:
>>>
>>> I suspect the root cause is the ioctls are not serialized against each other
>>> (probably not even against read()) and yet we treat m->private as safe to
>>> work on. Now we have various fields that are dangerous to race on - for
>>> example locked_vma and iter races would explain a lot of this.
>>>
>>> I suspect as long as we used purely seq_file workflow, it did the right
>>> thing for us wrt serialization, but the ioctl addition violates that. We
>>> should rather recheck even the code before this series, if dangerous ioctl
>>> vs read() races are possible. And the ioctl implementation should be
>>> refactored to use an own per-ioctl-call private context, not the seq_file's
>>> per-file-open context.
>> 
>> Entirely agree with this analysis. I had a look at most recent report, see:
>> 
>> https://lore.kernel.org/linux-mm/f13cda37-06a0-4281-87d1-042678a38a6b@lucifer.local/
>> 
>> AFAICT we either have to lock around the ioctl or find a new way of storing
>> per-ioctl state.
>> 
>> We'd probably need to separate out the procmap query stuff to do that
>> though. Probably.
> 
> When I skimmed that series the first time, I was wondering "why are we 
> even caring about PROCMAP_QUERY that in the context of this patch series".
> 
> Maybe that helps :)

Yeah seems like before patch 8/8 the ioctl handling, specifically
do_procmap_query() only looks at priv->mm and nothing else so it should be
safe as that's a stable value.

So it should be also enough to drop the last patch from mm for now, not
whole series.

