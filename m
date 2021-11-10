Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DCE44BD73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 09:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhKJJAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 04:00:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhKJJAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 04:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636534657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3KAQ2TyWknxx/QWCYCyvuZx1be3dMQ9P5XgzUpSmndc=;
        b=MZDhOT/lTm7o5GtbTCHSDiqSXaqNIowNt3b2ThU7g3/lLA3BRVjcb9L4FuuI2FhTJ3kgk9
        GDdrv7R2i+nsD8UPYQAsVt5a1nP4OYu3CtJ9wh8r1x6yVlvLW/SvK44Fk1Ghsae5SNefEv
        +6anAF9MAvvuXpTZCTXl6qMlMIcmkjU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-IoL9pQJCM4iYQhd5iL68JA-1; Wed, 10 Nov 2021 03:57:36 -0500
X-MC-Unique: IoL9pQJCM4iYQhd5iL68JA-1
Received: by mail-pj1-f71.google.com with SMTP id x6-20020a17090a6c0600b001a724a5696cso693134pjj.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 00:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3KAQ2TyWknxx/QWCYCyvuZx1be3dMQ9P5XgzUpSmndc=;
        b=YF2AaSNJNZUyf9xHwe0aNnq1vNCeJJYPqoSdJvDEr+upgNIyIqwLPGEq0aFoW2zMGN
         HXycPQ/DT7UNe8QWgSJURcfKkm910M0tbPCmw45m9JOdg8SE+KIA0bEqaDzucylsfrHx
         N5h9PoRThhN5NNbqmqTE1YHc0blzLVGWjNCIW7BWWcJsGQh6XtknlacBdyA2YPNM/WPR
         GFySU72BUnzaELtpyUnI9Qnn1fOjpYXJhut/YPryV8RXMh2alioX3FBxErHdXhvBxAvw
         eOM1XI8ONhNVRP2+u5wuJ0PXgOxzhXPcOgtG1aEcv1AooN/yU1RWZra29iOjS+xtvPNV
         zUsA==
X-Gm-Message-State: AOAM531jNrFvvommHSQaCKx9+mhVZI2DGddf0EA9bdsjfJRbqJPHG5jE
        ndIFADLj3sO8ChR+cmGIBFKKlDHMRiaUfWNCAUsR/UT6PVEs8R3VTR/b0RGfuafSLEHvz9yv9tk
        gUuoaH/I8zz9kZFillOUN2T37eQ==
X-Received: by 2002:a63:8b4b:: with SMTP id j72mr10705952pge.10.1636534655294;
        Wed, 10 Nov 2021 00:57:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYVeA1YbnxCLJHeUVTE40Yp83p8k+PlYnN0X+h7COcawOK6O3AMBdyxxdFewwYzccU/o+c1Q==
X-Received: by 2002:a63:8b4b:: with SMTP id j72mr10705930pge.10.1636534654994;
        Wed, 10 Nov 2021 00:57:34 -0800 (PST)
Received: from xz-m1.local ([94.177.118.35])
        by smtp.gmail.com with ESMTPSA id x33sm11454976pfh.133.2021.11.10.00.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 00:57:34 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:57:27 +0800
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmckrcu@fb.com>,
        Yu Zhao <yuzhao@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <florian.schmidt@nutanix.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Add PM_HUGE_THP_MAPPING to /proc/pid/pagemap
Message-ID: <YYuJd9ZBQiY50dVs@xz-m1.local>
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s>
 <c5ed86d0-8af6-f54f-e352-8871395ad62e@redhat.com>
 <YYuCaNXikls/9JhS@t490s>
 <793685d2-be3f-9a74-c9a3-65c486e0ef1f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <793685d2-be3f-9a74-c9a3-65c486e0ef1f@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:30:50AM +0100, David Hildenbrand wrote:
