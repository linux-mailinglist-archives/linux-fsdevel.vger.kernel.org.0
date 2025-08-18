Return-Path: <linux-fsdevel+bounces-58125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E83B29A6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 09:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0091517B492
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B0C27CCC7;
	Mon, 18 Aug 2025 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m2n5Pn/s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZQBT1OMa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m2n5Pn/s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZQBT1OMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58F9270540
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500271; cv=none; b=h3KXqB7nOMb6ukd6KJo4xtLVWnRpXV4hA7E50mIewzT8D8gmVOevDVHNzYxFtCxKwFrWg/LKDpLdv4AmXf8WzJ/L3rFzMxdA3uxfqo/DJZUNhHy9IOyFc2QdZ2ZxjHNgn+ATB17Oh/CH52mAeb1cDB3+I40HP5lm/fhkA7AT8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500271; c=relaxed/simple;
	bh=lhtFdAMWxFCtq8+vdzMXqqRRrjkfeX7HX1NSCHa8I8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfF41/XbhQobPI5afINfSdeqzukq8fETXlfYL21Ao5W1nbu2fUcreeOCuZxcj4LdG+2v9ZAE7c50jZRSG3nfIz/9zown/wZ3+2C/E5piyqH+N1QjEyH3dRmxZC9ysDObhhdvnfPvryMs0WmoSnV+lWKK3N6CUJwbLt5ZyvFcJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m2n5Pn/s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZQBT1OMa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m2n5Pn/s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZQBT1OMa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40F982122E;
	Mon, 18 Aug 2025 06:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755500268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5NJv+yFL+xt33TWRdS3ak5apbcoiIS+C6qqfQR5hMU=;
	b=m2n5Pn/swRjMcr/BL/mW3Rs9gdfHEjFiJUo43cfx+OPe7St/esbRFm66e8TgvfRnEKJ7AV
	4ti+7xbLf833OrS8+6KIXn2yb2Dvpi1jkrOg0JF7HWXN5qMKo1HML4A/Q9NKLNv7XeMymf
	V0H9V1V7Ayy6aaogQfT8XRfeLKZpd0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755500268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5NJv+yFL+xt33TWRdS3ak5apbcoiIS+C6qqfQR5hMU=;
	b=ZQBT1OMaO/NhRqw9HziHqPbvJRKepl/M6W1RDhf2Lia5W0VeG00Zv3ap7PoxgXWa8+hrOQ
	yyKvhycPlpCD56AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="m2n5Pn/s";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZQBT1OMa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755500268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5NJv+yFL+xt33TWRdS3ak5apbcoiIS+C6qqfQR5hMU=;
	b=m2n5Pn/swRjMcr/BL/mW3Rs9gdfHEjFiJUo43cfx+OPe7St/esbRFm66e8TgvfRnEKJ7AV
	4ti+7xbLf833OrS8+6KIXn2yb2Dvpi1jkrOg0JF7HWXN5qMKo1HML4A/Q9NKLNv7XeMymf
	V0H9V1V7Ayy6aaogQfT8XRfeLKZpd0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755500268;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5NJv+yFL+xt33TWRdS3ak5apbcoiIS+C6qqfQR5hMU=;
	b=ZQBT1OMaO/NhRqw9HziHqPbvJRKepl/M6W1RDhf2Lia5W0VeG00Zv3ap7PoxgXWa8+hrOQ
	yyKvhycPlpCD56AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBEB413686;
	Mon, 18 Aug 2025 06:57:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id awQEMOrOomiqCQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 18 Aug 2025 06:57:46 +0000
