Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD85719965
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjFAKTR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjFAKSf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E078E49
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 03:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685614464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYR/VkMk/voOznqHepF47pBoY++iUIp7AId3uEofiiU=;
        b=dQ13meQ+T7sQL3wVuwWT2ZUA3kKoLFA6bHqrGSYSSRor7sVCOs7zpdc0jroU60vwMpiHP0
        I1Elb1O7UTu25UN3oShWFT0lKS0vwu9Ak9S9jx+ICwmEYkYO1r36GYCdgtvkswjmqKioBM
        kHt6qcAsTqij3glOsP/ubFiknpdJP/k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-wOY-TMZyPsKaogwvzmoVVw-1; Thu, 01 Jun 2023 06:14:23 -0400
X-MC-Unique: wOY-TMZyPsKaogwvzmoVVw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f603fed174so4180935e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 03:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614462; x=1688206462;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYR/VkMk/voOznqHepF47pBoY++iUIp7AId3uEofiiU=;
        b=S+RV0dfenTHbQtElfMxlLgYb0oIIAoxPIb2UF9sIMr7vS8q7rIM5+K3FRbo/Cz/QQD
         eEdm2z/Du7Y+kj3ifCtZZgxeAsGuo5m+/sizXEttDHq21qp2sc1UYzKwfbOUe/snHCxv
         u087+4R+GAWF/DFbsV53/AgrvEIMeLlo5dOdf8itk+6UDwdDjpjbm0n4iUKPbI3XWoIq
         xBL5MdyFpXgK0IE8XiAc+gzHoFZOOjMgVAqjn9BeFPVn37WqBDlTVURe5t+iB174Rjgy
         YYYHMhQfID/v8VQx8ZnZNA+z9Ww395L+/ATxR0xc0TsTt2VZKjah7erLCiYIye5wR6VZ
         uQrA==
X-Gm-Message-State: AC+VfDxXb6F8M2WMOM0ZpPpgLgc/ToeBFiq9nnl/uCAQw4boTjaC7uw9
        Mw2mxNuWV61kD+P7TY1YaWkxnCSQrNS4MZD1d/aAPg4rVmP/rbpMIEok5eIwn6e0rAXomZkttcB
        Caao3ntp7BTB8oJ6NUOW+Yu99pg==
X-Received: by 2002:a1c:4b04:0:b0:3f6:1508:950d with SMTP id y4-20020a1c4b04000000b003f61508950dmr1560166wma.8.1685614461792;
        Thu, 01 Jun 2023 03:14:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VnsEBhESdjXdiQFg74eikZktRK8TAGK3ABpDAi6e4ScCG4i4Ww4wsGLH4CWPzX8JVUMeRXg==
X-Received: by 2002:a1c:4b04:0:b0:3f6:1508:950d with SMTP id y4-20020a1c4b04000000b003f61508950dmr1560131wma.8.1685614461274;
        Thu, 01 Jun 2023 03:14:21 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c219900b003f42314832fsm1766220wme.18.2023.06.01.03.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:14:20 -0700 (PDT)
Message-ID: <73befe4b-b9cc-72ee-872e-29efc16539ca@redhat.com>
Date:   Thu, 1 Jun 2023 12:14:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <492558dc-1377-fc4b-126f-c358bb000ff7@redhat.com>
 <cbd39f94-407a-03b6-9c43-8144d0efc8bb@redhat.com>
 <20230526214142.958751-1-dhowells@redhat.com>
 <20230526214142.958751-2-dhowells@redhat.com>
 <510965.1685522152@warthog.procyon.org.uk>
 <703628.1685541335@warthog.procyon.org.uk>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v4 1/3] mm: Don't pin ZERO_PAGE in pin_user_pages()
In-Reply-To: <703628.1685541335@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31.05.23 15:55, David Howells wrote:
> David Hildenbrand <david@redhat.com> wrote:
> 
>> Yes, it would be clearer if we would be using "pinned" now only for FOLL_PIN
> 
> You're not likely to get that.  "To pin" is too useful a verb that gets used
> in other contexts too.  For that reason, I think FOLL_PIN was a poor choice of
> name:-/.  I guess the English language has got somewhat overloaded.  Maybe
> FOLL_PEG? ;-)

You're probably right. FOLL_PIN and all around that is "get me an 
additional reference on the page and make sure I can DMA it without any 
undesired side-effects".

FOLL_PIN_DMA would have been clearer (and matches 
folio_maybe_dma_pinned() ) ... but then, there are some use cases where 
want the same semantics but not actually perform DMA, but simply 
read/write via the directmap (e.g., vmsplice, some io_uring cases). 
Sure, one could say that they behave like DMA: access page content at 
any time.

Saying a page is pinned (additional refcount) and having a pincount of 0 
or does indeed cause confusion.

... but once we start renaming FOLL_PIN, pincount, ... we also have to 
rename pin_user_pages() and friends, and things get nasty.

> 
>> and everything else is simply "taking a temporary reference on the page".
> 
> Excluding refs taken with pins, many refs are more permanent than pins as, so
> far as I'm aware, pins only last for the duration of an I/O operation.

I was more thinking along the lines of FOLL_GET vs. FOLL_PIN. Once we 
consider any references we might have on a page, things get more tricky 
indeed.

> 
>>>> "Note that the refcount of any zero_pages returned among the pinned pages will
>>>> not be incremented, and unpin_user_page() will similarly not decrement it."
>>> That's not really right (although it happens to be true), because we're
>>> talking primarily about the pin counter, not the refcount - and they may be
>>> separate.
>>
>> In any case (FOLL_PIN/FOLL_GET) you increment/decrement the refcount. If we
>> have a separate pincount, we increment/decrement the refcount by 1 when
>> (un)pinning.
> 
> FOLL_GET isn't relevant here - only FOLL_PIN.  Yes, as it happens, we count a
> ref if we count a pin, but that's kind of irrelevant; what matters is that the
> effect must be undone with un-PUP.

The point I was trying to make is that we always modify the refcount, 
and in some cases (FOLL_PIN on order > 0) also the pincount.

But if you define "pins" as "additional reference", we're on the same page.

> 
> It would be nice not to get a ref on the zero page in FOLL_GET, but I don't
> think we can do that yet.  Too many places assume that GUP will give them a
> ref they can release later via ordinary methods.

No we can't I'm afraid.

-- 
Thanks,

David / dhildenb

