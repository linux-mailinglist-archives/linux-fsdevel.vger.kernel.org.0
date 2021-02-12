Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076B831A635
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 21:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhBLUse (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 15:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhBLUsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:48:31 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAACEC0613D6
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 12:47:50 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id p15so396102ilq.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 12:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHQMdD4M/9n7kXDwApYNepXGgL4rr9toLyZC0YSWleM=;
        b=J1hnM+AVDAhiSATGl302gnQnCE/GOG7MuY62LilWK/sdFL812lS2Bdqnf2fQLH9VpQ
         SzmM1gCQNMH+gRnJHEedOgSB3Mxjd191Ve34rKxUCz5aBpMdmt9/wlQPW1Ce50WtxbgD
         ON5AlHpe8LT/nAzSpaTKz/4vknmVfNj08uFk6yL59XBq/0Ko7BpXjjOFhaT1xzn1crr1
         oBcOPnRHOs3uv6kGiQnYHuOJr6phnsc+C3h5/yo4cZtENlUTCm8GccwJmpvr8IZZnDLQ
         1Al2Ar8xTeYt+YJhhLB/xRjTwu1E+2S0h7j17nJ7oZKsEhogLRs7vJZqZW2IZiAi+K+s
         DynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHQMdD4M/9n7kXDwApYNepXGgL4rr9toLyZC0YSWleM=;
        b=NsLoMaI9pquLaicwHTesJyzFYBNRtRhfEDMa2khiwLu/OU5PWeWbHBIi7kFW0F2HKC
         Wbcg0POku4/T2b5+YCNhwQ65fHsfJMVFCzOgWjmZ8xt0YksdEmjLblbiRERVqCHG8BDg
         hIpQkX314qTB4O/uxi2My+tOmUwxLQdqGXTVZ64n+8luethbcXJRkwaul8liZ1VGy1Gn
         nGKjOVnQZ+ceSmpFHybmWRkPqd+eMIrEJfvm5v97PTPi5pwzBz9IjjnhwCs3orlGxP6B
         jmouRUmGsG9dzEgCWLDPywI3/AI1WysrzDMpwwldBl2iYbRteBIAmjZEoXnbbleVN69d
         BPrg==
X-Gm-Message-State: AOAM533YXFdSb31BMpl0ZTW5IN/u6940Pzl9df0U1le9nO7sv/n8Gpw6
        gokODz/MlSIINcESnkK2sCcewC0yO0NzBrbCAQhBMw==
X-Google-Smtp-Source: ABdhPJy7X2kavmCOVJnqOgE4aEszNs9PZjIWjqj0Wwe57tdEHfPYv7JFz1/cCUxHzeX2/mUbeHqaY8XYstpcrrvvp4M=
X-Received: by 2002:a92:c941:: with SMTP id i1mr3869403ilq.258.1613162870096;
 Fri, 12 Feb 2021 12:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20210210212200.1097784-1-axelrasmussen@google.com>
 <20210210212200.1097784-3-axelrasmussen@google.com> <0a991b83-18f8-cd76-46c0-4e0dcd5c87a7@oracle.com>
 <20210212204028.GC3171@xz-x1>
In-Reply-To: <20210212204028.GC3171@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 12 Feb 2021 12:47:12 -0800
Message-ID: <CAJHvVchJtjpjNUYTGw1m568w_GTK_KMKbu0MLyvK8gcbrs6S7A@mail.gmail.com>
Subject: Re: [PATCH v5 02/10] hugetlb/userfaultfd: Forbid huge pmd sharing
 when uffd enabled
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 12, 2021 at 12:40 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 11, 2021 at 04:19:55PM -0800, Mike Kravetz wrote:
> > want_pmd_share() is currently just a check for CONFIG_ARCH_WANT_HUGE_PMD_SHARE.
> > How about leaving that mostly as is, and adding the new vma checks to
> > vma_shareable().  vma_shareable() would then be something like:
> >
> >       if (!(vma->vm_flags & VM_MAYSHARE))
> >               return false;
> > #ifdef CONFIG_USERFAULTFD
> >       if (uffd_disable_huge_pmd_share(vma)
> >               return false;
> > #endif
> > #ifdef /* XXX */
> >       /* add other checks for things like uffd wp and soft dirty here */
> > #endif /* XXX */
> >
> >       if (range_in_vma(vma, base, end)
> >               return true;
> >       return false;
> >
> > Of course, this would require we leave the call to vma_shareable() at the
> > beginning of huge_pmd_share.  It also means that we are always making a
> > function call into huge_pmd_share to determine if sharing is possible.
> > That is not any different than today.  If we do not want to make that extra
> > function call, then I would suggest putting all that code in want_pmd_share.
> > It just seems that all the vma checks for sharing should be in one place
> > if possible.
>
> I don't worry a lot on that since we've already got huge_pte_alloc() which
> takes care of huge pmd sharing case, so I don't expect e.g. even most hugetlb
> developers to use want_pmd_share() at all, because huge_pte_alloc() will be the
> one that frequently got called.
>
> But yeah we can definitely put the check logic into huge_pmd_share() too.
> Looking at above code it looks still worth a helper like want_pmd_share() or
> with some other name.  Then... instead of making this complicated, how about I
> mostly keep this patch but move want_pmd_share() call into huge_pmd_share()
> instead?
>
> Btw, Axel, it seems there will still be some respins on the pmd sharing
> patches.  Since it turns out it'll be shared by multiple tasks now, do you mind
> I pick those out and send them separately?  Then we can consolidate this part
> to move on with either the rest of the tasks we've got on hand.

Sounds good to me. :) Thanks Peter + Mike for working on this!

>
> Thanks,
>
> --
> Peter Xu
>
