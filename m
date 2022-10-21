Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5C607211
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 10:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJUIXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJUIW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:22:59 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E470A18E294;
        Fri, 21 Oct 2022 01:22:55 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id s185so1108701vkb.0;
        Fri, 21 Oct 2022 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aYPdV2QCO5zoMvEMj5OjU7h66tXfI7vgZk7sSlFUVJw=;
        b=pei+cELxm/VzqgUkjL4ROOxCA9HchRMJn/mBJZneSMe3YrOWxoUUSuadbrE0xo71bE
         lABVTprna8CSeKMNHENO3DyX5G72trziipXSABqxMrdVMhewMK5Tq5rfdFH10KFtMwqj
         aJRCC6LmrkCp0ap+BShakSec6crPPaOBOdgE0+huwzIiejfohCOTjNgL5R/QkTQa1Rxk
         8goAF6jeouO2/cpi/Zy9bqR0oEaYxUix+Nbiii3aqABoqo/0EHo8J2DDDUvEZv9mDrus
         KtstL1f5XGA+ffseqpoF+h8vTR39hzzD6Cz9MhmLhEVQ1vWPBY1jyWPi1iB1wjgXN4/g
         y6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYPdV2QCO5zoMvEMj5OjU7h66tXfI7vgZk7sSlFUVJw=;
        b=efrWMKdglGVopS2GBDVW8JcQ8D8pA5/qUL8ir8NzgK8CAqYDTDK/EuRasQBmdEA3QW
         gl4Jb5daowwgltcrpvxP8RUo+YHIjYvU6+rmkefXeYloEj4jjbJSy6HFwJGqg82I+jFL
         d15bhaf5qHdkFBf9ooacJaLudWgOf0NRqOTrUO4Ks3wkD7vMRIsbfgJyKvyvsFd011yh
         H9RiQjOgCCxlMcmnpPLqrOC6UT+acyzxHVmT0CQzndHm1SghRMf4bT7fi9Yl0B4l1JyU
         MpjehdyNQowvkAoen7QM9nRQGfkr5JlqLudRjeMss0xlqFC834jWTmBTCPIhKmPAlixZ
         BkKA==
X-Gm-Message-State: ACrzQf3iQZON7Hn2DYXgYl7QmNBXvMmuJfZ5yruDtXMZJqaG5tK/XC6m
        A4UI2gelzTg6XD/8NpjAZTAW2dkCiCrv0NkGeoEtXyzMA+U=
X-Google-Smtp-Source: AMsMyM7wOYouK7wSZPXh1uhDXeTnp6HOmAOiz7xfRm0CDvXSePKwqNCbDuvZfMX2tnH6PfDJM6/frO1VStzwxeQfMng=
X-Received: by 2002:a1f:a004:0:b0:398:3e25:d2a7 with SMTP id
 j4-20020a1fa004000000b003983e25d2a7mr11269810vke.36.1666340574143; Fri, 21
 Oct 2022 01:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com> <20221021010310.29521-3-stephen.s.brennan@oracle.com>
In-Reply-To: <20221021010310.29521-3-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 Oct 2022 11:22:42 +0300
Message-ID: <CAOQ4uxj+ctptwuJ__gn=2URvzkXUc2NZkJaY=woGFEQQZdZn9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 21, 2022 at 4:03 AM Stephen Brennan
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
> Instead, update flags when we disconnect a mark connector. Remember the
> state of the children flags in the fsnotify_mark_connector flags.
> Provide mutual exclusion by holding i_rwsem exclusive while we update
> children, and use the cached state to avoid updating flags
> unnecessarily.
>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---

Looks pretty good overall.

A nit for review.
It is convenient for reviewers to have a "Changes since v1"
change log either in cover letter and/or in individual patches
even a change log that says "no changes since v1"

>
>  fs/notify/fsnotify.c             |  22 ++++++-
>  fs/notify/fsnotify.h             |  31 ++++++++-
>  fs/notify/mark.c                 | 106 ++++++++++++++++++++-----------
>  include/linux/fsnotify_backend.h |   8 +++
>  4 files changed, 127 insertions(+), 40 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 6c338322f0c3..f83eca4fb841 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -103,13 +103,15 @@ void fsnotify_sb_delete(struct super_block *sb)
>   * parent cares.  Thus when an event happens on a child it can quickly tell
>   * if there is a need to find a parent and send the event to the parent.
>   */
> -void __fsnotify_update_child_dentry_flags(struct inode *inode)
> +bool __fsnotify_update_children_dentry_flags(struct inode *inode)
>  {
>         struct dentry *alias, *child;
>         int watched;
>
>         if (!S_ISDIR(inode->i_mode))
> -               return;
> +               return false;
> +
> +       lockdep_assert_held_write(&inode->i_rwsem);
>
>         /* determine if the children should tell inode about their events */
>         watched = fsnotify_inode_watches_children(inode);
> @@ -133,6 +135,20 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>                 spin_unlock(&child->d_lock);
>         }
>         spin_unlock(&alias->d_lock);
> +       return watched;
> +}
> +
> +void __fsnotify_update_child_dentry_flags(struct inode *inode, struct dentry *dentry)

