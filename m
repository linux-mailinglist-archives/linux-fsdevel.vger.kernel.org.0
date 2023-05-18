Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E5708AA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjERVjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 17:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjERVjI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 17:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33C9F9
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 14:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684445899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fF16NozMTAGkjTJVbzcLd4pKW6g0WKeMa5ciTZoyR8I=;
        b=C0wIZKNA0vCUPWGgZiw/ElXmIvQ/wABRkpP/nyfxLb4hcKCCPLr5/fNOk73RYrFiPvIu8q
        m6HpkMn8qhY0AfPW/stufna+Bjf8deBNSOai6foXEjsQI7GKQqA2/0ndNpGXQqANeMuqI1
        7Cf+BpAgqVNekmQqEFLCFtL3tzv/aB8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-y-9kuQbsOKCuXvHM9zbL-Q-1; Thu, 18 May 2023 17:38:18 -0400
X-MC-Unique: y-9kuQbsOKCuXvHM9zbL-Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f398a25be2so2398101cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 14:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684445898; x=1687037898;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fF16NozMTAGkjTJVbzcLd4pKW6g0WKeMa5ciTZoyR8I=;
        b=Y0+p1VO3SUhfIr2djxHjQN1njptgI/3QzkcOsj/GP1pnX0IbgvirMwaKRDAqHBAmhS
         8Z4o1kKmNgztWk/XtbTbJ/UCslU/qIRr/TscYr1aV3H1TXl679kroZPzc+KNdQnWc4Z3
         yBf3P5LN8iBjQWLQksJ1iU2E3oC9w0Jpa+Hn7PIgP6E0Vmo6ytnjL2kSKgIarsyS0Be3
         wu4RE0SrY0iDTIqqNDQoiOPoMQ3b+tVti0DMb/IFI2VgzXaF5FNva+7bpzoqN2KDDODO
         8cv/Cg1JhuyN/8H0OzuUVyUZx+kSSPescfMSHjnReoRWdgCZ0s4b2L9dChJgTN6mDx7x
         z9bw==
X-Gm-Message-State: AC+VfDy7hCX9YQb43LXhdPK7sIjF3jY0Jcc0FwsvegsVqTaPiSHvYQko
        xY/jX9c2myU6vp34NmSM0u3OD+TwWCaeTKfv5RrYGJZotOKdsiemsnGknWbUoBysY8GSANW6xGG
        88IA5PPRWJlRgaqZv0yDKb8rgSA==
X-Received: by 2002:a05:622a:1801:b0:3ef:4614:d0e9 with SMTP id t1-20020a05622a180100b003ef4614d0e9mr33313qtc.5.1684445897739;
        Thu, 18 May 2023 14:38:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4F7YYadNy4hNwuBEtJHsszBONmAwTnm70nfw8WkvP5XXBIxqCTLfGirE7l4DCLZRdFzwOonA==
X-Received: by 2002:a05:622a:1801:b0:3ef:4614:d0e9 with SMTP id t1-20020a05622a180100b003ef4614d0e9mr33285qtc.5.1684445897332;
        Thu, 18 May 2023 14:38:17 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca. [70.24.86.62])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9e905000000b0075931950b5esm670407qkf.74.2023.05.18.14.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:38:16 -0700 (PDT)
Date:   Thu, 18 May 2023 17:38:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        James Houghton <jthoughton@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Huang Ying <ying.huang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Anish Moorthy <amoorthy@google.com>
Subject: Re: [PATCH 1/3] mm: userfaultfd: add new UFFDIO_SIGBUS ioctl
Message-ID: <ZGaaxjS4jWUio+f6@x1n>
References: <20230511182426.1898675-1-axelrasmussen@google.com>
 <CADrL8HXFiTL-RDnETS2BUg_qH8CvcCMZiX-kutsrS1-8Uy25=w@mail.gmail.com>
 <ZGVRUeCWr8209m8d@x1n>
 <ZGVTMnVKNcQDM0x4@x1n>
 <CAJHvVcgXynHcuoS6eCfOAB2SgzqYy_zMGrRMR2kFuxOtSdUwvQ@mail.gmail.com>
 <CACw3F52MNOVv6KA5n7wRYDT2ujwYkco=aYngbo-zGA3zW1yq+w@mail.gmail.com>
 <ZGZMtK6PzoTuLZ1b@x1n>
 <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJHvVcgcYPu-G3RDVrkrM_J48NUiUY0SH0G1sd+=X9BDgnQEuQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 01:38:09PM -0700, Axel Rasmussen wrote:
