Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F6B6D188A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 09:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCaH0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 03:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCaHZ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:25:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC86A3AA6
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 00:25:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso153295e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680247551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw4kStS7rzbbLRqrWs4BjnS/rfPwq6lyL0n3r//piM4=;
        b=BD2fSO1ioVmfH8kTUKFk4RCIgml6T+ntV2pSMl6FqHKLjBbsMywpSB7JFDCoHurnLI
         V9o1X7oCj9Jv5ac882+AMXAfxTwK6hLy+/NK3ZJi40FJTY+CbC1IQQLS+YMLkwbtbzOw
         H3sh2XMfB1LLIlPQbZUAdPb93N3AvQGMds9a+yyZpaDSCaJRwSpUPqMLTuR1u3z+/Ur5
         68nP8o+u0Th7+o5O4AlPzpPsLH/f/sblbW/IGfzEWBSXq4hUwKdloV4cMx/+7YLbpiPM
         pAqmx55DTfBdGh74Xl6PY3KG+bjnX/S2cqxeLC1pOy22SVlDFDHPpiwk8k6bVUcElsQ3
         dWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680247551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw4kStS7rzbbLRqrWs4BjnS/rfPwq6lyL0n3r//piM4=;
        b=wTgxBb9SN5XjI0H5ZJBXelicLgj2BB61NbkrIfigCbJlfOAiwHVSUuzbCTgTekO5ir
         VSlOXOVDF/WnmcAJZMqBUbdHX6LeNDfwVwathpZzk7v49IMdG+E2F1Q2LzLXEBUcjqZ5
         g+Fxoqnf+NRIxPYjScdva9JZaeODwiwo6N0a+zix4bp09Ybkl+z62XLyeV7iWB7irxkS
         a56Uc8FKA9jfiL/UxaPwSNgW9C5XxrH2geRxuXd8Km2PMAgxmB24N+e9bTtEi2VTzyZQ
         4jkIqRxMyX5VZLdP691Y4S2ZIeou4IxClIUibvyJnnMEf5c5QitlvTQz85Byj3FpTm1F
         0ybw==
X-Gm-Message-State: AAQBX9dbJEA4sKZodJNSwFptS6ttik7ANBSZS0QrzLv22vf+pgNHziR2
        LDeui+/XovFUguTbBID4LFJiJWRs5rGUz7mp8ZCjbA==
X-Google-Smtp-Source: AKy350abOVAkC/dx0dxQVe8vtvq9YDRYyGvhn/EWZ6txiXHe82kTuCLaKsXWJ3VDTDrFx6WCn8woIMYCmAHVCwAovDk=
X-Received: by 2002:a05:600c:1e26:b0:3df:f3ce:be44 with SMTP id
 ay38-20020a05600c1e2600b003dff3cebe44mr81129wmb.3.1680247551038; Fri, 31 Mar
 2023 00:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230331070818.2792558-1-yosryahmed@google.com> <20230331070818.2792558-4-yosryahmed@google.com>
In-Reply-To: <20230331070818.2792558-4-yosryahmed@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 31 Mar 2023 01:25:14 -0600
Message-ID: <CAOUHufY2NieQ8x7-Kv8PSzMVEOjJtBhi6QwKeu-Ojxnia4-TpQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 1:08=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:

...

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a3e38851b34ac..bf9d8e175e92a 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -533,7 +533,35 @@ EXPORT_SYMBOL(mm_account_reclaimed_pages);
>  static void flush_reclaim_state(struct scan_control *sc,
>                                 struct reclaim_state *rs)
>  {
> -       if (rs) {
> +       /*
> +        * Currently, reclaim_state->reclaimed includes three types of pa=
ges
> +        * freed outside of vmscan:
> +        * (1) Slab pages.
> +        * (2) Clean file pages from pruned inodes.
> +        * (3) XFS freed buffer pages.
> +        *
> +        * For all of these cases, we have no way of finding out whether =
these
> +        * pages were related to the memcg under reclaim. For example, a =
freed
> +        * slab page could have had only a single object charged to the m=
emcg
> +        * under reclaim. Also, populated inodes are not on shrinker LRUs
> +        * anymore except on highmem systems.
> +        *
> +        * Instead of over-reporting the reclaimed pages in a memcg recla=
im,
> +        * only count such pages in system-wide reclaim. This prevents
> +        * unnecessary retries during memcg charging and false positive f=
rom
> +        * proactive reclaim (memory.reclaim).

What happens when writing to the root memory.reclaim?

> +        *
> +        * For uncommon cases were the freed pages were actually signific=
antly
> +        * charged to the memcg under reclaim, and we end up under-report=
ing, it
> +        * should be fine. The freed pages will be uncharged anyway, even=
 if
> +        * they are not reported properly, and we will be able to make fo=
rward
> +        * progress in charging (which is usually in a retry loop).
> +        *
> +        * We can go one step further, and report the uncharged objcg pag=
es in
> +        * memcg reclaim, to make reporting more accurate and reduce
> +        * under-reporting, but it's probably not worth the complexity fo=
r now.
> +        */
> +       if (rs && !cgroup_reclaim(sc)) {

To answer the question above, global_reclaim() would be preferred.
