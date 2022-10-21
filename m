Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71436070E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 09:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJUHW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJUHW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:22:56 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A64D2465C8;
        Fri, 21 Oct 2022 00:22:55 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id a2so371248vsc.13;
        Fri, 21 Oct 2022 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xY1cnGPEcrmupw/kqHJhdnRIzBhL093FDlZni8rRSz4=;
        b=O/W9B4uhu0uAQ3vSuitB1LYk+2UKktGLmN034LkWrk2ktlBxgA4LL2LsFb/B5Rm9Rh
         vOgu9mFRmiZe5BV3k1JlfpyQGAe9o3hhfqzi7wpZg7g6HaHX0zpYM/tpg+6wzRQvqxA2
         CIvNTSEcdPyuzV7NH6K1nb2PckBcXW4wAY7sXW7n0tHash9DE90A4WbxLbASi27V5CR3
         3rIqlKI8P7doqskLCEC2QGyDDSlBIgtw6WU1t2adhJyj9jEP6OB+N7kk/YLvRfU9GmEQ
         h5te+YeR5iji8SgjobKRzJEMRRFAXl4j22VM4GW4Zj5/zTtZU8GEJcOQ1A7wrYkHo7R9
         7PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY1cnGPEcrmupw/kqHJhdnRIzBhL093FDlZni8rRSz4=;
        b=B0NnWAnM8ORMchWmUmmCVdGx7OHCg19LqWBr3Z3JAFIjfVatMIIFCOariLiqa+k3eI
         u8Ri2Nf4Pr+M7vRL0j3u+Nndptz7O29lFsRyxvZh2CT47jolh5j7myHIiyUWivvpDii+
         cRkKCi9Nind7+2RnS7R6NqS2o1Qp7hxixZrPtgAqz4LQ474sepCPH2gd3jTge3FCmOFp
         MOPebqH3yK6HsUgf6Dptv/xjGKMdCGHkPGLJrAXiNtUiaZEwI/PFp39BpyIuzyclIFr8
         EVhkexru4ilVi3usQjZQ69DHw/sqybBzQsz1+68dDz89tA1/oPc/OPrh9vWhWkETDIds
         PcEg==
X-Gm-Message-State: ACrzQf2QpNr8aPjzlDoejZHcU/hrpyoWokXoCKC4PdMw0bRaC/aVyZJ1
        GlQ03sdVZrgNX5g0tLgVCClh3GO6h7kK47CIDhE=
X-Google-Smtp-Source: AMsMyM5nU8xWzOUsu33+q6rF6PebqTNnccCgrlNwhFTnXSqUM+DDBRaot//0Psa+LLRa9nw2LCEe5KcM+4FgeLkHJsQ=
X-Received: by 2002:a67:c099:0:b0:39b:342:3c0d with SMTP id
 x25-20020a67c099000000b0039b03423c0dmr11440901vsi.3.1666336973944; Fri, 21
 Oct 2022 00:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com> <20221018041233.376977-2-stephen.s.brennan@oracle.com>
 <CAOQ4uxhi27ZZmXMV1JTR1+3-1MVMY3W_R=+7LbOHWXbKOk4hjg@mail.gmail.com> <87y1taggmu.fsf@oracle.com>
In-Reply-To: <87y1taggmu.fsf@oracle.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 Oct 2022 10:22:42 +0300
Message-ID: <CAOQ4uxg0u+eEpyjW7ACn60wXDG1OAWZ8YF0H_OyTgZ2YLxQsXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

()


