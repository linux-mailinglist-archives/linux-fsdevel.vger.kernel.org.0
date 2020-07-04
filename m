Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A622144AE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgGDJaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 05:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgGDJaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 05:30:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A280C061794
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2020 02:30:22 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id a6so12346063ilq.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2020 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0Lm6SsL+oARp35qSv+EVBSn+BqwdZLV8/EszsiU2BU=;
        b=rszYWtsWSM6Vf9L80pe1Ha78oqeBNFQOJ8ldD8rhIaSzmTA+DnQ/1Ev85fdUnBqQu8
         Zh4Y5VV34uzUYlJ19TCywKPLm85T8wN2QHEwaw8vd3Fecw54kQjXp+C9T95YE+ruR8s8
         9uHZaeAfu4NrXNeKowg81StBU0upQlyXBCNDh+z5VfcO7yfY3UjdsIHrvpgOR3AEX8n8
         IkaCM3dmqz1PhJrDXmFIsEnbZxzsL+bwP/Q+JduAjzSbhmdhoO4SBupeqpSGNLNQBQD4
         gaCjlkKK2wznSCIP/YdzOPddWttBgKZitWA4loyY68rJnmyKkfAwI213Fk+unQYMesvB
         /LYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0Lm6SsL+oARp35qSv+EVBSn+BqwdZLV8/EszsiU2BU=;
        b=biGsHwo2U3nxCbXsBIF6t0vW+DF1op0Jz6JFMTpHOgxWrCwB1irfa6xLldygkWqfv+
         SGqCetc0q4QlR08uA54CkPmrLnBmYWocttAStOyXregHTEm/HDCxcA3M2rPbqPlfPk6m
         knKbvBf6GhvL4otI1Ut217lWaCpiRgm6HhX4rCMWFN9lOaNvGomGZI35pBRvtRtIZnEw
         gqcseruhFsE8Wamt9A1lf3t0I0ae1pUVUNVVIScpchdUnhiD6ZkR0k36HVhdsmQdT54B
         W0MLKa6th8Lqb70julohYHhCly3Oi/KxUasUrPG2/qBbruXiuntjnCA0JdkuZJW8fMOu
         UqEA==
X-Gm-Message-State: AOAM533YUmAfBytJARfb5U+ht9bLeRbEvNu+Jpe127FM22PlgyZMZNVp
        72KcnoElgzS6s/jg2PnvuFCtNLIlM6vrIe4njQN3+seB
X-Google-Smtp-Source: ABdhPJx+izQw92U2aLg+jztXvMQPn9bxAm94Hi4GpgRbEmfcwk0IQQgbc2wdEQ3xDOPsYvVgaen4qA9L4uuW9nSbNJI=
X-Received: by 2002:a92:b6d4:: with SMTP id m81mr21488074ill.72.1593855021173;
 Sat, 04 Jul 2020 02:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200612093343.5669-1-amir73il@gmail.com> <20200612093343.5669-2-amir73il@gmail.com>
 <20200703140342.GD21364@quack2.suse.cz>
