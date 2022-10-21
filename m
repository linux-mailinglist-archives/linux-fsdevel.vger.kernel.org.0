Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF56073E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiJUJWV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 05:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbiJUJWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:22:09 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E79173FCF;
        Fri, 21 Oct 2022 02:22:04 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id h3so622646vsa.4;
        Fri, 21 Oct 2022 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X0SsVkkMNFp/PXaKlbAPg9aNsimnbFJJph5XDSN5hcg=;
        b=KFXnRU+yroLlBjyoRcis12i9r/wWOK0hU7J1GSOXnPw186q/dKpTp9ZNYdDxCb+l0y
         QBie0Zzblw4Sc2vJyPgGux2hVd2ht7ZA1ibeCi0tE/dkFjt7PZUxIitDn6e38m9fNi0e
         76wMLq9TFd3YAUCZctP3eYUSI1x9bDaxePOdvQHJnPOaEoPAgujXttVFS/tzwgIG7OaE
         +5Y74yGycmLVrZPGd5//t5+oVxohEsYq6KaDkwC4z1l8acAyEnVQPYkekCcs1ygJ0jX5
         YXIH2LNVHfhM6ceYdXKqd274xU6/Bcn+cyGl2iOT6JB1sUTfWxxcE19ZMLNow+87VIYS
         MGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0SsVkkMNFp/PXaKlbAPg9aNsimnbFJJph5XDSN5hcg=;
        b=VwXctuG1qgDCRm0PUbZnpA3V/89+hYVf6p/S7ssIUMezkv04X24BHlg8XlkBxHMn08
         TMP35ANVcIg6mqd/16Ic5i1hSwyWsn/zcMLzn4ZQMbbLiQl3EEVujnNApxR5LoOcE0Zx
         GBVsTxMWSV9brAhYYoMC0eQXzECWP318kahrDbVvsUIpyqZQfsrSVBJzn0bl1NQH3HcR
         0RuK0tOt8vNQ9oG+dbDw70vLBBMLDwc8iREFRGzCZV3LuKJR9av74MStfSlC2M8J9FGc
         Pwd55oNzjBw0eZYOvzfZt+uwtTjnI/ZzI3LOC29oTqbS5+L1WlmyrDYoc4wSJ7RPeRVC
         igKQ==
X-Gm-Message-State: ACrzQf2mCaOm8Jxh/siCdQXyfMffwD1lHRzxKwuLx/lrxpS1nHd2hXga
        tqxmeg23wN4DaKwDCTV1DhpVnNQK7kbDif7TDrg=
X-Google-Smtp-Source: AMsMyM4h51Nk/KZ3+A3xCb2efZL2VLpc/HT1Qow/Tly35d90U44p6YYnuPs4VVHTf4ojlivhJEKP1X+nGme/E4f7Sys=
X-Received: by 2002:a67:a24e:0:b0:3a5:38a0:b610 with SMTP id
 t14-20020a67a24e000000b003a538a0b610mr11595627vsh.2.1666344122739; Fri, 21
 Oct 2022 02:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221021010310.29521-1-stephen.s.brennan@oracle.com> <20221021010310.29521-3-stephen.s.brennan@oracle.com>
 <20221021091710.jxv6zi3nfkmqdmqy@wittgenstein>
In-Reply-To: <20221021091710.jxv6zi3nfkmqdmqy@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 Oct 2022 12:21:51 +0300
Message-ID: <CAOQ4uxiHs-TPHXFJB=G0fQ6pD+fFKkxwmytSrtZpvO1opaekkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
To:     Christian Brauner <brauner@kernel.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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

