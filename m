Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375396268A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 10:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiKLJmv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 04:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiKLJmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 04:42:40 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6956553;
        Sat, 12 Nov 2022 01:42:24 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id t14so7203652vsr.9;
        Sat, 12 Nov 2022 01:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B1gzX8v9y+2mjgii5279K+WJr8VfcVZnEHBgjqufFMc=;
        b=PGOECwGE2nzbnm5td+DyNfIFTZao/7MFk86HSdYj6Z8ZPQgkVWHng7OJVw1B6myPM0
         vhoKxw8gnZMre/XGp2pOn70RKdfLXGYGCECsfQ49dFDd/mlx3cZe9zVbKy41qCaHzzrk
         Z+BHp0NcoZ1LYqnuOmxYeNmFoJfdhQM0XuSJp+oawSGcM4SUA0GC/kb8BqadOwZToNVr
         XN9rWcx60LHjSz2p9uwWueyrnbjROsBAWn40uXCQi+wktWc+2FJSVSxyd9csVqpAyoZy
         ue2TZdJgoR/mLLxLzb0kuIb0B5HKah594Jccmgr6oJQcWl0CWbulpuDaCs9g8cmBHC7I
         INnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1gzX8v9y+2mjgii5279K+WJr8VfcVZnEHBgjqufFMc=;
        b=3qK075CxuihKXbgDS+Jolei+BadTyY2reFuY/d/fiY2pjyRd2eipwv6FlquK3/ZUGl
         jIKmPefSxVugFNuSquSS3isw7vyWZLGR6Ic8/GsDAv8gQJv9wrpCD/g42boFzbMobdXd
         forLZgK4pTZfDm/mwU5Ge5LJM4HNY3Sav83BDZJmEMgn+bpP6DvtTfw5isHYnK/tl9vG
         d8nxe/4jSVqcAGhbwfeTBgkdNjFWr9jbn0mc6x603nmKBeEJGrH1jL0654eL3XnIl/yA
         TATauxm7CkeAIga/8psKR60a9qaBnl1X9HsJybCO6GMioLAuNyNNWsQNjTHFt1TOV38z
         lFZw==
X-Gm-Message-State: ANoB5pmI7eeqxL0AvT412H2k4hv9Etz+JYsQnPXwvDXIspMzXHhbhMeW
        FU+8K/iL5jRDghzwqc8rhS+5V1OvVSo1+MLGS+o=
X-Google-Smtp-Source: AA0mqf7LkUaNFA748NWf+1ra3/MkaLyo9MAOR3HUZwtqHtnj4EB76XkLvQplbdvTN22PogAQRTfQDsB9msQid4P6b2I=
X-Received: by 2002:a67:f1cb:0:b0:3ad:7661:a081 with SMTP id
 v11-20020a67f1cb000000b003ad7661a081mr2657800vsm.2.1668246143158; Sat, 12 Nov
 2022 01:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221111220614.991928-1-stephen.s.brennan@oracle.com> <20221111220614.991928-6-stephen.s.brennan@oracle.com>
In-Reply-To: <20221111220614.991928-6-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Nov 2022 11:42:11 +0200
Message-ID: <CAOQ4uxiDaP1n+M6vMPP-k8pqotT=h2D_y+o3rAeZmYFP=O3DhQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] fsnotify: require inode lock held during child
 flag update
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

fsnotify_update_flags

On Sat, Nov 12, 2022 at 12:06 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> With the prior changes to fsnotify, it is now possible for
> fsnotify_recalc_mask() to return before all children flags have been
> set. Imagine that two CPUs attempt to add a mark to an inode which would
> require watching the children of that directory:
>
> CPU 1:                                 CPU 2:
>
> fsnotify_recalc_mask() {
>   spin_lock();
>   update_children = ...
>   __fsnotify_recalc_mask();
>   update_children = ...
>   spin_unlock();
>   // update_children is true!
>   fsnotify_conn_set_children_dentry_flags() {
>     // updating flags ...
>     cond_resched();
>
>                                        fsnotify_recalc_mask() {
>                                          spin_lock();
>                                          update_children = ...
>                                          __fsnotify_recalc_mask();
>                                          update_children = ...
>                                          spin_unlock();
>                                          // update_children is false
>                                        }
>                                        // returns to userspace, but
>                                        // not all children are marked
>     // continue updating flags
>    }
> }
>
> To prevent this situation, hold the directory inode lock. This ensures
> that any concurrent update to the mask will block until the update is
> complete, so that we can guarantee that child flags are set prior to
> returning.
>
> Since the directory inode lock is now held during iteration over
> d_subdirs, we are guaranteed that __d_move() cannot remove the dentry we
> hold, so we no longer need check whether we should retry iteration. We
> also are guaranteed that no cursors are moving through the list, since
> simple_readdir() holds the inode read lock. Simplify the iteration by
> removing this logic.
>

