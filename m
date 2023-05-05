Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104A66F84BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 16:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjEEOSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 10:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjEEOSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 10:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF314373
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683296265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P1oCIf84RG7+6O7buoOZWskEuD34mndm17BNvxGm8Ys=;
        b=MmhWQgxcTeSGfLuCMdymkGT+sBZD8oJ/8es0HsuRqMJNWtWRHDB7akKtd58If3E7+uxXon
        dQNeiMm2vO83lBfeaF8tSliLxd17yJEuMefULKXZhE7VGcpUdO5v/vd5whKxwYBnBJRQOS
        g3K/qhXyT/XpjxhRJ/Dk39eydayKixQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-qUZ1DbLfOISw0E1Jxli96g-1; Fri, 05 May 2023 10:17:43 -0400
X-MC-Unique: qUZ1DbLfOISw0E1Jxli96g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f32b3835e9so7389535e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 07:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683296262; x=1685888262;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1oCIf84RG7+6O7buoOZWskEuD34mndm17BNvxGm8Ys=;
        b=lSbCIqOaaOC3lgxDMCp6bPPOUdhDij2d2/qhdGc7nYW7wpDwpzcB/h88YyZoRuLBxR
         kKjVsVrA1aqpUpXX5byEPXbs73pmdxfiJmInaULJ9bHyNSUGLORV+noli3cV4YQXFOJy
         kCqe3gvSuEm2Myn96WspohzsMqu0aIsaGQ9CEup95nUJI6BsCpyamQSMh/yFxLcY1L4v
         ivUaZgCzuBJAsZ7nVNFZlDHWHaEPJF1Jlw6SEhxqsD3JTtEyw0UdUHOKQEyd/Z9vZG0E
         jAbwiGkohgyrN73PTp5qL6NVxTrVgzRqgI2UDLiMtTXQbe15hZBkt82GcV6WW/pbTIlM
         D1sw==
X-Gm-Message-State: AC+VfDyxcukWQqf34pYn0LPhy0vJNJab5vR/gHRTJefzFuUYzqh2dxmx
        YBUPAzS5ArVs6wp5txzc2O0DIzM3CTNJsAxvqpna5+Gv7sYLE/8EnpG85ZBmACuE3958MjztdAW
        H6VyOkK++ArMPVEKQLNGZVELsXA==
X-Received: by 2002:adf:e948:0:b0:2fb:87f7:3812 with SMTP id m8-20020adfe948000000b002fb87f73812mr1224210wrn.1.1683296261853;
        Fri, 05 May 2023 07:17:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TcJqqd654Tk6HhTBKZ1iWhCqzdn+unDXZ1fRotGzitSWjcybH0sIfqEWc/QeEZR4qCpa8LQ==
X-Received: by 2002:adf:e948:0:b0:2fb:87f7:3812 with SMTP id m8-20020adfe948000000b002fb87f73812mr1224169wrn.1.1683296261426;
        Fri, 05 May 2023 07:17:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71f:6900:2b25:fc69:599e:3986? (p200300cbc71f69002b25fc69599e3986.dip0.t-ipconnect.de. [2003:cb:c71f:6900:2b25:fc69:599e:3986])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b0030631dcbea6sm2548971wrz.77.2023.05.05.07.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 07:17:40 -0700 (PDT)
Message-ID: <ae9a1134-4f5b-4c26-6822-adff838c8702@redhat.com>
Date:   Fri, 5 May 2023 16:17:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <cover.1683067198.git.lstoakes@gmail.com>
 <a690186fc37e1ea92556a7dbd0887fe201fcc709.1683067198.git.lstoakes@gmail.com>
 <e4c92510-9756-d9a1-0055-4cd64a0c76d9@redhat.com>
 <c2a6311c-7fdc-4d12-9a3f-d2eed954c468@lucifer.local>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 3/3] mm/gup: disallow FOLL_LONGTERM GUP-fast writing to
 file-backed mappings
In-Reply-To: <c2a6311c-7fdc-4d12-9a3f-d2eed954c468@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> And there is nothing wrong about pinning an anon page that's still in the
>> swapcache. The following folio_test_anon() check will allow them.
>>
>> The check made sense in page_mapping(), but here it's not required.
> 
> Waaaaaaaaaait a second, you were saying before:-
> 
>    "Folios in the swap cache return the swap mapping" -- you might disallow
>    pinning anonymous pages that are in the swap cache.
> 
>    I recall that there are corner cases where we can end up with an anon
>    page that's mapped writable but still in the swap cache ... so you'd
>    fallback to the GUP slow path (acceptable for these corner cases, I
>    guess), however especially the comment is a bit misleading then.
> 
> So are we allowing or disallowing pinning anon swap cache pages? :P

