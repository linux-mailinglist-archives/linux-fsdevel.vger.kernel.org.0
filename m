Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16263984CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 10:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhFBJAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 05:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhFBJAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:00:42 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EEBC061574
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 01:59:00 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id f15so683411vsq.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 01:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLWpOnx/iw1CEqFu8aVvjEaq/agq3E2iyw94IErInPc=;
        b=nY1kbY7/QSUCDrXiaFOhA8gbbzhozBN9OX3YIsdbiCCbuY7QO5BqrLZJCFEjB2VYRX
         asu2pKOjfnO5y0WIadVkgfT8iuJUbt15ZZo2gnik45qZGhELHNFLaqZWP23LwiMPhRtW
         rIYbrClloptrBKGAgmpU2Yqjpojs1fPfCtQSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLWpOnx/iw1CEqFu8aVvjEaq/agq3E2iyw94IErInPc=;
        b=QZzez1tU6vMR6uWs2+cZO9bBO3bwkcxmEdQ2BvUYD6ZaaOoZQ4mLYgK71MaeqrI6+0
         oCZZKoVU772VJXH3Os/4Z0fdkqsI5+zKWHVO9rZLjySc8kVVGyvtptaQQiY+WPBI9q1Q
         mdoHni0kmlQcmktdmgwvl8/YfyflEo5g0vOvDxNDi/bW+LunHr5df0HtBzKmcWsFVNxZ
         qIrPRwJzs24+6t5X5wRrdZgWsXpvIGaVxs19gd2hcSscbFuS34Q0PO5XoLvBE8shdZ9z
         cBDeSNnVaWyQ0b/0YnR3DuoLvuxoOaNnNFUhAUcYSK6gcUirP1q0L5Tu34l63q4BesRY
         9BFQ==
X-Gm-Message-State: AOAM531npE4nWuDq18Jrq4q/KjLVQt6uPGUwpjdj28g1dtHIXP3CewBL
        LwBXe9DWArQ3q9JBmq4+HbUd4MtwCpVJfjhDQuq6zA==
X-Google-Smtp-Source: ABdhPJzWOb/Y/vvMixw7Ap9EZqJmB1Nrwg3Z+raefHVfOAoYA/iY/ULLwcNG9/BhNPcy7/7Wk286HqW7ysbcXK70UaI=
X-Received: by 2002:a05:6102:b06:: with SMTP id b6mr22371112vst.21.1622624338774;
 Wed, 02 Jun 2021 01:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
 <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
 <CAJfpeguUj5WKtKZsn_tZZNpiL17ggAPcPBXdpA03aAnjaexWug@mail.gmail.com> <972701826ebb1b3b3e00b12cde821b85eebc9749.camel@themaw.net>
In-Reply-To: <972701826ebb1b3b3e00b12cde821b85eebc9749.camel@themaw.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 2 Jun 2021 10:58:47 +0200
Message-ID: <CAJfpegsLqowjMPCAgsFe6eQK_CeixrevUPyA04V2hdYvc0HpLQ@mail.gmail.com>
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2 Jun 2021 at 05:44, Ian Kent <raven@themaw.net> wrote:
>
> On Tue, 2021-06-01 at 14:41 +0200, Miklos Szeredi wrote:
> > On Fri, 28 May 2021 at 08:34, Ian Kent <raven@themaw.net> wrote:
> > >
> > > If there are many lookups for non-existent paths these negative
> > > lookups
> > > can lead to a lot of overhead during path walks.
> > >
> > > The VFS allows dentries to be created as negative and hashed, and
> > > caches
> > > them so they can be used to reduce the fairly high overhead
> > > alloc/free
> > > cycle that occurs during these lookups.
> >
> > Obviously there's a cost associated with negative caching too.  For
> > normal filesystems it's trivially worth that cost, but in case of
> > kernfs, not sure...
> >
> > Can "fairly high" be somewhat substantiated with a microbenchmark for
> > negative lookups?
>
> Well, maybe, but anything we do for a benchmark would be totally
> artificial.
>
> The reason I added this is because I saw appreciable contention
> on the dentry alloc path in one case I saw.

If multiple tasks are trying to look up the same negative dentry in
parallel, then there will be contention on the parent inode lock.
Was this the issue?   This could easily be reproduced with an
artificial benchmark.

> > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > > index 4c69e2af82dac..5151c712f06f5 100644
> > > --- a/fs/kernfs/dir.c
> > > +++ b/fs/kernfs/dir.c
> > > @@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct
> > > dentry *dentry, unsigned int flags)
> > >         if (flags & LOOKUP_RCU)
> > >                 return -ECHILD;
> > >
> > > -       /* Always perform fresh lookup for negatives */
> > > -       if (d_really_is_negative(dentry))
> > > -               goto out_bad_unlocked;
> > > +       mutex_lock(&kernfs_mutex);
> > >
> > >         kn = kernfs_dentry_node(dentry);
> > > -       mutex_lock(&kernfs_mutex);
> > > +
> > > +       /* Negative hashed dentry? */
> > > +       if (!kn) {
> > > +               struct kernfs_node *parent;
> > > +
> > > +               /* If the kernfs node can be found this is a stale
> > > negative
> > > +                * hashed dentry so it must be discarded and the
> > > lookup redone.
> > > +                */
> > > +               parent = kernfs_dentry_node(dentry->d_parent);
> >
> > This doesn't look safe WRT a racing sys_rename().  In this case
> > d_move() is called only with parent inode locked, but not with
> > kernfs_mutex while ->d_revalidate() may not have parent inode locked.
> > After d_move() the old parent dentry can be freed, resulting in use
> > after free.  Easily fixed by dget_parent().
>
> Umm ... I'll need some more explanation here ...
>
> We are in ref-walk mode so the parent dentry isn't going away.

The parent that was used to lookup the dentry in __d_lookup() isn't
going away.  But it's not necessarily equal to dentry->d_parent
anymore.

> And this is a negative dentry so rename is going to bail out
> with ENOENT way early.

You are right.  But note that negative dentry in question could be the
target of a rename.  Current implementation doesn't switch the
target's parent or name, but this wasn't always the case (commit
076515fc9267 ("make non-exchanging __d_move() copy ->d_parent rather
than swap them")), so a backport of this patch could become incorrect
on old enough kernels.

So I still think using dget_parent() is the correct way to do this.

> >
> > > +               if (parent) {
> > > +                       const void *ns = NULL;
> > > +
> > > +                       if (kernfs_ns_enabled(parent))
> > > +                               ns = kernfs_info(dentry->d_sb)->ns;
> > > +                       kn = kernfs_find_ns(parent, dentry-
> > > >d_name.name, ns);
> >
> > Same thing with d_name.  There's
> > take_dentry_name_snapshot()/release_dentry_name_snapshot() to
> > properly
> > take care of that.
>
> I don't see that problem either, due to the dentry being negative,
> but please explain what your seeing here.

Yeah.  Negative dentries' names weren't always stable, but that was a
long time ago (commit 8d85b4845a66 ("Allow sharing external names
after __d_move()")).

Thanks,
Miklos
