Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE5F6023D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 07:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJRFg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 01:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiJRFg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:36:57 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E719DFB6;
        Mon, 17 Oct 2022 22:36:56 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id d187so13653397vsd.6;
        Mon, 17 Oct 2022 22:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GRO29qOkdnOa9C7o61HNBtwsA+7dwhlTyOkHKXO3eHc=;
        b=a1G8HT/htXindqFfzLGz5h1TpezRmwlJpV0X38v4UqhlgnllfrHnUhY1bHGvCnKfcS
         J+JV4oXvaAW7I85yZjLyy+ub34x6T16TibVWPYE+/bKPNfsOA68a5+jbeKEpY9xKUwBw
         w6sPdVQxjWITpOyOufIYNfxjYY7pW9Vwsm/CE4aOZ6+x6q1SUztlTZ3z8ps57+OHao3h
         8IeikZfeHATQitr7vyXUUI2sQqgIFHs0NyrpmgyndsBcQ2DcbrXaF/5OG06vwPeE+RLP
         k1Is3/IpeZsIeN2T2vSaev1w7VE1kIJn1tnXYiV3ZXcW8GwDvLegsOm7TYXPkffIoDee
         4GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRO29qOkdnOa9C7o61HNBtwsA+7dwhlTyOkHKXO3eHc=;
        b=D6BP5qCvYDE8CSpuFP6MKedP+t/vA+e+tXEhxbXyT3yAtssX2GkOZ0O7CPlkosolFs
         +5rzE6xmswBPUt2lAlITF6Y5hGvh4cyuuIdVXhaXTYm6Ab5fPtIvib5dTbJ6HYbuBuWv
         1yPHjKI9yvM2RX3/VtawKH1KLHSpoi6n0FYGzXr6j7Dm00qzVDOUmSW4I47wiUjWHOUU
         GVx5J5L/USPiODAwmdzg27uOvv0oeUudqXNr8+Xmu45/zmWER9KiM39QCat8RBea+U3r
         +cYs+egqQZg8ipEjCrlpzc7xQStCu9bY/2pw6cFu5la0g+PO/lDC186YXh3hfpCcZksa
         uA2Q==
X-Gm-Message-State: ACrzQf3eIYFrrXb8EswqzDuXMcE3KZdOOIgRGM5R3Y1B239eCNkvjctQ
        TORMTbyvg+vanwg7O6wCxoisdTW3jryrHwcsto0=
X-Google-Smtp-Source: AMsMyM5pmhYvfn/YJncmzMuLVuA7hklYzWwHgwpX/cM/iPGZenUy+jNiHTitXIHs0dyiSlIHM2RGm2n5DOwIzSgKGYA=
X-Received: by 2002:a67:df08:0:b0:3a6:cb22:8fe7 with SMTP id
 s8-20020a67df08000000b003a6cb228fe7mr478677vsk.71.1666071415094; Mon, 17 Oct
 2022 22:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com> <20221018041233.376977-3-stephen.s.brennan@oracle.com>
In-Reply-To: <20221018041233.376977-3-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Oct 2022 08:36:43 +0300
Message-ID: <CAOQ4uxjkPg=RmQzgtP=_qdBWNDhCg5=7TtZd6VjPtCFAjE6Fng@mail.gmail.com>
Subject: Re: [PATCH 2/2] fsnotify: allow sleepable child flag update
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, Oct 18, 2022 at 7:12 AM Stephen Brennan
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
>  fs/notify/fsnotify.c | 72 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 22 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index e887a195983b..499b19272b32 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -102,10 +102,13 @@ void fsnotify_sb_delete(struct super_block *sb)
>   * on a child we run all of our children and set a dentry flag saying that the
>   * parent cares.  Thus when an event happens on a child it can quickly tell
>   * if there is a need to find a parent and send the event to the parent.
> + *
> + * Context: inode locked exclusive

Please add code assertion

        WARN_ON_ONCE(!inode_is_locked(inode));

and it probably wouldn't hurt to add an inline wrapper
fsnotify_update_child_dentry_flags()
that locks the inode and calls this helper.

>   */
>  void __fsnotify_update_child_dentry_flags(struct inode *inode)
>  {
> -       struct dentry *alias;
> +       struct dentry *child, *alias, *last_ref = NULL;
> +       struct list_head *p;
>         int watched;
>
>         if (!S_ISDIR(inode->i_mode))
> @@ -114,30 +117,55 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>         /* determine if the children should tell inode about their events */
>         watched = fsnotify_inode_watches_children(inode);
>
> -       spin_lock(&inode->i_lock);
> -       /* run all of the dentries associated with this inode.  Since this is a
> -        * directory, there damn well better only be one item on this list */
> -       hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
> -               struct dentry *child;
> -
> -               /* run all of the children of the original inode and fix their
> -                * d_flags to indicate parental interest (their parent is the
> -                * original inode) */
> -               spin_lock(&alias->d_lock);
> -               list_for_each_entry(child, &alias->d_subdirs, d_child) {
> -                       if (!child->d_inode)
> -                               continue;
> +       alias = d_find_any_alias(inode);

Please make the alias change in a separate patch.
It is not explained in commit message and it clutters
the diff which makes reviewing the actual logic changes
harder.

> +
> +       /*
> +        * These lists can get very long, so we may need to sleep during
> +        * iteration. Normally this would be impossible without a cursor,
> +        * but since we have the inode locked exclusive, we're guaranteed
> +        * that the directory won't be modified, so whichever dentry we
> +        * pick to sleep on won't get moved. So, start a manual iteration
> +        * over d_subdirs which will allow us to sleep.
> +        */
> +       spin_lock(&alias->d_lock);
> +       p = alias->d_subdirs.next;
>
> -                       spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> -                       if (watched)
> -                               child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
> -                       else
> -                               child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> -                       spin_unlock(&child->d_lock);
> +       while (p != &alias->d_subdirs) {
> +               child = list_entry(p, struct dentry, d_child);

IMO it would be better to use list iterator helpers.
What was wrong with list_for_each_entry()?
Why did you feel that you need to open code it?

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
> +                       dget(child);
> +                       spin_unlock(&alias->d_lock);
> +                       if (last_ref)
> +                               dput(last_ref);
> +                       last_ref = child;
> +                       cond_resched();
> +                       spin_lock(&alias->d_lock);
>                 }
> -               spin_unlock(&alias->d_lock);
> +               p = p->next;
> +
> +               if (!child->d_inode)
> +                       continue;
> +
> +               spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
> +               if (watched)
> +                       child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
> +               else
> +                       child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> +               spin_unlock(&child->d_lock);
>         }
> -       spin_unlock(&inode->i_lock);
> +       spin_unlock(&alias->d_lock);
> +       if (last_ref)
> +               dput(last_ref);

Nit: if not needed. dput(NULL) works just fine.

Thanks,
Amir.
