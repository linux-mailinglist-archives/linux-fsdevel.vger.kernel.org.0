Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5AB6E9C26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 20:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjDTS5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjDTS5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:57:20 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D039DE65
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 11:57:18 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3ef36d814a5so908781cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682017038; x=1684609038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPC/T+cZBiALDJb1UQ+biPUmWPyQkwBmvhpGsYNp8Ec=;
        b=PkKT30pQsy0dCCBavAqHdYdEypziw027sTRPtrDqQEAdFY/TgNivu3OfPvntSwK5vh
         mU5R6qzBEL+qOULk/9IpVdRCuSYMJd/CzosuFnkJHrtdKzbtz0qrvCTLqa6YVYOFENL6
         eUbuwLtPygmsEnnix7qVPS4j+Mb06vn2kCVGU22IQ/QipOnHx3x30cc17Wf2V/b6eOQA
         FBcLvayQhbewEQqXjzzBGqjCWuPzVpydlIFaj667t12Zh2ffgrUquDBsin3Tzj+OScUJ
         BWjEbdTXXG4edmqIovf5NwazZ359XreOT3MIExV27wqDBPOW6JeKvDnWf6Vv752fS0yk
         hnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682017038; x=1684609038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPC/T+cZBiALDJb1UQ+biPUmWPyQkwBmvhpGsYNp8Ec=;
        b=QfDG9dKa2qZ7MZzLRjb1zf/hxczlQs178GQ+c4fZ8clVybFc9DEmOiDPS48MpLOLvq
         +POlnYZgdChxBiivi3jOyZ1kdrYOq4TwiL6I4s1MWoBwSDrhDcCOd8ZOdUBBUtkADffF
         xrZ2y+yGzrtYFVcKXvCcfWxj3FHy1wKrmqO/RIqqUx7GU5IAB20u/1GZGgwp9ALkz8iL
         JaDQFu/XtsU8JOBCqn6HXeEDd9uJy42tnLdtYKitexCrIqTSzvCaRafXwoB9LaB9qPUP
         jPT0P6OEcqoZt07fpzmlSVWKZaKPk1t6sm/hVr2dpHNiDe5azLSf+chafRhqIpkelT3t
         Oxtw==
X-Gm-Message-State: AAQBX9cGy6AMrMejyndncG81uGwJxV7yIyXgycETzHF2VPBVW46W89ih
        sfRIQDPKBJgL/5bXGrzxLGSx3ZNhVBolNCK7mKcMBA==
X-Google-Smtp-Source: AKy350Ybjxqe9UNlAY93vEa6/CWa86430QrJTp0Wuib3dT/K1RCencGmEZTuWYiHeeJuqVMNI7KbpwHyDPsTlcYFsTw=
X-Received: by 2002:a05:622a:290:b0:3ef:5008:336f with SMTP id
 z16-20020a05622a029000b003ef5008336fmr29892qtw.1.1682017037936; Thu, 20 Apr
 2023 11:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com> <20230403220337.443510-4-yosryahmed@google.com>
In-Reply-To: <20230403220337.443510-4-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Apr 2023 11:57:06 -0700
Message-ID: <CALvZod5WNiiV2NmikaGMPd62hiGtKWZrO0f2amk2HE8quBxkDQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 3/5] memcg: calculate root usage from
 global state
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Currently, we approximate the root usage by adding the memcg stats for
> anon, file, and conditionally swap (for memsw). To read the memcg stats
> we need to invoke an rstat flush. rstat flushes can be expensive, they
> scale with the number of cpus and cgroups on the system.
>
> mem_cgroup_usage() is called by memcg_events()->mem_cgroup_threshold()
> with irqs disabled, so such an expensive operation with irqs disabled
> can cause problems.
>
> Instead, approximate the root usage from global state. This is not 100%
> accurate, but the root usage has always been ill-defined anyway.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
