Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE61E415A83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 11:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbhIWJFU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 05:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240074AbhIWJFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 05:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632387828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2vZx6Tk6VuuMikWnLUs2Mq5yA5lp/FlcON1t/+GITs=;
        b=E7V9plAGN3YQUB4OJbw0296TnH2SR7uLl0A291A4xLoG2YtBBnADKHniCNywunlDamFy2g
        7gjWap+NCMoktes4AbBpPIwdpkt3e2icobiwQYLcB6yWttHRdul+rg1WS52H7AYFm43Osg
        Oa3hEXexnuEFXMcqVmLQV3PazDa7xls=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-zoXhJIQyPFKs38ajTeejEA-1; Thu, 23 Sep 2021 05:03:47 -0400
X-MC-Unique: zoXhJIQyPFKs38ajTeejEA-1
Received: by mail-wr1-f72.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so4541283wrp.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 02:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t2vZx6Tk6VuuMikWnLUs2Mq5yA5lp/FlcON1t/+GITs=;
        b=CRdpZSSF5g7gCbcOPeVbrv4ubLPJ+QLLRm5hEzdVDHMEDSrnBe3hqBt/LO2l7JrDVJ
         RdHYLjWfMUdErcQmOmMKTQUBQDCwBrjzCL/Y/0XWzV/CxYncYjXepbQnS9GyRbgPncY/
         jmqPVUlCGsfmWOc/JhJHmNdN/MOA6yzItv+7oB/g5gv9sIq2BdTbq4jd/ZwaYexisMrF
         JZTA8n9fqDJTCe3CTynACJzb7ouvK32HSB7kCvpNBDH7Gv3iuUbZmYGfgD+IUh26XBkX
         PszHstB/ohYbH9h0nroyj5q6GXlKSOcbFzHWelBel+BzGJuqQPKX0HLvyV7lPJsjJVPs
         tc6w==