Message-ID: <728b9bd5-f423-48cf-a9e0-31270d0b9506@suse.de>
Date: Mon, 18 Aug 2025 08:57:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] add persistent huge zero folio support
To: David Hildenbrand <david@redhat.com>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Vlastimil Babka
 <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org,
 Ritesh Harjani <ritesh.list@gmail.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 mcgrof@kernel.org, gost.dev@samsung.com, hch@lst.de,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20250811084113.647267-1-kernel@pankajraghav.com>
 <hzk7e52sfhfqvo5bh7btthtyyo2tf4rwe24jxtp3fqd62vxo7k@cylwrbxqj47b>
 <dfb01243-7251-444c-8ac6-d76666742aa9@redhat.com>
 <112b4bcd-230a-4482-ae2e-67fa22b3596f@redhat.com>
 <rr6kkjxizlpruc46hjnx72jl5625rsw3mcpkc5h4bvtp3wbmjf@g45yhep3ogjo>
 <b087814e-8bdf-4503-a6ba-213db4263083@lucifer.local>
 <lkwidnuk5qtb65qz5mjkjln7k3hhc6eiixpjmh3a522drfsquu@tizjis7y467s>
 <57bec266-97c4-4292-bd81-93baca737a3c@redhat.com>
 <osippshkfu7ip5tg42zc5nyxegrplm2kekskhitrapzjdyps3h@hodqaqh5r26o>
 <6afa5cab-2044-46fb-9afb-8be82fe8a39f@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6afa5cab-2044-46fb-9afb-8be82fe8a39f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,pankajraghav.com,google.com,arm.com,linux.alibaba.com,suse.cz,nvidia.com,kernel.org,linux.intel.com,suse.com,linux-foundation.org,linutronix.de,redhat.com,kernel.dk,vger.kernel.org,kvack.org,infradead.org,gmail.com,samsung.com,lst.de];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLxigy8pr3gnoabpfzcidubger)];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 40F982122E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

On 8/11/25 12:43, David Hildenbrand wrote:
> On 11.08.25 12:36, Kiryl Shutsemau wrote:
>> On Mon, Aug 11, 2025 at 12:21:23PM +0200, David Hildenbrand wrote:
>>> On 11.08.25 12:17, Kiryl Shutsemau wrote:
>>>> On Mon, Aug 11, 2025 at 11:09:24AM +0100, Lorenzo Stoakes wrote:
>>>>> On Mon, Aug 11, 2025 at 11:07:48AM +0100, Kiryl Shutsemau wrote:
>>>>>>
>>>>>> Well, my worry is that 2M can be a high tax for smaller machines.
>>>>>> Compile-time might be cleaner, but it has downsides.
>>>>>>
>>>>>> It is also not clear if these users actually need physical HZP or 
>>>>>> virtual
>>>>>> is enough. Virtual is cheap.
>>>>>
>>>>> The kernel config flag (default =N) literally says don't use unless 
>>>>> you
>>>>> have plenty of memory :)
>>>>>
>>>>> So this isn't an issue.
>>>>
>>>> Distros use one-config-fits-all approach. Default N doesn't help
>>>> anything.
>>>
>>> You'd probably want a way to say "use the persistent huge zero folio 
>>> if you
>>> machine has more than X Gigs". That's all reasonable stuff that can 
>>> be had
>>> on top of this series.
>>
>> We have 'totalram_pages() < (512 << (20 - PAGE_SHIFT))' check in
>> hugepage_init(). It can [be abstracted out and] re-used.
> 
> I'll note that e.g., RHEL 10 already has a minimum RAM requirement of 2 
> GiB. I think for Fedora it's 1 GiB, with the recommendation of having at 
> least 2 GiB.
> 
> What might be reasonable is having a kconfig option where one (distro) 
> can define the minimum RAM size for the persistent huge zero folio, and 
> then checking against totalram_pages() during boot.
> 
> But again, I think this is something that goes on top of this series. 
> (it might also be interesting to allow for disabling the persistent huge 
> zero folio through a cmdline option)
> 
Please make this a kernel config option and don't rely on heuristics.
They have the nasty habit of doing exactly the wrong thing at places
where you really don't expect them to.
(Consider SoCs with a large CMA area for video grabbing or similar stuff
and very little main memory ...)
A kernel option will give distros and/or admins the flexibility they
need without having to rebuild the kernel and also not having to
worry about heuristics going wrong.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

