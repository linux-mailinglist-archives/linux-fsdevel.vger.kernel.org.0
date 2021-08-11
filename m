Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6AB3E979B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 20:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhHKS0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 14:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20226 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229655AbhHKS0V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628706356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dPC7yuqLsjJqvrG1jk73xuT51FKTNAzfvIkh4QB+hPY=;
        b=hjSCe65+4iTA9ej79mG+ksLB7/mjSXd9TZVKGOkgDHapj8iNym4pOmPG1DNTn3h/PVc5vJ
        uMhJjV5CKPeSDJGKwFfzVs2e0qf5SP4TeeDzV8gBMP+Q3NSRHg4ixmvtoHSfZLNtZC48Oo
        wg7hMhlvQX9mAg5be/akHI4g0i7Z4nk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-PlftL7S3PbiQAlSI2lxhsQ-1; Wed, 11 Aug 2021 14:25:55 -0400
X-MC-Unique: PlftL7S3PbiQAlSI2lxhsQ-1
Received: by mail-qt1-f198.google.com with SMTP id 12-20020ac8570c0000b029029624d5a057so1773281qtw.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 11:25:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dPC7yuqLsjJqvrG1jk73xuT51FKTNAzfvIkh4QB+hPY=;
        b=uNmZIJzfSigqeMavIXYYFrrxlGSvVG3tvblITqtbre0OdEMVvSps6CEkF5ra1uRxI6
         XEjBhzom34jBViYlcv5lY6F3W3FMgC7LDaj7xXKJW/15ALebSNRYeyb+Euajo4at7Hzq
         /wPNkB7IZ+vGZNsS+vtT18Y/d7Jj9romH2lmg//bc9B94qZMwpRvViK5Z+Ttu0YmnZwi
         Z+CSBupniagnY6t6sdQMQHFehDzwqBnKYbjzGVCmsTzZiEFtxDeNpQExwQv4ydK1DOEF
         etWDrhzHlyy78Zg3+8/cFJ1uwSjoCQ1rXFZkXPCSWapu9t9BmH5iG0E9F8M8SNWg1fSg
         R6QQ==
X-Gm-Message-State: AOAM533wjHAWl36qQa4HFgxZNk+AfDmZ6CCStuw3b3/SBE24LfBDJR1z
        lP7kmhny7bPTmyEjD6ttQAt8ODfFXeuw+H+I7Z507Ob1pD38Rq7wV6QTU5i9vkyoXs9diAXTpVT
        S17FYgrEhsXO4BjxsRvNDu8dcjw==
X-Received: by 2002:a37:383:: with SMTP id 125mr333210qkd.321.1628706355007;
        Wed, 11 Aug 2021 11:25:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnSpIK9A3sv+nXhr9+jALvfldLeORuwofGKxFehBJfcFnu50+qbEV6jgS8/IERVecl8T5i5A==
X-Received: by 2002:a37:383:: with SMTP id 125mr333175qkd.321.1628706354755;
        Wed, 11 Aug 2021 11:25:54 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id q9sm10875890qkn.85.2021.08.11.11.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:25:54 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:25:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        vincenzo.frascino@arm.com, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        jonathan.davies@nutanix.com
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
Message-ID: <YRQWMIBwkdBK12Z3@t490s>
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
 <YQrdY5zQOVgQJ1BI@t490s>
 <839e82f7-2c54-d1ef-8371-0a332a4cb447@redhat.com>
 <YQrn33pOlpdl662i@t490s>
 <0beb1386-d670-aab1-6291-5c3cb0d661e0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0beb1386-d670-aab1-6291-5c3cb0d661e0@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 06:15:37PM +0200, David Hildenbrand wrote:
