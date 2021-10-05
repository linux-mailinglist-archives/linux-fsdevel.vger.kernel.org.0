Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4142309C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 21:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhJETRE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 15:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhJETRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:17:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9445C061749
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 12:15:11 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id a7so51384yba.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/mJ1wrJl0e2S4EbithBXePxqkT5yOeu8iCmqxY+6zM=;
        b=M1kis41L+W8a3X4xSlCWbuPFyHGcq4qAALLCMn7eMkW+D55940o+GnlKZhYo7SfEFf
         eKx6U0ezgxMJKf89ERCwNbfcEjqSrgI8bXetehSKbTq3hBALUwCIZPjkpgB+cjunVdCS
         WUOM7tVLgucnzyc8N7gK6PqKOxIpKi31m9jpvL6Suhi3ntBbP04Ksv5mHZBiqQ5gDMuB
         mlnsP6U61UcL/L4VlXu/rhMogaYmgD7B9TYlwJp7ET39MVF2lwNWW/NYA9HVlvbQWWyg
         +U9pskA/P247x4+EuPoUg8wGV/hMoaBW2hCKqC5njS/cSZCbY21y0BxIUGtwBZcfJF1H
         84mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/mJ1wrJl0e2S4EbithBXePxqkT5yOeu8iCmqxY+6zM=;
        b=LAtfMzwLni25Zkg4Sh0ozRFsOB45kkc7U8WrncHysyndgSuykXoNcLJ2vZDfk77b2n
         ToSZ29BacBE7W5aBmiGRHwNpscT5zrnI28JVZ4MwAOI6EactAQQ2gfFY7doF2PmiRerc
         iglzAXH7y0v7FlPkDG7/UA/q3FTPaI8MZfO0EGRYsSZgNTt1UidDmO1VpPNEbVo2+CN+
         sg8cblO2KoPSMaCxMIqrCyUpij/G+hhpOdvOlZGc40FYXOizr0a7RYWGildc9TK5SEZv
         y7EanusrMnAXehuLjZX9vddnLA6FRLARea3tOF6mEl9uRYIZ7GULYGsYk8HodnoBaxEs
         tzwg==
X-Gm-Message-State: AOAM533oYZ5SFq1rroSN+HX3Cxx5Uhrbr+axzwyIy68dTGF+bRwfoSuB
        TkS9ty47sc3uyx84mYKG6r4o11VKrXxB3GkheU3PRw==
X-Google-Smtp-Source: ABdhPJxa45KExZ/7k/RCApHcxypXu8XAAvYJq3w4XtzePMFBwOXwgWrUVZ+OKZLOGNg4W5UYgNh720duxvdX3NBhPKs=
X-Received: by 2002:a25:5646:: with SMTP id k67mr25382729ybb.127.1633461310475;
 Tue, 05 Oct 2021 12:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz>
In-Reply-To: <20211005184211.GA19804@duo.ucw.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 5 Oct 2021 12:14:59 -0700
Message-ID: <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Peter Xu <peterx@redhat.com>, rppt@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        vincenzo.frascino@arm.com,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        John Hubbard <jhubbard@nvidia.com>,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        chris.hyser@oracle.com, Peter Collingbourne <pcc@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org,
        Rolf Eike Beer <eb@emlix.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Cedeno <thomascedeno@google.com>, sashal@kernel.org,
        cxfcosmos@gmail.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 5, 2021 at 11:42 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2021-10-01 13:56:57, Suren Baghdasaryan wrote:
> > While forking a process with high number (64K) of named anonymous vmas the
> > overhead caused by strdup() is noticeable. Experiments with ARM64
> Android
>
> I still believe you should simply use numbers and do the
> numbers->strings mapping in userspace. We should not need to optimize
> strdups in kernel...

Here are complications with mapping numbers to strings in the userspace:
Approach 1: hardcode number->string in some header file and let all
tools use that mapping. The issue is that whenever that mapping
changes all the tools that are using it (including 3rd party ones)
have to be rebuilt. This is not really maintainable since we don't
control 3rd party tools and even for the ones we control, it will be a
maintenance issue figuring out which version of the tool used which
header file.
Approach 2: have a centralized facility (a process or a DB)
maintaining number->string mapping. This would require an additional
request to this facility whenever we want to make a number->string
conversion. Moreover, when we want to name a VMA, we would have to
register a new VMA name in that facility or check that one already
exists and get its ID. So each prctl() call to name a VMA will be
preceded by such a request (IPC call), maybe with some optimizations
to cache already known number->string pairs. This would be quite
expensive performance-wise. Additional issue with this approach is
that this mapping will have to be persistent to handle a case when the
facility crashes and has to be restored.

As I said before, it complicates userspace quite a bit. Is that a good
enough reason to store the names in the kernel and pay a little more
memory for that? IMHO yes, but I might be wrong.
Thanks,
Suren.

>
> Best regards,
>                                                                 Pavel
> --
> http://www.livejournal.com/~pavelmachek
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
