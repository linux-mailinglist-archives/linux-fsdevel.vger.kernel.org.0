Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512C241E4BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 01:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348740AbhI3X0t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 19:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhI3X0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 19:26:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6CC06176A
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 16:25:05 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ce20-20020a17090aff1400b0019f13f6a749so7654298pjb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 16:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eh34nKlBtcXIhSkXFiXgZHHEXy1pUVrM2m/QPvjGZhs=;
        b=Hs3DNk4Z5KQlgSeNyHreuKuvEU3//1qlQHAU6a7/5w5PaGkR53udvoJVoOdC9VYM+4
         oclqUS4GaVHxlcKo64+K6oVPlWjJLs2LIrFdjEdhbknM3o0FBpyNLGRmyykcmR2LSMoz
         9dsuPdW3grv3wXZx7jpKUG0rnO+B3L23iItAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eh34nKlBtcXIhSkXFiXgZHHEXy1pUVrM2m/QPvjGZhs=;
        b=QZxHv5NnlilNqaKdsSPjnnWlRPz/J/JHqF+vW4Rsd5nt6fQxXf4rw/7HIVCkkxuaET
         kDCiiWax6vR674WeapiWeuWUgXG9fFDaF0Gnf9rNpuAwbPhaKNA9hbKKSdbSf3fclj4J
         TYgn2OpAHzbtTlSqxm3CoF/vi+GA5eV9ImeVOPOch9aYtbQkttkhPmZfIbVk/97YFn6n
         djxVE0xFnkD0WMFH59/G1tbp+2j0zkFxf4jQ9osvpB56A9/2o01xgfdu1z3XXW6GZ6mO
         s2efDAlAAo6nozo/R7LVTws2o/2CpWxDbIMUE6i/lte6veytwmcOFFm5Km4n8r2wghm1
         yo1g==
X-Gm-Message-State: AOAM533El8QBctxR4HcStsTgfOKnyTDyYzS+JkgZrI0ZEPWKc/ZENNsf
        HzcRedcJsLJbF+7DyewmIR3+mg==
X-Google-Smtp-Source: ABdhPJylqjkv4pN89l4jFNBRqBmfAjaekWIwj3On6XS7U+IYWAgJXHbj5PZrkmGMBxnVbJZPind/Dg==
X-Received: by 2002:a17:902:b205:b0:13d:b0a1:da90 with SMTP id t5-20020a170902b20500b0013db0a1da90mr6640971plr.26.1633044304955;
        Thu, 30 Sep 2021 16:25:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 23sm4600716pfw.97.2021.09.30.16.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 16:25:03 -0700 (PDT)
Date:   Thu, 30 Sep 2021 16:25:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
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
Subject: Re: [PATCH v9 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <202109301621.3E03AE14F@keescook>
References: <20210902231813.3597709-1-surenb@google.com>
 <20210902231813.3597709-2-surenb@google.com>
 <YTZIGhbSTghbUay+@casper.infradead.org>
 <CAJuCfpEYOC+6FPmVzzV2od3H8vqWVCsb1hiu5CiDS0-hSg6cfQ@mail.gmail.com>
 <CAJuCfpH8LtKG+1LpVb8JM73dL11yaqR7io8+HDHLGNUVZYVTQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH8LtKG+1LpVb8JM73dL11yaqR7io8+HDHLGNUVZYVTQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:56:12AM -0700, Suren Baghdasaryan wrote:
> I thought more about these alternative suggestions for userspace to
> record allocations but that would introduce considerable complexity
> into userspace. Userspace would have to collect and consolidate this
> data by some daemon, all users would have to query it for the data
> (IPC or something similar), in case this daemon crashes the data would
> need to be somehow recovered. So, in short, it's possible but makes
> things much more complex compared to proposed in-kernel
> implementation.

Agreed: this is something for the kernel to manage.

> OTOH, the only downside of the current implementation is the
> additional memory required to store anon vma names. I checked the
> memory consumption on the latest Android with these patches and
> because we share vma names during fork, the actual memory required to
> store vma names is no more than 600kB. Even on older phones like Pixel
> 3 with 4GB RAM, this is less than 0.015% of total memory. IMHO, this
> is an acceptable price to pay.

I think that's entirely fine. We don't end up with any GUP games, and
everything is refcounted.

I think a v10 with the various nits fixed would be a good next step
here. What do you think Matthew?

-- 
Kees Cook
