Return-Path: <linux-fsdevel+bounces-50998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0979BAD1A17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 10:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B94188CA3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 08:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6A24DD11;
	Mon,  9 Jun 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gx7p5hts";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YraVW2OW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKSd75Vr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebUw0FwS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012919F11F
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 08:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749459354; cv=none; b=jl2sUQ2CbAHuAHoZEpk/IVObXPQ6NuZBY48+WP1umcM+68xBM98GrCRs2ntJBEHn9cvDz8KEaFVzeY4L9CaZ/I1ZiQdYoN4LwRazRZeiBW4M0betDyfku/5uKcNfy3t3iU8EtNtWkW64/gngObc9NSLUWL5tpDCZwA5iKt/JPEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749459354; c=relaxed/simple;
	bh=aUc3V74DsYY/wg9EW9IlXVkzvYiyhMat0xQ5xqEpj8w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LUVyKHfQ6ljWokAHg4eqWE/0Z4r3bHRz7Nr3q4zzD2PUpUoXPSLeK3GQU84APZC9ffRPB8kY6X6qRS2+/SJI/0KhvKItnczWIxGBYLLV5V9S0XUP3ydX0uTJzHdCk65FZ4hImtSaFx1tQaGPMXRuLpIEZJ6ErcmBR5jWUPI3GLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gx7p5hts; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YraVW2OW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKSd75Vr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ebUw0FwS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 714C91F38F;
	Mon,  9 Jun 2025 08:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749459351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POPSOPzrV5qDs0CuEEXX+nlfWZQ+0FpSQoAuUPO/QYY=;
	b=gx7p5htsrl2nXhWao3a9HIpG+6OXhe4qWUv5PPCJ+cfxVC95Iy5wMBqOFLYPW2ZUsQLarF
	eDNpe+laaVC84sD2hMb0ESUKVKQe5tuorHbmvtqIJaEADDJVoa3oo+YQBfZ5fFohiMPNRM
	eazJxhGelgoDPpIC3Ubcwf4T5nGzWBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749459351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POPSOPzrV5qDs0CuEEXX+nlfWZQ+0FpSQoAuUPO/QYY=;
	b=YraVW2OWrUg0QckwZh5RlASWqKJJm4MxA8pLGmlUkCyh2z7nDmKVrzN0yYkHbZdR7B6TP0
	+JD0zVUIQ/2rJLCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OKSd75Vr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ebUw0FwS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749459350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POPSOPzrV5qDs0CuEEXX+nlfWZQ+0FpSQoAuUPO/QYY=;
	b=OKSd75Vr1EACIUTiRUGWQOchoYdNyKRTKqtzCp2HcXbzJoTE4mK+4J2fKhGmyvlzlr8D8l
	Dis2590aE99+eE4agLcnb5qyRezQMaNkx8XOhmOB7bSxbHnBL7r+qfiI0ry2HyHB54WmG5
	rVEvbHd53JDROz0Y1Sz52tdtdslxUi8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749459350;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POPSOPzrV5qDs0CuEEXX+nlfWZQ+0FpSQoAuUPO/QYY=;
	b=ebUw0FwS4iKYML+FLtQgrXiREdgnnFjVJHyp81w6fRfYBpDg1h2blt8+3CtINUHoPME0V9
	LRT1J3oFHmCC63Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48CF8137FE;
	Mon,  9 Jun 2025 08:55:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TC1jEZahRmioEQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 09 Jun 2025 08:55:50 +0000
Message-ID: <06d9981e-4a4a-4b99-9418-9dec0a3420e8@suse.cz>
Date: Mon, 9 Jun 2025 10:56:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for
 users
From: Vlastimil Babka <vbabka@suse.cz>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, david@redhat.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
 sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
 <87bjqx4h82.fsf@gmail.com> <aEaOzpQElnG2I3Tz@tiehlicka>
 <890b825e-b3b1-4d32-83ec-662495e35023@linux.alibaba.com>
 <87a56h48ow.fsf@gmail.com> <4c113d58-c858-4ef8-a7f1-bae05c293edf@suse.cz>
Content-Language: en-US
In-Reply-To: <4c113d58-c858-4ef8-a7f1-bae05c293edf@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 714C91F38F
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.alibaba.com,suse.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,alibaba.com:email]
X-Spam-Score: -3.01
X-Spam-Level: 

On 6/9/25 10:52 AM, Vlastimil Babka wrote:
> On 6/9/25 10:31 AM, Ritesh Harjani (IBM) wrote:
>> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
>>
>>> On 2025/6/9 15:35, Michal Hocko wrote:
>>>> On Mon 09-06-25 10:57:41, Ritesh Harjani wrote:
>>>>>
>>>>> Any reason why we dropped the Fixes tag? I see there were a series of
>>>>> discussion on v1 and it got concluded that the fix was correct, then why
>>>>> drop the fixes tag?
>>>>
>>>> This seems more like an improvement than a bug fix.
>>>
>>> Yes. I don't have a strong opinion on this, but we (Alibaba) will 
>>> backport it manually,
>>>
>>> because some of user-space monitoring tools depend 
>>> on these statistics.
>>
>> That sounds like a regression then, isn't it?
> 
> Hm if counters were accurate before f1a7941243c1 and not afterwards, and
> this is making them accurate again, and some userspace depends on it,
> then Fixes: and stable is probably warranted then. If this was just a
> perf improvement, then not. But AFAIU f1a7941243c1 was the perf
> improvement...

Dang, should have re-read the commit log of f1a7941243c1 first. It seems
like the error margin due to batching existed also before f1a7941243c1.

" This patch converts the rss_stats into percpu_counter to convert the
error  margin from (nr_threads * 64) to approximately (nr_cpus ^ 2)."

so if on some systems this means worse margin than before, the above
"if" chain of thought might still hold.

> 
>> -ritesh
> 


