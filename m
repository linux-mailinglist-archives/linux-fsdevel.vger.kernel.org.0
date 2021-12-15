Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5C4758F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 13:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242572AbhLOMhH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 07:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242562AbhLOMhF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:37:05 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0719C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Dec 2021 04:37:04 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id x32so54685470ybi.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Dec 2021 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8r8XSvSuYu3ZxgnX8Iq0jqKYxog5KOUtPtLKnhEkEw=;
        b=4AghxD+KT7s9yyElNwN0c1w4aNYag2FvFgEPc3cpIfezoxE3NZoiARw3vAa2yfY3hS
         mw4n3mu7LS8hUEQJdwZdCZrpAhDjhD85Tj79vszagcjseK8hZnI2rN28Gqc1wGXyTzRM
         71tD+sziOM3stmstau3gQY+2HNKAUpGP2vlVtzaGEP+V2HHCS4Aqc4j2dmP/AV6QFx/2
         jI1B3buJphwPACrGU5LRR5B2i2jKjCRGf3koV/uPKRBOZQhGbcsiyFf4Y6v2l5yW+ejD
         DL9TjdFNqQg9FyhizICVZK1xqnOkJGODiQmuC/1oesPvmXMbI4vBBAyuO4GGaukq+0LM
         EuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8r8XSvSuYu3ZxgnX8Iq0jqKYxog5KOUtPtLKnhEkEw=;
        b=U6f31ut01jUE/uG24Hp4XkxMRkV4bz6IVXRjITnzAePe5Mr+nuqO9xaGfX/+Grb7xQ
         N3iwWHS+DP2gnbNU9M4wSW0kpGlGBpJhajgsp/Sudy/n6XBRsHFOIPw/zwcKnthahiH3
         mergXdJqJH+9exGGNZldQEn7eWXrDMCWtt8TTu2s1F/NB46TulbTp20U9158k+Ge1EWd
         GZ3Bi0NmIyeu0DMLpUaKmwDwufKEGdvas6mohP4EAG4UoJfKxcnXkyG4spKF6gjqS5iR
         +otKrRCB5Jj4h2KO0SAS81sHsIrpokhRIEZd/57tL4uEpCvhhfu6FfJJZeHJNB5m6DRQ
         tPpA==
X-Gm-Message-State: AOAM532EeRtuDa+9eAMdXhhAztl8VNchPudT3GAE4aJWCQ+1S7jOLafk
        AmsPRZTwEozI2oD8qxxtes5VWMCoHXZaOMenVngfkA==
X-Google-Smtp-Source: ABdhPJy7XuDUBZjUXayR4SOS35Xzmwel1sEN2LoYxG/u2Rr6YggD031pTlQUTqN+7t/G1Dw+lmYcEL/VApAhalHOoWY=
X-Received: by 2002:a25:b285:: with SMTP id k5mr6012330ybj.132.1639571824184;
 Wed, 15 Dec 2021 04:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20211213165342.74704-1-songmuchun@bytedance.com>
 <20211213165342.74704-10-songmuchun@bytedance.com> <YbilqnwnuTiQ2FEB@cmpxchg.org>
In-Reply-To: <YbilqnwnuTiQ2FEB@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 15 Dec 2021 20:36:28 +0800
Message-ID: <CAMZfGtXng-X2LPZ3CHwNuyT6LtnkWcHsd_3FZiQpchwtKhR5JQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/17] mm: workingset: use xas_set_lru() to pass shadow_nodes
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Yang Shi <shy828301@gmail.com>,
        Alex Shi <alexs@kernel.org>,
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
        fam.zheng@bytedance.com, Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 14, 2021 at 10:09 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Dec 14, 2021 at 12:53:34AM +0800, Muchun Song wrote:
> > The workingset will add the xa_node to shadow_nodes, so we should use
> > xas_set_lru() to pass the list_lru which we want to insert xa_node
> > into to set up the xa_node reclaim context correctly.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Ah, you can't instantiate the list on-demand in list_lru_add() because
> that's happening in an atomic context. So you need the lru available
> in the broader xa update context and group the lru setup in with the
> other pre-atomic node allocation bits. Fair enough. I think it would
> be a bit easier to read if this patch and the previous one were
> squashed (workingset is the only user of xa_lru anyway) and you added
> that explanation. But other than that, the changes make sense to me;
> to a combined patch, please add:
>

Great. I'll do it. Thanks for your review.

> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
