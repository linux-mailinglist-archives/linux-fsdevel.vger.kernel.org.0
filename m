Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900934D3DD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 01:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiCJADG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 19:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbiCJACy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:02:54 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7510C122F72
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 16:01:55 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id c11so3269451pgu.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 16:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUB8geEpJ+XtoTHFW5CyzSR89RxzbZocHBgXZDsT0q4=;
        b=otdsgu05707Lk9KMy9Xl5aGoGpb6RqPU5UPULqEDsN/2l0x6ZW4fwG3smZmmXYgccr
         uSOZID4KxBtbRYlE+5DzLmbTAZ+0UWldA4oJxDpKPrEnop8Fo9ENjzluPuJpHAt/f0Ph
         JWHz1tJmUUKYOA51azuWN3u/HBuHP6xKdAEKkTinas859+sluZ5V6iIwToVN0w545JZ0
         3MztadxrOxyAdk25++05k8H4fZKxTQ71SQh5zMwp9yN8iMhkMaVGQTUzYKS4c55c7s98
         4/Uv6gYvdgNlFaNfigcT3+pjUGlyDppfCnmg8Tgo1wa+NEPrmpAzqwTGnItaDus8dWJS
         vbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUB8geEpJ+XtoTHFW5CyzSR89RxzbZocHBgXZDsT0q4=;
        b=KE94u4wmTkgQEH/O8yfuWzViiQtGzNEuVFT/bd9ixRA7V+iz982xABdV/mIof3qD2I
         QDGnM6BlC7hC+ILNUSwA0CmA/8wWgY9zctQM3+4wo/IewclJ5l6J4sz4fyVbR2AQ/+dq
         rTxRTbC/aZZ80RiLXBB1O49sbU3VXmtILoEE8VNsMn4zCqpMdJx6XzMH4SobMCJE+KU5
         //lsDgUi8iynPfkOXUQjKbf3kvRQDPNJQmQYqAQ5rdT2QUS35FZVtPk1m1jfFlILzR5E
         evz4aFjG/yfrBFY5vuYGMByjV7lXfUYtwfsWWQqANk74xOspo53k3D/lBroLpEmXk18k
         NdDg==
X-Gm-Message-State: AOAM532wk/zihIE8u1OJviT4yGsHl/dYz8bG61SS1wnXrQ3UU/mufWT3
        OQMgR6SUL6j1XZfkODrk0yOm7Hg6rE45GrASuSRcp91alkA=
X-Google-Smtp-Source: ABdhPJxMwIgsbbMlOTDNiL7M3O6I5DfVtqlrxkmc58HdiEKBYmj4+VrHYnD7h5nPhaUJdRIDGvR7mrBpMKdCiPBYlTI=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr1821136pgb.74.1646870515046; Wed, 09
 Mar 2022 16:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20220302082718.32268-1-songmuchun@bytedance.com> <20220302082718.32268-2-songmuchun@bytedance.com>
In-Reply-To: <20220302082718.32268-2-songmuchun@bytedance.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 16:01:44 -0800
Message-ID: <CAPcyv4j0cMaknAcMSHJ0U0QP4E2btir2b+1g=Rw+o2CHVQrH=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] mm: rmap: fix cache flush on THP pages
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>, xiyuyang19@fudan.edu.cn,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, duanxiongchun@bytedance.com,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 2, 2022 at 12:29 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
> However, it does not cover the full pages in a THP except a head page.
> Replace it with flush_cache_range() to fix this issue. At least, no
> problems were found due to this. Maybe because the architectures that
> have virtual indexed caches is less.
>
> Fixes: f27176cfc363 ("mm: convert page_mkclean_one() to use page_vma_mapped_walk()")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