I very much prefer to start the series with this patch and avoid
those details altogether.

> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  fs/notify/fsnotify.c | 25 +++++++++----------------
>  fs/notify/mark.c     |  8 ++++++++
>  2 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 0ba61211456c..b5778775b88d 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -102,6 +102,8 @@ void fsnotify_sb_delete(struct super_block *sb)
>   * on a child we run all of our children and set a dentry flag saying that the
>   * parent cares.  Thus when an event happens on a child it can quickly tell
>   * if there is a need to find a parent and send the event to the parent.
> + *
> + * Context: inode locked exclusive
>   */
>  void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
>  {
> @@ -124,22 +126,16 @@ void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
>          * over d_subdirs which will allow us to sleep.
>          */
>         spin_lock(&alias->d_lock);
> -retry:
>         list_for_each_entry(child, &alias->d_subdirs, d_child) {
>                 /*
> -                * We need to hold a reference while we sleep. But we cannot
> -                * sleep holding a reference to a cursor, or we risk skipping
> -                * through the list.
> -                *
> -                * When we wake, dput() could free the dentry, invalidating the
> -                * list pointers.  We can't look at the list pointers until we
> -                * re-lock the parent, and we can't dput() once we have the
> -                * parent locked.  So the solution is to hold onto our reference
> -                * and free it the *next* time we drop alias->d_lock: either at
> -                * the end of the function, or at the time of the next sleep.
> +                * We need to hold a reference while we sleep. When we wake,
> +                * dput() could free the dentry, invalidating the list pointers.
> +                * We can't look at the list pointers until we re-lock the
> +                * parent, and we can't dput() once we have the parent locked.
> +                * So the solution is to hold onto our reference and free it the
> +                * *next* time we drop alias->d_lock: either at the end of the
> +                * function, or at the time of the next sleep.
>                  */
> -               if (child->d_flags & DCACHE_DENTRY_CURSOR)
> -                       continue;
>                 if (need_resched()) {
>                         dget(child);
>                         spin_unlock(&alias->d_lock);
> @@ -147,9 +143,6 @@ void fsnotify_update_children_dentry_flags(struct inode *inode, bool watched)
>                         last_ref = child;
>                         cond_resched();
>                         spin_lock(&alias->d_lock);
> -                       /* Check for races with __d_move() */
> -                       if (child->d_parent != alias)
> -                               goto retry;
>                 }
>
>                 /*
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 6797a2952f87..f39cd88ad778 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -203,10 +203,15 @@ static void fsnotify_conn_set_children_dentry_flags(
>  void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  {
>         bool update_children;
> +       struct inode *inode = NULL;
>
>         if (!conn)
>                 return;
>
> +       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
> +               inode = fsnotify_conn_inode(conn);
> +               inode_lock(inode);
> +       }
>         spin_lock(&conn->lock);
>         update_children = !fsnotify_conn_watches_children(conn);
>         __fsnotify_recalc_mask(conn);
> @@ -219,6 +224,9 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>          */
>         if (update_children)
>                 fsnotify_conn_set_children_dentry_flags(conn);
> +
> +       if (inode)
> +               inode_unlock(inode);
>  }
>

Interesting.

I was imagining inode_lock taken only inside
fsnotify_conn_set_children_dentry_flags()

The reason is that removing the parent watch does not need
to be serialized for lazy clean up to work correctly.

Maybe I am missing something or maybe it is just best practice
to serialize all parent state changes to keep the mental model
of the code simpler and to keep it the same as the existing upstream
mental model.

So I am NOT opposed to serializing fsnotify_recalc_mask()
just wanted to hear opinions.

Thanks,
Amir.