nit: no need for __

> +{
> +       /*
> +        * Flag would be cleared soon by
> +        * __fsnotify_update_child_dentry_flags(), but as an
> +        * optimization, clear it now.
> +        */
> +       spin_lock(&dentry->d_lock);
> +       if (!fsnotify_inode_watches_children(inode))
> +               dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> +       spin_unlock(&dentry->d_lock);
>  }
>
>  /* Are inode/sb/mount interested in parent and name info with this event? */
> @@ -203,7 +219,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>         p_inode = parent->d_inode;
>         p_mask = fsnotify_inode_watches_children(p_inode);
>         if (unlikely(parent_watched && !p_mask))
> -               __fsnotify_update_child_dentry_flags(p_inode);
> +               __fsnotify_update_child_dentry_flags(p_inode, dentry);
>
>         /*
>          * Include parent/name in notification either if some notification
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index fde74eb333cc..182d93014c6b 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -70,11 +70,40 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>         fsnotify_destroy_marks(&sb->s_fsnotify_marks);
>  }
>
> +static inline bool fsnotify_children_need_update(struct fsnotify_mark_connector *conn,
> +                                                 struct inode *inode)
> +{
> +       bool watched, flags_set;
> +       watched = fsnotify_inode_watches_children(inode);
> +       flags_set = conn->flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
> +       return (watched && !flags_set) || (!watched && flags_set);

cleaner:
return watched ^ flags_set;

> +}
> +
>  /*
>   * update the dentry->d_flags of all of inode's children to indicate if inode cares
>   * about events that happen to its children.
>   */
> -extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
> +extern bool __fsnotify_update_children_dentry_flags(struct inode *inode);
> +
> +static inline void fsnotify_update_children_dentry_flags(struct fsnotify_mark_connector *conn,
> +                                                         struct inode *inode)
> +{
> +       bool need_update;
> +       inode_lock(inode);
> +       spin_lock(&conn->lock);
> +       need_update = fsnotify_children_need_update(conn, inode);
> +       spin_unlock(&conn->lock);
> +       if (need_update) {
> +               bool watched = __fsnotify_update_children_dentry_flags(inode);
> +               spin_lock(&conn->lock);
> +               if (watched)
> +                       conn->flags |= FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
> +               else
> +                       conn->flags &= ~FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
> +               spin_unlock(&conn->lock);
> +       }
> +       inode_unlock(inode);
> +}
>
>  extern struct kmem_cache *fsnotify_mark_connector_cachep;
>
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c74ef947447d..ecfd355a93f2 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -130,30 +130,39 @@ static void fsnotify_get_inode_ref(struct inode *inode)
>   * iput() outside of spinlocks. This happens when last mark that wanted iref is
>   * detached.
>   */
> -static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
> -                                         bool want_iref)
> +static struct inode *fsnotify_update_inode_conn_flags(struct fsnotify_mark_connector *conn,
> +                                                     bool want_iref, int *flags)

Please update comment above to reflect the code.

suggest to return int* changed_flags
oldlfags = conn->flags;
...
*changed_flags = oldflags ^ conn->flags;
return ret;

