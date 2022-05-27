Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E497153575F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 03:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiE0Bkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 21:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiE0Bka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 21:40:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7016D9EB5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 18:40:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nn3-20020a17090b38c300b001e0e091cf03so1961700pjb.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 18:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsCeaKQYu2owUyCBDwtZbNFjRtUaibD4xCTBzD5NHwQ=;
        b=h5Os058/7Tkd1AvepTU0323lt2cG3mwUjYbiF3arFls/6rkKiXILKvCHrwLRQsySnZ
         96/cCr2uqYFgpmz9nwuM3rG0f2J7xv5nQ0hqC6+iVv8nc4HgwHmTAlochAsZhfhqI83i
         saL36v4tANwGgUtHRDRXTByMQY8bwYbtQ/ll7KeQkIdOsJMyc1FvNm6aEzlzHG2k8jqo
         +V8bpsIxil8gc9piiCPIB8XYrUg5bo5kaXjbukdEC3xyym+MtICa2qY2Tcir2U37jJ1m
         4ORO+Hu35zYgIWw/XT9PYNPw2QnLNZ1+Eb9F16UCV9gkZsq4Szql++3KR1rUZ5VhzQ/k
         YUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsCeaKQYu2owUyCBDwtZbNFjRtUaibD4xCTBzD5NHwQ=;
        b=36IA3WM1oL/POAevfQkCs5Hv7EsigZTjYPgB0R8yUuwORnLjgJ2+Ct8SbAEbTZME4m
         Ph6bn1JrxUuqXBnrIu99QIILXn6o6aEiwBMaVM+9VH09tz4fUrkP/jTzfd441IVHGfPj
         DbizfGAGSQ8G8GNlfbdgtL+LthVYiz1Z5KzweLjBcnfTKehGqVUJhN6doXvwtFUYm4n9
         a9cbh0fH+I1ijAwSjy+cn8z/sJOh9wyGIl1+bU7h1luV+h6P1qhT15AoxU+9WNeZm2AQ
         Bfwew8UpLzp2QjbHHVZVh9XdOl6TfwDFtmutNov2Noi+4F+tArbjxsdB/z5Jjdqhb3mi
         6kzQ==
X-Gm-Message-State: AOAM530Vu1PoNzMvIA07Uu2ZYKFofdWEE0UahvH9y/QFO2ahS9Spt8Kr
        7I2kRXw7TGCmJEL9+97rWffbE76OOmJpxuZePESY7w==
X-Google-Smtp-Source: ABdhPJzk910Eqiuu/69sbIFt/rEQ4I6MtCDwrXFQ/nJqkbUlb/6Ny4mXvfFnPS95wsU6a5b8EAwIeusUd82ItqgJ2NA=
X-Received: by 2002:a17:902:b58b:b0:162:2e01:9442 with SMTP id
 a11-20020a170902b58b00b001622e019442mr20257616pls.6.1653615629019; Thu, 26
 May 2022 18:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <348dc099-737d-94ba-55ad-2db285084c73@openvz.org> <YpAnqqY/c3Y5ZkPG@casper.infradead.org>
In-Reply-To: <YpAnqqY/c3Y5ZkPG@casper.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 26 May 2022 18:40:18 -0700
Message-ID: <CALvZod7iyO5Ti5xhzq36UjDFNAmfEyPk1MQv_t4kUHKuPCeNng@mail.gmail.com>
Subject: Re: [PATCH] XArray: handle XA_FLAGS_ACCOUNT in xas_split_alloc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vasily Averin <vvs@openvz.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 26, 2022 at 6:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, May 25, 2022 at 11:26:37AM +0300, Vasily Averin wrote:
> > Commit 7b785645e8f1 ("mm: fix page cache convergence regression")
> > added support of new XA_FLAGS_ACCOUNT flag into all Xarray allocation
> > functions. Later commit 8fc75643c5e1 ("XArray: add xas_split")
> > introduced xas_split_alloc() but missed about XA_FLAGS_ACCOUNT
> > processing.
>
> Thanks, Vasily.
>
> Johannes, Shakeel, is this right?  I don't fully understand the accounting
> stuff.
>

If called from __filemap_add_folio() then this is correct.

However from split_huge_page_to_list(), we can not use the memcg from
current as that codepath is called from reclaim which can be triggered
by processes of other memcgs.

> > Signed-off-by: Vasily Averin <vvs@openvz.org>
> > ---
> >  lib/xarray.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/xarray.c b/lib/xarray.c
> > index 54e646e8e6ee..5f5b42e6f842 100644
> > --- a/lib/xarray.c
> > +++ b/lib/xarray.c
> > @@ -1013,6 +1013,8 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
> >       if (xas->xa_shift + XA_CHUNK_SHIFT > order)
> >               return;
> >
> > +     if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
> > +             gfp |= __GFP_ACCOUNT;
> >       do {
> >               unsigned int i;
> >               void *sibling = NULL;
> > --
> > 2.31.1
> >
