Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2FA32303C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 19:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhBWSHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 13:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhBWSHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:07:08 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B55DC06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 10:06:28 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id f20so18089629ioo.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vTI/ZdZz+qz8Dx2SLW9Ocz24gRVgR01CbdQNKNmll5k=;
        b=kJv3Zxq0E0xdXJMdBV0Qymaxo3EKmXLhrzNKEoR1lEq6FQ2L+KIToHQV71nOETjiu4
         jSIDazyhhQfKFV3Siq4AGLLgHpeAJgvfeNFFwl6ZBV/NypjnFAv26PscPklbQKZkbhIg
         KDaQvT5mNTADuS2BE5Z/VFllYEjnbu736vlWbV0xSE74lwfdo2P+3SMSBuWCzk2d90X5
         HmYlmKJd0nucCD/9eyNVU9egBEf6Y/sqkUNBf1FGWNLYulQ3vHiy1IEDz5FiGqsOc2JY
         bnw/q/JSbt8u8APa8ShoLnkzb05+xx30eFz/W7GHM/NuZn1EL1MmXYGVk82D0N3MXgUO
         D+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vTI/ZdZz+qz8Dx2SLW9Ocz24gRVgR01CbdQNKNmll5k=;
        b=rv+PcXnhln5DgN0UWx3RNQ1L/is0QZXqOW0FaO77A8r4Fnc31fyXqgyg5rUckCK5W4
         q8VpTMQJybKKLLNGxZiSGHSC7uXmFQg5lAMD/lOoNuCSxbgqf1mROUJg/ZpeTMT1103y
         wmA5Zmm+b+zAOxWfXZhZ0cM7xj/W51k74FsqhVG9EMWnvgVYhVbctZo3MX6JAc+i1aKt
         eGlo7ffSVT6/MaZlLDMXsvQ/ner42s1sTfUGOkiCb1a6L6RybgNHcQDWULw3sPKQVdF2
         UUk4gyCwNj57s2Jp2sG5zcfBp9xaUWpWB6GYrapCD5zZ4jAkHhbulcfenilgYbxouh1V
         E/9Q==
X-Gm-Message-State: AOAM5303QMwswKv457M/HWJku4hvmyEmJ72WMQVYjJxBtdtTMiXn6uGA
        7X+CeS0Apu7jPv2KQb5rufau+NIu56pyhoziwQQ7dw==
X-Google-Smtp-Source: ABdhPJzpHY27RWxiyNrVgREJDawnkqSWtUel0EdDg7HXH+35aHSwQVloU4RBy57ghfHc1GSt5G6KzF/z83VRwCEKrxE=
X-Received: by 2002:a6b:c84a:: with SMTP id y71mr20733760iof.86.1614103587647;
 Tue, 23 Feb 2021 10:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20210219004824.2899045-1-axelrasmussen@google.com>
 <20210219004824.2899045-5-axelrasmussen@google.com> <20210223153840.GB154711@xz-x1>
In-Reply-To: <20210223153840.GB154711@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 23 Feb 2021 10:05:49 -0800
Message-ID: <CAJHvVcg_hV0diLxyB2=JbLbJkXWTW+zsPsdzBTJW_WcG-vbvbA@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] userfaultfd: add UFFDIO_CONTINUE ioctl
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
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

On Tue, Feb 23, 2021 at 7:38 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Feb 18, 2021 at 04:48:22PM -0800, Axel Rasmussen wrote:
> > @@ -4645,8 +4646,18 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> >       spinlock_t *ptl;
> >       int ret;
> >       struct page *page;
> > +     int writable;
> >
> > -     if (!*pagep) {
> > +     mapping = dst_vma->vm_file->f_mapping;
> > +     idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> > +
> > +     if (is_continue) {
> > +             ret = -EFAULT;
> > +             page = find_lock_page(mapping, idx);
> > +             *pagep = NULL;
>
> Why set *pagep to NULL?  Shouldn't it be NULL always?.. If that's the case,
> maybe WARN_ON_ONCE(*pagep) suite more.

Right, the caller should be passing in NULL in the
MCOPY_ATOMIC_CONTINUE case. Looking more closely at the caller
(__mcopy_atomic_hugetlb), it already has a BUG_ON(page), so at best
this assignment is redundant, and at worst it might actually cover up
a real bug (say the caller mistakenly *did* pass in some page, we'd
set it to NULL and the BUG_ON wouldn't trigger).

So, I'll just remove this - I don't think an additional WARN_ON_ONCE
is needed given the existing BUG_ON.

>
> Otherwise the patch looks good to me.

Shall I add a R-B? :)

Thanks for taking the time to review Peter!

>
> Thanks,
>
> --
> Peter Xu
>
