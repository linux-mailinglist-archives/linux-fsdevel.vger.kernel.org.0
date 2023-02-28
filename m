Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6706A5FB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjB1TcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 14:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjB1TcT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:32:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3352F17CE8
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 11:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677612690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ugqqZhF3NdZnSGhbQkL8EKwtOca9623ykRgIup6NQM0=;
        b=bKT2OUSnarBPVdydH7esKQAOYzc6CWmiHiAE5KpgQDARa1R8cQWVVUg/Yv4i/ojWhLcWrI
        m6IyTM2Ng8G4fg7L6oJUuJ89oSoi7M29OdfB3tU3EdKUlr8s7vS8HRoj8cZwdutqq1Jxvr
        ZPNt+iKtURPmHd+b347rDhrU4XLSWc8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-pquV7BvgOvK31FbcLOqjJg-1; Tue, 28 Feb 2023 14:31:29 -0500
X-MC-Unique: pquV7BvgOvK31FbcLOqjJg-1
Received: by mail-qk1-f198.google.com with SMTP id 19-20020a370c13000000b007428253bb55so6592351qkm.23
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 11:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677612688;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ugqqZhF3NdZnSGhbQkL8EKwtOca9623ykRgIup6NQM0=;
        b=TG88uvPEaJhDSaiWPJ91YIMpgR64peZvY4O4eal85cJKKxtJUE0h6Q8yi/QlvOe+58
         w0qLOghS0qH3wWru3P/sH8P1IbO7k4EfeqXmher4tKC3MfR+CzI3bQHMOjlf3RZaBuQx
         H6irbtxHTEkzs8+dni9PQTfVQBGDSgr3Of7hcfTkW3xvUF3pM8rzv6NSMZ3jJBKyzGo8
         9yuxPsp8eNR+x46nSrPIrG40E97UIl3ezJ+9T14bDIhlyMwcSQIGID2YSeX4DNdsqVBJ
         L3Py/PYzafDf6B0csjC/hmsDTq9Uz6BkiLjEhzjtk5fHOx3vwF8GBUohQi2cDC8+jmR4
         F1YQ==
X-Gm-Message-State: AO0yUKU8RLWp1Y/Km2sxHA7UAu9qWOtJ38YZE5NzdOsS8/VLEeQFRLEE
        K07l1vEQQZOqpsJZcio1KGbvN2lz/50OYpZYeM376TGB1bwlYQ3/hGApbhTQbeU3pWQpbuc+/NQ
        CAzxZU0gVw2rPyAQ3WCJRbKh/sQ==
X-Received: by 2002:a05:622a:15d4:b0:3b9:a4d4:7f37 with SMTP id d20-20020a05622a15d400b003b9a4d47f37mr7373423qty.3.1677612688590;
        Tue, 28 Feb 2023 11:31:28 -0800 (PST)
X-Google-Smtp-Source: AK7set9dU/RRxNhm5XoDCcnR56WP4+VRAVbJVAUIK8DiKGJ0dtx1DeIPjYkCBpkqIAEwSF9CFsLK2w==
X-Received: by 2002:a05:622a:15d4:b0:3b9:a4d4:7f37 with SMTP id d20-20020a05622a15d400b003b9a4d47f37mr7373372qty.3.1677612688196;
        Tue, 28 Feb 2023 11:31:28 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id h9-20020ac85489000000b003b62e9c82ebsm6974586qtq.48.2023.02.28.11.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 11:31:27 -0800 (PST)
Date:   Tue, 28 Feb 2023 14:31:25 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Message-ID: <Y/5WjdXJ+56Kud3u@x1n>
References: <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
 <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
 <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
 <c15446c5-eedd-690f-9dae-2bc12ee9eb78@collabora.com>
 <F73885A1-14AE-4820-876B-A8E6DC6D19CC@vmware.com>
 <Y/0eIUIh81jK9w2i@x1n>
 <5D5DEEED-55EB-457B-9EB7-C6D5B326FE99@vmware.com>
 <Y/4j/Nu1vp9sVI7N@x1n>
 <C96B273F-31EE-4784-A614-B03DEE680462@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C96B273F-31EE-4784-A614-B03DEE680462@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 05:21:20PM +0000, Nadav Amit wrote:
