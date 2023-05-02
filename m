Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87F6F4933
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 19:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjEBRjP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 13:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjEBRjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 13:39:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA5115
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683049114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v8fHR5fGdOr3tzI1vnMcnzbjMrPGTX3k27WoHFiXGI0=;
        b=MqRp4fGxemQDpSYW8ZnRj5pjbq/lTY7dFQdndrR/s80rWDUIGiVkAcsryJH3lOx7Cgouft
        0n4PGwhvFwl0E6h/VE7YPqvm6dNPt3KsKiqhFqrJfjMPXMTexSPfU+GtLEAXgT+RPcWWSc
        N+33t9riWLhrg216Q2RPQ5u272AjR68=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-9sztXUbvNgWccfZiHpZM9w-1; Tue, 02 May 2023 13:38:31 -0400
X-MC-Unique: 9sztXUbvNgWccfZiHpZM9w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f195129aa4so25149115e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 10:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683049110; x=1685641110;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8fHR5fGdOr3tzI1vnMcnzbjMrPGTX3k27WoHFiXGI0=;
        b=EFz6wzu7Ohv9ZoHnILlNyJ6p0LRenQ8mzlqQz8vDtZEMgucnMnVlxE1I9RkyHP9+dH
         Lge3Uiv6BBWKlditVYMk6awAqNugIR6ZdogN/aEjH428ef+El7/B6Gp7YN67Dn8vmE7s
         dTQ6SjFjOoLF+3u6v1GrZipU7Tk04KuqmHenwBPGhFT9smOlx5HZ/PjoSkO0T9QhFUQK
         IDdeRa3Fy4gwN7SPstV43q9nhMtF4DtaLLqbdSsL7sF3MZEg+h9oTX9RR//wLOR2ohQX
         C0IB5xP89Zkr6/9PGx5HaTqPsc9BByNh+PCKAIbDfikxWeMxHci2E+GlYSaxI5nPDfDF
         tUuA==
X-Gm-Message-State: AC+VfDwj3lK6lxoRQu48DX2yvIgMTFVXGqzPQ2yJQ0YjkU3BIfrBbxDt
        caqtcLaFLpxMsG8CfG+V1OTBIatsX8aoKNLyL706/DzUkd32YkYfTP8m4ya5J7JHQVCdFa56ZAS
        V0J4tJBcLtr8GAB3a/XQyqYbkFQ==
X-Received: by 2002:adf:f5c2:0:b0:2c9:e585:84b0 with SMTP id k2-20020adff5c2000000b002c9e58584b0mr12006537wrp.1.1683049110606;
        Tue, 02 May 2023 10:38:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6UHQZmPjIHoSHGB9u6827k6gGO+sy+BGJNzulnCYxHPhBnThYPQpbu7NtdcVnWP3Er6P987w==
X-Received: by 2002:adf:f5c2:0:b0:2c9:e585:84b0 with SMTP id k2-20020adff5c2000000b002c9e58584b0mr12006525wrp.1.1683049110163;
        Tue, 02 May 2023 10:38:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id l7-20020a5d4bc7000000b002fefe2edb72sm31513852wrt.17.2023.05.02.10.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 10:38:29 -0700 (PDT)
Message-ID: <6f17af6b-0925-12bd-5041-14462dab2768@redhat.com>
Date:   Tue, 2 May 2023 19:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <cover.1683044162.git.lstoakes@gmail.com>
 <b3a4441cade9770e00d24f5ecb75c8f4481785a4.1683044162.git.lstoakes@gmail.com>
 <1691115d-dba4-636b-d736-6a20359a67c3@redhat.com>
 <392debc7-2de8-440e-8b26-20f2d42cdf8d@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <392debc7-2de8-440e-8b26-20f2d42cdf8d@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.05.23 19:31, Lorenzo Stoakes wrote:
