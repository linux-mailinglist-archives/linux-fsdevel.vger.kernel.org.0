Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0AF44BCD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 09:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhKJIaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 03:30:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230235AbhKJIaQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:30:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636532849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zky/vWToC3C8LiDo8BNPLluCNBMJ39ylhYqpXz2GoPI=;
        b=DLqjjdQfCGUdtqTHSdnziDN9igmqtS9QEXT5Nxe8P86BW7Pbk64rEOGfz8+eWDKIEOKXsF
        jI1uPZeuet/cfkP0qnMmkkRkeVq/B2rQ7AOxI3tJ8BqcY72SZAxalUyY+ZLdCVY2Zz07n1
        sPPJNVfOFVpBq7wo5qJQ1yh8Sseijp0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-EqWLK0QsPduKEd8M2sz4qA-1; Wed, 10 Nov 2021 03:27:27 -0500
X-MC-Unique: EqWLK0QsPduKEd8M2sz4qA-1
Received: by mail-pg1-f200.google.com with SMTP id v63-20020a632f42000000b002cc65837088so1172925pgv.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Nov 2021 00:27:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zky/vWToC3C8LiDo8BNPLluCNBMJ39ylhYqpXz2GoPI=;
        b=XDo04DCvklyA0nXegJqu4sU8sMKoZpCJn+TSFpi7aDfdN9ah6zCLjIvU8iFhiTl/Yw
         QkebfoBUTRduwofIye6vN5U0e8GJsMf4zBKheoxhF3L/8M9+wyMuGP67ve9GUQGiRAKX
         85p3HgzY4ddKmqaojP64b2QeYsLfFVtTtLaJ++AfCspNOkiCmtuHGU0H3rTruGG+HOhj
         x/dI68vF3ZrPUsIONOJpjNns91ThtRBa54ENmhfwcqOVuSf9fEC6QyZXE26YjpKEc8AT
         u9tO9OM0L0ZFNHEteVTk/7JG5RH8rujaeQSH1GHgJkAbEzmDxBxRICES19fv7TIO0wbE
         ymlA==
X-Gm-Message-State: AOAM532u2I/jwC/mzA1h3PPz7Z5gx9K08gF4VI+O4CjTGeiFVOjeDKMI
        QwmJECC//omaGPz9iat8TaQURX2QrQdnNM9aKlV5Z9kq5ieI57NopX6YlsEAu4s1sFUb0B0zZcp
        ZAE0Rhn2gd9GU6i/RPg5cRXkUPw==
X-Received: by 2002:a05:6a00:1151:b0:492:62e1:5968 with SMTP id b17-20020a056a00115100b0049262e15968mr14506323pfm.75.1636532846742;
        Wed, 10 Nov 2021 00:27:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOKflnGQgX7O2PA+X5kdlAqd3MkOusyaBbTGvH2hKDFVlvijLehbB5yQCaRdyGTfDaYWw8ZA==
X-Received: by 2002:a05:6a00:1151:b0:492:62e1:5968 with SMTP id b17-20020a056a00115100b0049262e15968mr14506300pfm.75.1636532846480;
        Wed, 10 Nov 2021 00:27:26 -0800 (PST)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u10sm21143749pfh.49.2021.11.10.00.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 00:27:25 -0800 (PST)
Date:   Wed, 10 Nov 2021 16:27:20 +0800
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
Message-ID: <YYuCaNXikls/9JhS@t490s>
References: <20211107235754.1395488-1-almasrymina@google.com>
 <YYtuqsnOSxA44AUX@t490s>
 <c5ed86d0-8af6-f54f-e352-8871395ad62e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5ed86d0-8af6-f54f-e352-8871395ad62e@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 10, 2021 at 09:14:42AM +0100, David Hildenbrand wrote:
> On 10.11.21 08:03, Peter Xu wrote:
> > Hi, Mina,
> > 
> > Sorry to comment late.
> > 
> > On Sun, Nov 07, 2021 at 03:57:54PM -0800, Mina Almasry wrote:
> >> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> >> index fdc19fbc10839..8a0f0064ff336 100644
> >> --- a/Documentation/admin-guide/mm/pagemap.rst
> >> +++ b/Documentation/admin-guide/mm/pagemap.rst
> >> @@ -23,7 +23,8 @@ There are four components to pagemap:
> >>      * Bit  56    page exclusively mapped (since 4.2)
> >>      * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
> >>        :ref:`Documentation/admin-guide/mm/userfaultfd.rst <userfaultfd>`)
> >> -    * Bits 57-60 zero
> >> +    * Bit  58    page is a huge (PMD size) THP mapping
> >> +    * Bits 59-60 zero
> >>      * Bit  61    page is file-page or shared-anon (since 3.5)
> >>      * Bit  62    page swapped
> >>      * Bit  63    page present
> >> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >> index ad667dbc96f5c..6f1403f83b310 100644
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -1302,6 +1302,7 @@ struct pagemapread {
> >>  #define PM_SOFT_DIRTY		BIT_ULL(55)
> >>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
> >>  #define PM_UFFD_WP		BIT_ULL(57)
> >> +#define PM_HUGE_THP_MAPPING	BIT_ULL(58)
> > 
> > The ending "_MAPPING" seems redundant to me, how about just call it "PM_THP" or
> > "PM_HUGE" (as THP also means HUGE already)?
> > 
> > IMHO the core problem is about permission controls, and it seems to me we're
> > actually trying to workaround it by duplicating some information we have.. so
> > it's kind of a pity.  Totally not against this patch, but imho it'll be nicer
> > if it's the permission part that to be enhanced, rather than a new but slightly
> > duplicated interface.
> 
> It's not a permission problem AFAIKS: even with permissions "changed",
> any attempt to use /proc/kpageflags is just racy. Let's not go down that
> path, it's really the wrong mechanism to export to random userspace.

I agree it's racy, but IMHO that's fine.  These are hints for userspace to make
decisions, they cannot be always right.  Even if we fetch atomically and seeing
that this pte is swapped out, it can be quickly accessed at the same time and
it'll be in-memory again.  Only if we can freeze the whole pgtable but we
can't, so they can only be used as hints.

> 
> We do have an interface to access this information from userspace
> already: /proc/self/smaps IIRC. Mina commented that they are seeing
> performance issues with that approach.
> 
> It would be valuable to add these details to the patch description,
> including a performance difference when using both interfaces we have
> available. As the patch description stands, there is no explanation
> "why" we want this change.

I didn't notice Mina mention about performance issues with kpageflags, if so
then I agree this solution helps.  I doubt the performance is an issue, though,
as THP info shouldn't be something changing rapidly so it should be some hint
to do sanity checks only (e.g., to make sure no unwanted split of THP
happening, but the scanning should not require to be super fast; it could be
done with a relatively long scanning period).  If there's a performance
concern, yes it would be great to mention it too in the commit message.

-- 
Peter Xu

