Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B7488837
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jan 2022 07:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbiAIGWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jan 2022 01:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbiAIGWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jan 2022 01:22:00 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B164C061746
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jan 2022 22:21:59 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id g80so29658914ybf.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Jan 2022 22:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MHOoZalZ4yzdXRz8I2/T4uac/wUxMGeLB4SbnbuPrk=;
        b=E0CjwfS0akiynM70MG+cOaaLmR+MLPa5cimWRH++WIDvhMf8SNXD6+Ce+k86NXuhHe
         Bpjc/YIFX0whSU8iyb5UwnoIqPW0+KheS1Ta0solvIEE/OXwqcLbeSLi2ynZm6JX5uZK
         r43biAwgdy2lKh9uqKPl+Wcpux/0SwkCI+ZaI8upAedJ2QX2Dg0VtaXtCsofOk7pSVoa
         av18a9k08ZqjeCsmIAhlqZIPUz4wnApQ8DCMjG6jSeothuRUF9Hgn/rVvkyY8SnAOLIX
         ZRaP8hTxlaH+RVc4hXGQGT3UVPHzAMIOs9v4HAr6wXJm35qWlalg3XFz21lJCLIoj4RW
         VwmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MHOoZalZ4yzdXRz8I2/T4uac/wUxMGeLB4SbnbuPrk=;
        b=WujLcmvxyWqRVIwDljZ13FRA6hyhrZWCW+kkD/v02P0KqOKr/oDVejKKeSlGpUznkZ
         I9+yKPR2KoweO1k4LoUBKWqsQedYKz/FZBTFRlJqqjx9V4gGtUMZ7C5kzcvqP6wq0Qot
         CjqVmqht/39mGTbfzwB41xmj1XYyT2XOufPRrtWB3ND5eh+Q8jOQTwUayJeORq78Xdrk
         ASdZ4HYJhcL9vSBIweuisfyL6VmcSlawMHCMe/204ybt43Zh8ZsUkREbCJT23H39UW6s
         N9t6dU8nj2DLPDCXMGn3sl1yhJLdigV/IeTN56CEwB/oqxYwnFM8ZOvsmDG+hDntd4vU
         RNGA==
X-Gm-Message-State: AOAM530u6gKGyLMyHLucj4JMbF4MFFgQhfiQocI5U29ot9JDQxRwE3J7
        /4lLanJgE2zia9UEJHNi/Da4mj5ENaR0Sp2WwLbUxg==
X-Google-Smtp-Source: ABdhPJyZ+bU4mbb0+w9+kdvDUEc5jYGIsxWWLUHnc0CSRRjhs5Oh0+esW/JLryFaRopClBiW67hA/1+sdioiJ76IOfs=
X-Received: by 2002:a25:3890:: with SMTP id f138mr79980398yba.703.1641709318562;
 Sat, 08 Jan 2022 22:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20211220085649.8196-1-songmuchun@bytedance.com>
 <20211220085649.8196-3-songmuchun@bytedance.com> <Ydet1XmiY8SZPLUx@carbon.dhcp.thefacebook.com>
In-Reply-To: <Ydet1XmiY8SZPLUx@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 9 Jan 2022 14:21:22 +0800
Message-ID: <CAMZfGtWmwTLHdO6acx9_+nR68j-v9SKjMsq-0v4ZDeQORgaQ=w@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] mm: introduce kmem_cache_alloc_lru
To:     Roman Gushchin <guro@fb.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 7, 2022 at 11:05 AM Roman Gushchin <guro@fb.com> wrote:
>
[...]
> >  /*
> >   * struct kmem_cache related prototypes
> > @@ -425,6 +426,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
> >
> >  void *__kmalloc(size_t size, gfp_t flags) __assume_kmalloc_alignment __alloc_size(1);
> >  void *kmem_cache_alloc(struct kmem_cache *s, gfp_t flags) __assume_slab_alignment __malloc;
> > +void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
> > +                        gfp_t gfpflags) __assume_slab_alignment __malloc;
>
> I'm not a big fan of this patch: I don't see why preparing the lru
> infrastructure has to be integrated that deep into the slab code.
>
> Why can't kmem_cache_alloc_lru() be a simple wrapper like (pseudo-code):
>   void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>                            gfp_t gfpflags) {
>         if (necessarily)
>            prepare_lru_infra();
>         return kmem_cache_alloc();
>   }

Hi Roman,

Actually, it can. But there is going to be some redundant code similar
like memcg_slab_pre_alloc_hook() does to detect the necessity of
prepare_lru_infra() in the new scheme of kmem_cache_alloc_lru().
I just want to reduce the redundant overhead.

Thanks.
