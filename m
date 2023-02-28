Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5086A5C7E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 16:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjB1P4l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 10:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjB1P4i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:56:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8D631E0D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 07:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677599746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6M2ykteJBFwPdE4Fc5PB7vibFCXhoU/gll1/xu6zk0=;
        b=R8OwL6QnQYfbCN0NH5tuz778m9YcoHcv2TeDKfmzibZPV4/zMlznpAxuO4/EYM6vRXyAqX
        fi1qEV49SpPGnJo6XHBduB2Wo3NmBTyY9IgTJijJNXSODH1I1+RTGL25LVNErXLMw9hCbx
        DXWp6c3xG6yfhTVW1+G4St0Lnn5X3zQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-zJOvQeS2P-G3H9bBrwz5eg-1; Tue, 28 Feb 2023 10:55:44 -0500
X-MC-Unique: zJOvQeS2P-G3H9bBrwz5eg-1
Received: by mail-qt1-f198.google.com with SMTP id l17-20020ac84cd1000000b003bfbae42753so4810689qtv.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 07:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677599744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6M2ykteJBFwPdE4Fc5PB7vibFCXhoU/gll1/xu6zk0=;
        b=G+TaiG0VuXS9ZnDoXWA7QibYUudn4H8Wzprv6iJnG8RPQTCVFgrPe0il+mxE8MtlNl
         kJ5zA+wts8tLTO8KYjg16n2Ad7HTFMxKsZDD8gQujAgabE7exgrJTDrYXdkGFueCJuS3
         tNRJsWmgLwa6rkJBtamxQ4AQkTIdE4iOYZ/50Fo9l34A5lZ9Y72m473/UcIFYjE+2rNP
         Jsku1h2FAknULt4V1wfRreCSpCIxJ6xmGv4rv0oNgwGp/Qd9g4L6VEENtJ+4lo7Q1+6I
         XUSZZD8CVNwF20RHDp8ZuET8eSaVDyeB8Y75bN0/PgjKVdGSIjCIQ9qPxo+HZ14cvX4H
         BDVQ==
X-Gm-Message-State: AO0yUKWFGw6OhBszGQXUboMGxVbgz1gWMxnhO+4eSPEHHkL4lsvmxKmy
        9slkOGJqFOTM6x/ziIGcM/6UtbN9waaGM9Zb8vjP5sl3v9G3fVTWAsqeB62DJPpXfm8zpXPbkKZ
        adDWcguDS+hPtIXO13doZJVRgMA==
X-Received: by 2002:ac8:580f:0:b0:3bf:daa8:cacc with SMTP id g15-20020ac8580f000000b003bfdaa8caccmr6872019qtg.3.1677599743734;
        Tue, 28 Feb 2023 07:55:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/XPVjIGEfnKjmfSsCn1612xPeb/JaaDAmV6dwmY5PblZQ38Qj9ElM25ukoj3dLGb0rICpZcw==
X-Received: by 2002:ac8:580f:0:b0:3bf:daa8:cacc with SMTP id g15-20020ac8580f000000b003bfdaa8caccmr6871879qtg.3.1677599742772;
        Tue, 28 Feb 2023 07:55:42 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id x21-20020a376315000000b007419eb86df0sm7080654qkb.127.2023.02.28.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:55:42 -0800 (PST)
Date:   Tue, 28 Feb 2023 10:55:40 -0500
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
Message-ID: <Y/4j/Nu1vp9sVI7N@x1n>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
 <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
 <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
 <c15446c5-eedd-690f-9dae-2bc12ee9eb78@collabora.com>
 <F73885A1-14AE-4820-876B-A8E6DC6D19CC@vmware.com>
 <Y/0eIUIh81jK9w2i@x1n>
 <5D5DEEED-55EB-457B-9EB7-C6D5B326FE99@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5D5DEEED-55EB-457B-9EB7-C6D5B326FE99@vmware.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:09:12PM +0000, Nadav Amit wrote:
> 
> 
> > On Feb 27, 2023, at 1:18 PM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > !! External Email
> > 
> > On Thu, Feb 23, 2023 at 05:11:11PM +0000, Nadav Amit wrote:
> >> From my experience with UFFD, proper ordering of events  is crucial, although it
> >> is not always done well. Therefore, we should aim for improvement, not
> >> regression. I believe that utilizing the pagemap-based mechanism for WP'ing
> >> might be a step in the wrong direction. I think that it would have been better
> >> to emit a 'UFFD_FEATURE_WP_ASYNC' WP-log (and ordered) with UFFD #PF and
> >> events. The 'UFFD_FEATURE_WP_ASYNC'-log may not need to wake waiters on the
> >> file descriptor unless the log is full.
> > 
> > Yes this is an interesting question to think about..
> > 
> > Keeping the data in the pgtable has one good thing that it doesn't need any
> > complexity on maintaining the log, and no possibility of "log full".
> 
> I understand your concern, but I think that eventually it might be simpler
> to maintain, since the logic of how to process the log is moved to userspace.
> 
> At the same time, handling inputs from pagemap and uffd handlers and sync’ing
> them would not be too easy for userspace.

