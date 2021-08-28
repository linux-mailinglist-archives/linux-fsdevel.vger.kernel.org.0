Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C6E3FA791
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 23:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhH1VOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 17:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhH1VOt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:14:49 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9683C061796
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 14:13:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id f15so19764892ybg.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Aug 2021 14:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICcSCFexjhpp8PBl0tQjqKkSyaD0mJsG1uKHkuscRbw=;
        b=gV1T+5i/k5S8ZzJnpNhMlyvXxAUnUgvbFDNvQcSjiLmWAm+5RMKOptlxPVAbDSB9y5
         DjNRnN5aBxTyw4/H75I2FCH88Zwihmjf9TpcXO0SJAX0UN8e8SIAlqjOOjkIanqGlbTY
         RMI8YRMNYv2G0S6FVFQCX5uNDAR2kKbD92SjaqnfnhfD0tQqLs3X8CtGg8rjSdEceQ6S
         MvJcXW+AL/eJW0wFEQvZwnxxN6qjnabEpuE4gDcxYezkBmtBq4lWKff5KT71Tk38dlWf
         Y6FEywUwpOgKyVBbSlLlUHSK8Ky94Q6eoOfKdGBLWf3OAxCQyDjyLfUl+Mam1YIEpNhr
         GF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICcSCFexjhpp8PBl0tQjqKkSyaD0mJsG1uKHkuscRbw=;
        b=War1J4Oq8vPxkJmo6S1ZLwwqlwIDJ0EbTF9DVrcJu5K92HIPCBVfh3kJd3A3erVg7/
         C3sJBVyDLtW07s58HvZa2IPIVr2yihIOdW9fRT/IIt9ZNVYEWaaCJEqVcslu5Ilvu1kg
         BjORX/sxzmeNFrS1bvZmPuhtKGqlBPf9OPJrJSUNcIxpajbzgE+RdVbhKNjWj0ZL2mAu
         9IlPCamh2LWytupIpkKvbescpan0pDkt0fTpJihlpsow/PsAYLFLIPZLC366Y6esJnsg
         N3p8Pik/BmVUsA8i5hNO4mQIa9/QQsCJW3WBpfCKgAn7TwsY4L+aDPATJDbfHX3+jJzS
         NVsA==
X-Gm-Message-State: AOAM530Qy7iUTakee0+uqxSClNjcHrpvBhWDM7H3MBau2F7PXj7LhWRW
        97P7l27B2eQwSOfciq+6V+Mv/L9/d/GwvFNLoXokqA==
X-Google-Smtp-Source: ABdhPJzTGgBAMEHL0PjhT2MzcQ07lzKlvxCvWWXzRYRZdMn4dsVrA+qJVnFa57VycofHCrLOcfOcy4S0yhD1Mp8cwI0=
X-Received: by 2002:a25:810c:: with SMTP id o12mr14438431ybk.250.1630185237477;
 Sat, 28 Aug 2021 14:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210827191858.2037087-1-surenb@google.com> <20210827191858.2037087-4-surenb@google.com>
 <202108271746.F444DA6C9@keescook>
In-Reply-To: <202108271746.F444DA6C9@keescook>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sat, 28 Aug 2021 14:13:46 -0700
Message-ID: <CAJuCfpHLTMyAFsxAYHbiwkZNidzQU3qKWzj57LZX=b-Zybmugg@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mm: add anonymous vma name refcounting
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 10:28 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Aug 27, 2021 at 12:18:58PM -0700, Suren Baghdasaryan wrote:
> > While forking a process with high number (64K) of named anonymous vmas the
> > overhead caused by strdup() is noticeable. Experiments with ARM64 Android
> > device show up to 40% performance regression when forking a process with
> > 64k unpopulated anonymous vmas using the max name lengths vs the same
> > process with the same number of anonymous vmas having no name.
> > Introduce anon_vma_name refcounted structure to avoid the overhead of
> > copying vma names during fork() and when splitting named anonymous vmas.
> > When a vma is duplicated, instead of copying the name we increment the
> > refcount of this structure. Multiple vmas can point to the same
> > anon_vma_name as long as they increment the refcount. The name member of
> > anon_vma_name structure is assigned at structure allocation time and is
> > never changed. If vma name changes then the refcount of the original
> > structure is dropped, a new anon_vma_name structure is allocated
> > to hold the new name and the vma pointer is updated to point to the new
> > structure.
> > With this approach the fork() performance regressions is reduced 3-4x
> > times and with usecases using more reasonable number of VMAs (a few
> > thousand) the regressions is not measurable.
>
> I like the refcounting; thank you!
>
> Since patch2 adds a lot of things that are changed by patch3; maybe
> combine them?

I thought it would be easier to review with the main logic being
written using a basic type (string) first and then replace the basic
type with a more complex refcounted structure. Also, if someone would
like to rerun the tests and measure the regression of strdup vs
refcounting approach, keeping this patch separate makes it easier to
set up these tests.
If that's not convenient I can absolutely squash them together.

>
> --
> Kees Cook
