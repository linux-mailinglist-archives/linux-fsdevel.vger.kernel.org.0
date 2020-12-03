Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811B82CD3F2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 11:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgLCKqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 05:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbgLCKqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:46:07 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42608C061A4D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 02:45:27 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id f5so1443137ilj.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 02:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocq/vpK/LAnHJ2bWaidCJ6AuKknzhcO92DvPm1TiZy0=;
        b=Hl9PH4H26Zua+zdkWwfVqcoahaudnkkv3nLxb2CgFZiWX9RBpUPovNN2XuvOYxm1nB
         ILmkve7WjiFgXMhOQa4y0oF740yOJXNjJgC9/2rK/qz61yJ2G3Pb9Kc9rAMp+aouEqdU
         TxgROo3qgtM0p5+d9GlIUUdISwkrGUWGzGMgAM5jQ+/B/zzjkXIv8FTGW8L11T47Jg4s
         OO3nqQ34GyXauQM+NUrRo6Qc6ifrXvjtEx3bPBaKu3GWfZjl2N2jze+nwWCO2IY/Zc5B
         loEJAo/+yGERDRJVcbBF2xCUaII9SALQz/kbZ2qAV2ec47JvYzAXKAiDA88W2dna1uJ1
         Htuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocq/vpK/LAnHJ2bWaidCJ6AuKknzhcO92DvPm1TiZy0=;
        b=nMXizOvGs3jnT8WwNStbJx3N5Y8nPjGehop6BDF0IK2eeGhLDtz6DiWzlfqvTtohRA
         DibTBo0JyMLhHsV4m0OAN5eigp/GLnYl2RJmjBcsDxc6lJ1Vf1wxAQZiW6YnqJQIIEqh
         ys+TF+fNX3VwwEIBSwp/B9ltSN/sLKB1VVVLKqTFzFHgLIS244S/SjAdE8r2t3/DeCXT
         yB3Pt7RO/Gw+DePu1722HXWNujomjXcmYXu2Funi1vN4PsNomdjzbFmWcHCoY7OSoxth
         o0AvsVU+OUbejO6Y26kdxnNlMXVUv2JOUhNM1K2rr6FSf5eFN9BUJtVf+2az1SM2BdMv
         8FHw==
X-Gm-Message-State: AOAM532EtEtaqHH2tDFuNnRctjUYczzbW3913R/8Um04brczc3Hgitbs
        hjC4FGvYQtLSlHrJaS8IjjK/gydWOHnMa66r3ZlKMTowWy0=
X-Google-Smtp-Source: ABdhPJwLDQoyb8zgl8x+eDGZBu2WpZ1nUJDjq9bMGHmnQypV/a7TFRA8EKmAM7FN3Iv/tTNyYCQbZDaPZ6KwEsHGE/c=
X-Received: by 2002:a92:da82:: with SMTP id u2mr2411801iln.137.1606992326718;
 Thu, 03 Dec 2020 02:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20201202120713.702387-1-amir73il@gmail.com> <20201202120713.702387-3-amir73il@gmail.com>
 <20201203095532.GB11854@quack2.suse.cz>
In-Reply-To: <20201203095532.GB11854@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Dec 2020 12:45:15 +0200
Message-ID: <CAOQ4uxghXX683tSiC=pOdMoqXYxBw20JaQQkFAE3NctBraODJg@mail.gmail.com>
Subject: Re: [PATCH 2/7] inotify: convert to handle_inode_event() interface
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 3, 2020 at 11:55 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 02-12-20 14:07:08, Amir Goldstein wrote:
> > Convert inotify to use the simple handle_inode_event() interface to
> > get rid of the code duplication between the generic helper
> > fsnotify_handle_event() and the inotify_handle_event() callback, which
> > also happen to be buggy code.
> >
> > The bug will be fixed in the generic helper.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/notify/inotify/inotify.h          |  9 +++---
> >  fs/notify/inotify/inotify_fsnotify.c | 47 ++++++----------------------
> >  fs/notify/inotify/inotify_user.c     |  7 +----
> >  3 files changed, 15 insertions(+), 48 deletions(-)
> >
> > diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
> > index 4327d0e9c364..7fc3782b2fb8 100644
> > --- a/fs/notify/inotify/inotify.h
> > +++ b/fs/notify/inotify/inotify.h
> > @@ -24,11 +24,10 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
> >
> >  extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
> >                                          struct fsnotify_group *group);
> > -extern int inotify_handle_event(struct fsnotify_group *group, u32 mask,
> > -                             const void *data, int data_type,
> > -                             struct inode *dir,
> > -                             const struct qstr *file_name, u32 cookie,
> > -                             struct fsnotify_iter_info *iter_info);
> > +extern int inotify_handle_event(struct fsnotify_group *group,
> > +                             struct fsnotify_mark *inode_mark, u32 mask,
> > +                             struct inode *inode, struct inode *dir,
> > +                             const struct qstr *name, u32 cookie);
> >
> >  extern const struct fsnotify_ops inotify_fsnotify_ops;
> >  extern struct kmem_cache *inotify_inode_mark_cachep;
> > diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> > index 9ddcbadc98e2..f348c1d3b358 100644
> > --- a/fs/notify/inotify/inotify_fsnotify.c
> > +++ b/fs/notify/inotify/inotify_fsnotify.c
> > @@ -55,10 +55,10 @@ static int inotify_merge(struct list_head *list,
> >       return event_compare(last_event, event);
> >  }
> >
> > -static int inotify_one_event(struct fsnotify_group *group, u32 mask,
> > -                          struct fsnotify_mark *inode_mark,
> > -                          const struct path *path,
> > -                          const struct qstr *file_name, u32 cookie)
> > +int inotify_handle_event(struct fsnotify_group *group,
> > +                      struct fsnotify_mark *inode_mark, u32 mask,
> > +                      struct inode *inode, struct inode *dir,
> > +                      const struct qstr *file_name, u32 cookie)
> >  {
> >       struct inotify_inode_mark *i_mark;
> >       struct inotify_event_info *event;
> > @@ -68,10 +68,6 @@ static int inotify_one_event(struct fsnotify_group *group, u32 mask,
> >       int alloc_len = sizeof(struct inotify_event_info);
> >       struct mem_cgroup *old_memcg;
> >
> > -     if ((inode_mark->mask & FS_EXCL_UNLINK) &&
> > -         path && d_unlinked(path->dentry))
> > -             return 0;
> > -
> >       if (file_name) {
> >               len = file_name->len;
> >               alloc_len += len + 1;
> > @@ -131,35 +127,12 @@ static int inotify_one_event(struct fsnotify_group *group, u32 mask,
> >       return 0;
> >  }
> >
> > -int inotify_handle_event(struct fsnotify_group *group, u32 mask,
> > -                      const void *data, int data_type, struct inode *dir,
> > -                      const struct qstr *file_name, u32 cookie,
> > -                      struct fsnotify_iter_info *iter_info)
> > +static int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
> > +                                   struct inode *inode, struct inode *dir,
> > +                                   const struct qstr *name, u32 cookie)
> >  {
>
> Looking at this I'd just fold inotify_handle_event() into
> inotify_handle_inode_event() as the only difference is the 'group' argument
> and that can be always fetched from inode_mark->group...
>

Yes, that is what I though, but then I wasn't sure about the call coming from
inotify_ignored_and_remove_idr(). It seemed to be on purpose that the
group argument is separate from the freeing mark.

Thanks,
Amir.