X-Gm-Message-State: AOAM5324r2HVJ/O0v5kjaw4DNMSl5KwEuxQX1BQkXDP8N51SHm/KPhbc
        wmmrlK5gRzaQXaBUxyB8mgS3mHAluy+Al2YoY5Q70DImoLJX3/QHdvimFVg3iB9ho8X7CI7xK0M
        CHRQfMRxyCLHv2iRqzoLa2Ajinw==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr3580677wri.391.1632387826272;
        Thu, 23 Sep 2021 02:03:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeRpgN+EL+Z5hNhW1qMdx3/KwVxtgMSwnv4toSVOPPdy+eTVEUuLA9m44ceRboo99Fo1O7RA==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr3580658wri.391.1632387825997;
        Thu, 23 Sep 2021 02:03:45 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23e5d.dip0.t-ipconnect.de. [79.242.62.93])
        by smtp.gmail.com with ESMTPSA id a77sm4539713wme.28.2021.09.23.02.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 02:03:45 -0700 (PDT)
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: Struct page proposal
Message-ID: <e567ad16-0f2b-940b-a39b-a4d1505bfcb9@redhat.com>
Date:   Thu, 23 Sep 2021 11:03:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUvWm6G16+ib+Wnb@moria.home.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23.09.21 03:21, Kent Overstreet wrote:
> One thing that's come out of the folios discussions with both Matthew and
> Johannes is that we seem to be thinking along similar lines regarding our end
> goals for struct page.
> 
> The fundamental reason for struct page is that we need memory to be self
> describing, without any context - we need to be able to go from a generic
> untyped struct page and figure out what it contains: handling physical memory
> failure is the most prominent example, but migration and compaction are more
> common. We need to be able to ask the thing that owns a page of memory "hey,
> stop using this and move your stuff here".
> 
> Matthew's helpfully been coming up with a list of page types:
> https://kernelnewbies.org/MemoryTypes
> 
> But struct page could be a lot smaller than it is now. I think we can get it
> down to two pointers, which means it'll take up 0.4% of system memory. Both
> Matthew and Johannes have ideas for getting it down even further - the main
> thing to note is that virt_to_page() _should_ be an uncommon operation (most of
> the places we're currently using it are completely unnecessary, look at all the
> places we're using it on the zero page). Johannes is thinking two layer radix
> tree, Matthew was thinking about using maple trees - personally, I think that
> 0.4% of system memory is plenty good enough.
> 
> 
> Ok, but what do we do with the stuff currently in struct page?
> -------------------------------------------------------------
> 
> The main thing to note is that since in normal operation most folios are going
> to be describing many pages, not just one - and we'll be using _less_ memory
> overall if we allocate them separately. That's cool.
> 
> Of course, for this to make sense, we'll have to get all the other stuff in
> struct page moved into their own types, but file & anon pages are the big one,
> and that's already being tackled.
> 
> Why two ulongs/pointers, instead of just one?
> ---------------------------------------------
> 
> Because one of the things we really want and don't have now is a clean division
> between allocator and allocatee state. Allocator meaning either the buddy
> allocator or slab, allocatee state would be the folio or the network pool state
> or whatever actually called kmalloc() or alloc_pages().
> 
> Right now slab state sits in the same place in struct page where allocatee state
> does, and the reason this is bad is that slab/slub are a hell of a lot faster
> than the buddy allocator, and Johannes wants to move the boundary between slab
> allocations and buddy allocator allocations up to like 64k. If we fix where slab
> state lives, this will become completely trivial to do.
> 
> So if we have this:
> 
> struct page {
> 	unsigned long	allocator;
> 	unsigned long	allocatee;
> };
> 
> The allocator field would be used for either a pointer to slab/slub's state, if
> it's a slab page, or if it's a buddy allocator page it'd encode the order of the
> allocation - like compound order today, and probably whether or not the
> (compound group of) pages is free.
> 
> The allocatee field would be used for a type tagged (using the low bits of the
> pointer) to one of:
>   - struct folio
>   - struct anon_folio, if that becomes a thing
>   - struct network_pool_page
>   - struct pte_page
>   - struct zone_device_page
> 
> Then we can further refactor things until all the stuff that's currently crammed
> in struct page lives in types where each struct field means one and precisely
> one thing, and also where we can freely reshuffle and reorganize and add stuff
> to the various types where we couldn't before because it'd make struct page
> bigger.
> 
> Other notes & potential issues:
>   - page->compound_dtor needs to die
> 
>   - page->rcu_head moves into the types that actually need it, no issues there
> 
>   - page->refcount has question marks around it. I think we can also just move it
>     into the types that need it; with RCU derefing the pointer to the folio or
>     whatever and grabing a ref on folio->refcount can happen under a RCU read
>     lock - there's no real question about whether it's technically possible to
>     get it out of struct page, and I think it would be cleaner overall that way.
> 
>     However, depending on how it's used from code paths that go from generic
>     untyped pages, I could see it turning into more of a hassle than it's worth.
>     More investigation is needed.
> 
>   - page->memcg_data - I don't know whether that one more properly belongs in
>     struct page or in the page subtypes - I'd love it if Johannes could talk
>     about that one.
> 
>   - page->flags - dealing with this is going to be a huge hassle but also where
>     we'll find some of the biggest gains in overall sanity and readability of the
>     code. Right now, PG_locked is super special and ad hoc and I have run into
>     situations multiple times (and Johannes was in vehement agreement on this
>     one) where I simply could not figure the behaviour of the current code re:
>     who is responsible for locking pages without instrumenting the code with
>     assertions.
> 
>     Meaning anything we do to create and enforce module boundaries between
>     different chunks of code is going to suck, but the end result should be
>     really worthwhile.
> 
> Matthew Wilcox and David Howells have been having conversations on IRC about
> what to do about other page bits. It appears we should be able to kill a lot of
> filesystem usage of both PG_private and PG_private_2 - filesystems in general
> hang state off of page->private, soon to be folio->private, and PG_private in
> current use just indicates whether page->private is nonzero - meaning it's
> completely redundant.
> 

Don't get me wrong, but before there are answers to some of the very 
basic questions raised above (especially everything that lives in 
page->flags, which are not only page flags, refcount, ...) this isn't 
very tempting to spend more time on, from a reviewer perspective.

-- 
Thanks,

David / dhildenb