>  {
>         bool has_iref = conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF;
> -       struct inode *inode = NULL;
> +       struct inode *inode = NULL, *ret = NULL;
>
> -       if (conn->type != FSNOTIFY_OBJ_TYPE_INODE ||
> -           want_iref == has_iref)
> +       if (conn->type != FSNOTIFY_OBJ_TYPE_INODE)
>                 return NULL;
>
> -       if (want_iref) {
> -               /* Pin inode if any mark wants inode refcount held */
> -               fsnotify_get_inode_ref(fsnotify_conn_inode(conn));
> -               conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
> -       } else {
> -               /* Unpin inode after detach of last mark that wanted iref */
> -               inode = fsnotify_conn_inode(conn);
> -               conn->flags &= ~FSNOTIFY_CONN_FLAG_HAS_IREF;
> +       inode = fsnotify_conn_inode(conn);
> +
> +       if (want_iref != has_iref) {
> +               if (want_iref) {
> +                       /* Pin inode if any mark wants inode refcount held */
> +                       fsnotify_get_inode_ref(inode);
> +                       conn->flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
> +               } else {
> +                       /* Unpin inode after detach of last mark that wanted iref */
> +                       conn->flags &= ~FSNOTIFY_CONN_FLAG_HAS_IREF;
> +                       ret = inode;
> +                       *flags |= FSNOTIFY_OBJ_FLAG_NEED_IPUT;
> +               }
> +       }
> +       if (fsnotify_children_need_update(conn, inode)) {
> +               ret = inode;
> +               *flags |= FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN;
>         }

I would move this above iref checks,
then if (want_iref == has_iref) { return ret }
to avoid the extra nesting level.

>
> -       return inode;
> +       return ret;
>  }
>
> -static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> +static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn,
> +                                    int *flags)
>  {
>         u32 new_mask = 0;
>         bool want_iref = false;
> @@ -173,7 +182,7 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>         }
>         *fsnotify_conn_mask_p(conn) = new_mask;
>
> -       return fsnotify_update_iref(conn, want_iref);
> +       return fsnotify_update_inode_conn_flags(conn, want_iref, flags);
>  }
>
>  /*
> @@ -184,15 +193,19 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>   */
>  void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  {
> +       struct inode *inode = NULL;
> +       int flags = 0;
> +
>         if (!conn)
>                 return;
>
>         spin_lock(&conn->lock);
> -       __fsnotify_recalc_mask(conn);
> +       inode = __fsnotify_recalc_mask(conn, &flags);
>         spin_unlock(&conn->lock);
> -       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> -               __fsnotify_update_child_dentry_flags(
> -                                       fsnotify_conn_inode(conn));
> +
> +       if (flags & FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN)
> +               fsnotify_update_children_dentry_flags(conn, inode);
> +       WARN_ON_ONCE(flags & FSNOTIFY_OBJ_FLAG_NEED_IPUT);

With changed_flags that WARN_ON would need to check
(inode && changed_flags & HAS_IREF)

>  }
>
>  /* Free all connectors queued for freeing once SRCU period ends */
> @@ -240,7 +253,8 @@ static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
>
>  static void *fsnotify_detach_connector_from_object(
>                                         struct fsnotify_mark_connector *conn,
> -                                       unsigned int *type)
> +                                       unsigned int *type,
> +                                       unsigned int *flags)
>  {
>         struct inode *inode = NULL;
>
> @@ -252,8 +266,11 @@ static void *fsnotify_detach_connector_from_object(
>                 inode = fsnotify_conn_inode(conn);
>                 inode->i_fsnotify_mask = 0;
>
> -               /* Unpin inode when detaching from connector */
> -               if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
> +               if (conn->flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN)
> +                       *flags |= FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN;
> +               if (conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF)
> +                       *flags |= ~FSNOTIFY_OBJ_FLAG_NEED_IPUT;

stray ~

this would be simpler with changed_flags:
*changed_flags = conn->flags &
        (FSNOTIFY_CONN_FLAG_HAS_IREF|
         FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN);
if (!*changed_flags)

> +               if (!*flags)
>                         inode = NULL;
>         } else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
>                 fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
> @@ -280,14 +297,35 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
>  }
>
>  /* Drop object reference originally held by a connector */
> -static void fsnotify_drop_object(unsigned int type, void *objp)
> +static void fsnotify_drop_object(struct fsnotify_mark_connector *conn,
> +                                 unsigned int type, void *objp, int flags)

rename to fsnotify_update_object() ?

