Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80E26025F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 09:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiJRHj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 03:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiJRHjy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:39:54 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD7E24093;
        Tue, 18 Oct 2022 00:39:53 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id h29so13843873vsq.9;
        Tue, 18 Oct 2022 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iqJ/wj3m69IfQ9f+xwOuQEvHL1Q8qDvcFRpi6jPb7d0=;
        b=QYDAloLsLLoP7VFP4aJBmTUwF3kSQW/Tq9CCSTOx8qMWw4P/cvp9qbZRu3GmkCrR+t
         0BeyuuhUtDjjoRr0B+L7O00bO2Vb+EISGZtPMmtqlCHGb2/X1JYLYd3/z792CC2lS92/
         XtLpNKoLA1oruy8n6ZQi9fQRlyY6RtoBEJvsuoovuR6Coiib8S9yHNHb69WnKFGOrZhX
         0iSFbGJrHWoSBCuhc5ijqPEwOrdy+/Iik1rXUpedkF1wO7vkkkddkcBrTcPH7G6NTeCB
         dp7HYbHH9Wztw0n1I06VnF3FO1I9tF1FGueqblE2+THuesxwtNi5hjAvy2/VTh+imAPK
         w/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqJ/wj3m69IfQ9f+xwOuQEvHL1Q8qDvcFRpi6jPb7d0=;
        b=2aIS93KNGfax5aXpRyWbYCI30y7DfFB+PSzYvEMI5fk0YezqEWfGPOwS8HZz71UbvN
         fM00WS+qy0RV5tYYnfqx3kRiWiUnMB5lgPWQknz4dKPqhJs0cxj/TYxYsgrZMz7NnN1L
         qNyu79u5YyaTqJLKKmJvMFQeOk66vb+Evt30sb9veGGPC3WS5eMwl4oN5xhpn5Ggs8kG
         auWqOEFWBTJMHJbv/31/X9sLjU4nH2L9TXAvrYPv7BBBNS9IqVW7y2iGUhnV7c5LrI44
         indRtF+kVJHce+iOoNw3M9ydvP3BacWRigQtAfF2VBbNHAtdtyrgWPwRccQFt6NU10QS
         Y4TQ==
X-Gm-Message-State: ACrzQf2GLk4wDpJSVCg+lK/NecJXgLT9kTE3Cda6qkNz1v3SEayPL0PL
        OprzEf2n6YAwREC+YSKyFCjkNU518as5hMcQ234=
X-Google-Smtp-Source: AMsMyM6uuZ8/77Jsf6Vn6QGw9kUdJLzfKUURFS51Aqy76kXJ5ID4E1xxiZNRzMbkY+ZKnuXg2NgEb+YhZzxEbTe3Pmg=
X-Received: by 2002:a67:a24e:0:b0:3a5:38a0:b610 with SMTP id
 t14-20020a67a24e000000b003a538a0b610mr802527vsh.2.1666078792492; Tue, 18 Oct
 2022 00:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com> <20221018041233.376977-2-stephen.s.brennan@oracle.com>
In-Reply-To: <20221018041233.376977-2-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Oct 2022 10:39:40 +0300
Message-ID: <CAOQ4uxhi27ZZmXMV1JTR1+3-1MVMY3W_R=+7LbOHWXbKOk4hjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
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
> When an inode is interested in events on its children, it must set
> DCACHE_FSNOTIFY_PARENT_WATCHED flag on all its children. Currently, when
> the fsnotify connector is removed and i_fsnotify_mask becomes zero, we
> lazily allow __fsnotify_parent() to do this the next time we see an
> event on a child.
>
> However, if the list of children is very long (e.g., in the millions),
> and lots of activity is occurring on the directory, then it's possible
> for many CPUs to end up blocked on the inode spinlock in
> __fsnotify_update_child_flags(). Each CPU will then redundantly iterate
> over the very long list of children. This situation can cause soft
> lockups.
>
> To avoid this, stop lazily updating child flags in __fsnotify_parent().
> Protect the child flag update with i_rwsem held exclusive, to ensure
> that we only iterate over the child list when it's absolutely necessary,
> and even then, only once.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>
> Notes:
>
> It seems that there are two implementation options for this, regarding
> what i_rwsem protects:
>
> 1. Both updates to i_fsnotify_mask, and the child dentry flags, or
> 2. Only updates to the child dentry flags
>
> I wanted to do #1, but it got really tricky with fsnotify_put_mark(). We
> don't want to hold the inode lock whenever we decrement the refcount,
> but if we don't, then we're stuck holding a spinlock when the refcount
> goes to zero, and we need to grab the inode rwsem to synchronize the
> update to the child flags. I'm sure there's a way around this, but I
> didn't keep going with it.
>
> With #1, as currently implemented, we have the unfortunate effect of
> that a mark can be added, can see that no update is required, and
> return, despite the fact that the flag update is still in progress on a
> different CPU/thread. From our discussion, that seems to be the current
> status quo, but I wanted to explicitly point that out. If we want to
> move to #1, it should be possible with some work.

I think the solution may be to store the state of children in conn
like you suggested.

See fsnotify_update_iref() and conn flag
FSNOTIFY_CONN_FLAG_HAS_IREF.

You can add a conn flag
FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN
that caches the result of the last invocation of update children flags.

For example, fsnotify_update_iref() becomes
fsnotify_update_inode_conn_flags() and
returns inode if either inode ref should be dropped
or if children flags need to be updated (or both)
maybe use some out argument to differentiate the cases.
Same for fsnotify_detach_connector_from_object().

