Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079D23FA7D1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 00:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhH1WHo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 18:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbhH1WHn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 18:07:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE92DC0613D9
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 15:06:52 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id r4so19925926ybp.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 15:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FaNp+rgluakS1NovJ9xRQmt2mW1nmBLtnie3IiMHfk=;
        b=hIw/qm9pg9ZdeTcKNLVVVOW4DRFhCbswcN4AUxuYQhsj8UGDdLJ/SeljNcx4n22yOJ
         C6jcmzcxhg7nfftciaoBfso9qRnMyBAO5PHFpG/udUXPdax6qLwAvxYqJYdYvmDya3xj
         7WtgdX+zuglKrfCseQdR07ng41SjaPz2H7F0bVObVVHfZw0V9pdKKOARroIHqjX72s5n
         vba2EQEd+3aOJO2sRbJ5TTKru6JrvWUogyWP0hAYWybVPUQ2COPxZi3D9MnQ+OroZSIs
         VTN253xQeZ2n6BmFRAoPI3FJlvfm9M5lU8N85Nu30Dqsmny9K9llY0zlZR7R4BHWRZYt
         efkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FaNp+rgluakS1NovJ9xRQmt2mW1nmBLtnie3IiMHfk=;
        b=UB3MDQdNEJIUmLZz5W0FuvWq6dADcbwU6PUCEgjKaFeuWvqFvUK3e9HE4ahrSRUXmr
         B5oqUnuO6UXhzng6S+05X+UBur5Ysx5b0floVW8Tdfh6h8ahtVH30xggfhYRLnV3u+Vf
         CJ2oB/LV4PHXWgIfqn64viUw1C26uSqCD85B3Yi37P1v2nlBTGcCvGu0pVkcasFbty1+
         remXAWf3FwAeGnxWQMUn4gXyCDF70xgf1zgnwbvv4D/boMUSbnH3s6fffCJvWGtEaGof
         34pxllJjYnmHfX7X4Yg+IO960HjrkMlj9Sk/xBrtEj2cIMON0i2RHsQAq4iUpJa1QtJC
         dOmA==
X-Gm-Message-State: AOAM533Y9q+4W2K8ZIn6ziKdN4Sj/gGNlbP1+SYyxcnA+9Ol5u9Mgzm8
        UCpThuZXZi6Y1xtfcbK/+VBaclNi9hj15JVk8BFTgA==
X-Google-Smtp-Source: ABdhPJxnDgVOH0h+Up9Sphumk/kGeSq9m09jSJlI2gZqPuf7VFR01D96XmdG0df9NqzDHkYt3N6qEPla3dpUcRXoYxM=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr13478289ybg.111.1630188411767;
 Sat, 28 Aug 2021 15:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com> <20210828124852.GA12580@duo.ucw.cz>
In-Reply-To: <20210828124852.GA12580@duo.ucw.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 28 Aug 2021 15:06:40 -0700
Message-ID: <CAJuCfpE85Pbw7TDcZOOonMLNgHMWsaWR-2qR5iUZJ4dyJ-6k7g@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] Anonymous VMA naming patches
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
        Jens Axboe <axboe@kernel.dk>, legion@kernel.org, eb@emlix.com,
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

On Sat, Aug 28, 2021 at 5:48 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> >  Documentation/filesystems/proc.rst |   2 +
>
> Documentation for the setting part would be welcome, too.

Absolutely! Thanks for reminding me. I'll add a description of the new
PR_SET_VMA and PR_SET_VMA_ANON_NAME options for prctl(2) manpage into
the second patch of this series which introduces them. After the patch
is finalized and accepted I'll also post a patch to update the
prctl(2) manpage.
Thanks,
Suren.


>
> Best regards,
>                                                         Pavel
> --
> http://www.livejournal.com/~pavelmachek
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
