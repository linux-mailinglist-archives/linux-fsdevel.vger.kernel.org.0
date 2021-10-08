Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF47A4272E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Oct 2021 23:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhJHVPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Oct 2021 17:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbhJHVPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Oct 2021 17:15:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4369C061762
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Oct 2021 14:13:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so8706733pjb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Oct 2021 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0j9Fen+aM1yxtAVTmt6zwsss9sN5UsLCk44GHH1tRc=;
        b=I+McrbgmDL8gZ9vmtX1aR7+zkzhDrlHhXT6iEzjY4OCKkruLZDBi+tzb3viHWvPBBY
         kW2Us4im1MyQTWLJHDidgCouWJsWR1fzIwUGgK8+FBItkM6TWjIfpDSi5vv4VKXHDqoI
         OyfVYPUddfURQDYvCN/P/GevbyB1QLdePw59Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0j9Fen+aM1yxtAVTmt6zwsss9sN5UsLCk44GHH1tRc=;
        b=AU9AMBnZ78l43ZxwjU2C3iFot9u89ANFgzBXYQ6wKznxGcwclZO/PYjfDz5SGllKJr
         8bRShzAGMbE1x3M5WTLTwkhe8T2MBGv1R0TkLTeiZedHxeWMicG3clwSt858VJYLnmog
         40A73U1V+zLxNfiMIr8IP4615Bj3dxt1gc1IzWXMsRE18HAgAZgkJRfj2dPIy3yKnBpG
         R7WRorFfHAnSiFB2c8wu6i0hRUSRXBc3BJRH2X+pyYZLg/3iDTD/k9YsWgDmbfZ+auX3
         qlRpU2S7RgPizWNCzht1zIDrUkMkSqWV+I0KT4birNL92LCskOpF0XXnXjkXtjuP8YpD
         VYGA==
X-Gm-Message-State: AOAM533/u99I+o55NjUL8oro9Ye89i0UexdEsMYhm6iyw5kKze2UyXel
        2/+/1M6JO9KJmRK09wQUxseWJwhwmTAsIw==
X-Google-Smtp-Source: ABdhPJw7VKHrHn5Ve+YJUHXmXb4Y/SdM39YgZAgr2mjSF0lGDycy5YuHBe+qaxeygUETUBv7bjuAQg==
X-Received: by 2002:a17:90a:6c97:: with SMTP id y23mr14115452pjj.117.1633727591243;
        Fri, 08 Oct 2021 14:13:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nn14sm147691pjb.27.2021.10.08.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:13:10 -0700 (PDT)
Date:   Fri, 8 Oct 2021 14:13:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Hubbard <jhubbard@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
        Chinwen Chang =?utf-8?B?KOW8temMpuaWhyk=?= 
        <chinwen.chang@mediatek.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, apopple@nvidia.com,
        Yu Zhao <yuzhao@google.com>, Will Deacon <will@kernel.org>,
        fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        Hugh Dickins <hughd@google.com>, feng.tang@intel.com,
        Jason Gunthorpe <jgg@ziepe.ca>, Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>, krisman@collabora.com,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
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
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-ID: <202110081401.7AB25E4@keescook>
References: <CAJuCfpGp0D9p3KhOWhcxMO1wEbo-J_b2Anc-oNwdycx4NTRqoA@mail.gmail.com>
 <YV8jB+kwU95hLqTq@dhcp22.suse.cz>
 <CAJuCfpG-Nza3YnpzvHaS_i1mHds3nJ+PV22xTAfgwvj+42WQNA@mail.gmail.com>
 <YV8u4B8Y9AP9xZIJ@dhcp22.suse.cz>
 <CAJuCfpHAG_C5vE-Xkkrm2kynTFF-Jd06tQoCWehHATL0W2mY_g@mail.gmail.com>
 <202110071111.DF87B4EE3@keescook>
 <CAJuCfpFT7qcLM0ygjbzgCj1ScPDkZvv0hcvHkc40s9wgoTov7A@mail.gmail.com>
 <caa830de-ea66-267d-bafa-369a6175251e@nvidia.com>
 <b606021e-0afa-a509-84c4-2988d77f68bc@rasmusvillemoes.dk>
 <eb9fd99e-177e-efe6-667c-f5ff99ad518b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb9fd99e-177e-efe6-667c-f5ff99ad518b@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 08, 2021 at 09:43:59AM +0200, David Hildenbrand wrote:
> I'm going to point out that we already do have names for memfds.

I just did the same here[1]. :P

> [...] It's also displayed in /proc/self/maps.

I missed that part! /me screams forever

We really need to filter this at creation time. :( At least
seq_file_path() escapes "\n" for it, but not "\r", so humans on a
terminal could get very confused...

$ ./memfd '^M0000000000000000-ffffffffffffffff rwxp 00000000 00:00 0 [stack]' &
[1] 2953833
$ cat /proc/2953833/maps
...
0000000000000000-ffffffffffffffff rwxp 00000000 00:00 0     [stack] (deleted)
...


-Kees

[1] https://lore.kernel.org/lkml/202110081344.FE6A7A82@keescook

-- 
Kees Cook