On Fri, Oct 21, 2022 at 12:17 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Oct 20, 2022 at 06:03:09PM -0700, Stephen Brennan wrote:
> > When an inode is interested in events on its children, it must set
> > DCACHE_FSNOTIFY_PARENT_WATCHED flag on all its children. Currently, when
> > the fsnotify connector is removed and i_fsnotify_mask becomes zero, we
> > lazily allow __fsnotify_parent() to do this the next time we see an
> > event on a child.
> >
> > However, if the list of children is very long (e.g., in the millions),
> > and lots of activity is occurring on the directory, then it's possible
> > for many CPUs to end up blocked on the inode spinlock in
> > __fsnotify_update_child_flags(). Each CPU will then redundantly iterate
> > over the very long list of children. This situation can cause soft
> > lockups.
> >
> > To avoid this, stop lazily updating child flags in __fsnotify_parent().
> > Instead, update flags when we disconnect a mark connector. Remember the
> > state of the children flags in the fsnotify_mark_connector flags.
> > Provide mutual exclusion by holding i_rwsem exclusive while we update
> > children, and use the cached state to avoid updating flags
> > unnecessarily.
> >
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > ---
> >
> >  fs/notify/fsnotify.c             |  22 ++++++-
> >  fs/notify/fsnotify.h             |  31 ++++++++-
> >  fs/notify/mark.c                 | 106 ++++++++++++++++++++-----------
> >  include/linux/fsnotify_backend.h |   8 +++
> >  4 files changed, 127 insertions(+), 40 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 6c338322f0c3..f83eca4fb841 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -103,13 +103,15 @@ void fsnotify_sb_delete(struct super_block *sb)
> >   * parent cares.  Thus when an event happens on a child it can quickly tell
> >   * if there is a need to find a parent and send the event to the parent.
> >   */
> > -void __fsnotify_update_child_dentry_flags(struct inode *inode)
> > +bool __fsnotify_update_children_dentry_flags(struct inode *inode)
> >  {
> >       struct dentry *alias, *child;
> >       int watched;
> >
> >       if (!S_ISDIR(inode->i_mode))
> > -             return;
> > +             return false;
> > +
> > +     lockdep_assert_held_write(&inode->i_rwsem);
> >
> >       /* determine if the children should tell inode about their events */
> >       watched = fsnotify_inode_watches_children(inode);
> > @@ -133,6 +135,20 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
> >               spin_unlock(&child->d_lock);
> >       }
> >       spin_unlock(&alias->d_lock);
> > +     return watched;
> > +}
> > +
> > +void __fsnotify_update_child_dentry_flags(struct inode *inode, struct dentry *dentry)
> > +{
> > +     /*
> > +      * Flag would be cleared soon by
> > +      * __fsnotify_update_child_dentry_flags(), but as an
> > +      * optimization, clear it now.
> > +      */
> > +     spin_lock(&dentry->d_lock);
> > +     if (!fsnotify_inode_watches_children(inode))
> > +             dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> > +     spin_unlock(&dentry->d_lock);
> >  }
> >
> >  /* Are inode/sb/mount interested in parent and name info with this event? */
> > @@ -203,7 +219,7 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> >       p_inode = parent->d_inode;
> >       p_mask = fsnotify_inode_watches_children(p_inode);
> >       if (unlikely(parent_watched && !p_mask))
> > -             __fsnotify_update_child_dentry_flags(p_inode);
> > +             __fsnotify_update_child_dentry_flags(p_inode, dentry);
> >
> >       /*
> >        * Include parent/name in notification either if some notification
> > diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
> > index fde74eb333cc..182d93014c6b 100644
> > --- a/fs/notify/fsnotify.h
> > +++ b/fs/notify/fsnotify.h
> > @@ -70,11 +70,40 @@ static inline void fsnotify_clear_marks_by_sb(struct super_block *sb)
> >       fsnotify_destroy_marks(&sb->s_fsnotify_marks);
> >  }
> >
> > +static inline bool fsnotify_children_need_update(struct fsnotify_mark_connector *conn,
> > +                                                 struct inode *inode)
> > +{
> > +     bool watched, flags_set;
> > +     watched = fsnotify_inode_watches_children(inode);
>
> nit: I'd leave a blank line after the variable declarations. Same for
> fsnotify_update_children_dentry_flags() below.
>
> > +     flags_set = conn->flags & FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN;
> > +     return (watched && !flags_set) || (!watched && flags_set);
> > +}
> > +
> >  /*
> >   * update the dentry->d_flags of all of inode's children to indicate if inode cares
> >   * about events that happen to its children.
> >   */
> > -extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
> > +extern bool __fsnotify_update_children_dentry_flags(struct inode *inode);
> > +
> > +static inline void fsnotify_update_children_dentry_flags(struct fsnotify_mark_connector *conn,
> > +                                                         struct inode *inode)
>
> Should that be a static inline function in a header seems a bit big. :)

I agree.
This helper has exactly one caller and should be placed right below it.

Thanks for spotting that,
Amir.