> 
> 
> > On Feb 28, 2023, at 7:55 AM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > !! External Email
> > 
> > On Mon, Feb 27, 2023 at 11:09:12PM +0000, Nadav Amit wrote:
> >> 
> >> 
> >>> On Feb 27, 2023, at 1:18 PM, Peter Xu <peterx@redhat.com> wrote:
> >>> 
> >>> !! External Email
> >>> 
> >>> On Thu, Feb 23, 2023 at 05:11:11PM +0000, Nadav Amit wrote:
> >>>> From my experience with UFFD, proper ordering of events  is crucial, although it
> >>>> is not always done well. Therefore, we should aim for improvement, not
> >>>> regression. I believe that utilizing the pagemap-based mechanism for WP'ing
> >>>> might be a step in the wrong direction. I think that it would have been better
> >>>> to emit a 'UFFD_FEATURE_WP_ASYNC' WP-log (and ordered) with UFFD #PF and
> >>>> events. The 'UFFD_FEATURE_WP_ASYNC'-log may not need to wake waiters on the
> >>>> file descriptor unless the log is full.
> >>> 
> >>> Yes this is an interesting question to think about..
> >>> 
> >>> Keeping the data in the pgtable has one good thing that it doesn't need any
> >>> complexity on maintaining the log, and no possibility of "log full".
> >> 
> >> I understand your concern, but I think that eventually it might be simpler
> >> to maintain, since the logic of how to process the log is moved to userspace.
> >> 
> >> At the same time, handling inputs from pagemap and uffd handlers and sync’ing
> >> them would not be too easy for userspace.
> > 
> > I do not expect a common uffd-wp async user to provide a fault handler at
> > all.  In my imagination it's in most cases used standalone from other uffd
> > modes; it means all the faults will still be handled by the kernel.  Here
> > we only leverage the accuracy of userfaultfd comparing to soft-dirty, so
> > not really real "user"-faults.
> 
> If that is the only use-case, it might make sense. But I guess most users would
> most likely use some library (and not syscalls directly). So slightly
> complicating the API for better generality may be reasonable.
> 
> > 
> >> 
> >> But yes, allocation on the heap for userfaultfd_wait_queue-like entries would
> >> be needed, and there are some issues of ordering the events (I think all #PF
> >> and other events should be ordered regardless) and how not to traverse all
> >> async-userfaultfd_wait_queue’s (except those that block if the log is full)
> >> when a wakeup is needed.
> > 
> > Will there be an ordering requirement for an async mode?  Considering it
> > should be async to whatever else, I would think it's not a problem, but
> > maybe I missed something.
> 
> You may be right, but I am not sure. I am still not sure what use-cases are
> targeted in this patch-set. For CRIU checkpoint use-case (when the app is
> not running), I guess the current interface makes sense. But if there are
> use-cases in which this you do care about UFFD-events this can become an
> issue.
> 
> But even in some obvious use-cases, this might be the wrong interface for
> major performance issues. If we think about some incremental copying of
> modified pages (a-la pre-copy live-migration or to create point-in-time
> snapshots), it seems to me much more efficient for application to have a
> log than traversing all the page-tables.

IMHO snapshots may not need a log at all - it needs CoW before the write
happens.  Nor is the case for swapping with userfaults, IIUC.  IOW in those
cases people don't care which page got dirtied, but care on data not being
modified until the app allows it to.

But I get the point, and I agree collecting by scanning is slower.

