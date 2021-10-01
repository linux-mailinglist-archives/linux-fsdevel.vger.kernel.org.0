Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8DD41F22F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 18:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354958AbhJAQgF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhJAQgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:36:04 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E8AC06177E
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 Oct 2021 09:34:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g6so4636649ybb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Oct 2021 09:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ng6JDVwxCaQ8Od84ybUMD2tq3euaLTCb3M9qHCPLiRk=;
        b=pWMrJuJhvcJ8kr7fX2piDmdGOeTPIu6T7Ho6tdDljq/6BkXtPtkfuXNxbt+VAqT0yx
         qxH/KnQhNeeeJUh0T0GkC6QwHIxhqylRWcgJyXMU+D6CEa1A2xn3JkoGhw6s1Gc+6MsL
         ldOkQXXl1f/J28Sh7R0D3OzTkx/zoHPdUWAcXgmv7vIlZJmvWyWWLCtMASYrqv0cHOIu
         xCiqq/L6s1VtjDKAFFZ4nN/n1H5YNknX/iIT7eaOoy5vqUnPIkcIofbg2CwaVcWRlIgh
         eIrXGyMuXaA4shxX3MN9QTuMdzpFe/4ddYSukhdrsyyKn3FJSo2U9wi3edKON9VPPnaw
         zZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng6JDVwxCaQ8Od84ybUMD2tq3euaLTCb3M9qHCPLiRk=;
        b=ekvEmkDIr/lsrVYMC86uC+pQ4SuJnYY/X4Ev1VD6L3Tf8MCxHCWUB6AU64KhyvQlcB
         h4GMm7rksyN6k2Ajxiphw+t6gKk2ZcCrZBXjPP04g9DGsCtyxFm7dx0MPvfXM0JTLGdX
         dDtfvyV5jf/QfRIacRWIGFm5mF1amIMiZxSz57W9s3b4qQnTXcDRy+0IjRLGyR+P1N/u
         ShcWBOyojN+eFoIK4poB5aoA3dTBgPkLiwDHweHzGgfNAz9/m7qXU/2yI4CUq91wDsgX
         Crs/hLddg0lp7CIeWL1VcUi1tvhJbBPsYlsqRoK87OlpHv1qoUJ4OH2boMD72AhvtZ5v
         f0Qg==
X-Gm-Message-State: AOAM532gfmJAWCyyFF39Yfvgpa3QzmOBECopuAbfU6w70nod5LkFVoBU
        C8lK6S027pVYt6DLj++2ASAVeg46C5tDbISmmbWPXQ==
X-Google-Smtp-Source: ABdhPJy4E0vJOJpFn2dtFuJvIo31XqxsO2A2l/zIgkxN2EgX2oY+90UDMspe6mET/djpD5FLURGDgJHVOkdXu1D6ku4=
X-Received: by 2002:a05:6902:124f:: with SMTP id t15mr8144006ybu.161.1633106059244;
 Fri, 01 Oct 2021 09:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210902231813.3597709-1-surenb@google.com> <20210902231813.3597709-2-surenb@google.com>
 <d8619a98-2380-ca96-001e-60fe9c6204a6@rasmusvillemoes.dk>
In-Reply-To: <d8619a98-2380-ca96-001e-60fe9c6204a6@rasmusvillemoes.dk>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 1 Oct 2021 09:34:08 -0700
Message-ID: <CAJuCfpH1csz6ghiQ+oHQ6qcs8hUp6qXEVknm3kRpZuUvwB7pRA@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] mm: add a field to store names for private
 anonymous memory
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
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
        cxfcosmos@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 1, 2021 at 12:01 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 03/09/2021 01.18, Suren Baghdasaryan wrote:
> > From: Colin Cross <ccross@google.com>
> >
> >
> > changes in v9
> > - Changed max anon vma name length from 64 to 256 (as in the original patch)
> > because I found one case of the name length being 139 bytes. If anyone is
> > curious, here it is:
> > dalvik-/data/dalvik-cache/arm64/apex@com.android.permission@priv-app@GooglePermissionController@GooglePermissionController.apk@classes.art
>
> I'm not sure that's a very convincing argument. We don't add code
> arbitrarily just because some userspace code running on some custom
> kernel (ab)uses something in that kernel. Surely that user can come up
> with a name that doesn't contain GooglePermissionController twice.
>
> The argument for using strings and not just a 128 bit uuid was that it
> should (also) be human readable, and 250-byte strings are not that.
> Also, there's no natural law forcing this to be some power-of-two, and
> in fact the implementation means that it's actually somewhat harmful
> (give it a 256 char name, and we'll do a 260 byte alloc, which becomes a
> 512 byte alloc). So just make the limit 80, the kernel's definition of a
> sane line length.

Sounds reasonable. I'll set the limit to 80 and will look into the
userspace part if we can trim the names to abide by this limit.

> As for the allowed chars, it can be relaxed later if convincing arguments can be made.

For the disallowed chars, I would like to go with "\\`$[]" set because
of the example I presented in my last reply. Since we disallow $, the
parsers should be able to process parentheses with no issues I think.

>
>
> > +/* mmap_lock should be read-locked */
> > +static inline bool is_same_vma_anon_name(struct vm_area_struct *vma,
> > +                                      const char *name)
> > +{
> > +     const char *vma_name = vma_anon_name(vma);
> > +
> > +     if (likely(!vma_name))
> > +             return name == NULL;
> > +
> > +     return name && !strcmp(name, vma_name);
>
> It's probably preferable to spell this
>
>   /* either both NULL, or pointers to same refcounted string */
>   if (vma_name == name)
>       return true;
>
>   return name && vma_name && !strcmp(name, vma_name);
>
> so you have one less conditional in the common case.

Ack.

>
> Rasmus

Thanks for the review!
Suren.