On Fri, Oct 21, 2022 at 3:33 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Tue, Oct 18, 2022 at 7:12 AM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> >>
> >> When an inode is interested in events on its children, it must set
> >> DCACHE_FSNOTIFY_PARENT_WATCHED flag on all its children. Currently, when
> >> the fsnotify connector is removed and i_fsnotify_mask becomes zero, we
> >> lazily allow __fsnotify_parent() to do this the next time we see an
> >> event on a child.
> >>
> >> However, if the list of children is very long (e.g., in the millions),
> >> and lots of activity is occurring on the directory, then it's possible
> >> for many CPUs to end up blocked on the inode spinlock in
> >> __fsnotify_update_child_flags(). Each CPU will then redundantly iterate
> >> over the very long list of children. This situation can cause soft
> >> lockups.
> >>
> >> To avoid this, stop lazily updating child flags in __fsnotify_parent().
> >> Protect the child flag update with i_rwsem held exclusive, to ensure
> >> that we only iterate over the child list when it's absolutely necessary,
> >> and even then, only once.
> >>
> >> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> >> ---
> >>
> >> Notes:
> >>
> >> It seems that there are two implementation options for this, regarding
> >> what i_rwsem protects:
> >>
> >> 1. Both updates to i_fsnotify_mask, and the child dentry flags, or
> >> 2. Only updates to the child dentry flags
> >>
> >> I wanted to do #1, but it got really tricky with fsnotify_put_mark(). We
> >> don't want to hold the inode lock whenever we decrement the refcount,
> >> but if we don't, then we're stuck holding a spinlock when the refcount
> >> goes to zero, and we need to grab the inode rwsem to synchronize the
> >> update to the child flags. I'm sure there's a way around this, but I
> >> didn't keep going with it.
> >>
> >> With #1, as currently implemented, we have the unfortunate effect of
> >> that a mark can be added, can see that no update is required, and
> >> return, despite the fact that the flag update is still in progress on a
> >> different CPU/thread. From our discussion, that seems to be the current
> >> status quo, but I wanted to explicitly point that out. If we want to
> >> move to #1, it should be possible with some work.
> >
> > I think the solution may be to store the state of children in conn
> > like you suggested.
> >
> > See fsnotify_update_iref() and conn flag
> > FSNOTIFY_CONN_FLAG_HAS_IREF.
> >
> > You can add a conn flag
> > FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN
> > that caches the result of the last invocation of update children flags.
> >
> > For example, fsnotify_update_iref() becomes
> > fsnotify_update_inode_conn_flags() and
> > returns inode if either inode ref should be dropped
> > or if children flags need to be updated (or both)
> > maybe use some out argument to differentiate the cases.
> > Same for fsnotify_detach_connector_from_object().
> >
> > Then, where fsnotify_drop_object() is called, for the
> > case that inode children need to be updated,
> > take inode_lock(), take connector spin lock
> > to check if another thread has already done the update
> > if not release spin lock, perform the update under inode lock
> > and at the end, take spin lock again and set the
> > FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN
> > connector flag.
> >
> > Not sure if it all works out... maybe
>
> I did this for v2 and I think it has worked well, all threads seem to
> block until the flags are updated on all dentries.
>

It did work out pretty well. v2 looks nice :)

> >>
> >>  fs/notify/fsnotify.c | 12 ++++++++--
> >>  fs/notify/mark.c     | 55 ++++++++++++++++++++++++++++++++++----------
> >>  2 files changed, 53 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> >> index 7974e91ffe13..e887a195983b 100644
> >> --- a/fs/notify/fsnotify.c
> >> +++ b/fs/notify/fsnotify.c
> >> @@ -207,8 +207,16 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> >>         parent = dget_parent(dentry);
> >>         p_inode = parent->d_inode;
> >>         p_mask = fsnotify_inode_watches_children(p_inode);
> >> -       if (unlikely(parent_watched && !p_mask))
> >> -               __fsnotify_update_child_dentry_flags(p_inode);
> >> +       if (unlikely(parent_watched && !p_mask)) {
> >> +               /*
> >> +                * Flag would be cleared soon by
> >> +                * __fsnotify_update_child_dentry_flags(), but as an
> >> +                * optimization, clear it now.
> >> +                */
> >
> > I think that we need to also take p_inode spin_lock here and
> > check  fsnotify_inode_watches_children() under lock
> > otherwise, we could be clearing the WATCHED flag
> > *after* __fsnotify_update_child_dentry_flags() had
> > already set it, because you we not observe the change to
> > p_inode mask.
>
> I'm not sure I follow. The i_fsnotify_mask field isn't protected by the
> p_inode spinlock. It isn't really protected at all, though it mainly
> gets modified with the conn->lock held.
>

Right.

> Wouldn't it be sufficient to do in a new helper:
>
> spin_lock(&dentry->d_lock);
> if (!fsnotify_inode_watches_children(p_inode))
>     dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> spin_unlock(&dentry->d_lock);
>

Yes, I think this is better.

I am not sure if that data race can lead to the wrong state of dentry
flags forever on upstream, but I'm pretty sure that it can on v1.

> I'm sure I'm missing something about your comment. For the moment I left
> it as is in the second version of the patch, we can discuss it more and
> I can update it for a v3.
>

v1 doesn't have a memory barrier between loading value into
parent_watched and into p_mask, so the check wasn't safe.

In v2,  __fsnotify_update_child_dentry_flags() rechecks
fsnotify_inode_watches_children() after the the barrier provided
by the dentry spin lock, so the "lockless" check is safe:

Writer:
store i_fsnotify_mask
smp_store_release(d_lock) // spin unlock
store d_flags

Reader:
load d_flags
smp_load_acquire(d_lock) // spin_lock
load i_fsnotify_mask

Best resource I like for refreshing my "lockless" skills:
https://lwn.net/Articles/844224/

> >
> > I would consider renaming __fsnotify_update_child_dentry_flags()
> > to __fsnotify_update_children_dentry_flags(struct inode *dir)
> >
> > and creating another inline helper for this call site called:
> > fsnotify_update_child_dentry_flags(struct inode *dir, struct dentry *child)
> >
> >
> >> +               spin_lock(&dentry->d_lock);
> >> +               dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
> >> +               spin_unlock(&dentry->d_lock);
> >> +       }
> >>
> >>         /*
> >>          * Include parent/name in notification either if some notification
> >> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> >> index c74ef947447d..da9f944fcbbb 100644
> >> --- a/fs/notify/mark.c
> >> +++ b/fs/notify/mark.c
> >> @@ -184,15 +184,36 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> >>   */
> >>  void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> >>  {
> >> +       struct inode *inode = NULL;
> >> +       int watched_before, watched_after;
> >> +
> >>         if (!conn)
> >>                 return;
> >>
> >> -       spin_lock(&conn->lock);
> >> -       __fsnotify_recalc_mask(conn);
> >> -       spin_unlock(&conn->lock);
> >> -       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
> >> -               __fsnotify_update_child_dentry_flags(
> >> -                                       fsnotify_conn_inode(conn));
> >> +       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
> >> +               /*
> >> +                * For inodes, we may need to update flags on the child
> >> +                * dentries. To ensure these updates occur exactly once,
> >> +                * synchronize the recalculation with the inode mutex.
> >> +                */
> >> +               inode = fsnotify_conn_inode(conn);
> >> +               spin_lock(&conn->lock);
> >> +               watched_before = fsnotify_inode_watches_children(inode);
> >> +               __fsnotify_recalc_mask(conn);
> >> +               watched_after = fsnotify_inode_watches_children(inode);
> >> +               spin_unlock(&conn->lock);
> >> +
> >> +               inode_lock(inode);
> >
> > With the pattern that I suggested above, this if / else would
> > be unified to code that looks something like this:
> >
> > spin_lock(&conn->lock);
> > inode =  __fsnotify_recalc_mask(conn);
> > spin_unlock(&conn->lock);
> >
> > if (inode)
> >     fsnotify_update_children_dentry_flags(conn, inode);
> >
> > Where fsnotify_update_children_dentry_flags()
> > takes inode lock around entire update and conn spin lock
> > only around check and update of conn flags.
> >
> > FYI, at this time in the code, adding  a mark or updating
> > existing mark mask cannot result in the need to drop iref.
> > That is the reason that return value of __fsnotify_recalc_mask()
> > is not checked here.
>
> For v3 I tried this with a new "flags" out variable and two flags - one
> for requiring an iput(), and one for calling
> fsnotify_update_children_dentry_flags(). As a result, I did stick a
> WARN_ON_ONCE here, but it more or less looks just like this code :)
>