> 
> 
> >> 
> >>> 
> >>> If there's possible "log full" then the next question is whether we should
> >>> let the worker wait the monitor if the monitor is not fast enough to
> >>> collect those data.  It adds some slight dependency on the two threads, I
> >>> think it can make the tracking harder or impossible in latency sensitive
> >>> workloads.
> >> 
> >> Again, I understand your concern. But this model that I propose is not new.
> >> It is used with PML (page-modification logging) and KVM, and IIRC there is
> >> a similar interface between KVM and QEMU to provide this information. There
> >> are endless other examples for similar producer-consumer mechanisms that
> >> might lead to stall in extreme cases.
> > 
> > Yes, I'm not against thinking of using similar structures here.  It's just
> > that it's definitely more complicated on the interface, at least we need
> > yet one more interface to setup the rings and define its interfaces.
> > 
> > Note that although Muhammud is defining another new interface here too for
> > pagemap, I don't think it's strictly needed for uffd-wp async mode.  One
> > can use uffd-wp async mode with PM_UFFD_WP which is with current pagemap
> > interface already.
> > 
> > So what Muhammud is proposing here are two things to me: (1) uffd-wp async,
> > plus (2) a new pagemap interface (which will closely work with (1) only if
> > we need atomicity on get-dirty and reprotect).
> > 
> > Defining new interface for uffd-wp async mode will be something extra, so
> > IMHO besides the heap allocation on the rings, we need to also justify
> > whether that is needed.  That's why I think it's fine to go with what
> > Muhammud proposed, because it's a minimum changeset at least for userfault
> > to support an async mode, and anything else can be done on top if necessary.
> > 
> > Going a bit back to the "lead to stall in extreme cases" above, just also
> > want to mention that the VM use case is slightly different - dirty tracking
> > is only heavily used during migration afaict, and it's a short period.  Not
> > a lot of people will complain performance degrades during that period
> > because that's just rare.  And, even without the ring the perf is really
> > bad during migration anyway... Especially when huge pages are used to back
> > the guest RAM.
> > 
> > Here it's slightly different to me: it's about tracking dirty pages during
> > any possible workload, and it can be monitored periodically and frequently.
> > So IMHO stricter than a VM use case where migration is the only period to
> > use it.
> 
> I still don’t get the use-cases. "monitored periodically and frequently” is
> not a use-case. And as I said before, actually, monitoring frequently is
> more performant with a log than with scanning all the page-tables.

Feel free to ignore this part if we're not taking about using a ring
structure.  My previous comment was mostly for that.  Bitmaps won't have
this issue.  Here I see a bitmap as one way to implement a log, where it's
recorded by one bit per page.  My comment was that we should be careful on
using rings.

Side note: actually kvm dirty ring is even trickier; see the soft-full
(kvm_dirty_ring.soft_limit) besides the hard-full event to make sure
hard-full won't really trigger (or we're prone to lose dirty bits).  I
don't think we'll have the same issue here so we can trigger hard-full, but
it's still unwanted to halt the threads being tracked for dirty pages.  I
don't know whether there'll be other side effects by the ring, though..

> 
> > 
> >> 
> >>> 
> >>> The other thing is we can also make the log "never gonna full" by making it
> >>> a bitmap covering any registered ranges, but I don't either know whether
> >>> it'll be worth it for the effort.
> >> 
> >> I do not see a benefit of half-log half-scan. It tries to take the
> >> data-structure of one format and combine it with another.
> > 
> > What I'm saying here is not half-log / half-scan, but use a single bitmap
> > to store what page is dirty, just like KVM_GET_DIRTY_LOG.  I think it
> > avoids any above "stall" issue.
> 
> Oh, I never went into the KVM details before - stupid me. If that’s what
> eventually was proven to work for KVM/QEMU, then it really sounds like
> the pagemap solution that Muhammad proposed.
> 
> But still not convoluting pagemap with userfaultfd (and especially
> uffd-wp) can be beneficial. Linus already threw some comments here and
> there about disliking uffd-wp, and I’m not sure adding uffd-wp specific
> stuff to pagemap would be welcomed.

Yes I also don't know..  As I mentioned I'm not super happy with the
interface either, but that's the simplest I can think of so far.

IOW, from an "userfaultfd-side reviewer" POV I'm fine if someone wants to
leverage the concepts of uffd-wp and its internals using a separate but
very light weighted patch just to impl async mode of uffd-wp.  But I'm
always open to any suggestions too.  It's just that when there're multiple
options and when we're not confident on either way, I normally prefer the
simplest and cleanest (even if less efficient).

> Anyhow, thanks for all the explanations. Eventually, I understand that
> using bitmaps can be more efficient than a log if the bits are condensed.

Note that I think what Muhammad (sorry, Muhammad! I think I spelled your
name wrongly before starting from some email..) proposed is not a bitmap,
but an array of ranges that can coalesce the result into very condensed
form.  Pros and cons.

Again, I can't comment much on that API, but since there're a bunch of
other developers looking at that and they're also potential future users,
I'll trust their judgement and just focus more on the other side of things.

Thanks,

-- 
Peter Xu

