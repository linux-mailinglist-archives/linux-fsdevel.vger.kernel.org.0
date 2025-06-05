Return-Path: <linux-fsdevel+bounces-50739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB617ACF0D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349A33AEC72
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB62566F5;
	Thu,  5 Jun 2025 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pA2BlPGP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cgfrCEgI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z5dctllm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rWzruBT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E52259CAB
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130480; cv=none; b=RstHbAfDUgse96+w50Td/nPLwpP9uJajR0O/AnPH4KcIO10m82+0/q4en743/de/512Nk/QXTBlQf9hQTWigygZUUBV0L7dojcKeZny3y0NAfI4UxdCfgErYbQJIJHRxZfmAUdE7BMf2g4cOwSfOxF11QSCn/qVc6c5JvmCCZ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130480; c=relaxed/simple;
	bh=o+OeHNvVMsKdPGlaWq2NVJf1SuPHQlddZkKqFWOLpDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJQKGbSurkl1zcf1jTwSd66D70vubH40YGAEwD7dr1rIg75kGfXNDlphnkliTKSO9a7g8i/DeT2WmQt1ujxPZg5CPxCr5nT9ePo7Xc9ma+VNECGcb3F8PN2WZVfIQoVoazb/lmLeY7FWy8+HpFAE8NaD/v0e8BA9zjgZlJbjBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pA2BlPGP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cgfrCEgI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z5dctllm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rWzruBT9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E353E1FC07;
	Thu,  5 Jun 2025 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749130476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uL+ybV+TixM0q32FANrl48/kwjAsBV5dKSWMTiFj95o=;
	b=pA2BlPGPELI+RRaNuHYZj4SDq5I5zoeYlpv7RUx15zjuuYk+kB2WrY9GSrMc/FMG8C0uVp
	z2M2EwUWmWQ9itoR+npbZZ4MOJJZv0dRALUXFZrb+cKx5obTjY9TgAidSNVsLZj5DbYhX4
	LfKzbk/YbShafOEhzxMUsnVun3Cc3b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749130476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uL+ybV+TixM0q32FANrl48/kwjAsBV5dKSWMTiFj95o=;
	b=cgfrCEgIIvxibDh2zN9P6Jv8x/WKHOV2rGeN9bcrD/vCw0+GXhSTXK4W+LR8wfeJgoGTDf
	NyiwfZptn9Cg4KAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749130475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uL+ybV+TixM0q32FANrl48/kwjAsBV5dKSWMTiFj95o=;
	b=Z5dctllm31sFJqFI446AFfuw9QpBbYCWaFrHpxJAbKDJDE229Vzn1eV3b/gLgWPMPu1B65
	LrceZsMBziLdiofOrAuu77WaIYddFa/J/257O4aPjYbdZxylo1BTQta9uZ2Juj/Yk/APFh
	RNVbGt7ji/TnyxMXUUl/tcxdzIyF6BY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749130475;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uL+ybV+TixM0q32FANrl48/kwjAsBV5dKSWMTiFj95o=;
	b=rWzruBT9BNObqf9/rS267AeGZ5LtGEzHz7zg7KlAEs2tl52FEWsg45W4EN42o7vllTlwq+
	lwOHfK2lQymK83AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C39AD1373E;
	Thu,  5 Jun 2025 13:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ZMbL+ucQWh2NAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 05 Jun 2025 13:34:35 +0000
Message-ID: <3fb96c53-e682-4e27-b13a-9e3a57d1676f@suse.cz>
Date: Thu, 5 Jun 2025 15:34:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for
 users
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 david@redhat.com, shakeel.butt@linux.dev
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, donettom@linux.ibm.com,
 aboorvad@linux.ibm.com, sj@kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
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
In-Reply-To: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 6/5/25 14:58, Baolin Wang wrote:
> On some large machines with a high number of CPUs running a 64K pagesize
> kernel, we found that the 'RES' field is always 0 displayed by the top
> command for some processes, which will cause a lot of confusion for users.
> 
>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>  875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
>       1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
> 
> The main reason is that the batch size of the percpu counter is quite large
> on these machines, caching a significant percpu value, since converting mm's
> rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> stats into percpu_counter"). Intuitively, the batch number should be optimized,
> but on some paths, performance may take precedence over statistical accuracy.
> Therefore, introducing a new interface to add the percpu statistical count
> and display it to users, which can remove the confusion. In addition, this
> change is not expected to be on a performance-critical path, so the modification
> should be acceptable.
> 
> In addition, the 'mm->rss_stat' is updated by using add_mm_counter() and
> dec/inc_mm_counter(), which are all wrappers around percpu_counter_add_batch().
> In percpu_counter_add_batch(), there is percpu batch caching to avoid 'fbc->lock'
> contention. This patch changes task_mem() and task_statm() to get the accurate
> mm counters under the 'fbc->lock', but this should not exacerbate kernel
> 'mm->rss_stat' lock contention due to the percpu batch caching of the mm
> counters. The following test also confirm the theoretical analysis.
> 
> I run the stress-ng that stresses anon page faults in 32 threads on my 32 cores
> machine, while simultaneously running a script that starts 32 threads to
> busy-loop pread each stress-ng thread's /proc/pid/status interface. From the
> following data, I did not observe any obvious impact of this patch on the
> stress-ng tests.
> 
> w/o patch:
> stress-ng: info:  [6848]          4,399,219,085,152 CPU Cycles          67.327 B/sec
> stress-ng: info:  [6848]          1,616,524,844,832 Instructions          24.740 B/sec (0.367 instr. per cycle)
> stress-ng: info:  [6848]          39,529,792 Page Faults Total           0.605 M/sec
> stress-ng: info:  [6848]          39,529,792 Page Faults Minor           0.605 M/sec
> 
> w/patch:
> stress-ng: info:  [2485]          4,462,440,381,856 CPU Cycles          68.382 B/sec
> stress-ng: info:  [2485]          1,615,101,503,296 Instructions          24.750 B/sec (0.362 instr. per cycle)
> stress-ng: info:  [2485]          39,439,232 Page Faults Total           0.604 M/sec
> stress-ng: info:  [2485]          39,439,232 Page Faults Minor           0.604 M/sec
> 
> Tested-by Donet Tom <donettom@linux.ibm.com>
> Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: SeongJae Park <sj@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!


