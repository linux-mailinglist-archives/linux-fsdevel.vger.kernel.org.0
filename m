Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5A813350
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 19:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfECRvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 13:51:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfECRvN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 13:51:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01CD381E0F;
        Fri,  3 May 2019 17:51:13 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A001C7BA12;
        Fri,  3 May 2019 17:51:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3819E220CB9; Fri,  3 May 2019 13:51:12 -0400 (EDT)
Date:   Fri, 3 May 2019 13:51:12 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        NeilBrown <neilb@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Message-ID: <20190503175112.GB8014@redhat.com>
References: <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <20190503153531.GJ12608@fieldses.org>
 <CAOQ4uxi6MRT=1nFqPD3cfEfBxHsGdUm=FgTjv3ts2bb4zSYwsw@mail.gmail.com>
 <20190503173133.GB14954@fieldses.org>
 <CAOQ4uxjztNzH7EbK7o2vkhzzjULkEVKnnedep9GbTSyOhRV-3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjztNzH7EbK7o2vkhzzjULkEVKnnedep9GbTSyOhRV-3g@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 03 May 2019 17:51:13 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 03, 2019 at 01:41:25PM -0400, Amir Goldstein wrote:
> On Fri, May 3, 2019 at 1:31 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> >
> > On Fri, May 03, 2019 at 01:26:01PM -0400, Amir Goldstein wrote:
> > > On Fri, May 3, 2019 at 12:03 PM J. Bruce Fields <bfields@fieldses.org> wrote:
> > > >
> > > > On Thu, May 02, 2019 at 12:02:33PM +1000, NeilBrown wrote:
> > > > > On Tue, Dec 06 2016, J. Bruce Fields wrote:
> > > > >
> > > > > > On Tue, Dec 06, 2016 at 02:18:31PM +0100, Andreas Gruenbacher wrote:
> > > > > >> On Tue, Dec 6, 2016 at 11:08 AM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > > >> > On Tue, Dec 6, 2016 at 12:24 AM, Andreas Grünbacher
> > > > > >> > <andreas.gruenbacher@gmail.com> wrote:
> > > > > >> >> 2016-12-06 0:19 GMT+01:00 Andreas Grünbacher <andreas.gruenbacher@gmail.com>:
> > > > > >> >
> > > > > >> >>> It's not hard to come up with a heuristic that determines if a
> > > > > >> >>> system.nfs4_acl value is equivalent to a file mode, and to ignore the
> > > > > >> >>> attribute in that case. (The file mode is transmitted in its own
> > > > > >> >>> attribute already, so actually converting .) That way, overlayfs could
> > > > > >> >>> still fail copying up files that have an actual ACL. It's still an
> > > > > >> >>> ugly hack ...
> > > > > >> >>
> > > > > >> >> Actually, that kind of heuristic would make sense in the NFS client
> > > > > >> >> which could then hide the "system.nfs4_acl" attribute.
> > > > > >> >
> > > > > >> > Even simpler would be if knfsd didn't send the attribute if not
> > > > > >> > necessary.  Looks like there's code actively creating the nfs4_acl on
> > > > > >> > the wire even if the filesystem had none:
> > > > > >> >
> > > > > >> >     pacl = get_acl(inode, ACL_TYPE_ACCESS);
> > > > > >> >     if (!pacl)
> > > > > >> >         pacl = posix_acl_from_mode(inode->i_mode, GFP_KERNEL);
> > > > > >> >
> > > > > >> > What's the point?
> > > > > >>
> > > > > >> That's how the protocol is specified.
> > > > > >
> > > > > > Yep, even if we could make that change to nfsd it wouldn't help the
> > > > > > client with the large number of other servers that are out there
> > > > > > (including older knfsd's).
> > > > > >
> > > > > > --b.
> > > > > >
> > > > > >> (I'm not saying that that's very helpful.)
> > > > > >>
> > > > > >> Andreas
> > > > >
> > > > > Hi everyone.....
> > > > >  I have a customer facing this problem, and so stumbled onto the email
> > > > >  thread.
> > > > >  Unfortunately it didn't resolve anything.  Maybe I can help kick things
> > > > >  along???
> > > > >
> > > > >  The core problem here is that NFSv4 and ext4 use different and largely
> > > > >  incompatible ACL implementations.  There is no way to accurately
> > > > >  translate from one to the other in general (common specific examples
> > > > >  can be converted).
> > > > >
> > > > >  This means that either:
> > > > >    1/ overlayfs cannot use ext4 for upper and NFS for lower (or vice
> > > > >       versa) or
> > > > >    2/ overlayfs need to accept that sometimes it cannot copy ACLs, and
> > > > >       that is OK.
> > > > >
> > > > >  Silently not copying the ACLs is probably not a good idea as it might
> > > > >  result in inappropriate permissions being given away.  So if the
> > > > >  sysadmin wants this (and some clearly do), they need a way to
> > > > >  explicitly say "I accept the risk".
> > > >
> > > > So, I feel like silently copying ACLs up *also* carries a risk, if that
> > > > means switching from server-enforcement to client-enforcement of those
> > > > permissions.
> > > >
> > > > Sorry, I know we had another thread recently about permissions in this
> > > > situation, and I've forgotten the conclusion.
> > > >
> > > > Out of curiosity, what's done with selinux labels?
> > > >
> > >
> > > overlayfs calls security_inode_copy_up_xattr(name) which
> > > can fail (<0) allow (0) or skip(1).
> > >
> > > selinux_inode_copy_up_xattr() as well as smack_inode_copy_up_xattr()
> > > skip their own xattr on copy up and fail any other xattr copy up.
> >
> > If it's OK to silently skip copying up security labels, maybe it's OK to
> > silently skip NFSv4 ACLs too?
> >
> 
> I think overlayfs inode security context is taken from overlayfs
> mount parameters (i.e. per container context) and therefore
> the lower security. xattr are ignored (CC Vivek).

If mount was done with "context=" option, then it is used otherwise
selinux security context comes from real inode xattr (lower/upper).

Thanks
Vivek
