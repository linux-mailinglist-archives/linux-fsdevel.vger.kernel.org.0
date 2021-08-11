Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBF13E993F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 21:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhHKTzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 15:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229946AbhHKTzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 15:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628711695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jdVd8k5URnX6lBMFB7udQq0EhcO+kahsChnmRwo3jM=;
        b=hQrLflbTZe+5vl6KExRD1cMYoErr4bhGA1m1Mes+8s7qyyGKVEGPpWE3vYo4tmu9YlwPvt
        daNTFDfnd33pKhS/jJihIhr1WKsgwsZSoxhjmrKtGHdh0yJeYLQqNriNAzl51syfVrB+RZ
        mGUKa6hRfe4gm1+3xf2S2Pjevb61yP4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-NhORR7e6Nv6RQ4fxJmSiRA-1; Wed, 11 Aug 2021 15:54:54 -0400
X-MC-Unique: NhORR7e6Nv6RQ4fxJmSiRA-1
Received: by mail-qv1-f69.google.com with SMTP id l16-20020a0cc2100000b029035a3d6757b3so839557qvh.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Aug 2021 12:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5jdVd8k5URnX6lBMFB7udQq0EhcO+kahsChnmRwo3jM=;
        b=VUOB4nNWCkGwUzXBXV/5m+N/EZDfvWApNXpXdiOMnNM1fgKA1rBEaJuSmwTIGDDNGS
         vdZbQZliBaw6MQPP0679MNycjzaG+PeyFJ5ktbcOpETNPJxiXkZKWwl1gDRPrZJdeRF8
         jg7rvcjNxVUI3xpbZJJhJ5sg0AUSgvmQOVVwgS4lZzCxHwS2VcrFEIl+yMZlSM8seCmw
         Q/XMe78mMmaZk46HQajNOp053Os9aF7hH0Nhc6L81PdcJ8lOxLs2ibvlCgWuh2D/Hpom
         Y+lIcoyjQ4xLI0k9gbCPDKvHPfZZFO07Pl5BPX6N0ECTiCHVD57x5dePkpjtxAGXi8ZJ
         HLBA==
X-Gm-Message-State: AOAM532F+FI2SwYBzK4PNalAM9d6tdPjxbwwiy3DnDqvGuPtQ72hfJrO
        jJhdNXZV3qpl9LG7uFH2uPj+1Zbji8k1D22gZFDpRJFlYSTPQe6jhQIiLJs/50WxB+fdi3B2Opk
        7hNEHSfFFWKSzrxTHslKhYI3eMQ==
X-Received: by 2002:a0c:e609:: with SMTP id z9mr289690qvm.37.1628711693763;
        Wed, 11 Aug 2021 12:54:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrS8Y6Pwjp17TuAO8ZT0PQJJipBxId/xjwfHs5hk6mFcayR6+uxDkQYm7yRWfcjlx45/5mjg==
X-Received: by 2002:a0c:e609:: with SMTP id z9mr289660qvm.37.1628711693481;
        Wed, 11 Aug 2021 12:54:53 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-92-76-70-75-133.dsl.bell.ca. [76.70.75.133])
        by smtp.gmail.com with ESMTPSA id n8sm113423qtp.52.2021.08.11.12.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:54:52 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:54:50 -0400
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
        jonathan.davies@nutanix.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 0/1] pagemap: swap location for shared pages
Message-ID: <YRQrCrOCbVkJJ6Ph@t490s>
References: <20210730160826.63785-1-tiberiu.georgescu@nutanix.com>
 <YQrdY5zQOVgQJ1BI@t490s>
 <839e82f7-2c54-d1ef-8371-0a332a4cb447@redhat.com>
 <YQrn33pOlpdl662i@t490s>
 <0beb1386-d670-aab1-6291-5c3cb0d661e0@redhat.com>
 <YRQWMIBwkdBK12Z3@t490s>
 <253e7067-1c62-19bd-d395-d5c0495610d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <253e7067-1c62-19bd-d395-d5c0495610d7@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 08:41:32PM +0200, David Hildenbrand wrote:
> On 11.08.21 20:25, Peter Xu wrote:
> > On Wed, Aug 11, 2021 at 06:15:37PM +0200, David Hildenbrand wrote:
> > > On 04.08.21 21:17, Peter Xu wrote:
> > > > On Wed, Aug 04, 2021 at 08:49:14PM +0200, David Hildenbrand wrote:
> > > > > TBH, I tend to really dislike the PTE marker idea. IMHO, we shouldn't store
> > > > > any state information regarding shared memory in per-process page tables: it
> > > > > just doesn't make too much sense.
> > > > > 
> > > > > And this is similar to SOFTDIRTY or UFFD_WP bits: this information actually
> > > > > belongs to the shared file ("did *someone* write to this page", "is
> > > > > *someone* interested into changes to that page", "is there something"). I
> > > > > know, that screams for a completely different design in respect to these
> > > > > features.
> > > > > 
> > > > > I guess we start learning the hard way that shared memory is just different
> > > > > and requires different interfaces than per-process page table interfaces we
> > > > > have (pagemap, userfaultfd).
> > > > > 
> > > > > I didn't have time to explore any alternatives yet, but I wonder if tracking
> > > > > such stuff per an actual fd/memfd and not via process page tables is
> > > > > actually the right and clean approach. There are certainly many issues to
> > > > > solve, but conceptually to me it feels more natural to have these shared
> > > > > memory features not mangled into process page tables.
> > > > 
> > > > Yes, we can explore all the possibilities, I'm totally fine with it.
> > > > 
> > > > I just want to say I still don't think when there's page cache then we must put
> > > > all the page-relevant things into the page cache.
> > > 
> > > [sorry for the late reply]
> > > 
> > > Right, but for the case of shared, swapped out pages, the information is
> > > already there, in the page cache :)
> > > 
> > > > 
> > > > They're shared by processes, but process can still have its own way to describe
> > > > the relationship to that page in the cache, to me it's as simple as "we allow
> > > > process A to write to page cache P", while "we don't allow process B to write
> > > > to the same page" like the write bit.
> > > 
> > > The issue I'm having uffd-wp as it was proposed for shared memory is that
> > > there is hardly a sane use case where we would *want* it to work that way.
> > > 
> > > A UFFD-WP flag in a page table for shared memory means "please notify once
> > > this process modifies the shared memory (via page tables, not via any other
> > > fd modification)". Do we have an example application where these semantics
> > > makes sense and don't over-complicate the whole approach? I don't know any,
> > > thus I'm asking dumb questions :)
> > > 
> > > 
> > > For background snapshots in QEMU the flow would currently be like this,
> > > assuming all processes have the shared guest memory mapped.
> > > 
> > > 1. Background snapshot preparation: QEMU requests all processes
> > >     to uffd-wp the range
> > > a) All processes register a uffd handler on guest RAM
> > 
> > To be explicit: not a handler; just register with uffd-wp and pass over the fd
> > to the main process.
> 
> Good point.
> 
> > 
> > > b) All processes fault in all guest memory (essentially populating all
> > >     memory): with a uffd-WP extensions we might be able to get rid of
> > >     that, I remember you were working on that.
> > > c) All processes uffd-WP the range to set the bit in their page table
> > > 
> > > 2. Background snapshot runs:
> > > a) A process either receives a UFFD-WP event and forwards it to QEMU or
> > >     QEMU polls all other processes for UFFD events.
> > > b) QEMU writes the to-be-changed page to the migration stream.
> > > c) QEMU triggers all processes to un-protect the page and wake up any
> > >     waiters. All processes clear the uffd-WP bit in their page tables.
> > > 
> > > 3. Background snapshot completes:
> > > a) All processes unregister the uffd handler
> > > 
> > > 
> > > Now imagine something like this:
> > > 
> > > 1. Background snapshot preparation:
> > > a) QEMU registers a UFFD-WP handler on a *memfd file* that corresponds
> > >     to guest memory.
> > > b) QEMU uffd-wp's the whole file
> > > 
> > > 2. Background snapshot runs:
> > > a) QEMU receives a UFFD-WP event.
> > > b) QEMU writes the to-be-changed page to the migration stream.
> > > c) QEMU un-protect the page and wake up any waiters.
> > > 
> > > 3. Background snapshot completes:
> > > a) QEMU unregister the uffd handler
> > > 
> > > 
> > > Wouldn't that be much nicer and much easier to handle? Yes, it is much
> > > harder to implement because such an infrastructure does not exist yet, and
> > > it most probably wouldn't be called uffd anymore, because we are dealing
> > > with file access. But this way, it would actually be super easy to use the
> > > feature across multiple processes and eventually to even catch other file
> > > modifications.
> > 
> > I can totally understand how you see this.  We've discussed about that, isn't
> > it? About the ideal worlds. :)
> 
> Well, let's dream big :)
> 
> > 
> > It would be great if this can work out, I hope so.  So far I'm not that
> > ambicious, and as I said, I don't know whether there will be other concerns
> > when it goes into the page cache layer, and when it's a behavior of multiple
> > processes where one of them can rule others without others being notice of it.
> > 
> > Even if we want to go that way, I think we should first come up with some way
> > to describe the domains that one uffd-wp registered file should behave upon.
> > It shouldn't be "any process touching this file".
> > 
> > One quick example in my mind is when a malicious process wants to stop another
> > daemon process, it'll be easier as long as the malicious process can delete a
> > file that the daemon used to read/write, replace it with a shmem with uffd-wp
> > registered (or maybe just a regular file on file systems, if your proposal will
> > naturally work on them).  The problem is, is it really "legal" to be able to
> > stop the daemon running like that?
> 
> Good question, I'd imagine e.g., file sealing could forbid uffd (or however
> it is called) registration on a file, and there would have to be a way to
> reject files that have uffd registered. But it's certainly a valid concern -
> and it raises the question to *what* we actually want to apply such a
> concept. Random files? random memfd? most probably not. Special memfds
> created with an ALLOW_UFFD flag? sounds like a good idea.

