Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A12610CCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJ1JLW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJ1JLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:11:14 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD23A66879;
        Fri, 28 Oct 2022 02:11:12 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id m18so2159648vka.10;
        Fri, 28 Oct 2022 02:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4RCyKD8zYwlvu9aAaMjqHPPigA0jvv7ic1y64rLtWXs=;
        b=fbWNzhHat+rQnn4Ziatl6xQK9MURxadNNbt6kWvOFV6Cmk7DYFImu2bzMacNAadR7V
         Nksz+4ZgrH1/4IOQqpF19YioFWuNdAIVvfVOlebZoE9BQc6beKbCKxbcvtWv/9T+63Cs
         BMXBbIlY/ivDVg9w+k/fcMaAg07IURovRBREkp2kYNttl1kzT5Nl9wezcnMZFgX+6dr9
         SQ/3TcoSjyssu/nAa1ynjgvRgz2xKbvwrPtDeo8FIKhGdaw9QQTxzibL7g3a92a6qq5w
         01YG/wAXELy+BAmQLBz4HycemOoKQfbNJYCTBoqh9avI6Zo0zAy3aIDaoStuF+CmMTpQ
         71zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4RCyKD8zYwlvu9aAaMjqHPPigA0jvv7ic1y64rLtWXs=;
        b=PJdk63cdgOHDWz5UniprEO7QhQGCfZtffkQ2JuPmucioDQCDXhj2Ty7Wk8Y6eKvWAU
         w7cAxXomZVrmdww3gvtYtppFYRAA4osksAt45j/3KSahJdGR9fkotKM3vrZWC5e7eskE
         ay1V2S8WCtCwumv2hnlIno/6/LeosuR5T/4PJaRd5F21kpInUPSRfJiM3Hl8igfKTkQC
         8ke7bz3zv2/iS0ZWV9tSxJBmV16cexNPAKaRm9wWpsGeV/ij9E1J/T+cDDV7CbV6mrL/
         b0GnIZaff7oBYCvYb0mgAIQX2ii2Dx9lm062Jo5gNsAR5UX/Nbxx4sus7eBsAT1pjqsl
         wzUQ==
X-Gm-Message-State: ACrzQf3l+y5qba0R8lVHnuDFOF94oO3zg4lOF8QpYJxhxzP/uB2BeEGm
        MzG8rIgn+Mrfy5C7XTnhWzpwNNkBPx/XDO74P9prJOXXe1U=
X-Google-Smtp-Source: AMsMyM4VJ0uhReh7DSMsTR7/NZm6joni79FPgcP+xgw5WX0PEPjhJcAEsf/VYa1TFndmgEXxYbvjQ0gEaLs+cYHzJEg=
X-Received: by 2002:a1f:a1c5:0:b0:3b7:690b:c3d4 with SMTP id
 k188-20020a1fa1c5000000b003b7690bc3d4mr5631661vke.3.1666948271545; Fri, 28
 Oct 2022 02:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com> <20221028001016.332663-3-stephen.s.brennan@oracle.com>
In-Reply-To: <20221028001016.332663-3-stephen.s.brennan@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 28 Oct 2022 12:11:00 +0300
Message-ID: <CAOQ4uxjF8kU90F49wHjMehhmxGFTHdsWDQZks4v9jWiLs76qzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
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

Looking good

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Regardless, some nits on comment styles...

