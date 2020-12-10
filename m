Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3440B2D60B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 17:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392088AbgLJP7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 10:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390527AbgLJP7T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:59:19 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C48C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:58:39 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w16so4581207pga.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Dec 2020 07:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JsItjQhJTNChGLKWrMzXdOtHhMmJn68zyS+vNfChmc=;
        b=YR54goM9BduaqkUSFsN45e6lbCS6jKd0VIuO8EoEZV4bRzXfT2OMkZL9t4rycCznXW
         3L+nB8URIDdu6cufleBaMugwkzBJ0bAmqF0tASnrYsCLhXE90t4kb9Fpi+J+fG4bsJly
         4UPW1v4jSERSN9+jdEjsc4NfOwDb9a/RIIiYugb5FFWv0opti3lRjgSvAZwG60ZblLwL
         8Q5zDENNJsMDc29AnGad8P8sF2aH8qAHCa1+ETX/nWCzL4DxswvNSMVczwx2143XKobK
         EZFF46MuoFXi2yZCvCbpV2lqjbGdRnJ4/Es9gUtDj8ArJRCqhb32n36XVO4LRVNfilvI
         3syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JsItjQhJTNChGLKWrMzXdOtHhMmJn68zyS+vNfChmc=;
        b=I15Sdm2qLJwDsDb2gjhs+gypNQYQ5eYRJ+b2j+r6FpvWqlrKQ2EEb+vLeSfOUqJfCI
         A4/QV+KI1qTumTsO5qOvWOHfhHSg/mMhWdUyNMxvh2Yzzh5YusELvfFSLiP54z0XGCDB
         gwS2mefxzQi4TzfTxJ7AR2O6b2F/WCUwtyPYu7LKwTRiX9JCzoMYh4sAdrgH12LMF1pY
         HW5XMQ7d2XsVQU+W5xb0aS0lmtiMMFiPwneJKkpzPU6WfH5w50CkJFjvaUD/EaGL0gwK
         2F9pbcCLlzdMkMmInBxwi1847sPlRRj3wVCE+1d61iZGF0pnYB73fDvIMdPDhhw6ICE+
         j2YA==
X-Gm-Message-State: AOAM533DqVqyv9oggHo70QQXsekpsI2HBggH4fSv+rNnw5Ytk35IYAFD
        rsH5lVbzjyoWAZA5eIJ/qM4rNblahps0yN0AV8SmAQ==
X-Google-Smtp-Source: ABdhPJxsRJTEViV1kHZNE7S/lb4xqQOiuBcWI/nuOSkpUU7hFgwqcfKWK3LPuNueNSM77fjVgLOMwdLciypLZQHT8Os=
X-Received: by 2002:a63:c15:: with SMTP id b21mr7123599pgl.341.1607615918579;
 Thu, 10 Dec 2020 07:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-5-songmuchun@bytedance.com> <20201210144256.GB8538@localhost.localdomain>
 <20201210144419.GC8538@localhost.localdomain>
In-Reply-To: <20201210144419.GC8538@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Dec 2020 23:58:02 +0800
Message-ID: <CAMZfGtVuoDnM5S1-rPcGELfr4xaO7Ok9qAyBYLQ3=dQ+DDjOGQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 04/12] mm/hugetlb: Free the vmemmap
 pages associated with each HugeTLB page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 10:44 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 10, 2020 at 03:42:56PM +0100, Oscar Salvador wrote:
> > On Thu, Dec 10, 2020 at 11:55:18AM +0800, Muchun Song wrote:
> > > The free_vmemmap_pages_per_hpage() which indicate that how many vmemmap
> > > pages associated with a HugeTLB page that can be freed to the buddy
> > > allocator just returns zero now, because all infrastructure is not
> > > ready. Once all the infrastructure is ready, we will rework this
> > > function to support the feature.
> >
> > I would reword the above to:
> >
> > "free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
> >  pages associated with a HugeTLB page can be freed, returns zero for
> >  now, which means the feature is disabled.
> >  We will enable it once all the infrastructure is there."
> >
> >  Or something along those lines.
> >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >
> > Overall this looks good to me, and it has seen a considerable
> > simplification, which is good.
> > Some nits/questions below:
>
> And as I said, I would merge patch#3 with this one.

Will do. Thanks.

>
>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