>  {
>         if (!objp)
>                 return;
>         /* Currently only inode references are passed to be dropped */
>         if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
>                 return;
> -       fsnotify_put_inode_ref(objp);
> +
> +       if (flags & FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN)
> +               /*
> +                * At this point, we've already detached the connector from the
> +                * inode. It's entirely possible that another connector has been
> +                * attached, and that connector would assume that the children's
> +                * flags are all clear. There are two possibilities:
> +                * (a) The connector has not yet attached a mark that watches its
> +                * children. In this case, we will properly clear out the flags,
> +                * and the connector's flags will be consistent with the
> +                * children.
> +                * (b) The connector attaches a mark that watches its children.
> +                * It may have even already altered i_fsnotify_mask and/or
> +                * altered the child dentry flags. In this case, our call here
> +                * will read the correct value of i_fsnotify_mask and apply it
> +                * to the children, which duplicates some work, but isn't
> +                * harmful.
> +                */

This sounds ok.
For the record, I have patches to keep the connector attached to the
inode until inode eviction.
https://github.com/amir73il/linux/commit/232ad40945b142559e8d85b598b641c956cc73de

There may not be any win in releasing connector on last mark detach.
its memory footprint is negligible compared to that of the inode.

Jan introduced the connector in order to let it live past the lifetime of
the inode, but I do not think that there is anything preventing us from
keeping it around longer and thus making the code simpler.

> +               fsnotify_update_children_dentry_flags(conn, objp);
> +       if (flags & FSNOTIFY_OBJ_FLAG_NEED_IPUT)
> +               fsnotify_put_inode_ref(objp);
>  }
>
>  void fsnotify_put_mark(struct fsnotify_mark *mark)
> @@ -296,6 +334,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>         void *objp = NULL;
>         unsigned int type = FSNOTIFY_OBJ_TYPE_DETACHED;
>         bool free_conn = false;
> +       int flags = 0;
>
>         /* Catch marks that were actually never attached to object */
>         if (!conn) {
> @@ -313,16 +352,16 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>
>         hlist_del_init_rcu(&mark->obj_list);
>         if (hlist_empty(&conn->list)) {
> -               objp = fsnotify_detach_connector_from_object(conn, &type);
> +               objp = fsnotify_detach_connector_from_object(conn, &type, &flags);
>                 free_conn = true;
>         } else {
> -               objp = __fsnotify_recalc_mask(conn);
> +               objp = __fsnotify_recalc_mask(conn, &flags);
>                 type = conn->type;
>         }
>         WRITE_ONCE(mark->connector, NULL);
>         spin_unlock(&conn->lock);
>
> -       fsnotify_drop_object(type, objp);
> +       fsnotify_drop_object(conn, type, objp, flags);
>
>         if (free_conn) {
>                 spin_lock(&destroy_lock);
> @@ -331,12 +370,6 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>                 spin_unlock(&destroy_lock);
>                 queue_work(system_unbound_wq, &connector_reaper_work);
>         }
> -       /*
> -        * Note that we didn't update flags telling whether inode cares about
> -        * what's happening with children. We update these flags from
> -        * __fsnotify_parent() lazily when next event happens on one of our
> -        * children.
> -        */
>         spin_lock(&destroy_lock);
>         list_add(&mark->g_list, &destroy_list);
>         spin_unlock(&destroy_lock);
> @@ -834,6 +867,7 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
>         struct fsnotify_mark *mark, *old_mark = NULL;
>         void *objp;
>         unsigned int type;
> +       int flags = 0;
>
>         conn = fsnotify_grab_connector(connp);
>         if (!conn)
> @@ -859,11 +893,11 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
>          * mark references get dropped. It would lead to strange results such
>          * as delaying inode deletion or blocking unmount.
>          */
> -       objp = fsnotify_detach_connector_from_object(conn, &type);
> +       objp = fsnotify_detach_connector_from_object(conn, &type, &flags);
>         spin_unlock(&conn->lock);
>         if (old_mark)
>                 fsnotify_put_mark(old_mark);
> -       fsnotify_drop_object(type, objp);
> +       fsnotify_drop_object(conn, type, objp, flags);
>  }
>
>  /*
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index d7d96c806bff..942fbcc34286 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -474,6 +474,7 @@ struct fsnotify_mark_connector {
>         unsigned short type;    /* Type of object [lock] */
>  #define FSNOTIFY_CONN_FLAG_HAS_FSID    0x01
>  #define FSNOTIFY_CONN_FLAG_HAS_IREF    0x02
> +#define FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN    0x04
>         unsigned short flags;   /* flags [lock] */
>         __kernel_fsid_t fsid;   /* fsid of filesystem containing object */
>         union {
> @@ -485,6 +486,13 @@ struct fsnotify_mark_connector {
>         struct hlist_head list;
>  };
>
> +/*
> + * Objects may need some additional actions to be taken when the last reference
> + * is dropped. Define flags to indicate which actions are necessary.
> + */
> +#define FSNOTIFY_OBJ_FLAG_NEED_IPUT            0x01
> +#define FSNOTIFY_OBJ_FLAG_UPDATE_CHILDREN      0x02

with changed_flags argument, you do not need these, you can use
the existing CONN_FLAGS.

It is a bit ugly that the direction of the change is not expressed
in changed_flags, but for the current code, it is not needed, because
update_children does care about the direction of the change and
the direction of change to HAS_IREF is expressed by the inode
object return value.

Maybe try it out in v3 to see how it works.

Unless Jan has an idea that will be easier to read and maintain...

Thanks,
Amir.
