Return-Path: <linux-fsdevel+bounces-12935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F83868D03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6BC1F26703
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809FF1384A7;
	Tue, 27 Feb 2024 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRedWJGW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+/QSkK3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NRedWJGW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+/QSkK3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65CC13849B;
	Tue, 27 Feb 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028641; cv=none; b=YONM83Sc8zHYE7Bg18FwMkH/G+1U3Z9kBb2lb/1sZ3JHzfGK30/tQkbexZsSEEgawVZJRU9+ZuXzcs2Nq6QOWvqOXqfHCEDBd9FlSRGtrLwO8uEmMYNxVRZrpXkixrcxuBPrNrvQ7U+yqVKBVubv434IRpOey2R4hQNR7K+Bnp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028641; c=relaxed/simple;
	bh=VQHSHypsOyUlToKSGwX981PQhnoVA0nj7us2KWCSvhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCGQ9vLHfx8RnCOJM95eCODJm2WgiPilLyz22nTtwVomr082WNPhx1HP1ncZ1Bv8fjfMJlmzCmXQYVpL49Me6NpETOKNsJN8Q0fHwlok5eUUr8NXvmPEWrTBX4o6UokDJzIHmMlqKBrvPv9/FoKIdKRr2i308NEVuVAuxVb8NV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRedWJGW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+/QSkK3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NRedWJGW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+/QSkK3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17BA51F44B;
	Tue, 27 Feb 2024 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709028637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEOHXhvS8pNNR8cMkMn4kxWIAkdQZXWg7A8CfENtHNM=;
	b=NRedWJGWFJAzS4CF9XfB57BUXiZSr9fEXG3UaVYrK7xsNu9pEhas+AzGoOmwiJ77C1wImX
	kLyqCZ8d+8Yo33VjpFS80gV7XGEK+1P6f67+trArChPhuARyJPllr3DLQyxyYgDJqROG88
	Pmf6er2yd2NHZ13r227E0w8m/yXHxl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709028637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEOHXhvS8pNNR8cMkMn4kxWIAkdQZXWg7A8CfENtHNM=;
	b=Y+/QSkK3bbZGf2h9qJvYuXM14gfjsGEokixautIm4GXz0UWCxl/8P4rw1sRb4CgSZY+ris
	hsSzhESQYkk+LnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709028637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEOHXhvS8pNNR8cMkMn4kxWIAkdQZXWg7A8CfENtHNM=;
	b=NRedWJGWFJAzS4CF9XfB57BUXiZSr9fEXG3UaVYrK7xsNu9pEhas+AzGoOmwiJ77C1wImX
	kLyqCZ8d+8Yo33VjpFS80gV7XGEK+1P6f67+trArChPhuARyJPllr3DLQyxyYgDJqROG88
	Pmf6er2yd2NHZ13r227E0w8m/yXHxl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709028637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VEOHXhvS8pNNR8cMkMn4kxWIAkdQZXWg7A8CfENtHNM=;
	b=Y+/QSkK3bbZGf2h9qJvYuXM14gfjsGEokixautIm4GXz0UWCxl/8P4rw1sRb4CgSZY+ris
	hsSzhESQYkk+LnBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF8CA13A65;
	Tue, 27 Feb 2024 10:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TYO6NRu13WUkfAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 27 Feb 2024 10:10:35 +0000
Message-ID: <2daf5f5a-401a-4ef7-8193-6dca4c064ea0@suse.cz>
Date: Tue, 27 Feb 2024 11:11:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/36] mm: create new codetag references during page
 splitting
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, mgorman@suse.de, dave@stgolabs.net,
 willy@infradead.org, liam.howlett@oracle.com,
 penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com,
 peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com,
 will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com,
 david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
 nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev,
 rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com,
 yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com,
 hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org,
 ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org,
 ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
 iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
 elver@google.com, dvyukov@google.com, shakeelb@google.com,
 songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
 minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org
