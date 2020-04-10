Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2B1A4238
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 07:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgDJFYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 01:24:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42199 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgDJFYD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 01:24:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id cw6so1073693edb.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2020 22:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/nBmYmVumG9MztPQcUGIMpUoVrrgn99Ut4zgYrcNXG8=;
        b=dZCvpDD6b1apJ/W5hm8A6GxD/yFOUY9EID9Z+/76blOw60pbeLt+LP63eS7o77RDQn
         2M+4udydrPbLJN/4bFlyo1qgLd59x8jP+YNNR+UW0W7Es3CZMazNBEx9fnO+nTQECxFo
         9T1jth3Grn3+VKCrglCQ9ccXqn+pG3SsmxMuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/nBmYmVumG9MztPQcUGIMpUoVrrgn99Ut4zgYrcNXG8=;
        b=strDmx3jlfa6UAr+muS4B/0G4t/R8ql64GKoT6ilQCYRDqipUfnh17NPpkLXMq9FcX
         zEqsgzugpz/DpR3ju5Pq1gXz/G4TBMyuEHXtdpKc86AQyDV3zEDQ8EdzAjowQvTbTDAM
         0DjcUH6d1F2OJ7oA2g4CqOc8BxvEl1dKD9BwO57+qCOXa6m0fBQlInT5GBBkZkXT/NS2
         ir9C0F9jk4dpzl/ZkkXeXsIEe/8O+rTUFVeux/v4tmvdZk54HdSMM2DKs61B0TF/Lr7J
         M7tmRtv8uU6x8OgaG9Qn9bo8QpimAeUssWciAWbiJldFn4yw3TqQpDcDKu7JKH0vfoAL
         3zNg==
X-Gm-Message-State: AGi0PualdsX/5PNKooJhfk0cieMnCW7hn1EuieBEr0p0BhP9MEZdBNjK
        QxP4pdBpNg8TVPAmZ+v5k2qM9ANFa4shlmE2Bnd6Jg==
X-Google-Smtp-Source: APiQypL/iIG/7PbSJHoSfaoOwOMNG7Es4Pov23/uqjlbo1QHwN6I9Sr8DmswmpGWkiSWniAMWz2rTbJIFlhxwAqJDF0=
X-Received: by 2002:a17:906:35ce:: with SMTP id p14mr2384239ejb.43.1586496238451;
 Thu, 09 Apr 2020 22:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200410050522.GI28467@miu.piliscsaba.redhat.com> <20200410051457.GI23230@ZenIV.linux.org.uk>
In-Reply-To: <20200410051457.GI23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 10 Apr 2020 07:23:47 +0200
Message-ID: <CAJfpegvse9GrzncMOShNf80-7a6AMaAEGdbpL739RBzQmpQdMw@mail.gmail.com>
Subject: Re: [PATCH v4] proc/mounts: add cursor
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 10, 2020 at 7:14 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Apr 10, 2020 at 07:05:22AM +0200, Miklos Szeredi wrote:
> > +     /* read after we'd reached the end? */
> > +     if (*pos && list_empty(&mnt->mnt_list))
> > +             return NULL;
> > +
> > +     lock_ns_list(p->ns);
> > +     if (!*pos)
> > +             mnt = list_first_entry(&p->ns->list, typeof(*mnt), mnt_list);
> > +     mnt = mnt_skip_cursors(p->ns, mnt);
> > +     unlock_ns_list(p->ns);
> >
> > -     p->cached_event = p->ns->event;
> > -     p->cached_mount = seq_list_start(&p->ns->list, *pos);
> > -     p->cached_index = *pos;
> > -     return p->cached_mount;
> > +     return mnt;
> >  }
>
> Hmm...  I wonder if it would be better to do something like
>         if (!*pos)
>                 prev = &p->ns->list.next;
>         else
>                 prev = &p->mnt.mnt_list.next;
>         mnt = mnt_skip_cursors(p->ns, prev);
>
> >  static void *m_next(struct seq_file *m, void *v, loff_t *pos)
> >  {
> >       struct proc_mounts *p = m->private;
> > +     struct mount *mnt = v;
> > +
> > +     lock_ns_list(p->ns);
> > +     mnt = mnt_skip_cursors(p->ns, list_next_entry(mnt, mnt_list));
>
> ... and mnt = mnt_skip_cursors(p->ns, &mnt->mnt_list.next);

If you prefer that, yes.  Functionally it's equivalent.

Thanks,
Miklos