Cool.

> >> +               if ((watched_before && !watched_after) ||
> >> +                   (!watched_before && watched_after)) {
> >> +                       __fsnotify_update_child_dentry_flags(inode);
> >> +               }
> >> +               inode_unlock(inode);
> >> +       } else {
> >> +               spin_lock(&conn->lock);
> >> +               __fsnotify_recalc_mask(conn);
> >> +               spin_unlock(&conn->lock);
> >> +       }
> >>  }
> >>
> >>  /* Free all connectors queued for freeing once SRCU period ends */
> >> @@ -295,6 +316,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
> >>         struct fsnotify_mark_connector *conn = READ_ONCE(mark->connector);
> >>         void *objp = NULL;
> >>         unsigned int type = FSNOTIFY_OBJ_TYPE_DETACHED;
> >> +       struct inode *inode = NULL;
> >> +       int watched_before, watched_after;
> >>         bool free_conn = false;
> >>
> >>         /* Catch marks that were actually never attached to object */
> >> @@ -311,17 +334,31 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
> >>         if (!refcount_dec_and_lock(&mark->refcnt, &conn->lock))
> >>                 return;
> >>
> >> +       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
> >> +               inode = fsnotify_conn_inode(conn);
> >> +               watched_before = fsnotify_inode_watches_children(inode);
> >> +       }
> >> +
> >>         hlist_del_init_rcu(&mark->obj_list);
> >>         if (hlist_empty(&conn->list)) {
> >>                 objp = fsnotify_detach_connector_from_object(conn, &type);
> >>                 free_conn = true;
> >> +               watched_after = 0;
> >>         } else {
> >>                 objp = __fsnotify_recalc_mask(conn);
> >>                 type = conn->type;
> >> +               watched_after = fsnotify_inode_watches_children(inode);
> >>         }
> >>         WRITE_ONCE(mark->connector, NULL);
> >>         spin_unlock(&conn->lock);
> >>
> >> +       if (inode) {
> >> +               inode_lock(inode);
> >> +               if (watched_before && !watched_after)
> >> +                       __fsnotify_update_child_dentry_flags(inode);
> >> +               inode_unlock(inode);
> >> +       }
> >> +
> >>         fsnotify_drop_object(type, objp);
> >>
> >
> > Here as well something like:
> > if (objp)
> >     fsnotify_update_children_dentry_flags(conn, obj);
> >
> > But need to distinguish when inode ref needs to be dropped
> > children flags updates or both.
>
> With a flags out-param, it works well. I actually was able to stuff this
> into fsnotify_drop_object, which was good because I had missed a whole
> other function that can detach a connector from an inode
> (fsnotify_destroy_marks()).
>

Haha, this call is coming from __fsnotify_inode_delete()
the evicted dir inode cannot have any children in dache,
but it's good to have robust code ;)

Thanks,
Amir.
