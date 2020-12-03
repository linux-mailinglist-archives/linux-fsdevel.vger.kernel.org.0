Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6819A2CD5B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 13:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgLCMoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 07:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLCMo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:44:27 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72AEC061A4E
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 04:43:41 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id q1so1767481ilt.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Dec 2020 04:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wln96Pve2QHOPqK3UPIyXmqiKMjnEXDZx+Zv/oVgEm4=;
        b=owUgkgxSpQb4HBreGrue6mh9gqlFCOIRdzqGpOxckqIvkZ8nO+wMqoaM2KJUTnP+1A
         YQHVxzlVPVElbQofRXv23ygCjA9BH6jmfy8knforRJQuNmVWapvNO77Gmz9M5xVkmN0B
         yWzNZ4y8Gw2Wjc3ss3HwSnlfKTEUebSaBffOee9psJZaE8q56WrtpVJP+hMUjBymgg6w
         Iqps4VqM324tIHuFtX6dlQbk8i9mb5aTgKhi/G/lbny7O1+Ft+WGq1A5WXscZIbIS0f+
         +vddBJxO6iBUbH0gE390BmuMi+rzjadSqEGIhIyRJZJ9rQaUVLylY0wdnateADjfOmeJ
         Qtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wln96Pve2QHOPqK3UPIyXmqiKMjnEXDZx+Zv/oVgEm4=;
        b=ev1EWZuw05Ohv6p1S/ZK7cfZ9rXi5G1gUj4IE3NZPGV2pEpQMHkcAO0iPCb8Xsf+hL
         FnC2huH45vZEa1W6zGHMgGyLkfi8YxeT/IxlesoZvaVPQ9qraU8+oIt7DAf//h3z3PLh
         pvV/57H2VGNiRlmrZJpL3HGegiVrqNvTE560DPlSESqALwun35SuSDqiuiOv4P6PuN5y
         ZaIC8pZde+VNb7RhLafoSrNN52eR0cwrlGmmY2xhaB4SKr7SzR9UQvWnBAE1qIi5wUHM
         zagrULJ5EnCWlHYyOTacy19bEphpGwZ34iTACbnkN+PiLdACyFYLeikeR+/xE+QqomNT
         SZPQ==
X-Gm-Message-State: AOAM530JrZWluF/f3LCg3pT6vI+cTchqBrETFhKXwNiWCJ25xGwpOp0Q
        y5LaYZ3BSwarSqtAm4D/gLPUl9sY5g6Z++yP/LzXuniZkho=
X-Google-Smtp-Source: ABdhPJwiJXTifFu2NkYI54haPn56A90JezEY6GFIpWw3S0U0kXvE8QHg7wmYV+s9cOUDl2pLgyDB1LPIIcivJKt0YzY=
X-Received: by 2002:a92:da82:: with SMTP id u2mr2788745iln.137.1606999421101;
 Thu, 03 Dec 2020 04:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20201202120713.702387-1-amir73il@gmail.com> <20201202120713.702387-3-amir73il@gmail.com>
 <20201203095532.GB11854@quack2.suse.cz> <CAOQ4uxghXX683tSiC=pOdMoqXYxBw20JaQQkFAE3NctBraODJg@mail.gmail.com>
 <20201203123729.GF11854@quack2.suse.cz>
