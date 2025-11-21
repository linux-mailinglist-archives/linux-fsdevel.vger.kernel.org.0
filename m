Return-Path: <linux-fsdevel+bounces-69380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F448C7A629
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B33CC33EC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F541F7580;
	Fri, 21 Nov 2025 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HsJFbmrm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S4QLf7ZN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cIl1ktSW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gu959glU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2DC29B8E8
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736659; cv=none; b=IPmEAu7P8YsU/aDg8XL3aXFmCbJlGCXvnDO6Zqu7wmBYgJq3anP6GTzfTt/Vp1i+VHvGzvSSMnxdFbIBIkat03x/FwpncAzdK6UriJXwbEgwZeheV0dnIGgLuGtx6Nn0XaZ8qPPCbnr5wyjizT+ULzzESy+09vU81ECaMF85xZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736659; c=relaxed/simple;
	bh=fwzsonDbk8J6wFL94nWNcpLsv+C2PpZoyG8sZODBzvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTpFcxuQpft0MLvFEDaT67pexmANnT9WP0cHyS0l2iHTrV+4G+9ABjpy8YP3ByhrTRqZZ/9GlIsO0q5ixHReSEAOjcLNmZQChHpx7Ids3DlwKv8jgz24zdLZg0KSJIn7ohlJdTy5fv4xb4ywFoBnfZsATU1dRAEibYDpiY11kPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HsJFbmrm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S4QLf7ZN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cIl1ktSW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gu959glU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B127219F5;
	Fri, 21 Nov 2025 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763736655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jD096lDSsWyQsnreGLMH4BfKdBgmYHYlcXpbNlm/KzM=;
	b=HsJFbmrm/AsLaEUXF37o0BYREKJD65cWa5ZihuTMXP2bgYIGziUGE8qjh0MIN9luwmW0cg
	Uo9poF9DZfle5qx9FITO9bc6eORC/T6qahY/qiA9AZ0MnNdENoEQF6tljvhwZw64MKBUNU
	rDPYVIL0F/Jx7eLwysPt3wric6w5Tkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763736655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jD096lDSsWyQsnreGLMH4BfKdBgmYHYlcXpbNlm/KzM=;
	b=S4QLf7ZNdVp3T541BHZyVEhlgpXqq4zIO11l+gMq/3bjR4oJtdtz2uafbhbMz2Vz77BnQY
	/HR5BgoRrvCEDbCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cIl1ktSW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Gu959glU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763736654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jD096lDSsWyQsnreGLMH4BfKdBgmYHYlcXpbNlm/KzM=;
	b=cIl1ktSWnIaB0CuZXU1OPOiDB3LBt9wLgvVIDQsjMB5JZRysDUu0guO/b/OQEzicm7z+VW
	K/E3wsxjM+l5us4X09QF/WjV5HOPlvaFn2maoWU41o3VGCRiCucE6pvgI2ZMNIiZ2kQPOb
	/ETbLTUGy1Ors8PHPJ0l2wyIwjHK330=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763736654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jD096lDSsWyQsnreGLMH4BfKdBgmYHYlcXpbNlm/KzM=;
	b=Gu959glU82mNif8VuDq28awoOYCkmuPxddGPc/2QZGIN3PuNiZ6GXUqLz1Xdwx74/gSAtx
	c4ox7RPo74HU6ZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE1373EA61;
	Fri, 21 Nov 2025 14:50:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nDQpKk18IGlELAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 21 Nov 2025 14:50:53 +0000
Message-ID: <d01001a5-03b5-4662-8955-bbade1e2f023@suse.cz>
Date: Fri, 21 Nov 2025 15:50:53 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] initial work on making VMA flags a bitmap
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
 Shakeel Butt <shakeel.butt@linux.dev>, David Rientjes <rientjes@google.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
References: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <cover.1763126447.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 3B127219F5
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,suse.de,redhat.com,oracle.com,kernel.org,google.com,suse.com,infradead.org,linaro.org,arm.com,goodmis.org,ziepe.ca,nvidia.com,linux.alibaba.com,zte.com.cn,intel.com,gmail.com,sk.com,gourry.net,surriel.com,huaweicloud.com,tencent.com,cmpxchg.org,bytedance.com,vger.kernel.org,kvack.org,garyguo.net,protonmail.com,umich.edu];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_GT_50(0.00)[70];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Score: -3.01