I do not expect a common uffd-wp async user to provide a fault handler at
all.  In my imagination it's in most cases used standalone from other uffd
modes; it means all the faults will still be handled by the kernel.  Here
we only leverage the accuracy of userfaultfd comparing to soft-dirty, so
not really real "user"-faults.

> 
> But yes, allocation on the heap for userfaultfd_wait_queue-like entries would
> be needed, and there are some issues of ordering the events (I think all #PF
> and other events should be ordered regardless) and how not to traverse all
> async-userfaultfd_wait_queue’s (except those that block if the log is full)
> when a wakeup is needed.

Will there be an ordering requirement for an async mode?  Considering it
should be async to whatever else, I would think it's not a problem, but
maybe I missed something.

> 
> > 
> > If there's possible "log full" then the next question is whether we should
> > let the worker wait the monitor if the monitor is not fast enough to
> > collect those data.  It adds some slight dependency on the two threads, I
> > think it can make the tracking harder or impossible in latency sensitive
> > workloads.
> 
> Again, I understand your concern. But this model that I propose is not new.
> It is used with PML (page-modification logging) and KVM, and IIRC there is
> a similar interface between KVM and QEMU to provide this information. There
> are endless other examples for similar producer-consumer mechanisms that
> might lead to stall in extreme cases. 

Yes, I'm not against thinking of using similar structures here.  It's just
that it's definitely more complicated on the interface, at least we need
yet one more interface to setup the rings and define its interfaces.

Note that although Muhammud is defining another new interface here too for
pagemap, I don't think it's strictly needed for uffd-wp async mode.  One
can use uffd-wp async mode with PM_UFFD_WP which is with current pagemap
interface already.

So what Muhammud is proposing here are two things to me: (1) uffd-wp async,
plus (2) a new pagemap interface (which will closely work with (1) only if
we need atomicity on get-dirty and reprotect).

Defining new interface for uffd-wp async mode will be something extra, so
IMHO besides the heap allocation on the rings, we need to also justify
whether that is needed.  That's why I think it's fine to go with what
Muhammud proposed, because it's a minimum changeset at least for userfault
to support an async mode, and anything else can be done on top if necessary.

Going a bit back to the "lead to stall in extreme cases" above, just also
want to mention that the VM use case is slightly different - dirty tracking
is only heavily used during migration afaict, and it's a short period.  Not
a lot of people will complain performance degrades during that period
because that's just rare.  And, even without the ring the perf is really
bad during migration anyway... Especially when huge pages are used to back
the guest RAM.

Here it's slightly different to me: it's about tracking dirty pages during
any possible workload, and it can be monitored periodically and frequently.
So IMHO stricter than a VM use case where migration is the only period to
use it.

> 
> > 
> > The other thing is we can also make the log "never gonna full" by making it
> > a bitmap covering any registered ranges, but I don't either know whether
> > it'll be worth it for the effort.
> 
> I do not see a benefit of half-log half-scan. It tries to take the
> data-structure of one format and combine it with another.

What I'm saying here is not half-log / half-scan, but use a single bitmap
to store what page is dirty, just like KVM_GET_DIRTY_LOG.  I think it
avoids any above "stall" issue.

> 
> Anyhow, I was just giving my 2 cents. Admittedly, I did not follow the
> threads of previous versions and I did not see userspace components that
> use the API to say something smart.

Actually similar here. :) So I'm probably not the best one to describe what
is the best to look as API.

What I know is I think the new pagemap interface is welcomed by CRIU
developers, so it may be something good with/without userfaultfd getting
involved already.  I see this as "let's add one more bit for uffd-wp" in
the new interface only.

Quotting some link I got from Muhammud before with CRIU usage:

https://lore.kernel.org/all/YyiDg79flhWoMDZB@gmail.com
https://lore.kernel.org/all/20221014134802.1361436-1-mdanylo@google.com

> Personally, I do not find the current API proposal to be very consistent
> and simple, and it seems to me that it lets pagemap do
> userfaultfd-related tasks, which might be considered inappropriate and
> non-intuitive.

Yes, I agree.  I just don't know what's the best way to avoid this.

The issue here IIUC is Muhammud needs one operation to do what Windows does
with getWriteWatch() API.  It means we need to mix up GET and PROTECT in a
single shot.  If we want to use pagemap as GET, then no choice to PROTECT
also here to me.

I think it'll be the same to soft-dirty if it's used, it means we'll extend
soft-dirty modifications from clear_refs to pagemap too which I also don't
think it's as clean.

> 
> If I derailed the discussion, I apologize.

Not at all.  I just wished you joined earlier!

-- 
Peter Xu

