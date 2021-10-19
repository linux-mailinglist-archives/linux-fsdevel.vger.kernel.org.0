Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761DC433D86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 19:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhJSRfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 13:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJSRfv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 13:35:51 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0DAC06161C;
        Tue, 19 Oct 2021 10:33:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t16so15783404eds.9;
        Tue, 19 Oct 2021 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDQrgeBBdj7+sNzmDhSvbOy+V1aJaoieSzO0LPZ0UBQ=;
        b=WdSib3WA5xtL3NT4m8nYjRxvBuYKT2HPI9bdArHvTIdntwX/EJxC3q1N9Ealrec/Ed
         EboMKpTZ7QBYE8CCrozRyB+QrWHK2yiK3OhRO2lslTTCjQ4PvBxw19nWBbMXQ89AA0L/
         OlwqD8pO8aJhIhY7C5Yog3uLNRbLUlK2VniNTQuHVcK/NpCdPBZ7Cu/PdhXKEKx38yNK
         r53iHPIe6M+FzyrAWe+A4KNJwQwgSj28VjKGYmOMHsmQA6w9IcMj1G+mrq7U+Nx/zj2U
         QgyaYejhCWU9H2n4ZS33kvgIJP+rew5XuREAP0zKtcFTbVLG9EYIX/3E7WsIVX8oTG1P
         4e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDQrgeBBdj7+sNzmDhSvbOy+V1aJaoieSzO0LPZ0UBQ=;
        b=am7IcYvf4MHFtOjFXPSCbsyT6rc3y+/KhYWvr443D9uBe0fYBDD47+ferXi/vm4ho1
         bmtQ3FqGkIH6k79MyA3ZgTzdxLlJnUBRwP1AOaQrTn81LVbwuWkSgojaibHieWKBcAKZ
         lP99N03+EpVPDlkzXYtsc029fS+5wLCLhcaP6xAWHrSTcOZ7MLdd3AGBYPyW5tGjK82g
         qEfPda7btDrxMVbP1O+UrTc5ibVESDXbkKiexx3WkpRKq9vo7uDFRPCCfrIGIkrennjP
         desrNWtkYYSBpan5CT+Gpo7Nx7RAltFAFHvqOo3e4dwtK478yMS0wyJzNVERpmKpPf0/
         q8NA==
X-Gm-Message-State: AOAM530YhytClmOhjzeZvkdfnotoI2HSWYKC/TXQy5SiolHx8oiySr78
        fscIQyT5NHSTAr7Gvis/JYsC/OOi7xhFNscWnJk=
X-Google-Smtp-Source: ABdhPJzfRVLY8ly+7FOTJ8oOxZqnGAziwsbm2f58FxSCMLEld3hYmdKuDUphVrqbiLyiDEUxFPLU22Qom4GYPYL/p6A=
X-Received: by 2002:a17:906:a94b:: with SMTP id hh11mr40207964ejb.85.1634664735608;
 Tue, 19 Oct 2021 10:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211014191615.6674-1-shy828301@gmail.com> <20211019055347.GD2268449@u2004>