Note that when daemons open files, they may not be aware of what's underneath
but read that file directly.  The attacker could still create the file with
uffd-wp enabled with any flag we introduce.

> 
> > 
> > I also don't know the initial concept when uffd is designed and why it's
> > designed at pte level.  Avoid vma manipulation should be a major factor, but I
> > can't say I understand all of them.  Not sure whether Andrea has any input here.
> 
> AFAIU originally a) avoid signal handler madness and b) avoid VMA
> modifications and c) avoid taking the mmap lock in write (well, that didn't
> work out completely for uffd-wp for now IIRC).

Nadav fixed that; it's with read lock now just like when it's introduced.
Please see mwriteprotect_range() and commit 6ce64428d62026a10c.

I won't say message queue (signal handling) is because uffd is pte-based; that
seems to be an orthogonal design decision.  But yeah I agree that's something
better than using signal handlers.

> 
> > 
> > That's why I think current uffd can still make sense with per-process concepts
> > and keep it that way.  When register uffd-wp yes we need to do that for
> > multiple processes, but it also means each process is fully aware that this is
> > happening so it's kind of verified that this is wanted behavior for that
> > process.  It'll happen with less "surprises", and smells safer.
> > 
> > I don't think that will not work out.  It may require all the process to
> > support uffd-wp apis and cooperate, but that's so far how it should work for me
> > in a safe and self-contained way.  Say, every process should be aware of what's
> > going to happen on blocked page faults.
> 
> That's a valid concern, although I wonder if it can just be handled via
> specially marked memfds ("this memfd might get a uffd handler registered
> later").

Yes, please see my above concern.  So I think we at least reached concensus on:
(1) that idea is already not userfaultfd but something else; what's that is
still to be defined.  And, (2) that definitely needs further thoughts and
context to support its validity and safety.  Now uffd got people worried about
safety already, that's why all the uffd selinux and privileged_userfaultfd
sysctl comes to mainline; we'd wish good luck with the new concept!

OTOH, uffd whole idea is already in mainline, it has limitations on requiring
to rework all processes to support uffd-wp, but actually the same to MISSING
messages has already happened and our QE is testing those: that's what we do
with e.g. postcopy-migrating vhost-user enabled OVS-DPDK - we pass over uffd
registered with missing mode and let QEMU handle the page fault.  So it's a bit
complicated but it should work.  And I hope you can also agree we don't need to
block uffd before that idea settles.

The pte markers idea need comment; that's about implementation, and it'll be
great to have comments there or even NACK (better with a better suggestion,
though :).  But the original idea of uffd that is pte-based has never changed.

> 
> > > 
> > > Again, I am not sure if uffd-wp or softdirty make too much sense in general
> > > when applied to shmem. But I'm happy to learn more.
> > 
> > Me too, I'm more than glad to know whether the page cache idea could be
> > welcomed or am I just wrong about it.  Before I understand more things around
> > this, so far I still think the per-process based and fd-based solution of uffd
> > still makes sense.
> 
> I'd be curious about applications where the per-process approach would
> actually solve something a per-fd approach couldn't solve. Maybe there are
> some that I just can't envision.

Right, that's a good point.

Actually it could be when like virtio-mem that some process shouldn't have
write privilege, but we still allow some other process writting to the shmem.
Something like that.

> 
> (using shmem for a single process only isn't a use case I consider important
> :) )

If you still remember the discussion about "having qemu start to use memfd and
shmem as default"? :)

shmem is hard but it's indeed useful in many cases, even if single threaded.
For example, shmem-based VMs can do local binary update without migrating guest
RAMs (because memory is shared between old/new binaries!).  To me it's always a
valid request to enable both shmem and write protect.

[It seems Andrea is not in the loop; do that for real]

Thanks,

-- 
Peter Xu