In-Reply-To: <20200703140342.GD21364@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 4 Jul 2020 12:30:10 +0300
Message-ID: <CAOQ4uxgJkmSgt6nSO3C4y2Mc=T92ky5K5eis0f1Ofr-wDq7Wrw@mail.gmail.com>
Subject: Re: [PATCH 01/20] fsnotify: Rearrange fast path to minimise overhead
 when there is no watcher
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 3, 2020 at 5:03 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 12-06-20 12:33:24, Amir Goldstein wrote:
> > From: Mel Gorman <mgorman@techsingularity.net>
> >
> > The fsnotify paths are trivial to hit even when there are no watchers and
> > they are surprisingly expensive. For example, every successful vfs_write()
> > hits fsnotify_modify which calls both fsnotify_parent and fsnotify unless
> > FMODE_NONOTIFY is set which is an internal flag invisible to userspace.
> > As it stands, fsnotify_parent is a guaranteed functional call even if there
> > are no watchers and fsnotify() does a substantial amount of unnecessary
> > work before it checks if there are any watchers. A perf profile showed
> > that applying mnt->mnt_fsnotify_mask in fnotify() was almost half of the
> > total samples taken in that function during a test. This patch rearranges
> > the fast paths to reduce the amount of work done when there are no
> > watchers.
> >
> > The test motivating this was "perf bench sched messaging --pipe". Despite
> > the fact the pipes are anonymous, fsnotify is still called a lot and
> > the overhead is noticeable even though it's completely pointless. It's
> > likely the overhead is negligible for real IO so this is an extreme
> > example. This is a comparison of hackbench using processes and pipes on
> > a 1-socket machine with 8 CPU threads without fanotify watchers.
> >
> >                               5.7.0                  5.7.0
> >                             vanilla      fastfsnotify-v1r1
> > Amean     1       0.4837 (   0.00%)      0.4630 *   4.27%*
> > Amean     3       1.5447 (   0.00%)      1.4557 (   5.76%)
> > Amean     5       2.6037 (   0.00%)      2.4363 (   6.43%)
> > Amean     7       3.5987 (   0.00%)      3.4757 (   3.42%)
> > Amean     12      5.8267 (   0.00%)      5.6983 (   2.20%)
> > Amean     18      8.4400 (   0.00%)      8.1327 (   3.64%)
> > Amean     24     11.0187 (   0.00%)     10.0290 *   8.98%*
> > Amean     30     13.1013 (   0.00%)     12.8510 (   1.91%)
> > Amean     32     13.9190 (   0.00%)     13.2410 (   4.87%)
> >
> >                        5.7.0       5.7.0
> >                      vanilla fastfsnotify-v1r1
> > Duration User         157.05      152.79
> > Duration System      1279.98     1219.32
> > Duration Elapsed      182.81      174.52
> >
> > This is showing that the latencies are improved by roughly 2-9%. The
> > variability is not shown but some of these results are within the noise
> > as this workload heavily overloads the machine. That said, the system CPU
> > usage is reduced by quite a bit so it makes sense to avoid the overhead
> > even if it is a bit tricky to detect at times. A perf profile of just 1
> > group of tasks showed that 5.14% of samples taken were in either fsnotify()
> > or fsnotify_parent(). With the patch, 2.8% of samples were in fsnotify,
> > mostly function entry and the initial check for watchers.  The check for
> > watchers is complicated enough that inlining it may be controversial.
> >
> > [Amir] Slightly simplify with mnt_or_sb_mask => marks_mask
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/fsnotify.c             | 27 +++++++++++++++------------
> >  include/linux/fsnotify.h         | 10 ++++++++++
> >  include/linux/fsnotify_backend.h |  4 ++--
> >  3 files changed, 27 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index 72d332ce8e12..d59a58d10b84 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -143,7 +143,7 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
> >  }
> >
> >  /* Notify this dentry's parent about a child's events. */
> > -int fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> > +int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
> >                   int data_type)
> >  {
> >       struct dentry *parent;
>
> Hum, should we actually remove the DCACHE_FSNOTIFY_PARENT_WATCHED check
> from here when it's moved to fsnotify_parent() inline helper?

No point.
It is making a comeback on:
 fsnotify: send event with parent/name info to sb/mount/non-dir marks

>
> > @@ -315,17 +315,11 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
> >       struct fsnotify_iter_info iter_info = {};
> >       struct super_block *sb = to_tell->i_sb;
> >       struct mount *mnt = NULL;
> > -     __u32 mnt_or_sb_mask = sb->s_fsnotify_mask;
> >       int ret = 0;
> > -     __u32 test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> > +     __u32 test_mask, marks_mask;
> >
> > -     if (path) {
> > +     if (path)
> >               mnt = real_mount(path->mnt);
> > -             mnt_or_sb_mask |= mnt->mnt_fsnotify_mask;
> > -     }
> > -     /* An event "on child" is not intended for a mount/sb mark */
> > -     if (mask & FS_EVENT_ON_CHILD)
> > -             mnt_or_sb_mask = 0;
> >
> >       /*
> >        * Optimization: srcu_read_lock() has a memory barrier which can
> > @@ -337,13 +331,22 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
> >       if (!to_tell->i_fsnotify_marks && !sb->s_fsnotify_marks &&
> >           (!mnt || !mnt->mnt_fsnotify_marks))
> >               return 0;
> > +
> > +     /* An event "on child" is not intended for a mount/sb mark */
> > +     marks_mask = to_tell->i_fsnotify_mask;
> > +     if (!(mask & FS_EVENT_ON_CHILD)) {
> > +             marks_mask |= sb->s_fsnotify_mask;
> > +             if (mnt)
> > +                     marks_mask |= mnt->mnt_fsnotify_mask;
> > +     }
> > +
> >       /*
> >        * if this is a modify event we may need to clear the ignored masks
> >        * otherwise return if neither the inode nor the vfsmount/sb care about
> >        * this type of event.
> >        */
> > -     if (!(mask & FS_MODIFY) &&
> > -         !(test_mask & (to_tell->i_fsnotify_mask | mnt_or_sb_mask)))
> > +     test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> > +     if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
> >               return 0;
>
> Otherwise the patch looks good. One observation though: The (mask &
> FS_MODIFY) check means that all vfs_write() calls end up going through the
> "slower" path iterating all mark types and checking whether there are marks
> anyway. That could be relatively simply optimized using a hidden mask flag
> like FS_ALWAYS_RECEIVE_MODIFY which would be set when there's some mark
> needing special handling of FS_MODIFY... Not sure if we care enough at this
> point...

Yeh that sounds low hanging.
Actually, I Don't think we need to define a flag for that.
__fsnotify_recalc_mask() can add FS_MODIFY to the object's mask if needed.

I will take a look at that as part of FS_PRE_MODIFY work.
But in general, we should fight the urge to optimize theoretic
performance issues...

Thanks,
Amir.
