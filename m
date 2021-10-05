Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C16423243
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 22:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhJEUpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 16:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhJEUpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:45:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4D7C06174E
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 13:43:55 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s64so496345yba.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqE21VBUis5F7P2tyfYlDOrpKr4yHrwWmAyRNmJWM3s=;
        b=cLdugDTmr/j2oBSHl6ozvoJ0MUztT02mdFP1wViGsj6Es2vUDXH3ZKf0dgAvBRswBG
         4nw7Ii4GeXo/fAzUaTjYOPt6JRHTe8t5Q40Sq/JAY1c2+zHmKNfHZtRuHtrubosUCXjj
         tNczBaDQ4bhQN0nlecEG5Y8I63K7PrxdUlrLmKmNAxtRSqnjPWgjkdwDPuwh0kUI9rBA
         m47INqgwtWh1ybXdUOTGhlDh007hgptN9+4uMEw/1iYHGtiI67rUFYFfsxg7a7ih3WLt
         rVQnsO/wS4iN+N3TONQfPsl0EcuNPmrWUSAnVcHAf52OQoxar1CxZFfZj6r0eJPQ5e1X
         pD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqE21VBUis5F7P2tyfYlDOrpKr4yHrwWmAyRNmJWM3s=;
        b=6qIhPbsxPvewTUjsNrTGkw5oD9Jpzx1id1mIvl4yP61YlFwSzLcC9Hd5oaLABAnx7r
         4RYJISZ0N4jlklpI4WTUEPQCGV3sC9jJ/nNr2tPnSW8bB9/L6326ovEqsLbX7RDNcXkD
         BZTpPFVQ0FkiAwuTPx6qKU4pDDb2+rK23ykA/Kr10UTeZ4HxjXFtyCHplhF6KcagceAg
         LV1lz7VAK+J6dMkWrGlYKGTxQpcQPw9aNsN46c5HVcbqCmCUW6RCFtVl+ujkEpr49nzw
         UcX5yQxc5vGDtfNx0in4BxYBgPCwFjnNc2ZeByJP6OZyN8/5Es4y+ksTvlKGXzViw0lh
         x6ow==
X-Gm-Message-State: AOAM5330xQtfKt8VynlwN1X9aFc8rmtWvji3hbsOa3QlQSe0GkBYmt5o
        QBr2d8VPhyPRiXTBd2abM9ofcNAPpnmzvKw8gCF/aQ==
X-Google-Smtp-Source: ABdhPJwSm0BVOOZ5kTvRyYIrXx9qnEj/0YszDwLj+4P9EMmNTXKp7nh2cjQfq6luS4PqGmW3SNrlE+Yl4FCV+mWu3MQ=
X-Received: by 2002:a25:3:: with SMTP id 3mr24647134yba.418.1633466634369;
 Tue, 05 Oct 2021 13:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211001205657.815551-1-surenb@google.com> <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz> <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
 <20211005200411.GB19804@duo.ucw.cz>
In-Reply-To: <20211005200411.GB19804@duo.ucw.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 5 Oct 2021 13:43:43 -0700
Message-ID: <CAJuCfpFZkz2c0ZWeqzOAx8KFqk1ge3K-SiCMeu3dmi6B7bK-9w@mail.gmail.com>
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

On Tue, Oct 5, 2021 at 1:04 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > On Fri 2021-10-01 13:56:57, Suren Baghdasaryan wrote:
> > > > While forking a process with high number (64K) of named anonymous vmas the
> > > > overhead caused by strdup() is noticeable. Experiments with ARM64
> > > Android
> > >
> > > I still believe you should simply use numbers and do the
> > > numbers->strings mapping in userspace. We should not need to optimize
> > > strdups in kernel...
> >
> > Here are complications with mapping numbers to strings in the userspace:
> > Approach 1: hardcode number->string in some header file and let all
> > tools use that mapping. The issue is that whenever that mapping
> > changes all the tools that are using it (including 3rd party ones)
> > have to be rebuilt. This is not really maintainable since we don't
> > control 3rd party tools and even for the ones we control, it will be a
> > maintenance issue figuring out which version of the tool used which
> > header file.
>
> 1a) Just put it into a file in /etc... Similar to header file but
> easier...
>
> > Approach 2: have a centralized facility (a process or a DB)
> > maintaining number->string mapping. This would require an additional
> > request to this facility whenever we want to make a number->string
> > conversion. Moreover, when we want to name a VMA, we would have to
>
> I see it complicates userspace. But that's better than complicating
> kernel, and I don't know what limits on strings you plan, but
> considering you'll be outputing the strings in /proc... someone is
> going to get confused with parsing.

I'm not a fan of complicating kernel but the proposed approach seems
simple enough to me. Again this is subjective, so I can't really have
a good argument here. Maybe, as Andrew suggested, I should keep it
under a separate config so that whoever does not care about this
feature pays no price for it?
On the topic of confusing the parsers, if the parser is written so
that it can't ignore new [anon:...] entry then it does not matter
whether we use strings or numbers, it will get confused either way.
Again, if we are concerned about confusing existing parsers I think
having a separate config option set to 'n' would help. This would
prevent some userspace process from naming an anonymous VMA and
causing parser confusion. OTOH on systems where parsers can handle
anon VMA names (Android) we will set that config and use the feature.
Would that address your concerns?


>
>                                                                 Pavel
> --
> http://www.livejournal.com/~pavelmachek
