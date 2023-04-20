Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A696E9C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 20:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjDTSya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjDTSyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 14:54:05 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D4859C1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 11:53:33 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3ef34c49cb9so893161cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682016812; x=1684608812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sYlJSAfMy5ZKFxBnqgIBVbqBgUxlBgjbZy6mx61ZB0=;
        b=wPs26Moc03UYXJfZwMIlURgsn2RCjMAbb7a+Kr6qiZim9sSPBSM+ZdRg4TYPr4vYxC
         QmCGtQFf+XPuri/obaV1duh6RAYA1qF/ZHAWZew0TZE7gE7UZb675H1CuZBgHJZA9Ze3
         JQDW57Ph2p1gegrBk5yb+/Cugi0waHR4zf/tF/KJuRI6aDUUzOySpS2PNB/mXKSyqIaj
         D6omDunMmwh7KE2tnbKxW3RSmLqgYQtibyeHI+ZrrYfdfCGk4cwgkrE06btrC9PAEVdR
         Ph0y7LUZGeuxMPJOCKnLmZqnjGOPUXbAkl8GvlEHQuAkYggnt45ueFJhkm469/iP9wO1
         wwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682016812; x=1684608812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sYlJSAfMy5ZKFxBnqgIBVbqBgUxlBgjbZy6mx61ZB0=;
        b=cIxozZZwRDinw9BTHF/9Nb9l27rqiENKy+yy0SYxkN9U1lkFQEWUQkbSlik+yh+R9M
         cQ+Drcdi5McYRnG/ETA/p69O2Fci9m5Hjy/TMDKNx5EWkYI67glBYkR+F88EhjoGnGh8
         ykxJNRDv+MgABrUie0srXqCqTFymWdwUsSMMHmxUQlODK/4PmjattWyv3J5SHOFX5ry5
         USCQkaVgMiWcR67RMDzHGQGSTgKCFG2XU/90jWqbDlBTD6FZLs59DaneZP+k1S8ePbEr
         qWQPxviXi7fo7Nk3HUdZK/GjiDKSp7nR/OXUOVJWPkwn8PJ21XiqnpE7xiYozfj5Djle
         SNNQ==
X-Gm-Message-State: AAQBX9efqrRTVE8Sm2HBye5D15soJK962foJnpuYio3SfIxzZPWxK5/H
        BvSNOEDZwXgtX90EkY4yvnobTQVYsXYsepoTV1uXgA==
X-Google-Smtp-Source: AKy350ZUv2Xw4EFjMQ3KO6rvuBHNKuGSX7X3hNqVdy6HeEhjaawEFI6dET+AMFaOtrBZGB3lve7sVEWIENM6k4qSjCs=
X-Received: by 2002:ac8:5b10:0:b0:3ef:343b:fe7e with SMTP id
 m16-20020ac85b10000000b003ef343bfe7emr59146qtw.2.1682016812108; Thu, 20 Apr
 2023 11:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com> <20230403220337.443510-2-yosryahmed@google.com>
In-Reply-To: <20230403220337.443510-2-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Apr 2023 11:53:21 -0700
Message-ID: <CALvZod5h5G9YNu8d9fAOL5eXie5iM3urw9QgD=vucBdCMAQnxA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 1/5] writeback: move wb_over_bg_thresh()
 call outside lock section
To:     Yosry Ahmed <yosryahmed@google.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
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

+Jens & Jan

The patch looks good but it would be nice to pass this patch through
the eyes of experts of this area.

On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
> flush, which can be expensive on large systems. Currently,
> wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
> have to make the rstat flush atomically. On systems with a lot of
> cpus/cgroups, this can cause us to disable irqs for a long time,
> potentially causing problems.
>
> Move the call to wb_over_bg_thresh() outside the lock section in
> preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic.
> The list_empty(&wb->work_list) should be okay outside the lock section
> of wb->list_lock as it is protected by a separate lock (wb->work_lock),
> and wb_over_bg_thresh() doesn't seem like it is modifying any of the b_*
> lists the wb->list_lock is protecting. Also, the loop seems to be
> already releasing and reacquring the lock, so this refactoring looks
> safe.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  fs/fs-writeback.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 195dc23e0d831..012357bc8daa3 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2021,7 +2021,6 @@ static long wb_writeback(struct bdi_writeback *wb,
>         struct blk_plug plug;
>
>         blk_start_plug(&plug);
> -       spin_lock(&wb->list_lock);
>         for (;;) {
>                 /*
>                  * Stop writeback when nr_pages has been consumed
> @@ -2046,6 +2045,9 @@ static long wb_writeback(struct bdi_writeback *wb,
>                 if (work->for_background && !wb_over_bg_thresh(wb))
>                         break;
>
> +
> +               spin_lock(&wb->list_lock);
> +
>                 /*
>                  * Kupdate and background works are special and we want t=
o
>                  * include all inodes that need writing. Livelock avoidan=
ce is
> @@ -2075,13 +2077,19 @@ static long wb_writeback(struct bdi_writeback *wb=
,
>                  * mean the overall work is done. So we keep looping as l=
ong
>                  * as made some progress on cleaning pages or inodes.
>                  */
> -               if (progress)
> +               if (progress) {
> +                       spin_unlock(&wb->list_lock);
>                         continue;
> +               }
> +
>                 /*
>                  * No more inodes for IO, bail
>                  */
> -               if (list_empty(&wb->b_more_io))
> +               if (list_empty(&wb->b_more_io)) {
> +                       spin_unlock(&wb->list_lock);
>                         break;
> +               }
> +
>                 /*
>                  * Nothing written. Wait for some inode to
>                  * become available for writeback. Otherwise
> @@ -2093,9 +2101,7 @@ static long wb_writeback(struct bdi_writeback *wb,
>                 spin_unlock(&wb->list_lock);
>                 /* This function drops i_lock... */
>                 inode_sleep_on_writeback(inode);
> -               spin_lock(&wb->list_lock);
>         }
> -       spin_unlock(&wb->list_lock);
>         blk_finish_plug(&plug);
>
>         return nr_pages - work->nr_pages;
> --
> 2.40.0.348.gf938b09366-goog
>