Then, where fsnotify_drop_object() is called, for the
case that inode children need to be updated,
take inode_lock(), take connector spin lock
to check if another thread has already done the update
if not release spin lock, perform the update under inode lock
and at the end, take spin lock again and set the
FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN
connector flag.

Not sure if it all works out... maybe

>
>  fs/notify/fsnotify.c | 12 ++++++++--
>  fs/notify/mark.c     | 55 ++++++++++++++++++++++++++++++++++----------
>  2 files changed, 53 insertions(+), 14 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 7974e91ffe13..e887a195983b 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -207,8 +207,16 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>         parent = dget_parent(dentry);
>         p_inode = parent->d_inode;
>         p_mask = fsnotify_inode_watches_children(p_inode);
> -       if (unlikely(parent_watched && !p_mask))
> -               __fsnotify_update_child_dentry_flags(p_inode);
> +       if (unlikely(parent_watched && !p_mask)) {
> +               /*
> +                * Flag would be cleared soon by
> +                * __fsnotify_update_child_dentry_flags(), but as an
> +                * optimization, clear it now.
> +                */

I think that we need to also take p_inode spin_lock here and
check  fsnotify_inode_watches_children() under lock
otherwise, we could be clearing the WATCHED flag
*after* __fsnotify_update_child_dentry_flags() had
already set it, because you we not observe the change to
p_inode mask.

I would consider renaming __fsnotify_update_child_dentry_flags()
to __fsnotify_update_children_dentry_flags(struct inode *dir)

and creating another inline helper for this call site called:
fsnotify_update_child_dentry_flags(struct inode *dir, struct dentry *child)


> +               spin_lock(&dentry->d_lock);
> +               dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> +               spin_unlock(&dentry->d_lock);
> +       }
>
>         /*
>          * Include parent/name in notification either if some notification
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c74ef947447d..da9f944fcbbb 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -184,15 +184,36 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>   */
>  void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  {
> +       struct inode *inode = NULL;
> +       int watched_before, watched_after;
> +
>         if (!conn)
>                 return;
>
> -       spin_lock(&conn->lock);
> -       __fsnotify_recalc_mask(conn);
> -       spin_unlock(&conn->lock);
> -       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> -               __fsnotify_update_child_dentry_flags(
> -                                       fsnotify_conn_inode(conn));
> +       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
> +               /*
> +                * For inodes, we may need to update flags on the child
> +                * dentries. To ensure these updates occur exactly once,
> +                * synchronize the recalculation with the inode mutex.
> +                */
> +               inode = fsnotify_conn_inode(conn);
> +               spin_lock(&conn->lock);
> +               watched_before = fsnotify_inode_watches_children(inode);
> +               __fsnotify_recalc_mask(conn);
> +               watched_after = fsnotify_inode_watches_children(inode);
> +               spin_unlock(&conn->lock);
> +
> +               inode_lock(inode);

With the pattern that I suggested above, this if / else would
be unified to code that looks something like this:

spin_lock(&conn->lock);
inode =  __fsnotify_recalc_mask(conn);
spin_unlock(&conn->lock);

if (inode)
    fsnotify_update_children_dentry_flags(conn, inode);

Where fsnotify_update_children_dentry_flags()
takes inode lock around entire update and conn spin lock
only around check and update of conn flags.

FYI, at this time in the code, adding  a mark or updating
existing mark mask cannot result in the need to drop iref.
That is the reason that return value of __fsnotify_recalc_mask()
is not checked here.

> +               if ((watched_before && !watched_after) ||
> +                   (!watched_before && watched_after)) {
> +                       __fsnotify_update_child_dentry_flags(inode);
> +               }
> +               inode_unlock(inode);
> +       } else {
> +               spin_lock(&conn->lock);
> +               __fsnotify_recalc_mask(conn);
> +               spin_unlock(&conn->lock);
> +       }
>  }
>
>  /* Free all connectors queued for freeing once SRCU period ends */
> @@ -295,6 +316,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>         struct fsnotify_mark_connector *conn = READ_ONCE(mark->connector);
>         void *objp = NULL;
>         unsigned int type = FSNOTIFY_OBJ_TYPE_DETACHED;
> +       struct inode *inode = NULL;
> +       int watched_before, watched_after;
>         bool free_conn = false;
>
>         /* Catch marks that were actually never attached to object */
> @@ -311,17 +334,31 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>         if (!refcount_dec_and_lock(&mark->refcnt, &conn->lock))
>                 return;
>
> +       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
> +               inode = fsnotify_conn_inode(conn);
> +               watched_before = fsnotify_inode_watches_children(inode);
> +       }
> +
>         hlist_del_init_rcu(&mark->obj_list);
>         if (hlist_empty(&conn->list)) {
>                 objp = fsnotify_detach_connector_from_object(conn, &type);
>                 free_conn = true;
> +               watched_after = 0;
>         } else {
>                 objp = __fsnotify_recalc_mask(conn);
>                 type = conn->type;
> +               watched_after = fsnotify_inode_watches_children(inode);
>         }
>         WRITE_ONCE(mark->connector, NULL);
>         spin_unlock(&conn->lock);
>
> +       if (inode) {
> +               inode_lock(inode);
> +               if (watched_before && !watched_after)
> +                       __fsnotify_update_child_dentry_flags(inode);
> +               inode_unlock(inode);
> +       }
> +
>         fsnotify_drop_object(type, objp);
>

Here as well something like:
if (objp)
    fsnotify_update_children_dentry_flags(conn, obj);

But need to distinguish when inode ref needs to be dropped
children flags updates or both.

Hope that this suggestion direction turns out to be useful and not
a complete waste of time...

Thanks,
Amir.
