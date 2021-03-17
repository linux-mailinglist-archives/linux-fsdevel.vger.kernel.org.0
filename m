Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E0233E6A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 03:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCQCM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 22:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCQCMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:12:25 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A55C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 19:12:24 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id g8so727889qvx.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 19:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KA0cQX0H+fedUmZSqotKHkFt9nfBS2lV4mSDduYC1Vo=;
        b=CfwgdSSKwnQ510ZsN0+CUYSCMnJvGTNOF0qgo3PkrJT/Da/ZELVOKWL/gvdjXbwGIJ
         +O24SS0hCf6GGdRpdBSk7N5NbLn2iWfl25SUnaP3oNJ7WiJXrG4UqOuQVtPZMqv1UvLq
         1k9Y29haYQb7OJLIFpq9Ca/2lmePu+tE/YxOqCC7/pjN0ZJm/td3809+dpAOb2cIbaOB
         JIelDCwL+8ebDLqZ3W53s0y9QKt1RRSRn3jACZJpraJ6VtSZoPGPLIHKRuVw6WXLF8mu
         NSaPFQU3F6l0ReQyu9G5Yv+r+f2QbaVUKOhZkjsn1XroEHm2K1q3C9v7SyUY5WN5Z7ln
         hDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KA0cQX0H+fedUmZSqotKHkFt9nfBS2lV4mSDduYC1Vo=;
        b=gBTwiu7wGOVDRZspykHhqMs5c/OJBQPq1nPlDX7OroYb4Sl9gE8jKryODQxozZs+Ge
         ctePRvHdiqXnj+IaISNOshvzS0WtebFxpaVA0iJp82Msglp3St5CtjwatoaxSlYDp7pZ
         s33X1QXKtT5MolWGp6rHTgwhUbTgEyh2TZ55jk4KLQ/JWMhsnNIMzVc9kGNzl925ySZd
         5cGQLkouuYz0F/SA2TpcKd3p5axDI6tnB4mWXvk5GUwPJuWE+3XnyQhnnkZTdkEvzIGG
         yIPBqp6uoo18dgTiCJUwFdXq13+XWc5g11LhW68pmqmPPUcyuuVPQHbGh3q9GYUnc9PM
         z99A==
X-Gm-Message-State: AOAM533AM6zfvl6EIbBAkzf73qSkJGbUTKTCY03g6ffOLv85stPpmbET
        q1jtzTf+YZo9eaSR6qrp8UrOlw==
X-Google-Smtp-Source: ABdhPJyCVi9KcQuRC+jk9afKmHcOxIGMxGHzjm2jLRzMICkswTbEAhqzEZ42z+xpCoNkmkSraZlwfQ==
X-Received: by 2002:a05:6214:1744:: with SMTP id dc4mr2746704qvb.40.1615947143864;
        Tue, 16 Mar 2021 19:12:23 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r3sm16393336qkm.129.2021.03.16.19.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 19:12:23 -0700 (PDT)
Subject: Re: [PATCH v4 02/28] mm: Add an unlock function for
 PG_private_2/PG_fscache
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <161539526152.286939.8589700175877370401.stgit@warthog.procyon.org.uk>
 <161539528910.286939.1252328699383291173.stgit@warthog.procyon.org.uk>
 <20210316190707.GD3420@casper.infradead.org>
 <CAHk-=wjSGsRj7xwhSMQ6dAQiz53xA39pOG+XA_WeTgwBBu4uqg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <887b9eb7-2764-3659-d0bf-6a034a031618@toxicpanda.com>
Date:   Tue, 16 Mar 2021 22:12:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjSGsRj7xwhSMQ6dAQiz53xA39pOG+XA_WeTgwBBu4uqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/16/21 8:43 PM, Linus Torvalds wrote:
> [ Adding btrfs people explicitly, maybe they see this on the fs-devel
> list, but maybe they don't react .. ]
> 
> On Tue, Mar 16, 2021 at 12:07 PM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> This isn't a problem with this patch per se, but I'm concerned about
>> private2 and expected page refcounts.
> 
> Ugh. You are very right.
> 
> It would be good to just change the rules - I get the feeling nobody
> actually depended on them anyway because they were _so_ esoteric.
> 
>> static inline int is_page_cache_freeable(struct page *page)
>> {
>>          /*
>>           * A freeable page cache page is referenced only by the caller
>>           * that isolated the page, the page cache and optional buffer
>>           * heads at page->private.
>>           */
>>          int page_cache_pins = thp_nr_pages(page);
>>          return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
> 
> You're right, that "page_has_private()" is really really nasty.
> 
> The comment is, I think, the traditional usage case, which used to be
> about page->buffers. Obviously these days it is now about
> page->private with PG_private set, pointing to buffers
> (attach_page_private() and detach_page_private()).
> 
> But as you point out:
> 
>> #define PAGE_FLAGS_PRIVATE                              \
>>          (1UL << PG_private | 1UL << PG_private_2)
>>
>> So ... a page with both flags cleared should have a refcount of N.
>> A page with one or both flags set should have a refcount of N+1.
> 
> Could we just remove the PG_private_2 thing in this context entirely,
> and make the rule be that
> 
>   (a) PG_private means that you have some local private data in
> page->private, and that's all that matters for the "freeable" thing.
> 
>   (b) PG_private_2 does *not* have the same meaning, and has no bearing
> on freeability (and only the refcount matters)
> 
> I _)think_ the btrfs behavior is to only use PagePrivate2() when it
> has a reference to the page, so btrfs doesn't care?
> 
> I think fscache is already happy to take the page count when using
> PG_private_2 for locking, exactly because I didn't want to have any
> confusion about lifetimes. But this "page_has_private()" math ends up
> meaning it's confusing anyway.
> 
> btrfs people? What are the semantics for PG_private_2? Is it just a
> flag, and you really don't want it to have anything to do with any
> page lifetime decisions? Or?
> 

Yeah it's just a flag, we use it to tell that the page is part of a range that 
has been allocated for IO.  The lifetime of the page is independent of the page, 
but is generally either dirty or under writeback, so either it goes through 
truncate and we clear PagePrivate2 there, or it actually goes through IO and is 
cleared before we drop the page in our endio.  We _always_ have PG_private set 
on the page as long as we own it, and PG_private_2 is only set in this IO 
related context, so we're safe there because of the rules around 
PG_dirty/PG_writeback.  We don't need it to have an extra ref for it being set. 
  Thanks,

Josef

