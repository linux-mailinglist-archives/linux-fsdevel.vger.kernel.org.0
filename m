Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D89F3FA3DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Aug 2021 07:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbhH1F3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Aug 2021 01:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhH1F3f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Aug 2021 01:29:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D84C0617A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 22:28:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t1so7958794pgv.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 22:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=stWDJ7pxROB/EYFBbI7ThyH/rSYnoU9WnqG7bRnPt18=;
        b=bt25+nM3eSC/BvfoTicc0kvU8X0ALlSypYs6nMG+ihBxWlZaCFTdELOgHd4ypV3SQF
         bNmfO7MJWL23KdE8b6R633QbGHj6wsYkr8qI4bQIAjy/oem5n+xTmj1AvXlQVcFUHF+r
         KxLKNJshPsF238Mfaa8vML8FvFyRRVbeIlieg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=stWDJ7pxROB/EYFBbI7ThyH/rSYnoU9WnqG7bRnPt18=;
        b=TVeX7IgCtak2TFAcgYnvQOZE3rEnz+9HFjhyy2T4jTh4oEy2G2RcVbKN1NCBpKcEhE
         PT2OTAnYfCdNAVv/W80vYxLuTMMhCfdT02HnDaGlzaF21y69Y9MLYqf85fwSVFem5Dxp
         kmqNt1vm9DBDJPMcO+JjeUDkEUznSyVi76TXjqlPN4SM7i445HIhho7+PMRYGtun3SaX
         g9LyFVHyHF4bParsn6RmjGLQ6CmKZ3Encxczr1JB+BVrM9RieLmsPHx3cZgsj0vX92S4
         wPwlgBAqZ9FsqgrJmL06BpuGGZzXFMB2QkwO3Cptq3F6aBWPbGcOaV1ujjx6FtpqevSP
         6pwA==
X-Gm-Message-State: AOAM530YMK4AFNEmYogxIMrRJ0RK+dzRshx56PZH1JJsdpHRxeBYxrY3
        lFr0OHoNWpKZailOGVwrFAazDA==
X-Google-Smtp-Source: ABdhPJyRblUvU4gbCZ7vv2bulSDNoJ7Vp3Z6WWqczImBz1dyvqqdk84ObtLecw4DydDVqpr9htn1SQ==
X-Received: by 2002:a05:6a00:2142:b029:3b9:e5df:77ab with SMTP id o2-20020a056a002142b02903b9e5df77abmr12703170pfk.52.1630128524423;
        Fri, 27 Aug 2021 22:28:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18sm8883397pgk.24.2021.08.27.22.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 22:28:43 -0700 (PDT)
Date:   Fri, 27 Aug 2021 22:28:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
        willy@infradead.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, hannes@cmpxchg.org, corbet@lwn.net,
        viro@zeniv.linux.org.uk, rdunlap@infradead.org,
        kaleshsingh@google.com, peterx@redhat.com, rppt@kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, songmuchun@bytedance.com,
        viresh.kumar@linaro.org, thomascedeno@google.com,
        sashal@kernel.org, cxfcosmos@gmail.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com
Subject: Re: [PATCH v8 3/3] mm: add anonymous vma name refcounting
Message-ID: <202108271746.F444DA6C9@keescook>
References: <20210827191858.2037087-1-surenb@google.com>
 <20210827191858.2037087-4-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827191858.2037087-4-surenb@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:18:58PM -0700, Suren Baghdasaryan wrote:
> While forking a process with high number (64K) of named anonymous vmas the
> overhead caused by strdup() is noticeable. Experiments with ARM64 Android
> device show up to 40% performance regression when forking a process with
> 64k unpopulated anonymous vmas using the max name lengths vs the same
> process with the same number of anonymous vmas having no name.
> Introduce anon_vma_name refcounted structure to avoid the overhead of
> copying vma names during fork() and when splitting named anonymous vmas.
> When a vma is duplicated, instead of copying the name we increment the
> refcount of this structure. Multiple vmas can point to the same
> anon_vma_name as long as they increment the refcount. The name member of
> anon_vma_name structure is assigned at structure allocation time and is
> never changed. If vma name changes then the refcount of the original
> structure is dropped, a new anon_vma_name structure is allocated
> to hold the new name and the vma pointer is updated to point to the new
> structure.
> With this approach the fork() performance regressions is reduced 3-4x
> times and with usecases using more reasonable number of VMAs (a few
> thousand) the regressions is not measurable.

I like the refcounting; thank you!

Since patch2 adds a lot of things that are changed by patch3; maybe
combine them?

-- 
Kees Cook
