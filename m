Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6B610D51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 11:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJ1Jcn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiJ1Jca (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:32:30 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320E1C2E98;
        Fri, 28 Oct 2022 02:32:29 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id z186so2184661vkg.6;
        Fri, 28 Oct 2022 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sulxL1P58qxSoZcqS/gQS4urVebZ0pVbfHu9VfgT72g=;
        b=dHGLdqKKKD1/71nEDkoet/hs2T55Sbq7/kl07M5mMvkR55GGCQH/m/1NUWOyKbczv2
         1htfxR9GsY3UUzFi8nq/TTpO1fJJOLPAL1kMIE2Qbh2lWwtkzU9AHx06T22WoftOk5xt
         JaT5kTeOANJm7C3HnLvgp3ZYFe8Wo92SXzPzVWQGsPUmVjSE2vCCg2FNuHk+qITpDPsv
         0C+IBiV2zSX/ZfK960se1uZ5LEBFeCXSqGQtGrYUL0JVsiolab0G0EjcX70cub+qg04E
         jD2qOyEtjRFaq7q2u0BTpYQLiEoLdbAXMIqq1Ov66hZI2+8JZEAc/yidB5Rvlf6ZxPJy
         0KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sulxL1P58qxSoZcqS/gQS4urVebZ0pVbfHu9VfgT72g=;
        b=GlwqmPPI5R14k9Fn8rCGhOuKaCf3AXJKr8M9v8vdkyD3Pqg8hR0jfTDEhUSrqA8RiZ
         GzFMZ5VyO8YH3o53A2QTt8K5P7I5jinWEwj5NPH2nPjGxSl/cP0mkuzxmj8TZwhQYQkG
         feKBJmjTsgyYgU8/JHj2mlvjEDoUGGnbfEMqQW4bC4YUdN1IbWhiWtgiDzLLxu7WP/58
         7ApKQsxhAbk5XUl1fttp0BOXHbOuJXF7MpOwVSA4J4w3h+XRj64bdDMChseTPJpmkhjB
         6P96tJgWxOSEnE+aktS7iW75xR3/9FDN7t3kAK+4da/weTj8ipJ+VG8HiaAb2SyHOllg
         VnMg==
X-Gm-Message-State: ACrzQf2m0OZegwSZeCptjy50nsXVA0G6IkfGzeHoN6HoM11AEgBa+WPp
        87qZBluQB9F/q2Y4UoGc07nSHAgIz2TYstp7pQ4=
X-Google-Smtp-Source: AMsMyM4foX79ncH7xMmHslGm3BoTecafFHA2IR9M7rnK1C6rioHfMZXld4Uf4vXKsmEe0/fffFaI2raxasWIu7p5iPE=
X-Received: by 2002:a1f:da86:0:b0:3b7:6af6:1e24 with SMTP id
 r128-20020a1fda86000000b003b76af61e24mr12061323vkg.25.1666949548109; Fri, 28
 Oct 2022 02:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com> <20221028001016.332663-4-stephen.s.brennan@oracle.com>
In-Reply-To: <20221028001016.332663-4-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 28 Oct 2022 12:32:16 +0300
Message-ID: <CAOQ4uxh8c2vbv50p8+rNnoV0H=L=+XRGuFP1dmGrrCrt6EjFYQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] fsnotify: allow sleepable child flag update
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 28, 2022 at 3:10 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> With very large d_subdirs lists, iteration can take a long time. Since
> iteration needs to hold parent->d_lock, this can trigger soft lockups.
> It would be best to make this iteration sleepable. Since we have the
> inode locked exclusive, we can drop the parent->d_lock and sleep,
> holding a reference to a child dentry, and continue iteration once we
> wake.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

some comment nits and one fortify suggestion

> Notes:
>     v3:
>     - removed if statements around dput()
>     v2:
>     - added a check for child->d_parent != alias and retry logic
>
>  fs/notify/fsnotify.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index ccb8a3a6c522..34e5d18235a7 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -102,10 +102,12 @@ void fsnotify_sb_delete(struct super_block *sb)
>   * on a child we run all of our children and set a dentry flag saying that the
>   * parent cares.  Thus when an event happens on a child it can quickly tell
>   * if there is a need to find a parent and send the event to the parent.
> + *
> + * Context: inode locked exclusive
>   */
>  static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
>  {
> -       struct dentry *alias, *child;
> +       struct dentry *child, *alias, *last_ref = NULL;
>         int watched;
>
>         if (!S_ISDIR(inode->i_mode))
> @@ -120,12 +122,37 @@ static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
>         alias = d_find_any_alias(inode);
>
>         /*
> -        * run all of the children of the original inode and fix their
> -        * d_flags to indicate parental interest (their parent is the
> -        * original inode)
> +        * These lists can get very long, so we may need to sleep during
> +        * iteration. Normally this would be impossible without a cursor,
> +        * but since we have the inode locked exclusive, we're guaranteed
> +        * that the directory won't be modified, so whichever dentry we
> +        * pick to sleep on won't get moved. So, start a manual iteration
> +        * over d_subdirs which will allow us to sleep.
>          */
>         spin_lock(&alias->d_lock);
> +retry:
>         list_for_each_entry(child, &alias->d_subdirs, d_child) {
> +               if (need_resched()) {
> +                       /*
> +                        * We need to hold a reference while we sleep. But when
> +                        * we wake, dput() could free the dentry, invalidating
> +                        * the list pointers. We can't look at the list pointers
> +                        * until we re-lock the parent, and we can't dput() once
> +                        * we have the parent locked. So the solution is to hold
> +                        * onto our reference and free it the *next* time we drop
> +                        * alias->d_lock: either at the end of the function, or
> +                        * at the time of the next sleep.
> +                        */

My personal preference would be to move this above if (needed_reschd())
it is not any less clear when this comment is above the condition
and less indented will read nicer.

> +                       dget(child);
> +                       spin_unlock(&alias->d_lock);
> +                       dput(last_ref);
> +                       last_ref = child;
> +                       cond_resched();
> +                       spin_lock(&alias->d_lock);
> +                       if (child->d_parent != alias)
> +                               goto retry;

Is this expected? If not, then we need a WARN_ON_ONCE().
Also, I wonder if it would be better to break out and leave
dentry flags as they are instead of risking some endless
or very long retry loop?

And how about asserting on unexpected !list_empty(&child->d_child)
to avoid an endless loop in list_for_each_entry()?

Thanks,
Amir.
