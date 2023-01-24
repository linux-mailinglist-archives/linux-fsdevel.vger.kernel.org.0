Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9606679848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 13:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjAXMpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 07:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjAXMpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EC43E622
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674564265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlWOeuZubdR/IcleVktzfNZM3qINJhEfgeqWEooUufo=;
        b=WHuZnKhHKyNPJJDInTwa5CXrfKqVgmoi22KaFjY2DHMYRvj+Pq48oV2ztwho7YMZZs/KbP
        EcPyTjwjDqHi6eMQMStgv7YNu8/qkBV4lev/vYjMFGzKjPIeoLELcACI4cx4yA5vBxKte1
        Go0Zgde+yb4XhJhPEI6+InDH6FRq4HY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-662-9E3mAvSqMRKFiVj41tapkA-1; Tue, 24 Jan 2023 07:44:24 -0500
X-MC-Unique: 9E3mAvSqMRKFiVj41tapkA-1
Received: by mail-wm1-f72.google.com with SMTP id l31-20020a05600c1d1f00b003da8b330db2so639599wms.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jan 2023 04:44:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HlWOeuZubdR/IcleVktzfNZM3qINJhEfgeqWEooUufo=;
        b=nSV0gksyJasllqXs6+IuP9uHr2ToLWhNWgumS9ovwgffV1eNrAGOs8yJLCgFAdJEZR
         eMLUN8dmum+3iFGpWMDkZodTC3SyOz6t2z59TVs0+DNZEH5SQ5FE/03HMwp4lVzJ3m+H
         yZq4E7OrWFHygXCajTAYYBB+PF+xIZPgE9OKexQKQhqxXKzzMzWpEmWApYtNCWGV0nwQ
         LxPLyoS/3Jx9mg7VA8nGH/eFk87Pylxx1UjvNUOBUmWBEJyksn2EkGY+UVvNgxohRkCd
         pmPxmRye060MVNw5oK3oOI+ireHg1gSnFEE9A19qo/ExSxdP2jyoJYCaXmeHjR+dOLgQ
         JFIQ==
X-Gm-Message-State: AFqh2kogf1eR0Dnd++7wpJ/E5CtRHgj8jMGtSE3SfhOn0y01bUFSUwfE
        nh95bERMroX6mTIGNvIXWmUNi+OnM+/bLZcH/LWpgbLjCsaH+rXbwvfE3heHYhXXtrxWD3gNMCF
        2+Tlw2v3LY0+l58Q3ujVBr8kImQ==
X-Received: by 2002:a05:600c:89a:b0:3cf:6e78:e2ca with SMTP id l26-20020a05600c089a00b003cf6e78e2camr35484882wmp.5.1674564263014;
        Tue, 24 Jan 2023 04:44:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvpaVb+KoSyYZ6Y+8AIxJte3JAF9rgdFAtF5kPBqPK5CZV0UkXliZS3CFsvIUsXKdIwnvdMEw==
X-Received: by 2002:a05:600c:89a:b0:3cf:6e78:e2ca with SMTP id l26-20020a05600c089a00b003cf6e78e2camr35484856wmp.5.1674564262663;
        Tue, 24 Jan 2023 04:44:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id he7-20020a05600c540700b003d9fb04f658sm13084678wmb.4.2023.01.24.04.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 04:44:22 -0800 (PST)
Message-ID: <02063032-61e7-e1e5-cd51-a50337405159@redhat.com>
Date:   Tue, 24 Jan 2023 13:44:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123173007.325544-1-dhowells@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v8 00/10] iov_iter: Improve page extraction (pin or just
 list)
In-Reply-To: <20230123173007.325544-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.01.23 18:29, David Howells wrote:
> Hi Al, Christoph,
> 
> Here are patches to provide support for extracting pages from an iov_iter
> and to use this in the extraction functions in the block layer bio code.
> 
> The patches make the following changes:
> 
>   (1) Add a function, iov_iter_extract_pages() to replace
>       iov_iter_get_pages*() that gets refs, pins or just lists the pages as
>       appropriate to the iterator type.
> 
>       Add a function, iov_iter_extract_mode() that will indicate from the
>       iterator type how the cleanup is to be performed, returning FOLL_PIN
>       or 0.
> 
>   (2) Add a function, folio_put_unpin(), and a wrapper, page_put_unpin(),
>       that take a page and the return from iov_iter_extract_mode() and do
>       the right thing to clean up the page.
> 
>   (3) Make the bio struct carry a pair of flags to indicate the cleanup
>       mode.  BIO_NO_PAGE_REF is replaced with BIO_PAGE_REFFED (equivalent to
>       FOLL_GET) and BIO_PAGE_PINNED (equivalent to BIO_PAGE_PINNED) is
>       added.
> 
>   (4) Add a function, bio_release_page(), to release a page appropriately to
>       the cleanup mode indicated by the BIO_PAGE_* flags.
> 
>   (5) Make the iter-to-bio code use iov_iter_extract_pages() to retain the
>       pages appropriately and clean them up later.
> 
>   (6) Fix bio_flagged() so that it doesn't prevent a gcc optimisation.
> 
>   (7) Renumber FOLL_PIN and FOLL_GET down so that they're at bits 0 and 1
>       and coincident with BIO_PAGE_PINNED and BIO_PAGE_REFFED.  The compiler
>       can then optimise on that.  Also, it's probably going to be necessary
>       to embed these in the page pointer in sk_buff fragments.  This patch
>       can go independently through the mm tree.

^ I feel like some of that information might be stale now that you're 
only using FOLL_PIN.

> 
> I've pushed the patches here also:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract

I gave this a quick test and it indeed fixes the last remaining test 
case of my O_DIRECT+fork tests [1] that was still failing on upstream 
(test3).


Once landed upstream, if we feel confident enough (I tend to), we could 
adjust the open() man page to state that O_DIRECT can now be run 
concurrently with fork(). Especially, the following documentation might 
be adjusted:

"O_DIRECT  I/Os  should  never  be run concurrently with the fork(2) 
system call, if the memory buffer is a private mapping (i.e., any 
mapping created with the mmap(2) MAP_PRIVATE flag; this includes  memory 
  allocated  on  the  heap  and statically allocated buffers).  Any such 
I/Os, whether submitted via an asynchronous I/O interface or from 
another thread in the  process, should  be completed before fork(2) is 
called.  Failure to do so can result in data corruption and undefined 
behavior in parent and child processes."


This series does not yet fix vmsplice()+hugetlb ... simply because your 
series does not mess with the vmsplice() implementation I assume ;) Once 
vmsplice() uses FOLL_PIN, all cow tests should be passing as well. Easy 
to test:

$ cd tools/testing/selftests/vm/
$ echo 2 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
$ echo 2 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
$ ./cow
...
Bail out! 8 out of 190 tests failed
# Totals: pass:181 fail:8 xfail:0 xpass:0 skip:1 error:0


[1] https://gitlab.com/davidhildenbrand/o_direct_fork_tests

-- 
Thanks,

David / dhildenb

