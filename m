Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F1C4ED2BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 06:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiCaEMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 00:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiCaEMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:12:22 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4365158791
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 20:53:27 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2e5757b57caso240885787b3.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ak2t2jCNQu1M2/jAOYEZkhc3R1ocF5/1qJQ+3hjAnME=;
        b=tkvUPecqmQulNzBQqTFmi7Dei2Lz6Mn445nrLTgnye7JELzViZqpIsbrhlyTvAs+Dc
         O2PzcrgIEqVcpVDVfjoBCzrwz8cX6owQtgn4k6W0tHNglJN4AxjMI4S42ir904Ky4cYz
         h8wULYh2QFZ3as3p2woAyxMFzGQCOFFEEsBnQAM8d1aloqJodsljEyX78x1pTQqYRTrp
         k2dHlWyyTA+IYWWBvIymhVYCJxorN4SNj1SlOo3wDa71/kBxms27NThdj/CmV/nrhGaF
         nwZr/ZqIWMYjR/DW2zaK8s6hVwv9+iUUYlf4yoK3QkMztFkKtOTVhQ/LBO/KJC3rdAKn
         BlhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ak2t2jCNQu1M2/jAOYEZkhc3R1ocF5/1qJQ+3hjAnME=;
        b=l02qKmnbFKsSXmW7uzdGERLStxE38ymGg1OtGl4jcVdDfvJ6ml1m4iQ03WG053P9/w
         zpVpC+YxpwW9KoIXOmpOO2Ke3hJWsXERdCqn7dxzO/plcUP9YnaGh00KqOfoxMpTv+lN
         U6p4ZJ69LJKq0KJlNvSv5hiLGhieEFxBTW5PkTm3Fcmtp96u1CQUJAeDWR6owc8R3GQi
         IvEkvNOiouZtmxGbXcmmW7uhH2eXip0R+C27LX1WNwM/lly9buvJsZDe44huHMIa/ghJ
         NNVqxewDsvovr4DEjTziPT8YiV8ywW6GfgBmM9xshW0pdi99RUoVCEB2PMkir9yo4Jdx
         nR1A==
X-Gm-Message-State: AOAM5320p2XQnCKGpFnSWVYs8rWldGLpS821qnFn6po2hsS1ua1q85Ik
        e+F9Jlb1locc8ef4H2cbQ/7sfEVamP3/oIFcXpMN2w==
X-Google-Smtp-Source: ABdhPJxHjh8wcw0AdvJ2RbvjPxEo4eKx9G8Z+IYtVJqziw69Fb+8Y8BoQ0j4XCRCr056HsXRwjqBvkq5wyqIZqUk8Dk=
X-Received: by 2002:a0d:f685:0:b0:2e2:22e6:52d7 with SMTP id
 g127-20020a0df685000000b002e222e652d7mr3190538ywf.418.1648698806850; Wed, 30
 Mar 2022 20:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220228122126.37293-1-songmuchun@bytedance.com>
 <20220228122126.37293-13-songmuchun@bytedance.com> <164869718565.25542.15818719940772238394@noble.neil.brown.name>
In-Reply-To: <164869718565.25542.15818719940772238394@noble.neil.brown.name>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 31 Mar 2022 11:52:50 +0800
Message-ID: <CAMZfGtUSA9f3k9jF5U-y+NVt8cpmB9_mk1F9-vmm4JOuWFF_Bw@mail.gmail.com>
Subject: Re: [PATCH v6 12/16] mm: list_lru: replace linear array with xarray
To:     NeilBrown <neilb@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yang Shi <shy828301@gmail.com>, Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org,
        Kari Argillander <kari.argillander@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:26 AM NeilBrown <neilb@suse.de> wrote:
>
> On Mon, 28 Feb 2022, Muchun Song wrote:
> > If we run 10k containers in the system, the size of the
> > list_lru_memcg->lrus can be ~96KB per list_lru. When we decrease the
> > number containers, the size of the array will not be shrinked. It is
> > not scalable. The xarray is a good choice for this case. We can save
> > a lot of memory when there are tens of thousands continers in the
> > system. If we use xarray, we also can remove the logic code of
> > resizing array, which can simplify the code.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Hi,
>  I've just tried some simple testing on NFS (xfstests generic/???) and
>  it reliably crashes in this code.
>  Specifically in list_lru_add(), list_lru_from_kmem() returns NULL,
>  which results in a NULL deref.
>  list_lru_from_kmem() returns NULL because an xa_load() returns NULL.

Did you test with the patch [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=ae085d7f9365de7da27ab5c0d16b12d51ea7fca9

>
>  The patch doesn't make any sense to me.  It replaces an array of
>  structures with an xarray, which is an array of pointers.
>  It seems to assume that all the pointers in the array get magically
>  allocated to the required structures.  I certainly cannot find when
>  the 'struct list_lru_node' structures get allocated.  So xa_load() will
>  *always* return NULL in this code.

struct list_lru_node is allocated via kmem_cache_alloc_lru().

>
>  I can provide more details of the failure stack if needed, but I doubt
>  that would be necessary.
>

If the above fix cannot fix your issue, would you mind providing
the .config and stack trace?

Thanks for your report.