In-Reply-To: <20201203123729.GF11854@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 3 Dec 2020 14:43:30 +0200
Message-ID: <CAOQ4uxja-6DC5985mAJMkYqhnBYRM2awXS8V3NWtSChEjT=mfw@mail.gmail.com>
Subject: Re: [PATCH 2/7] inotify: convert to handle_inode_event() interface
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:37 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 03-12-20 12:45:15, Amir Goldstein wrote:
> > On Thu, Dec 3, 2020 at 11:55 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Wed 02-12-20 14:07:08, Amir Goldstein wrote:
> > > > Convert inotify to use the simple handle_inode_event() interface to
> > > > get rid of the code duplication between the generic helper
> > > > fsnotify_handle_event() and the inotify_handle_event() callback, which
> > > > also happen to be buggy code.
> > > >
> > > > The bug will be fixed in the generic helper.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/notify/inotify/inotify.h          |  9 +++---
> > > >  fs/notify/inotify/inotify_fsnotify.c | 47 ++++++----------------------
> > > >  fs/notify/inotify/inotify_user.c     |  7 +----
> > > >  3 files changed, 15 insertions(+), 48 deletions(-)
> > > >
> > > > diff --git a/fs/notify/inotify/inotify.h b/fs/notify/inotify/inotify.h
> > > > index 4327d0e9c364..7fc3782b2fb8 100644
> > > > --- a/fs/notify/inotify/inotify.h
> > > > +++ b/fs/notify/inotify/inotify.h
> > > > @@ -24,11 +24,10 @@ static inline struct inotify_event_info *INOTIFY_E(struct fsnotify_event *fse)
> > > >
> > > >  extern void inotify_ignored_and_remove_idr(struct fsnotify_mark *fsn_mark,
> > > >                                          struct fsnotify_group *group);
> > > > -extern int inotify_handle_event(struct fsnotify_group *group, u32 mask,
> > > > -                             const void *data, int data_type,
> > > > -                             struct inode *dir,
> > > > -                             const struct qstr *file_name, u32 cookie,
> > > > -                             struct fsnotify_iter_info *iter_info);
> > > > +extern int inotify_handle_event(struct fsnotify_group *group,
> > > > +                             struct fsnotify_mark *inode_mark, u32 mask,
> > > > +                             struct inode *inode, struct inode *dir,
> > > > +                             const struct qstr *name, u32 cookie);
> > > >
> > > >  extern const struct fsnotify_ops inotify_fsnotify_ops;
> > > >  extern struct kmem_cache *inotify_inode_mark_cachep;
> > > > diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> > > > index 9ddcbadc98e2..f348c1d3b358 100644
> > > > --- a/fs/notify/inotify/inotify_fsnotify.c
> > > > +++ b/fs/notify/inotify/inotify_fsnotify.c
> > > > @@ -55,10 +55,10 @@ static int inotify_merge(struct list_head *list,
> > > >       return event_compare(last_event, event);
> > > >  }
> > > >
> > > > -static int inotify_one_event(struct fsnotify_group *group, u32 mask,
> > > > -                          struct fsnotify_mark *inode_mark,
> > > > -                          const struct path *path,
> > > > -                          const struct qstr *file_name, u32 cookie)
> > > > +int inotify_handle_event(struct fsnotify_group *group,
> > > > +                      struct fsnotify_mark *inode_mark, u32 mask,
> > > > +                      struct inode *inode, struct inode *dir,
> > > > +                      const struct qstr *file_name, u32 cookie)
> > > >  {
> > > >       struct inotify_inode_mark *i_mark;
> > > >       struct inotify_event_info *event;
> > > > @@ -68,10 +68,6 @@ static int inotify_one_event(struct fsnotify_group *group, u32 mask,
> > > >       int alloc_len = sizeof(struct inotify_event_info);
> > > >       struct mem_cgroup *old_memcg;
> > > >
> > > > -     if ((inode_mark->mask & FS_EXCL_UNLINK) &&
> > > > -         path && d_unlinked(path->dentry))
> > > > -             return 0;
> > > > -
> > > >       if (file_name) {
> > > >               len = file_name->len;
> > > >               alloc_len += len + 1;
> > > > @@ -131,35 +127,12 @@ static int inotify_one_event(struct fsnotify_group *group, u32 mask,
> > > >       return 0;
> > > >  }
> > > >
> > > > -int inotify_handle_event(struct fsnotify_group *group, u32 mask,
> > > > -                      const void *data, int data_type, struct inode *dir,
> > > > -                      const struct qstr *file_name, u32 cookie,
> > > > -                      struct fsnotify_iter_info *iter_info)
> > > > +static int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
> > > > +                                   struct inode *inode, struct inode *dir,
> > > > +                                   const struct qstr *name, u32 cookie)
> > > >  {
> > >
> > > Looking at this I'd just fold inotify_handle_event() into
> > > inotify_handle_inode_event() as the only difference is the 'group' argument
> > > and that can be always fetched from inode_mark->group...
> > >
> >
> > Yes, that is what I though, but then I wasn't sure about the call coming from
> > inotify_ignored_and_remove_idr(). It seemed to be on purpose that the
> > group argument is separate from the freeing mark.
>
> Well, the 'group' argument is just fetched from mark->group in
> fsnotify_free_mark() so I rather think it is a relict from the past when
> the lifetime rules for marks were different. In fact

Ha right! I should have checked that.

> fsnotify_final_mark_destroy() which is called just before really freeing
> the memory uses mark->group. So I'm pretty sure we are safe to grab
> mark->group in inotify_handle_event() as well.
>

Unless I have other fixes to post, I'll assume you will be folding the
inotify_handle_inode_event wrapper on commit.

Thanks,
Amir.
