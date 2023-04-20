Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C3D6E9D24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 22:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjDTU0Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 16:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjDTUZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:25:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0C783DB
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 13:24:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94f3df30043so103301566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 13:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682022251; x=1684614251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbIzxM2shVuTXnR29vOy8VrlUCteiWMqeXeOo/QS9Rg=;
        b=VTaW3U7jSYhLPocSpczDYnca0rbAWGQgU2jjGGlWDIq5GGg1s2LuD56syxmIWB+6qR
         GCRzWrCkj7UaWW4VmeG1EDlGeA2cv5n6i+/1ZlmxgT8KbN4mV/xe61NzDcaW4rgYDkgm
         jHokeVXZP6pipdMf0KYcooTWmSNa+7hzYwjVBYtlvaK8xZd+wUfSZws1DmUuiXY7Zbw7
         sBLoAcQ2EBQdn5Dl8NmHIWdrl8ZjowRpXxXgceiE5uvfZD8U7QlqDQvr7zKtIoo3yem0
         cRMo4BXarqyRoyMm8OOAQ4Xxw847QScEkKKvvVSbe29ydE5meDqi4SZWKSGtKkSI4epK
         vLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022251; x=1684614251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbIzxM2shVuTXnR29vOy8VrlUCteiWMqeXeOo/QS9Rg=;
        b=Bo0DuXjXO2fqt4MJfTsULDy3PB2TRr73KlsrXbAU4upCG4INVsEXP48cb8qwf+q7eh
         i6D2+lSAXWARAQ9AaehasaSMcaCdNFdE5oKb/TSfmLhYF0lfjlpIbcir4Cck5z6D/MDs
         kelFQd2Ljov7txtuGjwPLI9rNWaPZRvAzYZkU2VFV8Ch+6mvDuOteoN+ZJI+HXnwWmEw
         i9AxVIVP+2DqQD9ZKgegVNd51cSgq8FNi0BGQELG6c9uE2vqu8oK8gfvaNUwGGuxgF6k
         EaJ28emjnk/Mzixj/BCOfJ2869KKNepGA40AYyws9Cpmw0eO0vxiNPE428kYek94fcmR
         pDgQ==
X-Gm-Message-State: AAQBX9dk78OtpxCCGL2/SLUVw0bZKTXG6XNMzi/odhn8Ib1WmZD6tUHf
        9o590WpxhxHNiq5r+hX87sdNotEKk1MO6HZHWKH85w==
X-Google-Smtp-Source: AKy350YzP2DUqggsYt0ZcKkLG944feScSZjAPbMWQZcCGzSlr7o4ESqaB9KAAN7o5+mnXTfcXLI3Ws7U4tV4gtZ7zlc=
X-Received: by 2002:a17:906:fcd4:b0:94f:50d:e16e with SMTP id
 qx20-20020a170906fcd400b0094f050de16emr241914ejb.12.1682022250565; Thu, 20
 Apr 2023 13:24:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-2-yosryahmed@google.com> <7woe6ljcarqsr6uep7uns7bc3hm6xqog6ufk4rhwfo4vxixczw@tdjkdhx2euok>
In-Reply-To: <7woe6ljcarqsr6uep7uns7bc3hm6xqog6ufk4rhwfo4vxixczw@tdjkdhx2euok>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Apr 2023 13:23:34 -0700
Message-ID: <CAJD7tkYxU7Bx7zAh=wRoGQeyu9UdR6noYiM3Q8Laaf2+13Jn=A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 1/5] writeback: move wb_over_bg_thresh()
 call outside lock section
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 4:38=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> On Mon, Apr 03, 2023 at 10:03:33PM +0000, Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
> > flush, which can be expensive on large systems. Currently,
> > wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
> > have to make the rstat flush atomically. On systems with a lot of
> > cpus/cgroups, this can cause us to disable irqs for a long time,
> > potentially causing problems.
> >
> > Move the call to wb_over_bg_thresh() outside the lock section in
> > preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic=
.
> > The list_empty(&wb->work_list) should be okay outside the lock section
> > of wb->list_lock as it is protected by a separate lock (wb->work_lock),
> > and wb_over_bg_thresh() doesn't seem like it is modifying any of the b_=
*
> > lists the wb->list_lock is protecting. Also, the loop seems to be
> > already releasing and reacquring the lock, so this refactoring looks
> > safe.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  fs/fs-writeback.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 195dc23e0d831..012357bc8daa3 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -2021,7 +2021,6 @@ static long wb_writeback(struct bdi_writeback *wb=
,
> >       struct blk_plug plug;
> >
> >       blk_start_plug(&plug);
> > -     spin_lock(&wb->list_lock);
> >       for (;;) {
> >               /*
> >                * Stop writeback when nr_pages has been consumed
> > @@ -2046,6 +2045,9 @@ static long wb_writeback(struct bdi_writeback *wb=
,
> >               if (work->for_background && !wb_over_bg_thresh(wb))
> >                       break;
> >
> > +
> > +             spin_lock(&wb->list_lock);
> > +
> >               /*
> >                * Kupdate and background works are special and we want t=
o
> >                * include all inodes that need writing. Livelock avoidan=
ce is
> > @@ -2075,13 +2077,19 @@ static long wb_writeback(struct bdi_writeback *=
wb,
> >                * mean the overall work is done. So we keep looping as l=
ong
> >                * as made some progress on cleaning pages or inodes.
> >                */
> > -             if (progress)
> > +             if (progress) {
> > +                     spin_unlock(&wb->list_lock);
> >                       continue;
> > +             }
> > +
>
> This would release wb->list_lock temporarily with progress but that's
> already not held continuously due to writeback_sb_inodes().
> Holding the lock could even be shortened by taking it later after
> trace_writeback_start().
>
> Altogether, the change looks OK,
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Thanks for taking a look!

>