>
> Notes:
>     v3 changes:
>
>     * Moved fsnotify_update_children_dentry_flags() into fsnotify.c,
>       declared it in the header. Made
>       __fsnotify_update_children_dentry_flags() static since it has no
>       external callers except fsnotify_update...().
>     * Use bitwise xor operator in children_need_update()
>     * Eliminated FSNOTIFY_OBJ_FLAG_* constants, reused CONN_FLAG_*
>     * Updated documentation of fsnotify_update_inode_conn_flags() to
>       reflect its behavior
>     * Renamed "flags" to "update_flags" in all its uses, so that it's a
>       clear pattern and matches renamed fsnotify_update_object().
>
>  fs/notify/fsnotify.c             |  45 ++++++++++-
>  fs/notify/fsnotify.h             |  13 +++-
>  fs/notify/mark.c                 | 124 ++++++++++++++++++++-----------
>  include/linux/fsnotify_backend.h |   1 +
>  4 files changed, 137 insertions(+), 46 deletions(-)
>
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 7939aa911931..ccb8a3a6c522 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -103,13 +103,15 @@ void fsnotify_sb_delete(struct super_block *sb)
>   * parent cares.  Thus when an event happens on a child it can quickly tell
>   * if there is a need to find a parent and send the event to the parent.
>   */
> -void __fsnotify_update_child_dentry_flags(struct inode *inode)
> +static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
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
> @@ -136,6 +138,43 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
>         }
>         spin_unlock(&alias->d_lock);
>         dput(alias);
> +       return watched;
> +}
> +
> +void fsnotify_update_children_dentry_flags(struct fsnotify_mark_connector *conn,
> +                                          struct inode *inode)
> +{
> +       bool need_update;
> +
> +       inode_lock(inode);
> +       spin_lock(&conn->lock);
> +       need_update = fsnotify_children_need_update(conn, inode);
> +       spin_unlock(&conn->lock);
> +       if (need_update) {
> +               bool watched = __fsnotify_update_children_dentry_flags(inode);
> +
> +               spin_lock(&conn->lock);
> +               if (watched)
> +                       conn->flags |= FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
> +               else
> +                       conn->flags &= ~FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
> +               spin_unlock(&conn->lock);
> +       }
> +       inode_unlock(inode);
> +}
> +
> +
> +static void fsnotify_update_child_dentry_flags(struct inode *inode, struct dentry *dentry)
> +{
> +       /*
> +        * Flag would be cleared soon by
> +        * __fsnotify_update_child_dentry_flags(), but as an
> +        * optimization, clear it now.
> +        */

Line breaks are weird.
Seems that this comment is out of context.
It is only true in the context of the specific call site.
Either remove it or move it.

> +       spin_lock(&dentry->d_lock);
> +       if (!fsnotify_inode_watches_children(inode))
> +               dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> +       spin_unlock(&dentry->d_lock);
>  }
>
>  /* Are inode/sb/mount interested in parent and name info with this event? */
> @@ -206,7 +245,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>         p_inode = parent->d_inode;
>         p_mask = fsnotify_inode_watches_children(p_inode);
>         if (unlikely(parent_watched && !p_mask))
> -               __fsnotify_update_child_dentry_flags(p_inode);
> +               fsnotify_update_child_dentry_flags(p_inode, dentry);
>
>         /*
>          * Include parent/name in notification either if some notification
> diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> index fde74eb333cc..621e78a6f0fb 100644
> --- a/fs/notify/fsnotify.h
> +++ b/fs/notify/fsnotify.h
> @@ -70,11 +70,22 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
>         fsnotify_destroy_marks(&sb->s_fsnotify_marks);
>  }
>
> +static inline bool fsnotify_children_need_update(struct fsnotify_mark_connector *conn,
> +                                                struct inode *inode)
> +{
> +       bool watched, flags_set;
> +
> +       watched = fsnotify_inode_watches_children(inode);
> +       flags_set = conn->flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
> +       return watched ^ flags_set;
> +}
> +
>  /*
>   * update the dentry->d_flags of all of inode's children to indicate if inode cares
>   * about events that happen to its children.
>   */
> -extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
> +extern void fsnotify_update_children_dentry_flags(struct fsnotify_mark_connector *conn,
> +                                                 struct inode *inode);
>
>  extern struct kmem_cache *fsnotify_mark_connector_cachep;
>
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c74ef947447d..8969128dacc1 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -123,37 +123,52 @@ static void fsnotify_get_inode_ref(struct inode *inode)
>  }
>
>  /*
> - * Grab or drop inode reference for the connector if needed.
> + * Determine the connector flags that it is necessary to update
>   *
> - * When it's time to drop the reference, we only clear the HAS_IREF flag and
> - * return the inode object. fsnotify_drop_object() will be resonsible for doing
> - * iput() outside of spinlocks. This happens when last mark that wanted iref is
> - * detached.
> + * If any action needs to be taken on the connector's inode outside of a spinlock,
> + * we return the inode and set *update_flags accordingly.
> + *
> + * If FSNOTIFY_CONN_FLAG_HAS_IREF is set in *update_flags, then the caller needs
> + * to drop the last inode reference using fsnotify_put_inode_ref().
> + *
> + * If FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN is set in *update_flags, then the
> + * caller needs to update the children dentry flags so that their
> + * DCACHE_FSNOTIFY_PARENT_WATCHED flag matches the i_fsnotify_mask value, using
> + * fsnotify_update_children_dentry_flags().
>   */
> -static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
> -                                         bool want_iref)
> +static struct inode *fsnotify_update_inode_conn_flags(struct fsnotify_mark_connector *conn,
> +                                                     bool want_iref, int *update_flags)
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
> +                       *update_flags |= FSNOTIFY_CONN_FLAG_HAS_IREF;
> +               }
> +       }
> +       if (fsnotify_children_need_update(conn, inode)) {
> +               ret = inode;
> +               *update_flags |= FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
>         }
>
> -       return inode;
> +       return ret;
>  }
>
> -static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> +static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn,
> +                                   int *update_flags)
>  {
>         u32 new_mask = 0;
>         bool want_iref = false;
> @@ -173,7 +188,7 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>         }
>         *fsnotify_conn_mask_p(conn) = new_mask;
>
> -       return fsnotify_update_iref(conn, want_iref);
> +       return fsnotify_update_inode_conn_flags(conn, want_iref, update_flags);
>  }
>
>  /*
> @@ -184,15 +199,19 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
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
> +       if (flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN)
> +               fsnotify_update_children_dentry_flags(conn, inode);
> +       WARN_ON_ONCE(flags & FSNOTIFY_CONN_FLAG_HAS_IREF);
>  }
>
>  /* Free all connectors queued for freeing once SRCU period ends */
> @@ -240,7 +259,8 @@ static void fsnotify_put_sb_connectors(struct fsnotify_mark_connector *conn)
>
>  static void *fsnotify_detach_connector_from_object(
>                                         struct fsnotify_mark_connector *conn,
> -                                       unsigned int *type)
> +                                       unsigned int *type,
> +                                       unsigned int *update_flags)
>  {
>         struct inode *inode = NULL;
>
> @@ -252,8 +272,10 @@ static void *fsnotify_detach_connector_from_object(
>                 inode = fsnotify_conn_inode(conn);
>                 inode->i_fsnotify_mask = 0;
>
> -               /* Unpin inode when detaching from connector */
> -               if (!(conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF))
> +               *update_flags = conn->flags &
> +                       (FSNOTIFY_CONN_FLAG_HAS_IREF |
> +                        FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN);
> +               if (!*update_flags)
>                         inode = NULL;
>         } else if (conn->type == FSNOTIFY_OBJ_TYPE_VFSMOUNT) {
>                 fsnotify_conn_mount(conn)->mnt_fsnotify_mask = 0;
> @@ -279,15 +301,37 @@ static void fsnotify_final_mark_destroy(struct fsnotify_mark *mark)
>         fsnotify_put_group(group);
>  }
>
> -/* Drop object reference originally held by a connector */
> -static void fsnotify_drop_object(unsigned int type, void *objp)
> +/* Apply the update_flags for a connector after recalculating mask */
> +static void fsnotify_update_object(struct fsnotify_mark_connector *conn,
> +                                  unsigned int type, void *objp,
> +                                  int update_flags)
>  {
>         if (!objp)
>                 return;
>         /* Currently only inode references are passed to be dropped */
>         if (WARN_ON_ONCE(type != FSNOTIFY_OBJ_TYPE_INODE))
>                 return;
> -       fsnotify_put_inode_ref(objp);
> +
> +       if (update_flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN)
> +               /*.

Stray .

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

Multi line section after if should have {} even if there is only a
single line of
code (checkpatch should complain?).

But I personally dislike large and deeply indented comments,
so if it were me, I would change the wording a bit
"...When detaching a connector from an inode that watches children,
 there are two possibilities:..."
and move the huge comment above the if ().

Thanks,
Amir.