On 11/14/25 14:26, Lorenzo Stoakes wrote:
> We are in the rather silly situation that we are running out of VMA flags
> as they are currently limited to a system word in size.
> 
> This leads to absurd situations where we limit features to 64-bit
> architectures only because we simply do not have the ability to add a flag
> for 32-bit ones.
> 
> This is very constraining and leads to hacks or, in the worst case, simply
> an inability to implement features we want for entirely arbitrary reasons.
> 
> This also of course gives us something of a Y2K type situation in mm where
> we might eventually exhaust all of the VMA flags even on 64-bit systems.
> 
> This series lays the groundwork for getting away from this limitation by
> establishing VMA flags as a bitmap whose size we can increase in future
> beyond 64 bits if required.
> 
> This is necessarily a highly iterative process given the extensive use of
> VMA flags throughout the kernel, so we start by performing basic steps.
> 
> Firstly, we declare VMA flags by bit number rather than by value, retaining
> the VM_xxx fields but in terms of these newly introduced VMA_xxx_BIT
> fields.
> 
> While we are here, we use sparse annotations to ensure that, when dealing
> with VMA bit number parameters, we cannot be passed values which are not
> declared as such - providing some useful type safety.
> 
> We then introduce an opaque VMA flag type, much like the opaque mm_struct
> flag type introduced in commit bb6525f2f8c4 ("mm: add bitmap mm->flags
> field"), which we establish in union with vma->vm_flags (but still set at
> system word size meaning there is no functional or data type size change).
> 
> We update the vm_flags_xxx() helpers to use this new bitmap, introducing
> sensible helpers to do so.
> 
> This series lays the foundation for further work to expand the use of
> bitmap VMA flags and eventually eliminate these arbitrary restrictions.
> 
> 
> v2:
> * Corrected kdoc for vma_flag_t.
> * Introduced DECLARE_VMA_BIT() as per Jason. We can't also declare the VMA
>   flags in the enum as this breaks assumptions in the kernel, resulting in
>   errors like 'enum constant in boolean context
>   [-Werror=int-in-bool-context]'.
> * Dropped the conversion patch - To make life simpler this cycle, let's just
>   fixup the flag declarations and introduce the new field type and introduce
>   vm_flags_*() changes. We can do more later.
> * Split out VMA testing vma->__vm_flags change.
> * Fixed vma_flag_*_atomic() helper functions for sparse purposes to work
>   with vma_flag_t.
> * Fixed rust breakages as reported by Nico and help provided by Alice. For
>   now we are doing a minimal fix, we can do a more substantial one once the
>   VMA flag helper functions are introduced in an upcoming series.
> 
> v1:
> https://lore.kernel.org/all/cover.1761757731.git.lorenzo.stoakes@oracle.com/
> 
> Lorenzo Stoakes (4):
>   mm: declare VMA flags by bit
>   mm: simplify and rename mm flags function for clarity
>   tools/testing/vma: eliminate dependency on vma->__vm_flags
>   mm: introduce VMA flags bitmap type

Acked-by: Vlastimil Babka <vbabka@suse.cz>

However something has happened to patch 4/4 in git, it has a very different
tools/testing/vma/vma_internal.h:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-stable&id=c3f7c506e8f122a31b9cc01d234e7fcda46b0eca

> 
>  fs/proc/task_mmu.c               |   4 +-
>  include/linux/mm.h               | 400 +++++++++++++++------------
>  include/linux/mm_types.h         |  78 +++++-
>  kernel/fork.c                    |   4 +-
>  mm/khugepaged.c                  |   2 +-
>  mm/madvise.c                     |   2 +-
>  rust/bindings/bindings_helper.h  |  25 ++
>  rust/kernel/mm/virt.rs           |   2 +-
>  tools/testing/vma/vma.c          |  20 +-
>  tools/testing/vma/vma_internal.h | 446 ++++++++++++++++++++++++++-----
>  10 files changed, 716 insertions(+), 267 deletions(-)
> 
> --
> 2.51.0


