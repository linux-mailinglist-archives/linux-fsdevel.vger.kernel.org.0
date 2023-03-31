Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7D56D2AF9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Apr 2023 00:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjCaWM2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Mar 2023 18:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjCaWM0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Mar 2023 18:12:26 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A936F9751
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 15:12:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so95285505edo.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Mar 2023 15:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680300743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXj7Qyhuc3VANVAIof/dkXyPEcXygM8YpKQLnR/FCeE=;
        b=Y7wgIhz8nV9/+JLQsYPnAwcryWNNk6SGIsTlR1ZDgFqo2CeTCBdwaY/59tRk1x6wDD
         kJ6hALcgHquJ/7Uw4MiIw4axX8C5DJ7h0ca615Iy3dMLiloDQeOLieUPgXncrwBpcX4e
         m4gAv6Jw4n7BAz5q/oWkZXbBG/l1vfedPJXZxOVCX0izr91Hbzh9Ff5RgEavalR/3rVf
         TlgSh9YdhXvtBNU3CNgG30msbxq42Qn1Iz3O8TlEOIqVOanF6/XVsco+Fyj6Qy1Je7EI
         VsH7GhxQddG6FAxXQId4sr1vTc9RbdeM9SBpzwSijPTcRwfUk4JQDAajQQajP2kXyrdy
         7WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680300743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXj7Qyhuc3VANVAIof/dkXyPEcXygM8YpKQLnR/FCeE=;
        b=QNKgf5fE9fM/8r/hfxW8H8CXlK/IlSMN6xnuXEtixU2nq+p+EdhiJDUOJp89okwrDs
         18pKdOPeJa3mT/djaN0vV5DQLfQPWxr7mHw3PGTugf5LyJXOarpvff798sLSu9D3dqgL
         rMIHBLAomBP0CDRgyNdvg0HsiLzqlnSEBNgOGvf+PoETNIDYS0YYvy856JrDkZBjiSgq
         qPHOvItreAmgMsAa+BsnRI+gQwtO+JrDBbaSd2O2EqpFrBiaf0dEsIC3r2ap5sk+BxO8
         qxYqt3E1C4arwg7kFJ9anBHdkLQeoWGI56ogfil+3axn9kAdKdxvirB8rEl9JEDKbI/5
         vmWQ==
X-Gm-Message-State: AAQBX9eVi2i0OsCRbFcdNzE8x0HvMfwXsFwFbvi71GOoqO64ZAOEFD1Y
        bDMaJBJG4b1w+ItJr7E9LiRVNNfND2NPT/IEMViFDQ==
X-Google-Smtp-Source: AKy350YNxzefAx/NXeor8UoJ5Yql4qMe7ZyBd+MvOF9a06S3oO/DniRs2KI3wKVInPUmESDZhZ1+jvPbQ747jsXKQN4=
X-Received: by 2002:a17:906:2456:b0:8e5:411d:4d09 with SMTP id
 a22-20020a170906245600b008e5411d4d09mr14741355ejb.15.1680300742955; Fri, 31
 Mar 2023 15:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230331070818.2792558-1-yosryahmed@google.com>
 <20230331070818.2792558-3-yosryahmed@google.com> <20230331205117.GI3223426@dread.disaster.area>
In-Reply-To: <20230331205117.GI3223426@dread.disaster.area>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 31 Mar 2023 15:11:46 -0700
Message-ID: <CAJD7tkai_tv32GREjLvopLkUufq+WiR0-fFr-eNAzZNmQqk5dQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: vmscan: refactor updating reclaimed pages in reclaim_state
To:     Dave Chinner <david@fromorbit.com>
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
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
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

On Fri, Mar 31, 2023 at 1:51=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Fri, Mar 31, 2023 at 07:08:17AM +0000, Yosry Ahmed wrote:
> > During reclaim, we keep track of pages reclaimed from other means than
> > LRU-based reclaim through scan_control->reclaim_state->reclaimed_slab,
> > which we stash a pointer to in current task_struct.
> >
> > However, we keep track of more than just reclaimed slab pages through
> > this. We also use it for clean file pages dropped through pruned inodes=
,
> > and xfs buffer pages freed. Rename reclaimed_slab to reclaimed, and add
> > a helper function that wraps updating it through current, so that futur=
e
> > changes to this logic are contained within mm/vmscan.c.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> .....
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index fef7d1c0f82b2..a3e38851b34ac 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -511,6 +511,34 @@ static void set_task_reclaim_state(struct task_str=
uct *task,
> >       task->reclaim_state =3D rs;
> >  }
> >
> > +/*
> > + * mm_account_reclaimed_pages(): account reclaimed pages outside of LR=
U-based
> > + * reclaim
> > + * @pages: number of pages reclaimed
> > + *
> > + * If the current process is undergoing a reclaim operation, increment=
 the
> > + * number of reclaimed pages by @pages.
> > + */
> > +void mm_account_reclaimed_pages(unsigned long pages)
> > +{
> > +     if (current->reclaim_state)
> > +             current->reclaim_state->reclaimed +=3D pages;
> > +}
> > +EXPORT_SYMBOL(mm_account_reclaimed_pages);
>
> Shouldn't this be a static inline in a header file?
>
> Then you don't need an EXPORT_SYMBOL() - which should really be
> EXPORT_SYMBOL_GPL() - and callers don't add the overhead of a
> function call for two lines of code....

Yes it should be. Thanks.

An earlier draft of this series had more going on in this function, so
I moved it to mm/vmscan.c, then I forgot to move it to the header
later. Will do that for v4.

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
