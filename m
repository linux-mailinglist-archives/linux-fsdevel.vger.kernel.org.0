Return-Path: <linux-fsdevel+bounces-45637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B80A7A339
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626DA1698D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 12:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E6C24E4A6;
	Thu,  3 Apr 2025 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQBeFlbO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cBOzrwSD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mQBeFlbO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cBOzrwSD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E424C07E
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685109; cv=none; b=tCX4e0RuWkR926mqe27UZPJjUtGUdm/QP3VsM9TPnuUUyHy+nxZxxSrR4WnxL1QQeCecKuzxZSPjBVrbSMOi0131OKEX1w5wUNusd5lWlfviKP+pk9KyRRuvmzcpl8ShLB467f2UBZl8mBAukfOENfO2KtT8FT7dnywwmETA8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685109; c=relaxed/simple;
	bh=YJrxwX6SFfs1FctQ3iarcffyEmt1jAQpMicHgYZ/ED8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SIBvjRLE/CQeBHTwW7k2kCZFAn0CePfhD53NAvWTBDo5HdjeRbhctBHb7bMN2jmvQMER+UItgsCxx8CSXw89uyP0bew84qBpkC4hO6JTPAhRIgUWpGD5FwmL//vC/9zIiFz/rJ/JsGP+m0EsQuehiMMRO37b8fiTb8pghoT7GhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQBeFlbO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cBOzrwSD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mQBeFlbO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cBOzrwSD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B4B662118C;
	Thu,  3 Apr 2025 12:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743685105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/JpmK1FdMpopONKIgxvs2nUGf/kiuG8cftum9/rbTw=;
	b=mQBeFlbO0R64kIkWZURZFc1++nuu+xm86PIKvFrsrKJWb4/0sQnzjRUb6ZSOn0B6i1R6oJ
	8fOf0xRatXrHPZ6PAx4p99ubb1ZSeSDfSdQiyqlghN0aNTMoBMm2YNUL79D6UBca3wW7Sr
	g5SkRX8wYcGFM91npkZyNGvYO2uBWmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743685105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/JpmK1FdMpopONKIgxvs2nUGf/kiuG8cftum9/rbTw=;
	b=cBOzrwSDMbzdP3XWIlI/qBXRIaBz/HKo63HmDkWRvJZw9XGQYfqiTgTtqWFI920KnGGFCx
	rIMek12jkz6wksDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743685105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/JpmK1FdMpopONKIgxvs2nUGf/kiuG8cftum9/rbTw=;
	b=mQBeFlbO0R64kIkWZURZFc1++nuu+xm86PIKvFrsrKJWb4/0sQnzjRUb6ZSOn0B6i1R6oJ
	8fOf0xRatXrHPZ6PAx4p99ubb1ZSeSDfSdQiyqlghN0aNTMoBMm2YNUL79D6UBca3wW7Sr
	g5SkRX8wYcGFM91npkZyNGvYO2uBWmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743685105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/JpmK1FdMpopONKIgxvs2nUGf/kiuG8cftum9/rbTw=;
	b=cBOzrwSDMbzdP3XWIlI/qBXRIaBz/HKo63HmDkWRvJZw9XGQYfqiTgTtqWFI920KnGGFCx
	rIMek12jkz6wksDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 851EE1392A;
	Thu,  3 Apr 2025 12:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OxrdH/GF7mcDOAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 03 Apr 2025 12:58:25 +0000
Message-ID: <a751498e-0bde-4114-a9f3-9d3c755d8835@suse.cz>
Date: Thu, 3 Apr 2025 14:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux
 kernel v6.13-rc5
Content-Language: en-US
To: Matt Fleming <matt@readmodwrite.com>, willy@infradead.org
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, luka.2016.cs@gmail.com,
 tytso@mit.edu, Barry Song <baohua@kernel.org>, kernel-team@cloudflare.com,
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
 <20250326105914.3803197-1-matt@readmodwrite.com>
 <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[dilger.ca,linux-foundation.org,vger.kernel.org,kvack.org,gmail.com,mit.edu,kernel.org,cloudflare.com,szeredi.hu,fromorbit.com,bytedance.com,linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,readmodwrite.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 4/3/25 14:29, Matt Fleming wrote:
> On Wed, Mar 26, 2025 at 10:59 AM Matt Fleming <matt@readmodwrite.com> wrote:
>>
>> Hi there,

+ Cc also Michal

>> I'm also seeing this PF_MEMALLOC WARN triggered from kswapd in 6.12.19.

We're talking about __alloc_pages_slowpath() doing WARN_ON_ONCE(current-
>flags & PF_MEMALLOC); for __GFP_NOFAIL allocations.

kswapd() sets:

tsk->flags |= PF_MEMALLOC | PF_KSWAPD;

so any __GFP_NOFAIL allocation done in the kswapd context risks this
warning. It's also objectively bad IMHO because for direct reclaim we can
loop and hope kswapd rescues us, but kswapd would then have to rely on
direct reclaimers to get unstuck. I don't see an easy generic solution?

>> Does overlayfs need some kind of background inode reclaim support?
> 
> Hey everyone, I know there was some off-list discussion last week at
> LSFMM, but I don't think a definite solution has been proposed for the
> below stacktrace.
> 
> What is the shrinker API policy wrt memory allocation and I/O? Should
> overlayfs do something more like XFS and background reclaim to avoid
> GFP_NOFAIL
> allocations when kswapd is shrinking caches?
> 
>>   Call Trace:
>>    <TASK>
>>    __alloc_pages_noprof+0x31c/0x330
>>    alloc_pages_mpol_noprof+0xe3/0x1d0
>>    folio_alloc_noprof+0x5b/0xa0
>>    __filemap_get_folio+0x1f3/0x380
>>    __getblk_slow+0xa3/0x1e0
>>    __ext4_get_inode_loc+0x121/0x4b0
>>    ext4_get_inode_loc+0x40/0xa0
>>    ext4_reserve_inode_write+0x39/0xc0
>>    __ext4_mark_inode_dirty+0x5b/0x220
>>    ext4_evict_inode+0x26d/0x690
>>    evict+0x112/0x2a0
>>    __dentry_kill+0x71/0x180
>>    dput+0xeb/0x1b0
>>    ovl_stack_put+0x2e/0x50 [overlay]
>>    ovl_destroy_inode+0x3a/0x60 [overlay]
>>    destroy_inode+0x3b/0x70
>>    __dentry_kill+0x71/0x180
>>    shrink_dentry_list+0x6b/0xe0
>>    prune_dcache_sb+0x56/0x80
>>    super_cache_scan+0x12c/0x1e0
>>    do_shrink_slab+0x13b/0x350
>>    shrink_slab+0x278/0x3a0
>>    shrink_node+0x328/0x880
>>    balance_pgdat+0x36d/0x740
>>    kswapd+0x1f0/0x380
>>    kthread+0xd2/0x100
>>    ret_from_fork+0x34/0x50
>>    ret_from_fork_asm+0x1a/0x30
>>    </TASK>
> 