In-Reply-To: <20211019055347.GD2268449@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 19 Oct 2021 10:32:04 -0700
Message-ID: <CAHbLzkpBusb2wmifocodcpWwC5q=1g6Cpn8HHHXZNq2=PD977g@mail.gmail.com>
Subject: Re: [RFC v4 PATCH 0/6] Solve silent data loss caused by poisoned page
 cache (shmem/tmpfs)
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:53 PM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Thu, Oct 14, 2021 at 12:16:09PM -0700, Yang Shi wrote:
> >
> > When discussing the patch that splits page cache THP in order to offline the
> > poisoned page, Noaya mentioned there is a bigger problem [1] that prevents this
> > from working since the page cache page will be truncated if uncorrectable
> > errors happen.  By looking this deeper it turns out this approach (truncating
> > poisoned page) may incur silent data loss for all non-readonly filesystems if
> > the page is dirty.  It may be worse for in-memory filesystem, e.g. shmem/tmpfs
> > since the data blocks are actually gone.
> >
> > To solve this problem we could keep the poisoned dirty page in page cache then
> > notify the users on any later access, e.g. page fault, read/write, etc.  The
> > clean page could be truncated as is since they can be reread from disk later on.
> >
> > The consequence is the filesystems may find poisoned page and manipulate it as
> > healthy page since all the filesystems actually don't check if the page is
> > poisoned or not in all the relevant paths except page fault.  In general, we
> > need make the filesystems be aware of poisoned page before we could keep the
> > poisoned page in page cache in order to solve the data loss problem.
> >
> > To make filesystems be aware of poisoned page we should consider:
> > - The page should be not written back: clearing dirty flag could prevent from
> >   writeback.
> > - The page should not be dropped (it shows as a clean page) by drop caches or
> >   other callers: the refcount pin from hwpoison could prevent from invalidating
> >   (called by cache drop, inode cache shrinking, etc), but it doesn't avoid
> >   invalidation in DIO path.
> > - The page should be able to get truncated/hole punched/unlinked: it works as it
> >   is.
> > - Notify users when the page is accessed, e.g. read/write, page fault and other
> >   paths (compression, encryption, etc).
> >
> > The scope of the last one is huge since almost all filesystems need do it once
> > a page is returned from page cache lookup.  There are a couple of options to
> > do it:
> >
> > 1. Check hwpoison flag for every path, the most straightforward way.
> > 2. Return NULL for poisoned page from page cache lookup, the most callsites
> >    check if NULL is returned, this should have least work I think.  But the
> >    error handling in filesystems just return -ENOMEM, the error code will incur
> >    confusion to the users obviously.
> > 3. To improve #2, we could return error pointer, e.g. ERR_PTR(-EIO), but this
> >    will involve significant amount of code change as well since all the paths
> >    need check if the pointer is ERR or not just like option #1.
> >
> > I did prototype for both #1 and #3, but it seems #3 may require more changes
> > than #1.  For #3 ERR_PTR will be returned so all the callers need to check the
> > return value otherwise invalid pointer may be dereferenced, but not all callers
> > really care about the content of the page, for example, partial truncate which
> > just sets the truncated range in one page to 0.  So for such paths it needs
> > additional modification if ERR_PTR is returned.  And if the callers have their
> > own way to handle the problematic pages we need to add a new FGP flag to tell
> > FGP functions to return the pointer to the page.
> >
> > It may happen very rarely, but once it happens the consequence (data corruption)
> > could be very bad and it is very hard to debug.  It seems this problem had been
> > slightly discussed before, but seems no action was taken at that time. [2]
> >
> > As the aforementioned investigation, it needs huge amount of work to solve
> > the potential data loss for all filesystems.  But it is much easier for
> > in-memory filesystems and such filesystems actually suffer more than others
> > since even the data blocks are gone due to truncating.  So this patchset starts
> > from shmem/tmpfs by taking option #1.
>
> Thank you for the work. I have a few comment on todo...
>
> >
> > TODO:
> > * The unpoison has been broken since commit 0ed950d1f281 ("mm,hwpoison: make
> >   get_hwpoison_page() call get_any_page()"), and this patch series make
> >   refcount check for unpoisoning shmem page fail.
>
> It's OK to leave unpoison unsolved now. I'm working on this now (revising
> v1 patch [1]), but I'm facing some race issue cauisng kernel panic with kernel
> mode page fault, so I need to solve it.
>
> [1] https://lore.kernel.org/linux-mm/20210614021212.223326-1-nao.horiguchi@gmail.com/

Thanks.

>
> > * Expand to other filesystems.  But I haven't heard feedback from filesystem
> >   developers yet.
>
> I think that hugetlbfs can be a good next target because it's similar to
> shmem in that it's in-memory filesystem.

Yeah, I agree. Will look into it later. Thanks for the suggestion.

>
> Thanks,
> Naoya Horiguchi