> On 10.11.21 09:27, Peter Xu wrote:
> > On Wed, Nov 10, 2021 at 09:14:42AM +0100, David Hildenbrand wrote:
> >> On 10.11.21 08:03, Peter Xu wrote:
> >>> Hi, Mina,
> >>>
> >>> Sorry to comment late.
> >>>
> >>> On Sun, Nov 07, 2021 at 03:57:54PM -0800, Mina Almasry wrote:
> >>>> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> >>>> index fdc19fbc10839..8a0f0064ff336 100644
> >>>> --- a/Documentation/admin-guide/mm/pagemap.rst
> >>>> +++ b/Documentation/admin-guide/mm/pagemap.rst
> >>>> @@ -23,7 +23,8 @@ There are four components to pagemap:
> >>>>      * Bit  56    page exclusively mapped (since 4.2)
> >>>>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
> >>>>        :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
> >>>> -    * Bits 57-60 zero
> >>>> +    * Bit  58    page is a huge (PMD size) THP mapping
> >>>> +    * Bits 59-60 zero
> >>>>      * Bit  61    page is file-page or shared-anon (since 3.5)
> >>>>      * Bit  62    page swapped
> >>>>      * Bit  63    page present
> >>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >>>> index ad667dbc96f5c..6f1403f83b310 100644
> >>>> --- a/fs/proc/task_mmu.c
> >>>> +++ b/fs/proc/task_mmu.c
> >>>> @@ -1302,6 +1302,7 @@ struct pagemapread {
> >>>>  #define PM_SOFT_DIRTY		BIT_ULL(55)
> >>>>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
> >>>>  #define PM_UFFD_WP		BIT_ULL(57)
> >>>> +#define PM_HUGE_THP_MAPPING	BIT_ULL(58)
> >>>
> >>> The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
> >>> "PM_HUGE" (as THP also means HUGE already)?
> >>>
> >>> IMHO the core problem is about permission controls, and it seems to me we're
> >>> actually trying to workaround it by duplicating some information we have.. so
> >>> it's kind of a pity.  Totally not against this patch, but imho it'll be nicer
> >>> if it's the permission part that to be enhanced, rather than a new but slightly
> >>> duplicated interface.
> >>
> >> It's not a permission problem AFAIKS: even with permissions "changed",
> >> any attempt to use /proc/kpageflags is just racy. Let's not go down that
> >> path, it's really the wrong mechanism to export to random userspace.
> > 
> > I agree it's racy, but IMHO that's fine.  These are hints for userspace to make
> > decisions, they cannot be always right.  Even if we fetch atomically and seeing
> > that this pte is swapped out, it can be quickly accessed at the same time and
> > it'll be in-memory again.  Only if we can freeze the whole pgtable but we
> > can't, so they can only be used as hints.
> 
> Sorry, I don't think /proc/kpageflags (or exporting the PFNs to random
> users via /proc/self/pagemap) is the way to go.
> 
> "Since Linux 4.0 only users with the CAP_SYS_ADMIN capability can get
> PFNs. In 4.0 and 4.1 opens by unprivileged fail with -EPERM.  Starting
> from 4.2 the PFN field is zeroed if the user does not have
> CAP_SYS_ADMIN. Reason: information about PFNs helps in exploiting
> Rowhammer vulnerability."

IMHO these are two problems that you mentioned.  That's also what I was
wondering about: could the app be granted with CAP_SYS_ADMIN then?

I am not sure whether that'll work well with /proc/kpage* though, as it's by
default 0400.  So perhaps we need to manual adjust the file permission too to
make sure the app can both access PFNs (with SYS_ADMIN) and the flags.  Totally
no expert on the permissions..

> 
> > 
> >>
> >> We do have an interface to access this information from userspace
> >> already: /proc/self/smaps IIRC. Mina commented that they are seeing
> >> performance issues with that approach.
> >>
> >> It would be valuable to add these details to the patch description,
> >> including a performance difference when using both interfaces we have
> >> available. As the patch description stands, there is no explanation
> >> "why" we want this change.
> > 
> > I didn't notice Mina mention about performance issues with kpageflags, if so
> > then I agree this solution helps. 
> The performance issue seems to be with /proc/self/smaps.

This also reminded me that we've got issue with smaps being too slow, and in
many cases we're only interested in a small portion of the whole memory.  This
made me wonder how about a new smaps interface taking memory range as input.

Thanks,

-- 
Peter Xu

