Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A543C16DF4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 01:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfEGXvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 19:51:16 -0400
Received: from fieldses.org ([173.255.197.46]:59706 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbfEGXvQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 19:51:16 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 583C51DCB; Tue,  7 May 2019 19:51:15 -0400 (EDT)
Date:   Tue, 7 May 2019 19:51:15 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     NeilBrown <neilb@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Message-ID: <20190507235115.GB16853@fieldses.org>
References: <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de>
 <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <20190503153531.GJ12608@fieldses.org>
 <CAJfpegv-0mUs=XRgerxR_Zz_MvYuDvb95v0QZeBUcHNnenusnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv-0mUs=XRgerxR_Zz_MvYuDvb95v0QZeBUcHNnenusnw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 07, 2019 at 04:07:21AM -0400, Miklos Szeredi wrote:
> On Fri, May 3, 2019 at 11:35 AM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Thu, May 02, 2019 at 12:02:33PM +1000, NeilBrown wrote:
> 
> > >  Silently not copying the ACLs is probably not a good idea as it might
> > >  result in inappropriate permissions being given away.  So if the
> > >  sysadmin wants this (and some clearly do), they need a way to
> > >  explicitly say "I accept the risk".
> >
> > So, I feel like silently copying ACLs up *also* carries a risk, if that
> > means switching from server-enforcement to client-enforcement of those
> > permissions.
> 
> That's not correct: permissions are checked on the overlay layer,
> regardless of where the actual file resides.  For filesystems using a
> server enforced permission model that means possibly different
> permissions for accesses through overlayfs than for accesses without
> overlayfs.  Apparently this is missing from the documentation and
> definitely needs to be added.

Well, we did have a thread on this pretty recently, I think, and I'm
just not remembering the conclusion.  Yes, it'd be nice to have this
documented.

In the case of NFSv4 ACLs, we not only lack storage for them, we don't
even have code to evaluate them.

--b.

> So I think it's perfectly fine to allow copying up ACLs, as long as
> the ACL is representable on the upper fs.  If that cannot be ensured,
> then the only sane thing to do is to disable ACL checking across the
> overlay ("noacl" option).
