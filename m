Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE761A425B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 08:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgDJGE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 02:04:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:59822 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDJGE0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:04:26 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMmm6-00FnMr-DK; Fri, 10 Apr 2020 06:04:22 +0000
Date:   Fri, 10 Apr 2020 07:04:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] proc/mounts: add cursor
Message-ID: <20200410060422.GJ23230@ZenIV.linux.org.uk>
References: <20200410050522.GI28467@miu.piliscsaba.redhat.com>
 <20200410051457.GI23230@ZenIV.linux.org.uk>
 <CAJfpegvse9GrzncMOShNf80-7a6AMaAEGdbpL739RBzQmpQdMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvse9GrzncMOShNf80-7a6AMaAEGdbpL739RBzQmpQdMw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 10, 2020 at 07:23:47AM +0200, Miklos Szeredi wrote:

> > Hmm...  I wonder if it would be better to do something like
> >         if (!*pos)
> >                 prev = &p->ns->list.next;
> >         else
> >                 prev = &p->mnt.mnt_list.next;
> >         mnt = mnt_skip_cursors(p->ns, prev);
> >
> > >  static void *m_next(struct seq_file *m, void *v, loff_t *pos)
> > >  {
> > >       struct proc_mounts *p = m->private;
> > > +     struct mount *mnt = v;
> > > +
> > > +     lock_ns_list(p->ns);
> > > +     mnt = mnt_skip_cursors(p->ns, list_next_entry(mnt, mnt_list));
> >
> > ... and mnt = mnt_skip_cursors(p->ns, &mnt->mnt_list.next);
> 
> If you prefer that, yes.  Functionally it's equivalent.

Sure, it's just that I suspect that result will be somewhat more
readable that way.

Incidentally, there might be another benefit - both &p->ns->list.next
and &p->mnt.mnt_list.next are not going to change.  So calculation of
prev can be lifter out of lock_ns_list() and _that_ promises something
more tasty - all callers of mnt_skip_cursors() are immediately
surrounded by lock_ns_list()/unlock_ns_list() and those can be moved
inside the damn thing.