> On Tue, May 02, 2023 at 07:13:49PM +0200, David Hildenbrand wrote:
>> [...]
>>
>>> +{
>>> +	struct address_space *mapping;
>>> +
>>> +	/*
>>> +	 * GUP-fast disables IRQs - this prevents IPIs from causing page tables
>>> +	 * to disappear from under us, as well as preventing RCU grace periods
>>> +	 * from making progress (i.e. implying rcu_read_lock()).
>>> +	 *
>>> +	 * This means we can rely on the folio remaining stable for all
>>> +	 * architectures, both those that set CONFIG_MMU_GATHER_RCU_TABLE_FREE
>>> +	 * and those that do not.
>>> +	 *
>>> +	 * We get the added benefit that given inodes, and thus address_space,
>>> +	 * objects are RCU freed, we can rely on the mapping remaining stable
>>> +	 * here with no risk of a truncation or similar race.
>>> +	 */
>>> +	lockdep_assert_irqs_disabled();
>>> +
>>> +	/*
>>> +	 * If no mapping can be found, this implies an anonymous or otherwise
>>> +	 * non-file backed folio so in this instance we permit the pin.
>>> +	 *
>>> +	 * shmem and hugetlb mappings do not require dirty-tracking so we
>>> +	 * explicitly whitelist these.
>>> +	 *
>>> +	 * Other non dirty-tracked folios will be picked up on the slow path.
>>> +	 */
>>> +	mapping = folio_mapping(folio);
>>> +	return !mapping || shmem_mapping(mapping) || folio_test_hugetlb(folio);
>>
>> "Folios in the swap cache return the swap mapping" -- you might disallow
>> pinning anonymous pages that are in the swap cache.
>>
>> I recall that there are corner cases where we can end up with an anon page
>> that's mapped writable but still in the swap cache ... so you'd fallback to
>> the GUP slow path (acceptable for these corner cases, I guess), however
>> especially the comment is a bit misleading then.
> 
> How could that happen?
> 
>>
>> So I'd suggest not dropping the folio_test_anon() check, or open-coding it
>> ... which will make this piece of code most certainly easier to get when
>> staring at folio_mapping(). Or to spell it out in the comment (usually I
>> prefer code over comments).
> 
> I literally made this change based on your suggestion :) but perhaps I
> misinterpreted what you meant.
> 
> I do spell it out in the comment that the page can be anonymous, But perhaps
> explicitly checking the mapping flags is the way to go.
> 
>>
>>> +}
>>> +
>>>    /**
>>>     * try_grab_folio() - Attempt to get or pin a folio.
>>>     * @page:  pointer to page to be grabbed
>>> @@ -123,6 +170,8 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
>>>     */
>>>    struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>>>    {
>>> +	bool is_longterm = flags & FOLL_LONGTERM;
>>> +
>>>    	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
>>>    		return NULL;
>>> @@ -136,8 +185,7 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>>>    		 * right zone, so fail and let the caller fall back to the slow
>>>    		 * path.
>>>    		 */
>>> -		if (unlikely((flags & FOLL_LONGTERM) &&
>>> -			     !is_longterm_pinnable_page(page)))
>>> +		if (unlikely(is_longterm && !is_longterm_pinnable_page(page)))
>>>    			return NULL;
>>>    		/*
>>> @@ -148,6 +196,16 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>>>    		if (!folio)
>>>    			return NULL;
>>> +		/*
>>> +		 * Can this folio be safely pinned? We need to perform this
>>> +		 * check after the folio is stabilised.
>>> +		 */
>>> +		if ((flags & FOLL_WRITE) && is_longterm &&
>>> +		    !folio_longterm_write_pin_allowed(folio)) {
>>> +			folio_put_refs(folio, refs);
>>> +			return NULL;
>>> +		}
>>
>> So we perform this change before validating whether the PTE changed.
>>
>> Hmm, naturally, I would have done it afterwards.
>>
>> IIRC, without IPI syncs during TLB flush (i.e.,
>> CONFIG_MMU_GATHER_RCU_TABLE_FREE), there is the possibility that
>> (1) We lookup the pte
>> (2) The page was unmapped and free
>> (3) The page gets reallocated and used
>> (4) We pin the page
>> (5) We dereference page->mapping
> 
> But we have an implied RCU lock from disabled IRQs right? Unless that CONFIG
> option does something odd (I've not really dug into its brehaviour). It feels
> like that would break GUP-fast as a whole.
> 
>>
>> If we then de-reference page->mapping that gets used by whoever allocated it
>> for something completely different (not a pointer to something reasonable),
>> I wonder if we might be in trouble.
>>
>> Checking first, whether the PTE changed makes sure that what we pinned and
>> what we're looking at is what we expected.
>>
>> ... I can spot that the page_is_secretmem() check is also done before that.
>> But it at least makes sure that it's still an LRU page before staring at the
>> mapping (making it a little safer?).
> 
> As do we :)
> 
> We also via try_get_folio() check to ensure that we aren't subject to a split.
> 
>>
>> BUT, I keep messing up this part of the story. Maybe it all works as
>> expected because we will be synchronizing RCU somehow before actually
>> freeing the page in the !IPI case. ... but I think that's only true for page
>> tables with CONFIG_MMU_GATHER_RCU_TABLE_FREE.
> 
> My understanding based on what Peter said is that the IRQs being disabled should
> prevent anything bad from happening here.


... only if we verified that the PTE didn't change IIUC. IRQs disabled 
only protect you from the mapping getting freed and reused (because 
mappings are freed via RCU IIUC).

But as far as I can tell, it doesn't protect you from the page itself 
getting freed and reused, and whoever freed the page uses page->mapping 
to store something completely different.

But, again, it's all complicated and confusing to me.


page_is_secretmem() also doesn't use a READ_ONCE() ...

-- 
Thanks,

David / dhildenb