References: <20240221194052.927623-1-surenb@google.com>
 <20240221194052.927623-20-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20240221194052.927623-20-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_GT_50(0.00)[74];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linux.dev,suse.com,cmpxchg.org,suse.de,stgolabs.net,infradead.org,oracle.com,i-love.sakura.ne.jp,lwn.net,manifault.com,redhat.com,arm.com,kernel.org,arndb.de,linutronix.de,linux.intel.com,kernel.dk,soleen.com,google.com,gmail.com,chromium.org,linuxfoundation.org,linaro.org,goodmis.org,linux.com,lge.com,bytedance.com,akamai.com,android.com,vger.kernel.org,lists.linux.dev,kvack.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.59

On 2/21/24 20:40, Suren Baghdasaryan wrote:
> When a high-order page is split into smaller ones, each newly split
> page should get its codetag. The original codetag is reused for these
> pages but it's recorded as 0-byte allocation because original codetag
> already accounts for the original high-order allocated page.

This was v3 but then you refactored (for the better) so the commit log
could reflect it?

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

I was going to R-b, but now I recalled the trickiness of
__free_pages() for non-compound pages if it loses the race to a
speculative reference. Will the codetag handling work fine there?

> ---
>  include/linux/pgalloc_tag.h | 30 ++++++++++++++++++++++++++++++
>  mm/huge_memory.c            |  2 ++
>  mm/page_alloc.c             |  2 ++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
> index b49ab955300f..9e6ad8e0e4aa 100644
> --- a/include/linux/pgalloc_tag.h
> +++ b/include/linux/pgalloc_tag.h
> @@ -67,11 +67,41 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int order)
>  	}
>  }
>  
> +static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
> +{
> +	int i;
> +	struct page_ext *page_ext;
> +	union codetag_ref *ref;
> +	struct alloc_tag *tag;
> +
> +	if (!mem_alloc_profiling_enabled())
> +		return;
> +
> +	page_ext = page_ext_get(page);
> +	if (unlikely(!page_ext))
> +		return;
> +
> +	ref = codetag_ref_from_page_ext(page_ext);
> +	if (!ref->ct)
> +		goto out;
> +
> +	tag = ct_to_alloc_tag(ref->ct);
> +	page_ext = page_ext_next(page_ext);
> +	for (i = 1; i < nr; i++) {
> +		/* Set new reference to point to the original tag */
> +		alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), tag);
> +		page_ext = page_ext_next(page_ext);
> +	}
> +out:
> +	page_ext_put(page_ext);
> +}
> +
>  #else /* CONFIG_MEM_ALLOC_PROFILING */
>  
>  static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
>  				   unsigned int order) {}
>  static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
> +static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
>  
>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
>  
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 94c958f7ebb5..86daae671319 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -38,6 +38,7 @@
>  #include <linux/sched/sysctl.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/compat.h>
> +#include <linux/pgalloc_tag.h>
>  
>  #include <asm/tlb.h>
>  #include <asm/pgalloc.h>
> @@ -2899,6 +2900,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>  	/* Caller disabled irqs, so they are still disabled here */
>  
>  	split_page_owner(head, nr);
> +	pgalloc_tag_split(head, nr);
>  
>  	/* See comment in __split_huge_page_tail() */
>  	if (PageAnon(head)) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 58c0e8b948a4..4bc5b4720fee 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2621,6 +2621,7 @@ void split_page(struct page *page, unsigned int order)
>  	for (i = 1; i < (1 << order); i++)
>  		set_page_refcounted(page + i);
>  	split_page_owner(page, 1 << order);
> +	pgalloc_tag_split(page, 1 << order);
>  	split_page_memcg(page, 1 << order);
>  }
>  EXPORT_SYMBOL_GPL(split_page);
> @@ -4806,6 +4807,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
>  		struct page *last = page + nr;
>  
>  		split_page_owner(page, 1 << order);
> +		pgalloc_tag_split(page, 1 << order);
>  		split_page_memcg(page, 1 << order);
>  		while (page < --last)
>  			set_page_refcounted(last);

