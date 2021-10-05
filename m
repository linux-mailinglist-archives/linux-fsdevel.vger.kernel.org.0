Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D54230B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 21:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhJETXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 15:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbhJETXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 15:23:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40E3C06174E
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 12:21:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so2775248pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 12:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7y0UQJo2ebCqon0Bb7OI4csD0ePdDv5zBX9x3Gtz6Mg=;
        b=ftC3Y73kipN8EROGIeJDV8NTUjflmrLwE19qsFs3y5p12F2JvJ1fDy3W7Ypic1NX81
         2v3cMbEpRUcZWhC6ttcRhGFCOMwikEjPQa8wJrz32tAVOxWEOBLrUobOQT01GkU2+fRm
         W4qbRjDRbrdUfClhtSjntPBzH4/bRmjW/H1v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7y0UQJo2ebCqon0Bb7OI4csD0ePdDv5zBX9x3Gtz6Mg=;
        b=ZaSw3+I9AFcHibK9bKOt1sEVDQWgkpGlE+J61FfQ//K5Z6MqrVTDXPaRRN5qT1eo7H
         0afUMJLRMWhmy+I1fsl6IrdsJQIb2PWuyV6HMD5E/9KmZnlcZWO8Cm2kyxWKp3IlC+el
         gWWXbt/gFMrUhhd+YhodLoXaqjAqDL7lUNWszqgegruGdaKF+WK3/1TTJ40n0+IeRTY/
         +fxh+FpLzf0zpDIy3LfnDyBdus9KcL42QSLr32alL4/XNYcaNMG1nYVykxP716GnJEEk
         KbOBrKJmt4qTprIa5UFmiNPc4Y6TTbbfnlcaOW4J+jzrtQsydLu34sJPwWHTfZKCzMzy
         igBw==
X-Gm-Message-State: AOAM531bjatXiLdgXSpnyXK7OwDGEeWhQmXQ+TuH7hVLQvnLdsIPQU4A
        +VjOCmotAUAyGkiyqkEzxsafCA==
X-Google-Smtp-Source: ABdhPJzezE2wUAuBWYAjH/zFwBXPaMFO3rBxvvJeba7vRgIkChPqAHZkAWQhGASVRMyeAEnLl+lViw==
X-Received: by 2002:a17:902:a3c2:b0:13d:be85:43ca with SMTP id q2-20020a170902a3c200b0013dbe8543camr6965857plb.0.1633461688236;
        Tue, 05 Oct 2021 12:21:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a5sm8228807pff.219.2021.10.05.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 12:21:27 -0700 (PDT)
Date:   Tue, 5 Oct 2021 12:21:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Cross <ccross@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
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
Subject: Re: [PATCH v10 3/3] mm: add anonymous vma name refcounting
Message-ID: <202110051220.FFD4C604EF@keescook>
References: <20211001205657.815551-1-surenb@google.com>
 <20211001205657.815551-3-surenb@google.com>
 <20211005184211.GA19804@duo.ucw.cz>
 <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE5JEThTMhwKPUREfSE1GYcTx4YSLoVhAH97fJH_qR0Zg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:14:59PM -0700, Suren Baghdasaryan wrote:
> On Tue, Oct 5, 2021 at 11:42 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > On Fri 2021-10-01 13:56:57, Suren Baghdasaryan wrote:
> > > While forking a process with high number (64K) of named anonymous vmas the
> > > overhead caused by strdup() is noticeable. Experiments with ARM64
> > Android
> >
> > I still believe you should simply use numbers and do the
> > numbers->strings mapping in userspace. We should not need to optimize
> > strdups in kernel...
> 
> Here are complications with mapping numbers to strings in the userspace:
> Approach 1: hardcode number->string in some header file and let all
> tools use that mapping. The issue is that whenever that mapping
> changes all the tools that are using it (including 3rd party ones)
> have to be rebuilt. This is not really maintainable since we don't
> control 3rd party tools and even for the ones we control, it will be a
> maintenance issue figuring out which version of the tool used which
> header file.
> Approach 2: have a centralized facility (a process or a DB)
> maintaining number->string mapping. This would require an additional
> request to this facility whenever we want to make a number->string
> conversion. Moreover, when we want to name a VMA, we would have to
> register a new VMA name in that facility or check that one already
> exists and get its ID. So each prctl() call to name a VMA will be
> preceded by such a request (IPC call), maybe with some optimizations
> to cache already known number->string pairs. This would be quite
> expensive performance-wise. Additional issue with this approach is
> that this mapping will have to be persistent to handle a case when the
> facility crashes and has to be restored.
> 
> As I said before, it complicates userspace quite a bit. Is that a good
> enough reason to store the names in the kernel and pay a little more
> memory for that? IMHO yes, but I might be wrong.

FWIW, I prefer the strings. It's more human-readable, which is important
for the kinds of cases where the maps are being used for diagnostics,
etc.

-- 
Kees Cook