> On 04.08.21 21:17, Peter Xu wrote:
> > On Wed, Aug 04, 2021 at 08:49:14PM +0200, David Hildenbrand wrote:
> > > TBH, I tend to really dislike the PTE marker idea. IMHO, we shouldn't store
> > > any state information regarding shared memory in per-process page tables: it
> > > just doesn't make too much sense.
> > > 
> > > And this is similar to SOFTDIRTY or UFFD_WP bits: this information actually
> > > belongs to the shared file ("did *someone* write to this page", "is
> > > *someone* interested into changes to that page", "is there something"). I
> > > know, that screams for a completely different design in respect to these
> > > features.
> > > 
> > > I guess we start learning the hard way that shared memory is just different
> > > and requires different interfaces than per-process page table interfaces we
> > > have (pagemap, userfaultfd).
> > > 
> > > I didn't have time to explore any alternatives yet, but I wonder if tracking
> > > such stuff per an actual fd/memfd and not via process page tables is
> > > actually the right and clean approach. There are certainly many issues to
> > > solve, but conceptually to me it feels more natural to have these shared
> > > memory features not mangled into process page tables.
> > 
> > Yes, we can explore all the possibilities, I'm totally fine with it.
> > 
> > I just want to say I still don't think when there's page cache then we must put
> > all the page-relevant things into the page cache.
> 
> [sorry for the late reply]
> 
> Right, but for the case of shared, swapped out pages, the information is
> already there, in the page cache :)
> 
> > 
> > They're shared by processes, but process can still have its own way to describe
> > the relationship to that page in the cache, to me it's as simple as "we allow
> > process A to write to page cache P", while "we don't allow process B to write
> > to the same page" like the write bit.
> 
> The issue I'm having uffd-wp as it was proposed for shared memory is that
> there is hardly a sane use case where we would *want* it to work that way.
> 
> A UFFD-WP flag in a page table for shared memory means "please notify once
> this process modifies the shared memory (via page tables, not via any other
> fd modification)". Do we have an example application where these semantics
> makes sense and don't over-complicate the whole approach? I don't know any,
> thus I'm asking dumb questions :)
> 
> 
> For background snapshots in QEMU the flow would currently be like this,
> assuming all processes have the shared guest memory mapped.
> 
> 1. Background snapshot preparation: QEMU requests all processes
>    to uffd-wp the range
> a) All processes register a uffd handler on guest RAM

To be explicit: not a handler; just register with uffd-wp and pass over the fd
to the main process.

> b) All processes fault in all guest memory (essentially populating all
>    memory): with a uffd-WP extensions we might be able to get rid of
>    that, I remember you were working on that.
> c) All processes uffd-WP the range to set the bit in their page table
> 
> 2. Background snapshot runs:
> a) A process either receives a UFFD-WP event and forwards it to QEMU or
>    QEMU polls all other processes for UFFD events.
> b) QEMU writes the to-be-changed page to the migration stream.
> c) QEMU triggers all processes to un-protect the page and wake up any
>    waiters. All processes clear the uffd-WP bit in their page tables.
> 
> 3. Background snapshot completes:
> a) All processes unregister the uffd handler
> 
> 
> Now imagine something like this:
> 
> 1. Background snapshot preparation:
> a) QEMU registers a UFFD-WP handler on a *memfd file* that corresponds
>    to guest memory.
> b) QEMU uffd-wp's the whole file
> 
> 2. Background snapshot runs:
> a) QEMU receives a UFFD-WP event.
> b) QEMU writes the to-be-changed page to the migration stream.
> c) QEMU un-protect the page and wake up any waiters.
> 
> 3. Background snapshot completes:
> a) QEMU unregister the uffd handler
> 
> 
> Wouldn't that be much nicer and much easier to handle? Yes, it is much
> harder to implement because such an infrastructure does not exist yet, and
> it most probably wouldn't be called uffd anymore, because we are dealing
> with file access. But this way, it would actually be super easy to use the
> feature across multiple processes and eventually to even catch other file
> modifications.

I can totally understand how you see this.  We've discussed about that, isn't
it? About the ideal worlds. :)

It would be great if this can work out, I hope so.  So far I'm not that
ambicious, and as I said, I don't know whether there will be other concerns
when it goes into the page cache layer, and when it's a behavior of multiple
processes where one of them can rule others without others being notice of it.

Even if we want to go that way, I think we should first come up with some way
to describe the domains that one uffd-wp registered file should behave upon.
It shouldn't be "any process touching this file".

One quick example in my mind is when a malicious process wants to stop another
daemon process, it'll be easier as long as the malicious process can delete a
file that the daemon used to read/write, replace it with a shmem with uffd-wp
registered (or maybe just a regular file on file systems, if your proposal will
naturally work on them).  The problem is, is it really "legal" to be able to
stop the daemon running like that?

I also don't know the initial concept when uffd is designed and why it's
designed at pte level.  Avoid vma manipulation should be a major factor, but I
can't say I understand all of them.  Not sure whether Andrea has any input here.

That's why I think current uffd can still make sense with per-process concepts
and keep it that way.  When register uffd-wp yes we need to do that for
multiple processes, but it also means each process is fully aware that this is
happening so it's kind of verified that this is wanted behavior for that
process.  It'll happen with less "surprises", and smells safer.

I don't think that will not work out.  It may require all the process to
support uffd-wp apis and cooperate, but that's so far how it should work for me
in a safe and self-contained way.  Say, every process should be aware of what's
going to happen on blocked page faults.

> 
> Again, I am not sure if uffd-wp or softdirty make too much sense in general
> when applied to shmem. But I'm happy to learn more.

Me too, I'm more than glad to know whether the page cache idea could be
welcomed or am I just wrong about it.  Before I understand more things around
this, so far I still think the per-process based and fd-based solution of uffd
still makes sense.

Thanks,

-- 
Peter Xu