If we have an exclusive anon page that's still in the swap cache, sure! :)

I think there are ways that can be done, and nothing would actually 
break. (I even wrote selftests in the cow selftests for that to amke 
sure it works as expected)

> 
> I mean slow path would allow them if they are just marked anon so I'm inclined
> to allow them.

Exactly my reasoning.

The less checks the better (especially if ordinary GUP just allows for 
pinning it) :)

> 
>>
>> I do agree regarding folio_test_slab(), though. Should we WARN in case we
>> would have one?
>>
>> if (WARN_ON_ONCE(folio_test_slab(folio)))
>> 	return false;
>>
> 
> God help us if we have a slab page at this point, so agreed worth doing, it
> would surely have to arise from some dreadful bug/memory corruption.
> 

Or some nasty race condition that we managed to ignore with rechecking 
if the PTEs/PMDs changed :)

>>> +	if (unlikely(folio_test_slab(folio) || folio_test_swapcache(folio)))
>>> +		return false;
>>> +
>>> +	/* hugetlb mappings do not require dirty-tracking. */
>>> +	if (folio_test_hugetlb(folio))
>>> +		return true;
>>> +
>>> +	/*
>>> +	 * GUP-fast disables IRQs. When IRQS are disabled, RCU grace periods
>>> +	 * cannot proceed, which means no actions performed under RCU can
>>> +	 * proceed either.
>>> +	 *
>>> +	 * inodes and thus their mappings are freed under RCU, which means the
>>> +	 * mapping cannot be freed beneath us and thus we can safely dereference
>>> +	 * it.
>>> +	 */
>>> +	lockdep_assert_irqs_disabled();
>>> +
>>> +	/*
>>> +	 * However, there may be operations which _alter_ the mapping, so ensure
>>> +	 * we read it once and only once.
>>> +	 */
>>> +	mapping = READ_ONCE(folio->mapping);
>>> +
>>> +	/*
>>> +	 * The mapping may have been truncated, in any case we cannot determine
>>> +	 * if this mapping is safe - fall back to slow path to determine how to
>>> +	 * proceed.
>>> +	 */
>>> +	if (!mapping)
>>> +		return false;
>>> +
>>> +	/* Anonymous folios are fine, other non-file backed cases are not. */
>>> +	mapping_flags = (unsigned long)mapping & PAGE_MAPPING_FLAGS;
>>> +	if (mapping_flags)
>>> +		return mapping_flags == PAGE_MAPPING_ANON;
>>
>> KSM pages are also (shared) anonymous folios, and that check would fail --
>> which is ok (the following unsharing checks rejects long-term pinning them),
>> but a bit inconstent with your comment and folio_test_anon().
>>
>> It would be more consistent (with your comment and also the folio_test_anon
>> implementation) to have here:
>>
>> 	return mapping_flags & PAGE_MAPPING_ANON;
>>
> 
> I explicitly excluded KSM out of fear that could be some breakage given they're
> wrprotect'd + expected to CoW though? But I guess you mean they'd get picked up
> by the unshare and so it doesn't matter + we wouldn't want to exclude an
> PG_anon_exclusive case?

Yes, unsharing handles that in the ordinary GUP and GUP-fast case. And 
unsharing is neither GUP-fast nor even longterm specific (for anon pages).

Reason I'm brining this up is that I think it's best if we let 
folio_fast_pin_allowed() just check for what's absolutely GUP-fast specific.

> 
> I'll make the change in any case given the unshare check!
> 
> I notice the gup_huge_pgd() doesn't do an unshare but I mean, a PGD-sized huge
> page probably isn't going to be CoW'd :P

I spotted exactly the same thing and wondered about that (after all I 
added all that unsharing logic ... so I should know). I'm sure there 
must be a reason I didn't add it ;)

... probably we should just add it even though it might essentially be 
dead code for now (at least the cow selftests would try with each and 
every hugetlb size and eventually reveal the problem on whatever arch 
ends up using that code ... ).

Do you want to send a patch to add unsharing to gup_huge_pgd() as well?

-- 
Thanks,

David / dhildenb

