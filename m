Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576DD41E717
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 07:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352003AbhJAFVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 01:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351884AbhJAFVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 01:21:36 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A64C06176A
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 22:19:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 145so6907094pfz.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Sep 2021 22:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EyTaw5QtAJ4bW8Vm8xYfacGbohlYt9c/AnSihiB9j34=;
        b=lHWczr+OPdwO6X6MxEziwiIYJTBe2iPHyLjFCYgLTl/SDrIXrQSS6vb7hnCYEx5bZs
         d9rHB0J91KliCK2wBSHSVBMNFc5ozW8CIi+2CARgkV1a8mv4S6Xg1wwZ+hD6nn2xdNJE
         qb+heFtlqPryXdSvgJZC8fLl3cg6iDg4rAcpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EyTaw5QtAJ4bW8Vm8xYfacGbohlYt9c/AnSihiB9j34=;
        b=uslqxZ/CXEKYlfuurIa3oVfHYjjw0WqeIlFklwFNmao4c45nI1GzVytupLSHpTZkzE
         XOuwRLDOB1HHaFvKYYLIynolLL69wVsOMS1HA5AlPdwbq1Oiq2hfbgcdIxCaFGYh8mDB
         Y/iiFWF6pa/MVwsSowCxWpKk3tbIFMaKZeggLT7iJLqY9phkSE7gcNddYPn+nA64a6GC
         aszrKSzIJGR1RJbGV4udri1T34vMVByjBnYu60/uiwxJz7FDR7bW7gYX0avBGZ0YoANH
         q5RcUEcqH8rJbWrWFY0AFUEtMk+fQ0xI1aq6jMoluTmQ+wmfHp+iu+Ck3jDaMT1nd+Yy
         9QiQ==
X-Gm-Message-State: AOAM530VB2psDDEKmy5PAyfazTPhmv5zY9pTlHM7FTJ/1WHloA9+g4pH
        IbAxN7GqTEcBFbqOVmh3vXGSaw==
X-Google-Smtp-Source: ABdhPJzprmCx1Nw75Isx1VIHD4op+s7oTt9KX5oRihjuhzp0VAPFJJOk8T2ufUoBr/6/fUvG1cvJ0g==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr8248588pgq.300.1633065592032;
        Thu, 30 Sep 2021 22:19:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k2sm6543077pjq.28.2021.09.30.22.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 22:19:51 -0700 (PDT)
Date:   Thu, 30 Sep 2021 22:19:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Suren Baghdasaryan <surenb@google.com>
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
Message-ID: <202109302219.FF1F3E24@keescook>
References: <20210902231813.3597709-1-surenb@google.com>
 <20210902231813.3597709-2-surenb@google.com>
 <202109031439.B58932AF0@keescook>
 <CAJuCfpEQAJqu2DLf5D5pCkv4nq+dtVOpiJSnsxwGrgb9H6inQA@mail.gmail.com>
 <202109031522.ACDF5BA8@keescook>
 <CAJuCfpGVgSpvW_oXaGVc3TiobaGaYUtu3WR_DhrhWnEr_V=7TQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGVgSpvW_oXaGVc3TiobaGaYUtu3WR_DhrhWnEr_V=7TQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 08:44:25PM -0700, Suren Baghdasaryan wrote:
> While testing v10 I found one case when () are used in the name
> "dalvik-main space (region space)". So I can add ` and $ to the
> restricted set but not ( and ). Kees, would you be happy with:
> 
> static inline bool is_valid_name_char(char ch)
> {
>     return ch > 0x1f && ch < 0x7f && !strchr("\\`$[]", ch);
> }
> 
> ?

That works for me! :)

-- 
Kees Cook
