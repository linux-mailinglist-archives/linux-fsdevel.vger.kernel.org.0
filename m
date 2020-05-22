Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE521DF03E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 21:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgEVT4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 15:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730893AbgEVT4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 15:56:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AC1C061A0E;
        Fri, 22 May 2020 12:56:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jcDmM-00Dfk3-I0; Fri, 22 May 2020 19:56:26 +0000
Date:   Fri, 22 May 2020 20:56:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ovl: make private mounts longterm
Message-ID: <20200522195626.GV23230@ZenIV.linux.org.uk>
References: <20200522085723.29007-1-mszeredi@redhat.com>
 <20200522160815.GT23230@ZenIV.linux.org.uk>
 <CAOssrKcpQwYh39JpcNmV3JiuH2aPDJxgT5MADQ9cZMboPa9QaQ@mail.gmail.com>
 <CAOQ4uxi80CFLgeTYbnHvD7GbY_01z0uywP1jF8gZe76_EZYiug@mail.gmail.com>
 <CAOssrKfXgpRykVN94EiEy8xT4j+HCedN96i31j9iHomtavFaLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOssrKfXgpRykVN94EiEy8xT4j+HCedN96i31j9iHomtavFaLA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 08:53:49PM +0200, Miklos Szeredi wrote:
> On Fri, May 22, 2020 at 7:02 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > > > > -     mntput(ofs->upper_mnt);
> > > > > -     for (i = 1; i < ofs->numlayer; i++) {
> > > > > -             iput(ofs->layers[i].trap);
> > > > > -             mntput(ofs->layers[i].mnt);
> > > > > +
> > > > > +     if (!ofs->layers) {
> > > > > +             /* Deal with partial setup */
> > > > > +             kern_unmount(ofs->upper_mnt);
> > > > > +     } else {
> > > > > +             /* Hack!  Reuse ofs->layers as a mounts array */
> > > > > +             struct vfsmount **mounts = (struct vfsmount **) ofs->layers;
> > > > > +
> > > > > +             for (i = 0; i < ofs->numlayer; i++) {
> > > > > +                     iput(ofs->layers[i].trap);
> > > > > +                     mounts[i] = ofs->layers[i].mnt;
> > > > > +             }
> > > > > +             kern_unmount_many(mounts, ofs->numlayer);
> > > > > +             kfree(ofs->layers);
> > > >
> > > > That's _way_ too subtle.  AFAICS, you rely upon ->upper_mnt == ->layers[0].mnt,
> > > > ->layers[0].trap == NULL, without even mentioning that.  And the hack you do
> > > > mention...  Yecchhh...  How many layers are possible, again?
> > >
> > > 500, mounts array would fit inside a page and a page can be allocated
> > > with __GFP_NOFAIL. But why bother?  It's not all that bad, is it?
> >
> > FWIW, it seems fine to me.
> > We can transfer the reference from upperdir_trap to layers[0].trap
> > when initializing layers[0] for the sake of clarity.
> 
> Right, we should just get rid of ofs->upper_mnt and ofs->upperdir_trap
> and use ofs->layers[0] to store those.

For that you'd need to allocate ->layers before you get to ovl_get_upper(),
though.  I'm not saying it's a bad idea - doing plain memory allocations
before anything else tends to make failure exits cleaner; it's just that
it'll take some massage.  Basically, do ovl_split_lowerdirs() early,
then allocate everything you need, then do lookups, etc., filling that
stuff.

Regarding this series - the points regarding the name choice and the
need to document the calling conventions change still remain.
