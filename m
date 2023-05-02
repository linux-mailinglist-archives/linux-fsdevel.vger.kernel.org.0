Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FD26F47C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 17:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjEBPyY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 11:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjEBPyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 11:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A96110E9
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683042792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2u65LuYPb7QHnSkAdm0mclaHTsGhn661RhJYVq6qWaA=;
        b=TBofuVd9s7MR0muCEh4nOHeSAzY1WukKjh4Hr7Jzgrdl4Ner+tyYU2yCgwdpKwgZb7nNsT
        24aFNH64gS7cK7lLeXkXhFWj5A+xjLJ1nRNgZprsm6rVc8QrP+Bmf1cKbm6m1eF9CJzzNJ
        6wVA4NW9koSMOQHuCvLu0WWAOQ1uMHA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-HKYOs0n1O5ykt6l6PDD3xA-1; Tue, 02 May 2023 11:53:11 -0400
X-MC-Unique: HKYOs0n1O5ykt6l6PDD3xA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f250e9e090so12649655e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 08:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683042790; x=1685634790;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2u65LuYPb7QHnSkAdm0mclaHTsGhn661RhJYVq6qWaA=;
        b=ZIoI6ibZ0lhkabZNV7OjgOt+fmo88fl5Ohh/xfwhjGVgly96/hcfAeGjJdjaGK6uhY
         fjZagBNs5Vct+VJxgbF8KIPBHadi8QHCo3GR8ieX33naLTYuI+r8/V+CGZBP3toLs+f9
         qoPGE9VeFPWODvFU41X7puMJLuCePDXH3PAom3tKAWiwMZ7vgnUOoPXcVi3XaqxgmSZ/
         05Lquqfpjta3skqzUQgbmon16nHw6T8DniSyPIHkCaqa0UIYUTiq3N9HnMuI+jpVDtE5
         1g8W/jtIgcc9v21ldcfrC3v7lwTXbLahuNNqP42qqFlu4Nb6i59rF8hqsPClUa+tVhCr
         oeQw==
X-Gm-Message-State: AC+VfDyYGQyuIwgruv4tpG01hW/yM3qfIsYmwoS3rEahLdNhbf2QQglG
        SX3fZaTI8kIn4ldg/jKANMDiq2FobW3xm+lP0D/acdnBrsxoPOh9f//A/lk6hU8r0njvNxzRh1T
        l25R0Jy0tSPavmC3bBzUPjSCBSw==
X-Received: by 2002:a05:6000:108f:b0:306:379e:d161 with SMTP id y15-20020a056000108f00b00306379ed161mr1871466wrw.5.1683042789937;
        Tue, 02 May 2023 08:53:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gFmAybutFB9eQ9Tbxlz4qEY/FJ8V5M2LIv21wHOxibkY6Uc3HukKMzqNz7cKtw+U3w+TVgw==
X-Received: by 2002:a05:6000:108f:b0:306:379e:d161 with SMTP id y15-20020a056000108f00b00306379ed161mr1871456wrw.5.1683042789546;
        Tue, 02 May 2023 08:53:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:2400:6b79:2aa:9602:7016? (p200300cbc70024006b7902aa96027016.dip0.t-ipconnect.de. [2003:cb:c700:2400:6b79:2aa:9602:7016])
        by smtp.gmail.com with ESMTPSA id t13-20020a7bc3cd000000b003f173c566b5sm35982711wmj.5.2023.05.02.08.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 08:53:09 -0700 (PDT)
Message-ID: <42b80e03-fc72-dfa0-f18d-d6006ea48e76@redhat.com>
Date:   Tue, 2 May 2023 17:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20230428124140.30166-1-jack@suse.cz> <ZFErn2Hl3mWiIudD@x1n>
 <8dba1912-4120-cb3d-6e10-5fc18459e2ac@redhat.com> <ZFEw6DzzZX54z3B/@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZFEw6DzzZX54z3B/@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02.05.23 17:48, Peter Xu wrote:
> On Tue, May 02, 2023 at 05:33:22PM +0200, David Hildenbrand wrote:
>> On 02.05.23 17:26, Peter Xu wrote:
>>> On Fri, Apr 28, 2023 at 02:41:40PM +0200, Jan Kara wrote:
>>>> If the page is pinned, there's no point in trying to reclaim it.
>>>> Furthermore if the page is from the page cache we don't want to reclaim
>>>> fs-private data from the page because the pinning process may be writing
>>>> to the page at any time and reclaiming fs private info on a dirty page
>>>> can upset the filesystem (see link below).
>>>>
>>>> Link: https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
>>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>>> ---
>>>>    mm/vmscan.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> This was the non-controversial part of my series [1] dealing with pinned pages
>>>> in filesystems. It is already a win as it avoids crashes in the filesystem and
>>>> we can drop workarounds for this in ext4. Can we merge it please?
>>>>
>>>> [1] https://lore.kernel.org/all/20230209121046.25360-1-jack@suse.cz/
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index bf3eedf0209c..401a379ea99a 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1901,6 +1901,16 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>>    			}
>>>>    		}
>>>> +		/*
>>>> +		 * Folio is unmapped now so it cannot be newly pinned anymore.
>>>> +		 * No point in trying to reclaim folio if it is pinned.
>>>> +		 * Furthermore we don't want to reclaim underlying fs metadata
>>>> +		 * if the folio is pinned and thus potentially modified by the
>>>> +		 * pinning process as that may upset the filesystem.
>>>> +		 */
>>>> +		if (folio_maybe_dma_pinned(folio))
>>>> +			goto activate_locked;
>>>> +
>>>>    		mapping = folio_mapping(folio);
>>>>    		if (folio_test_dirty(folio)) {
>>>>    			/*
>>>> -- 
>>>> 2.35.3
>>>>
>>>>
>>>
>>> IIUC we have similar handling for anon (feb889fb40fafc).  Should we merge
>>> the two sites and just move the check earlier?  Thanks,
>>>
>>
>> feb889fb40fafc introduced a best-effort check that is racy, as the page is
>> still mapped (can still get pinned). Further, we get false positives most
>> only if a page is shared very often (1024 times), which happens rarely with
>> anon pages. Now that we handle COW+pinning correctly using
>> PageAnonExclusive, that check only optimizes for the "already pinned" case.
>> But it's not required for correctness anymore (so it can be racy).
>>
>> Here, however, we want more precision, and not false positives simply
>> because a page is mapped many times (which can happen easily) or can still
>> get pinned while mapped.
> 
> Ah makes sense, thanks.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> 
> This seems not obvious, though, if we simply read the two commits. It'll be
> great if we mention it somewhere in either comment or commit message on the
> relationship of the two checks.

I once had a patch lying around to document the existing check:

https://github.com/davidhildenbrand/linux/commit/abb01d42a99b56e2c5e707ba80ddc8b05ad7d618

-- 
Thanks,

David / dhildenb