> On Thu, May 18, 2023 at 9:05 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, May 17, 2023 at 05:43:53PM -0700, Jiaqi Yan wrote:
> > > On Wed, May 17, 2023 at 3:29 PM Axel Rasmussen <axelrasmussen@google.com> wrote:
> > > >
> > > > On Wed, May 17, 2023 at 3:20 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > On Wed, May 17, 2023 at 06:12:33PM -0400, Peter Xu wrote:
> > > > > > On Thu, May 11, 2023 at 03:00:09PM -0700, James Houghton wrote:
> > > > > > > On Thu, May 11, 2023 at 11:24 AM Axel Rasmussen
> > > > > > > <axelrasmussen@google.com> wrote:
> > > > > > > >
> > > > > > > > So the basic way to use this new feature is:
> > > > > > > >
> > > > > > > > - On the new host, the guest's memory is registered with userfaultfd, in
> > > > > > > >   either MISSING or MINOR mode (doesn't really matter for this purpose).
> > > > > > > > - On any first access, we get a userfaultfd event. At this point we can
> > > > > > > >   communicate with the old host to find out if the page was poisoned.
> > > > > > > > - If so, we can respond with a UFFDIO_SIGBUS - this places a swap marker
> > > > > > > >   so any future accesses will SIGBUS. Because the pte is now "present",
> > > > > > > >   future accesses won't generate more userfaultfd events, they'll just
> > > > > > > >   SIGBUS directly.
> > > > > > >
> > > > > > > I want to clarify the SIGBUS mechanism here when KVM is involved,
> > > > > > > keeping in mind that we need to be able to inject an MCE into the
> > > > > > > guest for this to be useful.
> > > > > > >
> > > > > > > 1. vCPU gets an EPT violation --> KVM attempts GUP.
> > > > > > > 2. GUP finds a PTE_MARKER_UFFD_SIGBUS and returns VM_FAULT_SIGBUS.
> > > > > > > 3. KVM finds that GUP failed and returns -EFAULT.
> > > > > > >
> > > > > > > This is different than if GUP found poison, in which case KVM will
> > > > > > > actually queue up a SIGBUS *containing the address of the fault*, and
> > > > > > > userspace can use it to inject an appropriate MCE into the guest. With
> > > > > > > UFFDIO_SIGBUS, we are missing the address!
> > > > > > >
> > > > > > > I see three options:
> > > > > > > 1. Make KVM_RUN queue up a signal for any VM_FAULT_SIGBUS. I think
> > > > > > > this is pointless.
> > > > > > > 2. Don't have UFFDIO_SIGBUS install a PTE entry, but instead have a
> > > > > > > UFFDIO_WAKE_MODE_SIGBUS, where upon waking, we return VM_FAULT_SIGBUS
> > > > > > > instead of VM_FAULT_RETRY. We will keep getting userfaults on repeated
> > > > > > > accesses, just like how we get repeated signals for real poison.
> > > > > > > 3. Use this in conjunction with the additional KVM EFAULT info that
> > > > > > > Anish proposed (the first part of [1]).
> > > > > > >
> > > > > > > I think option 3 is fine. :)
> > > > > >
> > > > > > Or... option 4) just to use either MADV_HWPOISON or hwpoison-inject? :)
> > > > >
> > > > > I just remember Axel mentioned this in the commit message, and just in case
> > > > > this is why option 4) was ruled out:
> > > > >
> > > > >         They expect that once poisoned, pages can never become
> > > > >         "un-poisoned". So, when we live migrate the VM, we need to preserve
> > > > >         the poisoned status of these pages.
> > > > >
> > > > > Just to supplement on this point: we do have unpoison (echoing to
> > > > > "debug/hwpoison/hwpoison_unpoison"), or am I wrong?
> > >
> > > If I read unpoison_memory() correctly, once there is a real hardware
> > > memory corruption (hw_memory_failure will be set), unpoison will stop
> > > working and return EOPNOTSUPP.
> > >
> > > I know some cloud providers evacuating VMs once a single memory error
> > > happens, so not supporting unpoison is probably not a big deal for
> > > them. BUT others do keep VM running until more errors show up later,
> > > which could be long after the 1st error.
> >
> > We're talking about postcopy migrating a VM has poisoned page on src,
> > rather than on dst host, am I right?  IOW, the dest hwpoison should be
> > fake.
> >
> > If so, then I would assume that's the case where all the pages on the dest
> > host is still all good (so hw_memory_failure not yet set, or I doubt the
> > judgement of being a migration target after all)?
> >
> > The other thing is even if dest host has hw poisoned page, I'm not sure
> > whether hw_memory_failure is the only way to solve this.
> >
> > I saw that this is something got worked on before from Zhenwei, David used
> > to have some reasoning on why it was suggested like using a global knob:
> >
> > https://lore.kernel.org/all/d7927214-e433-c26d-7a9c-a291ced81887@redhat.com/
> >
> > Two major issues here afaics:
> >
> >   - Zhenwei's approach only considered x86 hwpoison - it relies on kpte
> >     having !present in entries but that's x86 specific rather than generic
> >     to memory_failure.c.
> >
> >   - It is _assumed_ that hwpoison injection is for debugging only.
> >
> > I'm not sure whether you can fix 1) by some other ways, e.g., what if the
> > host just remember all the hardware poisoned pfns (or remember
> > soft-poisoned ones, but then here we need to be careful on removing them
> > from the list when it's hwpoisoned for real)?  It sounds like there's
> > opportunity on providing a generic solution rather than relying on
> > !pte_present().
> >
> > For 2) IMHO that's not a big issue, you can declare it'll be used in !debug
> > but production systems so as to boost the feature importance with a real
> > use case.
> >
> > So far I'd say it'll be great to leverage what it's already there in linux
> > and make it as generic as possible. The only issue is probably
> > CAP_ADMIN... not sure whether we can have some way to provide !ADMIN
> > somehow, or you can simply work around this issue.
> 
> As you mention below I think the key distinction is the scope - I
> think MADV_HWPOISON affects the whole system, including other
> processes.
> 
> For our purposes, we really just want to "poison" this particular
> virtual address (the HVA, from the VM's perspective), not even other
> mappings of the same shared memory. I think that behavior is different
> from MADV_HWPOISON, at least.
> 
> >
> > >
> > > > >
> > > > > >
> > > > > > Besides what James mentioned on "missing addr", I didn't quickly see what's
> > > > > > the major difference comparing to the old hwpoison injection methods even
> > > > > > without the addr requirement. If we want the addr for MCE then it's more of
> > > > > > a question to ask.
> > > > > >
> > > > > > I also didn't quickly see why for whatever new way to inject a pte error we
> > > > > > need to have it registered with uffd.  Could it be something like
> > > > > > MADV_PGERR (even if MADV_HWPOISON won't suffice) so you can inject even
> > > > > > without an userfault context (but still usable when uffd registered)?
> > > > > >
> > > > > > And it'll be alawys nice to have a cover letter too (if there'll be a new
> > > > > > version) explaining the bits.
> > > >
> > > > I do plan a v2, if for no other reason than to update the
> > > > documentation. Happy to add a cover letter with it as well.
> > > >
> > > > +Jiaqi back to CC, this is one piece of a larger memory poisoning /
> > > > recovery design Jiaqi is working on, so he may have some ideas why
> > > > MADV_HWPOISON or MADV_PGER will or won't work.
> > >
> > > Per https://man7.org/linux/man-pages/man2/madvise.2.html,
> > > MADV_HWPOISON "is available only for privileged (CAP_SYS_ADMIN)
> > > processes." So for a non-root VMM, MADV_HWPOISON is out of option.
> >
> > It makes sense to me especially when the page can be shared with other
> > tasks.
> >
> > >
> > > Another issue with MADV_HWPOISON is, it requires to first successfully
> > > get_user_pages_fast(). I don't think it will work if memory is not
> > > mapped yet.
> >
> > Fair point, so probably current MADV_HWPOISON got ruled out.
> > hwpoison-inject seems fine where only the PFN is needed rather than the
> > pte. But same issue on CAP_ADMIN indeed.
> >
> > >
> > > With the UFFDIO_SIGBUS feature introduced in this patchset, it may
> > > even be possible to free the emulated-hwpoison page back to the kernel
> > > so we don't lose a 4K page.
> > >
> > > I didn't find any ref/doc for MADV_PGERR. Is it something you suggest
> > > to build, Peter?
> >
> > That's something I made up just to show my question on why such an
> > interface (even if wanted) needs to be bound to userfaultfd, e.g. a
> > madvise() seems working if someone sololy want to install a poisoned pte.
> 
> I look at it a bit differently...
> 
> Even existing UFFDIO_* operations could technically be separated from
> userfaultfd. You could imagine a MADV_MAP_PAGE instead of
> UFFDIO_CONTINUE. UFFDIO_COPY is a bit trickier since it takes an
> argument, but it could be done with process_madvise(). (Granted, I'm
> not sure this would be useful... But this is equally true for
> UFFDIO_SIGBUS; it seems non-live-migration use cases could use
> MADV_HWPOISON, and for live migration use cases we will be using
> UFFD.)
> 
> We've sort of setup a convention with userfaultfd where at a high
> level users are supposed to:
> 
> 1. Receive events from the uffd
> 2. Resolve those events with UFFDIO_* ioctls
> 3. Wake up with UFFDIO_WAKE to retry the fault that generated the
> original event (can be combined with step 2 of course)
> 
> So for me, even if MADV_PGERR or similar existed, I would be tempted
> to add a UFFDIO_SIGBUS as well, even if it just calls the same
> underlying function to do the same thing, if only for consistency
> (with the idea "UFFD events are resolved by UFFD ioctls") from the
> user's perspective.

I don't worry too much on "consistency", but I'm trying to understand
whether it's more beneficial to combine it with uffd or being generic.

One thing I was thinking is if I have a library that manages some memory
for the user, the library can use such madvise()/... to poison specific
small pages (without registering uffd with sigbus mode, also no lose on
page faults of other normal pages) so when illegal access it can trap it
for current mm rather than silently happen (e.g. use after free).  Unpoison
is also easy there, we can simply DONTNEED it.

One defect of such general solution for your case is we need one more
UFFDIO_WAKE, but since we're talking about real poisoned pages on src, so I
guess it's not a concern (unlike most of the rest ioctls).

I've no strong opinion if you still want to do that with an userfault
ioctl.  After all, I can't provide a solid example but just some rough
ideas.  But I hope I explained why I think it's still different from other
ioctls (e.g., an "atomic update a page" operation doesn't sound reasonable
at all as generic operation for any !uffd context, so that definitely
suites more as an uffd specific ioctl).

If with uffd, perhaps avoid calling it sigbus? As we have FEATURE_SIGBUS
and I'm afraid it'll cause confusion.  UFFDIO_HWPOISON may sound more
suitable?

Thanks,

-- 
Peter Xu

